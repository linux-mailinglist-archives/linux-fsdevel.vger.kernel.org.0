Return-Path: <linux-fsdevel+bounces-7181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8783B822D99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D825EB21E61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732CF19464;
	Wed,  3 Jan 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYgpstkR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D819442;
	Wed,  3 Jan 2024 12:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91619C433C7;
	Wed,  3 Jan 2024 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286528;
	bh=SpzdVkvU80u/Zx2kHKteHWnu5YYrYN4EsSSqYxA33HA=;
	h=From:Subject:Date:To:Cc:From;
	b=QYgpstkRJhm6koyb/plpwB9iKPWWaV/SWoiDVA9UV9CbLNdEGuj/GuzW6WRUnyXsG
	 9ZFm0FjuRazwzD4+jc5M1jVtYG2t9dlH/NTuC9IOKfMVpZfChPanpLsnHfgnZMiy88
	 yxJcW2nVW6u3ysxfdDNefMQCWTbR3HYJ4ZrT/YVRuuQp0FbDQargygArzVHSc1Qi7G
	 fh6boicF8VN8Z90uuQXKEJYYnzmBc1nrrwd9Aj4s2/Eq8wXAQksQRDq8MAwu/D74yB
	 NB7UeLWgJvBLWFjQryiDqZ52w5mO4t33e4aKMdkg87W3pC/vn+XZ/sobL6nadc0wFq
	 Cqbr22aC1dzkQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 00/34] Open block devices as files & a bd_inode
 proposal
Date: Wed, 03 Jan 2024 13:54:58 +0100
Message-Id: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNZlWUC/x3MQQrCMBCF4auUWTuSpELFreABuhUXk2ZiB0KUD
 ASh9O6OLv8H79tAuQkrXIYNGndReVULfxhgWak+GSVZQ3Dh5LwbsWfFmLhjlsLogzsnmsY0MYF
 93o2zfP7eHebbFR42RlLG2Kgu648y4UilwL5/AUqqPY5+AAAA
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=10217; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SpzdVkvU80u/Zx2kHKteHWnu5YYrYN4EsSSqYxA33HA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbT2T7k5vUpmbaybdukJebOfkj4f1T8dMb/57eXX2
 ffl+u9f7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI/iyG/2GX73jqHvU+9GVP
 i4LN/bNNilfXlob23uYxEM18If3SYSkjw6+O7ZLP7DeKFB8Pn3EwMUtapWjJvKK6ZI6ouac3HvG
 5ygkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey Christoph,
Hey Jan,
Hey Jens,

I've been toying with this idea in between changing diapers essentially
and I've taken it far enough that I'd like some general input before
going further and massaging out any corner cases I might've missed.

I wanted to see whether we can make struct bdev_handle completely
private to the block layer in the next cycle and unexport low-level
helpers such as bdev_release() - formerly blkdev_put() - completely.

And afaict, we can actually get that to work. Simply put instead of
doing this bdev_open_by_*() dance where we return a struct block_device
we can just make bdev_file_open_by_*() return a struct file. Opening and
closing a block device from setup_bdev_super() and in all other places
just becomes equivalent to opening and closing a file.

This has held up in xfstests and in blktests so far and it seems stable
and clean. The equivalence of opening and closing block devices to
regular files is a win in and of itself imho. Added to that is the
ability to hide away all of the the details of struct bdev_handle and
various other low-level helpers.

So for that reason alone I think we should do it. All places were we
currently stash a bdev_handle we just stash a file and use accessors
such as F_BDEV() akin to I_BDEV() to get to the block device.

While I was doing that I realized that this is also a way for us to get
rid of bd_inode in fs/buffer.c though I don't think that's a requirement
for this change to be worth it.

Basically we simply record a struct file for the block device in struct
buffer_head and in struct iomap. That works without a problem afaict.
All filesystems will have a struct file handle to the block device so we
can trivially get access to it in nearly all places. The only exception
is for the block/fops.c layer itself where we obviously don't have a
struct file for the inode. So if we can solve that problem we can kill
bd_inode access and simply rely on file->f_mapping->host there as well.
IOW, just export and use bdev_file_inode() everywhere in fs/buffer.c

I only roughly drafted that bd_inode removal in fs/buffer.c. I think
this would work but I'd like to hear your thoughts on this. But again, I
don't think that's a requirement for that change to be worth it.

The patch series is barebones with really tiny commit messages because
I'd like to get early input. The core patches are:

bdev: open block device as files

In that patch the order between allocating a file and opening a bdev
handle are still reversed that's all fully cleaned up after all users of
bdev_handle are ported to rely on files. So the final form is:

bdev: rework bdev_open_by_dev()

and I think that looks fairly nice.

I've added a few additional illustrational patches for future work on
top:

* port ext4 to only rely on sb->s_f_bdev instead of sb->s_bdev
* port ext4 to never touch bdev->bd_inode and just rely on bdev_file_inode()
* remove bdev->bd_inode access from fs/buffer.c and just rely on bdev_file_inode()

I haven't though about potential corner cases yet too much but the file
stuff should actually be doable.

Thanks!
Christian

---
Christian Brauner (34):
      bdev: open block device as files
      block/ioctl: port blkdev_bszset() to file
      block/genhd: port disk_scan_partitions() to file
      md: port block device access to file
      swap: port block device usage to file
      power: port block device access to file
      xfs: port block device access to files
      drbd: port block device access to file
      pktcdvd: port block device access to file
      rnbd: port block device access to file
      xen: port block device access to file
      zram: port block device access to file
      bcache: port block device access to files
      block2mtd: port device access to files
      nvme: port block device access to file
      s390: port block device access to file
      target: port block device access to file
      bcachefs: port block device access to file
      btrfs: port device access to file
      erofs: port device access to file
      ext4: port block device access to file
      f2fs: port block device access to files
      jfs: port block device access to file
      nfs: port block device access to files
      ocfs2: port block device access to file
      reiserfs: port block device access to file
      bdev: remove bdev_open_by_path()
      bdev: make bdev_release() private to block layer
      bdev: make struct bdev_handle private to the block layer
      bdev: rework bdev_open_by_dev()
      ext4: rely on sb->f_bdev only
      block: expose bdev_file_inode()
      ext4: use bdev_file_inode()
      [DRAFT] buffer: port block device access to files and get rid of bd_inode access

 block/bdev.c                        | 220 +++++++++++++++++++++++-------------
 block/blk.h                         |  10 ++
 block/fops.c                        |  40 +++----
 block/genhd.c                       |  12 +-
 block/ioctl.c                       |   9 +-
 drivers/block/drbd/drbd_int.h       |   4 +-
 drivers/block/drbd/drbd_nl.c        |  58 +++++-----
 drivers/block/pktcdvd.c             |  68 +++++------
 drivers/block/rnbd/rnbd-srv.c       |  26 ++---
 drivers/block/rnbd/rnbd-srv.h       |   2 +-
 drivers/block/xen-blkback/blkback.c |   4 +-
 drivers/block/xen-blkback/common.h  |   4 +-
 drivers/block/xen-blkback/xenbus.c  |  36 +++---
 drivers/block/zram/zram_drv.c       |  26 ++---
 drivers/block/zram/zram_drv.h       |   2 +-
 drivers/md/bcache/bcache.h          |   4 +-
 drivers/md/bcache/super.c           |  74 ++++++------
 drivers/md/dm.c                     |  23 ++--
 drivers/md/md-bitmap.c              |   1 +
 drivers/md/md.c                     |  12 +-
 drivers/md/md.h                     |   2 +-
 drivers/mtd/devices/block2mtd.c     |  42 +++----
 drivers/nvme/target/io-cmd-bdev.c   |  16 +--
 drivers/nvme/target/nvmet.h         |   2 +-
 drivers/s390/block/dasd.c           |  10 +-
 drivers/s390/block/dasd_genhd.c     |  36 +++---
 drivers/s390/block/dasd_int.h       |   2 +-
 drivers/s390/block/dasd_ioctl.c     |   2 +-
 drivers/target/target_core_iblock.c |  18 +--
 drivers/target/target_core_iblock.h |   2 +-
 drivers/target/target_core_pscsi.c  |  22 ++--
 drivers/target/target_core_pscsi.h  |   2 +-
 fs/affs/file.c                      |   1 +
 fs/bcachefs/super-io.c              |  20 ++--
 fs/bcachefs/super_types.h           |   2 +-
 fs/btrfs/dev-replace.c              |  14 +--
 fs/btrfs/inode.c                    |   1 +
 fs/btrfs/ioctl.c                    |  16 +--
 fs/btrfs/volumes.c                  |  92 +++++++--------
 fs/btrfs/volumes.h                  |   4 +-
 fs/buffer.c                         |  69 +++++------
 fs/cramfs/inode.c                   |   2 +-
 fs/direct-io.c                      |   2 +-
 fs/erofs/data.c                     |  13 ++-
 fs/erofs/internal.h                 |   3 +-
 fs/erofs/super.c                    |  16 +--
 fs/erofs/zmap.c                     |   1 +
 fs/ext2/inode.c                     |   8 +-
 fs/ext4/dir.c                       |   2 +-
 fs/ext4/ext4.h                      |   2 +-
 fs/ext4/ext4_jbd2.c                 |   2 +-
 fs/ext4/fast_commit.c               |   2 +-
 fs/ext4/fsmap.c                     |   8 +-
 fs/ext4/inode.c                     |   6 +-
 fs/ext4/super.c                     |  88 +++++++--------
 fs/f2fs/data.c                      |   6 +-
 fs/f2fs/f2fs.h                      |   3 +-
 fs/f2fs/super.c                     |  12 +-
 fs/fuse/dax.c                       |   1 +
 fs/gfs2/aops.c                      |   1 +
 fs/gfs2/bmap.c                      |   1 +
 fs/hpfs/file.c                      |   1 +
 fs/jbd2/commit.c                    |   1 +
 fs/jbd2/journal.c                   |  26 +++--
 fs/jbd2/recovery.c                  |   6 +-
 fs/jbd2/revoke.c                    |  10 +-
 fs/jbd2/transaction.c               |   1 +
 fs/jfs/jfs_logmgr.c                 |  26 ++---
 fs/jfs/jfs_logmgr.h                 |   2 +-
 fs/jfs/jfs_mount.c                  |   2 +-
 fs/mpage.c                          |   5 +-
 fs/nfs/blocklayout/blocklayout.h    |   2 +-
 fs/nfs/blocklayout/dev.c            |  68 +++++------
 fs/nilfs2/btnode.c                  |   2 +
 fs/nilfs2/gcinode.c                 |   1 +
 fs/nilfs2/mdt.c                     |   1 +
 fs/nilfs2/page.c                    |   2 +
 fs/nilfs2/recovery.c                |  20 ++--
 fs/nilfs2/the_nilfs.c               |   1 +
 fs/ntfs/aops.c                      |   3 +
 fs/ntfs/file.c                      |   1 +
 fs/ntfs/mft.c                       |   2 +
 fs/ntfs3/fsntfs.c                   |   8 +-
 fs/ntfs3/inode.c                    |   1 +
 fs/ntfs3/super.c                    |   2 +-
 fs/ocfs2/cluster/heartbeat.c        |  32 +++---
 fs/ocfs2/journal.c                  |   2 +-
 fs/reiserfs/journal.c               |  44 ++++----
 fs/reiserfs/procfs.c                |   2 +-
 fs/reiserfs/reiserfs.h              |   8 +-
 fs/reiserfs/tail_conversion.c       |   1 +
 fs/romfs/super.c                    |   2 +-
 fs/super.c                          |  18 +--
 fs/xfs/xfs_buf.c                    |  10 +-
 fs/xfs/xfs_buf.h                    |   4 +-
 fs/xfs/xfs_iomap.c                  |   7 +-
 fs/xfs/xfs_super.c                  |  43 ++++---
 fs/zonefs/file.c                    |   2 +
 include/linux/blkdev.h              |  18 +--
 include/linux/buffer_head.h         |  45 ++++----
 include/linux/device-mapper.h       |   2 +-
 include/linux/fs.h                  |   4 +-
 include/linux/iomap.h               |   1 +
 include/linux/jbd2.h                |   6 +-
 include/linux/pktcdvd.h             |   4 +-
 include/linux/swap.h                |   2 +-
 kernel/power/swap.c                 |  28 ++---
 mm/swapfile.c                       |  22 ++--
 108 files changed, 908 insertions(+), 782 deletions(-)
---
base-commit: aee755dd02191d5669860f38e28ec93d8f0a4e70
change-id: 20240103-vfs-bdev-file-1208da73d7ea


