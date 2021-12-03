Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16F467607
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 12:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351697AbhLCLUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 06:20:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38328 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbhLCLUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:20:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4AE1629FD
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 11:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BB8C53FC7;
        Fri,  3 Dec 2021 11:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530247;
        bh=eF49/qfoUz5oMiSY7/myY4Io16uGs5gqMQT9j2zu61c=;
        h=From:To:Cc:Subject:Date:From;
        b=bk2bDTHhB5tqb+tg9RJ2vCMEZgf5d/SyijbYute/3EDh0lF0Av6rFOZhWxnP44yJy
         lVUcBiA/q7YvZgMZeTVOTfh6IgJaaxPex3rK4dqcxD1nfQk0Ow2kM33EOCHOcq/VwM
         J66ykoBYR4gBYz2bQcT3bIy+URupTF0FQqjVzMzahPLCYkxuyw4aAjVxrM7Myn8p47
         HLOnuAPgYqfBrrDV6Uo3A67z+QqA0eNOKYrJYs9TNAeT+ewsMcIIO9ro0go/Oo7nqR
         B+RqputJFx73EZoB1dFct6Dz6sjjwr6JLVK3dU/KVA53h3my3mXfB52stJHvnAeHzo
         Q0cGuAgkolC1A==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 00/10] Extend and tweak mapping support
Date:   Fri,  3 Dec 2021 12:16:57 +0100
Message-Id: <20211203111707.3901969-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11969; h=from:subject; bh=zuM5tTPxzsck7oRn+EpLnbAqnOIqC558rK6tR0PbyJY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSu/DNV9Lf/sYwXCo5v7wWwPNnqcEc0L5Pp2Ks2+cZzAiKy /NUtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5bsHIsP5G1UWlvEjhDbYeF3WO2B kmzj31fa2IbH2CrQbfqv3yjxkZ/r6e/Lpg/dvSt7Pfy/49l+XjEVzG9G3fgsXfky6++OTuzQYA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

This is v3 with the review from Seth added.
All fstests pass. For the sake brevity only the idmapping and generic
vfs tests are shown but all other tests pass as well:

SECTION       -- ext4
RECREATING    -- ext4 on /dev/loop0
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 f2-vm 5.16.0-rc3-fs-idmapped-fs-f7c88bda45bb #19 SMP PREEMPT Fri Dec 3 10:38:36 UTC 2021
MKFS_OPTIONS  -- -F /dev/loop1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop1 /mnt/scratch

generic/633 2s ...  3s
generic/644 1s ...  1s
generic/645 2s ...  1s
generic/656 1s ...  2s
Ran: generic/633 generic/644 generic/645 generic/656
Passed all 4 tests

SECTION       -- xfs
RECREATING    -- xfs on /dev/loop0
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 f2-vm 5.16.0-rc3-fs-idmapped-fs-f7c88bda45bb #19 SMP PREEMPT Fri Dec 3 10:38:36 UTC 2021
MKFS_OPTIONS  -- -f -f /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/633 3s ...  4s
generic/644 1s ...  2s
generic/645 1s ...  4s
generic/656 2s ...  2s
xfs/152 50s ...  29s
xfs/153 9s ...  10s
Ran: generic/633 generic/644 generic/645 generic/656 xfs/152 xfs/153
Passed all 6 tests

SECTION       -- btrfs
RECREATING    -- btrfs on /dev/loop0
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 f2-vm 5.16.0-rc3-fs-idmapped-fs-f7c88bda45bb #19 SMP PREEMPT Fri Dec 3 10:38:36 UTC 2021
MKFS_OPTIONS  -- -f /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

btrfs/245 3s ...  3s
generic/633 4s ...  2s
generic/644 2s ...  1s
generic/645 4s ...  2s
generic/656 2s ...  1s
Ran: btrfs/245 generic/633 generic/644 generic/645 generic/656
Passed all 5 tests

SECTION       -- ext4
=========================
Ran: generic/633 generic/644 generic/645 generic/656
Passed all 4 tests

SECTION       -- xfs
=========================
Ran: generic/633 generic/644 generic/645 generic/656 xfs/152 xfs/153
Passed all 6 tests

SECTION       -- btrfs
=========================
Ran: btrfs/245 generic/633 generic/644 generic/645 generic/656
Passed all 5 tests

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
  fs: add is_idmapped_mnt() helper
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
 fs/ksmbd/smbacl.c                        |  19 +-
 fs/ksmbd/smbacl.h                        |   5 +-
 fs/namespace.c                           |  53 +++--
 fs/nfsd/export.c                         |   2 +-
 fs/open.c                                |   8 +-
 fs/overlayfs/super.c                     |   2 +-
 fs/posix_acl.c                           |  17 +-
 fs/proc_namespace.c                      |   2 +-
 fs/xfs/xfs_inode.c                       |   8 +-
 fs/xfs/xfs_linux.h                       |   1 +
 fs/xfs/xfs_symlink.c                     |   4 +-
 include/linux/fs.h                       | 141 ++++----------
 include/linux/mnt_idmapping.h            | 234 +++++++++++++++++++++++
 security/commoncap.c                     |  15 +-
 17 files changed, 356 insertions(+), 231 deletions(-)
 create mode 100644 include/linux/mnt_idmapping.h


base-commit: d58071a8a76d779eedab38033ae4c821c30295a5
-- 
2.30.2

