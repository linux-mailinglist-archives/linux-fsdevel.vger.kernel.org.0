Return-Path: <linux-fsdevel+bounces-14436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC887CD09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A492839CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8EF1C695;
	Fri, 15 Mar 2024 12:09:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5191C683;
	Fri, 15 Mar 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504540; cv=none; b=t5tkdRLtpmBX+fTXIHOT5P/JhETPLX+cCFeDilYiDhnqZ915bZh2uexGPFtvN/h3498CMj0+r1NrwTlE9Vxc9Bl6eZIVd1y4LDU5biPtWNJyj0OzF1nPzM52fdsergqRX4yXD4bZ26r/t1CB0JN1wUQ6gt58E9Q/Nel/fMDR7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504540; c=relaxed/simple;
	bh=BoxHO+NQNUivX0dnzc7jAksKWZjd5aXdu6wr0adXOqo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mKh7sVoMJdFZjzLx1ECT0Kv11GyoK/MITHX6cncQu3MFWN4a2q22M4jzf1UecvDUlp/h/tlPVPY8ulkcwfyxwdWG7YUA1e4CcuxoV5dTn+DolxxaMW+sXpM9h26Yh3SfvsfnO3NNI6m2pR6DAMb60wYKQN4StxJIFXhOCXDxFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tx31Y2yxDz1FMPL;
	Fri, 15 Mar 2024 20:08:33 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 5113D140124;
	Fri, 15 Mar 2024 20:08:51 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 20:08:50 +0800
Subject: Re: [RFC v4 linux-next 00/19] fs & block: remove bdev->bd_inode
To: Yu Kuai <yukuai1@huaweicloud.com>, <jack@suse.cz>, <hch@lst.de>,
	<brauner@kernel.org>, <axboe@kernel.dk>
CC: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai3@huawei.com>
Message-ID: <1324ffb5-28b6-34fb-014e-3f57df714095@huawei.com>
Date: Fri, 15 Mar 2024 20:08:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)

Hi, Christian
Hi, Christoph
Hi, Jan

Perhaps now is a good time to send a formal version of this set.
However, I'm not sure yet what branch should I rebase and send this set.
Should I send to the vfs tree?

Thanks,
Kuai

ÔÚ 2024/02/22 20:45, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v4:
>   - respin on the top of linux-next, based on Christian's patchset to
>   open bdev as file. Most of patches from v3 is dropped and change to use
>   file_inode(bdev_file) to get bd_inode or bdev_file->f_mapping to get
>   bd_inode->i_mapping.
> 
> Changes in v3:
>   - remove bdev_associated_mapping() and patch 12 from v1;
>   - add kerneldoc comments for new bdev apis;
>   - rename __bdev_get_folio() to bdev_get_folio;
>   - fix a problem in erofs that erofs_init_metabuf() is not always
>   called.
>   - add reviewed-by tag for patch 15-17;
> 
> Changes in v2:
>   - remove some bdev apis that is not necessary;
>   - pass in offset for bdev_read_folio() and __bdev_get_folio();
>   - remove bdev_gfp_constraint() and add a new helper in fs/buffer.c to
>   prevent access bd_indoe() directly from mapping_gfp_constraint() in
>   ext4.(patch 15, 16);
>   - remove block_device_ejected() from ext4.
> 
> Yu Kuai (19):
>    block: move two helpers into bdev.c
>    block: remove sync_blockdev_nowait()
>    block: remove sync_blockdev_range()
>    block: prevent direct access of bd_inode
>    bcachefs: remove dead function bdev_sectors()
>    cramfs: prevent direct access of bd_inode
>    erofs: prevent direct access of bd_inode
>    nilfs2: prevent direct access of bd_inode
>    gfs2: prevent direct access of bd_inode
>    s390/dasd: use bdev api in dasd_format()
>    btrfs: prevent direct access of bd_inode
>    ext4: remove block_device_ejected()
>    ext4: prevent direct access of bd_inode
>    jbd2: prevent direct access of bd_inode
>    bcache: prevent direct access of bd_inode
>    block2mtd: prevent direct access of bd_inode
>    dm-vdo: prevent direct access of bd_inode
>    scsi: factor out a helper bdev_read_folio() from scsi_bios_ptable()
>    fs & block: remove bdev->bd_inode
> 
>   block/bdev.c                              | 108 +++++++++++++++-------
>   block/blk-zoned.c                         |   4 +-
>   block/blk.h                               |   2 +
>   block/fops.c                              |   4 +-
>   block/genhd.c                             |   9 +-
>   block/ioctl.c                             |   8 +-
>   block/partitions/core.c                   |   8 +-
>   drivers/md/bcache/super.c                 |   7 +-
>   drivers/md/dm-vdo/dedupe.c                |   3 +-
>   drivers/md/dm-vdo/dm-vdo-target.c         |   5 +-
>   drivers/md/dm-vdo/indexer/config.c        |   1 +
>   drivers/md/dm-vdo/indexer/config.h        |   3 +
>   drivers/md/dm-vdo/indexer/index-layout.c  |   6 +-
>   drivers/md/dm-vdo/indexer/index-layout.h  |   2 +-
>   drivers/md/dm-vdo/indexer/index-session.c |  13 +--
>   drivers/md/dm-vdo/indexer/index.c         |   4 +-
>   drivers/md/dm-vdo/indexer/index.h         |   2 +-
>   drivers/md/dm-vdo/indexer/indexer.h       |   4 +-
>   drivers/md/dm-vdo/indexer/io-factory.c    |  13 ++-
>   drivers/md/dm-vdo/indexer/io-factory.h    |   4 +-
>   drivers/md/dm-vdo/indexer/volume.c        |   4 +-
>   drivers/md/dm-vdo/indexer/volume.h        |   2 +-
>   drivers/md/md-bitmap.c                    |   2 +-
>   drivers/mtd/devices/block2mtd.c           |   6 +-
>   drivers/s390/block/dasd_ioctl.c           |   5 +-
>   drivers/scsi/scsicam.c                    |   3 +-
>   fs/affs/file.c                            |   2 +-
>   fs/bcachefs/util.h                        |   5 -
>   fs/btrfs/dev-replace.c                    |   2 +-
>   fs/btrfs/disk-io.c                        |  17 ++--
>   fs/btrfs/disk-io.h                        |   4 +-
>   fs/btrfs/inode.c                          |   2 +-
>   fs/btrfs/super.c                          |   2 +-
>   fs/btrfs/volumes.c                        |  32 ++++---
>   fs/btrfs/volumes.h                        |   2 +-
>   fs/btrfs/zoned.c                          |  20 ++--
>   fs/btrfs/zoned.h                          |   4 +-
>   fs/buffer.c                               | 103 ++++++++++++---------
>   fs/cramfs/inode.c                         |   2 +-
>   fs/direct-io.c                            |   4 +-
>   fs/erofs/data.c                           |   5 +-
>   fs/erofs/internal.h                       |   1 +
>   fs/erofs/zmap.c                           |   2 +-
>   fs/exfat/fatent.c                         |   2 +-
>   fs/ext2/inode.c                           |   4 +-
>   fs/ext2/xattr.c                           |   2 +-
>   fs/ext4/dir.c                             |   2 +-
>   fs/ext4/ext4_jbd2.c                       |   2 +-
>   fs/ext4/inode.c                           |   8 +-
>   fs/ext4/mmp.c                             |   2 +-
>   fs/ext4/page-io.c                         |   5 +-
>   fs/ext4/super.c                           |  30 ++----
>   fs/ext4/xattr.c                           |   2 +-
>   fs/f2fs/data.c                            |   7 +-
>   fs/f2fs/f2fs.h                            |   1 +
>   fs/fat/inode.c                            |   2 +-
>   fs/fuse/dax.c                             |   2 +-
>   fs/gfs2/aops.c                            |   2 +-
>   fs/gfs2/bmap.c                            |   2 +-
>   fs/gfs2/glock.c                           |   2 +-
>   fs/gfs2/meta_io.c                         |   2 +-
>   fs/gfs2/ops_fstype.c                      |   2 +-
>   fs/hpfs/file.c                            |   2 +-
>   fs/iomap/buffered-io.c                    |   8 +-
>   fs/iomap/direct-io.c                      |  11 ++-
>   fs/iomap/swapfile.c                       |   2 +-
>   fs/iomap/trace.h                          |   2 +-
>   fs/jbd2/commit.c                          |   2 +-
>   fs/jbd2/journal.c                         |  34 ++++---
>   fs/jbd2/recovery.c                        |   8 +-
>   fs/jbd2/revoke.c                          |  13 +--
>   fs/jbd2/transaction.c                     |   8 +-
>   fs/mpage.c                                |  26 ++++--
>   fs/nilfs2/btnode.c                        |   4 +-
>   fs/nilfs2/gcinode.c                       |   2 +-
>   fs/nilfs2/mdt.c                           |   2 +-
>   fs/nilfs2/page.c                          |   4 +-
>   fs/nilfs2/recovery.c                      |  27 ++++--
>   fs/nilfs2/segment.c                       |   2 +-
>   fs/ntfs3/fsntfs.c                         |   8 +-
>   fs/ntfs3/inode.c                          |   4 +-
>   fs/ntfs3/super.c                          |   2 +-
>   fs/ocfs2/journal.c                        |   2 +-
>   fs/reiserfs/fix_node.c                    |   2 +-
>   fs/reiserfs/journal.c                     |  10 +-
>   fs/reiserfs/prints.c                      |   4 +-
>   fs/reiserfs/reiserfs.h                    |   6 +-
>   fs/reiserfs/stree.c                       |   2 +-
>   fs/reiserfs/tail_conversion.c             |   2 +-
>   fs/sync.c                                 |   9 +-
>   fs/xfs/xfs_iomap.c                        |   4 +-
>   fs/zonefs/file.c                          |   4 +-
>   include/linux/blk_types.h                 |   1 -
>   include/linux/blkdev.h                    |  21 +----
>   include/linux/buffer_head.h               |  73 ++++++++++-----
>   include/linux/iomap.h                     |  14 ++-
>   include/linux/jbd2.h                      |  18 +++-
>   include/trace/events/block.h              |   2 +-
>   98 files changed, 491 insertions(+), 376 deletions(-)
> 

