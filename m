Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07A3C9703
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhGOEQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbhGOEQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:16:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529DCC06175F;
        Wed, 14 Jul 2021 21:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7SMIlDbXKPWxLzuFnfZFts4v50wHRfeaO4Y4aZlCsWU=; b=MS1ehyKqO/+QGbr7/SKPVCvJv2
        J+7FyHQyPVd6mECMoRQjvoacC5SIbNpviHhN2fh5vbzPDmwYoQWcp+a+4993J290fGZ+89kOQqo22
        Xt7xBgD7nJHfpdCOgHnTW9o8fnqVh4k5hhzRELA9JqzFsYlrgwd1h8T10nF89w4U2xfce2Llf3JC5
        Zxvm0cANkk+ETbGQoA+lq8M9Irgz8NwFIf2i7gA1G9srXvRF7PpjLf8OKmIYV8KXEWZLqlJSIZqhO
        unNQ1VYUQ52jij5oARMzBqxXXL1hrPv48ODgo/dPY94qbF2wmEve0xRfeWcREdxJS0G/KrSkNgMF5
        BVx7qebA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sjm-002wO1-3X; Thu, 15 Jul 2021 04:12:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 045/138] mm/memcg: Add folio_memcg_lock() and folio_memcg_unlock()
Date:   Thu, 15 Jul 2021 04:35:31 +0100
Message-Id: <20210715033704.692967-46-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are the folio equivalents of lock_page_memcg() and
unlock_page_memcg().

lock_page_memcg() and unlock_page_memcg() have too many callers to be
easily replaced in a single patch, so reimplement them as wrappers for
now to be cleaned up later when enough callers have been converted to
use folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memcontrol.h | 10 +++++++++
 mm/memcontrol.c            | 45 ++++++++++++++++++++++++--------------
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20084c47d2ca..4b79dd6b3a9c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -950,6 +950,8 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 extern bool cgroup_memory_noswap;
 #endif
 
+void folio_memcg_lock(struct folio *folio);
+void folio_memcg_unlock(struct folio *folio);
 void lock_page_memcg(struct page *page);
 void unlock_page_memcg(struct page *page);
 
@@ -1367,6 +1369,14 @@ static inline void unlock_page_memcg(struct page *page)
 {
 }
 
+static inline void folio_memcg_lock(struct folio *folio)
+{
+}
+
+static inline void folio_memcg_unlock(struct folio *folio)
+{
+}
+
 static inline void mem_cgroup_handle_over_high(void)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 96c34357fbca..0dd40ea67a90 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1965,18 +1965,17 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 /**
- * lock_page_memcg - lock a page and memcg binding
- * @page: the page
+ * folio_memcg_lock - Bind a folio to its memcg.
+ * @folio: The folio.
  *
- * This function protects unlocked LRU pages from being moved to
+ * This function prevents unlocked LRU folios from being moved to
  * another cgroup.
  *
- * It ensures lifetime of the locked memcg. Caller is responsible
- * for the lifetime of the page.
+ * It ensures lifetime of the bound memcg.  The caller is responsible
+ * for the lifetime of the folio.
  */
-void lock_page_memcg(struct page *page)
+void folio_memcg_lock(struct folio *folio)
 {
-	struct page *head = compound_head(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
 	unsigned long flags;
 
@@ -1990,7 +1989,7 @@ void lock_page_memcg(struct page *page)
 	if (mem_cgroup_disabled())
 		return;
 again:
-	memcg = page_memcg(head);
+	memcg = folio_memcg(folio);
 	if (unlikely(!memcg))
 		return;
 
@@ -2004,7 +2003,7 @@ void lock_page_memcg(struct page *page)
 		return;
 
 	spin_lock_irqsave(&memcg->move_lock, flags);
-	if (memcg != page_memcg(head)) {
+	if (memcg != folio_memcg(folio)) {
 		spin_unlock_irqrestore(&memcg->move_lock, flags);
 		goto again;
 	}
@@ -2018,9 +2017,15 @@ void lock_page_memcg(struct page *page)
 	memcg->move_lock_task = current;
 	memcg->move_lock_flags = flags;
 }
+EXPORT_SYMBOL(folio_memcg_lock);
+
+void lock_page_memcg(struct page *page)
+{
+	folio_memcg_lock(page_folio(page));
+}
 EXPORT_SYMBOL(lock_page_memcg);
 
-static void __unlock_page_memcg(struct mem_cgroup *memcg)
+static void __folio_memcg_unlock(struct mem_cgroup *memcg)
 {
 	if (memcg && memcg->move_lock_task == current) {
 		unsigned long flags = memcg->move_lock_flags;
@@ -2035,14 +2040,22 @@ static void __unlock_page_memcg(struct mem_cgroup *memcg)
 }
 
 /**
- * unlock_page_memcg - unlock a page and memcg binding
- * @page: the page
+ * folio_memcg_unlock - Release the binding between a folio and its memcg.
+ * @folio: The folio.
+ *
+ * This releases the binding created by folio_memcg_lock().  This does
+ * not change the accounting of this folio to its memcg, but it does
+ * permit others to change it.
  */
-void unlock_page_memcg(struct page *page)
+void folio_memcg_unlock(struct folio *folio)
 {
-	struct page *head = compound_head(page);
+	__folio_memcg_unlock(folio_memcg(folio));
+}
+EXPORT_SYMBOL(folio_memcg_unlock);
 
-	__unlock_page_memcg(page_memcg(head));
+void unlock_page_memcg(struct page *page)
+{
+	folio_memcg_unlock(page_folio(page));
 }
 EXPORT_SYMBOL(unlock_page_memcg);
 
@@ -5666,7 +5679,7 @@ static int mem_cgroup_move_account(struct page *page,
 
 	page->memcg_data = (unsigned long)to;
 
-	__unlock_page_memcg(from);
+	__folio_memcg_unlock(from);
 
 	ret = 0;
 	nid = page_to_nid(page);
-- 
2.30.2

