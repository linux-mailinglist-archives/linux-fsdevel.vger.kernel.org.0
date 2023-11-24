Return-Path: <linux-fsdevel+bounces-3665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4597F7161
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 11:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA5E1C209EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C3F1A5AC;
	Fri, 24 Nov 2023 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYvu8MeE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B181A584
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 10:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33F0C433C8;
	Fri, 24 Nov 2023 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700821678;
	bh=qVwJcFDiIpymt6eUkHVD8R3OpoVEzT8XHjqe8OUw3gY=;
	h=From:To:Cc:Subject:Date:From;
	b=sYvu8MeE8IkSjV0il7aiZosZ3Ymd/EG2GU0ZPtN5SOXpcSpNNccXSaX6RKlIjaO7U
	 jvzp0UG0cp3SOzwlvfN0gdnHpTOEgaS/DXk49f+e9ywvaHydsCwhclZcOkluy1fQDb
	 sD5ZtP0dSOQL1ukPvfGAkae4ZCkjpSLMFkEPNHNJ1RkEiDinqraTlWCapZ2moQGS68
	 XOib7SnGPn9thxaCkYqdZG84EVhknmbxJMXiDLZ/mP3b7wcfAYvYCG9BEUqDBPQlAX
	 mp+M5zXVjvfmJLkZmuY4OVi1DG18xNl76hTe9eqiprWEJ5HUcI9y9vuvjdDvNNoI5X
	 sfriUGYRWbqPA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri, 24 Nov 2023 11:27:28 +0100
Message-ID: <20231124-vfs-fixes-3420a81c0abe@brauner>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5043; i=brauner@kernel.org; h=from:subject:message-id; bh=qVwJcFDiIpymt6eUkHVD8R3OpoVEzT8XHjqe8OUw3gY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQmVE3I2WdSLlbuwSx69I7K3XS/i/s2F1zgC9+W4Pns1 D1WD0PljlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYzmdkOPZDQmJrhfnLmA83 ZVyW8B3lczkmpzB52Srt3C7eErHFlxn+GUg4V/3hj+N4rxjw7m6x1+TfW4vXlPKXnXz+dUbror0 TWAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the usual miscellaneous fixes:

* Avoid calling back into LSMs from vfs_getattr_nosec() calls.

  IMA used to query inode properties accessing raw inode fields without
  dedicated helpers. That was finally fixed a few releases ago by
  forcing IMA to use vfs_getattr_nosec() helpers.

  The goal of the vfs_getattr_nosec() helper is to query for attributes
  without calling into the LSM layer which would be quite problematic
  because incredibly IMA is called from __fput()...

  __fput()
    -> ima_file_free()

  What it does is to call back into the filesystem to update the file's
  IMA xattr. Querying the inode without using vfs_getattr_nosec() meant
  that IMA didn't handle stacking filesystems such as overlayfs
  correctly. So the switch to vfs_getattr_nosec() is quite correct. But
  the switch to vfs_getattr_nosec() revealed another bug when used on
  stacking filesystems:

  __fput()
    -> ima_file_free()
       -> vfs_getattr_nosec()
          -> i_op->getattr::ovl_getattr()
             -> vfs_getattr()
                -> i_op->getattr::$WHATEVER_UNDERLYING_FS_getattr()
                   -> security_inode_getattr() # calls back into LSMs

  Now, if that __fput() happens from task_work_run() of an exiting task
  current->fs and various other pointer could already be NULL. So
  anything in the LSM layer relying on that not being NULL would be
  quite surprised.

  Fix that by passing the information that this is a security request
  through to the stacking filesystem by adding a new internal
  ATT_GETATTR_NOSEC flag. Now the callchain becomes:

  __fput()
    -> ima_file_free()
       -> vfs_getattr_nosec()
          -> i_op->getattr::ovl_getattr()
             -> if (AT_GETATTR_NOSEC)
                       vfs_getattr_nosec()
                else
                       vfs_getattr()
                -> i_op->getattr::$WHATEVER_UNDERLYING_FS_getattr()

* Fix a bug introduced with the iov_iter rework from last cycle.

  This broke /proc/kcore by copying too much and without the correct
  offset.

* Add a missing NULL check when allocating the root inode in
  autofs_fill_super().

* Fix stable writes for multi-device filesystems (xfs, btrfs etc) and
  the block device pseudo filesystem.

  Stable writes used to be a superblock flag only, making it a per
  filesystem property. Add an additional AS_STABLE_WRITES mapping flag
  to allow for fine-grained control.

* Ensure that offset_iterate_dir() returns 0 after reaching the end of a
  directory so it adheres to getdents() convention.

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.7-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. Passes xfstests.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7-rc3.fixes

for you to fetch changes up to 796432efab1e372d404e7a71cc6891a53f105051:

  libfs: getdents() should return 0 after reaching EOD (2023-11-20 15:34:22 +0100)

Please consider pulling these changes from the signed vfs-6.7-rc3.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7-rc3.fixes

----------------------------------------------------------------
Christoph Hellwig (4):
      filemap: add a per-mapping stable writes flag
      block: update the stable_writes flag in bdev_add
      xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags
      xfs: respect the stable writes flag on the RT device

Chuck Lever (1):
      libfs: getdents() should return 0 after reaching EOD

Ian Kent (1):
      autofs: add: new_inode check in autofs_fill_super()

Omar Sandoval (1):
      iov_iter: fix copy_page_to_iter_nofault()

Stefan Berger (1):
      fs: Pass AT_GETATTR_NOSEC flag to getattr interface function

 block/bdev.c               |  2 ++
 fs/autofs/inode.c          | 56 +++++++++++++++++-----------------------------
 fs/ecryptfs/inode.c        | 12 ++++++++--
 fs/inode.c                 |  2 ++
 fs/libfs.c                 | 14 +++++++++---
 fs/overlayfs/inode.c       | 10 ++++-----
 fs/overlayfs/overlayfs.h   |  8 +++++++
 fs/stat.c                  |  6 ++++-
 fs/xfs/xfs_inode.h         |  8 +++++++
 fs/xfs/xfs_ioctl.c         | 30 ++++++++++++++++---------
 fs/xfs/xfs_iops.c          |  7 ++++++
 include/linux/pagemap.h    | 17 ++++++++++++++
 include/uapi/linux/fcntl.h |  3 +++
 lib/iov_iter.c             |  2 +-
 mm/page-writeback.c        |  2 +-
 15 files changed, 121 insertions(+), 58 deletions(-)

