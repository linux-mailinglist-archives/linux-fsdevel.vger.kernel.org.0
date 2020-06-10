Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15E1F5CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgFJURC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730545AbgFJUNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D0C03E96F;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VYY9s5PmR1cZwQ4BpRweOnmMFXWZx2Gnlj2etUW5KY8=; b=aAG6i/6K8oKtZYRWYMUiyLnDho
        9J9EHOCY5VyIn7O1jBGrPkf1M86kEkutYSUL0J+Ld8Uf5cwemZgdcDh1/s2WJCdvgWE+5J8gnP3sm
        mqnEWlBV3jYbTnpzzKCHa6R9rHTrJcEmDfNAcHtnLhP4ldRNeDdDDjrAXS88ES5ILGtrdQLSzxN+G
        BZkjOWgQr7s3Ksqb7X9pqaVZxxIo4WF9NXz/h7d+pEzHU1hBnvAl5khWTrc/woSuTLCzazNHCus5c
        MTa2Fb89YvW5rmIsGQ7fbww1XVFQ40kgRcFva5/WjgEIpGvKyF0iMu8FPaEWSmrj1G0fTWDNupKE2
        +e5AdrnQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003VG-49; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 23/51] iomap: Support THPs in iomap_adjust_read_range
Date:   Wed, 10 Jun 2020 13:13:17 -0700
Message-Id: <20200610201345.13273-24-willy@infradead.org>
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

Pass the struct page instead of the iomap_page so we can determine the
size of the page.  Use offset_in_thp() instead of offset_in_page() and
use thp_size() instead of PAGE_SIZE.  Convert the arguments to be size_t
instead of unsigned int, in case pages ever get larger than 2^31 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1a398af42ed2..1b450e966822 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -77,16 +77,16 @@ iomap_page_release(struct page *page)
 /*
  * Calculate the range inside the page that we actually need to read.
  */
-static void
-iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
-		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp)
+static void iomap_adjust_read_range(struct inode *inode, struct page *page,
+		loff_t *pos, loff_t length, size_t *offp, size_t *lenp)
 {
+	struct iomap_page *iop = to_iomap_page(page);
 	loff_t orig_pos = *pos;
 	loff_t isize = i_size_read(inode);
 	unsigned block_bits = inode->i_blkbits;
 	unsigned block_size = (1 << block_bits);
-	unsigned poff = offset_in_page(*pos);
-	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
+	size_t poff = offset_in_thp(page, *pos);
+	size_t plen = min_t(loff_t, thp_size(page) - poff, length);
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
@@ -124,7 +124,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
 	if (orig_pos <= isize && orig_pos + length > isize) {
-		unsigned end = offset_in_page(isize - 1) >> block_bits;
+		unsigned end = offset_in_thp(page, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
 			plen -= (last - end) * block_size;
@@ -241,7 +241,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iomap_page *iop = iomap_page_create(inode, page);
 	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
-	unsigned poff, plen;
+	size_t poff, plen;
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -251,7 +251,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
-	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
+	iomap_adjust_read_range(inode, page, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
@@ -560,18 +560,19 @@ static int
 __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 		struct page *page, struct iomap *srcmap)
 {
-	struct iomap_page *iop = iomap_page_create(inode, page);
 	loff_t block_size = i_blocksize(inode);
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
-	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
+	unsigned from = offset_in_page(pos), to = from + len;
+	size_t poff, plen;
 	int status;
 
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

