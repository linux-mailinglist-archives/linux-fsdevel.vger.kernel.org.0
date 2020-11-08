Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06122AAB6D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgKHOMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbgKHOMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:12:52 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AE2C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:12:52 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id oc3so1896350pjb.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViDdOmBRgb5hnUIFaB4WtjDnZp7Cey4qhqZPozCdPTE=;
        b=RV5JZEtYb/jv7Riusz889INkfBW9YWjsSGPo5y797XUr7ibDqmjMDwMXeDRp2VnhQ6
         YLSNJOUGgifIwE+IZbgRibhBefG6pazChnJcsKjt6fU89esN88rrrUHsl8Q6L0d48X5i
         lx8hUtrG4ClboxdDiF2fbNVzESbgG/RpdzsS53VubU+J/mA9YAg1vqLEk0wPqgYg0cT2
         18Jvw2isDRL7Lp1hEFqM3ZtCHvKloUU9cc+nW1XhHPs4kPZ/q0NqHbrHLpZJgUQpphB+
         eUsDYuQPE2wl/32SgDiGQeHZJMPMtG4Ml9WF1BuAiiEBr9SdZj+TTc2cWt0Mkjo585mV
         dqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViDdOmBRgb5hnUIFaB4WtjDnZp7Cey4qhqZPozCdPTE=;
        b=tzJkkuUN8200mbtuLJqeS4sMz1TFfp7SRVw7EOvG5/7n8gu0E5l8vfm1q35CGn3rt2
         Zwk+J7KAA0diV6acY3oT3bYck19cwd4IKPaizsAMYcubZ0dEDcwSgucTeLEReWBG0ZDz
         rJARnBaw2j/+w2N5tJ1+MFP8OWyb/IK4foKnfGde3AXIJWV3sIUcaQo7UpdS6ZZ+EEG1
         tWpOqradXMkVZHRNiadgXp89fks/gJH3Mx8y+tchtH777d7mzvC8S7wADp0WXwKiDjao
         f2INmKmF/XEF85lv/nwtVCkx1JRpvlNxNKDCy04J02pXPquO5PyVXfCk8Gg9XuROUpV8
         cE+w==
X-Gm-Message-State: AOAM533U+f2l22JDi1JR6AluBOhM5UDoE9HGV3KjZRBUCsIctRwPbFm1
        24NzjQIR3GDufeGYpnm8J4Ajrg==
X-Google-Smtp-Source: ABdhPJzaq6xPhI1MKttFTsTVH2ADrn75dQVLbF8ukP71lvwo8Zled9eFiBNGlvOEJ0zaNUDRfMGnZg==
X-Received: by 2002:a17:90a:648:: with SMTP id q8mr8674681pje.176.1604844771991;
        Sun, 08 Nov 2020 06:12:51 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.12.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:12:51 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 07/21] mm/bootmem_info: Combine bootmem info and type into page->freelist
Date:   Sun,  8 Nov 2020 22:10:59 +0800
Message-Id: <20201108141113.65450-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page->private shares storage with page->ptl. In the later patch,
we will use the page->ptl. So here we combine bootmem info and type
into page->freelist so that we can do not use page->private.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/bootmem_info.h | 18 ++++++++++++++++--
 mm/bootmem_info.c            | 12 ++++++------
 mm/sparse.c                  |  4 ++--
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index ce9d8c97369d..b5786a8b412e 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -6,7 +6,7 @@
 #include <linux/mm.h>
 
 /*
- * Types for free bootmem stored in page->lru.next. These have to be in
+ * Types for free bootmem stored in page->freelist. These have to be in
  * some random range in unsigned long space for debugging purposes.
  */
 enum {
@@ -17,6 +17,20 @@ enum {
 	MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE = NODE_INFO,
 };
 
+#define BOOTMEM_TYPE_BITS	4
+#define BOOTMEM_TYPE_MAX	((1UL << BOOTMEM_TYPE_BITS) - 1)
+#define BOOTMEM_INFO_MAX	(ULONG_MAX >> BOOTMEM_TYPE_BITS)
+
+static inline unsigned long page_bootmem_type(struct page *page)
+{
+	return (unsigned long)page->freelist & BOOTMEM_TYPE_MAX;
+}
+
+static inline unsigned long page_bootmem_info(struct page *page)
+{
+	return (unsigned long)page->freelist >> BOOTMEM_TYPE_BITS;
+}
+
 #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
 
@@ -30,7 +44,7 @@ static inline void free_vmemmap_page(struct page *page)
 
 	/* bootmem page has reserved flag in the reserve_bootmem_region */
 	if (PageReserved(page)) {
-		unsigned long magic = (unsigned long)page->freelist;
+		unsigned long magic = page_bootmem_type(page);
 
 		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
 			put_page_bootmem(page);
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index fcab5a3f8cc0..9baf163965fd 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -12,9 +12,9 @@
 
 void get_page_bootmem(unsigned long info, struct page *page, unsigned long type)
 {
-	page->freelist = (void *)type;
-	SetPagePrivate(page);
-	set_page_private(page, info);
+	BUG_ON(info > BOOTMEM_INFO_MAX);
+	BUG_ON(type > BOOTMEM_TYPE_MAX);
+	page->freelist = (void *)((info << BOOTMEM_TYPE_BITS) | type);
 	page_ref_inc(page);
 }
 
@@ -22,14 +22,12 @@ void put_page_bootmem(struct page *page)
 {
 	unsigned long type;
 
-	type = (unsigned long) page->freelist;
+	type = page_bootmem_type(page);
 	BUG_ON(type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
 	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
 
 	if (page_ref_dec_return(page) == 1) {
 		page->freelist = NULL;
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
 		INIT_LIST_HEAD(&page->lru);
 		free_reserved_page(page);
 	}
@@ -101,6 +99,8 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
 	int node = pgdat->node_id;
 	struct page *page;
 
+	BUILD_BUG_ON(MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE > BOOTMEM_TYPE_MAX);
+
 	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
 	page = virt_to_page(pgdat);
 
diff --git a/mm/sparse.c b/mm/sparse.c
index a4138410d890..fca5fa38c2bc 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -740,12 +740,12 @@ static void free_map_bootmem(struct page *memmap)
 		>> PAGE_SHIFT;
 
 	for (i = 0; i < nr_pages; i++, page++) {
-		magic = (unsigned long) page->freelist;
+		magic = page_bootmem_type(page);
 
 		BUG_ON(magic == NODE_INFO);
 
 		maps_section_nr = pfn_to_section_nr(page_to_pfn(page));
-		removing_section_nr = page_private(page);
+		removing_section_nr = page_bootmem_info(page);
 
 		/*
 		 * When this function is called, the removing section is
-- 
2.11.0

