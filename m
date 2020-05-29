Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B421E7FCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgE2OL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 10:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgE2OLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 10:11:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E355C03E969;
        Fri, 29 May 2020 07:11:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so1198111plo.7;
        Fri, 29 May 2020 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xgMt8/Ap5gvlX6ynibkokY447a53n7PgRJd4O0S9s1g=;
        b=CiAbWXa/UnMPkO6KPS69UlWCIlGlJ0uEZUrL/5cENWQhkx+7M88kEouiTRuIcHiBFY
         cwU9+0BTLQgK0HN68/GUdBAnqo3S6tnlxi5Bv3/ATQG4kmIwqIPmLkKRuRGMWPX9/KWV
         3EYvDr6B0GQlxYU/8XYS2zwFUDtKcU4Vg65sBMsmgoiTb1k3dfRUBkfD0Lj/azF4H7ew
         2rvkTouIQR8A46Ykxge5BsK2WfM9LUqkEHGstrpRhDLO1D3xbpWs+JQtCE1oBZ9PduE8
         oARZ6xrOyeD3rFB1dbZDF0FxIDtidd7aRq++3+47eTuMo9RCJY83xZQorP61fvtph9Jb
         7/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xgMt8/Ap5gvlX6ynibkokY447a53n7PgRJd4O0S9s1g=;
        b=r0ig9k9ssXhkr7dRchv+rPEgIKT4Es31R+KSNvR7UNklU8qvvDbiB/uw9t3BrR+fvn
         kC0EDfcrC0JzmSQcAcEO8jrM1KKrbs4p3tVnEyHF96A3PoFc694zbxGvAvMxfVLIwCwW
         YphOs6UkeiVNh1Jbsa7ROm7Md6Z9EnHcugoACvfHK8yFM/2EWOPBGQpa/sXc4PqVia/O
         RJXyGHNxO8s2LNi4YcJz4C9Hts37y94ZyHdHrpsXErH6LLpezHLG20xgImfFKvPKfpyh
         ElbAJPOWwPptro4UY0IbQ7wEh4XvkD3q1+5hXXmTXmbNxAf5qR4PN0lxcn+/6F9OJaem
         rvMw==
X-Gm-Message-State: AOAM5326zNKGvuzAwnZ451NplwfZM7oGZYpqv/Xi9hJT0iPJ4AmVMf+I
        j3weeTLpVrb0lnWQTiTrHYk=
X-Google-Smtp-Source: ABdhPJzFMCwkzDp3IkhKL3lk0R3scS2Yh0i7BgzdBQ154tbip+aLEfVcaO1NgL+5iytcLq+RymuMpA==
X-Received: by 2002:a17:90a:2622:: with SMTP id l31mr1765843pje.18.1590761483912;
        Fri, 29 May 2020 07:11:23 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.67])
        by smtp.gmail.com with ESMTPSA id o25sm7048777pgn.84.2020.05.29.07.11.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 07:11:23 -0700 (PDT)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     axboe@kernel.dk, hch@lst.de, sth@linux.ibm.com,
        viro@zeniv.linux.org.uk, clm@fb.com, jaegeuk@kernel.org,
        hch@infradead.org, mark@fasheh.com, dhowells@redhat.com,
        balbi@kernel.org
Cc:     damien.lemoal@wdc.com, bvanassche@acm.org, ming.lei@redhat.com,
        martin.petersen@oracle.com, satyat@google.com,
        chaitanya.kulkarni@wdc.com, houtao1@huawei.com,
        asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, deepa.kernel@gmail.com,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
Date:   Fri, 29 May 2020 22:11:00 +0800
Message-Id: <20200529141100.37519-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a function named ilog2() exist which can replace blksize.
The generated code will be shorter and more efficient on some
architecture, such as arm64. And ilog2() can be optimized according
to different architecture.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
changes in v2:
	Remove all blksize_bits

 drivers/nvme/target/io-cmd-bdev.c            |  2 +-
 drivers/s390/block/dasd_ioctl.c              |  2 +-
 drivers/usb/gadget/function/storage_common.c |  2 +-
 fs/block_dev.c                               |  6 +++---
 fs/btrfs/disk-io.c                           |  4 ++--
 fs/buffer.c                                  |  2 +-
 fs/direct-io.c                               |  2 +-
 fs/f2fs/data.c                               |  2 +-
 fs/iomap/direct-io.c                         |  2 +-
 fs/ocfs2/super.c                             |  2 +-
 fs/romfs/super.c                             |  2 +-
 include/linux/blkdev.h                       | 11 -----------
 12 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index bcf979eb8e83..58bd947e232e 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -63,7 +63,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 		return ret;
 	}
 	ns->size = i_size_read(ns->bdev->bd_inode);
-	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+	ns->blksize_shift = ilog2(bdev_logical_block_size(ns->bdev));
 	return 0;
 }
 
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 777734d1b4e5..55adb134451b 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -228,7 +228,7 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
 	 */
 	if (fdata->start_unit == 0) {
 		struct block_device *bdev = bdget_disk(block->gdp, 0);
-		bdev->bd_inode->i_blkbits = blksize_bits(fdata->blksize);
+		bdev->bd_inode->i_blkbits = ilog2(fdata->blksize);
 		bdput(bdev);
 	}
 
diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
index f7e6c42558eb..eada3e801dd7 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -233,7 +233,7 @@ int fsg_lun_open(struct fsg_lun *curlun, const char *filename)
 		blkbits = 11;
 	} else if (inode->i_bdev) {
 		blksize = bdev_logical_block_size(inode->i_bdev);
-		blkbits = blksize_bits(blksize);
+		blkbits = ilog2(blksize);
 	} else {
 		blksize = 512;
 		blkbits = 9;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index a333a648244e..d18496dfc6e7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -115,7 +115,7 @@ static void set_init_blocksize(struct block_device *bdev)
 		bsize <<= 1;
 	}
 	bdev->bd_block_size = bsize;
-	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	bdev->bd_inode->i_blkbits = ilog2(bsize);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
@@ -132,7 +132,7 @@ int set_blocksize(struct block_device *bdev, int size)
 	if (bdev->bd_block_size != size) {
 		sync_blockdev(bdev);
 		bdev->bd_block_size = size;
-		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		bdev->bd_inode->i_blkbits = ilog2(size);
 		kill_bdev(bdev);
 	}
 	return 0;
@@ -147,7 +147,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 	/* If we get here, we know size is power of two
 	 * and it's value is between 512 and PAGE_SIZE */
 	sb->s_blocksize = size;
-	sb->s_blocksize_bits = blksize_bits(size);
+	sb->s_blocksize_bits = ilog2(size);
 	return sb->s_blocksize;
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7c6f0bbb54a5..711b9fc31c94 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2765,7 +2765,7 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 
 	fs_info->sb = sb;
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
-	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
+	sb->s_blocksize_bits = ilog2(BTRFS_BDEV_BLOCKSIZE);
 
 	ret = percpu_counter_init(&fs_info->dio_bytes, 0, GFP_KERNEL);
 	if (ret)
@@ -3059,7 +3059,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
 
 	sb->s_blocksize = sectorsize;
-	sb->s_blocksize_bits = blksize_bits(sectorsize);
+	sb->s_blocksize_bits = ilog2(sectorsize);
 	memcpy(&sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
 
 	mutex_lock(&fs_info->chunk_mutex);
diff --git a/fs/buffer.c b/fs/buffer.c
index fc8831c392d7..fa92e0afe349 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -907,7 +907,7 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 	loff_t sz = i_size_read(bdev->bd_inode);
 
 	if (sz) {
-		unsigned int sizebits = blksize_bits(size);
+		unsigned int sizebits = ilog2(size);
 		retval = (sz >> sizebits);
 	}
 	return retval;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 1543b5af400e..7ea2cd3effcc 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1148,7 +1148,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 	if (align & blocksize_mask) {
 		if (bdev)
-			blkbits = blksize_bits(bdev_logical_block_size(bdev));
+			blkbits = ilog2(bdev_logical_block_size(bdev));
 		blocksize_mask = (1 << blkbits) - 1;
 		if (align & blocksize_mask)
 			goto out;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cb05f71cf850..b896da27942a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3458,7 +3458,7 @@ static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
 
 	if (align & blocksize_mask) {
 		if (bdev)
-			blkbits = blksize_bits(bdev_logical_block_size(bdev));
+			blkbits = ilog2(bdev_logical_block_size(bdev));
 		blocksize_mask = (1 << blkbits) - 1;
 		if (align & blocksize_mask)
 			return -EINVAL;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6feca..2a807657d544 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -203,7 +203,7 @@ static loff_t
 iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		struct iomap_dio *dio, struct iomap *iomap)
 {
-	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
+	unsigned int blkbits = ilog2(bdev_logical_block_size(iomap->bdev));
 	unsigned int fs_block_size = i_blocksize(inode), pad;
 	unsigned int align = iov_iter_alignment(dio->submit.iter);
 	struct bio *bio;
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 71ea9ce71a6b..9b5622881d34 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2054,7 +2054,7 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	osb->osb_dx_seed[3] = le32_to_cpu(di->id2.i_super.s_uuid_hash);
 
 	osb->sb = sb;
-	osb->s_sectsize_bits = blksize_bits(sector_size);
+	osb->s_sectsize_bits = ilog2(sector_size);
 	BUG_ON(!osb->s_sectsize_bits);
 
 	spin_lock_init(&osb->dc_task_lock);
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index e582d001f792..4f6963570739 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -470,7 +470,7 @@ static int romfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb_set_blocksize(sb, ROMBSIZE);
 	} else {
 		sb->s_blocksize = ROMBSIZE;
-		sb->s_blocksize_bits = blksize_bits(ROMBSIZE);
+		sb->s_blocksize_bits = ilog2(ROMBSIZE);
 	}
 #endif
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7d10f4e63232..16038b609c14 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1502,17 +1502,6 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
 	return !(addr & alignment) && !(len & alignment);
 }
 
-/* assumes size > 256 */
-static inline unsigned int blksize_bits(unsigned int size)
-{
-	unsigned int bits = 8;
-	do {
-		bits++;
-		size >>= 1;
-	} while (size > 256);
-	return bits;
-}
-
 static inline unsigned int block_size(struct block_device *bdev)
 {
 	return bdev->bd_block_size;
-- 
2.20.1

