Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6AF2B793B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKRIsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgKRIsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AEDC0613D4;
        Wed, 18 Nov 2020 00:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1HqksWkdy5TD5089kbgpLkdwQc0zqxN82ofqJmKnirc=; b=AHXQG/U4KR4qNzMpNSog6V51VV
        wjsi6n9xcpEeqZn/MMB04HP7tR0A8r44SrdkbUxHgMsa5f+/JAaCbglIjKO+SZPbTwLg6pXB882m9
        HOB1Rxb+CCdSeIIDG5HBlR1+Myb+be9Ch4lRIFPc18cX6Xn/zhfrXY7vIcMrmimE0DauKF2Nyl20m
        T0Yc/5ZrOWFuiQZGpMUegLN1ASO8fwh5Nixfks4FyeA84jgEcpaUR6SVVxlriPIhzV8cfEaANYv9y
        S9QIVWOcJtgL3JDV3ADDxRC/UNWlgqr9M4CtBGqHuiQ7nA1DLO9ChILAstf7zOE7tWWUMnn7+8GeW
        nuyGqKxg==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8d-0007ni-3J; Wed, 18 Nov 2020 08:48:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 15/20] block: merge struct block_device and struct hd_struct
Date:   Wed, 18 Nov 2020 09:47:55 +0100
Message-Id: <20201118084800.2339180-16-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of having two structures that represent each block device with
different lift time rules merged them into a single one.  This also
greatly simplifies the reference counting rules, as we can use the inode
reference count as the main reference count for the new struct
block_device, with the device model reference front ending it for device
model interaction.  The percpu refcount in struct hd_struct is entirely
gone given that struct block_device must be opened and thus valid for
the duration of the I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                        |   6 +-
 block/blk-cgroup.c                 |   9 +-
 block/blk-core.c                   |  85 +++++-----
 block/blk-flush.c                  |   2 +-
 block/blk-lib.c                    |   2 +-
 block/blk-merge.c                  |   6 +-
 block/blk-mq.c                     |  11 +-
 block/blk-mq.h                     |   5 +-
 block/blk.h                        |  39 ++---
 block/genhd.c                      | 240 +++++++++++------------------
 block/ioctl.c                      |   4 +-
 block/partitions/core.c            | 221 ++++++++------------------
 drivers/block/drbd/drbd_receiver.c |   2 +-
 drivers/block/drbd/drbd_worker.c   |   2 +-
 drivers/block/zram/zram_drv.c      |   2 +-
 drivers/md/bcache/request.c        |   4 +-
 drivers/md/dm.c                    |   8 +-
 drivers/md/md.c                    |   4 +-
 drivers/nvme/target/admin-cmd.c    |  20 +--
 drivers/s390/block/dasd.c          |   8 +-
 fs/block_dev.c                     |  77 ++++-----
 fs/ext4/super.c                    |  18 +--
 fs/ext4/sysfs.c                    |  10 +-
 fs/f2fs/checkpoint.c               |   5 +-
 fs/f2fs/f2fs.h                     |   2 +-
 fs/f2fs/super.c                    |   6 +-
 fs/f2fs/sysfs.c                    |   9 --
 include/linux/blk_types.h          |  23 ++-
 include/linux/blkdev.h             |  13 +-
 include/linux/genhd.h              |  67 ++------
 include/linux/part_stat.h          |  17 +-
 init/do_mounts.c                   |  20 +--
 kernel/trace/blktrace.c            |  54 ++-----
 33 files changed, 362 insertions(+), 639 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0c5269997434d6..4df1ecd53baf8f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -608,12 +608,12 @@ void bio_truncate(struct bio *bio, unsigned new_size)
 void guard_bio_eod(struct bio *bio)
 {
 	sector_t maxsector;
-	struct hd_struct *part;
+	struct block_device *part;
 
 	rcu_read_lock();
-	part = __disk_get_part(bio->bi_disk, bio->bi_partno);
+	part = __bdget_disk(bio->bi_disk, bio->bi_partno);
 	if (part)
-		maxsector = bdev_nr_sectors(part->bdev);
+		maxsector = bdev_nr_sectors(part);
 	else
 		maxsector = get_capacity(bio->bi_disk);
 	rcu_read_unlock();
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4c0ae0f6bce02d..fb5076223f10f2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -820,9 +820,9 @@ static void blkcg_fill_root_iostats(void)
 
 	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
 	while ((dev = class_dev_iter_next(&iter))) {
-		struct gendisk *disk = dev_to_disk(dev);
-		struct hd_struct *part = disk_get_part(disk, 0);
-		struct blkcg_gq *blkg = blk_queue_root_blkg(disk->queue);
+		struct block_device *bdev = dev_to_bdev(dev);
+		struct blkcg_gq *blkg =
+			blk_queue_root_blkg(bdev->bd_disk->queue);
 		struct blkg_iostat tmp;
 		int cpu;
 
@@ -830,7 +830,7 @@ static void blkcg_fill_root_iostats(void)
 		for_each_possible_cpu(cpu) {
 			struct disk_stats *cpu_dkstats;
 
-			cpu_dkstats = per_cpu_ptr(part->dkstats, cpu);
+			cpu_dkstats = per_cpu_ptr(bdev->bd_stats, cpu);
 			tmp.ios[BLKG_IOSTAT_READ] +=
 				cpu_dkstats->ios[STAT_READ];
 			tmp.ios[BLKG_IOSTAT_WRITE] +=
@@ -849,7 +849,6 @@ static void blkcg_fill_root_iostats(void)
 			blkg_iostat_set(&blkg->iostat.cur, &tmp);
 			u64_stats_update_end(&blkg->iostat.sync);
 		}
-		disk_put_part(part);
 	}
 }
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 988f45094a387b..192607c98e87c5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -119,7 +119,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->tag = BLK_MQ_NO_TAG;
 	rq->internal_tag = BLK_MQ_NO_TAG;
 	rq->start_time_ns = ktime_get_ns();
-	rq->part = NULL;
+	rq->bdev = NULL;
 	refcount_set(&rq->ref, 1);
 	blk_crypto_rq_set_defaults(rq);
 }
@@ -666,9 +666,9 @@ static int __init setup_fail_make_request(char *str)
 }
 __setup("fail_make_request=", setup_fail_make_request);
 
-static bool should_fail_request(struct hd_struct *part, unsigned int bytes)
+static bool should_fail_request(struct block_device *bdev, unsigned int bytes)
 {
-	return part->make_it_fail && should_fail(&fail_make_request, bytes);
+	return bdev->bd_make_it_fail && should_fail(&fail_make_request, bytes);
 }
 
 static int __init fail_make_request_debugfs(void)
@@ -683,19 +683,19 @@ late_initcall(fail_make_request_debugfs);
 
 #else /* CONFIG_FAIL_MAKE_REQUEST */
 
-static inline bool should_fail_request(struct hd_struct *part,
-					unsigned int bytes)
+static inline bool should_fail_request(struct block_device *bdev,
+		unsigned int bytes)
 {
 	return false;
 }
 
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
-static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
+static inline bool bio_check_ro(struct bio *bio, struct block_device *bdev)
 {
 	const int op = bio_op(bio);
 
-	if (part->policy && op_is_write(op)) {
+	if (bdev->bd_policy && op_is_write(op)) {
 		char b[BDEVNAME_SIZE];
 
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
@@ -703,7 +703,7 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 
 		WARN_ONCE(1,
 		       "Trying to write to read-only block-device %s (partno %d)\n",
-			bio_devname(bio, b), part->partno);
+			bio_devname(bio, b), bdev->bd_partno);
 		/* Older lvm-tools actually trigger this */
 		return false;
 	}
@@ -713,7 +713,7 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 
 static noinline int should_fail_bio(struct bio *bio)
 {
-	if (should_fail_request(&bio->bi_disk->part0, bio->bi_iter.bi_size))
+	if (should_fail_request(bio->bi_disk->part0, bio->bi_iter.bi_size))
 		return -EIO;
 	return 0;
 }
@@ -742,11 +742,11 @@ static inline int bio_check_eod(struct bio *bio, sector_t maxsector)
  */
 static inline int blk_partition_remap(struct bio *bio)
 {
-	struct hd_struct *p;
+	struct block_device *p;
 	int ret = -EIO;
 
 	rcu_read_lock();
-	p = __disk_get_part(bio->bi_disk, bio->bi_partno);
+	p = __bdget_disk(bio->bi_disk, bio->bi_partno);
 	if (unlikely(!p))
 		goto out;
 	if (unlikely(should_fail_request(p, bio->bi_iter.bi_size)))
@@ -755,11 +755,11 @@ static inline int blk_partition_remap(struct bio *bio)
 		goto out;
 
 	if (bio_sectors(bio)) {
-		if (bio_check_eod(bio, bdev_nr_sectors(p->bdev)))
+		if (bio_check_eod(bio, bdev_nr_sectors(p)))
 			goto out;
-		bio->bi_iter.bi_sector += p->start_sect;
-		trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
-				      bio->bi_iter.bi_sector - p->start_sect);
+		bio->bi_iter.bi_sector += p->bd_start_sect;
+		trace_block_bio_remap(bio->bi_disk->queue, bio, p->bd_dev,
+				      bio->bi_iter.bi_sector - p->bd_start_sect);
 	}
 	bio->bi_partno = 0;
 	ret = 0;
@@ -829,7 +829,7 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		if (unlikely(blk_partition_remap(bio)))
 			goto end_io;
 	} else {
-		if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))
+		if (unlikely(bio_check_ro(bio, bio->bi_disk->part0)))
 			goto end_io;
 		if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))
 			goto end_io;
@@ -1201,7 +1201,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		return ret;
 
 	if (rq->rq_disk &&
-	    should_fail_request(&rq->rq_disk->part0, blk_rq_bytes(rq)))
+	    should_fail_request(rq->rq_disk->part0, blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
 
 	if (blk_crypto_insert_cloned_request(rq))
@@ -1260,30 +1260,29 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
 
-static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
+static void update_io_ticks(struct block_device *part, unsigned long now,
+		bool end)
 {
 	unsigned long stamp;
 again:
-	stamp = READ_ONCE(part->stamp);
+	stamp = READ_ONCE(part->bd_stamp);
 	if (unlikely(stamp != now)) {
-		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
+		if (likely(cmpxchg(&part->bd_stamp, stamp, now) == stamp))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
-	if (part->partno) {
-		part = &part_to_disk(part)->part0;
+	if (part->bd_partno) {
+		part = part->bd_disk->part0;
 		goto again;
 	}
 }
 
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
-	if (req->part && blk_do_io_stat(req)) {
+	if (req->bdev && blk_do_io_stat(req)) {
 		const int sgrp = op_stat_group(req_op(req));
-		struct hd_struct *part;
 
 		part_stat_lock();
-		part = req->part;
-		part_stat_add(part, sectors[sgrp], bytes >> 9);
+		part_stat_add(req->bdev, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
 }
@@ -1295,20 +1294,15 @@ void blk_account_io_done(struct request *req, u64 now)
 	 * normal IO on queueing nor completion.  Accounting the
 	 * containing request is enough.
 	 */
-	if (req->part && blk_do_io_stat(req) &&
+	if (req->bdev && blk_do_io_stat(req) &&
 	    !(req->rq_flags & RQF_FLUSH_SEQ)) {
 		const int sgrp = op_stat_group(req_op(req));
-		struct hd_struct *part;
 
 		part_stat_lock();
-		part = req->part;
-
-		update_io_ticks(part, jiffies, true);
-		part_stat_inc(part, ios[sgrp]);
-		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
+		update_io_ticks(req->bdev, jiffies, true);
+		part_stat_inc(req->bdev, ios[sgrp]);
+		part_stat_add(req->bdev, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
-
-		hd_struct_put(part);
 	}
 }
 
@@ -1317,15 +1311,15 @@ void blk_account_io_start(struct request *rq)
 	if (!blk_do_io_stat(rq))
 		return;
 
-	rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
+	rq->bdev = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
 
 	part_stat_lock();
-	update_io_ticks(rq->part, jiffies, false);
+	update_io_ticks(rq->bdev, jiffies, false);
 	part_stat_unlock();
 }
 
-static unsigned long __part_start_io_acct(struct hd_struct *part,
-					  unsigned int sectors, unsigned int op)
+static unsigned long __part_start_io_acct(struct block_device *part,
+		unsigned int sectors, unsigned int op)
 {
 	const int sgrp = op_stat_group(op);
 	unsigned long now = READ_ONCE(jiffies);
@@ -1340,8 +1334,8 @@ static unsigned long __part_start_io_acct(struct hd_struct *part,
 	return now;
 }
 
-unsigned long part_start_io_acct(struct gendisk *disk, struct hd_struct **part,
-				 struct bio *bio)
+unsigned long part_start_io_acct(struct gendisk *disk,
+		struct block_device **part, struct bio *bio)
 {
 	*part = disk_map_sector_rcu(disk, bio->bi_iter.bi_sector);
 
@@ -1352,11 +1346,11 @@ EXPORT_SYMBOL_GPL(part_start_io_acct);
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 				 unsigned int op)
 {
-	return __part_start_io_acct(&disk->part0, sectors, op);
+	return __part_start_io_acct(disk->part0, sectors, op);
 }
 EXPORT_SYMBOL(disk_start_io_acct);
 
-static void __part_end_io_acct(struct hd_struct *part, unsigned int op,
+static void __part_end_io_acct(struct block_device *part, unsigned int op,
 			       unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
@@ -1370,18 +1364,17 @@ static void __part_end_io_acct(struct hd_struct *part, unsigned int op,
 	part_stat_unlock();
 }
 
-void part_end_io_acct(struct hd_struct *part, struct bio *bio,
+void part_end_io_acct(struct block_device *part, struct bio *bio,
 		      unsigned long start_time)
 {
 	__part_end_io_acct(part, bio_op(bio), start_time);
-	hd_struct_put(part);
 }
 EXPORT_SYMBOL_GPL(part_end_io_acct);
 
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 		      unsigned long start_time)
 {
-	__part_end_io_acct(&disk->part0, op, start_time);
+	__part_end_io_acct(disk->part0, op, start_time);
 }
 EXPORT_SYMBOL(disk_end_io_acct);
 
diff --git a/block/blk-flush.c b/block/blk-flush.c
index e32958f0b68750..9507dcdd58814c 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -139,7 +139,7 @@ static void blk_flush_queue_rq(struct request *rq, bool add_front)
 
 static void blk_account_io_flush(struct request *rq)
 {
-	struct hd_struct *part = &rq->rq_disk->part0;
+	struct block_device *part = rq->rq_disk->part0;
 
 	part_stat_lock();
 	part_stat_inc(part, ios[STAT_FLUSH]);
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
diff --git a/block/blk-merge.c b/block/blk-merge.c
index bcf5e458060337..3ec0d322e4a769 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -681,10 +681,8 @@ static void blk_account_io_merge_request(struct request *req)
 {
 	if (blk_do_io_stat(req)) {
 		part_stat_lock();
-		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+		part_stat_inc(req->bdev, merges[op_stat_group(req_op(req))]);
 		part_stat_unlock();
-
-		hd_struct_put(req->part);
 	}
 }
 
@@ -906,7 +904,7 @@ static void blk_account_io_merge_bio(struct request *req)
 		return;
 
 	part_stat_lock();
-	part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+	part_stat_inc(req->bdev, merges[op_stat_group(req_op(req))]);
 	part_stat_unlock();
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc0320c..a28475e6405de9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -95,7 +95,7 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 }
 
 struct mq_inflight {
-	struct hd_struct *part;
+	struct block_device *part;
 	unsigned int inflight[2];
 };
 
@@ -105,13 +105,14 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	if (rq->part == mi->part && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
+	if (rq->bdev == mi->part && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
 
 	return true;
 }
 
-unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
+unsigned int blk_mq_in_flight(struct request_queue *q,
+		struct block_device *part)
 {
 	struct mq_inflight mi = { .part = part };
 
@@ -120,7 +121,7 @@ unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
 	return mi.inflight[0] + mi.inflight[1];
 }
 
-void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 			 unsigned int inflight[2])
 {
 	struct mq_inflight mi = { .part = part };
@@ -300,7 +301,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->rq_disk = NULL;
-	rq->part = NULL;
+	rq->bdev = NULL;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
 	rq->alloc_time_ns = alloc_time_ns;
 #endif
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a52703c98b7736..395fbc6c59d1eb 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -182,8 +182,9 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
-unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
-void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+unsigned int blk_mq_in_flight(struct request_queue *q,
+		struct block_device *bdev);
+void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *bdev,
 			 unsigned int inflight[2]);
 
 static inline void blk_mq_put_dispatch_budget(struct request_queue *q)
diff --git a/block/blk.h b/block/blk.h
index 09cee7024fb43e..90dd2047c6cd29 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -215,7 +215,15 @@ static inline void elevator_exit(struct request_queue *q,
 	__elevator_exit(q, e);
 }
 
-struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
+static inline struct block_device *__bdget_disk(struct gendisk *disk,
+		int partno)
+{
+	struct disk_part_tbl *ptbl = rcu_dereference(disk->part_tbl);
+
+	if (unlikely(partno < 0 || partno >= ptbl->len))
+		return NULL;
+	return rcu_dereference(ptbl->part[partno]);
+}
 
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
@@ -348,44 +356,21 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q);
 static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
 #endif
 
-struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
+struct block_device *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
 
-int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
+int blk_alloc_devt(struct block_device *bdev, dev_t *devt);
 void blk_free_devt(dev_t devt);
 char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
-void delete_partition(struct hd_struct *part);
+void delete_partition(struct block_device *part);
 int bdev_add_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 int bdev_del_partition(struct block_device *bdev, int partno);
 int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 int disk_expand_part_tbl(struct gendisk *disk, int target);
-int hd_ref_init(struct hd_struct *part);
-
-/* no need to get/put refcount of part0 */
-static inline int hd_struct_try_get(struct hd_struct *part)
-{
-	if (part->partno)
-		return percpu_ref_tryget_live(&part->ref);
-	return 1;
-}
-
-static inline void hd_struct_put(struct hd_struct *part)
-{
-	if (part->partno)
-		percpu_ref_put(&part->ref);
-}
-
-static inline void hd_free_part(struct hd_struct *part)
-{
-	free_percpu(part->dkstats);
-	kfree(part->info);
-	bdput(part->bdev);
-	percpu_ref_exit(&part->ref);
-}
 
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
diff --git a/block/genhd.c b/block/genhd.c
index e101b6843f7437..a14e2408e3d4e8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -40,7 +40,7 @@ static void disk_release_events(struct gendisk *disk);
 
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
-	struct block_device *bdev = disk->part0.bdev;
+	struct block_device *bdev = disk->part0;
 
 	spin_lock(&bdev->bd_size_lock);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
@@ -93,13 +93,14 @@ const char *bdevname(struct block_device *bdev, char *buf)
 }
 EXPORT_SYMBOL(bdevname);
 
-static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
+static void part_stat_read_all(struct block_device *part,
+		struct disk_stats *stat)
 {
 	int cpu;
 
 	memset(stat, 0, sizeof(struct disk_stats));
 	for_each_possible_cpu(cpu) {
-		struct disk_stats *ptr = per_cpu_ptr(part->dkstats, cpu);
+		struct disk_stats *ptr = per_cpu_ptr(part->bd_stats, cpu);
 		int group;
 
 		for (group = 0; group < NR_STAT_GROUPS; group++) {
@@ -113,7 +114,7 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 	}
 }
 
-static unsigned int part_in_flight(struct hd_struct *part)
+static unsigned int part_in_flight(struct block_device *part)
 {
 	unsigned int inflight = 0;
 	int cpu;
@@ -128,7 +129,8 @@ static unsigned int part_in_flight(struct hd_struct *part)
 	return inflight;
 }
 
-static void part_in_flight_rw(struct hd_struct *part, unsigned int inflight[2])
+static void part_in_flight_rw(struct block_device *part,
+		unsigned int inflight[2])
 {
 	int cpu;
 
@@ -144,42 +146,6 @@ static void part_in_flight_rw(struct hd_struct *part, unsigned int inflight[2])
 		inflight[1] = 0;
 }
 
-struct hd_struct *__disk_get_part(struct gendisk *disk, int partno)
-{
-	struct disk_part_tbl *ptbl = rcu_dereference(disk->part_tbl);
-
-	if (unlikely(partno < 0 || partno >= ptbl->len))
-		return NULL;
-	return rcu_dereference(ptbl->part[partno]);
-}
-
-/**
- * disk_get_part - get partition
- * @disk: disk to look partition from
- * @partno: partition number
- *
- * Look for partition @partno from @disk.  If found, increment
- * reference count and return it.
- *
- * CONTEXT:
- * Don't care.
- *
- * RETURNS:
- * Pointer to the found partition on success, NULL if not found.
- */
-struct hd_struct *disk_get_part(struct gendisk *disk, int partno)
-{
-	struct hd_struct *part;
-
-	rcu_read_lock();
-	part = __disk_get_part(disk, partno);
-	if (part)
-		get_device(part_to_dev(part));
-	rcu_read_unlock();
-
-	return part;
-}
-
 /**
  * disk_part_iter_init - initialize partition iterator
  * @piter: iterator to initialize
@@ -224,7 +190,7 @@ EXPORT_SYMBOL_GPL(disk_part_iter_init);
  * CONTEXT:
  * Don't care.
  */
-struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter)
+struct block_device *disk_part_iter_next(struct disk_part_iter *piter)
 {
 	struct disk_part_tbl *ptbl;
 	int inc, end;
@@ -251,19 +217,18 @@ struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter)
 
 	/* iterate to the next partition */
 	for (; piter->idx != end; piter->idx += inc) {
-		struct hd_struct *part;
+		struct block_device *part;
 
 		part = rcu_dereference(ptbl->part[piter->idx]);
 		if (!part)
 			continue;
-		if (!bdev_nr_sectors(part->bdev) &&
+		if (!bdev_nr_sectors(part) &&
 		    !(piter->flags & DISK_PITER_INCL_EMPTY) &&
 		    !(piter->flags & DISK_PITER_INCL_EMPTY_PART0 &&
 		      piter->idx == 0))
 			continue;
 
-		get_device(part_to_dev(part));
-		piter->part = part;
+		piter->part = bdgrab(part);
 		piter->idx += inc;
 		break;
 	}
@@ -285,15 +250,16 @@ EXPORT_SYMBOL_GPL(disk_part_iter_next);
  */
 void disk_part_iter_exit(struct disk_part_iter *piter)
 {
-	disk_put_part(piter->part);
+	if (piter->part)
+		bdput(piter->part);
 	piter->part = NULL;
 }
 EXPORT_SYMBOL_GPL(disk_part_iter_exit);
 
-static inline int sector_in_part(struct hd_struct *part, sector_t sector)
+static inline int sector_in_part(struct block_device *part, sector_t sector)
 {
-	return part->start_sect <= sector &&
-		sector < part->start_sect + bdev_nr_sectors(part->bdev);
+	return part->bd_start_sect <= sector &&
+		sector < part->bd_start_sect + bdev_nr_sectors(part);
 }
 
 /**
@@ -313,36 +279,28 @@ static inline int sector_in_part(struct hd_struct *part, sector_t sector)
  * Found partition on success, part0 is returned if no partition matches
  * or the matched partition is being deleted.
  */
-struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
+struct block_device *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 {
 	struct disk_part_tbl *ptbl;
-	struct hd_struct *part;
+	struct block_device *part;
 	int i;
 
 	rcu_read_lock();
 	ptbl = rcu_dereference(disk->part_tbl);
 
 	part = rcu_dereference(ptbl->last_lookup);
-	if (part && sector_in_part(part, sector) && hd_struct_try_get(part))
+	if (part && sector_in_part(part, sector))
 		goto out_unlock;
 
 	for (i = 1; i < ptbl->len; i++) {
 		part = rcu_dereference(ptbl->part[i]);
-
 		if (part && sector_in_part(part, sector)) {
-			/*
-			 * only live partition can be cached for lookup,
-			 * so use-after-free on cached & deleting partition
-			 * can be avoided
-			 */
-			if (!hd_struct_try_get(part))
-				break;
 			rcu_assign_pointer(ptbl->last_lookup, part);
 			goto out_unlock;
 		}
 	}
 
-	part = &disk->part0;
+	part = disk->part0;
 out_unlock:
 	rcu_read_unlock();
 	return part;
@@ -560,7 +518,7 @@ static int blk_mangle_minor(int minor)
 
 /**
  * blk_alloc_devt - allocate a dev_t for a partition
- * @part: partition to allocate dev_t for
+ * @bdev: partition to allocate dev_t for
  * @devt: out parameter for resulting dev_t
  *
  * Allocate a dev_t for block device.
@@ -572,14 +530,14 @@ static int blk_mangle_minor(int minor)
  * CONTEXT:
  * Might sleep.
  */
-int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
+int blk_alloc_devt(struct block_device *bdev, dev_t *devt)
 {
-	struct gendisk *disk = part_to_disk(part);
+	struct gendisk *disk = bdev->bd_disk;
 	int idx;
 
 	/* in consecutive minor range? */
-	if (part->partno < disk->minors) {
-		*devt = MKDEV(disk->major, disk->first_minor + part->partno);
+	if (bdev->bd_partno < disk->minors) {
+		*devt = MKDEV(disk->major, disk->first_minor + bdev->bd_partno);
 		return 0;
 	}
 
@@ -636,7 +594,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 {
 	struct device *ddev = disk_to_dev(disk);
 	struct disk_part_iter piter;
-	struct hd_struct *part;
+	struct block_device *part;
 	int err;
 
 	ddev->parent = parent;
@@ -668,7 +626,8 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
-	disk->part0.holder_dir = kobject_create_and_add("holders", &ddev->kobj);
+	disk->part0->bd_holder_dir =
+		kobject_create_and_add("holders", &ddev->kobj);
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 
 	if (disk->flags & GENHD_FL_HIDDEN) {
@@ -685,7 +644,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 	/* announce possible partitions */
 	disk_part_iter_init(&piter, disk, 0);
 	while ((part = disk_part_iter_next(&piter)))
-		kobject_uevent(&part_to_dev(part)->kobj, KOBJ_ADD);
+		kobject_uevent(bdev_kobj(part), KOBJ_ADD);
 	disk_part_iter_exit(&piter);
 
 	if (disk->queue->backing_dev_info->dev) {
@@ -734,7 +693,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk->flags |= GENHD_FL_UP;
 
-	retval = blk_alloc_devt(&disk->part0, &devt);
+	retval = blk_alloc_devt(disk->part0, &devt);
 	if (retval) {
 		WARN_ON(1);
 		return;
@@ -761,7 +720,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
 		WARN_ON(ret);
 		bdi_set_owner(bdi, dev);
-		bdev_add(disk->part0.bdev, devt);
+		bdev_add(disk->part0, devt);
 	}
 	register_disk(parent, disk, groups);
 	if (register_queue)
@@ -791,14 +750,8 @@ void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
 
-static void invalidate_partition(struct gendisk *disk, int partno)
+static void invalidate_partition(struct block_device *bdev)
 {
-	struct block_device *bdev;
-
-	bdev = bdget_disk(disk, partno);
-	if (!bdev)
-		return;
-
 	fsync_bdev(bdev);
 	__invalidate_device(bdev, true);
 
@@ -807,7 +760,6 @@ static void invalidate_partition(struct gendisk *disk, int partno)
 	 * as last inode reference is dropped.
 	 */
 	remove_inode_hash(bdev->bd_inode);
-	bdput(bdev);
 }
 
 /**
@@ -832,7 +784,7 @@ static void invalidate_partition(struct gendisk *disk, int partno)
 void del_gendisk(struct gendisk *disk)
 {
 	struct disk_part_iter piter;
-	struct hd_struct *part;
+	struct block_device *part;
 
 	might_sleep();
 
@@ -851,12 +803,12 @@ void del_gendisk(struct gendisk *disk)
 	disk_part_iter_init(&piter, disk,
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
 	while ((part = disk_part_iter_next(&piter))) {
-		invalidate_partition(disk, part->partno);
+		invalidate_partition(part);
 		delete_partition(part);
 	}
 	disk_part_iter_exit(&piter);
 
-	invalidate_partition(disk, 0);
+	invalidate_partition(disk->part0);
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
 	up_write(&disk->lookup_sem);
@@ -873,11 +825,11 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_unregister_queue(disk);
 
-	kobject_put(disk->part0.holder_dir);
+	kobject_put(disk->part0->bd_holder_dir);
 	kobject_put(disk->slave_dir);
 
-	part_stat_set_all(&disk->part0, 0);
-	disk->part0.stamp = 0;
+	part_stat_set_all(disk->part0, 0);
+	disk->part0->bd_stamp = 0;
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
@@ -945,13 +897,13 @@ void blk_request_module(dev_t devt)
  */
 struct block_device *bdget_disk(struct gendisk *disk, int partno)
 {
-	struct hd_struct *part;
 	struct block_device *bdev = NULL;
 
-	part = disk_get_part(disk, partno);
-	if (part)
-		bdev = bdget_part(part);
-	disk_put_part(part);
+	rcu_read_lock();
+	bdev = __bdget_disk(disk, partno);
+	if (bdev)
+		bdgrab(bdev);
+	rcu_read_unlock();
 
 	return bdev;
 }
@@ -971,7 +923,7 @@ void __init printk_all_partitions(void)
 	while ((dev = class_dev_iter_next(&iter))) {
 		struct gendisk *disk = dev_to_disk(dev);
 		struct disk_part_iter piter;
-		struct hd_struct *part;
+		struct block_device *part;
 		char name_buf[BDEVNAME_SIZE];
 		char devt_buf[BDEVT_SIZE];
 
@@ -990,13 +942,14 @@ void __init printk_all_partitions(void)
 		 */
 		disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
 		while ((part = disk_part_iter_next(&piter))) {
-			bool is_part0 = part == &disk->part0;
+			bool is_part0 = part == disk->part0;
 
 			printk("%s%s %10llu %s %s", is_part0 ? "" : "  ",
-			       bdevt_str(part_devt(part), devt_buf),
-			       bdev_nr_sectors(part->bdev) >> 1
-			       , disk_name(disk, part->partno, name_buf),
-			       part->info ? part->info->uuid : "");
+			       bdevt_str(part->bd_dev, devt_buf),
+			       bdev_nr_sectors(part) >> 1,
+			       disk_name(disk, part->bd_partno, name_buf),
+			       part->bd_meta_info ?
+					part->bd_meta_info->uuid : "");
 			if (is_part0) {
 				if (dev->parent && dev->parent->driver)
 					printk(" driver: %s\n",
@@ -1072,7 +1025,7 @@ static int show_partition(struct seq_file *seqf, void *v)
 {
 	struct gendisk *sgp = v;
 	struct disk_part_iter piter;
-	struct hd_struct *part;
+	struct block_device *part;
 	char buf[BDEVNAME_SIZE];
 
 	/* Don't show non-partitionable removeable devices or empty devices */
@@ -1086,9 +1039,9 @@ static int show_partition(struct seq_file *seqf, void *v)
 	disk_part_iter_init(&piter, sgp, DISK_PITER_INCL_PART0);
 	while ((part = disk_part_iter_next(&piter)))
 		seq_printf(seqf, "%4d  %7d %10llu %s\n",
-			   MAJOR(part_devt(part)), MINOR(part_devt(part)),
-			   bdev_nr_sectors(part->bdev) >> 1,
-			   disk_name(sgp, part->partno, buf));
+			   MAJOR(part->bd_dev), MINOR(part->bd_dev),
+			   bdev_nr_sectors(part) >> 1,
+			   disk_name(sgp, part->bd_partno, buf));
 	disk_part_iter_exit(&piter);
 
 	return 0;
@@ -1167,24 +1120,22 @@ static ssize_t disk_ro_show(struct device *dev,
 ssize_t part_size_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
-
-	return sprintf(buf, "%llu\n", bdev_nr_sectors(p->bdev));
+	return sprintf(buf, "%llu\n", bdev_nr_sectors(dev_to_bdev(dev)));
 }
 
 ssize_t part_stat_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
-	struct request_queue *q = part_to_disk(p)->queue;
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct request_queue *q = bdev->bd_disk->queue;
 	struct disk_stats stat;
 	unsigned int inflight;
 
-	part_stat_read_all(p, &stat);
+	part_stat_read_all(bdev, &stat);
 	if (queue_is_mq(q))
-		inflight = blk_mq_in_flight(q, p);
+		inflight = blk_mq_in_flight(q, bdev);
 	else
-		inflight = part_in_flight(p);
+		inflight = part_in_flight(bdev);
 
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
@@ -1219,14 +1170,14 @@ ssize_t part_stat_show(struct device *dev,
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
-	struct request_queue *q = part_to_disk(p)->queue;
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct request_queue *q = bdev->bd_disk->queue;
 	unsigned int inflight[2];
 
 	if (queue_is_mq(q))
-		blk_mq_in_flight_rw(q, p, inflight);
+		blk_mq_in_flight_rw(q, bdev, inflight);
 	else
-		part_in_flight_rw(p, inflight);
+		part_in_flight_rw(bdev, inflight);
 
 	return sprintf(buf, "%8u %8u\n", inflight[0], inflight[1]);
 }
@@ -1274,16 +1225,14 @@ static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
 ssize_t part_fail_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
-
-	return sprintf(buf, "%d\n", p->make_it_fail);
+	return sprintf(buf, "%d\n", dev_to_bdev(dev)->make_it_fail);
 }
 
 ssize_t part_fail_store(struct device *dev,
 			struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	struct hd_struct *p = dev_to_part(dev);
+	struct block_device *p = dev_to_bdev(dev);
 	int i;
 
 	if (count > 0 && sscanf(buf, "%d", &i) > 0)
@@ -1444,9 +1393,9 @@ static void disk_release(struct device *dev)
 	disk_release_events(disk);
 	kfree(disk->random);
 	disk_replace_part_tbl(disk, NULL);
-	hd_free_part(&disk->part0);
 	if (disk->queue)
 		blk_put_queue(disk->queue);
+	bdput(disk->part0);
 	kfree(disk);
 }
 struct class block_class = {
@@ -1482,7 +1431,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 {
 	struct gendisk *gp = v;
 	struct disk_part_iter piter;
-	struct hd_struct *hd;
+	struct block_device *hd;
 	char buf[BDEVNAME_SIZE];
 	unsigned int inflight;
 	struct disk_stats stat;
@@ -1510,8 +1459,8 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   "%lu %lu %lu %u "
 			   "%lu %u"
 			   "\n",
-			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
-			   disk_name(gp, hd->partno, buf),
+			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev),
+			   disk_name(gp, hd->bd_partno, buf),
 			   stat.ios[STAT_READ],
 			   stat.merges[STAT_READ],
 			   stat.sectors[STAT_READ],
@@ -1567,9 +1516,9 @@ dev_t blk_lookup_devt(const char *name, int partno)
 	struct device *dev;
 
 	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
-	while ((dev = class_dev_iter_next(&iter))) {
+	while ((dev = class_dev_iter_next(&iter)) && !devt) {
 		struct gendisk *disk = dev_to_disk(dev);
-		struct hd_struct *part;
+		struct block_device *bdev;
 
 		if (strcmp(dev_name(dev), name))
 			continue;
@@ -1580,15 +1529,13 @@ dev_t blk_lookup_devt(const char *name, int partno)
 			 */
 			devt = MKDEV(MAJOR(dev->devt),
 				     MINOR(dev->devt) + partno);
-			break;
+		} else {
+			rcu_read_lock();
+			bdev = __bdget_disk(disk, partno);
+			if (bdev)
+				devt = bdev->bd_dev;
+			rcu_read_unlock();
 		}
-		part = disk_get_part(disk, partno);
-		if (part) {
-			devt = part_devt(part);
-			disk_put_part(part);
-			break;
-		}
-		disk_put_part(part);
 	}
 	class_dev_iter_exit(&iter);
 	return devt;
@@ -1610,26 +1557,17 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	if (!disk)
 		return NULL;
 
-	disk->part0.bdev = bdev_alloc(disk, 0);
-	if (!disk->part0.bdev)
+	disk->part0 = bdev_alloc(disk, 0);
+	if (!disk->part0)
 		goto out_free_disk;
 
-	disk->part0.dkstats = alloc_percpu(struct disk_stats);
-	if (!disk->part0.dkstats)
-		goto out_bdput;
-
 	init_rwsem(&disk->lookup_sem);
 	disk->node_id = node_id;
 	if (disk_expand_part_tbl(disk, 0))
-		goto out_free_bdstats;
+		goto out_bdput;
 
 	ptbl = rcu_dereference_protected(disk->part_tbl, 1);
-	rcu_assign_pointer(ptbl->part[0], &disk->part0);
-
-	if (hd_ref_init(&disk->part0)) {
-		hd_free_part(&disk->part0);
-		return NULL;
-	}
+	rcu_assign_pointer(ptbl->part[0], disk->part0);
 
 	disk->minors = minors;
 	rand_initialize_disk(disk);
@@ -1638,10 +1576,8 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	device_initialize(disk_to_dev(disk));
 	return disk;
 
-out_free_bdstats:
-	free_percpu(disk->part0.dkstats);
 out_bdput:
-	bdput(disk->part0.bdev);
+	bdput(disk->part0);
 out_free_disk:
 	kfree(disk);
 	return NULL;
@@ -1678,16 +1614,16 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 void set_disk_ro(struct gendisk *disk, int flag)
 {
 	struct disk_part_iter piter;
-	struct hd_struct *part;
+	struct block_device *part;
 
-	if (disk->part0.policy != flag) {
+	if (disk->part0->bd_policy != flag) {
 		set_disk_ro_uevent(disk, flag);
-		disk->part0.policy = flag;
+		disk->part0->bd_policy = flag;
 	}
 
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
-		part->policy = flag;
+		part->bd_policy = flag;
 	disk_part_iter_exit(&piter);
 }
 
@@ -1697,7 +1633,7 @@ int bdev_read_only(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return bdev->bd_part->policy;
+	return bdev->bd_policy;
 }
 
 EXPORT_SYMBOL(bdev_read_only);
diff --git a/block/ioctl.c b/block/ioctl.c
index 6b785181344fe1..aa9546e5d6a1bd 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -35,7 +35,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
 
-	/* check for fit in a hd_struct */
+	/* check for fit in a sector_t */
 	if (sizeof(sector_t) < sizeof(long long)) {
 		long pstart = start, plength = length;
 
@@ -354,7 +354,7 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		if (ret)
 			return ret;
 	}
-	bdev->bd_part->policy = n;
+	bdev->bd_policy = n;
 	return 0;
 }
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index aae857c22af05d..0269128219decc 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -182,44 +182,39 @@ static struct parsed_partitions *check_partition(struct gendisk *hd,
 static ssize_t part_partition_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
-
-	return sprintf(buf, "%d\n", p->partno);
+	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_partno);
 }
 
 static ssize_t part_start_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
-
-	return sprintf(buf, "%llu\n",(unsigned long long)p->start_sect);
+	return sprintf(buf, "%llu\n", dev_to_bdev(dev)->bd_start_sect);
 }
 
 static ssize_t part_ro_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
-	return sprintf(buf, "%d\n", p->policy ? 1 : 0);
+	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_policy ? 1 : 0);
 }
 
 static ssize_t part_alignment_offset_show(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
+	struct block_device *bdev = dev_to_bdev(dev);
 
 	return sprintf(buf, "%u\n",
-		queue_limit_alignment_offset(&part_to_disk(p)->queue->limits,
-				p->start_sect));
+		queue_limit_alignment_offset(&bdev->bd_disk->queue->limits,
+				bdev->bd_start_sect));
 }
 
 static ssize_t part_discard_alignment_show(struct device *dev,
 					   struct device_attribute *attr, char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
+	struct block_device *bdev = dev_to_bdev(dev);
 
 	return sprintf(buf, "%u\n",
-		queue_limit_discard_alignment(&part_to_disk(p)->queue->limits,
-				p->start_sect));
+		queue_limit_discard_alignment(&bdev->bd_disk->queue->limits,
+				bdev->bd_start_sect));
 }
 
 static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
@@ -264,19 +259,19 @@ static const struct attribute_group *part_attr_groups[] = {
 
 static void part_release(struct device *dev)
 {
-	struct hd_struct *p = dev_to_part(dev);
+	struct block_device *p = dev_to_bdev(dev);
+
 	blk_free_devt(dev->devt);
-	hd_free_part(p);
-	kfree(p);
+	bdput(p);
 }
 
 static int part_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct hd_struct *part = dev_to_part(dev);
+	struct block_device *part = dev_to_bdev(dev);
 
-	add_uevent_var(env, "PARTN=%u", part->partno);
-	if (part->info && part->info->volname[0])
-		add_uevent_var(env, "PARTNAME=%s", part->info->volname);
+	add_uevent_var(env, "PARTN=%u", part->bd_partno);
+	if (part->bd_meta_info && part->bd_meta_info->volname[0])
+		add_uevent_var(env, "PARTNAME=%s", part->bd_meta_info->volname);
 	return 0;
 }
 
@@ -287,72 +282,28 @@ struct device_type part_type = {
 	.uevent		= part_uevent,
 };
 
-static void hd_struct_free_work(struct work_struct *work)
-{
-	struct hd_struct *part =
-		container_of(to_rcu_work(work), struct hd_struct, rcu_work);
-	struct gendisk *disk = part_to_disk(part);
-
-	/*
-	 * Release the disk reference acquired in delete_partition here.
-	 * We can't release it in hd_struct_free because the final put_device
-	 * needs process context and thus can't be run directly from a
-	 * percpu_ref ->release handler.
-	 */
-	put_device(disk_to_dev(disk));
-
-	part->start_sect = 0;
-	bdev_set_nr_sectors(part->bdev, 0);
-	part_stat_set_all(part, 0);
-	put_device(part_to_dev(part));
-}
-
-static void hd_struct_free(struct percpu_ref *ref)
-{
-	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
-	struct gendisk *disk = part_to_disk(part);
-	struct disk_part_tbl *ptbl =
-		rcu_dereference_protected(disk->part_tbl, 1);
-
-	rcu_assign_pointer(ptbl->last_lookup, NULL);
-
-	INIT_RCU_WORK(&part->rcu_work, hd_struct_free_work);
-	queue_rcu_work(system_wq, &part->rcu_work);
-}
-
-int hd_ref_init(struct hd_struct *part)
-{
-	if (percpu_ref_init(&part->ref, hd_struct_free, 0, GFP_KERNEL))
-		return -ENOMEM;
-	return 0;
-}
-
 /*
  * Must be called either with bd_mutex held, before a disk can be opened or
  * after all disk users are gone.
  */
-void delete_partition(struct hd_struct *part)
+void delete_partition(struct block_device *part)
 {
-	struct gendisk *disk = part_to_disk(part);
+	struct gendisk *disk = part->bd_disk;
 	struct disk_part_tbl *ptbl =
 		rcu_dereference_protected(disk->part_tbl, 1);
 
-	/*
-	 * ->part_tbl is referenced in this part's release handler, so
-	 *  we have to hold the disk device
-	 */
-	get_device(disk_to_dev(disk));
-	rcu_assign_pointer(ptbl->part[part->partno], NULL);
-	kobject_put(part->holder_dir);
+	rcu_assign_pointer(ptbl->part[part->bd_partno], NULL);
+	rcu_assign_pointer(ptbl->last_lookup, NULL);
+	kobject_put(part->bd_holder_dir);
 	device_del(part_to_dev(part));
 
 	/*
 	 * Remove the block device from the inode hash, so that it cannot be
 	 * looked up while waiting for the RCU grace period.
 	 */
-	remove_inode_hash(part->bdev->bd_inode);
+	remove_inode_hash(part->bd_inode);
 
-	percpu_ref_kill(&part->ref);
+	put_device(part_to_dev(part));
 }
 
 static ssize_t whole_disk_show(struct device *dev,
@@ -366,11 +317,11 @@ static DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
  * Must be called either with bd_mutex held, before a disk can be opened or
  * after all disk users are gone.
  */
-static struct hd_struct *add_partition(struct gendisk *disk, int partno,
+static struct block_device *add_partition(struct gendisk *disk, int partno,
 				sector_t start, sector_t len, int flags,
 				struct partition_meta_info *info)
 {
-	struct hd_struct *p;
+	struct block_device *p;
 	dev_t devt = MKDEV(0, 0);
 	struct device *ddev = disk_to_dev(disk);
 	struct device *pdev;
@@ -404,36 +355,22 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	if (ptbl->part[partno])
 		return ERR_PTR(-EBUSY);
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = bdev_alloc(disk, partno);
 	if (!p)
-		return ERR_PTR(-EBUSY);
-
-	err = -ENOMEM;
-	p->dkstats = alloc_percpu(struct disk_stats);
-	if (!p->dkstats)
-		goto out_free;
-
-	p->bdev = bdev_alloc(disk, partno);
-	if (!p->bdev)
-		goto out_free_stats;
-
-	pdev = part_to_dev(p);
+		return ERR_PTR(-ENOMEM);
 
-	p->start_sect = start;
-	bdev_set_nr_sectors(p->bdev, len);
-	p->partno = partno;
-	p->policy = get_disk_ro(disk);
+	p->bd_start_sect = start;
+	bdev_set_nr_sectors(p, len);
+	p->bd_policy = get_disk_ro(disk);
 
 	if (info) {
-		struct partition_meta_info *pinfo;
-
-		pinfo = kzalloc_node(sizeof(*pinfo), GFP_KERNEL, disk->node_id);
-		if (!pinfo)
+		err = -ENOMEM;
+		p->bd_meta_info = kmemdup(info, sizeof(*info), GFP_KERNEL);
+		if (!p->bd_meta_info)
 			goto out_bdput;
-		memcpy(pinfo, info, sizeof(*info));
-		p->info = pinfo;
 	}
 
+	pdev = part_to_dev(p);
 	dname = dev_name(ddev);
 	if (isdigit(dname[strlen(dname) - 1]))
 		dev_set_name(pdev, "%sp%d", dname, partno);
@@ -457,8 +394,8 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 		goto out_put;
 
 	err = -ENOMEM;
-	p->holder_dir = kobject_create_and_add("holders", &pdev->kobj);
-	if (!p->holder_dir)
+	p->bd_holder_dir = kobject_create_and_add("holders", &pdev->kobj);
+	if (!p->bd_holder_dir)
 		goto out_del;
 
 	dev_set_uevent_suppress(pdev, 0);
@@ -468,15 +405,8 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 			goto out_del;
 	}
 
-	err = hd_ref_init(p);
-	if (err) {
-		if (flags & ADDPART_FLAG_WHOLEDISK)
-			goto out_remove_file;
-		goto out_del;
-	}
-
 	/* everything is up and running, commence */
-	bdev_add(p->bdev, devt);
+	bdev_add(p, devt);
 	rcu_assign_pointer(ptbl->part[partno], p);
 
 	/* suppress uevent if the disk suppresses it */
@@ -485,19 +415,13 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	return p;
 
 out_free_info:
-	kfree(p->info);
+	kfree(p->bd_meta_info);
 out_bdput:
-	bdput(p->bdev);
-out_free_stats:
-	free_percpu(p->dkstats);
-out_free:
-	kfree(p);
+	bdput(p);
 	return ERR_PTR(err);
 
-out_remove_file:
-	device_remove_file(pdev, &dev_attr_whole_disk);
 out_del:
-	kobject_put(p->holder_dir);
+	kobject_put(p->bd_holder_dir);
 	device_del(pdev);
 out_put:
 	put_device(pdev);
@@ -508,14 +432,14 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 		sector_t length, int skip_partno)
 {
 	struct disk_part_iter piter;
-	struct hd_struct *part;
+	struct block_device *part;
 	bool overlap = false;
 
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter))) {
-		if (part->partno == skip_partno ||
-		    start >= part->start_sect + bdev_nr_sectors(part->bdev) ||
-		    start + length <= part->start_sect)
+		if (part->bd_partno == skip_partno ||
+		    start >= part->bd_start_sect + bdev_nr_sectors(part) ||
+		    start + length <= part->bd_start_sect)
 			continue;
 		overlap = true;
 		break;
@@ -528,7 +452,7 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 int bdev_add_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length)
 {
-	struct hd_struct *part;
+	struct block_device *part;
 
 	mutex_lock(&bdev->bd_mutex);
 	if (partition_overlaps(bdev->bd_disk, start, length, -1)) {
@@ -544,76 +468,59 @@ int bdev_add_partition(struct block_device *bdev, int partno,
 
 int bdev_del_partition(struct block_device *bdev, int partno)
 {
-	struct block_device *bdevp;
-	struct hd_struct *part = NULL;
+	struct block_device *part;
 	int ret;
 
-	bdevp = bdget_disk(bdev->bd_disk, partno);
-	if (!bdevp)
+	part = bdget_disk(bdev->bd_disk, partno);
+	if (!part)
 		return -ENXIO;
 
-	mutex_lock(&bdevp->bd_mutex);
+	mutex_lock(&part->bd_mutex);
 	mutex_lock_nested(&bdev->bd_mutex, 1);
 
-	ret = -ENXIO;
-	part = disk_get_part(bdev->bd_disk, partno);
-	if (!part)
-		goto out_unlock;
-
 	ret = -EBUSY;
-	if (bdevp->bd_openers)
+	if (part->bd_openers)
 		goto out_unlock;
 
-	sync_blockdev(bdevp);
-	invalidate_bdev(bdevp);
+	sync_blockdev(part);
+	invalidate_bdev(part);
 
 	delete_partition(part);
 	ret = 0;
 out_unlock:
 	mutex_unlock(&bdev->bd_mutex);
-	mutex_unlock(&bdevp->bd_mutex);
-	bdput(bdevp);
-	if (part)
-		disk_put_part(part);
+	mutex_unlock(&part->bd_mutex);
+	bdput(part);
 	return ret;
 }
 
 int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length)
 {
-	struct block_device *bdevp;
-	struct hd_struct *part;
+	struct block_device *part;
 	int ret = 0;
 
-	part = disk_get_part(bdev->bd_disk, partno);
+	part = bdget_disk(bdev->bd_disk, partno);
 	if (!part)
 		return -ENXIO;
 
-	ret = -ENOMEM;
-	bdevp = bdget_part(part);
-	if (!bdevp)
-		goto out_put_part;
-
-	mutex_lock(&bdevp->bd_mutex);
+	mutex_lock(&part->bd_mutex);
 	mutex_lock_nested(&bdev->bd_mutex, 1);
-
 	ret = -EINVAL;
-	if (start != part->start_sect)
+	if (start != part->bd_start_sect)
 		goto out_unlock;
 
 	ret = -EBUSY;
 	if (partition_overlaps(bdev->bd_disk, start, length, partno))
 		goto out_unlock;
 
-	bdev_set_nr_sectors(bdevp, length);
+	bdev_set_nr_sectors(part, length);
 
 	ret = 0;
 out_unlock:
-	mutex_unlock(&bdevp->bd_mutex);
+	mutex_unlock(&part->bd_mutex);
 	mutex_unlock(&bdev->bd_mutex);
-	bdput(bdevp);
-out_put_part:
-	disk_put_part(part);
+	bdput(part);
 	return ret;
 }
 
@@ -636,7 +543,7 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
 int blk_drop_partitions(struct block_device *bdev)
 {
 	struct disk_part_iter piter;
-	struct hd_struct *part;
+	struct block_device *part;
 
 	if (bdev->bd_part_count)
 		return -EBUSY;
@@ -661,7 +568,7 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 {
 	sector_t size = state->parts[p].size;
 	sector_t from = state->parts[p].from;
-	struct hd_struct *part;
+	struct block_device *part;
 
 	if (!size)
 		return true;
@@ -701,7 +608,7 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 
 	if (IS_BUILTIN(CONFIG_BLK_DEV_MD) &&
 	    (state->parts[p].flags & ADDPART_FLAG_RAID))
-		md_autodetect_dev(part_to_dev(part)->devt);
+		md_autodetect_dev(part->bd_dev);
 
 	return true;
 }
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index dc333dbe523281..09c86ef3f0fd93 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2802,7 +2802,7 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 	if (c_min_rate == 0)
 		return false;
 
-	curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
+	curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
 			atomic_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index ba56f3f05312f0..4537559829876e 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1678,7 +1678,7 @@ void drbd_rs_controller_reset(struct drbd_device *device)
 	atomic_set(&device->rs_sect_in, 0);
 	atomic_set(&device->rs_sect_ev, 0);
 	device->rs_in_flight = 0;
-	device->rs_last_events = (int)part_stat_read_accum(&disk->part0, sectors);
+	device->rs_last_events = part_stat_read_accum(disk->part0, sectors);
 
 	/* Updating the RCU protected object in place is necessary since
 	   this function gets called from atomic context.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 88baa6158eaee1..01757f9578dcb8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1687,7 +1687,7 @@ static void zram_reset_device(struct zram *zram)
 	zram->disksize = 0;
 
 	set_capacity_and_notify(zram->disk, 0);
-	part_stat_set_all(&zram->disk->part0, 0);
+	part_stat_set_all(zram->disk->part0, 0);
 
 	up_write(&zram->init_lock);
 	/* I/O operation under all of CPU are done so let's free */
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index afac8d07c1bd00..85b1f2a9b72d68 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -475,7 +475,7 @@ struct search {
 	unsigned int		read_dirty_data:1;
 	unsigned int		cache_missed:1;
 
-	struct hd_struct	*part;
+	struct block_device	*part;
 	unsigned long		start_time;
 
 	struct btree_op		op;
@@ -1073,7 +1073,7 @@ struct detached_dev_io_private {
 	unsigned long		start_time;
 	bio_end_io_t		*bi_end_io;
 	void			*bi_private;
-	struct hd_struct	*part;
+	struct block_device	*part;
 };
 
 static void detached_dev_end_io(struct bio *bio)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 83fe1e7f13e6b0..c9438feefe55a3 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1607,7 +1607,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 				 * (by eliminating DM's splitting and just using bio_split)
 				 */
 				part_stat_lock();
-				__dm_part_stat_sub(&dm_disk(md)->part0,
+				__dm_part_stat_sub(dm_disk(md)->part0,
 						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
 				part_stat_unlock();
 
@@ -2242,12 +2242,12 @@ EXPORT_SYMBOL_GPL(dm_put);
 static bool md_in_flight_bios(struct mapped_device *md)
 {
 	int cpu;
-	struct hd_struct *part = &dm_disk(md)->part0;
+	struct block_device *bdev = dm_disk(md)->part0;
 	long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		sum += part_stat_local_read_cpu(part, in_flight[0], cpu);
-		sum += part_stat_local_read_cpu(part, in_flight[1], cpu);
+		sum += part_stat_local_read_cpu(bdev, in_flight[0], cpu);
+		sum += part_stat_local_read_cpu(bdev, in_flight[1], cpu);
 	}
 
 	return sum != 0;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7ce6047c856ea2..0065736f05b428 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -464,7 +464,7 @@ struct md_io {
 	bio_end_io_t *orig_bi_end_io;
 	void *orig_bi_private;
 	unsigned long start_time;
-	struct hd_struct *part;
+	struct block_device *part;
 };
 
 static void md_end_io(struct bio *bio)
@@ -8441,7 +8441,7 @@ static int is_mddev_idle(struct mddev *mddev, int init)
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		struct gendisk *disk = rdev->bdev->bd_disk;
-		curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
+		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
 			      atomic_read(&disk->sync_io);
 		/* sync IO will cause sync_io to increase before the disk_stats
 		 * as sync_io is counted when a request starts, and
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index dca34489a1dc9e..8d90235e4fcc5a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -89,12 +89,12 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	if (!ns->bdev)
 		goto out;
 
-	host_reads = part_stat_read(ns->bdev->bd_part, ios[READ]);
-	data_units_read = DIV_ROUND_UP(part_stat_read(ns->bdev->bd_part,
-		sectors[READ]), 1000);
-	host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
-	data_units_written = DIV_ROUND_UP(part_stat_read(ns->bdev->bd_part,
-		sectors[WRITE]), 1000);
+	host_reads = part_stat_read(ns->bdev, ios[READ]);
+	data_units_read =
+		DIV_ROUND_UP(part_stat_read(ns->bdev, sectors[READ]), 1000);
+	host_writes = part_stat_read(ns->bdev, ios[WRITE]);
+	data_units_written =
+		DIV_ROUND_UP(part_stat_read(ns->bdev, sectors[WRITE]), 1000);
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
@@ -120,12 +120,12 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 		/* we don't have the right data for file backed ns */
 		if (!ns->bdev)
 			continue;
-		host_reads += part_stat_read(ns->bdev->bd_part, ios[READ]);
+		host_reads += part_stat_read(ns->bdev, ios[READ]);
 		data_units_read += DIV_ROUND_UP(
-			part_stat_read(ns->bdev->bd_part, sectors[READ]), 1000);
-		host_writes += part_stat_read(ns->bdev->bd_part, ios[WRITE]);
+			part_stat_read(ns->bdev, sectors[READ]), 1000);
+		host_writes += part_stat_read(ns->bdev, ios[WRITE]);
 		data_units_written += DIV_ROUND_UP(
-			part_stat_read(ns->bdev->bd_part, sectors[WRITE]), 1000);
+			part_stat_read(ns->bdev, sectors[WRITE]), 1000);
 	}
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index db24e04ee9781e..1825fa8d05a780 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -432,7 +432,7 @@ dasd_state_ready_to_online(struct dasd_device * device)
 {
 	struct gendisk *disk;
 	struct disk_part_iter piter;
-	struct hd_struct *part;
+	struct block_device *part;
 
 	device->state = DASD_STATE_ONLINE;
 	if (device->block) {
@@ -445,7 +445,7 @@ dasd_state_ready_to_online(struct dasd_device * device)
 		disk = device->block->bdev->bd_disk;
 		disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
 		while ((part = disk_part_iter_next(&piter)))
-			kobject_uevent(&part_to_dev(part)->kobj, KOBJ_CHANGE);
+			kobject_uevent(bdev_kobj(part), KOBJ_CHANGE);
 		disk_part_iter_exit(&piter);
 	}
 	return 0;
@@ -459,7 +459,7 @@ static int dasd_state_online_to_ready(struct dasd_device *device)
 	int rc;
 	struct gendisk *disk;
 	struct disk_part_iter piter;
-	struct hd_struct *part;
+	struct block_device *part;
 
 	if (device->discipline->online_to_ready) {
 		rc = device->discipline->online_to_ready(device);
@@ -472,7 +472,7 @@ static int dasd_state_online_to_ready(struct dasd_device *device)
 		disk = device->block->bdev->bd_disk;
 		disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
 		while ((part = disk_part_iter_next(&piter)))
-			kobject_uevent(&part_to_dev(part)->kobj, KOBJ_CHANGE);
+			kobject_uevent(bdev_kobj(part), KOBJ_CHANGE);
 		disk_part_iter_exit(&piter);
 	}
 	return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index a5a2ac4ca1ce9c..c2da068bd983f4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -34,6 +34,7 @@
 #include <linux/falloc.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
+#include <linux/part_stat.h>
 #include "internal.h"
 
 struct bdev_inode {
@@ -788,23 +789,18 @@ static struct inode *bdev_alloc_inode(struct super_block *sb)
 
 static void bdev_free_inode(struct inode *inode)
 {
+	struct block_device *bdev = I_BDEV(inode);
+
+	kfree(bdev->bd_meta_info);
+	free_percpu(bdev->bd_stats);
 	kmem_cache_free(bdev_cachep, BDEV_I(inode));
 }
 
 static void init_once(void *foo)
 {
 	struct bdev_inode *ei = (struct bdev_inode *) foo;
-	struct block_device *bdev = &ei->bdev;
 
-	memset(bdev, 0, sizeof(*bdev));
-	mutex_init(&bdev->bd_mutex);
-#ifdef CONFIG_SYSFS
-	INIT_LIST_HEAD(&bdev->bd_holder_disks);
-#endif
-	bdev->bd_bdi = &noop_backing_dev_info;
 	inode_init_once(&ei->vfs_inode);
-	/* Initialize mutex for freeze. */
-	mutex_init(&bdev->bd_fsfreeze_mutex);
 }
 
 static void bdev_evict_inode(struct inode *inode)
@@ -876,12 +872,22 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		return NULL;
 
 	bdev = I_BDEV(inode);
+	memset(bdev, 0, sizeof(*bdev));
 	spin_lock_init(&bdev->bd_size_lock);
+	mutex_init(&bdev->bd_mutex);
+	mutex_init(&bdev->bd_fsfreeze_mutex);
+	bdev->bd_bdi = &noop_backing_dev_info;
 	bdev->bd_disk = disk;
 	bdev->bd_partno = partno;
-	bdev->bd_super = NULL;
 	bdev->bd_inode = inode;
-	bdev->bd_part_count = 0;
+	bdev->bd_stats = alloc_percpu(struct disk_stats);
+	if (!bdev->bd_stats) {
+		iput(inode);
+		return NULL;
+	}
+#ifdef CONFIG_SYSFS
+	INIT_LIST_HEAD(&bdev->bd_holder_disks);
+#endif
 
 	inode->i_mode = S_IFBLK;
 	inode->i_rdev = 0;
@@ -920,11 +926,6 @@ struct block_device *bdgrab(struct block_device *bdev)
 }
 EXPORT_SYMBOL(bdgrab);
 
-struct block_device *bdget_part(struct hd_struct *part)
-{
-	return bdget(part_devt(part));
-}
-
 long nr_blockdev_pages(void)
 {
 	struct inode *inode;
@@ -1201,7 +1202,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	WARN_ON_ONCE(!bdev->bd_holder);
 
 	/* FIXME: remove the following once add_disk() handles errors */
-	if (WARN_ON(!disk->slave_dir || !bdev->bd_part->holder_dir))
+	if (WARN_ON(!disk->slave_dir || !bdev->bd_holder_dir))
 		goto out_unlock;
 
 	holder = bd_find_holder_disk(bdev, disk);
@@ -1220,24 +1221,24 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	holder->disk = disk;
 	holder->refcnt = 1;
 
-	ret = add_symlink(disk->slave_dir, &part_to_dev(bdev->bd_part)->kobj);
+	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
 	if (ret)
 		goto out_free;
 
-	ret = add_symlink(bdev->bd_part->holder_dir, &disk_to_dev(disk)->kobj);
+	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
 	if (ret)
 		goto out_del;
 	/*
 	 * bdev could be deleted beneath us which would implicitly destroy
 	 * the holder directory.  Hold on to it.
 	 */
-	kobject_get(bdev->bd_part->holder_dir);
+	kobject_get(bdev->bd_holder_dir);
 
 	list_add(&holder->list, &bdev->bd_holder_disks);
 	goto out_unlock;
 
 out_del:
-	del_symlink(disk->slave_dir, &part_to_dev(bdev->bd_part)->kobj);
+	del_symlink(disk->slave_dir, bdev_kobj(bdev));
 out_free:
 	kfree(holder);
 out_unlock:
@@ -1265,10 +1266,10 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	holder = bd_find_holder_disk(bdev, disk);
 
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
-		del_symlink(disk->slave_dir, &part_to_dev(bdev->bd_part)->kobj);
-		del_symlink(bdev->bd_part->holder_dir,
+		del_symlink(disk->slave_dir, bdev_kobj(bdev));
+		del_symlink(bdev->bd_holder_dir,
 			    &disk_to_dev(disk)->kobj);
-		kobject_put(bdev->bd_part->holder_dir);
+		kobject_put(bdev->bd_holder_dir);
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
@@ -1392,11 +1393,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		first_open = true;
 
 		if (!bdev->bd_partno) {
-			ret = -ENXIO;
-			bdev->bd_part = disk_get_part(disk, 0);
-			if (!bdev->bd_part)
-				goto out_clear;
-
 			ret = 0;
 			if (disk->fops->open) {
 				ret = disk->fops->open(bdev, mode);
@@ -1422,19 +1418,16 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 
 			if (ret)
-				goto out_clear;
+				goto out_unlock_bdev;
 		} else {
 			BUG_ON(for_part);
 			ret = __blkdev_get(bdev_whole(bdev), mode, NULL, 1);
 			if (ret)
-				goto out_clear;
+				goto out_unlock_bdev;
 			bdgrab(bdev_whole(bdev));
-			bdev->bd_part = disk_get_part(disk, bdev->bd_partno);
-			if (!(disk->flags & GENHD_FL_UP) ||
-			    !bdev->bd_part || !bdev_nr_sectors(bdev)) {
-				ret = -ENXIO;
-				goto out_clear;
-			}
+			ret = -ENXIO;
+			if (!bdev_nr_sectors(bdev))
+				goto out_put_whole;
 			set_init_blocksize(bdev);
 		}
 
@@ -1453,6 +1446,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 				goto out_unlock_bdev;
 		}
 	}
+
 	bdev->bd_openers++;
 	if (for_part) {
 		bdev->bd_part_count++;
@@ -1482,11 +1476,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		put_disk_and_module(disk);
 	return 0;
 
- out_clear:
-	disk_put_part(bdev->bd_part);
-	bdev->bd_part = NULL;
-	if (bdev_is_partition(bdev))
-		__blkdev_put(bdev_whole(bdev), mode, 1);
+ out_put_whole:
+	__blkdev_put(bdev_whole(bdev), mode, 1);
  out_unlock_bdev:
 	if (!for_part && (mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, holder);
@@ -1679,8 +1670,6 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 		if (!bdev_is_partition(bdev) && disk->fops->release)
 			disk->fops->release(disk, mode);
 
-		disk_put_part(bdev->bd_part);
-		bdev->bd_part = NULL;
 		if (bdev_is_partition(bdev))
 			victim = bdev_whole(bdev);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6633b20224d509..c303a0ff0b1701 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4048,9 +4048,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_sb = sb;
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
 	sbi->s_sb_block = sb_block;
-	if (sb->s_bdev->bd_part)
-		sbi->s_sectors_written_start =
-			part_stat_read(sb->s_bdev->bd_part, sectors[STAT_WRITE]);
+	sbi->s_sectors_written_start =
+		part_stat_read(sb->s_bdev, sectors[STAT_WRITE]);
 
 	/* Cleanup superblock name */
 	strreplace(sb->s_id, '/', '!');
@@ -5509,15 +5508,10 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 	 */
 	if (!(sb->s_flags & SB_RDONLY))
 		ext4_update_tstamp(es, s_wtime);
-	if (sb->s_bdev->bd_part)
-		es->s_kbytes_written =
-			cpu_to_le64(EXT4_SB(sb)->s_kbytes_written +
-			    ((part_stat_read(sb->s_bdev->bd_part,
-					     sectors[STAT_WRITE]) -
-			      EXT4_SB(sb)->s_sectors_written_start) >> 1));
-	else
-		es->s_kbytes_written =
-			cpu_to_le64(EXT4_SB(sb)->s_kbytes_written);
+	es->s_kbytes_written =
+		cpu_to_le64(EXT4_SB(sb)->s_kbytes_written +
+		    ((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
+		      EXT4_SB(sb)->s_sectors_written_start) >> 1));
 	if (percpu_counter_initialized(&EXT4_SB(sb)->s_freeclusters_counter))
 		ext4_free_blocks_count_set(es,
 			EXT4_C2B(EXT4_SB(sb), percpu_counter_sum_positive(
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 4e27fe6ed3ae6a..075aa3a19ff5f1 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -62,11 +62,8 @@ static ssize_t session_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
 {
 	struct super_block *sb = sbi->s_buddy_cache->i_sb;
 
-	if (!sb->s_bdev->bd_part)
-		return snprintf(buf, PAGE_SIZE, "0\n");
 	return snprintf(buf, PAGE_SIZE, "%lu\n",
-			(part_stat_read(sb->s_bdev->bd_part,
-					sectors[STAT_WRITE]) -
+			(part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
 			 sbi->s_sectors_written_start) >> 1);
 }
 
@@ -74,12 +71,9 @@ static ssize_t lifetime_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
 {
 	struct super_block *sb = sbi->s_buddy_cache->i_sb;
 
-	if (!sb->s_bdev->bd_part)
-		return snprintf(buf, PAGE_SIZE, "0\n");
 	return snprintf(buf, PAGE_SIZE, "%llu\n",
 			(unsigned long long)(sbi->s_kbytes_written +
-			((part_stat_read(sb->s_bdev->bd_part,
-					 sectors[STAT_WRITE]) -
+			((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
 			  EXT4_SB(sb)->s_sectors_written_start) >> 1)));
 }
 
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 023462e80e58d5..54a1905af052cc 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1395,7 +1395,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	__u32 crc32 = 0;
 	int i;
 	int cp_payload_blks = __cp_payload(sbi);
-	struct super_block *sb = sbi->sb;
 	struct curseg_info *seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	u64 kbytes_written;
 	int err;
@@ -1489,9 +1488,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	start_blk += data_sum_blocks;
 
 	/* Record write statistics in the hot node summary */
-	kbytes_written = sbi->kbytes_written;
-	if (sb->s_bdev->bd_part)
-		kbytes_written += BD_PART_WRITTEN(sbi);
+	kbytes_written = sbi->kbytes_written + BD_PART_WRITTEN(sbi);
 
 	seg_i->journal->info.kbytes_written = cpu_to_le64(kbytes_written);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cb700d79729680..5f9522d4c727fb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1675,7 +1675,7 @@ static inline bool f2fs_is_multi_device(struct f2fs_sb_info *sbi)
  * and the return value is in kbytes. s is of struct f2fs_sb_info.
  */
 #define BD_PART_WRITTEN(s)						 \
-(((u64)part_stat_read((s)->sb->s_bdev->bd_part, sectors[STAT_WRITE]) -   \
+(((u64)part_stat_read((s)->sb->s_bdev, sectors[STAT_WRITE]) -   \
 		(s)->sectors_written_start) >> 1)
 
 static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d4e7fab352bacb..fae92285f561b4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3700,10 +3700,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	/* For write statistics */
-	if (sb->s_bdev->bd_part)
-		sbi->sectors_written_start =
-			(u64)part_stat_read(sb->s_bdev->bd_part,
-					    sectors[STAT_WRITE]);
+	sbi->sectors_written_start =
+		part_stat_read(sb->s_bdev, sectors[STAT_WRITE]);
 
 	/* Read accumulated write IO statistics if exists */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index ec77ccfea923dc..24e876e849c512 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -90,11 +90,6 @@ static ssize_t free_segments_show(struct f2fs_attr *a,
 static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	struct super_block *sb = sbi->sb;
-
-	if (!sb->s_bdev->bd_part)
-		return sprintf(buf, "0\n");
-
 	return sprintf(buf, "%llu\n",
 			(unsigned long long)(sbi->kbytes_written +
 			BD_PART_WRITTEN(sbi)));
@@ -103,12 +98,8 @@ static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 static ssize_t features_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	struct super_block *sb = sbi->sb;
 	int len = 0;
 
-	if (!sb->s_bdev->bd_part)
-		return sprintf(buf, "0\n");
-
 	if (f2fs_sb_has_encrypt(sbi))
 		len += scnprintf(buf, PAGE_SIZE - len, "%s",
 						"encryption");
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 453b940b87d8e9..a30559501dfe17 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 #include <linux/bvec.h>
+#include <linux/device.h>
 #include <linux/ktime.h>
 
 struct bio_set;
@@ -20,7 +21,13 @@ typedef void (bio_end_io_t) (struct bio *);
 struct bio_crypt_ctx;
 
 struct block_device {
+	sector_t		bd_start_sect;
+	unsigned long		bd_stamp;
+	struct disk_stats __percpu *bd_stats;
+	u8			bd_partno;
+	int			bd_policy;
 	dev_t			bd_dev;
+	struct device		bd_device;
 	int			bd_openers;
 	struct inode *		bd_inode;	/* will die */
 	struct super_block *	bd_super;
@@ -32,8 +39,7 @@ struct block_device {
 #ifdef CONFIG_SYSFS
 	struct list_head	bd_holder_disks;
 #endif
-	u8			bd_partno;
-	struct hd_struct *	bd_part;
+	struct kobject		*bd_holder_dir;
 	/* number of times partitions within this device have been opened. */
 	unsigned		bd_part_count;
 
@@ -45,13 +51,22 @@ struct block_device {
 	int			bd_fsfreeze_count;
 	/* Mutex for freeze */
 	struct mutex		bd_fsfreeze_mutex;
+
+	struct partition_meta_info *bd_meta_info;
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	int			bd_make_it_fail;
+#endif
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
-	((_bdev)->bd_disk->part0.bdev)
+	((_bdev)->bd_disk->part0)
+
+#define dev_to_bdev(device) \
+	container_of((device), struct block_device, bd_device)
+#define part_to_dev(part)	(&((part)->bd_device))
 
 #define bdev_kobj(_bdev) \
-	(&part_to_dev((_bdev)->bd_part)->kobj)
+	(&part_to_dev((_bdev))->kobj)
 
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 696b2f9c5529d8..ed40144ab80339 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -191,7 +191,7 @@ struct request {
 	};
 
 	struct gendisk *rq_disk;
-	struct hd_struct *part;
+	struct block_device *bdev;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
 	/* Time that the first bio started allocating this request. */
 	u64 alloc_time_ns;
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
 
@@ -1943,9 +1943,9 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 		unsigned long start_time);
 
-unsigned long part_start_io_acct(struct gendisk *disk, struct hd_struct **part,
-				 struct bio *bio);
-void part_end_io_acct(struct hd_struct *part, struct bio *bio,
+unsigned long part_start_io_acct(struct gendisk *disk,
+		struct block_device **part, struct bio *bio);
+void part_end_io_acct(struct block_device *part, struct bio *bio,
 		      unsigned long start_time);
 
 /**
@@ -1996,7 +1996,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
 void bdev_add(struct block_device *bdev, dev_t dev);
 struct block_device *bdget(dev_t dev);
 struct block_device *I_BDEV(struct inode *inode);
-struct block_device *bdget_part(struct hd_struct *part);
 struct block_device *bdgrab(struct block_device *bdev);
 void bdput(struct block_device *);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index e01618dfafc05c..6da7bfd6b0bd2a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -19,11 +19,6 @@
 #include <linux/blk_types.h>
 #include <asm/local.h>
 
-#define dev_to_disk(device)	container_of((device), struct gendisk, part0.__dev)
-#define dev_to_part(device)	container_of((device), struct hd_struct, __dev)
-#define disk_to_dev(disk)	(&(disk)->part0.__dev)
-#define part_to_dev(part)	(&((part)->__dev))
-
 extern const struct device_type disk_type;
 extern struct device_type part_type;
 extern struct class block_class;
@@ -50,23 +45,6 @@ struct partition_meta_info {
 	u8 volname[PARTITION_META_INFO_VOLNAMELTH];
 };
 
-struct hd_struct {
-	sector_t start_sect;
-	unsigned long stamp;
-	struct disk_stats __percpu *dkstats;
-	struct percpu_ref ref;
-
-	struct block_device *bdev;
-	struct device __dev;
-	struct kobject *holder_dir;
-	int policy, partno;
-	struct partition_meta_info *info;
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-	int make_it_fail;
-#endif
-	struct rcu_work rcu_work;
-};
-
 /**
  * DOC: genhd capability flags
  *
@@ -141,8 +119,8 @@ enum {
 struct disk_part_tbl {
 	struct rcu_head rcu_head;
 	int len;
-	struct hd_struct __rcu *last_lookup;
-	struct hd_struct __rcu *part[];
+	struct block_device __rcu *last_lookup;
+	struct block_device __rcu *part[];
 };
 
 struct disk_events;
@@ -176,7 +154,7 @@ struct gendisk {
 	 * helpers.
 	 */
 	struct disk_part_tbl __rcu *part_tbl;
-	struct hd_struct part0;
+	struct block_device *part0;
 
 	const struct block_device_operations *fops;
 	struct request_queue *queue;
@@ -202,23 +180,17 @@ struct gendisk {
 	struct lockdep_map lockdep_map;
 };
 
+#define dev_to_disk(device) \
+	(dev_to_bdev(device)->bd_disk)
+#define disk_to_dev(disk) \
+	(part_to_dev((disk)->part0))
+
 #if IS_REACHABLE(CONFIG_CDROM)
 #define disk_to_cdi(disk)	((disk)->cdi)
 #else
 #define disk_to_cdi(disk)	NULL
 #endif
 
-static inline struct gendisk *part_to_disk(struct hd_struct *part)
-{
-	if (likely(part)) {
-		if (part->partno)
-			return dev_to_disk(part_to_dev(part)->parent);
-		else
-			return dev_to_disk(part_to_dev(part));
-	}
-	return NULL;
-}
-
 static inline int disk_max_parts(struct gendisk *disk)
 {
 	if (disk->flags & GENHD_FL_EXT_DEVT)
@@ -237,19 +209,6 @@ static inline dev_t disk_devt(struct gendisk *disk)
 	return MKDEV(disk->major, disk->first_minor);
 }
 
-static inline dev_t part_devt(struct hd_struct *part)
-{
-	return part_to_dev(part)->devt;
-}
-
-extern struct hd_struct *disk_get_part(struct gendisk *disk, int partno);
-
-static inline void disk_put_part(struct hd_struct *part)
-{
-	if (likely(part))
-		put_device(part_to_dev(part));
-}
-
 /*
  * Smarter partition iterator without context limits.
  */
@@ -260,14 +219,14 @@ static inline void disk_put_part(struct hd_struct *part)
 
 struct disk_part_iter {
 	struct gendisk		*disk;
-	struct hd_struct	*part;
+	struct block_device	*part;
 	int			idx;
 	unsigned int		flags;
 };
 
 extern void disk_part_iter_init(struct disk_part_iter *piter,
 				 struct gendisk *disk, unsigned int flags);
-extern struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter);
+struct block_device *disk_part_iter_next(struct disk_part_iter *piter);
 extern void disk_part_iter_exit(struct disk_part_iter *piter);
 extern bool disk_has_partitions(struct gendisk *disk);
 
@@ -291,7 +250,7 @@ extern void set_disk_ro(struct gendisk *disk, int flag);
 
 static inline int get_disk_ro(struct gendisk *disk)
 {
-	return disk->part0.policy;
+	return disk->part0->bd_policy;
 }
 
 extern void disk_block_events(struct gendisk *disk);
@@ -305,7 +264,7 @@ extern void rand_initialize_disk(struct gendisk *disk);
 
 static inline sector_t get_start_sect(struct block_device *bdev)
 {
-	return bdev->bd_part->start_sect;
+	return bdev->bd_start_sect;
 }
 	
 static inline sector_t bdev_nr_sectors(struct block_device *bdev)
@@ -315,7 +274,7 @@ static inline sector_t bdev_nr_sectors(struct block_device *bdev)
 	
 static inline sector_t get_capacity(struct gendisk *disk)
 {
-	return bdev_nr_sectors(disk->part0.bdev);
+	return bdev_nr_sectors(disk->part0);
 }
 
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 24125778ef3ec7..3b3621b4983a58 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -25,26 +25,26 @@ struct disk_stats {
 #define part_stat_unlock()	preempt_enable()
 
 #define part_stat_get_cpu(part, field, cpu)				\
-	(per_cpu_ptr((part)->dkstats, (cpu))->field)
+	(per_cpu_ptr((part)->bd_stats, (cpu))->field)
 
 #define part_stat_get(part, field)					\
 	part_stat_get_cpu(part, field, smp_processor_id())
 
 #define part_stat_read(part, field)					\
 ({									\
-	typeof((part)->dkstats->field) res = 0;				\
+	typeof((part)->bd_stats->field) res = 0;				\
 	unsigned int _cpu;						\
 	for_each_possible_cpu(_cpu)					\
-		res += per_cpu_ptr((part)->dkstats, _cpu)->field;	\
+		res += per_cpu_ptr((part)->bd_stats, _cpu)->field;	\
 	res;								\
 })
 
-static inline void part_stat_set_all(struct hd_struct *part, int value)
+static inline void part_stat_set_all(struct block_device *bdev, int value)
 {
 	int i;
 
 	for_each_possible_cpu(i)
-		memset(per_cpu_ptr(part->dkstats, i), value,
+		memset(per_cpu_ptr(bdev->bd_stats, i), value,
 				sizeof(struct disk_stats));
 }
 
@@ -54,13 +54,12 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 	 part_stat_read(part, field[STAT_DISCARD]))
 
 #define __part_stat_add(part, field, addnd)				\
-	__this_cpu_add((part)->dkstats->field, addnd)
+	__this_cpu_add((part)->bd_stats->field, addnd)
 
 #define part_stat_add(part, field, addnd)	do {			\
 	__part_stat_add((part), field, addnd);				\
-	if ((part)->partno)						\
-		__part_stat_add(&part_to_disk((part))->part0,		\
-				field, addnd);				\
+	if ((part)->bd_partno)						\
+		__part_stat_add((part)->bd_disk->part0, field, addnd);	\
 } while (0)
 
 #define part_stat_dec(gendiskp, field)					\
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5879edf083b318..a78e44ee6adb8d 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -76,11 +76,11 @@ struct uuidcmp {
  */
 static int match_dev_by_uuid(struct device *dev, const void *data)
 {
+	struct block_device *bdev = dev_to_bdev(dev);
 	const struct uuidcmp *cmp = data;
-	struct hd_struct *part = dev_to_part(dev);
 
-	if (!part->info ||
-	    strncasecmp(cmp->uuid, part->info->uuid, cmp->len))
+	if (!bdev->bd_meta_info ||
+	    strncasecmp(cmp->uuid, bdev->bd_meta_info->uuid, cmp->len))
 		return 0;
 	return 1;
 }
@@ -133,13 +133,13 @@ static dev_t devt_from_partuuid(const char *uuid_str)
 		 * Attempt to find the requested partition by adding an offset
 		 * to the partition number found by UUID.
 		 */
-		struct hd_struct *part;
+		struct block_device *part;
 
-		part = disk_get_part(dev_to_disk(dev),
-				     dev_to_part(dev)->partno + offset);
+		part = bdget_disk(dev_to_disk(dev),
+				  dev_to_bdev(dev)->bd_partno + offset);
 		if (part) {
-			devt = part_devt(part);
-			put_device(part_to_dev(part));
+			devt = part->bd_dev;
+			bdput(part);
 		}
 	} else {
 		devt = dev->devt;
@@ -166,10 +166,10 @@ static dev_t devt_from_partuuid(const char *uuid_str)
  */
 static int match_dev_by_label(struct device *dev, const void *data)
 {
+	struct block_device *bdev = dev_to_bdev(dev);
 	const char *label = data;
-	struct hd_struct *part = dev_to_part(dev);
 
-	if (!part->info || strcmp(label, part->info->volname))
+	if (!bdev->bd_meta_info || strcmp(label, bdev->bd_meta_info->volname))
 		return 0;
 	return 1;
 }
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7076d588a50d69..a482a37848bff7 100644
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
@@ -1815,30 +1810,15 @@ static ssize_t blk_trace_mask2str(char *buf, int mask)
 	return p - buf;
 }
 
-static struct request_queue *blk_trace_get_queue(struct block_device *bdev)
-{
-	if (bdev->bd_disk == NULL)
-		return NULL;
-
-	return bdev_get_queue(bdev);
-}
-
 static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct block_device *bdev = bdget_part(dev_to_part(dev));
-	struct request_queue *q;
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct request_queue *q = bdev_get_queue(bdev);
 	struct blk_trace *bt;
 	ssize_t ret = -ENXIO;
 
-	if (bdev == NULL)
-		goto out;
-
-	q = blk_trace_get_queue(bdev);
-	if (q == NULL)
-		goto out_bdput;
-
 	mutex_lock(&q->debugfs_mutex);
 
 	bt = rcu_dereference_protected(q->blk_trace,
@@ -1861,9 +1841,6 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 
 out_unlock_bdev:
 	mutex_unlock(&q->debugfs_mutex);
-out_bdput:
-	bdput(bdev);
-out:
 	return ret;
 }
 
@@ -1871,8 +1848,8 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t count)
 {
-	struct block_device *bdev;
-	struct request_queue *q;
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct request_queue *q = bdev_get_queue(bdev);
 	struct blk_trace *bt;
 	u64 value;
 	ssize_t ret = -EINVAL;
@@ -1888,17 +1865,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 				goto out;
 			value = ret;
 		}
-	} else if (kstrtoull(buf, 0, &value))
-		goto out;
-
-	ret = -ENXIO;
-	bdev = bdget_part(dev_to_part(dev));
-	if (bdev == NULL)
-		goto out;
-
-	q = blk_trace_get_queue(bdev);
-	if (q == NULL)
-		goto out_bdput;
+	} else {
+		if (kstrtoull(buf, 0, &value))
+			goto out;
+	}
 
 	mutex_lock(&q->debugfs_mutex);
 
@@ -1936,8 +1906,6 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 
 out_unlock_bdev:
 	mutex_unlock(&q->debugfs_mutex);
-out_bdput:
-	bdput(bdev);
 out:
 	return ret ? ret : count;
 }
-- 
2.29.2

