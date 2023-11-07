Return-Path: <linux-fsdevel+bounces-2263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 834457E4221
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 15:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1B3B20CC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF42FE02;
	Tue,  7 Nov 2023 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cve460iX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051EF30F9B
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 14:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277B4C433C8;
	Tue,  7 Nov 2023 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699368797;
	bh=MaOv3uRMTC7lQ4NBx17LlalIHL3gMHwO/4ig3t9FTYs=;
	h=From:To:Cc:Subject:Date:From;
	b=Cve460iXGtNGqEQBh35z3TRxbV692UkhDwnIZjC4goeiVD1FKzANJVhDacbDYEg+8
	 JwOxD7xS9Qn8c/fwnX+RhI2QpQo19IvuVhmXMjwbOHHhfUwfN9+YTanzKOZwDYTp3I
	 wi6tay+6pPLsdBsjt2AzuIyGBCLeMYVfQHxNcMapQT7cnKeMDcgElWuGJrsmHH5n8k
	 Psi3goSxXLERogy58YG2o2r+XJ1p3QMERhltU1gd0/veaLqUVm2Pk6c4kRqy6b1+LZ
	 1b6QUx4KiCoBdRupYUF68xQFXHEW7EOQJkaDyMn62b9bw8y15UfCa4wOKaozVN7eTW
	 x8ZExeoC7jDPw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fanotify fsid updates
Date: Tue,  7 Nov 2023 15:49:05 +0100
Message-Id: <20231107-vfs-fsid-5037e344d215@brauner>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4496; i=brauner@kernel.org; h=from:subject:message-id; bh=7h6GXlgDapiairCQv3vt5Tjr1T20Utak+PtBsBNKJ5E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR6+dpwqH/9ckt6gubHD4Vz9r/Lfx0iuMizt6lQp2XrR7up S1raO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSd4aRYaeJzP7sm27pBw99O3PN8v +Lirdi611WzVI8fdz/jzC7nRzDH34Oxrp3Itft1z6Y6RG8d4pBL5PAnU8ac7xz3fNz0ywmcwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This work is part of the plan to enable fanotify to serve as a drop-in
replacement for inotify. While inotify is availabe on all filesystems,
fanotify currently isn't.

In order to support fanotify on all filesystems two things are needed:

(1) all filesystems need to support AT_HANDLE_FID
(2) all filesystems need to report a non-zero f_fsid

This pull request contains (1) and allows filesystems to encode
non-decodable file handlers for fanotify without implementing any
exportfs operations by encoding a file id of type FILEID_INO64_GEN from
i_ino and i_generation.

Filesystems that want to opt out of encoding non-decodable file ids for
fanotify that don't support NFS export can do so by providing an empty
export_operations struct.

The pull request also partially addresses (2) by generating f_fsid for
simple filesystems as well as freevxfs. Remaining filesystems will be
dealt with by separate patches.

Finally, this contains the patch from the current exportfs maintainers
which moves exportfs under vfs with Chuck, Jeff, and Amir as maintainers
and vfs.git as tree.

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.6-rc7 and have been sitting in linux-next.
A single build failure was reported but has since been fixed.

/* Conflicts */
This will have a merge conflict with the vfs-6.7.iomap pull request I
sent out earlier:

  [GIT PULL] vfs iomap updates
  https://lore.kernel.org/r/20231107-vfs-iomap-60b485c2b4fb@brauner

It should be fairly obvious how to resolve.

It will also have a merge conflict with current mainline that I suggest
to resolve as:

diff --cc Documentation/filesystems/porting.rst
index d69f59700a23,9cc6cb27c4d5..000000000000
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@@ -1050,5 -1050,7 +1050,14 @@@ kill_anon_super(), or kill_block_super(

  **mandatory**

 +Lock ordering has been changed so that s_umount ranks above open_mutex again.
 +All places where s_umount was taken under open_mutex have been fixed up.
++
++---
++
++**mandatory**
++
+ export_operations ->encode_fh() no longer has a default implementation to
+ encode FILEID_INO32_GEN* file handles.
+ Filesystems that used the default implementation may use the generic helper
+ generic_encode_ino32_fh() explicitly.

The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.fsid

for you to fetch changes up to 4ad714df58e646d4b2a454a7dface8ff903911c4:

  MAINTAINERS: create an entry for exportfs (2023-11-07 15:06:01 +0100)

Please consider pulling these changes from the signed vfs-6.7.fsid tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7.fsid

----------------------------------------------------------------
Amir Goldstein (8):
      exportfs: add helpers to check if filesystem can encode/decode file handles
      exportfs: make ->encode_fh() a mandatory method for NFS export
      exportfs: define FILEID_INO64_GEN* file handle types
      exportfs: support encoding non-decodeable file handles by default
      fs: report f_fsid from s_dev for "simple" filesystems
      freevxfs: derive f_fsid from bdev->bd_dev
      fs: fix build error with CONFIG_EXPORTFS=m or not defined
      MAINTAINERS: create an entry for exportfs

 Documentation/filesystems/nfs/exporting.rst |  7 +---
 Documentation/filesystems/porting.rst       |  9 +++++
 MAINTAINERS                                 | 13 ++++++-
 fs/affs/namei.c                             |  1 +
 fs/befs/linuxvfs.c                          |  1 +
 fs/efivarfs/super.c                         |  2 +
 fs/efs/super.c                              |  1 +
 fs/erofs/super.c                            |  1 +
 fs/exportfs/expfs.c                         | 57 ++++++++++-------------------
 fs/ext2/super.c                             |  1 +
 fs/ext4/super.c                             |  1 +
 fs/f2fs/super.c                             |  1 +
 fs/fat/nfs.c                                |  1 +
 fs/fhandle.c                                |  6 +--
 fs/freevxfs/vxfs_super.c                    |  2 +
 fs/fuse/inode.c                             |  7 ++--
 fs/hugetlbfs/inode.c                        |  2 +
 fs/jffs2/super.c                            |  1 +
 fs/jfs/super.c                              |  1 +
 fs/libfs.c                                  | 44 ++++++++++++++++++++++
 fs/nfsd/export.c                            |  3 +-
 fs/notify/fanotify/fanotify_user.c          |  4 +-
 fs/ntfs/namei.c                             |  1 +
 fs/ntfs3/super.c                            |  1 +
 fs/overlayfs/util.c                         |  2 +-
 fs/smb/client/export.c                      | 11 +++---
 fs/squashfs/export.c                        |  1 +
 fs/ufs/super.c                              |  1 +
 include/linux/exportfs.h                    | 50 +++++++++++++++++++++++--
 29 files changed, 168 insertions(+), 65 deletions(-)

