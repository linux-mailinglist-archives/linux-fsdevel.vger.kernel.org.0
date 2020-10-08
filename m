Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9770A28703A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgJHH4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgJHHz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C893C0613D4;
        Thu,  8 Oct 2020 00:55:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d23so2366196pll.7;
        Thu, 08 Oct 2020 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tP/lJJiY+XHS3Tqjt8+lhvljOhGvK52JvoQA9+uEFQk=;
        b=Qcm+4YHWLy7vd7eZwG3uqWcHRKc0LUHmPsVkrMdKIt8ykEsi4x08XRZNML/b4w/n/e
         tayHd7M3Pmx1py2aGvGSeA8kcbN/DupSYdHK4IvkQZQElgNehtV2P0wm9y79Kz1R8nDF
         eX/sftMraCWByoAyLe/cKmm64PaKxMy5imvLYMUggSPH8ivQO4ukPeCarYjvD3+wHDc+
         NKNQNYGb0nVAX2mBk5rWM3YLsqnXk38yYBjePF5Ln7w0KNPbkVCY4WV2NJ03GEr2xfDl
         JDdl8zGW1ApjHpf+BBQOFQ4RJ88g1KGQeaRBKgKNFqI3TTIWz6vsXi5HrFejtIBFDOOq
         zp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tP/lJJiY+XHS3Tqjt8+lhvljOhGvK52JvoQA9+uEFQk=;
        b=pfH1ynLoIsO92pzyEmivZRuAjMhiAHi8rd022UOTFCwXv/xBvS4xow8/2nIPgvqCrW
         iHhD29bOM1aC3gi7VVB4yF9ZycVAcrwSkwGrdO8Osw0FNBX5JPq7szWiAppCPKz5pY/J
         IJkOqG2UWBd4CxES2aoRRbi8t7pY9GQ7GCu88AFGUitDJvGr6Ks9cnCQwtPK0tUxbjBB
         hvZsrtUrzWeaNIHht8kYttegt3dT/0oD7hljXJ4t3vsCfAPKjH15gXNC9h2zt0N1d4QI
         AHy3tROKFt6Bg0Fswh/V9+qgde0/7CzxSOFDN02YH46dzLvkm47YWUnbLVsTboOF1RA9
         uH7w==
X-Gm-Message-State: AOAM5308gfHcnK8fy8AdtTg60iEFpNLyXjurtYa0jSWprCoBCeb1u3Yx
        x765OWT4HTqZvUo21xXfH7k=
X-Google-Smtp-Source: ABdhPJyjs+IkeIkk5jzJbnSKGDDptAu+x0PXtjw/SvpIVj0BlEbb/SByMNcMW2ExCzt/vVrJMSI1Yw==
X-Received: by 2002:a17:902:d888:b029:d0:cb2d:f274 with SMTP id b8-20020a170902d888b02900d0cb2df274mr6280077plz.13.1602143756683;
        Thu, 08 Oct 2020 00:55:56 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:56 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 30/35] dmem: introduce dmem_bitmap_alloc() and dmem_bitmap_free()
Date:   Thu,  8 Oct 2020 15:54:20 +0800
Message-Id: <f79969d52ad112210259f39c606e158b2206792a.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

If dmem contained in dmem region is too large and dmemfs is mounted as
4K pagesize, size of bitmap in this dmem region maybe exceed maximal
available memory of kzalloc(). It would cause kzalloc() fail.

So introduce dmem_bitmap_alloc() and use vzalloc() if bitmap is larger than
PAGE_SIZE as vzalloc() will get sparse page.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/inode.c         |  6 ++++
 include/linux/fs.h |  1 +
 mm/dmem.c          | 69 +++++++++++++++++++++++++++++-----------------
 3 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..6f8c60ac9302 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -208,6 +208,12 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 }
 EXPORT_SYMBOL(inode_init_always);
 
+struct inode *alloc_inode_nonrcu(void)
+{
+	return kmem_cache_alloc(inode_cachep, GFP_KERNEL);
+}
+EXPORT_SYMBOL(alloc_inode_nonrcu);
+
 void free_inode_nonrcu(struct inode *inode)
 {
 	kmem_cache_free(inode_cachep, inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a08..872552dc5a61 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2984,6 +2984,7 @@ extern void clear_inode(struct inode *);
 extern void __destroy_inode(struct inode *);
 extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
+extern struct inode *alloc_inode_nonrcu(void);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int should_remove_suid(struct dentry *);
 extern int file_remove_privs(struct file *);
diff --git a/mm/dmem.c b/mm/dmem.c
index eb6df7059cf0..50cdff98675b 100644
--- a/mm/dmem.c
+++ b/mm/dmem.c
@@ -17,6 +17,7 @@
 #include <linux/dmem.h>
 #include <linux/debugfs.h>
 #include <linux/notifier.h>
+#include <linux/vmalloc.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dmem.h>
@@ -362,9 +363,38 @@ static int __init dmem_node_init(struct dmem_node *dnode)
 	return 0;
 }
 
+static unsigned long *dmem_bitmap_alloc(unsigned long pages,
+					unsigned long *static_bitmap)
+{
+	unsigned long *bitmap, size;
+
+	size = BITS_TO_LONGS(pages) * sizeof(long);
+	if (size <= sizeof(*static_bitmap))
+		bitmap = static_bitmap;
+	else if (size <= PAGE_SIZE)
+		bitmap = kzalloc(size, GFP_KERNEL);
+	else
+		bitmap = vzalloc(size);
+
+	return bitmap;
+}
+
+static void dmem_bitmap_free(unsigned long pages,
+			     unsigned long *bitmap,
+			     unsigned long *static_bitmap)
+{
+	unsigned long size;
+
+	size = BITS_TO_LONGS(pages) * sizeof(long);
+	if (size > PAGE_SIZE)
+		vfree(bitmap);
+	else if (bitmap != static_bitmap)
+		kfree(bitmap);
+}
+
 static void __init dmem_region_uinit(struct dmem_region *dregion)
 {
-	unsigned long nr_pages, size, *bitmap = dregion->error_bitmap;
+	unsigned long nr_pages, *bitmap = dregion->error_bitmap;
 
 	if (!bitmap)
 		return;
@@ -374,9 +404,7 @@ static void __init dmem_region_uinit(struct dmem_region *dregion)
 
 	WARN_ON(!nr_pages);
 
-	size = BITS_TO_LONGS(nr_pages) * sizeof(long);
-	if (size > sizeof(dregion->static_bitmap))
-		kfree(bitmap);
+	dmem_bitmap_free(nr_pages, bitmap, &dregion->static_error_bitmap);
 	dregion->error_bitmap = NULL;
 }
 
@@ -405,19 +433,15 @@ static void __init dmem_uinit(void)
 
 static int __init dmem_region_init(struct dmem_region *dregion)
 {
-	unsigned long *bitmap, size, nr_pages;
+	unsigned long *bitmap, nr_pages;
 
 	nr_pages = __phys_to_pfn(dregion->reserved_end_addr)
 		- __phys_to_pfn(dregion->reserved_start_addr);
 
-	size = BITS_TO_LONGS(nr_pages) * sizeof(long);
-	if (size <= sizeof(dregion->static_error_bitmap)) {
-		bitmap = &dregion->static_error_bitmap;
-	} else {
-		bitmap = kzalloc(size, GFP_KERNEL);
-		if (!bitmap)
-			return -ENOMEM;
-	}
+	bitmap = dmem_bitmap_alloc(nr_pages, &dregion->static_error_bitmap);
+	if (!bitmap)
+		return -ENOMEM;
+
 	dregion->error_bitmap = bitmap;
 	return 0;
 }
@@ -472,7 +496,7 @@ late_initcall(dmem_late_init);
 static int dmem_alloc_region_init(struct dmem_region *dregion,
 				  unsigned long *dpages)
 {
-	unsigned long start, end, *bitmap, size;
+	unsigned long start, end, *bitmap;
 
 	start = DMEM_PAGE_UP(dregion->reserved_start_addr);
 	end = DMEM_PAGE_DOWN(dregion->reserved_end_addr);
@@ -481,14 +505,9 @@ static int dmem_alloc_region_init(struct dmem_region *dregion,
 	if (!*dpages)
 		return 0;
 
-	size = BITS_TO_LONGS(*dpages) * sizeof(long);
-	if (size <= sizeof(dregion->static_bitmap))
-		bitmap = &dregion->static_bitmap;
-	else {
-		bitmap = kzalloc(size, GFP_KERNEL);
-		if (!bitmap)
-			return -ENOMEM;
-	}
+	bitmap = dmem_bitmap_alloc(*dpages, &dregion->static_bitmap);
+	if (!bitmap)
+		return -ENOMEM;
 
 	dregion->bitmap = bitmap;
 	dregion->next_free_pos = 0;
@@ -582,7 +601,7 @@ static void dmem_uinit_check_alloc_bitmap(struct dmem_region *dregion)
 
 static void dmem_alloc_region_uinit(struct dmem_region *dregion)
 {
-	unsigned long dpages, size, *bitmap = dregion->bitmap;
+	unsigned long dpages, *bitmap = dregion->bitmap;
 
 	if (!bitmap)
 		return;
@@ -592,9 +611,7 @@ static void dmem_alloc_region_uinit(struct dmem_region *dregion)
 
 	dmem_uinit_check_alloc_bitmap(dregion);
 
-	size = BITS_TO_LONGS(dpages) * sizeof(long);
-	if (size > sizeof(dregion->static_bitmap))
-		kfree(bitmap);
+	dmem_bitmap_free(dpages, bitmap, &dregion->static_bitmap);
 	dregion->bitmap = NULL;
 }
 
-- 
2.28.0

