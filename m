Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24FC36B45B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhDZN4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbhDZN4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:56:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1D0C061574;
        Mon, 26 Apr 2021 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=o1FY6CTl0qvPBJnKwDpocv7ICvwHj49ZEX485bbqHLA=; b=K6AKjczOc8Rq1DKEcWFN0QgeyO
        r1quXTxvMpzPykk0rf1+oDs/Qp2T3knmSoVFeHBQJr2XrvAcJNQlHbb3R2t49CdF9UGZAcOd9xfqW
        bJ1ytpCYy1167X+HcvcAhCPKeNuOEcA7rtbhx68Rx6Bw3BX5lcCDrvyti+QXjNu4cAPl1pVu1OtE9
        ucERUIliGPW/90+xWdYSL311U2GlZPKMG/xugGvsaqnEjhto74Lvta4EBLkPbgRQHbW3gjM7JoSLM
        BEXo1ITfZqiMBLWgTlAHlNZN/i6BN5rGxmws14Svzp/981EIaPmDoO5t2OqonUZUoxJi3XTcYUYpt
        0l8HKApQ==;
Received: from [2001:4bb8:18c:28b2:8b12:7453:9423:67a4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1hj-00Fzod-Uw; Mon, 26 Apr 2021 13:55:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/12] blk-mq: remove blk_qc_t_valid
Date:   Mon, 26 Apr 2021 15:48:17 +0200
Message-Id: <20210426134821.2191160-9-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the trivial check into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c            | 2 +-
 include/linux/blk_types.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 846e1c51128d..40b20f7986c1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3896,7 +3896,7 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t qc, bool spin)
  */
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
-	if (!blk_qc_t_valid(cookie) ||
+	if (cookie == BLK_QC_T_NONE ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4c28ab22f93d..d0cf835d3b50 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -510,11 +510,6 @@ typedef unsigned int blk_qc_t;
 #define BLK_QC_T_SHIFT		16
 #define BLK_QC_T_INTERNAL	(1U << 31)
 
-static inline bool blk_qc_t_valid(blk_qc_t cookie)
-{
-	return cookie != BLK_QC_T_NONE;
-}
-
 struct blk_rq_stat {
 	u64 mean;
 	u64 min;
-- 
2.30.1

