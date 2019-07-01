Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5C15C55D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfGAV41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:56:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAV41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y10BC0t6LYdDuR0Paviv8ojLBdUiEzyaXmCWCbURS8Y=; b=FQflLT91HiucrTUcF7xhTD2jsR
        PLUOd2GhauLG38djRyHMZvHWfvnEhtWqDs5JPUtNezy2ZWS64Sf4UAYjUVC8JYmewCTnyD5xkfMYf
        N0sZpSsRcpWRmwmL/9YvwrpIjIWsmi5yxqZQOVxOxOpMimEKn1lsrpk2Dkw4R/oR74Z/V60qxl90X
        A7pyDM/OgHMfLbSWRmIITXORe1vOwCrpYtKz/wgM85gNNr99evoSDrhyHGFtp4G+h8QZPED5K4ULK
        N/AacfJw4q2rRWYaN39uT32oJGrEwqLRMu3DMJRoXCpbBdHIJJ0nWetsHMpT8F/q3EV0e0O2IhXvF
        ZbWNLcCg==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4Hh-0001vN-0i; Mon, 01 Jul 2019 21:56:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 13/15] gfs2: implement gfs2_block_zero_range using iomap_zero_range
Date:   Mon,  1 Jul 2019 23:54:37 +0200
Message-Id: <20190701215439.19162-14-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701215439.19162-1-hch@lst.de>
References: <20190701215439.19162-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap handles all the nitty-gritty details of zeroing a file
range for us, so use the proper helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/bmap.c | 68 +-------------------------------------------------
 1 file changed, 1 insertion(+), 67 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 8e8768685264..b7bd811872cb 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1281,76 +1281,10 @@ int gfs2_extent_map(struct inode *inode, u64 lblock, int *new, u64 *dblock, unsi
 	return ret;
 }
 
-/**
- * gfs2_block_zero_range - Deal with zeroing out data
- *
- * This is partly borrowed from ext3.
- */
 static int gfs2_block_zero_range(struct inode *inode, loff_t from,
 				 unsigned int length)
 {
-	struct address_space *mapping = inode->i_mapping;
-	struct gfs2_inode *ip = GFS2_I(inode);
-	unsigned long index = from >> PAGE_SHIFT;
-	unsigned offset = from & (PAGE_SIZE-1);
-	unsigned blocksize, iblock, pos;
-	struct buffer_head *bh;
-	struct page *page;
-	int err;
-
-	page = find_or_create_page(mapping, index, GFP_NOFS);
-	if (!page)
-		return 0;
-
-	blocksize = inode->i_sb->s_blocksize;
-	iblock = index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
-
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, blocksize, 0);
-
-	/* Find the buffer that contains "offset" */
-	bh = page_buffers(page);
-	pos = blocksize;
-	while (offset >= pos) {
-		bh = bh->b_this_page;
-		iblock++;
-		pos += blocksize;
-	}
-
-	err = 0;
-
-	if (!buffer_mapped(bh)) {
-		gfs2_block_map(inode, iblock, bh, 0);
-		/* unmapped? It's a hole - nothing to do */
-		if (!buffer_mapped(bh))
-			goto unlock;
-	}
-
-	/* Ok, it's mapped. Make sure it's up-to-date */
-	if (PageUptodate(page))
-		set_buffer_uptodate(bh);
-
-	if (!buffer_uptodate(bh)) {
-		err = -EIO;
-		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
-		wait_on_buffer(bh);
-		/* Uhhuh. Read error. Complain and punt. */
-		if (!buffer_uptodate(bh))
-			goto unlock;
-		err = 0;
-	}
-
-	if (gfs2_is_jdata(ip))
-		gfs2_trans_add_data(ip->i_gl, bh);
-	else
-		gfs2_ordered_add_inode(ip);
-
-	zero_user(page, offset, length);
-	mark_buffer_dirty(bh);
-unlock:
-	unlock_page(page);
-	put_page(page);
-	return err;
+	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops);
 }
 
 #define GFS2_JTRUNC_REVOKES 8192
-- 
2.20.1

