Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51701F5CB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgFJUPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbgFJUNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60CCC008636;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=82Nf07arRh2ddQXM6dUk5PZd/nwdd9dRkn6QAYZMbpg=; b=I/97wCaN/5C2K/kQyPuyQujzpa
        YRWA5GcqLOs2vkpFgnLJWaJQB6T7QxNfsMd3eeQR3Feu818PYzH92vaasIMMZwbhHysfiLYZX132s
        LcfFTuSOfhquq7DCwyyFfOMqyJcjGntmxql5tDNPn9tz6JkI9mprEHH7knvvaGIDehpNUbXE9kKS6
        vZlNmBOmKt57BgcUPR9dvCnEf5wCxJ1gj+jR7vnPA1C2HpBHFR5J2tP8FD4UafK3HRBsGWjeyrn7n
        i0Mxe2FQN7xAApt7xHyYyhGKmGeFDkWZMNErILFRbTrxvgwBJwPPfyqu9OztjzizUtMCEyL9g5e5b
        KZwtQDiQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003Wg-MM; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 35/51] mm: Allow THPs to be added to the page cache
Date:   Wed, 10 Jun 2020 13:13:29 -0700
Message-Id: <20200610201345.13273-36-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We return -EEXIST if there are any non-shadow entries in the page
cache in the range covered by the THP.  If there are multiple
shadow entries in the range, we set *shadowp to one of them (currently
the one at the highest index).  If that turns out to be the wrong
answer, we can implement something more complex.  This is mostly
modelled after the equivalent function in the shmem code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3a9579a1ffa7..ab9746aff766 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -834,41 +834,58 @@ static int __add_to_page_cache_locked(struct page *page,
 	XA_STATE(xas, &mapping->i_pages, offset);
 	int huge = PageHuge(page);
 	int error;
+	unsigned int nr = 1;
 	void *old;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
 	mapping_set_update(&xas, mapping);
 
-	get_page(page);
-	page->mapping = mapping;
-	page->index = offset;
-
 	if (!huge) {
 		error = mem_cgroup_charge(page, current->mm, gfp_mask);
 		if (error)
-			goto error;
+			return error;
+		xas_set_order(&xas, offset, thp_order(page));
+		nr = thp_nr_pages(page);
 	}
 
+	page_ref_add(page, nr);
+	page->mapping = mapping;
+	page->index = offset;
+
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
-			__inc_lruvec_page_state(page, NR_FILE_PAGES);
+		if (!huge) {
+			__mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
+			if (nr > 1)
+				__inc_lruvec_page_state(page, NR_FILE_THPS);
+		}
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp_mask & GFP_RECLAIM_MASK));
@@ -883,7 +900,8 @@ static int __add_to_page_cache_locked(struct page *page,
 error:
 	page->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
-	put_page(page);
+	page_ref_sub(page, nr);
+	VM_BUG_ON_PAGE(page_count(page) <= 0, page);
 	return error;
 }
 ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
-- 
2.26.2

