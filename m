Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD53A1BDF30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgD2NlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgD2NhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E357AC09B054;
        Wed, 29 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7CmfqOJK6S19EckditoMkvWvGLDrCQNnv0HgEdn9l3o=; b=DtXWrjwccPuY+GQBBQ67oO8Rk9
        4MsYFoEsxJaT+XuKLfigNfQvaAGeyc941g4/O1qVdXQhGxuHIV/t8StKWw3VYS/fQyPV99C9gk/AV
        hfoig8Yye9pi54kgWiAYPvHg6Ecyvy3YNCNvdoc6xUJ6LD+dE9897vBfH7ICBeMSEhBL6wd7M/NS9
        S1taO1QBsfsDN9bTmmsykfBKgAGoUHDMQhQpKSbYyF3JxUJVeMoKl2J5woH0/G4HCLdI0YmyHmQod
        Ul6AqLNuxoKaPzae9zBdz3DLHu93mBAArADWQSeTbnjpAmfTZCQOtBvz8AduEppKkLGZ1BB1I5wnB
        FqppMCKw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005w9-O8; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/25] mm: Allow large pages to be added to the page cache
Date:   Wed, 29 Apr 2020 06:36:50 -0700
Message-Id: <20200429133657.22632-19-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We return -EEXIST if there are any non-shadow entries in the page
cache in the range covered by the large page.  If there are multiple
shadow entries in the range, we set *shadowp to one of them (currently
the one at the highest index).  If that turns out to be the wrong
answer, we can implement something more complex.  This is mostly
modelled after the equivalent function in the shmem code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9abba062973a..842afee3d066 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -834,6 +834,7 @@ static int __add_to_page_cache_locked(struct page *page,
 	int huge = PageHuge(page);
 	struct mem_cgroup *memcg;
 	int error;
+	unsigned int nr = 1;
 	void *old;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -845,31 +846,50 @@ static int __add_to_page_cache_locked(struct page *page,
 					      gfp_mask, &memcg, false);
 		if (error)
 			return error;
+		xas_set_order(&xas, offset, thp_order(page));
+		nr = hpage_nr_pages(page);
 	}
 
-	get_page(page);
+	page_ref_add(page, nr);
 	page->mapping = mapping;
 	page->index = offset;
 
 	do {
+		unsigned long exceptional = 0;
+		unsigned int i = 0;
+
 		xas_lock_irq(&xas);
-		old = xas_load(&xas);
-		if (old && !xa_is_value(old))
-			xas_set_err(&xas, -EEXIST);
-		xas_store(&xas, page);
+		xas_for_each_conflict(&xas, old) {
+			if (!xa_is_value(old)) {
+				xas_set_err(&xas, -EEXIST);
+				break;
+			}
+			exceptional++;
+			if (shadowp)
+				*shadowp = old;
+		}
+		xas_create_range(&xas);
 		if (xas_error(&xas))
 			goto unlock;
 
-		if (xa_is_value(old)) {
-			mapping->nrexceptional--;
-			if (shadowp)
-				*shadowp = old;
+next:
+		xas_store(&xas, page);
+		if (++i < nr) {
+			xas_next(&xas);
+			goto next;
 		}
-		mapping->nrpages++;
+		mapping->nrexceptional -= exceptional;
+		mapping->nrpages += nr;
 
 		/* hugetlb pages do not participate in page cache accounting */
-		if (!huge)
-			__inc_node_page_state(page, NR_FILE_PAGES);
+		if (!huge) {
+			__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES,
+						nr);
+			if (nr > 1) {
+				__inc_node_page_state(page, NR_FILE_THPS);
+				filemap_nr_thps_inc(mapping);
+			}
+		}
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp_mask & GFP_RECLAIM_MASK));
@@ -886,7 +906,7 @@ static int __add_to_page_cache_locked(struct page *page,
 	/* Leave page->index set: truncation relies upon it */
 	if (!huge)
 		mem_cgroup_cancel_charge(page, memcg, false);
-	put_page(page);
+	page_ref_sub(page, nr);
 	return xas_error(&xas);
 }
 ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
-- 
2.26.2

