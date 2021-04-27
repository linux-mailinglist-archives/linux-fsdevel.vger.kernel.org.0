Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7167336C928
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbhD0QUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhD0QTp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:19:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26C0C06138B;
        Tue, 27 Apr 2021 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zIhmXZ/vFd6CtYYyxjA6xYDFiwZe/UbTM7HWeEPtD6I=; b=Tfu5eVCvVCyocsZbSdcDz902W5
        BZqGOsNe1SOZEk3EVNVkbDY15GIoIziFtZai5U7XOxSswsfpE/0wIbooPtuQXAqINg/O+fSuQ8klz
        AIGJzwZiqe1Gvy1u+d03ZeDdjdv9fsV6HzZ2MNKryYatW1iAuKrFedJm4Aa2GiTiZyC1t45Yh8F7Z
        50L0taUC/5n3o/gkuu7WYqwoPYvts4hFQDA2JEovzQfzUFlcY+DbRyij81wf3lBttsPzHgkKSPot2
        uuFBwnthCa0m2LdLckTNLMr8LRBQ66RoGJZ8oqgY2L+0B2U6OxB6LLYUMiWPMcOfFFqP4vEBWJ7yF
        qYkHpcaQ==;
Received: from [2001:4bb8:18c:28b2:c772:7205:2aa4:840d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbQQF-00Gr4p-VD; Tue, 27 Apr 2021 16:18:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/15] blk-mq: remove blk_qc_t_to_tag and blk_qc_t_is_internal
Date:   Tue, 27 Apr 2021 18:16:10 +0200
Message-Id: <20210427161619.1294399-7-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210427161619.1294399-1-hch@lst.de>
References: <20210427161619.1294399-1-hch@lst.de>
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
index ba563ca57bd9..726f9dae5b54 100644
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

