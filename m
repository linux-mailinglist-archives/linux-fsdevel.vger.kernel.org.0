Return-Path: <linux-fsdevel+bounces-9076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2683DE1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C69A1F24CB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD91D697;
	Fri, 26 Jan 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfsdxSGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A731D545
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284651; cv=none; b=mKSFj6Os/mjkpYgivxMsyz+u+VNHeEwk+EKWPIgAQgaOVkzS15HYDL/rdAHAZde85XGzlqMaeWxXaGg4a1O+2SsEQSDbPe88jPD8iJq6QPeSGlxOkKV9s5+AMMzQkrIoINvjec7cUxlZCHNnbA0mpf7T5WPz/+ss4E/7jxWJPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284651; c=relaxed/simple;
	bh=fHwkyIdQT4SZ+pg11KW/vWNospg1pMcQWocpCSsy5Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T49+CnFHenJQD4pYkRVt/dyIXNgYQwMR9vzhS97/VRG4vgraS1oyxJYC8ux8i0VDtbRBlqHYO70Jt76lKV9fRSeHUhR7KQUpmUh4Hu7qSfWFpmOtfD1NaN7JDXYDJCyrUCMh3JFlSwtJ0Qpj8R5l+n5tvlQB0E1j3p8i014LpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfsdxSGu; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso5855951fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 07:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706284647; x=1706889447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEoRLjZxsDql9htA9V4PRolq3lloZtO5EyOWZLDSizA=;
        b=QfsdxSGuMN42A/ncNNUlHNOPID7ELF2R5/BoD1FW6E11zv+rAqdO0jqUvK1hJU+O3j
         9TKRGxmlpcwHZQTYD19Zq9euc96YG4JfetSgCzpHgXkTNGX5rAvwmaeOxLn5xqC608Bn
         KE/niFwE5xBYFokWX5l6V9rcS3ClADM5CxdsMbzoKZuGYZM5RA8D5e69UTWNWypRxUCD
         i+ZxNEUFLw8Xp19MJ+OzHyQKwMMR90W3XRHfGLbEDIbq+xrY5/sL6x0f4zp2Us710uDF
         pY5ijbKNEC5jp7xHYua0W4xMRhW90+Wna8P3VHoW5qGFgdhYnywIknxSJVLbMjVK92FH
         Kopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706284647; x=1706889447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEoRLjZxsDql9htA9V4PRolq3lloZtO5EyOWZLDSizA=;
        b=vUeYfAaM7zccoMxvJ6jAFQDnNmCOH3JyICXKT8DoFYUC2g431/tUPKyeuBm2XVy07M
         p5zToTkQa+jMe6hHGSonmCyk8iLa3z/ID4Jn0gIVKgrtp8rD5LHfTwupW0CXb377GhWq
         WSro4tL2AjyW+nRPoaXDA9qLDmQ1I69iqjD/GeioJesYK7sE3DX98J5A56H6j8q5zBWm
         fdvPVPaoOH0TcATmDBPSHrrmN8s82+XsB7DXkYdRJQScBJmaGT8RxRq20VqqxGPYodrn
         pHm8xljq8JD7UWitNa+Weroh0x0ppJQy3jYf9FOP7biiaWN2N14r5QwviBgprQePZfvy
         zpRQ==
X-Gm-Message-State: AOJu0Yz9ei4kgOQPKU/zrFCV9BfIayq2eC5+6mFjp0cSegBLaUoRiKy7
	Z9MC7xdI4AOMhmtlhsulv1ClKOaf/CeyoFgx4IWlCjqYdFL6wx+G
X-Google-Smtp-Source: AGHT+IHiMn1bMLnNmyIOE99XayThFyvrspKHaof/6MnqK63aeBqCUPVxN9ifR/vIevC2GEoTy86Jmg==
X-Received: by 2002:a2e:6a04:0:b0:2cf:1ae2:dcd with SMTP id f4-20020a2e6a04000000b002cf1ae20dcdmr1670744ljc.32.1706284647174;
        Fri, 26 Jan 2024 07:57:27 -0800 (PST)
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id f8-20020a2e6a08000000b002ccdb771df0sm188598ljc.108.2024.01.26.07.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:57:26 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v7 2/2] io_uring: add support for ftruncate
Date: Fri, 26 Jan 2024 17:57:20 +0200
Message-Id: <20240126155720.20385-3-tony.solomonik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126155720.20385-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240126155720.20385-1-tony.solomonik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for doing truncate through io_uring, eliminating
the need for applications to roll their own thread pool or offload
mechanism to be able to do non-blocking truncates.

Signed-off-by: Tony Solomonik <tony.solomonik@gmail.com>
---
 include/uapi/linux/io_uring.h |  1 +
 io_uring/Makefile             |  2 +-
 io_uring/opdef.c              | 10 ++++++++
 io_uring/truncate.c           | 48 +++++++++++++++++++++++++++++++++++
 io_uring/truncate.h           |  4 +++
 5 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 io_uring/truncate.c
 create mode 100644 io_uring/truncate.h

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index f1c16f817742..be682e000c94 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -253,6 +253,7 @@ enum io_uring_op {
 	IORING_OP_FUTEX_WAIT,
 	IORING_OP_FUTEX_WAKE,
 	IORING_OP_FUTEX_WAITV,
+	IORING_OP_FTRUNCATE,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/Makefile b/io_uring/Makefile
index e5be47e4fc3b..4f8ed6530a29 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -8,6 +8,6 @@ obj-$(CONFIG_IO_URING)		+= io_uring.o xattr.o nop.o fs.o splice.o \
 					statx.o net.o msg_ring.o timeout.o \
 					sqpoll.o fdinfo.o tctx.o poll.o \
 					cancel.o kbuf.o rsrc.o rw.o opdef.o \
-					notif.o waitid.o
+					notif.o waitid.o truncate.o
 obj-$(CONFIG_IO_WQ)		+= io-wq.o
 obj-$(CONFIG_FUTEX)		+= futex.o
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 799db44283c7..7a83b76c6ee7 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -35,6 +35,7 @@
 #include "rw.h"
 #include "waitid.h"
 #include "futex.h"
+#include "truncate.h"
 
 static int io_no_issue(struct io_kiocb *req, unsigned int issue_flags)
 {
@@ -469,6 +470,12 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_eopnotsupp_prep,
 #endif
 	},
+	[IORING_OP_FTRUNCATE] = {
+		.needs_file		= 1,
+		.hash_reg_file		= 1,
+		.prep			= io_ftruncate_prep,
+		.issue			= io_ftruncate,
+	},
 };
 
 const struct io_cold_def io_cold_defs[] = {
@@ -704,6 +711,9 @@ const struct io_cold_def io_cold_defs[] = {
 	[IORING_OP_FUTEX_WAITV] = {
 		.name			= "FUTEX_WAITV",
 	},
+	[IORING_OP_FTRUNCATE] = {
+		.name			= "FTRUNCATE",
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
diff --git a/io_uring/truncate.c b/io_uring/truncate.c
new file mode 100644
index 000000000000..9b0735890c62
--- /dev/null
+++ b/io_uring/truncate.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/io_uring.h>
+
+#include <uapi/linux/io_uring.h>
+
+#include "../fs/internal.h"
+
+#include "io_uring.h"
+#include "truncate.h"
+
+struct io_ftrunc {
+	struct file			*file;
+	loff_t				len;
+};
+
+int io_ftruncate_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_ftrunc *ft = io_kiocb_to_cmd(req, struct io_ftrunc);
+
+	if (sqe->rw_flags || sqe->addr || sqe->len || sqe->buf_index ||
+	    sqe->splice_fd_in || sqe->addr3)
+		return -EINVAL;
+
+	ft->len = READ_ONCE(sqe->off);
+
+	req->flags |= REQ_F_FORCE_ASYNC;
+	return 0;
+}
+
+int io_ftruncate(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_ftrunc *ft = io_kiocb_to_cmd(req, struct io_ftrunc);
+	int ret;
+
+	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+
+	ret = do_ftruncate(req->file, ft->len);
+
+	io_req_set_res(req, ret, 0);
+	return IOU_OK;
+}
diff --git a/io_uring/truncate.h b/io_uring/truncate.h
new file mode 100644
index 000000000000..ec088293a478
--- /dev/null
+++ b/io_uring/truncate.h
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+int io_ftruncate_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_ftruncate(struct io_kiocb *req, unsigned int issue_flags);
-- 
2.34.1


