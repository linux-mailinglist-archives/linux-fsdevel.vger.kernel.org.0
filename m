Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA42A751708
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 05:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjGMDzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 23:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjGMDzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:55:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A78F1FDA;
        Wed, 12 Jul 2023 20:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DeCWJbZIEI3UvuMa+3l4cfkxIkNgFoQ48F8WN4E7png=; b=TxD9GhB08ZWtw0Hr2RVcx4E3AB
        4qqUDV+cZV4jTdL4GhPuXmr64YTgId79iybVm/wVJ0Lm+UcP0MtU4k94GzKxwPbyO9fZfQngssVtE
        iGigyXH7jujGSPlLxHLEX26PVTAO6TcnAecExKnOKkFP/9N/OolPoSTxeZ+tUJY05W9yOtli5AxRt
        WJhPzopW8L5Ri/0KkZnC6XS8ZaXTAr969hhvQUuq7vSFAlqXkxFbQqoEGlcxvXxYajIByimQ1NDCw
        1D+z1Pd7Bv0R15YA0rfAVbG6U9whoTVPapm1cohGD1Sglp37efyaZFugge/1m43woXEkaHCTZLw46
        UiGBlq5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJnQA-00HMri-Dh; Thu, 13 Jul 2023 03:55:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, "Theodore Tso" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: [PATCH 3/7] affs: Convert data read and write to use folios
Date:   Thu, 13 Jul 2023 04:55:08 +0100
Message-Id: <20230713035512.4139457-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230713035512.4139457-1-willy@infradead.org>
References: <20230713035512.4139457-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We still need to convert to/from folios in write_begin & write_end
to fit the API, but this removes a lot of calls to old page-based
functions, removing many hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/affs/file.c | 77 +++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index e43f2f007ac1..705e227ff63d 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -520,21 +520,20 @@ affs_getemptyblk_ino(struct inode *inode, int block)
 	return ERR_PTR(err);
 }
 
-static int
-affs_do_readpage_ofs(struct page *page, unsigned to, int create)
+static int affs_do_read_folio_ofs(struct folio *folio, size_t to, int create)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh;
-	unsigned pos = 0;
-	u32 bidx, boff, bsize;
+	size_t pos = 0;
+	size_t bidx, boff, bsize;
 	u32 tmp;
 
-	pr_debug("%s(%lu, %ld, 0, %d)\n", __func__, inode->i_ino,
-		 page->index, to);
-	BUG_ON(to > PAGE_SIZE);
+	pr_debug("%s(%lu, %ld, 0, %zu)\n", __func__, inode->i_ino,
+		 folio->index, to);
+	BUG_ON(to > folio_size(folio));
 	bsize = AFFS_SB(sb)->s_data_blksize;
-	tmp = page->index << PAGE_SHIFT;
+	tmp = folio_pos(folio);
 	bidx = tmp / bsize;
 	boff = tmp % bsize;
 
@@ -544,7 +543,7 @@ affs_do_readpage_ofs(struct page *page, unsigned to, int create)
 			return PTR_ERR(bh);
 		tmp = min(bsize - boff, to - pos);
 		BUG_ON(pos + tmp > to || tmp > bsize);
-		memcpy_to_page(page, pos, AFFS_DATA(bh) + boff, tmp);
+		memcpy_to_folio(folio, pos, AFFS_DATA(bh) + boff, tmp);
 		affs_brelse(bh);
 		bidx++;
 		pos += tmp;
@@ -624,25 +623,23 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 	return PTR_ERR(bh);
 }
 
-static int
-affs_read_folio_ofs(struct file *file, struct folio *folio)
+static int affs_read_folio_ofs(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
-	u32 to;
+	struct inode *inode = folio->mapping->host;
+	size_t to;
 	int err;
 
-	pr_debug("%s(%lu, %ld)\n", __func__, inode->i_ino, page->index);
-	to = PAGE_SIZE;
-	if (((page->index + 1) << PAGE_SHIFT) > inode->i_size) {
-		to = inode->i_size & ~PAGE_MASK;
-		memset(page_address(page) + to, 0, PAGE_SIZE - to);
+	pr_debug("%s(%lu, %ld)\n", __func__, inode->i_ino, folio->index);
+	to = folio_size(folio);
+	if (folio_pos(folio) + to > inode->i_size) {
+		to = inode->i_size - folio_pos(folio);
+		folio_zero_segment(folio, to, folio_size(folio));
 	}
 
-	err = affs_do_readpage_ofs(page, to, 0);
+	err = affs_do_read_folio_ofs(folio, to, 0);
 	if (!err)
-		SetPageUptodate(page);
-	unlock_page(page);
+		folio_mark_uptodate(folio);
+	folio_unlock(folio);
 	return err;
 }
 
@@ -651,7 +648,7 @@ static int affs_write_begin_ofs(struct file *file, struct address_space *mapping
 				struct page **pagep, void **fsdata)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t index;
 	int err = 0;
 
@@ -667,19 +664,20 @@ static int affs_write_begin_ofs(struct file *file, struct address_space *mapping
 	}
 
 	index = pos >> PAGE_SHIFT;
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
-		return -ENOMEM;
-	*pagep = page;
+	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	*pagep = &folio->page;
 
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		return 0;
 
 	/* XXX: inefficient but safe in the face of short writes */
-	err = affs_do_readpage_ofs(page, PAGE_SIZE, 1);
+	err = affs_do_read_folio_ofs(folio, folio_size(folio), 1);
 	if (err) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	return err;
 }
@@ -688,6 +686,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
 				struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh, *prev_bh;
@@ -701,18 +700,18 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 	to = from + len;
 	/*
 	 * XXX: not sure if this can handle short copies (len < copied), but
-	 * we don't have to, because the page should always be uptodate here,
+	 * we don't have to, because the folio should always be uptodate here,
 	 * due to write_begin.
 	 */
 
 	pr_debug("%s(%lu, %llu, %llu)\n", __func__, inode->i_ino, pos,
 		 pos + len);
 	bsize = AFFS_SB(sb)->s_data_blksize;
-	data = page_address(page);
+	data = folio_address(folio);
 
 	bh = NULL;
 	written = 0;
-	tmp = (page->index << PAGE_SHIFT) + from;
+	tmp = (folio->index << PAGE_SHIFT) + from;
 	bidx = tmp / bsize;
 	boff = tmp % bsize;
 	if (boff) {
@@ -804,11 +803,11 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		from += tmp;
 		bidx++;
 	}
-	SetPageUptodate(page);
+	folio_mark_uptodate(folio);
 
 done:
 	affs_brelse(bh);
-	tmp = (page->index << PAGE_SHIFT) + from;
+	tmp = (folio->index << PAGE_SHIFT) + from;
 	if (tmp > inode->i_size)
 		inode->i_size = AFFS_I(inode)->mmu_private = tmp;
 
@@ -819,8 +818,8 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 	}
 
 err_first_bh:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return written;
 
-- 
2.39.2

