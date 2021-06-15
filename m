Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3353A7EEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 15:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFONRR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 09:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhFONRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:17:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C3C061574;
        Tue, 15 Jun 2021 06:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3z22i3o1IYVvzDBHHwFmESs6m1NW1WLgP5++bAzjFgg=; b=rhGVhXPRuuMavZ8mOb+BymSVHB
        EHVl8Yzdi/UJpS3Z9ChEzJSWLaORZFCWSnkV9SJdbS86HaP1BNtgDdo4slchhO6yHVNT2/A6EugPf
        BhsCgg5jjPoxFlUyF7Qyb1uG4OOsihS/vNa4be12bnWCkhqtWg6Y+nvCExGXAzYj3GBcsTvXxdA67
        X5e383ErlNa2Q/X7yzudlEdPESPJj05+T/fkw82dP7tSpZkDc6wros7nJvKo9JY76KfRYhA0I5g/a
        yMr0TxB5fmN5ycLYokgKFXYglnYUCLo2hUkvmmiJl2JahkkxoNg4DGYRr320vBK1YogPtQKCGUJwj
        yzljWZQw==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt8te-006nPp-4c; Tue, 15 Jun 2021 13:14:30 +0000
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
Subject: [PATCH 14/16] block: don't allow writing to the poll queue attribute
Date:   Tue, 15 Jun 2021 15:10:32 +0200
Message-Id: <20210615131034.752623-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
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
index f89e2fc3963b..f78e73ca6091 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -428,26 +428,11 @@ static ssize_t queue_poll_show(struct request_queue *q, char *page)
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

