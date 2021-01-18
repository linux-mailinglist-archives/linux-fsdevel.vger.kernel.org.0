Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514EF2FA753
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407042AbhARRUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391921AbhARRDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F7EC061795;
        Mon, 18 Jan 2021 09:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QtagCdqlQRSTNk83TE6iZzeshtghM/dQX9PoljD/GxI=; b=NHUggwmMfkx38kuG5SvJRxpVR6
        FYsVmuQLHbSJVFSXVNFO8MLK+5pkUCBJZpaVi/8jESUN7vQ7Wq0c6MHQL8hQ2BCmcVWtP9PNI6bzz
        95FsUNZtsAZ4F1G8fjg+rvNJyylih4YBWh10q1AeE097TLQwEfK5VWS70/xDCAWv6WhYrVUnfvrVI
        FUxEtk+APnGrR9NNyWD27mRadHobF0i/0wBo+aRtkwCXRy0fD0f/9XaEBVykTv698GiDaihlnmBvf
        VGK0O9yEKhKH6kYmr/Re1/400/oFkSGxwMgVjGeka1AJSqar1zGPZiXz4xShs03nmoo0uU8EZTteB
        31bZL/3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xuo-00D7J7-6s; Mon, 18 Jan 2021 17:02:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/27] mm/memcg: Add folio_memcg, lock_folio_memcg and unlock_folio_memcg
Date:   Mon, 18 Jan 2021 17:01:32 +0000
Message-Id: <20210118170148.3126186-12-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The memcontrol code already assumes that page_memcg() will be called
with a non-tail page, so make that more natural by wrapping it with a
folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 16 ++++++++++++++++
 mm/memcontrol.c            | 36 ++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7a38a1517a05..89aaa22506e6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -383,6 +383,11 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
+static inline struct mem_cgroup *folio_memcg(struct folio *folio)
+{
+	return page_memcg(&folio->page);
+}
+
 /*
  * page_memcg_rcu - locklessly get the memory cgroup associated with a page
  * @page: a pointer to the page struct
@@ -869,8 +874,10 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 extern bool cgroup_memory_noswap;
 #endif
 
+struct mem_cgroup *lock_folio_memcg(struct folio *folio);
 struct mem_cgroup *lock_page_memcg(struct page *page);
 void __unlock_page_memcg(struct mem_cgroup *memcg);
+void unlock_folio_memcg(struct folio *folio);
 void unlock_page_memcg(struct page *page);
 
 /*
@@ -1298,6 +1305,11 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
+static inline struct mem_cgroup *lock_folio_memcg(struct folio *folio)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *lock_page_memcg(struct page *page)
 {
 	return NULL;
@@ -1307,6 +1319,10 @@ static inline void __unlock_page_memcg(struct mem_cgroup *memcg)
 {
 }
 
+static inline void unlock_folio_memcg(struct folio *folio)
+{
+}
+
 static inline void unlock_page_memcg(struct page *page)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1b1ec0c1b6f8..d5ec868cd9f7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2140,19 +2140,18 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 /**
- * lock_page_memcg - lock a page and memcg binding
- * @page: the page
+ * lock_folio_memcg - lock a folio and memcg binding
+ * @folio: the folio
  *
- * This function protects unlocked LRU pages from being moved to
+ * This function protects unlocked LRU folios from being moved to
  * another cgroup.
  *
  * It ensures lifetime of the returned memcg. Caller is responsible
- * for the lifetime of the page; __unlock_page_memcg() is available
- * when @page might get freed inside the locked section.
+ * for the lifetime of the folio; __unlock_folio_memcg() is available
+ * when @folio might get freed inside the locked section.
  */
-struct mem_cgroup *lock_page_memcg(struct page *page)
+struct mem_cgroup *lock_folio_memcg(struct folio *folio)
 {
-	struct page *head = compound_head(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
 	unsigned long flags;
 
@@ -2172,7 +2171,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 	if (mem_cgroup_disabled())
 		return NULL;
 again:
-	memcg = page_memcg(head);
+	memcg = folio_memcg(folio);
 	if (unlikely(!memcg))
 		return NULL;
 
@@ -2186,7 +2185,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 		return memcg;
 
 	spin_lock_irqsave(&memcg->move_lock, flags);
-	if (memcg != page_memcg(head)) {
+	if (memcg != folio_memcg(folio)) {
 		spin_unlock_irqrestore(&memcg->move_lock, flags);
 		goto again;
 	}
@@ -2201,6 +2200,12 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 
 	return memcg;
 }
+EXPORT_SYMBOL(lock_folio_memcg);
+
+struct mem_cgroup *lock_page_memcg(struct page *page)
+{
+	return lock_folio_memcg(page_folio(page));
+}
 EXPORT_SYMBOL(lock_page_memcg);
 
 /**
@@ -2223,15 +2228,22 @@ void __unlock_page_memcg(struct mem_cgroup *memcg)
 	rcu_read_unlock();
 }
 
+/**
+ * unlock_folio_memcg - unlock a folio and memcg binding
+ * @folio: the folio
+ */
+void unlock_folio_memcg(struct folio *folio)
+{
+	__unlock_page_memcg(folio_memcg(folio));
+}
+
 /**
  * unlock_page_memcg - unlock a page and memcg binding
  * @page: the page
  */
 void unlock_page_memcg(struct page *page)
 {
-	struct page *head = compound_head(page);
-
-	__unlock_page_memcg(page_memcg(head));
+	unlock_folio_memcg(page_folio(page));
 }
 EXPORT_SYMBOL(unlock_page_memcg);
 
-- 
2.29.2

