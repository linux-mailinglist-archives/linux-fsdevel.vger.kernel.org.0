Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D02DD13A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 13:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgLQMQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 07:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgLQMQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:16:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B27AC061282
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 04:16:15 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q4so9326506plr.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 04:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4dPLPzck6kFTICnnm6pOIxTCOOE9pZF0RcQDn1W2nM=;
        b=Z/fm8Jkvky6uM79c3EnJXTurjRvzR81fNFYuCoSJa7/EHqX74YmEwLi9R2nMdKBr0+
         8qbRlG8pRhuR5fqfRfGvXX50XXjV56/6PducBm+aaQNswZaE3tzoplT3bJyXgF9eSEX5
         GGoasJLXYPl6kqEOGIDW9JiqTDFKOVJakkQPccJhgAmIEJwD0YAL02rcMzenQkyJv02u
         Bjj6BLV9uGpk2vAOWTjqQiVN300w3B04OLTeG3Spxpv1hrF2x7Id7QtPr+KmhrJCmxe8
         KHpEEWfw5nN2y8HDRQQ1Jews4wu9tgar2Yk1rdoXew5FHoqcoSxhWqChSXG+5mJqz3SJ
         3hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4dPLPzck6kFTICnnm6pOIxTCOOE9pZF0RcQDn1W2nM=;
        b=iEJlCEDuA7p7nLdJPpOqBxaXzLpFbVdRvr/hEQCJ3sOW41cunM60IxYqw4y3Pmdn+i
         46gBqyf3xdiYfIb1l5azPp2yDCxMPS8lvKr3gCk0Wy51Ig7enUoeOkbTOFjZTISa0+mu
         sF9i4Dx3SsQ1c0vSssQIZzSTqD9bb4dB5JhXtE2QRiAdmx/U481PsxXQ+V6DREb9pzUi
         9Fd1C9J3IU/kULrbPJNOGmme5h2l3aHGsr0VJsgrGyCnt1PztuMlCGV5mabFdeTHuomc
         mr3VLChLXvqfpaZS2xeQbVMYX6rO9DaZzswnOAbuG1QB34CbiiJbzMcBVRYr4VFw4ETQ
         QLMw==
X-Gm-Message-State: AOAM531umpJdXsrtHA0h9Nt8qHh0LhzhQyUIijOKzEgYgaw0kI3gjlCD
        Gr5/tdt1QkrKBWwG59zt6vP75w==
X-Google-Smtp-Source: ABdhPJxSW3f1EoG0md+ulos+fD0SCWxRxyz/oTDM0Kf9cb/M3CQzUYcF4lB+daxG90MsE14vUA0fJQ==
X-Received: by 2002:a17:90b:4a84:: with SMTP id lp4mr7842963pjb.218.1608207375114;
        Thu, 17 Dec 2020 04:16:15 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id n15sm2775691pgl.31.2020.12.17.04.16.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 04:16:14 -0800 (PST)
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
Subject: [PATCH v10 04/11] mm/hugetlb: Defer freeing of HugeTLB pages
Date:   Thu, 17 Dec 2020 20:12:56 +0800
Message-Id: <20201217121303.13386-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201217121303.13386-1-songmuchun@bytedance.com>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the subsequent patch, we will allocate the vmemmap pages when free
HugeTLB pages. But update_and_free_page() is called from a non-task
context(and hold hugetlb_lock), so we can defer the actual freeing in
a workqueue to prevent from using GFP_ATOMIC to allocate the vmemmap
pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 80 ++++++++++++++++++++++++++++++++++++++++++++++++----
 mm/hugetlb_vmemmap.c | 12 --------
 mm/hugetlb_vmemmap.h | 17 +++++++++++
 3 files changed, 91 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 140135fc8113..9f35f34d3195 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1292,15 +1292,79 @@ static inline void destroy_compound_gigantic_page(struct page *page,
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
+/*
+ * This is where the call to allocate vmemmmap pages will be inserted.
+ */
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
+		 * Temporarily drop the hugetlb_lock only when this type of
+		 * HugeTLB page does not support vmemmap optimization (which
+		 * context do not hold the hugetlb_lock), because we might
+		 * block in free_gigantic_page().
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
index 5cf7b6122c86..c4bbca270453 100644
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

