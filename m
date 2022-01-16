Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598A348FCAA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiAPMSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiAPMSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2474FC061748;
        Sun, 16 Jan 2022 04:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xWU6598e4aJ6j8LBEVFg/+CSnDbanOj2pq/9yym6seM=; b=rbCpPuUDrtplvD2Re5I4f0vZpA
        U64QaNgvTkA4w7eHgfz8wtBAHipbF1+rombZMLPZ0A0OpcrMIhbjhJi+/wqXOjtE4HCQXb0Tp1PAt
        s0cihpaRBiw3iAZ5b/GDNR2di8Wo8QfKwG9AkbJKJJyiSJiMXUp0OIs5VuZhEhaz6KyIDcknXkq2X
        Md/yv9peIyIAKv4n4m9E5wGIjb6KtQiQuqYWD7FoW92q6OLgQGm9bF2XQTi22bSyjQFIatQbOwK4/
        yvtahBz8MDpJjdQMLu/6U409X+RBe4eEwsc+5gy/UVgoJE1WxLOIhiV+TnmZeEKOhnj1+4oxpQUNM
        0/FFx7JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UM-007FUF-Af; Sun, 16 Jan 2022 12:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 03/12] filemap: Allow large folios to be added to the page cache
Date:   Sun, 16 Jan 2022 12:18:13 +0000
Message-Id: <20220116121822.1727633-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We return -EEXIST if there are any non-shadow entries in the page
cache in the range covered by the folio.  If there are multiple
shadow entries in the range, we set *shadowp to one of them (currently
the one at the highest index).  If that turns out to be the wrong
answer, we can implement something more complex.  This is mostly
modelled after the equivalent function in the shmem code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index afc8f5ca85ac..fe079b676ab7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -851,26 +851,27 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int huge = folio_test_hugetlb(folio);
-	int error;
 	bool charged = false;
+	long nr = 1;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
 	mapping_set_update(&xas, mapping);
 
-	folio_get(folio);
-	folio->mapping = mapping;
-	folio->index = index;
-
 	if (!huge) {
-		error = mem_cgroup_charge(folio, NULL, gfp);
+		int error = mem_cgroup_charge(folio, NULL, gfp);
 		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
-			goto error;
+			return error;
 		charged = true;
+		xas_set_order(&xas, index, folio_order(folio));
+		nr = folio_nr_pages(folio);
 	}
 
 	gfp &= GFP_RECLAIM_MASK;
+	folio_ref_add(folio, nr);
+	folio->mapping = mapping;
+	folio->index = xas.xa_index;
 
 	do {
 		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
@@ -894,6 +895,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 			/* entry may have been split before we acquired lock */
 			order = xa_get_order(xas.xa, xas.xa_index);
 			if (order > folio_order(folio)) {
+				/* How to handle large swap entries? */
+				BUG_ON(shmem_mapping(mapping));
 				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
@@ -903,29 +906,31 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		if (xas_error(&xas))
 			goto unlock;
 
-		mapping->nrpages++;
+		mapping->nrpages += nr;
 
 		/* hugetlb pages do not participate in page cache accounting */
-		if (!huge)
-			__lruvec_stat_add_folio(folio, NR_FILE_PAGES);
+		if (!huge) {
+			__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
+			if (folio_test_pmd_mappable(folio))
+				__lruvec_stat_mod_folio(folio,
+						NR_FILE_THPS, nr);
+		}
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp));
 
-	if (xas_error(&xas)) {
-		error = xas_error(&xas);
-		if (charged)
-			mem_cgroup_uncharge(folio);
+	if (xas_error(&xas))
 		goto error;
-	}
 
 	trace_mm_filemap_add_to_page_cache(folio);
 	return 0;
 error:
+	if (charged)
+		mem_cgroup_uncharge(folio);
 	folio->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
-	folio_put(folio);
-	return error;
+	folio_put_refs(folio, nr);
+	return xas_error(&xas);
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
-- 
2.34.1

