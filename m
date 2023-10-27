Return-Path: <linux-fsdevel+bounces-1377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211067D9C2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F8B1C2108F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17937168;
	Fri, 27 Oct 2023 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxMKHBk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907620307
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 14:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE3AC433C7;
	Fri, 27 Oct 2023 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698418297;
	bh=blKWZpijBMf809KyFafStEDUjjEYN8wRceKFOG5/Pgg=;
	h=From:To:Cc:Subject:Date:From;
	b=OxMKHBk922gShjrR0C24JZVtA7dwF9IZ7tGxCknJ4gItDy1Km+LLxggZwXk4LhxMz
	 Qn5lz6rf8NOhi8OB0MkqX/fPUxXppvEltXOtW4q/7AN4faXbS9lrviXaxwH/o0rBwz
	 /Omdhg5VpDrKIh9gFMNOccVuS4c65iYg5IbtUM88YVqPW5X3o1UXcQX3bJafDrH2gU
	 s5S5V+17jN6FAjHu3fzvDozCygNhvltuwXJY+cnp5Lk0EImaFOsvL8YbHGdlVl2fE2
	 Okm1xj5E91JUPVQ6C0UszM89ySVBcERhrx7Rw1h1St66H3yLXFZa/H6NV2+JXFjJ46
	 gS800gk8IhjpQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.7] vfs time updates
Date: Fri, 27 Oct 2023 16:51:07 +0200
Message-Id: <20231027-vfs-ctime-6271b23ced64@brauner>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20511; i=brauner@kernel.org; h=from:subject:message-id; bh=Fs7WU5tqmLwWm02taffXgfp/RJWw0Nb3QlIfcLwcuok=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRan004eb16S/H0mxrMLCm31zwS23+zvkZ8X5FuzsSm3dfn GUYs6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjItzcM/52Xuf9Xtzvw+A3/czb5FW +m3m7xMLC5eMcvb41i8q3PLhcYGY5a9rOyds754a/wOzxvjwHXVcGla11X8mjvP69WO7XHjhkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This pull request will have a merge conflict with the vfs-6.7.super
pr that will be available under the following link once sent:

    https://lore.kernel.org/r/20231027-vfs-super-aa4b9ecfd803@brauner

/* Summary */
This finishes the conversion of all inode time fields to accessor
functions as discussed on list. Changing timestamps manually as we used
to do before is error prone. Using accessors function makes this robust.

It does not contain the switch of the time fields to discrete 64 bit
integers to replace struct timespec and free up space in struct inode.
But after this, the switch can be trivially made and the patch should
only affect the vfs if we decide to do it.

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.6-rc5 and have been sitting in linux-next.
No build failures or warnings were observed. xfstests were run for the
major filesystems. They pass.

/* Conflicts */

## Merge Conflicts with other trees

The following trees will have a merge conflict with this tree.

[1] linux-next: manual merge of the vfs-brauner tree with the ntfs3 tree
    https://lore.kernel.org/r/20231010103744.2e7085a6@canb.auug.org.au

[2] linux-next: manual merge of the vfs-brauner tree with the ext3 tree
    https://lore.kernel.org/r/20231027104356.3fda2bc9@canb.auug.org.au

[3] This will have a merge conflict with the btrfs and vfs.super trees.
    The vfs.super tree does contain the btrfs tree this cycle and the
    conflict resolution will be provided on the vfs-6.7.super pr as
    mentioned above.

[4] For bcachefs a whole separate patch would be needed:

>From 7aaefe3c8d4eda19519235c7a575d964120e31a5 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 Sep 2023 08:41:01 -0400
Subject: [PATCH] bcachefs: convert to new timestamp accessors

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/bcachefs/fs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 09137a20449b..1fbaad27d07b 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -66,9 +66,9 @@ void bch2_inode_update_after_write(struct btree_trans *trans,
 	inode->v.i_mode	= bi->bi_mode;
 
 	if (fields & ATTR_ATIME)
-		inode->v.i_atime = bch2_time_to_timespec(c, bi->bi_atime);
+		inode_set_atime_to_ts(&inode->v, bch2_time_to_timespec(c, bi->bi_atime));
 	if (fields & ATTR_MTIME)
-		inode->v.i_mtime = bch2_time_to_timespec(c, bi->bi_mtime);
+		inode_set_mtime_to_ts(&inode->v, bch2_time_to_timespec(c, bi->bi_mtime));
 	if (fields & ATTR_CTIME)
 		inode_set_ctime_to_ts(&inode->v, bch2_time_to_timespec(c, bi->bi_ctime));
 
@@ -753,8 +753,8 @@ static int bch2_getattr(struct mnt_idmap *idmap,
 	stat->gid	= inode->v.i_gid;
 	stat->rdev	= inode->v.i_rdev;
 	stat->size	= i_size_read(&inode->v);
-	stat->atime	= inode->v.i_atime;
-	stat->mtime	= inode->v.i_mtime;
+	stat->atime	= inode_get_atime(&inode->v);
+	stat->mtime	= inode_get_mtime(&inode->v);
 	stat->ctime	= inode_get_ctime(&inode->v);
 	stat->blksize	= block_bytes(c);
 	stat->blocks	= inode->v.i_blocks;
@@ -1418,8 +1418,8 @@ static int inode_update_times_fn(struct btree_trans *trans,
 {
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
 
-	bi->bi_atime	= timespec_to_bch2_time(c, inode->v.i_atime);
-	bi->bi_mtime	= timespec_to_bch2_time(c, inode->v.i_mtime);
+	bi->bi_atime	= timespec_to_bch2_time(c, inode_get_atime(&inode->v));
+	bi->bi_mtime	= timespec_to_bch2_time(c, inode_get_mtime(&inode->v));
 	bi->bi_ctime	= timespec_to_bch2_time(c, inode_get_ctime(&inode->v));
 
 	return 0;
-- 
2.34.1

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.ctime

for you to fetch changes up to 12cd44023651666bd44baa36a5c999698890debb:

  fs: rename inode i_atime and i_mtime fields (2023-10-18 14:08:31 +0200)

Please consider pulling these changes from the signed vfs-6.7.ctime tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7.ctime

----------------------------------------------------------------
Jeff Layton (86):
      fs: new accessor methods for atime and mtime
      fs: convert core infrastructure to new timestamp accessors
      spufs: convert to new timestamp accessors
      hypfs: convert to new timestamp accessors
      android: convert to new timestamp accessors
      char: convert to new timestamp accessors
      qib: convert to new timestamp accessors
      ibmasm: convert to new timestamp accessors
      misc: convert to new timestamp accessors
      x86: convert to new timestamp accessors
      tty: convert to new timestamp accessors
      function: convert to new timestamp accessors
      legacy: convert to new timestamp accessors
      usb: convert to new timestamp accessors
      9p: convert to new timestamp accessors
      adfs: convert to new timestamp accessors
      affs: convert to new timestamp accessors
      afs: convert to new timestamp accessors
      autofs: convert to new timestamp accessors
      befs: convert to new timestamp accessors
      bfs: convert to new timestamp accessors
      btrfs: convert to new timestamp accessors
      ceph: convert to new timestamp accessors
      coda: convert to new timestamp accessors
      configfs: convert to new timestamp accessors
      cramfs: convert to new timestamp accessors
      debugfs: convert to new timestamp accessors
      devpts: convert to new timestamp accessors
      efivarfs: convert to new timestamp accessors
      efs: convert to new timestamp accessors
      erofs: convert to new timestamp accessors
      exfat: convert to new timestamp accessors
      ext2: convert to new timestamp accessors
      ext4: convert to new timestamp accessors
      f2fs: convert to new timestamp accessors
      fat: convert to new timestamp accessors
      freevxfs: convert to new timestamp accessors
      fuse: convert to new timestamp accessors
      gfs2: convert to new timestamp accessors
      hfs: convert to new timestamp accessors
      hfsplus: convert to new timestamp accessors
      hostfs: convert to new timestamp accessors
      hpfs: convert to new timestamp accessors
      hugetlbfs: convert to new timestamp accessors
      isofs: convert to new timestamp accessors
      jffs2: convert to new timestamp accessors
      jfs: convert to new timestamp accessors
      kernfs: convert to new timestamp accessors
      minix: convert to new timestamp accessors
      nfs: convert to new timestamp accessors
      nfsd: convert to new timestamp accessors
      nilfs2: convert to new timestamp accessors
      ntfs: convert to new timestamp accessors
      ntfs3: convert to new timestamp accessors
      ocfs2: convert to new timestamp accessors
      omfs: convert to new timestamp accessors
      openpromfs: convert to new timestamp accessors
      orangefs: convert to new timestamp accessors
      overlayfs: convert to new timestamp accessors
      proc: convert to new timestamp accessors
      pstore: convert to new timestamp accessors
      qnx4: convert to new timestamp accessors
      qnx6: convert to new timestamp accessors
      ramfs: convert to new timestamp accessors
      reiserfs: convert to new timestamp accessors
      romfs: convert to new timestamp accessors
      client: convert to new timestamp accessors
      server: convert to new timestamp accessors
      squashfs: convert to new timestamp accessors
      sysv: convert to new timestamp accessors
      tracefs: convert to new timestamp accessors
      ubifs: convert to new timestamp accessors
      udf: convert to new timestamp accessors
      ufs: convert to new timestamp accessors
      vboxsf: convert to new timestamp accessors
      xfs: convert to new timestamp accessors
      zonefs: convert to new timestamp accessors
      linux: convert to new timestamp accessors
      ipc: convert to new timestamp accessors
      bpf: convert to new timestamp accessors
      mm: convert to new timestamp accessors
      sunrpc: convert to new timestamp accessors
      apparmor: convert to new timestamp accessors
      selinux: convert to new timestamp accessors
      security: convert to new timestamp accessors
      fs: rename inode i_atime and i_mtime fields

 arch/powerpc/platforms/cell/spufs/inode.c |  2 +-
 arch/s390/hypfs/inode.c                   |  4 +-
 drivers/android/binderfs.c                |  8 +--
 drivers/char/sonypi.c                     |  2 +-
 drivers/infiniband/hw/qib/qib_fs.c        |  4 +-
 drivers/misc/ibmasm/ibmasmfs.c            |  2 +-
 drivers/misc/ibmvmc.c                     |  2 +-
 drivers/platform/x86/sony-laptop.c        |  2 +-
 drivers/tty/tty_io.c                      | 10 ++--
 drivers/usb/core/devio.c                  | 26 +++++----
 drivers/usb/gadget/function/f_fs.c        |  4 +-
 drivers/usb/gadget/legacy/inode.c         |  2 +-
 fs/9p/vfs_inode.c                         |  6 +--
 fs/9p/vfs_inode_dotl.c                    | 16 +++---
 fs/adfs/inode.c                           | 13 +++--
 fs/affs/amigaffs.c                        |  4 +-
 fs/affs/inode.c                           | 17 +++---
 fs/afs/dynroot.c                          |  2 +-
 fs/afs/inode.c                            |  8 +--
 fs/afs/write.c                            |  2 +-
 fs/attr.c                                 |  4 +-
 fs/autofs/inode.c                         |  2 +-
 fs/autofs/root.c                          |  6 +--
 fs/bad_inode.c                            |  2 +-
 fs/befs/linuxvfs.c                        | 10 ++--
 fs/bfs/dir.c                              |  9 ++--
 fs/bfs/inode.c                            | 12 ++---
 fs/binfmt_misc.c                          |  2 +-
 fs/btrfs/delayed-inode.c                  | 20 +++----
 fs/btrfs/file.c                           | 18 ++++---
 fs/btrfs/inode.c                          | 43 ++++++++-------
 fs/btrfs/reflink.c                        |  2 +-
 fs/btrfs/transaction.c                    |  3 +-
 fs/btrfs/tree-log.c                       | 12 ++---
 fs/ceph/addr.c                            | 10 ++--
 fs/ceph/caps.c                            |  4 +-
 fs/ceph/file.c                            |  2 +-
 fs/ceph/inode.c                           | 64 ++++++++++++----------
 fs/ceph/mds_client.c                      |  8 ++-
 fs/ceph/snap.c                            |  4 +-
 fs/coda/coda_linux.c                      |  6 ++-
 fs/coda/dir.c                             |  2 +-
 fs/coda/file.c                            |  2 +-
 fs/configfs/inode.c                       |  8 +--
 fs/cramfs/inode.c                         |  4 +-
 fs/debugfs/inode.c                        |  2 +-
 fs/devpts/inode.c                         |  6 +--
 fs/efivarfs/file.c                        |  2 +-
 fs/efivarfs/inode.c                       |  2 +-
 fs/efs/inode.c                            |  5 +-
 fs/erofs/inode.c                          |  3 +-
 fs/exfat/exfat_fs.h                       |  1 +
 fs/exfat/file.c                           |  7 ++-
 fs/exfat/inode.c                          | 31 ++++++-----
 fs/exfat/misc.c                           |  8 +++
 fs/exfat/namei.c                          | 31 +++++------
 fs/exfat/super.c                          |  4 +-
 fs/ext2/dir.c                             |  6 +--
 fs/ext2/ialloc.c                          |  2 +-
 fs/ext2/inode.c                           | 13 +++--
 fs/ext2/super.c                           |  2 +-
 fs/ext4/ext4.h                            | 20 +++++--
 fs/ext4/extents.c                         | 11 ++--
 fs/ext4/ialloc.c                          |  4 +-
 fs/ext4/inline.c                          |  4 +-
 fs/ext4/inode.c                           | 19 +++----
 fs/ext4/ioctl.c                           | 13 ++++-
 fs/ext4/namei.c                           | 10 ++--
 fs/ext4/super.c                           |  2 +-
 fs/ext4/xattr.c                           |  8 +--
 fs/f2fs/dir.c                             |  6 +--
 fs/f2fs/f2fs.h                            | 10 ++--
 fs/f2fs/file.c                            | 14 ++---
 fs/f2fs/inline.c                          |  2 +-
 fs/f2fs/inode.c                           | 24 ++++-----
 fs/f2fs/namei.c                           |  4 +-
 fs/f2fs/recovery.c                        |  8 +--
 fs/f2fs/super.c                           |  2 +-
 fs/fat/inode.c                            | 25 ++++++---
 fs/fat/misc.c                             |  6 +--
 fs/freevxfs/vxfs_inode.c                  |  6 +--
 fs/fuse/control.c                         |  2 +-
 fs/fuse/dir.c                             | 10 ++--
 fs/fuse/inode.c                           | 29 +++++-----
 fs/fuse/readdir.c                         |  6 ++-
 fs/gfs2/bmap.c                            | 10 ++--
 fs/gfs2/dir.c                             | 10 ++--
 fs/gfs2/glops.c                           | 11 ++--
 fs/gfs2/inode.c                           |  7 +--
 fs/gfs2/quota.c                           |  2 +-
 fs/gfs2/super.c                           | 12 ++---
 fs/hfs/catalog.c                          |  8 +--
 fs/hfs/inode.c                            | 16 +++---
 fs/hfs/sysdep.c                           | 10 ++--
 fs/hfsplus/catalog.c                      |  8 +--
 fs/hfsplus/inode.c                        | 22 ++++----
 fs/hostfs/hostfs_kern.c                   | 12 +++--
 fs/hpfs/dir.c                             | 12 +++--
 fs/hpfs/inode.c                           | 16 +++---
 fs/hpfs/namei.c                           | 22 ++++----
 fs/hpfs/super.c                           | 10 ++--
 fs/hugetlbfs/inode.c                      | 10 ++--
 fs/inode.c                                | 35 +++++++-----
 fs/isofs/inode.c                          |  4 +-
 fs/isofs/rock.c                           | 18 +++----
 fs/jffs2/dir.c                            | 35 ++++++------
 fs/jffs2/file.c                           |  4 +-
 fs/jffs2/fs.c                             | 20 +++----
 fs/jffs2/os-linux.h                       |  4 +-
 fs/jfs/inode.c                            |  2 +-
 fs/jfs/jfs_imap.c                         | 20 +++----
 fs/jfs/jfs_inode.c                        |  4 +-
 fs/jfs/namei.c                            | 20 +++----
 fs/jfs/super.c                            |  2 +-
 fs/kernfs/inode.c                         |  6 +--
 fs/libfs.c                                | 41 ++++++++++----
 fs/minix/bitmap.c                         |  2 +-
 fs/minix/dir.c                            |  6 +--
 fs/minix/inode.c                          | 17 +++---
 fs/minix/itree_common.c                   |  2 +-
 fs/nfs/callback_proc.c                    |  2 +-
 fs/nfs/fscache.h                          |  4 +-
 fs/nfs/inode.c                            | 30 +++++------
 fs/nfsd/blocklayout.c                     |  3 +-
 fs/nfsd/nfs3proc.c                        |  4 +-
 fs/nfsd/nfs4proc.c                        |  8 +--
 fs/nfsd/nfsctl.c                          |  2 +-
 fs/nfsd/vfs.c                             |  2 +-
 fs/nilfs2/dir.c                           |  6 +--
 fs/nilfs2/inode.c                         | 20 +++----
 fs/nsfs.c                                 |  2 +-
 fs/ntfs/inode.c                           | 25 ++++-----
 fs/ntfs/mft.c                             |  2 +-
 fs/ntfs3/file.c                           |  6 +--
 fs/ntfs3/frecord.c                        | 11 ++--
 fs/ntfs3/inode.c                          | 24 +++++----
 fs/ntfs3/namei.c                          |  4 +-
 fs/ocfs2/acl.c                            |  4 +-
 fs/ocfs2/alloc.c                          |  6 +--
 fs/ocfs2/aops.c                           |  6 +--
 fs/ocfs2/dir.c                            |  9 ++--
 fs/ocfs2/dlmfs/dlmfs.c                    |  4 +-
 fs/ocfs2/dlmglue.c                        | 29 +++++-----
 fs/ocfs2/file.c                           | 30 ++++++-----
 fs/ocfs2/inode.c                          | 28 +++++-----
 fs/ocfs2/move_extents.c                   |  4 +-
 fs/ocfs2/namei.c                          | 16 +++---
 fs/ocfs2/refcounttree.c                   | 12 ++---
 fs/ocfs2/xattr.c                          |  4 +-
 fs/omfs/inode.c                           | 12 ++---
 fs/openpromfs/inode.c                     |  4 +-
 fs/orangefs/orangefs-utils.c              | 16 +++---
 fs/overlayfs/file.c                       |  9 ++--
 fs/overlayfs/inode.c                      |  3 +-
 fs/overlayfs/util.c                       |  4 +-
 fs/pipe.c                                 |  2 +-
 fs/proc/base.c                            |  2 +-
 fs/proc/inode.c                           |  2 +-
 fs/proc/proc_sysctl.c                     |  2 +-
 fs/proc/self.c                            |  2 +-
 fs/proc/thread_self.c                     |  2 +-
 fs/pstore/inode.c                         |  5 +-
 fs/qnx4/inode.c                           |  6 +--
 fs/qnx6/inode.c                           |  6 +--
 fs/ramfs/inode.c                          |  7 +--
 fs/reiserfs/inode.c                       | 26 ++++-----
 fs/reiserfs/namei.c                       |  8 +--
 fs/reiserfs/stree.c                       |  5 +-
 fs/reiserfs/super.c                       |  2 +-
 fs/romfs/super.c                          |  3 +-
 fs/smb/client/file.c                      | 18 ++++---
 fs/smb/client/fscache.h                   |  6 +--
 fs/smb/client/inode.c                     | 17 +++---
 fs/smb/client/smb2ops.c                   |  6 ++-
 fs/smb/server/smb2pdu.c                   |  8 +--
 fs/squashfs/inode.c                       |  6 +--
 fs/stack.c                                |  4 +-
 fs/stat.c                                 |  4 +-
 fs/sysv/dir.c                             |  6 +--
 fs/sysv/ialloc.c                          |  2 +-
 fs/sysv/inode.c                           | 12 ++---
 fs/sysv/itree.c                           |  2 +-
 fs/tracefs/inode.c                        |  2 +-
 fs/ubifs/debug.c                          | 12 ++---
 fs/ubifs/dir.c                            | 23 +++++---
 fs/ubifs/file.c                           | 16 +++---
 fs/ubifs/journal.c                        | 12 ++---
 fs/ubifs/super.c                          |  8 +--
 fs/udf/ialloc.c                           |  4 +-
 fs/udf/inode.c                            | 38 +++++++------
 fs/udf/namei.c                            | 16 +++---
 fs/ufs/dir.c                              |  6 +--
 fs/ufs/ialloc.c                           |  2 +-
 fs/ufs/inode.c                            | 42 ++++++++-------
 fs/vboxsf/utils.c                         | 15 +++---
 fs/xfs/libxfs/xfs_inode_buf.c             | 10 ++--
 fs/xfs/libxfs/xfs_rtbitmap.c              |  6 ++-
 fs/xfs/libxfs/xfs_trans_inode.c           |  2 +-
 fs/xfs/xfs_bmap_util.c                    |  7 +--
 fs/xfs/xfs_inode.c                        |  4 +-
 fs/xfs/xfs_inode_item.c                   |  4 +-
 fs/xfs/xfs_iops.c                         |  8 +--
 fs/xfs/xfs_itable.c                       | 12 ++---
 fs/xfs/xfs_rtalloc.c                      | 30 ++++++-----
 fs/zonefs/super.c                         | 10 ++--
 include/linux/fs.h                        | 89 +++++++++++++++++++++++++------
 include/linux/fs_stack.h                  |  6 +--
 ipc/mqueue.c                              | 19 +++----
 kernel/bpf/inode.c                        |  5 +-
 mm/shmem.c                                | 20 +++----
 net/sunrpc/rpc_pipe.c                     |  2 +-
 security/apparmor/apparmorfs.c            |  7 +--
 security/apparmor/policy_unpack.c         |  4 +-
 security/inode.c                          |  2 +-
 security/selinux/selinuxfs.c              |  2 +-
 215 files changed, 1194 insertions(+), 982 deletions(-)

