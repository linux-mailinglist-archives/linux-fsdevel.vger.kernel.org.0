Return-Path: <linux-fsdevel+bounces-70153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D4C929EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6934334D296
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D5C2C2349;
	Fri, 28 Nov 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFWP11ly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9B2C0F7F;
	Fri, 28 Nov 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348675; cv=none; b=AAyOh5NsZf4o+4phkC+6+qfx/Cr0S5pC8RPLRgZB8ODTXArEQ/hQZfOJD+WpFHGVL1Y+RA5bJtaLwlZgy9EqVvuUPqXIB4E0k2NnZokPWR4MglFvhNdepW3p9wT561N72N3ZFZMsd4P8h4c7tnB1+I9tbSrWeItMGJ4mKfpcqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348675; c=relaxed/simple;
	bh=/Uua+MwT9uT9RWCZ2Mc6uwd5dONKBm4+LNI6xV7ezQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ+Qq/C7VjcW3T3Pbofw0CwVvOsnwOE3UPX6VR+rkfXO+oCRkxsTR18jXKEpm/13570gn8Wp6UbZBgIiyqwL6OLQS5yktJz0oI7pBiSoSJQpsvy3tuaz6vvjTXoVuFEWSGHRoTHJjPIDv/DwTpdEUTRK2rlBL+ERXdVIi6P4zrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFWP11ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A25C4CEFB;
	Fri, 28 Nov 2025 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348674;
	bh=/Uua+MwT9uT9RWCZ2Mc6uwd5dONKBm4+LNI6xV7ezQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oFWP11lyUJcVRFp5tGeRYSkjQ/Rc+DlucfnQSwHgsyvGfGVStlwjbUYOiHf+Gc5ZV
	 GadkIJfMd8err3cP665i7ejLEhlpcmODmVJilL2PPEoORlFhC71s0hzk2SxDePpyAL
	 LWFPkbBg7yFavjVhpyPOObR25HcCMUu/FDxUP+Ift0zdnL/D8cF6H3h7VlszHofxqd
	 b1hT8FAJeqV8bm5Jjyof2rMTqrMVMhKtGm2VuD3bbd9HCjRZ4cGI7IUcGMhDAY+7xf
	 IJ1Xp1tyqyu1VVdDqcnILvg0GApJ0ec3WmC4PZpvksAazK63ZGIhpYbz2QWyt3xiuT
	 cwj/fBwIVrQSA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 03/17 for v6.19] vfs inode
Date: Fri, 28 Nov 2025 17:48:14 +0100
Message-ID: <20251128-vfs-inode-v619-730a38ce04b0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9286; i=brauner@kernel.org; h=from:subject:message-id; bh=/Uua+MwT9uT9RWCZ2Mc6uwd5dONKBm4+LNI6xV7ezQo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnqoeEnue7m78Rqv0Ax25Ud7TFV+36wpvX27a+Olq VXCMaf8O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaySpfhf30db0qJnazbngLT 8oip+9lm2v1vE1zMNS91hqu1xYb5Lxj+56THsuTcYZhywUfnR19Ad8CsDYEHU7qcaiQVuk4ZVWv xAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains inode specific changes for this cycle:

Features

- Hide inode->i_state behind accessors. Open-coded accesses prevent
  asserting they are done correctly. One obvious aspect is locking, but
  significantly more can be checked. For example it can be detected when
  the code is clearing flags which are already missing, or is setting
  flags when it is illegal (e.g., I_FREEING when ->i_count > 0).

- Provide accessors for ->i_state, converts all filesystems using coccinelle
  and manual conversions (btrfs, ceph, smb, f2fs, gfs2, overlayfs, nilfs2,
  xfs), and makes plain ->i_state access fail to compile.

- Rework I_NEW handling to operate without fences, simplifying the code
  after the accessor infrastructure is in place.

Cleanups

- Move wait_on_inode() from writeback.h to fs.h.

- Spell out fenced ->i_state accesses with explicit smp_wmb/smp_rmb
  for clarity.

- Cosmetic fixes to LRU handling.

- Push list presence check into inode_io_list_del().

- Touch up predicts in __d_lookup_rcu().

- ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage.

- Assert on ->i_count in iput_final().

- Assert ->i_lock held in __iget().

Fixes

- Add missing fences to I_NEW handling.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.inode

for you to fetch changes up to ca0d620b0afae20a7bcd5182606eba6860b2dbf2:

  dcache: touch up predicts in __d_lookup_rcu() (2025-11-28 10:31:45 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.inode tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.inode

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "hide ->i_state behind accessors"

Mateusz Guzik (22):
      fs: assert ->i_lock held in __iget()
      fs: assert on ->i_count in iput_final()
      ocfs2: retire ocfs2_drop_inode() and I_WILL_FREE usage
      fs: add missing fences to I_NEW handling
      fs: move wait_on_inode() from writeback.h to fs.h
      fs: spell out fenced ->i_state accesses with explicit smp_wmb/smp_rmb
      fs: provide accessors for ->i_state
      Coccinelle-based conversion to use ->i_state accessors
      Manual conversion to use ->i_state accessors of all places not covered by coccinelle
      btrfs: use the new ->i_state accessors
      ceph: use the new ->i_state accessors
      smb: use the new ->i_state accessors
      f2fs: use the new ->i_state accessors
      gfs2: use the new ->i_state accessors
      overlayfs: use the new ->i_state accessors
      nilfs2: use the new ->i_state accessors
      xfs: use the new ->i_state accessors
      fs: make plain ->i_state access fail to compile
      fs: rework I_NEW handling to operate without fences
      fs: cosmetic fixes to lru handling
      fs: push list presence check into inode_io_list_del()
      dcache: touch up predicts in __d_lookup_rcu()

 Documentation/filesystems/porting.rst |   2 +-
 block/bdev.c                          |   4 +-
 drivers/dax/super.c                   |   2 +-
 fs/9p/vfs_inode.c                     |   2 +-
 fs/9p/vfs_inode_dotl.c                |   2 +-
 fs/affs/inode.c                       |   2 +-
 fs/afs/dir.c                          |   4 +-
 fs/afs/dynroot.c                      |   6 +-
 fs/afs/inode.c                        |   8 +-
 fs/befs/linuxvfs.c                    |   2 +-
 fs/bfs/inode.c                        |   2 +-
 fs/btrfs/inode.c                      |  10 +-
 fs/buffer.c                           |   4 +-
 fs/ceph/cache.c                       |   2 +-
 fs/ceph/crypto.c                      |   4 +-
 fs/ceph/file.c                        |   4 +-
 fs/ceph/inode.c                       |  28 ++--
 fs/coda/cnode.c                       |   4 +-
 fs/cramfs/inode.c                     |   2 +-
 fs/crypto/keyring.c                   |   2 +-
 fs/crypto/keysetup.c                  |   2 +-
 fs/dcache.c                           |  29 ++--
 fs/drop_caches.c                      |   2 +-
 fs/ecryptfs/inode.c                   |   6 +-
 fs/efs/inode.c                        |   2 +-
 fs/erofs/inode.c                      |   2 +-
 fs/ext2/inode.c                       |   2 +-
 fs/ext4/inode.c                       |  13 +-
 fs/ext4/orphan.c                      |   4 +-
 fs/f2fs/data.c                        |   2 +-
 fs/f2fs/inode.c                       |   2 +-
 fs/f2fs/namei.c                       |   4 +-
 fs/f2fs/super.c                       |   2 +-
 fs/freevxfs/vxfs_inode.c              |   2 +-
 fs/fs-writeback.c                     | 132 +++++++++---------
 fs/fuse/inode.c                       |   4 +-
 fs/gfs2/file.c                        |   2 +-
 fs/gfs2/glock.c                       |   2 +-
 fs/gfs2/glops.c                       |   2 +-
 fs/gfs2/inode.c                       |   4 +-
 fs/gfs2/ops_fstype.c                  |   2 +-
 fs/hfs/btree.c                        |   2 +-
 fs/hfs/inode.c                        |   2 +-
 fs/hfsplus/super.c                    |   2 +-
 fs/hostfs/hostfs_kern.c               |   2 +-
 fs/hpfs/dir.c                         |   2 +-
 fs/hpfs/inode.c                       |   2 +-
 fs/inode.c                            | 247 +++++++++++++++++++---------------
 fs/isofs/inode.c                      |   2 +-
 fs/jffs2/fs.c                         |   4 +-
 fs/jfs/file.c                         |   4 +-
 fs/jfs/inode.c                        |   2 +-
 fs/jfs/jfs_txnmgr.c                   |   2 +-
 fs/kernfs/inode.c                     |   2 +-
 fs/libfs.c                            |   6 +-
 fs/minix/inode.c                      |   2 +-
 fs/namei.c                            |   8 +-
 fs/netfs/misc.c                       |   8 +-
 fs/netfs/read_single.c                |   6 +-
 fs/nfs/inode.c                        |   2 +-
 fs/nfs/pnfs.c                         |   2 +-
 fs/nfsd/vfs.c                         |   2 +-
 fs/nilfs2/cpfile.c                    |   2 +-
 fs/nilfs2/dat.c                       |   2 +-
 fs/nilfs2/ifile.c                     |   2 +-
 fs/nilfs2/inode.c                     |  10 +-
 fs/nilfs2/sufile.c                    |   2 +-
 fs/notify/fsnotify.c                  |   2 +-
 fs/ntfs3/inode.c                      |   2 +-
 fs/ocfs2/dlmglue.c                    |   2 +-
 fs/ocfs2/inode.c                      |  27 +---
 fs/ocfs2/inode.h                      |   1 -
 fs/ocfs2/ocfs2_trace.h                |   2 -
 fs/ocfs2/super.c                      |   2 +-
 fs/omfs/inode.c                       |   2 +-
 fs/openpromfs/inode.c                 |   2 +-
 fs/orangefs/inode.c                   |   2 +-
 fs/orangefs/orangefs-utils.c          |   6 +-
 fs/overlayfs/dir.c                    |   2 +-
 fs/overlayfs/inode.c                  |   6 +-
 fs/overlayfs/util.c                   |  10 +-
 fs/pipe.c                             |   2 +-
 fs/qnx4/inode.c                       |   2 +-
 fs/qnx6/inode.c                       |   2 +-
 fs/quota/dquot.c                      |   2 +-
 fs/romfs/super.c                      |   2 +-
 fs/smb/client/cifsfs.c                |   2 +-
 fs/smb/client/inode.c                 |  14 +-
 fs/squashfs/inode.c                   |   2 +-
 fs/sync.c                             |   2 +-
 fs/ubifs/file.c                       |   2 +-
 fs/ubifs/super.c                      |   2 +-
 fs/udf/inode.c                        |   2 +-
 fs/ufs/inode.c                        |   2 +-
 fs/xfs/scrub/common.c                 |   2 +-
 fs/xfs/scrub/inode_repair.c           |   2 +-
 fs/xfs/scrub/parent.c                 |   2 +-
 fs/xfs/xfs_bmap_util.c                |   2 +-
 fs/xfs/xfs_health.c                   |   4 +-
 fs/xfs/xfs_icache.c                   |   6 +-
 fs/xfs/xfs_inode.c                    |   6 +-
 fs/xfs/xfs_inode_item.c               |   4 +-
 fs/xfs/xfs_iops.c                     |   2 +-
 fs/xfs/xfs_reflink.h                  |   2 +-
 fs/zonefs/super.c                     |   4 +-
 include/linux/backing-dev.h           |   5 +-
 include/linux/fs.h                    |  99 ++++++++++++--
 include/linux/writeback.h             |   9 +-
 include/trace/events/writeback.h      |   8 +-
 mm/backing-dev.c                      |   2 +-
 mm/filemap.c                          |   4 +-
 mm/truncate.c                         |   6 +-
 mm/vmscan.c                           |   2 +-
 mm/workingset.c                       |   2 +-
 security/landlock/fs.c                |   2 +-
 115 files changed, 514 insertions(+), 414 deletions(-)

