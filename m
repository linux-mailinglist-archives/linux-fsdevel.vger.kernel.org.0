Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56A74F0B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 00:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFUWP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 18:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfFUWPz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 18:15:55 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060732070B;
        Fri, 21 Jun 2019 22:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561155353;
        bh=it3dbvLdWeh79gTltDF3Q+rToMhoNdaL+phoH/s379U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xDB8DufrBdf9LmnM5xI3OcB0hxub17ncwTcqoz4JmlfEd7I8ANVD9vigjWzd2ryOb
         uWs1XzveAnAcBLo+abbbTWvMcKhRsBxziVwYumvN8vyJ5WQmwZw9cwWrt29B5etibc
         AlUxLBRBcq4J39+cHI8rqWnnrZcU8iCc8EzAET4w=
Date:   Fri, 21 Jun 2019 15:15:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V3 0/7] Consolidate FS read I/O callbacks code
Message-ID: <20190621221550.GF167064@gmail.com>
References: <20190616160813.24464-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616160813.24464-1-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 16, 2019 at 09:38:06PM +0530, Chandan Rajendra wrote:
> This patchset moves the "FS read I/O callbacks" code into a file of its
> own (i.e. fs/read_callbacks.c) and modifies the generic
> do_mpage_readpge() to make use of the functionality provided.
> 
> "FS read I/O callbacks" code implements the state machine that needs
> to be executed after reading data from files that are encrypted and/or
> have verity metadata associated with them.
> 
> With these changes in place, the patchset changes Ext4 to use
> mpage_readpage[s] instead of its own custom ext4_readpage[s]()
> functions. This is done to reduce duplication of code across
> filesystems. Also, "FS read I/O callbacks" source files will be built
> only if CONFIG_FS_ENCRYPTION is enabled.
> 
> The patchset also modifies fs/buffer.c to get file
> encryption/decryption to work with subpage-sized blocks.
> 
> The patches can also be obtained from
> https://github.com/chandanr/linux.git at branch subpage-encryption-v3.
> 

FWIW: while doing my review I put together an (untested) incremental patch that
addresses my comments on the code, so I've provided it below in case you want to
start with it when addressing my comments.

This is just a single diff against your subpage-encryption-v3 branch, so of
course it would still need to be folded into the appropriate patches.  Also see
my suggestions in reply to patch 2 about how to better organize the series.  I
also left TODOs in kerneldoc comments that still need to be updated.

diff --git a/fs/Kconfig b/fs/Kconfig
index d869859c88da18..d95897a0f3d052 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -22,7 +22,7 @@ config FS_IOMAP
 	bool
 
 config FS_READ_CALLBACKS
-       bool
+	bool
 
 source "fs/ext2/Kconfig"
 source "fs/ext4/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index a1a06f0db5c181..81854d8161dea7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -21,8 +21,6 @@ else
 obj-y +=	no-block.o
 endif
 
-obj-$(CONFIG_FS_READ_CALLBACKS) += read_callbacks.o
-
 obj-$(CONFIG_PROC_FS) += proc_namespace.o
 
 obj-y				+= notify/
@@ -55,6 +53,7 @@ obj-$(CONFIG_SYSCTL)		+= drop_caches.o
 
 obj-$(CONFIG_FHANDLE)		+= fhandle.o
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
+obj-$(CONFIG_FS_READ_CALLBACKS)	+= read_callbacks.o
 
 obj-y				+= quota/
 
diff --git a/fs/buffer.c b/fs/buffer.c
index dcb67525dac91d..bfda6af7ea1042 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -247,7 +247,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	return ret;
 }
 
-void end_buffer_async_read(struct buffer_head *bh)
+void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
 	unsigned long flags;
 	struct buffer_head *first;
@@ -255,7 +255,17 @@ void end_buffer_async_read(struct buffer_head *bh)
 	struct page *page;
 	int page_uptodate = 1;
 
+	BUG_ON(!buffer_async_read(bh));
+
 	page = bh->b_page;
+	if (uptodate) {
+		set_buffer_uptodate(bh);
+	} else {
+		clear_buffer_uptodate(bh);
+		buffer_io_error(bh, ", async page read");
+		SetPageError(page);
+	}
+
 	/*
 	 * Be _very_ careful from here on. Bad things can happen if
 	 * two buffer heads end IO at almost the same time and both
@@ -298,25 +308,9 @@ void end_buffer_async_read(struct buffer_head *bh)
  * I/O completion handler for block_read_full_page().  Pages are unlocked
  * after the I/O completes and the read callbacks (if any) have executed.
  */
-static void __end_buffer_async_read(struct buffer_head *bh, int uptodate)
+static void end_buffer_async_read_cbs(struct buffer_head *bh, int uptodate)
 {
-	struct page *page;
-
-	BUG_ON(!buffer_async_read(bh));
-
-	if (read_callbacks_end_bh(bh, uptodate))
-		return;
-
-	page = bh->b_page;
-	if (uptodate) {
-		set_buffer_uptodate(bh);
-	} else {
-		clear_buffer_uptodate(bh);
-		buffer_io_error(bh, ", async page read");
-		SetPageError(page);
-	}
-
-	end_buffer_async_read(bh);
+	read_callbacks_endio_bh(bh, uptodate);
 }
 
 /*
@@ -391,7 +385,7 @@ EXPORT_SYMBOL(end_buffer_async_write);
  */
 static void mark_buffer_async_read(struct buffer_head *bh)
 {
-	bh->b_end_io = __end_buffer_async_read;
+	bh->b_end_io = end_buffer_async_read_cbs;
 	set_buffer_async_read(bh);
 }
 
@@ -2307,10 +2301,10 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
 	for (i = 0; i < nr; i++) {
 		bh = arr[i];
 		if (buffer_uptodate(bh)) {
-			__end_buffer_async_read(bh, 1);
+			end_buffer_async_read(bh, 1);
 		} else {
-			if (WARN_ON(read_callbacks_setup(inode, NULL, bh, NULL))) {
-				__end_buffer_async_read(bh, 0);
+			if (read_callbacks_setup_bh(inode, bh)) {
+				end_buffer_async_read(bh, 0);
 				continue;
 			}
 			submit_bh(REQ_OP_READ, 0, bh);
diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index 7752f99642808b..24ed99e2eca0b2 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -9,7 +9,6 @@ config FS_ENCRYPTION
 	select CRYPTO_CTS
 	select CRYPTO_SHA256
 	select KEYS
-	select FS_READ_CALLBACKS if BLOCK
 	help
 	  Enable encryption of files and directories.  This
 	  feature is similar to ecryptfs, but it is more memory
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index b836d648fd2713..f65cc3059e5c77 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -24,52 +24,8 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/namei.h>
-#include <linux/buffer_head.h>
-#include <linux/read_callbacks.h>
 #include "fscrypt_private.h"
 
-static void fscrypt_decrypt_bio(struct bio *bio)
-{
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
-		int ret = fscrypt_decrypt_pagecache_blocks(page, bv->bv_len,
-							   bv->bv_offset);
-		if (ret)
-			SetPageError(page);
-	}
-}
-
-static void fscrypt_decrypt_bh(struct buffer_head *bh)
-{
-	struct page *page;
-	int ret;
-
-	page = bh->b_page;
-
-	ret = fscrypt_decrypt_pagecache_blocks(page, bh->b_size,
-					bh_offset(bh));
-	if (ret)
-		SetPageError(page);
-}
-
-void fscrypt_decrypt_work(struct work_struct *work)
-{
-	struct read_callbacks_ctx *ctx =
-		container_of(work, struct read_callbacks_ctx, work);
-
-	WARN_ON(!ctx->bh && !ctx->bio);
-
-	if (ctx->bio)
-		fscrypt_decrypt_bio(ctx->bio);
-	else
-		fscrypt_decrypt_bh(ctx->bh);
-
-	read_callbacks(ctx);
-}
-
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 				sector_t pblk, unsigned int len)
 {
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 18c6b664b042fb..56697ba58f8676 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -46,7 +46,6 @@ struct kmem_cache *fscrypt_info_cachep;
 
 void fscrypt_enqueue_decrypt_work(struct work_struct *work)
 {
-	INIT_WORK(work, fscrypt_decrypt_work);
 	queue_work(fscrypt_read_workqueue, work);
 }
 EXPORT_SYMBOL(fscrypt_enqueue_decrypt_work);
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 0bd65921efbf1c..702403dc761464 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -93,8 +93,6 @@ typedef enum {
 	FS_ENCRYPT,
 } fscrypt_direction_t;
 
-#define FS_CTX_REQUIRES_FREE_ENCRYPT_FL		0x00000001
-
 static inline bool fscrypt_valid_enc_modes(u32 contents_mode,
 					   u32 filenames_mode)
 {
@@ -113,9 +111,6 @@ static inline bool fscrypt_valid_enc_modes(u32 contents_mode,
 	return false;
 }
 
-/* bio.c */
-void fscrypt_decrypt_work(struct work_struct *work);
-
 /* crypto.c */
 extern struct kmem_cache *fscrypt_info_cachep;
 extern int fscrypt_initialize(unsigned int cop_flags);
diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index cbb5ca830e57f3..c232aab7260ffd 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -39,6 +39,7 @@ config EXT4_FS
 	select CRYPTO
 	select CRYPTO_CRC32C
 	select FS_IOMAP
+	select FS_READ_CALLBACKS if FS_ENCRYPTION
 	help
 	  This is the next generation of the ext3 filesystem.
 
diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 110a38ca5d53a7..c66072dee9bb5d 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -5,6 +5,7 @@ config F2FS_FS
 	select CRYPTO
 	select CRYPTO_CRC32
 	select F2FS_FS_XATTR if FS_ENCRYPTION
+	select FS_READ_CALLBACKS if FS_ENCRYPTION
 	help
 	  F2FS is based on Log-structured File System (LFS), which supports
 	  versatile "flash-friendly" features. The design has been focused on
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1e8b1eb68a90a3..cf17b19b292557 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -65,20 +65,6 @@ static enum count_type __read_io_type(struct page *page)
 	return F2FS_RD_DATA;
 }
 
-static void f2fs_end_page_op(struct bio *bio, struct page *page)
-{
-	BUG_ON(!PageLocked(page));
-
-	/* PG_error was set if any post_read step failed */
-	if (bio->bi_status || PageError(page)) {
-		ClearPageUptodate(page);
-		/* will re-read again later */
-		ClearPageError(page);
-	}
-
-	dec_page_count(F2FS_P_SB(page), __read_io_type(page));
-}
-
 static void __read_end_io(struct bio *bio)
 {
 	struct page *page;
@@ -88,14 +74,16 @@ static void __read_end_io(struct bio *bio)
 	bio_for_each_segment_all(bv, bio, iter_all) {
 		page = bv->bv_page;
 
-		if (!bio->bi_status && !PageError(page))
+		if (bio->bi_status || read_callbacks_failed(page)) {
+			ClearPageUptodate(page);
+			/* will re-read again later */
+			ClearPageError(page);
+		} else {
 			SetPageUptodate(page);
-
-		f2fs_end_page_op(bio, page);
-
+		}
+		dec_page_count(F2FS_P_SB(page), __read_io_type(page));
 		unlock_page(page);
 	}
-
 	bio_put(bio);
 }
 
@@ -107,10 +95,7 @@ static void f2fs_read_end_io(struct bio *bio)
 		bio->bi_status = BLK_STS_IOERR;
 	}
 
-	if (read_callbacks_end_bio(bio))
-		return;
-
-	__read_end_io(bio);
+	read_callbacks_endio_bio(bio, __read_end_io);
 }
 
 static void f2fs_write_end_io(struct bio *bio)
@@ -511,7 +496,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
-	int ret;
+	int err;
 
 	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
 	if (!bio)
@@ -520,10 +505,10 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	bio->bi_end_io = f2fs_read_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
 
-	ret = read_callbacks_setup(inode, bio, NULL, f2fs_end_page_op);
-	if (ret) {
+	err = read_callbacks_setup_bio(inode, bio);
+	if (err) {
 		bio_put(bio);
-		return ERR_PTR(ret);
+		return ERR_PTR(err);
 	}
 
 	return bio;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 06b89a9862ab2b..182c1d91d150b9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3161,8 +3161,6 @@ void f2fs_destroy_checkpoint_caches(void);
 /*
  * data.c
  */
-int f2fs_init_post_read_processing(void);
-void f2fs_destroy_post_read_processing(void);
 void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, struct page *page,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e2e6a8c7236c7f..2c8123b1587166 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3627,9 +3627,7 @@ static int __init init_f2fs_fs(void)
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
 		goto free_shrinker;
-
 	f2fs_create_root_stats();
-
 	return 0;
 
 free_shrinker:
diff --git a/fs/mpage.c b/fs/mpage.c
index 387c23b529eb90..bf0549d9ce656e 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -33,6 +33,25 @@
 #include <linux/read_callbacks.h>
 #include "internal.h"
 
+static void __mpage_end_io(struct bio *bio)
+{
+	struct bio_vec *bv;
+	struct bvec_iter_all iter_all;
+	bool is_write = (bio_op(bio) != REQ_OP_READ);
+	int err = blk_status_to_errno(bio->bi_status);
+
+	bio_for_each_segment_all(bv, bio, iter_all) {
+		struct page *page = bv->bv_page;
+		int this_err = err;
+
+		if (!err && !is_write && read_callbacks_failed(page))
+			this_err = -EIO;
+
+		page_endio(page, is_write, this_err);
+	}
+	bio_put(bio);
+}
+
 /*
  * I/O completion handler for multipage BIOs.
  *
@@ -47,18 +66,7 @@
  */
 static void mpage_end_io(struct bio *bio)
 {
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
-
-	if (read_callbacks_end_bio(bio))
-		return;
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
-		page_endio(page, bio_op(bio),
-			   blk_status_to_errno(bio->bi_status));
-	}
-
-	bio_put(bio);
+	read_callbacks_endio_bio(bio, __mpage_end_io);
 }
 
 static struct bio *mpage_bio_submit(int op, int op_flags, struct bio *bio)
@@ -313,7 +321,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 		if (args->bio == NULL)
 			goto confused;
 
-		if (read_callbacks_setup(inode, args->bio, NULL, NULL)) {
+		if (read_callbacks_setup_bio(inode, args->bio)) {
 			bio_put(args->bio);
 			args->bio = NULL;
 			goto confused;
@@ -339,7 +347,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 confused:
 	if (args->bio)
 		args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
-	if (!PageUptodate(page) && !PageError(page))
+	if (!PageUptodate(page))
 		block_read_full_page(page, args->get_block);
 	else
 		unlock_page(page);
diff --git a/fs/read_callbacks.c b/fs/read_callbacks.c
index 7b3ab11c1652f6..3c2baffebb6159 100644
--- a/fs/read_callbacks.c
+++ b/fs/read_callbacks.c
@@ -1,15 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This file tracks the state machine that needs to be executed after reading
- * data from files that are encrypted and/or have verity metadata associated
- * with them.
+ * fs/read_callbacks.c
+ *
+ * Utility functions for filesystems to postprocess data after I/O completion.
+ * Currently this only supports decryption (fscrypt), but eventually it will
+ * support fs-verity too.
+ *
+ * Before submitting a read I/O, filesystems call read_callbacks_setup_bio() (or
+ * read_callbacks_setup_bh()) to allocate and store a read_callbacks_ctx in
+ * bio::bi_private (or buffer_head::b_private).  After the I/O completes, they
+ * call read_callbacks_endio_bio() (or read_callbacks_endio_bh()) to execute the
+ * postprocessing steps and free the context if needed, then unlock the pages.
+ *
+ * All pages into which the I/O is being done are assumed to be pagecache pages.
  */
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/pagemap.h>
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
 #include <linux/fscrypt.h>
+#include <linux/mm.h>
 #include <linux/read_callbacks.h>
 
 #define NUM_PREALLOC_READ_CALLBACK_CTXS	128
@@ -23,194 +31,182 @@ enum read_callbacks_step {
 	STEP_DECRYPT,
 };
 
-static void put_read_callbacks_ctx(struct read_callbacks_ctx *ctx)
-{
-	mempool_free(ctx, read_callbacks_ctx_pool);
-}
+struct read_callbacks_ctx {
+	unsigned int enabled_steps;
+	unsigned int cur_step;
+	struct bio *bio;
+	struct buffer_head *bh;
+	end_bio_func_t end_bio;
+	struct work_struct work;
+};
 
-static void end_read_callbacks_bio(struct bio *bio)
+static struct read_callbacks_ctx *get_read_callbacks_ctx(struct inode *inode)
 {
-	struct read_callbacks_ctx *ctx;
-	struct page *page;
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
-
-	ctx = bio->bi_private;
+	struct read_callbacks_ctx *ctx = NULL;
+	unsigned int enabled_steps = 0;
 
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		page = bv->bv_page;
+	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
+		enabled_steps |= 1 << STEP_DECRYPT;
 
-		if (bio->bi_status || PageError(page)) {
-			ClearPageUptodate(page);
-			SetPageError(page);
-		} else {
-			SetPageUptodate(page);
-		}
+	if (enabled_steps) {
+		ctx = mempool_alloc(read_callbacks_ctx_pool, GFP_NOFS);
+		if (!ctx)
+			return ERR_PTR(-ENOMEM);
+		ctx->enabled_steps = enabled_steps;
+		ctx->cur_step = STEP_INITIAL;
+	}
+	return ctx;
+}
 
-		if (ctx->page_op)
-			ctx->page_op(bio, page);
+/**
+ * read_callbacks_setup_bio() - Initialize the read callbacks state machine
+ * @inode: The file on which read I/O is performed.
+ * @bio: bio holding page cache pages on which read I/O is performed
+ *
+ * Based on the nature of the file's data (e.g. encrypted), this function
+ * computes the steps that need to be performed after data is read of the
+ * backing disk. This information is saved in a context structure. A pointer to
+ * the context structure is then stored in bio->bi_private for later usage.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int read_callbacks_setup_bio(struct inode *inode, struct bio *bio)
+{
+	struct read_callbacks_ctx *ctx = get_read_callbacks_ctx(inode);
 
-		unlock_page(page);
+	if (ctx) {
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
+		ctx->bio = bio;
+		ctx->bh = NULL;
+		bio->bi_private = ctx;
 	}
+	return 0;
+}
+EXPORT_SYMBOL(read_callbacks_setup_bio);
 
-	put_read_callbacks_ctx(ctx);
+/**
+ * read_callbacks_setup_bh() - TODO
+ */
+int read_callbacks_setup_bh(struct inode *inode, struct buffer_head *bh)
+{
+	struct read_callbacks_ctx *ctx = get_read_callbacks_ctx(inode);
 
-	bio_put(bio);
+	if (ctx) {
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
+		ctx->bh = bh;
+		ctx->bio = NULL;
+		bh->b_private = ctx;
+	}
+	return 0;
 }
+EXPORT_SYMBOL(read_callbacks_setup_bh);
 
-static void end_read_callbacks_bh(struct buffer_head *bh)
+static void free_read_callbacks_ctx(struct read_callbacks_ctx *ctx)
 {
-	struct read_callbacks_ctx *ctx;
-
-	if (!PageError(bh->b_page))
-		set_buffer_uptodate(bh);
+	mempool_free(ctx, read_callbacks_ctx_pool);
+}
 
-	ctx = bh->b_private;
+static void read_callbacks(struct read_callbacks_ctx *ctx);
 
-	end_buffer_async_read(bh);
+static void decrypt_bio(struct bio *bio)
+{
+	struct bio_vec *bv;
+	struct bvec_iter_all iter_all;
 
-	put_read_callbacks_ctx(ctx);
+	bio_for_each_segment_all(bv, bio, iter_all) {
+		struct page *page = bv->bv_page;
+		int ret = fscrypt_decrypt_pagecache_blocks(page, bv->bv_len,
+							   bv->bv_offset);
+		if (ret)
+			SetPageError(page);
+	}
 }
 
-static void end_read_callbacks(struct bio *bio, struct buffer_head *bh)
+static void decrypt_bh(struct buffer_head *bh)
 {
-	if (bio)
-		end_read_callbacks_bio(bio);
-	else
-		end_read_callbacks_bh(bh);
+	struct page *page = bh->b_page;
+
+	if (fscrypt_decrypt_pagecache_blocks(page, bh->b_size, bh_offset(bh)))
+		SetPageError(page);
 }
 
-/**
- * read_callbacks_end_bio() - Initiate the read callbacks state machine.
- * @bio: bio on which read I/O operation has just been completed.
- *
- * Initiates the execution of the read callbacks state machine when the read
- * operation has been completed successfully. If there was an error associated
- * with the bio, this function frees the read callbacks context structure stored
- * in bio->bi_private (if any).
- *
- * Return: 1 to indicate that the bio has been handled (including unlocking the
- * pages); 0 otherwise.
- */
-int read_callbacks_end_bio(struct bio *bio)
+static void decrypt_work(struct work_struct *work)
 {
-	if (!bio->bi_status && bio->bi_private) {
-		read_callbacks((struct read_callbacks_ctx *)(bio->bi_private));
-		return 1;
-	}
+	struct read_callbacks_ctx *ctx =
+		container_of(work, struct read_callbacks_ctx, work);
 
-	if (bio->bi_private)
-		put_read_callbacks_ctx((struct read_callbacks_ctx *)(bio->bi_private));
+	if (ctx->bio)
+		decrypt_bio(ctx->bio);
+	else
+		decrypt_bh(ctx->bh);
 
-	return 0;
+	read_callbacks(ctx);
 }
-EXPORT_SYMBOL(read_callbacks_end_bio);
 
-/**
- * read_callbacks_end_bh() - Initiate the read callbacks state machine.
- * @bh: buffer head on which read I/O operation has just been completed.
- * @uptodate: Buffer head's I/O status.
- *
- * Initiates the execution of the read callbacks state machine when the read
- * operation has been completed successfully. If there was an error associated
- * with the buffer head, this function frees the read callbacks context
- * structure stored in bh->b_private (if any).
- *
- * Return: 1 to indicate that the buffer head has been handled (including
- * unlocking the buffer head and the corresponding page if applicable); 0
- * otherwise.
- */
-int read_callbacks_end_bh(struct buffer_head *bh, int uptodate)
+static void end_read_callbacks(struct read_callbacks_ctx *ctx)
 {
-	if (uptodate && bh->b_private) {
-		read_callbacks((struct read_callbacks_ctx *)(bh->b_private));
-		return 1;
-	}
-
-	if (bh->b_private)
-		put_read_callbacks_ctx((struct read_callbacks_ctx *)(bh->b_private));
-
-	return 0;
+	if (ctx->bio)
+		ctx->end_bio(ctx->bio);
+	else
+		end_buffer_async_read(ctx->bh,
+				      !read_callbacks_failed(ctx->bh->b_page));
+	free_read_callbacks_ctx(ctx);
 }
-EXPORT_SYMBOL(read_callbacks_end_bh);
 
-/**
- * read_callbacks() - Execute the read callbacks state machine.
- * @ctx: The context structure tracking the current state.
- *
- * For each state, this function enqueues a work into appropriate subsystem's
- * work queue. After performing further processing of the data in the bio's
- * pages, the subsystem should invoke read_calbacks() to continue with the next
- * state in the state machine.
- */
-void read_callbacks(struct read_callbacks_ctx *ctx)
+static void read_callbacks(struct read_callbacks_ctx *ctx)
 {
-	/*
-	 * We use different work queues for decryption and for verity because
-	 * verity may require reading metadata pages that need decryption, and
-	 * we shouldn't recurse to the same workqueue.
-	 */
 	switch (++ctx->cur_step) {
 	case STEP_DECRYPT:
 		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
+			INIT_WORK(&ctx->work, decrypt_work);
 			fscrypt_enqueue_decrypt_work(&ctx->work);
 			return;
 		}
 		ctx->cur_step++;
 		/* fall-through */
 	default:
-		end_read_callbacks(ctx->bio, ctx->bh);
+		end_read_callbacks(ctx);
 	}
 }
-EXPORT_SYMBOL(read_callbacks);
 
 /**
- * read_callbacks_setup() - Initialize the read callbacks state machine
- * @inode: The file on which read I/O is performed.
- * @bio: bio holding page cache pages on which read I/O is performed.
- * @bh: Buffer head on which read I/O is performed.
- * @page_op: Function to perform filesystem specific operations on a page.
- *
- * Based on the nature of the file's data (e.g. encrypted), this function
- * computes the steps that need to be performed after data is read of the
- * backing disk. This information is saved in a context structure. A pointer
- * to the context structure is then stored in bio->bi_private for later
- * usage.
- *
- * Return: 0 on success; An error code on failure.
+ * read_callbacks_endio_bio() - TODO
  */
-int read_callbacks_setup(struct inode *inode, struct bio *bio,
-			struct buffer_head *bh, end_page_op_t page_op)
+void read_callbacks_endio_bio(struct bio *bio, end_bio_func_t end_bio)
 {
-	struct read_callbacks_ctx *ctx = NULL;
-	unsigned int enabled_steps = 0;
-
-	if (!bh && !bio)
-		return -EINVAL;
+	struct read_callbacks_ctx *ctx = bio->bi_private;
 
-	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
-		enabled_steps |= 1 << STEP_DECRYPT;
+	if (ctx) {
+		if (!bio->bi_status) {
+			ctx->end_bio = end_bio;
+			read_callbacks(ctx);
+			return;
+		}
+		free_read_callbacks_ctx(ctx);
+	}
+	end_bio(bio);
+}
+EXPORT_SYMBOL(read_callbacks_endio_bio);
 
-	if (enabled_steps) {
-		ctx = mempool_alloc(read_callbacks_ctx_pool, GFP_NOFS);
-		if (!ctx)
-			return -ENOMEM;
+/**
+ * read_callbacks_endio_bh() - TODO
+ */
+void read_callbacks_endio_bh(struct buffer_head *bh, int uptodate)
+{
+	struct read_callbacks_ctx *ctx = bh->b_private;
 
-		ctx->bh = bh;
-		ctx->bio = bio;
-		ctx->inode = inode;
-		ctx->enabled_steps = enabled_steps;
-		ctx->cur_step = STEP_INITIAL;
-		ctx->page_op = page_op;
-		if (bio)
-			bio->bi_private = ctx;
-		else
-			bh->b_private = ctx;
+	if (ctx) {
+		if (uptodate) {
+			read_callbacks(ctx);
+			return;
+		}
+		free_read_callbacks_ctx(ctx);
 	}
-
-	return 0;
+	end_buffer_async_read(bh, uptodate);
 }
-EXPORT_SYMBOL(read_callbacks_setup);
+EXPORT_SYMBOL(read_callbacks_endio_bh);
 
 static int __init init_read_callbacks(void)
 {
@@ -229,5 +225,4 @@ static int __init init_read_callbacks(void)
 fail:
 	return -ENOMEM;
 }
-
 fs_initcall(init_read_callbacks);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 42d0d63c7a3b38..5176a7a7e22aab 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -165,7 +165,7 @@ void create_empty_buffers(struct page *, unsigned long,
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_async_write(struct buffer_head *bh, int uptodate);
-void end_buffer_async_read(struct buffer_head *bh);
+void end_buffer_async_read(struct buffer_head *bh, int uptodate);
 
 /* Things to do with buffers at mapping->private_list */
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 13012c589aa32e..6d2d16d79752bb 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -402,6 +402,7 @@ static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
 	return !memcmp(de_name, fname->disk_name.name, fname->disk_name.len);
 }
 
+/* bio.c */
 static inline int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 					sector_t pblk, unsigned int len)
 {
diff --git a/include/linux/read_callbacks.h b/include/linux/read_callbacks.h
index 0b52d7961fb2c8..610324f362a87e 100644
--- a/include/linux/read_callbacks.h
+++ b/include/linux/read_callbacks.h
@@ -2,44 +2,58 @@
 #ifndef _READ_CALLBACKS_H
 #define _READ_CALLBACKS_H
 
-typedef void (*end_page_op_t)(struct bio *bio, struct page *page);
-
-struct read_callbacks_ctx {
-	struct buffer_head *bh;
-	struct bio *bio;
-	struct inode *inode;
-	struct work_struct work;
-	unsigned int cur_step;
-	unsigned int enabled_steps;
-	end_page_op_t page_op;
-};
+#include <linux/buffer_head.h>
+
+struct bio;
+struct page;
+struct read_callbacks_ctx;
+
+typedef void (*end_bio_func_t)(struct bio *bio);
 
 #ifdef CONFIG_FS_READ_CALLBACKS
-void read_callbacks(struct read_callbacks_ctx *ctx);
-int read_callbacks_end_bio(struct bio *bio);
-int read_callbacks_end_bh(struct buffer_head *bh, int uptodate);
-int read_callbacks_setup(struct inode *inode, struct bio *bio,
-			struct buffer_head *bh, end_page_op_t page_op);
-#else
-static inline void read_callbacks(struct read_callbacks_ctx *ctx)
+
+int read_callbacks_setup_bio(struct inode *inode, struct bio *bio);
+
+int read_callbacks_setup_bh(struct inode *inode, struct buffer_head *bh);
+
+void read_callbacks_endio_bio(struct bio *bio, end_bio_func_t end_bio);
+
+void read_callbacks_endio_bh(struct buffer_head *bh, int uptodate);
+
+static inline bool read_callbacks_failed(struct page *page)
 {
+	return PageError(page);
 }
 
-static inline int read_callbacks_end_bio(struct bio *bio)
+#else /* !CONFIG_FS_READ_CALLBACKS */
+
+static inline int read_callbacks_setup_bio(struct inode *inode, struct bio *bio)
 {
-	return -EOPNOTSUPP;
+	return 0;
 }
 
-static inline int read_callbacks_end_bh(struct buffer_head *bh, int uptodate)
+static inline int read_callbacks_setup_bh(struct inode *inode,
+					  struct buffer_head *bh)
 {
-	return -EOPNOTSUPP;
+	return 0;
 }
 
-static inline int read_callbacks_setup(struct inode *inode, struct bio *bio,
-				struct buffer_head *bh, end_page_op_t page_op)
+static inline void read_callbacks_endio_bio(struct bio *bio,
+					    end_bio_func_t end_bio)
 {
-	return -EOPNOTSUPP;
+	end_bio(bio);
 }
-#endif
+
+static inline void read_callbacks_endio_bh(struct buffer_head *bh, int uptodate)
+{
+	end_buffer_async_read(bh, uptodate);
+}
+
+static inline bool read_callbacks_failed(struct page *page)
+{
+	return false;
+}
+
+#endif /* !CONFIG_FS_READ_CALLBACKS */
 
 #endif	/* _READ_CALLBACKS_H */
