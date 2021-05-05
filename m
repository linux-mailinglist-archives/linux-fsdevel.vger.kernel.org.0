Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5CD37473E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhEERxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhEERwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:52:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE159C035439;
        Wed,  5 May 2021 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=o2TH6QhEzWLrE8XJpaqMkQYw4rvJWZRsE6FI0c6cN8k=; b=VECtjC0yyd207an4UE86dXHZea
        j79N2c0XNGciEV8Uhoim+U8D65flmgMSBmYsFdxOlcM0OVIcu2+pba6nsk1OuDItA+OYbqBDK0oCh
        pl1ekyN5+6o+bDNVmJcPDm0rbR8hPquhbqRVhPqX7jmh02LOK6wDU3yDoT6EXhPINA3MRCeUCscqr
        8WoH6EHeZKY8f5nsw9n3ZolSuz1YtiFpVfZVhHEoTVoR5AmUvFUIc7DXY0CeeftFJKiB5XeXS9Mvw
        zK0lL/098QuSvu0iLvDFIpMje5O4+Kw2gzcPX51wj908OiQ+ao7KHGmYHuvqsc/UrSzXo288rCgcG
        dXmzTBHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leLBA-000dbG-7R; Wed, 05 May 2021 17:19:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 87/96] iomap: Pass the iomap_page into iomap_set_range_uptodate
Date:   Wed,  5 May 2021 16:06:19 +0100
Message-Id: <20210505150628.111735-88-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index c36e16b87c45..f40a22a696c6 100644
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
@@ -670,6 +669,8 @@ EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct page *page)
 {
+	struct folio *folio = page_folio(page);
+	struct iomap_page *iop = to_iomap_page(folio);
 	flush_dcache_page(page);
 
 	/*
@@ -685,7 +686,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
-	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_range_uptodate(page, iop, offset_in_page(pos), len);
 	iomap_set_page_dirty(page);
 	return copied;
 }
-- 
2.30.2

