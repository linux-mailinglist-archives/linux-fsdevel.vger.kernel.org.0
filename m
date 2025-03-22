Return-Path: <linux-fsdevel+bounces-44769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4918DA6C904
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB88D3B725C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD331F872C;
	Sat, 22 Mar 2025 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXEN+9R8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0631F4E5B;
	Sat, 22 Mar 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638511; cv=none; b=Mn7/Ay3QozcgSTkgdKjp3nENdT069EXg3lVck5im8WPP+tS8ZtvWZkVF6QxuMjhkxSIECZ/Qf7VHehTeCtkOURjYJCd+t+Y/3WcmjCG7H+NEV70tUYMDTpLYpdyJX+TaqLtiICcsyjPP1QZ0PDodtAqMHbRlMSM/HmF3Jo9CRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638511; c=relaxed/simple;
	bh=VwuWqCuq/nahe3KrsnNCNONybwm09cdnbnt4rBD0E+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6l2U/PiMg5a+p2BRYYZNcud9+QFZf2rPuJMdywOJgsFN4jaaWtt/iJNXrSzhJr5jz377LOdRJ++iJVuqyrHLVuXpvTKYUBA6NVNF0H3qd4mZI8QB0MbXAD58lZrGG8xa+9bUcU8D1sP7F+qQSnsZeSqFZ3Nllzg2z7zaNFhIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXEN+9R8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6469FC4CEDD;
	Sat, 22 Mar 2025 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638510;
	bh=VwuWqCuq/nahe3KrsnNCNONybwm09cdnbnt4rBD0E+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=IXEN+9R82iDtvBnAxJlQfAtB31Ut+n6+YgecDGFvzDPsLi7MGY4w0tcerc141cb9+
	 JAhUxnvOgfP6RC6r1KpjHCkRN1imgmK+EWCzKBLSmLtjs6t3yeClVuWcJrZPHuNjPR
	 gEHa1QNd103jdgiQ6k02SoJFsNpeh4Ks+kHilvr1cI3So+SXbPModEDKSgDfZgGLK3
	 TvFlJxMcpM62DzFXL57lBSbNkT/8JoSSdr4voAEFgQlexu6C6DdzlR+8QymYIhse6G
	 zpG9ryb9QOCCjOsiEdDYmKz0jyWMIO3sZqR5XpEycykKm/oLaTxR984bLBVn3FH0pU
	 UhiosH22GdLWg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs mkdir
Date: Sat, 22 Mar 2025 11:15:02 +0100
Message-ID: <20250322-vfs-mkdir-78768e0d8dee@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8812; i=brauner@kernel.org; h=from:subject:message-id; bh=VwuWqCuq/nahe3KrsnNCNONybwm09cdnbnt4rBD0E+Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf612xaUGcdtIqs6lG+1kK9uwVZ772eVvl3tDtJsmfz Vi5DyWf7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIGWFGhqa1D4rfzJy2oen/ qqbNL0TePrrvaPRwukDznYYndYZ1ufUM/8PsqncU37+wtfKWvUnb1V3yLScuyG/9UmwhclHe2G7 GKwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains cleanups that fell out of the work from async directory
handling:

- Change kern_path_locked() and user_path_locked_at() to never return a
  negative dentry. This simplifies the usability of these helpers in
  various places.

- Drop d_exact_alias() from the remaining place in NFS where it is still
  used. This also allows us to drop the d_exact_alias() helper completely.

- Drop an unnecessary call to fh_update() from nfsd_create_locked().

- Change i_op->mkdir() to return a struct dentry.

  Change vfs_mkdir() to return a dentry provided by the filesystems
  which is hashed and positive. This allows us to reduce the number of
  cases where the resulting dentry is not positive to very few cases.
  The code in these places becomes simpler and easier to understand.

- Repack DENTRY_* and LOOKUP_* flags.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This contains a merge conflict with current mainline:

diff --cc Documentation/filesystems/porting.rst
index 12a71ba221b8,6817614e0820..000000000000
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@@ -1160,5 -1160,39 +1160,44 @@@ magic
  
  ---
  
 +** mandatory **
 +invalidate_inodes() is gone use evict_inodes() instead.
++
++---
++
+ ** recommended**
+ 
+ kern_path_locked() and user_path_locked() no longer return a negative
+ dentry so this doesn't need to be checked.  If the name cannot be found,
+ ERR_PTR(-ENOENT) is returned.
+ 
+ ** recommend**
+ 
+ lookup_one_qstr_excl() is changed to return errors in more cases, so
+ these conditions don't require explicit checks:
+ 
+  - if LOOKUP_CREATE is NOT given, then the dentry won't be negative,
+    ERR_PTR(-ENOENT) is returned instead
+  - if LOOKUP_EXCL IS given, then the dentry won't be positive,
+    ERR_PTR(-EEXIST) is rreturned instread
+ 
+ LOOKUP_EXCL now means "target must not exist".  It can be combined with
+ LOOK_CREATE or LOOKUP_RENAME_TARGET.
+ 
+ ---
+ 
+ ** mandatory**
+ 
+ ->mkdir() now returns a dentry.  If the created inode is found to
+ already be in cache and have a dentry (often IS_ROOT()), it will need to
+ be spliced into the given name in place of the given dentry. That dentry
+ now needs to be returned.  If the original dentry is used, NULL should
+ be returned.  Any error should be returned with ERR_PTR().
+ 
+ In general, filesystems which use d_instantiate_new() to install the new
+ inode can safely return NULL.  Filesystems which may not have an I_NEW inode
+ should use d_drop();d_splice_alias() and return the result of the latter.
+ 
+ If a positive dentry cannot be returned for some reason, in-kernel
+ clients such as cachefiles, nfsd, smb/server may not perform ideally but
+ will fail-safe.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.async.dir

for you to fetch changes up to be6690199719a2968628713a746002fda14bd595:

  doc: fix inline emphasis warning (2025-03-05 11:52:50 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.async.dir tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.async.dir

----------------------------------------------------------------
Christian Brauner (4):
      Merge patch series "VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry"
      Merge patch series "prep patches for my mkdir series"
      Merge patch series "Change inode_operations.mkdir to return struct dentry *"
      doc: fix inline emphasis warning

NeilBrown (12):
      VFS: repack DENTRY_ flags.
      VFS: repack LOOKUP_ bit flags.
      VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry
      VFS: add common error checks to lookup_one_qstr_excl()
      nfs/vfs: discard d_exact_alias()
      nfsd: drop fh_update() from S_IFDIR branch of nfsd_create_locked()
      Change inode_operations.mkdir to return struct dentry *
      hostfs: store inode in dentry after mkdir if possible.
      ceph: return the correct dentry on mkdir
      fuse: return correct dentry for ->mkdir
      nfs: change mkdir inode_operation to return alternate dentry if needed.
      VFS: Change vfs_mkdir() to return the dentry.

 Documentation/filesystems/locking.rst |   2 +-
 Documentation/filesystems/porting.rst |  39 +++++++++++++
 Documentation/filesystems/vfs.rst     |  23 +++++++-
 drivers/base/devtmpfs.c               |  72 +++++++++++------------
 fs/9p/vfs_inode.c                     |   7 +--
 fs/9p/vfs_inode_dotl.c                |   8 +--
 fs/affs/affs.h                        |   2 +-
 fs/affs/namei.c                       |   8 +--
 fs/afs/dir.c                          |  12 ++--
 fs/autofs/root.c                      |  14 ++---
 fs/bad_inode.c                        |   6 +-
 fs/bcachefs/fs-ioctl.c                |   4 --
 fs/bcachefs/fs.c                      |   6 +-
 fs/btrfs/inode.c                      |   8 +--
 fs/cachefiles/namei.c                 |  16 +++---
 fs/ceph/dir.c                         |  30 ++++++----
 fs/coda/dir.c                         |  14 ++---
 fs/configfs/dir.c                     |   6 +-
 fs/dcache.c                           |  46 ---------------
 fs/ecryptfs/inode.c                   |  20 ++++---
 fs/exfat/namei.c                      |   8 +--
 fs/ext2/namei.c                       |   9 +--
 fs/ext4/namei.c                       |  10 ++--
 fs/f2fs/namei.c                       |  14 ++---
 fs/fat/namei_msdos.c                  |   8 +--
 fs/fat/namei_vfat.c                   |   8 +--
 fs/fuse/dir.c                         |  50 ++++++++++------
 fs/gfs2/inode.c                       |   9 +--
 fs/hfs/dir.c                          |  10 ++--
 fs/hfsplus/dir.c                      |   6 +-
 fs/hostfs/hostfs_kern.c               |  16 ++++--
 fs/hpfs/namei.c                       |  10 ++--
 fs/hugetlbfs/inode.c                  |   6 +-
 fs/init.c                             |   7 ++-
 fs/jffs2/dir.c                        |  18 +++---
 fs/jfs/namei.c                        |   8 +--
 fs/kernfs/dir.c                       |  12 ++--
 fs/minix/namei.c                      |   8 +--
 fs/namei.c                            | 105 ++++++++++++++++++----------------
 fs/nfs/dir.c                          |  20 +++----
 fs/nfs/internal.h                     |   4 +-
 fs/nfs/nfs3proc.c                     |  29 +++++-----
 fs/nfs/nfs4proc.c                     |  47 ++++++++++-----
 fs/nfs/proc.c                         |  12 ++--
 fs/nfsd/nfs4recover.c                 |   7 ++-
 fs/nfsd/vfs.c                         |  34 ++++-------
 fs/nilfs2/namei.c                     |   8 +--
 fs/ntfs3/namei.c                      |   8 +--
 fs/ocfs2/dlmfs/dlmfs.c                |  10 ++--
 fs/ocfs2/namei.c                      |  10 ++--
 fs/omfs/dir.c                         |   6 +-
 fs/orangefs/namei.c                   |   8 +--
 fs/overlayfs/dir.c                    |  46 +++------------
 fs/overlayfs/overlayfs.h              |  15 +++--
 fs/overlayfs/super.c                  |   7 ++-
 fs/ramfs/inode.c                      |   6 +-
 fs/smb/client/cifsfs.h                |   4 +-
 fs/smb/client/inode.c                 |  10 ++--
 fs/smb/server/vfs.c                   |  58 +++++++------------
 fs/sysv/namei.c                       |   6 +-
 fs/tracefs/inode.c                    |  10 ++--
 fs/ubifs/dir.c                        |  10 ++--
 fs/udf/namei.c                        |  12 ++--
 fs/ufs/namei.c                        |   8 +--
 fs/vboxsf/dir.c                       |   8 +--
 fs/xfs/scrub/orphanage.c              |   9 +--
 fs/xfs/xfs_iops.c                     |   4 +-
 include/linux/dcache.h                |  39 ++++++-------
 include/linux/fs.h                    |   8 +--
 include/linux/namei.h                 |  45 ++++++++-------
 include/linux/nfs_xdr.h               |   2 +-
 kernel/audit_watch.c                  |  12 ++--
 kernel/bpf/inode.c                    |   8 +--
 mm/shmem.c                            |   8 +--
 security/apparmor/apparmorfs.c        |   8 +--
 75 files changed, 614 insertions(+), 597 deletions(-)

