Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B329D51F13D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiEHUeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiEHUdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1323BDFFD
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PMMFqnfx33ltUl2cmgc1sH2zu3gIcFs97QY4wzRnWG4=; b=aFvI8YJ/b7slIe7ZJtK/T1KLBn
        FkZ0DDtSv+vD3Kzv1cGPoFZpn3mU0KM7akHIe95CWTCC0e01OZ84ZRROG1p4mLE5Ry0naFxqYN6Nx
        NqZ6uB91T3/lBib6THkqRYZ0EYngJgzn9aonADE5rsmfRqWTbOsQHgtdqB97oZ5U1bglshhqPAmPn
        1fkPik15ejD110Vj/mTViydEamrvfvy11pc7aL3HAeq2VEl8yGiolIxM5pw4Qh8GKWH3KBF+A9x7V
        nqwT4WJe4hkfUKIW0dcxgry8IkxGcrqHpqtCPSzIg+9/7EAIc+zx3Ovpy3Nwgdvbkin9VofEdkE+i
        TbKxhWig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXT-002nZ9-BI; Sun, 08 May 2022 20:29:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/25] fs: Remove flags parameter from aops->write_begin
Date:   Sun,  8 May 2022 21:29:31 +0100
Message-Id: <20220508202941.667024-16-willy@infradead.org>
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
 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/vfs.rst     |  5 +----
 block/fops.c                          |  3 +--
 fs/9p/vfs_addr.c                      |  2 +-
 fs/adfs/inode.c                       |  2 +-
 fs/affs/file.c                        |  6 +++---
 fs/afs/internal.h                     |  2 +-
 fs/afs/write.c                        |  2 +-
 fs/bfs/file.c                         |  2 +-
 fs/ceph/addr.c                        |  2 +-
 fs/cifs/file.c                        |  2 +-
 fs/ecryptfs/mmap.c                    |  2 +-
 fs/exfat/inode.c                      |  2 +-
 fs/ext2/inode.c                       |  6 ++----
 fs/ext4/inode.c                       | 10 +++++-----
 fs/f2fs/data.c                        |  5 ++---
 fs/f2fs/super.c                       |  2 +-
 fs/fat/inode.c                        |  2 +-
 fs/fuse/file.c                        |  3 +--
 fs/hfs/inode.c                        |  2 +-
 fs/hfsplus/inode.c                    |  2 +-
 fs/hostfs/hostfs_kern.c               |  2 +-
 fs/hpfs/file.c                        |  2 +-
 fs/hugetlbfs/inode.c                  |  2 +-
 fs/jffs2/file.c                       |  4 ++--
 fs/jfs/inode.c                        |  2 +-
 fs/libfs.c                            |  2 +-
 fs/minix/inode.c                      |  2 +-
 fs/nfs/file.c                         |  2 +-
 fs/nilfs2/inode.c                     |  2 +-
 fs/ntfs3/inode.c                      |  2 +-
 fs/ocfs2/aops.c                       |  2 +-
 fs/omfs/file.c                        |  2 +-
 fs/orangefs/inode.c                   |  5 ++---
 fs/reiserfs/inode.c                   |  2 +-
 fs/sysv/itree.c                       |  2 +-
 fs/ubifs/file.c                       |  7 +++----
 fs/udf/file.c                         |  2 +-
 fs/udf/inode.c                        |  2 +-
 fs/ufs/inode.c                        |  2 +-
 include/linux/fs.h                    |  4 ++--
 include/trace/events/ext4.h           | 21 ++++++++-------------
 include/trace/events/f2fs.h           | 12 ++++--------
 mm/filemap.c                          |  6 ++----
 mm/shmem.c                            |  2 +-
 45 files changed, 69 insertions(+), 90 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index c26d854275a0..fd9d9caf09ab 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -242,7 +242,7 @@ prototypes::
 	bool (*dirty_folio)(struct address_space *, struct folio *folio);
 	void (*readahead)(struct readahead_control *);
 	int (*write_begin)(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
+				loff_t pos, unsigned len,
 				struct page **pagep, void **fsdata);
 	int (*write_end)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 794bd1a66bfb..30f303180a7d 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -727,7 +727,7 @@ cache in your filesystem.  The following members are defined:
 		bool (*dirty_folio)(struct address_space *, struct folio *);
 		void (*readahead)(struct readahead_control *);
 		int (*write_begin)(struct file *, struct address_space *mapping,
-				   loff_t pos, unsigned len, unsigned flags,
+				   loff_t pos, unsigned len,
 				struct page **pagep, void **fsdata);
 		int (*write_end)(struct file *, struct address_space *mapping,
 				 loff_t pos, unsigned len, unsigned copied,
@@ -832,9 +832,6 @@ cache in your filesystem.  The following members are defined:
 	passed to write_begin is greater than the number of bytes copied
 	into the page).
 
-	flags is a field for AOP_FLAG_xxx flags, described in
-	include/linux/fs.h.
-
 	A void * may be returned in fsdata, which then gets passed into
 	write_end.
 
diff --git a/block/fops.c b/block/fops.c
index b432756570c6..712affe56e29 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -398,8 +398,7 @@ static void blkdev_readahead(struct readahead_control *rac)
 }
 
 static int blkdev_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, unsigned flags, struct page **pagep,
-		void **fsdata)
+		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
 {
 	return block_write_begin(mapping, pos, len, pagep, blkdev_get_block);
 }
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index d311e68e21fd..a2d57112f53e 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -260,7 +260,7 @@ v9fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 }
 
 static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
-			    loff_t pos, unsigned int len, unsigned int flags,
+			    loff_t pos, unsigned int len,
 			    struct page **subpagep, void **fsdata)
 {
 	int retval;
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index b6912496bb19..f7959b1a2d52 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -52,7 +52,7 @@ static void adfs_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int adfs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 06645d05c717..b952f65c3f06 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -414,7 +414,7 @@ affs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 }
 
 static int affs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
@@ -650,7 +650,7 @@ affs_readpage_ofs(struct file *file, struct page *page)
 }
 
 static int affs_write_begin_ofs(struct file *file, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
+				loff_t pos, unsigned len,
 				struct page **pagep, void **fsdata)
 {
 	struct inode *inode = mapping->host;
@@ -887,7 +887,7 @@ affs_truncate(struct inode *inode)
 		loff_t isize = inode->i_size;
 		int res;
 
-		res = mapping->a_ops->write_begin(NULL, mapping, isize, 0, 0, &page, &fsdata);
+		res = mapping->a_ops->write_begin(NULL, mapping, isize, 0, &page, &fsdata);
 		if (!res)
 			res = mapping->a_ops->write_end(NULL, mapping, isize, 0, 0, page, fsdata);
 		else
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 7b7ef945dc78..7a72e9c60423 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1535,7 +1535,7 @@ bool afs_dirty_folio(struct address_space *, struct folio *);
 #define afs_dirty_folio filemap_dirty_folio
 #endif
 extern int afs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata);
 extern int afs_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
diff --git a/fs/afs/write.c b/fs/afs/write.c
index af496c98d394..5224e346fbad 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -42,7 +42,7 @@ static void afs_folio_start_fscache(bool caching, struct folio *folio)
  * prepare to perform part of a write to a page
  */
 int afs_write_begin(struct file *file, struct address_space *mapping,
-		    loff_t pos, unsigned len, unsigned flags,
+		    loff_t pos, unsigned len,
 		    struct page **_page, void **fsdata)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 9408f45225cb..dc97c9b8f23b 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -169,7 +169,7 @@ static void bfs_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int bfs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 415f0886bc25..e65541a51b68 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1311,7 +1311,7 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
  * clean, or already dirty within the same snap context.
  */
 static int ceph_write_begin(struct file *file, struct address_space *mapping,
-			    loff_t pos, unsigned len, unsigned aop_flags,
+			    loff_t pos, unsigned len,
 			    struct page **pagep, void **fsdata)
 {
 	struct inode *inode = file_inode(file);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 91aeae7fced8..da362b5a0c96 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4681,7 +4681,7 @@ bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file)
 }
 
 static int cifs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int oncethru = 0;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 84e399a921ad..47904d40ef88 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -264,7 +264,7 @@ static int fill_zeros_to_end_of_page(struct page *page, unsigned int to)
  */
 static int ecryptfs_write_begin(struct file *file,
 			struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 8ed3c4b700cd..b9f63113db2d 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -389,7 +389,7 @@ static void exfat_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int exfat_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned int len, unsigned int flags,
+		loff_t pos, unsigned int len,
 		struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index bfa69c52ce2c..d8ca8050945a 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -887,8 +887,7 @@ static void ext2_readahead(struct readahead_control *rac)
 
 static int
 ext2_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, unsigned flags,
-		struct page **pagep, void **fsdata)
+		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
 {
 	int ret;
 
@@ -912,8 +911,7 @@ static int ext2_write_end(struct file *file, struct address_space *mapping,
 
 static int
 ext2_nobh_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, unsigned flags,
-		struct page **pagep, void **fsdata)
+		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
 {
 	int ret;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 512d8143c765..d3a7e8581291 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1130,7 +1130,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 #endif
 
 static int ext4_write_begin(struct file *file, struct address_space *mapping,
-			    loff_t pos, unsigned len, unsigned flags,
+			    loff_t pos, unsigned len,
 			    struct page **pagep, void **fsdata)
 {
 	struct inode *inode = mapping->host;
@@ -1144,7 +1144,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	trace_ext4_write_begin(inode, pos, len, flags);
+	trace_ext4_write_begin(inode, pos, len);
 	/*
 	 * Reserve one block more for addition to orphan list in case
 	 * we allocate blocks but write fails for some reason
@@ -2931,7 +2931,7 @@ static int ext4_nonda_switch(struct super_block *sb)
 }
 
 static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
-			       loff_t pos, unsigned len, unsigned flags,
+			       loff_t pos, unsigned len,
 			       struct page **pagep, void **fsdata)
 {
 	int ret, retries = 0;
@@ -2948,10 +2948,10 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	    ext4_verity_in_progress(inode)) {
 		*fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
 		return ext4_write_begin(file, mapping, pos,
-					len, flags, pagep, fsdata);
+					len, pagep, fsdata);
 	}
 	*fsdata = (void *)0;
-	trace_ext4_da_write_begin(inode, pos, len, flags);
+	trace_ext4_da_write_begin(inode, pos, len);
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		ret = ext4_da_write_inline_data_begin(mapping, inode, pos, len,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9a1a526f2092..b3cf49136b9f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3314,8 +3314,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 }
 
 static int f2fs_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, unsigned flags,
-		struct page **pagep, void **fsdata)
+		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
 {
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -3325,7 +3324,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
-	trace_f2fs_write_begin(inode, pos, len, flags);
+	trace_f2fs_write_begin(inode, pos, len);
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
 		err = -ENOSPC;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4368f90571bd..ed3e8b7a8260 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2483,7 +2483,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 		tocopy = min_t(unsigned long, sb->s_blocksize - offset,
 								towrite);
 retry:
-		err = a_ops->write_begin(NULL, mapping, off, tocopy, 0,
+		err = a_ops->write_begin(NULL, mapping, off, tocopy,
 							&page, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 9b34ccef2501..1f15b0fd1bb0 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -226,7 +226,7 @@ static void fat_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int fat_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e35e394264ad..bca8c2135ec5 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2273,8 +2273,7 @@ static int fuse_writepages(struct address_space *mapping,
  * but how to implement it without killing performance need more thinking.
  */
 static int fuse_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, unsigned flags,
-		struct page **pagep, void **fsdata)
+		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 396735dd3407..93d9aa832139 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -50,7 +50,7 @@ static void hfs_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int hfs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 435b6202532a..73010aa4623f 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -44,7 +44,7 @@ static void hfsplus_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int hfsplus_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 2bfd316e1bf1..e658d8edde35 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -463,7 +463,7 @@ static int hostfs_readpage(struct file *file, struct page *page)
 }
 
 static int hostfs_write_begin(struct file *file, struct address_space *mapping,
-			      loff_t pos, unsigned len, unsigned flags,
+			      loff_t pos, unsigned len,
 			      struct page **pagep, void **fsdata)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 8740b4ea0b52..8b590b3826c3 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -194,7 +194,7 @@ static void hpfs_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int hpfs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index dd3a088db11d..2de9ca5d260d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -383,7 +383,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 static int hugetlbfs_write_begin(struct file *file,
 			struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	return -EINVAL;
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 142d3ba9f0a8..2b35811772de 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -25,7 +25,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *pg, void *fsdata);
 static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata);
 static int jffs2_readpage (struct file *filp, struct page *pg);
 
@@ -130,7 +130,7 @@ static int jffs2_readpage (struct file *filp, struct page *pg)
 }
 
 static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	struct page *pg;
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index e16f77b4e84c..aa9f112107b2 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -314,7 +314,7 @@ static void jfs_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int jfs_write_begin(struct file *file, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
+				loff_t pos, unsigned len,
 				struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/libfs.c b/fs/libfs.c
index d4395e1c6696..a1c10d3163e0 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -549,7 +549,7 @@ static int simple_readpage(struct file *file, struct page *page)
 }
 
 int simple_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	struct page *page;
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 5e8d7ba661cf..3add78bccedc 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -423,7 +423,7 @@ static void minix_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int minix_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d66088dd33e7..314d2d7ba84a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -313,7 +313,7 @@ static bool nfs_want_read_modify_write(struct file *file, struct page *page,
  * increment the page use counts until he is done with the page.
  */
 static int nfs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index be09a0d10f04..02297ec8dc55 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -248,7 +248,7 @@ void nilfs_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int nilfs_write_begin(struct file *file, struct address_space *mapping,
-			     loff_t pos, unsigned len, unsigned flags,
+			     loff_t pos, unsigned len,
 			     struct page **pagep, void **fsdata)
 
 {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 16466c8648f3..1364174cc6c9 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -862,7 +862,7 @@ static int ntfs_get_block_write_begin(struct inode *inode, sector_t vbn,
 }
 
 static int ntfs_write_begin(struct file *file, struct address_space *mapping,
-			    loff_t pos, u32 len, u32 flags, struct page **pagep,
+			    loff_t pos, u32 len, struct page **pagep,
 			    void **fsdata)
 {
 	int err;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 4b9af65cb61b..7cffe9dcad17 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -1881,7 +1881,7 @@ int ocfs2_write_begin_nolock(struct address_space *mapping,
 }
 
 static int ocfs2_write_begin(struct file *file, struct address_space *mapping,
-			     loff_t pos, unsigned len, unsigned flags,
+			     loff_t pos, unsigned len,
 			     struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 349b96d89c44..980b0a72c172 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -316,7 +316,7 @@ static void omfs_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int omfs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 809690db8be2..bc7ccd15d7a3 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -326,9 +326,8 @@ static int orangefs_readpage(struct file *file, struct page *page)
 }
 
 static int orangefs_write_begin(struct file *file,
-    struct address_space *mapping,
-    loff_t pos, unsigned len, unsigned flags, struct page **pagep,
-    void **fsdata)
+		struct address_space *mapping, loff_t pos, unsigned len,
+		struct page **pagep, void **fsdata)
 {
 	struct orangefs_write_range *wr;
 	struct folio *folio;
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index aa31cf1dbba6..46ba4892030a 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2753,7 +2753,7 @@ static void reiserfs_truncate_failed_write(struct inode *inode)
 
 static int reiserfs_write_begin(struct file *file,
 				struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
+				loff_t pos, unsigned len,
 				struct page **pagep, void **fsdata)
 {
 	struct inode *inode;
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 96b7fd4facf3..96ad24fe0ffb 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -477,7 +477,7 @@ static void sysv_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int sysv_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 0911fc311434..81c085c4decf 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -215,8 +215,7 @@ static void release_existing_page_budget(struct ubifs_info *c)
 }
 
 static int write_begin_slow(struct address_space *mapping,
-			    loff_t pos, unsigned len, struct page **pagep,
-			    unsigned flags)
+			    loff_t pos, unsigned len, struct page **pagep)
 {
 	struct inode *inode = mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
@@ -419,7 +418,7 @@ static int allocate_budget(struct ubifs_info *c, struct page *page,
  * without forcing write-back. The slow path does not make this assumption.
  */
 static int ubifs_write_begin(struct file *file, struct address_space *mapping,
-			     loff_t pos, unsigned len, unsigned flags,
+			     loff_t pos, unsigned len,
 			     struct page **pagep, void **fsdata)
 {
 	struct inode *inode = mapping->host;
@@ -493,7 +492,7 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 		unlock_page(page);
 		put_page(page);
 
-		return write_begin_slow(mapping, pos, len, pagep, flags);
+		return write_begin_slow(mapping, pos, len, pagep);
 	}
 
 	/*
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 724bb3141fda..3f4d5c44c784 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -87,7 +87,7 @@ static int udf_adinicb_writepage(struct page *page,
 
 static int udf_adinicb_write_begin(struct file *file,
 			struct address_space *mapping, loff_t pos,
-			unsigned len, unsigned flags, struct page **pagep,
+			unsigned len, struct page **pagep,
 			void **fsdata)
 {
 	struct page *page;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 88a95886ce8a..866f9a53248e 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -204,7 +204,7 @@ static void udf_readahead(struct readahead_control *rac)
 }
 
 static int udf_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index bd0e0c66f93d..6c973b71cab2 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -495,7 +495,7 @@ static void ufs_write_failed(struct address_space *mapping, loff_t to)
 }
 
 static int ufs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	int ret;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f81bc5cbcbb6..a0e73432526f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -346,7 +346,7 @@ struct address_space_operations {
 	void (*readahead)(struct readahead_control *);
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
+				loff_t pos, unsigned len,
 				struct page **pagep, void **fsdata);
 	int (*write_end)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
@@ -3179,7 +3179,7 @@ extern int noop_fsync(struct file *, loff_t, loff_t, int);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
 extern int simple_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata);
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index d06ffffad434..229e8fae66a3 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -335,17 +335,15 @@ TRACE_EVENT(ext4_begin_ordered_truncate,
 
 DECLARE_EVENT_CLASS(ext4__write_begin,
 
-	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len,
-		 unsigned int flags),
+	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len),
 
-	TP_ARGS(inode, pos, len, flags),
+	TP_ARGS(inode, pos, len),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(	loff_t,	pos			)
 		__field(	unsigned int, len		)
-		__field(	unsigned int, flags		)
 	),
 
 	TP_fast_assign(
@@ -353,29 +351,26 @@ DECLARE_EVENT_CLASS(ext4__write_begin,
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= pos;
 		__entry->len	= len;
-		__entry->flags	= flags;
 	),
 
-	TP_printk("dev %d,%d ino %lu pos %lld len %u flags %u",
+	TP_printk("dev %d,%d ino %lu pos %lld len %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
-		  __entry->pos, __entry->len, __entry->flags)
+		  __entry->pos, __entry->len)
 );
 
 DEFINE_EVENT(ext4__write_begin, ext4_write_begin,
 
-	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len,
-		 unsigned int flags),
+	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len),
 
-	TP_ARGS(inode, pos, len, flags)
+	TP_ARGS(inode, pos, len)
 );
 
 DEFINE_EVENT(ext4__write_begin, ext4_da_write_begin,
 
-	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len,
-		 unsigned int flags),
+	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len),
 
-	TP_ARGS(inode, pos, len, flags)
+	TP_ARGS(inode, pos, len)
 );
 
 DECLARE_EVENT_CLASS(ext4__write_end,
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 1779e133cea0..bea654a85e6b 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1159,17 +1159,15 @@ DEFINE_EVENT_CONDITION(f2fs__bio, f2fs_submit_write_bio,
 
 TRACE_EVENT(f2fs_write_begin,
 
-	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len,
-				unsigned int flags),
+	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len),
 
-	TP_ARGS(inode, pos, len, flags),
+	TP_ARGS(inode, pos, len),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
 		__field(loff_t,	pos)
 		__field(unsigned int, len)
-		__field(unsigned int, flags)
 	),
 
 	TP_fast_assign(
@@ -1177,14 +1175,12 @@ TRACE_EVENT(f2fs_write_begin,
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= pos;
 		__entry->len	= len;
-		__entry->flags	= flags;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, pos = %llu, len = %u, flags = %u",
+	TP_printk("dev = (%d,%d), ino = %lu, pos = %llu, len = %u",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->pos,
-		__entry->len,
-		__entry->flags)
+		__entry->len)
 );
 
 TRACE_EVENT(f2fs_write_end,
diff --git a/mm/filemap.c b/mm/filemap.c
index 9a1eef6c5d35..0751843b052f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3628,8 +3628,7 @@ int pagecache_write_begin(struct file *file, struct address_space *mapping,
 {
 	const struct address_space_operations *aops = mapping->a_ops;
 
-	return aops->write_begin(file, mapping, pos, len, flags,
-							pagep, fsdata);
+	return aops->write_begin(file, mapping, pos, len, pagep, fsdata);
 }
 EXPORT_SYMBOL(pagecache_write_begin);
 
@@ -3754,7 +3753,6 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	const struct address_space_operations *a_ops = mapping->a_ops;
 	long status = 0;
 	ssize_t written = 0;
-	unsigned int flags = 0;
 
 	do {
 		struct page *page;
@@ -3784,7 +3782,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		status = a_ops->write_begin(file, mapping, pos, bytes, flags,
+		status = a_ops->write_begin(file, mapping, pos, bytes,
 						&page, &fsdata);
 		if (unlikely(status < 0))
 			break;
diff --git a/mm/shmem.c b/mm/shmem.c
index 4b2fea33158e..0f557a512171 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2426,7 +2426,7 @@ static int shmem_initxattrs(struct inode *, const struct xattr *, void *);
 
 static int
 shmem_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
 {
 	struct inode *inode = mapping->host;
-- 
2.34.1

