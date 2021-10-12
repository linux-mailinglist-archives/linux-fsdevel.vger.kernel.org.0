Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB342A364
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 13:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhJLLiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 07:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLLiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:38:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90094C061570;
        Tue, 12 Oct 2021 04:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ww+Ty4M+5zg/6wB4vhxhfQ/Y0ChJVLWnI6STKNcR1EI=; b=h359ZifKSODfVXcNXExLeBAuZ6
        owLMPSJo8jyUmWBC0YBM5UYQr/YGl+tE6ziIP58Vy9a7eJO3PllGMLVOL8HrkkWniusP2V2YpfH9s
        w8+lu7k+tZtjrc4llqDdOf5+2yQHcHaltANwPmU7pY9Xuxq+CxdhzT/Z5pAyRQZZrsctLW6sunyLF
        caJ0e3Q0r/gktJd7G+6ente47vEUPYeNvBVUFjIKyX9aemeN8fGk7QcPged9attmdHp8EVOxQ6aE8
        VajanxrWgt6HZseacppVuKFKKaiazA++atMhBBFpMDFj0EwywRbTmXFGmBFxOX87Njuc7oWZG7Iph
        as+DL7pA==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maG21-006SXv-A7; Tue, 12 Oct 2021 11:33:36 +0000
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
Date:   Tue, 12 Oct 2021 13:12:26 +0200
Message-Id: <20211012111226.760968-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
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
 drivers/nvme/host/multipath.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 4a3252651f69e..d5d7bbb1bc6ab 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -85,8 +85,13 @@ void nvme_failover_req(struct request *req)
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	for (bio = req->bio; bio; bio = bio->bi_next)
+	for (bio = req->bio; bio; bio = bio->bi_next) {
 		bio_set_dev(bio, ns->head->disk->part0);
+		if (bio->bi_opf & REQ_POLLED) {
+			bio->bi_opf &= ~REQ_POLLED;
+			bio->bi_cookie = BLK_QC_T_NONE;
+		}
+	}
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
@@ -479,6 +484,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
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

