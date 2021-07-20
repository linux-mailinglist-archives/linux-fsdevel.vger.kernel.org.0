Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA13CF653
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 10:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhGTILc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 04:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhGTIDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:03:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CCAC061762;
        Tue, 20 Jul 2021 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hDxhkvl1GckRp/8tfsdTt+oLETLQj3SGmuyOppemisU=; b=E6h+j2IZrkz9vX8wE5cJUT8w04
        9KtLcZOxgDU94wJyotd/+LL5TwYUkVYvbHqemHTQ5viqk0NARaAtKk6e6fb1m2rU4Bk/McE30JN4Q
        mg8ObHnq//pWwN31Jnrltp/ajHtgB8SBe3HysdkX9dXUjOM1/y6aP+QraZg8RWqhyxAJfb4oVwLa4
        ymjZWtjE5aDcJrj/qMbtku7Yr4m2UvM6Ay9TSq5EpO3j+SaQkAQ7mf1UPoDjFbUJVuLjynsXz5LCR
        LUoZ/0hcsoBamxirxbZU+XROMOHrr+V3pQaWTE32cDxeRwqDcXhdg6X42vctbW6RlVRLuPtKBT8CC
        FW7ztdHA==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5lLW-007vLn-SG; Tue, 20 Jul 2021 08:43:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, willy@infradead.org
Subject: [PATCH 1/2] iomap: simplify iomap_readpage_actor
Date:   Tue, 20 Jul 2021 10:43:19 +0200
Message-Id: <20210720084320.184877-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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
---
 fs/iomap/buffered-io.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438becd9..4eaadbd265fcfa 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -241,7 +241,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
 	struct iomap_page *iop;
-	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
 	unsigned poff, plen;
 	sector_t sector;
@@ -268,16 +267,10 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
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
+	    bio_full(ctx->bio, plen) ||
+	    bio_end_sector(ctx->bio) != sector) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
-- 
2.30.2

