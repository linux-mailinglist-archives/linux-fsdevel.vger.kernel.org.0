Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0524B741558
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjF1PdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjF1Pcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD0F2979;
        Wed, 28 Jun 2023 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oWSLZv12x05QP3p0AQrKmp5Y2EJAD7LcPxF5Vt7GEF8=; b=T/z/rrYf+BURpRoG7MkvJpXTNw
        qCXpZvDJyOfAR2Nf1tINAnHvbLul+bCw6b4JUiwc6s0a03Fzxq4efg7bDGARWtv/70jHjEsAbpSLJ
        VMzbDly3irlt8UyLdf8Z1i/zN+Ind3ps5cr1yIL+WKJ4mh+iQzjzpKDM0RrodNxIjaEM9pTZBZThr
        GQFLsE7pwAh2pwKD9PNWj/A2In/++yWbZ3+6e/rXGQgYrFfEtn13PeZ3LJcHCVkeJNSRA/rzCkQWR
        9l72JCxQ9cIJZprvAHNis0HbXzw9SfI1B0LYnJJx5B0yShS9Wi4BAV/nJMSge6hWgbiHo+StLFtZb
        IL+wgRJw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9r-00G0Bt-1B;
        Wed, 28 Jun 2023 15:32:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/23] btrfs: further simplify the compress or not logic in compress_file_range
Date:   Wed, 28 Jun 2023 17:31:37 +0200
Message-Id: <20230628153144.22834-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the logic whether to compress or not in compress_file_range is
a bit convoluted because it tries to share code for creating inline
extents for the compressible [1] path and the bail to uncompressed path.

But the latter isn't needed at all, because cow_file_range as called by
submit_uncompressed_range will already create inline extents as needed,
so there is no need to have special handling for it if we can live with
the fact that it will be called a bit later in the ->ordered_func of the
workqueue instead of right now.

[1] there is undocumented logic that creates an uncompressed inline
extent outside of the shall not compress logic if total_in is too small.
This logic isn't explained in comments or any commit log I could find,
so I've preserved it.  Documentation explaining it would be appreciated
if anyone understands this code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 51 ++++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e7c05d07ff50f8..560682a5d9d7aa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -847,7 +847,6 @@ static void compress_file_range(struct btrfs_work *work)
 	unsigned long total_in = 0;
 	unsigned int poff;
 	int i;
-	int will_compress;
 	int compress_type = fs_info->compress_type;
 	int redirty = 0;
 
@@ -867,7 +866,6 @@ static void compress_file_range(struct btrfs_work *work)
 	barrier();
 	actual_end = min_t(u64, i_size, end + 1);
 again:
-	will_compress = 0;
 	pages = NULL;
 	nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
 	nr_pages = min_t(unsigned long, nr_pages, BTRFS_MAX_COMPRESSED_PAGES);
@@ -917,14 +915,12 @@ static void compress_file_range(struct btrfs_work *work)
 	 * discover bad compression ratios.
 	 */
 	if (!inode_need_compress(inode, start, end))
-		goto cont;
+		goto cleanup_and_bail_uncompressed;
 
 	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
-	if (!pages) {
+	if (!pages)
 		/* just bail out to the uncompressed code */
-		nr_pages = 0;
-		goto cont;
-	}
+		goto cleanup_and_bail_uncompressed;
 
 	if (inode->defrag_compress)
 		compress_type = inode->defrag_compress;
@@ -953,7 +949,7 @@ static void compress_file_range(struct btrfs_work *work)
 				   mapping, start, pages, &nr_pages, &total_in,
 				   &total_compressed);
 	if (ret)
-		goto cont;
+		goto cleanup_and_bail_uncompressed;
 
 	/*
 	 * Zero the tail end of the last page, as we might be sending it down
@@ -962,24 +958,22 @@ static void compress_file_range(struct btrfs_work *work)
 	poff = offset_in_page(total_compressed);
 	if (poff)
 		memzero_page(pages[nr_pages - 1], poff, PAGE_SIZE - poff);
-	will_compress = 1;
 
-cont:
 	/*
+	 * Try to create an inline extent.
+	 *
+	 * If we didn't compress the entire range, try to create an uncompressed
+	 * inline extent, else a compressed one.
+	 *
 	 * Check cow_file_range() for why we don't even try to create inline
 	 * extent for the subpage case.
 	 */
 	if (start == 0 && fs_info->sectorsize == PAGE_SIZE) {
-		/* lets try to make an inline extent */
-		if (ret || total_in < actual_end) {
-			/* we didn't compress the entire range, try
-			 * to make an uncompressed inline extent.
-			 */
-			ret = cow_file_range_inline(inode, actual_end,
-						    0, BTRFS_COMPRESS_NONE,
-						    NULL, false);
+		if (total_in < actual_end) {
+			ret = cow_file_range_inline(inode, actual_end, 0,
+						    BTRFS_COMPRESS_NONE, NULL,
+						    false);
 		} else {
-			/* try making a compressed inline extent */
 			ret = cow_file_range_inline(inode, actual_end,
 						    total_compressed,
 						    compress_type, pages,
@@ -1009,26 +1003,15 @@ static void compress_file_range(struct btrfs_work *work)
 						     PAGE_UNLOCK |
 						     PAGE_START_WRITEBACK |
 						     PAGE_END_WRITEBACK);
-
-			/*
-			 * Ensure we only free the compressed pages if we have
-			 * them allocated, as we can still reach here with
-			 * inode_need_compress() == false.
-			 */
-			if (pages) {
-				for (i = 0; i < nr_pages; i++) {
-					WARN_ON(pages[i]->mapping);
-					put_page(pages[i]);
-				}
-				kfree(pages);
+			for (i = 0; i < nr_pages; i++) {
+				WARN_ON(pages[i]->mapping);
+				put_page(pages[i]);
 			}
+			kfree(pages);
 			return;
 		}
 	}
 
-	if (!will_compress)
-		goto cleanup_and_bail_uncompressed;
-
 	/*
 	 * We aren't doing an inline extent. Round the compressed size up to a
 	 * block size boundary so the allocator does sane things.
-- 
2.39.2

