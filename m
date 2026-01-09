Return-Path: <linux-fsdevel+bounces-72988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC9D06F51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 04:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B107306E46B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 03:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939CD322B93;
	Fri,  9 Jan 2026 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oJbF4d0t";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oJbF4d0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC333EB0A;
	Fri,  9 Jan 2026 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928514; cv=none; b=BNhZykL8zP/cTg3ufCXOwl15VLC9Up/M51wxLR+7ZMgrBPCiV+bBf80Wn8PXuRC9z3mCQxrSFcn4vqcXlGdNZKN9mQZJsAv+pbGm1+yHNAhFN8MnxcgfoU2qkpPpgtQ6TvGZSfTLh24bmxO32apx5e7V9ivgHlUTS8LHRY4xnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928514; c=relaxed/simple;
	bh=bLPyX55goz9UpKyTSsH/rsQVx9Lcd+68NmlbcIC2gHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4wlQA7DUaaiC09KYY119Jmw1agxfmsr+IlhpMfI4pQfiDy6vhRgwKwUHjhdba42jwItT61F7jxIODbXvdp5ktF+QoQiYGxv0pQmYR+igswQNJcOP+2lWfcNazUBcYIKJi6x4Fg9dIHqXCxxNqIGRc0bnuuacqMEl5Pu6oOS+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oJbF4d0t; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oJbF4d0t; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=otZzmT6rxktVNDVECk5mC06H07hAnwXYZ9UJTBeZ2EE=;
	b=oJbF4d0t5wRl+Q3D2MEG1XxQ46Sws4p95wCVOUDW01xFXaHTtZLIuDaU1CGP+FYnhHWI9gyc+
	vl1DpAL3wOTCohN8rpHMh58gcD4/VUG36UAoqVqtLr4Wg1E8jI9n820W4N+o3Weae21OVDrRQCJ
	RiDve7yi5NEMgQAYQ4IAnOc=
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dnRgr2gp8z1BFq8;
	Fri,  9 Jan 2026 11:14:00 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=otZzmT6rxktVNDVECk5mC06H07hAnwXYZ9UJTBeZ2EE=;
	b=oJbF4d0t5wRl+Q3D2MEG1XxQ46Sws4p95wCVOUDW01xFXaHTtZLIuDaU1CGP+FYnhHWI9gyc+
	vl1DpAL3wOTCohN8rpHMh58gcD4/VUG36UAoqVqtLr4Wg1E8jI9n820W4N+o3Weae21OVDrRQCJ
	RiDve7yi5NEMgQAYQ4IAnOc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dnRck2myNzcb3h;
	Fri,  9 Jan 2026 11:11:18 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 5ED5F40569;
	Fri,  9 Jan 2026 11:14:53 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Jan
 2026 11:14:52 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v13 04/10] erofs: decouple `struct erofs_anon_fs_type`
Date: Fri, 9 Jan 2026 03:01:34 +0000
Message-ID: <20260109030140.594936-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260109030140.594936-1-lihongbo22@huawei.com>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Gao Xiang <hsiangkao@linux.alibaba.com>

  - Move the `struct erofs_anon_fs_type` to super.c and expose it
    in preparation for the upcoming page cache share feature;

  - Remove the `.owner` field, as they are all internal mounts and
    fully managed by EROFS.  Retaining `.owner` would unnecessarily
    increment module reference counts, preventing the EROFS kernel
    module from being unloaded.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 13 -------------
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 7a346e20f7b7..f4937b025038 100644
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
index 937a215f626c..f18f43b78fca 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
 #include <linux/backing-dev.h>
+#include <linux/pseudo_fs.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -936,6 +937,19 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+#if defined(CONFIG_EROFS_FS_ONDEMAND)
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
+}
+
+struct file_system_type erofs_anon_fs_type = {
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


