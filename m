Return-Path: <linux-fsdevel+bounces-40956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76109A29934
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94D83AA126
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E21FDA9D;
	Wed,  5 Feb 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbmXLtX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE0B13D897;
	Wed,  5 Feb 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780772; cv=none; b=GKXCQxSakkm9g0jF1KEAxtdDNb6Wh7gPLrUZrpQs/67yMyD1Wsz68sXccSDu+NwRQryi8VoWSEuhmbRArCQVKLZ9QixPjG3Qn1XCefpNlEc19wVMaBMXYs+2FF64XbidNP8ygWaGSVATSjbwzcXBDsnuEzcfNVF24Te3ZQfwZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780772; c=relaxed/simple;
	bh=rSrgBXoRQUY1G3aXlbo7qAi2ZwiSsS1ffYKOdNljnXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEDaSzg1xxygSq1VoEjk4mJmpzYrxb1PEl7rpaCk0B/QxRsLb2j1PKk1yBPu0Rw0HzARm8gBoL7vAeNAUnzptDca8NDlUEckrW5q51mH6B+ZBM12Izno+N9FDvhRGLmToLnw8NXWDZseScjUke540Wk6a01o5ij0kAJJq9mTdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbmXLtX0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa67ac42819so24445266b.0;
        Wed, 05 Feb 2025 10:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738780769; x=1739385569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncI8U9yeEkwYbqL+S/qfhrzFnBLh0LPVDRLpisjGJBU=;
        b=mbmXLtX0ZpQ5FpocNnhGHoIk/wZtF5Fx5mpGEEzZ+X9X2frXLv/tKoEt8sHap400pe
         d5fW2T6F/m6xHwoowWngheXhd2PC5VTjlx1SgBO3HubwGu9Mf1EW+RyFBeokTPFr/+dY
         VtxlBulHfKBSaaaBRHv8pxF7i6VKDGipF+nWJkHlZdjW7/dg8n8oylb7WeuJr8Ls4E1o
         DsBvaxEFZ1GxDqmjnnXLqCKeoPpo2UukQ/WFak0Wv9w6k0KdEb7/oJFZwn7kQvt3UB2w
         ktqb59upGZnNP+tca0RV0STwSxZZHfCd0ajj/LmTyx496Amgh29r9f7NRO/qbVBBTwUd
         edmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738780769; x=1739385569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncI8U9yeEkwYbqL+S/qfhrzFnBLh0LPVDRLpisjGJBU=;
        b=ZGJJA2v0uad00+ZDfmBvKcDOoAwBIkCV8gGMdn1tTHZuiUSI0SQ+ZnXO9/zaib2CTX
         BNOYQBO2KLzLck2jVDV5T7XUlBo1TDxKH7VU/gNsZd019iUV3tCZNNImGtBkcFL55XgJ
         5TflOsW2dPDCiOw0mhKOiDu5GcQRftYvewzAAVqoDQ1mMqHaxHvcewViY4j3P1u7ep9f
         4uhkZV1dzBQJvk6IlxmJo/sIsrGfHi9jv9E4gHEn0FV4onJbPwa/0EhCRqMYEyC0hnrC
         JqbPbEXLYkCv11nB+qBO8mcRyFPBOCVHMJ163YRQcZe2FkhkCbfZFH9oFybmxmoenuHw
         7Zqg==
X-Forwarded-Encrypted: i=1; AJvYcCUz97PyHpLEbUm4rQ/EVf3q448oKAgHQZOTCSJUJPofvUMiZbfYu5FtURpW7UEcFpCmYyOYGwJoxxrpC4jB@vger.kernel.org, AJvYcCXwTvgUklFsVfuWprXupWQZLQp38LXyae7IqCet937zVA4+m38CE0Pnc+1gWJ3c++tPWqAlySmpUhJ6iR8l@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6bkQz6ig20szc6E+p9rrI8nvNiAd2SKmLyXVQYrLO5k5JjGB
	r9lFjP4URCQIytU2+8KdKyMOfsAdJ6gfGh5adQQB0rkhGD4CdjXB
X-Gm-Gg: ASbGnctBR0DBXaa8rn9KmMhAoT0et6VSEBBfOXhJzvSodweP1szbzQV7EXHP1//gEci
	5MbRHTjd9cJvBuNwxo6TbX3wzl+aKe5QsF9GsM6X8LIFHoxtIB0g5GVEYxsoMpzjiwChEfEQSaO
	82KIhXWayOztyYroUMzvbWEgsokrhe6pfiUFl3uJS/RxQ9axsz0Zjj6GP/mA6QJRvhBjQ9um5nc
	3YddOhWrjW4D78Fb7Lmeye6V7jlQBtBULVEJ0UAxgIuE4VAqw1ut00Pxmlv4Qnms/gI3cQ/oSJH
	FwVZttzOzxu1raryyI3M6RUhTGGfJfU=
X-Google-Smtp-Source: AGHT+IFUX79gh897LiFZ5oLsZQzfpYQCYr9mg/iDGAhCxp40KKPRHLInG35yebegRSBQUO/oWVFvOQ==
X-Received: by 2002:a17:907:8689:b0:aae:ef24:888d with SMTP id a640c23a62f3a-ab75e34075dmr365966866b.55.1738780768710;
        Wed, 05 Feb 2025 10:39:28 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47d0fa3sm1134082266b.47.2025.02.05.10.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:39:28 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/3] vfs: add initial support for CONFIG_VFS_DEBUG
Date: Wed,  5 Feb 2025 19:38:37 +0100
Message-ID: <20250205183839.395081-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205183839.395081-1-mjguzik@gmail.com>
References: <20250205183839.395081-1-mjguzik@gmail.com>
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
 include/linux/fs.h       |  1 +
 include/linux/vfsdebug.h | 50 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |  9 ++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 include/linux/vfsdebug.h

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
index 000000000000..b1a2c776992a
--- /dev/null
+++ b/include/linux/vfsdebug.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_VFS_DEBUG_H
+#define LINUX_VFS_DEBUG_H 1
+
+#include <linux/bug.h>
+#include <linux/stringify.h>
+
+struct inode;
+
+#ifdef CONFIG_DEBUG_VFS
+/*
+ * TODO: add a proper inode dumping routine, this is a stub to get debug off the ground
+ */
+static inline void dump_inode(struct inode *inode, const char *reason) {
+	pr_crit("%s failed for inode %px", reason, inode);
+}
+#define VFS_BUG_ON(cond) BUG_ON(cond)
+#define VFS_WARN_ON(cond) (void)WARN_ON(cond)
+#define VFS_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
+#define VFS_WARN_ONCE(cond, format...) (void)WARN_ONCE(cond, format)
+#define VFS_WARN(cond, format...) (void)WARN(cond, format)
+
+#define VFS_BUG_ON_INODE(cond, inode)		({			\
+	if (unlikely(!!(cond))) {					\
+		dump_inode(inode, "VFS_BUG_ON_INODE(" __stringify(cond)")");\
+		BUG_ON(1);						\
+	}								\
+})
+
+#define VFS_WARN_ON_INODE(cond, inode)		({			\
+	int __ret_warn = !!(cond);					\
+									\
+	if (unlikely(__ret_warn)) {					\
+		dump_inode(inode, "VFS_WARN_ON_INODE(" __stringify(cond)")");\
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


