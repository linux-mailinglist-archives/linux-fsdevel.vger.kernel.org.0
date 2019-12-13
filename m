Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51E511EA72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 19:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfLMSgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 13:36:43 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38354 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfLMSgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:36:43 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so646827ioj.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 10:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BvbAUwfhvErzK8hAEaqvoLvxzMrFdnyKRzaKHwJ4h0w=;
        b=EIPBsr0Hy04FMziRNWz5mdylpV5LPUGMFRgE7RAl4OXT2YsmTC+B8okmnQn1pmj+Xu
         1OYh3wrdWKknMpSuayQmfTYMjju1+NqjZYfP4th2Aq24/aOu2Ug76b/go2bWH/q6VUlC
         0Uagps29q6RlOmqZh+xnZIHIh+Nml2DG9EeMqgWTZnPpzqIX+PJisePEQcOSmAztYkoR
         D2aqKhBHpXR+QkGb2gdmAxCvJh9teLZq2UWULLKgapOmB9hu9tsYcCNUOYgHZAnGaEmk
         o26ukFBU2zeNMEAj8DQlQtx7eCHnDLDiLuQ16PLmTpWXVeiWqJtUDyznV6etXDugMZqw
         eQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvbAUwfhvErzK8hAEaqvoLvxzMrFdnyKRzaKHwJ4h0w=;
        b=ejjeHoXLa0azXBS6Bo9sDTHCn+U41QbHv2nZnsWkZUXr0PS/QZSln9Z7/c1cUGtN9Q
         9mOPj68gJ8TLAOKMAcrt029Eu9K5PcSiqu/4hHLsmzyjXZ9ncf7mDFPv7Qer/b/FKrTb
         TIpq5o1nCWtg0/hasmLlNlMSZDbCoDAXyEMXOGjy2iO88nILn3w2srDSX/MLdtKPt/Hp
         /7UglhPkpZHQaQJOdb+3/AELOSYt7FT/C3QpNtdANM4BpTvhwacjOYsAAVNugyfp5TXK
         zslztwjoBOwcXnBZTkF9pM+ko/NN+svq44YjJItRdlAn58rEkPkyIbCffPbowbL2sFBX
         P1qg==
X-Gm-Message-State: APjAAAV2TnTyNKBNDliY+FZqMXeFHW9E+rT4Ed8Pbyvhb/cZcfEoNxJw
        ZNw7YG+JL3yvKm2eUnXNvUmXaQ==
X-Google-Smtp-Source: APXvYqymc23gJpCScbe1C1ljZfg1PFpzrQPetfQSpmO5ZZljgvJiTRR0Otw6CoG02UBASsau3xe2Sw==
X-Received: by 2002:a02:cd0d:: with SMTP id g13mr796702jaq.110.1576262202125;
        Fri, 13 Dec 2019 10:36:42 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w24sm2932031ilk.4.2019.12.13.10.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 10:36:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/10] io_uring: add support for IORING_OP_OPENAT
Date:   Fri, 13 Dec 2019 11:36:27 -0700
Message-Id: <20191213183632.19441-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213183632.19441-1-axboe@kernel.dk>
References: <20191213183632.19441-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This works just like openat(2), except it can be performed async. For
the normal case of a non-blocking path lookup this will complete
inline. If we have to do IO to perform the open, it'll be done from
async context.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 106 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/io_uring.h |   2 +
 2 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 93a967cf3f9f..db79ac79d80e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -70,6 +70,8 @@
 #include <linux/sizes.h>
 #include <linux/hugetlb.h>
 #include <linux/highmem.h>
+#include <linux/namei.h>
+#include <linux/fsnotify.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/io_uring.h>
@@ -322,6 +324,10 @@ struct io_async_rw {
 	ssize_t				size;
 };
 
+struct io_async_open {
+	struct filename			*filename;
+};
+
 struct io_async_ctx {
 	struct io_uring_sqe		sqe;
 	union {
@@ -329,6 +335,7 @@ struct io_async_ctx {
 		struct io_async_msghdr	msg;
 		struct io_async_connect	connect;
 		struct io_timeout_data	timeout;
+		struct io_async_open	open;
 	};
 };
 
@@ -879,8 +886,11 @@ static void __io_free_req(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
-	if (req->io)
+	if (req->io) {
+		if (req->io->sqe.opcode == IORING_OP_OPENAT)
+			putname(req->io->open.filename);
 		kfree(req->io);
+	}
 	if (req->file && !(req->flags & REQ_F_FIXED_FILE))
 		fput(req->file);
 	if (req->flags & REQ_F_INFLIGHT) {
@@ -2001,6 +2011,88 @@ static int io_fallocate(struct io_kiocb *req, struct io_kiocb **nxt,
 	return 0;
 }
 
+static int io_openat_prep(struct io_kiocb *req, struct io_async_ctx *io)
+{
+	const struct io_uring_sqe *sqe = req->sqe;
+	const char __user *fname;
+	int ret;
+
+	fname = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	io->open.filename = getname(fname);
+	if (!IS_ERR(io->open.filename))
+		return 0;
+
+	ret = PTR_ERR(io->open.filename);
+	io->open.filename = NULL;
+	return ret;
+}
+
+static int io_openat(struct io_kiocb *req, struct io_kiocb **nxt,
+		     bool force_nonblock)
+{
+	const struct io_uring_sqe *sqe = req->sqe;
+	struct filename *filename;
+	const char __user *fname;
+	struct open_flags op;
+	int flags, ret, dfd;
+	struct file *file;
+	umode_t mode;
+
+	if (sqe->ioprio || sqe->buf_index)
+		return -EINVAL;
+
+	dfd = READ_ONCE(sqe->fd);
+	mode = READ_ONCE(sqe->len);
+	fname = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	flags = READ_ONCE(sqe->open_flags);
+
+	ret = build_open_flags(flags, mode, &op);
+	if (ret)
+		goto err;
+	if (force_nonblock)
+		op.lookup_flags |= LOOKUP_NONBLOCK;
+	if (req->io) {
+		filename = req->io->open.filename;
+	} else {
+		filename = getname(fname);
+		if (IS_ERR(filename)) {
+			ret = PTR_ERR(filename);
+			goto err;
+		}
+	}
+
+	ret = get_unused_fd_flags(flags);
+	if (ret < 0)
+		goto err;
+
+	file = do_filp_open(dfd, filename, &op);
+	if (IS_ERR(file)) {
+		put_unused_fd(ret);
+		ret = PTR_ERR(file);
+		if (ret == -EAGAIN) {
+			req->io = kmalloc(sizeof(*req->io), GFP_KERNEL);
+			if (!req->io) {
+				ret = -ENOMEM;
+				goto err;
+			}
+			req->io->open.filename = filename;
+			req->work.flags |= IO_WQ_WORK_NEEDS_FILES;
+			return -EAGAIN;
+		}
+		putname(filename);
+	} else {
+		fsnotify_open(file);
+		fd_install(ret, file);
+		putname(filename);
+	}
+err:
+	if (ret < 0)
+		req_set_fail_links(req);
+	io_cqring_add_event(req, ret);
+	io_put_req_find_next(req, nxt);
+	return 0;
+}
+
 static int io_prep_sfr(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -2909,6 +3001,9 @@ static int io_req_defer_prep(struct io_kiocb *req, struct io_async_ctx *io)
 		return io_timeout_prep(req, io, false);
 	case IORING_OP_LINK_TIMEOUT:
 		return io_timeout_prep(req, io, true);
+	case IORING_OP_OPENAT:
+		ret = io_openat_prep(req, io);
+		break;
 	default:
 		req->io = io;
 		return 0;
@@ -3018,6 +3113,9 @@ static int io_issue_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 	case IORING_OP_FALLOCATE:
 		ret = io_fallocate(req, nxt, force_nonblock);
 		break;
+	case IORING_OP_OPENAT:
+		ret = io_openat(req, nxt, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -3102,7 +3200,7 @@ static bool io_req_op_valid(int op)
 	return op >= IORING_OP_NOP && op < IORING_OP_LAST;
 }
 
-static int io_op_needs_file(const struct io_uring_sqe *sqe)
+static int io_op_needs_file(const struct io_uring_sqe *sqe, int fd)
 {
 	int op = READ_ONCE(sqe->opcode);
 
@@ -3114,6 +3212,8 @@ static int io_op_needs_file(const struct io_uring_sqe *sqe)
 	case IORING_OP_ASYNC_CANCEL:
 	case IORING_OP_LINK_TIMEOUT:
 		return 0;
+	case IORING_OP_OPENAT:
+		return fd != -1;
 	default:
 		if (io_req_op_valid(op))
 			return 1;
@@ -3142,7 +3242,7 @@ static int io_req_set_file(struct io_submit_state *state, struct io_kiocb *req)
 	if (flags & IOSQE_IO_DRAIN)
 		req->flags |= REQ_F_IO_DRAIN;
 
-	ret = io_op_needs_file(req->sqe);
+	ret = io_op_needs_file(req->sqe, fd);
 	if (ret <= 0)
 		return ret;
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index bdbe2b130179..02af580754ce 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -34,6 +34,7 @@ struct io_uring_sqe {
 		__u32		timeout_flags;
 		__u32		accept_flags;
 		__u32		cancel_flags;
+		__u32		open_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	union {
@@ -77,6 +78,7 @@ enum {
 	IORING_OP_LINK_TIMEOUT,
 	IORING_OP_CONNECT,
 	IORING_OP_FALLOCATE,
+	IORING_OP_OPENAT,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
-- 
2.24.1

