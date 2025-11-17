Return-Path: <linux-fsdevel+bounces-68726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B56C646C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 14:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F93AB6FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10B3346AD;
	Mon, 17 Nov 2025 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="U0mzbbkr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9938332EDD;
	Mon, 17 Nov 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386647; cv=none; b=mm6bJV0DmklOtSq7eDPX/Eh9ojGhl2Mr1KbDQViUgHD5LgMDb0y3XJ4jz0vcq8g9Jfcf2fAlKg1dK9wpk1ihVt8IAzEPqtil4RUx1sCZE+VZ7PxwH9Zts0B4Dab0XR/GGdzpYP/jNXHQ37yLtrVbpaLgCDu1Dp0TGZGkX7zJ9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386647; c=relaxed/simple;
	bh=tH0JolREo8cNIFkYyW3F7pwq+OVNHXGNB0uE8egG1/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIDh4c3MwWyQVIxmwhZNfHZcylNLI9eSnNLz1YIksmp0L99FchC+6hSzuJnC2kCO/uV8PLeawx1Qb1w5CY9cbwAh1ixhFFkno1ejfDmqdmDitreZ1rRpgde/2pXB1XPxE2BjTq9ZjNpQZ5xN7+zDMr2ef92KJGzaqosP/mSRFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=U0mzbbkr; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VE0DQ7pctvI8MKUuVLQSMq+RxdHSNjkD65i/wt7FY9k=;
	b=U0mzbbkr6XqSBexR9vLPrW62ltoceXM76eb1thCUd7R4PI93f3zOeio1BUh/Y+FBEfGQAzWN5
	xHjBu8EECQ9XlCFtNCx2BdnQyM5Uu/epg1dcdYDUMj9D0roOOPABrkwiRIfvdGRK0BFth5hcxDm
	ujhGwQ2xuWSnAQ60VG2gOXM=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d97zW113BzRhrk;
	Mon, 17 Nov 2025 21:35:35 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 60D1D140202;
	Mon, 17 Nov 2025 21:37:17 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:37:16 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 04/10] erofs: move `struct erofs_anon_fs_type` to super.c
Date: Mon, 17 Nov 2025 13:25:31 +0000
Message-ID: <20251117132537.227116-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251117132537.227116-1-lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

Move the `struct erofs_anon_fs_type` to the super.c and
expose it in preparation for the upcoming page cache share
feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/fscache.c  | 13 -------------
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 362acf828279..2d1683479fc0 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2022, Alibaba Cloud
  * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
-#include <linux/pseudo_fs.h>
 #include <linux/fscache.h>
 #include "internal.h"
 
@@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
 static LIST_HEAD(erofs_domain_cookies_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
-static int erofs_anon_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type erofs_anon_fs_type = {
-	.owner		= THIS_MODULE,
-	.name           = "pseudo_erofs",
-	.init_fs_context = erofs_anon_init_fs_context,
-	.kill_sb        = kill_anon_super,
-};
-
 struct erofs_fscache_io {
 	struct netfs_cache_resources cres;
 	struct iov_iter		iter;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f7f622836198..98fe652aea33 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -188,6 +188,8 @@ static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
 	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
 }
 
+extern struct file_system_type erofs_anon_fs_type;
+
 static inline bool erofs_is_fscache_mode(struct super_block *sb)
 {
 	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f3f8d8c066e4..0d88c04684b9 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
 #include <linux/backing-dev.h>
+#include <linux/pseudo_fs.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -920,6 +921,20 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+#if defined(CONFIG_EROFS_FS_ONDEMAND)
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
+}
+
+struct file_system_type erofs_anon_fs_type = {
+	.owner		= THIS_MODULE,
+	.name           = "pseudo_erofs",
+	.init_fs_context = erofs_anon_init_fs_context,
+	.kill_sb        = kill_anon_super,
+};
+#endif
+
 static int __init erofs_module_init(void)
 {
 	int err;
-- 
2.22.0


