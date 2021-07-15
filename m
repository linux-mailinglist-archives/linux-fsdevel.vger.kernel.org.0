Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F6E3C9706
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhGOER4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhGOERz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:17:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CEC06175F;
        Wed, 14 Jul 2021 21:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5j2X8nBiTF1CrIxwWHedWUAM3oUKCMvVlZFvZear/v0=; b=nQgqCL3M6qTgq6k0o7ut2tLqLF
        hH+PfA6JrVnEIHHtnbjJr0HBTE1SHmMtQ8TTzgiIKT306JFp9jk0zgdodcDF25u2siajORCpPkFdi
        PE+lHbB2QMJY0vZlZyUDpIgeNaiBvAU5Ug7v1xOsV0XUzXwos7hLoHSaX+SEOXDjmhm9S8lBJ6cQO
        GpQxddk1pPGyz5dkdhbqoTyOjunx3tNMFkRiJiTu7MKO6kpCNsqCP5+gMzXQX0wwAqAIq4vSqvlff
        TSDOvei9UPx9rf9bJBO7bX0no7SclplfF+bMQCN2BPIv63eJ0sY7Kq4Lqusa5MZ+x10ysZT/3iQnR
        DzWfg68A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3skN-002wQz-S6; Thu, 15 Jul 2021 04:13:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 046/138] mm/memcg: Convert mem_cgroup_move_account() to use a folio
Date:   Thu, 15 Jul 2021 04:35:32 +0100
Message-Id: <20210715033704.692967-47-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This saves dozens of bytes of text by eliminating a lot of calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/memcontrol.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0dd40ea67a90..96d6e6c0a65d 100644
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
+	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
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
+	if (folio_test_anon(folio)) {
+		if (folio_mapped(folio)) {
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
-			if (PageTransHuge(page)) {
+			if (folio_test_transhuge(folio)) {
 				__mod_lruvec_state(from_vec, NR_ANON_THPS,
 						   -nr_pages);
 				__mod_lruvec_state(to_vec, NR_ANON_THPS,
@@ -5632,18 +5633,18 @@ static int mem_cgroup_move_account(struct page *page,
 		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
 		__mod_lruvec_state(to_vec, NR_FILE_PAGES, nr_pages);
 
-		if (PageSwapBacked(page)) {
+		if (folio_test_swapbacked(folio)) {
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
+		if (folio_test_dirty(folio)) {
+			struct address_space *mapping = folio_mapping(folio);
 
 			if (mapping_can_writeback(mapping)) {
 				__mod_lruvec_state(from_vec, NR_FILE_DIRTY,
@@ -5654,7 +5655,7 @@ static int mem_cgroup_move_account(struct page *page,
 		}
 	}
 
-	if (PageWriteback(page)) {
+	if (folio_test_writeback(folio)) {
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

