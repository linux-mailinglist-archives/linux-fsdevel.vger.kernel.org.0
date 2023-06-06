Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79535724FFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbjFFWgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbjFFWfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:35:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D49B26BB
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jOALfJLyvjPEQIpHOW/8vAfZ7DTUe2p7Aq5vwq5459M=; b=uO5L2Yd/VkfHNW2ZXaQlPBEYrT
        Xu7FhP/4ebN7A8xa4o2pK032Nu+dH+H+PsR0bk5KWRBT7Fag4zIuAsipzirmQrTZL5YfoeikCqloe
        bRrf+gYzGPFxGVvkr2wlK57fzhFWcKpShCbAS71bq+hq46xIttk3eefiZTTXRHg6gwVaWDSeG382F
        MoInhYo44uGhSOe7XZC0afYqke7ofpclLbsWSPv7Iy/LZczRdBCZCBavJjFJCC4nQEzjpzjUPlb/f
        n8zY4Hp7B0FaYaRvqNr1ixisedOQVrpOjfKhdP/bqaQrbrT01MF0r9EKG6ByWgZc7Lemc9ztFTs3E
        hrWe0aUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6fFV-00DbEx-CA; Tue, 06 Jun 2023 22:33:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 08/14] buffer: Convert __block_commit_write() to take a folio
Date:   Tue,  6 Jun 2023 23:33:40 +0100
Message-Id: <20230606223346.3241328-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230606223346.3241328-1-willy@infradead.org>
References: <20230606223346.3241328-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This removes a hidden call to compound_head() inside
__block_commit_write() and moves it to those callers which are still
page based.  Also make block_write_end() safe for large folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f34ed29b1085..8ea9edd86519 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2116,15 +2116,15 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 }
 EXPORT_SYMBOL(__block_write_begin);
 
-static int __block_commit_write(struct inode *inode, struct page *page,
-		unsigned from, unsigned to)
+static int __block_commit_write(struct inode *inode, struct folio *folio,
+		size_t from, size_t to)
 {
-	unsigned block_start, block_end;
-	int partial = 0;
+	size_t block_start, block_end;
+	bool partial = false;
 	unsigned blocksize;
 	struct buffer_head *bh, *head;
 
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 	blocksize = bh->b_size;
 
 	block_start = 0;
@@ -2132,7 +2132,7 @@ static int __block_commit_write(struct inode *inode, struct page *page,
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
 			if (!buffer_uptodate(bh))
-				partial = 1;
+				partial = true;
 		} else {
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
@@ -2147,11 +2147,11 @@ static int __block_commit_write(struct inode *inode, struct page *page,
 	/*
 	 * If this is a partial write which happened to make all buffers
 	 * uptodate then we can optimize away a bogus read_folio() for
-	 * the next read(). Here we 'discover' whether the page went
+	 * the next read(). Here we 'discover' whether the folio went
 	 * uptodate as a result of this (potentially partial) write.
 	 */
 	if (!partial)
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	return 0;
 }
 
@@ -2188,10 +2188,9 @@ int block_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
-	unsigned start;
-
-	start = pos & (PAGE_SIZE - 1);
+	size_t start = pos - folio_pos(folio);
 
 	if (unlikely(copied < len)) {
 		/*
@@ -2203,18 +2202,18 @@ int block_write_end(struct file *file, struct address_space *mapping,
 		 * read_folio might come in and destroy our partial write.
 		 *
 		 * Do the simplest thing, and just treat any short write to a
-		 * non uptodate page as a zero-length write, and force the
+		 * non uptodate folio as a zero-length write, and force the
 		 * caller to redo the whole thing.
 		 */
-		if (!PageUptodate(page))
+		if (!folio_test_uptodate(folio))
 			copied = 0;
 
-		page_zero_new_buffers(page, start+copied, start+len);
+		page_zero_new_buffers(&folio->page, start+copied, start+len);
 	}
-	flush_dcache_page(page);
+	flush_dcache_folio(folio);
 
 	/* This could be a short (even 0-length) commit */
-	__block_commit_write(inode, page, start, start+copied);
+	__block_commit_write(inode, folio, start, start + copied);
 
 	return copied;
 }
@@ -2537,8 +2536,9 @@ EXPORT_SYMBOL(cont_write_begin);
 
 int block_commit_write(struct page *page, unsigned from, unsigned to)
 {
-	struct inode *inode = page->mapping->host;
-	__block_commit_write(inode,page,from,to);
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
+	__block_commit_write(inode, folio, from, to);
 	return 0;
 }
 EXPORT_SYMBOL(block_commit_write);
@@ -2586,7 +2586,7 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 
 	ret = __block_write_begin_int(folio, 0, end, get_block, NULL);
 	if (!ret)
-		ret = block_commit_write(&folio->page, 0, end);
+		ret = __block_commit_write(inode, folio, 0, end);
 
 	if (unlikely(ret < 0))
 		goto out_unlock;
-- 
2.39.2

