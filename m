Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C428DD73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgJNJYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgJNJUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C38C0F26EF;
        Tue, 13 Oct 2020 20:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rdRSJzenCaIYGt1c8MjAxB4wKLLuGR+cw6SImpK8bI0=; b=Nk0RamlgvFMF3mfimqDPDv38YJ
        k1gSyEeWe3JCYqS7T7athwnlLgcyd0P2Fb9Po755SB01tnrMWAFTijZxeBzd4TW/PDxKxFit+H5ID
        hqjAdiDH71a2YRdx9q965OeHOYfhzmY/Hz1sjf3qcozLR9fNew4FybrFICoJig4+8JKH8jBbolkQI
        CXmKrCX7BrT/LwIZZ6Z4UD5/8g9CeVXm7g2FChVcECTAGu5lLACZ52E+Y/nnTXSm0/dVrXDbBL1bA
        HDCcjAK9gkkfF0b6I7L2QD+TPiSVl6U1Mgm0ncYdO3NQC82J2km+nJQjis4xaFJkRykAbVlPnOtX8
        4nPVlDfw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX57-0005iw-6i; Wed, 14 Oct 2020 03:04:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 08/14] iomap: Support THPs in readahead
Date:   Wed, 14 Oct 2020 04:03:51 +0100
Message-Id: <20201014030357.21898-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201014030357.21898-1-willy@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use offset_in_thp() instead of offset_in_page() and change how we estimate
the number of bio_vecs we're going to need.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ca305fbaf811..4ef02afaedc5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -264,6 +264,16 @@ static inline bool iomap_block_needs_zeroing(struct inode *inode,
 		pos >= i_size_read(inode);
 }
 
+/*
+ * Estimate the number of vectors we need based on the current page size;
+ * if we're wrong we'll end up doing an overly large allocation or needing
+ * to do a second allocation, neither of which is a big deal.
+ */
+static unsigned int iomap_nr_vecs(struct page *page, loff_t length)
+{
+	return (length + thp_size(page) - 1) >> page_shift(page);
+}
+
 static loff_t
 iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap, struct iomap *srcmap)
@@ -309,7 +319,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	if (!is_contig || bio_full(ctx->bio, plen)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
-		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		int nr_vecs = iomap_nr_vecs(page, length);
 
 		if (ctx->bio)
 			submit_bio(ctx->bio);
@@ -424,7 +434,8 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
 	loff_t done, ret;
 
 	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
+		if (ctx->cur_page &&
+		    offset_in_thp(ctx->cur_page, pos + done) == 0) {
 			if (!ctx->cur_page_in_bio)
 				unlock_page(ctx->cur_page);
 			put_page(ctx->cur_page);
-- 
2.28.0

