Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F24E2C87B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgK3PVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgK3PVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:21:08 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4911AC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:20:53 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b12so1566216pjl.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XlNyUom0PnuHIQiQo4ldJxgfjRtgFvL+VMXnHz2fArs=;
        b=IhU2Zv3Z5pBoEqwFOp2o/6bCEobuh9LdLbKbBz822Lyi1P+3mSGhbS+A3K2m+rblss
         vCVDVMzE4ykLJ2RrcGyuhcu33OK9ayT/d3G4p3RQKB5UcA5anpFfef3OE9tYRipSDLyh
         Blqw5iWKhkgaSgmH44exaBzGMD55fwn9Mb1+IJbw8mQllEUQI/ykfv4SpSTZtxeCASS1
         FFkBayT6DoAsG4FF1juYMoSS854gICN+LYpPnm+KKiNcdXypKEU8eKoKkvTcA6Tx4YTs
         P/FBrJUD0yFN4VG22NehR61k4C5lmRqAtWGF/yr1I5vTJHMRrE7stKuRw5d1lktD6Wim
         qKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XlNyUom0PnuHIQiQo4ldJxgfjRtgFvL+VMXnHz2fArs=;
        b=pZXAqSjgNP3JY+yTAXXBymrB8xEA+HtseSQ+P+KYyg1FKd51hNx7JxShfXULyQUYzs
         HjIQXrxY2k7y6hfzFzEUsnj9DU+rXjf5l/Lqtmr/5KN+9TcbJEclNJBfT+QhZOrXY4+w
         g2mdbg+hp7qCruUw/h/J3I0Y4++OIXToh4q8W+H1ykXx2ubhCgkb9M/SQSAswUBsCZr/
         mlqy5tRRKVw1K1Vf+09+jfoFWCtPBYPMqE4qCS4pC0GBp0KfPUlmTFAPjud3SIJs/2M+
         KZ8ExpXGp3kyQBPN2K5eFO/SEjVFn9mgysgyr8Wi6yAN0Do8SnQe41wWCSRRWibbYDbG
         PFyg==
X-Gm-Message-State: AOAM531X9hPooKnRTO+qybiuwpleDGVoWmRaehDwxNOGruKXBa0UyTQk
        YaTPEiI1hSAmGeORk8yIYw6JVg==
X-Google-Smtp-Source: ABdhPJx6bw73jGyt6PNniBABrrLrn66e8wznBT6G1oDmy1Qip01Fr+dAQuvMk9kdlfhq5oA+FlWb4Q==
X-Received: by 2002:a17:902:d34a:b029:da:861e:ecd8 with SMTP id l10-20020a170902d34ab02900da861eecd8mr2563726plk.45.1606749652810;
        Mon, 30 Nov 2020 07:20:52 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.20.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:20:52 -0800 (PST)
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
Subject: [PATCH v7 09/15] mm/hugetlb: Defer freeing of HugeTLB pages
Date:   Mon, 30 Nov 2020 23:18:32 +0800
Message-Id: <20201130151838.11208-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
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
index 93dee37ceb6d..5131ae3d2245 100644
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
@@ -1287,20 +1287,100 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
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
@@ -1312,14 +1392,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
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
index 2c997b5de3b6..af42fad1f131 100644
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

