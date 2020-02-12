Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972BA159FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBLET1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:19:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oDWvgcF6dlhezySIqP1bKbtFkpsm87G/1cVbkdABghc=; b=uiu6mEGGpI8HmZNr0RR0F2S9yH
        j5qWzjYpCw2UwjBC+47AJqdt0D7v8CHHwEcSlzSW8pnr4n4vtFX48tPwImDqKlLt4wIYDxKrCPoLT
        G8t8yZZuq5zYQ+y0pzrEXeJhbuCv8EE89EV6pDLGq6MEhNkpMy0Q/RkMkgW9eRjOjD98AF/+rxhcj
        juRr/7u3bMtlJI2bQZRZ5DVKbIdriM9ZCIeBDupEagxsY6BGfmSkwZQl2i0Fdvr/AAxLtkVhAWyJa
        ZM0fBodWRQS7vAHEJj3fG2z9/BsZ+kY3FZnkVhe1NFjqz6CM0z1du9sY+9ndBHHU2LSCgc5bFumkM
        3w6mAUsQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006ou-E3; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/25] mm: Allow large pages to be added to the page cache
Date:   Tue, 11 Feb 2020 20:18:42 -0800
Message-Id: <20200212041845.25879-23-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
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
index 1061463a169e..08b5cd4ce47b 100644
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
2.25.0

