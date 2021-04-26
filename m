Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B5736B459
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhDZN4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbhDZN4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:56:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA7C061574;
        Mon, 26 Apr 2021 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QbV8AgDud8Altk8SgdzfEknApx0Bp/jd0omJ5D+WIi8=; b=arDWuXXpGtNgnVek9ijXHp4uTD
        0ACseAUjyUm/zpOVlj/8wOJY9a2UTK3aVcqXDLqUP1zZDFwRl5HQDKiBI4W+uFB8BRv3i/80K0U96
        7NqQuF2GQpU97dit6xRVOpkcmLbktC8wxR7m3glL4i6PsSNiKTccwxZ4WCpOBSQk6oS6OKgVd5mZX
        ypIULW7M/qLPkXojd4RU9OZJ99KtZ4utQDhDGOTnO0OcCUDfZulBQXWLFXAfnQdlN/REsIvdAKiin
        GvuUGUNAK3z3cGF37hL9wWfj7LUQoboBnXwVM3loHKSwcy+ZauiHu+e+8QP6eiyQwoDtj3yLL9FGU
        0490VBGw==;
Received: from [2001:4bb8:18c:28b2:8b12:7453:9423:67a4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1hh-00FzoU-CW; Mon, 26 Apr 2021 13:55:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/12] blk-mq: remove blk_qc_t_to_tag and blk_qc_t_is_internal
Date:   Mon, 26 Apr 2021 15:48:16 +0200
Message-Id: <20210426134821.2191160-8-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge both functions into their only caller to keep the blk-mq tag to
blk_qc_t mapping as private as possible in blk-mq.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c            |  8 +++++---
 include/linux/blk_types.h | 10 ----------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 15a8bfd27aa2..846e1c51128d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -72,9 +72,11 @@ static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
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
index ed71a8d968f2..4c28ab22f93d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -515,16 +515,6 @@ static inline bool blk_qc_t_valid(blk_qc_t cookie)
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
2.30.1

