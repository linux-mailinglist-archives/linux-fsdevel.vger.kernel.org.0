Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2377C2500F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgHXPYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgHXPRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:17:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C9C0613ED;
        Mon, 24 Aug 2020 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dyVV1/WtfynBLYrYkKLGof4OOEqAPKqK6TxXZzYjTco=; b=H05djLHGmbjcLzwN2UkfMkgywz
        cBT773asAxYxNl0FfZCC4YxpgQYKexyL+T9KYhcLqabzR42Rt+jLn+oAx+Wd+nxEUB68ImToQl8vz
        iPt8nyRkZaXL7Ak6LzrdCxg2mpHL86NDxywIsPMEBuzsqrQNXk3bv8V4Loz8INQdMhEhY7E5Lwx7o
        Kig1UbJsto4PSwnYbgxrS5XJf580l7EgSPaJmKs7hn8hCVs2htX5K7NS/GsK+7WexgDVcGswaPiIA
        8bUPrHiKrPIPfrYy+7M4pcPyA26Kn4dIlFnyUoy0qCF5Lag0jGZUxtOVefahuOXUR8oGES9ohpwvB
        002L+kKA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAEDX-0004Cq-9R; Mon, 24 Aug 2020 15:17:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] iomap: Support THPs in iomap_adjust_read_range
Date:   Mon, 24 Aug 2020 16:16:54 +0100
Message-Id: <20200824151700.16097-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824151700.16097-1-willy@infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the struct page instead of the iomap_page so we can determine the
size of the page.  Use offset_in_thp() instead of offset_in_page() and
use thp_size() instead of PAGE_SIZE.  Convert the arguments to be size_t
instead of unsigned int, in case pages ever get larger than 2^31 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2dba054095e8..5cc0343b6a8e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -76,16 +76,16 @@ iomap_page_release(struct page *page)
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
 
@@ -123,7 +123,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
 	if (orig_pos <= isize && orig_pos + length > isize) {
-		unsigned end = offset_in_page(isize - 1) >> block_bits;
+		unsigned end = offset_in_thp(page, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
 			plen -= (last - end) * block_size;
@@ -234,7 +234,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iomap_page *iop = iomap_page_create(inode, page);
 	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
-	unsigned poff, plen;
+	size_t poff, plen;
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -244,7 +244,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
-	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
+	iomap_adjust_read_range(inode, page, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
@@ -550,18 +550,19 @@ static int
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
2.28.0

