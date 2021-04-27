Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E5836C93F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhD0QVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbhD0QUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:20:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43DCC061761;
        Tue, 27 Apr 2021 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ng4KGhTuRpeTyKKImesR+zTWZGj6X96YYP6xXXnEO2Q=; b=IQdLE4T5hOodA7mLeV+EzNRgZL
        NUt3TNL19PcNbqVu/y8bDO5zPxdjM4WM46Q+6oAGJ3Wn3z7L04UIsf/eyMCmcjHnERERZLJILoEMe
        BU2eVd9LDhgXwLpyA/wFAHP6ieGguD1gNA7zT3U95b6XPTlI1wlFe6iZ23G826gReehN47Rr95Z7y
        GpHtimD3b/UQXae3CqTU+8h7G167vYx2/JNXkSBUMUkqxy8AMZa/lYP1Tdm+9w+A/EF0xlDRZPVAo
        Cj/QXK6RNKEzHOYFsUbT8CjkVYoI7Wkn7HrbE5wkUaDCyduQqLaubN/D3n9/fVsRgyKS5ry0u/ECV
        VjNsqzpg==;
Received: from [2001:4bb8:18c:28b2:c772:7205:2aa4:840d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbQQa-00Gr6K-Ra; Tue, 27 Apr 2021 16:19:13 +0000
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
Subject: [PATCH 13/15] block: add a QUEUE_FLAG_POLL_CAPABLE flag
Date:   Tue, 27 Apr 2021 18:16:17 +0200
Message-Id: <20210427161619.1294399-14-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210427161619.1294399-1-hch@lst.de>
References: <20210427161619.1294399-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new flag to prepare for bio based stacking drivers that support
polling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 4 +++-
 block/blk-sysfs.c      | 3 +--
 include/linux/blkdev.h | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c26df1f68e5b..45e69eea2788 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3236,8 +3236,10 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 	if (set->nr_maps > HCTX_TYPE_POLL &&
-	    set->map[HCTX_TYPE_POLL].nr_queues)
+	    set->map[HCTX_TYPE_POLL].nr_queues) {
+		blk_queue_flag_set(QUEUE_FLAG_POLL_CAPABLE, q);
 		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
+	}
 
 	q->sg_reserved_size = INT_MAX;
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e03bedf180ab..258468a3ab9c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -431,8 +431,7 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	unsigned long poll_on;
 	ssize_t ret;
 
-	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
-	    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
+	if (!test_bit(QUEUE_FLAG_POLL_CAPABLE, &q->queue_flags))
 		return -EINVAL;
 
 	ret = queue_var_store(&poll_on, page, count);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5ed5cf57b4..366cf2a6d2e8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -600,6 +600,7 @@ struct request_queue {
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
 #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
+#define QUEUE_FLAG_POLL_CAPABLE	2	/* IO polling supported */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
 #define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
-- 
2.30.1

