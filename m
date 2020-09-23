Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8882C27574E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 13:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIWLor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 07:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgIWLoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:44:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67197C0613D1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 04:44:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so14881751pfd.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yr5ceun1c0XjkFqzZiGqBJsZB++H8ShVuyzsBejSWgA=;
        b=1E+UfLc3ed9Nzd/69B6wR8oqAK1nzlpJras5WEGa4NXD+pmf9w9quHEfuDIKdnvWK2
         /n4QHu4D1NR1buVZtglkdBJVR8vdsU1FrK0zCzWi1ayUNztSlnguwwCrSkN+/v0XSZpp
         N0Rdz6AAY6uMEhh+UZo1YFMLueR1fNBmSeuOOPjtLmyMXVwb8p89Q8OQOcgG/WYy5Vaj
         3pEPyMeLIYeNzwS3SKPngJbUsYg1xxXZPdqALipIYd1lZlPcvdUFWiSgDolC6s3V46YQ
         i9QJuFMZFM3K9IRllLtMF3eYCwi3cUestYfcVC9QsRsdgZ/ImIva9aTUlMDDKQ9qD06G
         MESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yr5ceun1c0XjkFqzZiGqBJsZB++H8ShVuyzsBejSWgA=;
        b=LAWomez9Yj/HBWZvOsYIwQmRIKUhvB5iN86MH8vC5kBrzg/H1+tr79M4fNoyiMzy5n
         S186gXHB6jdXUzygG+m7yCRAKbyzy7sLkFJopm0ULu4L5C+4VkJHRz8sDdsDIARIFMfX
         tcs1P5x8/fTk9AJZVF27lTunYIr+nOhHho6eTRGaKv5mAgXR4ezLuLF08I/1Yo1j+4gc
         5IQU5PLVz2gaaI5hLi2ojMnZ+X4T+A3aJqDAZnoGZiTjOt+iNpAOuKKi+M9EEVjRx+Ve
         jeeLzoht3QydmidvZOQzkmaBLpHJCEr/nq7xJzJRuCqOT9hPc7GhibzFxcGaNA/37k+w
         royA==
X-Gm-Message-State: AOAM533PKOHAY6d/mP8mKEI+HkXWgbezKFySgxj3y240W1jTmle+jlsE
        5Mn7oMBPNH5VEUECqyUpYRTNoA==
X-Google-Smtp-Source: ABdhPJxGbuGehtEUXo1yipomX/tpseVVA2sWoXaHx79aka+feeuEgyOCtMz/Om5S1ArsWU9TKKeEsg==
X-Received: by 2002:a63:1d5a:: with SMTP id d26mr7257874pgm.432.1600861485971;
        Wed, 23 Sep 2020 04:44:45 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm17632155pfl.184.2020.09.23.04.44.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:44:45 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com
Subject: [PATCH v2 1/5] io_uring: Fix resource leaking when kill the process
Date:   Wed, 23 Sep 2020 19:44:15 +0800
Message-Id: <20200923114419.71218-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200923114419.71218-1-songmuchun@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
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
 fs/io_uring.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 454cef93a39e8..a1350c7c50055 100644
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
@@ -3717,7 +3717,7 @@ static int io_uring_fasync(int fd, struct file *file, int on)
 }
 
 static void io_cancel_async_work(struct io_ring_ctx *ctx,
-				 struct task_struct *task)
+				 struct files_struct *files)
 {
 	if (list_empty(&ctx->task_list))
 		return;
@@ -3729,7 +3729,7 @@ static void io_cancel_async_work(struct io_ring_ctx *ctx,
 		req = list_first_entry(&ctx->task_list, struct io_kiocb, task_list);
 		list_del_init(&req->task_list);
 		req->flags |= REQ_F_CANCEL;
-		if (req->work_task && (!task || req->task == task))
+		if (req->work_task && (!files || req->files == files))
 			send_sig(SIGINT, req->work_task, 1);
 	}
 	spin_unlock_irq(&ctx->task_lock);
@@ -3754,7 +3754,7 @@ static int io_uring_flush(struct file *file, void *data)
 	struct io_ring_ctx *ctx = file->private_data;
 
 	if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
-		io_cancel_async_work(ctx, current);
+		io_cancel_async_work(ctx, data);
 
 	return 0;
 }
-- 
2.11.0

