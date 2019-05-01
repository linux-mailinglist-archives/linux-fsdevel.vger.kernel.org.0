Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF710ACA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfEAQLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 12:11:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfEAQLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 12:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C1JFCpcZ5l1nzCsgLfhWfKHo8a7m+wqGevCNCESRWiM=; b=MAOqUMQ6iCrux1T2lnLWrrMA0
        pzGBGE98fkJDy0cZui0RUSuQQrFLCDmP+RTSvz4D2gWrt6vD5GD6i5leWy7SegcCM3smGGeN8vMVZ
        bAch2fJnrOwiVY77u2hxXkBrYSfpTKLF1v5RDs1WUhwfnPNbe40Sjb6pDAgFidvYIYr+qMfS8jLZJ
        IYQa0tJdTngD/fY7zYIeivJ/przbOG7LHNaTd0XFyJ3B/44zx4H10vnl/k0nofGAThY19VCzgSWfw
        bZKuMR22AqbSsZgWrVkRSkJnD1/swNenF/2dt4xb7ZCSfwRwKrTIAxg//KHGclVtKxeICFNj8vySn
        /tLbf1d7g==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrpl-0003lM-C7; Wed, 01 May 2019 16:11:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     darrick.wong@oracle.com
Cc:     agruenba@redhat.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: move iomap_read_inline_data around
Date:   Wed,  1 May 2019 12:11:11 -0400
Message-Id: <20190501161111.32475-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_read_inline_data ended up being placed in the middle of the bio
based read I/O completion handling, which tends to confuse the heck out
of me whenever I follow the code.  Move it to a more suitable place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index fbfe20b7f6f0..9ef049d61e8a 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -240,26 +240,6 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
 	iomap_read_finish(iop, page);
 }
 
-static void
-iomap_read_inline_data(struct inode *inode, struct page *page,
-		struct iomap *iomap)
-{
-	size_t size = i_size_read(inode);
-	void *addr;
-
-	if (PageUptodate(page))
-		return;
-
-	BUG_ON(page->index);
-	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
-
-	addr = kmap_atomic(page);
-	memcpy(addr, iomap->inline_data, size);
-	memset(addr + size, 0, PAGE_SIZE - size);
-	kunmap_atomic(addr);
-	SetPageUptodate(page);
-}
-
 static void
 iomap_read_end_io(struct bio *bio)
 {
@@ -281,6 +261,26 @@ struct iomap_readpage_ctx {
 	struct list_head	*pages;
 };
 
+static void
+iomap_read_inline_data(struct inode *inode, struct page *page,
+		struct iomap *iomap)
+{
+	size_t size = i_size_read(inode);
+	void *addr;
+
+	if (PageUptodate(page))
+		return;
+
+	BUG_ON(page->index);
+	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
+
+	addr = kmap_atomic(page);
+	memcpy(addr, iomap->inline_data, size);
+	memset(addr + size, 0, PAGE_SIZE - size);
+	kunmap_atomic(addr);
+	SetPageUptodate(page);
+}
+
 static loff_t
 iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap)
-- 
2.20.1

