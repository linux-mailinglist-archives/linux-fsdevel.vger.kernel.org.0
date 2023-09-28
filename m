Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434AC7B134E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 08:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjI1Gqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 02:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjI1Gqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:46:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B099C;
        Wed, 27 Sep 2023 23:46:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4054f790190so115713385e9.2;
        Wed, 27 Sep 2023 23:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695883603; x=1696488403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1K9DQQKeU3Trmc67Wg1LO259/muomJxDdO8xPLflkK0=;
        b=kyCmhG4Q7eJnGzlzsOd9bAeyW6qRwT0xHj4uvFLpJaAqkNn+6IurNr/Z6IOvAIWPAS
         ewFAA5bQmAcqVBsuHtqmL7aghlQw29y4b7wnRTN6LLIJawx4obvXpYgxoH630z6iAsOi
         bHJf9QguRmF5coVKPc1rJ7TRcV+jCVhOnERxb/R9VlIA1Sl6PrQaWyvD1JJZ+i7Ad/4e
         0Reyac+oNOmcv9TxcHBqFJ1KAC09NKLmJOiOE6Nmz0tSn2JxlHaTLNQqoskC3eCjZA1s
         Ol8FD/p/ThdnuKm4/WsQxmd+U39fJVEP2pyt1WmCJfD8QiKMiY0YFbYKkFD8cER4J7R3
         qKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695883603; x=1696488403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1K9DQQKeU3Trmc67Wg1LO259/muomJxDdO8xPLflkK0=;
        b=H1tmU94Vcn6lB+2lxmOLqzdti96bpLeCxlyAEAhYTgRUeaqo5hB7nyIta4x1h3//tG
         z0IPY9JPMiXbSW1+lBgcs5Ay71+HFjin3CzTMBB/e7ZsxAOPNWluF2FkSth8s8LqNIbH
         K4PXe83k/XrRV/0utTX4PhipV3vlDAlPqfyxd+fgJxOamkJWXSsYfWsUWpJlNpkMa4Qh
         t3OEY+08YS7zHfqBoz36hHO/DZ4rxdr3VAj9TyrMXLQrZotc1LmT4dpIgmEM8IaiZB+5
         IsdyjFnrVN9QrDrbaewLpzwdV64UIvEl8/mdZFwIqrdSyVcogxyyQ8Y9Y80LSTdxKLuJ
         f/rw==
X-Gm-Message-State: AOJu0YztshX37ajj8sD8YydJ5NSnU3UTvI5x6TVBJPjU9LCoDlNH5EV5
        Jygzo1vUFGc+jeXH+WrzY7E=
X-Google-Smtp-Source: AGHT+IEDHzsTa1Z5mp9i0EYxKVr5rxXeybKkJSZ2w5wRZeMDVLUhTUA6LWAR36hJe9/aV2oph4R1EA==
X-Received: by 2002:a7b:ce0a:0:b0:406:4573:81d2 with SMTP id m10-20020a7bce0a000000b00406457381d2mr362206wmc.39.1695883603117;
        Wed, 27 Sep 2023 23:46:43 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c248400b0040640073d25sm4397370wms.16.2023.09.27.23.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:46:42 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: punt write aio completion to workqueue
Date:   Thu, 28 Sep 2023 09:46:36 +0300
Message-Id: <20230928064636.487317-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want to protect concurrent updates of ovl inode size and mtime
(i.e. ovl_copyattr()) from aio completion context.

Punt write aio completion to a workqueue so that we can protect
ovl_copyattr() with a spinlock.

Export sb_init_dio_done_wq(), so that overlayfs can use its own
dio workqueue to punt aio completions.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/r/8620dfd3-372d-4ae0-aa3f-2fe97dda1bca@kernel.dk/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Jens,

I did not want to add an overlayfs specific workqueue for those
completions, because, as I'd mentioned before, I intend to move this
stacked file io infrastructure to common vfs code.

I figured it's fine for overlayfs (or any stacked filesystem) to use its
own s_dio_done_wq for its own private needs.

Please help me reassure that I got this right.

Thanks,
Amir.


 fs/overlayfs/file.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/super.c          |  1 +
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 173cc55e47fb..b4fefd96881f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -15,10 +15,15 @@
 #include <linux/fs.h>
 #include "overlayfs.h"
 
+#include "../internal.h"	/* for sb_init_dio_done_wq */
+
 struct ovl_aio_req {
 	struct kiocb iocb;
 	refcount_t ref;
 	struct kiocb *orig_iocb;
+	/* used for aio completion */
+	struct work_struct work;
+	long res;
 };
 
 static struct kmem_cache *ovl_aio_request_cachep;
@@ -302,6 +307,37 @@ static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
 	orig_iocb->ki_complete(orig_iocb, res);
 }
 
+static void ovl_aio_complete_work(struct work_struct *work)
+{
+	struct ovl_aio_req *aio_req = container_of(work,
+						   struct ovl_aio_req, work);
+
+	ovl_aio_rw_complete(&aio_req->iocb, aio_req->res);
+}
+
+static void ovl_aio_queue_completion(struct kiocb *iocb, long res)
+{
+	struct ovl_aio_req *aio_req = container_of(iocb,
+						   struct ovl_aio_req, iocb);
+	struct kiocb *orig_iocb = aio_req->orig_iocb;
+
+	/*
+	 * Punt to a work queue to serialize updates of mtime/size.
+	 */
+	aio_req->res = res;
+	INIT_WORK(&aio_req->work, ovl_aio_complete_work);
+	queue_work(file_inode(orig_iocb->ki_filp)->i_sb->s_dio_done_wq,
+		   &aio_req->work);
+}
+
+static int ovl_init_aio_done_wq(struct super_block *sb)
+{
+	if (sb->s_dio_done_wq)
+		return 0;
+
+	return sb_init_dio_done_wq(sb);
+}
+
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -402,6 +438,10 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	} else {
 		struct ovl_aio_req *aio_req;
 
+		ret = ovl_init_aio_done_wq(inode->i_sb);
+		if (ret)
+			goto out;
+
 		ret = -ENOMEM;
 		aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
 		if (!aio_req)
@@ -411,7 +451,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		aio_req->orig_iocb = iocb;
 		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
 		aio_req->iocb.ki_flags = ifl;
-		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
+		aio_req->iocb.ki_complete = ovl_aio_queue_completion;
 		refcount_set(&aio_req->ref, 2);
 		kiocb_start_write(&aio_req->iocb);
 		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
diff --git a/fs/super.c b/fs/super.c
index 2d762ce67f6e..6ab6624989f2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2139,3 +2139,4 @@ int sb_init_dio_done_wq(struct super_block *sb)
 		destroy_workqueue(wq);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(sb_init_dio_done_wq);
-- 
2.34.1

