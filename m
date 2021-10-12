Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D727C42A327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhJLLZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 07:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbhJLLZp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:25:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B47C061570;
        Tue, 12 Oct 2021 04:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2jekzTOKw0yWZJEvYoe5lmOtBAHrUy6faNmK+C8chh4=; b=le20fnhDpl3GUrRDjN4Qvw6cxo
        smssyG/HDe8ZP3W4YQ1O+n3E9BK1T0IcSqUsm7C6s9mpgUnzM55472ZnNn5dyHmJpRvzXoXkqOstG
        Q9aq7CyAyaNPnHY2Wr1t4T96FQ05BmcqGMCNfaLKUBqtOjcgPPcQsX1K8Wpk3GacCCTHg7XTIMHa+
        Q4km5+46KNioVgmNkRQmyEpd7LPBv23vbwALjaI/I7tiFoofKpYr25cHGfnVh4907ru9l4fciVCnl
        wXQBmWm+xT0nztpMMd3q2ZkAiyuZKeWTb7BGhu/llpKq0I4swcxfwYV4oFg088BLXzndoNABVVU9w
        LnJ0U7Gw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFpX-006Rou-IR; Tue, 12 Oct 2021 11:20:54 +0000
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
Subject: [PATCH 07/16] blk-mq: remove blk_qc_t_to_tag and blk_qc_t_is_internal
Date:   Tue, 12 Oct 2021 13:12:17 +0200
Message-Id: <20211012111226.760968-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge both functions into their only caller to keep the blk-mq tag to
blk_qc_t mapping as private as possible in blk-mq.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c            |  8 +++++---
 include/linux/blk_types.h | 10 ----------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 00bc595d8de6d..3d65e79a11db5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -74,9 +74,11 @@ static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
 static inline struct request *blk_qc_to_rq(struct blk_mq_hw_ctx *hctx,
 		blk_qc_t qc)
 {
-	if (blk_qc_t_is_internal(qc))
-		return blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(qc));
-	return blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(qc));
+	unsigned int tag = qc & ((1U << BLK_QC_T_SHIFT) - 1);
+
+	if (qc & BLK_QC_T_INTERNAL)
+		return blk_mq_tag_to_rq(hctx->sched_tags, tag);
+	return blk_mq_tag_to_rq(hctx->tags, tag);
 }
 
 /*
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 000351c5312af..fb7c1477617b8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -505,16 +505,6 @@ static inline bool blk_qc_t_valid(blk_qc_t cookie)
 	return cookie != BLK_QC_T_NONE;
 }
 
-static inline unsigned int blk_qc_t_to_tag(blk_qc_t cookie)
-{
-	return cookie & ((1u << BLK_QC_T_SHIFT) - 1);
-}
-
-static inline bool blk_qc_t_is_internal(blk_qc_t cookie)
-{
-	return (cookie & BLK_QC_T_INTERNAL) != 0;
-}
-
 struct blk_rq_stat {
 	u64 mean;
 	u64 min;
-- 
2.30.2

