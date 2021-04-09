Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AF335A6B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhDITJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 15:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbhDITJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:09:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B188C061762;
        Fri,  9 Apr 2021 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3OiOISSuA2SH6R+I8ePIgoOcVjWcdXLcZNZAVLZj/Ik=; b=BTTj/YJVJCB7p0wptPQZ/SEn3w
        gH7J6RYldNBQRbQd4AEF269OtGzrq7hZpKFIc4VjAu71k5IwtqDE0PmLOGZjXFuy73W0kpVEPP+0D
        J2x3aED8b3Xze98nL2CGDrIxsmaLAUFfRTe0/hfJvUSKpl0PwANGYd0niYPNMWnlDuuTYuh+RWlDO
        TAHFCZw0gbjywakSa5SRHQqcgEJI4LmGidD7dDS+vxQ+BEn1MAJ9+6Hy/ZaGslEYwJ/LIERzhpSOB
        XujYsAzMohTCT+BrXbxjw6bhtRWAq8+F/qQWrQgWoAsQh3diNyLWDv9Kuoa2RZL7A5TqBrCxKRBEg
        oWleqCtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwU4-000oTh-4r; Fri, 09 Apr 2021 19:08:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 22/28] mm/filemap: Add wait_on_folio_locked
Date:   Fri,  9 Apr 2021 19:50:59 +0100
Message-Id: <20210409185105.188284-23-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409185105.188284-1-willy@infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also add wait_on_folio_locked_killable().  Turn wait_on_page_locked()
and wait_on_page_locked_killable() into wrappers.  This eliminates a
call to compound_head() from each call-site, reducing text size by 200
bytes for me.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h | 26 ++++++++++++++++++--------
 mm/filemap.c            |  4 ++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 00864e098693..18c4c2ae8074 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -797,23 +797,33 @@ extern void wait_on_page_bit(struct page *page, int bit_nr);
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
+static inline void wait_on_folio_locked(struct folio *folio)
+{
+	if (FolioLocked(folio))
+		wait_on_page_bit(&folio->page, PG_locked);
+}
+
+static inline int wait_on_folio_locked_killable(struct folio *folio)
+{
+	if (!FolioLocked(folio))
+		return 0;
+	return wait_on_page_bit_killable(&folio->page, PG_locked);
+}
+
 static inline void wait_on_page_locked(struct page *page)
 {
-	if (PageLocked(page))
-		wait_on_page_bit(compound_head(page), PG_locked);
+	wait_on_folio_locked(page_folio(page));
 }
 
 static inline int wait_on_page_locked_killable(struct page *page)
 {
-	if (!PageLocked(page))
-		return 0;
-	return wait_on_page_bit_killable(compound_head(page), PG_locked);
+	return wait_on_folio_locked_killable(page_folio(page));
 }
 
 int put_and_wait_on_page_locked(struct page *page, int state);
diff --git a/mm/filemap.c b/mm/filemap.c
index 73c8d7102157..d23430ad5bbc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1643,9 +1643,9 @@ int __lock_folio_or_retry(struct folio *folio, struct mm_struct *mm,
 
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
-			wait_on_page_locked_killable(page);
+			wait_on_folio_locked_killable(folio);
 		else
-			wait_on_page_locked(page);
+			wait_on_folio_locked(folio);
 		return 0;
 	}
 	if (flags & FAULT_FLAG_KILLABLE) {
-- 
2.30.2

