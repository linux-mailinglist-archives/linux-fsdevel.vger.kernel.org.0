Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CED3B03D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhFVML4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhFVMLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:11:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA30EC061767;
        Tue, 22 Jun 2021 05:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rJ2l7RXAu6RyRSb4WIeXBpZfSowkaxZgBSgWKhhFDqM=; b=WAmsbvlJoTckWVl5Q5YVcRpwK+
        A3PCXSJRa4O2NJIswNJRSQQw4iiGdVP9uuf92M1kR0EVkri37HogjPiIYMVCHDPl736baSY9IdSZC
        6Uykq+epj7mBapPv1mvX1Hs5LHlU1fLtk6vu0HrinPKqmxsjxC0gWWXgeRwy9tUtXnw/QAKQhfCRW
        dEzrrhmRZMdpv+AGlIIXaVhoNu3DKZpVG2kFi9XBZa5PcFe8ylGvJyLIq+gA7KurpUktP/RJ38oXf
        QMixTtmhqffAF5oFy/Brh1LF2y+p+mOsBrupQuCRLtupyb2ZME77dWeQDvtbWCzchTP8OSgJ8kaZE
        PX1e3ozg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfC8-00EFWh-6i; Tue, 22 Jun 2021 12:08:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v12 31/33] mm/filemap: Add folio private_2 functions
Date:   Tue, 22 Jun 2021 12:41:16 +0100
Message-Id: <20210622114118.3388190-32-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622114118.3388190-1-willy@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

end_page_private_2() becomes folio_end_private_2(),
wait_on_page_private_2() becomes folio_wait_private_2() and
wait_on_page_private_2_killable() becomes folio_wait_private_2_killable().

Adjust the fscache equivalents to call page_folio() before calling these
functions to avoid adding wrappers.  Ends up costing 1 byte of text
in ceph & netfs, but the core shrinks by three calls to page_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/netfs.h   |  6 +++---
 include/linux/pagemap.h |  6 +++---
 mm/filemap.c            | 37 ++++++++++++++++---------------------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 9062adfa2fb9..fad8c6209edd 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -55,7 +55,7 @@ static inline void set_page_fscache(struct page *page)
  */
 static inline void end_page_fscache(struct page *page)
 {
-	end_page_private_2(page);
+	folio_end_private_2(page_folio(page));
 }
 
 /**
@@ -66,7 +66,7 @@ static inline void end_page_fscache(struct page *page)
  */
 static inline void wait_on_page_fscache(struct page *page)
 {
-	wait_on_page_private_2(page);
+	folio_wait_private_2(page_folio(page));
 }
 
 /**
@@ -82,7 +82,7 @@ static inline void wait_on_page_fscache(struct page *page)
  */
 static inline int wait_on_page_fscache_killable(struct page *page)
 {
-	return wait_on_page_private_2_killable(page);
+	return folio_wait_private_2_killable(page_folio(page));
 }
 
 enum netfs_read_source {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1330d8d0ca26..6a06224afa2f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -795,9 +795,9 @@ static inline void set_page_private_2(struct page *page)
 	SetPagePrivate2(page);
 }
 
-void end_page_private_2(struct page *page);
-void wait_on_page_private_2(struct page *page);
-int wait_on_page_private_2_killable(struct page *page);
+void folio_end_private_2(struct folio *folio);
+void folio_wait_private_2(struct folio *folio);
+int folio_wait_private_2_killable(struct folio *folio);
 
 /*
  * Add an arbitrary waiter to a page's wait queue
diff --git a/mm/filemap.c b/mm/filemap.c
index 7d8125f6c955..7b0e4d0e4741 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1451,56 +1451,51 @@ void folio_unlock(struct folio *folio)
 EXPORT_SYMBOL(folio_unlock);
 
 /**
- * end_page_private_2 - Clear PG_private_2 and release any waiters
- * @page: The page
+ * folio_end_private_2 - Clear PG_private_2 and wake any waiters.
+ * @folio: The folio.
  *
- * Clear the PG_private_2 bit on a page and wake up any sleepers waiting for
- * this.  The page ref held for PG_private_2 being set is released.
+ * Clear the PG_private_2 bit on a folio and wake up any sleepers waiting for
+ * it.  The page ref held for PG_private_2 being set is released.
  *
  * This is, for example, used when a netfs page is being written to a local
  * disk cache, thereby allowing writes to the cache for the same page to be
  * serialised.
  */
-void end_page_private_2(struct page *page)
+void folio_end_private_2(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	VM_BUG_ON_FOLIO(!folio_private_2(folio), folio);
 	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
 	folio_wake_bit(folio, PG_private_2);
 	folio_put(folio);
 }
-EXPORT_SYMBOL(end_page_private_2);
+EXPORT_SYMBOL(folio_end_private_2);
 
 /**
- * wait_on_page_private_2 - Wait for PG_private_2 to be cleared on a page
- * @page: The page to wait on
+ * folio_wait_private_2 - Wait for PG_private_2 to be cleared on a page.
+ * @folio: The folio to wait on.
  *
- * Wait for PG_private_2 (aka PG_fscache) to be cleared on a page.
+ * Wait for PG_private_2 (aka PG_fscache) to be cleared on a folio.
  */
-void wait_on_page_private_2(struct page *page)
+void folio_wait_private_2(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	while (folio_private_2(folio))
 		folio_wait_bit(folio, PG_private_2);
 }
-EXPORT_SYMBOL(wait_on_page_private_2);
+EXPORT_SYMBOL(folio_wait_private_2);
 
 /**
- * wait_on_page_private_2_killable - Wait for PG_private_2 to be cleared on a page
- * @page: The page to wait on
+ * folio_wait_private_2_killable - Wait for PG_private_2 to be cleared on a folio.
+ * @folio: The folio to wait on.
  *
- * Wait for PG_private_2 (aka PG_fscache) to be cleared on a page or until a
+ * Wait for PG_private_2 (aka PG_fscache) to be cleared on a folio or until a
  * fatal signal is received by the calling task.
  *
  * Return:
  * - 0 if successful.
  * - -EINTR if a fatal signal was encountered.
  */
-int wait_on_page_private_2_killable(struct page *page)
+int folio_wait_private_2_killable(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	int ret = 0;
 
 	while (folio_private_2(folio)) {
@@ -1511,7 +1506,7 @@ int wait_on_page_private_2_killable(struct page *page)
 
 	return ret;
 }
-EXPORT_SYMBOL(wait_on_page_private_2_killable);
+EXPORT_SYMBOL(folio_wait_private_2_killable);
 
 /**
  * folio_end_writeback - End writeback against a folio.
-- 
2.30.2

