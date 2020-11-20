Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B822BA27F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 07:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgKTGrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 01:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgKTGrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:47:18 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BE9C0617A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:47:18 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id v21so6503351pgi.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8+6kFiX35+SYRYCMY/5tIq0PVNkZdMDuwu0+2DoVOg=;
        b=CibrVpa1DK/y4ZBSiLT6b4E/pdTpwIde9RU+znTztJxfn8U/3iyalIR7uOR/nTAAhc
         wDWncwLhE1bUVLjI4eUEk8T0hyY1WbPhR+y4q9SJGPViYRcZvqDRxOnf0bWZ/f06izMB
         VpprHhjU8mInlWAAQVe3/ediZ21TCiudNAsvVJ1VaBn2xSXfumC9Lg9XidyFo+CiOC+n
         VjHad2x99Ldm9ApW4Sj0aCNweF3Ohy3T+FROsEuVhiE7QZqmLk0EddgvzPmSGjYb1rOC
         pTQBWzrxRTebJuYuTpI+8q6AtWTj3rVp0xnY2sUVtJQ5HRB7EzW1bAnnvIVnxHYfEqg5
         pk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8+6kFiX35+SYRYCMY/5tIq0PVNkZdMDuwu0+2DoVOg=;
        b=kuL6pv3Kzd7uNvSg5uVORTgzh1yJepMwBdZPsv9Hi5JHnj1OcgrW3yW9zQlU/tD89l
         Jw66cMeUMMELdSiR9xwJeC8s782HmbRG6f5F9uRQCkIY7gudS7tTUG8qr02oz7EnttJI
         kM8MGsjfn7TDY8mGOynNCgLC6txEAPAC7zbu+QKYwn4hfUf5Y+HknX7G1Hrjaj20lNg7
         615HJpxYOzLkDEO0vw13Lcxy4ApaD6BkECNBiI0cyqQsImfxq41HQt3AmKNCX4gFGZvU
         V1cMemFa5tcxq99ljf6xLwF79bFxPR8af3XlFIMJGDjqDvZrUj3rAkREQXvX481VUtie
         Y+AQ==
X-Gm-Message-State: AOAM530/zraygoSy0ixEQ5gFgh0hIi6c7GpcHvMYauKrwpj2PjoQqAMx
        mZI27ERaBV4E7r7kGQMcH0MM9Q==
X-Google-Smtp-Source: ABdhPJwiM8/hpCe4kOH5I+hIrt6fADSa/eg/PqPGaiVEXY38h+crBZPI5lED4J/HD569nN1T8rp3hQ==
X-Received: by 2002:a17:90a:9dc2:: with SMTP id x2mr8720214pjv.98.1605854837972;
        Thu, 19 Nov 2020 22:47:17 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.47.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:47:17 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 07/21] mm/bootmem_info: Combine bootmem info and type into page->freelist
Date:   Fri, 20 Nov 2020 14:43:11 +0800
Message-Id: <20201120064325.34492-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
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
 arch/x86/mm/init_64.c        |  2 +-
 include/linux/bootmem_info.h | 18 ++++++++++++++++--
 mm/bootmem_info.c            | 12 ++++++------
 mm/sparse.c                  |  4 ++--
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0435bee2e172..9b738c6cb659 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -883,7 +883,7 @@ static void __meminit free_pagetable(struct page *page, int order)
 	if (PageReserved(page)) {
 		__ClearPageReserved(page);
 
-		magic = (unsigned long)page->freelist;
+		magic = page_bootmem_type(page);
 		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
 			while (nr_pages--)
 				put_page_bootmem(page++);
diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 239e3cc8f86c..95ae80838680 100644
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
 
+#define BOOTMEM_TYPE_BITS	(ilog2(MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE) + 1)
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

