Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8801751F164
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiEHUgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiEHUff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688335F8A
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jk1UW5fp5fPlTLJ/xWRH7xjgxYLQuIENvNwJAeh2LlM=; b=qvd/a8X+NJa/9pirdCGGPsj3nc
        UG3rMIlQP8TxtPKIeuE4gkX0562wkTQ03LaX/a2C8brNsKyWcuKGFyOn0p4awbnQkSE71Wlbw0YGm
        b8ycplXHiu/KXYMq3K6ptp2snisnC+K2MyFIoD05ydocskQtMDru45iqfA9EI3apEkIJ6ctNTzHBE
        jokvEarw4J71l/2IG8ZGgtBLEj4s4s3YvQefReL6LzGhnc6wXceF3FCXl+db829RW6HxcuUvmZ0Ge
        bc9oLKypOt/E7CbCUt63h+07tBosPcOoHB4rFNFxCfZl9NQeSd2GPgFVAuOkc4EWC8gLKEqvAFzTk
        moDV+3Bg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ5-002np3-VF; Sun, 08 May 2022 20:31:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 24/37] isofs: Convert symlinks and zisofs to read_folio
Date:   Sun,  8 May 2022 21:31:18 +0100
Message-Id: <20220508203131.667959-25-willy@infradead.org>
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
 fs/isofs/compress.c | 5 +++--
 fs/isofs/rock.c     | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index bc12ac7e2312..95a19f25d61c 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -296,8 +296,9 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
  * per reference.  We inject the additional pages into the page
  * cache as a form of readahead.
  */
-static int zisofs_readpage(struct file *file, struct page *page)
+static int zisofs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	int err;
@@ -369,7 +370,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 }
 
 const struct address_space_operations zisofs_aops = {
-	.readpage = zisofs_readpage,
+	.read_folio = zisofs_read_folio,
 	/* No bmap operation supported */
 };
 
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 4880146babaf..48f58c6c9e69 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -687,11 +687,12 @@ int parse_rock_ridge_inode(struct iso_directory_record *de, struct inode *inode,
 }
 
 /*
- * readpage() for symlinks: reads symlink contents into the page and either
+ * read_folio() for symlinks: reads symlink contents into the folio and either
  * makes it uptodate and returns 0 or returns error (-EIO)
  */
-static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
+static int rock_ridge_symlink_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);
@@ -804,5 +805,5 @@ static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
 }
 
 const struct address_space_operations isofs_symlink_aops = {
-	.readpage = rock_ridge_symlink_readpage
+	.read_folio = rock_ridge_symlink_read_folio
 };
-- 
2.34.1

