Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D153350223C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 06:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349797AbiDOE4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 00:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349492AbiDOE4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:56:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5BB71A33;
        Thu, 14 Apr 2022 21:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HrgNfnZXHjI7+oEfFDB5J5Uuocj6xy8pedsh1Yy5WG4=; b=R0lBPRibOGoSZmsdT2BBTTPD3x
        NwCzRpJB/bxli2xONupKhhJNx7Tq1nA6hg5urvI8CevCDma1aSHOvltCxPQVBkCYYIAazdu94JhOg
        jUc9C0uB0ZcqdXuo3tqllo7RFWblcuoKttRRtshPAOTk9xPWXo9L51Jx+MBLxWuevzEN6ePJqPM9o
        O/Kgk+1vrPJJ/tXWxgEWAoGzr7Z1pW3yunSGYLN41shEprbTPauLr7ZDX+uOWX/sBmVGFEWkzS8iP
        pSkYNyZUK+8w0sI6r2DBAifGctVRL3GCvrebz8RO5GOBvOX0W6zq/yOSLOkXbitIIxFW4u3HYF7ZU
        82QTqcrQ==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfDxl-008P65-E3; Fri, 15 Apr 2022 04:53:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 11/27] block: add a bdev_nonrot helper
Date:   Fri, 15 Apr 2022 06:52:42 +0200
Message-Id: <20220415045258.199825-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415045258.199825-1-hch@lst.de>
References: <20220415045258.199825-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to check the nonrot flag based on the block_device instead
of having to poke into the block layer internal request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Acked-by: David Sterba <dsterba@suse.com> [btrfs]
---
 block/ioctl.c                       | 2 +-
 drivers/block/loop.c                | 2 +-
 drivers/md/dm-table.c               | 4 +---
 drivers/md/md.c                     | 3 +--
 drivers/md/raid1.c                  | 2 +-
 drivers/md/raid10.c                 | 2 +-
 drivers/md/raid5.c                  | 2 +-
 drivers/target/target_core_file.c   | 3 +--
 drivers/target/target_core_iblock.c | 2 +-
 fs/btrfs/volumes.c                  | 4 ++--
 fs/ext4/mballoc.c                   | 2 +-
 include/linux/blkdev.h              | 5 +++++
 mm/swapfile.c                       | 4 ++--
 13 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 4a86340133e46..ad3771b268b81 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -489,7 +489,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 				    queue_max_sectors(bdev_get_queue(bdev)));
 		return put_ushort(argp, max_sectors);
 	case BLKROTATIONAL:
-		return put_ushort(argp, !blk_queue_nonrot(bdev_get_queue(bdev)));
+		return put_ushort(argp, !bdev_nonrot(bdev));
 	case BLKRASET:
 	case BLKFRASET:
 		if(!capable(CAP_SYS_ADMIN))
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a58595f5ee2c8..8d800d46e4985 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -903,7 +903,7 @@ static void loop_update_rotational(struct loop_device *lo)
 
 	/* not all filesystems (e.g. tmpfs) have a sb->s_bdev */
 	if (file_bdev)
-		nonrot = blk_queue_nonrot(bdev_get_queue(file_bdev));
+		nonrot = bdev_nonrot(file_bdev);
 
 	if (nonrot)
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 03541cfc2317c..5e38d0dd009d5 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1820,9 +1820,7 @@ static int device_dax_write_cache_enabled(struct dm_target *ti,
 static int device_is_rotational(struct dm_target *ti, struct dm_dev *dev,
 				sector_t start, sector_t len, void *data)
 {
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-
-	return !blk_queue_nonrot(q);
+	return !bdev_nonrot(dev->bdev);
 }
 
 static int device_is_not_random(struct dm_target *ti, struct dm_dev *dev,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 309b3af906ad3..19636c2f2cda4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5991,8 +5991,7 @@ int md_run(struct mddev *mddev)
 		bool nonrot = true;
 
 		rdev_for_each(rdev, mddev) {
-			if (rdev->raid_disk >= 0 &&
-			    !blk_queue_nonrot(bdev_get_queue(rdev->bdev))) {
+			if (rdev->raid_disk >= 0 && !bdev_nonrot(rdev->bdev)) {
 				nonrot = false;
 				break;
 			}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 99d5464a51f81..d81b896855f9f 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -704,7 +704,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			/* At least two disks to choose from so failfast is OK */
 			set_bit(R1BIO_FailFast, &r1_bio->state);
 
-		nonrot = blk_queue_nonrot(bdev_get_queue(rdev->bdev));
+		nonrot = bdev_nonrot(rdev->bdev);
 		has_nonrot_disk |= nonrot;
 		pending = atomic_read(&rdev->nr_pending);
 		dist = abs(this_sector - conf->mirrors[disk].head_position);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index dfe7d62d3fbdd..7816c8b2e8087 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -796,7 +796,7 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		if (!do_balance)
 			break;
 
-		nonrot = blk_queue_nonrot(bdev_get_queue(rdev->bdev));
+		nonrot = bdev_nonrot(rdev->bdev);
 		has_nonrot_disk |= nonrot;
 		pending = atomic_read(&rdev->nr_pending);
 		if (min_pending > pending && nonrot) {
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 351d341a1ffa4..0bbae0e638666 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7242,7 +7242,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	rdev_for_each(rdev, mddev) {
 		if (test_bit(Journal, &rdev->flags))
 			continue;
-		if (blk_queue_nonrot(bdev_get_queue(rdev->bdev))) {
+		if (bdev_nonrot(rdev->bdev)) {
 			conf->batch_bio_dispatch = false;
 			break;
 		}
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 8d191fdc33217..b6ba582b06775 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -135,7 +135,6 @@ static int fd_configure_device(struct se_device *dev)
 	inode = file->f_mapping->host;
 	if (S_ISBLK(inode->i_mode)) {
 		struct block_device *bdev = I_BDEV(inode);
-		struct request_queue *q = bdev_get_queue(bdev);
 		unsigned long long dev_size;
 
 		fd_dev->fd_block_size = bdev_logical_block_size(bdev);
@@ -160,7 +159,7 @@ static int fd_configure_device(struct se_device *dev)
 		 */
 		dev->dev_attrib.max_write_same_len = 0xFFFF;
 
-		if (blk_queue_nonrot(q))
+		if (bdev_nonrot(bdev))
 			dev->dev_attrib.is_nonrot = 1;
 	} else {
 		if (!(fd_dev->fbd_flags & FBDF_HAS_SIZE)) {
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index b886ce1770bfd..b41ee5c3b5b82 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -133,7 +133,7 @@ static int iblock_configure_device(struct se_device *dev)
 	else
 		dev->dev_attrib.max_write_same_len = 0xFFFF;
 
-	if (blk_queue_nonrot(q))
+	if (bdev_nonrot(bd))
 		dev->dev_attrib.is_nonrot = 1;
 
 	bi = bdev_get_integrity(bd);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2cfbc74a3b4ee..77f1a5696842b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -643,7 +643,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	}
 
-	if (!blk_queue_nonrot(bdev_get_queue(bdev)))
+	if (!bdev_nonrot(bdev))
 		fs_devices->rotating = true;
 
 	device->bdev = bdev;
@@ -2706,7 +2706,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
 
-	if (!blk_queue_nonrot(bdev_get_queue(bdev)))
+	if (!bdev_nonrot(bdev))
 		fs_devices->rotating = true;
 
 	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 252c168454c7f..c3668c977cd99 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3498,7 +3498,7 @@ int ext4_mb_init(struct super_block *sb)
 		spin_lock_init(&lg->lg_prealloc_lock);
 	}
 
-	if (blk_queue_nonrot(bdev_get_queue(sb->s_bdev)))
+	if (bdev_nonrot(sb->s_bdev))
 		sbi->s_mb_max_linear_groups = 0;
 	else
 		sbi->s_mb_max_linear_groups = MB_DEFAULT_LINEAR_LIMIT;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 60d0161389971..3a9578e14a6b0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1326,6 +1326,11 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline bool bdev_nonrot(struct block_device *bdev)
+{
+	return blk_queue_nonrot(bdev_get_queue(bdev));
+}
+
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4c7537162af5e..d5ab7ec4d92ca 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2466,7 +2466,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	if (p->flags & SWP_CONTINUED)
 		free_swap_count_continuations(p);
 
-	if (!p->bdev || !blk_queue_nonrot(bdev_get_queue(p->bdev)))
+	if (!p->bdev || !bdev_nonrot(p->bdev))
 		atomic_dec(&nr_rotate_swap);
 
 	mutex_lock(&swapon_mutex);
@@ -3071,7 +3071,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (p->bdev && p->bdev->bd_disk->fops->rw_page)
 		p->flags |= SWP_SYNCHRONOUS_IO;
 
-	if (p->bdev && blk_queue_nonrot(bdev_get_queue(p->bdev))) {
+	if (p->bdev && bdev_nonrot(p->bdev)) {
 		int cpu;
 		unsigned long ci, nr_cluster;
 
-- 
2.30.2

