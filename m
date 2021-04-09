Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D9E35A6C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 21:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhDITMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 15:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhDITMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:12:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F736C061762;
        Fri,  9 Apr 2021 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jAqapOL6/Q7ges0ll0u4wMviUWG3R6VVJlANPuTC5Tc=; b=plkPzPgJ9L3NdtLtOy7OCld88H
        4ANipG3gob05ukIQJwXhmCy8Z3UkEilYFLQYu7bEpFvhSsRu4WDbcbnU1KjPaD7/aZlqU9YMesdav
        D3VSL9ETfUu5mygvMfdCsEKuXCjoRKtEzNugxs6W4O+mk8uSg8BZSP3hINEp5XhQLPnS2AMADg8Cr
        l8EZQ5j605Qu8x7ZXXGwDMZsmHs+6rUPkUt4veW4R2QM9tAYGyky5V9zgAwlvSQUMlstFNwHMUtak
        REEHW+jJQOrnnBywA7jHeRK1lQGddO0lQeMrd8KaZq3sJ/j9Rwyz+t6TqMCLUI9D7ZG187gV5yHai
        TwzWzAWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwXB-000oiB-BF; Fri, 09 Apr 2021 19:11:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 27/28] mm/filemap: Convert wake_up_page_bit to wake_up_folio_bit
Date:   Fri,  9 Apr 2021 19:51:04 +0100
Message-Id: <20210409185105.188284-28-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409185105.188284-1-willy@infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers have a folio, so use it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 mm/filemap.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8f07e21a8f29..dfdc04130c5b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1121,14 +1121,14 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
 }
 
-static void wake_up_page_bit(struct page *page, int bit_nr)
+static void wake_up_folio_bit(struct folio *folio, int bit_nr)
 {
-	wait_queue_head_t *q = page_waitqueue(page);
+	wait_queue_head_t *q = page_waitqueue(&folio->page);
 	struct wait_page_key key;
 	unsigned long flags;
 	wait_queue_entry_t bookmark;
 
-	key.page = page;
+	key.page = &folio->page;
 	key.bit_nr = bit_nr;
 	key.page_match = 0;
 
@@ -1163,7 +1163,7 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 	 * page waiters.
 	 */
 	if (!waitqueue_active(q) || !key.page_match) {
-		ClearPageWaiters(page);
+		ClearFolioWaiters(folio);
 		/*
 		 * It's possible to miss clearing Waiters here, when we woke
 		 * our page waiters, but the hashed waitqueue has waiters for
@@ -1179,7 +1179,7 @@ static void wake_up_folio(struct folio *folio, int bit)
 {
 	if (!FolioWaiters(folio))
 		return;
-	wake_up_page_bit(&folio->page, bit);
+	wake_up_folio_bit(folio, bit);
 }
 
 /*
@@ -1444,7 +1444,7 @@ void unlock_folio(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	VM_BUG_ON_FOLIO(!FolioLocked(folio), folio);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
-		wake_up_page_bit(&folio->page, PG_locked);
+		wake_up_folio_bit(folio, PG_locked);
 }
 EXPORT_SYMBOL(unlock_folio);
 
@@ -1461,11 +1461,12 @@ EXPORT_SYMBOL(unlock_folio);
  */
 void end_page_private_2(struct page *page)
 {
-	page = compound_head(page);
-	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
-	clear_bit_unlock(PG_private_2, &page->flags);
-	wake_up_page_bit(page, PG_private_2);
-	put_page(page);
+	struct folio *folio = page_folio(page);
+
+	VM_BUG_ON_FOLIO(!FolioPrivate2(folio), folio);
+	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
+	wake_up_folio_bit(folio, PG_private_2);
+	put_folio(folio);
 }
 EXPORT_SYMBOL(end_page_private_2);
 
-- 
2.30.2

