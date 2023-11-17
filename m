Return-Path: <linux-fsdevel+bounces-3039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5574D7EF5F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 17:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5EE281381
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDBD41223;
	Fri, 17 Nov 2023 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QdpB+VDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11B5A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 08:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3d07ubN7Lt9CAyL8HyT5gd46gkz7i8yQq9PdgneSji0=; b=QdpB+VDV8/VJP1P6+8acYCvEyG
	zG0if7j0FYaEUIVl8GQZqYcMIXKuAr39vfMcKdSCYYhV47tuUwB0jAoGXq/8DRDGzFwNryLOHPXOW
	ecEvJ5m8eh1YBEYRiD5BLXe52Qb/iAfZd+oMPqvKs4JBBgUJgC7ZMVbYgPJ/Q8FxTKvlgAqrsuW9D
	dK1h1rDqy8RIpfD5tJJetSKVPJwVw40TN6O1DH0ZLx9Qas926Szb/rGmY2VsXQ2UcmHKzbFbCEmKG
	mmRt9seIdIBEVDra5mg0FwojGwHZM7kedcxNXQ07f3lYuxriZ8c187p1uGhRDFZxItLAaZLhkM6UM
	U0DwtgJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r41Uc-00AKcZ-UF; Fri, 17 Nov 2023 16:14:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/6] fs: Convert error_remove_page to error_remove_folio
Date: Fri, 17 Nov 2023 16:14:47 +0000
Message-Id: <20231117161447.2461643-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231117161447.2461643-1-willy@infradead.org>
References: <20231117161447.2461643-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were already assertions that we were not passing a tail page
to error_remove_page(), so make the compiler enforce that by converting
everything to pass and use a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  4 ++--
 Documentation/filesystems/vfs.rst     |  6 +++---
 block/fops.c                          |  2 +-
 fs/afs/write.c                        |  2 +-
 fs/bcachefs/fs.c                      |  2 +-
 fs/btrfs/inode.c                      |  2 +-
 fs/ceph/addr.c                        |  4 ++--
 fs/ext2/inode.c                       |  2 +-
 fs/ext4/inode.c                       |  6 +++---
 fs/f2fs/compress.c                    |  2 +-
 fs/f2fs/inode.c                       |  2 +-
 fs/gfs2/aops.c                        |  4 ++--
 fs/hugetlbfs/inode.c                  |  6 +++---
 fs/nfs/file.c                         |  2 +-
 fs/ntfs/aops.c                        |  6 +++---
 fs/ocfs2/aops.c                       |  2 +-
 fs/xfs/xfs_aops.c                     |  2 +-
 fs/zonefs/file.c                      |  2 +-
 include/linux/fs.h                    |  2 +-
 include/linux/mm.h                    |  3 ++-
 mm/memory-failure.c                   | 10 +++++-----
 mm/shmem.c                            |  6 +++---
 mm/truncate.c                         |  9 ++++-----
 virt/kvm/guest_memfd.c                |  9 +++++----
 24 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 7be2900806c8..421daf837940 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -261,7 +261,7 @@ prototypes::
 			struct folio *src, enum migrate_mode);
 	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate)(struct folio *, size_t from, size_t count);
-	int (*error_remove_page)(struct address_space *, struct page *);
+	int (*error_remove_folio)(struct address_space *, struct folio *);
 	int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
 	int (*swap_deactivate)(struct file *);
 	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
@@ -287,7 +287,7 @@ direct_IO:
 migrate_folio:		yes (both)
 launder_folio:		yes
 is_partially_uptodate:	yes
-error_remove_page:	yes
+error_remove_folio:	yes
 swap_activate:		no
 swap_deactivate:	no
 swap_rw:		yes, unlocks
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 99acc2e98673..dd99ce5912d8 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -823,7 +823,7 @@ cache in your filesystem.  The following members are defined:
 		bool (*is_partially_uptodate) (struct folio *, size_t from,
 					       size_t count);
 		void (*is_dirty_writeback)(struct folio *, bool *, bool *);
-		int (*error_remove_page) (struct mapping *mapping, struct page *page);
+		int (*error_remove_folio)(struct mapping *mapping, struct folio *);
 		int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
 		int (*swap_deactivate)(struct file *);
 		int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
@@ -1034,8 +1034,8 @@ cache in your filesystem.  The following members are defined:
 	VM if a folio should be treated as dirty or writeback for the
 	purposes of stalling.
 
-``error_remove_page``
-	normally set to generic_error_remove_page if truncation is ok
+``error_remove_folio``
+	normally set to generic_error_remove_folio if truncation is ok
 	for this address space.  Used for memory failure handling.
 	Setting this implies you deal with pages going away under you,
 	unless you have them locked or reference counts increased.
diff --git a/block/fops.c b/block/fops.c
index 0abaac705daf..0bdad1e8d514 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -500,7 +500,7 @@ const struct address_space_operations def_blk_aops = {
 	.readahead		= blkdev_readahead,
 	.writepages		= blkdev_writepages,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
-	.error_remove_page	= generic_error_remove_page,
+	.error_remove_folio	= generic_error_remove_folio,
 	.migrate_folio		= filemap_migrate_folio,
 };
 #endif /* CONFIG_BUFFER_HEAD */
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 57d05d67f0c2..e87b52b1f34c 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -242,7 +242,7 @@ static void afs_kill_pages(struct address_space *mapping,
 		folio_clear_uptodate(folio);
 		folio_end_writeback(folio);
 		folio_lock(folio);
-		generic_error_remove_page(mapping, &folio->page);
+		generic_error_remove_folio(mapping, folio);
 		folio_unlock(folio);
 		folio_put(folio);
 
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 74cdd3d85c8a..dc3f6e75703a 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1103,7 +1103,7 @@ static const struct address_space_operations bch_address_space_operations = {
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	= filemap_migrate_folio,
 #endif
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_folio = generic_error_remove_folio,
 };
 
 struct bcachefs_fid {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9f5a9894f88f..ff7b4efca24f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10930,7 +10930,7 @@ static const struct address_space_operations btrfs_aops = {
 	.release_folio	= btrfs_release_folio,
 	.migrate_folio	= btrfs_migrate_folio,
 	.dirty_folio	= filemap_dirty_folio,
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_folio = generic_error_remove_folio,
 	.swap_activate	= btrfs_swap_activate,
 	.swap_deactivate = btrfs_swap_deactivate,
 };
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 85be3bf18cdf..13af429ab030 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -907,8 +907,8 @@ static void writepages_finish(struct ceph_osd_request *req)
 			doutc(cl, "unlocking %p\n", page);
 
 			if (remove_page)
-				generic_error_remove_page(inode->i_mapping,
-							  page);
+				generic_error_remove_folio(inode->i_mapping,
+							  page_folio(page));
 
 			unlock_page(page);
 		}
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 464faf6c217e..5a4272b2c6b0 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -969,7 +969,7 @@ const struct address_space_operations ext2_aops = {
 	.writepages		= ext2_writepages,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate	= block_is_partially_uptodate,
-	.error_remove_page	= generic_error_remove_page,
+	.error_remove_folio	= generic_error_remove_folio,
 };
 
 static const struct address_space_operations ext2_dax_aops = {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 61277f7f8722..d7729b17a66b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3564,7 +3564,7 @@ static const struct address_space_operations ext4_aops = {
 	.direct_IO		= noop_direct_IO,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate  = block_is_partially_uptodate,
-	.error_remove_page	= generic_error_remove_page,
+	.error_remove_folio	= generic_error_remove_folio,
 	.swap_activate		= ext4_iomap_swap_activate,
 };
 
@@ -3581,7 +3581,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.direct_IO		= noop_direct_IO,
 	.migrate_folio		= buffer_migrate_folio_norefs,
 	.is_partially_uptodate  = block_is_partially_uptodate,
-	.error_remove_page	= generic_error_remove_page,
+	.error_remove_folio	= generic_error_remove_folio,
 	.swap_activate		= ext4_iomap_swap_activate,
 };
 
@@ -3598,7 +3598,7 @@ static const struct address_space_operations ext4_da_aops = {
 	.direct_IO		= noop_direct_IO,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate  = block_is_partially_uptodate,
-	.error_remove_page	= generic_error_remove_page,
+	.error_remove_folio	= generic_error_remove_folio,
 	.swap_activate		= ext4_iomap_swap_activate,
 };
 
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 36e5dab6baae..6b2af514660d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1944,7 +1944,7 @@ void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino)
 				continue;
 			}
 
-			generic_error_remove_page(mapping, &folio->page);
+			generic_error_remove_folio(mapping, folio);
 			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 560bfcad1af2..a9eb3891f417 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -600,7 +600,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		inode->i_mapping->a_ops = &f2fs_compress_aops;
 		/*
-		 * generic_error_remove_page only truncates pages of regular
+		 * generic_error_remove_folio only truncates pages of regular
 		 * inode
 		 */
 		inode->i_mode |= S_IFREG;
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index ba8742dc91f8..5cffb079b87c 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -745,7 +745,7 @@ static const struct address_space_operations gfs2_aops = {
 	.bmap = gfs2_bmap,
 	.migrate_folio = filemap_migrate_folio,
 	.is_partially_uptodate = iomap_is_partially_uptodate,
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_folio = generic_error_remove_folio,
 };
 
 static const struct address_space_operations gfs2_jdata_aops = {
@@ -758,7 +758,7 @@ static const struct address_space_operations gfs2_jdata_aops = {
 	.invalidate_folio = gfs2_invalidate_folio,
 	.release_folio = gfs2_release_folio,
 	.is_partially_uptodate = block_is_partially_uptodate,
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_folio = generic_error_remove_folio,
 };
 
 void gfs2_set_aops(struct inode *inode)
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f757d4f7ad98..36132c9125f9 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1129,8 +1129,8 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 #define hugetlbfs_migrate_folio NULL
 #endif
 
-static int hugetlbfs_error_remove_page(struct address_space *mapping,
-				struct page *page)
+static int hugetlbfs_error_remove_folio(struct address_space *mapping,
+				struct folio *folio)
 {
 	return 0;
 }
@@ -1277,7 +1277,7 @@ static const struct address_space_operations hugetlbfs_aops = {
 	.write_end	= hugetlbfs_write_end,
 	.dirty_folio	= noop_dirty_folio,
 	.migrate_folio  = hugetlbfs_migrate_folio,
-	.error_remove_page	= hugetlbfs_error_remove_page,
+	.error_remove_folio	= hugetlbfs_error_remove_folio,
 };
 
 
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 3f9768810427..e8cccb94b927 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -567,7 +567,7 @@ const struct address_space_operations nfs_file_aops = {
 	.migrate_folio = nfs_migrate_folio,
 	.launder_folio = nfs_launder_folio,
 	.is_dirty_writeback = nfs_check_dirty_writeback,
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_folio = generic_error_remove_folio,
 	.swap_activate = nfs_swap_activate,
 	.swap_deactivate = nfs_swap_deactivate,
 	.swap_rw = nfs_swap_rw,
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 71e31e789b29..70479ce915e8 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1644,7 +1644,7 @@ const struct address_space_operations ntfs_normal_aops = {
 	.bmap		= ntfs_bmap,
 	.migrate_folio	= buffer_migrate_folio,
 	.is_partially_uptodate = block_is_partially_uptodate,
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_folio = generic_error_remove_folio,
 };
 
 /*
@@ -1658,7 +1658,7 @@ const struct address_space_operations ntfs_compressed_aops = {
 #endif /* NTFS_RW */
 	.migrate_folio	= buffer_migrate_folio,
 	.is_partially_uptodate = block_is_partially_uptodate,
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_folio = generic_error_remove_folio,
 };
 
 /*
@@ -1673,7 +1673,7 @@ const struct address_space_operations ntfs_mst_aops = {
 #endif /* NTFS_RW */
 	.migrate_folio	= buffer_migrate_folio,
 	.is_partially_uptodate	= block_is_partially_uptodate,
-	.error_remove_page = generic_error_remove_page,
+	.error_remove_folio = generic_error_remove_folio,
 };
 
 #ifdef NTFS_RW
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index ba790219d528..795997806326 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2480,5 +2480,5 @@ const struct address_space_operations ocfs2_aops = {
 	.release_folio		= ocfs2_release_folio,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate	= block_is_partially_uptodate,
-	.error_remove_page	= generic_error_remove_page,
+	.error_remove_folio	= generic_error_remove_folio,
 };
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 465d7630bb21..813f85156b0c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -584,7 +584,7 @@ const struct address_space_operations xfs_address_space_operations = {
 	.bmap			= xfs_vm_bmap,
 	.migrate_folio		= filemap_migrate_folio,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
-	.error_remove_page	= generic_error_remove_page,
+	.error_remove_folio	= generic_error_remove_folio,
 	.swap_activate		= xfs_iomap_swapfile_activate,
 };
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index b2c9b35df8f7..6ab2318a9c8e 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -180,7 +180,7 @@ const struct address_space_operations zonefs_file_aops = {
 	.invalidate_folio	= iomap_invalidate_folio,
 	.migrate_folio		= filemap_migrate_folio,
 	.is_partially_uptodate	= iomap_is_partially_uptodate,
-	.error_remove_page	= generic_error_remove_page,
+	.error_remove_folio	= generic_error_remove_folio,
 	.swap_activate		= zonefs_swap_activate,
 };
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b2a3f1c61c19..0f26cf2fbac8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -434,7 +434,7 @@ struct address_space_operations {
 	bool (*is_partially_uptodate) (struct folio *, size_t from,
 			size_t count);
 	void (*is_dirty_writeback) (struct folio *, bool *dirty, bool *wb);
-	int (*error_remove_page)(struct address_space *, struct page *);
+	int (*error_remove_folio)(struct address_space *, struct folio *);
 
 	/* swapfile support */
 	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64cd1ee4aacc..13a090271716 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2384,7 +2384,8 @@ extern void truncate_pagecache(struct inode *inode, loff_t new);
 extern void truncate_setsize(struct inode *inode, loff_t newsize);
 void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
 void truncate_pagecache_range(struct inode *inode, loff_t offset, loff_t end);
-int generic_error_remove_page(struct address_space *mapping, struct page *page);
+int generic_error_remove_folio(struct address_space *mapping,
+		struct folio *folio);
 
 struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 		unsigned long address, struct pt_regs *regs);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6aec94821fda..d8c853b35dbb 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -927,13 +927,13 @@ static int delete_from_lru_cache(struct folio *folio)
 	return -EIO;
 }
 
-static int truncate_error_page(struct folio *folio, unsigned long pfn,
+static int truncate_error_folio(struct folio *folio, unsigned long pfn,
 				struct address_space *mapping)
 {
 	int ret = MF_FAILED;
 
-	if (mapping->a_ops->error_remove_page) {
-		int err = mapping->a_ops->error_remove_page(mapping, &folio->page);
+	if (mapping->a_ops->error_remove_folio) {
+		int err = mapping->a_ops->error_remove_folio(mapping, folio);
 
 		if (err != 0)
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
@@ -1054,7 +1054,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 	 *
 	 * Open: to take i_rwsem or not for this? Right now we don't.
 	 */
-	ret = truncate_error_page(folio, page_to_pfn(p), mapping);
+	ret = truncate_error_folio(folio, page_to_pfn(p), mapping);
 	if (has_extra_refcount(ps, p, extra_pins))
 		ret = MF_FAILED;
 
@@ -1188,7 +1188,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 
 	mapping = folio_mapping(folio);
 	if (mapping) {
-		res = truncate_error_page(folio, page_to_pfn(p), mapping);
+		res = truncate_error_folio(folio, page_to_pfn(p), mapping);
 		/* The page is kept in page cache. */
 		extra_pins = true;
 		folio_unlock(folio);
diff --git a/mm/shmem.c b/mm/shmem.c
index 0d1ce70bce38..c62f904ba1ca 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4462,8 +4462,8 @@ static void __init shmem_destroy_inodecache(void)
 }
 
 /* Keep the page in page cache instead of truncating it */
-static int shmem_error_remove_page(struct address_space *mapping,
-				   struct page *page)
+static int shmem_error_remove_folio(struct address_space *mapping,
+				   struct folio *folio)
 {
 	return 0;
 }
@@ -4478,7 +4478,7 @@ const struct address_space_operations shmem_aops = {
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	= migrate_folio,
 #endif
-	.error_remove_page = shmem_error_remove_page,
+	.error_remove_folio = shmem_error_remove_folio,
 };
 EXPORT_SYMBOL(shmem_aops);
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 52e3a703e7b2..725b150e47ac 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -250,10 +250,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 /*
  * Used to get rid of pages on hardware memory corruption.
  */
-int generic_error_remove_page(struct address_space *mapping, struct page *page)
+int generic_error_remove_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
-
 	if (!mapping)
 		return -EINVAL;
 	/*
@@ -262,9 +261,9 @@ int generic_error_remove_page(struct address_space *mapping, struct page *page)
 	 */
 	if (!S_ISREG(mapping->host->i_mode))
 		return -EIO;
-	return truncate_inode_folio(mapping, page_folio(page));
+	return truncate_inode_folio(mapping, folio);
 }
-EXPORT_SYMBOL(generic_error_remove_page);
+EXPORT_SYMBOL(generic_error_remove_folio);
 
 /**
  * mapping_evict_folio() - Remove an unused folio from the page-cache.
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b99272396119..451435123fe7 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -267,7 +267,8 @@ static int kvm_gmem_migrate_folio(struct address_space *mapping,
 	return -EINVAL;
 }
 
-static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
+static int kvm_gmem_error_folio(struct address_space *mapping,
+		struct folio *folio)
 {
 	struct list_head *gmem_list = &mapping->private_list;
 	struct kvm_gmem *gmem;
@@ -275,8 +276,8 @@ static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
 
 	filemap_invalidate_lock_shared(mapping);
 
-	start = page->index;
-	end = start + thp_nr_pages(page);
+	start = folio->index;
+	end = start + folio_nr_pages(folio);
 
 	list_for_each_entry(gmem, gmem_list, entry)
 		kvm_gmem_invalidate_begin(gmem, start, end);
@@ -303,7 +304,7 @@ static const struct address_space_operations kvm_gmem_aops = {
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	= kvm_gmem_migrate_folio,
 #endif
-	.error_remove_page = kvm_gmem_error_page,
+	.error_remove_folio = kvm_gmem_error_folio,
 };
 
 static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *path,
-- 
2.42.0


