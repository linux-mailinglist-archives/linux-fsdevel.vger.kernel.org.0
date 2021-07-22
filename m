Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9F3D1DBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 07:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhGVFFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 01:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhGVFFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:05:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F9EC061575;
        Wed, 21 Jul 2021 22:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4dVFqjHgK8444UeqJbU/jDJ2IIwH8Uq8oXpe7UAENeg=; b=Q7FDqutbg9ryBeMpOv4YNtTm1+
        jFk59hngQlLI9XiZH1lDUI/Jb/wnimWS24n724okdTPuPv9rfeMPyIY+QY3tReSH76sAjZN7iLhBY
        i23Tq53fs5WozTvZysdefGiEkVWCaioRXsldB1GRxiNs5haXJMSzxAQCHE2sBvWtjc9HWb9D3gZnr
        8dr/WFmdAZQwpgc5svys/ItPyDButxf79unySqCymwoX5QCWZ1k3c+AUeYfkh1M8mJkFio0vwtENF
        nsyHTzG1oEgorfvsx4TfITh5mZyQAIBjuFyJyRm2IO3lZPw7yc4CAiEVCVLaQNIhQRtS8jsF6m+ay
        gLRzQ4MQ==;
Received: from [2001:4bb8:193:7660:643c:9899:473:314a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6RV2-009vQe-1L; Thu, 22 Jul 2021 05:44:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/2] iomap: simplify iomap_readpage_actor
Date:   Thu, 22 Jul 2021 07:42:55 +0200
Message-Id: <20210722054256.932965-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722054256.932965-1-hch@lst.de>
References: <20210722054256.932965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the outstanding reads are counted in bytes, there is no need
to use the low-level __bio_try_merge_page API, we can switch back to
always using bio_add_page and simply iomap_readpage_actor again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0597f5c186a33f..7898c1c47370e6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -245,7 +245,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
 	struct iomap_page *iop;
-	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
 	unsigned poff, plen;
 	sector_t sector;
@@ -269,16 +268,10 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	if (iop)
 		atomic_add(plen, &iop->read_bytes_pending);
 
-	/* Try to merge into a previous segment if we can */
 	sector = iomap_sector(iomap, pos);
-	if (ctx->bio && bio_end_sector(ctx->bio) == sector) {
-		if (__bio_try_merge_page(ctx->bio, page, plen, poff,
-				&same_page))
-			goto done;
-		is_contig = true;
-	}
-
-	if (!is_contig || bio_full(ctx->bio, plen)) {
+	if (!ctx->bio ||
+	    bio_end_sector(ctx->bio) != sector ||
+	    bio_add_page(ctx->bio, page, plen, poff) != plen) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
@@ -302,9 +295,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		ctx->bio->bi_iter.bi_sector = sector;
 		bio_set_dev(ctx->bio, iomap->bdev);
 		ctx->bio->bi_end_io = iomap_read_end_io;
+		__bio_add_page(ctx->bio, page, plen, poff);
 	}
-
-	bio_add_page(ctx->bio, page, plen, poff);
 done:
 	/*
 	 * Move the caller beyond our range so that it keeps making progress.
-- 
2.30.2

