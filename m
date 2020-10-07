Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099902856F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgJGDRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 23:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgJGDRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:17:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D787FC061755
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2020 20:17:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s19so292292plp.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2020 20:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GeVbov0xNPxL4pvkkmxnDNiMOHPiM/FJbyQtEEMpPQc=;
        b=fwSdbZZlK5Q7h7g2nyZsoFvVzwIWW97I/PVzJbBd1xKj5L7sttS7jiyZ1oDvU7CUjm
         J3OK1fVORdZq5/vFvFMrPi8CJilG1lsTE1AHbpLDjp5Kr3iNKNuG3XX4vrsbmfM1A0is
         4WVaiR91B6d3pbYyY5End0VaHMSfEHaU9DnjoCBOmIWo7+ZtIhfiHwm9o2SiTSxfamMF
         qUNI7nsNxAMfs8cuRunI2BSh7kbkT1dd75fgD9f78gp/4XqgEPn50nhrIbOcrDvn0imO
         jL4Tw2320znVzyDvKnSBEN+W6CWZdfXIPvOIIDrtpzD66fRCYM4hUnMvK06RAcr9fk74
         o9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GeVbov0xNPxL4pvkkmxnDNiMOHPiM/FJbyQtEEMpPQc=;
        b=jvxcaNGurUQsYbbD0UM5IGr/JskGONnBrQB8ZN81RVOER5e3gPXCWfEr74/4ZxYYyv
         avsUPkQT2H2Gj+pobGu6BuoPWRb0gXnhVo7x7ANuK9AkdMVAdbi12U8avMBaZEMqyI8v
         oaYaFtf4+q0KSO/l3M7KWpY/JYmLpgZQuyxMNFdwtzl4d7+bV4ayOamL0PbJaa+r72r+
         rrhxe62utm8kc4KB4UF/+MJ3iY6YAcbF8Jz2x0z1zu8gm3m2Eb1QlM4+3O6MZ8R/N2Tm
         BhsLb/klzHTWSm7+faUC5W/WdG4OFQbbSrmR7xBmdW9kcF9bCuN/vkQSGtFled8fYyr/
         CYpQ==
X-Gm-Message-State: AOAM532MOrTTBdmt9CWOe5HlFEBldVyLE4Ig8qpDkFPiAOMeWfv5l8RJ
        pWs9fAwTaQbrybRV1EL8w/YHew==
X-Google-Smtp-Source: ABdhPJyCF+csF7t8Drpu+3DqDzO7ygzPcNqG8s9mzckzPIum0U43WiRp8bWyW4FIx9nsww5R5jvIjQ==
X-Received: by 2002:a17:902:8d96:b029:d2:8cdd:db9d with SMTP id v22-20020a1709028d96b02900d28cdddb9dmr1138671plo.79.1602040625464;
        Tue, 06 Oct 2020 20:17:05 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id e1sm729094pfd.198.2020.10.06.20.17.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 20:17:04 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 3/4] io_uring: Fix remove irrelevant req from the task_list
Date:   Wed,  7 Oct 2020 11:16:34 +0800
Message-Id: <20201007031635.65295-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201007031635.65295-1-songmuchun@bytedance.com>
References: <20201007031635.65295-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the process 0 has been initialized io_uring is complete, and
then fork process 1. If process 1 exits and it leads to delete
all reqs from the task_list. If we kill process 0. We will not
send SIGINT signal to the kworker. So we can not remove the req
from the task_list. The io_sq_wq_submit_work() can do that for
us.

Fixes: 1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/io_uring.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5d9583e3d0d25..c65f78f395655 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2277,13 +2277,11 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 					break;
 				cond_resched();
 			} while (1);
-end_req:
-			if (!list_empty(&req->task_list)) {
-				spin_lock_irq(&ctx->task_lock);
-				list_del_init(&req->task_list);
-				spin_unlock_irq(&ctx->task_lock);
-			}
 		}
+end_req:
+		spin_lock_irq(&ctx->task_lock);
+		list_del_init(&req->task_list);
+		spin_unlock_irq(&ctx->task_lock);
 
 		/* drop submission reference */
 		io_put_req(req);
@@ -3727,15 +3725,16 @@ static int io_uring_fasync(int fd, struct file *file, int on)
 static void io_cancel_async_work(struct io_ring_ctx *ctx,
 				 struct files_struct *files)
 {
+	struct io_kiocb *req;
+
 	if (list_empty(&ctx->task_list))
 		return;
 
 	spin_lock_irq(&ctx->task_lock);
-	while (!list_empty(&ctx->task_list)) {
-		struct io_kiocb *req;
 
-		req = list_first_entry(&ctx->task_list, struct io_kiocb, task_list);
-		list_del_init(&req->task_list);
+	list_for_each_entry(req, &ctx->task_list, task_list) {
+		if (files && req->files != files)
+			continue;
 
 		/*
 		 * The below executes an smp_mb(), which matches with the
@@ -3745,7 +3744,7 @@ static void io_cancel_async_work(struct io_ring_ctx *ctx,
 		 */
 		smp_store_mb(req->flags, req->flags | REQ_F_CANCEL); /* B */
 
-		if (req->work_task && (!files || req->files == files))
+		if (req->work_task)
 			send_sig(SIGINT, req->work_task, 1);
 	}
 	spin_unlock_irq(&ctx->task_lock);
-- 
2.11.0

