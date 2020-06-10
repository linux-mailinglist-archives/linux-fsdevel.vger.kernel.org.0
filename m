Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175C21F5CC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbgFJUQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbgFJUNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C9BC00862C;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UDxDIbJeI06u3N6GB6RtskaCIa6/f+0o49vLLz1oNrw=; b=LCORptvixsIn242sHeS/5VHXpO
        9cijUpAt69pL3N/zjLExsd1abDJ7gozi1ZMubtZlJm0x5DoXnbaIjRPCGRp8Rl3pZKoPgyMYFlxBe
        FNibNK8EKx6qrIEpe1yxFEgjlQRu/D+xEaRjWH7CLIMwWRCE7v41fp39rEc+cOBCok5lRyqNBQbGH
        GJ6i6K2TQ/34krSF0IcT5BCXjGIXe1OE8e0O45/enfa7q8AhKmQSzT1NkloScLhkKbv30ZJIQsIjA
        VX5lAc7vZJLXk9Fh35YJvT8z4KLVEj6kKDlUKfYMBb8jZvrGSV2plLH7rG+OQyi8qIdd1OWxSQVvp
        DkDmXpQQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003VM-5k; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 24/51] iomap: Support THPs in invalidatepage
Date:   Wed, 10 Jun 2020 13:13:18 -0700
Message-Id: <20200610201345.13273-25-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If we're punching a hole in a THP, we need to remove the per-page iomap
data, but not clear the dirty bit from the page, so separate the two
conditions.  This means that writepage can now come across a page with
no iop allocated, so remove the assertions that there is already one,
and just create one if there isn't one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1b450e966822..b1a2ab2c7a8d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -487,17 +487,21 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 void
 iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 {
+	bool full_page = (offset == 0) && (len == thp_size(page));
 	trace_iomap_invalidatepage(page->mapping->host, offset, len);
 
 	/*
 	 * If we are invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
 	 */
-	if (offset == 0 && len == PAGE_SIZE) {
+	if (full_page) {
 		WARN_ON_ONCE(PageWriteback(page));
 		cancel_dirty_page(page);
-		iomap_page_release(page);
 	}
+
+	/* Punching a hole in a THP requires releasing the iop */
+	if (full_page || thp_order(page) > 0)
+		iomap_page_release(page);
 }
 EXPORT_SYMBOL_GPL(iomap_invalidatepage);
 
@@ -1064,14 +1068,13 @@ static void
 iomap_finish_page_writeback(struct inode *inode, struct page *page,
 		int error)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct iomap_page *iop = iomap_page_create(inode, page);
 
 	if (error) {
 		SetPageError(page);
 		mapping_set_error(inode->i_mapping, -EIO);
 	}
 
-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
 
 	if (!iop || atomic_dec_and_test(&iop->write_count))
@@ -1360,14 +1363,13 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct page *page, u64 end_offset)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct iomap_page *iop = iomap_page_create(inode, page);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	u64 file_offset; /* file offset of page */
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
 
 	/*
-- 
2.26.2

