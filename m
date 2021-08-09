Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9853E476B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 16:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhHIOWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhHIOWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:22:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D54C0613D3;
        Mon,  9 Aug 2021 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cx20kliwfg2q0jiwTTflF5MkZZxEomotsS24I2QDDN0=; b=OE+mAWhVjo2613HZ1IHqJa/cuN
        SLahRNhr9u17HjnB2V38+8DvFiiLztDsQ01rUuUqsQshrnv81zeEG8g+H1kT1McLkfW2kLGYiAaf4
        F2HlfNdSl/I7dXpOko7QAWmgOsFy8bGQN1/qdws+YeYXuBnjs6vi0ZfbFecrdmusI29IYLrK6mCl8
        93nB9iGHjKm00P1GJLzI0fO+DrCc2uSiws0b+lQThO5P57M82KR0FjwHqlvFbEotRabwdRgq2cEwf
        8YkP9wZDIXHe48Nj6miyv4JrQgOoGAmCk92842wiFsShmx8w7PeJOx1JJ31gKOHAqD4U/EjBb+um3
        CT389pCg==;
Received: from [2001:4bb8:184:6215:d19a:ace4:57f0:d5ad] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD68p-00B4Ca-Jq; Mon, 09 Aug 2021 14:21:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 4/5] block: move the bdi from the request_queue to the gendisk
Date:   Mon,  9 Aug 2021 16:17:43 +0200
Message-Id: <20210809141744.1203023-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809141744.1203023-1-hch@lst.de>
References: <20210809141744.1203023-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The backing device information only makes sense for file system I/O,
and thus belongs into the gendisk and not the lower level request_queue
structure.  Move it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c           |  4 ++--
 block/blk-cgroup.c            |  7 +++----
 block/blk-core.c              | 13 +++----------
 block/blk-mq.c                |  2 +-
 block/blk-settings.c          | 14 +++++++++-----
 block/blk-sysfs.c             | 26 ++++++++++++--------------
 block/blk-wbt.c               | 10 +++++-----
 block/genhd.c                 | 23 ++++++++++++++---------
 drivers/block/drbd/drbd_req.c |  5 ++---
 drivers/block/pktcdvd.c       |  8 +++-----
 fs/block_dev.c                |  4 ++--
 fs/fat/fatent.c               |  1 +
 include/linux/blkdev.h        |  3 ---
 include/linux/genhd.h         |  1 +
 14 files changed, 58 insertions(+), 63 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 727955918563..1576e858d3a5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5266,8 +5266,8 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	switch (ioprio_class) {
 	default:
 		pr_err("bdi %s: bfq: bad prio class %d\n",
-				bdi_dev_name(bfqq->bfqd->queue->backing_dev_info),
-				ioprio_class);
+			bdi_dev_name(queue_to_disk(bfqq->bfqd->queue)->bdi),
+			ioprio_class);
 		fallthrough;
 	case IOPRIO_CLASS_NONE:
 		/*
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 575d7a2e7203..db034e35ae20 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -489,10 +489,9 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 
 const char *blkg_dev_name(struct blkcg_gq *blkg)
 {
-	/* some drivers (floppy) instantiate a queue w/o disk registered */
-	if (blkg->q->backing_dev_info->dev)
-		return bdi_dev_name(blkg->q->backing_dev_info);
-	return NULL;
+	if (!queue_has_disk(blkg->q) || !queue_to_disk(blkg->q)->bdi->dev)
+		return NULL;
+	return bdi_dev_name(queue_to_disk(blkg->q)->bdi);
 }
 
 /**
diff --git a/block/blk-core.c b/block/blk-core.c
index 5897bc37467d..0874bc2fcdb4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -14,7 +14,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/backing-dev.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
@@ -531,13 +530,9 @@ struct request_queue *blk_alloc_queue(int node_id)
 	if (ret)
 		goto fail_id;
 
-	q->backing_dev_info = bdi_alloc(node_id);
-	if (!q->backing_dev_info)
-		goto fail_split;
-
 	q->stats = blk_alloc_queue_stats();
 	if (!q->stats)
-		goto fail_stats;
+		goto fail_split;
 
 	q->node = node_id;
 
@@ -567,7 +562,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	if (percpu_ref_init(&q->q_usage_counter,
 				blk_queue_usage_counter_release,
 				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))
-		goto fail_bdi;
+		goto fail_stats;
 
 	if (blkcg_init_queue(q))
 		goto fail_ref;
@@ -580,10 +575,8 @@ struct request_queue *blk_alloc_queue(int node_id)
 
 fail_ref:
 	percpu_ref_exit(&q->q_usage_counter);
-fail_bdi:
-	blk_free_queue_stats(q->stats);
 fail_stats:
-	bdi_put(q->backing_dev_info);
+	blk_free_queue_stats(q->stats);
 fail_split:
 	bioset_exit(&q->bio_split);
 fail_id:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c4ac51e54eb..d2725f94491d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -525,7 +525,7 @@ void blk_mq_free_request(struct request *rq)
 		__blk_mq_dec_active_requests(hctx);
 
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
-		laptop_io_completion(q->backing_dev_info);
+		laptop_io_completion(queue_to_disk(q)->bdi);
 
 	rq_qos_done(q, rq);
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 44aaef9bf736..3613d2cc0688 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -8,6 +8,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/pagemap.h>
+#include <linux/backing-dev-defs.h>
 #include <linux/gcd.h>
 #include <linux/lcm.h>
 #include <linux/jiffies.h>
@@ -140,7 +141,9 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors = max_sectors;
 
-	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
+	if (!queue_has_disk(q))
+		return;
+	queue_to_disk(q)->bdi->io_pages = max_sectors >> (PAGE_SHIFT - 9);
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
 
@@ -388,10 +391,9 @@ void disk_update_readahead(struct gendisk *disk)
 	 * For read-ahead of large files to be effective, we need to read ahead
 	 * at least twice the optimal I/O size.
 	 */
-	q->backing_dev_info->ra_pages =
+	disk->bdi->ra_pages =
 		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
-	q->backing_dev_info->io_pages =
-		queue_max_sectors(q) >> (PAGE_SHIFT - 9);
+	disk->bdi->io_pages = queue_max_sectors(q) >> (PAGE_SHIFT - 9);
 }
 EXPORT_SYMBOL_GPL(disk_update_readahead);
 
@@ -473,7 +475,9 @@ EXPORT_SYMBOL(blk_limits_io_opt);
 void blk_queue_io_opt(struct request_queue *q, unsigned int opt)
 {
 	blk_limits_io_opt(&q->limits, opt);
-	q->backing_dev_info->ra_pages =
+	if (!queue_has_disk(q))
+		return;
+	queue_to_disk(q)->bdi->ra_pages =
 		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
 }
 EXPORT_SYMBOL(blk_queue_io_opt);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 3af2ab7d5086..1832587dce3a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -88,9 +88,11 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
 
 static ssize_t queue_ra_show(struct request_queue *q, char *page)
 {
-	unsigned long ra_kb = q->backing_dev_info->ra_pages <<
-					(PAGE_SHIFT - 10);
+	unsigned long ra_kb;
 
+	if (!queue_has_disk(q))
+		return -EINVAL;
+	ra_kb = queue_to_disk(q)->bdi->ra_pages << (PAGE_SHIFT - 10);
 	return queue_var_show(ra_kb, page);
 }
 
@@ -98,13 +100,14 @@ static ssize_t
 queue_ra_store(struct request_queue *q, const char *page, size_t count)
 {
 	unsigned long ra_kb;
-	ssize_t ret = queue_var_store(&ra_kb, page, count);
+	ssize_t ret;
 
+	if (!queue_has_disk(q))
+		return -EINVAL;
+	ret = queue_var_store(&ra_kb, page, count);
 	if (ret < 0)
 		return ret;
-
-	q->backing_dev_info->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
-
+	queue_to_disk(q)->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
 	return ret;
 }
 
@@ -251,7 +254,9 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 
 	spin_lock_irq(&q->queue_lock);
 	q->limits.max_sectors = max_sectors_kb << 1;
-	q->backing_dev_info->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
+	if (queue_has_disk(q))
+		queue_to_disk(q)->bdi->io_pages =
+			max_sectors_kb >> (PAGE_SHIFT - 10);
 	spin_unlock_irq(&q->queue_lock);
 
 	return ret;
@@ -766,13 +771,6 @@ static void blk_exit_queue(struct request_queue *q)
 	 * e.g. blkcg_print_blkgs() to crash.
 	 */
 	blkcg_exit_queue(q);
-
-	/*
-	 * Since the cgroup code may dereference the @q->backing_dev_info
-	 * pointer, only decrease its reference count after having removed the
-	 * association with the block cgroup controller.
-	 */
-	bdi_put(q->backing_dev_info);
 }
 
 /**
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 3ed71b8da887..31086afaad9c 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -97,7 +97,7 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
  */
 static bool wb_recent_wait(struct rq_wb *rwb)
 {
-	struct bdi_writeback *wb = &rwb->rqos.q->backing_dev_info->wb;
+	struct bdi_writeback *wb = &queue_to_disk(rwb->rqos.q)->bdi->wb;
 
 	return time_before(jiffies, wb->dirty_sleep + HZ);
 }
@@ -234,7 +234,7 @@ enum {
 
 static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 {
-	struct backing_dev_info *bdi = rwb->rqos.q->backing_dev_info;
+	struct backing_dev_info *bdi = queue_to_disk(rwb->rqos.q)->bdi;
 	struct rq_depth *rqd = &rwb->rq_depth;
 	u64 thislat;
 
@@ -287,7 +287,7 @@ static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 
 static void rwb_trace_step(struct rq_wb *rwb, const char *msg)
 {
-	struct backing_dev_info *bdi = rwb->rqos.q->backing_dev_info;
+	struct backing_dev_info *bdi = queue_to_disk(rwb->rqos.q)->bdi;
 	struct rq_depth *rqd = &rwb->rq_depth;
 
 	trace_wbt_step(bdi, msg, rqd->scale_step, rwb->cur_win_nsec,
@@ -359,8 +359,8 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
 
 	status = latency_exceeded(rwb, cb->stat);
 
-	trace_wbt_timer(rwb->rqos.q->backing_dev_info, status, rqd->scale_step,
-			inflight);
+	trace_wbt_timer(queue_to_disk(rwb->rqos.q)->bdi, status,
+			rqd->scale_step, inflight);
 
 	/*
 	 * If we exceeded the latency target, step down. If we did not,
diff --git a/block/genhd.c b/block/genhd.c
index a4817e42f3a3..4b212a620941 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -456,10 +456,9 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 	dev_set_uevent_suppress(ddev, 0);
 	disk_uevent(disk, KOBJ_ADD);
 
-	if (disk->queue->backing_dev_info->dev) {
-		err = sysfs_create_link(&ddev->kobj,
-			  &disk->queue->backing_dev_info->dev->kobj,
-			  "bdi");
+	if (disk->bdi->dev) {
+		err = sysfs_create_link(&ddev->kobj, &disk->bdi->dev->kobj,
+					"bdi");
 		WARN_ON(err);
 	}
 }
@@ -531,15 +530,14 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	} else {
-		struct backing_dev_info *bdi = disk->queue->backing_dev_info;
 		struct device *dev = disk_to_dev(disk);
 
 		/* Register BDI before referencing it from bdev */
 		dev->devt = MKDEV(disk->major, disk->first_minor);
-		ret = bdi_register(bdi, "%u:%u",
+		ret = bdi_register(disk->bdi, "%u:%u",
 				   disk->major, disk->first_minor);
 		WARN_ON(ret);
-		bdi_set_owner(bdi, dev);
+		bdi_set_owner(disk->bdi, dev);
 		bdev_add(disk->part0, dev->devt);
 	}
 	register_disk(parent, disk, groups);
@@ -620,7 +618,7 @@ void del_gendisk(struct gendisk *disk)
 		 * Unregister bdi before releasing device numbers (as they can
 		 * get reused and we'd get clashes in sysfs).
 		 */
-		bdi_unregister(disk->queue->backing_dev_info);
+		bdi_unregister(disk->bdi);
 	}
 
 	blk_unregister_queue(disk);
@@ -1093,6 +1091,7 @@ static void disk_release(struct device *dev)
 
 	might_sleep();
 
+	bdi_put(disk->bdi);
 	if (MAJOR(dev->devt) == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(MINOR(dev->devt));
 	disk_release_events(disk);
@@ -1273,9 +1272,13 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	if (!disk)
 		return NULL;
 
+	disk->bdi = bdi_alloc(node_id);
+	if (!disk->bdi)
+		goto out_free_disk;
+
 	disk->part0 = bdev_alloc(disk, 0);
 	if (!disk->part0)
-		goto out_free_disk;
+		goto out_free_bdi;
 
 	disk->node_id = node_id;
 	mutex_init(&disk->open_mutex);
@@ -1295,6 +1298,8 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
 	iput(disk->part0->bd_inode);
+out_free_bdi:
+	bdi_put(disk->bdi);
 out_free_disk:
 	kfree(disk);
 	return NULL;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 13beb98a7c5a..5ca233644d70 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -905,13 +905,12 @@ static bool drbd_may_do_local_read(struct drbd_device *device, sector_t sector,
 static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t sector,
 		enum drbd_read_balancing rbm)
 {
-	struct backing_dev_info *bdi;
 	int stripe_shift;
 
 	switch (rbm) {
 	case RB_CONGESTED_REMOTE:
-		bdi = device->ldev->backing_bdev->bd_disk->queue->backing_dev_info;
-		return bdi_read_congested(bdi);
+		return bdi_read_congested(
+			device->ldev->backing_bdev->bd_disk->bdi);
 	case RB_LEAST_PENDING:
 		return atomic_read(&device->local_cnt) >
 			atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 538446b652de..0f26b2510a75 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1183,10 +1183,8 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	wakeup = (pd->write_congestion_on > 0
 	 		&& pd->bio_queue_size <= pd->write_congestion_off);
 	spin_unlock(&pd->lock);
-	if (wakeup) {
-		clear_bdi_congested(pd->disk->queue->backing_dev_info,
-					BLK_RW_ASYNC);
-	}
+	if (wakeup)
+		clear_bdi_congested(pd->disk->bdi, BLK_RW_ASYNC);
 
 	pkt->sleep_time = max(PACKET_WAIT_TIME, 1);
 	pkt_set_state(pkt, PACKET_WAITING_STATE);
@@ -2366,7 +2364,7 @@ static void pkt_make_request_write(struct request_queue *q, struct bio *bio)
 	spin_lock(&pd->lock);
 	if (pd->write_congestion_on > 0
 	    && pd->bio_queue_size >= pd->write_congestion_on) {
-		set_bdi_congested(q->backing_dev_info, BLK_RW_ASYNC);
+		set_bdi_congested(bio->bi_bdev->bd_disk->bdi, BLK_RW_ASYNC);
 		do {
 			spin_unlock(&pd->lock);
 			congestion_wait(BLK_RW_ASYNC, HZ);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6658f40ae492..de8c3d9cbdb1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1232,7 +1232,7 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 	if (!bdev->bd_openers) {
 		set_init_blocksize(bdev);
 		if (bdev->bd_bdi == &noop_backing_dev_info)
-			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
+			bdev->bd_bdi = bdi_get(disk->bdi);
 	}
 	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
 		bdev_disk_changed(disk, false);
@@ -1267,7 +1267,7 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 	disk->open_partitions++;
 	set_init_blocksize(part);
 	if (part->bd_bdi == &noop_backing_dev_info)
-		part->bd_bdi = bdi_get(disk->queue->backing_dev_info);
+		part->bd_bdi = bdi_get(disk->bdi);
 done:
 	part->bd_openers++;
 	return 0;
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 860e884e56e8..978ac6751aeb 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -5,6 +5,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/sched/signal.h>
+#include <linux/backing-dev-defs.h>
 #include "fat.h"
 
 struct fatent_operations {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 96f3d9617cd8..23e1253a8d88 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -11,7 +11,6 @@
 #include <linux/minmax.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
-#include <linux/backing-dev-defs.h>
 #include <linux/wait.h>
 #include <linux/mempool.h>
 #include <linux/pfn.h>
@@ -398,8 +397,6 @@ struct request_queue {
 	struct blk_mq_hw_ctx	**queue_hw_ctx;
 	unsigned int		nr_hw_queues;
 
-	struct backing_dev_info	*backing_dev_info;
-
 	/*
 	 * The queue owner gets to use this for whatever they like.
 	 * ll_rw_blk doesn't touch it.
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 849486de81c6..ef94b770d696 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -158,6 +158,7 @@ struct gendisk {
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
 
+	struct backing_dev_info	*bdi;
 	struct kobject *slave_dir;
 
 	struct timer_rand_state *random;
-- 
2.30.2

