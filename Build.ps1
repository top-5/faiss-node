# Set the path to vcpkg
$vcpkgPath = "C:\vcpkg"

# Check if vcpkg is built
if (-not (Test-Path -Path "$vcpkgPath\vcpkg.exe")) {
    Write-Host "vcpkg is not built. Building vcpkg..."
    Push-Location $vcpkgPath
    .\bootstrap-vcpkg.bat
    Pop-Location
} else {
    Write-Host "vcpkg is already built."
}

# Install BLAS using vcpkg
Write-Host "Installing BLAS using vcpkg..."
Push-Location $vcpkgPath
.\vcpkg.exe install blas
.\vcpkg.exe install lapack
.\vcpkg.exe install faiss
.\vcpkg.exe install intel-mkl
Pop-Location

npm install -g node-gyp
npm install .

# Load compiled native node module to verify it works
Write-Host "Running example script..."
node examples/index.js
