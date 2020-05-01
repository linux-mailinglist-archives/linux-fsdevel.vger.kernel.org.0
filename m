Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D512A1C1B76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 19:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgEARSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729246AbgEARSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 13:18:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE3C061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 10:18:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l25so2482464pgc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QDlWf9LzZNbk9dgJ+RBVnfsnQ3+A0mxSDEKIw0bzaco=;
        b=FpzpiJAjtrsI5WVV4SKUJKHzij1rnmdtadoDsR0qqk+CXqE/hUHWXsPL2oRuS5hZOA
         aONes5w4zEx6gmkZDZ6e+DDNyY6oF1sBt8OTtkCNHUF7lIpD793t1sJeXqTogQzRv1FF
         rQVS4UbK3usuavte361SjI3SyujPmUqmJQaBjPO2z569bDBeC1Au4je5MaiW2UZo7e0A
         c0t+3N2zecfZcjev5eK3OlU9k0rqur4pKZOp57pJMLMFZVQ2Gcq8V9DtbUU15VXWgiWb
         aAODoOXCfGrarLxotuNODA72LF/1aktUrRpZ0A499uAy6tKJ+aez5X8Cu3PlM0p5KlhW
         15gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QDlWf9LzZNbk9dgJ+RBVnfsnQ3+A0mxSDEKIw0bzaco=;
        b=KEYx8sSHRq0pNVfFwZN+M2gVlTeA0Hj/fI6Rqtja8AAGICB5zP+RvP852la3WJvj7C
         xJhOuVq0faQxl1jwxIypet0Ujmky0nB9nWbzfUhTMhzRgI7peyp90JHwoXhqmj7JR0H2
         3o8Pl3OCTT5yKDlPjjleS09BdC5DgqJLpDaj+0e+h47bUFDSa8CsXrzH+YTBFBEh+7h+
         oryXL/WEghRPv3AG1XaMalIspQ0DVrn8Zrc9rdXoiIwpkEAfN3uwWzsxRAlBJ4sJSuGA
         ttVuvz9EP1htMq7Woh95GegO6noNj5evmM4v8ZVKkcdfPlMgT90m51J0EFUf0KROb2rK
         yJEA==
X-Gm-Message-State: AGi0Pub+MXSH2oE/N/99kHi4gzVvuezCFWO0LcFoc98sYH9ytCuIGavw
        CQI5bXiGAarDlZQz/DM7omi4LduC7hvrhA==
X-Google-Smtp-Source: APiQypIbVNlKonsbj1FeJLncadYmaCauJ4vAfbpeDxwqDEqE4vTJNbAUdn7MtIgDmvTSQ6gmVXXCGQ==
X-Received: by 2002:aa7:9a87:: with SMTP id w7mr5070915pfi.47.1588353487288;
        Fri, 01 May 2020 10:18:07 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c1::158c? ([2620:10d:c090:400::5:bb5c])
        by smtp.gmail.com with ESMTPSA id i72sm2915863pfe.104.2020.05.01.10.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:18:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] eventfd: convert to f_op->read_iter()
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <c71b2091-a86e-cc81-056d-de2f1e839f50@kernel.dk>
Date:   Fri, 1 May 2020 11:18:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

eventfd is using ->read() as it's file_operations read handler, but
this prevents passing in information about whether a given IO operation
is blocking or not. We can only use the file flags for that. To support
async (-EAGAIN/poll based) retries for io_uring, we need ->read_iter()
support. Convert eventfd to using ->read_iter().

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Since v1:

- Add FMODE_NOWAIT to the eventfd file

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 78e41c7c3d05..d590c2141d39 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -216,10 +216,11 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_remove_wait_queue);
 
-static ssize_t eventfd_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
+static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *iov)
 {
+	struct file *file = iocb->ki_filp;
 	struct eventfd_ctx *ctx = file->private_data;
+	size_t count = iov_iter_count(iov);
 	ssize_t res;
 	__u64 ucnt = 0;
 	DECLARE_WAITQUEUE(wait, current);
@@ -231,7 +232,8 @@ static ssize_t eventfd_read(struct file *file, char __user *buf, size_t count,
 	res = -EAGAIN;
 	if (ctx->count > 0)
 		res = sizeof(ucnt);
-	else if (!(file->f_flags & O_NONBLOCK)) {
+	else if (!(file->f_flags & O_NONBLOCK) &&
+		 !(iocb->ki_flags & IOCB_NOWAIT)) {
 		__add_wait_queue(&ctx->wqh, &wait);
 		for (;;) {
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -257,7 +259,7 @@ static ssize_t eventfd_read(struct file *file, char __user *buf, size_t count,
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
 
-	if (res > 0 && put_user(ucnt, (__u64 __user *)buf))
+	if (res > 0 && copy_to_iter(&ucnt, res, iov) < res)
 		return -EFAULT;
 
 	return res;
@@ -329,7 +331,7 @@ static const struct file_operations eventfd_fops = {
 #endif
 	.release	= eventfd_release,
 	.poll		= eventfd_poll,
-	.read		= eventfd_read,
+	.read_iter	= eventfd_read,
 	.write		= eventfd_write,
 	.llseek		= noop_llseek,
 };
@@ -427,8 +429,17 @@ static int do_eventfd(unsigned int count, int flags)
 
 	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
 			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
-	if (fd < 0)
+	if (fd < 0) {
 		eventfd_free_ctx(ctx);
+	} else {
+		struct file *file;
+
+		file = fget(fd);
+		if (file) {
+			file->f_mode |= FMODE_NOWAIT;
+			fput(file);
+		}
+	}
 
 	return fd;
 }

-- 
Jens Axboe

