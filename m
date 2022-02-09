Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D79C4AFE40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiBIUWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiBIUWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184DE039C4E
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aWNmG6vr7i9nQsg/FR3ZMa/ueMgVkzTUTWOCuCya9QU=; b=Zxllt4dvv67t1KC+rx2ouMoX+d
        Khw5iEkmOcktU7J02jVldD7qzLlAcUrvI2ftvZmdgHB4ogA1N/TnvJtyOZRNDoJ7iPugtrlmzwyjI
        bgAP5bhy3nbgcdft11RrpkxS90nE1Miqniu/kIFI50ySPMGurh046kzSEXjTqn8ofP4bdTFZZLu1D
        3/iyqgwtpQgKJWXF7tJ0RpzVr4oLoj4Z4xVOu4vJbpVSAJFW8Y6EPmg40tnHI7iggXQthHKJ9oowv
        /HtHN/a84cRF0fpQNKyaF9gGXJxFUkOXdgTELQhdMvT5HgNnjQgbjJRQy87cCKu9RMe+1qDZhSOoP
        fkCK1xPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTt-008cqN-04; Wed, 09 Feb 2022 20:22:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 19/56] afs: Convert invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:38 +0000
Message-Id: <20220209202215.2055748-20-willy@infradead.org>
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

We know the page is in the page cache, not the swap cache.  If we ever
support folios larger than 2GB, afs_invalidate_dirty() will need to be
fixed, but that's a larger project.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/file.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 720818a7c166..699ea2dd01e4 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -21,8 +21,8 @@
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
 static int afs_readpage(struct file *file, struct page *page);
 static int afs_symlink_readpage(struct file *file, struct page *page);
-static void afs_invalidatepage(struct page *page, unsigned int offset,
-			       unsigned int length);
+static void afs_invalidate_folio(struct folio *folio, size_t offset,
+			       size_t length);
 static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 
 static void afs_readahead(struct readahead_control *ractl);
@@ -57,7 +57,7 @@ const struct address_space_operations afs_file_aops = {
 	.set_page_dirty	= afs_set_page_dirty,
 	.launder_page	= afs_launder_page,
 	.releasepage	= afs_releasepage,
-	.invalidatepage	= afs_invalidatepage,
+	.invalidate_folio = afs_invalidate_folio,
 	.write_begin	= afs_write_begin,
 	.write_end	= afs_write_end,
 	.writepage	= afs_writepage,
@@ -67,7 +67,7 @@ const struct address_space_operations afs_file_aops = {
 const struct address_space_operations afs_symlink_aops = {
 	.readpage	= afs_symlink_readpage,
 	.releasepage	= afs_releasepage,
-	.invalidatepage	= afs_invalidatepage,
+	.invalidate_folio = afs_invalidate_folio,
 };
 
 static const struct vm_operations_struct afs_vm_ops = {
@@ -427,8 +427,8 @@ int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
  * Adjust the dirty region of the page on truncation or full invalidation,
  * getting rid of the markers altogether if the region is entirely invalidated.
  */
-static void afs_invalidate_dirty(struct folio *folio, unsigned int offset,
-				 unsigned int length)
+static void afs_invalidate_dirty(struct folio *folio, size_t offset,
+				 size_t length)
 {
 	struct afs_vnode *vnode = AFS_FS_I(folio_inode(folio));
 	unsigned long priv;
@@ -485,16 +485,14 @@ static void afs_invalidate_dirty(struct folio *folio, unsigned int offset,
  * - release a page and clean up its private data if offset is 0 (indicating
  *   the entire page)
  */
-static void afs_invalidatepage(struct page *page, unsigned int offset,
-			       unsigned int length)
+static void afs_invalidate_folio(struct folio *folio, size_t offset,
+			       size_t length)
 {
-	struct folio *folio = page_folio(page);
-
-	_enter("{%lu},%u,%u", folio_index(folio), offset, length);
+	_enter("{%lu},%zu,%zu", folio->index, offset, length);
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 
-	if (PagePrivate(page))
+	if (folio_get_private(folio))
 		afs_invalidate_dirty(folio, offset, length);
 
 	folio_wait_fscache(folio);
-- 
2.34.1

