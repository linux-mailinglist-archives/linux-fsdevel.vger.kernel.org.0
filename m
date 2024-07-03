Return-Path: <linux-fsdevel+bounces-23040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8528D92639B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D76285983
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D917C23F;
	Wed,  3 Jul 2024 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="aIa+6Cii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC9176ADB
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017554; cv=none; b=VCMdLlhujTpW3G7+SXDi3PJmQKHwp3Xa5zuExyHQ204cSPxwde8KbODOcLxaPR6FQp57bMlw45tQ/SH2I5tZzC8uCL5UMClLif1DT6eBMG0UK6V330v9zccL5xMxtfYsz1RAMEoXWAaYibz9FbN9OHTEeE/rkAfYItoMbDRjWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017554; c=relaxed/simple;
	bh=Elee2BDq6qTQjNRd+/OU9osvHHOA1Kgb9H/hwDvti7E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=utZiPrn8NCRa/Bv/L3NB8jWjUMB5BY2GAkPIvPhUGz5wVD4S6xvDHF7lK0EyOTu0aLJ4k5Gb94IGoPWIlRdJCZg8D25BHNKs57MGZmIZeWyHchNgkwDs0ydYwxStrLq2tb/SPHlSQno+hpkzgBxDl6IXmNVG9x5NmzE7r48UGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=aIa+6Cii; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79c06a06a8eso338389485a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720017551; x=1720622351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hthTJrDZRWREh2oJI4fydmpnrOcaPRKsi/dxzm4/eoU=;
        b=aIa+6CiiArBuJvs4RSrGs9TwcTQdu67ovzmitdwPig5SGz36xr3bfb8D2+nkrLz0V/
         JNqI4IwtXkn9iQIFiIqqQNLTHHkQMCPeUPRKwQHKxRoAPi9ee4W0dWuhl2h0LBDYhQO+
         aA1US6eb2f9NPfydDAiVCZTb81dDOU84r6pIW7tli+J3DsWlBCPLUkQndiCzNwQwA8VH
         86bvQuDvEuoHjMs//H6lyHksO7jhOvZ7nqHP1briLPPMhXbdrVTgv2eniPz3kKoxwUz/
         P/gUjDUukV8gqQz4C1HGInAFFedsV8JfcNMDNTre5l7+8HAKFYEsPeFAvtOpHyDvi9Fe
         tGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720017551; x=1720622351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hthTJrDZRWREh2oJI4fydmpnrOcaPRKsi/dxzm4/eoU=;
        b=CcTzfMyl9c4MRN7414wxVxXRX3W153B0kOq3+gcvqKlBsmT3OEYasP8g5DHWr5jpE2
         FIMZUNIHX/lZeDHrobiltWT619HghSbuncG5NqapgsGWM2jNCllKv8tsxpbEbUBqXiH7
         Cgv805ERbsdoIvKKfg5qPK+z/UZ5gD84arkJH1KtZZBByqLHKaYC6dPo0xXQaT6PAh2w
         0+Hu7jc+o4+sU7ZOTf5ov5PKjjj0TMxMCvmOxD5Uk6JB2HTOYa5mSGQIFxjwkuZIFbFD
         zYiJbUoOJOSSTh9i5ci8qpoK5/vEUHjMqcJaM0qtAxcpG2+Z5tVS9n76IeFw6/vtmuFD
         9Z5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkAbBRj5c5y+8S0ywt71rvx9z4koZS9katSVJtigQ0FQ+KNW7hk1I65rcWT91yE35+CwGUG+7YARZ2v3QstXhjDuiKXrfrpL69LPRXyA==
X-Gm-Message-State: AOJu0YwC9x0pcM9NOIy6NdDU5PRQNvm7bfce+p72/Hsgyo0lC23vcl1d
	ZnyrkvU7yRlRBggoXkytp1o3NLXi410rWkehG2vuke6qEg1fKn93mWMBwtS5QWfunQMgPNDggZn
	x
X-Google-Smtp-Source: AGHT+IFIgKk4xGUdx36jXIaKRQWdxvKSPlPB3yTtLcVXpDjWghAoJ5olcfxSkIYBZUBZXSME5sYYcg==
X-Received: by 2002:a05:620a:1a18:b0:79d:5528:a1b9 with SMTP id af79cd13be357-79d7b987e3dmr1497740685a.6.1720017551201;
        Wed, 03 Jul 2024 07:39:11 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6925ecbesm572287185a.24.2024.07.03.07.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 07:39:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH][RESEND] fuse: add simple request tracepoints
Date: Wed,  3 Jul 2024 10:38:42 -0400
Message-ID: <fc6559455ed29437cd414c0fc838ef4749670ff2.1720017492.git.josef@toxicpanda.com>
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
index 9eb191b5c4de..d303bfd31450 100644
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


