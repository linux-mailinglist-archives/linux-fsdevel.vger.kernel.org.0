Return-Path: <linux-fsdevel+bounces-9070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B7983DD55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FABC1F22473
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674971D531;
	Fri, 26 Jan 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0wcFcgG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F51CF9C
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282490; cv=none; b=lYCUvANYHrj3zzCaDHBCZN2fOuA+VbOlEIQyT9JV/kX1TTX2owrUAn/C8neCsm4a/DzVBlziMmkhyWFe6a9akva1Do/aexTxzXYbx1hgUn8r7DJXd7cAVK8Mg7x0VF5UWaWIGfPkR6edSu1L/9f5uNtLdNVt0PRHT14xanbOc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282490; c=relaxed/simple;
	bh=KLqycvbxyin5EK5xfoYb5x+uoZFu70Qomxz8UPGqFOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2uwiy6h/x9yOgqFatCggqdzgpzHms5vp8TBUZuAikta8wU+G/anP4QUyu0ERU8Hfl9hhKV4uebS1Ls5/Z/h53dZ+MXLagrSPSfgZl8/XLG3WEauoByLmXmgmR8OiqeRIwbhVVguDt9HOBDhKaZl+2X98VsTFkg1yrojOrPl0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0wcFcgG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33924df7245so676880f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706282486; x=1706887286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4H1DhlYjrJNv9sMfgkE4dNp5tHYsFKrmvXGRqcdsmQ=;
        b=Z0wcFcgG0IxUw1iiVF7rCFJWEIPxgm/gVxaqV9Dy0nN9mQGzw05lZuz5tca4Out3rx
         kamoc3YB42NYLdatcEBAdvnAEkQG3F5m5DROAOawdr1B3RBnfErt3VIl9cjmuWN7Fs2d
         sxQH+ENPJuPZDMDnUaCfKDgziJ2vD5opfQ5wvAPS8A7+jCg0758v7zWL3sRkqWqwxfZX
         2I7NT94eZR6f6RNQcg7tHQppJoGVjukSC+7QbCwaYKetps6HBH3iZxawSIWFbBvYIif+
         HgjLJUILdqohPFXSQqzbbW1xLx3u5JJAiDV3awJSCLdS/FZJ2RVcMsVbIrYpoXJry+8Y
         DQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282486; x=1706887286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4H1DhlYjrJNv9sMfgkE4dNp5tHYsFKrmvXGRqcdsmQ=;
        b=QPmcI0j3YSEWCq35F8rLt+dwcpEgdkmyhQ+ThJ210Jxohf6y7PpQd2MKCq8HJ8YkWo
         MZqU8vqhw9zmw0drQup59E7vGwn4wQz2Q5LQ+R1IHEcW1pRxmgbf2Tkhdpy83KJlB5hI
         BC7EtO6xOw8/HqFQPCnom/VEbHbkyWE6R3XZ+ttGY+4p8nAl498Y5QMplLT6Nok4RgrY
         bFqaQczXwQryax4bkT8FoG1h5fkGoiEw7sCAMQmITcGbD4NwzrJP2QX4Ro6U8ONnPq49
         aSrWNpPAy/yVSWI85D93+FiuLUfaW/z0PUYiyHGRd2HD5U6dtLeBqm5pdhqfKKIREm3O
         hLUg==
X-Gm-Message-State: AOJu0YwYgq7OPvOjd3ap6IiIiOr2Eh3JGLxc/juuj5Fwt3yy53QPkKnh
	dpENURo9fP9kdHn64r08+MeDZbx3YNdyg7LSbPO/HYTA+n4XPHH0
X-Google-Smtp-Source: AGHT+IEnzjnuVvPj2oFTOk5PnJjcvQ/+Crss4+7xoR2euNC+UjpIx3bNeBnXfyVmFtAuWJkCAS/4aA==
X-Received: by 2002:adf:ec4e:0:b0:337:5b64:7414 with SMTP id w14-20020adfec4e000000b003375b647414mr1189234wrn.100.1706282486644;
        Fri, 26 Jan 2024 07:21:26 -0800 (PST)
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id bn7-20020a056000060700b0033946c0f9e7sm1493914wrb.17.2024.01.26.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:21:26 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v6 2/2] io_uring: add support for ftruncate
Date: Fri, 26 Jan 2024 17:21:18 +0200
Message-Id: <20240126152118.14201-3-tony.solomonik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126152118.14201-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240126152118.14201-1-tony.solomonik@gmail.com>
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
index 000000000000..fa61d9a39835
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
+	ret = do_ftruncate(req->file, ft->len, 0);
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


