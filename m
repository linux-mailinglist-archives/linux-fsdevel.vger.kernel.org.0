Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D909D72D169
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbjFLVFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbjFLVEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D61510C9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y3oTUBr8nUbuZPwhJLsYAQkdoLOLLxnDGymoFp7BQW8=; b=X8dun2nKFjxWLL2wyZG6PKYjOy
        7oRuiHDN09PIGW8XhOtq+2JegWniSG1JEFa52Ha4SBTBnOMfUhhKNcEdr6PZm87muuv/zrcpzB9DD
        wBuc2kqJhtPk7wep9btVGHoYUSKwbdWP6g1vqjiGqiuPxb88W+HWp8m2HfiAfjTiT5L/7xXLIo/F3
        dsIJu1Gzjxd7mSaAeHEmIfvrkFnFeATGAwgnlUBS2pnA6bn5H2m1pfjiaQCABo1I9gSmDjuxv97Gf
        dbJ8lYf0cQNjOhH4/4+7JYCiQuRfw2fWGq+ZOQIjUcqzvirx6p5jzvSv7bMe/+dZjPNtr9smdaEVr
        Yk2HzYKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ofX-0033x8-QY; Mon, 12 Jun 2023 21:01:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 10/14] buffer: Convert grow_dev_page() to use a folio
Date:   Mon, 12 Jun 2023 22:01:37 +0100
Message-Id: <20230612210141.730128-11-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230612210141.730128-1-willy@infradead.org>
References: <20230612210141.730128-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get a folio from the page cache instead of a page, then use the
folio API throughout.  Removes a few calls to compound_head()
and may be needed to support block size > PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e4bd465ecee8..06d031e28bee 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -976,7 +976,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	      pgoff_t index, int size, int sizebits, gfp_t gfp)
 {
 	struct inode *inode = bdev->bd_inode;
-	struct page *page;
+	struct folio *folio;
 	struct buffer_head *bh;
 	sector_t end_block;
 	int ret = 0;
@@ -992,42 +992,38 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	 */
 	gfp_mask |= __GFP_NOFAIL;
 
-	page = find_or_create_page(inode->i_mapping, index, gfp_mask);
-
-	BUG_ON(!PageLocked(page));
+	folio = __filemap_get_folio(inode->i_mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp_mask);
 
-	if (page_has_buffers(page)) {
-		bh = page_buffers(page);
+	bh = folio_buffers(folio);
+	if (bh) {
 		if (bh->b_size == size) {
-			end_block = init_page_buffers(page, bdev,
+			end_block = init_page_buffers(&folio->page, bdev,
 						(sector_t)index << sizebits,
 						size);
 			goto done;
 		}
-		if (!try_to_free_buffers(page_folio(page)))
+		if (!try_to_free_buffers(folio))
 			goto failed;
 	}
 
-	/*
-	 * Allocate some buffers for this page
-	 */
-	bh = alloc_page_buffers(page, size, true);
+	bh = folio_alloc_buffers(folio, size, true);
 
 	/*
-	 * Link the page to the buffers and initialise them.  Take the
+	 * Link the folio to the buffers and initialise them.  Take the
 	 * lock to be atomic wrt __find_get_block(), which does not
-	 * run under the page lock.
+	 * run under the folio lock.
 	 */
 	spin_lock(&inode->i_mapping->private_lock);
-	link_dev_buffers(page, bh);
-	end_block = init_page_buffers(page, bdev, (sector_t)index << sizebits,
-			size);
+	link_dev_buffers(&folio->page, bh);
+	end_block = init_page_buffers(&folio->page, bdev,
+			(sector_t)index << sizebits, size);
 	spin_unlock(&inode->i_mapping->private_lock);
 done:
 	ret = (block < end_block) ? 1 : -ENXIO;
 failed:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return ret;
 }
 
-- 
2.39.2

