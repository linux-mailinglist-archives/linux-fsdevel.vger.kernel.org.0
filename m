Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D278E1C1C4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgEARxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 13:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729611AbgEARxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 13:53:09 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9DBC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 10:53:09 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f3so5626896ioj.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XdJA1wCaC5kLmDy04IJIo29nZqrjKJoJjzCuDdVwDTk=;
        b=z//v2qYWnW8SwmqV+dDk6BILpZx1qMVWZ0pkGVjWZSOKkdAa/7TlRo86mGJ9gDGwK+
         vbkzgLQJ3hNMr6bP8v2YLUUiKt/l3GvgwMV8qjCHD9IUiJ3HxLJ2yI+q1dySo/LleK1Z
         1OezD5QK/l6Sopbop+asqne16E1VKpBSFaCBM+iAkFsO/Whk9svAYTEogY3Bhl0NNG6g
         FuA4cauJYwcLuHkx7XK6BU7ASIdHAvKl4KE5iiUE+w7BXxqSGQfS3mLoSFhxBO6HQdis
         hNdIFoYlBd4krZ0uMSG2XsW6+iMtnU2aXYya7jHMdl2zTaP6nE2jfudyE4bo0vHKHuFe
         9GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XdJA1wCaC5kLmDy04IJIo29nZqrjKJoJjzCuDdVwDTk=;
        b=HJ6Cz6/zhdwg4RSKH6wNUvgfn4G29gtrPUJkUzEuOs7wl/YdQYCY4t9czykEXxxyh0
         J2KL30Zt8LlDVpZF7GoWGHLHyxQY89IHkQQtaYsNocRcxbaeQiUmtU4J08TtwoqDGTka
         Kd5E4maYTRWBefNPA+oLkrq0tBfsypqJeL9x+oxb1PuJhu5ECOGIBieo3zer2mYd3NsE
         k2qL/XoESTBS1Inv2cuJ/AuzK3uDvNzTY1gJ6UD4ONYWcbn+Bxs5rSrOd4cViH8ertAS
         Um4Z5HIPeUQRXqEHGZUWEQNl7sxA3YyJuCwgAXMwFLW5hjVPYuoFngZwTH7c1X6Vk2JX
         zzAg==
X-Gm-Message-State: AGi0PubGt3UJQiWDp0uiVGzIpTbs2CagYdEGfhoj2AlbHpWFbxgm42M5
        slKO/RxREPZMGRaqJX5rB/UbD7xRtnkQTA==
X-Google-Smtp-Source: APiQypKCCJ6EjlTDfVmI0HNR9sHGD+IUBltyY6FC/6vL5rBVpJipJHetgPjWqmn+enrvNZ6eV/nrmA==
X-Received: by 2002:a02:cd03:: with SMTP id g3mr4112123jaq.61.1588355588807;
        Fri, 01 May 2020 10:53:08 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z3sm1178310ior.45.2020.05.01.10.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:53:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3] eventfd: convert to f_op->read_iter()
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <4037e867-af74-6a11-a501-7e5b804beec5@kernel.dk>
Date:   Fri, 1 May 2020 11:53:07 -0600
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

Since v2:

- Cleanup eventfd_read() as per Al's suggestions

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

