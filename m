Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4943604A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 10:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhDOInj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 04:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhDOIni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:43:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B6AC06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 01:43:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so8106406pjb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwwWxcjL7/ZgriiZ7PmyesiU1nwrUlYRrkWxiyoK9uI=;
        b=uGVt48g0XVlIcaAbjG/DC3OyQg/WtSM/UNJw0xZQOs8v9zKnd0od2YBC9Vv6stjOIP
         TLnzQJ7j/n9/soHUp/1wLXLTxBO7+nVk/BsLcMHaHEAXmsEcXNS5ZfPLVJd5rgP/Im7t
         q0rKn6ob2GSNMv/mJHprkx/6bAf1fCxl4ke47jXre+E0QFEvmzzyXz6pMg5iSKM8+rNC
         hsLg9hp7TSpq2lOvp3tIyABbPkpve6lmJPhyfQN8h54/+f7XahG7Tn2yG33rVkfQ7D0Z
         ly3gvORZc13KKzhjNAat+N3ZUmrgpoP1XCUtJQmiQHAgtIe2xTGpUBlWB59dVMiohUO8
         eD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwwWxcjL7/ZgriiZ7PmyesiU1nwrUlYRrkWxiyoK9uI=;
        b=CD+AZWl4Nmj3fD+B4ETMwB2Bo1PrnDeiEjysw2rsR7TEDnp5KP1kY34ZU7P1tNPO1O
         QHiV6rvEYasuKVuodrGlvR8ghTSVBIQ0tlKWGpIHTvtqAMNHHXO2UT2aEY/c5x0B385X
         S+Ki7mkGgFyxLJdicsd9kW7r91J6CnI538WA4IzjwN4c2ikkmT21i0VpliulzYho1Am5
         zoiHeppMP+8nhfIm/LTqaTdMHcMXbK0opbdwS3TVFELgooHojTTgRCEB6S0zdbKujFJk
         X4cT87au3GZp/PsjVubX5uIpaRwel+TO2ewlIMlPi51MQdLSlRCjvS6igSLY0fSKJ6i1
         K8bg==
X-Gm-Message-State: AOAM532/KBAAMJcNN9OWFK/owogXGjZMpwxPp4C6g2LpYiBwoqae9gYo
        UgQ+VHh+gvvCXnk17tD8qc+J4A==
X-Google-Smtp-Source: ABdhPJyT6R/pSknWjXspgUSIfiX+ZW/dd+KcodopiAjEXv1L4FG3GBuVGWAEIWxO4wr8mNsGNaXa+g==
X-Received: by 2002:a17:902:7682:b029:eb:2900:ed69 with SMTP id m2-20020a1709027682b02900eb2900ed69mr2530505pll.53.1618476195259;
        Thu, 15 Apr 2021 01:43:15 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id e13sm1392365pgt.91.2021.04.15.01.43.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 01:43:14 -0700 (PDT)
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v20 5/9] mm: hugetlb: defer freeing of HugeTLB pages
Date:   Thu, 15 Apr 2021 16:40:01 +0800
Message-Id: <20210415084005.25049-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210415084005.25049-1-songmuchun@bytedance.com>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c         | 73 ++++++++++++++++++++++++++++++++++++++++++++++++----
 mm/hugetlb_vmemmap.c | 12 ---------
 mm/hugetlb_vmemmap.h | 17 ++++++++++++
 3 files changed, 85 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 923d05e2806b..eeb8f5480170 100644
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
@@ -1399,12 +1399,73 @@ static void update_and_free_page(struct hstate *h, struct page *page)
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
+		h = page_hstate(page);
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
@@ -1471,12 +1532,12 @@ void free_huge_page(struct page *page)
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
@@ -1785,7 +1846,7 @@ int dissolve_free_huge_page(struct page *page)
 		remove_hugetlb_page(h, page, false);
 		h->max_huge_pages--;
 		spin_unlock_irq(&hugetlb_lock);
-		update_and_free_page(h, head);
+		update_and_free_page(h, head, false);
 		return 0;
 	}
 out:
@@ -2627,6 +2688,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * pages in hstate via the proc/sysfs interfaces.
 	 */
 	mutex_lock(&h->resize_lock);
+	flush_free_hpage_work(h);
 	spin_lock_irq(&hugetlb_lock);
 
 	/*
@@ -2736,6 +2798,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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

