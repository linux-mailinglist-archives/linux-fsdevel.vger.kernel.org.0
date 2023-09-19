Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7F7A58DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjISEwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjISEvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1577611A;
        Mon, 18 Sep 2023 21:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mUIK9nBwhAI9Ryy/+0vVqkN8LwxEIln+yTemaK9zJBo=; b=guUpDLzG8BlfE6Tit98RP1DNJN
        2xpezrbA4qawVoCg32DiMzru0nETB8nlQsYcPHxd06GVGgkXsPn8bW2jhgacbhaCXKjXs44p+5OMS
        lADgbnPbkK/TFHG9timsYL9oMFJQwLqNU1E1aLYhncIE83OmsIX+OdljfOxFpJItsWxbWeCp7jRQA
        ncHE9NSRASSjbEl6PUk7N1TLV17gzcAUHRPH4Rmw/C+jUBS5GPUkm8MedchaZucpSKqQQ8XrF3aOZ
        M2bHEuZYfIl/3Bo5OxYX+1v+5yF5lXXTN95tAsAfemC1RL5FCQs3HStRTH1FEcWXVirR2f+L+UybJ
        LV/2XX4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi5-00FFmW-B1; Tue, 19 Sep 2023 04:51:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 24/26] ufs; Convert ufs_change_blocknr() to use folios
Date:   Tue, 19 Sep 2023 05:51:33 +0100
Message-Id: <20230919045135.3635437-25-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230919045135.3635437-1-willy@infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the locked_page argument to a folio, then use folios throughout.
Saves three hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/balloc.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 2436e3f82147..53c11be2b2c1 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -240,6 +240,7 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 			       unsigned int count, sector_t oldb,
 			       sector_t newb, struct page *locked_page)
 {
+	struct folio *folio, *locked_folio = page_folio(locked_page);
 	const unsigned blks_per_page =
 		1 << (PAGE_SHIFT - inode->i_blkbits);
 	const unsigned mask = blks_per_page - 1;
@@ -247,42 +248,39 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 	pgoff_t index, cur_index, last_index;
 	unsigned pos, j, lblock;
 	sector_t end, i;
-	struct page *page;
 	struct buffer_head *head, *bh;
 
 	UFSD("ENTER, ino %lu, count %u, oldb %llu, newb %llu\n",
 	      inode->i_ino, count,
 	     (unsigned long long)oldb, (unsigned long long)newb);
 
-	BUG_ON(!locked_page);
-	BUG_ON(!PageLocked(locked_page));
+	BUG_ON(!folio_test_locked(locked_folio));
 
-	cur_index = locked_page->index;
+	cur_index = locked_folio->index;
 	end = count + beg;
 	last_index = end >> (PAGE_SHIFT - inode->i_blkbits);
 	for (i = beg; i < end; i = (i | mask) + 1) {
 		index = i >> (PAGE_SHIFT - inode->i_blkbits);
 
 		if (likely(cur_index != index)) {
-			page = ufs_get_locked_page(mapping, index);
-			if (!page)/* it was truncated */
+			folio = ufs_get_locked_folio(mapping, index);
+			if (!folio) /* it was truncated */
 				continue;
-			if (IS_ERR(page)) {/* or EIO */
+			if (IS_ERR(folio)) {/* or EIO */
 				ufs_error(inode->i_sb, __func__,
 					  "read of page %llu failed\n",
 					  (unsigned long long)index);
 				continue;
 			}
 		} else
-			page = locked_page;
+			folio = locked_folio;
 
-		head = page_buffers(page);
+		head = folio_buffers(folio);
 		bh = head;
 		pos = i & mask;
 		for (j = 0; j < pos; ++j)
 			bh = bh->b_this_page;
 
-
 		if (unlikely(index == last_index))
 			lblock = end & mask;
 		else
@@ -313,7 +311,7 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 		} while (bh != head);
 
 		if (likely(cur_index != index))
-			ufs_put_locked_page(page);
+			ufs_put_locked_folio(folio);
  	}
 	UFSD("EXIT\n");
 }
-- 
2.40.1

