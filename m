Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151BA51F19A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiEHUhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiEHUgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03F811C32
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Wp4qyvul8OWeh743288KfYhL0nittkyAWFb25kqyK+A=; b=eKVivQ+2VFBqw/5cWrsolKyw/B
        9s83iNt3fxZ94a9+zQo3FaNNtH3LhHApjkJ13f+rmB8EXtlXdRptINvkKRCIyjzpmSSYDq4iR0FYT
        ZKN9ewFwjxntXyi1camKWIkVSR4pG+akrRBRtwBEBd3py5qIM0I285zIGHWLwI0IZvuUGZV3FsyU4
        vLyGhxSIymHCVqX0K/uBBsMzZMdJtd/YUGdKxATYDN8F6koO3F31tnUlT1OEZ2yag06ArBWR5I198
        /51pLlSjLNSK6SvriYv5+fTPeXfd5127hLQiqBt4fH1hQqeax0jqIQUOQrAPbplAta0Mv25Ajii8E
        vtcZfv8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaF-002o2W-7o; Sun, 08 May 2022 20:32:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 19/26] reiserfs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:40 +0100
Message-Id: <20220508203247.668791-20-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
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

Use folios throughout the release_folio path.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 33a9555f77b9..9cf2e1420a74 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3202,39 +3202,39 @@ static bool reiserfs_dirty_folio(struct address_space *mapping,
 }
 
 /*
- * Returns 1 if the page's buffers were dropped.  The page is locked.
+ * Returns true if the folio's buffers were dropped.  The folio is locked.
  *
  * Takes j_dirty_buffers_lock to protect the b_assoc_buffers list_heads
- * in the buffers at page_buffers(page).
+ * in the buffers at folio_buffers(folio).
  *
  * even in -o notail mode, we can't be sure an old mount without -o notail
  * didn't create files with tails.
  */
-static int reiserfs_releasepage(struct page *page, gfp_t unused_gfp_flags)
+static bool reiserfs_release_folio(struct folio *folio, gfp_t unused_gfp_flags)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb);
 	struct buffer_head *head;
 	struct buffer_head *bh;
-	int ret = 1;
+	bool ret = true;
 
-	WARN_ON(PageChecked(page));
+	WARN_ON(folio_test_checked(folio));
 	spin_lock(&j->j_dirty_buffers_lock);
-	head = page_buffers(page);
+	head = folio_buffers(folio);
 	bh = head;
 	do {
 		if (bh->b_private) {
 			if (!buffer_dirty(bh) && !buffer_locked(bh)) {
 				reiserfs_free_jh(bh);
 			} else {
-				ret = 0;
+				ret = false;
 				break;
 			}
 		}
 		bh = bh->b_this_page;
 	} while (bh != head);
 	if (ret)
-		ret = try_to_free_buffers(page);
+		ret = try_to_free_buffers(&folio->page);
 	spin_unlock(&j->j_dirty_buffers_lock);
 	return ret;
 }
@@ -3423,7 +3423,7 @@ const struct address_space_operations reiserfs_address_space_operations = {
 	.writepage = reiserfs_writepage,
 	.read_folio = reiserfs_read_folio,
 	.readahead = reiserfs_readahead,
-	.releasepage = reiserfs_releasepage,
+	.release_folio = reiserfs_release_folio,
 	.invalidate_folio = reiserfs_invalidate_folio,
 	.write_begin = reiserfs_write_begin,
 	.write_end = reiserfs_write_end,
-- 
2.34.1

