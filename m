Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B79A3C642C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbhGLTxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbhGLTxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:53:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8859C0613DD;
        Mon, 12 Jul 2021 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CNMLwGuffYYGTGbDG5P9YD1h4bepOLQJbVfrPxpXyxI=; b=kcTVqUUVY/6Cmyr5TvYXLUodmb
        jagegh+0MixoOn2eTpKIwt/DbD8eKfqLWFN/L1oTQEOVcK43uPh6JVuBRiAhyEq1BwTJDhHUEyIGj
        vse2U293w3LEU3X0QJQ/Mg7id0hJNsau0dXDfJ1yY1HSVN9LBOYG14xV8FZY3xFCxbOazwKjlMSBP
        +YFd2CCK5SaMmcoLFvVEClThrVI0yvKcRSKCCujvITw1DSwY0tOo3gxwHd6xU5qlQk6h5+8557sSH
        B4JpllXNCGjmGm5tOgxhi3P+04XJs3kJXwWIG81F2/9xv69zjDop+RA4WMtpxyJokJtuhg5O7WKAF
        a8RBgywA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31vf-000OCC-NO; Mon, 12 Jul 2021 19:49:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v13 07/18] mm/memcg: Convert commit_charge() to take a folio
Date:   Mon, 12 Jul 2021 20:45:40 +0100
Message-Id: <20210712194551.91920-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712194551.91920-1-willy@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The memcg_data is only set on the head page, so enforce that by
typing it as a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f0f781dde37a..f64869c0e06e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2769,9 +2769,9 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 }
 #endif
 
-static void commit_charge(struct page *page, struct mem_cgroup *memcg)
+static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 {
-	VM_BUG_ON_PAGE(page_memcg(page), page);
+	VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
 	/*
 	 * Any of the following ensures page's memcg stability:
 	 *
@@ -2780,7 +2780,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 	 * - lock_page_memcg()
 	 * - exclusive reference
 	 */
-	page->memcg_data = (unsigned long)memcg;
+	folio->memcg_data = (unsigned long)memcg;
 }
 
 static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
@@ -6684,7 +6684,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 			       gfp_t gfp)
 {
-	unsigned int nr_pages = thp_nr_pages(page);
+	struct folio *folio = page_folio(page);
+	unsigned int nr_pages = folio_nr_pages(folio);
 	int ret;
 
 	ret = try_charge(memcg, gfp, nr_pages);
@@ -6692,7 +6693,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 		goto out;
 
 	css_get(&memcg->css);
-	commit_charge(page, memcg);
+	commit_charge(folio, memcg);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
@@ -6952,21 +6953,21 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
  */
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 {
+	struct folio *newfolio = page_folio(newpage);
 	struct mem_cgroup *memcg;
-	unsigned int nr_pages;
+	unsigned int nr_pages = folio_nr_pages(newfolio);
 	unsigned long flags;
 
 	VM_BUG_ON_PAGE(!PageLocked(oldpage), oldpage);
-	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
-	VM_BUG_ON_PAGE(PageAnon(oldpage) != PageAnon(newpage), newpage);
-	VM_BUG_ON_PAGE(PageTransHuge(oldpage) != PageTransHuge(newpage),
-		       newpage);
+	VM_BUG_ON_FOLIO(!folio_locked(newfolio), newfolio);
+	VM_BUG_ON_FOLIO(PageAnon(oldpage) != folio_anon(newfolio), newfolio);
+	VM_BUG_ON_FOLIO(compound_nr(oldpage) != nr_pages, newfolio);
 
 	if (mem_cgroup_disabled())
 		return;
 
 	/* Page cache replacement: new page already charged? */
-	if (page_memcg(newpage))
+	if (folio_memcg(newfolio))
 		return;
 
 	memcg = page_memcg(oldpage);
@@ -6975,8 +6976,6 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 		return;
 
 	/* Force-charge the new page. The old one will be freed soon */
-	nr_pages = thp_nr_pages(newpage);
-
 	if (!mem_cgroup_is_root(memcg)) {
 		page_counter_charge(&memcg->memory, nr_pages);
 		if (do_memsw_account())
@@ -6984,7 +6983,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	}
 
 	css_get(&memcg->css);
-	commit_charge(newpage, memcg);
+	commit_charge(newfolio, memcg);
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-- 
2.30.2

