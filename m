Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2003C373F61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhEEQR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhEEQR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:17:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB98BC06174A;
        Wed,  5 May 2021 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5LjNoYmK1XhSwyJvOUPBCDBdw/ey3Otu+Mm30IJSGHQ=; b=j6zHQVF2cenSiDvE7VFdBK2CsK
        ascPCyoJUqjHBXk71RRaTl8iq9iOqaxzQcu2CE6KcNG2AGlwL4CRfBbxt4EAYP8yDKHjRc1PUnwE2
        EDFewhYybbDjcVyQWzNAoPqq0QPxV3efgrLpk+RB6gEg3aZ+44sICL8BkbPrHVoR0ix6sIHuvHf/J
        D/UBa2xNCImv/yoM8Gz8+C0PEhkSQvvLOMSU/LBYmUqmHqcC1Oi2/PPchO/xeSiQPaKgaenjjBUfh
        H4ksoGnIerD7Ty9YeOPdEpbfLHyeEskSY1KP6varMiWgLTni2vFTNc2mYAwzLxjQtznwCmTKcgddt
        0VFzZOjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKBI-000ZjX-Nz; Wed, 05 May 2021 16:15:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 58/96] mm/writeback: Add folio_start_writeback
Date:   Wed,  5 May 2021 16:05:50 +0100
Message-Id: <20210505150628.111735-59-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename set_page_writeback() to folio_start_writeback() to match
folio_end_writeback().  Do not bother with wrappers that return void;
callers are perfectly capable of ignoring return values.

Add wrappers for set_page_writeback(), set_page_writeback_keepwrite() and
test_set_page_writeback() for compatibililty with existing filesystems.
The main advantage of this patch is getting the statistics right,
although it does eliminate a couple of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 19 +++++++++++-------
 mm/page-writeback.c        | 40 ++++++++++++++++++++------------------
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a2e203b9f677..b685ef9b41a3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -645,21 +645,26 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int __test_set_page_writeback(struct page *page, bool keep_write);
+bool __folio_start_writeback(struct folio *folio, bool keep_write);
 
-#define test_set_page_writeback(page)			\
-	__test_set_page_writeback(page, false)
-#define test_set_page_writeback_keepwrite(page)	\
-	__test_set_page_writeback(page, true)
+#define folio_start_writeback(folio)			\
+	__folio_start_writeback(folio, false)
+#define folio_start_writeback_keepwrite(folio)	\
+	__folio_start_writeback(folio, true)
 
 static inline void set_page_writeback(struct page *page)
 {
-	test_set_page_writeback(page);
+	folio_start_writeback(page_folio(page));
 }
 
 static inline void set_page_writeback_keepwrite(struct page *page)
 {
-	test_set_page_writeback_keepwrite(page);
+	folio_start_writeback_keepwrite(page_folio(page));
+}
+
+static inline bool test_set_page_writeback(struct page *page)
+{
+	return folio_start_writeback(page_folio(page));
 }
 
 __PAGEFLAG(Head, head, PF_ANY) CLEARPAGEFLAG(Head, head, PF_ANY)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 9b8f39d124e7..4d36f4d3037f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2761,21 +2761,23 @@ bool __folio_end_writeback(struct folio *folio)
 	return ret;
 }
 
-int __test_set_page_writeback(struct page *page, bool keep_write)
+bool __folio_start_writeback(struct folio *folio, bool keep_write)
 {
-	struct address_space *mapping = page_mapping(page);
-	int ret, access_ret;
+	long nr = folio_nr_pages(folio);
+	struct address_space *mapping = folio_mapping(folio);
+	bool ret;
+	int access_ret;
 
-	lock_page_memcg(page);
+	lock_folio_memcg(folio);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
-		XA_STATE(xas, &mapping->i_pages, page_index(page));
+		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 		unsigned long flags;
 
 		xas_lock_irqsave(&xas, flags);
 		xas_load(&xas);
-		ret = TestSetPageWriteback(page);
+		ret = folio_test_set_writeback_flag(folio);
 		if (!ret) {
 			bool on_wblist;
 
@@ -2784,40 +2786,40 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 
 			xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
 			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT)
-				inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
+				wb_stat_mod(inode_to_wb(inode), WB_WRITEBACK,
+						nr);
 
 			/*
-			 * We can come through here when swapping anonymous
-			 * pages, so we don't necessarily have an inode to track
-			 * for sync.
+			 * We can come through here when swapping
+			 * anonymous folios, so we don't necessarily
+			 * have an inode to track for sync.
 			 */
 			if (mapping->host && !on_wblist)
 				sb_mark_inode_writeback(mapping->host);
 		}
-		if (!PageDirty(page))
+		if (!folio_dirty(folio))
 			xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
 		if (!keep_write)
 			xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		xas_unlock_irqrestore(&xas, flags);
 	} else {
-		ret = TestSetPageWriteback(page);
+		ret = folio_test_set_writeback_flag(folio);
 	}
 	if (!ret) {
-		inc_lruvec_page_state(page, NR_WRITEBACK);
-		inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
+		lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr);
+		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
 	}
-	unlock_page_memcg(page);
-	access_ret = arch_make_page_accessible(page);
+	unlock_folio_memcg(folio);
+	access_ret = arch_make_folio_accessible(folio);
 	/*
 	 * If writeback has been triggered on a page that cannot be made
 	 * accessible, it is too late to recover here.
 	 */
-	VM_BUG_ON_PAGE(access_ret != 0, page);
+	VM_BUG_ON_FOLIO(access_ret != 0, folio);
 
 	return ret;
-
 }
-EXPORT_SYMBOL(__test_set_page_writeback);
+EXPORT_SYMBOL(__folio_start_writeback);
 
 /**
  * folio_wait_writeback - Wait for a folio to finish writeback.
-- 
2.30.2

