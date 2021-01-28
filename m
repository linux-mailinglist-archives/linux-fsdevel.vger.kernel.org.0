Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AFA30706A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhA1H5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhA1HFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:05:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C861C061793;
        Wed, 27 Jan 2021 23:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=S0uQo/Yk1v2sMp6b+mV5hXUQDMHIn5aK5Y5Umb7Odeo=; b=Ikx90UlcrKeK++Jncqw0KHmwCA
        OBhYSdnMutx+RpnvqwA78gNLYZpH7+monWhW1o2415pJGiXdtH7n4FXABCPd+GJEY7QYNhv4+54RZ
        YJQGlu04DFHIl3faqUeHdl7uEjMTM6Dr0hL48Ps6kA6O/a61qMdelr/EdvL7V0mPXmFNcMYS1dUIJ
        o0FN2khrWY6L34ySrQ+rdyILoWrRD6Y8XBCOzTP6rpk9qoLITezbo+0R5deeE/fFgUwSXKHg9hwX4
        iY1XIGrdNhJTllaYbfqa5hAFtET/kyeKmDkNT+G+jOe2fezzghFUylnGg7oT4A1ezcHrjhjdzNX3p
        SNuMxFmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Lr-00847d-Tp; Thu, 28 Jan 2021 07:04:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/25] mm/memcg: Add folio_memcg, lock_folio_memcg and unlock_folio_memcg
Date:   Thu, 28 Jan 2021 07:03:50 +0000
Message-Id: <20210128070404.1922318-12-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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
index ed5cc78a8dbf..c3c0c8124b09 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2139,19 +2139,18 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
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
 
@@ -2171,7 +2170,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 	if (mem_cgroup_disabled())
 		return NULL;
 again:
-	memcg = page_memcg(head);
+	memcg = folio_memcg(folio);
 	if (unlikely(!memcg))
 		return NULL;
 
@@ -2185,7 +2184,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 		return memcg;
 
 	spin_lock_irqsave(&memcg->move_lock, flags);
-	if (memcg != page_memcg(head)) {
+	if (memcg != folio_memcg(folio)) {
 		spin_unlock_irqrestore(&memcg->move_lock, flags);
 		goto again;
 	}
@@ -2200,6 +2199,12 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 
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
@@ -2222,15 +2227,22 @@ void __unlock_page_memcg(struct mem_cgroup *memcg)
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

