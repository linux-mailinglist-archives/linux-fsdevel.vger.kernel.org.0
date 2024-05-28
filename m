Return-Path: <linux-fsdevel+bounces-20366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634598D21F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 18:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8335B1C22FF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB6717332C;
	Tue, 28 May 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MMaip63m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D97173328;
	Tue, 28 May 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914915; cv=none; b=LjHIdrXDNIHfEfQ3UsgOmpG0IfkjM8jEdvihFrOcWZG5f66gH9/jhb0mm923BFEdBuVvKsIc021XeE+5K4k6l4E4RYfSk9h6Be4zJbHH4bv3FzblPozW3aiumuXwNqVZyMImRHWhTUJc8MR9QbKUiOa+g2c6nSSGjm3fiDU8ms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914915; c=relaxed/simple;
	bh=qvj9AvSuAO7iaLziIsdmDUA6I+Nze224/7M2Onq5khw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKzdVY/kgVQaqksVInQYEUFrZuOheIsCYjJ0zj1hP5LyO+7BsYweZnWxpTXVf8YgIVOl3uPRMGb9ART9ZtL0aId/Qs8kOyGHoXwPK+mJg9lZ3jJzRdDR2TMGIPJG4PdTHXxyFsRv1x7HCzBgfdJmXY2CWN4wSrTC06tTK2Oz9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MMaip63m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=b8tfGuIMOOtLkmj3SquUXuuoroZe0OEB7YzKy418gEI=; b=MMaip63m2bQhZOUOE+hCdWk/WN
	N4/iissAi3Nj1MQN/Fy7XMqSiTZl7OUQHEVyEkIdbtGYjQv6FNcNjOPkJqOQ4eY7JIj1Hpm2X7Jgg
	6jkPh4D9kCdbgG+0Lz17uyhiBUHpG++firTza704gBHRSWbDGLxPjKR2/2B4XFgWCwPEA4uoiXOB0
	NLWSk5XalpdH18THTTedhreow4SmIhC98DIcL7IxQ+eSZuVx+RFFTz9dVzOUQvpxhnVO0OD4FdT81
	Yzhabwo8mmuiCfn9heQqbs0+Dco8ZYE8LK94w9SpOGSNPDxXr6pMG6bVQTRe9Bb/baeaGkIjTBeb4
	28jUoyUw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzzz-00000008pjX-3R2f;
	Tue, 28 May 2024 16:48:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 6/7] ext4: Convert to buffered_write_operations
Date: Tue, 28 May 2024 17:48:27 +0100
Message-ID: <20240528164829.2105447-7-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528164829.2105447-1-willy@infradead.org>
References: <20240528164829.2105447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the appropriate buffered_write_operations to filemap_perform_write().
Saves a lot of page<->folio conversions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c      |   2 +-
 fs/ext4/ext4.h   |  24 ++++-----
 fs/ext4/file.c   |  12 ++++-
 fs/ext4/inline.c |  66 ++++++++++-------------
 fs/ext4/inode.c  | 134 ++++++++++++++++++++---------------------------
 5 files changed, 108 insertions(+), 130 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4064b21fe499..98f116e8abde 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2299,7 +2299,7 @@ int block_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
-	return buffer_write_end(file, mapping, pos, len, copied,
+	return __buffer_write_end(file, mapping, pos, len, copied,
 			page_folio(page));
 }
 EXPORT_SYMBOL(block_write_end);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 983dad8c07ec..b6f7509e3f55 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2971,8 +2971,6 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
-#define FALL_BACK_TO_NONDELALLOC 1
-#define CONVERT_INLINE_DATA	 2
 
 typedef enum {
 	EXT4_IGET_NORMAL =	0,
@@ -3011,6 +3009,7 @@ extern int ext4_break_layouts(struct inode *);
 extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
 extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
+int ext4_nonda_switch(struct super_block *sb);
 extern void ext4_set_aops(struct inode *inode);
 extern int ext4_writepage_trans_blocks(struct inode *);
 extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
@@ -3026,6 +3025,10 @@ extern void ext4_da_update_reserve_space(struct inode *inode,
 extern int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk,
 			      ext4_fsblk_t pblk, ext4_lblk_t len);
 
+extern const struct buffered_write_operations ext4_bw_ops;
+extern const struct buffered_write_operations ext4_journalled_bw_ops;
+extern const struct buffered_write_operations ext4_da_bw_ops;
+
 /* indirect.c */
 extern int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 				struct ext4_map_blocks *map, int flags);
@@ -3551,17 +3554,12 @@ extern int ext4_find_inline_data_nolock(struct inode *inode);
 extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);
 
 int ext4_readpage_inline(struct inode *inode, struct folio *folio);
-extern int ext4_try_to_write_inline_data(struct address_space *mapping,
-					 struct inode *inode,
-					 loff_t pos, unsigned len,
-					 struct page **pagep);
-int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
-			       unsigned copied, struct folio *folio);
-extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
-					   struct inode *inode,
-					   loff_t pos, unsigned len,
-					   struct page **pagep,
-					   void **fsdata);
+struct folio *ext4_try_to_write_inline_data(struct address_space *mapping,
+		struct inode *inode, loff_t pos, size_t len);
+size_t ext4_write_inline_data_end(struct inode *inode, loff_t pos, size_t len,
+			       size_t copied, struct folio *folio);
+struct folio *ext4_da_write_inline_data_begin(struct address_space *mapping,
+		struct inode *inode, loff_t pos, size_t len);
 extern int ext4_try_add_inline_entry(handle_t *handle,
 				     struct ext4_filename *fname,
 				     struct inode *dir, struct inode *inode);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c89e434db6b7..08c2772966a9 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -287,16 +287,26 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 {
 	ssize_t ret;
 	struct inode *inode = file_inode(iocb->ki_filp);
+	const struct buffered_write_operations *ops;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
+	if (ext4_should_journal_data(inode))
+		ops = &ext4_journalled_bw_ops;
+	else if (test_opt(inode->i_sb, DELALLOC) &&
+		 !ext4_nonda_switch(inode->i_sb) &&
+		 !ext4_verity_in_progress(inode))
+		ops = &ext4_da_bw_ops;
+	else
+		ops = &ext4_bw_ops;
+
 	inode_lock(inode);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
 
-	ret = generic_perform_write(iocb, from);
+	ret = filemap_perform_write(iocb, from, ops, NULL);
 
 out:
 	inode_unlock(inode);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d5bd1e3a5d36..cb5cb2cc9c2b 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -538,8 +538,9 @@ int ext4_readpage_inline(struct inode *inode, struct folio *folio)
 	return ret >= 0 ? 0 : ret;
 }
 
-static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
-					      struct inode *inode)
+/* Returns NULL on success, ERR_PTR on failure */
+static void *ext4_convert_inline_data_to_extent(struct address_space *mapping,
+		struct inode *inode)
 {
 	int ret, needed_blocks, no_expand;
 	handle_t *handle = NULL;
@@ -554,14 +555,14 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		 * will trap here again.
 		 */
 		ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
-		return 0;
+		return NULL;
 	}
 
 	needed_blocks = ext4_writepage_trans_blocks(inode);
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 retry:
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, needed_blocks);
@@ -648,7 +649,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	if (handle)
 		ext4_journal_stop(handle);
 	brelse(iloc.bh);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /*
@@ -657,10 +658,8 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
  * in the inode also. If not, create the page the handle, move the data
  * to the page make it update and let the later codes create extent for it.
  */
-int ext4_try_to_write_inline_data(struct address_space *mapping,
-				  struct inode *inode,
-				  loff_t pos, unsigned len,
-				  struct page **pagep)
+struct folio *ext4_try_to_write_inline_data(struct address_space *mapping,
+		struct inode *inode, loff_t pos, size_t len)
 {
 	int ret;
 	handle_t *handle;
@@ -672,7 +671,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	/*
 	 * The possible write could happen in the inode,
@@ -680,7 +679,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	 */
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
 	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
+		folio = ERR_CAST(handle);
 		handle = NULL;
 		goto out;
 	}
@@ -703,17 +702,14 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 
 	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
 					mapping_gfp_mask(mapping));
-	if (IS_ERR(folio)) {
-		ret = PTR_ERR(folio);
+	if (IS_ERR(folio))
 		goto out;
-	}
 
-	*pagep = &folio->page;
 	down_read(&EXT4_I(inode)->xattr_sem);
 	if (!ext4_has_inline_data(inode)) {
-		ret = 0;
 		folio_unlock(folio);
 		folio_put(folio);
+		folio = NULL;
 		goto out_up_read;
 	}
 
@@ -726,21 +722,22 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		}
 	}
 
-	ret = 1;
 	handle = NULL;
 out_up_read:
 	up_read(&EXT4_I(inode)->xattr_sem);
 out:
-	if (handle && (ret != 1))
+	if (ret < 0)
+		folio = ERR_PTR(ret);
+	if (handle && IS_ERR_OR_NULL(folio))
 		ext4_journal_stop(handle);
 	brelse(iloc.bh);
-	return ret;
+	return folio;
 convert:
 	return ext4_convert_inline_data_to_extent(mapping, inode);
 }
 
-int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
-			       unsigned copied, struct folio *folio)
+size_t ext4_write_inline_data_end(struct inode *inode, loff_t pos, size_t len,
+		size_t copied, struct folio *folio)
 {
 	handle_t *handle = ext4_journal_current_handle();
 	int no_expand;
@@ -831,8 +828,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
  *    need to start the journal since the file's metadata isn't changed now.
  */
 static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
-						 struct inode *inode,
-						 void **fsdata)
+						 struct inode *inode)
 {
 	int ret = 0, inline_size;
 	struct folio *folio;
@@ -869,7 +865,6 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 	folio_mark_dirty(folio);
 	folio_mark_uptodate(folio);
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
-	*fsdata = (void *)CONVERT_INLINE_DATA;
 
 out:
 	up_read(&EXT4_I(inode)->xattr_sem);
@@ -888,11 +883,8 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
  * handle in writepages(the i_disksize update is left to the
  * normal ext4_da_write_end).
  */
-int ext4_da_write_inline_data_begin(struct address_space *mapping,
-				    struct inode *inode,
-				    loff_t pos, unsigned len,
-				    struct page **pagep,
-				    void **fsdata)
+struct folio *ext4_da_write_inline_data_begin(struct address_space *mapping,
+		struct inode *inode, loff_t pos, size_t len)
 {
 	int ret;
 	handle_t *handle;
@@ -902,7 +894,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 retry_journal:
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
@@ -918,8 +910,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	if (ret == -ENOSPC) {
 		ext4_journal_stop(handle);
 		ret = ext4_da_convert_inline_data_to_extent(mapping,
-							    inode,
-							    fsdata);
+							    inode);
 		if (ret == -ENOSPC &&
 		    ext4_should_retry_alloc(inode->i_sb, &retries))
 			goto retry_journal;
@@ -932,10 +923,8 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	 */
 	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
 					mapping_gfp_mask(mapping));
-	if (IS_ERR(folio)) {
-		ret = PTR_ERR(folio);
+	if (IS_ERR(folio))
 		goto out_journal;
-	}
 
 	down_read(&EXT4_I(inode)->xattr_sem);
 	if (!ext4_has_inline_data(inode)) {
@@ -954,18 +943,17 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out_release_page;
 
 	up_read(&EXT4_I(inode)->xattr_sem);
-	*pagep = &folio->page;
-	brelse(iloc.bh);
-	return 1;
+	goto out;
 out_release_page:
 	up_read(&EXT4_I(inode)->xattr_sem);
 	folio_unlock(folio);
 	folio_put(folio);
+	folio = ERR_PTR(ret);
 out_journal:
 	ext4_journal_stop(handle);
 out:
 	brelse(iloc.bh);
-	return ret;
+	return folio;
 }
 
 #ifdef INLINE_DIR_DEBUG
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4bae9ccf5fe0..e9526e55e86c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1014,7 +1014,7 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 
 #ifdef CONFIG_FS_ENCRYPTION
 static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
-				  get_block_t *get_block)
+				  get_block_t *get_block, void **fsdata)
 {
 	unsigned from = pos & (PAGE_SIZE - 1);
 	unsigned to = from + len;
@@ -1114,9 +1114,9 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
  * and the ext4_write_end().  So doing the jbd2_journal_start at the start of
  * ext4_write_begin() is the right place.
  */
-static int ext4_write_begin(struct file *file, struct address_space *mapping,
-			    loff_t pos, unsigned len,
-			    struct page **pagep, void **fsdata)
+static struct folio *ext4_write_begin(struct file *file,
+		struct address_space *mapping, loff_t pos, size_t len,
+		void **fsdata)
 {
 	struct inode *inode = mapping->host;
 	int ret, needed_blocks;
@@ -1127,7 +1127,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	unsigned from, to;
 
 	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+		return ERR_PTR(-EIO);
 
 	trace_ext4_write_begin(inode, pos, len);
 	/*
@@ -1140,12 +1140,9 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	to = from + len;
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
-		ret = ext4_try_to_write_inline_data(mapping, inode, pos, len,
-						    pagep);
-		if (ret < 0)
-			return ret;
-		if (ret == 1)
-			return 0;
+		folio = ext4_try_to_write_inline_data(mapping, inode, pos, len);
+		if (folio)
+			return folio;
 	}
 
 	/*
@@ -1159,7 +1156,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 					mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+		return folio;
 	/*
 	 * The same as page allocation, we prealloc buffer heads before
 	 * starting the handle.
@@ -1173,7 +1170,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, needed_blocks);
 	if (IS_ERR(handle)) {
 		folio_put(folio);
-		return PTR_ERR(handle);
+		return ERR_CAST(handle);
 	}
 
 	folio_lock(folio);
@@ -1190,9 +1187,10 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 #ifdef CONFIG_FS_ENCRYPTION
 	if (ext4_should_dioread_nolock(inode))
 		ret = ext4_block_write_begin(folio, pos, len,
-					     ext4_get_block_unwritten);
+					     ext4_get_block_unwritten, fsdata);
 	else
-		ret = ext4_block_write_begin(folio, pos, len, ext4_get_block);
+		ret = ext4_block_write_begin(folio, pos, len, ext4_get_block,
+				fsdata);
 #else
 	if (ext4_should_dioread_nolock(inode))
 		ret = __block_write_begin(&folio->page, pos, len,
@@ -1239,10 +1237,9 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		    ext4_should_retry_alloc(inode->i_sb, &retries))
 			goto retry_journal;
 		folio_put(folio);
-		return ret;
+		return ERR_PTR(ret);
 	}
-	*pagep = &folio->page;
-	return ret;
+	return folio;
 }
 
 /* For write_end() in data=journal mode */
@@ -1266,12 +1263,10 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
  * ext4 never places buffers on inode->i_mapping->i_private_list.  metadata
  * buffers are managed internally.
  */
-static int ext4_write_end(struct file *file,
-			  struct address_space *mapping,
-			  loff_t pos, unsigned len, unsigned copied,
-			  struct page *page, void *fsdata)
+static size_t ext4_write_end(struct file *file, struct address_space *mapping,
+		loff_t pos, size_t len, size_t copied, struct folio *folio,
+		void **fsdata)
 {
-	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -1286,7 +1281,7 @@ static int ext4_write_end(struct file *file,
 		return ext4_write_inline_data_end(inode, pos, len, copied,
 						  folio);
 
-	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
+	copied = __buffer_write_end(file, mapping, pos, len, copied, folio);
 	/*
 	 * it's important to update i_size while still holding folio lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
@@ -1370,12 +1365,10 @@ static void ext4_journalled_zero_new_buffers(handle_t *handle,
 	} while (bh != head);
 }
 
-static int ext4_journalled_write_end(struct file *file,
-				     struct address_space *mapping,
-				     loff_t pos, unsigned len, unsigned copied,
-				     struct page *page, void *fsdata)
+static size_t ext4_journalled_write_end(struct file *file,
+		struct address_space *mapping, loff_t pos, size_t len,
+		size_t copied, struct folio *folio, void **fsdata)
 {
-	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -2816,7 +2809,7 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	return ret;
 }
 
-static int ext4_nonda_switch(struct super_block *sb)
+int ext4_nonda_switch(struct super_block *sb)
 {
 	s64 free_clusters, dirty_clusters;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -2850,45 +2843,35 @@ static int ext4_nonda_switch(struct super_block *sb)
 	return 0;
 }
 
-static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
-			       loff_t pos, unsigned len,
-			       struct page **pagep, void **fsdata)
+static struct folio *ext4_da_write_begin(struct file *file,
+		struct address_space *mapping, loff_t pos, size_t len,
+		void **fsdata)
 {
 	int ret, retries = 0;
 	struct folio *folio;
-	pgoff_t index;
 	struct inode *inode = mapping->host;
 
 	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+		return ERR_PTR(-EIO);
 
-	index = pos >> PAGE_SHIFT;
-
-	if (ext4_nonda_switch(inode->i_sb) || ext4_verity_in_progress(inode)) {
-		*fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
-		return ext4_write_begin(file, mapping, pos,
-					len, pagep, fsdata);
-	}
-	*fsdata = (void *)0;
 	trace_ext4_da_write_begin(inode, pos, len);
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
-		ret = ext4_da_write_inline_data_begin(mapping, inode, pos, len,
-						      pagep, fsdata);
-		if (ret < 0)
-			return ret;
-		if (ret == 1)
-			return 0;
+		folio = ext4_da_write_inline_data_begin(mapping, inode, pos,
+				len);
+		if (folio)
+			return folio;
 	}
 
 retry:
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+	folio = __filemap_get_folio(mapping, pos / PAGE_SIZE, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+		return folio;
 
 #ifdef CONFIG_FS_ENCRYPTION
-	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
+	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep,
+			fsdata);
 #else
 	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
 #endif
@@ -2906,11 +2889,10 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 		if (ret == -ENOSPC &&
 		    ext4_should_retry_alloc(inode->i_sb, &retries))
 			goto retry;
-		return ret;
+		return ERR_PTR(ret);
 	}
 
-	*pagep = &folio->page;
-	return ret;
+	return folio;
 }
 
 /*
@@ -2936,9 +2918,8 @@ static int ext4_da_should_update_i_disksize(struct folio *folio,
 	return 1;
 }
 
-static int ext4_da_do_write_end(struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct folio *folio)
+static size_t ext4_da_do_write_end(struct address_space *mapping, loff_t pos,
+		size_t len, size_t copied, struct folio *folio)
 {
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -2998,23 +2979,15 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	return copied;
 }
 
-static int ext4_da_write_end(struct file *file,
-			     struct address_space *mapping,
-			     loff_t pos, unsigned len, unsigned copied,
-			     struct page *page, void *fsdata)
+static size_t ext4_da_write_end(struct file *file,
+		struct address_space *mapping, loff_t pos, size_t len,
+		size_t copied, struct folio *folio, void **fsdata)
 {
 	struct inode *inode = mapping->host;
-	int write_mode = (int)(unsigned long)fsdata;
-	struct folio *folio = page_folio(page);
-
-	if (write_mode == FALL_BACK_TO_NONDELALLOC)
-		return ext4_write_end(file, mapping, pos,
-				      len, copied, &folio->page, fsdata);
 
 	trace_ext4_da_write_end(inode, pos, len, copied);
 
-	if (write_mode != CONVERT_INLINE_DATA &&
-	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
+	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
 	    ext4_has_inline_data(inode))
 		return ext4_write_inline_data_end(inode, pos, len, copied,
 						  folio);
@@ -3521,8 +3494,6 @@ static const struct address_space_operations ext4_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
 	.writepages		= ext4_writepages,
-	.write_begin		= ext4_write_begin,
-	.write_end		= ext4_write_end,
 	.dirty_folio		= ext4_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
@@ -3537,8 +3508,6 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
 	.writepages		= ext4_writepages,
-	.write_begin		= ext4_write_begin,
-	.write_end		= ext4_journalled_write_end,
 	.dirty_folio		= ext4_journalled_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_journalled_invalidate_folio,
@@ -3553,8 +3522,6 @@ static const struct address_space_operations ext4_da_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
 	.writepages		= ext4_writepages,
-	.write_begin		= ext4_da_write_begin,
-	.write_end		= ext4_da_write_end,
 	.dirty_folio		= ext4_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
@@ -3572,6 +3539,21 @@ static const struct address_space_operations ext4_dax_aops = {
 	.swap_activate		= ext4_iomap_swap_activate,
 };
 
+const struct buffered_write_operations ext4_bw_ops = {
+	.write_begin		= ext4_write_begin,
+	.write_end		= ext4_write_end,
+};
+
+const struct buffered_write_operations ext4_journalled_bw_ops = {
+	.write_begin		= ext4_write_begin,
+	.write_end		= ext4_journalled_write_end,
+};
+
+const struct buffered_write_operations ext4_da_bw_ops = {
+	.write_begin		= ext4_da_write_begin,
+	.write_end		= ext4_da_write_end,
+};
+
 void ext4_set_aops(struct inode *inode)
 {
 	switch (ext4_inode_journal_mode(inode)) {
-- 
2.43.0


