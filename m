Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71275353F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 21:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbiEZT3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347385AbiEZT30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 15:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8022C67D15
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=x+uWnv9eHPm+ndPDGZ6NXBV5ZLTnCGexee2oZ9N0PrI=; b=QNr+rf7eqh/VvcxHMxywyXQix2
        duGO7r5M5FEMCOy1SknG1fFeKYkML5/kTWw1/rGOQyzJ228MMiOE241BvT5tj1fdp9jfqoRlUnA1H
        omWibmX2FUg+JBRCXLN/1wNa89AUM48ST82lX8BEA81R9PDo3NrDIPRJjDI5lAZM7NRHDqPGmP4Im
        WKq+cL97wCbZefSGfH7VPNNwSvDC3IviDakdf/8MG88RD1LSMhjKD7nGnoS1wFBhoJOBlRM8FL3hY
        NmiMEosyUkrfu0rnVym/I8tJM7UbzaGMesiGdPxZeC+0MBdixSVfgTvvqaR018FxOJ7fo0tNBorbK
        EWvt1CIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuJAa-001UuE-Il; Thu, 26 May 2022 19:29:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 2/9] jfs: Add jfs_iomap_begin()
Date:   Thu, 26 May 2022 20:29:03 +0100
Message-Id: <20220526192910.357055-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220526192910.357055-1-willy@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn jfs_get_block() into a wrapper around jfs_iomap_begin().  This fixes
a latent bug where JFS was not setting b_size when it encountered a hole.
At least mpage_readahead() does not look at b_size when the buffer is
unmapped, but iomap will care whether iomap->length is set correctly,
and so we may as well set b_size correctly as well.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/inode.c | 67 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index a5dd7e53754a..1a5bdaf35e9b 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/iomap.h>
 #include <linux/mpage.h>
 #include <linux/buffer_head.h>
 #include <linux/pagemap.h>
@@ -196,15 +197,21 @@ void jfs_dirty_inode(struct inode *inode, int flags)
 	set_cflag(COMMIT_Dirty, inode);
 }
 
-int jfs_get_block(struct inode *ip, sector_t lblock,
-		  struct buffer_head *bh_result, int create)
+int jfs_iomap_begin(struct inode *ip, loff_t pos, loff_t length,
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
-	s64 lblock64 = lblock;
+	s64 lblock64 = pos >> ip->i_blkbits;
+	int create = flags & IOMAP_WRITE;
 	int rc = 0;
 	xad_t xad;
 	s64 xaddr;
 	int xflag;
-	s32 xlen = bh_result->b_size >> ip->i_blkbits;
+	s32 xlen;
+
+	xlen = DIV_ROUND_UP(pos + length - (lblock64 << ip->i_blkbits),
+			    i_blocksize(ip));
+	if (xlen < 0)
+		xlen = INT_MAX;
 
 	/*
 	 * Take appropriate lock on inode
@@ -214,8 +221,8 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 	else
 		IREAD_LOCK(ip, RDWRLOCK_NORMAL);
 
-	if (((lblock64 << ip->i_sb->s_blocksize_bits) < ip->i_size) &&
-	    (!xtLookup(ip, lblock64, xlen, &xflag, &xaddr, &xlen, 0)) &&
+	if (pos < ip->i_size &&
+	    !xtLookup(ip, lblock64, xlen, &xflag, &xaddr, &xlen, 0) &&
 	    xaddr) {
 		if (xflag & XAD_NOTRECORDED) {
 			if (!create)
@@ -238,13 +245,11 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 #endif				/* _JFS_4K */
 			rc = extRecord(ip, &xad);
 			if (rc)
-				goto unlock;
-			set_buffer_new(bh_result);
+				goto err;
+			iomap->flags |= IOMAP_F_NEW;
 		}
 
-		map_bh(bh_result, ip->i_sb, xaddr);
-		bh_result->b_size = xlen << ip->i_blkbits;
-		goto unlock;
+		goto map;
 	}
 	if (!create)
 		goto unlock;
@@ -254,14 +259,14 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 	 */
 #ifdef _JFS_4K
 	if ((rc = extHint(ip, lblock64 << ip->i_sb->s_blocksize_bits, &xad)))
-		goto unlock;
+		goto err;
 	rc = extAlloc(ip, xlen, lblock64, &xad, false);
 	if (rc)
-		goto unlock;
+		goto err;
 
-	set_buffer_new(bh_result);
-	map_bh(bh_result, ip->i_sb, addressXAD(&xad));
-	bh_result->b_size = lengthXAD(&xad) << ip->i_blkbits;
+	xaddr = addressXAD(&xad);
+	xlen = lengthXAD(&xad);
+	iomap->flags |= IOMAP_F_NEW;
 
 #else				/* _JFS_4K */
 	/*
@@ -271,7 +276,14 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 	BUG();
 #endif				/* _JFS_4K */
 
-      unlock:
+map:
+	iomap->addr = xaddr << ip->i_blkbits;
+	iomap->bdev = ip->i_sb->s_bdev;
+	iomap->type = IOMAP_MAPPED;
+unlock:
+	iomap->offset = lblock64 << ip->i_blkbits;
+	iomap->length = xlen << ip->i_blkbits;
+err:
 	/*
 	 * Release lock on inode
 	 */
@@ -282,6 +294,27 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 	return rc;
 }
 
+int jfs_get_block(struct inode *ip, sector_t lblock,
+		  struct buffer_head *bh_result, int create)
+{
+	struct iomap iomap = { };
+	int ret;
+
+	ret = jfs_iomap_begin(ip, lblock << ip->i_blkbits, bh_result->b_size,
+			create ? IOMAP_WRITE : 0, &iomap, NULL);
+	if (ret)
+		return ret;
+
+	bh_result->b_size = iomap.length;
+	if (iomap.type == IOMAP_HOLE)
+		return 0;
+
+	map_bh(bh_result, ip->i_sb, iomap.addr >> ip->i_blkbits);
+	if (iomap.flags & IOMAP_F_NEW)
+		set_buffer_new(bh_result);
+	return 0;
+}
+
 static int jfs_writepage(struct page *page, struct writeback_control *wbc)
 {
 	return block_write_full_page(page, jfs_get_block, wbc);
-- 
2.34.1

