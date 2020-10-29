Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7303129F568
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgJ2Tea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgJ2TeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F822C0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2Bn5b1P1ATGl/MqPbstL/ShGH6FmIS/ZdMSjQOY1lJ4=; b=GG08yJaqKcj195RpDR4Pd6vfkR
        aKZdXWtCjSMaAt8/DxgYYwzJoEUHTh6Mo3BGXx587A3pM9VPifVfz70pzEuLyJ3tEyDpU8EsjvZns
        1MQpV1Eb87bpv64/Pyl5Iz4nWnMm7gInAI5dNaGqWXF2CKJcbLKnIVuX1IN+9CpDy+H+cF63BpRAy
        KrBz5WxU75R48VKwmCaJG2wPop9AtlfB5mCVfxrsMWHliVanDoqRlkVnEfGO+L6V9NwNy3+2dNEAx
        L0yEknmsmX5I1kKvCvhIDSYp2ZyUiaEkC2ArZxVTUfE5FOURW8rhG/9G2eaIA2ScRm5kWCC9xoEDl
        QSvlDUxg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgX-0007c1-S2; Thu, 29 Oct 2020 19:34:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 09/19] mm/filemap: Allow THPs to be added to the page cache
Date:   Thu, 29 Oct 2020 19:33:55 +0000
Message-Id: <20201029193405.29125-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We return -EEXIST if there are any non-shadow entries in the page
cache in the range covered by the THP.  If there are multiple
shadow entries in the range, we set *shadowp to one of them (currently
the one at the highest index).  If that turns out to be the wrong
answer, we can implement something more complex.  This is mostly
modelled after the equivalent function in the shmem code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 64fe0018ee17..dabc26cf0067 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -811,23 +811,25 @@ noinline int __add_to_page_cache_locked(struct page *page,
 {
 	XA_STATE(xas, &mapping->i_pages, offset);
 	int huge = PageHuge(page);
-	int error;
+	unsigned int nr = 1;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
 	mapping_set_update(&xas, mapping);
 
-	get_page(page);
-	page->mapping = mapping;
-	page->index = offset;
-
 	if (!huge) {
-		error = mem_cgroup_charge(page, current->mm, gfp);
+		int error = mem_cgroup_charge(page, current->mm, gfp);
+
 		if (error)
-			goto error;
+			return error;
+		xas_set_order(&xas, offset, thp_order(page));
+		nr = thp_nr_pages(page);
 	}
 
 	gfp &= GFP_RECLAIM_MASK;
+	page_ref_add(page, nr);
+	page->mapping = mapping;
+	page->index = xas.xa_index;
 
 	do {
 		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
@@ -851,6 +853,8 @@ noinline int __add_to_page_cache_locked(struct page *page,
 			/* entry may have been split before we acquired lock */
 			order = xa_get_order(xas.xa, xas.xa_index);
 			if (order > thp_order(page)) {
+				/* How to handle large swap entries? */
+				BUG_ON(shmem_mapping(mapping));
 				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
@@ -860,27 +864,30 @@ noinline int __add_to_page_cache_locked(struct page *page,
 		if (xas_error(&xas))
 			goto unlock;
 
-		mapping->nrpages++;
+		mapping->nrpages += nr;
 
 		/* hugetlb pages do not participate in page cache accounting */
-		if (!huge)
-			__inc_lruvec_page_state(page, NR_FILE_PAGES);
+		if (!huge) {
+			__mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
+			if (nr > 1)
+				__mod_node_page_state(page_pgdat(page),
+						NR_FILE_THPS, nr);
+		}
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp));
 
-	if (xas_error(&xas)) {
-		error = xas_error(&xas);
+	if (xas_error(&xas))
 		goto error;
-	}
 
 	trace_mm_filemap_add_to_page_cache(page);
 	return 0;
 error:
 	page->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
-	put_page(page);
-	return error;
+	page_ref_sub(page, nr);
+	VM_BUG_ON_PAGE(page_count(page) <= 0, page);
+	return xas_error(&xas);
 }
 ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
 
-- 
2.28.0

