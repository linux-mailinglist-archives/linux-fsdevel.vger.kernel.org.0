Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7FC2E0BBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 15:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgLVObB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 09:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgLVObA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:31:00 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0AFC0613D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:30:14 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j1so7523725pld.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLqxbS6LtrTLoVFdlTdUuNVdlDwo14Fqd+EkuFETfK8=;
        b=WurtkCZNNXR0Vhts3Qpr6O8zUxh9px6S5TDgal3MNrS02aff5oykPsTo2vpYMKc7X1
         6j4FojKDH94AmM7d/lBE9KzVLk4zXt9cwHQIiD+XN/4YTOs6ikrdv45LtrJ3oUJPGz56
         Ew1ACjDQnsQHHk+9ynJHkl5oRXCtvtqUdbblSavYkRrbXV3O7F9vkIlo14mR5NJt6uWj
         HS9LFCflT2e04qwcU90bbgOIqQep7Hv0Z+I5fR82zkyNVGOjtnOxUQ+sTSO3ugHXZZhH
         h+/8HFGPRqtEVbuUXZeo/1u0LkjvDA80dk3bSRsgaTBhKbsOD9JgDxc8sUPMTn2xtvGr
         8OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLqxbS6LtrTLoVFdlTdUuNVdlDwo14Fqd+EkuFETfK8=;
        b=nk1oTMoNXf6tUWY7Yqz3uLWHVYJl5483VTGRXEifWMfHOmqHmqyORS36+Kx7LE1JA8
         cIc2Q2XTHP6vUoTiHuyGQTbjBnwDawiJyPQrHbE9mYJD6W+C0nHZw9mUOY7S3z3T/ysr
         gLUusUUR89V8OP0UU0VhS4UXFy7m2GgM4cIZPOAn94nqFVRPkCNhi3XTRKavCiA9ARoa
         R5vZm+NuNohdlfOqDSUuFogzLk18MfiDybip2zTcLBE7Y+qzHFHbA3fif5JxZM4pJj8M
         tTJuyVcwXWORv0HCQBjZGNaqN0aOVn/pCG8WGgCnv2oicPWOvOGHwGH32WSj/bbqTX9I
         51wQ==
X-Gm-Message-State: AOAM533CqjinhR7YNg1RViAgqs/E1/4VJEMo46YjWZmufgbwkglVK1UK
        uT9g3Ydd7r0o7ldI4WeGseIrYg==
X-Google-Smtp-Source: ABdhPJwKezQ06zxgxgIZ9Yx7aSkCO6Idh1yQ80GyilRIHCJEPgcpHpGOrQlu2T8qHGrP1kHtk4Fdmg==
X-Received: by 2002:a17:90a:f404:: with SMTP id ch4mr21647948pjb.78.1608647414411;
        Tue, 22 Dec 2020 06:30:14 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id a31sm21182088pgb.93.2020.12.22.06.30.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 06:30:13 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v11 04/11] mm/hugetlb: Defer freeing of HugeTLB pages
Date:   Tue, 22 Dec 2020 22:24:33 +0800
Message-Id: <20201222142440.28930-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201222142440.28930-1-songmuchun@bytedance.com>
References: <20201222142440.28930-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the subsequent patch, we should allocate the vmemmap pages when
freeing HugeTLB pages. But update_and_free_page() is always called
with holding hugetlb_lock, so we cannot use GFP_KERNEL to allocate
vmemmap pages. However, we can defer the actual freeing in a workqueue
to prevent from using GFP_ATOMIC to allocate the vmemmap pages.

The __free_hugepage() is where the call to allocate vmemmmap pages
will be inserted.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 80 ++++++++++++++++++++++++++++++++++++++++++++++++----
 mm/hugetlb_vmemmap.c | 12 --------
 mm/hugetlb_vmemmap.h | 17 +++++++++++
 3 files changed, 91 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 140135fc8113..fc45a900acf1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1292,15 +1292,79 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
-static void update_and_free_page(struct hstate *h, struct page *page)
+static void __free_hugepage(struct hstate *h, struct page *page);
+
+/*
+ * As update_and_free_page() is always called with holding hugetlb_lock, so we
+ * cannot use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
+ * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
+ * the vmemmap pages.
+ *
+ * The __free_hugepage() is where the call to allocate vmemmmap pages will be
+ * inserted.
+ *
+ * update_hpage_vmemmap_workfn() locklessly retrieves the linked list of pages
+ * to be freed and frees them one-by-one. As the page->mapping pointer is going
+ * to be cleared in update_hpage_vmemmap_workfn() anyway, it is reused as the
+ * llist_node structure of a lockless linked list of huge pages to be freed.
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
+
+		cond_resched();
+	}
+}
+static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
 
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
@@ -1313,13 +1377,17 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
 		/*
-		 * Temporarily drop the hugetlb_lock, because
-		 * we might block in free_gigantic_page().
+		 * Temporarily drop the hugetlb_lock, because we might block
+		 * in free_gigantic_page(). Only drop it in case the vmemmap
+		 * optimization is disabled, since that context does not hold
+		 * the lock.
 		 */
-		spin_unlock(&hugetlb_lock);
+		if (!free_vmemmap_pages_per_hpage(h))
+			spin_unlock(&hugetlb_lock);
 		destroy_compound_gigantic_page(page, huge_page_order(h));
 		free_gigantic_page(page, huge_page_order(h));
-		spin_lock(&hugetlb_lock);
+		if (!free_vmemmap_pages_per_hpage(h))
+			spin_lock(&hugetlb_lock);
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4ffa2a4ae2a8..19f1898aaede 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -178,18 +178,6 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
-/*
- * How many vmemmap pages associated with a HugeTLB page that can be freed
- * to the buddy allocator.
- *
- * Todo: Returns zero for now, which means the feature is disabled. We will
- * enable it once all the infrastructure is there.
- */
-static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
-{
-	return 0;
-}
-
 static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
 {
 	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 6923f03534d5..01f8637adbe0 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,9 +12,26 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+
+/*
+ * How many vmemmap pages associated with a HugeTLB page that can be freed
+ * to the buddy allocator.
+ *
+ * Todo: Returns zero for now, which means the feature is disabled. We will
+ * enable it once all the infrastructure is there.
+ */
+static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return 0;
+}
 #else
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

