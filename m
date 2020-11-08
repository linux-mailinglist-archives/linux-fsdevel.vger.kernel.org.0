Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D57A2AAB77
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgKHON0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbgKHONW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:13:22 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64655C0613D4
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:13:22 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id oc3so1896783pjb.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rXSn3D2YKe0+X0WLHIvZOcLAPiLQlYOefZQ1A7s7AtE=;
        b=Q2qHU7V4lYexamo2M7caIRpE5GFV3Xh9Dk2KgSI8RavPh3p0jsS341WkT4TBpMGbtE
         Jzm2zAXu/zi9SY2X2TooQNmx4aZd0F/+YLyeSXgCAuoChxZdzZo4qYZjjS4y+C0bwJgw
         fJdiDqyEAHK8bu3R0kCfB/lu/JoHInS27ZAoq9WHbVrvbBISB3Oa3ZB6TLd9uI3Jajii
         tSmllNlMLCdBSQE/Lk+UmIf5b1YGGibwA+vx1tW7zOz6vypKM8QVQ2FfOYASx6+vgAF5
         Xgr8764EmXA5nktDLN5X8f4dCWd0c+WME/e/gU8TlAwqgs5ogGJsQYqiVFcjnT3ySdUv
         8uVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXSn3D2YKe0+X0WLHIvZOcLAPiLQlYOefZQ1A7s7AtE=;
        b=tOvp6SDJQyihoEzCJjQDDMQTcf6WcOyHns93gZRoU7baOSMil4FF7Ovys7Um7hqD7U
         JaNS5Cj7UyWYhIEkPKckDobt5iUyNHcaIoYilE5zO39ZG4GQqVwhZ7dSIYP58XvTKq5i
         BaBGL10dcqcuQkmKyUYl/fTHzMTfmaeVOXfD3gEDPoDnn2pTrgOsAQDNO89ZMY/nSI+U
         bncw7jhzC+w6iinme9VgUtcSsqeQkdaEY8fBCTGRYgun4qeJwxjMiykkU0tb1ojXdCpQ
         FKjS32OT+QWSjrNS2rJ0QA+crm+G/d5ppoSzllrKDbm5LanE6FJulz8IKBMD1pkAIClk
         0o0w==
X-Gm-Message-State: AOAM5330PaVS4fMqdvl2YfQgwtUOAwZRhuw1qvz8kM+Ltii8c8DW29t+
        EToiUW7GXCSGntrrMFqoP2JNQw==
X-Google-Smtp-Source: ABdhPJxP2eZ+jU77mxWdGYFFsWcVpA5y1yjM2Ntif+Ct0/qeAd9IIoR/2NeAhAX+KQKP5LIv69d+aA==
X-Received: by 2002:a17:902:8e8b:b029:d2:4276:1df0 with SMTP id bg11-20020a1709028e8bb02900d242761df0mr9025848plb.62.1604844801946;
        Sun, 08 Nov 2020 06:13:21 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.13.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:13:21 -0800 (PST)
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
Subject: [PATCH v3 10/21] mm/hugetlb: Defer freeing of hugetlb pages
Date:   Sun,  8 Nov 2020 22:11:02 +0800
Message-Id: <20201108141113.65450-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the subsequent patch, we will allocate the vmemmap pages when free
huge pages. But update_and_free_page() is be called from a non-task
context(and hold hugetlb_lock), we can defer the actual freeing in
a workqueue to prevent use GFP_ATOMIC to allocate the vmemmap pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 27f0269aab70..ded7f0fbde35 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1220,7 +1220,7 @@ static void destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
-static void free_gigantic_page(struct page *page, unsigned int order)
+static void __free_gigantic_page(struct page *page, unsigned int order)
 {
 	/*
 	 * If the page isn't allocated using the cma allocator,
@@ -1287,11 +1287,14 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 {
 	return NULL;
 }
-static inline void free_gigantic_page(struct page *page, unsigned int order) { }
+static inline void __free_gigantic_page(struct page *page,
+					unsigned int order) { }
 static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+static void __free_hugepage(struct hstate *h, struct page *page);
+
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 #include <linux/bootmem_info.h>
 
@@ -1574,6 +1577,64 @@ static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	free_vmemmap_page_list(&free_pages);
 }
+
+/*
+ * As update_and_free_page() is be called from a non-task context(and hold
+ * hugetlb_lock), we can defer the actual freeing in a workqueue to prevent
+ * use GFP_ATOMIC to allocate a lot of vmemmap pages.
+ *
+ * update_hpage_vmemmap_workfn() locklessly retrieves the linked list of
+ * pages to be freed and frees them one-by-one. As the page->mapping pointer
+ * is going to be cleared in update_hpage_vmemmap_workfn() anyway, it is
+ * reused as the llist_node structure of a lockless linked list of huge
+ * pages to be freed.
+ */
+static LLIST_HEAD(hpage_update_freelist);
+
+static void update_hpage_vmemmap_workfn(struct work_struct *work)
+{
+	struct llist_node *node;
+	struct page *page;
+
+	node = llist_del_all(&hpage_update_freelist);
+
+	while (node) {
+		page = container_of((struct address_space **)node,
+				     struct page, mapping);
+		node = node->next;
+		page->mapping = NULL;
+		__free_hugepage(page_hstate(page), page);
+
+		cond_resched();
+	}
+}
+static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
+
+static inline void __update_and_free_page(struct hstate *h, struct page *page)
+{
+	/* No need to allocate vmemmap pages */
+	if (!free_vmemmap_pages_per_hpage(h)) {
+		__free_hugepage(h, page);
+		return;
+	}
+
+	/*
+	 * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap
+	 * pages.
+	 *
+	 * Only call schedule_work() if hpage_update_freelist is previously
+	 * empty. Otherwise, schedule_work() had been called but the workfn
+	 * hasn't retrieved the list yet.
+	 */
+	if (llist_add((struct llist_node *)&page->mapping,
+		      &hpage_update_freelist))
+		schedule_work(&hpage_update_work);
+}
+
+static inline void free_gigantic_page(struct hstate *h, struct page *page)
+{
+	__free_gigantic_page(page, huge_page_order(h));
+}
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
@@ -1591,17 +1652,39 @@ static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
+
+static inline void __update_and_free_page(struct hstate *h, struct page *page)
+{
+	__free_hugepage(h, page);
+}
+
+static inline void free_gigantic_page(struct hstate *h, struct page *page)
+{
+	/*
+	 * Temporarily drop the hugetlb_lock, because
+	 * we might block in __free_gigantic_page().
+	 */
+	spin_unlock(&hugetlb_lock);
+	__free_gigantic_page(page, huge_page_order(h));
+	spin_lock(&hugetlb_lock);
+}
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
 {
-	int i;
-
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[page_to_nid(page)]--;
+
+	__update_and_free_page(h, page);
+}
+
+static void __free_hugepage(struct hstate *h, struct page *page)
+{
+	int i;
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
@@ -1613,14 +1696,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
-		/*
-		 * Temporarily drop the hugetlb_lock, because
-		 * we might block in free_gigantic_page().
-		 */
-		spin_unlock(&hugetlb_lock);
 		destroy_compound_gigantic_page(page, huge_page_order(h));
-		free_gigantic_page(page, huge_page_order(h));
-		spin_lock(&hugetlb_lock);
+		free_gigantic_page(h, page);
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
@@ -2057,7 +2134,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 
 	if (vmemmap_pgtable_prealloc(h, page)) {
 		if (hstate_is_gigantic(h))
-			free_gigantic_page(page, huge_page_order(h));
+			free_gigantic_page(h, page);
 		else
 			put_page(page);
 		return NULL;
-- 
2.11.0

