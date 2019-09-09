Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF1ADED9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfIIS1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:27:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS1k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6AyJ8f2rUAmIaLPimaFbnFcSM99Smo3Uy/Yc2jOKlDM=; b=lMeXTbWH2xhHmTGk3JzoaIHxH
        6VZvE1VE7uu9/fr8taDWYVtRrlzFFqydsMHOeCNcTxTtnfn9fkZhD/pXATvp1FfIBRxYAxEly6uKU
        NNckLnFhup78kQ1phLWvI61EmUVo8FfvVmkx+CbSJA5+jneRK/Dvki9NKlc+eJr6TtkeQHaKzsPjw
        6pdzphEqh0G/m5oxIvPWbIILjDzX/zaFf741fOiB5rPfI59FsvEDOTbiGTcfooynEmMJk3b+fO7zd
        huuhhBLtu3i1iYQEzPS1W+FHqIZ2V/tW6vCNABBnwE7HXuzv8JBnAUyGJmblI4fvY9V0auVA2jsyR
        IE7lT9ZBg==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7OO4-0001wW-7I; Mon, 09 Sep 2019 18:27:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/19] iomap: move the zeroing case out of iomap_read_page_sync
Date:   Mon,  9 Sep 2019 20:27:08 +0200
Message-Id: <20190909182722.16783-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909182722.16783-1-hch@lst.de>
References: <20190909182722.16783-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

That keeps the function a little easier to understand, and easier to
modify for pending enhancements.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0b05551d9b5a..fe099faf540f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -547,19 +547,12 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 }
 
 static int
-iomap_read_page_sync(struct inode *inode, loff_t block_start, struct page *page,
-		unsigned poff, unsigned plen, unsigned from, unsigned to,
-		struct iomap *iomap)
+iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
+		unsigned plen, struct iomap *iomap)
 {
 	struct bio_vec bvec;
 	struct bio bio;
 
-	if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
-		zero_user_segments(page, poff, from, to, poff + plen);
-		iomap_set_range_uptodate(page, poff, plen);
-		return 0;
-	}
-
 	bio_init(&bio, &bvec, 1);
 	bio.bi_opf = REQ_OP_READ;
 	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
@@ -577,7 +570,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
 	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
-	int status = 0;
+	int status;
 
 	if (PageUptodate(page))
 		return 0;
@@ -588,17 +581,23 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
 		if (plen == 0)
 			break;
 
-		if ((from > poff && from < poff + plen) ||
-		    (to > poff && to < poff + plen)) {
-			status = iomap_read_page_sync(inode, block_start, page,
-					poff, plen, from, to, iomap);
-			if (status)
-				break;
+		if ((from <= poff || from >= poff + plen) &&
+		    (to <= poff || to >= poff + plen))
+			continue;
+
+		if (iomap_block_needs_zeroing(inode, iomap, block_start)) {
+			zero_user_segments(page, poff, from, to, poff + plen);
+			iomap_set_range_uptodate(page, poff, plen);
+			continue;
 		}
 
+		status = iomap_read_page_sync(block_start, page, poff, plen,
+				iomap);
+		if (status)
+			return status;
 	} while ((block_start += plen) < block_end);
 
-	return status;
+	return 0;
 }
 
 static int
-- 
2.20.1

