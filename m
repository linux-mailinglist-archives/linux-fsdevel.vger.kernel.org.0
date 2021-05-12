Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4722537BDF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhELNSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhELNRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:17:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E77C06138D;
        Wed, 12 May 2021 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ErQiIq/YOmz4YzZ4E99a6RCK5eOX97ipCw7O3ph9DFs=; b=EQDE4xee/RkNRgVsT4OjfS6yh4
        ruKZgSDj7EHjo6N4MP7LWp/Z9GNkxpGCZQagOyTBpNK12CkFqg/UD4nSmtRHwXqhoTHyfZWQfjqrG
        9RIThTi0y3AB2WXSIpC4Pxo2phhhm7maPm+Sz7SyDf/qEThHO0yp3Yzyz9nRoJwxtyzwxW1X5jmjI
        qYjVqfbcDOQ2G0SbOBvS4TZcn8XC1OieR6AfhLDuwFPtREuMWk+mP0Q++P/9WimijUU6cTLQWMNlt
        27CaKQKjdv+DIEv+3SBIQvq4dL2RhVoW20+2YmzNeAo7D7HmMMpXsGdsaFmngES4fNGG9wxTxJLVQ
        0ajtsp/g==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoiw-00AO5j-FW; Wed, 12 May 2021 13:16:27 +0000
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
Subject: [PATCH 14/15] nvme-multipath: set QUEUE_FLAG_NOWAIT
Date:   Wed, 12 May 2021 15:15:44 +0200
Message-Id: <20210512131545.495160-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The nvme multipathing code just dispatches bios to one of the blk-mq
based paths and never blocks on its own, so set QUEUE_FLAG_NOWAIT
to support REQ_NOWAIT bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74455960337b..516fe977606d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -445,6 +445,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (!q)
 		goto out;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
+
 	/* set to a default value for 512 until disk is validated */
 	blk_queue_logical_block_size(q, 512);
 	blk_set_stacking_limits(&q->limits);
-- 
2.30.2

