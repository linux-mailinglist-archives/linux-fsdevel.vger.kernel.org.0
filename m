Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52E742A361
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 13:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbhJLLgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 07:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhJLLga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:36:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44931C061570;
        Tue, 12 Oct 2021 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tneaoMD9sFq3X6FLJdwBi1IxEWuqgBQnrLkwkZNVHD4=; b=OaId8asF2rWnk2NFA8OnHW8gJB
        mmSa1VY8nNIqtFC5h4WwG7RzwsHD87I07v6Dopgnc/WAoRnDMuh+WDxx5i+a4safPiaerC3/u26yk
        oNxfwQog9k6KQvRT0SITL2uNUWhvhMFnkvH/u5xSNkhXZp0nQd7sLDa7eozCW8wzIAHdDnJHibaQD
        Xu8vHwMbsoFv56RiYqz80i55zjz0Ddu2jzPYMQHZngg/O2gi/G1n9kxiXzvP1tiqfOEuKeH3ARQYw
        qqxpR9SoHZ9ZbE14d0+BVbuKHVOQ+ha+jpbZDDy0copLt6qGMgpNYpsOsQmL2n6wu4084++9s4lV4
        feKL5wCw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maG13-006SUg-A2; Tue, 12 Oct 2021 11:32:36 +0000
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
Subject: [PATCH 15/16] block: don't allow writing to the poll queue attribute
Date:   Tue, 12 Oct 2021 13:12:25 +0200
Message-Id: <20211012111226.760968-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The poll attribute is a historic artefact from before when we had
explicit poll queues that require driver specific configuration.
Just print a warning when writing to the attribute.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-sysfs.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index da883efcba33a..36f14d658e816 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -433,26 +433,11 @@ static ssize_t queue_poll_show(struct request_queue *q, char *page)
 static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 				size_t count)
 {
-	unsigned long poll_on;
-	ssize_t ret;
-
-	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
-	    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return -EINVAL;
-
-	ret = queue_var_store(&poll_on, page, count);
-	if (ret < 0)
-		return ret;
-
-	if (poll_on) {
-		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
-	} else {
-		blk_mq_freeze_queue(q);
-		blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
-		blk_mq_unfreeze_queue(q);
-	}
-
-	return ret;
+	pr_info_ratelimited("writes to the poll attribute are ignored.\n");
+	pr_info_ratelimited("please use driver specific parameters instead.\n");
+	return count;
 }
 
 static ssize_t queue_io_timeout_show(struct request_queue *q, char *page)
-- 
2.30.2

