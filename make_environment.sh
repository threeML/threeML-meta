#!/bin/bash

export channels="-c conda-forge -c fermi -c threeML"

# First, let's build the meta package
# This downloads all packages as specified into recipe/meta.yaml
conda build ${channels} recipe --python=2

# Now let's create and env with the package just built
# This will contain all dependencies
conda create -y --name threeML_env --use-local ${channels} threeML_meta

# Install conda-pack
conda install -c conda-forge -y conda-pack

# Build the tar file
cd ${HOME}
source activate threeML_env
conda pack -o threeML_env.tar.gz

echo "Package size: "`du -h threeML_env.tar.gz`
