Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D922DC652
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgLPSZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbgLPSZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218CC0619D4;
        Wed, 16 Dec 2020 10:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cXG7kJK3meM8MQd2jvgIHsE5lHkaGClp2jmn9lL0VAk=; b=Km5X7euC6WK1VBPHQ4OzCXLPM9
        tFTM3oebxJZHI0sWWWGPhpNNBbOeoP/c8EkgkXvGtgoIMO2Qp89VQslpXiH68DQBRNvnZYL59ZAf8
        /vW8gcf2tzhXbwvRpm9htaQt4XKvRliW1oAn4owvGWIPsM2bvI/9LlE70gA+t40l6Eqhs0bGS/K73
        9jlMPMq4b0q6VYUVdipd9xQTC7rymOlJkvw+j+TSUreikoMgt2y9EJctRqmJFESzcojj7fnxMzxYP
        DzDsr5vRVBm3eH8Ift1cUgDjwHYAyl6+faZLpxLRkcfQZ0rS2CmIoCmilR2Jwq4NfNX4eyYpr2krn
        uUPrz6+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSh-00078e-MH; Wed, 16 Dec 2020 18:23:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/25] fs: Change readpage to take a folio
Date:   Wed, 16 Dec 2020 18:23:30 +0000
Message-Id: <20201216182335.27227-21-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We track the uptodate state on the entire folio, not individual
pages.  That means the readpage should be passed a folio and told
to update the entire folio.  Filesystems will not have multi-page
folios created for them until they indicate support for them by
setting the FS_MULTI_PAGE_FOLIO flag.  Until they do, they can
assume that the folio being passed in contains a single page.

Also convert filler_t to take a folio as these two are tightly
intertwined.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/vfs.rst     | 18 ++++++++++--------
 fs/9p/vfs_addr.c                      |  9 +++++----
 fs/adfs/inode.c                       |  4 ++--
 fs/affs/file.c                        |  8 ++++----
 fs/affs/symlink.c                     |  3 ++-
 fs/afs/file.c                         |  5 +++--
 fs/befs/linuxvfs.c                    | 23 +++++++++++------------
 fs/bfs/file.c                         |  4 ++--
 fs/block_dev.c                        |  4 ++--
 fs/btrfs/ctree.h                      |  2 +-
 fs/btrfs/file.c                       | 13 +++++++------
 fs/btrfs/free-space-cache.c           |  9 +++++----
 fs/btrfs/inode.c                      | 16 +++++++++-------
 fs/btrfs/ioctl.c                      | 11 ++++++-----
 fs/btrfs/relocation.c                 | 11 ++++++-----
 fs/btrfs/send.c                       | 11 ++++++-----
 fs/buffer.c                           | 12 +++++++-----
 fs/cachefiles/rdwr.c                  | 11 ++++++-----
 fs/ceph/addr.c                        |  6 +++---
 fs/cifs/file.c                        |  3 ++-
 fs/coda/symlink.c                     |  3 ++-
 fs/cramfs/inode.c                     |  3 ++-
 fs/ecryptfs/mmap.c                    |  3 ++-
 fs/efs/inode.c                        |  4 ++--
 fs/efs/symlink.c                      |  3 ++-
 fs/erofs/data.c                       |  3 ++-
 fs/erofs/zdata.c                      |  3 ++-
 fs/exfat/inode.c                      |  4 ++--
 fs/ext2/inode.c                       |  4 ++--
 fs/ext4/ext4.h                        |  2 +-
 fs/ext4/inode.c                       | 10 +++++-----
 fs/ext4/readpage.c                    | 26 ++++++++++++++------------
 fs/f2fs/data.c                        |  3 ++-
 fs/fat/inode.c                        |  4 ++--
 fs/freevxfs/vxfs_immed.c              |  7 ++++---
 fs/freevxfs/vxfs_subr.c               |  7 +++----
 fs/fuse/dir.c                         |  8 ++++----
 fs/fuse/file.c                        |  3 ++-
 fs/gfs2/aops.c                        | 13 +++++++------
 fs/hfs/inode.c                        |  4 ++--
 fs/hfsplus/inode.c                    |  4 ++--
 fs/hpfs/file.c                        |  4 ++--
 fs/hpfs/namei.c                       |  3 ++-
 fs/iomap/buffered-io.c                | 10 +++++-----
 fs/isofs/compress.c                   |  3 ++-
 fs/isofs/inode.c                      |  4 ++--
 fs/isofs/rock.c                       |  3 ++-
 fs/jffs2/file.c                       | 20 +++++++++++---------
 fs/jffs2/os-linux.h                   |  2 +-
 fs/jfs/inode.c                        |  4 ++--
 fs/jfs/jfs_metapage.c                 |  3 ++-
 fs/libfs.c                            | 10 +++++-----
 fs/minix/inode.c                      |  4 ++--
 fs/mpage.c                            |  6 +++---
 fs/nfs/file.c                         |  5 +++--
 fs/nfs/read.c                         |  7 ++++---
 fs/nfs/symlink.c                      | 12 ++++++------
 fs/nilfs2/inode.c                     |  4 ++--
 fs/ntfs/aops.c                        |  3 ++-
 fs/ocfs2/aops.c                       | 14 +++++++-------
 fs/ocfs2/refcounttree.c               |  5 +++--
 fs/ocfs2/symlink.c                    |  3 ++-
 fs/omfs/file.c                        |  4 ++--
 fs/orangefs/inode.c                   |  3 ++-
 fs/qnx4/inode.c                       |  4 ++--
 fs/qnx6/inode.c                       |  4 ++--
 fs/reiserfs/inode.c                   |  4 ++--
 fs/romfs/super.c                      |  3 ++-
 fs/squashfs/file.c                    |  3 ++-
 fs/squashfs/symlink.c                 |  3 ++-
 fs/sysv/itree.c                       |  4 ++--
 fs/ubifs/file.c                       |  8 ++++----
 fs/udf/file.c                         |  8 ++++----
 fs/udf/inode.c                        |  4 ++--
 fs/udf/symlink.c                      |  3 ++-
 fs/ufs/inode.c                        |  4 ++--
 fs/vboxsf/file.c                      |  3 ++-
 fs/xfs/xfs_aops.c                     |  4 ++--
 fs/zonefs/super.c                     |  4 ++--
 include/linux/buffer_head.h           |  2 +-
 include/linux/fs.h                    |  4 ++--
 include/linux/iomap.h                 |  2 +-
 include/linux/mpage.h                 |  2 +-
 include/linux/nfs_fs.h                |  2 +-
 include/linux/pagemap.h               |  2 +-
 mm/filemap.c                          | 19 +++++++------------
 mm/page_io.c                          |  2 +-
 mm/readahead.c                        |  6 +++---
 89 files changed, 292 insertions(+), 254 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index c0f2c7586531..13a7a1278200 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -236,7 +236,7 @@ address_space_operations
 prototypes::
 
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
+	int (*readpage)(struct file *, struct folio *);
 	int (*writepages)(struct address_space *, struct writeback_control *);
 	int (*set_page_dirty)(struct page *page);
 	void (*readahead)(struct readahead_control *);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 5ac42b93225c..fee05c6e71f7 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -703,7 +703,7 @@ cache in your filesystem.  The following members are defined:
 
 	struct address_space_operations {
 		int (*writepage)(struct page *page, struct writeback_control *wbc);
-		int (*readpage)(struct file *, struct page *);
+		int (*readpage)(struct file *, struct folio *);
 		int (*writepages)(struct address_space *, struct writeback_control *);
 		int (*set_page_dirty)(struct page *page);
 		void (*readahead)(struct readahead_control *);
@@ -756,13 +756,15 @@ cache in your filesystem.  The following members are defined:
 	See the file "Locking" for more details.
 
 ``readpage``
-	called by the VM to read a page from backing store.  The page
-	will be Locked when readpage is called, and should be unlocked
-	and marked uptodate once the read completes.  If ->readpage
-	discovers that it needs to unlock the page for some reason, it
-	can do so, and then return AOP_TRUNCATED_PAGE.  In this case,
-	the page will be relocated, relocked and if that all succeeds,
-	->readpage will be called again.
+	Called by the VM to read a folio from the backing store.  If the
+	filesystem has not indicated that it can handle multi-page
+	folios by setting FS_MULTI_PAGE_FOLIOS, the folio will contain
+	one page.  The folio will be Locked when readpage is called, and
+	should be unlocked and marked uptodate once the read completes.
+	If ->readpage discovers that it needs to unlock the folio for
+	some reason, it can do so, and then return AOP_TRUNCATED_PAGE.
+	In this case, the caller will attempt to look up the page and
+	call ->readpage again.
 
 ``writepages``
 	called by the VM to write out pages associated with the
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index cce9ace651a2..db31b25c6282 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -35,8 +35,9 @@
  * @page: structure to page
  *
  */
-static int v9fs_fid_readpage(void *data, struct page *page)
+static int v9fs_fid_readpage(void *data, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct p9_fid *fid = data;
 	struct inode *inode = page->mapping->host;
 	struct bio_vec bvec = {.bv_page = page, .bv_len = PAGE_SIZE};
@@ -80,9 +81,9 @@ static int v9fs_fid_readpage(void *data, struct page *page)
  *
  */
 
-static int v9fs_vfs_readpage(struct file *filp, struct page *page)
+static int v9fs_vfs_readpage(struct file *filp, struct folio *folio)
 {
-	return v9fs_fid_readpage(filp->private_data, page);
+	return v9fs_fid_readpage(filp->private_data, folio);
 }
 
 /**
@@ -279,7 +280,7 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
 	if (len == PAGE_SIZE)
 		goto out;
 
-	retval = v9fs_fid_readpage(v9inode->writeback_fid, page);
+	retval = v9fs_fid_readpage(v9inode->writeback_fid, page_folio(page));
 	put_page(page);
 	if (!retval)
 		goto start;
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 32620f4a7623..aaf9f749a4ab 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -38,9 +38,9 @@ static int adfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, adfs_get_block, wbc);
 }
 
-static int adfs_readpage(struct file *file, struct page *page)
+static int adfs_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, adfs_get_block);
+	return block_read_full_page(folio, adfs_get_block);
 }
 
 static void adfs_write_failed(struct address_space *mapping, loff_t to)
diff --git a/fs/affs/file.c b/fs/affs/file.c
index d91b0133d95d..0c3b614b16a1 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -375,9 +375,9 @@ static int affs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, affs_get_block, wbc);
 }
 
-static int affs_readpage(struct file *file, struct page *page)
+static int affs_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, affs_get_block);
+	return block_read_full_page(folio, affs_get_block);
 }
 
 static void affs_write_failed(struct address_space *mapping, loff_t to)
@@ -626,9 +626,9 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 	return PTR_ERR(bh);
 }
 
-static int
-affs_readpage_ofs(struct file *file, struct page *page)
+static int affs_readpage_ofs(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	u32 to;
 	int err;
diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
index a7531b26e8f0..01d30f8ef0dd 100644
--- a/fs/affs/symlink.c
+++ b/fs/affs/symlink.c
@@ -11,8 +11,9 @@
 
 #include "affs.h"
 
-static int affs_symlink_readpage(struct file *file, struct page *page)
+static int affs_symlink_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct buffer_head *bh;
 	struct inode *inode = page->mapping->host;
 	char *link = page_address(page);
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 85f5adf21aa0..a4cd8b9f7806 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -17,7 +17,7 @@
 #include "internal.h"
 
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
-static int afs_readpage(struct file *file, struct page *page);
+static int afs_readpage(struct file *file, struct folio *folio);
 static void afs_invalidatepage(struct page *page, unsigned int offset,
 			       unsigned int length);
 static int afs_releasepage(struct page *page, gfp_t gfp_flags);
@@ -389,8 +389,9 @@ int afs_page_filler(void *data, struct page *page)
  * read page from file, directory or symlink, given a file to nominate the key
  * to be used
  */
-static int afs_readpage(struct file *file, struct page *page)
+static int afs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct key *key;
 	int ret;
 
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index c1ba13d19024..fb397f0433f4 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -40,7 +40,7 @@ MODULE_LICENSE("GPL");
 
 static int befs_readdir(struct file *, struct dir_context *);
 static int befs_get_block(struct inode *, sector_t, struct buffer_head *, int);
-static int befs_readpage(struct file *file, struct page *page);
+static int befs_readpage(struct file *file, struct folio *folio);
 static sector_t befs_bmap(struct address_space *mapping, sector_t block);
 static struct dentry *befs_lookup(struct inode *, struct dentry *,
 				  unsigned int);
@@ -48,7 +48,7 @@ static struct inode *befs_iget(struct super_block *, unsigned long);
 static struct inode *befs_alloc_inode(struct super_block *sb);
 static void befs_free_inode(struct inode *inode);
 static void befs_destroy_inodecache(void);
-static int befs_symlink_readpage(struct file *, struct page *);
+static int befs_symlink_readpage(struct file *, struct folio *);
 static int befs_utf2nls(struct super_block *sb, const char *in, int in_len,
 			char **out, int *out_len);
 static int befs_nls2utf(struct super_block *sb, const char *in, int in_len,
@@ -108,10 +108,9 @@ static const struct export_operations befs_export_operations = {
  * passes it the address of befs_get_block, for mapping file
  * positions to disk blocks.
  */
-static int
-befs_readpage(struct file *file, struct page *page)
+static int befs_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, befs_get_block);
+	return block_read_full_page(folio, befs_get_block);
 }
 
 static sector_t
@@ -468,14 +467,14 @@ befs_destroy_inodecache(void)
  * The data stream become link name. Unless the LONG_SYMLINK
  * flag is set.
  */
-static int befs_symlink_readpage(struct file *unused, struct page *page)
+static int befs_symlink_readpage(struct file *unused, struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->page.mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct befs_inode_info *befs_ino = BEFS_I(inode);
 	befs_data_stream *data = &befs_ino->i_data.ds;
 	befs_off_t len = data->size;
-	char *link = page_address(page);
+	char *link = page_address(&folio->page);
 
 	if (len == 0 || len > PAGE_SIZE) {
 		befs_error(sb, "Long symlink with illegal length");
@@ -488,12 +487,12 @@ static int befs_symlink_readpage(struct file *unused, struct page *page)
 		goto fail;
 	}
 	link[len - 1] = '\0';
-	SetPageUptodate(page);
-	unlock_page(page);
+	SetFolioUptodate(folio);
+	unlock_folio(folio);
 	return 0;
 fail:
-	SetPageError(page);
-	unlock_page(page);
+	SetFolioError(folio);
+	unlock_folio(folio);
 	return -EIO;
 }
 
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 0dceefc54b48..852f98af446f 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -155,9 +155,9 @@ static int bfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, bfs_get_block, wbc);
 }
 
-static int bfs_readpage(struct file *file, struct page *page)
+static int bfs_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, bfs_get_block);
+	return block_read_full_page(folio, bfs_get_block);
 }
 
 static void bfs_write_failed(struct address_space *mapping, loff_t to)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e56ee1f2652..932cb795e3d6 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -617,9 +617,9 @@ static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, blkdev_get_block, wbc);
 }
 
-static int blkdev_readpage(struct file * file, struct page * page)
+static int blkdev_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, blkdev_get_block);
+	return block_read_full_page(folio, blkdev_get_block);
 }
 
 static void blkdev_readahead(struct readahead_control *rac)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 45f8c5797aca..bdde4582479d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3102,7 +3102,7 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 			     unsigned long bio_flags);
 void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
-int btrfs_readpage(struct file *file, struct page *page);
+int btrfs_readpage(struct file *file, struct folio *folio);
 void btrfs_evict_inode(struct inode *inode);
 int btrfs_write_inode(struct inode *inode, struct writeback_control *wbc);
 struct inode *btrfs_alloc_inode(struct super_block *sb);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e41459b8de6..a88b18bb37f1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1331,16 +1331,17 @@ static int prepare_uptodate_page(struct inode *inode,
 
 	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
 	    !PageUptodate(page)) {
-		ret = btrfs_readpage(NULL, page);
+		struct folio *folio = page_folio(page);
+		ret = btrfs_readpage(NULL, folio);
 		if (ret)
 			return ret;
-		lock_page(page);
-		if (!PageUptodate(page)) {
-			unlock_page(page);
+		lock_folio(folio);
+		if (!FolioUptodate(folio)) {
+			unlock_folio(folio);
 			return -EIO;
 		}
-		if (page->mapping != inode->i_mapping) {
-			unlock_page(page);
+		if (folio->page.mapping != inode->i_mapping) {
+			unlock_folio(folio);
 			return -EAGAIN;
 		}
 	}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 71d0d14bc18b..ca0fef79ce6c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -438,15 +438,16 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 		}
 		io_ctl->pages[i] = page;
 		if (uptodate && !PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
-			lock_page(page);
-			if (page->mapping != inode->i_mapping) {
+			struct folio *folio = page_folio(page);
+			btrfs_readpage(NULL, folio);
+			lock_folio(folio);
+			if (folio->page.mapping != inode->i_mapping) {
 				btrfs_err(BTRFS_I(inode)->root->fs_info,
 					  "free space cache page truncated");
 				io_ctl_drop_pages(io_ctl);
 				return -EIO;
 			}
-			if (!PageUptodate(page)) {
+			if (!FolioUptodate(folio)) {
 				btrfs_err(BTRFS_I(inode)->root->fs_info,
 					   "error reading free space cache");
 				io_ctl_drop_pages(io_ctl);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 070716650df8..ce9eea76135a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4722,14 +4722,15 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	}
 
 	if (!PageUptodate(page)) {
-		ret = btrfs_readpage(NULL, page);
-		lock_page(page);
-		if (page->mapping != mapping) {
-			unlock_page(page);
-			put_page(page);
+		struct folio *folio = page_folio(page);
+		ret = btrfs_readpage(NULL, folio);
+		lock_folio(folio);
+		if (folio->page.mapping != mapping) {
+			unlock_folio(folio);
+			put_folio(folio);
 			goto again;
 		}
-		if (!PageUptodate(page)) {
+		if (!FolioUptodate(folio)) {
 			ret = -EIO;
 			goto out_unlock;
 		}
@@ -8060,8 +8061,9 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
 }
 
-int btrfs_readpage(struct file *file, struct page *page)
+int btrfs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dde49a791f3e..cab05b00e91e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1347,11 +1347,12 @@ static int cluster_pages_for_defrag(struct inode *inode,
 		}
 
 		if (!PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
-			lock_page(page);
-			if (!PageUptodate(page)) {
-				unlock_page(page);
-				put_page(page);
+			struct folio *folio = page_folio(page);
+			btrfs_readpage(NULL, folio);
+			lock_folio(folio);
+			if (!FolioUptodate(folio)) {
+				unlock_folio(folio);
+				put_folio(folio);
 				ret = -EIO;
 				break;
 			}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19b7db8b2117..e66039c13e3a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2687,11 +2687,12 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 
 		if (!PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
-			lock_page(page);
-			if (!PageUptodate(page)) {
-				unlock_page(page);
-				put_page(page);
+			struct folio *folio = page_folio(page);
+			btrfs_readpage(NULL, folio);
+			lock_folio(folio);
+			if (!FolioUptodate(folio)) {
+				unlock_folio(folio);
+				put_folio(folio);
 				btrfs_delalloc_release_metadata(BTRFS_I(inode),
 							PAGE_SIZE, true);
 				btrfs_delalloc_release_extents(BTRFS_I(inode),
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d719a2755a40..8f803297459f 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4978,11 +4978,12 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 		}
 
 		if (!PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
-			lock_page(page);
-			if (!PageUptodate(page)) {
-				unlock_page(page);
-				put_page(page);
+			struct folio *folio = page_folio(page);
+			btrfs_readpage(NULL, folio);
+			lock_folio(folio);
+			if (!FolioUptodate(folio)) {
+				unlock_folio(folio);
+				put_folio(folio);
 				ret = -EIO;
 				break;
 			}
diff --git a/fs/buffer.c b/fs/buffer.c
index 96c7604f69b3..f7b62b69f33d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2293,8 +2293,9 @@ EXPORT_SYMBOL(block_is_partially_uptodate);
  * set/clear_buffer_uptodate() functions propagate buffer state into the
  * page struct once IO has completed.
  */
-int block_read_full_page(struct page *page, get_block_t *get_block)
+int block_read_full_page(struct folio *folio, get_block_t *get_block)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	sector_t iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
@@ -2882,13 +2883,14 @@ int nobh_truncate_page(struct address_space *mapping,
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
 	if (!PageUptodate(page)) {
-		err = mapping->a_ops->readpage(NULL, page);
+		struct folio *folio = page_folio(page);
+		err = mapping->a_ops->readpage(NULL, folio);
 		if (err) {
-			put_page(page);
+			put_folio(folio);
 			goto out;
 		}
-		lock_page(page);
-		if (!PageUptodate(page)) {
+		lock_folio(folio);
+		if (!FolioUptodate(folio)) {
 			err = -EIO;
 			goto unlock;
 		}
diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 268fbcac4afb..f2a858d71927 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -111,15 +111,16 @@ static int cachefiles_read_reissue(struct cachefiles_object *object,
 	add_page_wait_queue(backpage, &monitor->monitor);
 
 	if (trylock_page(backpage)) {
+		struct folio *folio = page_folio(backpage);
 		ret = -EIO;
-		if (PageError(backpage))
+		if (FolioError(folio))
 			goto unlock_discard;
 		ret = 0;
-		if (PageUptodate(backpage))
+		if (FolioUptodate(folio))
 			goto unlock_discard;
 
 		_debug("reissue read");
-		ret = bmapping->a_ops->readpage(NULL, backpage);
+		ret = bmapping->a_ops->readpage(NULL, folio);
 		if (ret < 0)
 			goto discard;
 	}
@@ -282,7 +283,7 @@ static int cachefiles_read_backing_file_one(struct cachefiles_object *object,
 	newpage = NULL;
 
 read_backing_page:
-	ret = bmapping->a_ops->readpage(NULL, backpage);
+	ret = bmapping->a_ops->readpage(NULL, page_folio(backpage));
 	if (ret < 0)
 		goto read_error;
 
@@ -522,7 +523,7 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
 		newpage = NULL;
 
 	reread_backing_page:
-		ret = bmapping->a_ops->readpage(NULL, backpage);
+		ret = bmapping->a_ops->readpage(NULL, page_folio(backpage));
 		if (ret < 0)
 			goto read_error;
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 5b2873b12904..1bcd7bf20930 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -259,11 +259,11 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
 	return err < 0 ? err : 0;
 }
 
-static int ceph_readpage(struct file *filp, struct page *page)
+static int ceph_readpage(struct file *filp, struct folio *folio)
 {
-	int r = ceph_do_readpage(filp, page);
+	int r = ceph_do_readpage(filp, &folio->page);
 	if (r != -EINPROGRESS)
-		unlock_page(page);
+		unlock_folio(folio);
 	else
 		r = 0;
 	return r;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 6d001905c8e5..cf806c7331aa 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4553,8 +4553,9 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 	return rc;
 }
 
-static int cifs_readpage(struct file *file, struct page *page)
+static int cifs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	loff_t offset = (loff_t)page->index << PAGE_SHIFT;
 	int rc = -EACCES;
 	unsigned int xid;
diff --git a/fs/coda/symlink.c b/fs/coda/symlink.c
index 8907d0508198..966053c1c523 100644
--- a/fs/coda/symlink.c
+++ b/fs/coda/symlink.c
@@ -20,8 +20,9 @@
 #include "coda_psdev.h"
 #include "coda_linux.h"
 
-static int coda_symlink_filler(struct file *file, struct page *page)
+static int coda_symlink_filler(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	int error;
 	struct coda_inode_info *cii;
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 4b90cfd1ec36..991650846605 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -816,8 +816,9 @@ static struct dentry *cramfs_lookup(struct inode *dir, struct dentry *dentry, un
 	return d_splice_alias(inode, dentry);
 }
 
-static int cramfs_readpage(struct file *file, struct page *page)
+static int cramfs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	u32 maxblock;
 	int bytes_filled;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 019572c6b39a..38f89b6f8095 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -177,8 +177,9 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
  *
  * Returns zero on success; non-zero on error.
  */
-static int ecryptfs_readpage(struct file *file, struct page *page)
+static int ecryptfs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct ecryptfs_crypt_stat *crypt_stat =
 		&ecryptfs_inode_to_private(page->mapping->host)->crypt_stat;
 	int rc = 0;
diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 89e73a6f0d36..28d85bc27cce 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -14,9 +14,9 @@
 #include "efs.h"
 #include <linux/efs_fs_sb.h>
 
-static int efs_readpage(struct file *file, struct page *page)
+static int efs_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page,efs_get_block);
+	return block_read_full_page(folio, efs_get_block);
 }
 static sector_t _efs_bmap(struct address_space *mapping, sector_t block)
 {
diff --git a/fs/efs/symlink.c b/fs/efs/symlink.c
index 923eb91654d5..3f6d9c8786a4 100644
--- a/fs/efs/symlink.c
+++ b/fs/efs/symlink.c
@@ -12,8 +12,9 @@
 #include <linux/buffer_head.h>
 #include "efs.h"
 
-static int efs_symlink_readpage(struct file *file, struct page *page)
+static int efs_symlink_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	char *link = page_address(page);
 	struct buffer_head * bh;
 	struct inode * inode = page->mapping->host;
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index ba6deef9a4cc..be148c090046 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -261,8 +261,9 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
  * since we dont have write or truncate flows, so no inode
  * locking needs to be held at the moment.
  */
-static int erofs_raw_access_readpage(struct file *file, struct page *page)
+static int erofs_raw_access_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	erofs_off_t last_block;
 	struct bio *bio;
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f83ddf5fd1b1..bcee824b82cb 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1299,8 +1299,9 @@ static void z_erofs_runqueue(struct super_block *sb,
 	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
 }
 
-static int z_erofs_readpage(struct file *file, struct page *page)
+static int z_erofs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *const inode = page->mapping->host;
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	int err;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 730373e0965a..94292c163c00 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -357,9 +357,9 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	return err;
 }
 
-static int exfat_readpage(struct file *file, struct page *page)
+static int exfat_readpage(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, exfat_get_block);
+	return mpage_readpage(folio, exfat_get_block);
 }
 
 static void exfat_readahead(struct readahead_control *rac)
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 78c417d3c898..a57a7a25db45 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -869,9 +869,9 @@ static int ext2_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, ext2_get_block, wbc);
 }
 
-static int ext2_readpage(struct file *file, struct page *page)
+static int ext2_readpage(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, ext2_get_block);
+	return mpage_readpage(folio, ext2_get_block);
 }
 
 static void ext2_readahead(struct readahead_control *rac)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 22f80efbe3a4..65454096cf74 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3525,7 +3525,7 @@ static inline void ext4_set_de_type(struct super_block *sb,
 
 /* readpages.c */
 extern int ext4_mpage_readpages(struct inode *inode,
-		struct readahead_control *rac, struct page *page);
+		struct readahead_control *rac, struct folio *folio);
 extern int __init ext4_init_post_read_processing(void);
 extern void ext4_exit_post_read_processing(void);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b147c2e20469..50b91a16ce19 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3225,18 +3225,18 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 	return iomap_bmap(mapping, block, &ext4_iomap_ops);
 }
 
-static int ext4_readpage(struct file *file, struct page *page)
+static int ext4_readpage(struct file *file, struct folio *folio)
 {
 	int ret = -EAGAIN;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->page.mapping->host;
 
-	trace_ext4_readpage(page);
+	trace_ext4_readpage(&folio->page);
 
 	if (ext4_has_inline_data(inode))
-		ret = ext4_readpage_inline(inode, page);
+		ret = ext4_readpage_inline(inode, &folio->page);
 
 	if (ret == -EAGAIN)
-		return ext4_mpage_readpages(inode, NULL, page);
+		return ext4_mpage_readpages(inode, NULL, folio);
 
 	return ret;
 }
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 6f5724d80a01..fd6e5f3b7ba7 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -222,8 +222,9 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
 }
 
 int ext4_mpage_readpages(struct inode *inode,
-		struct readahead_control *rac, struct page *page)
+		struct readahead_control *rac, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
 
@@ -252,7 +253,8 @@ int ext4_mpage_readpages(struct inode *inode,
 		unsigned first_hole = blocks_per_page;
 
 		if (rac) {
-			page = &readahead_folio(rac)->page;
+			folio = readahead_folio(rac);
+			page = &folio->page;
 			prefetchw(&page->flags);
 		}
 
@@ -303,10 +305,10 @@ int ext4_mpage_readpages(struct inode *inode,
 
 				if (ext4_map_blocks(NULL, inode, &map, 0) < 0) {
 				set_error_page:
-					SetPageError(page);
+					SetFolioError(folio);
 					zero_user_segment(page, 0,
 							  PAGE_SIZE);
-					unlock_page(page);
+					unlock_folio(folio);
 					continue;
 				}
 			}
@@ -343,16 +345,16 @@ int ext4_mpage_readpages(struct inode *inode,
 				if (ext4_need_verity(inode, page->index) &&
 				    !fsverity_verify_page(page))
 					goto set_error_page;
-				SetPageUptodate(page);
-				unlock_page(page);
+				SetFolioUptodate(folio);
+				unlock_folio(folio);
 				continue;
 			}
 		} else if (fully_mapped) {
-			SetPageMappedToDisk(page);
+			SetFolioMappedToDisk(folio);
 		}
 		if (fully_mapped && blocks_per_page == 1 &&
-		    !PageUptodate(page) && cleancache_get_page(page) == 0) {
-			SetPageUptodate(page);
+		    !FolioUptodate(folio) && cleancache_get_page(page) == 0) {
+			SetFolioUptodate(folio);
 			goto confused;
 		}
 
@@ -400,10 +402,10 @@ int ext4_mpage_readpages(struct inode *inode,
 			submit_bio(bio);
 			bio = NULL;
 		}
-		if (!PageUptodate(page))
-			block_read_full_page(page, ext4_get_block);
+		if (!FolioUptodate(folio))
+			block_read_full_page(folio, ext4_get_block);
 		else
-			unlock_page(page);
+			unlock_folio(folio);
 	}
 	if (bio)
 		submit_bio(bio);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2397bfd1a88d..654a79f5e4ea 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2458,8 +2458,9 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	return ret;
 }
 
-static int f2fs_read_data_page(struct file *file, struct page *page)
+static int f2fs_read_data_page(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page_file_mapping(page)->host;
 	int ret = -EAGAIN;
 
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index bab9b202b496..9d55d47a28df 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -205,9 +205,9 @@ static int fat_writepages(struct address_space *mapping,
 	return mpage_writepages(mapping, wbc, fat_get_block);
 }
 
-static int fat_readpage(struct file *file, struct page *page)
+static int fat_readpage(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, fat_get_block);
+	return mpage_readpage(folio, fat_get_block);
 }
 
 static void fat_readahead(struct readahead_control *rac)
diff --git a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
index bfc780c682fb..69c05606d904 100644
--- a/fs/freevxfs/vxfs_immed.c
+++ b/fs/freevxfs/vxfs_immed.c
@@ -38,7 +38,7 @@
 #include "vxfs_inode.h"
 
 
-static int	vxfs_immed_readpage(struct file *, struct page *);
+static int	vxfs_immed_readpage(struct file *, struct folio *);
 
 /*
  * Address space operations for immed files and directories.
@@ -50,7 +50,7 @@ const struct address_space_operations vxfs_immed_aops = {
 /**
  * vxfs_immed_readpage - read part of an immed inode into pagecache
  * @file:	file context (unused)
- * @page:	page frame to fill in.
+ * @folio:	folio to fill in.
  *
  * Description:
  *   vxfs_immed_readpage reads a part of the immed area of the
@@ -63,8 +63,9 @@ const struct address_space_operations vxfs_immed_aops = {
  *   @page is locked and will be unlocked.
  */
 static int
-vxfs_immed_readpage(struct file *fp, struct page *pp)
+vxfs_immed_readpage(struct file *fp, struct folio *folio)
 {
+	struct page *pp = &folio->page;
 	struct vxfs_inode_info	*vip = VXFS_INO(pp->mapping->host);
 	u_int64_t	offset = (u_int64_t)pp->index << PAGE_SHIFT;
 	caddr_t		kaddr;
diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
index e806694d4145..1b68210ab859 100644
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -38,7 +38,7 @@
 #include "vxfs_extern.h"
 
 
-static int		vxfs_readpage(struct file *, struct page *);
+static int		vxfs_readpage(struct file *, struct folio *);
 static sector_t		vxfs_bmap(struct address_space *, sector_t);
 
 const struct address_space_operations vxfs_aops = {
@@ -155,10 +155,9 @@ vxfs_getblk(struct inode *ip, sector_t iblock,
  * Locking status:
  *   @page is locked and will be unlocked.
  */
-static int
-vxfs_readpage(struct file *file, struct page *page)
+static int vxfs_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, vxfs_getblk);
+	return block_read_full_page(folio, vxfs_getblk);
 }
  
 /**
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 78f9f209078c..3622fc5f33e8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1908,14 +1908,14 @@ void fuse_init_dir(struct inode *inode)
 	fi->rdc.version = 0;
 }
 
-static int fuse_symlink_readpage(struct file *null, struct page *page)
+static int fuse_symlink_readpage(struct file *null, struct folio *folio)
 {
-	int err = fuse_readlink_page(page->mapping->host, page);
+	int err = fuse_readlink_page(folio->page.mapping->host, &folio->page);
 
 	if (!err)
-		SetPageUptodate(page);
+		SetFolioUptodate(folio);
 
-	unlock_page(page);
+	unlock_folio(folio);
 
 	return err;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c4645a54e932..5d957f931caf 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -862,8 +862,9 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	return 0;
 }
 
-static int fuse_readpage(struct file *file, struct page *page)
+static int fuse_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	int err;
 
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index cc4f987687f3..f3736ab1f6ce 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -465,8 +465,9 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
 }
 
 
-static int __gfs2_readpage(void *file, struct page *page)
+static int __gfs2_readpage(void *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
@@ -474,12 +475,12 @@ static int __gfs2_readpage(void *file, struct page *page)
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !page_has_buffers(page))) {
-		error = iomap_readpage(page, &gfs2_iomap_ops);
+		error = iomap_readpage(folio, &gfs2_iomap_ops);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_readpage(ip, page);
-		unlock_page(page);
+		unlock_folio(folio);
 	} else {
-		error = mpage_readpage(page, gfs2_block_map);
+		error = mpage_readpage(folio, gfs2_block_map);
 	}
 
 	if (unlikely(gfs2_withdrawn(sdp)))
@@ -494,9 +495,9 @@ static int __gfs2_readpage(void *file, struct page *page)
  * @page: The page of the file
  */
 
-static int gfs2_readpage(struct file *file, struct page *page)
+static int gfs2_readpage(struct file *file, struct folio *folio)
 {
-	return __gfs2_readpage(file, page);
+	return __gfs2_readpage(file, folio);
 }
 
 /**
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index f35a37c65e5f..778f65256e49 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -34,9 +34,9 @@ static int hfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, hfs_get_block, wbc);
 }
 
-static int hfs_readpage(struct file *file, struct page *page)
+static int hfs_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, hfs_get_block);
+	return block_read_full_page(folio, hfs_get_block);
 }
 
 static void hfs_write_failed(struct address_space *mapping, loff_t to)
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index e3da9e96b835..afaa784fae9f 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -22,9 +22,9 @@
 #include "hfsplus_raw.h"
 #include "xattr.h"
 
-static int hfsplus_readpage(struct file *file, struct page *page)
+static int hfsplus_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, hfsplus_get_block);
+	return block_read_full_page(folio, hfsplus_get_block);
 }
 
 static int hfsplus_writepage(struct page *page, struct writeback_control *wbc)
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 077c25128eb7..b1fe2040279e 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -116,9 +116,9 @@ static int hpfs_get_block(struct inode *inode, sector_t iblock, struct buffer_he
 	return r;
 }
 
-static int hpfs_readpage(struct file *file, struct page *page)
+static int hpfs_readpage(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, hpfs_get_block);
+	return mpage_readpage(folio, hpfs_get_block);
 }
 
 static int hpfs_writepage(struct page *page, struct writeback_control *wbc)
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 1aee39160ac5..16bf0c2f7925 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -475,8 +475,9 @@ static int hpfs_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int hpfs_symlink_readpage(struct file *file, struct page *page)
+static int hpfs_symlink_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	char *link = page_address(page);
 	struct inode *i = page->mapping->host;
 	struct fnode *fnode;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef650573ab9e..8cfb5fc2c13d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -312,15 +312,15 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	return pos - orig_pos + plen;
 }
 
-int
-iomap_readpage(struct page *page, const struct iomap_ops *ops)
+int iomap_readpage(struct folio *folio, const struct iomap_ops *ops)
 {
+	struct page *page = &folio->page;
 	struct iomap_readpage_ctx ctx = { .cur_page = page };
 	struct inode *inode = page->mapping->host;
 	unsigned poff;
 	loff_t ret;
 
-	trace_iomap_readpage(page->mapping->host, 1);
+	trace_iomap_readpage(inode, 1);
 
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
@@ -328,7 +328,7 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 				iomap_readpage_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
-			SetPageError(page);
+			SetFolioError(folio);
 			break;
 		}
 	}
@@ -338,7 +338,7 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 		WARN_ON_ONCE(!ctx.cur_page_in_bio);
 	} else {
 		WARN_ON_ONCE(ctx.cur_page_in_bio);
-		unlock_page(page);
+		unlock_folio(folio);
 	}
 
 	/*
diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index bc12ac7e2312..f502103d5b6d 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -296,8 +296,9 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
  * per reference.  We inject the additional pages into the page
  * cache as a form of readahead.
  */
-static int zisofs_readpage(struct file *file, struct page *page)
+static int zisofs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	int err;
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index ec90773527ee..ea1b99562cbc 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1174,9 +1174,9 @@ struct buffer_head *isofs_bread(struct inode *inode, sector_t block)
 	return sb_bread(inode->i_sb, blknr);
 }
 
-static int isofs_readpage(struct file *file, struct page *page)
+static int isofs_readpage(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, isofs_get_block);
+	return mpage_readpage(folio, isofs_get_block);
 }
 
 static void isofs_readahead(struct readahead_control *rac)
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 94ef92fe806c..7c5358efa130 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -690,8 +690,9 @@ int parse_rock_ridge_inode(struct iso_directory_record *de, struct inode *inode,
  * readpage() for symlinks: reads symlink contents into the page and either
  * makes it uptodate and returns 0 or returns error (-EIO)
  */
-static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
+static int rock_ridge_symlink_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index f8fb89b10227..378ddff6bbea 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -27,7 +27,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
 			struct page **pagep, void **fsdata);
-static int jffs2_readpage (struct file *filp, struct page *pg);
+static int jffs2_readpage(struct file *filp, struct folio *folio);
 
 int jffs2_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 {
@@ -76,8 +76,9 @@ const struct address_space_operations jffs2_file_address_operations =
 	.write_end =	jffs2_write_end,
 };
 
-static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
+static int jffs2_do_readpage_nolock(struct inode *inode, struct folio *folio)
 {
+	struct page *pg = &folio->page;
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
 	unsigned char *pg_buf;
@@ -109,21 +110,22 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 	return ret;
 }
 
-int jffs2_do_readpage_unlock(void *data, struct page *pg)
+int jffs2_do_readpage_unlock(void *data, struct folio *folio)
 {
-	int ret = jffs2_do_readpage_nolock(data, pg);
-	unlock_page(pg);
+	int ret = jffs2_do_readpage_nolock(data, folio);
+	unlock_folio(folio);
 	return ret;
 }
 
 
-static int jffs2_readpage (struct file *filp, struct page *pg)
+static int jffs2_readpage(struct file *file, struct folio *folio)
 {
-	struct jffs2_inode_info *f = JFFS2_INODE_INFO(pg->mapping->host);
+	struct inode *inode = folio->page.mapping->host;
+	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 	int ret;
 
 	mutex_lock(&f->sem);
-	ret = jffs2_do_readpage_unlock(pg->mapping->host, pg);
+	ret = jffs2_do_readpage_unlock(inode, folio);
 	mutex_unlock(&f->sem);
 	return ret;
 }
@@ -218,7 +220,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 	 */
 	if (!PageUptodate(pg)) {
 		mutex_lock(&f->sem);
-		ret = jffs2_do_readpage_nolock(inode, pg);
+		ret = jffs2_do_readpage_nolock(inode, page_folio(pg));
 		mutex_unlock(&f->sem);
 		if (ret)
 			goto out_page;
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index ef1cfa61549e..ff4a38d4510c 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -155,7 +155,7 @@ extern const struct file_operations jffs2_file_operations;
 extern const struct inode_operations jffs2_file_inode_operations;
 extern const struct address_space_operations jffs2_file_address_operations;
 int jffs2_fsync(struct file *, loff_t, loff_t, int);
-int jffs2_do_readpage_unlock(void *data, struct page *pg);
+int jffs2_do_readpage_unlock(void *data, struct folio *folio);
 
 /* ioctl.c */
 long jffs2_ioctl(struct file *, unsigned int, unsigned long);
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 6f65bfa9f18d..f502131a4e69 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -291,9 +291,9 @@ static int jfs_writepages(struct address_space *mapping,
 	return mpage_writepages(mapping, wbc, jfs_get_block);
 }
 
-static int jfs_readpage(struct file *file, struct page *page)
+static int jfs_readpage(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, jfs_get_block);
+	return mpage_readpage(folio, jfs_get_block);
 }
 
 static void jfs_readahead(struct readahead_control *rac)
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 176580f54af9..058837d7172e 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -468,8 +468,9 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 	return -EIO;
 }
 
-static int metapage_readpage(struct file *fp, struct page *page)
+static int metapage_readpage(struct file *fp, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct bio *bio = NULL;
 	int block_offset;
diff --git a/fs/libfs.c b/fs/libfs.c
index d1c3bade9f30..a0f9274271c4 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -509,12 +509,12 @@ int simple_setattr(struct dentry *dentry, struct iattr *iattr)
 }
 EXPORT_SYMBOL(simple_setattr);
 
-int simple_readpage(struct file *file, struct page *page)
+int simple_readpage(struct file *file, struct folio *folio)
 {
-	clear_highpage(page);
-	flush_dcache_page(page);
-	SetPageUptodate(page);
-	unlock_page(page);
+	clear_highpage(&folio->page);
+	flush_dcache_page(&folio->page);
+	SetFolioUptodate(folio);
+	unlock_folio(folio);
 	return 0;
 }
 EXPORT_SYMBOL(simple_readpage);
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 34f546404aa1..df1ee731bf22 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -402,9 +402,9 @@ static int minix_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, minix_get_block, wbc);
 }
 
-static int minix_readpage(struct file *file, struct page *page)
+static int minix_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page,minix_get_block);
+	return block_read_full_page(folio, minix_get_block);
 }
 
 int minix_prepare_chunk(struct page *page, loff_t pos, unsigned len)
diff --git a/fs/mpage.c b/fs/mpage.c
index 58b7e15d85c1..f1b89b05f8ce 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -331,7 +331,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (args->bio)
 		args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
 	if (!PageUptodate(page))
-		block_read_full_page(page, args->get_block);
+		block_read_full_page((struct folio *)page, args->get_block);
 	else
 		unlock_page(page);
 	goto out;
@@ -398,10 +398,10 @@ EXPORT_SYMBOL(mpage_readahead);
 /*
  * This isn't called much at all
  */
-int mpage_readpage(struct page *page, get_block_t get_block)
+int mpage_readpage(struct folio *folio, get_block_t get_block)
 {
 	struct mpage_readpage_args args = {
-		.page = page,
+		.page = &folio->page,
 		.nr_pages = 1,
 		.get_block = get_block,
 	};
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 63940a7a70be..ca2844ff0d28 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -340,9 +340,10 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 		put_page(page);
 	} else if (!once_thru &&
 		   nfs_want_read_modify_write(file, page, pos, len)) {
+		struct folio *folio = page_folio(page);
 		once_thru = 1;
-		ret = nfs_readpage(file, page);
-		put_page(page);
+		ret = nfs_readpage(file, folio);
+		put_folio(folio);
 		if (!ret)
 			goto start;
 	}
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index eb854f1f86e2..293394785e69 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -310,8 +310,9 @@ static void nfs_readpage_result(struct rpc_task *task,
  *  -	The error flag is set for this page. This happens only when a
  *	previous async read operation failed.
  */
-int nfs_readpage(struct file *file, struct page *page)
+int nfs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct nfs_open_context *ctx;
 	struct inode *inode = page_file_mapping(page)->host;
 	int		error;
@@ -372,9 +373,9 @@ struct nfs_readdesc {
 	struct nfs_open_context *ctx;
 };
 
-static int
-readpage_async_filler(void *data, struct page *page)
+static int readpage_async_filler(void *data, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
 	struct nfs_page *new;
 	unsigned int len;
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 25ba299fdac2..e42efd820f2f 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -26,21 +26,21 @@
  * and straight-forward than readdir caching.
  */
 
-static int nfs_symlink_filler(void *data, struct page *page)
+static int nfs_symlink_filler(void *data, struct folio *folio)
 {
 	struct inode *inode = data;
 	int error;
 
-	error = NFS_PROTO(inode)->readlink(inode, page, 0, PAGE_SIZE);
+	error = NFS_PROTO(inode)->readlink(inode, &folio->page, 0, PAGE_SIZE);
 	if (error < 0)
 		goto error;
-	SetPageUptodate(page);
-	unlock_page(page);
+	SetFolioUptodate(folio);
+	unlock_folio(folio);
 	return 0;
 
 error:
-	SetPageError(page);
-	unlock_page(page);
+	SetFolioError(folio);
+	unlock_folio(folio);
 	return -EIO;
 }
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 745d371d6fea..118c23c75239 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -141,9 +141,9 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
  * @file - file struct of the file to be read
  * @page - the page to be read
  */
-static int nilfs_readpage(struct file *file, struct page *page)
+static int nilfs_readpage(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, nilfs_get_block);
+	return mpage_readpage(folio, nilfs_get_block);
 }
 
 static void nilfs_readahead(struct readahead_control *rac)
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index bb0a43860ad2..7ee896069be9 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -375,8 +375,9 @@ static int ntfs_read_block(struct page *page)
  *
  * Return 0 on success and -errno on error.
  */
-static int ntfs_readpage(struct file *file, struct page *page)
+static int ntfs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	loff_t i_size;
 	struct inode *vi;
 	ntfs_inode *ni, *base_ni;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 3bfb4147895a..7264e844e577 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -277,15 +277,15 @@ static int ocfs2_readpage_inline(struct inode *inode, struct page *page)
 	return ret;
 }
 
-static int ocfs2_readpage(struct file *file, struct page *page)
+static int ocfs2_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	loff_t start = (loff_t)page->index << PAGE_SHIFT;
 	int ret, unlock = 1;
 
-	trace_ocfs2_readpage((unsigned long long)oi->ip_blkno,
-			     (page ? page->index : 0));
+	trace_ocfs2_readpage((unsigned long long)oi->ip_blkno, page->index);
 
 	ret = ocfs2_inode_lock_with_page(inode, NULL, 0, page);
 	if (ret != 0) {
@@ -301,7 +301,7 @@ static int ocfs2_readpage(struct file *file, struct page *page)
 		 * busyloop waiting for ip_alloc_sem to unlock
 		 */
 		ret = AOP_TRUNCATED_PAGE;
-		unlock_page(page);
+		unlock_folio(folio);
 		unlock = 0;
 		down_read(&oi->ip_alloc_sem);
 		up_read(&oi->ip_alloc_sem);
@@ -320,7 +320,7 @@ static int ocfs2_readpage(struct file *file, struct page *page)
 	 */
 	if (start >= i_size_read(inode)) {
 		zero_user(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
+		SetFolioUptodate(folio);
 		ret = 0;
 		goto out_alloc;
 	}
@@ -328,7 +328,7 @@ static int ocfs2_readpage(struct file *file, struct page *page)
 	if (oi->ip_dyn_features & OCFS2_INLINE_DATA_FL)
 		ret = ocfs2_readpage_inline(inode, page);
 	else
-		ret = block_read_full_page(page, ocfs2_get_block);
+		ret = block_read_full_page(folio, ocfs2_get_block);
 	unlock = 0;
 
 out_alloc:
@@ -337,7 +337,7 @@ static int ocfs2_readpage(struct file *file, struct page *page)
 	ocfs2_inode_unlock(inode, 0);
 out:
 	if (unlock)
-		unlock_page(page);
+		unlock_folio(folio);
 	return ret;
 }
 
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 3b397fa9c9e8..f4700e9a36da 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -2963,12 +2963,13 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
 		}
 
 		if (!PageUptodate(page)) {
-			ret = block_read_full_page(page, ocfs2_get_block);
+			struct folio *folio = page_folio(page);
+			ret = block_read_full_page(folio, ocfs2_get_block);
 			if (ret) {
 				mlog_errno(ret);
 				goto unlock;
 			}
-			lock_page(page);
+			lock_folio(folio);
 		}
 
 		if (page_has_buffers(page)) {
diff --git a/fs/ocfs2/symlink.c b/fs/ocfs2/symlink.c
index 94cfacc9bad7..3091c3278ce8 100644
--- a/fs/ocfs2/symlink.c
+++ b/fs/ocfs2/symlink.c
@@ -54,8 +54,9 @@
 #include "buffer_head_io.h"
 
 
-static int ocfs2_fast_symlink_readpage(struct file *unused, struct page *page)
+static int ocfs2_fast_symlink_readpage(struct file *unused, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct buffer_head *bh = NULL;
 	int status = ocfs2_read_inode_block(inode, &bh);
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 2c7b70ee1388..db00be77e3f2 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -284,9 +284,9 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 	return ret;
 }
 
-static int omfs_readpage(struct file *file, struct page *page)
+static int omfs_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page, omfs_get_block);
+	return block_read_full_page(folio, omfs_get_block);
 }
 
 static void omfs_readahead(struct readahead_control *rac)
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 48f0547d4850..c277a0fbc417 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -244,8 +244,9 @@ static int orangefs_writepages(struct address_space *mapping,
 
 static int orangefs_launder_page(struct page *);
 
-static int orangefs_readpage(struct file *file, struct page *page)
+static int orangefs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct iov_iter iter;
 	struct bio_vec bv;
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 3fb7fc819b4f..7515e9b6e6cb 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -245,9 +245,9 @@ static void qnx4_kill_sb(struct super_block *sb)
 	}
 }
 
-static int qnx4_readpage(struct file *file, struct page *page)
+static int qnx4_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page,qnx4_get_block);
+	return block_read_full_page(folio, qnx4_get_block);
 }
 
 static sector_t qnx4_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 61191f7bdf62..dc55db339ee6 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -94,9 +94,9 @@ static int qnx6_check_blockptr(__fs32 ptr)
 	return 1;
 }
 
-static int qnx6_readpage(struct file *file, struct page *page)
+static int qnx6_readpage(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, qnx6_get_block);
+	return mpage_readpage(folio, qnx6_get_block);
 }
 
 static void qnx6_readahead(struct readahead_control *rac)
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c76d563dec0e..5a37575b8dc6 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2735,9 +2735,9 @@ static int reiserfs_write_full_page(struct page *page,
 	goto done;
 }
 
-static int reiserfs_readpage(struct file *f, struct page *page)
+static int reiserfs_readpage(struct file *f, struct folio *folio)
 {
-	return block_read_full_page(page, reiserfs_get_block);
+	return block_read_full_page(folio, reiserfs_get_block);
 }
 
 static int reiserfs_writepage(struct page *page, struct writeback_control *wbc)
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 259f684d9236..fe88dc5e5b4d 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -99,8 +99,9 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos);
 /*
  * read a page worth of data from the image
  */
-static int romfs_readpage(struct file *file, struct page *page)
+static int romfs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	loff_t offset, size;
 	unsigned long fillsize, pos;
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 7b1128398976..20c458e8c45f 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -444,8 +444,9 @@ static int squashfs_readpage_sparse(struct page *page, int expected)
 	return 0;
 }
 
-static int squashfs_readpage(struct file *file, struct page *page)
+static int squashfs_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 	int index = page->index >> (msblk->block_log - PAGE_SHIFT);
diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index 1430613183e6..277dcd4bf4b2 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -30,8 +30,9 @@
 #include "squashfs.h"
 #include "xattr.h"
 
-static int squashfs_symlink_readpage(struct file *file, struct page *page)
+static int squashfs_symlink_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index bcb67b0cabe7..81b5e6947932 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -456,9 +456,9 @@ static int sysv_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page,get_block,wbc);
 }
 
-static int sysv_readpage(struct file *file, struct page *page)
+static int sysv_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page,get_block);
+	return block_read_full_page(folio, get_block);
 }
 
 int sysv_prepare_chunk(struct page *page, loff_t pos, unsigned len)
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 2bc7780d2963..0b596e3665f5 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -890,12 +890,12 @@ static int ubifs_bulk_read(struct page *page)
 	return err;
 }
 
-static int ubifs_readpage(struct file *file, struct page *page)
+static int ubifs_readpage(struct file *file, struct folio *folio)
 {
-	if (ubifs_bulk_read(page))
+	if (ubifs_bulk_read(&folio->page))
 		return 0;
-	do_readpage(page);
-	unlock_page(page);
+	do_readpage(&folio->page);
+	unlock_folio(folio);
 	return 0;
 }
 
diff --git a/fs/udf/file.c b/fs/udf/file.c
index ad8eefad27d7..9fc85201dd20 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -57,11 +57,11 @@ static void __udf_adinicb_readpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-static int udf_adinicb_readpage(struct file *file, struct page *page)
+static int udf_adinicb_readpage(struct file *file, struct folio *folio)
 {
-	BUG_ON(!PageLocked(page));
-	__udf_adinicb_readpage(page);
-	unlock_page(page);
+	BUG_ON(!FolioLocked(folio));
+	__udf_adinicb_readpage(&folio->page);
+	unlock_folio(folio);
 
 	return 0;
 }
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index bb89c3e43212..3bce0406956e 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -193,9 +193,9 @@ static int udf_writepages(struct address_space *mapping,
 	return mpage_writepages(mapping, wbc, udf_get_block);
 }
 
-static int udf_readpage(struct file *file, struct page *page)
+static int udf_readpage(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, udf_get_block);
+	return mpage_readpage(folio, udf_get_block);
 }
 
 static void udf_readahead(struct readahead_control *rac)
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index c973db239604..b621ae41e6e3 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -101,8 +101,9 @@ static int udf_pc_to_char(struct super_block *sb, unsigned char *from,
 	return 0;
 }
 
-static int udf_symlink_filler(struct file *file, struct page *page)
+static int udf_symlink_filler(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct buffer_head *bh = NULL;
 	unsigned char *symlink;
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index c843ec858cf7..1b87d88761d5 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -472,9 +472,9 @@ static int ufs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page,ufs_getfrag_block,wbc);
 }
 
-static int ufs_readpage(struct file *file, struct page *page)
+static int ufs_readpage(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(page,ufs_getfrag_block);
+	return block_read_full_page(folio, ufs_getfrag_block);
 }
 
 int ufs_prepare_chunk(struct page *page, loff_t pos, unsigned len)
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index c4ab5996d97a..aa918615cec9 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -208,8 +208,9 @@ const struct inode_operations vboxsf_reg_iops = {
 	.setattr = vboxsf_setattr
 };
 
-static int vboxsf_readpage(struct file *file, struct page *page)
+static int vboxsf_readpage(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct vboxsf_handle *sf_handle = file->private_data;
 	loff_t off = page_offset(page);
 	u32 nread = PAGE_SIZE;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 4304c6416fbb..cd1880b31652 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -620,9 +620,9 @@ xfs_vm_bmap(
 STATIC int
 xfs_vm_readpage(
 	struct file		*unused,
-	struct page		*page)
+	struct folio		*folio)
 {
-	return iomap_readpage(page, &xfs_read_iomap_ops);
+	return iomap_readpage(folio, &xfs_read_iomap_ops);
 }
 
 STATIC void
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bec47f2d074b..5a6dbd515ca8 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -107,9 +107,9 @@ static const struct iomap_ops zonefs_iomap_ops = {
 	.iomap_begin	= zonefs_iomap_begin,
 };
 
-static int zonefs_readpage(struct file *unused, struct page *page)
+static int zonefs_readpage(struct file *unused, struct folio *folio)
 {
-	return iomap_readpage(page, &zonefs_iomap_ops);
+	return iomap_readpage(folio, &zonefs_iomap_ops);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94378c5..7a3c2caf5740 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -221,7 +221,7 @@ int block_write_full_page(struct page *page, get_block_t *get_block,
 int __block_write_full_page(struct inode *inode, struct page *page,
 			get_block_t *get_block, struct writeback_control *wbc,
 			bh_end_io_t *handler);
-int block_read_full_page(struct page*, get_block_t*);
+int block_read_full_page(struct folio *, get_block_t *);
 int block_is_partially_uptodate(struct page *page, unsigned long from,
 				unsigned long count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 08f9a8a524f2..0a8250c8d6f7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -366,7 +366,7 @@ typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
+	int (*readpage)(struct file *, struct folio *);
 
 	/* Write back some dirty pages from this mapping. */
 	int (*writepages)(struct address_space *, struct writeback_control *);
@@ -3158,7 +3158,7 @@ extern void noop_invalidatepage(struct page *page, unsigned int offset,
 		unsigned int length);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
-extern int simple_readpage(struct file *file, struct page *page);
+extern int simple_readpage(struct file *file, struct folio *folio);
 extern int simple_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
 			struct page **pagep, void **fsdata);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5bd3cac4df9c..a6da774a7532 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -155,7 +155,7 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
-int iomap_readpage(struct page *page, const struct iomap_ops *ops);
+int iomap_readpage(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 int iomap_set_page_dirty(struct page *page);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
diff --git a/include/linux/mpage.h b/include/linux/mpage.h
index f4f5e90a6844..b3361c9e5439 100644
--- a/include/linux/mpage.h
+++ b/include/linux/mpage.h
@@ -16,7 +16,7 @@ struct writeback_control;
 struct readahead_control;
 
 void mpage_readahead(struct readahead_control *, get_block_t get_block);
-int mpage_readpage(struct page *page, get_block_t get_block);
+int mpage_readpage(struct folio *folio, get_block_t get_block);
 int mpage_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, get_block_t get_block);
 int mpage_writepage(struct page *page, get_block_t *get_block,
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 681ed98e4ba8..3643609cfe13 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -567,7 +567,7 @@ nfs_have_writebacks(struct inode *inode)
 /*
  * linux/fs/nfs/read.c
  */
-extern int  nfs_readpage(struct file *, struct page *);
+extern int nfs_readpage(struct file *, struct folio *);
 extern int  nfs_readpages(struct file *, struct address_space *,
 		struct list_head *, unsigned);
 extern int  nfs_readpage_async(struct nfs_open_context *, struct inode *,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 30123ae18ee1..2283e58ebe32 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -300,7 +300,7 @@ static inline gfp_t readahead_gfp_mask(struct address_space *x)
 	return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
 }
 
-typedef int filler_t(void *, struct page *);
+typedef int filler_t(void *, struct folio *);
 
 pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan);
diff --git a/mm/filemap.c b/mm/filemap.c
index f3722ca8f7d4..3c5eb39452c3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2222,7 +2222,7 @@ generic_file_buffered_read_readpage(struct kiocb *iocb,
 	 */
 	ClearPageError(page);
 	/* Start the actual read. The read will unlock the page. */
-	error = mapping->a_ops->readpage(filp, page);
+	error = mapping->a_ops->readpage(filp, page_folio(page));
 
 	if (unlikely(error)) {
 		put_page(page);
@@ -3006,7 +3006,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	ClearPageError(page);
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	error = mapping->a_ops->readpage(file, page);
+	error = mapping->a_ops->readpage(file, page_folio(page));
 	if (!error) {
 		wait_on_page_locked(page);
 		if (!PageUptodate(page))
@@ -3193,10 +3193,7 @@ static struct page *wait_on_page_read(struct page *page)
 }
 
 static struct page *do_read_cache_page(struct address_space *mapping,
-				pgoff_t index,
-				int (*filler)(void *, struct page *),
-				void *data,
-				gfp_t gfp)
+		pgoff_t index, filler_t filler, void *data, gfp_t gfp)
 {
 	struct page *page;
 	int err;
@@ -3217,9 +3214,9 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 
 filler:
 		if (filler)
-			err = filler(data, page);
+			err = filler(data, page_folio(page));
 		else
-			err = mapping->a_ops->readpage(data, page);
+			err = mapping->a_ops->readpage(data, page_folio(page));
 
 		if (err < 0) {
 			put_page(page);
@@ -3313,10 +3310,8 @@ static struct page *do_read_cache_page(struct address_space *mapping,
  *
  * Return: up to date page on success, ERR_PTR() on failure.
  */
-struct page *read_cache_page(struct address_space *mapping,
-				pgoff_t index,
-				int (*filler)(void *, struct page *),
-				void *data)
+struct page *read_cache_page(struct address_space *mapping, pgoff_t index,
+		filler_t filler, void *data)
 {
 	return do_read_cache_page(mapping, index, filler, data,
 			mapping_gfp_mask(mapping));
diff --git a/mm/page_io.c b/mm/page_io.c
index 1fc0a579da58..09d509ea0c62 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -407,7 +407,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
 
-		ret = mapping->a_ops->readpage(swap_file, page);
+		ret = mapping->a_ops->readpage(swap_file, page_folio(page));
 		if (!ret)
 			count_vm_event(PSWPIN);
 		goto out;
diff --git a/mm/readahead.c b/mm/readahead.c
index b2d78984e406..fb08d1d46ddb 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -87,7 +87,7 @@ static void read_cache_pages_invalidate_pages(struct address_space *mapping,
  * Returns: %0 on success, error return by @filler otherwise
  */
 int read_cache_pages(struct address_space *mapping, struct list_head *pages,
-			int (*filler)(void *, struct page *), void *data)
+			filler_t filler, void *data)
 {
 	struct page *page;
 	int ret = 0;
@@ -102,7 +102,7 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 		}
 		put_page(page);
 
-		ret = filler(data, page);
+		ret = filler(data, page_folio(page));
 		if (unlikely(ret)) {
 			read_cache_pages_invalidate_pages(mapping, pages);
 			break;
@@ -140,7 +140,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 		rac->_nr_pages = 0;
 	} else {
 		while ((folio = readahead_folio(rac)))
-			aops->readpage(rac->file, &folio->page);
+			aops->readpage(rac->file, folio);
 	}
 
 	blk_finish_plug(&plug);
-- 
2.29.2

