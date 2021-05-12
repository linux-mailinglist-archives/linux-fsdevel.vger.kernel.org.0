Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7249D37BDEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhELNSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhELNRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:17:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00B1C06138C;
        Wed, 12 May 2021 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=j5xtD4dLrWl+f8ewCxfPu2i9g8nlqr3jf+vNj4lOeX0=; b=FDhN3W1x7xreHa65JIpv0t50LY
        ONao9zLhnfupPdLaJq/H3p5AUIQc6sDrtMe2T3Gs0nJve58zevGXAYUFbdiH5SgV/l3PPvPd2D2rh
        KRK0O8CF6EtCd+YVac3PhUbcmKJW3hKruThCyoGj4SK32W/DklPMKS8wO72YJaDVZW0YKqfyRCx+B
        vSREj81ukE1xpJWs8wCoM3j4G7JSqHV78WWk2qNIteJ91HwEWBYb53pa7VYbsFQMxTmS88Epn8j6P
        cuMnkvV2WLYs1t6nfITvFj4t9dkeA7tFfSMdhiv1QDogpMNVou09lEgYqmgj7VL7oMLXc+pJoG+iH
        3eqlM8BA==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoit-00AO5G-Ke; Wed, 12 May 2021 13:16:24 +0000
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
Subject: [PATCH 13/15] block: don't allow writing to the poll queue attribute
Date:   Wed, 12 May 2021 15:15:43 +0200
Message-Id: <20210512131545.495160-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The poll attribute is a historic artefact from before when we had
explicit poll queues that require driver specific configuration.
Just print a warning when writing to the attribute.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

