Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560933CEF31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388971AbhGSVdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381348AbhGSSHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:07:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D9AC06178C;
        Mon, 19 Jul 2021 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N9B5ve6ovqtgjce1eRAExZZQLHs/EQ6RuhK6otFJV0c=; b=sUQPfapsAfFUCAT9eCjcP4/j/J
        OmEricRCvhqn6ZhKtiBB1idVqanyxKN7MqJfUu6TLwQAFHmQVBSGLDzCa0179RBznoOnHobwMbRXV
        cyRtY8VvjZKsybiBQzvOLfhHIfMryGLx2OxAjWnok4HN/QvRhBy4/wNbx02Vl3SsssmrAme0siE+R
        OCltdb4nml7wK+e4DR0J61kI9NBc7Rwc5OmITfx4uD7XUYNJhsQdafv8j5n9MggkzPwfX223mMTZJ
        1U0NDTFr108cQzgJa8Rqmd6h27fohIqmWG+5WZ1iiljm3qf5Eg8JYtHPAijnq7jIzO46rrOeMLNY7
        5tq0pF+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YE9-007LZ7-3A; Mon, 19 Jul 2021 18:43:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v15 05/17] iomap: Convert iomap_page_release to take a folio
Date:   Mon, 19 Jul 2021 19:39:49 +0100
Message-Id: <20210719184001.1750630-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_page_release() was also assuming that it was being passed a
head page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ec8bdc0c63df..83eb5fdcbe05 100644
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
+	unsigned int nr_blocks = i_blocks_per_folio(folio->mapping->host,
+							folio);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
 	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
-			PageUptodate(page));
+			folio_test_uptodate(folio));
 	kfree(iop);
 }
 
@@ -458,6 +458,8 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 int
 iomap_releasepage(struct page *page, gfp_t gfp_mask)
 {
+	struct folio *folio = page_folio(page);
+
 	trace_iomap_releasepage(page->mapping->host, page_offset(page),
 			PAGE_SIZE);
 
@@ -468,7 +470,7 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 	 */
 	if (PageDirty(page) || PageWriteback(page))
 		return 0;
-	iomap_page_release(page);
+	iomap_page_release(folio);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(iomap_releasepage);
@@ -476,6 +478,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 void
 iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 {
+	struct folio *folio = page_folio(page);
+
 	trace_iomap_invalidatepage(page->mapping->host, offset, len);
 
 	/*
@@ -485,7 +489,7 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 	if (offset == 0 && len == PAGE_SIZE) {
 		WARN_ON_ONCE(PageWriteback(page));
 		cancel_dirty_page(page);
-		iomap_page_release(page);
+		iomap_page_release(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidatepage);
-- 
2.30.2

