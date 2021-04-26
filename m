Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D34436B464
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhDZN4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhDZN4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:56:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D99C061756;
        Mon, 26 Apr 2021 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OcCgGcT+UBp8aNqRtfACBC0J8Q2FpI7JOZM0WJ3Sv4w=; b=y0M1EdII1TQuEZkW3BF9WOk69O
        IbZMDdHUmzYrMGApHeLEhudmA6TK1Jb33tD3VovwYSQ5962EavPu9DHmmqDPGWM+Sp4a4CtNx3q+h
        6v4Hv3K2SF2AdG22g2QkUkneeYlQlmcRvt2wIqXiX2aBqhaZc11Ni/yfKUGWdfuJhJdbVSGECMgDo
        K9mkvgIAz6h5hFuJJDElFyYMiquY1pa5LANby7hy30tMk4UuqeX6RmfTDETzWrnxa5oSyzCPmtSwi
        yqdAPZddT3lfdPY/AaV0javaYiDYr7wk2TZnauWclkhaFoa1Z4aTYn7/mt3aXVaV6UW7gTo+r3YCI
        tQcoajRQ==;
Received: from [2001:4bb8:18c:28b2:8b12:7453:9423:67a4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1hu-00Fzps-8N; Mon, 26 Apr 2021 13:55:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/12] block: switch polling to be bio based
Date:   Mon, 26 Apr 2021 15:48:21 +0200
Message-Id: <20210426134821.2191160-13-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the blk_poll interface that requires the caller to keep a queue
and cookie from the submissions with polling based on the bio.

Polling for the bio itself leads to a few advantages:

 - the cookie construction can made entirely private in blk-mq.c
 - the caller does not need to remember the request_queue and cookie
   separately and thus sidesteps their lifetime issues
 - keeping the device and the cookie inside the bio allows to trivially
   support polling BIOs remapping by stacking drivers
 - a lot of code to propagate the cookie back up the submission path can
   be removed entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/emu/nfblock.c             |   3 +-
 arch/xtensa/platforms/iss/simdisk.c |   3 +-
 block/bio.c                         |   1 +
 block/blk-core.c                    | 103 +++++++++++++++++++---------
 block/blk-mq.c                      |  75 +++++++-------------
 block/blk-mq.h                      |   2 +
 drivers/block/brd.c                 |  12 ++--
 drivers/block/drbd/drbd_int.h       |   2 +-
 drivers/block/drbd/drbd_req.c       |   3 +-
 drivers/block/n64cart.c             |  12 ++--
 drivers/block/null_blk/main.c       |   3 +-
 drivers/block/pktcdvd.c             |   7 +-
 drivers/block/ps3vram.c             |   6 +-
 drivers/block/rsxx/dev.c            |   7 +-
 drivers/block/umem.c                |   4 +-
 drivers/block/zram/zram_drv.c       |  10 +--
 drivers/lightnvm/pblk-init.c        |   6 +-
 drivers/md/bcache/request.c         |  13 ++--
 drivers/md/bcache/request.h         |   4 +-
 drivers/md/dm.c                     |  28 +++-----
 drivers/md/md.c                     |  10 ++-
 drivers/nvdimm/blk.c                |   5 +-
 drivers/nvdimm/btt.c                |   5 +-
 drivers/nvdimm/pmem.c               |   3 +-
 drivers/nvme/host/core.c            |   2 +-
 drivers/nvme/host/multipath.c       |   6 +-
 drivers/nvme/host/nvme.h            |   2 +-
 drivers/s390/block/dcssblk.c        |   7 +-
 drivers/s390/block/xpram.c          |   5 +-
 fs/block_dev.c                      |  25 +++----
 fs/btrfs/inode.c                    |   8 +--
 fs/ext4/file.c                      |   2 +-
 fs/gfs2/file.c                      |   4 +-
 fs/iomap/direct-io.c                |  39 ++++-------
 fs/xfs/xfs_file.c                   |   2 +-
 fs/zonefs/super.c                   |   2 +-
 include/linux/bio.h                 |   2 +-
 include/linux/blk-mq.h              |  15 +---
 include/linux/blk_types.h           |  12 ++--
 include/linux/blkdev.h              |   8 ++-
 include/linux/fs.h                  |   6 +-
 include/linux/iomap.h               |   3 +-
 mm/page_io.c                        |   8 +--
 43 files changed, 208 insertions(+), 277 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index ba808543161a..dd36808f0d5e 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -59,7 +59,7 @@ struct nfhd_device {
 	struct gendisk *disk;
 };
 
-static blk_qc_t nfhd_submit_bio(struct bio *bio)
+static void nfhd_submit_bio(struct bio *bio)
 {
 	struct nfhd_device *dev = bio->bi_bdev->bd_disk->private_data;
 	struct bio_vec bvec;
@@ -77,7 +77,6 @@ static blk_qc_t nfhd_submit_bio(struct bio *bio)
 		sec += len;
 	}
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int nfhd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index fc09be7b1347..182825d639e2 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -101,7 +101,7 @@ static void simdisk_transfer(struct simdisk *dev, unsigned long sector,
 	spin_unlock(&dev->lock);
 }
 
-static blk_qc_t simdisk_submit_bio(struct bio *bio)
+static void simdisk_submit_bio(struct bio *bio)
 {
 	struct simdisk *dev = bio->bi_bdev->bd_disk->private_data;
 	struct bio_vec bvec;
@@ -119,7 +119,6 @@ static blk_qc_t simdisk_submit_bio(struct bio *bio)
 	}
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int simdisk_open(struct block_device *bdev, fmode_t mode)
diff --git a/block/bio.c b/block/bio.c
index 7296abe293de..484b6d786857 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -259,6 +259,7 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 	memset(bio, 0, sizeof(*bio));
 	atomic_set(&bio->__bi_remaining, 1);
 	atomic_set(&bio->__bi_cnt, 1);
+	bio->bi_cookie = BLK_QC_T_NONE;
 
 	bio->bi_io_vec = table;
 	bio->bi_max_vecs = max_vecs;
diff --git a/block/blk-core.c b/block/blk-core.c
index adfab5976be0..77fdb00fcad3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -910,18 +910,18 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	return false;
 }
 
-static blk_qc_t __submit_bio(struct bio *bio)
+static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
-	blk_qc_t ret = BLK_QC_T_NONE;
 
 	if (blk_crypto_bio_prep(&bio)) {
-		if (!disk->fops->submit_bio)
-			return blk_mq_submit_bio(bio);
-		ret = disk->fops->submit_bio(bio);
+		if (!disk->fops->submit_bio) {
+			blk_mq_submit_bio(bio);
+			return;
+		}
+		disk->fops->submit_bio(bio);
 	}
 	blk_queue_exit(disk->queue);
-	return ret;
 }
 
 /*
@@ -943,10 +943,9 @@ static blk_qc_t __submit_bio(struct bio *bio)
  * bio_list_on_stack[1] contains bios that were submitted before the current
  *	->submit_bio_bio, but that haven't been processed yet.
  */
-static blk_qc_t __submit_bio_noacct(struct bio *bio)
+static void __submit_bio_noacct(struct bio *bio)
 {
 	struct bio_list bio_list_on_stack[2];
-	blk_qc_t ret = BLK_QC_T_NONE;
 
 	BUG_ON(bio->bi_next);
 
@@ -966,7 +965,7 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 		bio_list_on_stack[1] = bio_list_on_stack[0];
 		bio_list_init(&bio_list_on_stack[0]);
 
-		ret = __submit_bio(bio);
+		__submit_bio(bio);
 
 		/*
 		 * Sort new bios into those for a lower level and those for the
@@ -989,13 +988,11 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
 
 	current->bio_list = NULL;
-	return ret;
 }
 
-static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
+static void __submit_bio_noacct_mq(struct bio *bio)
 {
 	struct bio_list bio_list[2] = { };
-	blk_qc_t ret = BLK_QC_T_NONE;
 
 	current->bio_list = bio_list;
 
@@ -1007,15 +1004,13 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 
 		if (!blk_crypto_bio_prep(&bio)) {
 			blk_queue_exit(disk->queue);
-			ret = BLK_QC_T_NONE;
 			continue;
 		}
 
-		ret = blk_mq_submit_bio(bio);
+		blk_mq_submit_bio(bio);
 	} while ((bio = bio_list_pop(&bio_list[0])));
 
 	current->bio_list = NULL;
-	return ret;
 }
 
 /**
@@ -1027,10 +1022,10 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
  * systems and other upper level users of the block layer should use
  * submit_bio() instead.
  */
-blk_qc_t submit_bio_noacct(struct bio *bio)
+void submit_bio_noacct(struct bio *bio)
 {
 	if (!submit_bio_checks(bio))
-		return BLK_QC_T_NONE;
+		return;
 
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
@@ -1038,14 +1033,12 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 	 * to collect a list of requests submited by a ->submit_bio method while
 	 * it is active, and then process them after it returned.
 	 */
-	if (current->bio_list) {
+	if (current->bio_list)
 		bio_list_add(&current->bio_list[0], bio);
-		return BLK_QC_T_NONE;
-	}
-
-	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
-		return __submit_bio_noacct_mq(bio);
-	return __submit_bio_noacct(bio);
+	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
+		__submit_bio_noacct_mq(bio);
+	else
+		__submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
@@ -1062,10 +1055,10 @@ EXPORT_SYMBOL(submit_bio_noacct);
  * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io() has
  * been called.
  */
-blk_qc_t submit_bio(struct bio *bio)
+void submit_bio(struct bio *bio)
 {
 	if (blkcg_punt_bio_submit(bio))
-		return BLK_QC_T_NONE;
+		return;
 
 	/*
 	 * If it's a regular read/write or a barrier with data attached,
@@ -1106,19 +1099,67 @@ blk_qc_t submit_bio(struct bio *bio)
 	if (unlikely(bio_op(bio) == REQ_OP_READ &&
 	    bio_flagged(bio, BIO_WORKINGSET))) {
 		unsigned long pflags;
-		blk_qc_t ret;
 
 		psi_memstall_enter(&pflags);
-		ret = submit_bio_noacct(bio);
+		submit_bio_noacct(bio);
 		psi_memstall_leave(&pflags);
-
-		return ret;
+		return;
 	}
 
-	return submit_bio_noacct(bio);
+	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
 
+/**
+ * bio_poll - poll for BIO completions
+ * @bio: bio to poll for
+ *
+ * Poll for completions on queue associated with the bio. Returns number of
+ * completed entries found. If @spin is true, then bio_poll will continue
+ * looping until at least one completion is found, unless the task is
+ * otherwise marked running (or we need to reschedule).
+ *
+ * Note: the caller must either be the context that submitted @bio, or
+ * be in a RCU critical section to prevent freeing of @bio.
+ */
+int bio_poll(struct bio *bio, bool spin)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
+
+	if (cookie == BLK_QC_T_NONE ||
+	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+		return 0;
+
+	if (current->plug)
+		blk_flush_plug_list(current->plug, false);
+
+	/* not yet implemented, so this should not happen */
+	if (WARN_ON_ONCE(!queue_is_mq(q)))
+		return 0;
+	return blk_mq_poll(q, cookie, spin);
+}
+EXPORT_SYMBOL_GPL(bio_poll);
+
+/*
+ * Helper to implements file_operations.iopoll.  Requires the bio to be stored
+ * in iocb->private, and cleared before freeing the bio.
+ */
+int iocb_bio_iopoll(struct kiocb *kiocb, bool spin)
+{
+	struct bio *bio;
+	int ret = 0;
+
+	rcu_read_lock();
+	bio = READ_ONCE(kiocb->private);
+	if (bio)
+		ret = bio_poll(bio, spin);
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iocb_bio_iopoll);
+
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
  *                              for the new queue limits
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c252d42b456f..a2d3f72f1984 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -63,6 +63,9 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 	return bucket;
 }
 
+#define BLK_QC_T_SHIFT		16
+#define BLK_QC_T_INTERNAL	(1U << 31)
+
 static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
 		blk_qc_t qc)
 {
@@ -79,6 +82,13 @@ static inline struct request *blk_qc_to_rq(struct blk_mq_hw_ctx *hctx,
 	return blk_mq_tag_to_rq(hctx->tags, tag);
 }
 
+static inline blk_qc_t blk_rq_to_qc(struct request *rq)
+{
+	return (rq->mq_hctx->queue_num << BLK_QC_T_SHIFT) |
+		(rq->tag != -1 ?
+		 rq->tag : (rq->internal_tag | BLK_QC_T_INTERNAL));
+}
+
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -747,6 +757,8 @@ void blk_mq_start_request(struct request *rq)
 	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE)
 		q->integrity.profile->prepare_fn(rq);
 #endif
+	if (rq->bio && rq->bio->bi_opf & REQ_POLLED)
+	        WRITE_ONCE(rq->bio->bi_cookie, blk_rq_to_qc(rq));
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
@@ -1981,19 +1993,15 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 }
 
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
-					    struct request *rq,
-					    blk_qc_t *cookie, bool last)
+					    struct request *rq, bool last)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_queue_data bd = {
 		.rq = rq,
 		.last = last,
 	};
-	blk_qc_t new_cookie;
 	blk_status_t ret;
 
-	new_cookie = request_to_qc_t(hctx, rq);
-
 	/*
 	 * For OK queue, we are done. For error, caller may kill it.
 	 * Any other error (busy), just add it to our list as we
@@ -2003,7 +2011,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	switch (ret) {
 	case BLK_STS_OK:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = new_cookie;
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
@@ -2012,7 +2019,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	default:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = BLK_QC_T_NONE;
 		break;
 	}
 
@@ -2021,7 +2027,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
-						blk_qc_t *cookie,
 						bool bypass_insert, bool last)
 {
 	struct request_queue *q = rq->q;
@@ -2051,7 +2056,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie, last);
+	return __blk_mq_issue_directly(hctx, rq, last);
 insert:
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
@@ -2065,7 +2070,6 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
  * blk_mq_try_issue_directly - Try to send a request directly to device driver.
  * @hctx: Pointer of the associated hardware queue.
  * @rq: Pointer to request to be sent.
- * @cookie: Request queue cookie.
  *
  * If the device has enough resources to accept a new request now, send the
  * request directly to device driver. Else, insert at hctx->dispatch queue, so
@@ -2073,7 +2077,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
  * queue have higher priority.
  */
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, blk_qc_t *cookie)
+		struct request *rq)
 {
 	blk_status_t ret;
 	int srcu_idx;
@@ -2082,7 +2086,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	hctx_lock(hctx, &srcu_idx);
 
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
+	ret = __blk_mq_try_issue_directly(hctx, rq, false, true);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
 		blk_mq_request_bypass_insert(rq, false, true);
 	else if (ret != BLK_STS_OK)
@@ -2095,11 +2099,10 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
 	blk_status_t ret;
 	int srcu_idx;
-	blk_qc_t unused_cookie;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
+	ret = __blk_mq_try_issue_directly(hctx, rq, true, last);
 	hctx_unlock(hctx, srcu_idx);
 
 	return ret;
@@ -2167,10 +2170,8 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
  *
  * It will not queue the request if there is an error with the bio, or at the
  * request creation.
- *
- * Returns: Request queue cookie.
  */
-blk_qc_t blk_mq_submit_bio(struct bio *bio)
+void blk_mq_submit_bio(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
 	const int is_sync = op_is_sync(bio->bi_opf);
@@ -2182,9 +2183,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
 	unsigned int nr_segs;
-	blk_qc_t cookie;
 	blk_status_t ret;
-	bool hipri;
 
 	blk_queue_bounce(q, &bio);
 	__blk_queue_split(&bio, &nr_segs);
@@ -2201,8 +2200,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	rq_qos_throttle(q, bio);
 
-	hipri = bio->bi_opf & REQ_POLLED;
-
 	data.cmd_flags = bio->bi_opf;
 	rq = __blk_mq_alloc_request(&data);
 	if (unlikely(!rq)) {
@@ -2216,8 +2213,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	rq_qos_track(q, rq, bio);
 
-	cookie = request_to_qc_t(data.hctx, rq);
-
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
 	ret = blk_crypto_init_request(rq);
@@ -2225,7 +2220,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		bio->bi_status = ret;
 		bio_endio(bio);
 		blk_mq_free_request(rq);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	plug = blk_mq_plug(q, bio);
@@ -2280,8 +2275,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		if (same_queue_rq) {
 			data.hctx = same_queue_rq->mq_hctx;
 			trace_block_unplug(q, 1, true);
-			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
-					&cookie);
+			blk_mq_try_issue_directly(data.hctx, same_queue_rq);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) ||
 			!data.hctx->dispatch_busy) {
@@ -2289,18 +2283,15 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		 * There is no scheduler and we can try to send directly
 		 * to the hardware.
 		 */
-		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
+		blk_mq_try_issue_directly(data.hctx, rq);
 	} else {
 		/* Default case. */
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
 
-	if (!hipri)
-		return BLK_QC_T_NONE;
-	return cookie;
+	return;
 queue_exit:
 	blk_queue_exit(q);
-	return BLK_QC_T_NONE;
 }
 
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
@@ -3882,27 +3873,8 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t qc, bool spin)
 	return 0;
 }
 
-/**
- * blk_poll - poll for IO completions
- * @q:  the queue
- * @cookie: cookie passed back at IO submission time
- * @spin: whether to spin for completions
- *
- * Description:
- *    Poll for completions on the passed in queue. Returns number of
- *    completed entries found. If @spin is true, then blk_poll will continue
- *    looping until at least one completion is found, unless the task is
- *    otherwise marked running (or we need to reschedule).
- */
-int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
-	if (cookie == BLK_QC_T_NONE ||
-	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		return 0;
-
-	if (current->plug)
-		blk_flush_plug_list(current->plug, false);
-
 	/*
 	 * If we sleep, have the caller restart the poll loop to reset the
 	 * state.  Like for the other success return cases, the caller is
@@ -3916,7 +3888,6 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	}
 	return blk_mq_poll_classic(q, cookie, spin);
 }
-EXPORT_SYMBOL_GPL(blk_poll);
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 38eac0434a52..17c5287d1590 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -37,6 +37,8 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
+void blk_mq_submit_bio(struct bio *bio);
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
 void blk_mq_exit_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 18bf99906662..0b1004ce3329 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -282,7 +282,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 	return err;
 }
 
-static blk_qc_t brd_submit_bio(struct bio *bio)
+static void brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
 	sector_t sector = bio->bi_iter.bi_sector;
@@ -299,16 +299,14 @@ static blk_qc_t brd_submit_bio(struct bio *bio)
 
 		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
 				  bio_op(bio), sector);
-		if (err)
-			goto io_error;
+		if (err) {
+			bio_io_error(bio);
+			return;
+		}
 		sector += len >> SECTOR_SHIFT;
 	}
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
-io_error:
-	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int brd_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 5d9181382ce1..6674a0b88341 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1448,7 +1448,7 @@ extern void conn_free_crypto(struct drbd_connection *connection);
 /* drbd_req */
 extern void do_submit(struct work_struct *ws);
 extern void __drbd_make_request(struct drbd_device *, struct bio *);
-extern blk_qc_t drbd_submit_bio(struct bio *bio);
+void drbd_submit_bio(struct bio *bio);
 extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
 extern int is_valid_ar_handle(struct drbd_request *, sector_t);
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 9398c2c2cb2d..df70b33216e0 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1596,7 +1596,7 @@ void do_submit(struct work_struct *ws)
 	}
 }
 
-blk_qc_t drbd_submit_bio(struct bio *bio)
+void drbd_submit_bio(struct bio *bio)
 {
 	struct drbd_device *device = bio->bi_bdev->bd_disk->private_data;
 
@@ -1609,7 +1609,6 @@ blk_qc_t drbd_submit_bio(struct bio *bio)
 
 	inc_ap_bio(device);
 	__drbd_make_request(device, bio);
-	return BLK_QC_T_NONE;
 }
 
 static bool net_timeout_reached(struct drbd_request *net_req,
diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index 47bdf324e962..94f3c43d6da2 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -84,7 +84,7 @@ static bool n64cart_do_bvec(struct device *dev, struct bio_vec *bv, u32 pos)
 	return true;
 }
 
-static blk_qc_t n64cart_submit_bio(struct bio *bio)
+static void n64cart_submit_bio(struct bio *bio)
 {
 	struct bio_vec bvec;
 	struct bvec_iter iter;
@@ -92,16 +92,14 @@ static blk_qc_t n64cart_submit_bio(struct bio *bio)
 	u32 pos = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (!n64cart_do_bvec(dev, &bvec, pos))
-			goto io_error;
+		if (!n64cart_do_bvec(dev, &bvec, pos)) {
+			bio_io_error(bio);
+			return;
+		}
 		pos += bvec.bv_len;
 	}
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
-io_error:
-	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static const struct block_device_operations n64cart_fops = {
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..29a86322cc9f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1416,7 +1416,7 @@ static struct nullb_queue *nullb_to_queue(struct nullb *nullb)
 	return &nullb->queues[index];
 }
 
-static blk_qc_t null_submit_bio(struct bio *bio)
+static void null_submit_bio(struct bio *bio)
 {
 	sector_t sector = bio->bi_iter.bi_sector;
 	sector_t nr_sectors = bio_sectors(bio);
@@ -1428,7 +1428,6 @@ static blk_qc_t null_submit_bio(struct bio *bio)
 	cmd->bio = bio;
 
 	null_handle_cmd(cmd, sector, nr_sectors, bio_op(bio));
-	return BLK_QC_T_NONE;
 }
 
 static bool should_timeout_request(struct request *rq)
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index bd3556585122..628ed0d3f2e4 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2402,7 +2402,7 @@ static void pkt_make_request_write(struct request_queue *q, struct bio *bio)
 	}
 }
 
-static blk_qc_t pkt_submit_bio(struct bio *bio)
+static void pkt_submit_bio(struct bio *bio)
 {
 	struct pktcdvd_device *pd;
 	char b[BDEVNAME_SIZE];
@@ -2425,7 +2425,7 @@ static blk_qc_t pkt_submit_bio(struct bio *bio)
 	 */
 	if (bio_data_dir(bio) == READ) {
 		pkt_make_request_read(pd, bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
@@ -2457,10 +2457,9 @@ static blk_qc_t pkt_submit_bio(struct bio *bio)
 		pkt_make_request_write(bio->bi_bdev->bd_disk->queue, split);
 	} while (split != bio);
 
-	return BLK_QC_T_NONE;
+	return;
 end_io:
 	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static void pkt_init_queue(struct pktcdvd_device *pd)
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 1d738999fb69..382be2f07c49 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -579,7 +579,7 @@ static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
 	return next;
 }
 
-static blk_qc_t ps3vram_submit_bio(struct bio *bio)
+static void ps3vram_submit_bio(struct bio *bio)
 {
 	struct ps3_system_bus_device *dev = bio->bi_bdev->bd_disk->private_data;
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
@@ -595,13 +595,11 @@ static blk_qc_t ps3vram_submit_bio(struct bio *bio)
 	spin_unlock_irq(&priv->lock);
 
 	if (busy)
-		return BLK_QC_T_NONE;
+		return;
 
 	do {
 		bio = ps3vram_do_bio(dev, bio);
 	} while (bio);
-
-	return BLK_QC_T_NONE;
 }
 
 static const struct block_device_operations ps3vram_fops = {
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 9a28322a8cd8..a4f5a09d0937 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -50,7 +50,7 @@ struct rsxx_bio_meta {
 
 static struct kmem_cache *bio_meta_pool;
 
-static blk_qc_t rsxx_submit_bio(struct bio *bio);
+static void rsxx_submit_bio(struct bio *bio);
 
 /*----------------- Block Device Operations -----------------*/
 static int rsxx_blkdev_ioctl(struct block_device *bdev,
@@ -120,7 +120,7 @@ static void bio_dma_done_cb(struct rsxx_cardinfo *card,
 	}
 }
 
-static blk_qc_t rsxx_submit_bio(struct bio *bio)
+static void rsxx_submit_bio(struct bio *bio)
 {
 	struct rsxx_cardinfo *card = bio->bi_bdev->bd_disk->private_data;
 	struct rsxx_bio_meta *bio_meta;
@@ -169,7 +169,7 @@ static blk_qc_t rsxx_submit_bio(struct bio *bio)
 	if (st)
 		goto queue_err;
 
-	return BLK_QC_T_NONE;
+	return;
 
 queue_err:
 	kmem_cache_free(bio_meta_pool, bio_meta);
@@ -177,7 +177,6 @@ static blk_qc_t rsxx_submit_bio(struct bio *bio)
 	if (st)
 		bio->bi_status = st;
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 /*----------------- Device Setup -------------------*/
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 664280f23bee..36610a4de792 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -519,7 +519,7 @@ static int mm_check_plugged(struct cardinfo *card)
 	return !!blk_check_plugged(mm_unplug, card, sizeof(struct blk_plug_cb));
 }
 
-static blk_qc_t mm_submit_bio(struct bio *bio)
+static void mm_submit_bio(struct bio *bio)
 {
 	struct cardinfo *card = bio->bi_bdev->bd_disk->private_data;
 
@@ -536,8 +536,6 @@ static blk_qc_t mm_submit_bio(struct bio *bio)
 	if (op_is_sync(bio->bi_opf) || !mm_check_plugged(card))
 		activate(card);
 	spin_unlock_irq(&card->lock);
-
-	return BLK_QC_T_NONE;
 }
 
 static irqreturn_t mm_interrupt(int irq, void *__card)
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf8deecc39ef..51dab0d4bedf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1598,22 +1598,18 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 /*
  * Handler function for all zram I/O requests.
  */
-static blk_qc_t zram_submit_bio(struct bio *bio)
+static void zram_submit_bio(struct bio *bio)
 {
 	struct zram *zram = bio->bi_bdev->bd_disk->private_data;
 
 	if (!valid_io_request(zram, bio->bi_iter.bi_sector,
 					bio->bi_iter.bi_size)) {
 		atomic64_inc(&zram->stats.invalid_io);
-		goto error;
+		bio_io_error(bio);
+		return;
 	}
 
 	__zram_make_request(zram, bio);
-	return BLK_QC_T_NONE;
-
-error:
-	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static void zram_slot_free_notify(struct block_device *bdev,
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 5924f09c217b..6716003d4cb6 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -47,7 +47,7 @@ static struct pblk_global_caches pblk_caches = {
 
 struct bio_set pblk_bio_set;
 
-static blk_qc_t pblk_submit_bio(struct bio *bio)
+static void pblk_submit_bio(struct bio *bio)
 {
 	struct pblk *pblk = bio->bi_bdev->bd_disk->queue->queuedata;
 
@@ -55,7 +55,7 @@ static blk_qc_t pblk_submit_bio(struct bio *bio)
 		pblk_discard(pblk, bio);
 		if (!(bio->bi_opf & REQ_PREFLUSH)) {
 			bio_endio(bio);
-			return BLK_QC_T_NONE;
+			return;
 		}
 	}
 
@@ -75,8 +75,6 @@ static blk_qc_t pblk_submit_bio(struct bio *bio)
 
 		pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
 	}
-
-	return BLK_QC_T_NONE;
 }
 
 static const struct block_device_operations pblk_bops = {
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 29c231758293..b549147a567f 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1169,7 +1169,7 @@ static void quit_max_writeback_rate(struct cache_set *c,
 
 /* Cached devices - read & write stuff */
 
-blk_qc_t cached_dev_submit_bio(struct bio *bio)
+void cached_dev_submit_bio(struct bio *bio)
 {
 	struct search *s;
 	struct block_device *orig_bdev = bio->bi_bdev;
@@ -1182,7 +1182,7 @@ blk_qc_t cached_dev_submit_bio(struct bio *bio)
 		     dc->io_disable)) {
 		bio->bi_status = BLK_STS_IOERR;
 		bio_endio(bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (likely(d->c)) {
@@ -1228,8 +1228,6 @@ blk_qc_t cached_dev_submit_bio(struct bio *bio)
 	} else
 		/* I/O request sent to backing device */
 		detached_dev_do_request(d, bio, orig_bdev, start_time);
-
-	return BLK_QC_T_NONE;
 }
 
 static int cached_dev_ioctl(struct bcache_device *d, fmode_t mode,
@@ -1279,7 +1277,7 @@ static void flash_dev_nodata(struct closure *cl)
 	continue_at(cl, search_free, NULL);
 }
 
-blk_qc_t flash_dev_submit_bio(struct bio *bio)
+void flash_dev_submit_bio(struct bio *bio)
 {
 	struct search *s;
 	struct closure *cl;
@@ -1288,7 +1286,7 @@ blk_qc_t flash_dev_submit_bio(struct bio *bio)
 	if (unlikely(d->c && test_bit(CACHE_SET_IO_DISABLE, &d->c->flags))) {
 		bio->bi_status = BLK_STS_IOERR;
 		bio_endio(bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	s = search_alloc(bio, d, bio->bi_bdev, bio_start_io_acct(bio));
@@ -1304,7 +1302,7 @@ blk_qc_t flash_dev_submit_bio(struct bio *bio)
 		continue_at_nobarrier(&s->cl,
 				      flash_dev_nodata,
 				      bcache_wq);
-		return BLK_QC_T_NONE;
+		return;
 	} else if (bio_data_dir(bio)) {
 		bch_keybuf_check_overlapping(&s->iop.c->moving_gc_keys,
 					&KEY(d->id, bio->bi_iter.bi_sector, 0),
@@ -1320,7 +1318,6 @@ blk_qc_t flash_dev_submit_bio(struct bio *bio)
 	}
 
 	continue_at(cl, search_free, NULL);
-	return BLK_QC_T_NONE;
 }
 
 static int flash_dev_ioctl(struct bcache_device *d, fmode_t mode,
diff --git a/drivers/md/bcache/request.h b/drivers/md/bcache/request.h
index 82b38366a95d..38ab4856eaab 100644
--- a/drivers/md/bcache/request.h
+++ b/drivers/md/bcache/request.h
@@ -37,10 +37,10 @@ unsigned int bch_get_congested(const struct cache_set *c);
 void bch_data_insert(struct closure *cl);
 
 void bch_cached_dev_request_init(struct cached_dev *dc);
-blk_qc_t cached_dev_submit_bio(struct bio *bio);
+void cached_dev_submit_bio(struct bio *bio);
 
 void bch_flash_dev_request_init(struct bcache_device *d);
-blk_qc_t flash_dev_submit_bio(struct bio *bio);
+void flash_dev_submit_bio(struct bio *bio);
 
 extern struct kmem_cache *bch_search_cache;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 50b693d776d6..0e3a9c8ac2ff 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1294,14 +1294,13 @@ static noinline void __set_swap_bios_limit(struct mapped_device *md, int latch)
 	mutex_unlock(&md->swap_bios_lock);
 }
 
-static blk_qc_t __map_bio(struct dm_target_io *tio)
+static void __map_bio(struct dm_target_io *tio)
 {
 	int r;
 	sector_t sector;
 	struct bio *clone = &tio->clone;
 	struct dm_io *io = tio->io;
 	struct dm_target *ti = tio->ti;
-	blk_qc_t ret = BLK_QC_T_NONE;
 
 	clone->bi_end_io = clone_endio;
 
@@ -1328,7 +1327,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 	case DM_MAPIO_REMAPPED:
 		/* the bio has been remapped so dispatch it */
 		trace_block_bio_remap(clone, bio_dev(io->orig_bio), sector);
-		ret = submit_bio_noacct(clone);
+		submit_bio_noacct(clone);
 		break;
 	case DM_MAPIO_KILL:
 		if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1350,8 +1349,6 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 		DMWARN("unimplemented target map return value: %d", r);
 		BUG();
 	}
-
-	return ret;
 }
 
 static void bio_setup_sector(struct bio *bio, sector_t sector, unsigned len)
@@ -1438,7 +1435,7 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 	}
 }
 
-static blk_qc_t __clone_and_map_simple_bio(struct clone_info *ci,
+static void __clone_and_map_simple_bio(struct clone_info *ci,
 					   struct dm_target_io *tio, unsigned *len)
 {
 	struct bio *clone = &tio->clone;
@@ -1448,8 +1445,7 @@ static blk_qc_t __clone_and_map_simple_bio(struct clone_info *ci,
 	__bio_clone_fast(clone, ci->bio);
 	if (len)
 		bio_setup_sector(clone, ci->sector, *len);
-
-	return __map_bio(tio);
+	__map_bio(tio);
 }
 
 static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
@@ -1463,7 +1459,7 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 
 	while ((bio = bio_list_pop(&blist))) {
 		tio = container_of(bio, struct dm_target_io, clone);
-		(void) __clone_and_map_simple_bio(ci, tio, len);
+		__clone_and_map_simple_bio(ci, tio, len);
 	}
 }
 
@@ -1507,7 +1503,7 @@ static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
 		free_tio(tio);
 		return r;
 	}
-	(void) __map_bio(tio);
+	__map_bio(tio);
 
 	return 0;
 }
@@ -1622,11 +1618,10 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
 /*
  * Entry point to split a bio into clones and submit them to the targets.
  */
-static blk_qc_t __split_and_process_bio(struct mapped_device *md,
+static void __split_and_process_bio(struct mapped_device *md,
 					struct dm_table *map, struct bio *bio)
 {
 	struct clone_info ci;
-	blk_qc_t ret = BLK_QC_T_NONE;
 	int error = 0;
 
 	init_clone_info(&ci, md, map, bio);
@@ -1670,7 +1665,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 
 				bio_chain(b, bio);
 				trace_block_split(b, bio->bi_iter.bi_sector);
-				ret = submit_bio_noacct(bio);
+				submit_bio_noacct(bio);
 				break;
 			}
 		}
@@ -1678,13 +1673,11 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 
 	/* drop the extra reference count */
 	dec_pending(ci.io, errno_to_blk_status(error));
-	return ret;
 }
 
-static blk_qc_t dm_submit_bio(struct bio *bio)
+static void dm_submit_bio(struct bio *bio)
 {
 	struct mapped_device *md = bio->bi_bdev->bd_disk->private_data;
-	blk_qc_t ret = BLK_QC_T_NONE;
 	int srcu_idx;
 	struct dm_table *map;
 
@@ -1714,10 +1707,9 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
 	if (is_abnormal_io(bio))
 		blk_queue_split(&bio);
 
-	ret = __split_and_process_bio(md, map, bio);
+	__split_and_process_bio(md, map, bio);
 out:
 	dm_put_live_table(md, srcu_idx);
-	return ret;
 }
 
 /*-----------------------------------------------------------------
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 21da0c48f6c2..2953eb308055 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -465,19 +465,19 @@ static void md_end_io(struct bio *bio)
 		bio->bi_end_io(bio);
 }
 
-static blk_qc_t md_submit_bio(struct bio *bio)
+static void md_submit_bio(struct bio *bio)
 {
 	const int rw = bio_data_dir(bio);
 	struct mddev *mddev = bio->bi_bdev->bd_disk->private_data;
 
 	if (mddev == NULL || mddev->pers == NULL) {
 		bio_io_error(bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
 		bio_io_error(bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	blk_queue_split(&bio);
@@ -486,7 +486,7 @@ static blk_qc_t md_submit_bio(struct bio *bio)
 		if (bio_sectors(bio) != 0)
 			bio->bi_status = BLK_STS_IOERR;
 		bio_endio(bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (bio->bi_end_io != md_end_io) {
@@ -508,8 +508,6 @@ static blk_qc_t md_submit_bio(struct bio *bio)
 	bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
-
-	return BLK_QC_T_NONE;
 }
 
 /* mddev_suspend makes sure no new requests are submitted
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 7b9556291eb1..90c202cd39dd 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -162,7 +162,7 @@ static int nsblk_do_bvec(struct nd_namespace_blk *nsblk,
 	return err;
 }
 
-static blk_qc_t nd_blk_submit_bio(struct bio *bio)
+static void nd_blk_submit_bio(struct bio *bio)
 {
 	struct bio_integrity_payload *bip;
 	struct nd_namespace_blk *nsblk = bio->bi_bdev->bd_disk->private_data;
@@ -173,7 +173,7 @@ static blk_qc_t nd_blk_submit_bio(struct bio *bio)
 	bool do_acct;
 
 	if (!bio_integrity_prep(bio))
-		return BLK_QC_T_NONE;
+		return;
 
 	bip = bio_integrity(bio);
 	rw = bio_data_dir(bio);
@@ -199,7 +199,6 @@ static blk_qc_t nd_blk_submit_bio(struct bio *bio)
 		bio_end_io_acct(bio, start);
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int nsblk_rw_bytes(struct nd_namespace_common *ndns,
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 41aa1f01fc07..cd3509e69974 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1439,7 +1439,7 @@ static int btt_do_bvec(struct btt *btt, struct bio_integrity_payload *bip,
 	return ret;
 }
 
-static blk_qc_t btt_submit_bio(struct bio *bio)
+static void btt_submit_bio(struct bio *bio)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct btt *btt = bio->bi_bdev->bd_disk->private_data;
@@ -1450,7 +1450,7 @@ static blk_qc_t btt_submit_bio(struct bio *bio)
 	bool do_acct;
 
 	if (!bio_integrity_prep(bio))
-		return BLK_QC_T_NONE;
+		return;
 
 	do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
 	if (do_acct)
@@ -1482,7 +1482,6 @@ static blk_qc_t btt_submit_bio(struct bio *bio)
 		bio_end_io_acct(bio, start);
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int btt_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index b8a85bfb2e95..55393ef11055 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -188,7 +188,7 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 	return rc;
 }
 
-static blk_qc_t pmem_submit_bio(struct bio *bio)
+static void pmem_submit_bio(struct bio *bio)
 {
 	int ret = 0;
 	blk_status_t rc = 0;
@@ -227,7 +227,6 @@ static blk_qc_t pmem_submit_bio(struct bio *bio)
 		bio->bi_status = errno_to_blk_status(ret);
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int pmem_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 723a4c382385..b0da256e7c48 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -963,7 +963,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 	blk_execute_rq_nowait(bd_disk, rq, at_head, nvme_end_sync_rq);
 
 	while (!completion_done(&wait)) {
-		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
+		bio_poll(rq->bio, true);
 		cond_resched();
 	}
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..7ccea6063cb5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -294,12 +294,11 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	return false;
 }
 
-blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
+void nvme_ns_head_submit_bio(struct bio *bio)
 {
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
 	struct device *dev = disk_to_dev(head->disk);
 	struct nvme_ns *ns;
-	blk_qc_t ret = BLK_QC_T_NONE;
 	int srcu_idx;
 
 	/*
@@ -316,7 +315,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 		bio->bi_opf |= REQ_NVME_MPATH;
 		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
-		ret = submit_bio_noacct(bio);
+		submit_bio_noacct(bio);
 	} else if (nvme_available_path(head)) {
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 
@@ -331,7 +330,6 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	}
 
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	return ret;
 }
 
 static void nvme_requeue_work(struct work_struct *work)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..29368b930fe0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -674,7 +674,7 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
-blk_qc_t nvme_ns_head_submit_bio(struct bio *bio);
+void nvme_ns_head_submit_bio(struct bio *bio);
 
 static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 {
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index da33cb4cba28..f17582ade60b 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -31,7 +31,7 @@
 
 static int dcssblk_open(struct block_device *bdev, fmode_t mode);
 static void dcssblk_release(struct gendisk *disk, fmode_t mode);
-static blk_qc_t dcssblk_submit_bio(struct bio *bio);
+static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn);
 
@@ -865,7 +865,7 @@ dcssblk_release(struct gendisk *disk, fmode_t mode)
 	up_write(&dcssblk_devices_sem);
 }
 
-static blk_qc_t
+static void
 dcssblk_submit_bio(struct bio *bio)
 {
 	struct dcssblk_dev_info *dev_info;
@@ -919,10 +919,9 @@ dcssblk_submit_bio(struct bio *bio)
 		bytes_done += bvec.bv_len;
 	}
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
+	return;
 fail:
 	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static long
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index d1ed39162943..bb129e31df77 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -182,7 +182,7 @@ static unsigned long xpram_highest_page_index(void)
 /*
  * Block device make request function.
  */
-static blk_qc_t xpram_submit_bio(struct bio *bio)
+static void xpram_submit_bio(struct bio *bio)
 {
 	xpram_device_t *xdev = bio->bi_bdev->bd_disk->private_data;
 	struct bio_vec bvec;
@@ -224,10 +224,9 @@ static blk_qc_t xpram_submit_bio(struct bio *bio)
 		}
 	}
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
+	return;
 fail:
 	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int xpram_getgeo(struct block_device *bdev, struct hd_geometry *geo)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index ea5b4617ff86..95f047060df5 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -239,7 +239,6 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bool should_dirty = false;
 	struct bio bio;
 	ssize_t ret;
-	blk_qc_t qc;
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
@@ -278,13 +277,12 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(&bio, iocb);
 
-	qc = submit_bio(&bio);
+	submit_bio(&bio);
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio.bi_private))
 			break;
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		if (!(iocb->ki_flags & IOCB_HIPRI) || !bio_poll(&bio, true))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -317,14 +315,6 @@ struct blkdev_dio {
 
 static struct bio_set blkdev_dio_pool;
 
-static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
-{
-	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
-}
-
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
@@ -338,6 +328,8 @@ static void blkdev_bio_end_io(struct bio *bio)
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;
 
+			WRITE_ONCE(iocb->private, NULL);
+
 			if (likely(!dio->bio.bi_status)) {
 				ret = dio->size;
 				iocb->ki_pos += ret;
@@ -376,7 +368,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	bool is_poll = (iocb->ki_flags & IOCB_HIPRI), do_poll = false;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
-	blk_qc_t qc = BLK_QC_T_NONE;
 	int ret = 0;
 
 	if ((pos | iov_iter_alignment(iter)) &
@@ -449,10 +440,10 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			bio_set_polled(bio, iocb);
 			do_poll = true;
 		}
-		qc = submit_bio(bio);
+		submit_bio(bio);
 		if (!nr_pages) {
 			if (do_poll)
-				WRITE_ONCE(iocb->ki_cookie, qc);
+				WRITE_ONCE(iocb->private, bio);
 			break;
 		}
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
@@ -469,7 +460,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, true))
+		if (!do_poll || !bio_poll(bio, true))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -1823,7 +1814,7 @@ const struct file_operations def_blk_fops = {
 	.llseek		= block_llseek,
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
-	.iopoll		= blkdev_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.mmap		= generic_file_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= block_ioctl,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7cdf65be3707..e9e39209c326 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8095,7 +8095,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	return dip;
 }
 
-static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
+static void btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		struct bio *dio_bio, loff_t file_offset)
 {
 	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
@@ -8124,7 +8124,7 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		}
 		dio_bio->bi_status = BLK_STS_RESOURCE;
 		bio_endio(dio_bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (!write) {
@@ -8222,15 +8222,13 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 
 		free_extent_map(em);
 	} while (submit_len > 0);
-	return BLK_QC_T_NONE;
+	return;
 
 out_err_em:
 	free_extent_map(em);
 out_err:
 	dip->dio_bio->bi_status = status;
 	btrfs_dio_private_put(dip);
-
-	return BLK_QC_T_NONE;
 }
 
 const struct iomap_ops btrfs_dio_iomap_ops = {
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 194f5d00fa32..a3b093c9d2a4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -896,7 +896,7 @@ const struct file_operations ext4_file_operations = {
 	.llseek		= ext4_llseek,
 	.read_iter	= ext4_file_read_iter,
 	.write_iter	= ext4_file_write_iter,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl = ext4_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= ext4_compat_ioctl,
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 2d500f90cdac..a2d120430ea9 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1359,7 +1359,7 @@ const struct file_operations gfs2_file_fops = {
 	.llseek		= gfs2_llseek,
 	.read_iter	= gfs2_file_read_iter,
 	.write_iter	= gfs2_file_write_iter,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.compat_ioctl	= gfs2_compat_ioctl,
 	.mmap		= gfs2_mmap,
@@ -1392,7 +1392,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.llseek		= gfs2_llseek,
 	.read_iter	= gfs2_file_read_iter,
 	.write_iter	= gfs2_file_write_iter,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.compat_ioctl	= gfs2_compat_ioctl,
 	.mmap		= gfs2_mmap,
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 357419f39654..19c98ee947ea 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -38,8 +38,7 @@ struct iomap_dio {
 		struct {
 			struct iov_iter		*iter;
 			struct task_struct	*waiter;
-			struct request_queue	*last_queue;
-			blk_qc_t		cookie;
+			struct bio		*poll_bio;
 		} submit;
 
 		/* used for aio completion: */
@@ -49,31 +48,21 @@ struct iomap_dio {
 	};
 };
 
-int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
-{
-	struct request_queue *q = READ_ONCE(kiocb->private);
-
-	if (!q)
-		return 0;
-	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), spin);
-}
-EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
-
 static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 		struct bio *bio, loff_t pos)
 {
 	atomic_inc(&dio->ref);
 
-	if (dio->iocb->ki_flags & IOCB_HIPRI)
+	if (dio->iocb->ki_flags & IOCB_HIPRI) {
 		bio_set_polled(bio, dio->iocb);
+		dio->submit.poll_bio = bio;
+	}
 
-	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
 	if (dio->dops && dio->dops->submit_io)
-		dio->submit.cookie = dio->dops->submit_io(
-				file_inode(dio->iocb->ki_filp),
-				iomap, bio, pos);
+		dio->dops->submit_io(file_inode(dio->iocb->ki_filp), iomap, bio,
+				     pos);
 	else
-		dio->submit.cookie = submit_bio(bio);
+		submit_bio(bio);
 }
 
 ssize_t iomap_dio_complete(struct iomap_dio *dio)
@@ -166,9 +155,11 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		} else if (dio->flags & IOMAP_DIO_WRITE) {
 			struct inode *inode = file_inode(dio->iocb->ki_filp);
 
+			WRITE_ONCE(dio->iocb->private, NULL);
 			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
 			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
 		} else {
+			WRITE_ONCE(dio->iocb->private, NULL);
 			iomap_dio_complete_work(&dio->aio.work);
 		}
 	}
@@ -492,8 +483,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	dio->submit.iter = iter;
 	dio->submit.waiter = current;
-	dio->submit.cookie = BLK_QC_T_NONE;
-	dio->submit.last_queue = NULL;
+	dio->submit.poll_bio = NULL;
 
 	if (iov_iter_rw(iter) == READ) {
 		if (pos >= dio->i_size)
@@ -601,8 +591,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (dio->flags & IOMAP_DIO_WRITE_FUA)
 		dio->flags &= ~IOMAP_DIO_NEED_SYNC;
 
-	WRITE_ONCE(iocb->ki_cookie, dio->submit.cookie);
-	WRITE_ONCE(iocb->private, dio->submit.last_queue);
+	WRITE_ONCE(iocb->private, dio->submit.poll_bio);
 
 	/*
 	 * We are about to drop our additional submission reference, which
@@ -629,10 +618,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (!READ_ONCE(dio->submit.waiter))
 				break;
 
-			if (!(iocb->ki_flags & IOCB_HIPRI) ||
-			    !dio->submit.last_queue ||
-			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie, true))
+			if (!dio->submit.poll_bio ||
+			    !bio_poll(dio->submit.poll_bio, true))
 				blk_io_schedule();
 		}
 		__set_current_state(TASK_RUNNING);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a007ca0711d9..6bebee96ab65 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1429,7 +1429,7 @@ const struct file_operations xfs_file_operations = {
 	.write_iter	= xfs_file_write_iter,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= xfs_file_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= xfs_file_compat_ioctl,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 049e36c69ed7..633e4890dfe4 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1143,7 +1143,7 @@ static const struct file_operations zonefs_file_operations = {
 	.write_iter	= zonefs_file_write_iter,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 };
 
 static struct kmem_cache *zonefs_inode_cachep;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 439a70bc42e2..37a63c0b5c39 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -426,7 +426,7 @@ static inline struct bio *bio_alloc(gfp_t gfp_mask, unsigned short nr_iovecs)
 	return bio_alloc_bioset(gfp_mask, nr_iovecs, &fs_bio_set);
 }
 
-extern blk_qc_t submit_bio(struct bio *);
+void submit_bio(struct bio *bio);
 
 extern void bio_endio(struct bio *);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b8990..69f509bf6761 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -148,9 +148,9 @@ struct blk_mq_hw_ctx {
 	/** @kobj: Kernel object for sysfs. */
 	struct kobject		kobj;
 
-	/** @poll_considered: Count times blk_poll() was called. */
+	/** @poll_considered: Count times blk_mq_poll() was called. */
 	unsigned long		poll_considered;
-	/** @poll_invoked: Count how many requests blk_poll() polled. */
+	/** @poll_invoked: Count how many requests blk_mq_poll() polled. */
 	unsigned long		poll_invoked;
 	/** @poll_success: Count how many polled requests were completed. */
 	unsigned long		poll_success;
@@ -586,16 +586,6 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
 	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
 
-static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx,
-		struct request *rq)
-{
-	if (rq->tag != -1)
-		return rq->tag | (hctx->queue_num << BLK_QC_T_SHIFT);
-
-	return rq->internal_tag | (hctx->queue_num << BLK_QC_T_SHIFT) |
-			BLK_QC_T_INTERNAL;
-}
-
 static inline void blk_mq_cleanup_rq(struct request *rq)
 {
 	if (rq->q->mq_ops->cleanup_rq)
@@ -614,7 +604,6 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 		rq->rq_disk = bio->bi_bdev->bd_disk;
 }
 
-blk_qc_t blk_mq_submit_bio(struct bio *bio);
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 183a76bf24b7..e0ca0cb9c94a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -217,6 +217,9 @@ static inline void bio_issue_init(struct bio_issue *issue,
 			((u64)size << BIO_ISSUE_SIZE_SHIFT));
 }
 
+typedef unsigned int blk_qc_t;
+#define BLK_QC_T_NONE		-1U
+
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
@@ -238,9 +241,9 @@ struct bio {
 		struct bvec_iter	bi_iter;
 		struct rcu_head		bi_rcu_free;
 	};
+	blk_qc_t		bi_cookie;
 
 	bio_end_io_t		*bi_end_io;
-
 	void			*bi_private;
 #ifdef CONFIG_BLK_CGROUP
 	/*
@@ -396,7 +399,7 @@ enum req_flag_bits {
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
-	__REQ_POLLED,		/* caller polls for completion using blk_poll */
+	__REQ_POLLED,		/* caller polls for completion using bio_poll */
 
 	/* for driver use */
 	__REQ_DRV,
@@ -509,11 +512,6 @@ static inline int op_stat_group(unsigned int op)
 	return op_is_write(op);
 }
 
-typedef unsigned int blk_qc_t;
-#define BLK_QC_T_NONE		-1U
-#define BLK_QC_T_SHIFT		16
-#define BLK_QC_T_INTERNAL	(1U << 31)
-
 struct blk_rq_stat {
 	u64 mean;
 	u64 min;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f2e77ba97550..d395c23206a4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -38,6 +38,7 @@ struct sg_io_hdr;
 struct bsg_job;
 struct blkcg_gq;
 struct blk_flush_queue;
+struct kiocb;
 struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
@@ -904,7 +905,7 @@ static inline void rq_flush_dcache_pages(struct request *rq)
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
-blk_qc_t submit_bio_noacct(struct bio *bio);
+void submit_bio_noacct(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
 extern void blk_put_request(struct request *);
 extern struct request *blk_get_request(struct request_queue *, unsigned int op,
@@ -950,7 +951,8 @@ extern const char *blk_op_str(unsigned int op);
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
-int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
+int bio_poll(struct bio *bio, bool spin);
+int iocb_bio_iopoll(struct kiocb *kiocb, bool spin);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
@@ -1855,7 +1857,7 @@ static inline void blk_ksm_unregister(struct request_queue *q) { }
 
 
 struct block_device_operations {
-	blk_qc_t (*submit_bio) (struct bio *bio);
+	void (*submit_bio)(struct bio *bio);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
 	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..279522d05a9d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -331,11 +331,7 @@ struct kiocb {
 	int			ki_flags;
 	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
-	union {
-		unsigned int		ki_cookie; /* for ->iopoll */
-		struct wait_page_queue	*ki_waitq; /* for async buffered IO */
-	};
-
+	struct wait_page_queue	*ki_waitq; /* for async buffered IO */
 	randomized_struct_fields_end
 };
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index d202fd2d0f91..6f94da85163d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -254,7 +254,7 @@ int iomap_writepages(struct address_space *mapping,
 struct iomap_dio_ops {
 	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
 		      unsigned flags);
-	blk_qc_t (*submit_io)(struct inode *inode, struct iomap *iomap,
+	void (*submit_io)(struct inode *inode, struct iomap *iomap,
 			struct bio *bio, loff_t file_offset);
 };
 
@@ -278,7 +278,6 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
-int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
 struct file;
diff --git a/mm/page_io.c b/mm/page_io.c
index dd86ea217da2..5b5259fc2c2a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -358,8 +358,6 @@ int swap_readpage(struct page *page, bool synchronous)
 	struct bio *bio;
 	int ret = 0;
 	struct swap_info_struct *sis = page_swap_info(page);
-	blk_qc_t qc;
-	struct gendisk *disk;
 	unsigned long pflags;
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
@@ -409,8 +407,6 @@ int swap_readpage(struct page *page, bool synchronous)
 	bio->bi_iter.bi_sector = swap_page_sector(page);
 	bio->bi_end_io = end_swap_bio_read;
 	bio_add_page(bio, page, thp_size(page), 0);
-
-	disk = bio->bi_bdev->bd_disk;
 	/*
 	 * Keep this task valid during swap readpage because the oom killer may
 	 * attempt to access it in the page fault retry time check.
@@ -422,13 +418,13 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 	count_vm_event(PSWPIN);
 	bio_get(bio);
-	qc = submit_bio(bio);
+	submit_bio(bio);
 	while (synchronous) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio->bi_private))
 			break;
 
-		if (!blk_poll(disk->queue, qc, true))
+		if (!bio_poll(bio, true))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.30.1

