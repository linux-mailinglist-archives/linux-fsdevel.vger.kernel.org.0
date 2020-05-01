Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240EE1C1C52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 19:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgEARyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 13:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729291AbgEARyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 13:54:04 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3EBC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 10:54:03 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q10so5167642ile.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dNu8cTkVAel6kkIGd2Z1GoaI4LYxnwwQdrPVYtjvHuw=;
        b=pn/yiNkH2BolGsTY90r0F9u4gIdfHJl1zOjp55qnb3xiTh9PzYpVb2A1N8O9DP1Svv
         w2NTNPf3TsfRpH9JftZ8IWVEkjOEC7RlENqSXU19puWMiK7krEinB/et2+ZMqzT/gFKS
         DovjjVYTXGh1Wt4C+aNh80QnF58iHc9T1ujPPlCI+PcIWU3witBQMS3lVFb8S0tD3o8H
         /OoekF/TkEbA7KQBvYXZmrGvqt9xsaRY9kWY2wL110pCnIlQI2J50s7dSq6n2uWS/gi6
         o7CAcrG3VbW55MnpPp/1EclkTQC+T4OJ8m0Kg3Rl0gPDFlaga53kpX4+hK2aG49p9DYY
         qVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dNu8cTkVAel6kkIGd2Z1GoaI4LYxnwwQdrPVYtjvHuw=;
        b=cv6Wl2Kp3t7JSlZOp1KBZGel34oMjWDCAq7xwxttUgUQUwOfrhsC/rPX5xhA7fmOZu
         IkUs8ZP19VNmLXlrktC/neY0ovEhP/U4bMg1s57CAGOcu84zk95322rLQQ/CgXwIhYz+
         jqfOxEeYYPlxinyP1J4e/yOSvqMqS2Sq1G1n3eJjalhFlRGUcQZgLSwaKsc5XeAmbjGu
         N0KPYLkfpoBeoKFdGcwhZXmnTJZYHTlOBIQnnvO9ljyjUcUeETGe1ZDsQJzRSAAfjCxm
         vupVSt9WLhGEZ2F8yKXg4Db2T5lMvKC+Fcy3vX1sBIzXUSSq8R3Dv+nMod8VIL4RNhIV
         Obkw==
X-Gm-Message-State: AGi0PubA55IPeXLiLG8FyQoldhqJnEqKP90vY5SrMwlD3riI/pxCHmUG
        K33gPX2dZKRSqQ2jnMmTnOmbKw==
X-Google-Smtp-Source: APiQypLC47NdRLDraisAQcHfyWfCaDlj787RuTHv7zD4S6HnvPYtPXq2e7lDVuNbH+p/xQT2nAZGYA==
X-Received: by 2002:a92:b6c4:: with SMTP id m65mr4851455ill.232.1588355643108;
        Fri, 01 May 2020 10:54:03 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u4sm1136668iop.1.2020.05.01.10.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:54:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3b] eventfd: convert to f_op->read_iter()
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <97a28bdb-284a-c215-c04d-288bcef66376@kernel.dk>
Date:   Fri, 1 May 2020 11:54:01 -0600
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

Actually send out the right patch...

Since v2:

- Cleanup eventfd_read() as per Al's suggestions

Since v1:

- Add FMODE_NOWAIT to the eventfd file

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 78e41c7c3d05..c9fa1e9cf5e3 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -216,32 +216,32 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_remove_wait_queue);
 
-static ssize_t eventfd_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
+static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct eventfd_ctx *ctx = file->private_data;
-	ssize_t res;
 	__u64 ucnt = 0;
 	DECLARE_WAITQUEUE(wait, current);
 
-	if (count < sizeof(ucnt))
+	if (iov_iter_count(to) < sizeof(ucnt))
 		return -EINVAL;
-
 	spin_lock_irq(&ctx->wqh.lock);
-	res = -EAGAIN;
-	if (ctx->count > 0)
-		res = sizeof(ucnt);
-	else if (!(file->f_flags & O_NONBLOCK)) {
+	if (!ctx->count) {
+		if ((file->f_flags & O_NONBLOCK) ||
+		    (iocb->ki_flags & IOCB_NOWAIT)) {
+			spin_unlock_irq(&ctx->wqh.lock);
+			return -EAGAIN;
+		}
 		__add_wait_queue(&ctx->wqh, &wait);
 		for (;;) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (ctx->count > 0) {
-				res = sizeof(ucnt);
+			if (ctx->count)
 				break;
-			}
 			if (signal_pending(current)) {
-				res = -ERESTARTSYS;
-				break;
+				__remove_wait_queue(&ctx->wqh, &wait);
+				__set_current_state(TASK_RUNNING);
+				spin_unlock_irq(&ctx->wqh.lock);
+				return -ERESTARTSYS;
 			}
 			spin_unlock_irq(&ctx->wqh.lock);
 			schedule();
@@ -250,17 +250,14 @@ static ssize_t eventfd_read(struct file *file, char __user *buf, size_t count,
 		__remove_wait_queue(&ctx->wqh, &wait);
 		__set_current_state(TASK_RUNNING);
 	}
-	if (likely(res > 0)) {
-		eventfd_ctx_do_read(ctx, &ucnt);
-		if (waitqueue_active(&ctx->wqh))
-			wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
-	}
+	eventfd_ctx_do_read(ctx, &ucnt);
+	if (waitqueue_active(&ctx->wqh))
+		wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
 	spin_unlock_irq(&ctx->wqh.lock);
-
-	if (res > 0 && put_user(ucnt, (__u64 __user *)buf))
+	if (unlikely(copy_to_iter(&ucnt, sizeof(ucnt), to) != sizeof(ucnt)))
 		return -EFAULT;
 
-	return res;
+	return sizeof(ucnt);
 }
 
 static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t count,
@@ -329,7 +326,7 @@ static const struct file_operations eventfd_fops = {
 #endif
 	.release	= eventfd_release,
 	.poll		= eventfd_poll,
-	.read		= eventfd_read,
+	.read_iter	= eventfd_read,
 	.write		= eventfd_write,
 	.llseek		= noop_llseek,
 };
@@ -427,8 +424,17 @@ static int do_eventfd(unsigned int count, int flags)
 
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

