Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6E36C953
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbhD0QYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbhD0QVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:21:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DA6C06138A;
        Tue, 27 Apr 2021 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5gR/AErYq/eqzo3k8wU7l4HemKfkKmB0mPrgeTjUPj8=; b=TnfQYupz8ShFzD+aE3bkbUKgUj
        O1ADgldt6BaXkdknIi3/l6q0Mjh3NxH4eQ7mNuqlEjHaFKSYjymzKzMC5yLq2tmPLx2a+CwjC5Grh
        zdGi2lXbdtpBeR4ygfyL/4Mi+RRY1swoAGVNFfpdywGhqAgjcOU1miEjjlkvHwPEx1Psy+MAYcyzb
        Bjr9CzEEEyMFopMYY0ntacQLAgrw0b+iVWcsXdBEY0VEdmHiOWrGnLn6m1auOn0zOPgkO1BDbl5R+
        n2Tz3gkJ0/PSYomcZMj3I4cIUkd3MUrce/XcVm0F+/gQ3Ufkrgkt79GhhmW8DpJ8ksceggdzcDr29
        Kwq31pCQ==;
Received: from [2001:4bb8:18c:28b2:c772:7205:2aa4:840d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbQQd-00Gr6T-Mj; Tue, 27 Apr 2021 16:19:16 +0000
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
Subject: [PATCH 14/15] nvme-multipath: set QUEUE_FLAG_NOWAIT
Date:   Tue, 27 Apr 2021 18:16:18 +0200
Message-Id: <20210427161619.1294399-15-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210427161619.1294399-1-hch@lst.de>
References: <20210427161619.1294399-1-hch@lst.de>
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
index 4e2c3a6787e9..1d17b2387884 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -442,6 +442,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (!q)
 		goto out;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
+
 	/* set to a default value for 512 until disk is validated */
 	blk_queue_logical_block_size(q, 512);
 	blk_set_stacking_limits(&q->limits);
-- 
2.30.1

