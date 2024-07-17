Return-Path: <linux-fsdevel+bounces-23860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608A933FFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8990C1F25D5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9500D1836D3;
	Wed, 17 Jul 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VHZD9VUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7E4181D11
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231247; cv=none; b=if5LrJSe1HegFl0AKyhhepjcXzHi9DkZVZWIg0wRfnxnoEvTLeL6wH+MC/T5Ifh5PODh7AA5sP7oXM5oyFS7B7sgAE7sVcJvnLJCn/FLt/PmefAkbwPioTDCqf2wFWOM91mEhiNnCXEMYPu6OvDOHNt1czPkKRKk5O4xdBRobks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231247; c=relaxed/simple;
	bh=K6iJHw2aPIU0uw1okJ7gz1VCClWv1D4Scv2NRRKT5eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN3PSTsX6KVYHxvUwHCNJY6AAGux2DVFfvLoRARstnQ4Tr4LbkasRor9cPgmO5q1F7K4Lt5kbDI5++mn9HJK8MP175cEJn6VSskD2x/p4vu9tH3vOgbh4Jlcwif//qMJEonk+3CZtBXovRPjx2AG/L+tsVOOFsPlIhLD+xSTrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VHZD9VUc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nozS2z8zYOKYe3QvN3WmLDVHjujgWUa98vMuX5DsAno=; b=VHZD9VUchHgs//KAB8LmqzPSWB
	CF9WZrPFNQj8ObI8r2aCeg536crw/hiwsHm+3GLQqgj/sm70pTZthWQrgKFcXe0OJ2NJPTOG66V+h
	1+Mut+EYFT4QIoGjHYro5PyuYG9bgfDpFhNNByhN9XpXDRL7AC+8A2J4P3peieOHOESFkN83BAHwZ
	3pT/f7L9iR3Ia4qoo3JM3aDzGCMh0tGe7ajd5+2pe2e2jvhNSYJS0emqLLfDoWNwQRVbRwJUPqcUB
	PuLOsc5X+U57/6o5tVACIr0yG0f8rI9UluQaa6IKyK60HVdWYWucq7E6vOAwoCEyZUG4ZgMzTa55T
	oseUFzUA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sE-00000000zvp-29lv;
	Wed, 17 Jul 2024 15:47:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 20/23] fs: Convert aops->write_end to take a folio
Date: Wed, 17 Jul 2024 16:47:10 +0100
Message-ID: <20240717154716.237943-21-willy@infradead.org>
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

Most callers have a folio, and most implementations operate on a folio,
so remove the conversion from folio->page->folio to fit through this
interface.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst     |  2 +-
 Documentation/filesystems/vfs.rst         |  6 +++---
 block/fops.c                              |  3 +--
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  4 ++--
 fs/affs/file.c                            |  9 ++++-----
 fs/bcachefs/fs-io-buffered.c              |  3 +--
 fs/bcachefs/fs-io-buffered.h              |  2 +-
 fs/buffer.c                               |  9 ++++-----
 fs/ceph/addr.c                            |  3 +--
 fs/ecryptfs/mmap.c                        |  5 ++---
 fs/exfat/file.c                           |  2 +-
 fs/exfat/inode.c                          |  4 ++--
 fs/ext2/inode.c                           |  4 ++--
 fs/ext4/inode.c                           | 11 ++++-------
 fs/ext4/verity.c                          |  2 +-
 fs/f2fs/data.c                            |  3 +--
 fs/f2fs/super.c                           |  2 +-
 fs/f2fs/verity.c                          |  2 +-
 fs/fat/inode.c                            |  4 ++--
 fs/fuse/file.c                            |  3 +--
 fs/hfs/extent.c                           |  2 +-
 fs/hfsplus/extents.c                      |  2 +-
 fs/hostfs/hostfs_kern.c                   |  3 +--
 fs/hpfs/file.c                            |  4 ++--
 fs/hugetlbfs/inode.c                      |  2 +-
 fs/jffs2/file.c                           |  5 ++---
 fs/jfs/inode.c                            |  4 ++--
 fs/libfs.c                                |  9 ++++-----
 fs/namei.c                                |  2 +-
 fs/nfs/file.c                             |  3 +--
 fs/nilfs2/inode.c                         |  6 +++---
 fs/ntfs3/file.c                           |  2 +-
 fs/ntfs3/inode.c                          |  5 ++---
 fs/ntfs3/ntfs_fs.h                        |  2 +-
 fs/ocfs2/aops.c                           |  2 +-
 fs/orangefs/inode.c                       |  4 ++--
 fs/reiserfs/inode.c                       | 11 +++++------
 fs/ubifs/file.c                           |  3 +--
 fs/udf/inode.c                            |  6 ++----
 fs/ufs/inode.c                            |  4 ++--
 fs/vboxsf/file.c                          |  7 +++----
 include/linux/buffer_head.h               |  4 ++--
 include/linux/fs.h                        |  2 +-
 mm/filemap.c                              |  2 +-
 mm/shmem.c                                |  3 +--
 45 files changed, 80 insertions(+), 102 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index e664061ed55d..827fb5a073b7 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -254,7 +254,7 @@ prototypes::
 				struct page **pagep, void **fsdata);
 	int (*write_end)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata);
+				struct folio *folio, void *fsdata);
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 6e903a903f8f..0e24f770c568 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -810,7 +810,7 @@ cache in your filesystem.  The following members are defined:
 				struct page **pagep, void **fsdata);
 		int (*write_end)(struct file *, struct address_space *mapping,
 				 loff_t pos, unsigned len, unsigned copied,
-				 struct page *page, void *fsdata);
+				 struct folio *folio, void *fsdata);
 		sector_t (*bmap)(struct address_space *, sector_t);
 		void (*invalidate_folio) (struct folio *, size_t start, size_t len);
 		bool (*release_folio)(struct folio *, gfp_t);
@@ -944,8 +944,8 @@ cache in your filesystem.  The following members are defined:
 	called.  len is the original len passed to write_begin, and
 	copied is the amount that was able to be copied.
 
-	The filesystem must take care of unlocking the page and
-	releasing it refcount, and updating i_size.
+	The filesystem must take care of unlocking the folio,
+	decrementing its refcount, and updating i_size.
 
 	Returns < 0 on failure, otherwise the number of bytes (<=
 	'copied') that were able to be copied into pagecache.
diff --git a/block/fops.c b/block/fops.c
index df0e762cf397..cd96a6f17119 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -457,10 +457,9 @@ static int blkdev_write_begin(struct file *file, struct address_space *mapping,
 }
 
 static int blkdev_write_end(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, unsigned copied, struct page *page,
+		loff_t pos, unsigned len, unsigned copied, struct folio *folio,
 		void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	int ret;
 	ret = block_write_end(file, mapping, pos, len, copied, folio, fsdata);
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index c5e1c718a6d2..3513165a2964 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -494,7 +494,7 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 		kunmap_local(vaddr);
 
 		err = aops->write_end(obj->base.filp, mapping, offset, len,
-				      len - unwritten, page, data);
+				      len - unwritten, page_folio(page), data);
 		if (err < 0)
 			return err;
 
@@ -688,7 +688,7 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
 		kunmap(page);
 
 		err = aops->write_end(file, file->f_mapping, offset, len, len,
-				      page, pgdata);
+				      page_folio(page), pgdata);
 		if (err < 0)
 			goto fail;
 
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 04c018e19602..6a6c5bc41b8f 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -433,12 +433,12 @@ static int affs_write_begin(struct file *file, struct address_space *mapping,
 
 static int affs_write_end(struct file *file, struct address_space *mapping,
 			  loff_t pos, unsigned int len, unsigned int copied,
-			  struct page *page, void *fsdata)
+			  struct folio *folio, void *fsdata)
 {
 	struct inode *inode = mapping->host;
 	int ret;
 
-	ret = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+	ret = generic_write_end(file, mapping, pos, len, copied, folio, fsdata);
 
 	/* Clear Archived bit on file writes, as AmigaOS would do */
 	if (AFFS_I(inode)->i_protect & FIBF_ARCHIVED) {
@@ -687,9 +687,8 @@ static int affs_write_begin_ofs(struct file *file, struct address_space *mapping
 
 static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata)
+				struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh, *prev_bh;
@@ -889,7 +888,7 @@ affs_truncate(struct inode *inode)
 
 		res = mapping->a_ops->write_begin(NULL, mapping, isize, 0, &page, &fsdata);
 		if (!res)
-			res = mapping->a_ops->write_end(NULL, mapping, isize, 0, 0, page, fsdata);
+			res = mapping->a_ops->write_end(NULL, mapping, isize, 0, 0, page_folio(page), fsdata);
 		else
 			inode->i_size = AFFS_I(inode)->mmu_private;
 		mark_inode_dirty(inode);
diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index cc33d763f722..46ae9ef3589a 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -743,12 +743,11 @@ int bch2_write_begin(struct file *file, struct address_space *mapping,
 
 int bch2_write_end(struct file *file, struct address_space *mapping,
 		   loff_t pos, unsigned len, unsigned copied,
-		   struct page *page, void *fsdata)
+		   struct folio *folio, void *fsdata)
 {
 	struct bch_inode_info *inode = to_bch_ei(mapping->host);
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
 	struct bch2_folio_reservation *res = fsdata;
-	struct folio *folio = page_folio(page);
 	unsigned offset = pos - folio_pos(folio);
 
 	lockdep_assert_held(&inode->v.i_rwsem);
diff --git a/fs/bcachefs/fs-io-buffered.h b/fs/bcachefs/fs-io-buffered.h
index a6126ff790e6..16569b9874e0 100644
--- a/fs/bcachefs/fs-io-buffered.h
+++ b/fs/bcachefs/fs-io-buffered.h
@@ -13,7 +13,7 @@ void bch2_readahead(struct readahead_control *);
 int bch2_write_begin(struct file *, struct address_space *, loff_t,
 		     unsigned, struct page **, void **);
 int bch2_write_end(struct file *, struct address_space *, loff_t,
-		   unsigned, unsigned, struct page *, void *);
+		   unsigned len, unsigned copied, struct folio *, void *);
 
 ssize_t bch2_write_iter(struct kiocb *, struct iov_iter *);
 
diff --git a/fs/buffer.c b/fs/buffer.c
index acba3dfe55d8..1a0f2f65e890 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2280,9 +2280,8 @@ EXPORT_SYMBOL(block_write_end);
 
 int generic_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
 	bool i_size_changed = false;
@@ -2480,7 +2479,7 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 	if (err)
 		goto out;
 
-	err = aops->write_end(NULL, mapping, size, 0, 0, page, fsdata);
+	err = aops->write_end(NULL, mapping, size, 0, 0, page_folio(page), fsdata);
 	BUG_ON(err > 0);
 
 out:
@@ -2518,7 +2517,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 			goto out;
 		zero_user(page, zerofrom, len);
 		err = aops->write_end(file, mapping, curpos, len, len,
-						page, fsdata);
+						page_folio(page), fsdata);
 		if (err < 0)
 			goto out;
 		BUG_ON(err != len);
@@ -2551,7 +2550,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 			goto out;
 		zero_user(page, zerofrom, len);
 		err = aops->write_end(file, mapping, curpos, len, len,
-						page, fsdata);
+						page_folio(page), fsdata);
 		if (err < 0)
 			goto out;
 		BUG_ON(err != len);
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8c16bc5250ef..87369e2659c7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1509,9 +1509,8 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
  */
 static int ceph_write_end(struct file *file, struct address_space *mapping,
 			  loff_t pos, unsigned len, unsigned copied,
-			  struct page *subpage, void *fsdata)
+			  struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(subpage);
 	struct inode *inode = file_inode(file);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	bool check_cap = false;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 75ce28d757b7..f43e42ede75e 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -458,15 +458,14 @@ int ecryptfs_write_inode_size_to_metadata(struct inode *ecryptfs_inode)
  * @pos: The file position
  * @len: The length of the data (unused)
  * @copied: The amount of data copied
- * @page: The eCryptfs page
+ * @folio: The eCryptfs folio
  * @fsdata: The fsdata (unused)
  */
 static int ecryptfs_write_end(struct file *file,
 			struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	pgoff_t index = pos >> PAGE_SHIFT;
 	unsigned from = pos & (PAGE_SIZE - 1);
 	unsigned to = from + copied;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 64c31867bc76..7144472d092e 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -548,7 +548,7 @@ static int exfat_file_zeroed_range(struct file *file, loff_t start, loff_t end)
 
 		zero_user_segment(page, zerofrom, zerofrom + len);
 
-		err = ops->write_end(file, mapping, start, len, len, page, NULL);
+		err = ops->write_end(file, mapping, start, len, len, page_folio(page), NULL);
 		if (err < 0)
 			goto out;
 		start += len;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index dd894e558c91..871e9e3e407e 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -463,13 +463,13 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
 
 static int exfat_write_end(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned int len, unsigned int copied,
-		struct page *pagep, void *fsdata)
+		struct folio *folio, void *fsdata)
 {
 	struct inode *inode = mapping->host;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	int err;
 
-	err = generic_write_end(file, mapping, pos, len, copied, pagep, fsdata);
+	err = generic_write_end(file, mapping, pos, len, copied, folio, fsdata);
 
 	if (ei->i_size_aligned < i_size_read(inode)) {
 		exfat_fs_error(inode->i_sb,
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 0caa1650cee8..aba41f6150e5 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -928,11 +928,11 @@ ext2_write_begin(struct file *file, struct address_space *mapping,
 
 static int ext2_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
 	int ret;
 
-	ret = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+	ret = generic_write_end(file, mapping, pos, len, copied, folio, fsdata);
 	if (ret < len)
 		ext2_write_failed(mapping, pos + len);
 	return ret;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1e4831d83adc..e19ac0a82bdc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1298,9 +1298,8 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
 static int ext4_write_end(struct file *file,
 			  struct address_space *mapping,
 			  loff_t pos, unsigned len, unsigned copied,
-			  struct page *page, void *fsdata)
+			  struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -1402,9 +1401,8 @@ static void ext4_journalled_zero_new_buffers(handle_t *handle,
 static int ext4_journalled_write_end(struct file *file,
 				     struct address_space *mapping,
 				     loff_t pos, unsigned len, unsigned copied,
-				     struct page *page, void *fsdata)
+				     struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -3080,15 +3078,14 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 static int ext4_da_write_end(struct file *file,
 			     struct address_space *mapping,
 			     loff_t pos, unsigned len, unsigned copied,
-			     struct page *page, void *fsdata)
+			     struct folio *folio, void *fsdata)
 {
 	struct inode *inode = mapping->host;
 	int write_mode = (int)(unsigned long)fsdata;
-	struct folio *folio = page_folio(page);
 
 	if (write_mode == FALL_BACK_TO_NONDELALLOC)
 		return ext4_write_end(file, mapping, pos,
-				      len, copied, &folio->page, fsdata);
+				      len, copied, folio, fsdata);
 
 	trace_ext4_da_write_end(inode, pos, len, copied);
 
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 2f37e1ea3955..86ef272296ab 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -86,7 +86,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 
 		memcpy_to_page(page, offset_in_page(pos), buf, n);
 
-		res = aops->write_end(NULL, mapping, pos, n, n, page, fsdata);
+		res = aops->write_end(NULL, mapping, pos, n, n, page_folio(page), fsdata);
 		if (res < 0)
 			return res;
 		if (res != n)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9a45f9fb8a64..4c32e2cfc403 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3689,9 +3689,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 static int f2fs_write_end(struct file *file,
 			struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = folio->mapping->host;
 
 	trace_f2fs_write_end(inode, pos, len, copied);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3959fd137cc9..cfd38cd4f82c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2700,7 +2700,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 		memcpy_to_page(page, offset, data, tocopy);
 
 		a_ops->write_end(NULL, mapping, off, tocopy, tocopy,
-						page, fsdata);
+						page_folio(page), fsdata);
 		offset = 0;
 		towrite -= tocopy;
 		off += tocopy;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index f7bb0c54502c..486512144bf1 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -90,7 +90,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 
 		memcpy_to_page(page, offset_in_page(pos), buf, n);
 
-		res = aops->write_end(NULL, mapping, pos, n, n, page, fsdata);
+		res = aops->write_end(NULL, mapping, pos, n, n, page_folio(page), fsdata);
 		if (res < 0)
 			return res;
 		if (res != n)
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 19115fd2d2a4..8ed02b17d591 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -236,11 +236,11 @@ static int fat_write_begin(struct file *file, struct address_space *mapping,
 
 static int fat_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *pagep, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
 	struct inode *inode = mapping->host;
 	int err;
-	err = generic_write_end(file, mapping, pos, len, copied, pagep, fsdata);
+	err = generic_write_end(file, mapping, pos, len, copied, folio, fsdata);
 	if (err < len)
 		fat_write_failed(mapping, pos + len);
 	if (!(err < 0) && !(MSDOS_I(inode)->i_attrs & ATTR_ARCH)) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 137485999d3d..a5cd6e4f9b2b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2433,9 +2433,8 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 
 static int fuse_write_end(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned len, unsigned copied,
-		struct page *page, void *fsdata)
+		struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = folio->mapping->host;
 
 	/* Haven't copied anything?  Skip zeroing, size extending, dirtying. */
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 6d1878b99b30..30512dbb79f0 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -495,7 +495,7 @@ void hfs_file_truncate(struct inode *inode)
 				&fsdata);
 		if (!res) {
 			res = generic_write_end(NULL, mapping, size + 1, 0, 0,
-					page, fsdata);
+					page_folio(page), fsdata);
 		}
 		if (res)
 			inode->i_size = HFS_I(inode)->phys_size;
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 9c51867dddc5..776c0ea722cb 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -563,7 +563,7 @@ void hfsplus_file_truncate(struct inode *inode)
 		if (res)
 			return;
 		res = generic_write_end(NULL, mapping, size, 0, 0,
-					page, fsdata);
+					page_folio(page), fsdata);
 		if (res < 0)
 			return;
 		mark_inode_dirty(inode);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 42b70780282d..6452431231ab 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -476,9 +476,8 @@ static int hostfs_write_begin(struct file *file, struct address_space *mapping,
 
 static int hostfs_write_end(struct file *file, struct address_space *mapping,
 			    loff_t pos, unsigned len, unsigned copied,
-			    struct page *page, void *fsdata)
+			    struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	void *buffer;
 	size_t from = offset_in_folio(folio, pos);
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 1bb8d97cd9ae..11e2d9e612ac 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -206,11 +206,11 @@ static int hpfs_write_begin(struct file *file, struct address_space *mapping,
 
 static int hpfs_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *pagep, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
 	struct inode *inode = mapping->host;
 	int err;
-	err = generic_write_end(file, mapping, pos, len, copied, pagep, fsdata);
+	err = generic_write_end(file, mapping, pos, len, copied, folio, fsdata);
 	if (err < len)
 		hpfs_write_failed(mapping, pos + len);
 	if (!(err < 0)) {
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9f6cff356796..b7a30055e6f4 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -395,7 +395,7 @@ static int hugetlbfs_write_begin(struct file *file,
 
 static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
 	BUG();
 	return -EINVAL;
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index ee8f7f029b45..b6fe1f1e8ea9 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -23,7 +23,7 @@
 
 static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *pg, void *fsdata);
+			struct folio *folio, void *fsdata);
 static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata);
@@ -239,9 +239,8 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 
 static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *pg, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(pg);
 	/* Actually commit the write from the page cache page we're looking at.
 	 * For now, we write the full page out each time. It sucks, but it's simple
 	 */
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 1a6b5921d17a..d63494182548 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -304,12 +304,12 @@ static int jfs_write_begin(struct file *file, struct address_space *mapping,
 }
 
 static int jfs_write_end(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, unsigned copied, struct page *page,
+		loff_t pos, unsigned len, unsigned copied, struct folio *folio,
 		void *fsdata)
 {
 	int ret;
 
-	ret = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+	ret = generic_write_end(file, mapping, pos, len, copied, folio, fsdata);
 	if (ret < len)
 		jfs_write_failed(mapping, pos + len);
 	return ret;
diff --git a/fs/libfs.c b/fs/libfs.c
index 8aa34870449f..4581be1d5b32 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -929,11 +929,11 @@ EXPORT_SYMBOL(simple_write_begin);
  * @pos: 		"
  * @len: 		"
  * @copied: 		"
- * @page: 		"
+ * @folio: 		"
  * @fsdata: 		"
  *
- * simple_write_end does the minimum needed for updating a page after writing is
- * done. It has the same API signature as the .write_end of
+ * simple_write_end does the minimum needed for updating a folio after
+ * writing is done. It has the same API signature as the .write_end of
  * address_space_operations vector. So it can just be set onto .write_end for
  * FSes that don't need any other processing. i_mutex is assumed to be held.
  * Block based filesystems should use generic_write_end().
@@ -946,9 +946,8 @@ EXPORT_SYMBOL(simple_write_begin);
  */
 static int simple_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = folio->mapping->host;
 	loff_t last_pos = pos + copied;
 
diff --git a/fs/namei.c b/fs/namei.c
index 80e48a440c1f..c65c03bc3703 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5325,7 +5325,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 	memcpy(page_address(page), symname, len-1);
 
 	err = aops->write_end(NULL, mapping, 0, len-1, len-1,
-							page, fsdata);
+						page_folio(page), fsdata);
 	if (err < 0)
 		goto fail;
 	if (err < len-1)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 61a8cdb9f1e1..fe583dbebe54 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -372,10 +372,9 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 
 static int nfs_write_end(struct file *file, struct address_space *mapping,
 			 loff_t pos, unsigned len, unsigned copied,
-			 struct page *page, void *fsdata)
+			 struct folio *folio, void *fsdata)
 {
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
-	struct folio *folio = page_folio(page);
 	unsigned offset = offset_in_folio(folio, pos);
 	int status;
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 7340a01d80e1..25841b75415a 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -269,16 +269,16 @@ static int nilfs_write_begin(struct file *file, struct address_space *mapping,
 
 static int nilfs_write_end(struct file *file, struct address_space *mapping,
 			   loff_t pos, unsigned len, unsigned copied,
-			   struct page *page, void *fsdata)
+			   struct folio *folio, void *fsdata)
 {
 	struct inode *inode = mapping->host;
 	unsigned int start = pos & (PAGE_SIZE - 1);
 	unsigned int nr_dirty;
 	int err;
 
-	nr_dirty = nilfs_page_count_clean_buffers(page, start,
+	nr_dirty = nilfs_page_count_clean_buffers(&folio->page, start,
 						  start + copied);
-	copied = generic_write_end(file, mapping, pos, len, copied, page,
+	copied = generic_write_end(file, mapping, pos, len, copied, folio,
 				   fsdata);
 	nilfs_set_file_dirty(inode, nr_dirty);
 	err = nilfs_transaction_commit(inode->i_sb);
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index ca1ddc46bd86..88a7d81cf2ba 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -215,7 +215,7 @@ static int ntfs_extend_initialized_size(struct file *file,
 		zero_user_segment(page, zerofrom, PAGE_SIZE);
 
 		/* This function in any case puts page. */
-		err = ntfs_write_end(file, mapping, pos, len, len, page, NULL);
+		err = ntfs_write_end(file, mapping, pos, len, len, page_folio(page), NULL);
 		if (err < 0)
 			goto out;
 		pos += len;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 8eaaf9e465d4..9efd3f7c59d6 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -947,9 +947,8 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
  * ntfs_write_end - Address_space_operations::write_end.
  */
 int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
-		   u32 len, u32 copied, struct page *page, void *fsdata)
+		   u32 len, u32 copied, struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u64 valid = ni->i_valid;
@@ -979,7 +978,7 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 		folio_unlock(folio);
 		folio_put(folio);
 	} else {
-		err = generic_write_end(file, mapping, pos, len, copied, page,
+		err = generic_write_end(file, mapping, pos, len, copied, folio,
 					fsdata);
 	}
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 4e363b8342d6..53517281f26b 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -713,7 +713,7 @@ int ntfs_get_block(struct inode *inode, sector_t vbn,
 int ntfs_write_begin(struct file *file, struct address_space *mapping,
 		     loff_t pos, u32 len, struct page **pagep, void **fsdata);
 int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
-		   u32 len, u32 copied, struct page *page, void *fsdata);
+		   u32 len, u32 copied, struct folio *folio, void *fsdata);
 int ntfs3_write_inode(struct inode *inode, struct writeback_control *wbc);
 int ntfs_sync_inode(struct inode *inode);
 int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 6be175a1ab3c..9d8aa417e8da 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2076,7 +2076,7 @@ int ocfs2_write_end_nolock(struct address_space *mapping,
 
 static int ocfs2_write_end(struct file *file, struct address_space *mapping,
 			   loff_t pos, unsigned len, unsigned copied,
-			   struct page *page, void *fsdata)
+			   struct folio *folio, void *fsdata)
 {
 	int ret;
 	struct inode *inode = mapping->host;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index e8440fa7d73c..69b507a611f8 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -361,9 +361,9 @@ static int orangefs_write_begin(struct file *file,
 }
 
 static int orangefs_write_end(struct file *file, struct address_space *mapping,
-    loff_t pos, unsigned len, unsigned copied, struct page *page, void *fsdata)
+		loff_t pos, unsigned len, unsigned copied, struct folio *folio,
+		void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = folio->mapping->host;
 	loff_t last_pos = pos + copied;
 
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 33da519c9767..f4b9db4b4df2 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2862,10 +2862,9 @@ static sector_t reiserfs_aop_bmap(struct address_space *as, sector_t block)
 
 static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 			      loff_t pos, unsigned len, unsigned copied,
-			      struct page *page, void *fsdata)
+			      struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	int ret = 0;
 	int update_sd = 0;
 	struct reiserfs_transaction_handle *th;
@@ -2887,7 +2886,7 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 	}
 	flush_dcache_folio(folio);
 
-	reiserfs_commit_page(inode, page, start, start + copied);
+	reiserfs_commit_page(inode, &folio->page, start, start + copied);
 
 	/*
 	 * generic_commit_write does this for us, but does not update the
@@ -2942,8 +2941,8 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 out:
 	if (locked)
 		reiserfs_write_unlock(inode->i_sb);
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (pos + len > inode->i_size)
 		reiserfs_truncate_failed_write(inode);
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 68e104423a48..baa3eecc32fe 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -524,9 +524,8 @@ static void cancel_budget(struct ubifs_info *c, struct folio *folio,
 
 static int ubifs_write_end(struct file *file, struct address_space *mapping,
 			   loff_t pos, unsigned len, unsigned copied,
-			   struct page *page, void *fsdata)
+			   struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4726a4d014b6..fdf024e0b772 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -273,16 +273,14 @@ static int udf_write_begin(struct file *file, struct address_space *mapping,
 
 static int udf_write_end(struct file *file, struct address_space *mapping,
 			 loff_t pos, unsigned len, unsigned copied,
-			 struct page *page, void *fsdata)
+			 struct folio *folio, void *fsdata)
 {
 	struct inode *inode = file_inode(file);
-	struct folio *folio;
 	loff_t last_pos;
 
 	if (UDF_I(inode)->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB)
-		return generic_write_end(file, mapping, pos, len, copied, page,
+		return generic_write_end(file, mapping, pos, len, copied, folio,
 					 fsdata);
-	folio = page_folio(page);
 	last_pos = pos + copied;
 	if (last_pos > inode->i_size)
 		i_size_write(inode, last_pos);
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 0e608fc0d0fd..69adb198c634 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -511,11 +511,11 @@ static int ufs_write_begin(struct file *file, struct address_space *mapping,
 
 static int ufs_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
 	int ret;
 
-	ret = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+	ret = generic_write_end(file, mapping, pos, len, copied, folio, fsdata);
 	if (ret < len)
 		ufs_write_failed(mapping, pos + len);
 	return ret;
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 029f106d56d9..b780deb81b02 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -300,9 +300,8 @@ static int vboxsf_writepage(struct page *page, struct writeback_control *wbc)
 
 static int vboxsf_write_end(struct file *file, struct address_space *mapping,
 			    loff_t pos, unsigned int len, unsigned int copied,
-			    struct page *page, void *fsdata)
+			    struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct vboxsf_handle *sf_handle = file->private_data;
 	size_t from = offset_in_folio(folio, pos);
@@ -314,10 +313,10 @@ static int vboxsf_write_end(struct file *file, struct address_space *mapping,
 	if (!folio_test_uptodate(folio) && copied < len)
 		folio_zero_range(folio, from + copied, len - copied);
 
-	buf = kmap(page);
+	buf = kmap(&folio->page);
 	err = vboxsf_write(sf_handle->root, sf_handle->handle,
 			   pos, &nwritten, buf + from);
-	kunmap(page);
+	kunmap(&folio->page);
 
 	if (err) {
 		nwritten = 0;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 3a3fec154536..165e859664a5 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -265,8 +265,8 @@ int block_write_end(struct file *, struct address_space *,
 				loff_t, unsigned len, unsigned copied,
 				struct folio *, void *);
 int generic_write_end(struct file *, struct address_space *,
-				loff_t, unsigned, unsigned,
-				struct page *, void *);
+				loff_t, unsigned len, unsigned copied,
+				struct folio *, void *);
 void folio_zero_new_buffers(struct folio *folio, size_t from, size_t to);
 int cont_write_begin(struct file *, struct address_space *, loff_t,
 			unsigned, struct page **, void **,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ea3df718c53e..6ff85d72067b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -411,7 +411,7 @@ struct address_space_operations {
 				struct page **pagep, void **fsdata);
 	int (*write_end)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata);
+				struct folio *folio, void *fsdata);
 
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..fab6b0c3044e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4033,7 +4033,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 		flush_dcache_folio(folio);
 
 		status = a_ops->write_end(file, mapping, pos, bytes, copied,
-						page, fsdata);
+						folio, fsdata);
 		if (unlikely(status != copied)) {
 			iov_iter_revert(i, copied - max(status, 0L));
 			if (unlikely(status < 0))
diff --git a/mm/shmem.c b/mm/shmem.c
index 2faa9daaf54b..1116f147d788 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2917,9 +2917,8 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 static int
 shmem_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+			struct folio *folio, void *fsdata)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 
 	if (pos + copied > inode->i_size)
-- 
2.43.0


