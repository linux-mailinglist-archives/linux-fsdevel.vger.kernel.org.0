Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5C27A58C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjISEwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjISEvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C8138;
        Mon, 18 Sep 2023 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ls5QcLT4iw9HwtdteFtFIYm/lsPpx02xEwWSdEB7w9A=; b=v/s0YAYridL5AWm2wYWPZkGzsB
        K9clHYJMlcJOaX+NmKb7HW9F2eDrR9hnEfFhe6YOq/YMCptTWYV3mUL+G2wUZGCpLuLp0qpTeuzgI
        tfpqOXserkhg/kyyX467Dysruzd3eSm3vC0glEAeMMY65rYuin/KFRuS0Lsm8EzJZCmpYoky31QWW
        yeFE0mR+6iFAOMdA38W8yDlIG1gMZUZEaZpturMo+/2erCJzbJ4Un6ZNsjv4H8NyPK4ef/kgPaHCh
        mbJX2zDqicJe9xcLmKePQpOVdc2efB17nrycatRVsH+bWRoVmcgvJ+9lCUkxoi7Ky4qPa1vl5H4DH
        AFTza2Gg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi4-00FFlu-M6; Tue, 19 Sep 2023 04:51:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 19/26] ntfs3: Convert ntfs_zero_range() to use a folio
Date:   Tue, 19 Sep 2023 05:51:28 +0100
Message-Id: <20230919045135.3635437-20-willy@infradead.org>
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

Use the folio API throughout, saving six hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/file.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 962f12ce6c0a..a003a69091a2 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -187,7 +187,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 	struct buffer_head *head, *bh;
 	u32 bh_next, bh_off, to;
 	sector_t iblock;
-	struct page *page;
+	struct folio *folio;
 
 	for (; idx < idx_end; idx += 1, from = 0) {
 		page_off = (loff_t)idx << PAGE_SHIFT;
@@ -195,16 +195,17 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 						       PAGE_SIZE;
 		iblock = page_off >> inode->i_blkbits;
 
-		page = find_or_create_page(mapping, idx,
-					   mapping_gfp_constraint(mapping,
-								  ~__GFP_FS));
-		if (!page)
-			return -ENOMEM;
+		folio = __filemap_get_folio(mapping, idx,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				mapping_gfp_constraint(mapping, ~__GFP_FS));
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		if (!page_has_buffers(page))
-			create_empty_buffers(page, blocksize, 0);
+		head = folio_buffers(folio);
+		if (!head)
+			head = folio_create_empty_buffers(folio, blocksize, 0);
 
-		bh = head = page_buffers(page);
+		bh = head;
 		bh_off = 0;
 		do {
 			bh_next = bh_off + blocksize;
@@ -220,14 +221,14 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 			}
 
 			/* Ok, it's mapped. Make sure it's up-to-date. */
-			if (PageUptodate(page))
+			if (folio_test_uptodate(folio))
 				set_buffer_uptodate(bh);
 
 			if (!buffer_uptodate(bh)) {
 				err = bh_read(bh, 0);
 				if (err < 0) {
-					unlock_page(page);
-					put_page(page);
+					folio_unlock(folio);
+					folio_put(folio);
 					goto out;
 				}
 			}
@@ -237,10 +238,10 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 		} while (bh_off = bh_next, iblock += 1,
 			 head != (bh = bh->b_this_page));
 
-		zero_user_segment(page, from, to);
+		folio_zero_segment(folio, from, to);
 
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		cond_resched();
 	}
 out:
-- 
2.40.1

