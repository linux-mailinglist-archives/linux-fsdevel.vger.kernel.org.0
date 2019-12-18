Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB7124A5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 15:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfLROwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 09:52:45 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:54346 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfLROwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:52:44 -0500
Received: by mail-pg1-f202.google.com with SMTP id i21so1312951pgm.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 06:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EADbsDRum38R86GWslHGIrQAClvnYHKnXEdwPqP/tUg=;
        b=DshjMIuOYKSldZF/54Op7s1VCWQoND4mCAFbEhT9QbBS3rzkIaxs4gGvc8LNZSnvka
         2SuLlMCCgC/x/SnvgNyrVTGFO781LoJ6HyijgLzCCp1SxOsQYdI4xGHQErCEjoTNi7c2
         1DNVekD88aMq++8iPhFpkae2xLJtPZNelRhSQS/Tlt6hlz2c/HNv7H2zrYg6nAlrlKJc
         ooiVFcdqwJCIZrpc26C9eqsVTMdqWLLBgDPtZKPY0ZGmUF58zBlBW4eTyy9bItS0ckzY
         UdRANIinc0QtGYMEY7p9TngCFANxIis44FAtjV2DB+N9oxMj7rzNHRc4QKxMTMMx1ZCd
         qrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EADbsDRum38R86GWslHGIrQAClvnYHKnXEdwPqP/tUg=;
        b=K7ulDggIIK/zuVU5NIHwS70v1XJo3xUxgtZuUcO3oB5MBRclhJvozYTgN3ScfvebaX
         X2+tdQbpLtgvJTElKVaTLX35afggoGN4BSodHtzcjN85DVCNrDZ14rDJsHxjbKMPfG2E
         TomKrJxyiHLDjy/WQVZAp8QLderaTF0aNgdPDvnB3SCxnuNf7fwbsdj2/SbI0H4wSmyA
         xehWALWQmPmveUQKGGlDLKKohjwpXX0YRm5K7fAO+wKvQVgivlUbYliWnzmn+x96+ztQ
         g1kSTkfffdTdun0S9C47DdWg/Whp1QG2k0SliWqUHWd92GvKiFJAsPCEQpS9U1OY4vim
         P/HQ==
X-Gm-Message-State: APjAAAX6nmdHSEkJFXUyr+CJllePWtYn3Hjf1uw9+j6BNpCI36O/5+oC
        CldLniEOgbDlj6EO9InQJOt+2buLy84=
X-Google-Smtp-Source: APXvYqzMJy3yg26qq4fv0gxiTnua1iPpCfXQw2eTCgAqasIGdhcQVu41R/+wZ69Od9LX+ggQLAax4Syo2uk=
X-Received: by 2002:a63:211f:: with SMTP id h31mr3346195pgh.299.1576680762342;
 Wed, 18 Dec 2019 06:52:42 -0800 (PST)
Date:   Wed, 18 Dec 2019 06:51:36 -0800
In-Reply-To: <20191218145136.172774-1-satyat@google.com>
Message-Id: <20191218145136.172774-10-satyat@google.com>
Mime-Version: 1.0
References: <20191218145136.172774-1-satyat@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v6 9/9] ext4: add inline encryption support
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

Wire up ext4 to support inline encryption via the helper functions which
fs/crypto/ now provides.  This includes:

- Adding a mount option 'inlinecrypt' which enables inline encryption
  on encrypted files where it can be used.

- Setting the bio_crypt_ctx on bios that will be submitted to an
  inline-encrypted file.

  Note: submit_bh_wbc() in fs/buffer.c also needed to be patched for
  this part, since ext4 sometimes uses ll_rw_block() on file data.

- Not adding logically discontiguous data to bios that will be submitted
  to an inline-encrypted file.

- Not doing filesystem-layer crypto on inline-encrypted files.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/buffer.c        |  2 ++
 fs/ext4/ext4.h     |  1 +
 fs/ext4/inode.c    |  4 ++--
 fs/ext4/page-io.c  |  6 ++++--
 fs/ext4/readpage.c | 11 ++++++++---
 fs/ext4/super.c    | 13 +++++++++++++
 6 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d8c7242426bb..3ad000db4a19 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3108,6 +3108,8 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	 */
 	bio = bio_alloc(GFP_NOIO, 1);
 
+	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
+
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f8578caba40d..aeaa01724d7c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1153,6 +1153,7 @@ struct ext4_inode_info {
 #define EXT4_MOUNT_JOURNAL_CHECKSUM	0x800000 /* Journal checksums */
 #define EXT4_MOUNT_JOURNAL_ASYNC_COMMIT	0x1000000 /* Journal Async Commit */
 #define EXT4_MOUNT_WARN_ON_ERROR	0x2000000 /* Trigger WARN_ON on error */
+#define EXT4_MOUNT_INLINECRYPT		0x4000000 /* Inline encryption support */
 #define EXT4_MOUNT_DELALLOC		0x8000000 /* Delalloc support */
 #define EXT4_MOUNT_DATA_ERR_ABORT	0x10000000 /* Abort on file data write */
 #define EXT4_MOUNT_BLOCK_VALIDITY	0x20000000 /* Block validity checking */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 28f28de0c1b6..44d9651b8638 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1090,7 +1090,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 	}
 	if (unlikely(err)) {
 		page_zero_new_buffers(page, from, to);
-	} else if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode)) {
+	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
 
@@ -3698,7 +3698,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		/* Uhhuh. Read error. Complain and punt. */
 		if (!buffer_uptodate(bh))
 			goto unlock;
-		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode)) {
+		if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 			/* We expect the key to be set. */
 			BUG_ON(!fscrypt_has_encryption_key(inode));
 			WARN_ON_ONCE(fscrypt_decrypt_pagecache_blocks(
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 24aeedb8fc75..acde754cc5ca 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -404,6 +404,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
 	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
+	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_end_io = ext4_end_bio;
@@ -420,7 +421,8 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 {
 	int ret;
 
-	if (io->io_bio && bh->b_blocknr != io->io_next_block) {
+	if (io->io_bio && (bh->b_blocknr != io->io_next_block ||
+			   !fscrypt_mergeable_bio_bh(io->io_bio, bh))) {
 submit_and_retry:
 		ext4_io_submit(io);
 	}
@@ -508,7 +510,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	 * (e.g. holes) to be unnecessarily encrypted, but this is rare and
 	 * can't happen in the common case of blocksize == PAGE_SIZE.
 	 */
-	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) && nr_to_submit) {
+	if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
 		gfp_t gfp_flags = GFP_NOFS;
 		unsigned int enc_bytes = round_up(len, i_blocksize(inode));
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index fef7755300c3..7844e27518b4 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -183,7 +183,7 @@ static struct bio_post_read_ctx *get_bio_post_read_ctx(struct inode *inode,
 	unsigned int post_read_steps = 0;
 	struct bio_post_read_ctx *ctx = NULL;
 
-	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
+	if (fscrypt_inode_uses_fs_layer_crypto(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
 
 	if (ext4_need_verity(inode, first_idx))
@@ -220,6 +220,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
 	const unsigned blkbits = inode->i_blkbits;
 	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
 	const unsigned blocksize = 1 << blkbits;
+	sector_t next_block;
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
@@ -252,7 +253,8 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		if (page_has_buffers(page))
 			goto confused;
 
-		block_in_file = (sector_t)page->index << (PAGE_SHIFT - blkbits);
+		block_in_file = next_block =
+			(sector_t)page->index << (PAGE_SHIFT - blkbits);
 		last_block = block_in_file + nr_pages * blocks_per_page;
 		last_block_in_file = (ext4_readpage_limit(inode) +
 				      blocksize - 1) >> blkbits;
@@ -352,7 +354,8 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		 * This page will go to BIO.  Do we need to send this
 		 * BIO off first?
 		 */
-		if (bio && (last_block_in_bio != blocks[0] - 1)) {
+		if (bio && (last_block_in_bio != blocks[0] - 1 ||
+			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
 		submit_and_realloc:
 			submit_bio(bio);
 			bio = NULL;
@@ -366,6 +369,8 @@ int ext4_mpage_readpages(struct address_space *mapping,
 			 */
 			bio = bio_alloc(GFP_KERNEL,
 				min_t(int, nr_pages, BIO_MAX_PAGES));
+			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
+						  GFP_KERNEL);
 			ctx = get_bio_post_read_ctx(inode, bio, page->index);
 			if (IS_ERR(ctx)) {
 				bio_put(bio);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 1d82b56d9b11..0a6b60620942 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1357,6 +1357,11 @@ static void ext4_get_ino_and_lblk_bits(struct super_block *sb,
 	*lblk_bits_ret = 8 * sizeof(ext4_lblk_t);
 }
 
+static bool ext4_inline_crypt_enabled(struct super_block *sb)
+{
+	return test_opt(sb, INLINECRYPT);
+}
+
 static const struct fscrypt_operations ext4_cryptops = {
 	.key_prefix		= "ext4:",
 	.get_context		= ext4_get_context,
@@ -1366,6 +1371,7 @@ static const struct fscrypt_operations ext4_cryptops = {
 	.max_namelen		= EXT4_NAME_LEN,
 	.has_stable_inodes	= ext4_has_stable_inodes,
 	.get_ino_and_lblk_bits	= ext4_get_ino_and_lblk_bits,
+	.inline_crypt_enabled	= ext4_inline_crypt_enabled,
 };
 #endif
 
@@ -1460,6 +1466,7 @@ enum {
 	Opt_journal_path, Opt_journal_checksum, Opt_journal_async_commit,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_data_err_abort, Opt_data_err_ignore, Opt_test_dummy_encryption,
+	Opt_inlinecrypt,
 	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
 	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
 	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
@@ -1556,6 +1563,7 @@ static const match_table_t tokens = {
 	{Opt_noinit_itable, "noinit_itable"},
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
+	{Opt_inlinecrypt, "inlinecrypt"},
 	{Opt_nombcache, "nombcache"},
 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
 	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
@@ -1767,6 +1775,11 @@ static const struct mount_opts {
 	{Opt_jqfmt_vfsv1, QFMT_VFS_V1, MOPT_QFMT},
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+	{Opt_inlinecrypt, EXT4_MOUNT_INLINECRYPT, MOPT_SET},
+#else
+	{Opt_inlinecrypt, EXT4_MOUNT_INLINECRYPT, MOPT_NOSUPPORT},
+#endif
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_err, 0, 0}
 };
-- 
2.24.1.735.g03f4e72817-goog

