Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB4477E25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbhLPVHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbhLPVHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8C4C061574;
        Thu, 16 Dec 2021 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FDfqvmr3ab60gvr2H9/ZIXdXgt08gzt0VMaO3j2bXiI=; b=C9hlJDVjrnhBvPbQ9Je7UGOeDW
        EzvjljBQj/ieWp7QwjEhbmMwkxeejxbZ9RPxwhUjaqWxDVBZmhG9ucvqaqKysYaieoBWGFlOR3Vwd
        e1IrBw9tFfpadIjFQedB/OOjrfwthqtVOcvVTkyEc+95boHgWWDfjispG/DuZc7phtjxU4sDQ0DhK
        FI0jlQdOxif0nQYDMArPTML/22c2VjlyYfe0kMI/rOVVM3aAHaK+UQQfKEt58cWXISCiuHB5Rtt/+
        WZnapa1mTFNI3bhvH4IlX/u0o+pH7SYworrKf2FXtWmE3fAsoA+4Z+HqzLf0BRfCCSIHH1zGBzqFE
        wtOk/jPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyB-00Fx3g-Nw; Thu, 16 Dec 2021 21:07:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 08/25] iomap: Add iomap_invalidate_folio
Date:   Thu, 16 Dec 2021 21:06:58 +0000
Message-Id: <20211216210715.3801857-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keep iomap_invalidatepage around as a wrapper for use in address_space
operations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 20 ++++++++++++--------
 include/linux/iomap.h  |  1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b0192b148c9f..de7ce1909527 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -479,23 +479,27 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL_GPL(iomap_releasepage);
 
-void
-iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
+void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 {
-	struct folio *folio = page_folio(page);
-
-	trace_iomap_invalidatepage(page->mapping->host, offset, len);
+	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
 
 	/*
 	 * If we're invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
 	 */
-	if (offset == 0 && len == PAGE_SIZE) {
-		WARN_ON_ONCE(PageWriteback(page));
-		cancel_dirty_page(page);
+	if (offset == 0 && len == folio_size(folio)) {
+		WARN_ON_ONCE(folio_test_writeback(folio));
+		folio_cancel_dirty(folio);
 		iomap_page_release(folio);
 	}
 }
+EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
+
+void iomap_invalidatepage(struct page *page, unsigned int offset,
+		unsigned int len)
+{
+	iomap_invalidate_folio(page_folio(page), offset, len);
+}
 EXPORT_SYMBOL_GPL(iomap_invalidatepage);
 
 #ifdef CONFIG_MIGRATION
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6d1b08d0ae93..29491fb9c5ba 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -225,6 +225,7 @@ void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
 int iomap_releasepage(struct page *page, gfp_t gfp_mask);
+void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 void iomap_invalidatepage(struct page *page, unsigned int offset,
 		unsigned int len);
 #ifdef CONFIG_MIGRATION
-- 
2.33.0

