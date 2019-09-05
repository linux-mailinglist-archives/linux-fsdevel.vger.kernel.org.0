Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35334AAAD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 20:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbfIESXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 14:23:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389833AbfIESXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wv/nfVfHUcEEwLwvWDB143BDF1cy+chJvZKm5OI/UQ0=; b=ru0grhHmHVJaHFm/ZEKyOlN78+
        X3yojMPGb2MTakkInNd8Gs0vdgmL5sdIz7ZAQt2XmZcvCvMva8YL9nqPANMRw6WgXm6W3z3zR16mC
        sHw+e8qWOYBHMAw6Q/qoY87ISI0H0ZkWh0QmlEKtsJ3i67Non71xJ9cppIhuHwm44QAR9z7qiJ4G8
        2UzSSL9xeg3flYfjVOuu06ZRhCfiVtqG611OK0rAKQn5rDQiL591OtBu3vacSCVzir3K2JzHZfv/J
        bL+4/HrdMaifmK44Q7+WUUe5vsFDO7Feubh2w6R069zPYE/yNXn5zgBcM/Wt4wnE3dvhvTQIExukq
        2rPa1FXA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5wQA-0001UQ-N1; Thu, 05 Sep 2019 18:23:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: [PATCH 2/3] mm: Allow large pages to be added to the page cache
Date:   Thu,  5 Sep 2019 11:23:47 -0700
Message-Id: <20190905182348.5319-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905182348.5319-1-willy@infradead.org>
References: <20190905182348.5319-1-willy@infradead.org>
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
 mm/filemap.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 041c77c4ca56..ae3c0a70a8e9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -850,6 +850,7 @@ static int __add_to_page_cache_locked(struct page *page,
 	int huge = PageHuge(page);
 	struct mem_cgroup *memcg;
 	int error;
+	unsigned int nr = 1;
 	void *old;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -861,31 +862,47 @@ static int __add_to_page_cache_locked(struct page *page,
 					      gfp_mask, &memcg, false);
 		if (error)
 			return error;
+		xas_set_order(&xas, offset, compound_order(page));
+		nr = compound_nr(page);
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
+		xas_for_each_conflict(&xas, old) {
+			if (!xa_is_value(old))
+				break;
+			exceptional++;
+			if (shadowp)
+				*shadowp = old;
+		}
+		if (old) {
 			xas_set_err(&xas, -EEXIST);
-		xas_store(&xas, page);
+			break;
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
 		if (!huge)
-			__inc_node_page_state(page, NR_FILE_PAGES);
+			__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES,
+						nr);
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp_mask & GFP_RECLAIM_MASK));
@@ -902,7 +919,7 @@ static int __add_to_page_cache_locked(struct page *page,
 	/* Leave page->index set: truncation relies upon it */
 	if (!huge)
 		mem_cgroup_cancel_charge(page, memcg, false);
-	put_page(page);
+	page_ref_sub(page, nr);
 	return xas_error(&xas);
 }
 ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
-- 
2.23.0.rc1

