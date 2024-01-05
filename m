Return-Path: <linux-fsdevel+bounces-7462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D2E825367
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 13:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708BC1F23D75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BCB2D609;
	Fri,  5 Jan 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px2zEA+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA44F2D047;
	Fri,  5 Jan 2024 12:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A95C433C7;
	Fri,  5 Jan 2024 12:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704458509;
	bh=u3IoHKqhZk9Ch274EqJvdQ1Aj2eqXJTBHOito1o2uss=;
	h=From:To:Cc:Subject:Date:From;
	b=Px2zEA+xkxIrJwF2KbpZInwLxwCYQ8Efj4s459NusfqAf9dH6A1xxIaR/Ip8BgEt2
	 fAA0qda0Y6larecc+4s5oAkGdeY/Cm9Tw9hzRLhYe1HevjQXd4N65jjD3P02Rk5X+7
	 aEvugM12Ag2Al6JyGsCwUY9bEcHqDDuffT6Yow9EvpDkgczC9rF2TGD6rc7vZBJCL2
	 BUT76nZ7I+3EI7p4YHXcCsaDSHZIWwzxVMmN07hwOg66QONiFiSoiPa7X8m5a227/+
	 m6WAilAVeBt+uzhwyvhuic26KOCZVjDxBTpZ+IGEmVSsQexiZIOaMUImgjROperrrn
	 gnzvGjQSvH6Fw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs super updates
Date: Fri,  5 Jan 2024 13:41:03 +0100
Message-ID: <20240105-vfs-super-4092d802972c@brauner>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6757; i=brauner@kernel.org; h=from:subject:message-id; bh=SYQRbVQy++VoeuP9iXJknGLdzmD5ZQdqwwELdAIWLy0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRO/3H/ffv5RMEgh4xloRdWGrR8fHJo69Vby2bPdC1fX J/9tOHwz45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJmP9mZHhW9GPis828Cgrz 67QYUr/2NrEK/5bMeZxespq5fdnpiACG/xlmOvtXd76aNC3s/2+bltoKrSB/VYbLe15sfjgxasq T6UwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the super work for this cycle including the long-awaited series
by Jan to make it possible to prevent writing to mounted block devices:

* Writing to mounted devices is dangerous and can lead to filesystem
  corruption as well as crashes. Furthermore syzbot comes with more and more
  involved examples how to corrupt block device under a mounted filesystem
  leading to kernel crashes and reports we can do nothing about. Add tracking
  of writers to each block device and a kernel cmdline argument which controls
  whether other writeable opens to block devices open with
  BLK_OPEN_RESTRICT_WRITES flag are allowed.

  Note that this effectively only prevents modification of the particular block
  device's page cache by other writers. The actual device content can still be
  modified by other means - e.g. by issuing direct scsi commands, by doing
  writes through devices lower in the storage stack (e.g. in case loop devices,
  DM, or MD are involved) etc. But blocking direct modifications of the block
  device page cache is enough to give filesystems a chance to perform data
  validation when loading data from the underlying storage and thus prevent
  kernel crashes.

  Syzbot can use this cmdline argument option to avoid uninteresting crashes.
  Also users whose userspace setup does not need writing to mounted block
  devices can set this option for hardening. We expect that this will be
  interesting to quite a few workloads.

  Btrfs is currently opted out of this because they still haven't merged
  patches we require for this to work from three kernel releases ago.

* Reimplement block device freezing and thawing as holder operations on the
  block device.

  This allows us to extend block device freezing to all devices associated with
  a superblock and not just the main device. It also allows us to remove
  get_active_super() and thus another function that scans the global list of
  superblocks.

  Freezing via additional block devices only works if the filesystem chooses to
  use @fs_holder_ops for these additional devices as well. That currently only
  includes ext4 and xfs.

  Earlier releases switched get_tree_bdev() and mount_bdev() to use
  @fs_holder_ops. The remaining nilfs2 open-coded version of mount_bdev() has
  been converted to rely on @fs_holder_ops as well. So block device freezing
  for the main block device will continue to work as before.

  There should be no regressions in functionality. The only special case is
  btrfs where block device freezing for the main block device never worked
  because sb->s_bdev isn't set. Block device freezing for btrfs can be fixed
  once they can switch to @fs_holder_ops but that can happen whenever they're
  ready.

* Various cleanups.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.7-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

[1] linux-next: manual merge of the vfs-brauner tree with Linus' tree
    https://lore.kernel.org/linux-next/20231204103510.0eb5ea5f@canb.auug.org.au

Merge conflicts with other trees
================================

[1] linux-next: manual merge of the vfs-brauner tree with the btrfs tree
    https://lore.kernel.org/linux-next/20231127092001.54a021e8@canb.auug.org.au

    The needed fix is presented in:

    https://lore.kernel.org/linux-next/20231128213344.GA3423530@dev-arch.thelio-3990X

[2] linux-next: manual merge of the vfs tree with the vfs-brauner tree
    https://lore.kernel.org/linux-next/20231220104110.56ae9b36@canb.auug.org.au

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.super

for you to fetch changes up to 8ff363ade395e72dc639810b6f59849c743c363e:

  block: Fix a memory leak in bdev_open_by_dev() (2023-12-28 11:48:17 +0100)

Please consider pulling these changes from the signed vfs-6.8.super tag.

Happy New Year!
Christian

----------------------------------------------------------------
vfs-6.8.super

----------------------------------------------------------------
Christian Brauner (17):
      fs: massage locking helpers
      bdev: rename freeze and thaw helpers
      bdev: surface the error from sync_blockdev()
      bdev: add freeze and thaw holder operations
      bdev: implement freeze and thaw holder operations
      fs: remove get_active_super()
      super: remove bd_fsfreeze_sb
      fs: remove unused helper
      porting: document block device freeze and thaw changes
      blkdev: comment fs_holder_ops
      fs: simplify setup_bdev_super() calls
      xfs: simplify device handling
      ext4: simplify device handling
      fs: remove dead check
      fs: handle freezing from multiple devices
      super: massage wait event mechanism
      super: don't bother with WARN_ON_ONCE()

Christoph Hellwig (1):
      fs: streamline thaw_super_locked

Christophe JAILLET (1):
      block: Fix a memory leak in bdev_open_by_dev()

Jan Kara (8):
      nilfs2: simplify device handling
      bcachefs: Convert to bdev_open_by_path()
      block: Remove blkdev_get_by_*() functions
      block: Add config option to not allow writing to mounted devices
      btrfs: Do not restrict writes to btrfs devices
      fs: Block writes to mounted block devices
      xfs: Block writes to log device
      ext4: Block writes to journal device

 Documentation/filesystems/porting.rst |  12 +
 block/Kconfig                         |  20 ++
 block/bdev.c                          | 258 ++++++++++--------
 drivers/md/dm.c                       |   4 +-
 fs/bcachefs/fs-ioctl.c                |   4 +-
 fs/bcachefs/super-io.c                |  19 +-
 fs/bcachefs/super_types.h             |   1 +
 fs/btrfs/super.c                      |   2 +
 fs/ext4/ioctl.c                       |   4 +-
 fs/ext4/super.c                       |   8 +-
 fs/f2fs/file.c                        |   4 +-
 fs/nilfs2/super.c                     |   8 -
 fs/super.c                            | 498 +++++++++++++++++++---------------
 fs/xfs/xfs_fsops.c                    |   4 +-
 fs/xfs/xfs_super.c                    |  24 +-
 include/linux/blk_types.h             |   8 +-
 include/linux/blkdev.h                |  29 +-
 include/linux/fs.h                    |  19 +-
 18 files changed, 531 insertions(+), 395 deletions(-)

