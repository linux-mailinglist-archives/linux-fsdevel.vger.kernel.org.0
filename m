Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55BE3C96D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhGOEEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhGOEEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:04:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F5C06175F;
        Wed, 14 Jul 2021 21:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PSN9WkEJMgxnxvx0ERIMZ9XtSwSkMfCNyELdamaG3X8=; b=sSanZsUqIYF0IEsFromte2IhP5
        v7UWwigspuTBNkvIqFgl+qRldS55g4MSColNQmo4RrMOMEl2Rbn5qTS5a57m/ZXrx3Mqzdjf4sdgU
        laEF/y5PQ/DGwDex4vrQVrm5KdCn2rRBg1Dg3gK8u9df4d1Vq2KBSR3RbzltxOUb2Mh/6W26ShreJ
        uRQDpQVIRqslHr9sp2BzF8wbTuKm+sqGx8Nes0Q4xVPCdRinDDO4zLZEp5gQdfT4HlICQvXFITBVG
        ha5cIqCtPP8myhdeynyRGP2SVjc00cheEe0ZA8K3FrKo5DFrO9MIOTmX8hd7eKhrDHTRAqmEoFClS
        qZhGaJww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sXH-002vc7-2t; Thu, 15 Jul 2021 03:59:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v14 028/138] mm/filemap: Add folio_wake_bit()
Date:   Thu, 15 Jul 2021 04:35:14 +0100
Message-Id: <20210715033704.692967-29-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert wake_up_page_bit() to folio_wake_bit().  All callers have a folio,
so use it directly.  Saves 66 bytes of text in end_page_private_2().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 mm/filemap.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b55c89d7997f..a3ef9abcbcde 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1121,14 +1121,14 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
 }
 
-static void wake_up_page_bit(struct page *page, int bit_nr)
+static void folio_wake_bit(struct folio *folio, int bit_nr)
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
+		folio_clear_waiters(folio);
 		/*
 		 * It's possible to miss clearing Waiters here, when we woke
 		 * our page waiters, but the hashed waitqueue has waiters for
@@ -1179,7 +1179,7 @@ static void folio_wake(struct folio *folio, int bit)
 {
 	if (!folio_test_waiters(folio))
 		return;
-	wake_up_page_bit(&folio->page, bit);
+	folio_wake_bit(folio, bit);
 }
 
 /*
@@ -1446,7 +1446,7 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
-		wake_up_page_bit(&folio->page, PG_locked);
+		folio_wake_bit(folio, PG_locked);
 }
 EXPORT_SYMBOL(folio_unlock);
 
@@ -1463,11 +1463,12 @@ EXPORT_SYMBOL(folio_unlock);
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
+	VM_BUG_ON_FOLIO(!folio_test_private_2(folio), folio);
+	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
+	folio_wake_bit(folio, PG_private_2);
+	folio_put(folio);
 }
 EXPORT_SYMBOL(end_page_private_2);
 
-- 
2.30.2

