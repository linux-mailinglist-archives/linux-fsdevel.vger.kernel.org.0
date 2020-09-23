Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B6327575E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 13:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIWLpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 07:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIWLpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:45:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02FFC0613CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 04:45:00 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so3029415pjr.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPkmLEjjOLqKd/lOoAyA8z7n9dUCjwGzd+W0L3DZgSM=;
        b=jUElUNR/aCuC47FTFhG+ItffqFmwJg58kuZUnBmtNmUSCv3QmjsuHGiNubphfVCWwo
         f5WVv+EXIx5PHxtWQ5Cqy4gRLqc8pAx6KV4ryb3N5QIky0xU8+dpfa9TZXTpzsopQtNH
         NojmKG9IHrIQbClrFWFgmUAb2cJg5x3l3EfYOGaHLnQ0fYSGZ3kF5EaCe59e0l7SUBY9
         O80XINHl/CvqKhEnwJ4SqQp/hX2tuJMg5gW3bto/N+744BSwhaZg9fWIPZtEKPydO3D0
         N9EXzRXiEVHTEF2BfD5A7SJjfZn9I6fJt0E60wHquNb0j/Uj5imwTOzJcOu1FCUADHe1
         qsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPkmLEjjOLqKd/lOoAyA8z7n9dUCjwGzd+W0L3DZgSM=;
        b=B+jZjpmCDJdRQlqKaSRup7WjNOLSiZybFoHDlduba89qPlPSyUziIypfhJT70gSNdr
         pSjGX3ihNzbuJIsc9fvMI7A7IkePtCfxTBV8QHEq1PD6i7Q34klgVVnIbGiDYwTAtMBR
         z5LwxxzoPaFn0wQ+qBhpDSdze7002NFnCreFwbX32n2tWm3WaS1RdbYaZMAOh2l2cEzx
         3oDmcF6F6JLE4wVYXqx42KGAj0fG9gSwgWlTW41LMV9Lu45A4O3jHPZjA6AU2dY8bqdb
         kMHresZT33nXSGMpxtuhilDSh6xki5q3v73Kvy+M8eHxMbchAiworyDNIvQezgmZ29a/
         Jy/w==
X-Gm-Message-State: AOAM532vRm4Lhy/5y3BnxHbbDGzNWHBMXqML6nZvKLKLCcsmWpH544+l
        uKlq/L+yV18W4wY11GaxLClM+w==
X-Google-Smtp-Source: ABdhPJynCqLc4R0uR3z+mm+2RmWHC4eyIwG+zcF5oGEc0p73c69eYffchw07KnbDQyeAvZgLntwxfQ==
X-Received: by 2002:a17:90b:3c1:: with SMTP id go1mr7987568pjb.192.1600861500197;
        Wed, 23 Sep 2020 04:45:00 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm17632155pfl.184.2020.09.23.04.44.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:44:59 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH v2 5/5] io_uring: Fix double list add in io_queue_async_work()
Date:   Wed, 23 Sep 2020 19:44:19 +0800
Message-Id: <20200923114419.71218-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200923114419.71218-1-songmuchun@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we queue work in io_poll_wake(), it will leads to list double
add. So we should add the list when the callback func is the
io_sq_wq_submit_work.

The following oops was seen:

    list_add double add: new=ffff9ca6a8f1b0e0, prev=ffff9ca62001cee8,
    next=ffff9ca6a8f1b0e0.
    ------------[ cut here ]------------
    kernel BUG at lib/list_debug.c:31!
    Call Trace:
     <IRQ>
     io_poll_wake+0xf3/0x230
     __wake_up_common+0x91/0x170
     __wake_up_common_lock+0x7a/0xc0
     io_commit_cqring+0xea/0x280
     ? blkcg_iolatency_done_bio+0x2b/0x610
     io_cqring_add_event+0x3e/0x60
     io_complete_rw+0x58/0x80
     dio_complete+0x106/0x250
     blk_update_request+0xa0/0x3b0
     blk_mq_end_request+0x1a/0x110
     blk_mq_complete_request+0xd0/0xe0
     nvme_irq+0x129/0x270 [nvme]
     __handle_irq_event_percpu+0x7b/0x190
     handle_irq_event_percpu+0x30/0x80
     handle_irq_event+0x3c/0x60
     handle_edge_irq+0x91/0x1e0
     do_IRQ+0x4d/0xd0
     common_interrupt+0xf/0xf

Fixes: 1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
Reported-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/io_uring.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c65f78f395655..a7cfe976480d8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -513,12 +513,14 @@ static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 		}
 	}
 
-	req->files = current->files;
+	if (req->work.func == io_sq_wq_submit_work) {
+		req->files = current->files;
 
-	spin_lock_irqsave(&ctx->task_lock, flags);
-	list_add(&req->task_list, &ctx->task_list);
-	req->work_task = NULL;
-	spin_unlock_irqrestore(&ctx->task_lock, flags);
+		spin_lock_irqsave(&ctx->task_lock, flags);
+		list_add(&req->task_list, &ctx->task_list);
+		req->work_task = NULL;
+		spin_unlock_irqrestore(&ctx->task_lock, flags);
+	}
 
 	queue_work(ctx->sqo_wq[rw], &req->work);
 }
@@ -667,6 +669,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		state->cur_req++;
 	}
 
+	INIT_LIST_HEAD(&req->task_list);
 	req->file = NULL;
 	req->ctx = ctx;
 	req->flags = 0;
-- 
2.11.0

