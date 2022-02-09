Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8C04AFE55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiBIUXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA290E040DC5
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EaMSg+nuqe3EvOXpkJZI00cuVVsVnTlon718LD+DS7Q=; b=OD/f55XvZZQasQZNQ2g1SDv5Rk
        rvnBTpALjyMvUQWLaFaRkGI4865NrPzrd4jBFJUf2xHBpMo0cYfeXbdf5/t1+TnR2QvOVpo2dgYqJ
        uewtSuculwP/cNhNObhXDv1AX3t0gvoBKTFcgipdKPcXsUeg7jNW2oyXb9yqD1p8OnKE9UTtkkbaT
        Yu9HnkcUSDjABEvPbw7dr8aVWbzkd5cTa/YA5NUW+Q+5Tk3KB5K375AS61dM0cA4ppP/w/epY1BFA
        aJ1fqJneGDpi3HOAfLCSKucPr4lMN65OoZjxZsEPl+eOWDFKxDef3JHjpU2WZVUUaNIIKv4iv2SZv
        LQmcuUww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTv-008cs7-A7; Wed, 09 Feb 2022 20:22:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 37/56] fuse: Convert from launder_page to launder_folio
Date:   Wed,  9 Feb 2022 20:21:56 +0000
Message-Id: <20220209202215.2055748-38-willy@infradead.org>
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

Straightforward conversion although the helper functions still assume
a single page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/dir.c  |  2 +-
 fs/fuse/file.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 656e921f3506..9ff27b8a9782 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1773,7 +1773,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 
 	/*
 	 * Only call invalidate_inode_pages2() after removing
-	 * FUSE_NOWRITE, otherwise fuse_launder_page() would deadlock.
+	 * FUSE_NOWRITE, otherwise fuse_launder_folio() would deadlock.
 	 */
 	if ((is_truncate || !is_wb) &&
 	    S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..aed0d5dcd022 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2330,17 +2330,17 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
 	return copied;
 }
 
-static int fuse_launder_page(struct page *page)
+static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
-	if (clear_page_dirty_for_io(page)) {
-		struct inode *inode = page->mapping->host;
+	if (folio_clear_dirty_for_io(folio)) {
+		struct inode *inode = folio->mapping->host;
 
 		/* Serialize with pending writeback for the same page */
-		fuse_wait_on_page_writeback(inode, page->index);
-		err = fuse_writepage_locked(page);
+		fuse_wait_on_page_writeback(inode, folio->index);
+		err = fuse_writepage_locked(&folio->page);
 		if (!err)
-			fuse_wait_on_page_writeback(inode, page->index);
+			fuse_wait_on_page_writeback(inode, folio->index);
 	}
 	return err;
 }
@@ -3161,7 +3161,7 @@ static const struct address_space_operations fuse_file_aops  = {
 	.readahead	= fuse_readahead,
 	.writepage	= fuse_writepage,
 	.writepages	= fuse_writepages,
-	.launder_page	= fuse_launder_page,
+	.launder_folio	= fuse_launder_folio,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-- 
2.34.1

