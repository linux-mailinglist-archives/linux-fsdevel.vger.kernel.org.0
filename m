Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE13D9C28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 05:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhG2DZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 23:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhG2DZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 23:25:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E658C061757;
        Wed, 28 Jul 2021 20:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Zx24Tdms2CAcVL+Y0xOOs/yG6aW6xTMzubnm9RhAPcs=; b=CmQJQH43AEoXaW6IJUt9izAtX1
        nkDtCr++9IelU/oLypXAuC4T4bx4cGCi9ychlZmYlTz5n3DMVxN5w7aQdahPJA4R+eggkUzB8PF+1
        UlsPalGGzI0z8qrMs66jk2fASWKfU8cdnOJULDzBMGKHA+oQn1J/Ddag8hGwY+LO9g7vgUtiuxVg0
        J06bxwWImi5fyAnx5TpHOgTnKSt+3g4e553AEsxoMwFIRkfLDbXys3Ht/ENgNyh80l05luVzjIStH
        Zbc6ZbAqhDPTOZkssqqzYxOqpSiV7/WdLM85limjNXxnqoBC6WHFZYYnTeWtCJjA349EqIKx/tqTN
        CAQKsHEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8weA-00GgCH-Gr; Thu, 29 Jul 2021 03:24:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        hsiangkao@linux.alibaba.com, djwong@kernel.org, hch@lst.de,
        agruenba@redhat.com
Subject: [PATCH v2] iomap: Support inline data with block size < page size
Date:   Thu, 29 Jul 2021 04:23:44 +0100
Message-Id: <20210729032344.3975412-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the restriction that inline data must start on a page boundary
in a file.  This allows, for example, the first 2KiB to be stored out
of line and the trailing 30 bytes to be stored inline.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v2:
 - Rebase on top of iomap: Support file tail packing v9

 fs/iomap/buffered-io.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 66b733537c46..50f18985ed13 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -209,28 +209,26 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
 		struct iomap *iomap)
 {
 	size_t size = i_size_read(inode) - iomap->offset;
+	size_t poff = offset_in_page(iomap->offset);
 	void *addr;
 
 	if (PageUptodate(page))
-		return 0;
+		return PAGE_SIZE - poff;
 
-	/* inline data must start page aligned in the file */
-	if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
-		return -EIO;
 	if (WARN_ON_ONCE(size > PAGE_SIZE -
 			 offset_in_page(iomap->inline_data)))
 		return -EIO;
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
-	if (WARN_ON_ONCE(page_has_private(page)))
-		return -EIO;
+	if (poff > 0)
+		iomap_page_create(inode, page);
 
-	addr = kmap_atomic(page);
+	addr = kmap_atomic(page) + poff;
 	memcpy(addr, iomap->inline_data, size);
-	memset(addr + size, 0, PAGE_SIZE - size);
+	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_atomic(addr);
-	SetPageUptodate(page);
-	return 0;
+	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
+	return PAGE_SIZE - poff;
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -252,13 +250,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	unsigned poff, plen;
 	sector_t sector;
 
-	if (iomap->type == IOMAP_INLINE) {
-		int ret = iomap_read_inline_data(inode, page, iomap);
-
-		if (ret)
-			return ret;
-		return PAGE_SIZE;
-	}
+	if (iomap->type == IOMAP_INLINE)
+		return iomap_read_inline_data(inode, page, iomap);
 
 	/* zero post-eof blocks as the page may be mapped */
 	iop = iomap_page_create(inode, page);
@@ -593,10 +586,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 static int iomap_write_begin_inline(struct inode *inode,
 		struct page *page, struct iomap *srcmap)
 {
+	int ret;
+
 	/* needs more work for the tailpacking case, disable for now */
 	if (WARN_ON_ONCE(srcmap->offset != 0))
 		return -EIO;
-	return iomap_read_inline_data(inode, page, srcmap);
+	ret = iomap_read_inline_data(inode, page, srcmap);
+	if (ret < 0)
+		return ret;
+	return 0;
 }
 
 static int
-- 
2.30.2

