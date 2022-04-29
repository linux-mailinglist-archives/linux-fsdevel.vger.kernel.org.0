Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24B45151DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379621AbiD2R3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379239AbiD2R3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC86991A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LOIGMDSQvqjbbLhfwrNoP8DhHNVzMWWPwJ1QHy+c/8o=; b=C5zr1ffl0rlYchOLShL8YAtHNR
        6tQk1EbWTAenS7r/W1ro2/NducwJ/h+YFAyaI/uezBGtR1yl/WveckI3EyQFdqlLv7ULY6a3zzljV
        HleemYQwYZFk6VoEQtfVwmjFk+1uEePBnwnrJ6i6j++NeHUZB+8x6X4Vvxt4QCO4wgahK4lFglRmr
        Dzgi9W3A9dzZvHU4vUko+X0tM/+qDVj3Ddc8f/yPfi64tbIZ5QHBGOMyGgLo6SvOWWQFwggGx2uzA
        NqDc12AUa0v0q6KSznkwCLuoEoQFeFo3xN1+AbGh6vj2GuVMYyfdZJKMhduAOjTmoEJhEHXdFMsYk
        PaupfBow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNX-00CdXs-9j; Fri, 29 Apr 2022 17:26:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/69] fs: Remove aop flags parameter from block_write_begin()
Date:   Fri, 29 Apr 2022 18:24:59 +0100
Message-Id: <20220429172556.3011843-13-willy@infradead.org>
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

There are no more aop flags left, so remove the parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c                | 3 +--
 fs/bfs/file.c               | 3 +--
 fs/buffer.c                 | 6 +++---
 fs/ext2/inode.c             | 3 +--
 fs/minix/inode.c            | 3 +--
 fs/nilfs2/inode.c           | 3 +--
 fs/nilfs2/recovery.c        | 2 +-
 fs/ntfs3/inode.c            | 4 ++--
 fs/omfs/file.c              | 3 +--
 fs/sysv/itree.c             | 2 +-
 fs/udf/inode.c              | 2 +-
 fs/ufs/inode.c              | 3 +--
 include/linux/buffer_head.h | 2 +-
 13 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9f2ecec406b0..b432756570c6 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -401,8 +401,7 @@ static int blkdev_write_begin(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned len, unsigned flags, struct page **pagep,
 		void **fsdata)
 {
-	return block_write_begin(mapping, pos, len, flags, pagep,
-				 blkdev_get_block);
+	return block_write_begin(mapping, pos, len, pagep, blkdev_get_block);
 }
 
 static int blkdev_write_end(struct file *file, struct address_space *mapping,
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 03139344568f..9408f45225cb 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -174,8 +174,7 @@ static int bfs_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, flags, pagep,
-				bfs_get_block);
+	ret = block_write_begin(mapping, pos, len, pagep, bfs_get_block);
 	if (unlikely(ret))
 		bfs_write_failed(mapping, pos + len);
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 2b5561ae5d0b..4ec6eb03c0eb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2104,13 +2104,13 @@ static int __block_commit_write(struct inode *inode, struct page *page,
  * The filesystem needs to handle block truncation upon failure.
  */
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
-		unsigned flags, struct page **pagep, get_block_t *get_block)
+		struct page **pagep, get_block_t *get_block)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct page *page;
 	int status;
 
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index, 0);
 	if (!page)
 		return -ENOMEM;
 
@@ -2460,7 +2460,7 @@ int cont_write_begin(struct file *file, struct address_space *mapping,
 		(*bytes)++;
 	}
 
-	return block_write_begin(mapping, pos, len, flags, pagep, get_block);
+	return block_write_begin(mapping, pos, len, pagep, get_block);
 }
 EXPORT_SYMBOL(cont_write_begin);
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 52377a0ee735..97192932ea56 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -892,8 +892,7 @@ ext2_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, flags, pagep,
-				ext2_get_block);
+	ret = block_write_begin(mapping, pos, len, pagep, ext2_get_block);
 	if (ret < 0)
 		ext2_write_failed(mapping, pos + len);
 	return ret;
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index f1a6610e4ee6..5e8d7ba661cf 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -428,8 +428,7 @@ static int minix_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, flags, pagep,
-				minix_get_block);
+	ret = block_write_begin(mapping, pos, len, pagep, minix_get_block);
 	if (unlikely(ret))
 		minix_write_failed(mapping, pos + len);
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 6045cea21f52..be09a0d10f04 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -258,8 +258,7 @@ static int nilfs_write_begin(struct file *file, struct address_space *mapping,
 	if (unlikely(err))
 		return err;
 
-	err = block_write_begin(mapping, pos, len, flags, pagep,
-				nilfs_get_block);
+	err = block_write_begin(mapping, pos, len, pagep, nilfs_get_block);
 	if (unlikely(err)) {
 		nilfs_write_failed(mapping, pos + len);
 		nilfs_transaction_abort(inode->i_sb);
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 9e2ed76c0f25..0955b657938f 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -511,7 +511,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 
 		pos = rb->blkoff << inode->i_blkbits;
 		err = block_write_begin(inode->i_mapping, pos, blocksize,
-					0, &page, nilfs_get_block);
+					&page, nilfs_get_block);
 		if (unlikely(err)) {
 			loff_t isize = inode->i_size;
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 9eab11e3b034..3914138fd8ba 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -894,7 +894,7 @@ static int ntfs_write_begin(struct file *file, struct address_space *mapping,
 			goto out;
 	}
 
-	err = block_write_begin(mapping, pos, len, flags, pagep,
+	err = block_write_begin(mapping, pos, len, pagep,
 				ntfs_get_block_write_begin);
 
 out:
@@ -975,7 +975,7 @@ int reset_log_file(struct inode *inode)
 
 		len = pos + PAGE_SIZE > log_size ? (log_size - pos) : PAGE_SIZE;
 
-		err = block_write_begin(mapping, pos, len, 0, &page,
+		err = block_write_begin(mapping, pos, len, &page,
 					ntfs_get_block_write_begin);
 		if (err)
 			goto out;
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 3f297b541713..349b96d89c44 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -321,8 +321,7 @@ static int omfs_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, flags, pagep,
-				omfs_get_block);
+	ret = block_write_begin(mapping, pos, len, pagep, omfs_get_block);
 	if (unlikely(ret))
 		omfs_write_failed(mapping, pos + len);
 
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 409ab5e17803..96b7fd4facf3 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -482,7 +482,7 @@ static int sysv_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, flags, pagep, get_block);
+	ret = block_write_begin(mapping, pos, len, pagep, get_block);
 	if (unlikely(ret))
 		sysv_write_failed(mapping, pos + len);
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index ca4fa710e562..88a95886ce8a 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -209,7 +209,7 @@ static int udf_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, flags, pagep, udf_get_block);
+	ret = block_write_begin(mapping, pos, len, pagep, udf_get_block);
 	if (unlikely(ret))
 		udf_write_failed(mapping, pos + len);
 	return ret;
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index d0dda01620f0..bd0e0c66f93d 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -500,8 +500,7 @@ static int ufs_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, flags, pagep,
-				ufs_getfrag_block);
+	ret = block_write_begin(mapping, pos, len, pagep, ufs_getfrag_block);
 	if (unlikely(ret))
 		ufs_write_failed(mapping, pos + len);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index bcb4fe9b8575..63e49dfa7738 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -226,7 +226,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 int block_read_full_page(struct page*, get_block_t*);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
-		unsigned flags, struct page **pagep, get_block_t *get_block);
+		struct page **pagep, get_block_t *get_block);
 int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 		get_block_t *get_block);
 int block_write_end(struct file *, struct address_space *,
-- 
2.34.1

