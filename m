Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCBC3C97D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbhGOE6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbhGOE6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:58:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF75C06175F;
        Wed, 14 Jul 2021 21:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vEW50pAiBefXZGZB4rMFPiTBwMLt7IwLVQwI0eyDnjw=; b=Xtis+O5l25gFqKYqvSBk/4/90b
        Z4c+n5MI2dGkoPxlRte/QI1ctxxf8AavDBa6IuUBLFaBXht0V3iL71IUTkyspxmyt4akqJ03YY4ic
        IqJKxU2gaGLZTz6Iu10BcsxGegKUoqOWje8W9N6aApYV9Vnc3UjUx5LozFiIB2CawqfxtfMp9KOt1
        U5d8g/1JI5GLOwr4hzIXC5uoA8JzlDcXd0qc8HeyFD6S0lUVswDXkQRQ5Z9TozMBd8RkbyabGTcC0
        589Vk+cfipC8YVky+BStDP1d6w7SkHCaas0nlQ9LHeXbdtuc51dlY3gqYUP5fRR/j5rOdp6FkFeek
        N4rBL6OQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tMz-002z2a-2W; Thu, 15 Jul 2021 04:53:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 097/138] iomap: Pass the iomap_page into iomap_set_range_uptodate
Date:   Thu, 15 Jul 2021 04:36:23 +0100
Message-Id: <20210715033704.692967-98-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All but one caller already has the iomap_page, and we can avoid getting
it again.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6b41019a51a3..fbe4ebc074ce 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -134,11 +134,9 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	*lenp = plen;
 }
 
-static void
-iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
+static void iomap_iop_set_range_uptodate(struct page *page,
+		struct iomap_page *iop, unsigned off, unsigned len)
 {
-	struct folio *folio = page_folio(page);
-	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = page->mapping->host;
 	unsigned first = off >> inode->i_blkbits;
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
@@ -151,14 +149,14 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
 
-static void
-iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
+static void iomap_set_range_uptodate(struct page *page,
+		struct iomap_page *iop, unsigned off, unsigned len)
 {
 	if (PageError(page))
 		return;
 
-	if (page_has_private(page))
-		iomap_iop_set_range_uptodate(page, off, len);
+	if (iop)
+		iomap_iop_set_range_uptodate(page, iop, off, len);
 	else
 		SetPageUptodate(page);
 }
@@ -174,7 +172,8 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
 		ClearPageUptodate(page);
 		SetPageError(page);
 	} else {
-		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
+		iomap_set_range_uptodate(page, iop, bvec->bv_offset,
+						bvec->bv_len);
 	}
 
 	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
@@ -254,7 +253,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
 		zero_user(page, poff, plen);
-		iomap_set_range_uptodate(page, poff, plen);
+		iomap_set_range_uptodate(page, iop, poff, plen);
 		goto done;
 	}
 
@@ -583,7 +582,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(page, poff, plen);
+		iomap_set_range_uptodate(page, iop, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
@@ -645,6 +644,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct page *page)
 {
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 	flush_dcache_page(page);
 
 	/*
@@ -660,7 +661,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
-	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_range_uptodate(page, iop, offset_in_page(pos), len);
 	__set_page_dirty_nobuffers(page);
 	return copied;
 }
-- 
2.30.2

