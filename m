Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F3837BDE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhELNRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhELNR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:17:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202F7C06138F;
        Wed, 12 May 2021 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dEGRgMGQQwP4FfVOy4dsOUeKKeFm50mq3cJYorsfvYg=; b=SfCyJDBMSucMIZ/bNm1qiN43qX
        SdYZFIkPhjdKbv1a+lnn7Srgw8uVG0c25s/6i7rFNHtASbgaOdh7VjDStCWiqHpbchidU6bkWKint
        CGHYWe0Km3/b1pZMcdJ5cPa6uKCZW89oQBsWvefZg4YdX+co/BGHvpedmSRQuGJvSmVWB9iXyO40K
        MUYQ8hcXS30xxdIEGXG7Pnws7ZqyQ/yjT1O8zv4/J2T0P4AbE8wXqYmDnHGVigdIrXhZ5+RfOrUpX
        S3Fz4JgB1PSE/W0QCgPKNBJPl5Y+bw8Nn7hQpT1k0HM4IcN7cbej0/4akoscptE61ijuvboijvj4m
        bui8KETA==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoic-00AO3U-GD; Wed, 12 May 2021 13:16:07 +0000
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
Subject: [PATCH 07/15] blk-mq: remove blk_qc_t_valid
Date:   Wed, 12 May 2021 15:15:37 +0200
Message-Id: <20210512131545.495160-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
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
index 919712e2b34c..ac0b517c5503 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3919,7 +3919,7 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
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
2.30.2

