Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E093CEF34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389461AbhGSVdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382562AbhGSSH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:07:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6E4C0617A7;
        Mon, 19 Jul 2021 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kKwIRh+f9wsPxETlTXIuMZIZvRf6jI5cu52KEL/0IJ8=; b=QSrCIFRG2r3pi9/+NP3OnfdbHl
        KxQzgCBEbrYNCzH67uM7WYfm7XWgcjsr4KOzKG9kEGlV1VpEijqVAp0saLueLtn2e5/j/n7MwWlJu
        Y0IyJkxTyL2qREci6sGWM0IJsO0RCJeTwv8Fpzf5KaKIgIGhNi6uenuaDQET2MHHbMj/gGuMshZbb
        6JTI/gyB5MwrDts+5pZGxHyve9BqETH+xQ99aUus0zeJMS6uXY7dEqNP0GkkQeKdMas4tKGfkzqOm
        KV11f1fM/GgEAAOFiO6q70z1Wanjjqgyp3zxAVFA4Ky5vLG1Y3DnWLFOMbE/YUv36qfYUbKekEmYa
        RkT9rvsA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YGS-007Lip-O5; Mon, 19 Jul 2021 18:45:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v15 08/17] iomap: Pass the iomap_page into iomap_set_range_uptodate
Date:   Mon, 19 Jul 2021 19:39:52 +0100
Message-Id: <20210719184001.1750630-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All but one caller already has the iomap_page, and we can avoid getting
it again.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0d7b6ef4c5cc..62d8ebcda429 100644
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
@@ -256,7 +255,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
 		zero_user(page, poff, plen);
-		iomap_set_range_uptodate(page, poff, plen);
+		iomap_set_range_uptodate(page, iop, poff, plen);
 		goto done;
 	}
 
@@ -585,7 +584,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(page, poff, plen);
+		iomap_set_range_uptodate(page, iop, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
@@ -647,6 +646,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct page *page)
 {
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 	flush_dcache_page(page);
 
 	/*
@@ -662,7 +663,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
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

