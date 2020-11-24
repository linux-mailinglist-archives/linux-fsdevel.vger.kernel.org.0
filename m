Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA5D2C27AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbgKXN3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbgKXN3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:29:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D37C0617A6;
        Tue, 24 Nov 2020 05:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5Ieqq2Esw2uH5DQ55aOZnqozMhcSVzcFskydpUrvjJE=; b=KNQXXXOsTK2/JcBFY0rAA5ZlcX
        0rxJfId/S/351sZwDEqvhFA5c390U1uD4rylUhYaRKFg6CHczRQ6dUEDPhs0M7k/Ew/fVtt/Ov3Un
        niAnpMHWjhkbP2ser95j7h5EO/ke/sf/VNnHk/BA61UsjvvFwXXFK3SXoKswP+8eqJNkECNtH2s+3
        dW14guawsNUlVQtDHx4od51EcFJ04Di1WK123CesbbjdLVyDBRRoNvDjgxWoz2zoAtO4eQNpozYzv
        +QPQTB8IQ6tJu6EdUxjALmqoj+dwd+Q7jxcE+yPo/Eu3D7cyiB4M1I2Gc9ofwlW8yUpSWCagJHjxu
        LaUf7O+A==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYNO-0006gl-Gq; Tue, 24 Nov 2020 13:28:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 38/45] block: switch partition lookup to use struct block_device
Date:   Tue, 24 Nov 2020 14:27:44 +0100
Message-Id: <20201124132751.3747337-39-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use struct block_device to lookup partitions on a disk.  This removes
all usage of struct hd_struct from the I/O path, and this allows removing
the percpu refcount in struct hd_struct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                        |  4 +-
 block/blk-core.c                   | 66 ++++++++++++++----------------
 block/blk-flush.c                  |  2 +-
 block/blk-mq.c                     |  9 ++--
 block/blk-mq.h                     |  7 ++--
 block/blk.h                        |  4 +-
 block/genhd.c                      | 56 +++++++++++++------------
 block/partitions/core.c            |  7 +---
 drivers/block/drbd/drbd_receiver.c |  2 +-
 drivers/block/drbd/drbd_worker.c   |  2 +-
 drivers/block/zram/zram_drv.c      |  2 +-
 drivers/md/bcache/request.c        |  4 +-
 drivers/md/dm.c                    |  4 +-
 drivers/md/md.c                    |  4 +-
 drivers/nvme/target/admin-cmd.c    | 20 ++++-----
 fs/ext4/super.c                    | 18 +++-----
 fs/ext4/sysfs.c                    | 10 +----
 fs/f2fs/f2fs.h                     |  2 +-
 fs/f2fs/super.c                    |  6 +--
 include/linux/blkdev.h             |  8 ++--
 include/linux/genhd.h              |  4 +-
 include/linux/part_stat.h          | 17 ++++----
 22 files changed, 120 insertions(+), 138 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 669bb47a31988e..ebb18136b86f2f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -608,12 +608,12 @@ void bio_truncate(struct bio *bio, unsigned new_size)
 void guard_bio_eod(struct bio *bio)
 {
 	sector_t maxsector;
-	struct hd_struct *part;
+	struct block_device *part;
 
 	rcu_read_lock();
 	part = __disk_get_part(bio->bi_disk, bio->bi_partno);
 	if (part)
-		maxsector = bdev_nr_sectors(part->bdev);
+		maxsector = bdev_nr_sectors(part);
 	else	
 		maxsector = get_capacity(bio->bi_disk);
 	rcu_read_unlock();
diff --git a/block/blk-core.c b/block/blk-core.c
index 9ea70275fc1cfe..cee568389b7e11 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -666,10 +666,9 @@ static int __init setup_fail_make_request(char *str)
 }
 __setup("fail_make_request=", setup_fail_make_request);
 
-static bool should_fail_request(struct hd_struct *part, unsigned int bytes)
+static bool should_fail_request(struct block_device *part, unsigned int bytes)
 {
-	return part->bdev->bd_make_it_fail &&
-		should_fail(&fail_make_request, bytes);
+	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
 }
 
 static int __init fail_make_request_debugfs(void)
@@ -684,7 +683,7 @@ late_initcall(fail_make_request_debugfs);
 
 #else /* CONFIG_FAIL_MAKE_REQUEST */
 
-static inline bool should_fail_request(struct hd_struct *part,
+static inline bool should_fail_request(struct block_device *part,
 					unsigned int bytes)
 {
 	return false;
@@ -692,11 +691,11 @@ static inline bool should_fail_request(struct hd_struct *part,
 
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
-static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
+static inline bool bio_check_ro(struct bio *bio, struct block_device *part)
 {
 	const int op = bio_op(bio);
 
-	if (part->bdev->bd_read_only && op_is_write(op)) {
+	if (part->bd_read_only && op_is_write(op)) {
 		char b[BDEVNAME_SIZE];
 
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
@@ -704,7 +703,7 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 
 		WARN_ONCE(1,
 		       "Trying to write to read-only block-device %s (partno %d)\n",
-			bio_devname(bio, b), part->partno);
+			bio_devname(bio, b), part->bd_partno);
 		/* Older lvm-tools actually trigger this */
 		return false;
 	}
@@ -714,8 +713,7 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 
 static noinline int should_fail_bio(struct bio *bio)
 {
-	if (should_fail_request(bio->bi_disk->part0->bd_part,
-			bio->bi_iter.bi_size))
+	if (should_fail_request(bio->bi_disk->part0, bio->bi_iter.bi_size))
 		return -EIO;
 	return 0;
 }
@@ -744,7 +742,7 @@ static inline int bio_check_eod(struct bio *bio, sector_t maxsector)
  */
 static inline int blk_partition_remap(struct bio *bio)
 {
-	struct hd_struct *p;
+	struct block_device *p;
 	int ret = -EIO;
 
 	rcu_read_lock();
@@ -757,12 +755,12 @@ static inline int blk_partition_remap(struct bio *bio)
 		goto out;
 
 	if (bio_sectors(bio)) {
-		if (bio_check_eod(bio, bdev_nr_sectors(p->bdev)))
+		if (bio_check_eod(bio, bdev_nr_sectors(p)))
 			goto out;
-		bio->bi_iter.bi_sector += p->bdev->bd_start_sect;
-		trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
+		bio->bi_iter.bi_sector += p->bd_start_sect;
+		trace_block_bio_remap(bio->bi_disk->queue, bio, p->bd_dev,
 				      bio->bi_iter.bi_sector -
-				      p->bdev->bd_start_sect);
+				      p->bd_start_sect);
 	}
 	bio->bi_partno = 0;
 	ret = 0;
@@ -832,7 +830,7 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		if (unlikely(blk_partition_remap(bio)))
 			goto end_io;
 	} else {
-		if (unlikely(bio_check_ro(bio, bio->bi_disk->part0->bd_part)))
+		if (unlikely(bio_check_ro(bio, bio->bi_disk->part0)))
 			goto end_io;
 		if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))
 			goto end_io;
@@ -1204,7 +1202,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		return ret;
 
 	if (rq->rq_disk &&
-	    should_fail_request(rq->rq_disk->part0->bd_part, blk_rq_bytes(rq)))
+	    should_fail_request(rq->rq_disk->part0, blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
 
 	if (blk_crypto_insert_cloned_request(rq))
@@ -1263,17 +1261,18 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
 
-static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
+static void update_io_ticks(struct block_device *part, unsigned long now,
+		bool end)
 {
 	unsigned long stamp;
 again:
-	stamp = READ_ONCE(part->bdev->bd_stamp);
+	stamp = READ_ONCE(part->bd_stamp);
 	if (unlikely(stamp != now)) {
-		if (likely(cmpxchg(&part->bdev->bd_stamp, stamp, now) == stamp))
+		if (likely(cmpxchg(&part->bd_stamp, stamp, now) == stamp))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
-	if (part->partno) {
-		part = part_to_disk(part)->part0->bd_part;
+	if (part->bd_partno) {
+		part = bdev_whole(part);
 		goto again;
 	}
 }
@@ -1282,11 +1281,9 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
 		const int sgrp = op_stat_group(req_op(req));
-		struct hd_struct *part;
 
 		part_stat_lock();
-		part = req->part;
-		part_stat_add(part, sectors[sgrp], bytes >> 9);
+		part_stat_add(req->part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
 }
@@ -1301,14 +1298,11 @@ void blk_account_io_done(struct request *req, u64 now)
 	if (req->part && blk_do_io_stat(req) &&
 	    !(req->rq_flags & RQF_FLUSH_SEQ)) {
 		const int sgrp = op_stat_group(req_op(req));
-		struct hd_struct *part;
 
 		part_stat_lock();
-		part = req->part;
-
-		update_io_ticks(part, jiffies, true);
-		part_stat_inc(part, ios[sgrp]);
-		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
+		update_io_ticks(req->part, jiffies, true);
+		part_stat_inc(req->part, ios[sgrp]);
+		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
 	}
 }
@@ -1325,7 +1319,7 @@ void blk_account_io_start(struct request *rq)
 	part_stat_unlock();
 }
 
-static unsigned long __part_start_io_acct(struct hd_struct *part,
+static unsigned long __part_start_io_acct(struct block_device *part,
 					  unsigned int sectors, unsigned int op)
 {
 	const int sgrp = op_stat_group(op);
@@ -1341,7 +1335,7 @@ static unsigned long __part_start_io_acct(struct hd_struct *part,
 	return now;
 }
 
-unsigned long part_start_io_acct(struct gendisk *disk, struct hd_struct **part,
+unsigned long part_start_io_acct(struct gendisk *disk, struct block_device **part,
 				 struct bio *bio)
 {
 	*part = disk_map_sector_rcu(disk, bio->bi_iter.bi_sector);
@@ -1353,11 +1347,11 @@ EXPORT_SYMBOL_GPL(part_start_io_acct);
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 				 unsigned int op)
 {
-	return __part_start_io_acct(disk->part0->bd_part, sectors, op);
+	return __part_start_io_acct(disk->part0, sectors, op);
 }
 EXPORT_SYMBOL(disk_start_io_acct);
 
-static void __part_end_io_acct(struct hd_struct *part, unsigned int op,
+static void __part_end_io_acct(struct block_device *part, unsigned int op,
 			       unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
@@ -1371,7 +1365,7 @@ static void __part_end_io_acct(struct hd_struct *part, unsigned int op,
 	part_stat_unlock();
 }
 
-void part_end_io_acct(struct hd_struct *part, struct bio *bio,
+void part_end_io_acct(struct block_device *part, struct bio *bio,
 		      unsigned long start_time)
 {
 	__part_end_io_acct(part, bio_op(bio), start_time);
@@ -1381,7 +1375,7 @@ EXPORT_SYMBOL_GPL(part_end_io_acct);
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 		      unsigned long start_time)
 {
-	__part_end_io_acct(disk->part0->bd_part, op, start_time);
+	__part_end_io_acct(disk->part0, op, start_time);
 }
 EXPORT_SYMBOL(disk_end_io_acct);
 
diff --git a/block/blk-flush.c b/block/blk-flush.c
index fcd0a60574dff8..9507dcdd58814c 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -139,7 +139,7 @@ static void blk_flush_queue_rq(struct request *rq, bool add_front)
 
 static void blk_account_io_flush(struct request *rq)
 {
-	struct hd_struct *part = rq->rq_disk->part0->bd_part;
+	struct block_device *part = rq->rq_disk->part0;
 
 	part_stat_lock();
 	part_stat_inc(part, ios[STAT_FLUSH]);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc0320c..a2593748fa5342 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -95,7 +95,7 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 }
 
 struct mq_inflight {
-	struct hd_struct *part;
+	struct block_device *part;
 	unsigned int inflight[2];
 };
 
@@ -111,7 +111,8 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 	return true;
 }
 
-unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
+unsigned int blk_mq_in_flight(struct request_queue *q,
+		struct block_device *part)
 {
 	struct mq_inflight mi = { .part = part };
 
@@ -120,8 +121,8 @@ unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
 	return mi.inflight[0] + mi.inflight[1];
 }
 
-void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
-			 unsigned int inflight[2])
+void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
+		unsigned int inflight[2])
 {
 	struct mq_inflight mi = { .part = part };
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index a52703c98b7736..c696515766c780 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -182,9 +182,10 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
-unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part);
-void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
-			 unsigned int inflight[2]);
+unsigned int blk_mq_in_flight(struct request_queue *q,
+		struct block_device *part);
+void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
+		unsigned int inflight[2]);
 
 static inline void blk_mq_put_dispatch_budget(struct request_queue *q)
 {
diff --git a/block/blk.h b/block/blk.h
index 32ac41f7557fcc..d5bf8f3a078186 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -215,7 +215,7 @@ static inline void elevator_exit(struct request_queue *q,
 	__elevator_exit(q, e);
 }
 
-struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
+struct block_device *__disk_get_part(struct gendisk *disk, int partno);
 
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
@@ -348,7 +348,7 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q);
 static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
 #endif
 
-struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
+struct block_device *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
 
 int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
 void blk_free_devt(dev_t devt);
diff --git a/block/genhd.c b/block/genhd.c
index 3bbf6d3a69ec63..197120c0c60f23 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -116,7 +116,7 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 	}
 }
 
-static unsigned int part_in_flight(struct hd_struct *part)
+static unsigned int part_in_flight(struct block_device *part)
 {
 	unsigned int inflight = 0;
 	int cpu;
@@ -131,7 +131,8 @@ static unsigned int part_in_flight(struct hd_struct *part)
 	return inflight;
 }
 
-static void part_in_flight_rw(struct hd_struct *part, unsigned int inflight[2])
+static void part_in_flight_rw(struct block_device *part,
+		unsigned int inflight[2])
 {
 	int cpu;
 
@@ -147,7 +148,7 @@ static void part_in_flight_rw(struct hd_struct *part, unsigned int inflight[2])
 		inflight[1] = 0;
 }
 
-struct hd_struct *__disk_get_part(struct gendisk *disk, int partno)
+struct block_device *__disk_get_part(struct gendisk *disk, int partno)
 {
 	struct disk_part_tbl *ptbl = rcu_dereference(disk->part_tbl);
 
@@ -172,15 +173,18 @@ struct hd_struct *__disk_get_part(struct gendisk *disk, int partno)
  */
 struct hd_struct *disk_get_part(struct gendisk *disk, int partno)
 {
-	struct hd_struct *part;
+	struct block_device *part;
 
 	rcu_read_lock();
 	part = __disk_get_part(disk, partno);
-	if (part)
-		get_device(part_to_dev(part));
-	rcu_read_unlock();
+	if (!part) {
+		rcu_read_unlock();
+		return NULL;
+	}
 
-	return part;
+	get_device(part_to_dev(part->bd_part));
+	rcu_read_unlock();
+	return part->bd_part;
 }
 
 /**
@@ -254,19 +258,19 @@ struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter)
 
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
+		get_device(part_to_dev(part->bd_part));
+		piter->part = part->bd_part;
 		piter->idx += inc;
 		break;
 	}
@@ -293,10 +297,10 @@ void disk_part_iter_exit(struct disk_part_iter *piter)
 }
 EXPORT_SYMBOL_GPL(disk_part_iter_exit);
 
-static inline int sector_in_part(struct hd_struct *part, sector_t sector)
+static inline int sector_in_part(struct block_device *part, sector_t sector)
 {
-	return part->bdev->bd_start_sect <= sector &&
-		sector < part->bdev->bd_start_sect + bdev_nr_sectors(part->bdev);
+	return part->bd_start_sect <= sector &&
+		sector < part->bd_start_sect + bdev_nr_sectors(part);
 }
 
 /**
@@ -314,10 +318,10 @@ static inline int sector_in_part(struct hd_struct *part, sector_t sector)
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
@@ -336,7 +340,7 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 		}
 	}
 
-	part = disk->part0->bd_part;
+	part = disk->part0;
 out_unlock:
 	rcu_read_unlock();
 	return part;
@@ -866,7 +870,7 @@ void del_gendisk(struct gendisk *disk)
 	kobject_put(disk->part0->bd_holder_dir);
 	kobject_put(disk->slave_dir);
 
-	part_stat_set_all(disk->part0->bd_part, 0);
+	part_stat_set_all(disk->part0, 0);
 	disk->part0->bd_stamp = 0;
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
@@ -1173,9 +1177,9 @@ ssize_t part_stat_show(struct device *dev,
 
 	part_stat_read_all(p, &stat);
 	if (queue_is_mq(q))
-		inflight = blk_mq_in_flight(q, p);
+		inflight = blk_mq_in_flight(q, p->bdev);
 	else
-		inflight = part_in_flight(p);
+		inflight = part_in_flight(p->bdev);
 
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
@@ -1215,9 +1219,9 @@ ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
 	unsigned int inflight[2];
 
 	if (queue_is_mq(q))
-		blk_mq_in_flight_rw(q, p, inflight);
+		blk_mq_in_flight_rw(q, p->bdev, inflight);
 	else
-		part_in_flight_rw(p, inflight);
+		part_in_flight_rw(p->bdev, inflight);
 
 	return sprintf(buf, "%8u %8u\n", inflight[0], inflight[1]);
 }
@@ -1490,9 +1494,9 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	while ((hd = disk_part_iter_next(&piter))) {
 		part_stat_read_all(hd, &stat);
 		if (queue_is_mq(gp->queue))
-			inflight = blk_mq_in_flight(gp->queue, hd);
+			inflight = blk_mq_in_flight(gp->queue, hd->bdev);
 		else
-			inflight = part_in_flight(hd);
+			inflight = part_in_flight(hd->bdev);
 
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
@@ -1610,7 +1614,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 		goto out_bdput;
 
 	ptbl = rcu_dereference_protected(disk->part_tbl, 1);
-	rcu_assign_pointer(ptbl->part[0], disk->part0->bd_part);
+	rcu_assign_pointer(ptbl->part[0], disk->part0);
 
 	disk->minors = minors;
 	rand_initialize_disk(disk);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 4b0352cb29e132..8beab9e7727e27 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -298,12 +298,9 @@ void delete_partition(struct hd_struct *part)
 	struct disk_part_tbl *ptbl =
 		rcu_dereference_protected(disk->part_tbl, 1);
 
-	/*
-	 * ->part_tbl is referenced in this part's release handler, so
-	 *  we have to hold the disk device
-	 */
 	rcu_assign_pointer(ptbl->part[part->partno], NULL);
 	rcu_assign_pointer(ptbl->last_lookup, NULL);
+
 	kobject_put(part->bdev->bd_holder_dir);
 	device_del(part_to_dev(part));
 
@@ -421,7 +418,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 
 	/* everything is up and running, commence */
 	bdev_add(bdev, devt);
-	rcu_assign_pointer(ptbl->part[partno], p);
+	rcu_assign_pointer(ptbl->part[partno], bdev);
 
 	/* suppress uevent if the disk suppresses it */
 	if (!dev_get_uevent_suppress(ddev))
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 9e5c2fdfda3629..09c86ef3f0fd93 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2802,7 +2802,7 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 	if (c_min_rate == 0)
 		return false;
 
-	curr_events = (int)part_stat_read_accum(disk->part0->bd_part, sectors) -
+	curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
 			atomic_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 343f56b86bb766..02044ab7f767d5 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1679,7 +1679,7 @@ void drbd_rs_controller_reset(struct drbd_device *device)
 	atomic_set(&device->rs_sect_ev, 0);
 	device->rs_in_flight = 0;
 	device->rs_last_events =
-		(int)part_stat_read_accum(disk->part0->bd_part, sectors);
+		(int)part_stat_read_accum(disk->part0, sectors);
 
 	/* Updating the RCU protected object in place is necessary since
 	   this function gets called from atomic context.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 153858734cd47d..01757f9578dcb8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1687,7 +1687,7 @@ static void zram_reset_device(struct zram *zram)
 	zram->disksize = 0;
 
 	set_capacity_and_notify(zram->disk, 0);
-	part_stat_set_all(zram->disk->part0->bd_part, 0);
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
index 1b2db4d530ea71..176adcff56b380 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1607,7 +1607,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 				 * (by eliminating DM's splitting and just using bio_split)
 				 */
 				part_stat_lock();
-				__dm_part_stat_sub(dm_disk(md)->part0->bd_part,
+				__dm_part_stat_sub(dm_disk(md)->part0,
 						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
 				part_stat_unlock();
 
@@ -2242,7 +2242,7 @@ EXPORT_SYMBOL_GPL(dm_put);
 static bool md_in_flight_bios(struct mapped_device *md)
 {
 	int cpu;
-	struct hd_struct *part = dm_disk(md)->part0->bd_part;
+	struct block_device *part = dm_disk(md)->part0;
 	long sum = 0;
 
 	for_each_possible_cpu(cpu) {
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3696c2d77a4dd7..0065736f05b428 100644
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
-		curr_events = (int)part_stat_read_accum(disk->part0->bd_part, sectors) -
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
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cb700d79729680..49681a8d2b14a5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1675,7 +1675,7 @@ static inline bool f2fs_is_multi_device(struct f2fs_sb_info *sbi)
  * and the return value is in kbytes. s is of struct f2fs_sb_info.
  */
 #define BD_PART_WRITTEN(s)						 \
-(((u64)part_stat_read((s)->sb->s_bdev->bd_part, sectors[STAT_WRITE]) -   \
+	(((u64)part_stat_read((s)->sb->s_bdev, sectors[STAT_WRITE]) -   \
 		(s)->sectors_written_start) >> 1)
 
 static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d4e7fab352bacb..af9f449da64bac 100644
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
+		(u64)part_stat_read(sb->s_bdev, sectors[STAT_WRITE]);
 
 	/* Read accumulated write IO statistics if exists */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fc0b266610f7f..0e83989b9678c3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -191,7 +191,7 @@ struct request {
 	};
 
 	struct gendisk *rq_disk;
-	struct hd_struct *part;
+	struct block_device *part;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
 	/* Time that the first bio started allocating this request. */
 	u64 alloc_time_ns;
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
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6e16c264439bdb..77443a1031e373 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -131,8 +131,8 @@ enum {
 struct disk_part_tbl {
 	struct rcu_head rcu_head;
 	int len;
-	struct hd_struct __rcu *last_lookup;
-	struct hd_struct __rcu *part[];
+	struct block_device __rcu *last_lookup;
+	struct block_device __rcu *part[];
 };
 
 struct disk_events;
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 680de036691ef9..d2558121d48c00 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -25,26 +25,26 @@ struct disk_stats {
 #define part_stat_unlock()	preempt_enable()
 
 #define part_stat_get_cpu(part, field, cpu)				\
-	(per_cpu_ptr((part)->bdev->bd_stats, (cpu))->field)
+	(per_cpu_ptr((part)->bd_stats, (cpu))->field)
 
 #define part_stat_get(part, field)					\
 	part_stat_get_cpu(part, field, smp_processor_id())
 
 #define part_stat_read(part, field)					\
 ({									\
-	typeof((part)->bdev->bd_stats->field) res = 0;			\
+	typeof((part)->bd_stats->field) res = 0;			\
 	unsigned int _cpu;						\
 	for_each_possible_cpu(_cpu)					\
-		res += per_cpu_ptr((part)->bdev->bd_stats, _cpu)->field; \
+		res += per_cpu_ptr((part)->bd_stats, _cpu)->field; \
 	res;								\
 })
 
-static inline void part_stat_set_all(struct hd_struct *part, int value)
+static inline void part_stat_set_all(struct block_device *part, int value)
 {
 	int i;
 
 	for_each_possible_cpu(i)
-		memset(per_cpu_ptr(part->bdev->bd_stats, i), value,
+		memset(per_cpu_ptr(part->bd_stats, i), value,
 				sizeof(struct disk_stats));
 }
 
@@ -54,13 +54,12 @@ static inline void part_stat_set_all(struct hd_struct *part, int value)
 	 part_stat_read(part, field[STAT_DISCARD]))
 
 #define __part_stat_add(part, field, addnd)				\
-	__this_cpu_add((part)->bdev->bd_stats->field, addnd)
+	__this_cpu_add((part)->bd_stats->field, addnd)
 
 #define part_stat_add(part, field, addnd)	do {			\
 	__part_stat_add((part), field, addnd);				\
-	if ((part)->partno)						\
-		__part_stat_add(part_to_disk((part))->part0->bd_part,	\
-			field, addnd); \
+	if ((part)->bd_partno)						\
+		__part_stat_add(bdev_whole(part), field, addnd);	\
 } while (0)
 
 #define part_stat_dec(part, field)					\
-- 
2.29.2

