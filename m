Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8B1BDF3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgD2Nlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgD2NhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7E9C09B044;
        Wed, 29 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uUwTC8qZH5aTuaqH+aLzce4GCEO3VHgfxQaRVX/zsNo=; b=W4Sr6rKEtev1u0dIamQAWKJFlY
        CaT+3/GY/csJYJXx6emoQLC/5MXUyEIJe9zcky0UJo3LPCJxhg/srJYfAJRafCSGEwIcbAcDeFQnp
        KH7QhiMm20qEbrYPkvQvCNVq93cXOQOvupTXiefjwUhsAtm1nVsl4x9PmUI5qEiWCIeNDb/rI+9i4
        P3KFPyiHo+cNqUlcje2PYvmXrmaIGjij8kKQ2JVYlJdpiqcjEwN04ftPVW7cTNboELMEweMacTyaP
        hR7XBj0bElYbanw91g8ZuVCf96Kolcd7WuSKReYCFMJksnabCQ5GU96xk6fq3Js8DXYV2oo1UbCLj
        i2Y7YFjw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005vR-GW; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/25] iomap: Support large pages in read paths
Date:   Wed, 29 Apr 2020 06:36:44 -0700
Message-Id: <20200429133657.22632-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
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
index 423ffc9d4a97..75f42c0d4cd9 100644
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

