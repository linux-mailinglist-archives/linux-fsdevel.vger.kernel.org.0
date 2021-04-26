Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA1F36B456
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhDZNz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZNzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:55:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05405C061574;
        Mon, 26 Apr 2021 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZGqoXDvGl7XEK1ZD/kOSK3Ondq/bXMcKa/xHEW9XJNY=; b=JCaQxlzMLrVJyLMxmP4A1kGZ0A
        9U4Q4N4Le25mc6lJrenr6xAhiv9E+vTupt42kauBzRDTLQbNQEm7ZcmcispMfaSJXRrsZjvcUPmi7
        gchGVN8A/FWgpXA4vLcvS9fQdLRwPq8Ay7b78pDjDBCaYzBMlW8BiPuy70pcC9WWPW2eGsXNTT/tm
        DtYC6vq07FwVggPTWAKDekuLZpoBRbcm9hqMvlHB79xvRFJpqIflPa5HYuJAC62Kss4Y1R/EbRQ6y
        tMcuTfOorLMatygQvIBWahSAbdj4m6prDHihhUaT+lwz3BN5L9671n8JZdu9yUUcwCDBXxLkXXysJ
        7asZFpBw==;
Received: from [2001:4bb8:18c:28b2:8b12:7453:9423:67a4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1hc-00Fznn-3r; Mon, 26 Apr 2021 13:55:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/12] blk-mq: factor out a blk_qc_to_hctx helper
Date:   Mon, 26 Apr 2021 15:48:14 +0200
Message-Id: <20210426134821.2191160-6-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to get the hctx from a request_queue and cookie, and fold
the blk_qc_t_to_queue_num helper into it as no other callers are left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c            | 10 ++++++++--
 include/linux/blk_types.h |  5 -----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4a72d3fa7964..3dde5e7b2251 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -63,6 +63,12 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 	return bucket;
 }
 
+static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
+		blk_qc_t qc)
+{
+	return q->queue_hw_ctx[(qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT];
+}
+
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -3855,7 +3861,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 
 static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t qc, bool spin)
 {
-	struct blk_mq_hw_ctx *hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(qc)];
+	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, qc);
 	long state = current->state;
 
 	hctx->poll_considered++;
@@ -3909,7 +3915,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+	hctx = blk_qc_to_hctx(q, cookie);
 
 	/*
 	 * If we sleep, have the caller restart the poll loop to reset
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..ed71a8d968f2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -515,11 +515,6 @@ static inline bool blk_qc_t_valid(blk_qc_t cookie)
 	return cookie != BLK_QC_T_NONE;
 }
 
-static inline unsigned int blk_qc_t_to_queue_num(blk_qc_t cookie)
-{
-	return (cookie & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT;
-}
-
 static inline unsigned int blk_qc_t_to_tag(blk_qc_t cookie)
 {
 	return cookie & ((1u << BLK_QC_T_SHIFT) - 1);
-- 
2.30.1

