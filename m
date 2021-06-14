Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946E63A7067
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhFNUbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbhFNUbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:31:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624DFC061574;
        Mon, 14 Jun 2021 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=O9aVCrsv4Z16U0LzyZIvQcSqxQjM3od8rgw4pV5j4+I=; b=Lkt/Jd4aYIDzKSK4IMWP4L0q0n
        eUq957MHB6vJ8IBti9wqS8QSaZiFbkDoxNN/SYVj28XWEFRKsqjszMDtszOcrOrKcH1RGovZkKf9N
        avvDy1TqEpdexCfLnMlLcdQpMKuhK4RT49do2PSjlAeVY3vN+Sxvujq8EYB47KpBJjRfwm+tVq3B0
        S5Nt9i/YWRPrDiUNIrRwCafV9o9kStCvKRqdn3XDD5Ejmrz0hwZHjynrX5RDrmJtF7CE2Y1XaaufZ
        ul0rMguDN87gBrnLiLJC4fxFFHnpKhI7T9s9ovD7aDk6nsBiW+SOchrFtDbuGlmj4Wz2uU9an6keO
        930t4y2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lstC9-005nzG-Tk; Mon, 14 Jun 2021 20:28:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 22/33] mm/filemap: Add folio_wait_locked()
Date:   Mon, 14 Jun 2021 21:14:24 +0100
Message-Id: <20210614201435.1379188-23-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
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
---
 include/linux/pagemap.h | 26 ++++++++++++++++++--------
 mm/filemap.c            |  4 ++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 809813751afc..e5ddc587e988 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -721,23 +721,33 @@ extern void wait_on_page_bit(struct page *page, int bit_nr);
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
index a8177324c393..1b76230d4345 100644
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

