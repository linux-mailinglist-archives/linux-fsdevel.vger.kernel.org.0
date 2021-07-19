Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1995D3CEF33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389417AbhGSVd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382579AbhGSSH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:07:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0EC0617AB;
        Mon, 19 Jul 2021 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=T/Dzopz4wPug8dYWGXlrS52upno8KobFcrpG2U14MrM=; b=ocZCurIALumvN27ERakjswTMo9
        BHjPJpEPKNkB/r9zD6MFD4T+Xauib6vEMYWly54fQFdIpf7REE2ekZ3RT9kYP3QwOxjR5dclSyE8C
        1BKFMTPUP3B9RZ0iJd8+t1LGNt/6E8pxZ+Rw80QPyjLO58QE/BR557CF+uNTmw/f1zB5eSCCtvMEu
        iirb9u98XW5b2f5S+KkID4EB472Ai1Gkj8HP0KxvNQcOA4/gLntlfshdwCXh6p+2l5iSEsgcQZsTt
        QeHbXlzHmDjzgtjW2cr6LlnTPvxLK9WBRFZTieTN13J/Bv4FiWSKg9WENfyMtEO4/BCeL7Qkl3UkR
        pYmvjNEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YDR-007LXm-Ou; Mon, 19 Jul 2021 18:42:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v15 04/17] iomap: Convert iomap_page_create to take a folio
Date:   Mon, 19 Jul 2021 19:39:48 +0100
Message-Id: <20210719184001.1750630-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function already assumed it was being passed a head page, so
just formalise that.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d4870a2691f9..ec8bdc0c63df 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -42,11 +42,10 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 static struct bio_set iomap_ioend_bioset;
 
 static struct iomap_page *
-iomap_page_create(struct inode *inode, struct page *page)
+iomap_page_create(struct inode *inode, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop = to_iomap_page(folio);
-	unsigned int nr_blocks = i_blocks_per_page(inode, page);
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	if (iop || nr_blocks <= 1)
 		return iop;
@@ -54,9 +53,9 @@ iomap_page_create(struct inode *inode, struct page *page)
 	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
 			GFP_NOFS | __GFP_NOFAIL);
 	spin_lock_init(&iop->uptodate_lock);
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		bitmap_fill(iop->uptodate, nr_blocks);
-	attach_page_private(page, iop);
+	folio_attach_private(folio, iop);
 	return iop;
 }
 
@@ -236,6 +235,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 {
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
+	struct folio *folio = page_folio(page);
 	struct iomap_page *iop;
 	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
@@ -249,7 +249,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(inode, page);
+	iop = iomap_page_create(inode, folio);
 	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
@@ -549,7 +549,8 @@ static int
 __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 		struct page *page, struct iomap *srcmap)
 {
-	struct iomap_page *iop = iomap_page_create(inode, page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = iomap_page_create(inode, folio);
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
@@ -1303,7 +1304,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct page *page, u64 end_offset)
 {
-	struct iomap_page *iop = iomap_page_create(inode, page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = iomap_page_create(inode, folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	u64 file_offset; /* file offset of page */
-- 
2.30.2

