Return-Path: <linux-fsdevel+bounces-16265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A047B89A9DC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EF64B22215
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DC128DD2;
	Sat,  6 Apr 2024 09:17:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBADB79E3;
	Sat,  6 Apr 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395068; cv=none; b=j7L9MNi52K8Phn3qIL2HdPtQndsd+ATUhCCOJDCafAp2WEzZrLg8V8OHciDjdZ+ba3pfV9V5BcIBmm8xweRiIvEchyfgvrRwwItzHnmE081vKJYtyqOx/BiOsmP9WtTvySr87jdfoioAT5e5zo9mfAY+2Udv8y3M90SR1pgC4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395068; c=relaxed/simple;
	bh=gMeefPhfxL4L23mApkXFK/WEoVhfa4qv57lD3Wkw3lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ba57A1Jci8tHge7PXQFnfk1BbCC2qwP0bbB4ZtatVMm4/c0tHCzg/wwB7ijyGzQYhAOQuyhPp/f7pSSOjDys2IJEoQziWUUWRVB8oWCL8RMAGsQeEujtBwFvwbjRRqSOFHFTcDLhlQZkutZTxNJkzSUZo3cm3pk7mbJ6M3EBi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVB96bnrz4f3jkC;
	Sat,  6 Apr 2024 17:17:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3C9341A0172;
	Sat,  6 Apr 2024 17:17:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S4;
	Sat, 06 Apr 2024 17:17:40 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH vfs.all 00/26] fs & block: remove bdev->bd_inode
Date: Sat,  6 Apr 2024 17:09:04 +0800
Message-Id: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr17ZF15JrWDXw18ZryrJFb_yoWxGFWUpr
	s5GFySkr1YvrWUuFWxZa1UAa4Yk3ZrWay29ry7Zwn8ZFW5GFyjvr4kKF45CFWDGrZ3Aw13
	ZF1UAw1kWr15urJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Hi, Jens!
Hi, Jan!
Hi, Christoph!
Hi, Christian!
Hi, AL!

Sorry for the delay(I was overwhelmed with other work stuff). Main changes
from last version is patch 22(modified based on [1]), the idea is that
stash a 'bdev_file' in 'bd_inode->i_private' while opening bdev the first
time, and release it when last opener close the bdev.

The patch to use bdev and bdev_file as union for iomap/buffer_head is
dropped and changes for iomap/buffer is splitted to patch 23-26.

I tested this set in my VM with blktests for virtio-scsi and xfstests
for ext4/xfs for one round now, no regerssions are found yet.

Please let me know what you think!

[1] https://lore.kernel.org/all/c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com/

Changes from RFC v4:
 - respin on the top of vfs.all branch from vfs tree;
 - add review tag, patches that are not reviewed: patch 19-26;
 - add patch 21, fix a module reference problem;
 - instead of using a union of bdev(for raw block device) and
 bdev_file(for filesystems), add patch 22 to stash a bdev_file to
 bd_inode->i_private, so that iomap and buffer_head for raw block device
 can convert to use bdev_file as well;
 - split the huge path for iomap/buffer into 4 patches, 21-24;

Changes from RFC v3:
 - respin on the top of linux-next, based on Christian's patchset to
 open bdev as file. Most of patches from v3 is dropped and change to use
 file_inode(bdev_file) to get bd_inode or bdev_file->f_mapping to get
 bd_inode->i_mapping.

Changes from RFC v2:
 - remove bdev_associated_mapping() and patch 12 from v1;
 - add kerneldoc comments for new bdev apis;
 - rename __bdev_get_folio() to bdev_get_folio;
 - fix a problem in erofs that erofs_init_metabuf() is not always
 called.
 - add reviewed-by tag for patch 15-17;

Changes from RFC v1:
 - remove some bdev apis that is not necessary;
 - pass in offset for bdev_read_folio() and __bdev_get_folio();
 - remove bdev_gfp_constraint() and add a new helper in fs/buffer.c to
 prevent access bd_indoe() directly from mapping_gfp_constraint() in
 ext4.(patch 15, 16);
 - remove block_device_ejected() from ext4.

Yu Kuai (26):
  block: move two helpers into bdev.c
  block: remove sync_blockdev_nowait()
  block: remove sync_blockdev_range()
  block: prevent direct access of bd_inode
  block: add a helper bdev_read_folio()
  bcachefs: remove dead function bdev_sectors()
  cramfs: prevent direct access of bd_inode
  erofs: prevent direct access of bd_inode
  nilfs2: prevent direct access of bd_inode
  gfs2: prevent direct access of bd_inode
  btrfs: prevent direct access of bd_inode
  ext4: remove block_device_ejected()
  ext4: prevent direct access of bd_inode
  jbd2: prevent direct access of bd_inode
  s390/dasd: use bdev api in dasd_format()
  bcache: prevent direct access of bd_inode
  block2mtd: prevent direct access of bd_inode
  scsi: use bdev helper in scsi_bios_ptable()
  dm-vdo: convert to use bdev_file
  block: factor out a helper init_bdev_file()
  block: fix module reference leakage from bdev_open_by_dev error path
  block: stash a bdev_file to read/write raw blcok_device
  iomap: add helpers helpers to get and set bdev
  iomap: convert to use bdev_file
  buffer: add helpers to get and set bdev
  buffer: convert to use bdev_file

 block/bdev.c                              | 262 ++++++++++++++++------
 block/blk-zoned.c                         |   4 +-
 block/blk.h                               |   2 +
 block/fops.c                              |   6 +-
 block/genhd.c                             |   9 +-
 block/ioctl.c                             |   8 +-
 block/partitions/core.c                   |   8 +-
 drivers/md/bcache/super.c                 |   7 +-
 drivers/md/dm-vdo/dedupe.c                |   7 +-
 drivers/md/dm-vdo/dm-vdo-target.c         |   9 +-
 drivers/md/dm-vdo/indexer/config.c        |   2 +-
 drivers/md/dm-vdo/indexer/config.h        |   4 +-
 drivers/md/dm-vdo/indexer/index-layout.c  |   6 +-
 drivers/md/dm-vdo/indexer/index-layout.h  |   2 +-
 drivers/md/dm-vdo/indexer/index-session.c |  18 +-
 drivers/md/dm-vdo/indexer/index.c         |   4 +-
 drivers/md/dm-vdo/indexer/index.h         |   2 +-
 drivers/md/dm-vdo/indexer/indexer.h       |   6 +-
 drivers/md/dm-vdo/indexer/io-factory.c    |  17 +-
 drivers/md/dm-vdo/indexer/io-factory.h    |   4 +-
 drivers/md/dm-vdo/indexer/volume.c        |   4 +-
 drivers/md/dm-vdo/indexer/volume.h        |   2 +-
 drivers/md/dm-vdo/vdo.c                   |   2 +-
 drivers/md/md-bitmap.c                    |   2 +-
 drivers/mtd/devices/block2mtd.c           |   6 +-
 drivers/s390/block/dasd_ioctl.c           |   5 +-
 drivers/scsi/scsicam.c                    |   3 +-
 fs/affs/file.c                            |   2 +-
 fs/bcachefs/util.h                        |   5 -
 fs/btrfs/disk-io.c                        |  17 +-
 fs/btrfs/disk-io.h                        |   4 +-
 fs/btrfs/inode.c                          |   2 +-
 fs/btrfs/super.c                          |   2 +-
 fs/btrfs/volumes.c                        |  25 ++-
 fs/btrfs/zoned.c                          |  20 +-
 fs/btrfs/zoned.h                          |   4 +-
 fs/buffer.c                               | 104 ++++-----
 fs/cramfs/inode.c                         |   2 +-
 fs/direct-io.c                            |   4 +-
 fs/erofs/data.c                           |  22 +-
 fs/erofs/internal.h                       |   1 +
 fs/erofs/zmap.c                           |   2 +-
 fs/exfat/fatent.c                         |   2 +-
 fs/ext2/inode.c                           |   4 +-
 fs/ext2/xattr.c                           |   2 +-
 fs/ext4/dir.c                             |   2 +-
 fs/ext4/ext4_jbd2.c                       |   2 +-
 fs/ext4/inode.c                           |   2 +-
 fs/ext4/mmp.c                             |   2 +-
 fs/ext4/page-io.c                         |   5 +-
 fs/ext4/super.c                           |  30 +--
 fs/ext4/xattr.c                           |   2 +-
 fs/f2fs/data.c                            |  10 +-
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
 fs/iomap/direct-io.c                      |  11 +-
 fs/iomap/swapfile.c                       |   2 +-
 fs/iomap/trace.h                          |   6 +-
 fs/jbd2/commit.c                          |   2 +-
 fs/jbd2/journal.c                         |  34 +--
 fs/jbd2/recovery.c                        |   9 +-
 fs/jbd2/revoke.c                          |  14 +-
 fs/jbd2/transaction.c                     |   8 +-
 fs/mpage.c                                |  18 +-
 fs/nilfs2/btnode.c                        |   4 +-
 fs/nilfs2/gcinode.c                       |   2 +-
 fs/nilfs2/mdt.c                           |   2 +-
 fs/nilfs2/page.c                          |   4 +-
 fs/nilfs2/recovery.c                      |  27 ++-
 fs/nilfs2/segment.c                       |   2 +-
 fs/ntfs3/fsntfs.c                         |  10 +-
 fs/ntfs3/inode.c                          |   4 +-
 fs/ntfs3/super.c                          |   6 +-
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
 include/linux/blk_types.h                 |   2 +-
 include/linux/blkdev.h                    |  19 +-
 include/linux/buffer_head.h               |  81 ++++---
 include/linux/iomap.h                     |  13 +-
 include/linux/jbd2.h                      |  18 +-
 include/trace/events/block.h              |   2 +-
 97 files changed, 620 insertions(+), 440 deletions(-)

-- 
2.39.2


