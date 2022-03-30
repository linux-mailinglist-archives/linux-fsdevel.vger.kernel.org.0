Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F10F4EC717
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347179AbiC3Ovk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347236AbiC3OvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01A813FB9
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+2zwYq+dMnlNSJeiNjJPF/adEkR6Ov+KiCIZAND8rQY=; b=oa0jxdXuygjGgXDhA0atxLr1iB
        Or0FtjsFogK9VnCFR9JuWdv6G4bLBkJelG4+YU5FnZH7wBsbWn8nSLB7N4o/F2UVvrMvQtulLopfF
        9VQxT2eCqKOHyhwAhgPKzPNEPg0QPaIBS251elgnKIbeLcnJX5Dl/2hQJqlCfkO+p4CwycYcbKGqv
        Wi3MsxJsL4qMZ9w8/tRzpsm4fZuA9VBn+v/CKGDo6OmONuyBHK7/adlUgCaNHgBc9q2N46GnK8/to
        MC/YCIE3fwTrOlOAEE4kPV/lNfEPOWAOMTEBRRbXl58vDiEoLvdU8vXrwBK1fHdDYYs2ysS5IBz6a
        xpKYt5+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdb-001KCx-SF; Wed, 30 Mar 2022 14:49:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/12] fs: Remove ->readpages address space operation
Date:   Wed, 30 Mar 2022 15:49:20 +0100
Message-Id: <20220330144930.315951-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220330144930.315951-1-willy@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
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

All filesystems have now been converted to use ->readahead, so
remove the ->readpages operation and fix all the comments that
used to refer to it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/fsverity.rst |  6 +++---
 Documentation/filesystems/locking.rst  |  6 ------
 Documentation/filesystems/vfs.rst      | 11 -----------
 fs/btrfs/reflink.c                     |  4 ++--
 fs/cifs/cifssmb.c                      |  2 +-
 fs/cifs/inode.c                        |  2 +-
 fs/crypto/crypto.c                     |  2 +-
 fs/ext4/readpage.c                     |  2 +-
 fs/f2fs/data.c                         |  4 ++--
 fs/fuse/fuse_i.h                       |  2 +-
 fs/verity/verify.c                     |  4 ++--
 include/linux/fs.h                     |  6 ------
 include/linux/fsverity.h               |  2 +-
 mm/filemap.c                           |  2 +-
 mm/readahead.c                         | 15 ++-------------
 15 files changed, 18 insertions(+), 52 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 1d831e3cbcb3..8cc536d08f51 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -549,7 +549,7 @@ Pagecache
 ~~~~~~~~~
 
 For filesystems using Linux's pagecache, the ``->readpage()`` and
-``->readpages()`` methods must be modified to verify pages before they
+``->readahead()`` methods must be modified to verify pages before they
 are marked Uptodate.  Merely hooking ``->read_iter()`` would be
 insufficient, since ``->read_iter()`` is not used for memory maps.
 
@@ -611,7 +611,7 @@ workqueue, and then the workqueue work does the decryption or
 verification.  Finally, pages where no decryption or verity error
 occurred are marked Uptodate, and the pages are unlocked.
 
-Files on ext4 and f2fs may contain holes.  Normally, ``->readpages()``
+Files on ext4 and f2fs may contain holes.  Normally, ``->readahead()``
 simply zeroes holes and sets the corresponding pages Uptodate; no bios
 are issued.  To prevent this case from bypassing fs-verity, these
 filesystems use fsverity_verify_page() to verify hole pages.
@@ -778,7 +778,7 @@ weren't already directly answered in other parts of this document.
     - To prevent bypassing verification, pages must not be marked
       Uptodate until they've been verified.  Currently, each
       filesystem is responsible for marking pages Uptodate via
-      ``->readpages()``.  Therefore, currently it's not possible for
+      ``->readahead()``.  Therefore, currently it's not possible for
       the VFS to do the verification on its own.  Changing this would
       require significant changes to the VFS and all filesystems.
 
diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 2998cec9af4b..c26d854275a0 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -241,8 +241,6 @@ prototypes::
 	int (*writepages)(struct address_space *, struct writeback_control *);
 	bool (*dirty_folio)(struct address_space *, struct folio *folio);
 	void (*readahead)(struct readahead_control *);
-	int (*readpages)(struct file *filp, struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages);
 	int (*write_begin)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
 				struct page **pagep, void **fsdata);
@@ -274,7 +272,6 @@ readpage:		yes, unlocks				shared
 writepages:
 dirty_folio		maybe
 readahead:		yes, unlocks				shared
-readpages:		no					shared
 write_begin:		locks the page		 exclusive
 write_end:		yes, unlocks		 exclusive
 bmap:
@@ -300,9 +297,6 @@ completion.
 
 ->readahead() unlocks the pages that I/O is attempted on like ->readpage().
 
-->readpages() populates the pagecache with the passed pages and starts
-I/O against them.  They come unlocked upon I/O completion.
-
 ->writepage() is used for two purposes: for "memory cleansing" and for
 "sync".  These are quite different operations and the behaviour may differ
 depending upon the mode.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 4f14edf93941..794bd1a66bfb 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -726,8 +726,6 @@ cache in your filesystem.  The following members are defined:
 		int (*writepages)(struct address_space *, struct writeback_control *);
 		bool (*dirty_folio)(struct address_space *, struct folio *);
 		void (*readahead)(struct readahead_control *);
-		int (*readpages)(struct file *filp, struct address_space *mapping,
-				 struct list_head *pages, unsigned nr_pages);
 		int (*write_begin)(struct file *, struct address_space *mapping,
 				   loff_t pos, unsigned len, unsigned flags,
 				struct page **pagep, void **fsdata);
@@ -817,15 +815,6 @@ cache in your filesystem.  The following members are defined:
 	completes successfully.  Setting PageError on any page will be
 	ignored; simply unlock the page if an I/O error occurs.
 
-``readpages``
-	called by the VM to read pages associated with the address_space
-	object.  This is essentially just a vector version of readpage.
-	Instead of just one page, several pages are requested.
-	readpages is only used for read-ahead, so read errors are
-	ignored.  If anything goes wrong, feel free to give up.
-	This interface is deprecated and will be removed by the end of
-	2020; implement readahead instead.
-
 ``write_begin``
 	Called by the generic buffered write code to ask the filesystem
 	to prepare to write len bytes at the given offset in the file.
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 04a88bfe4fcf..998e3f180d90 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -645,7 +645,7 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 	int ret;
 
 	/*
-	 * Lock destination range to serialize with concurrent readpages() and
+	 * Lock destination range to serialize with concurrent readahead() and
 	 * source range to serialize with relocation.
 	 */
 	btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
@@ -739,7 +739,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	}
 
 	/*
-	 * Lock destination range to serialize with concurrent readpages() and
+	 * Lock destination range to serialize with concurrent readahead() and
 	 * source range to serialize with relocation.
 	 */
 	btrfs_double_extent_lock(src, off, inode, destoff, len);
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 071e2f21a7db..bc3ded4f34f6 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -597,7 +597,7 @@ CIFSSMBNegotiate(const unsigned int xid,
 	set_credits(server, server->maxReq);
 	/* probably no need to store and check maxvcs */
 	server->maxBuf = le32_to_cpu(pSMBr->MaxBufferSize);
-	/* set up max_read for readpages check */
+	/* set up max_read for readahead check */
 	server->max_read = server->maxBuf;
 	server->max_rw = le32_to_cpu(pSMBr->MaxRawSize);
 	cifs_dbg(NOISY, "Max buf = %d\n", ses->server->maxBuf);
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 60d853c92f6a..2f9e7d2f81b6 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -49,7 +49,7 @@ static void cifs_set_ops(struct inode *inode)
 			inode->i_fop = &cifs_file_ops;
 		}
 
-		/* check if server can support readpages */
+		/* check if server can support readahead */
 		if (cifs_sb_master_tcon(cifs_sb)->ses->server->max_read <
 				PAGE_SIZE + MAX_CIFS_HDR_SIZE)
 			inode->i_data.a_ops = &cifs_addr_ops_smallbuf;
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 4fcca79f39ae..526a4c1bed99 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -248,7 +248,7 @@ EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
  * which must still be locked and not uptodate.  Normally, blocksize ==
  * PAGE_SIZE and the whole page is decrypted at once.
  *
- * This is for use by the filesystem's ->readpages() method.
+ * This is for use by the filesystem's ->readahead() method.
  *
  * Return: 0 on success; -errno on failure
  */
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 1aa26d6634fc..af491e170c4a 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -109,7 +109,7 @@ static void verity_work(struct work_struct *work)
 	struct bio *bio = ctx->bio;
 
 	/*
-	 * fsverity_verify_bio() may call readpages() again, and although verity
+	 * fsverity_verify_bio() may call readahead() again, and although verity
 	 * will be disabled for that, decryption may still be needed, causing
 	 * another bio_post_read_ctx to be allocated.  So to guarantee that
 	 * mempool_alloc() never deadlocks we must free the current ctx first.
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f8fcbe91059b..c92920c8661d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -164,7 +164,7 @@ static void f2fs_verify_bio(struct work_struct *work)
 	bool may_have_compressed_pages = (ctx->enabled_steps & STEP_DECOMPRESS);
 
 	/*
-	 * fsverity_verify_bio() may call readpages() again, and while verity
+	 * fsverity_verify_bio() may call readahead() again, and while verity
 	 * will be disabled for this, decryption and/or decompression may still
 	 * be needed, resulting in another bio_post_read_ctx being allocated.
 	 * So to prevent deadlocks we need to release the current ctx to the
@@ -2392,7 +2392,7 @@ static void f2fs_readahead(struct readahead_control *rac)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return;
 
-	/* If the file has inline data, skip readpages */
+	/* If the file has inline data, skip readahead */
 	if (f2fs_has_inline_data(inode))
 		return;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index eac4984cc753..488b460e046f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -627,7 +627,7 @@ struct fuse_conn {
 	/** Connection successful.  Only set in INIT */
 	unsigned conn_init:1;
 
-	/** Do readpages asynchronously?  Only set in INIT */
+	/** Do readahead asynchronously?  Only set in INIT */
 	unsigned async_read:1;
 
 	/** Return an unique read error after abort.  Only set in INIT */
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 0adb970f4e73..14e2fb49cff5 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Data verification functions, i.e. hooks for ->readpages()
+ * Data verification functions, i.e. hooks for ->readahead()
  *
  * Copyright 2019 Google LLC
  */
@@ -214,7 +214,7 @@ EXPORT_SYMBOL_GPL(fsverity_verify_page);
  * that fail verification are set to the Error state.  Verification is skipped
  * for pages already in the Error state, e.g. due to fscrypt decryption failure.
  *
- * This is a helper function for use by the ->readpages() method of filesystems
+ * This is a helper function for use by the ->readahead() method of filesystems
  * that issue bios to read data directly into the page cache.  Filesystems that
  * populate the page cache without issuing bios (e.g. non block-based
  * filesystems) must instead call fsverity_verify_page() directly on each page.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 183160872133..7c81887cc7e8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -370,12 +370,6 @@ struct address_space_operations {
 	/* Mark a folio dirty.  Return true if this dirtied it */
 	bool (*dirty_folio)(struct address_space *, struct folio *);
 
-	/*
-	 * Reads in the requested pages. Unlike ->readpage(), this is
-	 * PURELY used for read-ahead!.
-	 */
-	int (*readpages)(struct file *filp, struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages);
 	void (*readahead)(struct readahead_control *);
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index b568b3c7d095..a7afc800bd8d 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -221,7 +221,7 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
  *
  * This checks whether ->i_verity_info has been set.
  *
- * Filesystems call this from ->readpages() to check whether the pages need to
+ * Filesystems call this from ->readahead() to check whether the pages need to
  * be verified or not.  Don't use IS_VERITY() for this purpose; it's subject to
  * a race condition where the file is being read concurrently with
  * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before ->i_verity_info.)
diff --git a/mm/filemap.c b/mm/filemap.c
index 647d72bf23b6..d904cd7e4181 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2538,7 +2538,7 @@ static int filemap_create_folio(struct file *file,
 	 * the page cache as the locked folio would then be enough to
 	 * synchronize with hole punching. But there are code paths
 	 * such as filemap_update_page() filling in partially uptodate
-	 * pages or ->readpages() that need to hold invalidate_lock
+	 * pages or ->readahead() that need to hold invalidate_lock
 	 * while mapping blocks for IO so let's hold the lock here as
 	 * well to keep locking rules simple.
 	 */
diff --git a/mm/readahead.c b/mm/readahead.c
index 9097af639beb..297bd0719cda 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -170,13 +170,6 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 			unlock_page(page);
 			put_page(page);
 		}
-	} else if (aops->readpages) {
-		aops->readpages(rac->file, rac->mapping, pages,
-				readahead_count(rac));
-		/* Clean up the remaining pages */
-		put_pages_list(pages);
-		rac->_index += rac->_nr_pages;
-		rac->_nr_pages = 0;
 	} else {
 		while ((page = readahead_page(rac))) {
 			aops->readpage(rac->file, page);
@@ -253,10 +246,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		folio = filemap_alloc_folio(gfp_mask, 0);
 		if (!folio)
 			break;
-		if (mapping->a_ops->readpages) {
-			folio->index = index + i;
-			list_add(&folio->lru, &page_pool);
-		} else if (filemap_add_folio(mapping, folio, index + i,
+		if (filemap_add_folio(mapping, folio, index + i,
 					gfp_mask) < 0) {
 			folio_put(folio);
 			read_pages(ractl, &page_pool, true);
@@ -318,8 +308,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages, index;
 
-	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
-			!mapping->a_ops->readahead))
+	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readahead))
 		return;
 
 	/*
-- 
2.34.1

