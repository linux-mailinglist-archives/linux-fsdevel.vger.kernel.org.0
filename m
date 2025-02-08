Return-Path: <linux-fsdevel+bounces-41289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7DDA2D74C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 17:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2515B167452
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1B91F30DF;
	Sat,  8 Feb 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7MoFODV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421E1F30A7;
	Sat,  8 Feb 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031987; cv=none; b=KoQGT4tCvG6MBgQyR+f/blFlX2lHY3v4CjzJx5xMIQVo1zLaByINhTyxiK19+YIe7qCGDlW5j5KE3JYlNxEBsZl48aUIfmaTgGzQAtn3Pj/rad7cqLNtHdojUwOG/ywK1QXF/bm8t4Q3OJrsjFelupdJv6y0JP3gVtGwnEnRYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031987; c=relaxed/simple;
	bh=thyIzr/hAE1egVwDCAqpAQjTRPiszDQk4UEy0efkMng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjpVKur6ylGhbmGoznkLoqUc7USAP49IJkJVde8Zn86l4xMiHAqK5Zjzx4wTcbP3zyrVQ3jV8+fHKvs4oaNfP53zwnApsgRlZpnV1znnR8GFAtx3Jbol8nIED0SxBEI89nJPjCxGC6ShUY0OSJ+H4/O08quZupmHqVEB0Vs6Opc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7MoFODV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7917fc0c2so244448866b.0;
        Sat, 08 Feb 2025 08:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739031984; x=1739636784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWCIQoK+T/QDWA9/1+I0/yGEQa/Cy6uKnjdSGLgFg6Q=;
        b=R7MoFODVCwcQaDLzw8oFvAUWSD3SMPCkLrBi01nnS727B6+tkXs0D+WdbVzjzAknB6
         /s1cvvgm5oOc5LQN9AfZjltDtYpS/UNCFykzj4jhMd3nKoOKHTp3V8kD99LXtZTv8mE4
         6KdE14UzgBOGrjUjBtaBvzcJlebWfw7YjIswHVMFNxuYuz23L6yhf7N7LbFfqIDqJUuQ
         tbXnMyO4Dib67SXVOrxVmim7tm4Az8cHpeA1DhyPotvM9doMcsYYiR2Fgw0JifcQNC1Q
         5/TePmH2E+E5iH9I59TuSfuOuY7tav/Qi26wjXlnh0LlwU6T9Kj4IxO7W0xMiO69nvJT
         Ja2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739031984; x=1739636784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWCIQoK+T/QDWA9/1+I0/yGEQa/Cy6uKnjdSGLgFg6Q=;
        b=iLpTil4qBk9nOoWxaD+/SOaCB0dh4Ugo8DKaO3Ar0ZqMETe7dnXNPRIuIzPSmxEKPq
         UVXcAYwqg9H7E0OIIn5F3fwu2dFH3NxhIQ6mY/eN9uHmGcZxJJBl5ZYjd4+gkONubTw3
         VgFeFvijYLUvrH0X8+XbQR1qLughztfqd77KfE9UCc2T9/dgEvRBvC9/RfsKavFhGoJY
         vJJrgpmJriev6sgWO59S6t2eVTnR6totJ36VlkBPUjXqeTmUWhAks2RuuyhoCiwjkUM6
         oej2/BhQWStfYak1plckvPk6mdSetIwXUA031oLLM4DJKsvjcR9mNLP3NMKfIJS/iRNG
         ecEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVITwmJMtX4l9ZIHf4iEl+a2pehoY3OoAV1TRI8Twfm7k/dUcI51l4xbv2I+wTdcNvRv3m1MqHFddsQeKmZ@vger.kernel.org, AJvYcCW8HYpgSjWdv/ACT90BXWYGfUodk1p5PzqubX8JnWOfEOyciB+0CYmfA1bd6GILG9pCGlqgp3hcFrlHxj3R@vger.kernel.org
X-Gm-Message-State: AOJu0YyklEBzbHlSASifI5am/uRe/dvRVO34D/INPc0hCGNsyN+7ePn1
	n7cXo5FzoIlIm7QUpuksvzlK356szHTd4/MPt2kKCku+L6fZBUOQ
X-Gm-Gg: ASbGncuVAe2U714G71X7sxRDS5rV4dsCBBQOJ3FnIT1fk6NJ9mtIDRrLa9YBkWf4i6w
	nS0wkrfn9LnAqJ/QBG2g4rwwt3H+Njz6tfbqLOWf3O8VwJPSHRZbvdoy6L0ua8/WGmLD11LVoxB
	pXmtaHjHQ4ysP2JFyd5EKVJNzch+AhFJiEZByVRDfoH2RymQFy0NDED4F2JUjfwzu4Q6Qi1slt6
	TKSw2fdqCJ54QCJ//KFQXaHIJHR5+0VdXQFNMqvWTeXHevRBH+yyg4Ks5WEPy5ePkQE3f7ezcAg
	McxgM1frUP41+515v1ItKktUxxrvfrqF+A==
X-Google-Smtp-Source: AGHT+IGdwjjOGmSnuYHY8CL/kldenIojki/aHYbsTcuF8zRjVjyW5iezgEkwbxSPGF0Wp6g4hDx0GA==
X-Received: by 2002:a17:907:3e06:b0:ab7:5d25:88e1 with SMTP id a640c23a62f3a-ab789b2a2a1mr786056166b.9.1739031983339;
        Sat, 08 Feb 2025 08:26:23 -0800 (PST)
Received: from f.. (cst-prg-84-201.cust.vodafone.cz. [46.135.84.201])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de47d6461asm3193943a12.74.2025.02.08.08.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 08:26:22 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 1/3] vfs: add initial support for CONFIG_VFS_DEBUG
Date: Sat,  8 Feb 2025 17:26:09 +0100
Message-ID: <20250208162611.628145-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208162611.628145-1-mjguzik@gmail.com>
References: <20250208162611.628145-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small collection of macros taken from mmdebug.h

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c               | 12 +++++++++++
 include/linux/fs.h       |  1 +
 include/linux/vfsdebug.h | 45 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |  9 ++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 include/linux/vfsdebug.h

diff --git a/fs/inode.c b/fs/inode.c
index 5587aabdaa5e..b73bb0b2dad6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2953,3 +2953,15 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 	return mode & ~S_ISGID;
 }
 EXPORT_SYMBOL(mode_strip_sgid);
+
+#ifdef CONFIG_DEBUG_VFS
+/*
+ * Dump an inode.
+ *
+ * TODO: add a proper inode dumping routine, this is a stub to get debug off the
+ * ground.
+ */
+void dump_inode(struct inode *inode, const char *reason) {
+       pr_warn("%s encountered for inode %px", reason, inode);
+}
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1437a3323731..034745af9702 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FS_H
 #define _LINUX_FS_H
 
+#include <linux/vfsdebug.h>
 #include <linux/linkage.h>
 #include <linux/wait_bit.h>
 #include <linux/kdev_t.h>
diff --git a/include/linux/vfsdebug.h b/include/linux/vfsdebug.h
new file mode 100644
index 000000000000..9cf22d3eb9dd
--- /dev/null
+++ b/include/linux/vfsdebug.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_VFS_DEBUG_H
+#define LINUX_VFS_DEBUG_H 1
+
+#include <linux/bug.h>
+
+struct inode;
+
+#ifdef CONFIG_DEBUG_VFS
+void dump_inode(struct inode *inode, const char *reason);
+
+#define VFS_BUG_ON(cond) BUG_ON(cond)
+#define VFS_WARN_ON(cond) (void)WARN_ON(cond)
+#define VFS_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
+#define VFS_WARN_ONCE(cond, format...) (void)WARN_ONCE(cond, format)
+#define VFS_WARN(cond, format...) (void)WARN(cond, format)
+
+#define VFS_BUG_ON_INODE(cond, inode)		({			\
+	if (unlikely(!!(cond))) {					\
+		dump_inode(inode, "VFS_BUG_ON_INODE(" #cond")");\
+		BUG_ON(1);						\
+	}								\
+})
+
+#define VFS_WARN_ON_INODE(cond, inode)		({			\
+	int __ret_warn = !!(cond);					\
+									\
+	if (unlikely(__ret_warn)) {					\
+		dump_inode(inode, "VFS_WARN_ON_INODE(" #cond")");\
+		WARN_ON(1);						\
+	}								\
+	unlikely(__ret_warn);						\
+})
+#else
+#define VFS_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
+#define VFS_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)
+#define VFS_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
+#define VFS_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
+#define VFS_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
+
+#define VFS_BUG_ON_INODE(cond, inode) VFS_BUG_ON(cond)
+#define VFS_WARN_ON_INODE(cond, inode)  BUILD_BUG_ON_INVALID(cond)
+#endif /* CONFIG_DEBUG_VFS */
+
+#endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..c08ce985c482 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -808,6 +808,15 @@ config ARCH_HAS_DEBUG_VM_PGTABLE
 	  An architecture should select this when it can successfully
 	  build and run DEBUG_VM_PGTABLE.
 
+config DEBUG_VFS
+	bool "Debug VFS"
+	depends on DEBUG_KERNEL
+	help
+	  Enable this to turn on extended checks in the VFS layer that may impact
+	  performance.
+
+	  If unsure, say N.
+
 config DEBUG_VM_IRQSOFF
 	def_bool DEBUG_VM && !PREEMPT_RT
 
-- 
2.43.0


