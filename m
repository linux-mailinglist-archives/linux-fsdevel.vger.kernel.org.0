Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803312D0F47
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgLGLfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgLGLfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:37 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DBFC0613D4;
        Mon,  7 Dec 2020 03:35:22 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 69so806577pgg.8;
        Mon, 07 Dec 2020 03:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amXRNC1mfdywzpWrbOff714/vb9YHjvjsXiNQKXcqcA=;
        b=k6DezM51fJayfcLxJQektp8YJvDSsBbz0aVlfSnHNBt+2Wxn4RS9e6sNgSGv12LZdn
         fScIMhUj9dLNh7Arm9VHs4vEpVXoSPwObS0+Csb8MMe9MYzmH6dg0lqwqyG6nAde1wOi
         34bTopBZUATvrIHVmW1MmgCkKXfJgTCxl5kBjmRFwuXuFss9pzdJv061rMlRT0sR6cvm
         QdbctetT25eotvN/DrxAcuWPDaSg3ZFzoyaDSMKXEBdg8nUVJsjJWPK3XNCksnNUGHkB
         SEu+RmRnibNi7ublI6HydqMUjgwWBf6MWZu/qay+0SGsOUxJkYzQEZGovb73STeCAsJh
         9Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amXRNC1mfdywzpWrbOff714/vb9YHjvjsXiNQKXcqcA=;
        b=Z7/2AO6O4HHXhClBz5MfEczfyWJ/xVkgc6QDHctbpG3YN+RK9Sw6iUlBS4cpajposo
         evRzf1NYWJTtLR5Lk+yy67QbZu17yYm527/rMeuIFZbC3FcpkcfY4eNoE9BAVtvuxtu3
         flI0SnJWhSZ8ZDplsijlXSU4WgI4lyoEROUgrvQ0jCLUhlREJRhD8Wl016vN96C+gwSd
         IP3RQZ5y50AHjYw4fepQApVGugMIBdYEZkaUvkpgBtLKuCMa2LXJjEn0B1/eiZs0HKvP
         D4guH+Z2vNW5tPRWdijKxmfnx/ojwBhfS7ZB81SfYNgKept/S6zhQnw2xW2KcoGYSnl4
         A/qw==
X-Gm-Message-State: AOAM530FU821JmRsnawHHOa1cvzA+FwqDhSgHwsuzf4lLOjdRtC2i1FM
        XT60dtx3qK9+mei9iWl7oZg=
X-Google-Smtp-Source: ABdhPJzktfbAut0a4U/9/77Kk3IPuy2wYdqsh6ukZ0LN08xk9L3dyRMq6PVyY4Nz0UXg4U/HCNjWVQ==
X-Received: by 2002:a17:902:b101:b029:da:c50e:cd56 with SMTP id q1-20020a170902b101b02900dac50ecd56mr15820085plr.59.1607340921829;
        Mon, 07 Dec 2020 03:35:21 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:21 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 30/37] dmem: introduce dmem_bitmap_alloc() and dmem_bitmap_free()
Date:   Mon,  7 Dec 2020 19:31:23 +0800
Message-Id: <6eca6b9b58b3cf9a52c8227ee92d9b926c249f0b.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/inode.c         |  6 +++++
 include/linux/fs.h |  1 +
 mm/dmem.c          | 69 ++++++++++++++++++++++++++++++++++--------------------
 3 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d78c37..9b6363d3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -210,6 +210,12 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
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
index 8667d0c..bc7a89c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2937,6 +2937,7 @@ static inline bool is_zero_ino(ino_t ino)
 extern void __destroy_inode(struct inode *);
 extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
+extern struct inode *alloc_inode_nonrcu(void);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int should_remove_suid(struct dentry *);
 extern int file_remove_privs(struct file *);
diff --git a/mm/dmem.c b/mm/dmem.c
index eb6df70..50cdff9 100644
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
@@ -472,7 +496,7 @@ static int __init dmem_late_init(void)
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
1.8.3.1

