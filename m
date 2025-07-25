Return-Path: <linux-fsdevel+bounces-56023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60448B11D88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0905A5165
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095A2EA486;
	Fri, 25 Jul 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzEYTvrp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9122EA172;
	Fri, 25 Jul 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442856; cv=none; b=aUZloeq8L+xKRfD/39Pec5ZCCH47bsrb7btm1lETlMGP67anJDHMQbwUUIiNgh6UebfyyTt8M4mHLbSCtm9gawC6c6PT4OGRWxUh4MXzBLevybI3OkSIQX3QMAh+r4bvZ9E66EZ8KkkBzZveeIdAC/lbluVuIYY1KvZDnjB3inA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442856; c=relaxed/simple;
	bh=QPw8wpvjPNOsL250HpO87X7GEuwe16d5Ist5M/JBn2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mo3TnLGBiH9ze+VDE1ouMCtjKktWn2b9ss5Hm35wFuQoYVQAj/hLtWlqInEk1e+5riObtsYUtp0igr+jpCCVgZiM/2tPAV3gVJWvoqXbuKm79VQHnMEOdZ/EplWnJJL0tGmuKlLFv7FmlKvu/wQZdsfL+KLMIkv6ruRtL3QQE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzEYTvrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586F3C4CEE7;
	Fri, 25 Jul 2025 11:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442856;
	bh=QPw8wpvjPNOsL250HpO87X7GEuwe16d5Ist5M/JBn2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YzEYTvrp+nErkFJXSOxy0pY26JXf/BUR4C7tdqrz00BXJL0eR+/Vc6kW6FR/7D2lU
	 ZchSv0LNWPZJ5fLzrPT9YC1WSLGRptlT/rsPMomgop4EiOhbG6gzoclbzdweSZW2AJ
	 8dAhvPds6O/MoD+THK+g6I92SC7HPPy7V6XbtnDL4SGYm3bSMng+H2Dd25yf5/9Hbu
	 dMaZ2AxkmxRtic4jyQCFFNAB5/ksbyAP92AL55QW9E6kWbme+y8kPwubUhdB5pcG4m
	 HbR+B0x4RLFWlD7T+cf+ifbtF8fJhw6BdBw0bgX/HuB01oMXmja2IkfuFvyGuMDhVv
	 iPPFZsZr3H29w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 12/14 for v6.17] vfs fileattr
Date: Fri, 25 Jul 2025 13:27:18 +0200
Message-ID: <20250725-vfs-fileattr-fcfc534aac44@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6908; i=brauner@kernel.org; h=from:subject:message-id; bh=QPw8wpvjPNOsL250HpO87X7GEuwe16d5Ist5M/JBn2E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4ly9vGzxhWXN7n8f2rV/Djrx470gl11Xn+LNdNPV H9bWB7YUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHuyQz/i04d4Wh4N4uL4+LL NMs9wbn9V/MYveQ1v4fKB706UXxiMiPDoqwXnYJ/GHmuFxZZPdhx54re6tuyy2NOX3LbMKmy8/A sHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This introduces the new file_getattr() and file_setattr() system calls
after lengthy discussions. Both system calls serve as successors and
extensible companions to the FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR
system calls which have started to show their age in addition to being
named in a way that makes it easy to conflate them with extended
attribute related operations.

These syscalls allow userspace to set filesystem inode attributes on
special files. One of the usage examples is the XFS quota projects.

XFS has project quotas which could be attached to a directory. All new
inodes in these directories inherit project ID set on parent directory.

The project is created from userspace by opening and calling
FS_IOC_FSSETXATTR on each inode. This is not possible for special files
such as FIFO, SOCK, BLK etc. Therefore, some inodes are left with empty
project ID. Those inodes then are not shown in the quota accounting but
still exist in the directory. This is not critical but in the case when
special files are created in the directory with already existing project
quota, these new inodes inherit extended attributes. This creates a mix
of special files with and without attributes. Moreover, special files
with attributes don't have a possibility to become clear or change the
attributes. This, in turn, prevents userspace from re-creating quota
project on these existing files.

In addition, these new system calls allow the implementation of
additional attributes that we couldn't or didn't want to fit into the
legacy ioctls anymore.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.fileattr

for you to fetch changes up to e85931d1cd699307e6a3f1060cbe4c42748f3fff:

  fs: tighten a sanity check in file_attr_to_fileattr() (2025-07-16 10:22:01 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.fileattr tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.fileattr

----------------------------------------------------------------
Amir Goldstein (1):
      fs: prepare for extending file_get/setattr()

Andrey Albershteyn (5):
      fs: split fileattr related helpers into separate file
      lsm: introduce new hooks for setting/getting inode fsxattr
      selinux: implement inode_file_[g|s]etattr hooks
      fs: make vfs_fileattr_[get|set] return -EOPNOTSUPP
      fs: introduce file_getattr and file_setattr syscalls

Christian Brauner (2):
      Merge patch series "fs: introduce file_getattr and file_setattr syscalls"
      tree-wide: s/struct fileattr/struct file_kattr/g

Dan Carpenter (1):
      fs: tighten a sanity check in file_attr_to_fileattr()

 Documentation/filesystems/locking.rst       |   4 +-
 Documentation/filesystems/vfs.rst           |   4 +-
 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/tools/syscall.tbl                  |   2 +
 arch/arm64/tools/syscall_32.tbl             |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 fs/Makefile                                 |   3 +-
 fs/bcachefs/fs.c                            |   4 +-
 fs/btrfs/ioctl.c                            |   4 +-
 fs/btrfs/ioctl.h                            |   6 +-
 fs/ecryptfs/inode.c                         |   4 +-
 fs/efivarfs/inode.c                         |   4 +-
 fs/ext2/ext2.h                              |   4 +-
 fs/ext2/ioctl.c                             |   4 +-
 fs/ext4/ext4.h                              |   4 +-
 fs/ext4/ioctl.c                             |   4 +-
 fs/f2fs/f2fs.h                              |   4 +-
 fs/f2fs/file.c                              |   4 +-
 fs/file_attr.c                              | 498 ++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h                            |   4 +-
 fs/fuse/ioctl.c                             |   8 +-
 fs/gfs2/file.c                              |   4 +-
 fs/gfs2/inode.h                             |   4 +-
 fs/hfsplus/hfsplus_fs.h                     |   4 +-
 fs/hfsplus/inode.c                          |   4 +-
 fs/ioctl.c                                  | 309 -----------------
 fs/jfs/ioctl.c                              |   4 +-
 fs/jfs/jfs_inode.h                          |   4 +-
 fs/nilfs2/ioctl.c                           |   4 +-
 fs/nilfs2/nilfs.h                           |   4 +-
 fs/ocfs2/ioctl.c                            |   4 +-
 fs/ocfs2/ioctl.h                            |   4 +-
 fs/orangefs/inode.c                         |   4 +-
 fs/overlayfs/copy_up.c                      |   6 +-
 fs/overlayfs/inode.c                        |  17 +-
 fs/overlayfs/overlayfs.h                    |  10 +-
 fs/overlayfs/util.c                         |   2 +-
 fs/ubifs/ioctl.c                            |   4 +-
 fs/ubifs/ubifs.h                            |   4 +-
 fs/xfs/xfs_ioctl.c                          |  18 +-
 fs/xfs/xfs_ioctl.h                          |   4 +-
 include/linux/fileattr.h                    |  38 ++-
 include/linux/fs.h                          |   6 +-
 include/linux/lsm_hook_defs.h               |   2 +
 include/linux/security.h                    |  16 +
 include/linux/syscalls.h                    |   7 +
 include/uapi/asm-generic/unistd.h           |   8 +-
 include/uapi/linux/fs.h                     |  18 +
 mm/shmem.c                                  |   4 +-
 scripts/syscall.tbl                         |   2 +
 security/security.c                         |  30 ++
 security/selinux/hooks.c                    |  14 +
 64 files changed, 752 insertions(+), 410 deletions(-)
 create mode 100644 fs/file_attr.c

