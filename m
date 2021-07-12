Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AC93C41ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhGLDf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLDf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:35:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5553DC0613DD;
        Sun, 11 Jul 2021 20:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D4GN68IbqyrLylaG0DbF380TGWbw4p/E2Sxd5WvWPQg=; b=p12FBMt8Xf7VjqOMrSyPm4aO92
        cdReMOgebBxkq2SynRS4dmoll9K6hG7hLnHPzoNLBoKLG0llcmhp7HS0+5KN0My/Hje0D56RfQQDW
        7WP8tAzU59FEQBeds+ZKVxGVVTsTCPoEtHlSQ48fCCKRqePHd0R3bvLbZW9vKlpTOVViACY5FnYXz
        EoO1i7sCX+EHZyORrm+6xskNVXM8k4ycOIFeeLIVvtIkM6FbyV/v2owEXXcCGmyd4cWDkJVl7ZyF+
        OC0TEUSYkx8hyCIUIz2cSxUxksPCW9IPj/RzI9Q0ii/RdO7v8n+pqoJYeq4xOsNt+q3VLhCL1juH4
        UMbKSjtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mfW-00GoWW-Gl; Mon, 12 Jul 2021 03:31:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 046/137] mm/memcg: Convert mem_cgroup_move_account() to use a folio
Date:   Mon, 12 Jul 2021 04:05:30 +0100
Message-Id: <20210712030701.4000097-47-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves dozens of bytes of text by eliminating a lot of calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cff267c59f4d..63cebdd48c27 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5590,38 +5590,39 @@ static int mem_cgroup_move_account(struct page *page,
 				   struct mem_cgroup *from,
 				   struct mem_cgroup *to)
 {
+	struct folio *folio = page_folio(page);
 	struct lruvec *from_vec, *to_vec;
 	struct pglist_data *pgdat;
-	unsigned int nr_pages = compound ? thp_nr_pages(page) : 1;
+	unsigned int nr_pages = compound ? folio_nr_pages(folio) : 1;
 	int nid, ret;
 
 	VM_BUG_ON(from == to);
-	VM_BUG_ON_PAGE(PageLRU(page), page);
-	VM_BUG_ON(compound && !PageTransHuge(page));
+	VM_BUG_ON_FOLIO(folio_lru(folio), folio);
+	VM_BUG_ON(compound && !folio_multi(folio));
 
 	/*
 	 * Prevent mem_cgroup_migrate() from looking at
 	 * page's memory cgroup of its source page while we change it.
 	 */
 	ret = -EBUSY;
-	if (!trylock_page(page))
+	if (!folio_trylock(folio))
 		goto out;
 
 	ret = -EINVAL;
-	if (page_memcg(page) != from)
+	if (folio_memcg(folio) != from)
 		goto out_unlock;
 
-	pgdat = page_pgdat(page);
+	pgdat = folio_pgdat(folio);
 	from_vec = mem_cgroup_lruvec(from, pgdat);
 	to_vec = mem_cgroup_lruvec(to, pgdat);
 
-	lock_page_memcg(page);
+	folio_memcg_lock(folio);
 
-	if (PageAnon(page)) {
-		if (page_mapped(page)) {
+	if (folio_anon(folio)) {
+		if (folio_mapped(folio)) {
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
-			if (PageTransHuge(page)) {
+			if (folio_transhuge(folio)) {
 				__mod_lruvec_state(from_vec, NR_ANON_THPS,
 						   -nr_pages);
 				__mod_lruvec_state(to_vec, NR_ANON_THPS,
@@ -5632,18 +5633,18 @@ static int mem_cgroup_move_account(struct page *page,
 		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
 		__mod_lruvec_state(to_vec, NR_FILE_PAGES, nr_pages);
 
-		if (PageSwapBacked(page)) {
+		if (folio_swapbacked(folio)) {
 			__mod_lruvec_state(from_vec, NR_SHMEM, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_SHMEM, nr_pages);
 		}
 
-		if (page_mapped(page)) {
+		if (folio_mapped(folio)) {
 			__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
 		}
 
-		if (PageDirty(page)) {
-			struct address_space *mapping = page_mapping(page);
+		if (folio_dirty(folio)) {
+			struct address_space *mapping = folio_mapping(folio);
 
 			if (mapping_can_writeback(mapping)) {
 				__mod_lruvec_state(from_vec, NR_FILE_DIRTY,
@@ -5654,7 +5655,7 @@ static int mem_cgroup_move_account(struct page *page,
 		}
 	}
 
-	if (PageWriteback(page)) {
+	if (folio_writeback(folio)) {
 		__mod_lruvec_state(from_vec, NR_WRITEBACK, -nr_pages);
 		__mod_lruvec_state(to_vec, NR_WRITEBACK, nr_pages);
 	}
@@ -5677,12 +5678,12 @@ static int mem_cgroup_move_account(struct page *page,
 	css_get(&to->css);
 	css_put(&from->css);
 
-	page->memcg_data = (unsigned long)to;
+	folio->memcg_data = (unsigned long)to;
 
 	__folio_memcg_unlock(from);
 
 	ret = 0;
-	nid = page_to_nid(page);
+	nid = folio_nid(folio);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(to, nr_pages);
@@ -5691,7 +5692,7 @@ static int mem_cgroup_move_account(struct page *page,
 	memcg_check_events(from, nid);
 	local_irq_enable();
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 out:
 	return ret;
 }
-- 
2.30.2

