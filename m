Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D942D8E54
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 16:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437209AbgLMPr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 10:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436975AbgLMPrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:47:52 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A97C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:02 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id s21so10416063pfu.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JzVjZqxZV7qnxps+XwTtc4y07Zkwq00cj3VktTcKlD8=;
        b=17mJ8xTPcqAavz6MM0pAp760eQvu1eOoW7F90e/v4d0+No+R9P9OubAYsCbNcLEVhi
         4F0PXmlUXQFrHZ9DUsY9oNcKkrUtmWslkjdROemZ8jxKIB3hQNMxHC8Mv8x+h5ZhPvxL
         Adxo2ov7TO6cwdxhIwXM0qqP1p0Q6Rotkex5ZSXtGG91+2tmsRdIvOz054gGerKyvbIj
         zH6QlfqKm1N3wu0FuKGDww9JNOPgPJia8daKsll0Z/Eq1PC2lxqOfbs9hTHFlFo9ONzl
         X/3K/NXu8SIIM6/85FW17Zvms5Ahn2mUr4mVNX4RBRxzkpc/YaZNHnOCgnLlkaiA/K7U
         tACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzVjZqxZV7qnxps+XwTtc4y07Zkwq00cj3VktTcKlD8=;
        b=bo+jmh1nhxdiNNfzilIly6QahHGyeYQY6Em+GKTQSXc+BueWnwZdi67ROvNMSGBjAR
         99uUIb/qPD8S98gos2ZQX55W6cpjMqPYwj9t/1CO7SWoR0ptRYmTVCkmqRMF8YbVwS++
         p35qiLEJ2ee2CaoKu+UAtKyBmzuf/utKHC+AGDg8iElNQh6M/jHjbB9KMCgOb3NrUyKd
         +v17Eh8DIoQq6CtgzYK2NgQE6YgqiX3Yi1shFZTOTXUYTcTe+DB8H1rucU1cpBNiG7Z4
         6FczHR3e++kMLgGGcUfVUXoDn6gyQnrvCwTQynLwrQ4IK8kFfH5axCAEZJRfsJ5ql73x
         c7BA==
X-Gm-Message-State: AOAM531A2fw72915tpBNLtYOPzqBXQpLRJ055arZMoGO/Sdn4NZRcyQq
        Y1Ga7GCb4jSfP7PKuB7ayCkaxg==
X-Google-Smtp-Source: ABdhPJwTdVq1N13ImJdxPVfax9bptCqn2O3MF5sosHV3Bj6TaA1ng4gLRWLVQ+rMi1MnmyQiDitiNw==
X-Received: by 2002:a63:6e0d:: with SMTP id j13mr20805782pgc.236.1607874421951;
        Sun, 13 Dec 2020 07:47:01 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id e24sm13113753pjt.16.2020.12.13.07.46.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2020 07:47:01 -0800 (PST)
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
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v9 04/11] mm/hugetlb: Defer freeing of HugeTLB pages
Date:   Sun, 13 Dec 2020 23:45:27 +0800
Message-Id: <20201213154534.54826-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201213154534.54826-1-songmuchun@bytedance.com>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++++++----
 mm/hugetlb_vmemmap.c | 12 --------
 mm/hugetlb_vmemmap.h | 17 ++++++++++++
 3 files changed, 88 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 140135fc8113..0ff9b90e524f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1292,15 +1292,76 @@ static inline void destroy_compound_gigantic_page(struct page *page,
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
@@ -1313,13 +1374,17 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
 		/*
-		 * Temporarily drop the hugetlb_lock, because
-		 * we might block in free_gigantic_page().
+		 * Temporarily drop the hugetlb_lock only when this type of
+		 * HugeTLB page does not support vmemmap optimization (which
+		 * contex do not hold the hugetlb_lock), because we might block
+		 * in free_gigantic_page().
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
index 5a714bd60d6b..6d4e77a2b6c7 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -180,18 +180,6 @@
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

