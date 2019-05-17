Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D410521FCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfEQVlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:41:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41952 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfEQVlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:41:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12so3907138plt.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6zAlRh9OPYhPFQn4Cl/zMapUx0b+2kyu/Sbx6quVpQU=;
        b=cVLb9VW5kjd+lYa1M9FVRl9blBqTIjIZ5HEj0shwuAojucnsh9a9xepahCxl9Fzaip
         FXo8KeUeyA1ltkFdprAhN+UVmAol4psb3bO4sbBAZ4gWP38kYLH0KaLkzY56zSWiXjQ1
         BOBX/TF/DgMBe2mLRor2KEWVHiFcUrbjXBEm8Id0HNhg3ZR01vO1uPYMqrEkdjCjNtTO
         1LS9lnNXOvKsUa0XKSfYvpfXN+ByWcrdcn3BgpW2hISy6AkiA0w5gAt54iyicoFN9kep
         NOWuOWs+JVZN8VvG7+ZBiJrerg0BAR3P2fseV7PcoY1D5YFtWyqAMuFqgBAP/TiKYjYf
         IM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6zAlRh9OPYhPFQn4Cl/zMapUx0b+2kyu/Sbx6quVpQU=;
        b=qmvDdPVxF973bcvfHS1UMaYQR+aXbzlslE7MSHnScwKbeDcqzSIW9f3v/imp168AFa
         kBvZcTU3EO0VTamTph5zvv/aRUJi5O0nYaK9DyK7W8wbCaTbcv7FEz3Bog51kC8Z3nFU
         5lB4zZkx6wyf+6KDv+/hshceN2MAqjHVRuYfhAIHPyUXeczvz02Bmzf/MXIix99xn0PL
         Rmzs+T+0FKUQ4/2EGRDzvux7OxuL0MN08Vw7A7ikDsXCho+2kctj0SNWlw1SYz5pCecj
         EeFOLUXx4biOekAcjNTUh2C8PUrx/bQbo9imNCFP/YZXZCCDHrgcCjSLU/5iLItu7Xwx
         MgBw==
X-Gm-Message-State: APjAAAUKTHh5z4V264pEkLZb7ZJk2JV6rvsdIizgWAFEIlI0vCl1VsBC
        q0bmLMfb+MPkkIOFEIcjF1nNr7U/QDKthg==
X-Google-Smtp-Source: APXvYqwgtCB6cxUJEH96U+O9qrI31proNY65sh+24QyvRhPY18xvtMlfKKXLaK3v3zosCaNrf21lew==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr60983501plb.202.1558129298111;
        Fri, 17 May 2019 14:41:38 -0700 (PDT)
Received: from x1.localdomain (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z125sm15885331pfb.75.2019.05.17.14.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:41:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] uio: make import_iovec()/compat_import_iovec() return bytes on success
Date:   Fri, 17 May 2019 15:41:29 -0600
Message-Id: <20190517214131.5925-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517214131.5925-1-axboe@kernel.dk>
References: <20190517214131.5925-1-axboe@kernel.dk>
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
index 65dd05505a16..84cb31e69727 100644
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
index 25212dcca2df..c5b951b0b639 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1355,7 +1355,7 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
-	long error;
+	ssize_t error;
 	struct fd f;
 	int type;
 
@@ -1366,7 +1366,7 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 
 	error = import_iovec(type, uiov, nr_segs,
 			     ARRAY_SIZE(iovstack), &iov, &iter);
-	if (!error) {
+	if (error >= 0) {
 		error = do_vmsplice(f.file, &iter, flags);
 		kfree(iov);
 	}
@@ -1381,7 +1381,7 @@ COMPAT_SYSCALL_DEFINE4(vmsplice, int, fd, const struct compat_iovec __user *, io
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
-	long error;
+	ssize_t error;
 	struct fd f;
 	int type;
 
@@ -1392,7 +1392,7 @@ COMPAT_SYSCALL_DEFINE4(vmsplice, int, fd, const struct compat_iovec __user *, io
 
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
index f74fa832f3aa..ad23f930f703 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1633,9 +1633,9 @@ EXPORT_SYMBOL(dup_iter);
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
@@ -1651,16 +1651,17 @@ int import_iovec(int type, const struct iovec __user * uvector,
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
@@ -1674,7 +1675,7 @@ int compat_import_iovec(int type, const struct compat_iovec __user * uvector,
 	}
 	iov_iter_init(i, type, p, nr_segs, n);
 	*iov = p == *iov ? NULL : p;
-	return 0;
+	return n;
 }
 #endif
 
diff --git a/net/compat.c b/net/compat.c
index a031bd333092..eb498fbf35de 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -79,9 +79,10 @@ int get_compat_msghdr(struct msghdr *kmsg,
 
 	kmsg->msg_iocb = NULL;
 
-	return compat_import_iovec(save_addr ? READ : WRITE,
+	err = compat_import_iovec(save_addr ? READ : WRITE,
 				   compat_ptr(msg.msg_iov), msg.msg_iovlen,
 				   UIO_FASTIOV, iov, &kmsg->msg_iter);
+	return err < 0 ? err : 0;
 }
 
 /* Bleech... */
diff --git a/net/socket.c b/net/socket.c
index bdd6942f6152..418ae316e6f8 100644
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

