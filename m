Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98693D7E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 21:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhG0TAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 15:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhG0TAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:00:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF69C061760;
        Tue, 27 Jul 2021 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KJh1YGLQQby8vB5k5T0j2GsK3k7vLYxKnZAJqgHTZHY=; b=ChNHl5IpLnGyCa4huJMFPteYrD
        GrtANyv5wgECPCMYaO9XlvyY0IzemNSYbxfbHmOOZl0gv8Fa7JIbWCOWcdLtrC3BQu8iaAYkNK+hc
        NFFDfJ0DhfklH7d+uitlrJyTf9lw8PwqILXifsKl71xOYIW2wx/NdFq1K8+H4TawUT1kenLvcgbM/
        VQ9TSn5VHcZIwUFTawSfwJbO+mm6M8rIZx4o0JfFY0Cu5zYJA9Rk8CT70ZT8BKZl02yJDUhv+jl2p
        G+vHlCgynqxg94KEsC1O+YOlRW82rv3ILGczH+1H1Vh5GmV82zbXU9yAFoItaEX6jmik8ZkxUSZB4
        okb41tJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8SIr-00FJmH-50; Tue, 27 Jul 2021 18:59:50 +0000
Date:   Tue, 27 Jul 2021 19:59:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: folio_nr_pages returning long
Message-ID: <YQBXoTyJHB99oTnw@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As noted by Nick, the following pattern:

unsigned int nr = ...;

mod_zone_page_state(x, y, -nr);

is buggy and will cause the page stats to be _increased_ by about 4
billion instead of decreased by a small number.  I have audited the
for-next branch and found a few bugs of this type.  I have also
changed a few other places to use 'long nr' so that people who
copy-and-paste don't get it wrong.  Theoretically, this means that
we now support folio sizes beyond 16TB, but that would be a ridiculous
thing to do (other limitations that exist currently are that we can
only allocate folios up to order 10, and we can only perform IO on
folios smaller than 4GB).  I think using 'int nr' would be safe
everywhere, but why make the compiler narrow the return value?

In lieu of reposting the entire series, here's the diff between
the previous and the next for-next:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52796adf7a2f..dc80039be60e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1667,9 +1667,9 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
  * folio_nr_pages - The number of pages in the folio.
  * @folio: The folio.
  *
- * Return: A number which is a power of two.
+ * Return: A number which is a non-negative power of two.
  */
-static inline unsigned long folio_nr_pages(struct folio *folio)
+static inline long folio_nr_pages(struct folio *folio)
 {
 	return compound_nr(&folio->page);
 }
@@ -1733,8 +1733,10 @@ static inline int arch_make_page_accessible(struct page *page)
 #ifndef HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
 static inline int arch_make_folio_accessible(struct folio *folio)
 {
-	int ret, i;
-	for (i = 0; i < folio_nr_pages(folio); i++) {
+	int ret;
+	long i, nr = folio_nr_pages(folio);
+
+	for (i = 0; i < nr; i++) {
 		ret = arch_make_page_accessible(folio_page(folio, i));
 		if (ret)
 			break;
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index d39537c5471b..e2ec68b0515c 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -32,7 +32,7 @@ static inline int page_is_file_lru(struct page *page)
 
 static __always_inline void update_lru_size(struct lruvec *lruvec,
 				enum lru_list lru, enum zone_type zid,
-				int nr_pages)
+				long nr_pages)
 {
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1aeeb4437ffd..9a018ac7defc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6693,7 +6693,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
-	unsigned int nr_pages = folio_nr_pages(folio);
+	long nr_pages = folio_nr_pages(folio);
 	int ret;
 
 	ret = try_charge(memcg, gfp, nr_pages);
@@ -6847,7 +6847,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 
 static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 {
-	unsigned long nr_pages;
+	long nr_pages;
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
 	bool use_objcg = folio_memcg_kmem(folio);
@@ -6962,7 +6962,7 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
 void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
 	struct mem_cgroup *memcg;
-	unsigned int nr_pages = folio_nr_pages(new);
+	long nr_pages = folio_nr_pages(new);
 	unsigned long flags;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
diff --git a/mm/migrate.c b/mm/migrate.c
index 36cdae0a1235..c96d7a78a2f4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -383,7 +383,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 	struct zone *oldzone, *newzone;
 	int dirty;
 	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
-	int nr = folio_nr_pages(folio);
+	long nr = folio_nr_pages(folio);
 
 	if (!mapping) {
 		/* Anonymous page without mapping */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c2987f05c944..987a2f2efe81 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2547,7 +2547,7 @@ void folio_account_redirty(struct folio *folio)
 		struct inode *inode = mapping->host;
 		struct bdi_writeback *wb;
 		struct wb_lock_cookie cookie = {};
-		unsigned nr = folio_nr_pages(folio);
+		long nr = folio_nr_pages(folio);
 
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 		current->nr_dirtied -= nr;
@@ -2574,7 +2574,7 @@ bool folio_redirty_for_writepage(struct writeback_control *wbc,
 		struct folio *folio)
 {
 	bool ret;
-	unsigned nr = folio_nr_pages(folio);
+	long nr = folio_nr_pages(folio);
 
 	wbc->pages_skipped += nr;
 	ret = filemap_dirty_folio(folio->mapping, folio);
diff --git a/mm/swap.c b/mm/swap.c
index 6f382abeccf9..ebd1bdd80b45 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -324,7 +324,7 @@ void lru_note_cost_folio(struct folio *folio)
 static void __folio_activate(struct folio *folio, struct lruvec *lruvec)
 {
 	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
-		int nr_pages = folio_nr_pages(folio);
+		long nr_pages = folio_nr_pages(folio);
 
 		lruvec_del_folio(lruvec, folio);
 		folio_set_active(folio);
@@ -1004,7 +1004,7 @@ EXPORT_SYMBOL(__pagevec_release);
 static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
 {
 	int was_unevictable = folio_test_clear_unevictable(folio);
-	int nr_pages = folio_nr_pages(folio);
+	long nr_pages = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
diff --git a/mm/util.c b/mm/util.c
index a0e859def6a8..b57fb165f761 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -649,7 +649,7 @@ void *page_rmapping(struct page *page)
  */
 bool folio_mapped(struct folio *folio)
 {
-	int i, nr;
+	long i, nr;
 
 	if (folio_single(folio))
 		return atomic_read(&folio->_mapcount) >= 0;
@@ -730,8 +730,8 @@ EXPORT_SYMBOL_GPL(__page_mapcount);
 
 void folio_copy(struct folio *dst, struct folio *src)
 {
-	unsigned i = 0;
-	unsigned nr = folio_nr_pages(src);
+	long i = 0;
+	long nr = folio_nr_pages(src);
 
 	for (;;) {
 		copy_highpage(folio_page(dst, i), folio_page(src, i));
@@ -1064,12 +1064,10 @@ EXPORT_SYMBOL(page_offline_end);
 #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
 void flush_dcache_folio(struct folio *folio)
 {
-	unsigned int n = folio_nr_pages(folio);
+	long i, nr = folio_nr_pages(folio);
 
-	do {
-		n--;
-		flush_dcache_page(folio_page(folio, n));
-	} while (n);
+	for (i = 0; i < nr; i++)
+		flush_dcache_page(folio_page(folio, i));
 }
 EXPORT_SYMBOL(flush_dcache_folio);
 #endif

