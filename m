Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F4C7AA2FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjIUVp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjIUVpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:45:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E53BE38;
        Thu, 21 Sep 2023 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0GrfoVZf4pEwJGUQDfdqNVEVdhrqvsVectxd5IhmpwU=; b=nI1NMFYATechazb63KL+u20rRS
        YeznrFpxSZ67lWT686rITU8827ZrJ6jSIveeK10VFV3aEiq/OHvEHdiKOa90yYnVLYIMh0ors8Vj1
        iaYH14MAjSv428F6Zk+R03+9jluelLzVeOFD0XZa0879hx/U1alxk/94E90qDime6qBa3pO0dap7u
        vMNk1TtnN0IUMdH6Ddg9Uob0tqfnoaxBPUSOMYy+1yTpZqw816jwHHcW7sIfe6DEQkgfx/SdebeGH
        qUCCzeY0zb52Bix+5Ikr4KyzbeLoG0Awx9MrdOURIbkehScFdbY9ahJN6vlCeHHwyXhYn3ts/RARb
        1NBubFEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPxj-00DrVi-NS; Thu, 21 Sep 2023 20:07:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 02/10] ext2: Convert ext2_check_page to ext2_check_folio
Date:   Thu, 21 Sep 2023 21:07:39 +0100
Message-Id: <20230921200746.3303942-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230921200746.3303942-1-willy@infradead.org>
References: <20230921200746.3303942-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Support in this function for large folios is limited to supporting
filesystems with block size > PAGE_SIZE.  This new functionality will only
be supported on machines without HIGHMEM, so the problem of kmap_local
only being able to map a single page in the folio can be ignored.
We will not use large folios for ext2 directories on HIGHMEM machines.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/dir.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index b335f17f682f..03867381eec2 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -96,19 +96,19 @@ static void ext2_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	unlock_page(page);
 }
 
-static bool ext2_check_page(struct page *page, int quiet, char *kaddr)
+static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
 {
-	struct inode *dir = page->mapping->host;
+	struct inode *dir = folio->mapping->host;
 	struct super_block *sb = dir->i_sb;
 	unsigned chunk_size = ext2_chunk_size(dir);
 	u32 max_inumber = le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count);
 	unsigned offs, rec_len;
-	unsigned limit = PAGE_SIZE;
+	unsigned limit = folio_size(folio);
 	ext2_dirent *p;
 	char *error;
 
-	if ((dir->i_size >> PAGE_SHIFT) == page->index) {
-		limit = dir->i_size & ~PAGE_MASK;
+	if (dir->i_size < folio_pos(folio) + limit) {
+		limit = offset_in_folio(folio, dir->i_size);
 		if (limit & (chunk_size - 1))
 			goto Ebadsize;
 		if (!limit)
@@ -132,7 +132,7 @@ static bool ext2_check_page(struct page *page, int quiet, char *kaddr)
 	if (offs != limit)
 		goto Eend;
 out:
-	SetPageChecked(page);
+	folio_set_checked(folio);
 	return true;
 
 	/* Too bad, we had an error */
@@ -160,22 +160,22 @@ static bool ext2_check_page(struct page *page, int quiet, char *kaddr)
 bad_entry:
 	if (!quiet)
 		ext2_error(sb, __func__, "bad entry in directory #%lu: : %s - "
-			"offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
-			dir->i_ino, error, (page->index<<PAGE_SHIFT)+offs,
+			"offset=%llu, inode=%lu, rec_len=%d, name_len=%d",
+			dir->i_ino, error, folio_pos(folio) + offs,
 			(unsigned long) le32_to_cpu(p->inode),
 			rec_len, p->name_len);
 	goto fail;
 Eend:
 	if (!quiet) {
 		p = (ext2_dirent *)(kaddr + offs);
-		ext2_error(sb, "ext2_check_page",
+		ext2_error(sb, "ext2_check_folio",
 			"entry in directory #%lu spans the page boundary"
-			"offset=%lu, inode=%lu",
-			dir->i_ino, (page->index<<PAGE_SHIFT)+offs,
+			"offset=%llu, inode=%lu",
+			dir->i_ino, folio_pos(folio) + offs,
 			(unsigned long) le32_to_cpu(p->inode));
 	}
 fail:
-	SetPageError(page);
+	folio_set_error(folio);
 	return false;
 }
 
@@ -195,9 +195,9 @@ static void *ext2_get_page(struct inode *dir, unsigned long n,
 
 	if (IS_ERR(folio))
 		return ERR_CAST(folio);
-	page_addr = kmap_local_folio(folio, n & (folio_nr_pages(folio) - 1));
+	page_addr = kmap_local_folio(folio, 0);
 	if (unlikely(!folio_test_checked(folio))) {
-		if (!ext2_check_page(&folio->page, quiet, page_addr))
+		if (!ext2_check_folio(folio, quiet, page_addr))
 			goto fail;
 	}
 	*page = &folio->page;
-- 
2.40.1

