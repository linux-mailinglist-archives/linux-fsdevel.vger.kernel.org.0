Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5538136B454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhDZNzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZNzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:55:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420D5C061574;
        Mon, 26 Apr 2021 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=h8m2F3fVcz3+U5q+AjT2TcAFXYp4ZOa8Rn47WMm/SNE=; b=CN49v/Bbl4xKnVBGRjtTvAz9R0
        yjEIOC2AII2Wkbh5vrjY4gujrpsck3CEIyP9ZRQ5nr715ySpMLT6Dx1wWHhHKPoOL9tCKxu0zbZyi
        H/Ij/7hl1nzxVdKssBfIzdQKQNx7dfizVRrEMEQWdNHnJVyVgKftFDpmlM/g6yvlEEKfNyD3OXqSF
        0MjSljeSimvFHNonWjbMWttWEBbzh8BhXRLKDV54y97H7/5tN491vWtoRQCyMvxKNWdkooaf+zzgC
        IXF5x3iEtET30095Lrt/TdHKfI6gn8UDJvhYuAngWxZ0IiJKqsf+SHzE6X3KPG9GI1AvdfowYIiG1
        skK9nvOQ==;
Received: from [2001:4bb8:18c:28b2:8b12:7453:9423:67a4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1hZ-00Fzng-H6; Mon, 26 Apr 2021 13:55:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/12] blk-mq: factor out a "classic" poll helper
Date:   Mon, 26 Apr 2021 15:48:13 +0200
Message-Id: <20210426134821.2191160-5-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
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
 block/blk-mq.c | 63 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 927189a55575..4a72d3fa7964 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3853,6 +3853,39 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, rq);
 }
 
+static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t qc, bool spin)
+{
+	struct blk_mq_hw_ctx *hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(qc)];
+	long state = current->state;
+
+	hctx->poll_considered++;
+
+	do {
+		int ret;
+
+		hctx->poll_invoked++;
+
+		ret = q->mq_ops->poll(hctx);
+		if (ret > 0) {
+			hctx->poll_success++;
+			__set_current_state(TASK_RUNNING);
+			return ret;
+		}
+
+		if (signal_pending_state(state, current))
+			__set_current_state(TASK_RUNNING);
+
+		if (current->state == TASK_RUNNING)
+			return 1;
+		if (ret < 0 || !spin)
+			break;
+		cpu_relax();
+	} while (!need_resched());
+
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
 /**
  * blk_poll - poll for IO completions
  * @q:  the queue
@@ -3868,7 +3901,6 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
-	long state;
 
 	if (!blk_qc_t_valid(cookie) ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
@@ -3889,34 +3921,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	 */
 	if (spin && blk_mq_poll_hybrid(q, hctx, cookie))
 		return 1;
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
-			return 1;
-		if (ret < 0 || !spin)
-			break;
-		cpu_relax();
-	} while (!need_resched());
-
-	__set_current_state(TASK_RUNNING);
-	return 0;
+	return blk_mq_poll_classic(q, cookie, spin);
 }
 EXPORT_SYMBOL_GPL(blk_poll);
 
-- 
2.30.1

