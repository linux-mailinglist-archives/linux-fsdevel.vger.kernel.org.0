Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D442A336
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 13:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbhJLL2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 07:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLL2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:28:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A42C061570;
        Tue, 12 Oct 2021 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=srRKVgwMKbFQimye+xXSsQ2Od77fKvJnubZkUfGfjxQ=; b=Ydt6cYET2qWaHlXDq1DwZkH+zl
        Jg1FTzwXxWq5fGlfjn3nOPc8UH2fmOZ24m5EXD64pYzQTVUGevPb9hNeItXcSFXHw2hiji9ctUGh7
        x5nK3rdxnKuUKFxqoJGLYeQPBPysHcFf5e845uKaD/jJ/xPGD8sJe/KFwrikhGDZdPO1kM1oljkG2
        FXul6whRdet05xLkxCBcBrxS0EduXLY1wwdKVrSkW3eEwkQZVo2MLcftH6/7bipXX2IEho2qAl2bl
        LzgCt36/S70j2X/whUBnFk11dccIq6XloQuDr9rSNZ9vWA8LW6m9jGeZAwdA8tiH0CV56dR/+tS5C
        lfuahl/Q==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFsJ-006Rzm-9l; Tue, 12 Oct 2021 11:23:41 +0000
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
Subject: [PATCH 09/16] block: replace the spin argument to blk_iopoll with a flags argument
Date:   Tue, 12 Oct 2021 13:12:19 +0200
Message-Id: <20211012111226.760968-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch the boolean spin argument to blk_poll to passing a set of flags
instead.  This will allow to control polling behavior in a more fine
grained way.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-exec.c       |  2 +-
 block/blk-mq.c         | 17 +++++++----------
 block/fops.c           |  8 ++++----
 fs/io_uring.c          | 11 ++++++-----
 fs/iomap/direct-io.c   |  6 +++---
 include/linux/blkdev.h |  4 +++-
 include/linux/fs.h     |  2 +-
 include/linux/iomap.h  |  2 +-
 mm/page_io.c           |  2 +-
 9 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index d6cd501c0d348..1fa7f25e57262 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -71,7 +71,7 @@ static bool blk_rq_is_poll(struct request *rq)
 static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
 	do {
-		blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
+		blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), 0);
 		cond_resched();
 	} while (!completion_done(wait));
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec2bee3d19f2d..d6e0beffaa6f3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4021,7 +4021,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q, blk_qc_t qc)
 }
 
 static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
-		bool spin)
+		unsigned int flags)
 {
 	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, cookie);
 	long state = get_current_state();
@@ -4044,7 +4044,7 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
 		if (task_is_running(current))
 			return 1;
 
-		if (ret < 0 || !spin)
+		if (ret < 0 || (flags & BLK_POLL_ONESHOT))
 			break;
 		cpu_relax();
 	} while (!need_resched());
@@ -4057,15 +4057,13 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
  * blk_poll - poll for IO completions
  * @q:  the queue
  * @cookie: cookie passed back at IO submission time
- * @spin: whether to spin for completions
+ * @flags: BLK_POLL_* flags that control the behavior
  *
  * Description:
  *    Poll for completions on the passed in queue. Returns number of
- *    completed entries found. If @spin is true, then blk_poll will continue
- *    looping until at least one completion is found, unless the task is
- *    otherwise marked running (or we need to reschedule).
+ *    completed entries found.
  */
-int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
 {
 	if (cookie == BLK_QC_T_NONE ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
@@ -4074,12 +4072,11 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	/* If specified not to spin, we also should not sleep. */
-	if (spin && q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
+	if (q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
 		if (blk_mq_poll_hybrid(q, cookie))
 			return 1;
 	}
-	return blk_mq_poll_classic(q, cookie, spin);
+	return blk_mq_poll_classic(q, cookie, flags);
 }
 EXPORT_SYMBOL_GPL(blk_poll);
 
diff --git a/block/fops.c b/block/fops.c
index 15324f2e5a914..db8f2fe68dd27 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -108,7 +108,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		if (!READ_ONCE(bio.bi_private))
 			break;
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		    !blk_poll(bdev_get_queue(bdev), qc, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -141,12 +141,12 @@ struct blkdev_dio {
 
 static struct bio_set blkdev_dio_pool;
 
-static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
+static int blkdev_iopoll(struct kiocb *kiocb, unsigned int flags)
 {
 	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
+	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), flags);
 }
 
 static void blkdev_bio_end_io(struct bio *bio)
@@ -297,7 +297,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, true))
+		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5b625f97ee225..dc6af04d778f3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2461,15 +2461,16 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			long min)
 {
+	unsigned int poll_flags = 0;
 	struct io_kiocb *req, *tmp;
 	LIST_HEAD(done);
-	bool spin;
 
 	/*
 	 * Only spin for completions if we don't have multiple devices hanging
 	 * off our complete list, and we're under the requested amount.
 	 */
-	spin = !ctx->poll_multi_queue && *nr_events < min;
+	if (ctx->poll_multi_queue || *nr_events >= min)
+		poll_flags |= BLK_POLL_ONESHOT;
 
 	list_for_each_entry_safe(req, tmp, &ctx->iopoll_list, inflight_entry) {
 		struct kiocb *kiocb = &req->rw.kiocb;
@@ -2487,11 +2488,11 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		if (!list_empty(&done))
 			break;
 
-		ret = kiocb->ki_filp->f_op->iopoll(kiocb, spin);
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, poll_flags);
 		if (unlikely(ret < 0))
 			return ret;
-		else if (ret)
-			spin = false;
+		if (ret)
+			poll_flags |= BLK_POLL_ONESHOT;
 
 		/* iopoll may have completed current req */
 		if (READ_ONCE(req->iopoll_completed))
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 560ae967f70e8..236aba256cd17 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -49,13 +49,13 @@ struct iomap_dio {
 	};
 };
 
-int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
+int iomap_dio_iopoll(struct kiocb *kiocb, unsigned int flags)
 {
 	struct request_queue *q = READ_ONCE(kiocb->private);
 
 	if (!q)
 		return 0;
-	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), spin);
+	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), flags);
 }
 EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
 
@@ -642,7 +642,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (!(iocb->ki_flags & IOCB_HIPRI) ||
 			    !dio->submit.last_queue ||
 			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie, true))
+					 dio->submit.cookie, 0))
 				blk_io_schedule();
 		}
 		__set_current_state(TASK_RUNNING);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17705c970d7e1..e177346bc0208 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -564,7 +564,9 @@ extern const char *blk_op_str(unsigned int op);
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
-int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
+/* only poll the hardware once, don't continue until a completion was found */
+#define BLK_POLL_ONESHOT		(1 << 0)
+int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd20..c443cddf414fd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2075,7 +2075,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
-	int (*iopoll)(struct kiocb *kiocb, bool spin);
+	int (*iopoll)(struct kiocb *kiocb, unsigned int flags);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 24f8489583ca7..1e86b65567c21 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -337,7 +337,7 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
-int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
+int iomap_dio_iopoll(struct kiocb *kiocb, unsigned int flags);
 
 #ifdef CONFIG_SWAP
 struct file;
diff --git a/mm/page_io.c b/mm/page_io.c
index c493ce9ebcf50..5d5543fcefa4e 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -428,7 +428,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		if (!READ_ONCE(bio->bi_private))
 			break;
 
-		if (!blk_poll(disk->queue, qc, true))
+		if (!blk_poll(disk->queue, qc, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.30.2

