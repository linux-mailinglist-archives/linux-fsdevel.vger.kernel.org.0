Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAE411EA79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 19:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfLMSgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 13:36:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33984 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbfLMSgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:36:48 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so447549iof.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 10:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMV39iK9uM/xl0XL6oXx1BdhxqURn0hlm/bx4cb3B28=;
        b=U6hFud9LgIU0+q3KKboeWtWm9HEOz07lsT+C+QF8YLI59KPZWgC6RoSZ7FWwiMk91+
         +lJCnqjjtMLj0fjfWyw9Fz63zfi66NkRLNKh7/NkP3eqtlJ2ql3JtQzdpwaIAyLKxINW
         KGZ+9cgcMruPHrZiLIfbNfHjOCCFsnV2QzewAHY2QuJYHBwUCOgsE4WDUE30pYdM2A1q
         kk8ElIMlzW3nzRqyJICq+Q1c2gznGk+pEm2X6zZxfaDhZa67elVXazD0saqFpqPzdZRp
         ADRg1Yg67bvB1lo+6XshMCIChXzp7NiF2El26wcLi4sEvfIzJ1I+ie5yvGQjW+LyzrP2
         STbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMV39iK9uM/xl0XL6oXx1BdhxqURn0hlm/bx4cb3B28=;
        b=cS6KTUjzetZPY/5/iqteWNVzplV8d7JWSdk4AEAFVQeTz+hRBzJMEQnxOgyWvke2XL
         959sYVGY1fH8TbFH0M7YwDafEShuCdFjZXKFek2nL7QNAjxQ0u/yxVV7Sa4Sa7AjwvzV
         CMouyvHeHZ/yKD1pdRlfhy6+uoMiU9RZf1SaiFbcI/mdcLFih1m5tWo7KzI9Du/1zwhc
         eBLcPE79I1xclFwgE4o+/KzcUrLk4Wdt5V4dypp6y+9eIudus6D/oUY/jga0vrzZxxGv
         r8A9EOB2tUBVsvHzQebjaqAvBtNlDlmAJGE2tNaGrhehtd043RC0A0qlq2rPqMYT/LID
         59Ig==
X-Gm-Message-State: APjAAAU0suJlV/0EJFiYyE28iMXwOGbMSQK//t4fuk0yIaoN9jKrSGMz
        wKUq1zYGUnLZMsIL0ZkZmS4fDQ==
X-Google-Smtp-Source: APXvYqwjJM7cluS/2E2/CXXOBr2MqnnsAmcMCr1X9tjS6izw94ue7ILjOaOKFwGoP7TbgbnSRMtBhw==
X-Received: by 2002:a02:ba91:: with SMTP id g17mr787847jao.106.1576262207416;
        Fri, 13 Dec 2019 10:36:47 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w24sm2932031ilk.4.2019.12.13.10.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 10:36:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/10] io_uring: use u64_to_user_ptr() consistently
Date:   Fri, 13 Dec 2019 11:36:31 -0700
Message-Id: <20191213183632.19441-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213183632.19441-1-axboe@kernel.dk>
References: <20191213183632.19441-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We use it in some spots, but not consistently. Convert the rest over,
makes it easier to read as well.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 927f28112f0e..6f169b5a6494 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2211,7 +2211,7 @@ static int io_sendmsg_prep(struct io_kiocb *req, struct io_async_ctx *io)
 	unsigned flags;
 
 	flags = READ_ONCE(sqe->msg_flags);
-	msg = (struct user_msghdr __user *)(unsigned long) READ_ONCE(sqe->addr);
+	msg = u64_to_user_ptr(READ_ONCE(sqe->addr));
 	io->msg.iov = io->msg.fast_iov;
 	return sendmsg_copy_msghdr(&io->msg.msg, msg, flags, &io->msg.iov);
 #else
@@ -2290,7 +2290,7 @@ static int io_recvmsg_prep(struct io_kiocb *req, struct io_async_ctx *io)
 	unsigned flags;
 
 	flags = READ_ONCE(sqe->msg_flags);
-	msg = (struct user_msghdr __user *)(unsigned long) READ_ONCE(sqe->addr);
+	msg = u64_to_user_ptr(READ_ONCE(sqe->addr));
 	io->msg.iov = io->msg.fast_iov;
 	return recvmsg_copy_msghdr(&io->msg.msg, msg, flags, &io->msg.uaddr,
 					&io->msg.iov);
@@ -2324,8 +2324,7 @@ static int io_recvmsg(struct io_kiocb *req, struct io_kiocb **nxt,
 		else if (force_nonblock)
 			flags |= MSG_DONTWAIT;
 
-		msg = (struct user_msghdr __user *) (unsigned long)
-			READ_ONCE(sqe->addr);
+		msg = u64_to_user_ptr(READ_ONCE(sqe->addr));
 		if (req->io) {
 			kmsg = &req->io->msg.msg;
 			kmsg->msg_name = &addr;
@@ -2380,8 +2379,8 @@ static int io_accept(struct io_kiocb *req, struct io_kiocb **nxt,
 	if (sqe->ioprio || sqe->len || sqe->buf_index)
 		return -EINVAL;
 
-	addr = (struct sockaddr __user *) (unsigned long) READ_ONCE(sqe->addr);
-	addr_len = (int __user *) (unsigned long) READ_ONCE(sqe->addr2);
+	addr = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	addr_len = u64_to_user_ptr(READ_ONCE(sqe->addr2));
 	flags = READ_ONCE(sqe->accept_flags);
 	file_flags = force_nonblock ? O_NONBLOCK : 0;
 
@@ -2409,7 +2408,7 @@ static int io_connect_prep(struct io_kiocb *req, struct io_async_ctx *io)
 	struct sockaddr __user *addr;
 	int addr_len;
 
-	addr = (struct sockaddr __user *) (unsigned long) READ_ONCE(sqe->addr);
+	addr = u64_to_user_ptr(READ_ONCE(sqe->addr));
 	addr_len = READ_ONCE(sqe->addr2);
 	return move_addr_to_kernel(addr, addr_len, &io->connect.address);
 #else
@@ -4654,7 +4653,7 @@ static int io_copy_iov(struct io_ring_ctx *ctx, struct iovec *dst,
 		if (copy_from_user(&ciov, &ciovs[index], sizeof(ciov)))
 			return -EFAULT;
 
-		dst->iov_base = (void __user *) (unsigned long) ciov.iov_base;
+		dst->iov_base = u64_to_user_ptr((u64)ciov.iov_base);
 		dst->iov_len = ciov.iov_len;
 		return 0;
 	}
-- 
2.24.1

