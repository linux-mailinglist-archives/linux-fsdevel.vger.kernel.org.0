Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA936C932
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhD0QV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbhD0QTp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:19:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F575C06138D;
        Tue, 27 Apr 2021 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ybbAI1iIzd802GzTsijPVVjMuQUPzCVGqa18qmqkyWA=; b=AD9+OzEv8HfVhl9Xph/ZAkvUNV
        muPhE7EpEPJNPLRQUZ5GSlAq6TOMRbr+60TNGG007kCcBn8KLokWdd2rYL3z3KuaOiwr8RQYFSs6C
        e82OXMLh5u0Ng0lLHGMcmPwDBPhpdBNHQ+pOzx1Ribt36vrL3UWXHdWTrkySyFY7rmVSCHvzzgXBO
        SbWFJe/uiMNHD4qTNWqV0TO/da8FJCNZwUh23EC/p6xJ8OKMTprXGOux4LBT5zSCll4pAiDFQICJK
        AJhHoraQY6cyaJX7dOrclixezaEDCMVvrtzYVLI/4DiZTygp6R327Gh8q9qVKxajPEVOMuz4RZ+FG
        sT8BtP6Q==;
Received: from [2001:4bb8:18c:28b2:c772:7205:2aa4:840d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbQQI-00Gr50-O2; Tue, 27 Apr 2021 16:18:55 +0000
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
Subject: [PATCH 07/15] blk-mq: remove blk_qc_t_valid
Date:   Tue, 27 Apr 2021 18:16:11 +0200
Message-Id: <20210427161619.1294399-8-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210427161619.1294399-1-hch@lst.de>
References: <20210427161619.1294399-1-hch@lst.de>
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
index 726f9dae5b54..9fd06a3f01c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3904,7 +3904,7 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
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

