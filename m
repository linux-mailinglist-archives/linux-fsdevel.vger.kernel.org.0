Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5B4AFE66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiBIUX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiBIUWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E09E046F09
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tabz2EPYNpIhM2JHkCH8pT0MOKvv+F909vgH+3Fvqqs=; b=FFghEMyoZ+7a2uaCLXKVvDC7Xs
        56pYZpm5vFMpGjVgB2z5i3uRjh/AY65ROmmirKCEUpinth1fN2usHlBtvsDZqeRp2/ZC59c06uKoX
        lHFhvkzSwh1p9AAFRW1eDjEuK+fMzXNoDdZFhBRYP0nuPxRm7Wwh9MTKqwLTwPuIKgU+bdaOb1nXu
        nVTmOnbYg/4WZjRLQ9ZbvgqipqY1NlLeWnVSVJGhz6Hzy6GSUfWCXXmIfBQITN1Sike3Kd7XobtXX
        MvWG/Kh3gfAOGJkCvbMR6ZnuYsuvtzKZAP9EHIZ4GdBOsw2iFN8ATFESAz/bbwpkkVWp9gElEjvA0
        yATGJdbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTx-008ctc-8m; Wed, 09 Feb 2022 20:22:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 52/56] nilfs: Convert nilfs_set_page_dirty() to nilfs_dirty_folio()
Date:   Wed,  9 Feb 2022 20:22:11 +0000
Message-Id: <20220209202215.2055748-53-willy@infradead.org>
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

The comment about the page always being locked is wrong, so copy
the locking protection from __set_page_dirty_buffers().  That
means moving the call to nilfs_set_file_dirty() down the
function so as to not acquire a new dependency between the
mapping->private_lock and the ns_inode_lock.  That might be a
harmless dependency to add, but it's not necessary.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/inode.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 153f0569dcf2..c1219c0678a5 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -199,23 +199,23 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 	return 0;
 }
 
-static int nilfs_set_page_dirty(struct page *page)
+static bool nilfs_dirty_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
-	int ret = __set_page_dirty_nobuffers(page);
+	struct inode *inode = mapping->host;
+	struct buffer_head *head;
+	unsigned int nr_dirty;
+	bool ret = filemap_dirty_folio(mapping, folio);
 
-	if (page_has_buffers(page)) {
-		unsigned int nr_dirty = 0;
-		struct buffer_head *bh, *head;
+	/*
+	 * The page may not be locked, eg if called from try_to_unmap_one()
+	 */
+	spin_lock(&mapping->private_lock);
+	head = folio_buffers(folio);
+	if (head) {
+		struct buffer_head *bh = head;
 
-		/*
-		 * This page is locked by callers, and no other thread
-		 * concurrently marks its buffers dirty since they are
-		 * only dirtied through routines in fs/buffer.c in
-		 * which call sites of mark_buffer_dirty are protected
-		 * by page lock.
-		 */
-		bh = head = page_buffers(page);
+		nr_dirty = 0;
 		do {
 			/* Do not mark hole blocks dirty */
 			if (buffer_dirty(bh) || !buffer_mapped(bh))
@@ -224,14 +224,13 @@ static int nilfs_set_page_dirty(struct page *page)
 			set_buffer_dirty(bh);
 			nr_dirty++;
 		} while (bh = bh->b_this_page, bh != head);
-
-		if (nr_dirty)
-			nilfs_set_file_dirty(inode, nr_dirty);
 	} else if (ret) {
-		unsigned int nr_dirty = 1 << (PAGE_SHIFT - inode->i_blkbits);
+		nr_dirty = 1 << (PAGE_SHIFT - inode->i_blkbits);
+	}
+	spin_unlock(&mapping->private_lock);
 
+	if (nr_dirty)
 		nilfs_set_file_dirty(inode, nr_dirty);
-	}
 	return ret;
 }
 
@@ -299,7 +298,7 @@ const struct address_space_operations nilfs_aops = {
 	.writepage		= nilfs_writepage,
 	.readpage		= nilfs_readpage,
 	.writepages		= nilfs_writepages,
-	.set_page_dirty		= nilfs_set_page_dirty,
+	.dirty_folio		= nilfs_dirty_folio,
 	.readahead		= nilfs_readahead,
 	.write_begin		= nilfs_write_begin,
 	.write_end		= nilfs_write_end,
-- 
2.34.1

