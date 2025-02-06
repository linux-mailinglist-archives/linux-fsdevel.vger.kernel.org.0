Return-Path: <linux-fsdevel+bounces-41099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F8A2AE75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CFB167BFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8487A22DFA4;
	Thu,  6 Feb 2025 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cixr7hAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB36238B60;
	Thu,  6 Feb 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861404; cv=none; b=jZP+9pHNyMVpXmHSWa2K5F4IReKxpq49HoVBsBIVFTgXLrhfzd51fyjyOP2EZM9hkycLD62AyDpnFh60Z5ZNURyBahoXda1wLb4p3OMTp9G+02xMWfjRJP9s/YeG3ELbx/QHYqLIB0WPJfNr9nSZsCS37Es62DLNd4BW1ChyXhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861404; c=relaxed/simple;
	bh=4G8n1qurah9/XX1SC2smoTLg2Y9foGcrGOVNXh1LxsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dS6NxNFhlAEW1klCsqrxIW8OwbxzRrw+Av5qpHQ0gyjF7qWtnpPD+s3mn6Qwc592y64ZOinNZQ7saywZGDrjuWmSEGnsnMcykNeTuZSPiDFo4VX3zORfqt6kfvQI6Gh0K28D7a1zHbG19iU4fMIB9175KdXyoOaRXsxm0Cdr8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cixr7hAa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a4f1so2441143a12.2;
        Thu, 06 Feb 2025 09:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738861401; x=1739466201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkZ4mmpYGy6ykhwXe8VklrwlkGdH0hD7/Bu+hQ/Ji0Q=;
        b=Cixr7hAaAw0gKfEKDBI2amrReyYsGAdso6egxmrcuTXw5G9QuZGEKG7x1ybFXhxPRt
         ntUHrlH3YFUPboGtVaAFpS2nm3xCK4h6QZ7sd9LylND9b4mUR+PB4nLjywlQ8IpK/Vsg
         8s9OyAw4fNzQZ5bpOLqm4hMLdYancK0HA4gcqn7IA1y9D0CW43ccT6mVDHAphRgQLIZU
         u/lq5EhmgTGwslX1rkTQq5bzIDnWY1Ac/ig2CiO50DI9tuDW9mX4nu2sF5a2LAsWGRLI
         lroAGEwhZhQ48TP6DZ6C5yXioygC1KeBpTS/OOUQUuxEXJa3LzLB0Lux0XjorCt9YcIC
         9SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861401; x=1739466201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkZ4mmpYGy6ykhwXe8VklrwlkGdH0hD7/Bu+hQ/Ji0Q=;
        b=t01Nc9Gq8Ozbc+nQsFbn33oBNRp2iaZWP+GRdxat69XEENKj8czrMqz9zBny+Gh2Pl
         FS8t7bLfr9o9z4eYU2ADW2fU7D/zIXzJgTBW8OS6DfGQkvXF3MPVWF5urX0OaYhgu4rw
         YW8EKYMBBeBf/an/r8MbS8wdeLdSuumD059pXsJ6QT1bQh6uA5RIBsEEts/9mUehw2pS
         4z9LF1oJwvVOMhB2kqk1MbVlqv8wy7CIEckjqdRMHO7RndO799GFH13VJ7HttmnR/oVe
         HNCKqthK7h46J+EOEpDCgafMc9UQIPAJzBOWmk5Yq/LZwrINQmrLCkujW3Y03AL2jWAW
         6W9g==
X-Forwarded-Encrypted: i=1; AJvYcCVDHzMKB901UrfB2a0YUICBWq1nxdUHrQEFUNm/HHWJptzKx7dcbAWQ+TJAYxGdCGvi7aKbi1ZOr10a5YdI@vger.kernel.org, AJvYcCXxN8TJnOc5qoSTmlzEeUvv+4DAdaHT/w4gsuyjs3afqujUl1Ok701UPctgFNHGF25I8Oz1Ls7coGMPLTOV@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeBNn3FbAKDwb81i8MrEdaqNCVi/CsNexkz5M29bycGLVBm3T
	5Y2OXPl3DHssTJsc+TcRlsE3q+4yzuKs3kHoYbvcJ5b5vzChSNqd
X-Gm-Gg: ASbGnctJ97ofoKPxpreSjexmB2pPYnVhiRczeO/ykr94Oab+4i7Gvno+cEGC5xNGPx5
	DkR1rtOyT4VLMnRhFaNlZcvPFqoitJm0/nvLcZqFJq67OleWihXt7JlTxGZKVSRo5td8cFX6THc
	FCkGikMpnDrfVS6hvS/HWAAMrUzaqgNyXVvu+m51fyGZaF5YsWBbMKjS1oWcA6vzqQjX6godAVB
	SSoiS3y+pBixSkSBRhmaDfevAHPIQpRhL5IaTvUT5ePjZB58zLS7rlkEcQIldm5wRBTdyNBxrCV
	pgaJbzu6GRYDFl/m/JRjimffpITbJLg=
X-Google-Smtp-Source: AGHT+IFM8acniUSaMumLoXI6jeGdM4syBvlj6OMz9GAtJJEkeaEku/dzNyqa4HgNItmqlH573bIXUA==
X-Received: by 2002:a05:6402:354b:b0:5dc:d0be:c348 with SMTP id 4fb4d7f45d1cf-5de45107542mr109822a12.20.1738861401131;
        Thu, 06 Feb 2025 09:03:21 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b73995sm1158110a12.7.2025.02.06.09.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:03:20 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/3] vfs: add initial support for CONFIG_VFS_DEBUG
Date: Thu,  6 Feb 2025 18:03:05 +0100
Message-ID: <20250206170307.451403-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206170307.451403-1-mjguzik@gmail.com>
References: <20250206170307.451403-1-mjguzik@gmail.com>
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
 include/linux/vfsdebug.h | 49 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |  9 ++++++++
 3 files changed, 59 insertions(+)
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
index 000000000000..c96dc589fa01
--- /dev/null
+++ b/include/linux/vfsdebug.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_VFS_DEBUG_H
+#define LINUX_VFS_DEBUG_H 1
+
+#include <linux/bug.h>
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


