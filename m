Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D9537BDE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhELNRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhELNR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:17:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829ACC061761;
        Wed, 12 May 2021 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=luNFfyNFZzLX6vF2Qe7lJkbLwxvrfYzl8Q/eTvpkSTg=; b=JtC3c9NS281jP+56CGfDg+o6XT
        8ZWesnMfnhHnp1ZmKrCJme7YQFm6el+fk+W8bWvqmtk4c8tUFyXbD12+Opd+5t/5Qt3yrCJIXsw8w
        x9ZKPFnPJEToUoSJ3bnpjn9TI5DSto0FETlR7vd6fm8KpUyaSNS7PxO8rlXUDqBDOvvwKkNYqFds4
        yD9E7jSxQGW4gHdCPfsBsnxDUzXBMs2z0d4IjLYMBKeyETzMhvdNzXFB/PDVMDIe4gU4nu4K2GniX
        yDnzBhO1CYSu4dGyQ/JtRfHLMbOCbuk8St9yzSDdlDce66OBnfavwQGZx3Ua+iTPO3fziox2goLP0
        Ka6uubdg==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoif-00AO3q-94; Wed, 12 May 2021 13:16:09 +0000
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
Subject: [PATCH 08/15] io_uring: don't sleep when polling for I/O
Date:   Wed, 12 May 2021 15:15:38 +0200
Message-Id: <20210512131545.495160-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no point in sleeping for the expected I/O completion timeout
in the io_uring async polling model as we never poll for a specific
I/O.  Split the boolean spin argument to blk_poll into a set of flags
to control sleeping and the oneshot behavior separately.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c           | 18 ++++++++----------
 drivers/nvme/host/core.c |  2 +-
 fs/block_dev.c           |  8 ++++----
 fs/io_uring.c            | 14 +++++++-------
 fs/iomap/direct-io.c     |  6 +++---
 include/linux/blkdev.h   |  6 +++++-
 include/linux/fs.h       |  2 +-
 include/linux/iomap.h    |  2 +-
 mm/page_io.c             |  2 +-
 9 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ac0b517c5503..164e39d34bf6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3873,7 +3873,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q, blk_qc_t qc)
 }
 
 static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
-		bool spin)
+		unsigned int flags)
 {
 	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, cookie);
 	long state = current->state;
@@ -3896,7 +3896,7 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
 		if (current->state == TASK_RUNNING)
 			return 1;
 
-		if (ret < 0 || !spin)
+		if (ret < 0 || (flags & BLK_POLL_ONESHOT))
 			break;
 		cpu_relax();
 	} while (!need_resched());
@@ -3909,15 +3909,13 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
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
@@ -3926,12 +3924,12 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	/* If specified not to spin, we also should not sleep. */
-	if (spin && q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
+	if (!(flags & BLK_POLL_NOSLEEP) &&
+	    q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
 		if (blk_mq_poll_hybrid(q, cookie))
 			return 1;
 	}
-	return blk_mq_poll_classic(q, cookie, spin);
+	return blk_mq_poll_classic(q, cookie, flags);
 }
 EXPORT_SYMBOL_GPL(blk_poll);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 522c9b229f80..8fa7e90020b0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1032,7 +1032,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 	blk_execute_rq_nowait(bd_disk, rq, at_head, nvme_end_sync_rq);
 
 	while (!completion_done(&wait)) {
-		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
+		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), 0);
 		cond_resched();
 	}
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0080a3b710b4..fd12a05cb3a9 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -286,7 +286,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(bio.bi_private))
 			break;
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		    !blk_poll(bdev_get_queue(bdev), qc, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -319,12 +319,12 @@ struct blkdev_dio {
 
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
@@ -473,7 +473,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, true))
+		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index f46acbbeed57..7baa88abe630 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2288,18 +2288,18 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			long min)
 {
+	unsigned int poll_flags = BLK_POLL_NOSLEEP;
 	struct io_kiocb *req, *tmp;
 	LIST_HEAD(done);
-	bool spin;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Only spin for completions if we don't have multiple devices hanging
 	 * off our complete list, and we're under the requested amount.
 	 */
-	spin = !ctx->poll_multi_file && *nr_events < min;
+	if (ctx->poll_multi_file || *nr_events >= min)
+		poll_flags |= BLK_POLL_ONESHOT;
 
-	ret = 0;
 	list_for_each_entry_safe(req, tmp, &ctx->iopoll_list, inflight_entry) {
 		struct kiocb *kiocb = &req->rw.kiocb;
 
@@ -2315,7 +2315,7 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		if (!list_empty(&done))
 			break;
 
-		ret = kiocb->ki_filp->f_op->iopoll(kiocb, spin);
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, poll_flags);
 		if (ret < 0)
 			break;
 
@@ -2323,8 +2323,8 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		if (READ_ONCE(req->iopoll_completed))
 			list_move_tail(&req->inflight_entry, &done);
 
-		if (ret && spin)
-			spin = false;
+		if (ret)
+			poll_flags |= BLK_POLL_ONESHOT;
 		ret = 0;
 	}
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index d5637f467109..9b6c26da3a2d 100644
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
 
@@ -640,7 +640,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (!(iocb->ki_flags & IOCB_HIPRI) ||
 			    !dio->submit.last_queue ||
 			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie, true))
+					 dio->submit.cookie, 0))
 				blk_io_schedule();
 		}
 		__set_current_state(TASK_RUNNING);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1255823b2bc0..273b86714c7e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -947,7 +947,11 @@ extern const char *blk_op_str(unsigned int op);
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
-int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
+/* only poll the hardware once, don't continue until a completion was found */
+#define BLK_POLL_ONESHOT		(1 << 0)
+/* do not sleep to wait for the expected completion time */
+#define BLK_POLL_NOSLEEP		(1 << 1)
+int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..483fb557d92f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2026,7 +2026,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
-	int (*iopoll)(struct kiocb *kiocb, bool spin);
+	int (*iopoll)(struct kiocb *kiocb, unsigned int flags);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index c87d0cb0de6d..56e5949ccb60 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -275,7 +275,7 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
-int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
+int iomap_dio_iopoll(struct kiocb *kiocb, unsigned int flags);
 
 #ifdef CONFIG_SWAP
 struct file;
diff --git a/mm/page_io.c b/mm/page_io.c
index c493ce9ebcf5..5d5543fcefa4 100644
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

