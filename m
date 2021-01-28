Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7373306E27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhA1HIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhA1HGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:06:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A6DC061574;
        Wed, 27 Jan 2021 23:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zZTV75qOL0xlMoCQDahb6dcgSvwaZqL/XSj+lLkIJic=; b=g3n1TeJh4bpmZ40U9TIK+cADXA
        80h10bytSVrOG0mYm8zuCnxmumlZEocleNB0apIVqtX+5iPE185iIQFdjFl3TFSEVJXFGtgoi9Y9u
        Ofr36XHv4f2s5cxzuy6XA8bc9kYyZU/9Wc1BGI/i7LYHLDw/FHmgOTuQoGk+32tKwnmyvISp7jkdA
        uLARFwxTqDc5PKSyllcCyCqpR03wTS8lH6EA6k8kx+HaSJ60RAmoYHm6fXfHxSeLzZRoLiCpPE9Ju
        EvJjHsmcdAShM34fK7xOWC75SLFWveRq4NwwPTg2Uoye6iN558Id7wFkZR9caCF+IJDdA81tTNKAa
        m2H2sySg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51MJ-00848m-EO; Thu, 28 Jan 2021 07:04:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 22/25] mm/filemap: Convert wake_up_page_bit to wake_up_folio_bit
Date:   Thu, 28 Jan 2021 07:04:01 +0000
Message-Id: <20210128070404.1922318-23-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers have a folio, so use it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f0a76258de97..906b29c3e1fb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1093,14 +1093,14 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
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
 
@@ -1135,7 +1135,7 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 	 * page waiters.
 	 */
 	if (!waitqueue_active(q) || !key.page_match) {
-		ClearPageWaiters(page);
+		ClearFolioWaiters(folio);
 		/*
 		 * It's possible to miss clearing Waiters here, when we woke
 		 * our page waiters, but the hashed waitqueue has waiters for
@@ -1151,7 +1151,7 @@ static void wake_up_folio(struct folio *folio, int bit)
 {
 	if (!FolioWaiters(folio))
 		return;
-	wake_up_page_bit(&folio->page, bit);
+	wake_up_folio_bit(folio, bit);
 }
 
 /*
@@ -1416,7 +1416,7 @@ void unlock_folio(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	VM_BUG_ON_FOLIO(!FolioLocked(folio), folio);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio)))
-		wake_up_page_bit(&folio->page, PG_locked);
+		wake_up_folio_bit(folio, PG_locked);
 }
 EXPORT_SYMBOL(unlock_folio);
 
-- 
2.29.2

