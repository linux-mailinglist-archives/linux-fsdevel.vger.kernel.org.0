Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B5351F132
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiEHUeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiEHUdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4230E02D
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=O6jon2wZcOuRWNjQMdKziInEpsy1o/Bcpi2Jw+DC7f0=; b=wBIdl6O7hDmhFDU8KZYs2Mr8OW
        pvfnEqigB2Lpl/ap0VirsbflzgQA4Y5g8dvnucRT2ze6D68I8mZwDGi/o5mu8efGxyk43YQio1KlR
        3/nMd9qgSKtdy4O/El+sGVpsqKWwPYYOPD+b2D1ZO1W+827WSIZqz4MGK4L2XOg3XhuNVHightBTj
        d9K+FgcJ25YpDFdyawsDEuKTAjEbGVwCD8HMHga+s4yxPXnWE1EonKOFjVst7sFvGqFyXAQBMFMZ5
        ve8HPfyvKy/CokVU8aHEjSRAyw1oUDfUuUwT3/yg+uHqiwG2Porn8eVgLb4PaTM5IDxKW+rFV9heW
        pNaNZLHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXT-002nYn-3H; Sun, 08 May 2022 20:29:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/25] fs: Remove aop flags parameter from grab_cache_page_write_begin()
Date:   Sun,  8 May 2022 21:29:29 +0100
Message-Id: <20220508202941.667024-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508202941.667024-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202941.667024-1-willy@infradead.org>
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

There are no more aop flags left, so remove the parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/affs/file.c          | 2 +-
 fs/buffer.c             | 4 ++--
 fs/cifs/file.c          | 2 +-
 fs/ecryptfs/mmap.c      | 2 +-
 fs/ext4/inline.c        | 8 ++++----
 fs/ext4/inode.c         | 4 ++--
 fs/ext4/move_extent.c   | 4 ++--
 fs/f2fs/f2fs.h          | 2 +-
 fs/fuse/file.c          | 4 ++--
 fs/hostfs/hostfs_kern.c | 2 +-
 fs/jffs2/file.c         | 2 +-
 fs/libfs.c              | 2 +-
 fs/nfs/file.c           | 2 +-
 fs/ntfs3/inode.c        | 2 +-
 fs/orangefs/inode.c     | 2 +-
 fs/reiserfs/inode.c     | 2 +-
 fs/ubifs/file.c         | 4 ++--
 fs/udf/file.c           | 2 +-
 include/linux/pagemap.h | 2 +-
 mm/folio-compat.c       | 2 +-
 20 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 704911d6aeba..06645d05c717 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -670,7 +670,7 @@ static int affs_write_begin_ofs(struct file *file, struct address_space *mapping
 	}
 
 	index = pos >> PAGE_SHIFT;
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
 	*pagep = page;
diff --git a/fs/buffer.c b/fs/buffer.c
index fb97646d1977..01630218c75f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2110,7 +2110,7 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 	struct page *page;
 	int status;
 
-	page = grab_cache_page_write_begin(mapping, index, 0);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
 
@@ -2591,7 +2591,7 @@ int nobh_write_begin(struct address_space *mapping,
 	from = pos & (PAGE_SIZE - 1);
 	to = from + len;
 
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
 	*pagep = page;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index d511a78383c3..91aeae7fced8 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4695,7 +4695,7 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
 	cifs_dbg(FYI, "write_begin from %lld len %d\n", (long long)pos, len);
 
 start:
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page) {
 		rc = -ENOMEM;
 		goto out;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 9ad61b582f07..84e399a921ad 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -272,7 +272,7 @@ static int ecryptfs_write_begin(struct file *file,
 	loff_t prev_page_end_size;
 	int rc = 0;
 
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
 	*pagep = page;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index b2ef5ba568bc..6d253edebf9f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -563,7 +563,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	/* We cannot recurse into the filesystem as the transaction is already
 	 * started */
 	flags = memalloc_nofs_save();
-	page = grab_cache_page_write_begin(mapping, 0, 0);
+	page = grab_cache_page_write_begin(mapping, 0);
 	memalloc_nofs_restore(flags);
 	if (!page) {
 		ret = -ENOMEM;
@@ -692,7 +692,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		goto out;
 
 	flags = memalloc_nofs_save();
-	page = grab_cache_page_write_begin(mapping, 0, 0);
+	page = grab_cache_page_write_begin(mapping, 0);
 	memalloc_nofs_restore(flags);
 	if (!page) {
 		ret = -ENOMEM;
@@ -852,7 +852,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 	int ret = 0, inline_size;
 	struct page *page;
 
-	page = grab_cache_page_write_begin(mapping, 0, 0);
+	page = grab_cache_page_write_begin(mapping, 0);
 	if (!page)
 		return -ENOMEM;
 
@@ -946,7 +946,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	 * is already started.
 	 */
 	flags = memalloc_nofs_save();
-	page = grab_cache_page_write_begin(mapping, 0, 0);
+	page = grab_cache_page_write_begin(mapping, 0);
 	memalloc_nofs_restore(flags);
 	if (!page) {
 		ret = -ENOMEM;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01a55647c959..512d8143c765 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1171,7 +1171,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * the page (if needed) without using GFP_NOFS.
 	 */
 retry_grab:
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
 	unlock_page(page);
@@ -2963,7 +2963,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	}
 
 retry:
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 56f21272fb00..4172a7d22471 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -141,13 +141,13 @@ mext_page_double_lock(struct inode *inode1, struct inode *inode2,
 	}
 
 	flags = memalloc_nofs_save();
-	page[0] = grab_cache_page_write_begin(mapping[0], index1, 0);
+	page[0] = grab_cache_page_write_begin(mapping[0], index1);
 	if (!page[0]) {
 		memalloc_nofs_restore(flags);
 		return -ENOMEM;
 	}
 
-	page[1] = grab_cache_page_write_begin(mapping[1], index2, 0);
+	page[1] = grab_cache_page_write_begin(mapping[1], index2);
 	memalloc_nofs_restore(flags);
 	if (!page[1]) {
 		unlock_page(page[0]);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 74929ade4b5e..18df53ef3d7e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2677,7 +2677,7 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 		return grab_cache_page(mapping, index);
 
 	flags = memalloc_nofs_save();
-	page = grab_cache_page_write_begin(mapping, index, 0);
+	page = grab_cache_page_write_begin(mapping, index);
 	memalloc_nofs_restore(flags);
 
 	return page;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f18d14d5fea1..e35e394264ad 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1174,7 +1174,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 			break;
 
 		err = -ENOMEM;
-		page = grab_cache_page_write_begin(mapping, index, 0);
+		page = grab_cache_page_write_begin(mapping, index);
 		if (!page)
 			break;
 
@@ -2284,7 +2284,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 
 	WARN_ON(!fc->writeback_cache);
 
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		goto error;
 
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 14f9ac973a2e..2bfd316e1bf1 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -468,7 +468,7 @@ static int hostfs_write_begin(struct file *file, struct address_space *mapping,
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
 
-	*pagep = grab_cache_page_write_begin(mapping, index, flags);
+	*pagep = grab_cache_page_write_begin(mapping, index);
 	if (!*pagep)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index bd7d58d27bfc..142d3ba9f0a8 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -213,7 +213,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 	 * page in read_cache_page(), which causes a deadlock.
 	 */
 	mutex_lock(&c->alloc_sem);
-	pg = grab_cache_page_write_begin(mapping, index, flags);
+	pg = grab_cache_page_write_begin(mapping, index);
 	if (!pg) {
 		ret = -ENOMEM;
 		goto release_sem;
diff --git a/fs/libfs.c b/fs/libfs.c
index e64bdedef168..d4395e1c6696 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -557,7 +557,7 @@ int simple_write_begin(struct file *file, struct address_space *mapping,
 
 	index = pos >> PAGE_SHIFT;
 
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
 
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 150b7fa8f0a7..d66088dd33e7 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -325,7 +325,7 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 		file, mapping->host->i_ino, len, (long long) pos);
 
 start:
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
 	*pagep = page;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3914138fd8ba..16466c8648f3 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -872,7 +872,7 @@ static int ntfs_write_begin(struct file *file, struct address_space *mapping,
 	*pagep = NULL;
 	if (is_resident(ni)) {
 		struct page *page = grab_cache_page_write_begin(
-			mapping, pos >> PAGE_SHIFT, flags);
+			mapping, pos >> PAGE_SHIFT);
 
 		if (!page) {
 			err = -ENOMEM;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 79c1025d18ea..809690db8be2 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -338,7 +338,7 @@ static int orangefs_write_begin(struct file *file,
 
 	index = pos >> PAGE_SHIFT;
 
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
 
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 36c59b25486c..aa31cf1dbba6 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2764,7 +2764,7 @@ static int reiserfs_write_begin(struct file *file,
 
  	inode = mapping->host;
 	index = pos >> PAGE_SHIFT;
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
 		return -ENOMEM;
 	*pagep = page;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 0383fbdc95ff..0911fc311434 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -244,7 +244,7 @@ static int write_begin_slow(struct address_space *mapping,
 	if (unlikely(err))
 		return err;
 
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (unlikely(!page)) {
 		ubifs_release_budget(c, &req);
 		return -ENOMEM;
@@ -437,7 +437,7 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 		return -EROFS;
 
 	/* Try out the fast-path part first */
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, index);
 	if (unlikely(!page))
 		return -ENOMEM;
 
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 0f6bf2504437..724bb3141fda 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -94,7 +94,7 @@ static int udf_adinicb_write_begin(struct file *file,
 
 	if (WARN_ON_ONCE(pos >= PAGE_SIZE))
 		return -EIO;
-	page = grab_cache_page_write_begin(mapping, 0, flags);
+	page = grab_cache_page_write_begin(mapping, 0);
 	if (!page)
 		return -ENOMEM;
 	*pagep = page;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 993994cd943a..65ae8f96554b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -735,7 +735,7 @@ static inline unsigned find_get_pages_tag(struct address_space *mapping,
 }
 
 struct page *grab_cache_page_write_begin(struct address_space *mapping,
-			pgoff_t index, unsigned flags);
+			pgoff_t index);
 
 /*
  * Returns locked page at given index in given cache, creating it if needed.
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 3e42ddb81918..20bc15b57d93 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -131,7 +131,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 EXPORT_SYMBOL(pagecache_get_page);
 
 struct page *grab_cache_page_write_begin(struct address_space *mapping,
-					pgoff_t index, unsigned flags)
+					pgoff_t index)
 {
 	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
 
-- 
2.34.1

