Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF0A2C2250
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbgKXJ6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbgKXJ6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:58:17 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF2C061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:58:17 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id m9so17005890pgb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lo85sr+ys6lf1U70qdtLk1A2yy6l0L87SOY5IKt+Rqg=;
        b=QuTKi5LeFc78ApnwKtQnKFpGpAFaDKYR2SPEUmVWgj/4ZUR2v9AJyfuVW5WVruRFoN
         FEET+MlGGH2GJqOaxPwIghe/UnIRZSlhrKcvxotqSlPEoiKkQ6MzkI+7L799Zttov95a
         5ESstlLDRvECWy8oer4helYMUoiejTAZVivERzLIA4DIoXk12ZgRh9AESBhUU58mm+Tq
         MQ1vggCT8xvopG0hkJahoUzZu+i1zc6KIeJytn1q0RbymNBA6QjVrr+uAxAVTyaQQPYw
         kMmaMQ0RVA4b4TdaTAvyE1uPbdrl5KaLcfZZIduwUOj+rlzVO1MuKKmzrPYebm1E8B8G
         GAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lo85sr+ys6lf1U70qdtLk1A2yy6l0L87SOY5IKt+Rqg=;
        b=uQTeTIbQtEdTvkcoYQeqgoExqWkWVtnyFCjxjb+KyzPNOcDd1O4OZQNJSA7pu1vrdz
         h1GXV/0X1oFiTO6Tcr7bh5a2quXkavSfXwiTXLyohLKU4nz4QsjSPschqTnZE3QLiwCN
         xs9gM7+tPFOOf7GgIQXmwDOVzqzu47VwQ6KNaSxIy1JsMDqnRXlIijlo3+87KvNVQsEC
         DAxgXSn2ieK3A+Yqi98EQd02kwh0zzD2lmKKI+uOj9A4sM8+upFgQVMQ/9o4Sc26GigT
         oTOgbHPse5+Ix0RoU2Ti1F7bWZBPregg9sYIlOxlytwOXJ4mwWRd92EQcr7HcpQpEqxE
         76mQ==
X-Gm-Message-State: AOAM533VzeFGIZs+LB85/pSi1iNqQlF1e4gv6HBKOPBqtXO0+MwX+tk6
        t7rzpylSDZH6WzEyQPjLi27JtA==
X-Google-Smtp-Source: ABdhPJyAtKbJcYyB5s0iPG+oh91QP+h3kDFCwvnUvcYufL0PAPrifyoMdxkl3ZhCw8GYFXaszwlw9g==
X-Received: by 2002:a62:f20e:0:b029:197:f6d8:8d4d with SMTP id m14-20020a62f20e0000b0290197f6d88d4dmr3405377pfh.58.1606211897122;
        Tue, 24 Nov 2020 01:58:17 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.58.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:58:16 -0800 (PST)
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
Subject: [PATCH v6 09/16] mm/hugetlb: Defer freeing of HugeTLB pages
Date:   Tue, 24 Nov 2020 17:52:52 +0800
Message-Id: <20201124095259.58755-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the subsequent patch, we will allocate the vmemmap pages when free
HugeTLB pages. But update_and_free_page() is called from a non-task
context(and hold hugetlb_lock), so we can defer the actual freeing in
a workqueue to prevent use GFP_ATOMIC to allocate the vmemmap pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 96 ++++++++++++++++++++++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.c |  5 ---
 mm/hugetlb_vmemmap.h | 10 ++++++
 3 files changed, 95 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9662b5535f3a..41056b4230f1 100644
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
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 1576f69bd1d3..f6ba288966d4 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -124,11 +124,6 @@
 	(__boundary - 1 < (end) - 1) ? __boundary : (end);		 \
 })
 
-static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
-{
-	return h->nr_free_vmemmap_pages;
-}
-
 static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 67113b67495f..293897b9f1d8 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,6 +13,11 @@
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 void __init hugetlb_vmemmap_init(struct hstate *h);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+
+static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return h->nr_free_vmemmap_pages;
+}
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
@@ -21,5 +26,10 @@ static inline void hugetlb_vmemmap_init(struct hstate *h)
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

