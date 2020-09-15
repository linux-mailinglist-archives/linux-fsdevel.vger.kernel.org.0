Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB926B86D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgIPAnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgIONCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:02:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92435C061351
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y1so1945419pgk.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bRCYHUYk1hH5GlJBxp/yuwD+jDdbOfhVtaE95IbYmOc=;
        b=kDUWUa2ZT8b/MvJ9cAxjIpRzubPelB4YMWzv/FPUiKvVXnR2wgLHRyJPlBTx2dFGPx
         WdHqq5NcPH25dOl0mZSnquMGz/e7PlX7cC42O/ZFcuDzbaB1biKNjfd1tzk2Oc6YgTFa
         d9OrrkV9EnSfmyUvBL+Vagbnl6bIxkyZtvYke2r2FbE6JYYwapT5RlbfRUhSJ53rXePP
         x0HwhaY92MKbHhHjIYRctLxb0cf76tXco75+M5/SFjZJHxPya0IEKclVXhAXblN2hOfT
         tJTZ6mqsoBnPfVTUIATM/SZDuHHl8VcDFX/HoR/H8KcZZSIb8UOudCvKwJqbipmZCQHD
         ZKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bRCYHUYk1hH5GlJBxp/yuwD+jDdbOfhVtaE95IbYmOc=;
        b=DMkpsKJO04105hlZFaaF0T29i8gvoichkHMSY8anQU0ww6RZKQNL4hqQYTGwTtibVL
         anvU06m2kSLVIO9ZJrOOsPfUNenv7FRrbwXNz3hsmvBfA7PXxU+NeraJYTmSXirupEkS
         v2/Elm1RMiDyX9mTUjUUngZCUErB1q2/4HSK0XjC+iwPquZl26v8dh/9E8q81rJowzOx
         nGjvzrfSgj2KATpj+4PGZxJdBkBGDRkv5ZQoHsUJivbl2/tDQMf+3KSpFDLMCJE9N8IT
         Tqf+1UUjYRmMrOdrka2jxijIRBTh2m9sBP2OcX5dgRUsK4bZnzP1Lr4lxqRxjwWLQpOb
         zh/g==
X-Gm-Message-State: AOAM533tQdpBWp7onAV36NvKFQoVZHuG1+TE9aENNtmHD8rAqCweAZnT
        0AtNaBEuX7MFxgC3+1oanVnW4g==
X-Google-Smtp-Source: ABdhPJxenPAUPU06D9i1v/P969ZaM4N7XdPUb9tgmOwsHIoNMdA/XIJz1ZOBc23yyjDVGrDlS8zHiA==
X-Received: by 2002:a62:178d:0:b029:13e:d13d:a0f8 with SMTP id 135-20020a62178d0000b029013ed13da0f8mr18090356pfx.20.1600174924831;
        Tue, 15 Sep 2020 06:02:04 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.01.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:02:04 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 12/24] mm/hugetlb: Defer freeing of hugetlb pages
Date:   Tue, 15 Sep 2020 20:59:35 +0800
Message-Id: <20200915125947.26204-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the subsequent patch, we will allocate the vmemmap pages when free
huge pages. But update_and_free_page() is be called from a non-task
context(and hold hugetlb_lock), we can defer the actual freeing in
a workqueue to prevent use GFP_ATOMIC to allocate the vmemmap pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a628588a075a..6b57a1183785 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1292,6 +1292,8 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+static void __free_hugepage(struct hstate *h, struct page *page);
+
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 #include <linux/bootmem_info.h>
 
@@ -1642,6 +1644,64 @@ static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
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
+	if (!nr_free_vmemmap(h)) {
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
+static inline void free_gigantic_page_comm(struct hstate *h, struct page *page)
+{
+	free_gigantic_page(page, huge_page_order(h));
+}
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
@@ -1659,17 +1719,39 @@ static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
+
+static inline void __update_and_free_page(struct hstate *h, struct page *page)
+{
+	__free_hugepage(h, page);
+}
+
+static inline void free_gigantic_page_comm(struct hstate *h, struct page *page)
+{
+	/*
+	 * Temporarily drop the hugetlb_lock, because
+	 * we might block in free_gigantic_page().
+	 */
+	spin_unlock(&hugetlb_lock);
+	free_gigantic_page(page, huge_page_order(h));
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
@@ -1681,14 +1763,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
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
+		free_gigantic_page_comm(h, page);
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
-- 
2.20.1

