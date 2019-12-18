Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA63124A59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLROwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 09:52:43 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55911 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfLROwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:52:40 -0500
Received: by mail-pl1-f202.google.com with SMTP id f10so1247651plr.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 06:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ENEj/1BO1ugeO8FPAEs1/3L7kkxZuF2zB3HNc8VqXUU=;
        b=nJgsyu5lb2elqBKYo5MraImnh64iOWc7LS5Il1uv5iyNZV4DVyrQSt73Pcj3SCsrDb
         PP17KyKOcMNa6qfTkGecKokGUanzYHwzBPLk+1FZF1EciWXjf3EKST5wljzlwKSpqr+S
         NXgVxxQLy6Mw7TdBSPadtIBFJy8NSs4mpABVhf/hQCA80RRfqqCWtsAAm1imvcDNV/U9
         koaUx1TJTUv1AL/9DUhWW55eXBM9HERmvLZ3iJdakkBOtMpbM598p5wyPJ2CvGb3eIUb
         eVpi2W9/aNQDHzPaB/W+RHamF3x97niiGrLN9/x13VApecKJyr/Ow6X7AvqEQSlPHZux
         Gk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ENEj/1BO1ugeO8FPAEs1/3L7kkxZuF2zB3HNc8VqXUU=;
        b=ZNf7r1m+IkheFJpUC+05hzFzqD16cWuyvyR9UBEhQ0xFH+KLcvLfoVT+HLd0m0/4fy
         /S+koL0sgZnw2INGGUTjIxyd7QAxmdhMTMMAz3c8VDE+trvYEonyxfoC62gYf5ctg/FD
         qX0G3MjGP18EXNda9rguX72jRKy9+vtGME2z8Ap/Q31SIkSyG36QarZNkaowH21Re3pL
         ZTeLzyUs1YNxZVvvAEztVMkXgJ/BloJzYpbdivBEYRZtC6wH6gMF1W5x0sQhPF7iw040
         nBR3dGpIvAVsq+rcHMyWAXqxEIEU0FW2v0UfNCVx0hUD0IgWSrhYdn6QVYBw3TTDC5/T
         QBtg==
X-Gm-Message-State: APjAAAXIJ9N15mrlX1e5Wt33+JyYSksTxZoobFvR3lkW+jzMm9K6n21E
        PxEoA15DL+L+M9bq2l1e2NOwsQpsWnI=
X-Google-Smtp-Source: APXvYqweaH8/6iaeRnKligmYfGMnxbqkyWQFfrTD4mSllE/XHSPXJ4zhBHd7E1wNwvP0SXCvr5pn60EePmo=
X-Received: by 2002:a63:954f:: with SMTP id t15mr3477010pgn.137.1576680759818;
 Wed, 18 Dec 2019 06:52:39 -0800 (PST)
Date:   Wed, 18 Dec 2019 06:51:35 -0800
In-Reply-To: <20191218145136.172774-1-satyat@google.com>
Message-Id: <20191218145136.172774-9-satyat@google.com>
Mime-Version: 1.0
References: <20191218145136.172774-1-satyat@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v6 8/9] f2fs: add inline encryption support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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
 fs/f2fs/data.c  | 65 +++++++++++++++++++++++++++++++++++++++++++------
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c | 41 +++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a034cd0ce021..ad63aa30d0c7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -308,6 +308,33 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
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
@@ -491,6 +518,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	/* Allocate a new bio */
 	bio = __bio_alloc(fio, 1);
 
+	f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
+			       fio->page->index, fio, GFP_NOIO);
+
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		bio_put(bio);
 		return -EFAULT;
@@ -678,12 +708,18 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	trace_f2fs_submit_page_bio(page, fio);
 	f2fs_trace_ios(fio, 0);
 
-	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
-						fio->new_blkaddr))
+	if (bio && (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
+				       fio->new_blkaddr) ||
+		    !f2fs_crypt_mergeable_bio(bio, fio->page->mapping->host,
+					      fio->page->index, fio))) {
 		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
+}
 alloc_new:
 	if (!bio) {
 		bio = __bio_alloc(fio, BIO_MAX_PAGES);
+		f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
+				       fio->page->index, fio,
+				       GFP_NOIO);
 		bio_set_op_attrs(bio, fio->op, fio->op_flags);
 
 		add_bio_entry(fio->sbi, bio, page, fio->temp);
@@ -735,8 +771,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 
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
@@ -748,6 +787,9 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 			goto skip;
 		}
 		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
+		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
+				       fio->page->index, fio,
+				       GFP_NOIO);
 		io->fio = *fio;
 	}
 
@@ -791,11 +833,14 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
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
 
 	if (f2fs_need_verity(inode, first_idx))
@@ -1832,8 +1877,9 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
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
@@ -1973,6 +2019,9 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
 
+	if (fscrypt_inode_uses_inline_crypto(inode))
+		return 0;
+
 retry_encrypt:
 	fio->encrypted_page = fscrypt_encrypt_pagecache_blocks(fio->page,
 							       PAGE_SIZE, 0,
@@ -2147,7 +2196,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 			f2fs_unlock_op(fio->sbi);
 		err = f2fs_inplace_write_data(fio);
 		if (err) {
-			if (f2fs_encrypted_file(inode))
+			if (fscrypt_inode_uses_fs_layer_crypto(inode))
 				fscrypt_finalize_bounce_page(&fio->encrypted_page);
 			if (PageWriteback(page))
 				end_page_writeback(page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a888a063c7f..d96cfb74ba31 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -137,6 +137,9 @@ struct f2fs_mount_info {
 	int alloc_mode;			/* segment allocation policy */
 	int fsync_mode;			/* fsync policy */
 	bool test_dummy_encryption;	/* test dummy encryption */
+#ifdef CONFIG_FS_ENCRYPTION
+	bool inlinecrypt;		/* inline encryption enabled */
+#endif
 	block_t unusable_cap;		/* Amount of space allowed to be
 					 * unusable when disabling checkpoint
 					 */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5111e1ffe58a..0e9c2303e86f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -137,6 +137,7 @@ enum {
 	Opt_alloc,
 	Opt_fsync,
 	Opt_test_dummy_encryption,
+	Opt_inlinecrypt,
 	Opt_checkpoint_disable,
 	Opt_checkpoint_disable_cap,
 	Opt_checkpoint_disable_cap_perc,
@@ -199,6 +200,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_alloc, "alloc_mode=%s"},
 	{Opt_fsync, "fsync_mode=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
+	{Opt_inlinecrypt, "inlinecrypt"},
 	{Opt_checkpoint_disable, "checkpoint=disable"},
 	{Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
 	{Opt_checkpoint_disable_cap_perc, "checkpoint=disable:%u%%"},
@@ -783,6 +785,13 @@ static int parse_options(struct super_block *sb, char *options)
 			f2fs_info(sbi, "Test dummy encryption mode enabled");
 #else
 			f2fs_info(sbi, "Test dummy encryption mount option ignored");
+#endif
+			break;
+		case Opt_inlinecrypt:
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+			F2FS_OPTION(sbi).inlinecrypt = true;
+#else
+			f2fs_info(sbi, "inline encryption not supported");
 #endif
 			break;
 		case Opt_checkpoint_disable_cap_perc:
@@ -1446,6 +1455,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_FS_ENCRYPTION
 	if (F2FS_OPTION(sbi).test_dummy_encryption)
 		seq_puts(seq, ",test_dummy_encryption");
+	if (F2FS_OPTION(sbi).inlinecrypt)
+		seq_puts(seq, ",inlinecrypt");
 #endif
 
 	if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_DEFAULT)
@@ -1474,6 +1485,9 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
 	F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
 	F2FS_OPTION(sbi).test_dummy_encryption = false;
+#ifdef CONFIG_FS_ENCRYPTION
+	F2FS_OPTION(sbi).inlinecrypt = false;
+#endif
 	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
 	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
 
@@ -2328,6 +2342,30 @@ static void f2fs_get_ino_and_lblk_bits(struct super_block *sb,
 	*lblk_bits_ret = 8 * sizeof(block_t);
 }
 
+static bool f2fs_inline_crypt_enabled(struct super_block *sb)
+{
+	return F2FS_OPTION(F2FS_SB(sb)).inlinecrypt;
+}
+
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
@@ -2337,6 +2375,9 @@ static const struct fscrypt_operations f2fs_cryptops = {
 	.max_namelen		= F2FS_NAME_LEN,
 	.has_stable_inodes	= f2fs_has_stable_inodes,
 	.get_ino_and_lblk_bits	= f2fs_get_ino_and_lblk_bits,
+	.inline_crypt_enabled	= f2fs_inline_crypt_enabled,
+	.get_num_devices	= f2fs_get_num_devices,
+	.get_devices		= f2fs_get_devices,
 };
 #endif
 
-- 
2.24.1.735.g03f4e72817-goog

