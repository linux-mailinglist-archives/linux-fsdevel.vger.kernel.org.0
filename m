Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E933C419A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhGLDWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGLDWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:22:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A21C0613DD;
        Sun, 11 Jul 2021 20:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wxo47piTAD6YTC6D0qoMYybSYTMdwvF55wUnIaJv/i8=; b=kSxqzZLQnD7ezzf9Jnc8N8b4Lq
        tI5WYWrPrL+G9/K3PrJZCW2A5egolgVgg5oxTy+CZzCvMVfdSZIk/s8V9b4rVJ6QyhFPgzKpJxVst
        b/+v7JJhiDuNKBzq6Apa6neG44n6cDnc8LHH3HGGgKHSCbn2AJEu56eWnoNcNDxfX+5L/LKan6D6V
        CD8X2q2/ItxT3Fbb1ZqY04Qo06Iw9mXDKqWud329dx2Y+k8+J1qiV0UuUesPK8vij8vl62fgFzDTF
        7dB2zpdiuQNs927A7FM4TZg1VhaV4sDiC4SOLk8jJjB/2Lu4DB0aONWTBQ7sDFHCizCLSObvwwczz
        RRkslgVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mT6-00GnXz-Nj; Mon, 12 Jul 2021 03:18:59 +0000
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
Subject: [PATCH v13 021/137] mm/filemap: Add folio_wait_locked()
Date:   Mon, 12 Jul 2021 04:05:05 +0100
Message-Id: <20210712030701.4000097-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also add folio_wait_locked_killable().  Turn wait_on_page_locked() and
wait_on_page_locked_killable() into wrappers.  This eliminates a call
to compound_head() from each call-site, reducing text size by 193 bytes
for me.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/pagemap.h | 26 ++++++++++++++++++--------
 mm/filemap.c            |  4 ++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 79ff079346aa..7994b497d505 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -733,23 +733,33 @@ extern void wait_on_page_bit(struct page *page, int bit_nr);
 extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
 
 /* 
- * Wait for a page to be unlocked.
+ * Wait for a folio to be unlocked.
  *
- * This must be called with the caller "holding" the page,
- * ie with increased "page->count" so that the page won't
+ * This must be called with the caller "holding" the folio,
+ * ie with increased "page->count" so that the folio won't
  * go away during the wait..
  */
+static inline void folio_wait_locked(struct folio *folio)
+{
+	if (folio_locked(folio))
+		wait_on_page_bit(&folio->page, PG_locked);
+}
+
+static inline int folio_wait_locked_killable(struct folio *folio)
+{
+	if (!folio_locked(folio))
+		return 0;
+	return wait_on_page_bit_killable(&folio->page, PG_locked);
+}
+
 static inline void wait_on_page_locked(struct page *page)
 {
-	if (PageLocked(page))
-		wait_on_page_bit(compound_head(page), PG_locked);
+	folio_wait_locked(page_folio(page));
 }
 
 static inline int wait_on_page_locked_killable(struct page *page)
 {
-	if (!PageLocked(page))
-		return 0;
-	return wait_on_page_bit_killable(compound_head(page), PG_locked);
+	return folio_wait_locked_killable(page_folio(page));
 }
 
 int put_and_wait_on_page_locked(struct page *page, int state);
diff --git a/mm/filemap.c b/mm/filemap.c
index 19c1486d85d2..018fad19146e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1649,9 +1649,9 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
-			wait_on_page_locked_killable(page);
+			folio_wait_locked_killable(folio);
 		else
-			wait_on_page_locked(page);
+			folio_wait_locked(folio);
 		return 0;
 	}
 	if (flags & FAULT_FLAG_KILLABLE) {
-- 
2.30.2

