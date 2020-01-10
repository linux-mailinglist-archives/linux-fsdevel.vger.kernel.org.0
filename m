Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806FC1371A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 16:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgAJPro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 10:47:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43381 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgAJPro (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:47:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so1311418pfo.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2020 07:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ar4Hk7sTDhuxABHFPIAjYj6whvYMREbeGUKWQd9uQ3c=;
        b=wVyxSKtHotMq4EuLG6hUjb4yKyMqleMnTy2ia5IR32vG1YEhn+fWVw6nECakPk3eMo
         govAPdUvlSguVPs4krubKp53uQQ9zcK/nOpruq7xLFh9MhZ2aVLRMep1ijJtRsBbRH4k
         qEn76slmf01lSzxBJn1EzDED7udNX2854BZX79hMA06qXKI1lwm0uhuikWvkINRrF3r6
         CaZIcsIEKXRJezA9MyOOURToYQ2i4oCtAWYFq7suJNrCZgzxls/hBecHUBdDUpl53n8i
         TiedOy91/RFnzrgw7ejTT0wHQMN0TQJmFUdbKmZFgnoDAeAWVoVmdDDOqJgnD38PMhQv
         uz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ar4Hk7sTDhuxABHFPIAjYj6whvYMREbeGUKWQd9uQ3c=;
        b=Y8iJWvFMMM/QCbpMj1GVjtZYCxOE8Ryumvg0niQIhGLX5f6pcQEmESg3rjt0cvS8ix
         D1JPk7MoVEZPOfjHEVeGLma9E8aAvJqw9F+z3YhvvXDuu9DSjmA7FUR8A0avSMyMCh8e
         7udOxALUCmD5z3Ipoqn6cS3CpFT7dW+q3LB8+zPw++Ajgtl76NO+RZ07sBPAmHf5gg1G
         2zjT7vwE2NsxQZDvtGkw1rGDtFOG0IivFRkfn4S3MPmytduxFrIyZ2JXHydTm4yAY9sG
         owC9EZIDT80KCdOL6WaL8DqQlBafVcGTs/QHJqi6pxImFUggGB7HHIwdy9/Ff73iLoy9
         Ff6g==
X-Gm-Message-State: APjAAAUhtdMWHHcJOH2gxhOyLkZtzVH0XQ2R3ngBjRwMapWlbxyJ36V/
        HhZNSj7BTnWSR7zG7kIhHNhaLThvF2w=
X-Google-Smtp-Source: APXvYqy/eFWRQ7Wigbs9Lto08/bjCPlfrb6Cq9OM8UDwn5twRULysQal8kDhfv5vdBLeNtpjBnQ+LQ==
X-Received: by 2002:a63:215f:: with SMTP id s31mr4979937pgm.27.1578671263157;
        Fri, 10 Jan 2020 07:47:43 -0800 (PST)
Received: from x1.localdomain ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 3sm3489520pfi.13.2020.01.10.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 07:47:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] io_uring: add IORING_OP_FADVISE
Date:   Fri, 10 Jan 2020 08:47:37 -0700
Message-Id: <20200110154739.2119-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110154739.2119-1-axboe@kernel.dk>
References: <20200110154739.2119-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support for doing fadvise through io_uring. We assume that
WILLNEED doesn't block, but that DONTNEED may block.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 53 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 62459a79a61f..0b200a7d4ae0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -72,6 +72,7 @@
 #include <linux/highmem.h>
 #include <linux/namei.h>
 #include <linux/fsnotify.h>
+#include <linux/fadvise.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/io_uring.h>
@@ -400,6 +401,13 @@ struct io_files_update {
 	u32				offset;
 };
 
+struct io_fadvise {
+	struct file			*file;
+	u64				offset;
+	u32				len;
+	u32				advice;
+};
+
 struct io_async_connect {
 	struct sockaddr_storage		address;
 };
@@ -452,6 +460,7 @@ struct io_kiocb {
 		struct io_open		open;
 		struct io_close		close;
 		struct io_files_update	files_update;
+		struct io_fadvise	fadvise;
 	};
 
 	struct io_async_ctx		*io;
@@ -669,6 +678,10 @@ static const struct io_op_def io_op_defs[] = {
 		.needs_file		= 1,
 		.unbound_nonreg_file	= 1,
 	},
+	{
+		/* IORING_OP_FADVISE */
+		.needs_file		= 1,
+	},
 };
 
 static void io_wq_submit_work(struct io_wq_work **workptr);
@@ -2435,6 +2448,35 @@ static int io_openat(struct io_kiocb *req, struct io_kiocb **nxt,
 	return 0;
 }
 
+static int io_fadvise_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	if (sqe->ioprio || sqe->buf_index || sqe->addr)
+		return -EINVAL;
+
+	req->fadvise.offset = READ_ONCE(sqe->off);
+	req->fadvise.len = READ_ONCE(sqe->len);
+	req->fadvise.advice = READ_ONCE(sqe->fadvise_advice);
+	return 0;
+}
+
+static int io_fadvise(struct io_kiocb *req, struct io_kiocb **nxt,
+		      bool force_nonblock)
+{
+	struct io_fadvise *fa = &req->fadvise;
+	int ret;
+
+	/* DONTNEED may block, others _should_ not */
+	if (fa->advice == POSIX_FADV_DONTNEED && force_nonblock)
+		return -EAGAIN;
+
+	ret = vfs_fadvise(req->file, fa->offset, fa->len, fa->advice);
+	if (ret < 0)
+		req_set_fail_links(req);
+	io_cqring_add_event(req, ret);
+	io_put_req_find_next(req, nxt);
+	return 0;
+}
+
 static int io_statx_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	unsigned lookup_flags;
@@ -3724,6 +3766,9 @@ static int io_req_defer_prep(struct io_kiocb *req,
 	case IORING_OP_STATX:
 		ret = io_statx_prep(req, sqe);
 		break;
+	case IORING_OP_FADVISE:
+		ret = io_fadvise_prep(req, sqe);
+		break;
 	default:
 		printk_once(KERN_WARNING "io_uring: unhandled opcode %d\n",
 				req->opcode);
@@ -3920,6 +3965,14 @@ static int io_issue_sqe(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		}
 		ret = io_statx(req, nxt, force_nonblock);
 		break;
+	case IORING_OP_FADVISE:
+		if (sqe) {
+			ret = io_fadvise_prep(req, sqe);
+			if (ret)
+				break;
+		}
+		ret = io_fadvise(req, nxt, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 80f892628e66..f87d8fb42916 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -36,6 +36,7 @@ struct io_uring_sqe {
 		__u32		cancel_flags;
 		__u32		open_flags;
 		__u32		statx_flags;
+		__u32		fadvise_advice;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	union {
@@ -86,6 +87,7 @@ enum {
 	IORING_OP_STATX,
 	IORING_OP_READ,
 	IORING_OP_WRITE,
+	IORING_OP_FADVISE,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
-- 
2.24.1

