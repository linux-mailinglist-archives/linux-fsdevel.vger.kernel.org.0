Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E995CF353
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfJHHPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:15:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfJHHPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qTtPzuP/nMnPlbbAVknM4QSuUEmzC+64swvwgvz7gSA=; b=K/Hy09NKZ5HiFN6yaF9fM9JdAa
        26AaMT+hsAUZ4t63FVR9FWpKwlC1kcUR8CZIW2tWlvRjudRvlR9woIybejnrECv21+52ilc1dezIY
        M0ZZ4t1e8xfUInM6f+GHjkKXsju0nHRPEMI0VpBZtZFdk8hzEXVNdYjSdmo9I3NlCU26P9Qc6uDNH
        KCzSI3ZUtkRBqyvn3QGrsr4Rz9OKnhX0ws/fB0gGwWZlxmyGU8fVkoWPDGQ0JXRASPlaN3kzh65FV
        K2lW4WSfUBPFNjQcJ6Mz6dOc28X3RpdjPyMbj1yWNCrVvgyKDz0t7bJR7CGcHWnSB6cG8uuxTg3gb
        SIO21rig==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjii-0005rN-8o; Tue, 08 Oct 2019 07:15:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 05/20] iomap: move the zeroing case out of iomap_read_page_sync
Date:   Tue,  8 Oct 2019 09:15:12 +0200
Message-Id: <20191008071527.29304-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008071527.29304-1-hch@lst.de>
References: <20191008071527.29304-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 59751835f172..d5abd8e5dca7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -562,19 +562,12 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
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
@@ -592,7 +585,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
 	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
-	int status = 0;
+	int status;
 
 	if (PageUptodate(page))
 		return 0;
@@ -603,17 +596,23 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
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

