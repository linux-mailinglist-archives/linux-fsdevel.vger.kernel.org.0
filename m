Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398E32856F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 05:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgJGDQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 23:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgJGDQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:16:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822DDC0613D2
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2020 20:16:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so336383pjb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2020 20:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbmPcsuMBq1Wr1VTHGw09I3ccTmLwf6tSkcDe8WJ9wg=;
        b=C3NVdaHyZWeFvUkhm10MsFRJ3eFD+WjxMF8k1dvn5K3aXofFxhf/cOOXIGeWPnxC+Z
         0VTFbUdBHV+nPLJmP6Xjl8TbB2OlRniv5BsgZMOvMGA5zKgCK1QPET8ZzJ/r2A8X4upF
         lyrOaWAk9sGiW40GQh2cIQEjASoSkRVE4Wi7JJu4pbyGPtgAGWNHfOXt2XRKkbcXNXPc
         uZ3wJcrYv2AggF1nIKcHzozQze6WnycGRsu0xaUeJL5xyYNuWJtPIGgu7Hp+gTvsaxNF
         ZqWxfCz7vWF6w4JZyGJesqNW+BpOxWBVLNC9hsvqDlEBe5VpN6Mvv8hjjAG14XprW5LX
         ltng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbmPcsuMBq1Wr1VTHGw09I3ccTmLwf6tSkcDe8WJ9wg=;
        b=Z9Lp0ME22dcjj8qkX2wcmIj8Boiv2K81lquC3PS48DBs7IvwOtdByBybROYY57zNJ2
         K+ZP0Fz03vdXqJuevTnZzqD+k6ycI1myeKBju7PVrkxNrfkV2n4vOwJUbJH17iO39c37
         2/FP/YErlZYsRK0Ql37+nsuuVp9qCtmCqkFmj1EaKHvXYMQV4D0DLFAxmhRyi0D1NmzI
         p/SqHgyvs7x7DZ2AwXybblMbD4QoXu0k0/25/05sGboiFj4V1SDsWtFJodqmVirubCC9
         JY9ngMAfiNvorUXHROKQFINnZbi4y5PIs0AlENKXTvWgqIWnYEY7L1NAJbmXnZgTb4aX
         cQEQ==
X-Gm-Message-State: AOAM5321Vs5JEuMd9ru0mB8ZcLhls26R07c2gMqeqR+brF6YdastTw9+
        hnMoAIi4E0uW88e5m5JaLi0ChS22FPXB33eq
X-Google-Smtp-Source: ABdhPJwC7MbrbAGH7sxJ4vVu1crzXAAdPT1QPTDrOJm6sPe6ZzYQ1cOXyZKNHi07lCohpnxSjWYwDA==
X-Received: by 2002:a17:90a:1b2f:: with SMTP id q44mr1006125pjq.220.1602040617045;
        Tue, 06 Oct 2020 20:16:57 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id e1sm729094pfd.198.2020.10.06.20.16.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 20:16:56 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com
Subject: [PATCH v3 1/4] io_uring: Fix resource leaking when kill the process
Date:   Wed,  7 Oct 2020 11:16:32 +0800
Message-Id: <20201007031635.65295-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201007031635.65295-1-songmuchun@bytedance.com>
References: <20201007031635.65295-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yinyin Zhu <zhuyinyin@bytedance.com>

The commit

  1c4404efcf2c0> ("<io_uring: make sure async workqueue is canceled on exit>")

doesn't solve the resource leak problem totally! When kworker is doing a
io task for the io_uring, The process which submitted the io task has
received a SIGKILL signal from the user. Then the io_cancel_async_work
function could have sent a SIGINT signal to the kworker, but the judging
condition is wrong. So it doesn't send a SIGINT signal to the kworker,
then caused the resource leaking problem.

Why the juding condition is wrong? The process is a multi-threaded process,
we call the thread of the process which has submitted the io task Thread1.
So the req->task is the current macro of the Thread1. when all the threads
of the process have done exit procedure, the last thread will call the
io_cancel_async_work, but the last thread may not the Thread1, so the task
is not equal and doesn't send the SIGINT signal. To fix this bug, we alter
the task attribute of the req with struct files_struct. And check the files
instead.

Fixes: 1c4404efcf2c0 ("io_uring: make sure async workqueue is canceled on exit")
Signed-off-by: Yinyin Zhu <zhuyinyin@bytedance.com>
---
 fs/io_uring.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 454cef93a39e8..2f46def7f5832 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -339,7 +339,7 @@ struct io_kiocb {
 	u64			user_data;
 	u32			result;
 	u32			sequence;
-	struct task_struct	*task;
+	struct files_struct	*files;
 
 	struct fs_struct	*fs;
 
@@ -513,7 +513,7 @@ static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 		}
 	}
 
-	req->task = current;
+	req->files = current->files;
 
 	spin_lock_irqsave(&ctx->task_lock, flags);
 	list_add(&req->task_list, &ctx->task_list);
@@ -2387,6 +2387,8 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 	if (ret) {
 		struct io_ring_ctx *ctx = req->ctx;
 
+		req->files = current->files;
+
 		spin_lock_irq(&ctx->task_lock);
 		list_add(&req->task_list, &ctx->task_list);
 		req->work_task = NULL;
@@ -3717,7 +3719,7 @@ static int io_uring_fasync(int fd, struct file *file, int on)
 }
 
 static void io_cancel_async_work(struct io_ring_ctx *ctx,
-				 struct task_struct *task)
+				 struct files_struct *files)
 {
 	if (list_empty(&ctx->task_list))
 		return;
@@ -3729,7 +3731,7 @@ static void io_cancel_async_work(struct io_ring_ctx *ctx,
 		req = list_first_entry(&ctx->task_list, struct io_kiocb, task_list);
 		list_del_init(&req->task_list);
 		req->flags |= REQ_F_CANCEL;
-		if (req->work_task && (!task || req->task == task))
+		if (req->work_task && (!files || req->files == files))
 			send_sig(SIGINT, req->work_task, 1);
 	}
 	spin_unlock_irq(&ctx->task_lock);
@@ -3754,7 +3756,7 @@ static int io_uring_flush(struct file *file, void *data)
 	struct io_ring_ctx *ctx = file->private_data;
 
 	if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
-		io_cancel_async_work(ctx, current);
+		io_cancel_async_work(ctx, data);
 
 	return 0;
 }
-- 
2.11.0

