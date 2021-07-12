Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E33C41DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhGLDbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhGLDbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:31:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79435C0613DD;
        Sun, 11 Jul 2021 20:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CNMLwGuffYYGTGbDG5P9YD1h4bepOLQJbVfrPxpXyxI=; b=VqBMC9ZcQB4G3FKNNfO4vjpNjV
        v6XyLLcZtePMmswT2TxIay1G9a8oo9iZZMkkyo2RLA5oYE/I6SACZL9avwucJV8FZT42aqIPqa05S
        0bBohmJLcHj9vJgc6wExoiT9PqbCtCdYqLblmUDec34VC9sOxHnjztj3iJlcRpsRMAjMd/XCIRJKq
        SAlJPy4E0AX3Fxh6g+gcMisFC4al8mJBNQQ0L/KwjnpZkqlrMmFCHpK6ngqhm/3SDHHXQicOxsEYq
        v9Bvm2qGRlVxDBI8l+3ypFk6EjWPzLtirSR4gdtYkFnLhV05Cs1qsOKNXYp0NbiYsLEQWiztQ4C1e
        FenTTEuA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mc4-00GoIU-DS; Mon, 12 Jul 2021 03:28:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v13 039/137] mm/memcg: Convert commit_charge() to take a folio
Date:   Mon, 12 Jul 2021 04:05:23 +0100
Message-Id: <20210712030701.4000097-40-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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

