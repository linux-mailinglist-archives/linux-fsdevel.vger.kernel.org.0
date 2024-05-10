Return-Path: <linux-fsdevel+bounces-19287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2F8C2BF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 23:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635F71F21A7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 21:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DED13BC34;
	Fri, 10 May 2024 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="v6oya9Z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182591A2C3B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377051; cv=none; b=ChDjnwsm7TnOPwdEOFHSfL7givfDWwyFM3bu4fOoV6gH+Epz82Q9/lg4IFvE+OR81lyGBzCELhxbMN9g2DIYkv40nt+kuZErdc0LqVwyQ1XgBzGPWLZrZw8weairWruymIzeDVMqBLqDnqMtykRiJfeMg94hocZMiqesoBuG9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377051; c=relaxed/simple;
	bh=SCoI3E3Z7Gz/djp4a8WWFYDBA6sLKOH8IcUvVX/Uq40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=k6QSUw9hD/CCRK8dAotnq3Jd8tOPZJCBryYv6WJkMvAyxtd+v1PM4EFolRoFutEo0zubTM0tB7hez7GCj1QenY+P6EDHI8RzVZzmyg3n1Hlndx+kPQWVq6MQCAnQwx/dkdMCOLp14OnCVY8L8ZtrkPvNATrSPSTbyXtdv54Xnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=v6oya9Z/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61804067da0so24828807b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715377048; x=1715981848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZzjF9czcudld5U3qAYUWKT3FElVhj7cDM4dA6fT//Q=;
        b=v6oya9Z/asP2J2rQiJv2vZFptNWdMsqWnYnEkUJ8rB/K6DvaJG41FZ/pG4hxkl9oem
         auxnORp433LIwXSg+X1CpCI4xwfaHaGm5UIaWrI+Tl1as3JccnVHCsG6tH7n57nAjjUQ
         iq71frA8aIsq67JieCwYkQQkV4x7b8Q5FhVcELHUgH6NhRjWa7hdc7B5EF//oWSEjzgT
         HtUiv/5M0QHLY2wKoUBCwULO9OBeG7u4ObAU8fINXdkSsiKIzslH2JL18MGP/ZKz9dCk
         q5B6yjCH3P2/JEGU2AgIzUGiWqzNArAI4cMYXhmcgDkGmvxVtClLmUpJ6XlYXSKEq4lw
         eJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377048; x=1715981848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZzjF9czcudld5U3qAYUWKT3FElVhj7cDM4dA6fT//Q=;
        b=TLAtCqbQ2XlylIpEUZPrXBBwAY8BoeIQLkWKxXKylwy4wZZ5QddQXk86V5akyhrFuk
         b4n1UuPdi/zmsDthtacTBU+irpDwZk+QnuGLxhbQDiuIn5PaVUw5ofYUYgoKmwUDhL28
         mcGFDFw0MpT/DP3UlqRmSKTP6ARvHUJEZpFQQI2Vp2Xgn0k9RLXxbc/NA+OiV5cfYgL4
         5h8E9Y0ET+Dql893Q3PXcrksLHRW7Dgrga1SGIeEfDXW1l5ue70nYttG16DKAsNyQAtu
         LL9YsYWd8CFCGNyDbOJVxyJDt5Rsl/YDgXhqRrHL/RbZgBLaLNtCvhR8Bw2GWoRgJ/rN
         nLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNJfDJtzaU3inQsUHVN7QVUDrGdco53cwbGNEmfnUAwQl3ByuHHriXITSI09mYwY/5ktXP5nXNOfg7yoP0lmy7fHgW099O5FmgcOu4Pg==
X-Gm-Message-State: AOJu0YxEPHpW7UnTDPkdgcTdJ5odKzI7HMRdUM+j8X96DPiwIq68iIi9
	dLrHDMf/hvd2MIAK0Vy0PVJrQqxDbCil3iESH/FslO233V3M1hZIjL7TZPYhpN4=
X-Google-Smtp-Source: AGHT+IEJdKBntPxhEnPqid7gghb9xBUf9hyKZyhEOZQmCt/XKgRAurdS+EZa3h8qSpfNph7lnBjT8Q==
X-Received: by 2002:a81:4f43:0:b0:618:7f3c:cbaf with SMTP id 00721157ae682-622afff6b31mr38267187b3.42.1715377047805;
        Fri, 10 May 2024 14:37:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e250aa0sm9113597b3.33.2024.05.10.14.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 14:37:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] fuse: add simple request tracepoints
Date: Fri, 10 May 2024 17:36:52 -0400
Message-ID: <4b11700964fdcdb67eb63a72c133423a5a876332.1715376944.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been timing various fuse operations and it's quite annoying to do
with kprobes.  Add two tracepoints for sending and ending fuse requests
to make it easier to debug and time various operations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/Makefile     |   3 +
 fs/fuse/dev.c        |   6 ++
 fs/fuse/fuse_trace.h | 132 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 fs/fuse/fuse_trace.h

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 6e0228c6d0cb..ce0ff7a9007b 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -3,6 +3,9 @@
 # Makefile for the FUSE filesystem.
 #
 
+# Needed for trace events
+ccflags-y = -I$(src)
+
 obj-$(CONFIG_FUSE_FS) += fuse.o
 obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3ec8bb5e68ff..c61609c38da6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -22,6 +22,9 @@
 #include <linux/splice.h>
 #include <linux/sched.h>
 
+#define CREATE_TRACE_POINTS
+#include "fuse_trace.h"
+
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
 
@@ -230,6 +233,7 @@ __releases(fiq->lock)
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
 	list_add_tail(&req->list, &fiq->pending);
+	trace_fuse_request_send(req);
 	fiq->ops->wake_pending_and_unlock(fiq);
 }
 
@@ -286,6 +290,8 @@ void fuse_request_end(struct fuse_req *req)
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
 		goto put_request;
 
+	trace_fuse_request_end(req);
+
 	/*
 	 * test_and_set_bit() implies smp_mb() between bit
 	 * changing and below FR_INTERRUPTED check. Pairs with
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
new file mode 100644
index 000000000000..bbe9ddd8c716
--- /dev/null
+++ b/fs/fuse/fuse_trace.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fuse
+
+#if !defined(_TRACE_FUSE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FUSE_H
+
+#include <linux/tracepoint.h>
+
+#define OPCODES							\
+	EM( FUSE_LOOKUP,		"FUSE_LOOKUP")		\
+	EM( FUSE_FORGET,		"FUSE_FORGET")		\
+	EM( FUSE_GETATTR,		"FUSE_GETATTR")		\
+	EM( FUSE_SETATTR,		"FUSE_SETATTR")		\
+	EM( FUSE_READLINK,		"FUSE_READLINK")	\
+	EM( FUSE_SYMLINK,		"FUSE_SYMLINK")		\
+	EM( FUSE_MKNOD,			"FUSE_MKNOD")		\
+	EM( FUSE_MKDIR,			"FUSE_MKDIR")		\
+	EM( FUSE_UNLINK,		"FUSE_UNLINK")		\
+	EM( FUSE_RMDIR,			"FUSE_RMDIR")		\
+	EM( FUSE_RENAME,		"FUSE_RENAME")		\
+	EM( FUSE_LINK,			"FUSE_LINK")		\
+	EM( FUSE_OPEN,			"FUSE_OPEN")		\
+	EM( FUSE_READ,			"FUSE_READ")		\
+	EM( FUSE_WRITE,			"FUSE_WRITE")		\
+	EM( FUSE_STATFS,		"FUSE_STATFS")		\
+	EM( FUSE_RELEASE,		"FUSE_RELEASE")		\
+	EM( FUSE_FSYNC,			"FUSE_FSYNC")		\
+	EM( FUSE_SETXATTR,		"FUSE_SETXATTR")	\
+	EM( FUSE_GETXATTR,		"FUSE_GETXATTR")	\
+	EM( FUSE_LISTXATTR,		"FUSE_LISTXATTR")	\
+	EM( FUSE_REMOVEXATTR,		"FUSE_REMOVEXATTR")	\
+	EM( FUSE_FLUSH,			"FUSE_FLUSH")		\
+	EM( FUSE_INIT,			"FUSE_INIT")		\
+	EM( FUSE_OPENDIR,		"FUSE_OPENDIR")		\
+	EM( FUSE_READDIR,		"FUSE_READDIR")		\
+	EM( FUSE_RELEASEDIR,		"FUSE_RELEASEDIR")	\
+	EM( FUSE_FSYNCDIR,		"FUSE_FSYNCDIR")	\
+	EM( FUSE_GETLK,			"FUSE_GETLK")		\
+	EM( FUSE_SETLK,			"FUSE_SETLK")		\
+	EM( FUSE_SETLKW,		"FUSE_SETLKW")		\
+	EM( FUSE_ACCESS,		"FUSE_ACCESS")		\
+	EM( FUSE_CREATE,		"FUSE_CREATE")		\
+	EM( FUSE_INTERRUPT,		"FUSE_INTERRUPT")	\
+	EM( FUSE_BMAP,			"FUSE_BMAP")		\
+	EM( FUSE_DESTROY,		"FUSE_DESTROY")		\
+	EM( FUSE_IOCTL,			"FUSE_IOCTL")		\
+	EM( FUSE_POLL,			"FUSE_POLL")		\
+	EM( FUSE_NOTIFY_REPLY,		"FUSE_NOTIFY_REPLY")	\
+	EM( FUSE_BATCH_FORGET,		"FUSE_BATCH_FORGET")	\
+	EM( FUSE_FALLOCATE,		"FUSE_FALLOCATE")	\
+	EM( FUSE_READDIRPLUS,		"FUSE_READDIRPLUS")	\
+	EM( FUSE_RENAME2,		"FUSE_RENAME2")		\
+	EM( FUSE_LSEEK,			"FUSE_LSEEK")		\
+	EM( FUSE_COPY_FILE_RANGE,	"FUSE_COPY_FILE_RANGE")	\
+	EM( FUSE_SETUPMAPPING,		"FUSE_SETUPMAPPING")	\
+	EM( FUSE_REMOVEMAPPING,		"FUSE_REMOVEMAPPING")	\
+	EM( FUSE_SYNCFS,		"FUSE_SYNCFS")		\
+	EM( FUSE_TMPFILE,		"FUSE_TMPFILE")		\
+	EM( FUSE_STATX,			"FUSE_STATX")		\
+	EMe(CUSE_INIT,			"CUSE_INIT")
+
+/*
+ * This will turn the above table into TRACE_DEFINE_ENUM() for each of the
+ * entries.
+ */
+#undef EM
+#undef EMe
+#define EM(a, b)	TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+OPCODES
+
+/* Now we redfine it with the table that __print_symbolic needs. */
+#undef EM
+#undef EMe
+#define EM(a, b)	{a, b},
+#define EMe(a, b)	{a, b}
+
+TRACE_EVENT(fuse_request_send,
+	TP_PROTO(const struct fuse_req *req),
+
+	TP_ARGS(req),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(uint64_t,		unique)
+		__field(enum fuse_opcode,	opcode)
+		__field(uint32_t,		len)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	req->fm->fc->dev;
+		__entry->unique		=	req->in.h.unique;
+		__entry->opcode		=	req->in.h.opcode;
+		__entry->len		=	req->in.h.len;
+	),
+
+	TP_printk("connection %u req %llu opcode %u (%s) len %u ",
+		  __entry->connection, __entry->unique, __entry->opcode,
+		  __print_symbolic(__entry->opcode, OPCODES), __entry->len)
+);
+
+TRACE_EVENT(fuse_request_end,
+	TP_PROTO(const struct fuse_req *req),
+
+	TP_ARGS(req),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	unique)
+		__field(uint32_t,	len)
+		__field(int32_t,	error)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	req->fm->fc->dev;
+		__entry->unique		=	req->in.h.unique;
+		__entry->len		=	req->out.h.len;
+		__entry->error		=	req->out.h.error;
+	),
+
+	TP_printk("connection %u req %llu len %u error %d", __entry->connection,
+		  __entry->unique, __entry->len, __entry->error)
+);
+
+#endif /* _TRACE_FUSE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE fuse_trace
+#include <trace/define_trace.h>
-- 
2.43.0


