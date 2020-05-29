Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C571E7353
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgE2DDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391655AbgE2C6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6763C08C5D1;
        Thu, 28 May 2020 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UiMCPebDLCXMqtOlym1wnistbwlAeXJLnwQjJng5vCw=; b=lGugaJHQ+YV3FPmqtvcjRR94wu
        FLmhxfY7yeWyvAM/LLhJRGbLFXpjGbBkOy6uVs6oP20tJ0bok7hJXncosBOkC0KCPmMqvkoWxExwt
        YvfrJt20etGOVznhlys89u1PP17fup5zv8RySURBraAZT0avKx0wZQVRWKv1ybeFd8Rzsz/kjGHUM
        hpmM5FBR9QhilVgK8eFxYdhlDcg8Tqtk/vCt6umsmYFXzL26S9tUSKGHO+IQWavfyPiAD974v6fgB
        NdYkObPB2q46c054aS+9dx+N8Z2kwi6Zts9+Bob4Ev3NMO5r8yufVzoAoRHJvbo/rFgelYIzjk19+
        jHK8ib2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008R2-3F; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/39] iomap: Support large pages in iomap_adjust_read_range
Date:   Thu, 28 May 2020 19:57:59 -0700
Message-Id: <20200529025824.32296-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Pass the struct page instead of the iomap_page so we can determine the
size of the page.  Use offset_in_thp() instead of offset_in_page() and use
thp_size() instead of PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4a79061073eb..423ffc9d4a97 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -83,15 +83,16 @@ iomap_page_release(struct page *page)
  * Calculate the range inside the page that we actually need to read.
  */
 static void
-iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
+iomap_adjust_read_range(struct inode *inode, struct page *page,
 		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp)
 {
+	struct iomap_page *iop = to_iomap_page(page);
 	loff_t orig_pos = *pos;
 	loff_t isize = i_size_read(inode);
 	unsigned block_bits = inode->i_blkbits;
 	unsigned block_size = (1 << block_bits);
-	unsigned poff = offset_in_page(*pos);
-	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
+	unsigned poff = offset_in_thp(page, *pos);
+	unsigned plen = min_t(loff_t, thp_size(page) - poff, length);
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
@@ -129,7 +130,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
 	if (orig_pos <= isize && orig_pos + length > isize) {
-		unsigned end = offset_in_page(isize - 1) >> block_bits;
+		unsigned end = offset_in_thp(page, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
 			plen -= (last - end) * block_size;
@@ -256,7 +257,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
-	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
+	iomap_adjust_read_range(inode, page, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
@@ -571,7 +572,6 @@ static int
 __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 		struct page *page, struct iomap *srcmap)
 {
-	struct iomap_page *iop = iomap_page_create(inode, page);
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
@@ -580,9 +580,10 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 
 	if (PageUptodate(page))
 		return 0;
+	iomap_page_create(inode, page);
 
 	do {
-		iomap_adjust_read_range(inode, iop, &block_start,
+		iomap_adjust_read_range(inode, page, &block_start,
 				block_end - block_start, &poff, &plen);
 		if (plen == 0)
 			break;
-- 
2.26.2

