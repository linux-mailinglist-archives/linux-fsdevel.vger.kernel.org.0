Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53067D639
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjAZUYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjAZUYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB634B765;
        Thu, 26 Jan 2023 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2BOzDK6pCDMgwyThNN8pM/V+Fp6gQ9QaiOWEuZvfoMo=; b=Hgxk1OmIJAntbg5fYpMqnXFSrj
        3/fqOZRtZx6YEcxSEJ6Zv9MCohDBDi/jkKMX1AljlICbOc1m3nI27O1QBAo1A1K5sdmA161Lo3WFD
        RetILdnqkn7tFLXW60ePDWKFJI7ms2ltDESl9Ba8XLr3RwdTbre6gL/QWPE3EqN6gHncjHioFdxmo
        AbmDtH5vJ/EqxaHRRyVJp9+N8RxtJz1aay7TVUjJKdW5Cp3cNZlUvRcioqCFat0iEYS1azgdQNp3A
        SeXXraztbdVVUFlPH55oqkGWcf7a90A5DDIaKL7l/eBE/PaxVWNAZhA3dFnfNiHq3aUmWXDET6V21
        ThrzQwNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nE-0073kp-KG; Thu, 26 Jan 2023 20:24:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/31] ext4: Convert __ext4_block_zero_page_range() to use a folio
Date:   Thu, 26 Jan 2023 20:24:04 +0000
Message-Id: <20230126202415.1682629-21-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
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

Use folio APIs throughout.  Saves many calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b79e591b7c8e..727aa2e51a9d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3812,23 +3812,26 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	ext4_lblk_t iblock;
 	struct inode *inode = mapping->host;
 	struct buffer_head *bh;
-	struct page *page;
+	struct folio *folio;
 	int err = 0;
 
-	page = find_or_create_page(mapping, from >> PAGE_SHIFT,
-				   mapping_gfp_constraint(mapping, ~__GFP_FS));
-	if (!page)
+	folio = __filemap_get_folio(mapping, from >> PAGE_SHIFT,
+				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				    mapping_gfp_constraint(mapping, ~__GFP_FS));
+	if (!folio)
 		return -ENOMEM;
 
 	blocksize = inode->i_sb->s_blocksize;
 
 	iblock = index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
 
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, blocksize, 0);
+	bh = folio_buffers(folio);
+	if (!bh) {
+		create_empty_buffers(&folio->page, blocksize, 0);
+		bh = folio_buffers(folio);
+	}
 
 	/* Find the buffer that contains "offset" */
-	bh = page_buffers(page);
 	pos = blocksize;
 	while (offset >= pos) {
 		bh = bh->b_this_page;
@@ -3850,7 +3853,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	}
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		set_buffer_uptodate(bh);
 
 	if (!buffer_uptodate(bh)) {
@@ -3860,7 +3863,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 			/* We expect the key to be set. */
 			BUG_ON(!fscrypt_has_encryption_key(inode));
-			err = fscrypt_decrypt_pagecache_blocks(page, blocksize,
+			err = fscrypt_decrypt_pagecache_blocks(&folio->page,
+							       blocksize,
 							       bh_offset(bh));
 			if (err) {
 				clear_buffer_uptodate(bh);
@@ -3875,7 +3879,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		if (err)
 			goto unlock;
 	}
-	zero_user(page, offset, length);
+	folio_zero_range(folio, offset, length);
 	BUFFER_TRACE(bh, "zeroed end of block");
 
 	if (ext4_should_journal_data(inode)) {
@@ -3889,8 +3893,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	}
 
 unlock:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.35.1

