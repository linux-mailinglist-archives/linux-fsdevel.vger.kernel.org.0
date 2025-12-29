Return-Path: <linux-fsdevel+bounces-72170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03513CE6B62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 13:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5E1E3009F2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2330FC3F;
	Mon, 29 Dec 2025 12:35:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE630FF23
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011747; cv=none; b=Ssxd+gQHsUIyqYxUhC06f3Z01UKIfib9GUv7sKt7ZjZAi328NpzLghNA6A9W5rVwYU0HOI0BjaIBRj4mSOGjfMpxRfMMSVvi3ZHfPbDviiylFU8WlxIlmJzqqYW7LfY6LbHQRXgEVKyEGUl+/uRg7cPFEZ294G3RjkxnSK5NQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011747; c=relaxed/simple;
	bh=J0whMQTVphA12jLiUAp6ocoM8RCqQHfMEm5ClwwPdWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3AFXEqH3wsCHODVwMmyBcCJGbCmtBLwU9tTKDvAcZqqcOrKdinbAaRwngtCz0x6hDPbVHQ+GefPO9XWctNxAJwpfIAveaBRqPO3dQ5HpY64rHBsWY7jy+wquvl7hYmTMvijYQWh64APUq48EKsiO1N09ADio8v6tV3aTfcNLmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-65d132240acso5086329eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 04:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767011743; x=1767616543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HP5712XjwmWEg71ucpb18kFhpeM549OaMp0Htkh7YU=;
        b=kGZH92+x6QLg336JZXrgyPPPzXaLCgfSDRmfMHGxOHUeJLIfC9UKhD2AGLv63CsUUT
         y5xQa6JA0eNUem/n2RvqCZqy5xtKyPkKRT5nXGZ5BdxetC1RyvDHNL7h6zCSEr9WBCJt
         0vkTY5QFK2bQOiD4h+1qX7kIm3iZCbQ2ffhkVuiLIatHNeuBIrvZihyN6hgVamQxings
         +hditBf0rvf/Ou+/0dNlXILRIx+bDlj6SAu8QxHaXalVxyd9FArIQ6ZxAAGV572MpjgK
         XuwBLlSrSw+6IrpQ8R/4NllJA5EggSvywr52mX8H5OohHIe2DDqmcx3cSck6VwC3C7a4
         PP9w==
X-Gm-Message-State: AOJu0Yx+5b7qPBiYfnJvLVjD7vHoCIN6fzwIYwfqGzDUvOcECZN4wePH
	XT3GzHQxJd7CWHgTvwYd6k96xJYQ4t1W30duG7L38qkxafRkAd+o1Pzg0rr+lQ==
X-Gm-Gg: AY/fxX5XU1203oi5tQFYx/oSgNgN9IScBUWldoo591c3/zy5O1os3ZtDH/88bQe4ntv
	yjIRghcEd5Oswk9Lg4q6c58jah0E0Nfrh8Fu/JTfrRXUNIzWpG4I8amgsmvRU1b0NZgebZaS3gg
	eSQD94U1OWUabCtWHa8CBRn3kkEW2tyvLR/KtrhB5xckfPUIo1ppxMy058dRhuuu/DO9sK2ZoeZ
	HHFP6GdI0lqYuyoKC/QWJVdC1H9rxkI3UBMQ1+yzQIIqLvRW6RYY4A/ujIX50hfbnLVGHKSRv2E
	9mGrlrAHYFgl8JlN/Fo7RnwKoMrCTxYOoA03gDPgPS6PnCJZCpdVk1mIokcQsjGgF1NfuqgbfNY
	uDOLxnoUw9OI6x4+pubRN2TmsU/gsH+q54bfbwYsyXsGb5S5v8ZyqZHQ/ozbecZ8d2tb+O3bvNl
	8RbhSBXszgesFj7EsA6rd31RWxTg==
X-Google-Smtp-Source: AGHT+IFGmJFeDh0CZGJ1o0n2gi9UNVVoSluJZFFvQ6V4jGQ5R/Yei75k1PYAbWNNjmy076uq88OJhw==
X-Received: by 2002:a05:6a00:800d:b0:7e8:43f5:bd4a with SMTP id d2e1a72fcca58-7ff67258d0bmr28063890b3a.54.1767006125703;
        Mon, 29 Dec 2025 03:02:05 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328basm29320722b3a.11.2025.12.29.03.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:02:04 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 11/14] ntfs: update misc operations
Date: Mon, 29 Dec 2025 19:59:29 +0900
Message-Id: <20251229105932.11360-12-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229105932.11360-1-linkinjeon@kernel.org>
References: <20251229105932.11360-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This updates the implementation of misc operations.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/collate.c | 106 +++++++++---
 fs/ntfs/debug.c   |  44 +++--
 fs/ntfs/logfile.c | 402 +++++++++++++++++++---------------------------
 fs/ntfs/quota.c   |  36 ++---
 fs/ntfs/sysctl.c  |  12 +-
 fs/ntfs/unistr.c  | 243 +++++++++++++++++++---------
 fs/ntfs/upcase.c  |  12 +-
 7 files changed, 471 insertions(+), 384 deletions(-)

diff --git a/fs/ntfs/collate.c b/fs/ntfs/collate.c
index 3ab6ec96abfe..2bde1ddceff1 100644
--- a/fs/ntfs/collate.c
+++ b/fs/ntfs/collate.c
@@ -1,15 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * collate.c - NTFS kernel collation handling.  Part of the Linux-NTFS project.
+ * NTFS kernel collation handling. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2004 Anton Altaparmakov
+ *
+ * Part of this file is based on code from the NTFS-3G project.
+ * and is copyrighted by the respective authors below:
+ * Copyright (c) 2004 Anton Altaparmakov
+ * Copyright (c) 2005 Yura Pakhuchiy
  */
 
 #include "collate.h"
 #include "debug.h"
 #include "ntfs.h"
 
-static int ntfs_collate_binary(ntfs_volume *vol,
+static int ntfs_collate_binary(struct ntfs_volume *vol,
 		const void *data1, const int data1_len,
 		const void *data2, const int data2_len)
 {
@@ -27,7 +32,7 @@ static int ntfs_collate_binary(ntfs_volume *vol,
 	return rc;
 }
 
-static int ntfs_collate_ntofs_ulong(ntfs_volume *vol,
+static int ntfs_collate_ntofs_ulong(struct ntfs_volume *vol,
 		const void *data1, const int data1_len,
 		const void *data2, const int data2_len)
 {
@@ -35,9 +40,10 @@ static int ntfs_collate_ntofs_ulong(ntfs_volume *vol,
 	u32 d1, d2;
 
 	ntfs_debug("Entering.");
-	// FIXME:  We don't really want to bug here.
-	BUG_ON(data1_len != data2_len);
-	BUG_ON(data1_len != 4);
+
+	if (data1_len != data2_len || data1_len != 4)
+		return -EINVAL;
+
 	d1 = le32_to_cpup(data1);
 	d2 = le32_to_cpup(data2);
 	if (d1 < d2)
@@ -52,12 +58,72 @@ static int ntfs_collate_ntofs_ulong(ntfs_volume *vol,
 	return rc;
 }
 
-typedef int (*ntfs_collate_func_t)(ntfs_volume *, const void *, const int,
+/**
+ * ntfs_collate_ntofs_ulongs - Which of two le32 arrays should be listed first
+ *
+ * Returns: -1, 0 or 1 depending of how the arrays compare
+ */
+static int ntfs_collate_ntofs_ulongs(struct ntfs_volume *vol,
+		const void *data1, const int data1_len,
+		const void *data2, const int data2_len)
+{
+	int rc;
+	int len;
+	const __le32 *p1, *p2;
+	u32 d1, d2;
+
+	ntfs_debug("Entering.");
+	if ((data1_len != data2_len) || (data1_len <= 0) || (data1_len & 3)) {
+		ntfs_error(vol->sb, "data1_len or data2_len not valid\n");
+		return -1;
+	}
+
+	p1 = (const __le32 *)data1;
+	p2 = (const __le32 *)data2;
+	len = data1_len;
+	do {
+		d1 = le32_to_cpup(p1);
+		p1++;
+		d2 = le32_to_cpup(p2);
+		p2++;
+	} while ((d1 == d2) && ((len -= 4) > 0));
+	if (d1 < d2)
+		rc = -1;
+	else {
+		if (d1 == d2)
+			rc = 0;
+		else
+			rc = 1;
+	}
+	ntfs_debug("Done, returning %i.", rc);
+	return rc;
+}
+
+/**
+ * ntfs_collate_file_name - Which of two filenames should be listed first
+ */
+static int ntfs_collate_file_name(struct ntfs_volume *vol,
+		const void *data1, const int __always_unused data1_len,
+		const void *data2, const int __always_unused data2_len)
+{
+	int rc;
+
+	ntfs_debug("Entering.\n");
+	rc = ntfs_file_compare_values(data1, data2, -2,
+			IGNORE_CASE, vol->upcase, vol->upcase_len);
+	if (!rc)
+		rc = ntfs_file_compare_values(data1, data2,
+			-2, CASE_SENSITIVE, vol->upcase, vol->upcase_len);
+	ntfs_debug("Done, returning %i.\n", rc);
+	return rc;
+}
+
+typedef int (*ntfs_collate_func_t)(struct ntfs_volume *, const void *, const int,
 		const void *, const int);
 
 static ntfs_collate_func_t ntfs_do_collate0x0[3] = {
 	ntfs_collate_binary,
-	NULL/*ntfs_collate_file_name*/,
+	ntfs_collate_file_name,
 	NULL/*ntfs_collate_unicode_string*/,
 };
 
@@ -65,7 +131,7 @@ static ntfs_collate_func_t ntfs_do_collate0x1[4] = {
 	ntfs_collate_ntofs_ulong,
 	NULL/*ntfs_collate_ntofs_sid*/,
 	NULL/*ntfs_collate_ntofs_security_hash*/,
-	NULL/*ntfs_collate_ntofs_ulongs*/,
+	ntfs_collate_ntofs_ulongs,
 };
 
 /**
@@ -84,27 +150,29 @@ static ntfs_collate_func_t ntfs_do_collate0x1[4] = {
  * For speed we use the collation rule @cr as an index into two tables of
  * function pointers to call the appropriate collation function.
  */
-int ntfs_collate(ntfs_volume *vol, COLLATION_RULE cr,
+int ntfs_collate(struct ntfs_volume *vol, __le32 cr,
 		const void *data1, const int data1_len,
-		const void *data2, const int data2_len) {
+		const void *data2, const int data2_len)
+{
 	int i;
 
 	ntfs_debug("Entering.");
-	/*
-	 * FIXME:  At the moment we only support COLLATION_BINARY and
-	 * COLLATION_NTOFS_ULONG, so we BUG() for everything else for now.
-	 */
-	BUG_ON(cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG);
+
+	if (cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG &&
+	    cr != COLLATION_FILE_NAME && cr != COLLATION_NTOFS_ULONGS)
+		return -EINVAL;
+
 	i = le32_to_cpu(cr);
-	BUG_ON(i < 0);
+	if (i < 0)
+		return -1;
 	if (i <= 0x02)
 		return ntfs_do_collate0x0[i](vol, data1, data1_len,
 				data2, data2_len);
-	BUG_ON(i < 0x10);
+	if (i < 0x10)
+		return -1;
 	i -= 0x10;
 	if (likely(i <= 3))
 		return ntfs_do_collate0x1[i](vol, data1, data1_len,
 				data2, data2_len);
-	BUG();
 	return 0;
 }
diff --git a/fs/ntfs/debug.c b/fs/ntfs/debug.c
index a3c1c5656f8f..5c63d22c2b98 100644
--- a/fs/ntfs/debug.c
+++ b/fs/ntfs/debug.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * debug.c - NTFS kernel debug support. Part of the Linux-NTFS project.
+ * NTFS kernel debug support. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2004 Anton Altaparmakov
  */
@@ -33,20 +33,24 @@ void __ntfs_warning(const char *function, const struct super_block *sb,
 	va_list args;
 	int flen = 0;
 
-#ifndef DEBUG
-	if (!printk_ratelimit())
-		return;
-#endif
 	if (function)
 		flen = strlen(function);
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
+#ifndef DEBUG
+	if (sb)
+		pr_warn_ratelimited("(device %s): %s(): %pV\n",
+			sb->s_id, flen ? function : "", &vaf);
+	else
+		pr_warn_ratelimited("%s(): %pV\n", flen ? function : "", &vaf);
+#else
 	if (sb)
 		pr_warn("(device %s): %s(): %pV\n",
 			sb->s_id, flen ? function : "", &vaf);
 	else
 		pr_warn("%s(): %pV\n", flen ? function : "", &vaf);
+#endif
 	va_end(args);
 }
 
@@ -69,34 +73,41 @@ void __ntfs_warning(const char *function, const struct super_block *sb,
  * Note, you should be using debug.h::ntfs_error(@sb, @fmt, @...) instead
  * as this provides the @function parameter automatically.
  */
-void __ntfs_error(const char *function, const struct super_block *sb,
+void __ntfs_error(const char *function, struct super_block *sb,
 		const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
 	int flen = 0;
 
-#ifndef DEBUG
-	if (!printk_ratelimit())
-		return;
-#endif
 	if (function)
 		flen = strlen(function);
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
+#ifndef DEBUG
+	if (sb)
+		pr_err_ratelimited("(device %s): %s(): %pV\n",
+		       sb->s_id, flen ? function : "", &vaf);
+	else
+		pr_err_ratelimited("%s(): %pV\n", flen ? function : "", &vaf);
+#else
 	if (sb)
 		pr_err("(device %s): %s(): %pV\n",
 		       sb->s_id, flen ? function : "", &vaf);
 	else
 		pr_err("%s(): %pV\n", flen ? function : "", &vaf);
+#endif
 	va_end(args);
+
+	if (sb)
+		ntfs_handle_error(sb);
 }
 
 #ifdef DEBUG
 
 /* If 1, output debug messages, and if 0, don't. */
-int debug_msgs = 0;
+int debug_msgs;
 
 void __ntfs_debug(const char *file, int line, const char *function,
 		const char *fmt, ...)
@@ -117,11 +128,12 @@ void __ntfs_debug(const char *file, int line, const char *function,
 }
 
 /* Dump a runlist. Caller has to provide synchronisation for @rl. */
-void ntfs_debug_dump_runlist(const runlist_element *rl)
+void ntfs_debug_dump_runlist(const struct runlist_element *rl)
 {
 	int i;
-	const char *lcn_str[5] = { "LCN_HOLE         ", "LCN_RL_NOT_MAPPED",
-				   "LCN_ENOENT       ", "LCN_unknown      " };
+	const char *lcn_str[5] = { "LCN_DELALLOC     ", "LCN_HOLE         ",
+				   "LCN_RL_NOT_MAPPED", "LCN_ENOENT       ",
+				   "LCN_unknown      " };
 
 	if (!debug_msgs)
 		return;
@@ -132,9 +144,9 @@ void ntfs_debug_dump_runlist(const runlist_element *rl)
 	}
 	pr_debug("VCN              LCN               Run length\n");
 	for (i = 0; ; i++) {
-		LCN lcn = (rl + i)->lcn;
+		s64 lcn = (rl + i)->lcn;
 
-		if (lcn < (LCN)0) {
+		if (lcn < 0) {
 			int index = -lcn - 1;
 
 			if (index > -LCN_ENOENT - 1)
diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index 6ce60ffc6ac0..31b3de595459 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -1,31 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * logfile.c - NTFS kernel journal handling. Part of the Linux-NTFS project.
+ * NTFS kernel journal handling. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2002-2007 Anton Altaparmakov
  */
 
-#ifdef NTFS_RW
-
-#include <linux/types.h>
-#include <linux/fs.h>
-#include <linux/highmem.h>
-#include <linux/buffer_head.h>
-#include <linux/bitops.h>
-#include <linux/log2.h>
 #include <linux/bio.h>
 
 #include "attrib.h"
 #include "aops.h"
-#include "debug.h"
 #include "logfile.h"
 #include "malloc.h"
-#include "volume.h"
 #include "ntfs.h"
 
 /**
  * ntfs_check_restart_page_header - check the page header for consistency
- * @vi:		$LogFile inode to which the restart page header belongs
+ * @vi:		LogFile inode to which the restart page header belongs
  * @rp:		restart page header to check
  * @pos:	position in @vi at which the restart page header resides
  *
@@ -36,7 +26,7 @@
  * require the full restart page.
  */
 static bool ntfs_check_restart_page_header(struct inode *vi,
-		RESTART_PAGE_HEADER *rp, s64 pos)
+		struct restart_page_header *rp, s64 pos)
 {
 	u32 logfile_system_page_size, logfile_log_page_size;
 	u16 ra_ofs, usa_count, usa_ofs, usa_end = 0;
@@ -54,7 +44,7 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 			logfile_system_page_size &
 			(logfile_system_page_size - 1) ||
 			!is_power_of_2(logfile_log_page_size)) {
-		ntfs_error(vi->i_sb, "$LogFile uses unsupported page size.");
+		ntfs_error(vi->i_sb, "LogFile uses unsupported page size.");
 		return false;
 	}
 	/*
@@ -62,17 +52,16 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 	 * size (2nd restart page).
 	 */
 	if (pos && pos != logfile_system_page_size) {
-		ntfs_error(vi->i_sb, "Found restart area in incorrect "
-				"position in $LogFile.");
+		ntfs_error(vi->i_sb, "Found restart area in incorrect position in LogFile.");
 		return false;
 	}
 	/* We only know how to handle version 1.1. */
-	if (sle16_to_cpu(rp->major_ver) != 1 ||
-			sle16_to_cpu(rp->minor_ver) != 1) {
-		ntfs_error(vi->i_sb, "$LogFile version %i.%i is not "
-				"supported.  (This driver supports version "
-				"1.1 only.)", (int)sle16_to_cpu(rp->major_ver),
-				(int)sle16_to_cpu(rp->minor_ver));
+	if (le16_to_cpu(rp->major_ver) != 1 ||
+	    le16_to_cpu(rp->minor_ver) != 1) {
+		ntfs_error(vi->i_sb,
+			"LogFile version %i.%i is not supported.  (This driver supports version 1.1 only.)",
+			(int)le16_to_cpu(rp->major_ver),
+			(int)le16_to_cpu(rp->minor_ver));
 		return false;
 	}
 	/*
@@ -86,17 +75,17 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 	/* Verify the size of the update sequence array. */
 	usa_count = 1 + (logfile_system_page_size >> NTFS_BLOCK_SIZE_BITS);
 	if (usa_count != le16_to_cpu(rp->usa_count)) {
-		ntfs_error(vi->i_sb, "$LogFile restart page specifies "
-				"inconsistent update sequence array count.");
+		ntfs_error(vi->i_sb,
+			"LogFile restart page specifies inconsistent update sequence array count.");
 		return false;
 	}
 	/* Verify the position of the update sequence array. */
 	usa_ofs = le16_to_cpu(rp->usa_ofs);
 	usa_end = usa_ofs + usa_count * sizeof(u16);
-	if (usa_ofs < sizeof(RESTART_PAGE_HEADER) ||
+	if (usa_ofs < sizeof(struct restart_page_header) ||
 			usa_end > NTFS_BLOCK_SIZE - sizeof(u16)) {
-		ntfs_error(vi->i_sb, "$LogFile restart page specifies "
-				"inconsistent update sequence array offset.");
+		ntfs_error(vi->i_sb,
+			"LogFile restart page specifies inconsistent update sequence array offset.");
 		return false;
 	}
 skip_usa_checks:
@@ -108,19 +97,19 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 	 */
 	ra_ofs = le16_to_cpu(rp->restart_area_offset);
 	if (ra_ofs & 7 || (have_usa ? ra_ofs < usa_end :
-			ra_ofs < sizeof(RESTART_PAGE_HEADER)) ||
+			ra_ofs < sizeof(struct restart_page_header)) ||
 			ra_ofs > logfile_system_page_size) {
-		ntfs_error(vi->i_sb, "$LogFile restart page specifies "
-				"inconsistent restart area offset.");
+		ntfs_error(vi->i_sb,
+			"LogFile restart page specifies inconsistent restart area offset.");
 		return false;
 	}
 	/*
 	 * Only restart pages modified by chkdsk are allowed to have chkdsk_lsn
 	 * set.
 	 */
-	if (!ntfs_is_chkd_record(rp->magic) && sle64_to_cpu(rp->chkdsk_lsn)) {
-		ntfs_error(vi->i_sb, "$LogFile restart page is not modified "
-				"by chkdsk but a chkdsk LSN is specified.");
+	if (!ntfs_is_chkd_record(rp->magic) && le64_to_cpu(rp->chkdsk_lsn)) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart page is not modified by chkdsk but a chkdsk LSN is specified.");
 		return false;
 	}
 	ntfs_debug("Done.");
@@ -129,7 +118,7 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 
 /**
  * ntfs_check_restart_area - check the restart area for consistency
- * @vi:		$LogFile inode to which the restart page belongs
+ * @vi:		LogFile inode to which the restart page belongs
  * @rp:		restart page whose restart area to check
  *
  * Check the restart area of the restart page @rp for consistency and return
@@ -141,25 +130,25 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
  * This function only needs NTFS_BLOCK_SIZE bytes in @rp, i.e. it does not
  * require the full restart page.
  */
-static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
+static bool ntfs_check_restart_area(struct inode *vi, struct restart_page_header *rp)
 {
 	u64 file_size;
-	RESTART_AREA *ra;
+	struct restart_area *ra;
 	u16 ra_ofs, ra_len, ca_ofs;
 	u8 fs_bits;
 
 	ntfs_debug("Entering.");
 	ra_ofs = le16_to_cpu(rp->restart_area_offset);
-	ra = (RESTART_AREA*)((u8*)rp + ra_ofs);
+	ra = (struct restart_area *)((u8 *)rp + ra_ofs);
 	/*
 	 * Everything before ra->file_size must be before the first word
 	 * protected by an update sequence number.  This ensures that it is
 	 * safe to access ra->client_array_offset.
 	 */
-	if (ra_ofs + offsetof(RESTART_AREA, file_size) >
+	if (ra_ofs + offsetof(struct restart_area, file_size) >
 			NTFS_BLOCK_SIZE - sizeof(u16)) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
-				"inconsistent file offset.");
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies inconsistent file offset.");
 		return false;
 	}
 	/*
@@ -172,8 +161,8 @@ static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
 	ca_ofs = le16_to_cpu(ra->client_array_offset);
 	if (((ca_ofs + 7) & ~7) != ca_ofs ||
 			ra_ofs + ca_ofs > NTFS_BLOCK_SIZE - sizeof(u16)) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
-				"inconsistent client array offset.");
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies inconsistent client array offset.");
 		return false;
 	}
 	/*
@@ -182,15 +171,13 @@ static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
 	 * Also, the calculated length must not exceed the specified length.
 	 */
 	ra_len = ca_ofs + le16_to_cpu(ra->log_clients) *
-			sizeof(LOG_CLIENT_RECORD);
+			sizeof(struct log_client_record);
 	if (ra_ofs + ra_len > le32_to_cpu(rp->system_page_size) ||
 			ra_ofs + le16_to_cpu(ra->restart_area_length) >
 			le32_to_cpu(rp->system_page_size) ||
 			ra_len > le16_to_cpu(ra->restart_area_length)) {
-		ntfs_error(vi->i_sb, "$LogFile restart area is out of bounds "
-				"of the system page size specified by the "
-				"restart page header and/or the specified "
-				"restart area length is inconsistent.");
+		ntfs_error(vi->i_sb,
+			"LogFile restart area is out of bounds of the system page size specified by the restart page header and/or the specified restart area length is inconsistent.");
 		return false;
 	}
 	/*
@@ -204,37 +191,37 @@ static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
 			(ra->client_in_use_list != LOGFILE_NO_CLIENT &&
 			le16_to_cpu(ra->client_in_use_list) >=
 			le16_to_cpu(ra->log_clients))) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
-				"overflowing client free and/or in use lists.");
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies overflowing client free and/or in use lists.");
 		return false;
 	}
 	/*
 	 * Check ra->seq_number_bits against ra->file_size for consistency.
 	 * We cannot just use ffs() because the file size is not a power of 2.
 	 */
-	file_size = (u64)sle64_to_cpu(ra->file_size);
+	file_size = le64_to_cpu(ra->file_size);
 	fs_bits = 0;
 	while (file_size) {
 		file_size >>= 1;
 		fs_bits++;
 	}
 	if (le32_to_cpu(ra->seq_number_bits) != 67 - fs_bits) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
-				"inconsistent sequence number bits.");
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies inconsistent sequence number bits.");
 		return false;
 	}
 	/* The log record header length must be a multiple of 8. */
 	if (((le16_to_cpu(ra->log_record_header_length) + 7) & ~7) !=
 			le16_to_cpu(ra->log_record_header_length)) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
-				"inconsistent log record header length.");
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies inconsistent log record header length.");
 		return false;
 	}
 	/* Dito for the log page data offset. */
 	if (((le16_to_cpu(ra->log_page_data_offset) + 7) & ~7) !=
 			le16_to_cpu(ra->log_page_data_offset)) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
-				"inconsistent log page data offset.");
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies inconsistent log page data offset.");
 		return false;
 	}
 	ntfs_debug("Done.");
@@ -243,7 +230,7 @@ static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
 
 /**
  * ntfs_check_log_client_array - check the log client array for consistency
- * @vi:		$LogFile inode to which the restart page belongs
+ * @vi:		LogFile inode to which the restart page belongs
  * @rp:		restart page whose log client array to check
  *
  * Check the log client array of the restart page @rp for consistency and
@@ -257,16 +244,16 @@ static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
  * restart page and the page must be multi sector transfer deprotected.
  */
 static bool ntfs_check_log_client_array(struct inode *vi,
-		RESTART_PAGE_HEADER *rp)
+		struct restart_page_header *rp)
 {
-	RESTART_AREA *ra;
-	LOG_CLIENT_RECORD *ca, *cr;
+	struct restart_area *ra;
+	struct log_client_record *ca, *cr;
 	u16 nr_clients, idx;
 	bool in_free_list, idx_is_first;
 
 	ntfs_debug("Entering.");
-	ra = (RESTART_AREA*)((u8*)rp + le16_to_cpu(rp->restart_area_offset));
-	ca = (LOG_CLIENT_RECORD*)((u8*)ra +
+	ra = (struct restart_area *)((u8 *)rp + le16_to_cpu(rp->restart_area_offset));
+	ca = (struct log_client_record *)((u8 *)ra +
 			le16_to_cpu(ra->client_array_offset));
 	/*
 	 * Check the ra->client_free_list first and then check the
@@ -302,13 +289,13 @@ static bool ntfs_check_log_client_array(struct inode *vi,
 	ntfs_debug("Done.");
 	return true;
 err_out:
-	ntfs_error(vi->i_sb, "$LogFile log client array is corrupt.");
+	ntfs_error(vi->i_sb, "LogFile log client array is corrupt.");
 	return false;
 }
 
 /**
  * ntfs_check_and_load_restart_page - check the restart page for consistency
- * @vi:		$LogFile inode to which the restart page belongs
+ * @vi:		LogFile inode to which the restart page belongs
  * @rp:		restart page to check
  * @pos:	position in @vi at which the restart page resides
  * @wrp:	[OUT] copy of the multi sector transfer deprotected restart page
@@ -331,14 +318,14 @@ static bool ntfs_check_log_client_array(struct inode *vi,
  * The following error codes are defined:
  *	-EINVAL	- The restart page is inconsistent.
  *	-ENOMEM	- Not enough memory to load the restart page.
- *	-EIO	- Failed to reading from $LogFile.
+ *	-EIO	- Failed to reading from LogFile.
  */
 static int ntfs_check_and_load_restart_page(struct inode *vi,
-		RESTART_PAGE_HEADER *rp, s64 pos, RESTART_PAGE_HEADER **wrp,
-		LSN *lsn)
+		struct restart_page_header *rp, s64 pos, struct restart_page_header **wrp,
+		s64 *lsn)
 {
-	RESTART_AREA *ra;
-	RESTART_PAGE_HEADER *trp;
+	struct restart_area *ra;
+	struct restart_page_header *trp;
 	int size, err;
 
 	ntfs_debug("Entering.");
@@ -352,15 +339,14 @@ static int ntfs_check_and_load_restart_page(struct inode *vi,
 		/* Error output already done inside the function. */
 		return -EINVAL;
 	}
-	ra = (RESTART_AREA*)((u8*)rp + le16_to_cpu(rp->restart_area_offset));
+	ra = (struct restart_area *)((u8 *)rp + le16_to_cpu(rp->restart_area_offset));
 	/*
 	 * Allocate a buffer to store the whole restart page so we can multi
 	 * sector transfer deprotect it.
 	 */
 	trp = ntfs_malloc_nofs(le32_to_cpu(rp->system_page_size));
 	if (!trp) {
-		ntfs_error(vi->i_sb, "Failed to allocate memory for $LogFile "
-				"restart page buffer.");
+		ntfs_error(vi->i_sb, "Failed to allocate memory for LogFile restart page buffer.");
 		return -ENOMEM;
 	}
 	/*
@@ -373,7 +359,7 @@ static int ntfs_check_and_load_restart_page(struct inode *vi,
 		memcpy(trp, rp, le32_to_cpu(rp->system_page_size));
 	} else {
 		pgoff_t idx;
-		struct page *page;
+		struct folio *folio;
 		int have_read, to_read;
 
 		/* First copy what we already have in @rp. */
@@ -382,20 +368,19 @@ static int ntfs_check_and_load_restart_page(struct inode *vi,
 		have_read = size;
 		to_read = le32_to_cpu(rp->system_page_size) - size;
 		idx = (pos + size) >> PAGE_SHIFT;
-		BUG_ON((pos + size) & ~PAGE_MASK);
 		do {
-			page = ntfs_map_page(vi->i_mapping, idx);
-			if (IS_ERR(page)) {
-				ntfs_error(vi->i_sb, "Error mapping $LogFile "
-						"page (index %lu).", idx);
-				err = PTR_ERR(page);
+			folio = read_mapping_folio(vi->i_mapping, idx, NULL);
+			if (IS_ERR(folio)) {
+				ntfs_error(vi->i_sb, "Error mapping LogFile page (index %lu).",
+						idx);
+				err = PTR_ERR(folio);
 				if (err != -EIO && err != -ENOMEM)
 					err = -EIO;
 				goto err_out;
 			}
 			size = min_t(int, to_read, PAGE_SIZE);
-			memcpy((u8*)trp + have_read, page_address(page), size);
-			ntfs_unmap_page(page);
+			memcpy((u8 *)trp + have_read, folio_address(folio), size);
+			folio_put(folio);
 			have_read += size;
 			to_read -= size;
 			idx++;
@@ -405,19 +390,18 @@ static int ntfs_check_and_load_restart_page(struct inode *vi,
 	 * Perform the multi sector transfer deprotection on the buffer if the
 	 * restart page is protected.
 	 */
-	if ((!ntfs_is_chkd_record(trp->magic) || le16_to_cpu(trp->usa_count))
-			&& post_read_mst_fixup((NTFS_RECORD*)trp,
-			le32_to_cpu(rp->system_page_size))) {
+	if ((!ntfs_is_chkd_record(trp->magic) || le16_to_cpu(trp->usa_count)) &&
+	    post_read_mst_fixup((struct ntfs_record *)trp, le32_to_cpu(rp->system_page_size))) {
 		/*
-		 * A multi sector tranfer error was detected.  We only need to
+		 * A multi sector transfer error was detected.  We only need to
 		 * abort if the restart page contents exceed the multi sector
 		 * transfer fixup of the first sector.
 		 */
 		if (le16_to_cpu(rp->restart_area_offset) +
 				le16_to_cpu(ra->restart_area_length) >
 				NTFS_BLOCK_SIZE - sizeof(u16)) {
-			ntfs_error(vi->i_sb, "Multi sector transfer error "
-					"detected in $LogFile restart page.");
+			ntfs_error(vi->i_sb,
+				"Multi sector transfer error detected in LogFile restart page.");
 			err = -EINVAL;
 			goto err_out;
 		}
@@ -437,9 +421,9 @@ static int ntfs_check_and_load_restart_page(struct inode *vi,
 	}
 	if (lsn) {
 		if (ntfs_is_rstr_record(rp->magic))
-			*lsn = sle64_to_cpu(ra->current_lsn);
+			*lsn = le64_to_cpu(ra->current_lsn);
 		else /* if (ntfs_is_chkd_record(rp->magic)) */
-			*lsn = sle64_to_cpu(rp->chkdsk_lsn);
+			*lsn = le64_to_cpu(rp->chkdsk_lsn);
 	}
 	ntfs_debug("Done.");
 	if (wrp)
@@ -453,37 +437,37 @@ static int ntfs_check_and_load_restart_page(struct inode *vi,
 
 /**
  * ntfs_check_logfile - check the journal for consistency
- * @log_vi:	struct inode of loaded journal $LogFile to check
+ * @log_vi:	struct inode of loaded journal LogFile to check
  * @rp:		[OUT] on success this is a copy of the current restart page
  *
- * Check the $LogFile journal for consistency and return 'true' if it is
+ * Check the LogFile journal for consistency and return 'true' if it is
  * consistent and 'false' if not.  On success, the current restart page is
  * returned in *@rp.  Caller must call ntfs_free(*@rp) when finished with it.
  *
  * At present we only check the two restart pages and ignore the log record
  * pages.
  *
- * Note that the MstProtected flag is not set on the $LogFile inode and hence
+ * Note that the MstProtected flag is not set on the LogFile inode and hence
  * when reading pages they are not deprotected.  This is because we do not know
- * if the $LogFile was created on a system with a different page size to ours
+ * if the LogFile was created on a system with a different page size to ours
  * yet and mst deprotection would fail if our page size is smaller.
  */
-bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
+bool ntfs_check_logfile(struct inode *log_vi, struct restart_page_header **rp)
 {
 	s64 size, pos;
-	LSN rstr1_lsn, rstr2_lsn;
-	ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
+	s64 rstr1_lsn, rstr2_lsn;
+	struct ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
 	struct address_space *mapping = log_vi->i_mapping;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	u8 *kaddr = NULL;
-	RESTART_PAGE_HEADER *rstr1_ph = NULL;
-	RESTART_PAGE_HEADER *rstr2_ph = NULL;
+	struct restart_page_header *rstr1_ph = NULL;
+	struct restart_page_header *rstr2_ph = NULL;
 	int log_page_size, err;
 	bool logfile_is_empty = true;
 	u8 log_page_bits;
 
 	ntfs_debug("Entering.");
-	/* An empty $LogFile must have been clean before it got emptied. */
+	/* An empty LogFile must have been clean before it got emptied. */
 	if (NVolLogFileEmpty(vol))
 		goto is_empty;
 	size = i_size_read(log_vi);
@@ -496,8 +480,8 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 	 * log page size if the page cache size is between the default log page
 	 * size and twice that.
 	 */
-	if (PAGE_SIZE >= DefaultLogPageSize && PAGE_SIZE <=
-			DefaultLogPageSize * 2)
+	if (DefaultLogPageSize <= PAGE_SIZE &&
+	    DefaultLogPageSize * 2 <= PAGE_SIZE)
 		log_page_size = DefaultLogPageSize;
 	else
 		log_page_size = PAGE_SIZE;
@@ -513,7 +497,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 	 */
 	if (size < log_page_size * 2 || (size - log_page_size * 2) >>
 			log_page_bits < MinLogRecordPages) {
-		ntfs_error(vol->sb, "$LogFile is too small.");
+		ntfs_error(vol->sb, "LogFile is too small.");
 		return false;
 	}
 	/*
@@ -526,23 +510,26 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 	 */
 	for (pos = 0; pos < size; pos <<= 1) {
 		pgoff_t idx = pos >> PAGE_SHIFT;
-		if (!page || page->index != idx) {
-			if (page)
-				ntfs_unmap_page(page);
-			page = ntfs_map_page(mapping, idx);
-			if (IS_ERR(page)) {
-				ntfs_error(vol->sb, "Error mapping $LogFile "
-						"page (index %lu).", idx);
+
+		if (!folio || folio->index != idx) {
+			if (folio) {
+				kunmap_local(kaddr);
+				folio_put(folio);
+			}
+			folio = read_mapping_folio(mapping, idx, NULL);
+			if (IS_ERR(folio)) {
+				ntfs_error(vol->sb, "Error mapping LogFile page (index %lu).",
+						idx);
 				goto err_out;
 			}
 		}
-		kaddr = (u8*)page_address(page) + (pos & ~PAGE_MASK);
+		kaddr = (u8 *)kmap_local_folio(folio, 0) + (pos & ~PAGE_MASK);
 		/*
 		 * A non-empty block means the logfile is not empty while an
 		 * empty block after a non-empty block has been encountered
 		 * means we are done.
 		 */
-		if (!ntfs_is_empty_recordp((le32*)kaddr))
+		if (!ntfs_is_empty_recordp((__le32 *)kaddr))
 			logfile_is_empty = false;
 		else if (!logfile_is_empty)
 			break;
@@ -550,11 +537,11 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 		 * A log record page means there cannot be a restart page after
 		 * this so no need to continue searching.
 		 */
-		if (ntfs_is_rcrd_recordp((le32*)kaddr))
+		if (ntfs_is_rcrd_recordp((__le32 *)kaddr))
 			break;
 		/* If not a (modified by chkdsk) restart page, continue. */
-		if (!ntfs_is_rstr_recordp((le32*)kaddr) &&
-				!ntfs_is_chkd_recordp((le32*)kaddr)) {
+		if (!ntfs_is_rstr_recordp((__le32 *)kaddr) &&
+				!ntfs_is_chkd_recordp((__le32 *)kaddr)) {
 			if (!pos)
 				pos = NTFS_BLOCK_SIZE >> 1;
 			continue;
@@ -565,7 +552,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 		 * deprotected restart page.
 		 */
 		err = ntfs_check_and_load_restart_page(log_vi,
-				(RESTART_PAGE_HEADER*)kaddr, pos,
+				(struct restart_page_header *)kaddr, pos,
 				!rstr1_ph ? &rstr1_ph : &rstr2_ph,
 				!rstr1_ph ? &rstr1_lsn : &rstr2_lsn);
 		if (!err) {
@@ -589,25 +576,27 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 		 * find a valid one further in the file.
 		 */
 		if (err != -EINVAL) {
-			ntfs_unmap_page(page);
+			kunmap_local(kaddr);
+			folio_put(folio);
 			goto err_out;
 		}
 		/* Continue looking. */
 		if (!pos)
 			pos = NTFS_BLOCK_SIZE >> 1;
 	}
-	if (page)
-		ntfs_unmap_page(page);
+	if (folio) {
+		kunmap_local(kaddr);
+		folio_put(folio);
+	}
 	if (logfile_is_empty) {
 		NVolSetLogFileEmpty(vol);
 is_empty:
-		ntfs_debug("Done.  ($LogFile is empty.)");
+		ntfs_debug("Done.  (LogFile is empty.)");
 		return true;
 	}
 	if (!rstr1_ph) {
-		BUG_ON(rstr2_ph);
-		ntfs_error(vol->sb, "Did not find any restart pages in "
-				"$LogFile and it was not empty.");
+		ntfs_error(vol->sb,
+			"Did not find any restart pages in LogFile and it was not empty.");
 		return false;
 	}
 	/* If both restart pages were found, use the more recent one. */
@@ -617,14 +606,12 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 		 * Otherwise just throw it away.
 		 */
 		if (rstr2_lsn > rstr1_lsn) {
-			ntfs_debug("Using second restart page as it is more "
-					"recent.");
+			ntfs_debug("Using second restart page as it is more recent.");
 			ntfs_free(rstr1_ph);
 			rstr1_ph = rstr2_ph;
 			/* rstr1_lsn = rstr2_lsn; */
 		} else {
-			ntfs_debug("Using first restart page as it is more "
-					"recent.");
+			ntfs_debug("Using first restart page as it is more recent.");
 			ntfs_free(rstr2_ph);
 		}
 		rstr2_ph = NULL;
@@ -643,98 +630,42 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 }
 
 /**
- * ntfs_is_logfile_clean - check in the journal if the volume is clean
- * @log_vi:	struct inode of loaded journal $LogFile to check
- * @rp:		copy of the current restart page
- *
- * Analyze the $LogFile journal and return 'true' if it indicates the volume was
- * shutdown cleanly and 'false' if not.
- *
- * At present we only look at the two restart pages and ignore the log record
- * pages.  This is a little bit crude in that there will be a very small number
- * of cases where we think that a volume is dirty when in fact it is clean.
- * This should only affect volumes that have not been shutdown cleanly but did
- * not have any pending, non-check-pointed i/o, i.e. they were completely idle
- * at least for the five seconds preceding the unclean shutdown.
- *
- * This function assumes that the $LogFile journal has already been consistency
- * checked by a call to ntfs_check_logfile() and in particular if the $LogFile
- * is empty this function requires that NVolLogFileEmpty() is true otherwise an
- * empty volume will be reported as dirty.
- */
-bool ntfs_is_logfile_clean(struct inode *log_vi, const RESTART_PAGE_HEADER *rp)
-{
-	ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
-	RESTART_AREA *ra;
-
-	ntfs_debug("Entering.");
-	/* An empty $LogFile must have been clean before it got emptied. */
-	if (NVolLogFileEmpty(vol)) {
-		ntfs_debug("Done.  ($LogFile is empty.)");
-		return true;
-	}
-	BUG_ON(!rp);
-	if (!ntfs_is_rstr_record(rp->magic) &&
-			!ntfs_is_chkd_record(rp->magic)) {
-		ntfs_error(vol->sb, "Restart page buffer is invalid.  This is "
-				"probably a bug in that the $LogFile should "
-				"have been consistency checked before calling "
-				"this function.");
-		return false;
-	}
-	ra = (RESTART_AREA*)((u8*)rp + le16_to_cpu(rp->restart_area_offset));
-	/*
-	 * If the $LogFile has active clients, i.e. it is open, and we do not
-	 * have the RESTART_VOLUME_IS_CLEAN bit set in the restart area flags,
-	 * we assume there was an unclean shutdown.
-	 */
-	if (ra->client_in_use_list != LOGFILE_NO_CLIENT &&
-			!(ra->flags & RESTART_VOLUME_IS_CLEAN)) {
-		ntfs_debug("Done.  $LogFile indicates a dirty shutdown.");
-		return false;
-	}
-	/* $LogFile indicates a clean shutdown. */
-	ntfs_debug("Done.  $LogFile indicates a clean shutdown.");
-	return true;
-}
-
-/**
- * ntfs_empty_logfile - empty the contents of the $LogFile journal
- * @log_vi:	struct inode of loaded journal $LogFile to empty
+ * ntfs_empty_logfile - empty the contents of the LogFile journal
+ * @log_vi:	struct inode of loaded journal LogFile to empty
  *
- * Empty the contents of the $LogFile journal @log_vi and return 'true' on
+ * Empty the contents of the LogFile journal @log_vi and return 'true' on
  * success and 'false' on error.
  *
- * This function assumes that the $LogFile journal has already been consistency
+ * This function assumes that the LogFile journal has already been consistency
  * checked by a call to ntfs_check_logfile() and that ntfs_is_logfile_clean()
- * has been used to ensure that the $LogFile is clean.
+ * has been used to ensure that the LogFile is clean.
  */
 bool ntfs_empty_logfile(struct inode *log_vi)
 {
-	VCN vcn, end_vcn;
-	ntfs_inode *log_ni = NTFS_I(log_vi);
-	ntfs_volume *vol = log_ni->vol;
+	s64 vcn, end_vcn;
+	struct ntfs_inode *log_ni = NTFS_I(log_vi);
+	struct ntfs_volume *vol = log_ni->vol;
 	struct super_block *sb = vol->sb;
-	runlist_element *rl;
+	struct runlist_element *rl;
 	unsigned long flags;
-	unsigned block_size, block_size_bits;
 	int err;
 	bool should_wait = true;
+	char *empty_buf = NULL;
+	struct file_ra_state *ra = NULL;
 
 	ntfs_debug("Entering.");
 	if (NVolLogFileEmpty(vol)) {
 		ntfs_debug("Done.");
 		return true;
 	}
+
 	/*
 	 * We cannot use ntfs_attr_set() because we may be still in the middle
 	 * of a mount operation.  Thus we do the emptying by hand by first
-	 * zapping the page cache pages for the $LogFile/$DATA attribute and
+	 * zapping the page cache pages for the LogFile/DATA attribute and
 	 * then emptying each of the buffers in each of the clusters specified
 	 * by the runlist by hand.
 	 */
-	block_size = sb->s_blocksize;
-	block_size_bits = sb->s_blocksize_bits;
 	vcn = 0;
 	read_lock_irqsave(&log_ni->size_lock, flags);
 	end_vcn = (log_ni->initialized_size + vol->cluster_size_mask) >>
@@ -747,19 +678,30 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 map_vcn:
 		err = ntfs_map_runlist_nolock(log_ni, vcn, NULL);
 		if (err) {
-			ntfs_error(sb, "Failed to map runlist fragment (error "
-					"%d).", -err);
+			ntfs_error(sb, "Failed to map runlist fragment (error %d).", -err);
 			goto err;
 		}
 		rl = log_ni->runlist.rl;
-		BUG_ON(!rl || vcn < rl->vcn || !rl->length);
 	}
 	/* Seek to the runlist element containing @vcn. */
 	while (rl->length && vcn >= rl[1].vcn)
 		rl++;
+
+	err = -ENOMEM;
+	empty_buf = ntfs_malloc_nofs(vol->cluster_size);
+	if (!empty_buf)
+		goto err;
+
+	memset(empty_buf, 0xff, vol->cluster_size);
+
+	ra = kzalloc(sizeof(*ra), GFP_NOFS);
+	if (!ra)
+		goto err;
+
+	file_ra_state_init(ra, sb->s_bdev->bd_mapping);
 	do {
-		LCN lcn;
-		sector_t block, end_block;
+		s64 lcn;
+		loff_t start, end;
 		s64 len;
 
 		/*
@@ -769,6 +711,7 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 		lcn = rl->lcn;
 		if (unlikely(lcn == LCN_RL_NOT_MAPPED)) {
 			vcn = rl->vcn;
+			ntfs_free(empty_buf);
 			goto map_vcn;
 		}
 		/* If this run is not valid abort with an error. */
@@ -777,29 +720,23 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 		/* Skip holes. */
 		if (lcn == LCN_HOLE)
 			continue;
-		block = lcn << vol->cluster_size_bits >> block_size_bits;
+		start = NTFS_CLU_TO_B(vol, lcn);
 		len = rl->length;
 		if (rl[1].vcn > end_vcn)
 			len = end_vcn - rl->vcn;
-		end_block = (lcn + len) << vol->cluster_size_bits >>
-				block_size_bits;
-		/* Iterate over the blocks in the run and empty them. */
+		end = NTFS_CLU_TO_B(vol, lcn + len);
+
+		page_cache_sync_readahead(sb->s_bdev->bd_mapping, ra, NULL,
+			start >> PAGE_SHIFT, (end - start) >> PAGE_SHIFT);
+
 		do {
-			struct buffer_head *bh;
+			err = ntfs_dev_write(sb, empty_buf, start,
+						  vol->cluster_size, should_wait);
+			if (err) {
+				ntfs_error(sb, "ntfs_dev_write failed, err : %d\n", err);
+				goto io_err;
+			}
 
-			/* Obtain the buffer, possibly not uptodate. */
-			bh = sb_getblk(sb, block);
-			BUG_ON(!bh);
-			/* Setup buffer i/o submission. */
-			lock_buffer(bh);
-			bh->b_end_io = end_buffer_write_sync;
-			get_bh(bh);
-			/* Set the entire contents of the buffer to 0xff. */
-			memset(bh->b_data, -1, block_size);
-			if (!buffer_uptodate(bh))
-				set_buffer_uptodate(bh);
-			if (buffer_dirty(bh))
-				clear_buffer_dirty(bh);
 			/*
 			 * Submit the buffer and wait for i/o to complete but
 			 * only for the first buffer so we do not miss really
@@ -807,25 +744,14 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 			 * completed ignore errors afterwards as we can assume
 			 * that if one buffer worked all of them will work.
 			 */
-			submit_bh(REQ_OP_WRITE, bh);
-			if (should_wait) {
+			if (should_wait)
 				should_wait = false;
-				wait_on_buffer(bh);
-				if (unlikely(!buffer_uptodate(bh)))
-					goto io_err;
-			}
-			brelse(bh);
-		} while (++block < end_block);
+			start += vol->cluster_size;
+		} while (start < end);
 	} while ((++rl)->vcn < end_vcn);
 	up_write(&log_ni->runlist.lock);
-	/*
-	 * Zap the pages again just in case any got instantiated whilst we were
-	 * emptying the blocks by hand.  FIXME: We may not have completed
-	 * writing to all the buffer heads yet so this may happen too early.
-	 * We really should use a kernel thread to do the emptying
-	 * asynchronously and then we can also set the volume dirty and output
-	 * an error message if emptying should fail.
-	 */
+	kfree(empty_buf);
+	kfree(ra);
 	truncate_inode_pages(log_vi->i_mapping, 0);
 	/* Set the flag so we do not have to do it again on remount. */
 	NVolSetLogFileEmpty(vol);
@@ -840,10 +766,10 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 	NVolSetErrors(vol);
 	err = -EIO;
 err:
+	ntfs_free(empty_buf);
+	kfree(ra);
 	up_write(&log_ni->runlist.lock);
-	ntfs_error(sb, "Failed to fill $LogFile with 0xff bytes (error %d).",
+	ntfs_error(sb, "Failed to fill LogFile with 0xff bytes (error %d).",
 			-err);
 	return false;
 }
-
-#endif /* NTFS_RW */
diff --git a/fs/ntfs/quota.c b/fs/ntfs/quota.c
index 9160480222fd..6f370184aafe 100644
--- a/fs/ntfs/quota.c
+++ b/fs/ntfs/quota.c
@@ -1,13 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * quota.c - NTFS kernel quota ($Quota) handling.  Part of the Linux-NTFS
- *	     project.
+ * NTFS kernel quota ($Quota) handling.
+ * Part of the Linux-NTFS project.
  *
  * Copyright (c) 2004 Anton Altaparmakov
  */
 
-#ifdef NTFS_RW
-
 #include "index.h"
 #include "quota.h"
 #include "debug.h"
@@ -20,11 +18,11 @@
  * Mark the quotas out of date on the ntfs volume @vol and return 'true' on
  * success and 'false' on error.
  */
-bool ntfs_mark_quotas_out_of_date(ntfs_volume *vol)
+bool ntfs_mark_quotas_out_of_date(struct ntfs_volume *vol)
 {
-	ntfs_index_context *ictx;
-	QUOTA_CONTROL_ENTRY *qce;
-	const le32 qid = QUOTA_DEFAULTS_ID;
+	struct ntfs_index_context *ictx;
+	struct quota_control_entry *qce;
+	const __le32 qid = QUOTA_DEFAULTS_ID;
 	int err;
 
 	ntfs_debug("Entering.");
@@ -35,7 +33,7 @@ bool ntfs_mark_quotas_out_of_date(ntfs_volume *vol)
 		return false;
 	}
 	inode_lock(vol->quota_q_ino);
-	ictx = ntfs_index_ctx_get(NTFS_I(vol->quota_q_ino));
+	ictx = ntfs_index_ctx_get(NTFS_I(vol->quota_q_ino), I30, 4);
 	if (!ictx) {
 		ntfs_error(vol->sb, "Failed to get index context.");
 		goto err_out;
@@ -43,22 +41,20 @@ bool ntfs_mark_quotas_out_of_date(ntfs_volume *vol)
 	err = ntfs_index_lookup(&qid, sizeof(qid), ictx);
 	if (err) {
 		if (err == -ENOENT)
-			ntfs_error(vol->sb, "Quota defaults entry is not "
-					"present.");
+			ntfs_error(vol->sb, "Quota defaults entry is not present.");
 		else
-			ntfs_error(vol->sb, "Lookup of quota defaults entry "
-					"failed.");
+			ntfs_error(vol->sb, "Lookup of quota defaults entry failed.");
 		goto err_out;
 	}
-	if (ictx->data_len < offsetof(QUOTA_CONTROL_ENTRY, sid)) {
-		ntfs_error(vol->sb, "Quota defaults entry size is invalid.  "
-				"Run chkdsk.");
+	if (ictx->data_len < offsetof(struct quota_control_entry, sid)) {
+		ntfs_error(vol->sb, "Quota defaults entry size is invalid.  Run chkdsk.");
 		goto err_out;
 	}
-	qce = (QUOTA_CONTROL_ENTRY*)ictx->data;
+	qce = (struct quota_control_entry *)ictx->data;
 	if (le32_to_cpu(qce->version) != QUOTA_VERSION) {
-		ntfs_error(vol->sb, "Quota defaults entry version 0x%x is not "
-				"supported.", le32_to_cpu(qce->version));
+		ntfs_error(vol->sb,
+			"Quota defaults entry version 0x%x is not supported.",
+			le32_to_cpu(qce->version));
 		goto err_out;
 	}
 	ntfs_debug("Quota defaults flags = 0x%x.", le32_to_cpu(qce->flags));
@@ -99,5 +95,3 @@ bool ntfs_mark_quotas_out_of_date(ntfs_volume *vol)
 	inode_unlock(vol->quota_q_ino);
 	return false;
 }
-
-#endif /* NTFS_RW */
diff --git a/fs/ntfs/sysctl.c b/fs/ntfs/sysctl.c
index 4e980170d86a..695c8a998c56 100644
--- a/fs/ntfs/sysctl.c
+++ b/fs/ntfs/sysctl.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * sysctl.c - Code for sysctl handling in NTFS Linux kernel driver. Part of
- *	      the Linux-NTFS project. Adapted from the old NTFS driver,
- *	      Copyright (C) 1997 Martin von Löwis, Régis Duchesne
+ * Code for sysctl handling in NTFS Linux kernel driver. Part of
+ * the Linux-NTFS project. Adapted from the old NTFS driver,
  *
+ * Copyright (C) 1997 Martin von Löwis, Régis Duchesne
  * Copyright (c) 2002-2005 Anton Altaparmakov
  */
 
@@ -20,7 +20,7 @@
 #include "debug.h"
 
 /* Definition of the ntfs sysctl. */
-static struct ctl_table ntfs_sysctls[] = {
+static const struct ctl_table ntfs_sysctls[] = {
 	{
 		.procname	= "ntfs-debug",
 		.data		= &debug_msgs,		/* Data pointer and size. */
@@ -28,6 +28,7 @@ static struct ctl_table ntfs_sysctls[] = {
 		.mode		= 0644,			/* Mode, proc handler. */
 		.proc_handler	= proc_dointvec
 	},
+	{}
 };
 
 /* Storage for the sysctls header. */
@@ -42,17 +43,14 @@ static struct ctl_table_header *sysctls_root_table;
 int ntfs_sysctl(int add)
 {
 	if (add) {
-		BUG_ON(sysctls_root_table);
 		sysctls_root_table = register_sysctl("fs", ntfs_sysctls);
 		if (!sysctls_root_table)
 			return -ENOMEM;
 	} else {
-		BUG_ON(!sysctls_root_table);
 		unregister_sysctl_table(sysctls_root_table);
 		sysctls_root_table = NULL;
 	}
 	return 0;
 }
-
 #endif /* CONFIG_SYSCTL */
 #endif /* DEBUG */
diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
index a6b6c64f14a9..b4424297bacf 100644
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -1,15 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * unistr.c - NTFS Unicode string handling. Part of the Linux-NTFS project.
+ * NTFS Unicode string handling. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2006 Anton Altaparmakov
  */
 
-#include <linux/slab.h>
-
-#include "types.h"
-#include "debug.h"
 #include "ntfs.h"
+#include "malloc.h"
 
 /*
  * IMPORTANT
@@ -51,9 +48,9 @@ static const u8 legal_ansi_char_array[0x40] = {
  * identical, or 'false' (0) if they are not identical. If @ic is IGNORE_CASE,
  * the @upcase table is used to performa a case insensitive comparison.
  */
-bool ntfs_are_names_equal(const ntfschar *s1, size_t s1_len,
-		const ntfschar *s2, size_t s2_len, const IGNORE_CASE_BOOL ic,
-		const ntfschar *upcase, const u32 upcase_size)
+bool ntfs_are_names_equal(const __le16 *s1, size_t s1_len,
+		const __le16 *s2, size_t s2_len, const u32 ic,
+		const __le16 *upcase, const u32 upcase_size)
 {
 	if (s1_len != s2_len)
 		return false;
@@ -65,7 +62,9 @@ bool ntfs_are_names_equal(const ntfschar *s1, size_t s1_len,
 /**
  * ntfs_collate_names - collate two Unicode names
  * @name1:	first Unicode name to compare
+ * @name1_len:	first Unicode name length
  * @name2:	second Unicode name to compare
+ * @name2_len:	second Unicode name length
  * @err_val:	if @name1 contains an invalid character return this value
  * @ic:		either CASE_SENSITIVE or IGNORE_CASE
  * @upcase:	upcase table (ignored if @ic is CASE_SENSITIVE)
@@ -80,10 +79,10 @@ bool ntfs_are_names_equal(const ntfschar *s1, size_t s1_len,
  *
  * The following characters are considered invalid: '"', '*', '<', '>' and '?'.
  */
-int ntfs_collate_names(const ntfschar *name1, const u32 name1_len,
-		const ntfschar *name2, const u32 name2_len,
-		const int err_val, const IGNORE_CASE_BOOL ic,
-		const ntfschar *upcase, const u32 upcase_len)
+int ntfs_collate_names(const __le16 *name1, const u32 name1_len,
+		const __le16 *name2, const u32 name2_len,
+		const int err_val, const u32 ic,
+		const __le16 *upcase, const u32 upcase_len)
 {
 	u32 cnt, min_len;
 	u16 c1, c2;
@@ -132,7 +131,7 @@ int ntfs_collate_names(const ntfschar *name1, const u32 name1_len,
  * if @s1 (or the first @n Unicode characters thereof) is found, respectively,
  * to be less than, to match, or be greater than @s2.
  */
-int ntfs_ucsncmp(const ntfschar *s1, const ntfschar *s2, size_t n)
+int ntfs_ucsncmp(const __le16 *s1, const __le16 *s2, size_t n)
 {
 	u16 c1, c2;
 	size_t i;
@@ -168,16 +167,18 @@ int ntfs_ucsncmp(const ntfschar *s1, const ntfschar *s2, size_t n)
  * if @s1 (or the first @n Unicode characters thereof) is found, respectively,
  * to be less than, to match, or be greater than @s2.
  */
-int ntfs_ucsncasecmp(const ntfschar *s1, const ntfschar *s2, size_t n,
-		const ntfschar *upcase, const u32 upcase_size)
+int ntfs_ucsncasecmp(const __le16 *s1, const __le16 *s2, size_t n,
+		const __le16 *upcase, const u32 upcase_size)
 {
 	size_t i;
 	u16 c1, c2;
 
 	for (i = 0; i < n; ++i) {
-		if ((c1 = le16_to_cpu(s1[i])) < upcase_size)
+		c1 = le16_to_cpu(s1[i]);
+		if (c1 < upcase_size)
 			c1 = le16_to_cpu(upcase[c1]);
-		if ((c2 = le16_to_cpu(s2[i])) < upcase_size)
+		c2 = le16_to_cpu(s2[i]);
+		if (c2 < upcase_size)
 			c2 = le16_to_cpu(upcase[c2]);
 		if (c1 < c2)
 			return -1;
@@ -189,42 +190,20 @@ int ntfs_ucsncasecmp(const ntfschar *s1, const ntfschar *s2, size_t n,
 	return 0;
 }
 
-void ntfs_upcase_name(ntfschar *name, u32 name_len, const ntfschar *upcase,
-		const u32 upcase_len)
+int ntfs_file_compare_values(const struct file_name_attr *file_name_attr1,
+		const struct file_name_attr *file_name_attr2,
+		const int err_val, const u32 ic,
+		const __le16 *upcase, const u32 upcase_len)
 {
-	u32 i;
-	u16 u;
-
-	for (i = 0; i < name_len; i++)
-		if ((u = le16_to_cpu(name[i])) < upcase_len)
-			name[i] = upcase[u];
-}
-
-void ntfs_file_upcase_value(FILE_NAME_ATTR *file_name_attr,
-		const ntfschar *upcase, const u32 upcase_len)
-{
-	ntfs_upcase_name((ntfschar*)&file_name_attr->file_name,
-			file_name_attr->file_name_length, upcase, upcase_len);
-}
-
-int ntfs_file_compare_values(FILE_NAME_ATTR *file_name_attr1,
-		FILE_NAME_ATTR *file_name_attr2,
-		const int err_val, const IGNORE_CASE_BOOL ic,
-		const ntfschar *upcase, const u32 upcase_len)
-{
-	return ntfs_collate_names((ntfschar*)&file_name_attr1->file_name,
+	return ntfs_collate_names((__le16 *)&file_name_attr1->file_name,
 			file_name_attr1->file_name_length,
-			(ntfschar*)&file_name_attr2->file_name,
+			(__le16 *)&file_name_attr2->file_name,
 			file_name_attr2->file_name_length,
 			err_val, ic, upcase, upcase_len);
 }
 
 /**
  * ntfs_nlstoucs - convert NLS string to little endian Unicode string
- * @vol:	ntfs volume which we are working with
- * @ins:	input NLS string buffer
- * @ins_len:	length of input string in bytes
- * @outs:	on return contains the allocated output Unicode string buffer
  *
  * Convert the input string @ins, which is in whatever format the loaded NLS
  * map dictates, into a little endian, 2-byte Unicode string.
@@ -242,53 +221,68 @@ int ntfs_file_compare_values(FILE_NAME_ATTR *file_name_attr1,
  *
  * This might look a bit odd due to fast path optimization...
  */
-int ntfs_nlstoucs(const ntfs_volume *vol, const char *ins,
-		const int ins_len, ntfschar **outs)
+int ntfs_nlstoucs(const struct ntfs_volume *vol, const char *ins,
+		const int ins_len, __le16 **outs, int max_name_len)
 {
 	struct nls_table *nls = vol->nls_map;
-	ntfschar *ucs;
+	__le16 *ucs;
 	wchar_t wc;
 	int i, o, wc_len;
 
 	/* We do not trust outside sources. */
 	if (likely(ins)) {
-		ucs = kmem_cache_alloc(ntfs_name_cache, GFP_NOFS);
+		if (max_name_len > NTFS_MAX_NAME_LEN)
+			ucs = kvmalloc((max_name_len + 2) * sizeof(__le16),
+				       GFP_NOFS | __GFP_ZERO);
+		else
+			ucs = kmem_cache_alloc(ntfs_name_cache, GFP_NOFS);
 		if (likely(ucs)) {
-			for (i = o = 0; i < ins_len; i += wc_len) {
-				wc_len = nls->char2uni(ins + i, ins_len - i,
-						&wc);
-				if (likely(wc_len >= 0 &&
-						o < NTFS_MAX_NAME_LEN)) {
-					if (likely(wc)) {
-						ucs[o++] = cpu_to_le16(wc);
-						continue;
-					} /* else if (!wc) */
-					break;
-				} /* else if (wc_len < 0 ||
-						o >= NTFS_MAX_NAME_LEN) */
-				goto name_err;
+			if (vol->nls_utf8) {
+				o = utf8s_to_utf16s(ins, ins_len,
+						    UTF16_LITTLE_ENDIAN,
+						    ucs,
+						    max_name_len + 2);
+				if (o < 0 || o > max_name_len) {
+					wc_len = o;
+					goto name_err;
+				}
+			} else {
+				for (i = o = 0; i < ins_len; i += wc_len) {
+					wc_len = nls->char2uni(ins + i, ins_len - i,
+							&wc);
+					if (likely(wc_len >= 0 &&
+					    o < max_name_len)) {
+						if (likely(wc)) {
+							ucs[o++] = cpu_to_le16(wc);
+							continue;
+						} /* else if (!wc) */
+						break;
+					}
+
+					goto name_err;
+				}
 			}
 			ucs[o] = 0;
 			*outs = ucs;
 			return o;
 		} /* else if (!ucs) */
-		ntfs_error(vol->sb, "Failed to allocate buffer for converted "
-				"name from ntfs_name_cache.");
+		ntfs_debug("Failed to allocate buffer for converted name from ntfs_name_cache.");
 		return -ENOMEM;
 	} /* else if (!ins) */
 	ntfs_error(vol->sb, "Received NULL pointer.");
 	return -EINVAL;
 name_err:
-	kmem_cache_free(ntfs_name_cache, ucs);
+	if (max_name_len > NTFS_MAX_NAME_LEN)
+		kvfree(ucs);
+	else
+		kmem_cache_free(ntfs_name_cache, ucs);
 	if (wc_len < 0) {
-		ntfs_error(vol->sb, "Name using character set %s contains "
-				"characters that cannot be converted to "
-				"Unicode.", nls->charset);
+		ntfs_debug("Name using character set %s contains characters that cannot be converted to Unicode.",
+				nls->charset);
 		i = -EILSEQ;
-	} else /* if (o >= NTFS_MAX_NAME_LEN) */ {
-		ntfs_error(vol->sb, "Name is too long (maximum length for a "
-				"name on NTFS is %d Unicode characters.",
-				NTFS_MAX_NAME_LEN);
+	} else {
+		ntfs_debug("Name is too long (maximum length for a name on NTFS is %d Unicode characters.",
+				max_name_len);
 		i = -ENAMETOOLONG;
 	}
 	return i;
@@ -319,7 +313,7 @@ int ntfs_nlstoucs(const ntfs_volume *vol, const char *ins,
  *
  * This might look a bit odd due to fast path optimization...
  */
-int ntfs_ucstonls(const ntfs_volume *vol, const ntfschar *ins,
+int ntfs_ucstonls(const struct ntfs_volume *vol, const __le16 *ins,
 		const int ins_len, unsigned char **outs, int outs_len)
 {
 	struct nls_table *nls = vol->nls_map;
@@ -340,8 +334,20 @@ int ntfs_ucstonls(const ntfs_volume *vol, const ntfschar *ins,
 			if (!ns)
 				goto mem_err_out;
 		}
+
+		if (vol->nls_utf8) {
+			o = utf16s_to_utf8s((const wchar_t *)ins, ins_len,
+					UTF16_LITTLE_ENDIAN, ns, ns_len);
+			if (o >= ns_len) {
+				wc = -ENAMETOOLONG;
+				goto conversion_err;
+			}
+			goto done;
+		}
+
 		for (i = o = 0; i < ins_len; i++) {
-retry:			wc = nls->uni2char(le16_to_cpu(ins[i]), ns + o,
+retry:
+			wc = nls->uni2char(le16_to_cpu(ins[i]), ns + o,
 					ns_len - o);
 			if (wc > 0) {
 				o += wc;
@@ -363,6 +369,7 @@ retry:			wc = nls->uni2char(le16_to_cpu(ins[i]), ns + o,
 			} /* wc < 0, real error. */
 			goto conversion_err;
 		}
+done:
 		ns[o] = 0;
 		*outs = ns;
 		return o;
@@ -370,9 +377,9 @@ retry:			wc = nls->uni2char(le16_to_cpu(ins[i]), ns + o,
 	ntfs_error(vol->sb, "Received NULL pointer.");
 	return -EINVAL;
 conversion_err:
-	ntfs_error(vol->sb, "Unicode name contains characters that cannot be "
-			"converted to character set %s.  You might want to "
-			"try to use the mount option nls=utf8.", nls->charset);
+	ntfs_error(vol->sb,
+		"Unicode name contains characters that cannot be converted to character set %s.  You might want to try to use the mount option nls=utf8.",
+		nls->charset);
 	if (ns != *outs)
 		kfree(ns);
 	if (wc != -ENAMETOOLONG)
@@ -382,3 +389,85 @@ retry:			wc = nls->uni2char(le16_to_cpu(ins[i]), ns + o,
 	ntfs_error(vol->sb, "Failed to allocate name!");
 	return -ENOMEM;
 }
+
+/**
+ * ntfs_ucsnlen - determine the length of a little endian Unicode string
+ * @s:		pointer to Unicode string
+ * @maxlen:	maximum length of string @s
+ *
+ * Return the number of Unicode characters in the little endian Unicode
+ * string @s up to a maximum of maxlen Unicode characters, not including
+ * the terminating (__le16)'\0'. If there is no (__le16)'\0' between @s
+ * and @s + @maxlen, @maxlen is returned.
+ *
+ * This function never looks beyond @s + @maxlen.
+ */
+static u32 ntfs_ucsnlen(const __le16 *s, u32 maxlen)
+{
+	u32 i;
+
+	for (i = 0; i < maxlen; i++) {
+		if (!le16_to_cpu(s[i]))
+			break;
+	}
+	return i;
+}
+
+/**
+ * ntfs_ucsndup - duplicate little endian Unicode string
+ * @s:		pointer to Unicode string
+ * @maxlen:	maximum length of string @s
+ *
+ * Return a pointer to a new little endian Unicode string which is a duplicate
+ * of the string s.  Memory for the new string is obtained with ntfs_malloc(3),
+ * and can be freed with free(3).
+ *
+ * A maximum of @maxlen Unicode characters are copied and a terminating
+ * (__le16)'\0' little endian Unicode character is added.
+ *
+ * This function never looks beyond @s + @maxlen.
+ *
+ * Return a pointer to the new little endian Unicode string on success and NULL
+ * on failure with errno set to the error code.
+ */
+__le16 *ntfs_ucsndup(const __le16 *s, u32 maxlen)
+{
+	__le16 *dst;
+	u32 len;
+
+	len = ntfs_ucsnlen(s, maxlen);
+	dst = ntfs_malloc_nofs((len + 1) * sizeof(__le16));
+	if (dst) {
+		memcpy(dst, s, len * sizeof(__le16));
+		dst[len] = cpu_to_le16(L'\0');
+	}
+	return dst;
+}
+
+/**
+ * ntfs_names_are_equal - compare two Unicode names for equality
+ * @s1:                 name to compare to @s2
+ * @s1_len:             length in Unicode characters of @s1
+ * @s2:                 name to compare to @s1
+ * @s2_len:             length in Unicode characters of @s2
+ * @ic:                 ignore case bool
+ * @upcase:             upcase table (only if @ic == IGNORE_CASE)
+ * @upcase_size:        length in Unicode characters of @upcase (if present)
+ *
+ * Compare the names @s1 and @s2 and return TRUE (1) if the names are
+ * identical, or FALSE (0) if they are not identical. If @ic is IGNORE_CASE,
+ * the @upcase table is used to perform a case insensitive comparison.
+ */
+bool ntfs_names_are_equal(const __le16 *s1, size_t s1_len,
+		const __le16 *s2, size_t s2_len,
+		const u32 ic,
+		const __le16 *upcase, const u32 upcase_size)
+{
+	if (s1_len != s2_len)
+		return false;
+	if (!s1_len)
+		return true;
+	if (ic == CASE_SENSITIVE)
+		return ntfs_ucsncmp(s1, s2, s1_len) ? false : true;
+	return ntfs_ucsncasecmp(s1, s2, s1_len, upcase, upcase_size) ? false : true;
+}
diff --git a/fs/ntfs/upcase.c b/fs/ntfs/upcase.c
index 4ebe84a78dea..21afd7e92428 100644
--- a/fs/ntfs/upcase.c
+++ b/fs/ntfs/upcase.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * upcase.c - Generate the full NTFS Unicode upcase table in little endian.
- *	      Part of the Linux-NTFS project.
+ * Generate the full NTFS Unicode upcase table in little endian.
+ * Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001 Richard Russon <ntfs@flatcap.org>
  * Copyright (c) 2001-2006 Anton Altaparmakov
@@ -10,7 +10,7 @@
 #include "malloc.h"
 #include "ntfs.h"
 
-ntfschar *generate_default_upcase(void)
+__le16 *generate_default_upcase(void)
 {
 	static const int uc_run_table[][3] = { /* Start, End, Add */
 	{0x0061, 0x007B,  -32}, {0x0451, 0x045D, -80}, {0x1F70, 0x1F72,  74},
@@ -52,12 +52,12 @@ ntfschar *generate_default_upcase(void)
 	};
 
 	int i, r;
-	ntfschar *uc;
+	__le16 *uc;
 
-	uc = ntfs_malloc_nofs(default_upcase_len * sizeof(ntfschar));
+	uc = ntfs_malloc_nofs(default_upcase_len * sizeof(__le16));
 	if (!uc)
 		return uc;
-	memset(uc, 0, default_upcase_len * sizeof(ntfschar));
+	memset(uc, 0, default_upcase_len * sizeof(__le16));
 	/* Generate the little endian Unicode upcase table used by ntfs. */
 	for (i = 0; i < default_upcase_len; i++)
 		uc[i] = cpu_to_le16(i);
-- 
2.25.1


