Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9615D1C1DAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgEATLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729930AbgEATLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 15:11:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395C4C061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 12:11:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s18so4932796pgl.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=c5dK1AbklroYAW5CprN7zWLQ3v0LEJ5QJui3W0lSbjE=;
        b=hEYy9ALwvpi9Nj7vjZM+2BujSPtzR7pr1xzZJ2wJNrUpJf+DBpkALWi7IJBWqTRRz3
         WAnthuChCJjH3p/TbVwJcXhanIYwAWdWqXur31qbmlShzOpg5tI8+GPn6ou4uN/7ciL+
         6A+Cs2qHOD4QYfz5nxFJbSvVLoEetDLQ1pCeHREsZiOHNNpV4LmOTtDS5vWuvbe2653o
         S84nBsCeciVYi4O67ejhg4ZacLv2GXwS2RFei7TDB8clqsltDIWndq/zDDE3k/PQ23sg
         P9OramRl01XAkPPSHlXGR4kYN2ZX35KLRR3VgvjTdY3K+f6aEzWSxdZnxLIRkMQ4Xbg/
         vFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=c5dK1AbklroYAW5CprN7zWLQ3v0LEJ5QJui3W0lSbjE=;
        b=NXRBf2db44EywB1V294ODTMWkS1G7b8f7eW5pO2Awf1N8E9bQFxfZeThtgI7TIB2n9
         /XEGC5W10ycQjjyYSVjmaJC6weU6Q0eRMQVBmYEcWjAybZkiyifoRK2//0oa98afYM6Z
         XUtgYKt8fdASy/6JgyeZlak+97ZVQBHl6q7zWkBtVC4h+oCzI0b1TZS9P7wHzPUxEuC+
         dbRxZWhLyNamaRcmWaFWgri6OwxbFiGFAYmwksmbcghQocVl5fTUOnRAWipHeuN8snGp
         OC9XllEal5VK4Rn8qazHg0Gk/J4xSQfGW+Uqf3cyyg2nnX5Xq+QKoQu1FLVPr0UC26+O
         g2ow==
X-Gm-Message-State: AGi0PuYt7u3F7U6o7nd7LWVHP+V3qImgygjAaMzwryTwxCpRRzShyyC3
        BUYVpz9fLJsQBBye0RcfwGXNTw==
X-Google-Smtp-Source: APiQypIAx3VymjxsbJHLkIAf8je/YP4wuBkmjFG4kuKUKvKBJlTDGqNf340O0aYdczkAG3AgttR0Lw==
X-Received: by 2002:a62:be0c:: with SMTP id l12mr5465435pff.95.1588360270684;
        Fri, 01 May 2020 12:11:10 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id v64sm2865008pfb.20.2020.05.01.12.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 12:11:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4] eventfd: convert to f_op->read_iter()
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <6b29f015-bd7c-0601-cf94-2c077285b933@kernel.dk>
Date:   Fri, 1 May 2020 13:11:09 -0600
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

With ->read_iter(), we can support IOCB_NOWAIT. Ensure the fd setup
is done such that we set file->f_mode with FMODE_NOWAIT.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Since v3:

- Ensure we fiddle ->f_mode before doing fd_install() on the fd

Since v2:

- Cleanup eventfd_read() as per Al's suggestions

Since v1:

- Add FMODE_NOWAIT to the eventfd file

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 78e41c7c3d05..20f0fd4d56e1 100644
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
@@ -406,6 +403,7 @@ EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
 static int do_eventfd(unsigned int count, int flags)
 {
 	struct eventfd_ctx *ctx;
+	struct file *file;
 	int fd;
 
 	/* Check the EFD_* constants for consistency.  */
@@ -425,11 +423,24 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->flags = flags;
 	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
 
-	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
-			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
+	flags &= EFD_SHARED_FCNTL_FLAGS;
+	flags |= O_RDWR;
+	fd = get_unused_fd_flags(flags);
 	if (fd < 0)
-		eventfd_free_ctx(ctx);
+		goto err;
+
+	file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		fd = PTR_ERR(file);
+		goto err;
+	}
 
+	file->f_mode |= FMODE_NOWAIT;
+	fd_install(fd, file);
+	return fd;
+err:
+	eventfd_free_ctx(ctx);
 	return fd;
 }
 
-- 
Jens Axboe

