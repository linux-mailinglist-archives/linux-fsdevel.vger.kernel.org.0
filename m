Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A775151F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379689AbiD2RaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379551AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA0EA2071
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BJj177M1qr0mdk+V5h83h2yX7XDhGHky1f+ZyB2GnAE=; b=u8fLA+/Iosdyw8McNYYZIxHcDj
        I7kRdQJRKR+gKtXZrxS3cMNLDS1aB8YvCBszJOfSD4fFq2zqp+5d78zHAIA5qy7zzNKyel823Ks0O
        PEl94YyDmECOXioaocAA+O2uXSpaX27kTrffj3dZTEgTllF7h+F+cSVuiCCg/PUjR3pKyYMZlWw3p
        Ejh+OD++P/JfKiccHeFONw7P32W3kqTvhKXWVBSnH9WIAKc9/JPUygCVpyMN2tHq9FGzzBVqIC3FP
        LLnShlxLs8fOj+Rnrljn4W39bOWeh5VL2JLmKUclUHFcPmGxAcRtVgbX+mZvowOMVXZ8Qup2UJU+F
        9oAsOn3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNb-00CdaW-1f; Fri, 29 Apr 2022 17:26:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 40/69] affs: Convert affs to read_folio
Date:   Fri, 29 Apr 2022 18:25:27 +0100
Message-Id: <20220429172556.3011843-41-willy@infradead.org>
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
 fs/affs/file.c    | 5 +++--
 fs/affs/symlink.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 5da562cc7fb7..cd00a4c68a12 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -629,8 +629,9 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 }
 
 static int
-affs_readpage_ofs(struct file *file, struct page *page)
+affs_read_folio_ofs(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	u32 to;
 	int err;
@@ -837,7 +838,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 const struct address_space_operations affs_aops_ofs = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage = affs_readpage_ofs,
+	.read_folio = affs_read_folio_ofs,
 	//.writepage = affs_writepage_ofs,
 	.write_begin = affs_write_begin_ofs,
 	.write_end = affs_write_end_ofs
diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
index a7531b26e8f0..31d6446dc166 100644
--- a/fs/affs/symlink.c
+++ b/fs/affs/symlink.c
@@ -11,8 +11,9 @@
 
 #include "affs.h"
 
-static int affs_symlink_readpage(struct file *file, struct page *page)
+static int affs_symlink_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct buffer_head *bh;
 	struct inode *inode = page->mapping->host;
 	char *link = page_address(page);
@@ -67,7 +68,7 @@ static int affs_symlink_readpage(struct file *file, struct page *page)
 }
 
 const struct address_space_operations affs_symlink_aops = {
-	.readpage	= affs_symlink_readpage,
+	.read_folio	= affs_symlink_read_folio,
 };
 
 const struct inode_operations affs_symlink_inode_operations = {
-- 
2.34.1

