Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722AE515206
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378101AbiD2Rao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379616AbiD2R3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C8AA66E5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jk1UW5fp5fPlTLJ/xWRH7xjgxYLQuIENvNwJAeh2LlM=; b=GUn9BVb1bPozHjyfS+qVueU4ym
        yrm0jSx+58w2CDEjYms0CP9S+Qgfzbqx/W3OHafzDWXn9q2xxPVga3MhZN9qeWiLYDck8KZZ78K8Q
        iGOgzENS8pNQmxS9OBS87QqZPiWqUNVghmVTt/rQnOVBQw2U4LlcB1HP3oDRglGgqRIxJ70FnZvpR
        sApVrcUWNrWVtipT8RyO4xwaxMiry4cgC96rIi2o37Q4Zg8j6Fx/DfbgnZkHOzITmL0s8zUWJ4Bz5
        e98vqPN9FvgccUqozdt/tm/4tc+TcPTlj7qyZDsFOzkpvocwmlWEwrdGzBxyLbIXAUNkwgv3aNO6i
        X/DW0j8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNd-00CdcY-A6; Fri, 29 Apr 2022 17:26:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 56/69] isofs: Convert symlinks and zisofs to read_folio
Date:   Fri, 29 Apr 2022 18:25:43 +0100
Message-Id: <20220429172556.3011843-57-willy@infradead.org>
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

