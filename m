Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5BC515200
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379666AbiD2Rac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379607AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41C2A66CD
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dkrajfA2mxp2aowMuf2gUwqeOPobJuO7Ne+a3M1SyHc=; b=VYfmFmk3/i6hORInXI0jd3n+Ki
        xWYtxWPwfMMYtXtiO5f6Zy+9URO/czU05GIVyYRTYyUQ3EDA1eI6orGbRFR3IyYV8amvqfX2VH3hL
        d9Uh/w2oQVCDFc56nrJXh0girqg8gvF45g6erjrE/eBCl/nRAmp4N5Ir3YffgzzeHBP1XFppoe4YO
        G2cwubAb2LbmtaQN/4Mv9aYcv4vz9MUrHaq4tsXuOrdAOkPgybyEP+whV8zAmHSN3Z2VhTP8y+WJ5
        kfl/GWVG+Ap0uQ0LCJSh0G8knvwDLIQbtf30a7ZUcjATbyDOyz4Yo7tzMPRKeepnPCWifimAI7u72
        j7dHJe9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNc-00CdcF-PC; Fri, 29 Apr 2022 17:26:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 53/69] fuse: Convert fuse to read_folio
Date:   Fri, 29 Apr 2022 18:25:40 +0100
Message-Id: <20220429172556.3011843-54-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
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

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/dir.c  | 10 +++++-----
 fs/fuse/file.c |  5 +++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 9ff27b8a9782..74303d6e987b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1957,20 +1957,20 @@ void fuse_init_dir(struct inode *inode)
 	fi->rdc.version = 0;
 }
 
-static int fuse_symlink_readpage(struct file *null, struct page *page)
+static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
 {
-	int err = fuse_readlink_page(page->mapping->host, page);
+	int err = fuse_readlink_page(folio->mapping->host, &folio->page);
 
 	if (!err)
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 
-	unlock_page(page);
+	folio_unlock(folio);
 
 	return err;
 }
 
 static const struct address_space_operations fuse_symlink_aops = {
-	.readpage	= fuse_symlink_readpage,
+	.read_folio	= fuse_symlink_read_folio,
 };
 
 void fuse_init_symlink(struct inode *inode)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bca8c2135ec5..05caa2b9272e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -857,8 +857,9 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	return 0;
 }
 
-static int fuse_readpage(struct file *file, struct page *page)
+static int fuse_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	int err;
 
@@ -3174,7 +3175,7 @@ static const struct file_operations fuse_file_operations = {
 };
 
 static const struct address_space_operations fuse_file_aops  = {
-	.readpage	= fuse_readpage,
+	.read_folio	= fuse_read_folio,
 	.readahead	= fuse_readahead,
 	.writepage	= fuse_writepage,
 	.writepages	= fuse_writepages,
-- 
2.34.1

