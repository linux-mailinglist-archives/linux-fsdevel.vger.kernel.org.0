Return-Path: <linux-fsdevel+bounces-1479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6EF7DA778
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 16:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3F81F21A88
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B793E156F3;
	Sat, 28 Oct 2023 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+SjXAze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE1258C
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17250C433C7;
	Sat, 28 Oct 2023 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698501808;
	bh=chp9cnawE8n3VM2tnnUZVWljPzU2PLJxWi7KUhc5OGw=;
	h=From:To:Cc:Subject:Date:From;
	b=G+SjXAzeqDCyldtJtg5IeQFIKzRe6bRA+ZVNh6M/qzRShP7qA3nEyWY1LUWq9Uebr
	 crFSaR9K4Ct2+5BtDURHgfTXHFNg8SYik82vfwi/CeKtXkhJJ62QZ2kAcVl3c5+AZH
	 bSY6LLb7vZGvdHndIJ+AKFFX3zCsHhwfgbF+wSpblOQyvL+vPTQJ9thITbDQK7uP9P
	 TV3yhiVpfXnAANXN7PcwpOteVXT5rJfebgg7QJaZgLfBpDcJExld1COahsmhcmlPfH
	 ju2lRVOwEXumdEHC5R8Ny73mT7wNlwGBwoAFyOwvln8yyLotcRUTlpTW/U0S4Jq+mI
	 07qU1pIluNolQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.7] vfs super updates
Date: Sat, 28 Oct 2023 16:02:33 +0200
Message-Id: <20231027-vfs-super-aa4b9ecfd803@brauner>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10167; i=brauner@kernel.org; h=from:subject:message-id; bh=chp9cnawE8n3VM2tnnUZVWljPzU2PLJxWi7KUhc5OGw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTaihivu/eodNJ/ps6OeSHzWG7HBD9SmHm4h9dsknu07D6/ lv+zOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS+5SRYdeJl5KhjNtcJlwx/uwtxn h0btf2jISqZZoeb/IWOK15WsLwv2Btc+3HS0UF3RLtYanr5mkX/nNX17q5e41DRU67WK0EPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

The vfs.super tree originally contained a good chunk of the btrfs tree
as a merge - as mentioned elsewhere - since we had intended to depend on
work that Christoph did a few months ago. We had allowed btrfs to carry
the patches themselves.

But it since became clear that btrfs/for-next likely does not contain
any of the patches there's zero reason for the original merge. So the
merge is dropped. It's not great because it's a late change but it's
better than bringing in a completely pointless merge.

I have zero appetite for repeating that unreliable experience again next
cycle and plan to just carry such conversion changes completely in
vfs.git going forward.

/* Summary */
This contains the work to make block device opening functions return a
struct bdev_handle instead of just a struct block_device. The same
struct bdev_handle is then also passed to block device closing
functions.

This allows us to propagate context from opening to closing a block
device without having to modify all users everytime.

Sidenote, in the future we might even want to try and have block device
opening functions return a struct file directly but that's a series on
top of this.

These are further preparatory changes to be able to count writable opens
and blocking writes to mounted block devices. That's a separate piece of
work for next cycle and for that we absolutely need the changes to btrfs
that have been quietly dropped somehow.

Originally the series contained a patch that removed the old blkdev_*()
helpers. But since this would've caused needles churn in -next for
bcachefs we ended up delaying it.

The second piece of work addresses one of the major annoyances about the
work last cycle, namely that we required dropping s_umount whenever we
used the superblock and fs_holder_ops for a block device.

The reason for that requirement had been that in some codepaths s_umount
could've been taken under disk->open_mutex (that's always been the case,
at least theoretically). For example, on surprise block device removal
or media change. And opening and closing block devices required grabbing
disk->open_mutex as well.

So we did the work and went through the block layer and fixed all those
places so that s_umount is never taken under disk->open_mutex. This
means no more brittle games where we yield and reacquire s_umount during
block device opening and closing and no more requirements where block
devices need to be closed. Filesystems don't need to care about this.

There's a bunch of other follow-up work such as moving block device
freezing and thawing to holder operations which makes it work for all
block devices and not just the main block device just as we did for
surprise removal. But that is for next cycle.

Tested with fstests for all major fses, blktests, LTP.

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.6-rc7 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

## Merge Conflicts with other trees

The following trees will have a merge conflict with this tree:

[1] linux-next: manual merge of the vfs-brauner tree with the mm tree
    https://lore.kernel.org/r/20230928102504.5c751249@canb.auug.org.au

[2] There used to be a merge conflicts with vfs-6.7.ctime tree. But that
    merge conflict only happened because of the btrfs merge we carried.
    So vfs-6.7.ctime now has a merge conflict with btrfs, not with
    vfs-6.7.super.

The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.super

for you to fetch changes up to 5aa9130acb98bacacc8bd9f1489a9269430d0eb8:

  porting: update locking requirements (2023-10-28 13:29:23 +0200)

Please consider pulling these changes from the signed vfs-6.7.super tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7.super

----------------------------------------------------------------
Christian Brauner (5):
      block: simplify bdev_del_partition()
      block: WARN_ON_ONCE() when we remove active partitions
      block: assert that we're not holding open_mutex over blk_report_disk_dead
      fs: assert that open_mutex isn't held over holder ops
      porting: update locking requirements

Christoph Hellwig (1):
      block: move bdev_mark_dead out of disk_check_media_change

Jan Kara (30):
      block: Provide bdev_open_* functions
      block: Use bdev_open_by_dev() in blkdev_open()
      block: Use bdev_open_by_dev() in disk_scan_partitions() and blkdev_bszset()
      drdb: Convert to use bdev_open_by_path()
      pktcdvd: Convert to bdev_open_by_dev()
      rnbd-srv: Convert to use bdev_open_by_path()
      xen/blkback: Convert to bdev_open_by_dev()
      zram: Convert to use bdev_open_by_dev()
      bcache: Convert to bdev_open_by_path()
      dm: Convert to bdev_open_by_dev()
      md: Convert to bdev_open_by_dev()
      mtd: block2mtd: Convert to bdev_open_by_dev/path()
      nvmet: Convert to bdev_open_by_path()
      s390/dasd: Convert to bdev_open_by_path()
      scsi: target: Convert to bdev_open_by_path()
      PM: hibernate: Convert to bdev_open_by_dev()
      PM: hibernate: Drop unused snapshot_test argument
      mm/swap: Convert to use bdev_open_by_dev()
      fs: Convert to bdev_open_by_dev()
      btrfs: Convert to bdev_open_by_path()
      erofs: Convert to use bdev_open_by_path()
      ext4: Convert to bdev_open_by_dev()
      f2fs: Convert to bdev_open_by_dev/path()
      jfs: Convert to bdev_open_by_dev()
      nfs/blocklayout: Convert to use bdev_open_by_dev/path()
      ocfs2: Convert to use bdev_open_by_dev()
      reiserfs: Convert to bdev_open_by_dev/path()
      xfs: Convert to bdev_open_by_path()
      bcache: Fixup error handling in register_cache()
      fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock

Lizhi Xu (1):
      jfs: fix log->bdev_handle null ptr deref in lbmStartIO

 Documentation/filesystems/porting.rst |   7 +++
 block/bdev.c                          |  65 ++++++++++++++++++---
 block/disk-events.c                   |  18 +++---
 block/fops.c                          |  44 +++++++++-----
 block/genhd.c                         |  19 ++++--
 block/ioctl.c                         |  11 ++--
 block/partitions/core.c               |  43 +++++++++-----
 drivers/block/ataflop.c               |   4 +-
 drivers/block/drbd/drbd_int.h         |   2 +
 drivers/block/drbd/drbd_nl.c          |  65 ++++++++++-----------
 drivers/block/floppy.c                |   4 +-
 drivers/block/pktcdvd.c               |  76 +++++++++++++-----------
 drivers/block/rnbd/rnbd-srv.c         |  27 ++++-----
 drivers/block/rnbd/rnbd-srv.h         |   2 +-
 drivers/block/xen-blkback/blkback.c   |   4 +-
 drivers/block/xen-blkback/common.h    |   4 +-
 drivers/block/xen-blkback/xenbus.c    |  40 +++++++------
 drivers/block/zram/zram_drv.c         |  31 +++++-----
 drivers/block/zram/zram_drv.h         |   2 +-
 drivers/md/bcache/bcache.h            |   2 +
 drivers/md/bcache/super.c             |  95 +++++++++++++++---------------
 drivers/md/dm.c                       |  20 ++++---
 drivers/md/md.c                       |  23 +++-----
 drivers/md/md.h                       |   4 +-
 drivers/mtd/devices/block2mtd.c       |  51 +++++++++-------
 drivers/nvme/target/io-cmd-bdev.c     |  20 ++++---
 drivers/nvme/target/nvmet.h           |   1 +
 drivers/s390/block/dasd.c             |  12 ++--
 drivers/s390/block/dasd_genhd.c       |  45 +++++++-------
 drivers/s390/block/dasd_int.h         |   2 +-
 drivers/s390/block/dasd_ioctl.c       |   2 +-
 drivers/target/target_core_iblock.c   |  19 +++---
 drivers/target/target_core_iblock.h   |   1 +
 drivers/target/target_core_pscsi.c    |  26 ++++-----
 drivers/target/target_core_pscsi.h    |   2 +-
 fs/btrfs/dev-replace.c                |  14 +++--
 fs/btrfs/ioctl.c                      |  18 +++---
 fs/btrfs/volumes.c                    | 107 +++++++++++++++++-----------------
 fs/btrfs/volumes.h                    |   6 +-
 fs/cramfs/inode.c                     |   2 +-
 fs/erofs/data.c                       |   4 +-
 fs/erofs/internal.h                   |   2 +-
 fs/erofs/super.c                      |  20 +++----
 fs/ext4/ext4.h                        |   2 +-
 fs/ext4/fsmap.c                       |   9 +--
 fs/ext4/super.c                       |  52 +++++++++--------
 fs/f2fs/f2fs.h                        |   1 +
 fs/f2fs/super.c                       |  13 +++--
 fs/jfs/jfs_logmgr.c                   |  33 ++++++-----
 fs/jfs/jfs_logmgr.h                   |   2 +-
 fs/jfs/jfs_mount.c                    |   3 +-
 fs/nfs/blocklayout/blocklayout.h      |   2 +-
 fs/nfs/blocklayout/dev.c              |  76 ++++++++++++------------
 fs/ocfs2/cluster/heartbeat.c          |  81 +++++++++++++------------
 fs/reiserfs/journal.c                 |  56 ++++++++----------
 fs/reiserfs/procfs.c                  |   2 +-
 fs/reiserfs/reiserfs.h                |  11 ++--
 fs/romfs/super.c                      |   2 +-
 fs/super.c                            |  66 +++++++++++++--------
 fs/xfs/xfs_buf.c                      |  22 ++++---
 fs/xfs/xfs_buf.h                      |   3 +-
 fs/xfs/xfs_super.c                    |  42 +++++++------
 include/linux/blkdev.h                |  11 ++++
 include/linux/device-mapper.h         |   1 +
 include/linux/fs.h                    |   1 +
 include/linux/pktcdvd.h               |   4 +-
 include/linux/swap.h                  |   1 +
 kernel/power/hibernate.c              |  14 ++---
 kernel/power/power.h                  |   2 +-
 kernel/power/swap.c                   |  37 ++++++------
 mm/swapfile.c                         |  23 ++++----
 71 files changed, 854 insertions(+), 684 deletions(-)

