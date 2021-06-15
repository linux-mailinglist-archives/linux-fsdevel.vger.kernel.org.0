Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526823A7EC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFONOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 09:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhFONOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:14:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4A6C061574;
        Tue, 15 Jun 2021 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zKY9jBpDwzuPywHQTnIwIIYWBI4TS/YDEVe6mpxMVhA=; b=gVN8qTLT/G5f8KzrTDgwdG8oMO
        qAdB4fVnGFj3k7ULLjaLVyLsueOStdqG9ol08wbAt9VtOyg7dDFN9eUzipK4M4xSx8geRRTUTw0YH
        1phGorzonpOSWGCWGKTp0+ctuQGKicDtwgw5X+plHS3wfB8m1JsSOqPJ21eR7rL2nO9nCfRYtMsnk
        vNp09mOPdYTbUZ7nV2oNalmT2sqb5DfKirL/i1K0ua5KtJ7agAtPpWlrtnkA3cONSx8CyXMInITWy
        UPrtICgOtusbfclSju8zgRZUoe7xc5evxZlx2+pJ0Ym9CcugVrUB5oYFjKJM4QhNR1n8HOYZPjMtz
        7JRJw8xQ==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt8qr-006nBy-DJ; Tue, 15 Jun 2021 13:11:37 +0000
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
Subject: [PATCH 04/16] blk-mq: factor out a blk_qc_to_hctx helper
Date:   Tue, 15 Jun 2021 15:10:22 +0200
Message-Id: <20210615131034.752623-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to get the hctx from a request_queue and cookie, and fold
the blk_qc_t_to_queue_num helper into it as no other callers are left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c            | 8 +++++++-
 include/linux/blk_types.h | 5 -----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3115ea2d0990..9b3fe1062061 100644
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
@@ -3970,7 +3976,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+	hctx = blk_qc_to_hctx(q, cookie);
 
 	/*
 	 * If we sleep, have the caller restart the poll loop to reset
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index fd3860d18d7e..e2c4a7d5de05 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -511,11 +511,6 @@ static inline bool blk_qc_t_valid(blk_qc_t cookie)
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
2.30.2

