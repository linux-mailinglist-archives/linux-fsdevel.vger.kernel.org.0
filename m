Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261E01D4F06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgEONS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgEONRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB7EC05BD0A;
        Fri, 15 May 2020 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dD9nVOWGwAdtF5Vt0w+D5s2gKPxSD7JmOgMrMrHOmY4=; b=KpzoZBbAmjWwdFJxwedHsBhPKW
        O3aGMgxi6+pOIdZGp7theZ4uKfR1dHwNTQ7neJc3I6hzjbwadOEIV3FvvNndyRNZyWVgfF8lP5xCW
        9hIVgtBTwTFQG1ISQ2Wd4iOJFtEXJdGjIOUv91w48CVK84HYFtRTibvxE397mC8C+4l7fLWE8IoCN
        0xVTwOcqZDpPrFn4Tl/lcHs1C4ZYEJ6e8OqjRwUEF9p8ABnXpyUwKvkcw6fLF3A8j6bzW/GXBma/R
        YSk7GvPr4Nd32nXa9FqM9IJMpm+gQhIJ2SNXuUVbF9Ul1LDmopxTpZJl9OI6umJ4VyfoVimZZEZ/J
        6t9H/HfQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaCz-0005c0-9J; Fri, 15 May 2020 13:17:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/36] iomap: Support arbitrarily many blocks per page
Date:   Fri, 15 May 2020 06:16:33 -0700
Message-Id: <20200515131656.12890-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Size the uptodate array dynamically.  Now that this array is protected
by a spinlock, we can use bitmap functions to set the bits in this array
instead of a loop around set_bit().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4bc37bf8d057..4a79061073eb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -22,14 +22,14 @@
 #include "../internal.h"
 
 /*
- * Structure allocated for each page when block size < PAGE_SIZE to track
+ * Structure allocated for each page when block size < page size to track
  * sub-page uptodate status and I/O completions.
  */
 struct iomap_page {
 	atomic_t		read_count;
 	atomic_t		write_count;
 	spinlock_t		uptodate_lock;
-	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
+	unsigned long		uptodate[];
 };
 
 static inline struct iomap_page *to_iomap_page(struct page *page)
@@ -45,15 +45,14 @@ static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
+	unsigned int nr_blocks = i_blocks_per_page(inode, page);
 
-	if (iop || i_blocks_per_page(inode, page) <= 1)
+	if (iop || nr_blocks <= 1)
 		return iop;
 
-	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
-	atomic_set(&iop->read_count, 0);
-	atomic_set(&iop->write_count, 0);
+	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
+				GFP_NOFS | __GFP_NOFAIL);
 	spin_lock_init(&iop->uptodate_lock);
-	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
 
 	/*
 	 * migrate_page_move_mapping() assumes that pages with private data have
@@ -146,20 +145,12 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	struct iomap_page *iop = to_iomap_page(page);
 	struct inode *inode = page->mapping->host;
 	unsigned first = off >> inode->i_blkbits;
-	unsigned last = (off + len - 1) >> inode->i_blkbits;
-	bool uptodate = true;
+	unsigned count = len >> inode->i_blkbits;
 	unsigned long flags;
-	unsigned int i;
 
 	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	for (i = 0; i < i_blocks_per_page(inode, page); i++) {
-		if (i >= first && i <= last)
-			set_bit(i, iop->uptodate);
-		else if (!test_bit(i, iop->uptodate))
-			uptodate = false;
-	}
-
-	if (uptodate)
+	bitmap_set(iop->uptodate, first, count);
+	if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
 		SetPageUptodate(page);
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
-- 
2.26.2

