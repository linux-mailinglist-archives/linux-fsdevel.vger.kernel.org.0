Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F048C51F16D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiEHUgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiEHUfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DFE60CD
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YgXlVyE6uLpqizpQn34DWWJORGr525Z9ytETikZF540=; b=AeleZuYkkXeJTLpIQ9P6fBuTFD
        Lv6MM1XY3smBF4vsiXaHjayYV4ssw204a03QelYYniLHhn6a3nxIal7g/azCoQOCescz8/2xTQ+YH
        xbyKxHGJ3UqwroxEKJ0/PO9Lvk+BMlkNffPBsO6tgaXrRqwxDheUUJj9j4Uc6Wjc2FmhmD0+88GW8
        qF9APi+esyt2z0m5DA8J4sMBsK2Mbcl/11qShXB8s+uCAKrc5FhYRKbf4wqhKLzYFlyQhXVO7nOaG
        dXYIpQAtioWYmdDI58k0oBof7OpshmnQ9yLbeMc5sI6tERZXNDT9q73uPLQuTvRKnhviUeo93dy7d
        VfdRPxJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ7-002nq7-8J; Sun, 08 May 2022 20:31:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 34/37] udf: Convert adinicb and symlinks to read_folio
Date:   Sun,  8 May 2022 21:31:28 +0100
Message-Id: <20220508203131.667959-35-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
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

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/udf/file.c    | 10 +++++-----
 fs/udf/symlink.c |  5 +++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 3f4d5c44c784..09aef77269fe 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -57,11 +57,11 @@ static void __udf_adinicb_readpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-static int udf_adinicb_readpage(struct file *file, struct page *page)
+static int udf_adinicb_read_folio(struct file *file, struct folio *folio)
 {
-	BUG_ON(!PageLocked(page));
-	__udf_adinicb_readpage(page);
-	unlock_page(page);
+	BUG_ON(!folio_test_locked(folio));
+	__udf_adinicb_readpage(&folio->page);
+	folio_unlock(folio);
 
 	return 0;
 }
@@ -127,7 +127,7 @@ static int udf_adinicb_write_end(struct file *file, struct address_space *mappin
 const struct address_space_operations udf_adinicb_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= udf_adinicb_readpage,
+	.read_folio	= udf_adinicb_read_folio,
 	.writepage	= udf_adinicb_writepage,
 	.write_begin	= udf_adinicb_write_begin,
 	.write_end	= udf_adinicb_write_end,
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index 9b223421a3c5..f3642f9c23f8 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -101,8 +101,9 @@ static int udf_pc_to_char(struct super_block *sb, unsigned char *from,
 	return 0;
 }
 
-static int udf_symlink_filler(struct file *file, struct page *page)
+static int udf_symlink_filler(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct buffer_head *bh = NULL;
 	unsigned char *symlink;
@@ -183,7 +184,7 @@ static int udf_symlink_getattr(struct user_namespace *mnt_userns,
  * symlinks can't do much...
  */
 const struct address_space_operations udf_symlink_aops = {
-	.readpage		= udf_symlink_filler,
+	.read_folio		= udf_symlink_filler,
 };
 
 const struct inode_operations udf_symlink_inode_operations = {
-- 
2.34.1

