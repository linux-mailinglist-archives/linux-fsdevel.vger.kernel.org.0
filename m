Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9A3C9864
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbhGOFaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGOFaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:30:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56101C06175F;
        Wed, 14 Jul 2021 22:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TkqtaN/E6Kzx072f6Xp9TqqLdQXoLJDrAXZBAqFQCyE=; b=FFwiokBZsoI4/L4BWe1/8l6S1A
        qSIUZAkTIRCU7OFhnaNX+JwyVcLWp91BdbcvtC1hEmgzXZgTwGEOdHaCVhcg5x8l3h7Q/vl+kAIHZ
        0E3VQOW/DlEbLr+OcKrd2lnX1c+Y6QT5woDEC95NhiwHA+ErY7P6D+qKLApeBdVOBH9JjHI8GU4nA
        DkAOXq1bjYEfjdEMTbVL9EMY+tu6bBfoZv89o/GvbTax4jMPFoNkH+93TrJBV1V0iWVTBJmSBW7xA
        +sDur43P5eJp8D+CTs160EDeOnsV5ugIkJygxEINKNV42LcfT0kwZJ8gCOO6djS6HX8IVwEN9I18R
        QnwTUszQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tt3-00318U-8H; Thu, 15 Jul 2021 05:26:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 135/138] mm/filemap: Allow multi-page folios to be added to the page cache
Date:   Thu, 15 Jul 2021 04:37:01 +0100
Message-Id: <20210715033704.692967-136-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
 mm/filemap.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d5787502c3be..1ff21b3346d3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -848,26 +848,27 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int huge = folio_test_hugetlb(folio);
-	int error;
 	bool charged = false;
+	unsigned int nr = 1;
 
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
@@ -891,6 +892,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 			/* entry may have been split before we acquired lock */
 			order = xa_get_order(xas.xa, xas.xa_index);
 			if (order > folio_order(folio)) {
+				/* How to handle large swap entries? */
+				BUG_ON(shmem_mapping(mapping));
 				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
@@ -900,29 +903,32 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		if (xas_error(&xas))
 			goto unlock;
 
-		mapping->nrpages++;
+		mapping->nrpages += nr;
 
 		/* hugetlb pages do not participate in page cache accounting */
-		if (!huge)
-			__lruvec_stat_add_folio(folio, NR_FILE_PAGES);
+		if (!huge) {
+			__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
+			if (nr > 1)
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
 
 	trace_mm_filemap_add_to_page_cache(&folio->page);
 	return 0;
 error:
+	if (charged)
+		mem_cgroup_uncharge(folio);
 	folio->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
-	folio_put(folio);
-	return error;
+	folio_ref_sub(folio, nr);
+	VM_BUG_ON_FOLIO(folio_ref_count(folio) <= 0, folio);
+	return xas_error(&xas);
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
-- 
2.30.2

