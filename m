Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D9937BDEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhELNR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhELNRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:17:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD01C06138A;
        Wed, 12 May 2021 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3/HVRj3Lbbq8HGul+87Y/R6sJVrDDCoLzrVTEhkTb1c=; b=ooo8HuUPAV59X+DtDGZK7U2lHF
        WdmCquWeln6pcNX3W3LWdtkb90XVKl08rakEC+qJDAIZwKCBdbU5DxMSmS81oniXbmZJNiLV3dDmf
        i3cLULuxUnK2Qrv1qndQ/9ycd24TC6PDc3WenpOQ4m5MKktIqZmghu+o/sAInvNcogNavhQ77BO+5
        wGd/oPAvfWJolsspPdy6qdrwIVy+CpTLg/jb/+WPApFrUNk7ia5AI3R+MAvcj4JWmfVafxpVzUjOK
        UhxOkzCLupLkz8wofwvLgrEBGzv70S4fmqoieq/tY0bkNVefTpONcvLbNoBtWxq9eJp6z5CE1gFdE
        U/Xdv4IQ==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoiq-00AO4x-DG; Wed, 12 May 2021 13:16:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 12/15] block: switch polling to be bio based
Date:   Wed, 12 May 2021 15:15:42 +0200
Message-Id: <20210512131545.495160-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
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
 block/blk-core.c                    | 120 +++++++++++++++++++++-------
 block/blk-mq.c                      |  73 ++++++-----------
 block/blk-mq.h                      |   2 +
 drivers/block/brd.c                 |  12 ++-
 drivers/block/drbd/drbd_int.h       |   2 +-
 drivers/block/drbd/drbd_req.c       |   3 +-
 drivers/block/n64cart.c             |  12 ++-
 drivers/block/null_blk/main.c       |   3 +-
 drivers/block/pktcdvd.c             |   7 +-
 drivers/block/ps3vram.c             |   6 +-
 drivers/block/rsxx/dev.c            |   7 +-
 drivers/block/zram/zram_drv.c       |  10 +--
 drivers/lightnvm/pblk-init.c        |   6 +-
 drivers/md/bcache/request.c         |  13 ++-
 drivers/md/bcache/request.h         |   4 +-
 drivers/md/dm.c                     |  28 +++----
 drivers/md/md.c                     |  10 +--
 drivers/nvdimm/blk.c                |   5 +-
 drivers/nvdimm/btt.c                |   5 +-
 drivers/nvdimm/pmem.c               |   3 +-
 drivers/nvme/host/core.c            |   2 +-
 drivers/nvme/host/multipath.c       |   6 +-
 drivers/s390/block/dcssblk.c        |   7 +-
 drivers/s390/block/xpram.c          |   5 +-
 fs/block_dev.c                      |  25 ++----
 fs/btrfs/inode.c                    |   8 +-
 fs/ext4/file.c                      |   2 +-
 fs/gfs2/file.c                      |   4 +-
 fs/iomap/direct-io.c                |  39 +++------
 fs/xfs/xfs_file.c                   |   2 +-
 fs/zonefs/super.c                   |   2 +-
 include/linux/bio.h                 |   2 +-
 include/linux/blk-mq.h              |  15 +---
 include/linux/blk_types.h           |  12 ++-
 include/linux/blkdev.h              |   8 +-
 include/linux/fs.h                  |   6 +-
 include/linux/iomap.h               |   3 +-
 mm/page_io.c                        |   8 +-
 41 files changed, 223 insertions(+), 271 deletions(-)

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
index de5505d7018e..986908cc99d4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -250,6 +250,7 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 	memset(bio, 0, sizeof(*bio));
 	atomic_set(&bio->__bi_remaining, 1);
 	atomic_set(&bio->__bi_cnt, 1);
+	bio->bi_cookie = BLK_QC_T_NONE;
 
 	bio->bi_io_vec = table;
 	bio->bi_max_vecs = max_vecs;
diff --git a/block/blk-core.c b/block/blk-core.c
index 94a817532472..c024cba98195 100644
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
@@ -1097,19 +1090,84 @@ blk_qc_t submit_bio(struct bio *bio)
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
+ * @flags: BLK_POLL_* flags that control the behavior
+ *
+ * Poll for completions on queue associated with the bio. Returns number of
+ * completed entries found.
+ *
+ * Note: the caller must either be the context that submitted @bio, or
+ * be in a RCU critical section to prevent freeing of @bio.
+ */
+int bio_poll(struct bio *bio, unsigned int flags)
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
+	return blk_mq_poll(q, cookie, flags);
+}
+EXPORT_SYMBOL_GPL(bio_poll);
+
+/*
+ * Helper to implement file_operations.iopoll.  Requires the bio to be stored
+ * in iocb->private, and cleared before freeing the bio.
+ */
+int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags)
+{
+	struct bio *bio;
+	int ret = 0;
+
+	/*
+	 * Note: the bio cache only uses SLAB_TYPESAFE_BY_RCU, so bio can
+	 * point to a freshly allocated bio at this point.  If that happens
+	 * we have a few cases to consider:
+	 *
+	 *  1) the bio is beeing initialized and bi_bdev is NULL.  We can just
+	 *     simply nothing in this case
+	 *  2) the bio points to a not poll enabled device.  bio_poll will catch
+	 *     this and return 0
+	 *  3) the bio points to a poll capable device, including but not
+	 *     limited to the one that the original bio pointed to.  In this
+	 *     case we will call into the actual poll method and poll for I/O,
+	 *     even if we don't need to, but it won't cause harm either.
+	 *
+	 * For cases 2) and 3) above the RCU grace period ensures that the
+	 * bi_bdev is still allocated, and because partitions hold a reference
+	 * to the whole device bdev and thus disk it is still valid.
+	 */
+	rcu_read_lock();
+	bio = READ_ONCE(kiocb->private);
+	if (bio && bio->bi_bdev)
+		ret = bio_poll(bio, flags);
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
index b0b35473f339..9769a351f81b 100644
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
 
@@ -1992,19 +2004,15 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
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
@@ -2014,7 +2022,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	switch (ret) {
 	case BLK_STS_OK:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = new_cookie;
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
@@ -2023,7 +2030,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	default:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = BLK_QC_T_NONE;
 		break;
 	}
 
@@ -2032,7 +2038,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
-						blk_qc_t *cookie,
 						bool bypass_insert, bool last)
 {
 	struct request_queue *q = rq->q;
@@ -2066,7 +2071,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie, last);
+	return __blk_mq_issue_directly(hctx, rq, last);
 insert:
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
@@ -2080,7 +2085,6 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
  * blk_mq_try_issue_directly - Try to send a request directly to device driver.
  * @hctx: Pointer of the associated hardware queue.
  * @rq: Pointer to request to be sent.
- * @cookie: Request queue cookie.
  *
  * If the device has enough resources to accept a new request now, send the
  * request directly to device driver. Else, insert at hctx->dispatch queue, so
@@ -2088,7 +2092,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
  * queue have higher priority.
  */
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, blk_qc_t *cookie)
+		struct request *rq)
 {
 	blk_status_t ret;
 	int srcu_idx;
@@ -2097,7 +2101,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	hctx_lock(hctx, &srcu_idx);
 
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
+	ret = __blk_mq_try_issue_directly(hctx, rq, false, true);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
 		blk_mq_request_bypass_insert(rq, false, true);
 	else if (ret != BLK_STS_OK)
@@ -2110,11 +2114,10 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
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
@@ -2182,10 +2185,8 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
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
@@ -2197,9 +2198,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
 	unsigned int nr_segs;
-	blk_qc_t cookie;
 	blk_status_t ret;
-	bool hipri;
 
 	blk_queue_bounce(q, &bio);
 	__blk_queue_split(&bio, &nr_segs);
@@ -2216,8 +2215,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	rq_qos_throttle(q, bio);
 
-	hipri = bio->bi_opf & REQ_POLLED;
-
 	data.cmd_flags = bio->bi_opf;
 	rq = __blk_mq_alloc_request(&data);
 	if (unlikely(!rq)) {
@@ -2231,8 +2228,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	rq_qos_track(q, rq, bio);
 
-	cookie = request_to_qc_t(data.hctx, rq);
-
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
 	ret = blk_crypto_init_request(rq);
@@ -2240,7 +2235,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		bio->bi_status = ret;
 		bio_endio(bio);
 		blk_mq_free_request(rq);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	plug = blk_mq_plug(q, bio);
@@ -2295,8 +2290,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		if (same_queue_rq) {
 			data.hctx = same_queue_rq->mq_hctx;
 			trace_block_unplug(q, 1, true);
-			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
-					&cookie);
+			blk_mq_try_issue_directly(data.hctx, same_queue_rq);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) ||
 			!data.hctx->dispatch_busy) {
@@ -2304,18 +2298,15 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
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
@@ -3905,25 +3896,8 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
 	return 0;
 }
 
-/**
- * blk_poll - poll for IO completions
- * @q:  the queue
- * @cookie: cookie passed back at IO submission time
- * @flags: BLK_POLL_* flags that control the behavior
- *
- * Description:
- *    Poll for completions on the passed in queue. Returns number of
- *    completed entries found.
- */
-int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
 {
-	if (cookie == BLK_QC_T_NONE ||
-	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		return 0;
-
-	if (current->plug)
-		blk_flush_plug_list(current->plug, false);
-
 	if (!(flags & BLK_POLL_NOSLEEP) &&
 	    q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
 		if (blk_mq_poll_hybrid(q, cookie))
@@ -3931,7 +3905,6 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
 	}
 	return blk_mq_poll_classic(q, cookie, flags);
 }
-EXPORT_SYMBOL_GPL(blk_poll);
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 2c1c73e19c89..f7a0a9489e61 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -37,6 +37,8 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
+void blk_mq_submit_bio(struct bio *bio);
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags);
 void blk_mq_exit_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 7562cf30b14e..7c69ed3765c1 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -287,7 +287,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 	return err;
 }
 
-static blk_qc_t brd_submit_bio(struct bio *bio)
+static void brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
 	sector_t sector = bio->bi_iter.bi_sector;
@@ -304,16 +304,14 @@ static blk_qc_t brd_submit_bio(struct bio *bio)
 
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
index 13beb98a7c5a..0a2b3cb7e0bd 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1597,7 +1597,7 @@ void do_submit(struct work_struct *ws)
 	}
 }
 
-blk_qc_t drbd_submit_bio(struct bio *bio)
+void drbd_submit_bio(struct bio *bio)
 {
 	struct drbd_device *device = bio->bi_bdev->bd_disk->private_data;
 
@@ -1610,7 +1610,6 @@ blk_qc_t drbd_submit_bio(struct bio *bio)
 
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
index 5f006d9e1472..baf3ec7af3d1 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1426,7 +1426,7 @@ static struct nullb_queue *nullb_to_queue(struct nullb *nullb)
 	return &nullb->queues[index];
 }
 
-static blk_qc_t null_submit_bio(struct bio *bio)
+static void null_submit_bio(struct bio *bio)
 {
 	sector_t sector = bio->bi_iter.bi_sector;
 	sector_t nr_sectors = bio_sectors(bio);
@@ -1438,7 +1438,6 @@ static blk_qc_t null_submit_bio(struct bio *bio)
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
index ca2aedd8ee7d..fe2b5e60f981 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1292,14 +1292,13 @@ static noinline void __set_swap_bios_limit(struct mapped_device *md, int latch)
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
 
@@ -1326,7 +1325,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 	case DM_MAPIO_REMAPPED:
 		/* the bio has been remapped so dispatch it */
 		trace_block_bio_remap(clone, bio_dev(io->orig_bio), sector);
-		ret = submit_bio_noacct(clone);
+		submit_bio_noacct(clone);
 		break;
 	case DM_MAPIO_KILL:
 		if (unlikely(swap_bios_limit(ti, clone))) {
@@ -1348,8 +1347,6 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 		DMWARN("unimplemented target map return value: %d", r);
 		BUG();
 	}
-
-	return ret;
 }
 
 static void bio_setup_sector(struct bio *bio, sector_t sector, unsigned len)
@@ -1436,7 +1433,7 @@ static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
 	}
 }
 
-static blk_qc_t __clone_and_map_simple_bio(struct clone_info *ci,
+static void __clone_and_map_simple_bio(struct clone_info *ci,
 					   struct dm_target_io *tio, unsigned *len)
 {
 	struct bio *clone = &tio->clone;
@@ -1446,8 +1443,7 @@ static blk_qc_t __clone_and_map_simple_bio(struct clone_info *ci,
 	__bio_clone_fast(clone, ci->bio);
 	if (len)
 		bio_setup_sector(clone, ci->sector, *len);
-
-	return __map_bio(tio);
+	__map_bio(tio);
 }
 
 static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
@@ -1461,7 +1457,7 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 
 	while ((bio = bio_list_pop(&blist))) {
 		tio = container_of(bio, struct dm_target_io, clone);
-		(void) __clone_and_map_simple_bio(ci, tio, len);
+		__clone_and_map_simple_bio(ci, tio, len);
 	}
 }
 
@@ -1505,7 +1501,7 @@ static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
 		free_tio(tio);
 		return r;
 	}
-	(void) __map_bio(tio);
+	__map_bio(tio);
 
 	return 0;
 }
@@ -1620,11 +1616,10 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
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
@@ -1667,19 +1662,17 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 
 			bio_chain(b, bio);
 			trace_block_split(b, bio->bi_iter.bi_sector);
-			ret = submit_bio_noacct(bio);
+			submit_bio_noacct(bio);
 		}
 	}
 
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
 
@@ -1709,10 +1702,9 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
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
index 49f897fbb89b..c9227a73ae86 100644
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
index 18a267d5073f..be739e701f79 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1440,7 +1440,7 @@ static int btt_do_bvec(struct btt *btt, struct bio_integrity_payload *bip,
 	return ret;
 }
 
-static blk_qc_t btt_submit_bio(struct bio *bio)
+static void btt_submit_bio(struct bio *bio)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct btt *btt = bio->bi_bdev->bd_disk->private_data;
@@ -1451,7 +1451,7 @@ static blk_qc_t btt_submit_bio(struct bio *bio)
 	bool do_acct;
 
 	if (!bio_integrity_prep(bio))
-		return BLK_QC_T_NONE;
+		return;
 
 	do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
 	if (do_acct)
@@ -1483,7 +1483,6 @@ static blk_qc_t btt_submit_bio(struct bio *bio)
 		bio_end_io_acct(bio, start);
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int btt_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index ed10a8b66068..488312effaa8 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -190,7 +190,7 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 	return rc;
 }
 
-static blk_qc_t pmem_submit_bio(struct bio *bio)
+static void pmem_submit_bio(struct bio *bio)
 {
 	int ret = 0;
 	blk_status_t rc = 0;
@@ -229,7 +229,6 @@ static blk_qc_t pmem_submit_bio(struct bio *bio)
 		bio->bi_status = errno_to_blk_status(ret);
 
 	bio_endio(bio);
-	return BLK_QC_T_NONE;
 }
 
 static int pmem_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c58dde3460e9..a47e705dafa9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1032,7 +1032,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 	blk_execute_rq_nowait(bd_disk, rq, at_head, nvme_end_sync_rq);
 
 	while (!completion_done(&wait)) {
-		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), 0);
+		bio_poll(rq->bio, 0);
 		cond_resched();
 	}
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0551796517e6..74455960337b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -297,12 +297,11 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	return false;
 }
 
-static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
+static void nvme_ns_head_submit_bio(struct bio *bio)
 {
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
 	struct device *dev = disk_to_dev(head->disk);
 	struct nvme_ns *ns;
-	blk_qc_t ret = BLK_QC_T_NONE;
 	int srcu_idx;
 
 	/*
@@ -319,7 +318,7 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 		bio->bi_opf |= REQ_NVME_MPATH;
 		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
-		ret = submit_bio_noacct(bio);
+		submit_bio_noacct(bio);
 	} else if (nvme_available_path(head)) {
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 
@@ -334,7 +333,6 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	}
 
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	return ret;
 }
 
 static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
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
index fd12a05cb3a9..e722a4e86e35 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -239,7 +239,6 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bool should_dirty = false;
 	struct bio bio;
 	ssize_t ret;
-	blk_qc_t qc;
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
@@ -280,13 +279,12 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(&bio, iocb);
 
-	qc = submit_bio(&bio);
+	submit_bio(&bio);
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio.bi_private))
 			break;
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, 0))
+		if (!(iocb->ki_flags & IOCB_HIPRI) || !bio_poll(&bio, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -319,14 +317,6 @@ struct blkdev_dio {
 
 static struct bio_set blkdev_dio_pool;
 
-static int blkdev_iopoll(struct kiocb *kiocb, unsigned int flags)
-{
-	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), flags);
-}
-
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
@@ -340,6 +330,8 @@ static void blkdev_bio_end_io(struct bio *bio)
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;
 
+			WRITE_ONCE(iocb->private, NULL);
+
 			if (likely(!dio->bio.bi_status)) {
 				ret = dio->size;
 				iocb->ki_pos += ret;
@@ -378,7 +370,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	bool is_poll = (iocb->ki_flags & IOCB_HIPRI), do_poll = false;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
-	blk_qc_t qc = BLK_QC_T_NONE;
 	int ret = 0;
 
 	if ((pos | iov_iter_alignment(iter)) &
@@ -453,10 +444,10 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -473,7 +464,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, 0))
+		if (!do_poll || !bio_poll(bio, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -1832,7 +1823,7 @@ const struct file_operations def_blk_fops = {
 	.llseek		= block_llseek,
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
-	.iopoll		= blkdev_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.mmap		= generic_file_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= block_ioctl,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4af336008b12..60ef00dfec8b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8103,7 +8103,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	return dip;
 }
 
-static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
+static void btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		struct bio *dio_bio, loff_t file_offset)
 {
 	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
@@ -8132,7 +8132,7 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		}
 		dio_bio->bi_status = BLK_STS_RESOURCE;
 		bio_endio(dio_bio);
-		return BLK_QC_T_NONE;
+		return;
 	}
 
 	if (!write) {
@@ -8226,15 +8226,13 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 
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
index 816dedcbd541..6146c4203fda 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -913,7 +913,7 @@ const struct file_operations ext4_file_operations = {
 	.llseek		= ext4_llseek,
 	.read_iter	= ext4_file_read_iter,
 	.write_iter	= ext4_file_write_iter,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl = ext4_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= ext4_compat_ioctl,
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index a0b542d84cd9..d51d0c663bde 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1334,7 +1334,7 @@ const struct file_operations gfs2_file_fops = {
 	.llseek		= gfs2_llseek,
 	.read_iter	= gfs2_file_read_iter,
 	.write_iter	= gfs2_file_write_iter,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.compat_ioctl	= gfs2_compat_ioctl,
 	.mmap		= gfs2_mmap,
@@ -1367,7 +1367,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.llseek		= gfs2_llseek,
 	.read_iter	= gfs2_file_read_iter,
 	.write_iter	= gfs2_file_write_iter,
-	.iopoll		= iomap_dio_iopoll,
+	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
 	.compat_ioctl	= gfs2_compat_ioctl,
 	.mmap		= gfs2_mmap,
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9b6c26da3a2d..76bc7c4b0deb 100644
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
 
-int iomap_dio_iopoll(struct kiocb *kiocb, unsigned int flags)
-{
-	struct request_queue *q = READ_ONCE(kiocb->private);
-
-	if (!q)
-		return 0;
-	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), flags);
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
@@ -609,8 +599,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (dio->flags & IOMAP_DIO_WRITE_FUA)
 		dio->flags &= ~IOMAP_DIO_NEED_SYNC;
 
-	WRITE_ONCE(iocb->ki_cookie, dio->submit.cookie);
-	WRITE_ONCE(iocb->private, dio->submit.last_queue);
+	WRITE_ONCE(iocb->private, dio->submit.poll_bio);
 
 	/*
 	 * We are about to drop our additional submission reference, which
@@ -637,10 +626,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (!READ_ONCE(dio->submit.waiter))
 				break;
 
-			if (!(iocb->ki_flags & IOCB_HIPRI) ||
-			    !dio->submit.last_queue ||
-			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie, 0))
+			if (!dio->submit.poll_bio ||
+			    !bio_poll(dio->submit.poll_bio, 0))
 				blk_io_schedule();
 		}
 		__set_current_state(TASK_RUNNING);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 396ef36dcd0a..d33f6e8bd313 100644
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
index cd145d318b17..2db3ba568bcf 100644
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
index 359486940fa0..8a3be0c65d8e 100644
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
@@ -595,16 +595,6 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
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
@@ -623,7 +613,6 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 		rq->rq_disk = bio->bi_bdev->bd_disk;
 }
 
-blk_qc_t blk_mq_submit_bio(struct bio *bio);
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ac60432752e3..8a232ea17820 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -216,6 +216,9 @@ static inline void bio_issue_init(struct bio_issue *issue,
 			((u64)size << BIO_ISSUE_SIZE_SHIFT));
 }
 
+typedef unsigned int blk_qc_t;
+#define BLK_QC_T_NONE		-1U
+
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
@@ -235,8 +238,8 @@ struct bio {
 
 	struct bvec_iter	bi_iter;
 
+	blk_qc_t		bi_cookie;
 	bio_end_io_t		*bi_end_io;
-
 	void			*bi_private;
 #ifdef CONFIG_BLK_CGROUP
 	/*
@@ -392,7 +395,7 @@ enum req_flag_bits {
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
-	__REQ_POLLED,		/* caller polls for completion using blk_poll */
+	__REQ_POLLED,		/* caller polls for completion using bio_poll */
 
 	/* for driver use */
 	__REQ_DRV,
@@ -505,11 +508,6 @@ static inline int op_stat_group(unsigned int op)
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
index 273b86714c7e..b5a5d747614b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -37,6 +37,7 @@ struct sg_io_hdr;
 struct bsg_job;
 struct blkcg_gq;
 struct blk_flush_queue;
+struct kiocb;
 struct pr_ops;
 struct rq_qos;
 struct blk_queue_stats;
@@ -901,7 +902,7 @@ static inline void rq_flush_dcache_pages(struct request *rq)
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
-blk_qc_t submit_bio_noacct(struct bio *bio);
+void submit_bio_noacct(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
 extern void blk_put_request(struct request *);
 extern struct request *blk_get_request(struct request_queue *, unsigned int op,
@@ -951,7 +952,8 @@ blk_status_t errno_to_blk_status(int errno);
 #define BLK_POLL_ONESHOT		(1 << 0)
 /* do not sleep to wait for the expected completion time */
 #define BLK_POLL_NOSLEEP		(1 << 1)
-int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags);
+int bio_poll(struct bio *bio, unsigned int flags);
+int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
@@ -1856,7 +1858,7 @@ static inline void blk_ksm_unregister(struct request_queue *q) { }
 
 
 struct block_device_operations {
-	blk_qc_t (*submit_bio) (struct bio *bio);
+	void (*submit_bio)(struct bio *bio);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
 	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 483fb557d92f..876ec2b11a7d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -332,11 +332,7 @@ struct kiocb {
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
index 56e5949ccb60..ac825a498816 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -251,7 +251,7 @@ int iomap_writepages(struct address_space *mapping,
 struct iomap_dio_ops {
 	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
 		      unsigned flags);
-	blk_qc_t (*submit_io)(struct inode *inode, struct iomap *iomap,
+	void (*submit_io)(struct inode *inode, struct iomap *iomap,
 			struct bio *bio, loff_t file_offset);
 };
 
@@ -275,7 +275,6 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
-int iomap_dio_iopoll(struct kiocb *kiocb, unsigned int flags);
 
 #ifdef CONFIG_SWAP
 struct file;
diff --git a/mm/page_io.c b/mm/page_io.c
index ed2eded74f3a..a68faab5b310 100644
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
 
-		if (!blk_poll(disk->queue, qc, 0))
+		if (!bio_poll(bio, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.30.2

