Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2695D161AC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgBQSsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:48:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgBQSqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=f6e1vXABPDL0rMBXcPDUicTcSHShodWe/Rf26ms+MIM=; b=l7hv3PdTD5FlyDvtWj7UIPyYIh
        pFC/dM1GbjDjHpQBTch+Ju7Tj6oFrw59IcILNGPJj2pRhPguzUqywp4ihcqCujOiORMcLauMi6++M
        kn6iUgpEid7/AdCzyF06VM+n6zhEa4s9iKGvJ120z70Va5ZAEKt7ybAjLiNO1ZRtcnYM7cRhfYHny
        FViLwoiNRNq0gdWXh6D6fvopIONeuQBtk3up9M2TW0Ly/0YrIA1GEBuqfD5GflLHZuRNw8q2V6UNg
        AioV/Bgo3ETArbEHNGlWf/KkKm7VWOmabymzPwLel4x8sURqCjyXn6tWcxXkHiaNRugSbhMboBXBa
        CMyA7Qyw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3lPL-00058v-ER; Mon, 17 Feb 2020 18:46:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 04/16] mm: Tweak readahead loop slightly
Date:   Mon, 17 Feb 2020 10:45:46 -0800
Message-Id: <20200217184613.19668-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Eliminate the page_offset variable which was just confusing;
record the start of each consecutive run of pages in the
readahead_control, and move the 'kick off a fresh batch' code to
the end of the function for easier use in the next patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 15329309231f..74791b96013f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -154,7 +154,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
@@ -163,6 +162,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	struct readahead_control rac = {
 		.mapping = mapping,
 		.file = filp,
+		._start = offset,
 		._nr_pages = 0,
 	};
 
@@ -175,32 +175,39 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
-		pgoff_t page_offset = offset + page_idx;
+		struct page *page;
 
-		if (page_offset > end_index)
+		if (offset > end_index)
 			break;
 
-		page = xa_load(&mapping->i_pages, page_offset);
+		page = xa_load(&mapping->i_pages, offset);
 		if (page && !xa_is_value(page)) {
 			/*
-			 * Page already present?  Kick off the current batch of
-			 * contiguous pages before continuing with the next
-			 * batch.
+			 * Page already present?  Kick off the current batch
+			 * of contiguous pages before continuing with the
+			 * next batch.  This page may be the one we would
+			 * have intended to mark as Readahead, but we don't
+			 * have a stable reference to this page, and it's
+			 * not worth getting one just for that.
 			 */
-			if (readahead_count(&rac))
-				read_pages(&rac, &page_pool, gfp_mask);
-			rac._nr_pages = 0;
-			continue;
+			goto read;
 		}
 
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = page_offset;
+		page->index = offset;
 		list_add(&page->lru, &page_pool);
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		rac._nr_pages++;
+		offset++;
+		continue;
+read:
+		if (readahead_count(&rac))
+			read_pages(&rac, &page_pool, gfp_mask);
+		rac._nr_pages = 0;
+		rac._start = ++offset;
 	}
 
 	/*
-- 
2.25.0

