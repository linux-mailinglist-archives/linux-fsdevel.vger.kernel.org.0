Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F482BA288
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 07:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKTGrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 01:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgKTGrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:47:47 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8FAC061A04
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:47:47 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b63so6914138pfg.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4ocrBp5RtbwrXGoGGGzEKCWuDM80WIWOrkJq24b7IM=;
        b=Se35lDK/XQgYJK1nao211OIIU2qYhqgO1R6rKGuX9Vr0lFX4czymPTlGW+jBkHVTa9
         hDd5u944BykhdpGl0L8yX0gU8XH9nTxoQG9ghUMh15iii0TqsArsh6TkQvt3zkCoee6b
         XB9n6wnWzZgccn4Bv+CR4NEW89sSobfOhfawE1ZWPTFgzEaIZNDw4vMzevrwvnaseAhq
         zoPQPI1AxNZwREynm80OIaHAzMeCpHb8Kwsb4p6R3EQkReAl5MBLQtz3OKWsZld3WVmP
         d/UhIqQzAAPOIlRILXO0EO8/f3eUf9RjeN7aLQntzw4Ndk+qJ4f+NtC4ta1mrDIVBag7
         NKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4ocrBp5RtbwrXGoGGGzEKCWuDM80WIWOrkJq24b7IM=;
        b=jSCy+jh/fINEaqDj9ID75DWgXqt7l3+QWtOlh+DW9qiNXxPS7ioFpVM3iWpiZoo/M4
         Kk5DkstP6fBA8GqTbQ9wAA756AImxtsHfr+oQMIrPGGLWDv741nnAy4YHczh/hS4Agz3
         92R7Q+XRDQOuP07JRbV/b+VBK59mWvJnGgI0D21iPQ+/mRrN51JnIeAC2fkJb+5Vfm7s
         WKgQZ0veBsXR6dNYBLnEz70O1NCivvO/SWd6AAoCHurYphdA7C1X+8Y5buUMu5pMQoAI
         N2BG91CtMj8ETENvIqrjjexnjZ2BCRjkJn6qmEny+gVYYu48M2jXe8BBLxq85w2w47JM
         MRfg==
X-Gm-Message-State: AOAM530/JOOqDHbat2ddLHL3Bu63BPh6iLioKNiaQpfS5Ry1VKhIb/Po
        HsR0FpRqV9smIPeUrq7JoKAWAw==
X-Google-Smtp-Source: ABdhPJwDQrgUMesiO1qtRhsL0SWbv3mx4C+Bq9qqub0lRaxnzDCkdADO40LR2/elDjmk33XOqDhU9Q==
X-Received: by 2002:a63:1445:: with SMTP id 5mr15576117pgu.357.1605854866690;
        Thu, 19 Nov 2020 22:47:46 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.47.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:47:46 -0800 (PST)
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
Subject: [PATCH v5 10/21] mm/hugetlb: Defer freeing of hugetlb pages
Date:   Fri, 20 Nov 2020 14:43:14 +0800
Message-Id: <20201120064325.34492-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c         | 98 +++++++++++++++++++++++++++++++++++++++++++++-------
 mm/hugetlb_vmemmap.c |  5 ---
 mm/hugetlb_vmemmap.h | 10 ++++++
 3 files changed, 96 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a0ce6f33a717..4aabf12aca9b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1221,7 +1221,7 @@ static void destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
-static void free_gigantic_page(struct page *page, unsigned int order)
+static void __free_gigantic_page(struct page *page, unsigned int order)
 {
 	/*
 	 * If the page isn't allocated using the cma allocator,
@@ -1288,20 +1288,100 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 {
 	return NULL;
 }
-static inline void free_gigantic_page(struct page *page, unsigned int order) { }
+static inline void __free_gigantic_page(struct page *page,
+					unsigned int order) { }
 static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
-static void update_and_free_page(struct hstate *h, struct page *page)
+static void __free_hugepage(struct hstate *h, struct page *page);
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
 {
-	int i;
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
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+static inline void free_gigantic_page(struct hstate *h, struct page *page)
+{
+	__free_gigantic_page(page, huge_page_order(h));
+}
+#else
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
+#endif
+
+static void update_and_free_page(struct hstate *h, struct page *page)
+{
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
@@ -1313,14 +1393,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
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
@@ -1761,7 +1835,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 
 	if (vmemmap_pgtable_prealloc(h, page)) {
 		if (hstate_is_gigantic(h))
-			free_gigantic_page(page, huge_page_order(h));
+			free_gigantic_page(h, page);
 		else
 			put_page(page);
 		return NULL;
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6f8a735e0dd3..eda7e3a0b67c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -141,11 +141,6 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
 }
 #endif
 
-static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
-{
-	return h->nr_free_vmemmap_pages;
-}
-
 static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index a9425d94ed8b..4175b44f88bc 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -15,6 +15,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h);
 int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page);
 void vmemmap_pgtable_free(struct page *page);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+
+static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return h->nr_free_vmemmap_pages;
+}
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
@@ -32,5 +37,10 @@ static inline void vmemmap_pgtable_free(struct page *page)
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
+
+static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return 0;
+}
 #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

