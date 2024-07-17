Return-Path: <linux-fsdevel+bounces-23862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EE0933FFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D5E1F25E20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A7184106;
	Wed, 17 Jul 2024 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G91BZvLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62599181325
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231248; cv=none; b=c2Rxji7/jWA64WEUwGaBJ0/tuuTrSa9l8ov20XfUzuO47CzdfvHc1+91EtL9jfH0ZFoc7lW3RFQ+9lBr6WGrmMfTsi7SKNIupFLj/QM3RPQFgBesODKOrRfYfzkb4os80D7b/vdkLi/rVSJpgmnA1lLeVQf4qjsDg1Ecs7XqxtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231248; c=relaxed/simple;
	bh=onJM9ij9zPSvGc+LGsZODf9s38Tq8JsJaTJb4H0CSnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A43q55C2DA2UN4Cp/Lxb/bExg4UjkcRoXDB5c5sa9mG0H2QR8ta8JdISPplDpRF5fGJe+qJL6prh55GAVBKK2iiBNFBpgw3I++3Ud1gIEn8k5/vpXh5m+ZLawXDvTSSaaLkkZr4A6KjlUw/hsAW9HW6MH9Vc7aUfEm9bAoTJHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G91BZvLA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=T2oz96jt089hEM1ev80+AjIyr1d2gM8mChb992i2nsU=; b=G91BZvLAhyVWUqguVjnYL32CZe
	Gp+NuKEOHwoszMo20CagJyHeIzCu9Jr8r8x576Di5fg6ZEgbpk+PBavLepyQSxPpo19un6GJlsPsI
	w+EDqyoCI8xEt9BojgYbpPg19f2gfqhpP9a2aWTT7Ab/qOOgMepGExy6oovhZuDR9I5ga3yp8qdAD
	vZS46CdCMCe+JrRFDtB5dQ3ZpHEhkfdSt3WL80BgPH5kirABXGNeNy6iblGR+C/RPaGEId+/1uL2E
	YEG/xHbQE9USppLRIdclK/ElBOSp1L4BU71cD93aExCDNIVlnXfHG7Nn61UUnQKpK2dnuGrY2QwEH
	E6ABaGAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sE-00000000zvu-2lnx;
	Wed, 17 Jul 2024 15:47:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 21/23] fs: Convert aops->write_begin to take a folio
Date: Wed, 17 Jul 2024 16:47:11 +0100
Message-ID: <20240717154716.237943-22-willy@infradead.org>
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

Convert all callers from working on a page to working on one page
of a folio (support for working on an entire folio can come later).
Removes a lot of folio->page->folio conversions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst     |  4 +-
 Documentation/filesystems/vfs.rst         |  6 +--
 block/fops.c                              |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 47 +++++++++++------------
 fs/adfs/inode.c                           |  5 +--
 fs/affs/file.c                            | 15 ++++----
 fs/bcachefs/fs-io-buffered.c              |  5 +--
 fs/bcachefs/fs-io-buffered.h              |  4 +-
 fs/bfs/file.c                             |  4 +-
 fs/buffer.c                               | 28 +++++++-------
 fs/ceph/addr.c                            | 10 ++---
 fs/ecryptfs/mmap.c                        |  7 ++--
 fs/exfat/file.c                           |  8 ++--
 fs/exfat/inode.c                          |  5 +--
 fs/ext2/inode.c                           |  4 +-
 fs/ext4/ext4.h                            |  4 +-
 fs/ext4/inline.c                          |  8 ++--
 fs/ext4/inode.c                           | 14 +++----
 fs/ext4/verity.c                          |  8 ++--
 fs/f2fs/data.c                            |  8 ++--
 fs/f2fs/super.c                           |  8 ++--
 fs/f2fs/verity.c                          |  8 ++--
 fs/fat/inode.c                            |  5 +--
 fs/fuse/file.c                            |  4 +-
 fs/hfs/extent.c                           |  6 +--
 fs/hfs/hfs_fs.h                           |  2 +-
 fs/hfs/inode.c                            |  5 +--
 fs/hfsplus/extents.c                      |  6 +--
 fs/hfsplus/hfsplus_fs.h                   |  2 +-
 fs/hfsplus/inode.c                        |  5 +--
 fs/hostfs/hostfs_kern.c                   |  7 ++--
 fs/hpfs/file.c                            |  5 +--
 fs/hugetlbfs/inode.c                      |  2 +-
 fs/jffs2/file.c                           |  6 +--
 fs/jfs/inode.c                            |  4 +-
 fs/libfs.c                                |  4 +-
 fs/minix/inode.c                          |  4 +-
 fs/namei.c                                | 10 ++---
 fs/nfs/file.c                             |  4 +-
 fs/nilfs2/inode.c                         |  4 +-
 fs/nilfs2/recovery.c                      |  6 +--
 fs/ntfs3/file.c                           |  9 ++---
 fs/ntfs3/inode.c                          |  7 ++--
 fs/ntfs3/ntfs_fs.h                        |  2 +-
 fs/ocfs2/aops.c                           | 10 ++---
 fs/ocfs2/aops.h                           |  2 +-
 fs/ocfs2/mmap.c                           |  6 +--
 fs/omfs/file.c                            |  4 +-
 fs/orangefs/inode.c                       |  4 +-
 fs/reiserfs/inode.c                       |  4 +-
 fs/sysv/itree.c                           |  4 +-
 fs/ubifs/file.c                           | 10 ++---
 fs/udf/inode.c                            |  6 +--
 fs/ufs/inode.c                            |  4 +-
 include/linux/buffer_head.h               |  4 +-
 include/linux/fs.h                        |  4 +-
 mm/filemap.c                              |  4 +-
 mm/shmem.c                                |  7 ++--
 58 files changed, 189 insertions(+), 207 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 827fb5a073b7..f5e3676db954 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -251,7 +251,7 @@ prototypes::
 	void (*readahead)(struct readahead_control *);
 	int (*write_begin)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len,
-				struct page **pagep, void **fsdata);
+				struct folio **foliop, void **fsdata);
 	int (*write_end)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
 				struct folio *folio, void *fsdata);
@@ -280,7 +280,7 @@ read_folio:		yes, unlocks				shared
 writepages:
 dirty_folio:		maybe
 readahead:		yes, unlocks				shared
-write_begin:		locks the page		 exclusive
+write_begin:		locks the folio		 exclusive
 write_end:		yes, unlocks		 exclusive
 bmap:
 invalidate_folio:	yes					exclusive
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 0e24f770c568..4f67b5ea0568 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -926,12 +926,12 @@ cache in your filesystem.  The following members are defined:
 	(if they haven't been read already) so that the updated blocks
 	can be written out properly.
 
-	The filesystem must return the locked pagecache page for the
-	specified offset, in ``*pagep``, for the caller to write into.
+	The filesystem must return the locked pagecache folio for the
+	specified offset, in ``*foliop``, for the caller to write into.
 
 	It must be able to cope with short writes (where the length
 	passed to write_begin is greater than the number of bytes copied
-	into the page).
+	into the folio).
 
 	A void * may be returned in fsdata, which then gets passed into
 	write_end.
diff --git a/block/fops.c b/block/fops.c
index cd96a6f17119..dacbd61fda29 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -451,9 +451,9 @@ static void blkdev_readahead(struct readahead_control *rac)
 }
 
 static int blkdev_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
+		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
 {
-	return block_write_begin(mapping, pos, len, pagep, blkdev_get_block);
+	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
 }
 
 static int blkdev_write_end(struct file *file, struct address_space *mapping,
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 3513165a2964..fe69f2c8527d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -424,7 +424,8 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 	struct address_space *mapping = obj->base.filp->f_mapping;
 	const struct address_space_operations *aops = mapping->a_ops;
 	char __user *user_data = u64_to_user_ptr(arg->data_ptr);
-	u64 remain, offset;
+	u64 remain;
+	loff_t pos;
 	unsigned int pg;
 
 	/* Caller already validated user args */
@@ -457,12 +458,12 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 	 */
 
 	remain = arg->size;
-	offset = arg->offset;
-	pg = offset_in_page(offset);
+	pos = arg->offset;
+	pg = offset_in_page(pos);
 
 	do {
 		unsigned int len, unwritten;
-		struct page *page;
+		struct folio *folio;
 		void *data, *vaddr;
 		int err;
 		char __maybe_unused c;
@@ -480,21 +481,19 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 		if (err)
 			return err;
 
-		err = aops->write_begin(obj->base.filp, mapping, offset, len,
-					&page, &data);
+		err = aops->write_begin(obj->base.filp, mapping, pos, len,
+					&folio, &data);
 		if (err < 0)
 			return err;
 
-		vaddr = kmap_local_page(page);
+		vaddr = kmap_local_folio(folio, offset_in_folio(folio, pos));
 		pagefault_disable();
-		unwritten = __copy_from_user_inatomic(vaddr + pg,
-						      user_data,
-						      len);
+		unwritten = __copy_from_user_inatomic(vaddr, user_data, len);
 		pagefault_enable();
 		kunmap_local(vaddr);
 
-		err = aops->write_end(obj->base.filp, mapping, offset, len,
-				      len - unwritten, page_folio(page), data);
+		err = aops->write_end(obj->base.filp, mapping, pos, len,
+				      len - unwritten, folio, data);
 		if (err < 0)
 			return err;
 
@@ -504,7 +503,7 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 
 		remain -= len;
 		user_data += len;
-		offset += len;
+		pos += len;
 		pg = 0;
 	} while (remain);
 
@@ -660,7 +659,7 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
 	struct drm_i915_gem_object *obj;
 	struct file *file;
 	const struct address_space_operations *aops;
-	resource_size_t offset;
+	loff_t pos;
 	int err;
 
 	GEM_WARN_ON(IS_DGFX(i915));
@@ -672,29 +671,27 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
 
 	file = obj->base.filp;
 	aops = file->f_mapping->a_ops;
-	offset = 0;
+	pos = 0;
 	do {
 		unsigned int len = min_t(typeof(size), size, PAGE_SIZE);
-		struct page *page;
-		void *pgdata, *vaddr;
+		struct folio *folio;
+		void *fsdata;
 
-		err = aops->write_begin(file, file->f_mapping, offset, len,
-					&page, &pgdata);
+		err = aops->write_begin(file, file->f_mapping, pos, len,
+					&folio, &fsdata);
 		if (err < 0)
 			goto fail;
 
-		vaddr = kmap(page);
-		memcpy(vaddr, data, len);
-		kunmap(page);
+		memcpy_to_folio(folio, offset_in_folio(folio, pos), data, len);
 
-		err = aops->write_end(file, file->f_mapping, offset, len, len,
-				      page_folio(page), pgdata);
+		err = aops->write_end(file, file->f_mapping, pos, len, len,
+				      folio, fsdata);
 		if (err < 0)
 			goto fail;
 
 		size -= len;
 		data += len;
-		offset += len;
+		pos += len;
 	} while (size);
 
 	return obj;
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index a183e213a4a5..21527189e430 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -55,12 +55,11 @@ static void adfs_write_failed(struct address_space *mapping, loff_t to)
 
 static int adfs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, foliop, fsdata,
 				adfs_get_block,
 				&ADFS_I(mapping->host)->mmu_private);
 	if (unlikely(ret))
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 6a6c5bc41b8f..a5a861dd5223 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -417,12 +417,11 @@ affs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static int affs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, foliop, fsdata,
 				affs_get_block,
 				&AFFS_I(mapping->host)->mmu_private);
 	if (unlikely(ret))
@@ -648,7 +647,7 @@ static int affs_read_folio_ofs(struct file *file, struct folio *folio)
 
 static int affs_write_begin_ofs(struct file *file, struct address_space *mapping,
 				loff_t pos, unsigned len,
-				struct page **pagep, void **fsdata)
+				struct folio **foliop, void **fsdata)
 {
 	struct inode *inode = mapping->host;
 	struct folio *folio;
@@ -671,7 +670,7 @@ static int affs_write_begin_ofs(struct file *file, struct address_space *mapping
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	*pagep = &folio->page;
+	*foliop = folio;
 
 	if (folio_test_uptodate(folio))
 		return 0;
@@ -881,14 +880,14 @@ affs_truncate(struct inode *inode)
 
 	if (inode->i_size > AFFS_I(inode)->mmu_private) {
 		struct address_space *mapping = inode->i_mapping;
-		struct page *page;
+		struct folio *folio;
 		void *fsdata = NULL;
 		loff_t isize = inode->i_size;
 		int res;
 
-		res = mapping->a_ops->write_begin(NULL, mapping, isize, 0, &page, &fsdata);
+		res = mapping->a_ops->write_begin(NULL, mapping, isize, 0, &folio, &fsdata);
 		if (!res)
-			res = mapping->a_ops->write_end(NULL, mapping, isize, 0, 0, page_folio(page), fsdata);
+			res = mapping->a_ops->write_end(NULL, mapping, isize, 0, 0, folio, fsdata);
 		else
 			inode->i_size = AFFS_I(inode)->mmu_private;
 		mark_inode_dirty(inode);
diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index 46ae9ef3589a..3d410d801825 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -659,7 +659,7 @@ int bch2_writepages(struct address_space *mapping, struct writeback_control *wbc
 
 int bch2_write_begin(struct file *file, struct address_space *mapping,
 		     loff_t pos, unsigned len,
-		     struct page **pagep, void **fsdata)
+		     struct folio **foliop, void **fsdata)
 {
 	struct bch_inode_info *inode = to_bch_ei(mapping->host);
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
@@ -728,12 +728,11 @@ int bch2_write_begin(struct file *file, struct address_space *mapping,
 		goto err;
 	}
 
-	*pagep = &folio->page;
+	*foliop = folio;
 	return 0;
 err:
 	folio_unlock(folio);
 	folio_put(folio);
-	*pagep = NULL;
 err_unlock:
 	bch2_pagecache_add_put(inode);
 	kfree(res);
diff --git a/fs/bcachefs/fs-io-buffered.h b/fs/bcachefs/fs-io-buffered.h
index 16569b9874e0..3207ebbb4ab4 100644
--- a/fs/bcachefs/fs-io-buffered.h
+++ b/fs/bcachefs/fs-io-buffered.h
@@ -10,8 +10,8 @@ int bch2_read_folio(struct file *, struct folio *);
 int bch2_writepages(struct address_space *, struct writeback_control *);
 void bch2_readahead(struct readahead_control *);
 
-int bch2_write_begin(struct file *, struct address_space *, loff_t,
-		     unsigned, struct page **, void **);
+int bch2_write_begin(struct file *, struct address_space *, loff_t pos,
+		     unsigned len, struct folio **, void **);
 int bch2_write_end(struct file *, struct address_space *, loff_t,
 		   unsigned len, unsigned copied, struct folio *, void *);
 
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index a778411574a9..fa66a09e496a 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -172,11 +172,11 @@ static void bfs_write_failed(struct address_space *mapping, loff_t to)
 
 static int bfs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, pagep, bfs_get_block);
+	ret = block_write_begin(mapping, pos, len, foliop, bfs_get_block);
 	if (unlikely(ret))
 		bfs_write_failed(mapping, pos + len);
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 1a0f2f65e890..d52a740f7fca 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2222,7 +2222,7 @@ static void __block_commit_write(struct folio *folio, size_t from, size_t to)
  * The filesystem needs to handle block truncation upon failure.
  */
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
-		struct page **pagep, get_block_t *get_block)
+		struct folio **foliop, get_block_t *get_block)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct folio *folio;
@@ -2240,7 +2240,7 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 		folio = NULL;
 	}
 
-	*pagep = &folio->page;
+	*foliop = folio;
 	return status;
 }
 EXPORT_SYMBOL(block_write_begin);
@@ -2467,7 +2467,7 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 {
 	struct address_space *mapping = inode->i_mapping;
 	const struct address_space_operations *aops = mapping->a_ops;
-	struct page *page;
+	struct folio *folio;
 	void *fsdata = NULL;
 	int err;
 
@@ -2475,11 +2475,11 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 	if (err)
 		goto out;
 
-	err = aops->write_begin(NULL, mapping, size, 0, &page, &fsdata);
+	err = aops->write_begin(NULL, mapping, size, 0, &folio, &fsdata);
 	if (err)
 		goto out;
 
-	err = aops->write_end(NULL, mapping, size, 0, 0, page_folio(page), fsdata);
+	err = aops->write_end(NULL, mapping, size, 0, 0, folio, fsdata);
 	BUG_ON(err > 0);
 
 out:
@@ -2493,7 +2493,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	const struct address_space_operations *aops = mapping->a_ops;
 	unsigned int blocksize = i_blocksize(inode);
-	struct page *page;
+	struct folio *folio;
 	void *fsdata = NULL;
 	pgoff_t index, curidx;
 	loff_t curpos;
@@ -2512,12 +2512,12 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		len = PAGE_SIZE - zerofrom;
 
 		err = aops->write_begin(file, mapping, curpos, len,
-					    &page, &fsdata);
+					    &folio, &fsdata);
 		if (err)
 			goto out;
-		zero_user(page, zerofrom, len);
+		folio_zero_range(folio, offset_in_folio(folio, curpos), len);
 		err = aops->write_end(file, mapping, curpos, len, len,
-						page_folio(page), fsdata);
+						folio, fsdata);
 		if (err < 0)
 			goto out;
 		BUG_ON(err != len);
@@ -2545,12 +2545,12 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		len = offset - zerofrom;
 
 		err = aops->write_begin(file, mapping, curpos, len,
-					    &page, &fsdata);
+					    &folio, &fsdata);
 		if (err)
 			goto out;
-		zero_user(page, zerofrom, len);
+		folio_zero_range(folio, offset_in_folio(folio, curpos), len);
 		err = aops->write_end(file, mapping, curpos, len, len,
-						page_folio(page), fsdata);
+						folio, fsdata);
 		if (err < 0)
 			goto out;
 		BUG_ON(err != len);
@@ -2566,7 +2566,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
  */
 int cont_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata,
+			struct folio **foliop, void **fsdata,
 			get_block_t *get_block, loff_t *bytes)
 {
 	struct inode *inode = mapping->host;
@@ -2584,7 +2584,7 @@ int cont_write_begin(struct file *file, struct address_space *mapping,
 		(*bytes)++;
 	}
 
-	return block_write_begin(mapping, pos, len, pagep, get_block);
+	return block_write_begin(mapping, pos, len, foliop, get_block);
 }
 EXPORT_SYMBOL(cont_write_begin);
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 87369e2659c7..4402cddf82b5 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1486,20 +1486,18 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
  */
 static int ceph_write_begin(struct file *file, struct address_space *mapping,
 			    loff_t pos, unsigned len,
-			    struct page **pagep, void **fsdata)
+			    struct folio **foliop, void **fsdata)
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct folio *folio = NULL;
 	int r;
 
-	r = netfs_write_begin(&ci->netfs, file, inode->i_mapping, pos, len, &folio, NULL);
+	r = netfs_write_begin(&ci->netfs, file, inode->i_mapping, pos, len, foliop, NULL);
 	if (r < 0)
 		return r;
 
-	folio_wait_private_2(folio); /* [DEPRECATED] */
-	WARN_ON_ONCE(!folio_test_locked(folio));
-	*pagep = &folio->page;
+	folio_wait_private_2(*foliop); /* [DEPRECATED] */
+	WARN_ON_ONCE(!folio_test_locked(*foliop));
 	return 0;
 }
 
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index f43e42ede75e..287e5d407f08 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -255,7 +255,7 @@ static int fill_zeros_to_end_of_page(struct folio *folio, unsigned int to)
  * @mapping: The eCryptfs object
  * @pos: The file offset at which to start writing
  * @len: Length of the write
- * @pagep: Pointer to return the page
+ * @foliop: Pointer to return the folio
  * @fsdata: Pointer to return fs data (unused)
  *
  * This function must zero any hole we create
@@ -265,7 +265,7 @@ static int fill_zeros_to_end_of_page(struct folio *folio, unsigned int to)
 static int ecryptfs_write_begin(struct file *file,
 			struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct folio *folio;
@@ -276,7 +276,7 @@ static int ecryptfs_write_begin(struct file *file,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	*pagep = &folio->page;
+	*foliop = folio;
 
 	prev_page_end_size = ((loff_t)index << PAGE_SHIFT);
 	if (!folio_test_uptodate(folio)) {
@@ -365,7 +365,6 @@ static int ecryptfs_write_begin(struct file *file,
 	if (unlikely(rc)) {
 		folio_unlock(folio);
 		folio_put(folio);
-		*pagep = NULL;
 	}
 	return rc;
 }
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 7144472d092e..e19469e88000 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -535,20 +535,20 @@ static int exfat_file_zeroed_range(struct file *file, loff_t start, loff_t end)
 
 	while (start < end) {
 		u32 zerofrom, len;
-		struct page *page = NULL;
+		struct folio *folio;
 
 		zerofrom = start & (PAGE_SIZE - 1);
 		len = PAGE_SIZE - zerofrom;
 		if (start + len > end)
 			len = end - start;
 
-		err = ops->write_begin(file, mapping, start, len, &page, NULL);
+		err = ops->write_begin(file, mapping, start, len, &folio, NULL);
 		if (err)
 			goto out;
 
-		zero_user_segment(page, zerofrom, zerofrom + len);
+		folio_zero_range(folio, offset_in_folio(folio, start), len);
 
-		err = ops->write_end(file, mapping, start, len, len, page_folio(page), NULL);
+		err = ops->write_end(file, mapping, start, len, len, folio, NULL);
 		if (err < 0)
 			goto out;
 		start += len;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 871e9e3e407e..05f0e07b01d0 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -448,12 +448,11 @@ static void exfat_write_failed(struct address_space *mapping, loff_t to)
 
 static int exfat_write_begin(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned int len,
-		struct page **pagep, void **fsdata)
+		struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	*pagep = NULL;
-	ret = block_write_begin(mapping, pos, len, pagep, exfat_get_block);
+	ret = block_write_begin(mapping, pos, len, foliop, exfat_get_block);
 
 	if (ret < 0)
 		exfat_write_failed(mapping, pos+len);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index aba41f6150e5..30f8201c155f 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -916,11 +916,11 @@ static void ext2_readahead(struct readahead_control *rac)
 
 static int
 ext2_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
+		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, pagep, ext2_get_block);
+	ret = block_write_begin(mapping, pos, len, foliop, ext2_get_block);
 	if (ret < 0)
 		ext2_write_failed(mapping, pos + len);
 	return ret;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08acd152261e..c3429b664b8d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3563,13 +3563,13 @@ int ext4_readpage_inline(struct inode *inode, struct folio *folio);
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
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e7a09a99837b..b7ea9cb4c398 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -660,7 +660,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 int ext4_try_to_write_inline_data(struct address_space *mapping,
 				  struct inode *inode,
 				  loff_t pos, unsigned len,
-				  struct page **pagep)
+				  struct folio **foliop)
 {
 	int ret;
 	handle_t *handle;
@@ -708,7 +708,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		goto out;
 	}
 
-	*pagep = &folio->page;
+	*foliop = folio;
 	down_read(&EXT4_I(inode)->xattr_sem);
 	if (!ext4_has_inline_data(inode)) {
 		ret = 0;
@@ -891,7 +891,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 int ext4_da_write_inline_data_begin(struct address_space *mapping,
 				    struct inode *inode,
 				    loff_t pos, unsigned len,
-				    struct page **pagep,
+				    struct folio **foliop,
 				    void **fsdata)
 {
 	int ret;
@@ -954,7 +954,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out_release_page;
 
 	up_read(&EXT4_I(inode)->xattr_sem);
-	*pagep = &folio->page;
+	*foliop = folio;
 	brelse(iloc.bh);
 	return 1;
 out_release_page:
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e19ac0a82bdc..90ef8ec5c59b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1145,7 +1145,7 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
  */
 static int ext4_write_begin(struct file *file, struct address_space *mapping,
 			    loff_t pos, unsigned len,
-			    struct page **pagep, void **fsdata)
+			    struct folio **foliop, void **fsdata)
 {
 	struct inode *inode = mapping->host;
 	int ret, needed_blocks;
@@ -1170,7 +1170,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		ret = ext4_try_to_write_inline_data(mapping, inode, pos, len,
-						    pagep);
+						    foliop);
 		if (ret < 0)
 			return ret;
 		if (ret == 1)
@@ -1270,7 +1270,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		folio_put(folio);
 		return ret;
 	}
-	*pagep = &folio->page;
+	*foliop = folio;
 	return ret;
 }
 
@@ -2924,7 +2924,7 @@ static int ext4_nonda_switch(struct super_block *sb)
 
 static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 			       loff_t pos, unsigned len,
-			       struct page **pagep, void **fsdata)
+			       struct folio **foliop, void **fsdata)
 {
 	int ret, retries = 0;
 	struct folio *folio;
@@ -2939,14 +2939,14 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
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
@@ -2981,7 +2981,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 		return ret;
 	}
 
-	*pagep = &folio->page;
+	*foliop = folio;
 	return ret;
 }
 
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 86ef272296ab..d9203228ce97 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -76,17 +76,17 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 	while (count) {
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
-		struct page *page;
+		struct folio *folio;
 		void *fsdata = NULL;
 		int res;
 
-		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
+		res = aops->write_begin(NULL, mapping, pos, n, &folio, &fsdata);
 		if (res)
 			return res;
 
-		memcpy_to_page(page, offset_in_page(pos), buf, n);
+		memcpy_to_folio(folio, offset_in_folio(folio, pos), buf, n);
 
-		res = aops->write_end(NULL, mapping, pos, n, n, page_folio(page), fsdata);
+		res = aops->write_end(NULL, mapping, pos, n, n, folio, fsdata);
 		if (res < 0)
 			return res;
 		if (res != n)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4c32e2cfc403..5dfa0207ad8f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3552,7 +3552,7 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 }
 
 static int f2fs_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
+		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
 {
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -3584,18 +3584,20 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
 		int ret;
+		struct page *page;
 
 		*fsdata = NULL;
 
 		if (len == PAGE_SIZE && !(f2fs_is_atomic_file(inode)))
 			goto repeat;
 
-		ret = f2fs_prepare_compress_overwrite(inode, pagep,
+		ret = f2fs_prepare_compress_overwrite(inode, &page,
 							index, fsdata);
 		if (ret < 0) {
 			err = ret;
 			goto fail;
 		} else if (ret) {
+			*foliop = page_folio(page);
 			return 0;
 		}
 	}
@@ -3615,7 +3617,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	/* TODO: cluster can be compressed due to race with .writepage */
 
-	*pagep = &folio->page;
+	*foliop = folio;
 
 	if (f2fs_is_atomic_file(inode))
 		err = prepare_atomic_write_begin(sbi, &folio->page, pos, len,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cfd38cd4f82c..176b5177c89d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2677,7 +2677,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 	const struct address_space_operations *a_ops = mapping->a_ops;
 	int offset = off & (sb->s_blocksize - 1);
 	size_t towrite = len;
-	struct page *page;
+	struct folio *folio;
 	void *fsdata = NULL;
 	int err = 0;
 	int tocopy;
@@ -2687,7 +2687,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 								towrite);
 retry:
 		err = a_ops->write_begin(NULL, mapping, off, tocopy,
-							&page, &fsdata);
+							&folio, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
 				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
@@ -2697,10 +2697,10 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 			break;
 		}
 
-		memcpy_to_page(page, offset, data, tocopy);
+		memcpy_to_folio(folio, offset_in_folio(folio, off), data, tocopy);
 
 		a_ops->write_end(NULL, mapping, off, tocopy, tocopy,
-						page_folio(page), fsdata);
+						folio, fsdata);
 		offset = 0;
 		towrite -= tocopy;
 		off += tocopy;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 486512144bf1..84a33fe49bed 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -80,17 +80,17 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 	while (count) {
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
-		struct page *page;
+		struct folio *folio;
 		void *fsdata = NULL;
 		int res;
 
-		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
+		res = aops->write_begin(NULL, mapping, pos, n, &folio, &fsdata);
 		if (res)
 			return res;
 
-		memcpy_to_page(page, offset_in_page(pos), buf, n);
+		memcpy_to_folio(folio, offset_in_folio(folio, pos), buf, n);
 
-		res = aops->write_end(NULL, mapping, pos, n, n, page_folio(page), fsdata);
+		res = aops->write_end(NULL, mapping, pos, n, n, folio, fsdata);
 		if (res < 0)
 			return res;
 		if (res != n)
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 8ed02b17d591..75722bbd6b5f 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -221,13 +221,12 @@ static void fat_write_failed(struct address_space *mapping, loff_t to)
 
 static int fat_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	int err;
 
-	*pagep = NULL;
 	err = cont_write_begin(file, mapping, pos, len,
-				pagep, fsdata, fat_get_block,
+				foliop, fsdata, fat_get_block,
 				&MSDOS_I(mapping->host)->mmu_private);
 	if (err < 0)
 		fat_write_failed(mapping, pos + len);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a5cd6e4f9b2b..bc49b2eeadf3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2387,7 +2387,7 @@ static int fuse_writepages(struct address_space *mapping,
  * but how to implement it without killing performance need more thinking.
  */
 static int fuse_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
+		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
@@ -2421,7 +2421,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 	if (err)
 		goto cleanup;
 success:
-	*pagep = &folio->page;
+	*foliop = folio;
 	return 0;
 
 cleanup:
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 30512dbb79f0..4a0ce131e233 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -487,15 +487,15 @@ void hfs_file_truncate(struct inode *inode)
 	if (inode->i_size > HFS_I(inode)->phys_size) {
 		struct address_space *mapping = inode->i_mapping;
 		void *fsdata = NULL;
-		struct page *page;
+		struct folio *folio;
 
 		/* XXX: Can use generic_cont_expand? */
 		size = inode->i_size - 1;
-		res = hfs_write_begin(NULL, mapping, size + 1, 0, &page,
+		res = hfs_write_begin(NULL, mapping, size + 1, 0, &folio,
 				&fsdata);
 		if (!res) {
 			res = generic_write_end(NULL, mapping, size + 1, 0, 0,
-					page_folio(page), fsdata);
+					folio, fsdata);
 		}
 		if (res)
 			inode->i_size = HFS_I(inode)->phys_size;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index b5a6ad5df357..a0c7cb0f79fc 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -202,7 +202,7 @@ extern const struct address_space_operations hfs_aops;
 extern const struct address_space_operations hfs_btree_aops;
 
 int hfs_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct page **pagep, void **fsdata);
+		loff_t pos, unsigned len, struct folio **foliop, void **fsdata);
 extern struct inode *hfs_new_inode(struct inode *, const struct qstr *, umode_t);
 extern void hfs_inode_write_fork(struct inode *, struct hfs_extent *, __be32 *, __be32 *);
 extern int hfs_write_inode(struct inode *, struct writeback_control *);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 744e10b46904..a81ce7a740b9 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -45,12 +45,11 @@ static void hfs_write_failed(struct address_space *mapping, loff_t to)
 }
 
 int hfs_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
+		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, foliop, fsdata,
 				hfs_get_block,
 				&HFS_I(mapping->host)->phys_size);
 	if (unlikely(ret))
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 776c0ea722cb..a6d61685ae79 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -554,16 +554,16 @@ void hfsplus_file_truncate(struct inode *inode)
 
 	if (inode->i_size > hip->phys_size) {
 		struct address_space *mapping = inode->i_mapping;
-		struct page *page;
+		struct folio *folio;
 		void *fsdata = NULL;
 		loff_t size = inode->i_size;
 
 		res = hfsplus_write_begin(NULL, mapping, size, 0,
-					  &page, &fsdata);
+					  &folio, &fsdata);
 		if (res)
 			return;
 		res = generic_write_end(NULL, mapping, size, 0, 0,
-					page_folio(page), fsdata);
+					folio, fsdata);
 		if (res < 0)
 			return;
 		mark_inode_dirty(inode);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 9e78f181c24f..59ce81dca73f 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -472,7 +472,7 @@ extern const struct address_space_operations hfsplus_btree_aops;
 extern const struct dentry_operations hfsplus_dentry_operations;
 
 int hfsplus_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct page **pagep, void **fsdata);
+		loff_t pos, unsigned len, struct folio **foliop, void **fsdata);
 struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 				umode_t mode);
 void hfsplus_delete_inode(struct inode *inode);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 3d326926c195..f331e9574217 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -39,12 +39,11 @@ static void hfsplus_write_failed(struct address_space *mapping, loff_t to)
 }
 
 int hfsplus_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
+		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, foliop, fsdata,
 				hfsplus_get_block,
 				&HFSPLUS_I(mapping->host)->phys_size);
 	if (unlikely(ret))
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6452431231ab..5acedbaa9296 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -464,12 +464,13 @@ static int hostfs_read_folio(struct file *file, struct folio *folio)
 
 static int hostfs_write_begin(struct file *file, struct address_space *mapping,
 			      loff_t pos, unsigned len,
-			      struct page **pagep, void **fsdata)
+			      struct folio **foliop, void **fsdata)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
 
-	*pagep = grab_cache_page_write_begin(mapping, index);
-	if (!*pagep)
+	*foliop = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
+	if (!*foliop)
 		return -ENOMEM;
 	return 0;
 }
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 11e2d9e612ac..449a3fc1b8d9 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -190,12 +190,11 @@ static void hpfs_write_failed(struct address_space *mapping, loff_t to)
 
 static int hpfs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	*pagep = NULL;
-	ret = cont_write_begin(file, mapping, pos, len, pagep, fsdata,
+	ret = cont_write_begin(file, mapping, pos, len, foliop, fsdata,
 				hpfs_get_block,
 				&hpfs_i(mapping->host)->mmu_private);
 	if (unlikely(ret))
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b7a30055e6f4..5cf327337e22 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -388,7 +388,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 static int hugetlbfs_write_begin(struct file *file,
 			struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	return -EINVAL;
 }
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index b6fe1f1e8ea9..ada572c466f8 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -26,7 +26,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			struct folio *folio, void *fsdata);
 static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata);
+			struct folio **foliop, void **fsdata);
 static int jffs2_read_folio(struct file *filp, struct folio *folio);
 
 int jffs2_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
@@ -125,7 +125,7 @@ static int jffs2_read_folio(struct file *file, struct folio *folio)
 
 static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	struct folio *folio;
 	struct inode *inode = mapping->host;
@@ -212,7 +212,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 		ret = PTR_ERR(folio);
 		goto release_sem;
 	}
-	*pagep = &folio->page;
+	*foliop = folio;
 
 	/*
 	 * Read in the folio if it wasn't already present. Cannot optimize away
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index d63494182548..07cfdc440596 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -292,11 +292,11 @@ static void jfs_write_failed(struct address_space *mapping, loff_t to)
 
 static int jfs_write_begin(struct file *file, struct address_space *mapping,
 				loff_t pos, unsigned len,
-				struct page **pagep, void **fsdata)
+				struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, pagep, jfs_get_block);
+	ret = block_write_begin(mapping, pos, len, foliop, jfs_get_block);
 	if (unlikely(ret))
 		jfs_write_failed(mapping, pos + len);
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 4581be1d5b32..1a776edb39de 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -901,7 +901,7 @@ static int simple_read_folio(struct file *file, struct folio *folio)
 
 int simple_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	struct folio *folio;
 
@@ -910,7 +910,7 @@ int simple_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	*pagep = &folio->page;
+	*foliop = folio;
 
 	if (!folio_test_uptodate(folio) && (len != folio_size(folio))) {
 		size_t from = offset_in_folio(folio, pos);
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 0002337977e0..abb190c46c04 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -444,11 +444,11 @@ static void minix_write_failed(struct address_space *mapping, loff_t to)
 
 static int minix_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, pagep, minix_get_block);
+	ret = block_write_begin(mapping, pos, len, foliop, minix_get_block);
 	if (unlikely(ret))
 		minix_write_failed(mapping, pos + len);
 
diff --git a/fs/namei.c b/fs/namei.c
index c65c03bc3703..d813b8672317 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5308,7 +5308,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 	struct address_space *mapping = inode->i_mapping;
 	const struct address_space_operations *aops = mapping->a_ops;
 	bool nofs = !mapping_gfp_constraint(mapping, __GFP_FS);
-	struct page *page;
+	struct folio *folio;
 	void *fsdata = NULL;
 	int err;
 	unsigned int flags;
@@ -5316,16 +5316,16 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 retry:
 	if (nofs)
 		flags = memalloc_nofs_save();
-	err = aops->write_begin(NULL, mapping, 0, len-1, &page, &fsdata);
+	err = aops->write_begin(NULL, mapping, 0, len-1, &folio, &fsdata);
 	if (nofs)
 		memalloc_nofs_restore(flags);
 	if (err)
 		goto fail;
 
-	memcpy(page_address(page), symname, len-1);
+	memcpy(folio_address(folio), symname, len - 1);
 
-	err = aops->write_end(NULL, mapping, 0, len-1, len-1,
-						page_folio(page), fsdata);
+	err = aops->write_end(NULL, mapping, 0, len - 1, len - 1,
+						folio, fsdata);
 	if (err < 0)
 		goto fail;
 	if (err < len-1)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index fe583dbebe54..6800ee92d742 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -336,7 +336,7 @@ static bool nfs_want_read_modify_write(struct file *file, struct folio *folio,
  * increment the page use counts until he is done with the page.
  */
 static int nfs_write_begin(struct file *file, struct address_space *mapping,
-			   loff_t pos, unsigned len, struct page **pagep,
+			   loff_t pos, unsigned len, struct folio **foliop,
 			   void **fsdata)
 {
 	fgf_t fgp = FGP_WRITEBEGIN;
@@ -353,7 +353,7 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 				    mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	*pagep = &folio->page;
+	*foliop = folio;
 
 	ret = nfs_flush_incompatible(file, folio);
 	if (ret) {
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 25841b75415a..8661f452dba6 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -250,7 +250,7 @@ void nilfs_write_failed(struct address_space *mapping, loff_t to)
 
 static int nilfs_write_begin(struct file *file, struct address_space *mapping,
 			     loff_t pos, unsigned len,
-			     struct page **pagep, void **fsdata)
+			     struct folio **foliop, void **fsdata)
 
 {
 	struct inode *inode = mapping->host;
@@ -259,7 +259,7 @@ static int nilfs_write_begin(struct file *file, struct address_space *mapping,
 	if (unlikely(err))
 		return err;
 
-	err = block_write_begin(mapping, pos, len, pagep, nilfs_get_block);
+	err = block_write_begin(mapping, pos, len, foliop, nilfs_get_block);
 	if (unlikely(err)) {
 		nilfs_write_failed(mapping, pos + len);
 		nilfs_transaction_abort(inode->i_sb);
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 40c5dfbc9d41..c2e60a6bd060 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -498,7 +498,6 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 	struct inode *inode;
 	struct nilfs_recovery_block *rb, *n;
 	unsigned int blocksize = nilfs->ns_blocksize;
-	struct page *page;
 	struct folio *folio;
 	loff_t pos;
 	int err = 0, err2 = 0;
@@ -513,7 +512,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 
 		pos = rb->blkoff << inode->i_blkbits;
 		err = block_write_begin(inode->i_mapping, pos, blocksize,
-					&page, nilfs_get_block);
+					&folio, nilfs_get_block);
 		if (unlikely(err)) {
 			loff_t isize = inode->i_size;
 
@@ -523,8 +522,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 			goto failed_inode;
 		}
 
-		folio = page_folio(page);
-		err = nilfs_recovery_copy_block(nilfs, rb, pos, page);
+		err = nilfs_recovery_copy_block(nilfs, rb, pos, &folio->page);
 		if (unlikely(err))
 			goto failed_page;
 
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 88a7d81cf2ba..6202895a4542 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -182,7 +182,7 @@ static int ntfs_extend_initialized_size(struct file *file,
 
 	for (;;) {
 		u32 zerofrom, len;
-		struct page *page;
+		struct folio *folio;
 		u8 bits;
 		CLST vcn, lcn, clen;
 
@@ -208,14 +208,13 @@ static int ntfs_extend_initialized_size(struct file *file,
 		if (pos + len > new_valid)
 			len = new_valid - pos;
 
-		err = ntfs_write_begin(file, mapping, pos, len, &page, NULL);
+		err = ntfs_write_begin(file, mapping, pos, len, &folio, NULL);
 		if (err)
 			goto out;
 
-		zero_user_segment(page, zerofrom, PAGE_SIZE);
+		folio_zero_range(folio, zerofrom, folio_size(folio));
 
-		/* This function in any case puts page. */
-		err = ntfs_write_end(file, mapping, pos, len, len, page_folio(page), NULL);
+		err = ntfs_write_end(file, mapping, pos, len, len, folio, NULL);
 		if (err < 0)
 			goto out;
 		pos += len;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 9efd3f7c59d6..f672072e6bd4 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -901,7 +901,7 @@ static int ntfs_get_block_write_begin(struct inode *inode, sector_t vbn,
 }
 
 int ntfs_write_begin(struct file *file, struct address_space *mapping,
-		     loff_t pos, u32 len, struct page **pagep, void **fsdata)
+		     loff_t pos, u32 len, struct folio **foliop, void **fsdata)
 {
 	int err;
 	struct inode *inode = mapping->host;
@@ -910,7 +910,6 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
-	*pagep = NULL;
 	if (is_resident(ni)) {
 		struct folio *folio = __filemap_get_folio(
 			mapping, pos >> PAGE_SHIFT, FGP_WRITEBEGIN,
@@ -926,7 +925,7 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 		ni_unlock(ni);
 
 		if (!err) {
-			*pagep = &folio->page;
+			*foliop = folio;
 			goto out;
 		}
 		folio_unlock(folio);
@@ -936,7 +935,7 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 			goto out;
 	}
 
-	err = block_write_begin(mapping, pos, len, pagep,
+	err = block_write_begin(mapping, pos, len, foliop,
 				ntfs_get_block_write_begin);
 
 out:
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 53517281f26b..584f814715f4 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -711,7 +711,7 @@ int ntfs_set_size(struct inode *inode, u64 new_size);
 int ntfs_get_block(struct inode *inode, sector_t vbn,
 		   struct buffer_head *bh_result, int create);
 int ntfs_write_begin(struct file *file, struct address_space *mapping,
-		     loff_t pos, u32 len, struct page **pagep, void **fsdata);
+		     loff_t pos, u32 len, struct folio **foliop, void **fsdata);
 int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 		   u32 len, u32 copied, struct folio *folio, void *fsdata);
 int ntfs3_write_inode(struct inode *inode, struct writeback_control *wbc);
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 9d8aa417e8da..d6c985cc6353 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -1643,7 +1643,7 @@ static int ocfs2_zero_tail(struct inode *inode, struct buffer_head *di_bh,
 
 int ocfs2_write_begin_nolock(struct address_space *mapping,
 			     loff_t pos, unsigned len, ocfs2_write_type_t type,
-			     struct page **pagep, void **fsdata,
+			     struct folio **foliop, void **fsdata,
 			     struct buffer_head *di_bh, struct page *mmap_page)
 {
 	int ret, cluster_of_pages, credits = OCFS2_INODE_UPDATE_CREDITS;
@@ -1826,8 +1826,8 @@ int ocfs2_write_begin_nolock(struct address_space *mapping,
 		ocfs2_free_alloc_context(meta_ac);
 
 success:
-	if (pagep)
-		*pagep = wc->w_target_page;
+	if (foliop)
+		*foliop = page_folio(wc->w_target_page);
 	*fsdata = wc;
 	return 0;
 out_quota:
@@ -1879,7 +1879,7 @@ int ocfs2_write_begin_nolock(struct address_space *mapping,
 
 static int ocfs2_write_begin(struct file *file, struct address_space *mapping,
 			     loff_t pos, unsigned len,
-			     struct page **pagep, void **fsdata)
+			     struct folio **foliop, void **fsdata)
 {
 	int ret;
 	struct buffer_head *di_bh = NULL;
@@ -1901,7 +1901,7 @@ static int ocfs2_write_begin(struct file *file, struct address_space *mapping,
 	down_write(&OCFS2_I(inode)->ip_alloc_sem);
 
 	ret = ocfs2_write_begin_nolock(mapping, pos, len, OCFS2_WRITE_BUFFER,
-				       pagep, fsdata, di_bh, NULL);
+				       foliop, fsdata, di_bh, NULL);
 	if (ret) {
 		mlog_errno(ret);
 		goto out_fail;
diff --git a/fs/ocfs2/aops.h b/fs/ocfs2/aops.h
index 3a520117fa59..45db1781ea73 100644
--- a/fs/ocfs2/aops.h
+++ b/fs/ocfs2/aops.h
@@ -38,7 +38,7 @@ typedef enum {
 
 int ocfs2_write_begin_nolock(struct address_space *mapping,
 			     loff_t pos, unsigned len, ocfs2_write_type_t type,
-			     struct page **pagep, void **fsdata,
+			     struct folio **foliop, void **fsdata,
 			     struct buffer_head *di_bh, struct page *mmap_page);
 
 int ocfs2_read_inline_data(struct inode *inode, struct page *page,
diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 1834f26522ed..6ef4cb045ccd 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -53,7 +53,7 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
 	loff_t pos = page_offset(page);
 	unsigned int len = PAGE_SIZE;
 	pgoff_t last_index;
-	struct page *locked_page = NULL;
+	struct folio *locked_folio = NULL;
 	void *fsdata;
 	loff_t size = i_size_read(inode);
 
@@ -91,7 +91,7 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
 		len = ((size - 1) & ~PAGE_MASK) + 1;
 
 	err = ocfs2_write_begin_nolock(mapping, pos, len, OCFS2_WRITE_MMAP,
-				       &locked_page, &fsdata, di_bh, page);
+				       &locked_folio, &fsdata, di_bh, page);
 	if (err) {
 		if (err != -ENOSPC)
 			mlog_errno(err);
@@ -99,7 +99,7 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
 		goto out;
 	}
 
-	if (!locked_page) {
+	if (!locked_folio) {
 		ret = VM_FAULT_NOPAGE;
 		goto out;
 	}
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 6b580b9da8e3..98358d405b6a 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -312,11 +312,11 @@ static void omfs_write_failed(struct address_space *mapping, loff_t to)
 
 static int omfs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, pagep, omfs_get_block);
+	ret = block_write_begin(mapping, pos, len, foliop, omfs_get_block);
 	if (unlikely(ret))
 		omfs_write_failed(mapping, pos + len);
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 69b507a611f8..aae6d2b8767d 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -309,7 +309,7 @@ static int orangefs_read_folio(struct file *file, struct folio *folio)
 
 static int orangefs_write_begin(struct file *file,
 		struct address_space *mapping, loff_t pos, unsigned len,
-		struct page **pagep, void **fsdata)
+		struct folio **foliop, void **fsdata)
 {
 	struct orangefs_write_range *wr;
 	struct folio *folio;
@@ -320,7 +320,7 @@ static int orangefs_write_begin(struct file *file,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	*pagep = &folio->page;
+	*foliop = folio;
 
 	if (folio_test_dirty(folio) && !folio_test_private(folio)) {
 		/*
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index f4b9db4b4df2..ea23872ba24f 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2735,7 +2735,7 @@ static void reiserfs_truncate_failed_write(struct inode *inode)
 static int reiserfs_write_begin(struct file *file,
 				struct address_space *mapping,
 				loff_t pos, unsigned len,
-				struct page **pagep, void **fsdata)
+				struct folio **foliop, void **fsdata)
 {
 	struct inode *inode;
 	struct folio *folio;
@@ -2749,7 +2749,7 @@ static int reiserfs_write_begin(struct file *file,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	*pagep = &folio->page;
+	*foliop = folio;
 
 	reiserfs_wait_on_write_block(inode->i_sb);
 	fix_tail_page_for_writing(&folio->page);
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index c8511e286673..8864438817a6 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -483,11 +483,11 @@ static void sysv_write_failed(struct address_space *mapping, loff_t to)
 
 static int sysv_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, pagep, get_block);
+	ret = block_write_begin(mapping, pos, len, foliop, get_block);
 	if (unlikely(ret))
 		sysv_write_failed(mapping, pos + len);
 
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index baa3eecc32fe..5130123005e4 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -211,7 +211,7 @@ static void release_existing_page_budget(struct ubifs_info *c)
 }
 
 static int write_begin_slow(struct address_space *mapping,
-			    loff_t pos, unsigned len, struct page **pagep)
+			    loff_t pos, unsigned len, struct folio **foliop)
 {
 	struct inode *inode = mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
@@ -298,7 +298,7 @@ static int write_begin_slow(struct address_space *mapping,
 			ubifs_release_dirty_inode_budget(c, ui);
 	}
 
-	*pagep = &folio->page;
+	*foliop = folio;
 	return 0;
 }
 
@@ -414,7 +414,7 @@ static int allocate_budget(struct ubifs_info *c, struct folio *folio,
  */
 static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 			     loff_t pos, unsigned len,
-			     struct page **pagep, void **fsdata)
+			     struct folio **foliop, void **fsdata)
 {
 	struct inode *inode = mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
@@ -483,7 +483,7 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 		folio_unlock(folio);
 		folio_put(folio);
 
-		return write_begin_slow(mapping, pos, len, pagep);
+		return write_begin_slow(mapping, pos, len, foliop);
 	}
 
 	/*
@@ -492,7 +492,7 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 	 * with @ui->ui_mutex locked if we are appending pages, and unlocked
 	 * otherwise. This is an optimization (slightly hacky though).
 	 */
-	*pagep = &folio->page;
+	*foliop = folio;
 	return 0;
 }
 
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index fdf024e0b772..eaee57b91c6c 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -246,14 +246,14 @@ static void udf_readahead(struct readahead_control *rac)
 
 static int udf_write_begin(struct file *file, struct address_space *mapping,
 			   loff_t pos, unsigned len,
-			   struct page **pagep, void **fsdata)
+			   struct folio **foliop, void **fsdata)
 {
 	struct udf_inode_info *iinfo = UDF_I(file_inode(file));
 	struct folio *folio;
 	int ret;
 
 	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		ret = block_write_begin(mapping, pos, len, pagep,
+		ret = block_write_begin(mapping, pos, len, foliop,
 					udf_get_block);
 		if (unlikely(ret))
 			udf_write_failed(mapping, pos + len);
@@ -265,7 +265,7 @@ static int udf_write_begin(struct file *file, struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	*pagep = &folio->page;
+	*foliop = folio;
 	if (!folio_test_uptodate(folio))
 		udf_adinicb_read_folio(folio);
 	return 0;
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 69adb198c634..f43461652d9f 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -498,11 +498,11 @@ static void ufs_write_failed(struct address_space *mapping, loff_t to)
 
 static int ufs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, pagep, ufs_getfrag_block);
+	ret = block_write_begin(mapping, pos, len, foliop, ufs_getfrag_block);
 	if (unlikely(ret))
 		ufs_write_failed(mapping, pos + len);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 165e859664a5..254563a2a9de 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -258,7 +258,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 int block_read_full_folio(struct folio *, get_block_t *);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
-		struct page **pagep, get_block_t *get_block);
+		struct folio **foliop, get_block_t *get_block);
 int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 		get_block_t *get_block);
 int block_write_end(struct file *, struct address_space *,
@@ -269,7 +269,7 @@ int generic_write_end(struct file *, struct address_space *,
 				struct folio *, void *);
 void folio_zero_new_buffers(struct folio *folio, size_t from, size_t to);
 int cont_write_begin(struct file *, struct address_space *, loff_t,
-			unsigned, struct page **, void **,
+			unsigned, struct folio **, void **,
 			get_block_t *, loff_t *);
 int generic_cont_expand_simple(struct inode *inode, loff_t size);
 void block_commit_write(struct page *page, unsigned int from, unsigned int to);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6ff85d72067b..34059e58aa92 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -408,7 +408,7 @@ struct address_space_operations {
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len,
-				struct page **pagep, void **fsdata);
+				struct folio **foliop, void **fsdata);
 	int (*write_end)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
 				struct folio *folio, void *fsdata);
@@ -3331,7 +3331,7 @@ extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
 extern int simple_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata);
+			struct folio **foliop, void **fsdata);
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
diff --git a/mm/filemap.c b/mm/filemap.c
index fab6b0c3044e..29fec1fccd0a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3987,7 +3987,6 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	ssize_t written = 0;
 
 	do {
-		struct page *page;
 		struct folio *folio;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
@@ -4017,11 +4016,10 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 		}
 
 		status = a_ops->write_begin(file, mapping, pos, bytes,
-						&page, &fsdata);
+						&folio, &fsdata);
 		if (unlikely(status < 0))
 			break;
 
-		folio = page_folio(page);
 		offset = offset_in_folio(folio, pos);
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
diff --git a/mm/shmem.c b/mm/shmem.c
index 1116f147d788..a8618eeed77a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2882,7 +2882,7 @@ static const struct inode_operations shmem_short_symlink_operations;
 static int
 shmem_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -2903,14 +2903,13 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	if (ret)
 		return ret;
 
-	*pagep = folio_file_page(folio, index);
-	if (PageHWPoison(*pagep)) {
+	if (folio_test_has_hwpoisoned(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
-		*pagep = NULL;
 		return -EIO;
 	}
 
+	*foliop = folio;
 	return 0;
 }
 
-- 
2.43.0


