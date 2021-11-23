Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2023845A1C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhKWLp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhKWLpz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:45:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A17760240;
        Tue, 23 Nov 2021 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637667767;
        bh=J9tO/THGEgoh+UbBJCscM7j2LFHm8uMKGVTeq4HPIWo=;
        h=From:To:Cc:Subject:Date:From;
        b=Gnkb98auBuvGaqYGNbvgvhQZqT053Pag2QQbaWJrc0o8XtOvKHYS+P5YGAXGhDpsg
         uztVkW3IYuX7OjWdoyQnDyam3T61K+hTRkQUeUZrQhaNF0fQzBdYAe3bFATz++B02U
         Ur+v6hLrzMMR8402boArDW3WlPY/+kqclCS+YmXPuDJz80lPmC/WhX5AC8qCrMud0N
         DpJz3qFjmnP0FY5p5uBQ2lUwj4/cOxSJofqVRMNGk1BlZTt6jkLLSIjw8Fv8u7bafo
         bWU4c5hOjbWK9OnARZv6F/3qDhOZvaTkMvVcfUNJz4rc0p6FhrAFWYekl3jmcmPDAf
         1D+vWOdmaUVsg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 00/10] Extend and tweak mapping support
Date:   Tue, 23 Nov 2021 12:42:17 +0100
Message-Id: <20211123114227.3124056-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9884; h=from:subject; bh=NKrKaz3tfZq7PO0YvfXf12LPY75oANlTHyEE2et+WhY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOuVzsuO/y7NzvSX/ZmovW8fn+vyJtZNiXfOZZwYSPN0OT 6u0kO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSV8Twh6+o9vrdGx8SGxtLFC0vyB w4y+r/ZqZHXMGPlS0bj66bL8/wz0Yp3t1MMaWEh8f9pAOP5MmMv15hz2K67M6tTX8Q/zOYDQA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

This series extend the mapping infrastructure in order to support mapped
mounts of mapped filesystems in the future.

Currently we only support mapped mounts of filesystems mounted without an
idmapping. This was a consicous decision mentioned in multiple places. For
example, see [1].

In our mapping documentation in [3] we explained in detail that it is
perfectly fine to extend support for mapped mounts to filesystem's mounted
with an idmapping should the need arise. The need has been there for some
time now (cf. [2]).

Before we can port any such filesystem we need to first extend the mapping
helpers to account for the filesystem's idmapping in the remapping helpers.
This again, is explained at length in our documentation at [3].

Currently, the low-level mapping helpers implement the remapping algorithms
described in [3] in a simplified manner. Because we could rely on the fact
that all filesystems supporting mapped mounts are mounted without an
idmapping the translation step from or into the filesystem idmapping could
be skipped.

In order to support mapped mounts of filesystem's mountable with an
idmapping the translation step we were able to skip before cannot be
skipped anymore. A filesystem mounted with an idmapping is very likely to
not use an identity mapping and will instead use a non-identity mapping. So
the translation step from or into the filesystem's idmapping in the
remapping algorithm cannot be skipped for such filesystems. More details
with examples can be found in [3].

This series adds a few new as well as prepares and tweaks some already
existing low-level mapping helpers to perform the full translation
algorithm explained in [3]. The low-level helpers can be written in a way
that they only perform the additional translation step when the filesystem
is indeed mounted with an idmapping.

Since we don't yet support such a filesystem yet a kernel was compiled
carrying a trivial patch making ext4 mountable with an idmapping:

# We're located on the host with the initial idmapping.
ubuntu@f2-vm:~$ cat /proc/self/uid_map
         0          0 4294967295

# Mount an ext4 filesystem with the initial idmapping.
ubuntu@f2-vm:~$ sudo mount -t ext4 /dev/loop0 /mnt

# The filesystem contains two files. One owned by id 0 and another one owned by
# id 1000 in the initial idmapping.
ubuntu@f2-vm:~$ ls -al /mnt/
total 8
drwxrwxrwx  2 root   root   4096 Nov 22 17:04 .
drwxr-xr-x 24 root   root   4096 Nov 20 11:24 ..
-rw-r--r--  1 root   root      0 Nov 22 17:04 file_init_mapping_0
-rw-r--r--  1 ubuntu ubuntu    0 Nov 22 17:04 file_init_mapping_1000

# Umount it again so we we can mount it in another namespace later.
ubuntu@f2-vm:~$ sudo umount  /mnt

# Use the lxc-usernsexec binary to run a shell in a user and mount namespace
# with an idmapping of 0:10000:100000000.
#
# This idmapping will have the effect that files which are owned by i_{g,u}id
# 10000 and files that are owned by i_{g,u}id 11000 will be owned by {g,u}id
# 0 and {g,u}id 1000 with that namespace respectively.
ubuntu@f2-vm:~$ sudo lxc-usernsexec -m b:0:10000:100000000 -- bash

# Verify that we're really running with the expected idmapping.
root@f2-vm:/home/ubuntu# cat /proc/self/uid_map
         0      10000  100000000

# Mount the ext4 filesystem in the user and mountns with the idmapping
# 0:10000:100000000.
# 
# Note, that this requires a test kernel that makes ext4 mountable in a
# non-initial userns. The patch is simply:
#
# diff --git a/fs/ext4/super.c b/fs/ext4/super.c
# index 4e33b5eca694..0221e8211e5b 100644
# --- a/fs/ext4/super.c
# +++ b/fs/ext4/super.c
# @@ -6584,7 +6584,7 @@ static struct file_system_type ext4_fs_type = {
#         .name           = "ext4",
#         .mount          = ext4_mount,
#         .kill_sb        = kill_block_super,
# -       .fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
# +       .fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_USERNS_MOUNT,
#  };
#  MODULE_ALIAS_FS("ext4");
root@f2-vm:/home/ubuntu# mount -t ext4 /dev/loop0 /mnt

# We verify that we can still interact with the files and that they are
# correctly owned from witin the namespace.
# 
# As mentioned before, a file owned by {g,u}id 0 within the userns is mapped to
# {g,u}id 10000 in the initial userns. So inode->i_{g,u}id will contain
# 10000. Similarly a file owned by {g,u}id 1000 within the userns means that
# inode->i_{g,u}id will contain 11000.
the inode->i_{g,u}id 
root@f2-vm:/home/ubuntu# ls -al /mnt/
total 8
drwxrwxrwx  2 root   root    4096 Nov 22 17:04 .
drwxr-xr-x 24 nobody nogroup 4096 Nov 20 11:24 ..
-rw-r--r--  1 root   root       0 Nov 22 17:04 file_init_mapping_0
-rw-r--r--  1 ubuntu ubuntu     0 Nov 22 17:04 file_init_mapping_1000

# Since we own the superblock we can also create idmapped mounts of the
# filesystem.
# First, we create an idmapped mount that maps {g,u}id 1000 to {g,u}id 0.
# Note that the idmapping 1000:0:1 as written from userspace is different from
# the idmapping the kernel actually stores. The idmapping is always translated
# into the initial userns. So the kernel actually stores the idmapping
# 1000:10000:1.
root@f2-vm:/home/ubuntu# /mount-idmapped --map-mount b:1000:0:1 /mnt /opt

# Verify that files owned by {g,u}id 1000 are now owned by {g,u}id 0 and all
# others are owned by the overflow{g,u}id.
root@f2-vm:/home/ubuntu# ls -al /opt
total 8
drwxrwxrwx  2 nobody nogroup 4096 Nov 22 17:04 .
drwxr-xr-x 24 nobody nogroup 4096 Nov 20 11:24 ..
-rw-r--r--  1 nobody nogroup    0 Nov 22 17:04 file_init_mapping_0
-rw-r--r--  1 root   root       0 Nov 22 17:04 file_init_mapping_1000

# Umount the idmapped mount.
root@f2-vm:/mnt# umount /opt

# Now create another idmapped mount with a mapping of 0:20000:1000000.
#
# Similar to what we said above the kernel doesn't store 0:20000:1000000 but
# 0:30000:1000000.
root@f2-vm:/mnt# /mount-idmapped --map-mount b:0:20000:1000000 /mnt /opt

# Verify that files owned by {g,u}id 0 in the filesystem's idmapping are owned
# by {g,u}id 20000 in the mount's idmapping and that files owned by {g,u}id
# 10000 in the filesystem's idmapping are owned by {g,u}id 21000 in the
# mount's idmapping.
root@f2-vm:/mnt# ls -al /opt
total 8
drwxrwxrwx  2  20000   20000 4096 Nov 22 17:04 .
drwxr-xr-x 24 nobody nogroup 4096 Nov 20 11:24 ..
-rw-r--r--  1  20000   20000    0 Nov 22 17:04 file_init_mapping_0
-rw-r--r--  1  21000   21000    0 Nov 22 17:04 file_init_mapping_1000

# Use the lxc-usernsexec binary to run a shell in a user and mount namespace
# with an idmapping of 0:20000:1000000.
#
# Similar to what we said above the kernel doesn't store 0:20000:1000000 but
# 0:30000:1000000.
root@f2-vm:/mnt# lxc-usernsexec -m b:0:20000:1000000 -- bash

# Verify that we managed to use the correct nested mapping.
root@f2-vm:/mnt# cat /proc/self/uid_map
         0      20000    1000000

# Verify that files owned by {g,u}id 20000 in the idmapped mount when accessed
# from the ancestor userns are now owned by {g,u}id 0 in the idmapped mount
# when accessed from the new namespace. Similarly, verify that files owned by
# {g,u}id 21000 in the idmapped mount when accessed from the ancestor userns
# are now owned by {g,u}id 1000 in the idmapped mount when accesed from the new
# namespace.
root@f2-vm:/mnt# ls -al /opt/
total 8
drwxrwxrwx  2 root   root    4096 Nov 22 17:04 .
drwxr-xr-x 24 nobody nogroup 4096 Nov 20 11:24 ..
-rw-r--r--  1 root   root       0 Nov 22 17:04 file_init_mapping_0
-rw-r--r--  1 ubuntu ubuntu     0 Nov 22 17:04 file_init_mapping_1000

# Create a file as id 0 in the current namespace through the idmapped mount.
root@f2-vm:/mnt# touch /opt/file_from_nested_ns

# Verify that the newly created file is owned by {g,u}id 0.
root@f2-vm:/mnt# ls -al /opt
total 8
drwxrwxrwx  2 root   root    4096 Nov 22 17:32 .
drwxr-xr-x 24 nobody nogroup 4096 Nov 20 11:24 ..
-rw-r--r--  1 root   root       0 Nov 22 17:32 file_from_nested_ns
-rw-r--r--  1 root   root       0 Nov 22 17:04 file_init_mapping_0
-rw-r--r--  1 ubuntu ubuntu     0 Nov 22 17:04 file_init_mapping_1000

[1]: commit 2ca4dcc4909d ("fs/mount_setattr: tighten permission checks")
[2]: https://github.com/containers/podman/issues/10374
[3]: Documentations/filesystems/idmappings.rst

Thanks!
Christian

Christian Brauner (10):
  fs: add is_mapped_mnt() helper
  fs: move mapping helpers
  fs: tweak fsuidgid_has_mapping()
  fs: account for filesystem mappings
  docs: update mapping documentation
  fs: use low-level mapping helpers
  fs: remove unused low-level mapping helpers
  fs: port higher-level mapping helpers
  fs: add i_user_ns() helper
  fs: support mapped mounts of mapped filesystems

 Documentation/filesystems/idmappings.rst |  72 -------
 fs/cachefiles/bind.c                     |   2 +-
 fs/ecryptfs/main.c                       |   2 +-
 fs/ksmbd/smbacl.c                        |  18 +-
 fs/ksmbd/smbacl.h                        |   4 +-
 fs/namespace.c                           |  38 ++--
 fs/nfsd/export.c                         |   2 +-
 fs/open.c                                |   7 +-
 fs/overlayfs/super.c                     |   2 +-
 fs/posix_acl.c                           |  16 +-
 fs/proc_namespace.c                      |   2 +-
 fs/xfs/xfs_inode.c                       |  10 +-
 fs/xfs/xfs_symlink.c                     |   5 +-
 include/linux/fs.h                       | 141 ++++----------
 include/linux/mnt_mapping.h              | 234 +++++++++++++++++++++++
 security/commoncap.c                     |  14 +-
 16 files changed, 339 insertions(+), 230 deletions(-)
 create mode 100644 include/linux/mnt_mapping.h


base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
-- 
2.30.2

