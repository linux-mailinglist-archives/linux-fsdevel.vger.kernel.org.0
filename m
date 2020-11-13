Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D592B1985
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 12:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKMLDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 06:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgKMLCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:02:49 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0541CC0617A6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:02:16 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t21so494064pgl.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8+6kFiX35+SYRYCMY/5tIq0PVNkZdMDuwu0+2DoVOg=;
        b=rf1io2iYRtz0L6+JHseYf3dNS5Mb/AXZcKwA/Xb/zSYFjMXMVAMQKlgCaQWr9kzns9
         n2H6cxCQQAw2K805Tb6B1f+nayVdlCQxYmE38oSQo3sdMt9dUaEOe4B4W2yW5awu+IZO
         t2HpmWp49mlrv5X/DxeSo4d2nWsH6NZe7dRo9HIkpVlEosJgOdWcVp/vIyWDA+aPW5hx
         VIIpf4RiBQp2Q5zaO0raOuFgcW6EmUlh/5MVBlKzug41UUnLf7O66tbD/bCKvXVSZcp0
         0UKvWGF3MM5MmYzrF++wlOOSwoVqq4o3IjJI7BUGkuNg+kFYYI8uGiX+WNQFI4K5Y65i
         eFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8+6kFiX35+SYRYCMY/5tIq0PVNkZdMDuwu0+2DoVOg=;
        b=QMXUe9JFNtMEZ624QP8Rt6UgE9UIHlPcrVVgm+77GmIYJpm9X5N0s9rcE2hXVXn79V
         TpIH5/euN+hvSiDq8nMllZv7JlK5BIkGLwtnVA9gKweLdBeIJSaq3IwEJ+l1exS6l0KL
         sG5TO4Sk0fWZpJEE1ZR8dMyzX8zyNtuyGbWHFfNNbMS/vOy3sUhnfPm4+cQurRtcyGsG
         hFTHzoi36pF+QOkkmR9L4a62cFrGI5UWzjfCtc8Umrm6aJEiz35Ga253/J7BVefX8uFS
         q+9y5sBCxXbWW0yFIteBkXbM0Vc2T1YfxPDKA3inzZ7/euTDc2VIb/HgN3nTWFvhgEqi
         D6kw==
X-Gm-Message-State: AOAM530z5wj3vkGbDWOGjvVoVun9zC4AOHbNNggtQOPxco/+sQUI0HDm
        zM7IroqjkPC3pJqRpI6kPN8KvQ==
X-Google-Smtp-Source: ABdhPJz7GS0CVqm/4oAdI7rZkckINR7GOC8+rUKzbAR0127hPf1uyWJEPox2fCoHDgwBDHSrLeK5oA==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr1575017pgb.165.1605265335521;
        Fri, 13 Nov 2020 03:02:15 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.02.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:02:14 -0800 (PST)
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
Subject: [PATCH v4 07/21] mm/bootmem_info: Combine bootmem info and type into page->freelist
Date:   Fri, 13 Nov 2020 18:59:38 +0800
Message-Id: <20201113105952.11638-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
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

