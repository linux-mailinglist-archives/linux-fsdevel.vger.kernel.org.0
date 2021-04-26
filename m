Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B923436B458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhDZNz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhDZNz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:55:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326B0C061760;
        Mon, 26 Apr 2021 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=D47Ua73ZdjgPgS3yqaNiOsjl7ShxCY8d//RRzGgixek=; b=p8z1MSWmUxPuSEUTqbEdGE9Eg8
        jrUVccfn3rTCS1qA9f5JvnJ2o2xFkmliGe4KaN1H+MnRekGaBP6vsZyDdssYUj+txpHD8lyGuZcXQ
        mii1LP+Rw3ExN4pgGmxOKAHQn+cyBpqxhLePZG/6Wmqh5rZz0nYAjXkzOTOrBaH6qZTJ94IjfLoka
        IuO+IConkj68G1OrXOGAePgHkgSaoXjYrvBu9vnF/cf6KYJNR8Ujxy2w6UhhwvoSzdRcu2HMeENJf
        EyiCN+l81i40diOKL34M6YSw1yBHWWj1JUhYoYiUCxYdrbFewRX4oKUFv/oEE47vFIcDWMhBNDLku
        MBxc96Cw==;
Received: from [2001:4bb8:18c:28b2:8b12:7453:9423:67a4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1he-00Fzo5-NK; Mon, 26 Apr 2021 13:55:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/12] blk-mq: refactor hybrid polling
Date:   Mon, 26 Apr 2021 15:48:15 +0200
Message-Id: <20210426134821.2191160-7-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor the hybrid polling logic by moving the request lookup into a
helper, and the check if hybrid polling is enabled into blk_poll, and
then merging blk_mq_poll_hybrid and blk_mq_poll_hybrid_sleep into a
single function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 65 +++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3dde5e7b2251..15a8bfd27aa2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -69,6 +69,14 @@ static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
 	return q->queue_hw_ctx[(qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT];
 }
 
+static inline struct request *blk_qc_to_rq(struct blk_mq_hw_ctx *hctx,
+		blk_qc_t qc)
+{
+	if (blk_qc_t_is_internal(qc))
+		return blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(qc));
+	return blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(qc));
+}
+
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -3781,15 +3789,20 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	return ret;
 }
 
-static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
-				     struct request *rq)
+static bool blk_mq_poll_hybrid(struct request_queue *q, blk_qc_t qc)
 {
+	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, qc);
+	struct request *rq = blk_qc_to_rq(hctx, qc);
 	struct hrtimer_sleeper hs;
 	enum hrtimer_mode mode;
 	unsigned int nsecs;
 	ktime_t kt;
 
-	if (rq->rq_flags & RQF_MQ_POLL_SLEPT)
+	/*
+	 * If a request has completed on queue that uses an I/O scheduler, we
+	 * won't get back a request from blk_qc_to_rq.
+	 */
+	if (!rq || (rq->rq_flags & RQF_MQ_POLL_SLEPT))
 		return false;
 
 	/*
@@ -3834,31 +3847,6 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	return true;
 }
 
-static bool blk_mq_poll_hybrid(struct request_queue *q,
-			       struct blk_mq_hw_ctx *hctx, blk_qc_t cookie)
-{
-	struct request *rq;
-
-	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
-		return false;
-
-	if (!blk_qc_t_is_internal(cookie))
-		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
-	else {
-		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
-		/*
-		 * With scheduling, if the request has completed, we'll
-		 * get a NULL return here, as we clear the sched tag when
-		 * that happens. The request still remains valid, like always,
-		 * so we should be safe with just the NULL check.
-		 */
-		if (!rq)
-			return false;
-	}
-
-	return blk_mq_poll_hybrid_sleep(q, rq);
-}
-
 static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t qc, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, qc);
@@ -3906,8 +3894,6 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t qc, bool spin)
  */
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
-	struct blk_mq_hw_ctx *hctx;
-
 	if (!blk_qc_t_valid(cookie) ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
@@ -3915,18 +3901,17 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	hctx = blk_qc_to_hctx(q, cookie);
-
 	/*
-	 * If we sleep, have the caller restart the poll loop to reset
-	 * the state. Like for the other success return cases, the
-	 * caller is responsible for checking if the IO completed. If
-	 * the IO isn't complete, we'll get called again and will go
-	 * straight to the busy poll loop. If specified not to spin,
-	 * we also should not sleep.
+	 * If we sleep, have the caller restart the poll loop to reset the
+	 * state.  Like for the other success return cases, the caller is
+	 * responsible for checking if the IO completed.  If the IO isn't
+	 * complete, we'll get called again and will go straight to the busy
+	 * poll loop. If specified not to spin, we also should not sleep.
 	 */
-	if (spin && blk_mq_poll_hybrid(q, hctx, cookie))
-		return 1;
+	if (spin && q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
+		if (blk_mq_poll_hybrid(q, cookie))
+			return 1;
+	}
 	return blk_mq_poll_classic(q, cookie, spin);
 }
 EXPORT_SYMBOL_GPL(blk_poll);
-- 
2.30.1

