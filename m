Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7BF1E7357
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391814AbgE2DDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391648AbgE2C6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF031C08C5C8;
        Thu, 28 May 2020 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=szc1w0bR49MUADtu9J/T+C7YUFT1QaCORo7QYzrGYc8=; b=tEx655VsZUZJb4RjDWdLlz/kYN
        KjLgesfGpUB19OLPv0n8cSoN+ad8FZRgkH2OWWnBMH8Ak0SoGJ+0i4XZnGWO1sG3gSQ0wdAKiXyZc
        LzgAbRYyU0fZjT8skMoaSDFeKCb13LBvccB51x6IK5lHfjFQG4qgFYRx41+ojxo6T0oyx2JOrm2J/
        GUkEHAzSDdM6imCusLU/FisKpIb7KBOnbO3TXz5j3pR8ewpSLyEaayG4zJCJiVzbAbJY3feoTWwFa
        RIyp7UKvEgDA04CSEt214aTso8eMchHyEUDzo/7VG+dOAaPIQ3NqUp1mKbTtsXIUz+oUq/wqI/TKG
        V01/pxxw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008RM-5p; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/39] iomap: Support large pages in read paths
Date:   Thu, 28 May 2020 19:58:01 -0700
Message-Id: <20200529025824.32296-17-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use thp_size() instead of PAGE_SIZE, offset_in_thp() instead of
offset_in_page() and bio_for_each_thp_segment_all().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 23eaaf1de906..bd70b7c1efd0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -198,7 +198,7 @@ iomap_read_end_io(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
-	bio_for_each_segment_all(bvec, bio, iter_all)
+	bio_for_each_thp_segment_all(bvec, bio, iter_all)
 		iomap_read_page_end_io(bvec, error);
 	bio_put(bio);
 }
@@ -238,6 +238,16 @@ static inline bool iomap_block_needs_zeroing(struct inode *inode,
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
@@ -294,7 +304,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
-		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		int nr_vecs = iomap_nr_vecs(page, length);
 
 		if (ctx->bio)
 			submit_bio(ctx->bio);
@@ -338,9 +348,9 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 
 	trace_iomap_readpage(page->mapping->host, 1);
 
-	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
+	for (poff = 0; poff < thp_size(page); poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
-				PAGE_SIZE - poff, 0, ops, &ctx,
+				thp_size(page) - poff, 0, ops, &ctx,
 				iomap_readpage_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
@@ -374,7 +384,8 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
 	loff_t done, ret;
 
 	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
+		if (ctx->cur_page &&
+		    offset_in_thp(ctx->cur_page, pos + done) == 0) {
 			if (!ctx->cur_page_in_bio)
 				unlock_page(ctx->cur_page);
 			put_page(ctx->cur_page);
-- 
2.26.2

