Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD04167D645
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjAZUYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjAZUYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0016A4B76C;
        Thu, 26 Jan 2023 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EeaPNEObsha+AWBX8R4Y4ZrKu6zLMBpNN7SqkKmdALs=; b=pruIDXeh6ee4FkxCdrpK8QyZmK
        lt3hVxfxXuyXALqwxERt+j/qLl+MaC8xYrXgPlPyHJ1fsoCAMh+yjthH2cJXx3wRftQjnb9iI+5du
        Kd4o5odr7E+/uDa+YbIb+FFdG/KP4X487UsJTfqLzLaPIC+3clFBC8kmI2IdUvY4TYy/SQkYiZ6O6
        cLr4AIug+eXMBPyOanM3V+BTF57EuSTECm9jFHeTtyyN3CRO2PBOfzX7tKfadFRL4WLCB+jDsOEp7
        87HrGcdUgwDgsOjsZUjcEd+GgT0HFJwQ7fBDv1syYw15BW4jRaA7XqtjdLL/400A/fKALJnCY1IvS
        6fY1KSNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nF-0073lM-58; Thu, 26 Jan 2023 20:24:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 24/31] ext4: Convert ext4_mpage_readpages() to work on folios
Date:   Thu, 26 Jan 2023 20:24:08 +0000
Message-Id: <20230126202415.1682629-25-willy@infradead.org>
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

This definitely doesn't include support for large folios; there
are all kinds of assumptions about the number of buffers attached
to a folio.  But it does remove several calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/ext4.h     |  2 +-
 fs/ext4/inode.c    |  7 +++---
 fs/ext4/readpage.c | 58 +++++++++++++++++++++-------------------------
 3 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d2998800855c..faa54035dbc8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3646,7 +3646,7 @@ static inline void ext4_set_de_type(struct super_block *sb,
 
 /* readpages.c */
 extern int ext4_mpage_readpages(struct inode *inode,
-		struct readahead_control *rac, struct page *page);
+		struct readahead_control *rac, struct folio *folio);
 extern int __init ext4_init_post_read_processing(void);
 extern void ext4_exit_post_read_processing(void);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8929add6808a..dbfc0670de75 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3299,17 +3299,16 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 
 static int ext4_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	int ret = -EAGAIN;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 
-	trace_ext4_readpage(page);
+	trace_ext4_readpage(&folio->page);
 
 	if (ext4_has_inline_data(inode))
 		ret = ext4_readpage_inline(inode, folio);
 
 	if (ret == -EAGAIN)
-		return ext4_mpage_readpages(inode, NULL, page);
+		return ext4_mpage_readpages(inode, NULL, folio);
 
 	return ret;
 }
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index c61dc8a7c014..8092d2ace75e 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -218,7 +218,7 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
 }
 
 int ext4_mpage_readpages(struct inode *inode,
-		struct readahead_control *rac, struct page *page)
+		struct readahead_control *rac, struct folio *folio)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -247,16 +247,15 @@ int ext4_mpage_readpages(struct inode *inode,
 		int fully_mapped = 1;
 		unsigned first_hole = blocks_per_page;
 
-		if (rac) {
-			page = readahead_page(rac);
-			prefetchw(&page->flags);
-		}
+		if (rac)
+			folio = readahead_folio(rac);
+		prefetchw(&folio->flags);
 
-		if (page_has_buffers(page))
+		if (folio_buffers(folio))
 			goto confused;
 
 		block_in_file = next_block =
-			(sector_t)page->index << (PAGE_SHIFT - blkbits);
+			(sector_t)folio->index << (PAGE_SHIFT - blkbits);
 		last_block = block_in_file + nr_pages * blocks_per_page;
 		last_block_in_file = (ext4_readpage_limit(inode) +
 				      blocksize - 1) >> blkbits;
@@ -290,7 +289,7 @@ int ext4_mpage_readpages(struct inode *inode,
 
 		/*
 		 * Then do more ext4_map_blocks() calls until we are
-		 * done with this page.
+		 * done with this folio.
 		 */
 		while (page_block < blocks_per_page) {
 			if (block_in_file < last_block) {
@@ -299,11 +298,11 @@ int ext4_mpage_readpages(struct inode *inode,
 
 				if (ext4_map_blocks(NULL, inode, &map, 0) < 0) {
 				set_error_page:
-					SetPageError(page);
-					zero_user_segment(page, 0,
-							  PAGE_SIZE);
-					unlock_page(page);
-					goto next_page;
+					folio_set_error(folio);
+					folio_zero_segment(folio, 0,
+							  folio_size(folio));
+					folio_unlock(folio);
+					continue;
 				}
 			}
 			if ((map.m_flags & EXT4_MAP_MAPPED) == 0) {
@@ -333,22 +332,22 @@ int ext4_mpage_readpages(struct inode *inode,
 			}
 		}
 		if (first_hole != blocks_per_page) {
-			zero_user_segment(page, first_hole << blkbits,
-					  PAGE_SIZE);
+			folio_zero_segment(folio, first_hole << blkbits,
+					  folio_size(folio));
 			if (first_hole == 0) {
-				if (ext4_need_verity(inode, page->index) &&
-				    !fsverity_verify_page(page))
+				if (ext4_need_verity(inode, folio->index) &&
+				    !fsverity_verify_page(&folio->page))
 					goto set_error_page;
-				SetPageUptodate(page);
-				unlock_page(page);
-				goto next_page;
+				folio_mark_uptodate(folio);
+				folio_unlock(folio);
+				continue;
 			}
 		} else if (fully_mapped) {
-			SetPageMappedToDisk(page);
+			folio_set_mappedtodisk(folio);
 		}
 
 		/*
-		 * This page will go to BIO.  Do we need to send this
+		 * This folio will go to BIO.  Do we need to send this
 		 * BIO off first?
 		 */
 		if (bio && (last_block_in_bio != blocks[0] - 1 ||
@@ -366,7 +365,7 @@ int ext4_mpage_readpages(struct inode *inode,
 					REQ_OP_READ, GFP_KERNEL);
 			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
 						  GFP_KERNEL);
-			ext4_set_bio_post_read_ctx(bio, inode, page->index);
+			ext4_set_bio_post_read_ctx(bio, inode, folio->index);
 			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
 			if (rac)
@@ -374,7 +373,7 @@ int ext4_mpage_readpages(struct inode *inode,
 		}
 
 		length = first_hole << blkbits;
-		if (bio_add_page(bio, page, length, 0) < length)
+		if (!bio_add_folio(bio, folio, length, 0))
 			goto submit_and_realloc;
 
 		if (((map.m_flags & EXT4_MAP_BOUNDARY) &&
@@ -384,19 +383,16 @@ int ext4_mpage_readpages(struct inode *inode,
 			bio = NULL;
 		} else
 			last_block_in_bio = blocks[blocks_per_page - 1];
-		goto next_page;
+		continue;
 	confused:
 		if (bio) {
 			submit_bio(bio);
 			bio = NULL;
 		}
-		if (!PageUptodate(page))
-			block_read_full_folio(page_folio(page), ext4_get_block);
+		if (!folio_test_uptodate(folio))
+			block_read_full_folio(folio, ext4_get_block);
 		else
-			unlock_page(page);
-	next_page:
-		if (rac)
-			put_page(page);
+			folio_unlock(folio);
 	}
 	if (bio)
 		submit_bio(bio);
-- 
2.35.1

