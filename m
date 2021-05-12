Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6990937BDDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhELNRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhELNRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:17:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75B7C061763;
        Wed, 12 May 2021 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JDmsJ/pSyuqPz8uukIe3TMrAfuxHXUxMtRdXXUli2rQ=; b=XudR05yoUSf+kg6wgALnugwwFt
        bkyuyVi8/WNgnDEzsPQoDwOvqPad52Yauwctwiy/LwZ0BDy4/VI61vxCqoRK5d04Qj4OnHesgRARY
        AMz6JPyjqTrlfSKs6BULvHPjpRhpNLi9pcs3DI/HiJruONaUxQ7htRhE/zMaNF4X0kxQFnPbTUgGd
        71YPqX7couwZrq21TAAPxseJtLqkGW3C0vwYCUsPKS38J6DIE5cufz5di+JgWcIVqGpHRXoEyG6Hb
        Gn57qPEWeJr1xLbLXiTHLUyPST4bhmmMgIGHItIwkbN6RMluC4ZhcUfVGHJ9Nd3TS93hg5giD9mY0
        hvrVEVnA==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoiX-00AO2e-3b; Wed, 12 May 2021 13:16:01 +0000
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
Subject: [PATCH 05/15] blk-mq: factor out a "classic" poll helper
Date:   Wed, 12 May 2021 15:15:35 +0200
Message-Id: <20210512131545.495160-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor the code to do the classic full metal polling out of blk_poll into
a separate blk_mq_poll_classic helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 120 +++++++++++++++++++++++--------------------------
 1 file changed, 56 insertions(+), 64 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 04e17d50fb02..72d5559e4bba 100644
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
@@ -3796,15 +3804,20 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
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
@@ -3846,32 +3859,48 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 
 	__set_current_state(TASK_RUNNING);
 	destroy_hrtimer_on_stack(&hs.timer);
+
+	/*
+	 * If we sleep, have the caller restart the poll loop to reset the
+	 * state.  Like for the other success return cases, the caller is
+	 * responsible for checking if the IO completed.  If the IO isn't
+	 * complete, we'll get called again and will go straight to the busy
+	 * poll loop.
+	 */
 	return true;
 }
 
-static bool blk_mq_poll_hybrid(struct request_queue *q,
-			       struct blk_mq_hw_ctx *hctx, blk_qc_t cookie)
+static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
+		bool spin)
 {
-	struct request *rq;
+	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, cookie);
+	long state = current->state;
+	int ret;
 
-	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
-		return false;
+	hctx->poll_considered++;
 
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
+	do {
+		hctx->poll_invoked++;
 
-	return blk_mq_poll_hybrid_sleep(q, rq);
+		ret = q->mq_ops->poll(hctx);
+		if (ret > 0) {
+			hctx->poll_success++;
+			__set_current_state(TASK_RUNNING);
+			return ret;
+		}
+
+		if (signal_pending_state(state, current))
+			__set_current_state(TASK_RUNNING);
+		if (current->state == TASK_RUNNING)
+			return 1;
+
+		if (ret < 0 || !spin)
+			break;
+		cpu_relax();
+	} while (!need_resched());
+
+	__set_current_state(TASK_RUNNING);
+	return 0;
 }
 
 /**
@@ -3888,9 +3917,6 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
  */
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
-	struct blk_mq_hw_ctx *hctx;
-	long state;
-
 	if (!blk_qc_t_valid(cookie) ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
@@ -3898,46 +3924,12 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	hctx = blk_qc_to_hctx(q, cookie);
-
-	/*
-	 * If we sleep, have the caller restart the poll loop to reset
-	 * the state. Like for the other success return cases, the
-	 * caller is responsible for checking if the IO completed. If
-	 * the IO isn't complete, we'll get called again and will go
-	 * straight to the busy poll loop. If specified not to spin,
-	 * we also should not sleep.
-	 */
-	if (spin && blk_mq_poll_hybrid(q, hctx, cookie))
-		return 1;
-
-	hctx->poll_considered++;
-
-	state = current->state;
-	do {
-		int ret;
-
-		hctx->poll_invoked++;
-
-		ret = q->mq_ops->poll(hctx);
-		if (ret > 0) {
-			hctx->poll_success++;
-			__set_current_state(TASK_RUNNING);
-			return ret;
-		}
-
-		if (signal_pending_state(state, current))
-			__set_current_state(TASK_RUNNING);
-
-		if (current->state == TASK_RUNNING)
+	/* If specified not to spin, we also should not sleep. */
+	if (spin && q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
+		if (blk_mq_poll_hybrid(q, cookie))
 			return 1;
-		if (ret < 0 || !spin)
-			break;
-		cpu_relax();
-	} while (!need_resched());
-
-	__set_current_state(TASK_RUNNING);
-	return 0;
+	}
+	return blk_mq_poll_classic(q, cookie, spin);
 }
 EXPORT_SYMBOL_GPL(blk_poll);
 
-- 
2.30.2

