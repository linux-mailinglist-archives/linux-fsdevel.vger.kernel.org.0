Return-Path: <linux-fsdevel+bounces-23861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED55933FFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB241F25D6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1761181B99;
	Wed, 17 Jul 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OSNByeKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A171822F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231247; cv=none; b=i8/9VBhB6UOPosX/fL7nLijB9oao2pwGL0GjtwODj+m1RD8h260ZaxQTETKyX+kufGSK54wjr0wuiBy6+Frrs8/K2VfbvpL+ibO1RL5loOeTb8EGxbvECliYvPkcVQP8c6AdOH6TmJi4B5Qfmsu4t1EM2v5RsSUKamZu2r/oRkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231247; c=relaxed/simple;
	bh=9/IVL1ZEjhaZP4aexG8iTSPlzxFGMnmVYL5oowVhdrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk2CSs1uTtYbsAS8lMxwojy0AWaYM/646kmJ8fT7mC56CRsj9pw1J5JvKQAIoUJ2rNdDIVEGvUBRTpiaOgDtfVdhbhnZklL8L/iJOeYGXHJmpJ5Wyp7CLUt5ddH109CEUAvi1mp24TqjPyLHxu1qzUIpg7o7+171NGPsLQx/CJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OSNByeKN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0LtFKFX2z3trbnN0Dpcyl/Ni0q8kqhOFNgKICa0CMi0=; b=OSNByeKN32aiang+Fn242IJRGn
	cQMT9N+v5Iw9sAT7M5nvdF8VHWyMdj35SaD6gmL0Jb51Z5UVUn0kCMcWYr7/3brGY+isMuJVG6cGc
	4Z3DT1yurqtcNAQQVtm7hQDFcIbrc4HlwIJnt6yrlR38DEZ1S8jbO+R/RLLhbZVg0dLOlPtxxaCwq
	5Er75BP8v7YyppY0xdRlvU83sHQ8GT4SHrvlotK3hUwc0EGih/zNVyFtJdwFo0qbQWX3BhC/1qiS7
	UwcEZTNqVVFLVW5bB9SLmL88HzWdcCOw6RasrUTAVezmgb9v5hv01pwjEgR0yRjyMA8Jsc/qscPhs
	LNI6CDkg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sE-00000000zw4-3xgu;
	Wed, 17 Jul 2024 15:47:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 23/23] buffer: Convert __block_write_begin() to take a folio
Date: Wed, 17 Jul 2024 16:47:13 +0100
Message-ID: <20240717154716.237943-24-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Almost all callers have a folio now, so change __block_write_begin()
to take a folio and remove a call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 5 ++---
 fs/ext2/dir.c               | 2 +-
 fs/ext4/inline.c            | 6 +++---
 fs/ext4/inode.c             | 8 ++++----
 fs/minix/inode.c            | 2 +-
 fs/nilfs2/dir.c             | 2 +-
 fs/ocfs2/file.c             | 2 +-
 fs/reiserfs/inode.c         | 6 +++---
 fs/sysv/itree.c             | 2 +-
 fs/udf/file.c               | 2 +-
 fs/ufs/inode.c              | 2 +-
 include/linux/buffer_head.h | 2 +-
 12 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d52a740f7fca..45eb06cb1a4e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2168,11 +2168,10 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 	return err;
 }
 
-int __block_write_begin(struct page *page, loff_t pos, unsigned len,
+int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block)
 {
-	return __block_write_begin_int(page_folio(page), pos, len, get_block,
-				       NULL);
+	return __block_write_begin_int(folio, pos, len, get_block, NULL);
 }
 EXPORT_SYMBOL(__block_write_begin);
 
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 60605fbdd0eb..2f3042d0174c 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -434,7 +434,7 @@ int ext2_inode_by_name(struct inode *dir, const struct qstr *child, ino_t *ino)
 
 static int ext2_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
-	return __block_write_begin(&folio->page, pos, len, ext2_get_block);
+	return __block_write_begin(folio, pos, len, ext2_get_block);
 }
 
 static int ext2_handle_dirsync(struct inode *dir)
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index b7ea9cb4c398..d5c2f3b75084 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -601,10 +601,10 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		goto out;
 
 	if (ext4_should_dioread_nolock(inode)) {
-		ret = __block_write_begin(&folio->page, from, to,
+		ret = __block_write_begin(folio, from, to,
 					  ext4_get_block_unwritten);
 	} else
-		ret = __block_write_begin(&folio->page, from, to, ext4_get_block);
+		ret = __block_write_begin(folio, from, to, ext4_get_block);
 
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
@@ -856,7 +856,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 			goto out;
 	}
 
-	ret = __block_write_begin(&folio->page, 0, inline_size,
+	ret = __block_write_begin(folio, 0, inline_size,
 				  ext4_da_get_block_prep);
 	if (ret) {
 		up_read(&EXT4_I(inode)->xattr_sem);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 90ef8ec5c59b..03374dc215d1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1224,10 +1224,10 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		ret = ext4_block_write_begin(folio, pos, len, ext4_get_block);
 #else
 	if (ext4_should_dioread_nolock(inode))
-		ret = __block_write_begin(&folio->page, pos, len,
+		ret = __block_write_begin(folio, pos, len,
 					  ext4_get_block_unwritten);
 	else
-		ret = __block_write_begin(&folio->page, pos, len, ext4_get_block);
+		ret = __block_write_begin(folio, pos, len, ext4_get_block);
 #endif
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
@@ -2962,7 +2962,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 #ifdef CONFIG_FS_ENCRYPTION
 	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
 #else
-	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
+	ret = __block_write_begin(folio, pos, len, ext4_da_get_block_prep);
 #endif
 	if (ret < 0) {
 		folio_unlock(folio);
@@ -6216,7 +6216,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		if (folio_pos(folio) + len > size)
 			len = size - folio_pos(folio);
 
-		err = __block_write_begin(&folio->page, 0, len, ext4_get_block);
+		err = __block_write_begin(folio, 0, len, ext4_get_block);
 		if (!err) {
 			ret = VM_FAULT_SIGBUS;
 			if (ext4_journal_folio_buffers(handle, folio, len))
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index abb190c46c04..f007e389d5d2 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -429,7 +429,7 @@ static int minix_read_folio(struct file *file, struct folio *folio)
 
 int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
-	return __block_write_begin(&folio->page, pos, len, minix_get_block);
+	return __block_write_begin(folio, pos, len, minix_get_block);
 }
 
 static void minix_write_failed(struct address_space *mapping, loff_t to)
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 66af42f88ca7..4b3e19d74925 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -83,7 +83,7 @@ static int nilfs_prepare_chunk(struct folio *folio, unsigned int from,
 {
 	loff_t pos = folio_pos(folio) + from;
 
-	return __block_write_begin(&folio->page, pos, to - from, nilfs_get_block);
+	return __block_write_begin(folio, pos, to - from, nilfs_get_block);
 }
 
 static void nilfs_commit_chunk(struct folio *folio,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index cfec1782ac2a..d058eb30cfc2 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -804,7 +804,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 		 * __block_write_begin and block_commit_write to zero the
 		 * whole block.
 		 */
-		ret = __block_write_begin(&folio->page, block_start + 1, 0,
+		ret = __block_write_begin(folio, block_start + 1, 0,
 					  ocfs2_get_block);
 		if (ret < 0) {
 			mlog_errno(ret);
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index ea23872ba24f..72c53129c952 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2198,7 +2198,7 @@ static int grab_tail_page(struct inode *inode,
 	/* start within the page of the last block in the file */
 	start = (offset / blocksize) * blocksize;
 
-	error = __block_write_begin(&folio->page, start, offset - start,
+	error = __block_write_begin(folio, start, offset - start,
 				    reiserfs_get_block_create_0);
 	if (error)
 		goto unlock;
@@ -2762,7 +2762,7 @@ static int reiserfs_write_begin(struct file *file,
 		old_ref = th->t_refcount;
 		th->t_refcount++;
 	}
-	ret = __block_write_begin(&folio->page, pos, len, reiserfs_get_block);
+	ret = __block_write_begin(folio, pos, len, reiserfs_get_block);
 	if (ret && reiserfs_transaction_running(inode->i_sb)) {
 		struct reiserfs_transaction_handle *th = current->journal_info;
 		/*
@@ -2822,7 +2822,7 @@ int __reiserfs_write_begin(struct page *page, unsigned from, unsigned len)
 		th->t_refcount++;
 	}
 
-	ret = __block_write_begin(page, from, len, reiserfs_get_block);
+	ret = __block_write_begin(page_folio(page), from, len, reiserfs_get_block);
 	if (ret && reiserfs_transaction_running(inode->i_sb)) {
 		struct reiserfs_transaction_handle *th = current->journal_info;
 		/*
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 8864438817a6..451e95f474fa 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -468,7 +468,7 @@ static int sysv_read_folio(struct file *file, struct folio *folio)
 
 int sysv_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
-	return __block_write_begin(&folio->page, pos, len, get_block);
+	return __block_write_begin(folio, pos, len, get_block);
 }
 
 static void sysv_write_failed(struct address_space *mapping, loff_t to)
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 3a4179de316b..412fe7c4d348 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -62,7 +62,7 @@ static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
 		end = size & ~PAGE_MASK;
 	else
 		end = PAGE_SIZE;
-	err = __block_write_begin(&folio->page, 0, end, udf_get_block);
+	err = __block_write_begin(folio, 0, end, udf_get_block);
 	if (err) {
 		folio_unlock(folio);
 		ret = vmf_fs_error(err);
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index f43461652d9f..5331ae7ebf3e 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -481,7 +481,7 @@ static int ufs_read_folio(struct file *file, struct folio *folio)
 
 int ufs_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
-	return __block_write_begin(&folio->page, pos, len, ufs_getfrag_block);
+	return __block_write_begin(folio, pos, len, ufs_getfrag_block);
 }
 
 static void ufs_truncate_blocks(struct inode *);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 254563a2a9de..c85e65fd4cdc 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -259,7 +259,7 @@ int block_read_full_folio(struct folio *, get_block_t *);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 		struct folio **foliop, get_block_t *get_block);
-int __block_write_begin(struct page *page, loff_t pos, unsigned len,
+int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block);
 int block_write_end(struct file *, struct address_space *,
 				loff_t, unsigned len, unsigned copied,
-- 
2.43.0


