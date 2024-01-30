Return-Path: <linux-fsdevel+bounces-9491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F105841B96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 06:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFD61F23C4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 05:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738D381BD;
	Tue, 30 Jan 2024 05:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CuR47Eo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532FD381B4;
	Tue, 30 Jan 2024 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594060; cv=none; b=FbxRCEDboURYNTXp8zROS8Y/xyRy0/scema71JBEQReBNUZ7t31M9veg7RnJYJnUv7FPo62Fu8xDIn8SHJ1lHnOvr9x8+7qhjP8PprZq3Tsk4oy8ZI8XVdjfwkEjpuVj8bjs7/86UmUb4eKv9/iOu8HnddjL/NjmXufPnNhQ2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594060; c=relaxed/simple;
	bh=c0fD+MAYXNAXa5oNaXtYEsoBD240F+BZn6nT/koVWEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUT5JwsNXpvLpSrSUcWF2ql/2TAClU35WAizUDh+QNF3eNMBhgcxTZfP53aF6X2/RqseLwwWOP45ydR/rtuO39GaFdUEdulYSlfRI9Dm1se+7lz97Q1ed9kZnQ4W3DunsIQZIPd7TNvPd8Fkq6Tn7DHes1YQ1vbR29ZhcYAnlko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CuR47Eo2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=V7/IQmodZEVVOURk79W2QOsKgj01svX706ULbJwppUc=; b=CuR47Eo2LLxYsdZaF02nqwACcc
	7hjWROyRhzcYaJKKZND9rB/m6cxLGcqzO7nG9rBJBqrVClJRvbG7fu2WYpdi/pTsg2vBFsykXv+sf
	kz6pjrAg5W3yhSDCsj7bkv556m1oHlQua+NNhV1YMCe5rr4bmMkUipCSsMFpeuG/2ELGn1rJUEggL
	CgPJRAuSgQLd9SIHq+TsE2K3Y+o/wf5/pfAI4n7MpdN1xtmyhBpRi4e1mySBdKw3NaYjyGhcLEoXN
	Q8ruV52v5SoUD+w8rbEZBK2C0VlmfhtTYIpVj+ifWPqi0q7aLFafSyy77nqU0wZowDSGb3RGCERXL
	IH6EMzTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUh4a-00000008zkn-1MYY;
	Tue, 30 Jan 2024 05:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 3/3] ext4: Convert to buffered_write_operations
Date: Tue, 30 Jan 2024 05:54:13 +0000
Message-ID: <20240130055414.2143959-4-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130055414.2143959-1-willy@infradead.org>
References: <20240130055414.2143959-1-willy@infradead.org>
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
 fs/ext4/ext4.h   |  8 ++++--
 fs/ext4/file.c   | 10 ++++++-
 fs/ext4/inline.c | 15 ++++------
 fs/ext4/inode.c  | 73 ++++++++++++++++++++++++------------------------
 4 files changed, 58 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a5d784872303..3491d5c279c7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3021,6 +3021,10 @@ extern void ext4_da_update_reserve_space(struct inode *inode,
 extern int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk,
 			      ext4_fsblk_t pblk, ext4_lblk_t len);
 
+extern const struct buffered_write_operations ext4_bw_ops;
+extern const struct buffered_write_operations ext4_journalled_bw_ops;
+extern const struct buffered_write_operations ext4_da_bw_ops;
+
 /* indirect.c */
 extern int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 				struct ext4_map_blocks *map, int flags);
@@ -3549,13 +3553,13 @@ int ext4_readpage_inline(struct inode *inode, struct folio *folio);
 extern int ext4_try_to_write_inline_data(struct address_space *mapping,
 					 struct inode *inode,
 					 loff_t pos, unsigned len,
-					 struct page **pagep);
+					 struct folio **foliop);
 int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 			       unsigned copied, struct folio *folio);
 extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
 					   struct inode *inode,
 					   loff_t pos, unsigned len,
-					   struct page **pagep,
+					   struct folio **foliop,
 					   void **fsdata);
 extern int ext4_try_add_inline_entry(handle_t *handle,
 				     struct ext4_filename *fname,
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6aa15dafc677..1bca5f47cb5f 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -287,16 +287,24 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 {
 	ssize_t ret;
 	struct inode *inode = file_inode(iocb->ki_filp);
+	const struct buffered_write_operations *ops;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
+	if (ext4_inode_journal_mode(inode))
+		ops = &ext4_journalled_bw_ops;
+	else if (test_opt(inode->i_sb, DELALLOC))
+		ops = &ext4_da_bw_ops;
+	else
+		ops = &ext4_bw_ops;
+
 	inode_lock(inode);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
 
-	ret = generic_perform_write(iocb, from);
+	ret = filemap_perform_write(iocb, from, ops);
 
 out:
 	inode_unlock(inode);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d5bd1e3a5d36..0d3fc5c14ad5 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -658,9 +658,8 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
  * to the page make it update and let the later codes create extent for it.
  */
 int ext4_try_to_write_inline_data(struct address_space *mapping,
-				  struct inode *inode,
-				  loff_t pos, unsigned len,
-				  struct page **pagep)
+		struct inode *inode, loff_t pos, unsigned len,
+		struct folio **foliop)
 {
 	int ret;
 	handle_t *handle;
@@ -708,7 +707,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		goto out;
 	}
 
-	*pagep = &folio->page;
+	*foliop = folio;
 	down_read(&EXT4_I(inode)->xattr_sem);
 	if (!ext4_has_inline_data(inode)) {
 		ret = 0;
@@ -889,10 +888,8 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
  * normal ext4_da_write_end).
  */
 int ext4_da_write_inline_data_begin(struct address_space *mapping,
-				    struct inode *inode,
-				    loff_t pos, unsigned len,
-				    struct page **pagep,
-				    void **fsdata)
+		struct inode *inode, loff_t pos, unsigned len,
+		struct folio **foliop, void **fsdata)
 {
 	int ret;
 	handle_t *handle;
@@ -954,7 +951,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out_release_page;
 
 	up_read(&EXT4_I(inode)->xattr_sem);
-	*pagep = &folio->page;
+	*foliop = folio;
 	brelse(iloc.bh);
 	return 1;
 out_release_page:
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5af1b0b8680e..4f532870c388 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1113,8 +1113,7 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
  * ext4_write_begin() is the right place.
  */
 static int ext4_write_begin(struct file *file, struct address_space *mapping,
-			    loff_t pos, unsigned len,
-			    struct page **pagep, void **fsdata)
+		loff_t pos, size_t len, struct folio **foliop, void **fsdata)
 {
 	struct inode *inode = mapping->host;
 	int ret, needed_blocks;
@@ -1139,7 +1138,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		ret = ext4_try_to_write_inline_data(mapping, inode, pos, len,
-						    pagep);
+						    foliop);
 		if (ret < 0)
 			return ret;
 		if (ret == 1)
@@ -1239,7 +1238,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		folio_put(folio);
 		return ret;
 	}
-	*pagep = &folio->page;
+	*foliop = folio;
 	return ret;
 }
 
@@ -1264,12 +1263,10 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
  * ext4 never places buffers on inode->i_mapping->i_private_list.  metadata
  * buffers are managed internally.
  */
-static int ext4_write_end(struct file *file,
-			  struct address_space *mapping,
-			  loff_t pos, unsigned len, unsigned copied,
-			  struct page *page, void *fsdata)
+static int ext4_write_end(struct file *file, struct address_space *mapping,
+		loff_t pos, size_t len, size_t copied, struct folio *folio,
+		void **fsdata)
 {
-	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -1284,7 +1281,7 @@ static int ext4_write_end(struct file *file,
 		return ext4_write_inline_data_end(inode, pos, len, copied,
 						  folio);
 
-	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
+	copied = block_write_end(file, mapping, pos, len, copied, &folio->page, *fsdata);
 	/*
 	 * it's important to update i_size while still holding folio lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
@@ -1369,11 +1366,9 @@ static void ext4_journalled_zero_new_buffers(handle_t *handle,
 }
 
 static int ext4_journalled_write_end(struct file *file,
-				     struct address_space *mapping,
-				     loff_t pos, unsigned len, unsigned copied,
-				     struct page *page, void *fsdata)
+		struct address_space *mapping, loff_t pos, size_t len,
+		size_t copied, struct folio *folio, void **fsdata)
 {
-	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -2856,9 +2851,9 @@ static int ext4_nonda_switch(struct super_block *sb)
 	return 0;
 }
 
-static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
-			       loff_t pos, unsigned len,
-			       struct page **pagep, void **fsdata)
+static int ext4_da_write_begin(struct file *file,
+		struct address_space *mapping, loff_t pos, size_t len,
+		struct folio **foliop, void **fsdata)
 {
 	int ret, retries = 0;
 	struct folio *folio;
@@ -2873,14 +2868,14 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	if (ext4_nonda_switch(inode->i_sb) || ext4_verity_in_progress(inode)) {
 		*fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
 		return ext4_write_begin(file, mapping, pos,
-					len, pagep, fsdata);
+					len, foliop, fsdata);
 	}
 	*fsdata = (void *)0;
 	trace_ext4_da_write_begin(inode, pos, len);
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		ret = ext4_da_write_inline_data_begin(mapping, inode, pos, len,
-						      pagep, fsdata);
+						      foliop, fsdata);
 		if (ret < 0)
 			return ret;
 		if (ret == 1)
@@ -2918,7 +2913,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 		return ret;
 	}
 
-	*pagep = &folio->page;
+	*foliop = folio;
 	return ret;
 }
 
@@ -2945,9 +2940,8 @@ static int ext4_da_should_update_i_disksize(struct folio *folio,
 	return 1;
 }
 
-static int ext4_da_do_write_end(struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct folio *folio)
+static int ext4_da_do_write_end(struct address_space *mapping, loff_t pos,
+		size_t len, size_t copied, struct folio *folio)
 {
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -3007,18 +3001,16 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	return copied;
 }
 
-static int ext4_da_write_end(struct file *file,
-			     struct address_space *mapping,
-			     loff_t pos, unsigned len, unsigned copied,
-			     struct page *page, void *fsdata)
+static int ext4_da_write_end(struct file *file, struct address_space *mapping,
+		loff_t pos, size_t len, size_t copied, struct folio *folio,
+		void **fsdata)
 {
 	struct inode *inode = mapping->host;
-	int write_mode = (int)(unsigned long)fsdata;
-	struct folio *folio = page_folio(page);
+	int write_mode = (int)(unsigned long)*fsdata;
 
 	if (write_mode == FALL_BACK_TO_NONDELALLOC)
 		return ext4_write_end(file, mapping, pos,
-				      len, copied, &folio->page, fsdata);
+				      len, copied, folio, fsdata);
 
 	trace_ext4_da_write_end(inode, pos, len, copied);
 
@@ -3556,8 +3548,6 @@ static const struct address_space_operations ext4_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
 	.writepages		= ext4_writepages,
-	.write_begin		= ext4_write_begin,
-	.write_end		= ext4_write_end,
 	.dirty_folio		= ext4_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
@@ -3573,8 +3563,6 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
 	.writepages		= ext4_writepages,
-	.write_begin		= ext4_write_begin,
-	.write_end		= ext4_journalled_write_end,
 	.dirty_folio		= ext4_journalled_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_journalled_invalidate_folio,
@@ -3590,8 +3578,6 @@ static const struct address_space_operations ext4_da_aops = {
 	.read_folio		= ext4_read_folio,
 	.readahead		= ext4_readahead,
 	.writepages		= ext4_writepages,
-	.write_begin		= ext4_da_write_begin,
-	.write_end		= ext4_da_write_end,
 	.dirty_folio		= ext4_dirty_folio,
 	.bmap			= ext4_bmap,
 	.invalidate_folio	= ext4_invalidate_folio,
@@ -3611,6 +3597,21 @@ static const struct address_space_operations ext4_dax_aops = {
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


