Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A262373F3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhEEQKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhEEQKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:10:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA62C061761;
        Wed,  5 May 2021 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N3vydzOWjmmFG0R2cR1PHRr8tSeV8Ri5it/enNyGnko=; b=h2Ljs0CdxLLhk81NSb2HlkOV4l
        +rUWbc5CcPjWh8r+R3mPj7LtVCNJtWgVn6/f9UQLIHWbtzw3Jf/zgHS4W783TjRXjPdG3YJRlF/oV
        CzQp/HKFAqBjAn611jTAr8HYL+bS34QtgT7PEy3CrxCqDQBy1KyMJlykZyz645IBZlNlmtuPNlnj5
        hpG3w7XKFY3TJpmYMOxaD3rc7sIW63LiBezaBdR6ifRdGjjtXYvIXnIAUrcq22FJIjqdEboxNFLUK
        e5OqgPhSXGquxJ9xsJSTGYD8b9oXME+TsraMSMxZ3+VSHB7lcwhqalBfkTZH19cW9JJAtBfBXeHUC
        nP22DjLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leK41-000Z9v-Fr; Wed, 05 May 2021 16:08:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 50/96] mm/memcg: Convert commit_charge to take a folio
Date:   Wed,  5 May 2021 16:05:42 +0100
Message-Id: <20210505150628.111735-51-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The memcg_data is only set on the head page, so enforce that by
typing it as a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7423cb11eb88..5493e094e9e9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2700,9 +2700,9 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
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
@@ -2711,7 +2711,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 	 * - lock_page_memcg()
 	 * - exclusive reference
 	 */
-	page->memcg_data = (unsigned long)memcg;
+	folio->memcg_data = (unsigned long)memcg;
 }
 
 static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
@@ -6506,7 +6506,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 			       gfp_t gfp)
 {
-	unsigned int nr_pages = thp_nr_pages(page);
+	struct folio *folio = page_folio(page);
+	unsigned int nr_pages = folio_nr_pages(folio);
 	int ret;
 
 	ret = try_charge(memcg, gfp, nr_pages);
@@ -6514,7 +6515,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 		goto out;
 
 	css_get(&memcg->css);
-	commit_charge(page, memcg);
+	commit_charge(folio, memcg);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
@@ -6771,21 +6772,22 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
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
+	VM_BUG_ON_FOLIO(compound_nr(oldpage) != folio_nr_pages(newfolio),
+		       newfolio);
 
 	if (mem_cgroup_disabled())
 		return;
 
 	/* Page cache replacement: new page already charged? */
-	if (page_memcg(newpage))
+	if (folio_memcg(newfolio))
 		return;
 
 	memcg = page_memcg(oldpage);
@@ -6794,14 +6796,12 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 		return;
 
 	/* Force-charge the new page. The old one will be freed soon */
-	nr_pages = thp_nr_pages(newpage);
-
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
 
 	css_get(&memcg->css);
-	commit_charge(newpage, memcg);
+	commit_charge(newfolio, memcg);
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-- 
2.30.2

