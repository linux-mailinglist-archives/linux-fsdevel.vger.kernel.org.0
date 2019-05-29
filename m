Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D72E62C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 22:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfE2U3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 16:29:54 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50547 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfE2U3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 16:29:54 -0400
Received: by mail-it1-f194.google.com with SMTP id a186so6248260itg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=02YGgvtDIhMKSVtZXrYkbxNSPMNTLcY7/zpAzC74d0A=;
        b=bhLSoBtLJt7Pa4l6Kzn82na0fLnsSVniB/CdFdf3vPaF4sLNsfFz/SVglaxz1F8Q7R
         DrvHRAOZaBru6WJW5KD4lWYciZdUa267CgYzE8LWA/1V7mY5N5r4K4v2GdfIoU5HokDy
         L2i5lVymSOlaUO8jvGaOi5fOVuFXxBa/DaN3uPJPHhat9pCyOZZVMDglVtuewERPQ2nT
         TFpJcYMNI+dMtrh33X6e2U5pH4nSIIvvGogiOojbFcYf1zx2RddPI+bFHTqImDrv/FNl
         YHNhkArkwYuDdU5wC5+t5OGOV2ggr2X6BuvnQ4QdTuERv8qqvzeS81jUDCymql1VGhgL
         ivKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=02YGgvtDIhMKSVtZXrYkbxNSPMNTLcY7/zpAzC74d0A=;
        b=N681jhggBiBc3n3tTUUfDnGoZP3nucJcIu4HsN1Hi1ASDg+mdP9pM1r9XqTJqy17WP
         31Up0slJTFYDybhQ40+Bwew69ANdrR6J9TuvwhA6imL8yoR2kUVG8Zx7fO90BVM9Xo0K
         EjCw9hEUqjqjpZYL6JU02QqcC5UmkmOL7dtJ0G524O9xPDmwKErT8Toy13bOjY/vq2Ph
         uQ4XBN5qRYlz4qI6x+MgsizdsqaBoGAG57WWnijWpansUC/wAeH1boHfsPWupRSurdFZ
         tr7zq7bQo9uPZ4Og3ufCSI/hJxWgzc0lCtRfCyQA25g4O6hJeEN+tKcC/mfys4yHwxhz
         dQwg==
X-Gm-Message-State: APjAAAXP+r35YBsEg+phTrF6wvRsKu8lmhq3f6v2PvuG8sMaxeoLRVAe
        GKiMkLi8HIyk3kvETQGE3kRIcCiH80mWkg==
X-Google-Smtp-Source: APXvYqyRnr7BB6nNjVOOZFHqoHxADY5/TfidED28JiJNZq0niROaw0Rq7RL7mPIkSBUlGrsQN9j+TA==
X-Received: by 2002:a24:f644:: with SMTP id u65mr120757ith.51.1559161793237;
        Wed, 29 May 2019 13:29:53 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k76sm179105ita.6.2019.05.29.13.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:29:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] uio: make import_iovec()/compat_import_iovec() return bytes on success
Date:   Wed, 29 May 2019 14:29:46 -0600
Message-Id: <20190529202948.20833-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529202948.20833-1-axboe@kernel.dk>
References: <20190529202948.20833-1-axboe@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently these functions return < 0 on error, and 0 for success.
Change that so that we return < 0 on error, but number of bytes
for success.

Some callers already treat the return value that way, others need a
slight tweak.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c            |  9 +++++----
 fs/io_uring.c       | 16 ++++++++--------
 fs/splice.c         |  8 ++++----
 include/linux/uio.h |  4 ++--
 lib/iov_iter.c      | 15 ++++++++-------
 net/compat.c        |  3 ++-
 net/socket.c        |  3 ++-
 7 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3490d1fa0e16..41824c710b36 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1479,8 +1479,9 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	return 0;
 }
 
-static int aio_setup_rw(int rw, const struct iocb *iocb, struct iovec **iovec,
-		bool vectored, bool compat, struct iov_iter *iter)
+static ssize_t aio_setup_rw(int rw, const struct iocb *iocb,
+		struct iovec **iovec, bool vectored, bool compat,
+		struct iov_iter *iter)
 {
 	void __user *buf = (void __user *)(uintptr_t)iocb->aio_buf;
 	size_t len = iocb->aio_nbytes;
@@ -1537,7 +1538,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 		return -EINVAL;
 
 	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
-	if (ret)
+	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
@@ -1565,7 +1566,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 		return -EINVAL;
 
 	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
-	if (ret)
+	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret) {
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0fbb486a320e..23e08c10f486 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1003,9 +1003,9 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 	return 0;
 }
 
-static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
-			   const struct sqe_submit *s, struct iovec **iovec,
-			   struct iov_iter *iter)
+static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
+			       const struct sqe_submit *s, struct iovec **iovec,
+			       struct iov_iter *iter)
 {
 	const struct io_uring_sqe *sqe = s->sqe;
 	void __user *buf = u64_to_user_ptr(READ_ONCE(sqe->addr));
@@ -1023,7 +1023,7 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 	opcode = READ_ONCE(sqe->opcode);
 	if (opcode == IORING_OP_READ_FIXED ||
 	    opcode == IORING_OP_WRITE_FIXED) {
-		int ret = io_import_fixed(ctx, rw, sqe, iter);
+		ssize_t ret = io_import_fixed(ctx, rw, sqe, iter);
 		*iovec = NULL;
 		return ret;
 	}
@@ -1089,7 +1089,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	struct iov_iter iter;
 	struct file *file;
 	size_t iov_count;
-	int ret;
+	ssize_t ret;
 
 	ret = io_prep_rw(req, s, force_nonblock);
 	if (ret)
@@ -1102,7 +1102,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		return -EINVAL;
 
 	ret = io_import_iovec(req->ctx, READ, s, &iovec, &iter);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	iov_count = iov_iter_count(&iter);
@@ -1136,7 +1136,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	struct iov_iter iter;
 	struct file *file;
 	size_t iov_count;
-	int ret;
+	ssize_t ret;
 
 	ret = io_prep_rw(req, s, force_nonblock);
 	if (ret)
@@ -1149,7 +1149,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 		return -EINVAL;
 
 	ret = io_import_iovec(req->ctx, WRITE, s, &iovec, &iter);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	iov_count = iov_iter_count(&iter);
diff --git a/fs/splice.c b/fs/splice.c
index 14cb602d9a2f..98412721f056 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1356,7 +1356,7 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
-	long error;
+	ssize_t error;
 	struct fd f;
 	int type;
 
@@ -1367,7 +1367,7 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 
 	error = import_iovec(type, uiov, nr_segs,
 			     ARRAY_SIZE(iovstack), &iov, &iter);
-	if (!error) {
+	if (error >= 0) {
 		error = do_vmsplice(f.file, &iter, flags);
 		kfree(iov);
 	}
@@ -1382,7 +1382,7 @@ COMPAT_SYSCALL_DEFINE4(vmsplice, int, fd, const struct compat_iovec __user *, io
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
-	long error;
+	ssize_t error;
 	struct fd f;
 	int type;
 
@@ -1393,7 +1393,7 @@ COMPAT_SYSCALL_DEFINE4(vmsplice, int, fd, const struct compat_iovec __user *, io
 
 	error = compat_import_iovec(type, iov32, nr_segs,
 			     ARRAY_SIZE(iovstack), &iov, &iter);
-	if (!error) {
+	if (error >= 0) {
 		error = do_vmsplice(f.file, &iter, flags);
 		kfree(iov);
 	}
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 2d0131ad4604..a61ceb6575ab 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -279,13 +279,13 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i);
 
-int import_iovec(int type, const struct iovec __user * uvector,
+ssize_t import_iovec(int type, const struct iovec __user * uvector,
 		 unsigned nr_segs, unsigned fast_segs,
 		 struct iovec **iov, struct iov_iter *i);
 
 #ifdef CONFIG_COMPAT
 struct compat_iovec;
-int compat_import_iovec(int type, const struct compat_iovec __user * uvector,
+ssize_t compat_import_iovec(int type, const struct compat_iovec __user * uvector,
 		 unsigned nr_segs, unsigned fast_segs,
 		 struct iovec **iov, struct iov_iter *i);
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f99c41d4eb54..f1e0569b4539 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1634,9 +1634,9 @@ EXPORT_SYMBOL(dup_iter);
  * on-stack array was used or not (and regardless of whether this function
  * returns an error or not).
  *
- * Return: 0 on success or negative error code on error.
+ * Return: Negative error code on error, bytes imported on success
  */
-int import_iovec(int type, const struct iovec __user * uvector,
+ssize_t import_iovec(int type, const struct iovec __user * uvector,
 		 unsigned nr_segs, unsigned fast_segs,
 		 struct iovec **iov, struct iov_iter *i)
 {
@@ -1652,16 +1652,17 @@ int import_iovec(int type, const struct iovec __user * uvector,
 	}
 	iov_iter_init(i, type, p, nr_segs, n);
 	*iov = p == *iov ? NULL : p;
-	return 0;
+	return n;
 }
 EXPORT_SYMBOL(import_iovec);
 
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
-int compat_import_iovec(int type, const struct compat_iovec __user * uvector,
-		 unsigned nr_segs, unsigned fast_segs,
-		 struct iovec **iov, struct iov_iter *i)
+ssize_t compat_import_iovec(int type,
+		const struct compat_iovec __user * uvector,
+		unsigned nr_segs, unsigned fast_segs,
+		struct iovec **iov, struct iov_iter *i)
 {
 	ssize_t n;
 	struct iovec *p;
@@ -1675,7 +1676,7 @@ int compat_import_iovec(int type, const struct compat_iovec __user * uvector,
 	}
 	iov_iter_init(i, type, p, nr_segs, n);
 	*iov = p == *iov ? NULL : p;
-	return 0;
+	return n;
 }
 #endif
 
diff --git a/net/compat.c b/net/compat.c
index 3f9ce609397f..0f7ded26059e 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -80,9 +80,10 @@ int get_compat_msghdr(struct msghdr *kmsg,
 
 	kmsg->msg_iocb = NULL;
 
-	return compat_import_iovec(save_addr ? READ : WRITE,
+	err = compat_import_iovec(save_addr ? READ : WRITE,
 				   compat_ptr(msg.msg_iov), msg.msg_iovlen,
 				   UIO_FASTIOV, iov, &kmsg->msg_iter);
+	return err < 0 ? err : 0;
 }
 
 /* Bleech... */
diff --git a/net/socket.c b/net/socket.c
index 72372dc5dd70..bffec466b4f1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2208,9 +2208,10 @@ static int copy_msghdr_from_user(struct msghdr *kmsg,
 
 	kmsg->msg_iocb = NULL;
 
-	return import_iovec(save_addr ? READ : WRITE,
+	err = import_iovec(save_addr ? READ : WRITE,
 			    msg.msg_iov, msg.msg_iovlen,
 			    UIO_FASTIOV, iov, &kmsg->msg_iter);
+	return err < 0 ? err : 0;
 }
 
 static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
-- 
2.17.1

