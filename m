Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA16D3A7EFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 15:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhFONSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 09:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFONSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:18:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4DAC061574;
        Tue, 15 Jun 2021 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qLPGexkyYM9Stdq39YTJB+tRWuoO4z3xvBgvAqEYJLU=; b=RRVq16UdE0V95vGQQqScEwzNhN
        Q+fKQVK9nbuQQVA19JfnpFkhzgoTpFe1Tnr9dUjR+0jpSYw4Z1Byz90/ItoHYC4izNlXsdmtvHRrf
        qbANMlhMDfi5XXcdb0nMXMYpEd89hD3Gi+evPovwPZqX1Sp68x9Rk0poWpZCwce0CTCENpb6cBoiB
        UtR6akwOAZvkYPOhqBPZxNGGwSxW2ToEm8b7eD2EZMgFJQZd2/Cm/e6Hm/L3IUzWufJUoZYL73XtB
        SylnL92aEgC0lHvlOUNctypODvibW2yclPSUZ0X5bTn4iVdRWWDp/1X2yuN1a3sVpHQqOktesBaVb
        +y690xxw==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt8uG-006nSt-7q; Tue, 15 Jun 2021 13:15:10 +0000
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
Subject: [PATCH 16/16] nvme-multipath: enable polled I/O
Date:   Tue, 15 Jun 2021 15:10:34 +0200
Message-Id: <20210615131034.752623-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Set the poll queue flag to enable polling, given that the multipath
node just dispatches the bios to a lower queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/host/multipath.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f77b774699de..48ea649d6c24 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -450,6 +450,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, head->disk->queue);
 	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, head->disk->queue);
+	/*
+	 * This assumes all controllers that refer to a namespace either
+	 * support poll queues or not.  That is not a strict guarantee,
+	 * but if the assumption is wrong the effect is only suboptimal
+	 * performance but not correctness problem.
+	 */
+	if (ctrl->tagset->nr_maps > HCTX_TYPE_POLL &&
+	    ctrl->tagset->map[HCTX_TYPE_POLL].nr_queues)
+		blk_queue_flag_set(QUEUE_FLAG_POLL, head->disk->queue);
 
 	/* set to a default value of 512 until the disk is validated */
 	blk_queue_logical_block_size(head->disk->queue, 512);
-- 
2.30.2

