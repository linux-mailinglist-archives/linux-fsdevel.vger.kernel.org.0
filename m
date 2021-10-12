Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1290942A308
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 13:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhJLLV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 07:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhJLLVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:21:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50BCC061570;
        Tue, 12 Oct 2021 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=I7TU5196DMrnq1/86jEdT7u0d1r5yBEHlH+oSOn2ra0=; b=VVdPFgVZrGm99g203OQBcrg2Zb
        fT+ItJObCg/eEwF3X0eXwIMR7bMQZhvYTdVq8kI/Tmuj5BrWNyrciyBOrGiH9PxeovcKC03U4RbMC
        kFcOWLo2v/zdMHJyhdEzhLlTeCtl8LQTLK92yyOFXM8SFphSNVaJ+pK0kESW5gh8ERCCaddqiSUpD
        +Ocvee89HbW2d/mwYK1cdYIaLkvsGKZy/Z78GXwgM3Ze3/5Qr27FII8wrfZ/NZF4IPHzsciNoFr8U
        lFNO6ZzAWHGMQ6tCW3weVRRbxx2fBwxr970iAILsUg/uc8bsPq8OOQfRBREgRo7ZakOKGdp7dX7Zz
        5DCFPaMQ==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFlv-006RYX-4t; Tue, 12 Oct 2021 11:17:03 +0000
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
Subject: [PATCH 04/16] io_uring: fix a layering violation in io_iopoll_req_issued
Date:   Tue, 12 Oct 2021 13:12:14 +0200
Message-Id: <20211012111226.760968-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syscall-level code can't just poke into the details of the poll cookie,
which is private information of the block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/io_uring.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 82f867983bb32..5b625f97ee225 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2743,19 +2743,12 @@ static void io_iopoll_req_issued(struct io_kiocb *req)
 		ctx->poll_multi_queue = false;
 	} else if (!ctx->poll_multi_queue) {
 		struct io_kiocb *list_req;
-		unsigned int queue_num0, queue_num1;
 
 		list_req = list_first_entry(&ctx->iopoll_list, struct io_kiocb,
 						inflight_entry);
 
-		if (list_req->file != req->file) {
+		if (list_req->file != req->file)
 			ctx->poll_multi_queue = true;
-		} else {
-			queue_num0 = blk_qc_t_to_queue_num(list_req->rw.kiocb.ki_cookie);
-			queue_num1 = blk_qc_t_to_queue_num(req->rw.kiocb.ki_cookie);
-			if (queue_num0 != queue_num1)
-				ctx->poll_multi_queue = true;
-		}
 	}
 
 	/*
-- 
2.30.2

