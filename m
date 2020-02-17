Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D1161A43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgBQSqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:46:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgBQSq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GsjiaZugI72vbGelDXh1gHsSqzMvkN1OtgDj3kywYLo=; b=mG3ezOVTlUwDZANXsCHvcKdwJB
        z3OlpT7AjCBCJphbep/jJMnYwWkqQCv4wTdvjax0x0CW6Nvu8+8tccy4vlbefujrJjJEj82Cnsx1d
        0Z0dVex246tKQbAITwLWjKWZ5u/u/QkHJfmmheFgDcrAuXqy1jKQgdOFfs9OG8e4Jv179uA6lHT0C
        rj7l1UtOFC7pBjOM+uPFkUB4PEe+Mm5ggHB2nPVgYYpq1iZJM1/7wiOXsE7PHbRws4qZi4knTfp9M
        Abo7HX1ADfB8vHy4nwtU2Q4tJcbww1fj8NQ9P/NHWgtRpkc995sdbYd50dglXP3xbP8Qt8cWX4AgS
        6OQh+pkw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3lPL-00058r-DR; Mon, 17 Feb 2020 18:46:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 04/19] mm: Rearrange readahead loop
Date:   Mon, 17 Feb 2020 10:45:45 -0800
Message-Id: <20200217184613.19668-5-willy@infradead.org>
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

Move the declaration of 'page' to inside the loop and move the 'kick
off a fresh batch' code to the end of the function for easier use in
subsequent patches.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 15329309231f..3eca59c43a45 100644
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
@@ -175,6 +174,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
+		struct page *page;
 		pgoff_t page_offset = offset + page_idx;
 
 		if (page_offset > end_index)
@@ -183,14 +183,14 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		page = xa_load(&mapping->i_pages, page_offset);
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
@@ -201,6 +201,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		rac._nr_pages++;
+		continue;
+read:
+		if (readahead_count(&rac))
+			read_pages(&rac, &page_pool, gfp_mask);
+		rac._nr_pages = 0;
 	}
 
 	/*
-- 
2.25.0

