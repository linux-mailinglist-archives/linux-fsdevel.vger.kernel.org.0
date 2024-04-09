Return-Path: <linux-fsdevel+bounces-16455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F3789DF05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 17:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B711F2289F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BF13B5A0;
	Tue,  9 Apr 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DD5j8TQx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BC13AD1C
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676289; cv=none; b=ho4YMBxVt4njHG8SH3rR77XTR6FHtOVsxFhynuVD7a/5W/a8USfBKEvgDavudl/3rD/m5fJhv36zZyaOltMzkKkXhnT5GPZt9sP+Q5UDHLBgiqiFSKI+kv5YApq54P9DxI4VQHWVMTsVjHkPhMTRg3/JxeWwYuL0eumBCDf/Q64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676289; c=relaxed/simple;
	bh=SrwS5t0A/frD/26uRx+Jc9vqADKXdR1SqDkgRp7UW5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPM669aMJjg4pm/TCnBEDd4USrpjG1rOAOCxPijVMrwwEsleIiuXHvXEfhbE+0M1iegnKqVXM1l9zuRv74ygcP/zSJ2xYEisfpvOR1FJwjRvAFzBfwGb0Y8KTi9UKmNbXazM40NLuUy7PQy/I4zdY+c2sssbiQetlG9a3cZ7Ovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DD5j8TQx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a2cced7482so1576490a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712676286; x=1713281086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBpHmg++FZ+uTrxs+NJvN18MokFvXNNYYZk1ttpqZ54=;
        b=DD5j8TQxJOA1rG7A3o/nVkRWRiknoNdTZqRPmBsuQbtosqXUcSHzBKwmOKnC91xrcF
         p4BhnRRTV4c374D3xq0BM++BSgvVj+E/6LGpW4Af2+yh3Ea3XOsQvhxkzLiCi749C1pL
         VIJy45D9YqYyhmPozb0neMqflgEIWj1MgUCMWXscHE0VZtdZcx6mzQa5WJVAhKQC673P
         giiIbUZWQ1OtuKNo0jrG6IqbwVenjy7EYOJvLLRPAf3CYgZZAC5FB8ZG7msQ5nw+YECh
         UlJaZu5rVMnZPyPlD2nqZzvTJjgW13f6n13Zssu0M1Lzto7dIBmlWjWhOKQjRc4mAnBv
         4EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676286; x=1713281086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBpHmg++FZ+uTrxs+NJvN18MokFvXNNYYZk1ttpqZ54=;
        b=G8n2JE2bJxdfFXK1qanph2E06wlJW86xHNaYdBBkadHeoX2MG5/MYqfTgtgJ/dMXo+
         S1tnAhRuWo/5HPBGPCYNFgYGVBK+frMD08uPtyoSZ0e6FP3ZZJklSB9RgAQTog9cC75U
         HXmCwSeVwWtUeQParbNSQPjc/Eq1z71Uh55sWlWESQ63ho2pYCcPdpq4YCcN9y+2wDAB
         dJJt3z1XyskALoV6QnN+h6/Jk++BI4Jq8HYMO+UYsWVJWpwn2bZ6AH2wXWr9GE3ug+Gb
         t1sJx6znHJkZXc7tbFAFWOjjQwWI1rWzSv76KChUrYRsScUy/EY5CBsHMK4oA/alWQdd
         RnqQ==
X-Gm-Message-State: AOJu0Yyb2Me/KiS555N8EMLHTfrruBxdkoOkwQ8FkcQNd5hOpv3AiEhF
	cNjbitUGSheP0HAHLpzY8oyzEuUbu72Mv6ujUdPHjTI+9Kjvz7i52TxfhCqePiqO4cMXTk08iUa
	+
X-Google-Smtp-Source: AGHT+IFx8dcTbqDzFCan3ii9R2GHt4JMXo2F485r7OyEJ/SyoJfy7yn/PVNWNnHSKVhaATGXZzTJOw==
X-Received: by 2002:a17:90b:3cb:b0:2a3:be48:23f3 with SMTP id go11-20020a17090b03cb00b002a3be4823f3mr10932902pjb.4.1712676286340;
        Tue, 09 Apr 2024 08:24:46 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090aeac600b002a513cc466esm3945558pjb.45.2024.04.09.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:24:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] userfaultfd: convert to ->read_iter()
Date: Tue,  9 Apr 2024 09:22:17 -0600
Message-ID: <20240409152438.77960-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409152438.77960-1-axboe@kernel.dk>
References: <20240409152438.77960-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than use the older style ->read() hook, use ->read_iter() so that
userfaultfd can support both O_NONBLOCK and IOCB_NOWAIT for non-blocking
read attempts.

Split the fd setup into two parts, so that userfaultfd can mark the file
mode with FMODE_NOWAIT before installing it into the process table. With
that, we can also defer grabbing the mm until we know the rest will
succeed, as the fd isn't visible before then.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/userfaultfd.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 60dcfafdc11a..6d963402c835 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -31,6 +31,7 @@
 #include <linux/hugetlb.h>
 #include <linux/swapops.h>
 #include <linux/miscdevice.h>
+#include <linux/uio.h>
 
 static int sysctl_unprivileged_userfaultfd __read_mostly;
 
@@ -282,7 +283,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 /*
  * Verify the pagetables are still not ok after having reigstered into
  * the fault_pending_wqh to avoid userland having to UFFDIO_WAKE any
- * userfault that has already been resolved, if userfaultfd_read and
+ * userfault that has already been resolved, if userfaultfd_read_iter and
  * UFFDIO_COPY|ZEROPAGE are being run simultaneously on two different
  * threads.
  */
@@ -1177,34 +1178,34 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 	return ret;
 }
 
-static ssize_t userfaultfd_read(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t userfaultfd_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct userfaultfd_ctx *ctx = file->private_data;
 	ssize_t _ret, ret = 0;
 	struct uffd_msg msg;
-	int no_wait = file->f_flags & O_NONBLOCK;
 	struct inode *inode = file_inode(file);
+	bool no_wait;
 
 	if (!userfaultfd_is_initialized(ctx))
 		return -EINVAL;
 
+	no_wait = file->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT;
 	for (;;) {
-		if (count < sizeof(msg))
+		if (iov_iter_count(to) < sizeof(msg))
 			return ret ? ret : -EINVAL;
 		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg, inode);
 		if (_ret < 0)
 			return ret ? ret : _ret;
-		if (copy_to_user((__u64 __user *) buf, &msg, sizeof(msg)))
+		_ret = !copy_to_iter_full(&msg, sizeof(msg), to);
+		if (_ret)
 			return ret ? ret : -EFAULT;
 		ret += sizeof(msg);
-		buf += sizeof(msg);
-		count -= sizeof(msg);
 		/*
 		 * Allow to read more than one fault at time but only
 		 * block if waiting for the very first one.
 		 */
-		no_wait = O_NONBLOCK;
+		no_wait = true;
 	}
 }
 
@@ -2172,7 +2173,7 @@ static const struct file_operations userfaultfd_fops = {
 #endif
 	.release	= userfaultfd_release,
 	.poll		= userfaultfd_poll,
-	.read		= userfaultfd_read,
+	.read_iter	= userfaultfd_read_iter,
 	.unlocked_ioctl = userfaultfd_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= noop_llseek,
@@ -2192,6 +2193,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 static int new_userfaultfd(int flags)
 {
 	struct userfaultfd_ctx *ctx;
+	struct file *file;
 	int fd;
 
 	BUG_ON(!current->mm);
@@ -2215,16 +2217,26 @@ static int new_userfaultfd(int flags)
 	init_rwsem(&ctx->map_changing_lock);
 	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
-	/* prevent the mm struct to be freed */
-	mmgrab(ctx->mm);
+
+	fd = get_unused_fd_flags(flags & UFFD_SHARED_FCNTL_FLAGS);
+	if (fd < 0)
+		goto err_out;
 
 	/* Create a new inode so that the LSM can block the creation.  */
-	fd = anon_inode_create_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
+	file = anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
 			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
-	if (fd < 0) {
-		mmdrop(ctx->mm);
-		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		fd = PTR_ERR(file);
+		goto err_out;
 	}
+	/* prevent the mm struct to be freed */
+	mmgrab(ctx->mm);
+	file->f_mode |= FMODE_NOWAIT;
+	fd_install(fd, file);
+	return fd;
+err_out:
+	kmem_cache_free(userfaultfd_ctx_cachep, ctx);
 	return fd;
 }
 
-- 
2.43.0


