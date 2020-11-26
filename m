Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236AC2C54DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389946AbgKZNHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389972AbgKZNHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:07:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553A7C0613D4;
        Thu, 26 Nov 2020 05:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=w/QBkEItEye82d1I56ixSRiHrWWB+I+iIiebQXlF55c=; b=k1CBVeSAz28h3ItFt9rUrYKRj8
        c3BDadnArEZ4c7mv5dbI4CGe7zP42Qw1cfOOo9HnDaKvqOJp2YDbpbrOLEjQNQdBzLfpi8eokWr32
        AUvbjHaVSSdfHNkmtnXtd8MohTlRx3ESvTfIZ92HNHJfQ/YLq/EbkBXBD1tAe7Redt/xppcf/48SP
        +bbOvT5D0iJyKZexgFm4HN/T4dE1XtoJNaiSP0VWNABW0pIiFkkC1xc1T+GzVs14Zi9eGNHBXQ1YJ
        O+mMlRC7FRGdaWtbrMeZ59DoTnwdSv3pd7jbhHnl0QKeZBlMbpSF6Tvv0ck2NtuziaUwGtZ+ohh/W
        f6xKImaA==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGzV-00045x-Gz; Thu, 26 Nov 2020 13:07:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 31/44] block: move the start_sect field to struct block_device
Date:   Thu, 26 Nov 2020 14:04:09 +0100
Message-Id: <20201126130422.92945-32-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the start_sect field to struct block_device in preparation
of killing struct hd_struct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c          |  5 +++--
 block/blk-lib.c           |  2 +-
 block/genhd.c             |  4 ++--
 block/partitions/core.c   | 17 +++++++++--------
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    |  4 ++--
 include/linux/genhd.h     |  3 +--
 kernel/trace/blktrace.c   | 11 +++--------
 8 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d2c9cb24e087f3..9a3793d5ce38d4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -757,9 +757,10 @@ static inline int blk_partition_remap(struct bio *bio)
 	if (bio_sectors(bio)) {
 		if (bio_check_eod(bio, bdev_nr_sectors(p->bdev)))
 			goto out;
-		bio->bi_iter.bi_sector += p->start_sect;
+		bio->bi_iter.bi_sector += p->bdev->bd_start_sect;
 		trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
-				      bio->bi_iter.bi_sector - p->start_sect);
+				      bio->bi_iter.bi_sector -
+				      p->bdev->bd_start_sect);
 	}
 	bio->bi_partno = 0;
 	ret = 0;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index e90614fd8d6a42..752f9c7220622a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -65,7 +65,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 	/* In case the discard request is in a partition */
 	if (bdev_is_partition(bdev))
-		part_offset = bdev->bd_part->start_sect;
+		part_offset = bdev->bd_start_sect;
 
 	while (nr_sects) {
 		sector_t granularity_aligned_lba, req_sects;
diff --git a/block/genhd.c b/block/genhd.c
index 9eead2970cb3d4..7bb45382658385 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -297,8 +297,8 @@ EXPORT_SYMBOL_GPL(disk_part_iter_exit);
 
 static inline int sector_in_part(struct hd_struct *part, sector_t sector)
 {
-	return part->start_sect <= sector &&
-		sector < part->start_sect + bdev_nr_sectors(part->bdev);
+	return part->bdev->bd_start_sect <= sector &&
+		sector < part->bdev->bd_start_sect + bdev_nr_sectors(part->bdev);
 }
 
 /**
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 8924e1ea8b2ad6..485777cea26bfa 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -192,7 +192,7 @@ static ssize_t part_start_show(struct device *dev,
 {
 	struct hd_struct *p = dev_to_part(dev);
 
-	return sprintf(buf, "%llu\n",(unsigned long long)p->start_sect);
+	return sprintf(buf, "%llu\n",(unsigned long long)p->bdev->bd_start_sect);
 }
 
 static ssize_t part_ro_show(struct device *dev,
@@ -209,7 +209,7 @@ static ssize_t part_alignment_offset_show(struct device *dev,
 
 	return sprintf(buf, "%u\n",
 		queue_limit_alignment_offset(&part_to_disk(p)->queue->limits,
-				p->start_sect));
+				p->bdev->bd_start_sect));
 }
 
 static ssize_t part_discard_alignment_show(struct device *dev,
@@ -219,7 +219,7 @@ static ssize_t part_discard_alignment_show(struct device *dev,
 
 	return sprintf(buf, "%u\n",
 		queue_limit_discard_alignment(&part_to_disk(p)->queue->limits,
-				p->start_sect));
+				p->bdev->bd_start_sect));
 }
 
 static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
@@ -301,7 +301,7 @@ static void hd_struct_free_work(struct work_struct *work)
 	 */
 	put_device(disk_to_dev(disk));
 
-	part->start_sect = 0;
+	part->bdev->bd_start_sect = 0;
 	bdev_set_nr_sectors(part->bdev, 0);
 	part_stat_set_all(part, 0);
 	put_device(part_to_dev(part));
@@ -416,7 +416,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 
 	pdev = part_to_dev(p);
 
-	p->start_sect = start;
+	bdev->bd_start_sect = start;
 	bdev_set_nr_sectors(bdev, len);
 	p->partno = partno;
 	p->policy = get_disk_ro(disk);
@@ -508,8 +508,9 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter))) {
 		if (part->partno == skip_partno ||
-		    start >= part->start_sect + bdev_nr_sectors(part->bdev) ||
-		    start + length <= part->start_sect)
+		    start >= part->bdev->bd_start_sect +
+			bdev_nr_sectors(part->bdev) ||
+		    start + length <= part->bdev->bd_start_sect)
 			continue;
 		overlap = true;
 		break;
@@ -592,7 +593,7 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 	mutex_lock_nested(&bdev->bd_mutex, 1);
 
 	ret = -EINVAL;
-	if (start != part->start_sect)
+	if (start != part->bdev->bd_start_sect)
 		goto out_unlock;
 
 	ret = -EBUSY;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 520011b95276fb..a690008f60cd92 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -20,6 +20,7 @@ typedef void (bio_end_io_t) (struct bio *);
 struct bio_crypt_ctx;
 
 struct block_device {
+	sector_t		bd_start_sect;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
 	dev_t			bd_dev;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 43a25d855e049a..619adea5709853 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1488,7 +1488,7 @@ static inline int bdev_alignment_offset(struct block_device *bdev)
 		return -1;
 	if (bdev_is_partition(bdev))
 		return queue_limit_alignment_offset(&q->limits,
-				bdev->bd_part->start_sect);
+				bdev->bd_start_sect);
 	return q->limits.alignment_offset;
 }
 
@@ -1529,7 +1529,7 @@ static inline int bdev_discard_alignment(struct block_device *bdev)
 
 	if (bdev_is_partition(bdev))
 		return queue_limit_discard_alignment(&q->limits,
-				bdev->bd_part->start_sect);
+				bdev->bd_start_sect);
 	return q->limits.discard_alignment;
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 804ac45fbfbc53..50d27f5d38e2af 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -51,7 +51,6 @@ struct partition_meta_info {
 };
 
 struct hd_struct {
-	sector_t start_sect;
 	struct percpu_ref ref;
 
 	struct block_device *bdev;
@@ -298,7 +297,7 @@ extern void rand_initialize_disk(struct gendisk *disk);
 
 static inline sector_t get_start_sect(struct block_device *bdev)
 {
-	return bdev->bd_part->start_sect;
+	return bdev->bd_start_sect;
 }
 
 static inline sector_t bdev_nr_sectors(struct block_device *bdev)
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7076d588a50d69..8a723a91ec5a06 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -458,14 +458,9 @@ static struct rchan_callbacks blk_relay_callbacks = {
 static void blk_trace_setup_lba(struct blk_trace *bt,
 				struct block_device *bdev)
 {
-	struct hd_struct *part = NULL;
-
-	if (bdev)
-		part = bdev->bd_part;
-
-	if (part) {
-		bt->start_lba = part->start_sect;
-		bt->end_lba = part->start_sect + bdev_nr_sectors(bdev);
+	if (bdev) {
+		bt->start_lba = bdev->bd_start_sect;
+		bt->end_lba = bdev->bd_start_sect + bdev_nr_sectors(bdev);
 	} else {
 		bt->start_lba = 0;
 		bt->end_lba = -1ULL;
-- 
2.29.2

