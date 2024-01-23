Return-Path: <linux-fsdevel+bounces-8545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B305838FE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBD228F52E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E435FDC3;
	Tue, 23 Jan 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCytiZZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610815F573;
	Tue, 23 Jan 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016420; cv=none; b=pHYuJ4DESmlvFygL9b9yY4uMhDsQuz2HhIaAa6Kk6nRnrzEX58BjIuj7WRCwBvNQugJaWAMtwgfI8479apX3p4L2QBeb6QCTIkdfGWbyWRbXFG6mi5yBzO1O9mGdqDgTK87bOSOw3HRAN3VwcWr3tbmt9w2xiY2l9b5DWD+fMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016420; c=relaxed/simple;
	bh=4/kjG6vijMn6THswf3eZrsDhiUNAIS3UtHzO4JQVLzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LNxgOpoODZmaWCow6M0GDyzIPPHs3xcuV4ci0+PpKeeJp1hJEuNkK2IhxxpYUhly10WIJ8a9FHmlW9pp84MCF8QbyffmYUAGOwnKOzu4BFsLuvyrZG1dpBZPwynVVpa8IvNmRv3fwRYnUoV/eqXP0DpR/dPJxrTbkphb2aJg86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCytiZZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D86C43394;
	Tue, 23 Jan 2024 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016420;
	bh=4/kjG6vijMn6THswf3eZrsDhiUNAIS3UtHzO4JQVLzE=;
	h=From:Subject:Date:To:Cc:From;
	b=GCytiZZJNbbvamnzzFkKQPsLhV5adbSftbSiv87PSihN/bmSOjW4J5ftPk9HVsWNK
	 7v6ruZxD65LhRkwT1cOKjofgYw72tsjfv04IqPsVrbLP8h9LVRHzEnlq1pqs1tnz5p
	 ULSJ59z3LiWErDwM534sMJ/jRzdkT+8p7RlybCASj/5/n0z+mrJtA1Rwl64lWmbY9R
	 iQcPspjoaEwBi2KLoJuegymQO4dy6kDBSaYLAwFTWXAzR27kUcv4tfh2EkAg2WnTQp
	 yS+DS7RvmIdz3vxZkgfqBGZweD/6kNyJ5BylPZbhMzv5ZWTZbpL5Z6V33I/IUVbDHf
	 IqcNQRtcTpszg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/34] Open block devices as files
Date: Tue, 23 Jan 2024 14:26:17 +0100
Message-Id: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHm+r2UC/3WNyw6DIBBFf8XMumMA6yNd9T8aFyCDkhJshoa0M
 f570X2XJ7nnng0SsacEt2oDpuyTX2MBdalgWnScCb0tDEqoq5CiwewSGksZnQ+EUonB6r6xPWk
 ozovJ+c/59xgLG50IDes4LcdLkWsdwrFcfHqv/D3DWR77f40sUWA3DURt60xH7v4kjhTqlWcY9
 33/AWbj+TXFAAAA
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=7055; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4/kjG6vijMn6THswf3eZrsDhiUNAIS3UtHzO4JQVLzE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zcv/aJGnorHzvDMvSefb5VprXqgfPz3d8nnLRZzT
 0SvFJpj01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRlG8M/wvjzz7V6FK/EX7C
 YYJdsnZh5WTZXvvv0W6TuBSjsm6cWcTI8OL76zC+/nb1jFvn26NYHI359UMFGaf/a2O/V/eC/8I
 mZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey Christoph,
Hey Jan,
Hey Jens,

This opens block devices as files. Instead of introducing a separate
indirection into bdev_open_by_*() vis struct bdev_handle we can just
make bdev_file_open_by_*() return a struct file. Opening and closing a
block device from setup_bdev_super() and in all other places just
becomes equivalent to opening and closing a file.

This has held up in xfstests and in blktests so far and it seems stable
and clean. The equivalence of opening and closing block devices to
regular files is a win in and of itself imho. Added to that is the
ability to do away with struct bdev_handle completely and make various
low-level helpers private to the block layer.

All places were we currently stash a struct bdev_handle we just stash a
file and use an accessor such as file_bdev() akin to I_BDEV() to get to
the block device.

It's now also possible to use file->f_mapping as a replacement for
bdev->bd_inode->i_mapping and file->f_inode or file->f_mapping->host as
an alternative to bdev->bd_inode allowing us to significantly reduce or
even fully remove bdev->bd_inode in follow-up patches.

In addition, we could get rid of sb->s_bdev and various other places
that stash the block device directly and instead stash the block device
file. Again, this is follow-up work.

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- This is not an RFC anymore.
- The patches to convert all of fs/buffer.c and associated helpers to
  struct file have been split out of the core infrastructure.
- Various renaming of helpers in response to v1.
- Link to v1: https://lore.kernel.org/r/20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org

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
      bdev: remove bdev pointer from struct bdev_handle
      block: use file->f_op to indicate restricted writes
      block: remove bdev_handle completely
      block: expose bdev_file_inode()
      ext4: rely on sb->f_bdev only

 block/bdev.c                        | 249 ++++++++++++++++++++++--------------
 block/blk.h                         |   6 +
 block/fops.c                        |  48 ++++---
 block/genhd.c                       |  12 +-
 block/ioctl.c                       |   9 +-
 drivers/block/drbd/drbd_int.h       |   4 +-
 drivers/block/drbd/drbd_nl.c        |  58 ++++-----
 drivers/block/pktcdvd.c             |  68 +++++-----
 drivers/block/rnbd/rnbd-srv.c       |  28 ++--
 drivers/block/rnbd/rnbd-srv.h       |   2 +-
 drivers/block/xen-blkback/blkback.c |   4 +-
 drivers/block/xen-blkback/common.h  |   4 +-
 drivers/block/xen-blkback/xenbus.c  |  37 +++---
 drivers/block/zram/zram_drv.c       |  26 ++--
 drivers/block/zram/zram_drv.h       |   2 +-
 drivers/md/bcache/bcache.h          |   4 +-
 drivers/md/bcache/super.c           |  74 +++++------
 drivers/md/dm.c                     |  23 ++--
 drivers/md/md.c                     |  12 +-
 drivers/md/md.h                     |   2 +-
 drivers/mtd/devices/block2mtd.c     |  46 +++----
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
 fs/bcachefs/super-io.c              |  20 +--
 fs/bcachefs/super_types.h           |   2 +-
 fs/btrfs/dev-replace.c              |  14 +-
 fs/btrfs/ioctl.c                    |  16 +--
 fs/btrfs/volumes.c                  |  92 ++++++-------
 fs/btrfs/volumes.h                  |   4 +-
 fs/cramfs/inode.c                   |   2 +-
 fs/erofs/data.c                     |   6 +-
 fs/erofs/internal.h                 |   2 +-
 fs/erofs/super.c                    |  16 +--
 fs/ext4/dir.c                       |   2 +-
 fs/ext4/ext4.h                      |   2 +-
 fs/ext4/ext4_jbd2.c                 |   2 +-
 fs/ext4/fast_commit.c               |   2 +-
 fs/ext4/fsmap.c                     |   8 +-
 fs/ext4/super.c                     |  87 ++++++-------
 fs/f2fs/f2fs.h                      |   2 +-
 fs/f2fs/super.c                     |  12 +-
 fs/file_table.c                     |  36 +++++-
 fs/jfs/jfs_logmgr.c                 |  26 ++--
 fs/jfs/jfs_logmgr.h                 |   2 +-
 fs/jfs/jfs_mount.c                  |   2 +-
 fs/nfs/blocklayout/blocklayout.h    |   2 +-
 fs/nfs/blocklayout/dev.c            |  68 +++++-----
 fs/ocfs2/cluster/heartbeat.c        |  32 ++---
 fs/reiserfs/journal.c               |  38 +++---
 fs/reiserfs/procfs.c                |   2 +-
 fs/reiserfs/reiserfs.h              |   8 +-
 fs/romfs/super.c                    |   2 +-
 fs/super.c                          |  18 +--
 fs/xfs/xfs_buf.c                    |  10 +-
 fs/xfs/xfs_buf.h                    |   4 +-
 fs/xfs/xfs_super.c                  |  43 +++----
 include/linux/blkdev.h              |  18 +--
 include/linux/device-mapper.h       |   2 +-
 include/linux/file.h                |   2 +
 include/linux/fs.h                  |   4 +-
 include/linux/pktcdvd.h             |   4 +-
 include/linux/swap.h                |   2 +-
 kernel/power/swap.c                 |  28 ++--
 mm/swapfile.c                       |  22 ++--
 72 files changed, 791 insertions(+), 705 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240103-vfs-bdev-file-1208da73d7ea


