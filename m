Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F036236C951
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhD0QYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbhD0QVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:21:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC1C06138D;
        Tue, 27 Apr 2021 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uo37evwGZllpIBJJs6mBOz6GCzAecaMYRuuhq2kwAKs=; b=UjqyaTW0+HUeB850F2dTtC25Ld
        3MgwhDgPw6BsyvWz9KDexAhVzu6tAkxV6V1mPHF9zWCR/jOJE5+7IsW/PmBB3VxZeJmX11L75c5O/
        LgI+XASXOJ20yqZUqV9eP54UdtI3p278pDGUzQh5ZGaGabveN+GLa4hlYwpfX12wLMKG/sVjJLmul
        EE26ExTtIowNFE/Rwq0W9asW+3JquVsWg5Sn2j3IuYeNPMNAh5nf6MelSL9WSaK9N512sIMuuPeFA
        AiGThb0fxnh/u0uLrNR9nheOGcJPzu1+1KmIoM2HReVXVe8kyQ1iLP49aLzhs5TptDcBrn0P8mIs2
        QiCwVm/w==;
Received: from [2001:4bb8:18c:28b2:c772:7205:2aa4:840d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbQQg-00Gr6w-Py; Tue, 27 Apr 2021 16:19:19 +0000
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
Subject: [PATCH 15/15] nvme-multipath: enable polled I/O
Date:   Tue, 27 Apr 2021 18:16:19 +0200
Message-Id: <20210427161619.1294399-16-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210427161619.1294399-1-hch@lst.de>
References: <20210427161619.1294399-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Set the poll queue flags to enable polling, given that the multipath
node just dispatches the bios to a lower queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1d17b2387884..0fa38f648ae7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -443,6 +443,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		goto out;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
+	blk_queue_flag_set(QUEUE_FLAG_POLL_CAPABLE, q);
+	blk_queue_flag_set(QUEUE_FLAG_POLL, q);
 
 	/* set to a default value for 512 until disk is validated */
 	blk_queue_logical_block_size(q, 512);
-- 
2.30.1

