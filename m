Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146891BF792
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 14:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgD3MAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 08:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727121AbgD3MAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:00:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BB2C035495
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 05:00:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y73so7362706ybe.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 05:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8xi+eRNHWgXdVhsYfo5zSJ9HHfQ0KOMyDBcY/UWa0FM=;
        b=BMzibYRQhKMrMr+D0k9GiKYuF3Zvf7fSuIdaSXD8JSuFT3Hp0Ll5kCKF9unp9t2hb/
         1AS0WdUIbTKB0cKwpwxLtivP9zpS78PIminE/rSpp+Lq9jyOrkzD4G5vUNlIdTDiwW5A
         TwMZKjiE8CTK9FmGZJIDMpHk/QBhh6TfLIHdbQvv+f1PsS3z/bnGsteJPyA1AwcjBUU6
         +yy17wLx2m5+BD0KIETjhDOpFAZvnbMfM/vA1Mot3SCnsuI9YsPaNmJFg3c2Yhq0R5/9
         V9BLO8Ivchcu6GwbXS4vhL60Fj0KZarvkloAbMRhXMDOEtsNaLno/+Jl5Fn11bwnNv0q
         7m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8xi+eRNHWgXdVhsYfo5zSJ9HHfQ0KOMyDBcY/UWa0FM=;
        b=Q8Rqhw0LxpoqJRvoP/oWkrjHTH7vqFrfNnMCuj56w5j/lfyMjMhyT5/ZyW+VoPCkbD
         fpo/QErHDoeh8E613W+Wni4ZVa7svqUoi1QKTVU731v6C6sYbyQzTR87yahEwCUPUHJ8
         f4sW7zJCp7I8SmoQr6yARnrYcJLwZtQ5Od1hgG9Zhsr4dJh8CybNvuBON9uSn+Bz/iZ9
         bpXmS6saDkiFGFNLd+AVTgnNT0EpydNNNLcRBVIG6wt6b8W9upANeaB1WKNkAg1jn9uN
         2zgCu9r3lZ3G4QWjqFvkP2d1f6V2XURW0kzUIX7cvDG62c1vHl+B9a/4VfK0BzXTOvPj
         1N2w==
X-Gm-Message-State: AGi0PuYvUv3i0tUrZ3kn1wwVLuzCzg56B0dwd9dftnt0ysW6ejNpGUIX
        G5TgyJKMjuNcD9j5tSPRiTg2ZbqO0+A=
X-Google-Smtp-Source: APiQypJdCPNjVqpXyZujJIzyg1FGx0+8h72x9GIZZHuGSXQMsnBAkkCp+j1iw01VYTcDjHRIk89KJgo1KvU=
X-Received: by 2002:a25:3d05:: with SMTP id k5mr4985571yba.111.1588248018943;
 Thu, 30 Apr 2020 05:00:18 -0700 (PDT)
Date:   Thu, 30 Apr 2020 11:59:58 +0000
In-Reply-To: <20200430115959.238073-1-satyat@google.com>
Message-Id: <20200430115959.238073-12-satyat@google.com>
Mime-Version: 1.0
References: <20200430115959.238073-1-satyat@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v12 11/12] f2fs: add inline encryption support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up f2fs to support inline encryption via the helper functions which
fs/crypto/ now provides.  This includes:

- Adding a mount option 'inlinecrypt' which enables inline encryption
  on encrypted files where it can be used.

- Setting the bio_crypt_ctx on bios that will be submitted to an
  inline-encrypted file.

- Not adding logically discontiguous data to bios that will be submitted
  to an inline-encrypted file.

- Not doing filesystem-layer crypto on inline-encrypted files.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/filesystems/f2fs.rst |  7 ++-
 fs/f2fs/compress.c                 |  2 +-
 fs/f2fs/data.c                     | 68 +++++++++++++++++++++++++-----
 fs/f2fs/super.c                    | 32 ++++++++++++++
 4 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 87d794bc75a47..e0e0353f8a498 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -254,7 +254,12 @@ compress_extension=%s  Support adding specified extension, so that f2fs can enab
                        on compression extension list and enable compression on
                        these file by default rather than to enable it via ioctl.
                        For other files, we can still enable compression via ioctl.
-====================== ============================================================
+inlinecrypt
+                       Encrypt/decrypt the contents of encrypted files using the
+                       blk-crypto framework rather than filesystem-layer encryption.
+                       This allows the use of inline encryption hardware. The on-disk
+                       format is unaffected. For more details, see
+                       Documentation/block/inline-encryption.rst.
 
 Debugfs Entries
 ===============
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index df7b2d15eacde..a19c093711a68 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -975,7 +975,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		.submitted = false,
 		.io_type = io_type,
 		.io_wbc = wbc,
-		.encrypted = f2fs_encrypted_file(cc->inode),
+		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode),
 	};
 	struct dnode_of_data dn;
 	struct node_info ni;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdf2f626bea7a..0dfa8d3361428 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -14,6 +14,7 @@
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
 #include <linux/bio.h>
+#include <linux/blk-crypto.h>
 #include <linux/swap.h>
 #include <linux/prefetch.h>
 #include <linux/uio.h>
@@ -457,6 +458,33 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	return bio;
 }
 
+static void f2fs_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
+				  pgoff_t first_idx,
+				  const struct f2fs_io_info *fio,
+				  gfp_t gfp_mask)
+{
+	/*
+	 * The f2fs garbage collector sets ->encrypted_page when it wants to
+	 * read/write raw data without encryption.
+	 */
+	if (!fio || !fio->encrypted_page)
+		fscrypt_set_bio_crypt_ctx(bio, inode, first_idx, gfp_mask);
+}
+
+static bool f2fs_crypt_mergeable_bio(struct bio *bio, const struct inode *inode,
+				     pgoff_t next_idx,
+				     const struct f2fs_io_info *fio)
+{
+	/*
+	 * The f2fs garbage collector sets ->encrypted_page when it wants to
+	 * read/write raw data without encryption.
+	 */
+	if (fio && fio->encrypted_page)
+		return !bio_has_crypt_ctx(bio);
+
+	return fscrypt_mergeable_bio(bio, inode, next_idx);
+}
+
 static inline void __submit_bio(struct f2fs_sb_info *sbi,
 				struct bio *bio, enum page_type type)
 {
@@ -653,6 +681,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	/* Allocate a new bio */
 	bio = __bio_alloc(fio, 1);
 
+	f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
+			       fio->page->index, fio, GFP_NOIO);
+
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		bio_put(bio);
 		return -EFAULT;
@@ -841,12 +872,16 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	trace_f2fs_submit_page_bio(page, fio);
 	f2fs_trace_ios(fio, 0);
 
-	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
-						fio->new_blkaddr))
+	if (bio && (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
+				       fio->new_blkaddr) ||
+		    !f2fs_crypt_mergeable_bio(bio, fio->page->mapping->host,
+					      fio->page->index, fio)))
 		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
 alloc_new:
 	if (!bio) {
 		bio = __bio_alloc(fio, BIO_MAX_PAGES);
+		f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
+				       fio->page->index, fio, GFP_NOIO);
 		bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
 		add_bio_entry(fio->sbi, bio, page, fio->temp);
@@ -903,8 +938,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 
 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
 
-	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
-			io->last_block_in_bio, fio->new_blkaddr))
+	if (io->bio &&
+	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
+			      fio->new_blkaddr) ||
+	     !f2fs_crypt_mergeable_bio(io->bio, fio->page->mapping->host,
+				       fio->page->index, fio)))
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
@@ -916,6 +954,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 			goto skip;
 		}
 		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
+		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
+				       fio->page->index, fio, GFP_NOIO);
 		io->fio = *fio;
 	}
 
@@ -960,11 +1000,14 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 								for_write);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
+
+	f2fs_set_bio_crypt_ctx(bio, inode, first_idx, NULL, GFP_NOFS);
+
 	f2fs_target_device(sbi, blkaddr, bio);
 	bio->bi_end_io = f2fs_read_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
 
-	if (f2fs_encrypted_file(inode))
+	if (fscrypt_inode_uses_fs_layer_crypto(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
 	if (f2fs_compressed_file(inode))
 		post_read_steps |= 1 << STEP_DECOMPRESS;
@@ -1988,8 +2031,9 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	 * This page will go to BIO.  Do we need to send this
 	 * BIO off first?
 	 */
-	if (bio && !page_is_mergeable(F2FS_I_SB(inode), bio,
-				*last_block_in_bio, block_nr)) {
+	if (bio && (!page_is_mergeable(F2FS_I_SB(inode), bio,
+				       *last_block_in_bio, block_nr) ||
+		    !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL))) {
 submit_and_realloc:
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
 		bio = NULL;
@@ -2117,8 +2161,9 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		blkaddr = data_blkaddr(dn.inode, dn.node_page,
 						dn.ofs_in_node + i + 1);
 
-		if (bio && !page_is_mergeable(sbi, bio,
-					*last_block_in_bio, blkaddr)) {
+		if (bio && (!page_is_mergeable(sbi, bio,
+					*last_block_in_bio, blkaddr) ||
+		    !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL))) {
 submit_and_realloc:
 			__submit_bio(sbi, bio, DATA);
 			bio = NULL;
@@ -2337,6 +2382,9 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
 
+	if (fscrypt_inode_uses_inline_crypto(inode))
+		return 0;
+
 retry_encrypt:
 	fio->encrypted_page = fscrypt_encrypt_pagecache_blocks(page,
 					PAGE_SIZE, 0, gfp_flags);
@@ -2510,7 +2558,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 			f2fs_unlock_op(fio->sbi);
 		err = f2fs_inplace_write_data(fio);
 		if (err) {
-			if (f2fs_encrypted_file(inode))
+			if (fscrypt_inode_uses_fs_layer_crypto(inode))
 				fscrypt_finalize_bounce_page(&fio->encrypted_page);
 			if (PageWriteback(page))
 				end_page_writeback(page);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f2dfc21c6abb0..8ccda50f28888 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -138,6 +138,7 @@ enum {
 	Opt_alloc,
 	Opt_fsync,
 	Opt_test_dummy_encryption,
+	Opt_inlinecrypt,
 	Opt_checkpoint_disable,
 	Opt_checkpoint_disable_cap,
 	Opt_checkpoint_disable_cap_perc,
@@ -203,6 +204,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_alloc, "alloc_mode=%s"},
 	{Opt_fsync, "fsync_mode=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
+	{Opt_inlinecrypt, "inlinecrypt"},
 	{Opt_checkpoint_disable, "checkpoint=disable"},
 	{Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
 	{Opt_checkpoint_disable_cap_perc, "checkpoint=disable:%u%%"},
@@ -788,6 +790,13 @@ static int parse_options(struct super_block *sb, char *options)
 			f2fs_info(sbi, "Test dummy encryption mode enabled");
 #else
 			f2fs_info(sbi, "Test dummy encryption mount option ignored");
+#endif
+			break;
+		case Opt_inlinecrypt:
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+			sb->s_flags |= SB_INLINECRYPT;
+#else
+			f2fs_info(sbi, "inline encryption not supported");
 #endif
 			break;
 		case Opt_checkpoint_disable_cap_perc:
@@ -1583,6 +1592,8 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_ext_cnt = 0;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 
+	sbi->sb->s_flags &= ~SB_INLINECRYPT;
+
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
@@ -2427,6 +2438,25 @@ static void f2fs_get_ino_and_lblk_bits(struct super_block *sb,
 	*lblk_bits_ret = 8 * sizeof(block_t);
 }
 
+static int f2fs_get_num_devices(struct super_block *sb)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
+	if (f2fs_is_multi_device(sbi))
+		return sbi->s_ndevs;
+	return 1;
+}
+
+static void f2fs_get_devices(struct super_block *sb,
+			     struct request_queue **devs)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int i;
+
+	for (i = 0; i < sbi->s_ndevs; i++)
+		devs[i] = bdev_get_queue(FDEV(i).bdev);
+}
+
 static const struct fscrypt_operations f2fs_cryptops = {
 	.key_prefix		= "f2fs:",
 	.get_context		= f2fs_get_context,
@@ -2436,6 +2466,8 @@ static const struct fscrypt_operations f2fs_cryptops = {
 	.max_namelen		= F2FS_NAME_LEN,
 	.has_stable_inodes	= f2fs_has_stable_inodes,
 	.get_ino_and_lblk_bits	= f2fs_get_ino_and_lblk_bits,
+	.get_num_devices	= f2fs_get_num_devices,
+	.get_devices		= f2fs_get_devices,
 };
 #endif
 
-- 
2.26.2.303.gf8c07b1a785-goog

