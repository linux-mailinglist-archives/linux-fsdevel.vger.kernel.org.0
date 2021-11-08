Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4544796B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbhKHEio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhKHEin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:38:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5091C061570;
        Sun,  7 Nov 2021 20:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Sk7LpdtcT/zMPW2QS9Dc0ppoW5yOJNSyoam+tZwg+L4=; b=tvMRYOss/mB+dwvifGAA86KaJF
        mSUk4yif3ihSTCsX4tPGj882QxRNGFFErvlykgWV8E8koHubMO/hrft0Na56u8BK3AWfr/25swQCV
        VfjrCe82CqZ3Gt8gKzILjP5IovKhFE3ce2cOzF6ip0xXjTZG6jR+fNXtOoboPmXvPv+HQ2/DCnvK6
        r6CWvfLGh9wd5deYCDZ9KiZ18zGetx6peT+att+usJsoIA/9Et1RQDqLy3Qh6aZRV6CcWTnIlfGdg
        T1FovOfXup+wmW8AMUDQsvEnHsiZIOBa/WiynDR5HG4ICGTSoXgZ+uuGFyZLlx1ZRHfPMVLyw2a0x
        R2YHfHIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwJ3-008A21-Id; Mon, 08 Nov 2021 04:31:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 10/28] iomap: Convert iomap_page_release to take a folio
Date:   Mon,  8 Nov 2021 04:05:33 +0000
Message-Id: <20211108040551.1942823-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_page_release() was also assuming that it was being passed a
head page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6972ac8fda77..ad3a16861ddc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -59,18 +59,18 @@ iomap_page_create(struct inode *inode, struct folio *folio)
 	return iop;
 }
 
-static void
-iomap_page_release(struct page *page)
+static void iomap_page_release(struct folio *folio)
 {
-	struct iomap_page *iop = detach_page_private(page);
-	unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
+	struct iomap_page *iop = folio_detach_private(folio);
+	struct inode *inode = folio->mapping->host;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
 	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
-			PageUptodate(page));
+			folio_test_uptodate(folio));
 	kfree(iop);
 }
 
@@ -451,6 +451,8 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 int
 iomap_releasepage(struct page *page, gfp_t gfp_mask)
 {
+	struct folio *folio = page_folio(page);
+
 	trace_iomap_releasepage(page->mapping->host, page_offset(page),
 			PAGE_SIZE);
 
@@ -461,7 +463,7 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 	 */
 	if (PageDirty(page) || PageWriteback(page))
 		return 0;
-	iomap_page_release(page);
+	iomap_page_release(folio);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(iomap_releasepage);
@@ -469,6 +471,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 void
 iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 {
+	struct folio *folio = page_folio(page);
+
 	trace_iomap_invalidatepage(page->mapping->host, offset, len);
 
 	/*
@@ -478,7 +482,7 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 	if (offset == 0 && len == PAGE_SIZE) {
 		WARN_ON_ONCE(PageWriteback(page));
 		cancel_dirty_page(page);
-		iomap_page_release(page);
+		iomap_page_release(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidatepage);
-- 
2.33.0

