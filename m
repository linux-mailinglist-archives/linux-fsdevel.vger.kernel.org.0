Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A47374715
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhEERnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbhEERlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:41:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0EFC061263;
        Wed,  5 May 2021 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ohnzd9QIkB6s2iaXAAv+tKeum9/w2lfuooKoxxLeatA=; b=o9/6JLyM8v9hXRmSpJYt0GF20+
        JBIgJb5NZtojE94vAscA/Oh9UAFPUB2CbGLLp8yqxDZWkPlTmBxZPRF6UDvufYEClLzEduahMyrGv
        CVRlKL/vk5aBcjore1p4sU2UZAnAxpBZAvjqIWctK1PJPcfY8S51vE6wEU9Pb7VQjbReGWmBAlRKM
        I4HArCZOH1UyfEb7AbkkdMKNoNH2Hkjde/IKV/4QxjIi3bjxDsfnJdww1ozRyULyxvNN4MGjXasIY
        t6X7CF5j+J4gjyDeE6RvgBVQTZPYAREbx0n+D1nM+UK3s2lNVFP3tHBs2vxr2Hri/dytz4Fiubb6U
        4OmVVu6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leL3U-000cxC-ST; Wed, 05 May 2021 17:12:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 83/96] iomap: Convert iomap_page_create to take a folio
Date:   Wed,  5 May 2021 16:06:15 +0100
Message-Id: <20210505150628.111735-84-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function already assumed it was being passed a head page, so
just formalise that.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 466a3de63497..94d33b0a96ff 100644
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
+	if (folio_uptodate(folio))
 		bitmap_fill(iop->uptodate, nr_blocks);
-	attach_page_private(page, iop);
+	folio_attach_private(folio, iop);
 	return iop;
 }
 
@@ -235,7 +234,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 {
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
-	struct iomap_page *iop = iomap_page_create(inode, page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = iomap_page_create(inode, folio);
 	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
 	unsigned poff, plen;
@@ -547,7 +547,8 @@ static int
 __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 		struct page *page, struct iomap *srcmap)
 {
-	struct iomap_page *iop = iomap_page_create(inode, page);
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = iomap_page_create(inode, folio);
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
@@ -985,6 +986,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 		void *data, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct page *page = data;
+	struct folio *folio = page_folio(page);
 	int ret;
 
 	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
@@ -994,7 +996,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 		block_commit_write(page, 0, length);
 	} else {
 		WARN_ON_ONCE(!PageUptodate(page));
-		iomap_page_create(inode, page);
+		iomap_page_create(inode, folio);
 		set_page_dirty(page);
 	}
 
-- 
2.30.2

