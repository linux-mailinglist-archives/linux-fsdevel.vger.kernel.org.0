Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FB34AFE42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiBIUWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiBIUWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71927E03A55C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oDXeo3OF5q00A6QGLjUpvLs1uWMTYSqQCl704+E26hU=; b=uNP4895h/5hB6k0KjfQcYYlOco
        9Vwq9or5q7JaKba44GG9MnVH4xST9gd1pb62YlHOOEU6bAnk0zcCgj+WZHbxXBGaq+FKs0bKGEDqn
        CFxHNm5e74dKbTyXwXFmSVPOi2N81s7MjWqJurw/Jdsp8VCQtOcipKfRFDYe9VGWCznMW7XrJQSi0
        YxYqMn6bfSovUaOj1cwucAdXeECwFVde3sFt7y70q/DjWw98IgiDmkoKxk3Suj5JbH3fkz3tGCK5J
        T2VpiljGeyHkfn/wYTWasENc1/mallhjUgTeUE1Fw+aWiwb4ya8Apq6tiB6gcDpxz39Tbo97v1Cbh
        uNzjhTYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTr-008cpV-Mp; Wed, 09 Feb 2022 20:22:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 09/56] fs: Turn do_invalidatepage() into folio_invalidate()
Date:   Wed,  9 Feb 2022 20:21:28 +0000
Message-Id: <20220209202215.2055748-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Take a folio instead of a page, fix the types of the offset & length,
and export it to filesystems.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      |  3 ---
 include/linux/pagemap.h |  1 +
 mm/truncate.c           | 20 ++++++++++----------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..7808a7959066 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1939,9 +1939,6 @@ int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
 			struct page **pages);
 struct page *get_dump_page(unsigned long addr);
 
-extern void do_invalidatepage(struct page *page, unsigned int offset,
-			      unsigned int length);
-
 bool folio_mark_dirty(struct folio *folio);
 bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2a4a46ff890c..469b7c4eeeed 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -891,6 +891,7 @@ static inline void cancel_dirty_page(struct page *page)
 }
 bool folio_clear_dirty_for_io(struct folio *folio);
 bool clear_page_dirty_for_io(struct page *page);
+void folio_invalidate(struct folio *folio, size_t offset, size_t length);
 int __must_check folio_write_one(struct folio *folio);
 static inline int __must_check write_one_page(struct page *page)
 {
diff --git a/mm/truncate.c b/mm/truncate.c
index 9dbf0b75da5d..aa0ed373789d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -138,33 +138,33 @@ static int invalidate_exceptional_entry2(struct address_space *mapping,
 }
 
 /**
- * do_invalidatepage - invalidate part or all of a page
- * @page: the page which is affected
+ * folio_invalidate - Invalidate part or all of a folio.
+ * @folio: The folio which is affected.
  * @offset: start of the range to invalidate
  * @length: length of the range to invalidate
  *
- * do_invalidatepage() is called when all or part of the page has become
+ * folio_invalidate() is called when all or part of the folio has become
  * invalidated by a truncate operation.
  *
- * do_invalidatepage() does not have to release all buffers, but it must
+ * folio_invalidate() does not have to release all buffers, but it must
  * ensure that no dirty buffer is left outside @offset and that no I/O
  * is underway against any of the blocks which are outside the truncation
  * point.  Because the caller is about to free (and possibly reuse) those
  * blocks on-disk.
  */
-void do_invalidatepage(struct page *page, unsigned int offset,
-		       unsigned int length)
+void folio_invalidate(struct folio *folio, size_t offset, size_t length)
 {
 	void (*invalidatepage)(struct page *, unsigned int, unsigned int);
 
-	invalidatepage = page->mapping->a_ops->invalidatepage;
+	invalidatepage = folio->mapping->a_ops->invalidatepage;
 #ifdef CONFIG_BLOCK
 	if (!invalidatepage)
 		invalidatepage = block_invalidatepage;
 #endif
 	if (invalidatepage)
-		(*invalidatepage)(page, offset, length);
+		(*invalidatepage)(&folio->page, offset, length);
 }
+EXPORT_SYMBOL_GPL(folio_invalidate);
 
 /*
  * If truncate cannot remove the fs-private metadata from the page, the page
@@ -182,7 +182,7 @@ static void truncate_cleanup_folio(struct folio *folio)
 		unmap_mapping_folio(folio);
 
 	if (folio_has_private(folio))
-		do_invalidatepage(&folio->page, 0, folio_size(folio));
+		folio_invalidate(folio, 0, folio_size(folio));
 
 	/*
 	 * Some filesystems seem to re-dirty the page even after
@@ -264,7 +264,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	folio_zero_range(folio, offset, length);
 
 	if (folio_has_private(folio))
-		do_invalidatepage(&folio->page, offset, length);
+		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
 	if (split_huge_page(&folio->page) == 0)
-- 
2.34.1

