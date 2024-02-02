Return-Path: <linux-fsdevel+bounces-10012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B41847007
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23D01F218B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0181419A6;
	Fri,  2 Feb 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyjIjONB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78614077E
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876253; cv=none; b=saqlWR+qM9UD17dkfb9l3qixUqkBz+qyAUfrKry78P9yvlgVdGgxqH9BevL8XWxQyGeG0HPktep3E4WxXQPZsUjMnuYJBo56Ou6UvKuCmv0uG+JXCjC/zkIRYsoxNrO2rEwN2jpytYWMd49ka0iRdDd4ciH58zZxACuvAGg5kYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876253; c=relaxed/simple;
	bh=gORs380CfLA2XaChTonMQ2kmcIdpE1eqE7dIaa3uhUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEnmUWeK7ZgQQ99QMfWJhcr9m8+sJTfDVWE6ESg8Y2zy5yzbOGn6kYAUW+onak3MLGasU9HB96z5Xkrp6q89W9g58YU54mMUn8TC3yD6//9nekW6u38y5lXBCC0mXaVtk0HavRyTK3GJnv0a61hSb8CSsyHaBiag5zhylskg5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyjIjONB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e80046246so4031015e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 04:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706876250; x=1707481050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grYHPax4BPqSxHU8FTAI7NDVVw4e3ZmnhYjGqX3e/Vs=;
        b=AyjIjONBHBcgEifcD+Ul3v330u6bxZjUYZ6NjIMqavkAzGy93NIexakrHy3suDXNyN
         1MwLnhm4HScViSMpU/C5tx6bEJCbkvox2RXifIkn0vm/zKXoc5+PAzXN1++NWO2obhuI
         SRZSxusMqASqzDuPBhY8rGK4BCji7rCkk5h4/Fe48jTQWO35yd1BIV0uTaKcbMhJZg3U
         FNQbqccImBv8n1Qmr8+Xu/xPeVIeI6miWrrcP8BMr/Wv2A2pW1qiqbYf8y27ESOxX+qA
         YmxRAiV7uOBO4jEmXsjwSOaIB2tNLSzJ4aHIMcs836lWa1t8gZDrhnxIf5fFXxDdFo/c
         7j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876250; x=1707481050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grYHPax4BPqSxHU8FTAI7NDVVw4e3ZmnhYjGqX3e/Vs=;
        b=UuGq8a2ZG409fhGKImz7Jtw++F5g2Uu622p5dJOxcBrMDG7lXmek2JibzA4js0vk0O
         1vPFLi1Wl+rkdsXOo3LHj3T3QLHLUx69S0VDHa7qyv0Ce1C5NF8e9YNUj1/sN5pUBl+B
         MyMtto6ZnjrUaqBULKrC2ukOH4AAHe5NlYyx0DQjP5xAb2MPF/ioWWZeIay+9DUhOul2
         cihiDyFh2fNJzPhscFMNTF6dJzwLZkbxOSMH67WaXsw/ttWaY6PcOfXPcMFSyji8I2Hf
         PwId7Ly9WABkrjnGsWPBsfgXD3BnpzW+5mGPuxgSIGG4OSeShGqp62zCSPdBPVVE5X0Q
         m2RQ==
X-Gm-Message-State: AOJu0YzPO5YZgL//qEHDhRuuRJfEmXJHFv3wJWXTNOWKNt3VwrFeWEZ3
	q7hF6LhM7nlDltxqabkuTx+FuKrbH1Gf4W15QxWRiWmAiiizeBpMc6MBQt72hZ6WJQ==
X-Google-Smtp-Source: AGHT+IF5BRJezdSox5fLR0wAx0koznjIcot8SUcHq8yBJ0AOIKyFWExqsUEKaVL0zhp5Ji9lMb+iVQ==
X-Received: by 2002:a05:600c:4f55:b0:40e:cca6:d82f with SMTP id m21-20020a05600c4f5500b0040ecca6d82fmr1713104wmq.16.1706876249838;
        Fri, 02 Feb 2024 04:17:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVrlAv7+remxikBVvJPvIdid/0migsk99Lxehxccqxgb7d1k2F7zFyUEpPZllhNqnUmke7iZaqmTSsCpwW48fJgmTWDcSUiLQ7iHREAmaR7FDNUBfUZSK5aBBSVPaXFtZgu3KmtLgp7EANISCRFX/D7Wtoy2ZKrAZHH7yK8xEiyuwfZgYtLKa54EYSJcQ==
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0040e3635ca65sm7364736wmo.2.2024.02.02.04.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:17:29 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v9 2/2] io_uring: add support for ftruncate
Date: Fri,  2 Feb 2024 14:17:24 +0200
Message-Id: <20240202121724.17461-3-tony.solomonik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202121724.17461-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240202121724.17461-1-tony.solomonik@gmail.com>
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
index 000000000000..62ee73d34d72
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
+	ret = do_ftruncate(req->file, ft->len, 1);
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


