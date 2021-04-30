Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0684936F478
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 05:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhD3DWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 23:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhD3DV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:21:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B80C061343
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 20:21:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t2-20020a17090a0242b0290155433387beso5991913pje.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 20:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jbkc9x++Vn8ZhHhQLxm3+dKKasXfp7J9ViOUSE1vqFE=;
        b=SZEbMxEoKG/WbmvAMrsUbytNBSlCl3lo0aI/O4RGtbML/vU9wGJtsx7UGijG2uJ9of
         nSqdMHKi0F+6LOG6MUnx3KU4I+bdFVbPUpG/2hrgDITYLfz0M5Gx7VcLWZpDq5gtSxPH
         7Mb8Qj+vNixfKFKOyGkLKsqNE1Alw1Fw7iXAnGWpNgsB1R5l+ZLebr8r9RlR/zIDkzYC
         ZGtimcxJY+jSi1q1Uv5px+fLQ1j7P9pHO+OIAwj9os9nzNHhTfygeyj/W3HePJb2mNOo
         GZz9fFlqo6XMIbwjbNcm10AyFyyloYDXNRwLvQSDwDpDXN/Ht47Sde/qZZE3im/OeriR
         ECGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jbkc9x++Vn8ZhHhQLxm3+dKKasXfp7J9ViOUSE1vqFE=;
        b=RqV1dRmfWFD8DFx1WcAgQPsTxZrpRB5RMW0+z9NOHpjUgVH5Hah8OkNIrDw3DfYExa
         TAhE6Fwnt/zO9gvLgD/DPSCvqKjk+78rHz8mnO5jT59EpXmVZ+KJfl93uZkM28qLV9YT
         EbjROmYq55R8cRYZnh4CDyi4HHpQ8u7xRwzmrFzLCNCx70WU8opSwfwbq8VDlUIWlB90
         1STyfi55OZD5hSCy6d0W5RguKz3b4PQ/C8qqq/YqvldpHaOchFXLp2GYFLejxN2UxeJm
         s45tvXPjF84lP5bgJXCD1YdY3Wfirc9DDN6Jzog+DhQn07xXuyPKSvZWdeRq4u7jSnnF
         UMWw==
X-Gm-Message-State: AOAM531Rc4rArwLOsGzo6N38w8J8nrgL1d+US7yvqhgREx/3BRjA15Ab
        VDXi4IKJpg03seTXACEyu7Jz4A==
X-Google-Smtp-Source: ABdhPJzii70hgI9WxNsa0W3mtiOK+ojMNv143IMEORek39kNaDq+Is1J2XOVdc38tt5Xp0/cnCoQsA==
X-Received: by 2002:a17:902:9a08:b029:ec:bef1:4ea1 with SMTP id v8-20020a1709029a08b02900ecbef14ea1mr3031465plp.78.1619752869504;
        Thu, 29 Apr 2021 20:21:09 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id t6sm405317pjl.57.2021.04.29.20.20.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Apr 2021 20:21:09 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v22 5/9] mm: hugetlb: defer freeing of HugeTLB pages
Date:   Fri, 30 Apr 2021 11:13:48 +0800
Message-Id: <20210430031352.45379-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210430031352.45379-1-songmuchun@bytedance.com>
References: <20210430031352.45379-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the subsequent patch, we should allocate the vmemmap pages when
freeing a HugeTLB page. But update_and_free_page() can be called
under any context, so we cannot use GFP_KERNEL to allocate vmemmap
pages. However, we can defer the actual freeing in a kworker to
prevent from using GFP_ATOMIC to allocate the vmemmap pages.

The __update_and_free_page() is where the call to allocate vmemmmap
pages will be inserted.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 83 +++++++++++++++++++++++++++++++++++++++++++++++-----
 mm/hugetlb_vmemmap.c | 12 --------
 mm/hugetlb_vmemmap.h | 17 +++++++++++
 3 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fd39fc94b23f..a3629c664f6a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1376,7 +1376,7 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	h->nr_huge_pages_node[nid]--;
 }
 
-static void update_and_free_page(struct hstate *h, struct page *page)
+static void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
 	struct page *subpage = page;
@@ -1399,12 +1399,79 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 	}
 }
 
+/*
+ * As update_and_free_page() can be called under any context, so we cannot
+ * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
+ * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
+ * the vmemmap pages.
+ *
+ * free_hpage_workfn() locklessly retrieves the linked list of pages to be
+ * freed and frees them one-by-one. As the page->mapping pointer is going
+ * to be cleared in free_hpage_workfn() anyway, it is reused as the llist_node
+ * structure of a lockless linked list of huge pages to be freed.
+ */
+static LLIST_HEAD(hpage_freelist);
+
+static void free_hpage_workfn(struct work_struct *work)
+{
+	struct llist_node *node;
+
+	node = llist_del_all(&hpage_freelist);
+
+	while (node) {
+		struct page *page;
+		struct hstate *h;
+
+		page = container_of((struct address_space **)node,
+				     struct page, mapping);
+		node = node->next;
+		page->mapping = NULL;
+		/*
+		 * The VM_BUG_ON_PAGE(!PageHuge(page), page) in page_hstate()
+		 * is going to trigger because a previous call to
+		 * remove_hugetlb_page() will set_compound_page_dtor(page,
+		 * NULL_COMPOUND_DTOR), so do not use page_hstate() directly.
+		 */
+		h = size_to_hstate(page_size(page));
+
+		__update_and_free_page(h, page);
+
+		cond_resched();
+	}
+}
+static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
+
+static inline void flush_free_hpage_work(struct hstate *h)
+{
+	if (free_vmemmap_pages_per_hpage(h))
+		flush_work(&free_hpage_work);
+}
+
+static void update_and_free_page(struct hstate *h, struct page *page,
+				 bool atomic)
+{
+	if (!free_vmemmap_pages_per_hpage(h) || !atomic) {
+		__update_and_free_page(h, page);
+		return;
+	}
+
+	/*
+	 * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap pages.
+	 *
+	 * Only call schedule_work() if hpage_freelist is previously
+	 * empty. Otherwise, schedule_work() had been called but the workfn
+	 * hasn't retrieved the list yet.
+	 */
+	if (llist_add((struct llist_node *)&page->mapping, &hpage_freelist))
+		schedule_work(&free_hpage_work);
+}
+
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct page *page, *t_page;
 
 	list_for_each_entry_safe(page, t_page, list, lru) {
-		update_and_free_page(h, page);
+		update_and_free_page(h, page, false);
 		cond_resched();
 	}
 }
@@ -1471,12 +1538,12 @@ void free_huge_page(struct page *page)
 	if (HPageTemporary(page)) {
 		remove_hugetlb_page(h, page, false);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
-		update_and_free_page(h, page);
+		update_and_free_page(h, page, true);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		remove_hugetlb_page(h, page, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
-		update_and_free_page(h, page);
+		update_and_free_page(h, page, true);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
@@ -1798,7 +1865,7 @@ int dissolve_free_huge_page(struct page *page)
 		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
 		spin_unlock_irq(&hugetlb_lock);
-		update_and_free_page(h, head);
+		update_and_free_page(h, head, false);
 		return 0;
 	}
 out:
@@ -2343,14 +2410,14 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Pages have been replaced, we can safely free the old one.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		update_and_free_page(h, old_page);
+		update_and_free_page(h, old_page, false);
 	}
 
 	return ret;
 
 free_new:
 	spin_unlock_irq(&hugetlb_lock);
-	update_and_free_page(h, new_page);
+	update_and_free_page(h, new_page, false);
 
 	return ret;
 }
@@ -2764,6 +2831,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * pages in hstate via the proc/sysfs interfaces.
 	 */
 	mutex_lock(&h->resize_lock);
+	flush_free_hpage_work(h);
 	spin_lock_irq(&hugetlb_lock);
 
 	/*
@@ -2873,6 +2941,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	/* free the pages after dropping lock */
 	spin_unlock_irq(&hugetlb_lock);
 	update_and_free_pages_bulk(h, &page_list);
+	flush_free_hpage_work(h);
 	spin_lock_irq(&hugetlb_lock);
 
 	while (count < persistent_huge_pages(h)) {
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index e45a138a7f85..cb28c5b6c9ff 100644
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

