Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A18225944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 09:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgGTHxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 03:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgGTHwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:52:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C419FC0619D2;
        Mon, 20 Jul 2020 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=E4ZiLQ1TqqknJUeMC3JgvLzT8XC1llQYxIpt4lcJDqs=; b=kW7KQ52fvCLMzGONer6niK2Grq
        vFtL8GXpMvmq0/vTZwKz+q/E+YwmxDXqFfwRaNXNp6wYHP/Eycm76yKTx3rrsFgWkub8GBmRenBA2
        /VUa9lEyQQbp/qWYf0olnsEw9L0jwXzwk3hyOr0F3d1/t1cHD27bQhV7NFiCXYbr0m+N/wieDV/H4
        S22P+huQQ2x4I/qg5CE+EhXthCbD7UOyiYzEAOFTjqABzFdajFHNf8EyYmi3bWEcEGLAn8nmUyxdo
        TzCfoIkElShDh41tje4Fj8S7uC9fk+NMestWRzCicg9LPClNEUaLs/KLWjTSNQIeJyNuW0Qs+/h7i
        xTv1h1Gg==;
Received: from [2001:4bb8:105:4a81:5185:88fc:94bb:f8bf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxQae-000416-BD; Mon, 20 Jul 2020 07:52:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: [PATCH 06/14] block: lift setting the readahead size into the block layer
Date:   Mon, 20 Jul 2020 09:51:40 +0200
Message-Id: <20200720075148.172156-7-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720075148.172156-1-hch@lst.de>
References: <20200720075148.172156-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drivers shouldn't really mess with the readahead size, as that is a VM
concept.  Instead set it based on the optimal I/O size by lifting the
algorithm from the md driver when registering the disk.  Also set
bdi->io_pages there as well by applying the same scheme based on
max_sectors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c         |  5 ++---
 block/blk-sysfs.c            |  1 -
 block/genhd.c                | 13 +++++++++++--
 drivers/block/aoe/aoeblk.c   |  2 --
 drivers/block/drbd/drbd_nl.c | 12 +-----------
 drivers/md/bcache/super.c    |  4 ----
 drivers/md/dm-table.c        |  3 ---
 drivers/md/raid0.c           | 16 ----------------
 drivers/md/raid10.c          | 24 +-----------------------
 drivers/md/raid5.c           | 13 +------------
 10 files changed, 16 insertions(+), 77 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 76a7e03bcd6cac..01049e9b998f1d 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -452,6 +452,8 @@ EXPORT_SYMBOL(blk_limits_io_opt);
 void blk_queue_io_opt(struct request_queue *q, unsigned int opt)
 {
 	blk_limits_io_opt(&q->limits, opt);
+	q->backing_dev_info->ra_pages =
+		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
 }
 EXPORT_SYMBOL(blk_queue_io_opt);
 
@@ -628,9 +630,6 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 		printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
 		       top, bottom);
 	}
-
-	t->backing_dev_info->io_pages =
-		t->limits.max_sectors >> (PAGE_SHIFT - 9);
 }
 EXPORT_SYMBOL(disk_stack_limits);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index be67952e7be229..d7cf560efa92e5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -245,7 +245,6 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 
 	spin_lock_irq(&q->queue_lock);
 	q->limits.max_sectors = max_sectors_kb << 1;
-	q->backing_dev_info->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
 	spin_unlock_irq(&q->queue_lock);
 
 	return ret;
diff --git a/block/genhd.c b/block/genhd.c
index 8b1e9f48957cb5..097d4e4bc0b8a2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -775,6 +775,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 			      const struct attribute_group **groups,
 			      bool register_queue)
 {
+	struct request_queue *q = disk->queue;
 	dev_t devt;
 	int retval;
 
@@ -785,7 +786,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 * registration.
 	 */
 	if (register_queue)
-		elevator_init_mq(disk->queue);
+		elevator_init_mq(q);
 
 	/* minors == 0 indicates to use ext devt from part0 and should
 	 * be accompanied with EXT_DEVT flag.  Make sure all
@@ -815,10 +816,18 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	} else {
-		struct backing_dev_info *bdi = disk->queue->backing_dev_info;
+		struct backing_dev_info *bdi = q->backing_dev_info;
 		struct device *dev = disk_to_dev(disk);
 		int ret;
 
+		/*
+		 * For read-ahead of large files to be effective, we need to
+		 * readahead at least twice the optimal I/O size.
+		 */
+		bdi->ra_pages = max(queue_io_opt(q) * 2 / PAGE_SIZE,
+				    VM_READAHEAD_PAGES);
+		bdi->io_pages = queue_max_sectors(q) >> (PAGE_SHIFT - 9);
+
 		/* Register BDI before referencing it from bdev */
 		dev->devt = devt;
 		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 5ca7216e9e01f3..89b33b402b4e52 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -347,7 +347,6 @@ aoeblk_gdalloc(void *vp)
 	mempool_t *mp;
 	struct request_queue *q;
 	struct blk_mq_tag_set *set;
-	enum { KB = 1024, MB = KB * KB, READ_AHEAD = 2 * MB, };
 	ulong flags;
 	int late = 0;
 	int err;
@@ -407,7 +406,6 @@ aoeblk_gdalloc(void *vp)
 	WARN_ON(d->gd);
 	WARN_ON(d->flags & DEVFL_UP);
 	blk_queue_max_hw_sectors(q, BLK_DEF_MAX_SECTORS);
-	q->backing_dev_info->ra_pages = READ_AHEAD / PAGE_SIZE;
 	d->bufpool = mp;
 	d->blkq = gd->queue = q;
 	q->queuedata = d;
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 650372ee2c7822..212bf711fb6b41 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1360,18 +1360,8 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	decide_on_discard_support(device, q, b, discard_zeroes_if_aligned);
 	decide_on_write_same_support(device, q, b, o, disable_write_same);
 
-	if (b) {
+	if (b)
 		blk_stack_limits(&q->limits, &b->limits, 0);
-
-		if (q->backing_dev_info->ra_pages !=
-		    b->backing_dev_info->ra_pages) {
-			drbd_info(device, "Adjusting my ra_pages to backing device's (%lu -> %lu)\n",
-				 q->backing_dev_info->ra_pages,
-				 b->backing_dev_info->ra_pages);
-			q->backing_dev_info->ra_pages =
-						b->backing_dev_info->ra_pages;
-		}
-	}
 	fixup_discard_if_not_supported(q);
 	fixup_write_zeroes(device, q);
 }
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 9e45faa054b6f4..9d3f0711be030f 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1367,10 +1367,6 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 	if (ret)
 		return ret;
 
-	dc->disk.disk->queue->backing_dev_info->ra_pages =
-		max(dc->disk.disk->queue->backing_dev_info->ra_pages,
-		    q->backing_dev_info->ra_pages);
-
 	atomic_set(&dc->io_errors, 0);
 	dc->io_disable = false;
 	dc->error_limit = DEFAULT_CACHED_DEV_ERROR_LIMIT;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index aac4c31cfc8498..324a42ed2f8894 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1924,9 +1924,6 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		q->nr_zones = blkdev_nr_zones(t->md->disk);
 	}
 #endif
-
-	/* Allow reads to exceed readahead limits */
-	q->backing_dev_info->io_pages = limits->max_sectors >> (PAGE_SHIFT - 9);
 }
 
 unsigned int dm_table_get_num_targets(struct dm_table *t)
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f54a449f97aa79..aa2d7279176880 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -410,22 +410,6 @@ static int raid0_run(struct mddev *mddev)
 		 mdname(mddev),
 		 (unsigned long long)mddev->array_sectors);
 
-	if (mddev->queue) {
-		/* calculate the max read-ahead size.
-		 * For read-ahead of large files to be effective, we need to
-		 * readahead at least twice a whole stripe. i.e. number of devices
-		 * multiplied by chunk size times 2.
-		 * If an individual device has an ra_pages greater than the
-		 * chunk size, then we will not drive that device as hard as it
-		 * wants.  We consider this a configuration error: a larger
-		 * chunksize should be used in that case.
-		 */
-		int stripe = mddev->raid_disks *
-			(mddev->chunk_sectors << 9) / PAGE_SIZE;
-		if (mddev->queue->backing_dev_info->ra_pages < 2* stripe)
-			mddev->queue->backing_dev_info->ra_pages = 2* stripe;
-	}
-
 	dump_zones(mddev);
 
 	ret = md_integrity_register(mddev);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 552ee0058c118d..67a15a49722f28 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3865,19 +3865,6 @@ static int raid10_run(struct mddev *mddev)
 	mddev->resync_max_sectors = size;
 	set_bit(MD_FAILFAST_SUPPORTED, &mddev->flags);
 
-	if (mddev->queue) {
-		int stripe = conf->geo.raid_disks *
-			((mddev->chunk_sectors << 9) / PAGE_SIZE);
-
-		/* Calculate max read-ahead size.
-		 * We need to readahead at least twice a whole stripe....
-		 * maybe...
-		 */
-		stripe /= conf->geo.near_copies;
-		if (mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
-			mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
-	}
-
 	if (md_integrity_register(mddev))
 		goto out_free_conf;
 
@@ -4715,17 +4702,8 @@ static void end_reshape(struct r10conf *conf)
 	conf->reshape_safe = MaxSector;
 	spin_unlock_irq(&conf->device_lock);
 
-	/* read-ahead size must cover two whole stripes, which is
-	 * 2 * (datadisks) * chunksize where 'n' is the number of raid devices
-	 */
-	if (conf->mddev->queue) {
-		int stripe = conf->geo.raid_disks *
-			((conf->mddev->chunk_sectors << 9) / PAGE_SIZE);
-		stripe /= conf->geo.near_copies;
-		if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
-			conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
+	if (conf->mddev->queue)
 		raid10_set_io_opt(conf);
-	}
 	conf->fullsync = 0;
 }
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f571b0eb5ec824..b70f7648140195 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7413,8 +7413,6 @@ static int raid5_run(struct mddev *mddev)
 		int data_disks = conf->previous_raid_disks - conf->max_degraded;
 		int stripe = data_disks *
 			((mddev->chunk_sectors << 9) / PAGE_SIZE);
-		if (mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
-			mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
 
 		chunk_size = mddev->chunk_sectors << 9;
 		blk_queue_io_min(mddev->queue, chunk_size);
@@ -8002,17 +8000,8 @@ static void end_reshape(struct r5conf *conf)
 		spin_unlock_irq(&conf->device_lock);
 		wake_up(&conf->wait_for_overlap);
 
-		/* read-ahead size must cover two whole stripes, which is
-		 * 2 * (datadisks) * chunksize where 'n' is the number of raid devices
-		 */
-		if (conf->mddev->queue) {
-			int data_disks = conf->raid_disks - conf->max_degraded;
-			int stripe = data_disks * ((conf->chunk_sectors << 9)
-						   / PAGE_SIZE);
-			if (conf->mddev->queue->backing_dev_info->ra_pages < 2 * stripe)
-				conf->mddev->queue->backing_dev_info->ra_pages = 2 * stripe;
+		if (conf->mddev->queue)
 			raid5_set_io_opt(conf);
-		}
 	}
 }
 
-- 
2.27.0

