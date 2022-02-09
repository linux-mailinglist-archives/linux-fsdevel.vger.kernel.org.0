Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14154AFE4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiBIUXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A183E03AE44
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1yi1dBtithx2lWpfj5efn1pgy/4YfJlEAfPlQnCxF2w=; b=dPeGyipIgnzXCUo1suMpXK9eVy
        kkYNFC/Gc3XcW+323Hubb0pHbW7015jLFe/lOn5F9OOrolCGZE5x0ha2gY0uATkKGNZUEWVO83Nic
        fUIGy4i0hklvP1LKQGkk6OIfiwORHfQJAJj8hd0D8KQbbrK0q3M7Ru/rCkxun27S/gL9fGy+UfpAh
        wVj3npbhoyTYX/BcOPa/x9nMWSDA5nhbRdDRGPek4G2wtqnz77gR7EPHIeA1H3p2QnBo4nNPuGBCs
        b3FFa6tUFJuB38kpTPjhKAgLL30Br1EZz+xrgllcjIf1xBrkOyMDfNV69CzvX8/JGMHtS8dORJx1u
        kHUL+HZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTu-008crU-DR; Wed, 09 Feb 2022 20:22:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 30/56] reiserfs: Convert from invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:49 +0000
Message-Id: <20220209202215.2055748-31-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

This is a straightforward conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c   | 26 +++++++++++++-------------
 fs/reiserfs/journal.c |  4 ++--
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index f49b72ccac4c..f7fa70b419d2 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3094,7 +3094,7 @@ void sd_attrs_to_i_attrs(__u16 sd_attrs, struct inode *inode)
  * decide if this buffer needs to stay around for data logging or ordered
  * write purposes
  */
-static int invalidatepage_can_drop(struct inode *inode, struct buffer_head *bh)
+static int invalidate_folio_can_drop(struct inode *inode, struct buffer_head *bh)
 {
 	int ret = 1;
 	struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb);
@@ -3147,26 +3147,26 @@ static int invalidatepage_can_drop(struct inode *inode, struct buffer_head *bh)
 	return ret;
 }
 
-/* clm -- taken from fs/buffer.c:block_invalidate_page */
-static void reiserfs_invalidatepage(struct page *page, unsigned int offset,
-				    unsigned int length)
+/* clm -- taken from fs/buffer.c:block_invalidate_folio */
+static void reiserfs_invalidate_folio(struct folio *folio, size_t offset,
+				    size_t length)
 {
 	struct buffer_head *head, *bh, *next;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	unsigned int curr_off = 0;
 	unsigned int stop = offset + length;
-	int partial_page = (offset || length < PAGE_SIZE);
+	int partial_page = (offset || length < folio_size(folio));
 	int ret = 1;
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 
 	if (!partial_page)
-		ClearPageChecked(page);
+		folio_clear_checked(folio);
 
-	if (!page_has_buffers(page))
+	head = folio_buffers(folio);
+	if (!head)
 		goto out;
 
-	head = page_buffers(page);
 	bh = head;
 	do {
 		unsigned int next_off = curr_off + bh->b_size;
@@ -3179,7 +3179,7 @@ static void reiserfs_invalidatepage(struct page *page, unsigned int offset,
 		 * is this block fully invalidated?
 		 */
 		if (offset <= curr_off) {
-			if (invalidatepage_can_drop(inode, bh))
+			if (invalidate_folio_can_drop(inode, bh))
 				reiserfs_unmap_buffer(bh);
 			else
 				ret = 0;
@@ -3194,7 +3194,7 @@ static void reiserfs_invalidatepage(struct page *page, unsigned int offset,
 	 * so real IO is not possible anymore.
 	 */
 	if (!partial_page && ret) {
-		ret = try_to_release_page(page, 0);
+		ret = filemap_release_folio(folio, 0);
 		/* maybe should BUG_ON(!ret); - neilb */
 	}
 out:
@@ -3430,7 +3430,7 @@ const struct address_space_operations reiserfs_address_space_operations = {
 	.readpage = reiserfs_readpage,
 	.readahead = reiserfs_readahead,
 	.releasepage = reiserfs_releasepage,
-	.invalidatepage = reiserfs_invalidatepage,
+	.invalidate_folio = reiserfs_invalidate_folio,
 	.write_begin = reiserfs_write_begin,
 	.write_end = reiserfs_write_end,
 	.bmap = reiserfs_aop_bmap,
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index a3e21160b634..b5b6f6201bed 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -858,8 +858,8 @@ static int write_ordered_buffers(spinlock_t * lock,
 			ret = -EIO;
 		}
 		/*
-		 * ugly interaction with invalidatepage here.
-		 * reiserfs_invalidate_page will pin any buffer that has a
+		 * ugly interaction with invalidate_folio here.
+		 * reiserfs_invalidate_folio will pin any buffer that has a
 		 * valid journal head from an older transaction.  If someone
 		 * else sets our buffer dirty after we write it in the first
 		 * loop, and then someone truncates the page away, nobody
-- 
2.34.1

