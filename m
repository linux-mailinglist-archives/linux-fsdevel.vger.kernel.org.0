Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B18D1ADD18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 14:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgDQMPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 08:15:55 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50643 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgDQMPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587125755; x=1618661755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n0oh3nH0mBwW3eyPFRpwMZNXVU9DU6b4e5ZfmVFoSEk=;
  b=S7vogfm6oB32RF9dyBjt4kW04BNnZrg6lYD9E4j44yds0TQIZ/8lVv7f
   085z/rZ13Su0Z5c24sD+10JocwMbIwYazoUn4S2djv7IlhZbxHBb5e5vx
   Sxvx0gwE9ILELmewzxYTlTVaM8JmL9pgkhHzpTmRqOT2RKJnuEVgJXP8q
   y1JtjgsMisMBKusA8ziCv3eijgUY9yIawdHKf1fLLh5ngXbJrYTBoNwY1
   vjroo9VIXvOS+cxRYfOjW5mdetqdQiby/iAFqcmrc437HToU+S6u7zK86
   AZ4LBqa5O6tM47EJwOWo+SQQEPtjg63CTACbPni3LeT3JVB0H0B9XtQZu
   w==;
IronPort-SDR: 3knQVrrV9rM0Xr04cxwPBbTmX7V+5rAeNsKpp6UlPJCFykS2vv1CmnVMUvyUcnyqEebFY9Gd8h
 Y7Of1smmsWHgpgVPjlgOwZQWYm9cXkhdmyPXz33QqtI/MI1nvvtl/RCGuRyPB4fw7LNJWkU3it
 bp82eSTFnd2dSOPp7mF6ebMLiX4gzlM1V01HfpIdCwvKx7NOx/ttybjkFtNP5BsL4BtkMziFaW
 ze+qMWquLbCX9gFy/IE3Jdd7xEXIoEYQY9PMw2mmZT2DrJ4tGL2qxbhtlf+HUBBxctXrdj5yLn
 EFw=
X-IronPort-AV: E=Sophos;i="5.72,394,1580745600"; 
   d="scan'208";a="237989203"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 20:15:54 +0800
IronPort-SDR: SY91Ep5Ix4PQyTDmgsjeAyVXmEwgVJqrr6sY/rkoGX3qxYNq1BFYWorkQ/ZBhrjSuVY13rbh9H
 B8fbaG3/VFns1EWg901aQZvQrW8r3RPBM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:06:51 -0700
IronPort-SDR: HSC8wp4m42cPTmyZmQj6b2U3uBFUQBzWLvaEoVNRnuWXNaeVHNmcBrKSUPglKBMJplDBthowOS
 CLue03tTwHkQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2020 05:15:52 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 04/11] block: Introduce REQ_OP_ZONE_APPEND
Date:   Fri, 17 Apr 2020 21:15:29 +0900
Message-Id: <20200417121536.5393-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Define REQ_OP_ZONE_APPEND to append-write sectors to a zone of a zoned
block device. This is a no-merge write operation.

A zone append write BIO must:
* Target a zoned block device
* Have a sector position indicating the start sector of the target zone
* The target zone must be a sequential write zone
* The BIO must not cross a zone boundary
* The BIO size must not be split to ensure that a single range of LBAs
  is written with a single command.

Implement these checks in generic_make_request_checks() using the
helper function blk_check_zone_append(). To avoid write append BIO
splitting, introduce the new max_zone_append_sectors queue limit
attribute and ensure that a BIO size is always lower than this limit.
Export this new limit through sysfs and check these limits in bio_full().

Also when a LLDD can't dispatch a request to a specific zone, it
will return BLK_STS_ZONE_RESOURCE indicating this request needs to
be delayed, e.g.  because the zone it will be dispatched to is still
write-locked. If this happens set the request aside in a local list
to continue trying dispatching requests such as READ requests or a
WRITE/ZONE_APPEND requests targetting other zones. This way we can
still keep a high queue depth without starving other requests even if
one request can't be served due to zone write-locking.

Finally, make sure that the bio sector position indicates the actual
write position as indicated by the device on completion.

Signed-off-by: Keith Busch <kbusch@kernel.org>
[ jth: added zone-append specific add_page and merge_page helpers ]
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c               | 64 ++++++++++++++++++++++++++++++++++++---
 block/blk-core.c          | 52 +++++++++++++++++++++++++++++++
 block/blk-mq.c            | 27 +++++++++++++++++
 block/blk-settings.c      | 23 ++++++++++++++
 block/blk-sysfs.c         | 13 ++++++++
 drivers/scsi/scsi_lib.c   |  1 +
 include/linux/blk_types.h | 14 +++++++++
 include/linux/blkdev.h    | 11 +++++++
 8 files changed, 200 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0f0e337e46b4..97baadc6d964 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1006,7 +1006,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 				put_page(page);
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len)))
-                                return -EINVAL;
+				 return -EINVAL;
 			__bio_add_page(bio, page, len, offset);
 		}
 		offset = 0;
@@ -1016,6 +1016,50 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	return 0;
 }
 
+static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
+{
+	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
+	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
+	struct request_queue *q = bio->bi_disk->queue;
+	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
+	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
+	struct page **pages = (struct page **)bv;
+	ssize_t size, left;
+	unsigned len, i;
+	size_t offset;
+
+	if (WARN_ON_ONCE(!max_append_sectors))
+		return 0;
+
+	/*
+	 * Move page array up in the allocated memory for the bio vecs as far as
+	 * possible so that we can start filling biovecs from the beginning
+	 * without overwriting the temporary page array.
+	 */
+	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
+	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
+
+	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	if (unlikely(size <= 0))
+		return size ? size : -EFAULT;
+
+	for (left = size, i = 0; left > 0; left -= len, i++) {
+		struct page *page = pages[i];
+		bool same_page = false;
+
+		len = min_t(size_t, PAGE_SIZE - offset, left);
+		if (bio_add_hw_page(q, bio, page, len, offset,
+				max_append_sectors, &same_page) != len)
+			return -EINVAL;
+		if (same_page)
+			put_page(page);
+		offset = 0;
+	}
+
+	iov_iter_advance(iter, size);
+	return 0;
+}
+
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
@@ -1045,10 +1089,16 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		return -EINVAL;
 
 	do {
-		if (is_bvec)
-			ret = __bio_iov_bvec_add_pages(bio, iter);
-		else
-			ret = __bio_iov_iter_get_pages(bio, iter);
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			if (WARN_ON_ONCE(is_bvec))
+				return -EINVAL;
+			ret = __bio_iov_append_get_pages(bio, iter);
+		} else {
+			if (is_bvec)
+				ret = __bio_iov_bvec_add_pages(bio, iter);
+			else
+				ret = __bio_iov_iter_get_pages(bio, iter);
+		}
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
 
 	if (is_bvec)
@@ -1451,6 +1501,10 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
 
+	/* Zone append commands cannot be split */
+	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
+		return NULL;
+
 	split = bio_clone_fast(bio, gfp, bs);
 	if (!split)
 		return NULL;
diff --git a/block/blk-core.c b/block/blk-core.c
index 7e4a1da0715e..34fe47a728c3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -135,6 +135,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(ZONE_OPEN),
 	REQ_OP_NAME(ZONE_CLOSE),
 	REQ_OP_NAME(ZONE_FINISH),
+	REQ_OP_NAME(ZONE_APPEND),
 	REQ_OP_NAME(WRITE_SAME),
 	REQ_OP_NAME(WRITE_ZEROES),
 	REQ_OP_NAME(SCSI_IN),
@@ -240,6 +241,17 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 
 	bio_advance(bio, nbytes);
 
+	if (req_op(rq) == REQ_OP_ZONE_APPEND && error == BLK_STS_OK) {
+		/*
+		 * Partial zone append completions cannot be supported as the
+		 * BIO fragments may end up not being written sequentially.
+		 */
+		if (bio->bi_iter.bi_size)
+			bio->bi_status = BLK_STS_IOERR;
+		else
+			bio->bi_iter.bi_sector = rq->__sector;
+	}
+
 	/* don't actually finish bio if it's part of flush sequence */
 	if (bio->bi_iter.bi_size == 0 && !(rq->rq_flags & RQF_FLUSH_SEQ))
 		bio_endio(bio);
@@ -871,6 +883,41 @@ static inline int blk_partition_remap(struct bio *bio)
 	return ret;
 }
 
+/*
+ * Check write append to a zoned block device.
+ */
+static inline blk_status_t blk_check_zone_append(struct request_queue *q,
+						 struct bio *bio)
+{
+	sector_t pos = bio->bi_iter.bi_sector;
+	int nr_sectors = bio_sectors(bio);
+
+	/* Only applicable to zoned block devices */
+	if (!blk_queue_is_zoned(q))
+		return BLK_STS_NOTSUPP;
+
+	/* The bio sector must point to the start of a sequential zone */
+	if (pos & (blk_queue_zone_sectors(q) - 1) ||
+	    !blk_queue_zone_is_seq(q, pos))
+		return BLK_STS_IOERR;
+
+	/*
+	 * Not allowed to cross zone boundaries. Otherwise, the BIO will be
+	 * split and could result in non-contiguous sectors being written in
+	 * different zones.
+	 */
+	if (blk_queue_zone_no(q, pos) != blk_queue_zone_no(q, pos + nr_sectors))
+		return BLK_STS_IOERR;
+
+	/* Make sure the BIO is small enough and will not get split */
+	if (nr_sectors > q->limits.max_zone_append_sectors)
+		return BLK_STS_IOERR;
+
+	bio->bi_opf |= REQ_NOMERGE;
+
+	return BLK_STS_OK;
+}
+
 static noinline_for_stack bool
 generic_make_request_checks(struct bio *bio)
 {
@@ -943,6 +990,11 @@ generic_make_request_checks(struct bio *bio)
 		if (!q->limits.max_write_same_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_ZONE_APPEND:
+		status = blk_check_zone_append(q, bio);
+		if (status != BLK_STS_OK)
+			goto end_io;
+		break;
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8e56884fd2e9..50e216a218ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1195,6 +1195,19 @@ static void blk_mq_handle_dev_resource(struct request *rq,
 	__blk_mq_requeue_request(rq);
 }
 
+static void blk_mq_handle_zone_resource(struct request *rq,
+					struct list_head *zone_list)
+{
+	/*
+	 * If we end up here it is because we cannot dispatch a request to a
+	 * specific zone due to LLD level zone-write locking or other zone
+	 * related resource not being available. In this case, set the request
+	 * aside in zone_list for retrying it later.
+	 */
+	list_add(&rq->queuelist, zone_list);
+	__blk_mq_requeue_request(rq);
+}
+
 /*
  * Returns true if we did some work AND can potentially do more.
  */
@@ -1206,6 +1219,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
+	LIST_HEAD(zone_list);
 
 	if (list_empty(list))
 		return false;
@@ -1264,6 +1278,16 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
 			blk_mq_handle_dev_resource(rq, list);
 			break;
+		} else if (ret == BLK_STS_ZONE_RESOURCE) {
+			/*
+			 * Move the request to zone_list and keep going through
+			 * the dispatch list to find more requests the drive can
+			 * accept.
+			 */
+			blk_mq_handle_zone_resource(rq, &zone_list);
+			if (list_empty(list))
+				break;
+			continue;
 		}
 
 		if (unlikely(ret != BLK_STS_OK)) {
@@ -1275,6 +1299,9 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		queued++;
 	} while (!list_empty(list));
 
+	if (!list_empty(&zone_list))
+		list_splice_tail_init(&zone_list, list);
+
 	hctx->dispatched[queued_to_index(queued)]++;
 
 	/*
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 14397b4c4b53..58d5b49fb131 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -48,6 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->chunk_sectors = 0;
 	lim->max_write_same_sectors = 0;
 	lim->max_write_zeroes_sectors = 0;
+	lim->max_zone_append_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
 	lim->discard_granularity = 0;
@@ -83,6 +84,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_same_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
+	lim->max_zone_append_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -221,6 +223,25 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
 
+/**
+ * blk_queue_max_zone_append_sectors - set max sectors for a single zone append
+ * @q:  the request queue for the device
+ * @max_zone_append_sectors: maximum number of sectors to write per command
+ **/
+void blk_queue_max_zone_append_sectors(struct request_queue *q,
+		unsigned int max_zone_append_sectors)
+{
+	unsigned int max_sectors;
+
+	max_sectors = min(q->limits.max_hw_sectors, max_zone_append_sectors);
+	if (max_sectors)
+		max_sectors = min_not_zero(q->limits.chunk_sectors,
+					   max_sectors);
+
+	q->limits.max_zone_append_sectors = max_sectors;
+}
+EXPORT_SYMBOL_GPL(blk_queue_max_zone_append_sectors);
+
 /**
  * blk_queue_max_segments - set max hw segments for a request for this queue
  * @q:  the request queue for the device
@@ -470,6 +491,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 					b->max_write_same_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
+	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
+					b->max_zone_append_sectors);
 	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..02643e149d5e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -218,6 +218,13 @@ static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
 		(unsigned long long)q->limits.max_write_zeroes_sectors << 9);
 }
 
+static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
+{
+	unsigned long long max_sectors = q->limits.max_zone_append_sectors;
+
+	return sprintf(page, "%llu\n", max_sectors << SECTOR_SHIFT);
+}
+
 static ssize_t
 queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 {
@@ -639,6 +646,11 @@ static struct queue_sysfs_entry queue_write_zeroes_max_entry = {
 	.show = queue_write_zeroes_max_show,
 };
 
+static struct queue_sysfs_entry queue_zone_append_max_entry = {
+	.attr = {.name = "zone_append_max_bytes", .mode = 0444 },
+	.show = queue_zone_append_max_show,
+};
+
 static struct queue_sysfs_entry queue_nonrot_entry = {
 	.attr = {.name = "rotational", .mode = 0644 },
 	.show = queue_show_nonrot,
@@ -749,6 +761,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_zeroes_data_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
+	&queue_zone_append_max_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ad97369ffabd..b9e8f55cf8c4 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1690,6 +1690,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case BLK_STS_OK:
 		break;
 	case BLK_STS_RESOURCE:
+	case BLK_STS_ZONE_RESOURCE:
 		if (atomic_read(&sdev->device_busy) ||
 		    scsi_device_blocked(sdev))
 			ret = BLK_STS_DEV_RESOURCE;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..824ec2d89954 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -63,6 +63,18 @@ typedef u8 __bitwise blk_status_t;
  */
 #define BLK_STS_DEV_RESOURCE	((__force blk_status_t)13)
 
+/*
+ * BLK_STS_ZONE_RESOURCE is returned from the driver to the block layer if zone
+ * related resources are unavailable, but the driver can guarantee the queue
+ * will be rerun in the future once the resources become available again.
+ *
+ * This is different from BLK_STS_DEV_RESOURCE in that it explicitly references
+ * a zone specific resource and IO to a different zone on the same device could
+ * still be served. Examples of that are zones that are write-locked, but a read
+ * to the same zone could be served.
+ */
+#define BLK_STS_ZONE_RESOURCE	((__force blk_status_t)14)
+
 /**
  * blk_path_error - returns true if error may be path related
  * @error: status the request was completed with
@@ -296,6 +308,8 @@ enum req_opf {
 	REQ_OP_ZONE_CLOSE	= 11,
 	/* Transition a zone to full */
 	REQ_OP_ZONE_FINISH	= 12,
+	/* write data at the current zone write pointer */
+	REQ_OP_ZONE_APPEND	= 13,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e47888a7d80b..774947365341 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -336,6 +336,7 @@ struct queue_limits {
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_write_same_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 
@@ -757,6 +758,9 @@ static inline bool rq_mergeable(struct request *rq)
 	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
 		return false;
 
+	if (req_op(rq) == REQ_OP_ZONE_APPEND)
+		return false;
+
 	if (rq->cmd_flags & REQ_NOMERGE_FLAGS)
 		return false;
 	if (rq->rq_flags & RQF_NOMERGE_FLAGS)
@@ -1091,6 +1095,8 @@ extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
+extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
+		unsigned int max_zone_append_sectors);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
@@ -1303,6 +1309,11 @@ static inline unsigned int queue_max_segment_size(const struct request_queue *q)
 	return q->limits.max_segment_size;
 }
 
+static inline unsigned int queue_max_zone_append_sectors(const struct request_queue *q)
+{
+	return q->limits.max_zone_append_sectors;
+}
+
 static inline unsigned queue_logical_block_size(const struct request_queue *q)
 {
 	int retval = 512;
-- 
2.24.1

