Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB6350709
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhCaS4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbhCaS41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:56:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EDEC061574;
        Wed, 31 Mar 2021 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H8qXMRHuXNPxaR/1xTfNg26NntZcpDie9l+kmIiKCGs=; b=eYLXdyi1nTJPslzoF87jDkoelO
        r8uiNVIK0Dt0BgJh7CSaHHJMkgxeESTyxxWHaaxF4bUO4tl8zSuLvTP8lsyBWEFttN9kus8Ur345I
        puZcfTCUnxia3SPQ6DlCkvmkRM5w+bVQlW7tVpshy2ZUBC9c8tugCeGXdH66smqIYgdqRVU7wNAdM
        IHZLMEq6pYexDFWcG3rN9kmxUkgRxUf5OZeuQXMgS7xImKr6CtFqvJNdTUp01EjMfRV+GnBJNp7kZ
        uf+ctBQ1BN5RUUGT7s1BRrgEVE+rv5ae/YQpCflzoIRQZMPdKnwU7fEtUp2NYkfe/dHeMf8Bkaf85
        1A+Ia4Aw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfz8-004zpP-F2; Wed, 31 Mar 2021 18:54:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 26/27] mm/filemap: Convert wake_up_page_bit to wake_up_folio_bit
Date:   Wed, 31 Mar 2021 19:47:27 +0100
Message-Id: <20210331184728.1188084-27-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers have a folio, so use it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 76e1c4be1205..51b2091d402c 100644
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
 
@@ -1461,10 +1461,10 @@ EXPORT_SYMBOL(unlock_folio);
  */
 void unlock_page_private_2(struct page *page)
 {
-	page = compound_head(page);
-	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
-	clear_bit_unlock(PG_private_2, &page->flags);
-	wake_up_page_bit(page, PG_private_2);
+	struct folio *folio = page_folio(page);
+	VM_BUG_ON_FOLIO(!FolioPrivate2(folio), folio);
+	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
+	wake_up_folio_bit(folio, PG_private_2);
 }
 EXPORT_SYMBOL(unlock_page_private_2);
 
-- 
2.30.2

