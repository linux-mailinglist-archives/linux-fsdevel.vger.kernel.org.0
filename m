Return-Path: <linux-fsdevel+bounces-12456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BDA85F8AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AEA280124
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC1132493;
	Thu, 22 Feb 2024 12:51:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A246435;
	Thu, 22 Feb 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606299; cv=none; b=rTDFJJCWwbvIRo6Ut+dIDxs1eW2mb2Fj19esQAz7uO9uaiy9okY8neMCAMJ8TMDPcTCSfbKXDmRSAb8zbsXWs+42lCMLXDY/CYjMeUxN2XgtgA+BxeUqLuXkHFla8YNWIuaOeFEltKTC3QlLvnUnmoO2vUX+P91OlkQWVrhzWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606299; c=relaxed/simple;
	bh=LsD8rMGBiu8TJWWPWXUQJE0mpNOrToPpnKAvJTdLyc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ndj3RRR6dzhGfSxihzmpXxaW+vbmy23UGel/07t/pxRHwdSw3x1FXYlsAZJmlqFKKHyPWYzkO8ZLulyW2zjDn6AOa38/hh2fwzTdQh5sKFaA8b0hHAhiNur1WVh6vfD9tJX2686lnawTWd/89fmYDZgO+xnNZaRVmbXfVPOM1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgY1C3Rtjz4f3jdY;
	Thu, 22 Feb 2024 20:51:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7F4CB1A0232;
	Thu, 22 Feb 2024 20:51:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFSQ9dlQ382Ew--.47909S4;
	Thu, 22 Feb 2024 20:51:32 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [RFC v4 linux-next 00/19] fs & block: remove bdev->bd_inode
Date: Thu, 22 Feb 2024 20:45:36 +0800
Message-Id: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFSQ9dlQ382Ew--.47909S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF48ur15ur4fuF13Ww1Utrb_yoWrKFW8pF
	s7GFySkr1YyrW3uFyfZa1xAa43K3Z7Way2vry7Zw15ZFy5JFyUZr4kKF45AFWDWrZ3Jw13
	Zr1UAw1DWr15urJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	XdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v4:
 - respin on the top of linux-next, based on Christian's patchset to
 open bdev as file. Most of patches from v3 is dropped and change to use
 file_inode(bdev_file) to get bd_inode or bdev_file->f_mapping to get
 bd_inode->i_mapping.

Changes in v3:
 - remove bdev_associated_mapping() and patch 12 from v1;
 - add kerneldoc comments for new bdev apis;
 - rename __bdev_get_folio() to bdev_get_folio;
 - fix a problem in erofs that erofs_init_metabuf() is not always
 called.
 - add reviewed-by tag for patch 15-17;

Changes in v2:
 - remove some bdev apis that is not necessary;
 - pass in offset for bdev_read_folio() and __bdev_get_folio();
 - remove bdev_gfp_constraint() and add a new helper in fs/buffer.c to
 prevent access bd_indoe() directly from mapping_gfp_constraint() in
 ext4.(patch 15, 16);
 - remove block_device_ejected() from ext4.

Yu Kuai (19):
  block: move two helpers into bdev.c
  block: remove sync_blockdev_nowait()
  block: remove sync_blockdev_range()
  block: prevent direct access of bd_inode
  bcachefs: remove dead function bdev_sectors()
  cramfs: prevent direct access of bd_inode
  erofs: prevent direct access of bd_inode
  nilfs2: prevent direct access of bd_inode
  gfs2: prevent direct access of bd_inode
  s390/dasd: use bdev api in dasd_format()
  btrfs: prevent direct access of bd_inode
  ext4: remove block_device_ejected()
  ext4: prevent direct access of bd_inode
  jbd2: prevent direct access of bd_inode
  bcache: prevent direct access of bd_inode
  block2mtd: prevent direct access of bd_inode
  dm-vdo: prevent direct access of bd_inode
  scsi: factor out a helper bdev_read_folio() from scsi_bios_ptable()
  fs & block: remove bdev->bd_inode

 block/bdev.c                              | 108 +++++++++++++++-------
 block/blk-zoned.c                         |   4 +-
 block/blk.h                               |   2 +
 block/fops.c                              |   4 +-
 block/genhd.c                             |   9 +-
 block/ioctl.c                             |   8 +-
 block/partitions/core.c                   |   8 +-
 drivers/md/bcache/super.c                 |   7 +-
 drivers/md/dm-vdo/dedupe.c                |   3 +-
 drivers/md/dm-vdo/dm-vdo-target.c         |   5 +-
 drivers/md/dm-vdo/indexer/config.c        |   1 +
 drivers/md/dm-vdo/indexer/config.h        |   3 +
 drivers/md/dm-vdo/indexer/index-layout.c  |   6 +-
 drivers/md/dm-vdo/indexer/index-layout.h  |   2 +-
 drivers/md/dm-vdo/indexer/index-session.c |  13 +--
 drivers/md/dm-vdo/indexer/index.c         |   4 +-
 drivers/md/dm-vdo/indexer/index.h         |   2 +-
 drivers/md/dm-vdo/indexer/indexer.h       |   4 +-
 drivers/md/dm-vdo/indexer/io-factory.c    |  13 ++-
 drivers/md/dm-vdo/indexer/io-factory.h    |   4 +-
 drivers/md/dm-vdo/indexer/volume.c        |   4 +-
 drivers/md/dm-vdo/indexer/volume.h        |   2 +-
 drivers/md/md-bitmap.c                    |   2 +-
 drivers/mtd/devices/block2mtd.c           |   6 +-
 drivers/s390/block/dasd_ioctl.c           |   5 +-
 drivers/scsi/scsicam.c                    |   3 +-
 fs/affs/file.c                            |   2 +-
 fs/bcachefs/util.h                        |   5 -
 fs/btrfs/dev-replace.c                    |   2 +-
 fs/btrfs/disk-io.c                        |  17 ++--
 fs/btrfs/disk-io.h                        |   4 +-
 fs/btrfs/inode.c                          |   2 +-
 fs/btrfs/super.c                          |   2 +-
 fs/btrfs/volumes.c                        |  32 ++++---
 fs/btrfs/volumes.h                        |   2 +-
 fs/btrfs/zoned.c                          |  20 ++--
 fs/btrfs/zoned.h                          |   4 +-
 fs/buffer.c                               | 103 ++++++++++++---------
 fs/cramfs/inode.c                         |   2 +-
 fs/direct-io.c                            |   4 +-
 fs/erofs/data.c                           |   5 +-
 fs/erofs/internal.h                       |   1 +
 fs/erofs/zmap.c                           |   2 +-
 fs/exfat/fatent.c                         |   2 +-
 fs/ext2/inode.c                           |   4 +-
 fs/ext2/xattr.c                           |   2 +-
 fs/ext4/dir.c                             |   2 +-
 fs/ext4/ext4_jbd2.c                       |   2 +-
 fs/ext4/inode.c                           |   8 +-
 fs/ext4/mmp.c                             |   2 +-
 fs/ext4/page-io.c                         |   5 +-
 fs/ext4/super.c                           |  30 ++----
 fs/ext4/xattr.c                           |   2 +-
 fs/f2fs/data.c                            |   7 +-
 fs/f2fs/f2fs.h                            |   1 +
 fs/fat/inode.c                            |   2 +-
 fs/fuse/dax.c                             |   2 +-
 fs/gfs2/aops.c                            |   2 +-
 fs/gfs2/bmap.c                            |   2 +-
 fs/gfs2/glock.c                           |   2 +-
 fs/gfs2/meta_io.c                         |   2 +-
 fs/gfs2/ops_fstype.c                      |   2 +-
 fs/hpfs/file.c                            |   2 +-
 fs/iomap/buffered-io.c                    |   8 +-
 fs/iomap/direct-io.c                      |  11 ++-
 fs/iomap/swapfile.c                       |   2 +-
 fs/iomap/trace.h                          |   2 +-
 fs/jbd2/commit.c                          |   2 +-
 fs/jbd2/journal.c                         |  34 ++++---
 fs/jbd2/recovery.c                        |   8 +-
 fs/jbd2/revoke.c                          |  13 +--
 fs/jbd2/transaction.c                     |   8 +-
 fs/mpage.c                                |  26 ++++--
 fs/nilfs2/btnode.c                        |   4 +-
 fs/nilfs2/gcinode.c                       |   2 +-
 fs/nilfs2/mdt.c                           |   2 +-
 fs/nilfs2/page.c                          |   4 +-
 fs/nilfs2/recovery.c                      |  27 ++++--
 fs/nilfs2/segment.c                       |   2 +-
 fs/ntfs3/fsntfs.c                         |   8 +-
 fs/ntfs3/inode.c                          |   4 +-
 fs/ntfs3/super.c                          |   2 +-
 fs/ocfs2/journal.c                        |   2 +-
 fs/reiserfs/fix_node.c                    |   2 +-
 fs/reiserfs/journal.c                     |  10 +-
 fs/reiserfs/prints.c                      |   4 +-
 fs/reiserfs/reiserfs.h                    |   6 +-
 fs/reiserfs/stree.c                       |   2 +-
 fs/reiserfs/tail_conversion.c             |   2 +-
 fs/sync.c                                 |   9 +-
 fs/xfs/xfs_iomap.c                        |   4 +-
 fs/zonefs/file.c                          |   4 +-
 include/linux/blk_types.h                 |   1 -
 include/linux/blkdev.h                    |  21 +----
 include/linux/buffer_head.h               |  73 ++++++++++-----
 include/linux/iomap.h                     |  14 ++-
 include/linux/jbd2.h                      |  18 +++-
 include/trace/events/block.h              |   2 +-
 98 files changed, 491 insertions(+), 376 deletions(-)

-- 
2.39.2


