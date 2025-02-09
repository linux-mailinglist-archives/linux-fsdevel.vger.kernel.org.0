Return-Path: <linux-fsdevel+bounces-41332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D6A2E00F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF216343E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9657B1E2838;
	Sun,  9 Feb 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMuYsO5Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319AEAC6;
	Sun,  9 Feb 2025 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739127339; cv=none; b=IAOoB6adg5eVj3Do3jE27AoEchyd/0uZlXw3Bpu206OIqaRBMNqM8H/bvN8KWsbVdlk3mXQM0P9T5S8cvdh/LAbloC2ZrzEWeNWNxvAZ70vvctPjl+dvuRfi+2z92H+ybK4wIXG/rWeMoevYFQR/wMAX2ZNBAqXR6kCvS41T9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739127339; c=relaxed/simple;
	bh=Q51XQfe56AFhuGNQTaw2YQJVCi8+KJGxjjuooUOyupA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKCqa12tZCSujTx7qJj/B9558wmkofjSepIUkz95U0A6bt9PUXleu8VSrjWhpxCURSZ998LZypxdE6zUx3rxvNRgeTdSLwrZYM+KDi84fS5rvMwfuaRP1I6nazmqfR3pv4i2T3MgzteEcWjrTX/GBTYZJeU9kT2yqI5OgvcZ76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMuYsO5Q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab78e6edb99so314059466b.2;
        Sun, 09 Feb 2025 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739127335; x=1739732135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFRswilTxe6On8n4prZbm2R1GRuCBxzYFss7QkKFRZw=;
        b=RMuYsO5QRk6H9m88liL4dgiI+e66BWCXqaPNjc4cLbQx8olhAieraW5km+Jw4uOAZv
         g6J06EXIlQEkrPXHubWd/QqZje3SQlzv6dANCxCIEyO3dRhKPlJ5r+WjTXb/c+wByRkX
         jE4mRHoIchOArFnrjRy0289ipzSI+9x2S8OFIzfvjRE8av69gEGXD6K0glLONbbER4gE
         YkXUoiayCCCRRbQ7x7i+QQA8kOWOmt/hL0t9JAE/37GuL9DGEj5Rlev/McUg88riwnux
         fuqwHoe7XJEh6ze5ULu8b3zieYzmiEz/vUV1KWwsjdqNlQLBkqPhGoIiaa5vNFfunGOs
         YkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739127335; x=1739732135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFRswilTxe6On8n4prZbm2R1GRuCBxzYFss7QkKFRZw=;
        b=wIvaxCNz75Sr+nlfvVquMUrIBAWyRjNgkneCx4wPVxOnndQ6f1Lvh33nn4Aa12sCc7
         B6c0lHs5ERQpENUzs1RJDmcf1bLfQoWmb+Upq/VWTmWzkPiYu1GIM+a0EiBRnDdpASNA
         c0C7pAkhppEo6v8XcQ/9WgI/3XODoGEiJX0v+9+rQqHk0VL+3PO2IvcoWtSloQ4MO50D
         R8itlHagW1UOY4nbmV3VYVsbXvK4thW5yOcnLRhUVZV6M3E0+6UFlDly5bdZp7FrTDQO
         hvo//SidJ6SAi2FPpxJGtQF7hOoiwNoFP8gZ1HLkNpTZkxeQr6F91mPKBPhRCn+TKBZ0
         Wjxg==
X-Forwarded-Encrypted: i=1; AJvYcCU88YQ8wWIMJaUGW7xIZLh+Y1L8uyRlKqeomt8ZSU2uu63x3fGudKvdA+cBEBMxGnzS9zznXKWS6jRjk5lN@vger.kernel.org, AJvYcCVqq17iwH9B8z4K4NRZPOJF4Za8uDjOFuqvvf5EdcaWPQpL2FGhfr5Xfe5E46MeacEMQV0gCFSw9p8nuYgv@vger.kernel.org
X-Gm-Message-State: AOJu0YzkeJ1m4bVEPprm6CE9ZJRrS4YpjhvA3V/rhPSc8kJGDlLXmoHJ
	ghgw8t1XyRl3NHaxzTD5bT5z1Nl+8cUQWfPvz1ccu4zVAsRrc2In
X-Gm-Gg: ASbGnctB/AuP5lrKVfVfwzYS0tr1TS0K+Tu29APAnNj6y/y3JazNYtDGQuxc1jbGI+V
	/F8Ih9HsD+SsJ9PSmOX9bwJMCD705dxEjLrVxwpriUbdqoP7PD2dxFbAE4ZLYs64xII832UGbsC
	3IXqWBNnTtq6o5oXiMf4w7xRVnOOrLglXJrszAn4azXakCp8RtzMIYcGNAtINa3WKllJaO//iet
	ugX+SOw9F9JYSWWqHTdXZf3IH+PpU1WXe/ACFgtp7ngy9DVQezPSKrfHFSyg3t6yRInKhFiSDgB
	3amEqA/rgdB52N/3iNzcqXw0oMGExhCovQ==
X-Google-Smtp-Source: AGHT+IE2E6xuO4bsGmAr2vQRRwDQnOiAypsmYow6wZgZuhIkXnmSoaQozfy4BglYDKCZrwE5YFAMkw==
X-Received: by 2002:a17:906:9c8d:b0:ab7:b93:f77d with SMTP id a640c23a62f3a-ab789a9ed18mr1248346166b.3.1739127335193;
        Sun, 09 Feb 2025 10:55:35 -0800 (PST)
Received: from f.. (cst-prg-84-201.cust.vodafone.cz. [46.135.84.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a82dba37sm318478566b.165.2025.02.09.10.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 10:55:34 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 1/3] vfs: add initial support for CONFIG_DEBUG_VFS
Date: Sun,  9 Feb 2025 19:55:20 +0100
Message-ID: <20250209185523.745956-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209185523.745956-1-mjguzik@gmail.com>
References: <20250209185523.745956-1-mjguzik@gmail.com>
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
 fs/inode.c               | 15 ++++++++++++++
 include/linux/fs.h       |  1 +
 include/linux/vfsdebug.h | 45 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |  9 ++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 include/linux/vfsdebug.h

diff --git a/fs/inode.c b/fs/inode.c
index 5587aabdaa5e..875e66261f06 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2953,3 +2953,18 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
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
+void dump_inode(struct inode *inode, const char *reason)
+{
+       pr_warn("%s encountered for inode %px", reason, inode);
+}
+
+EXPORT_SYMBOL(dump_inode);
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


