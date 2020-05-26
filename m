Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C203A1A1AAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 05:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDHD5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 23:57:37 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:38603 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgDHD5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:57:36 -0400
Received: by mail-pj1-f74.google.com with SMTP id l12so1525638pjh.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 20:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7D13JogXFe1JCEV8qFRYg97/dIBd9Yj2YknwY62/3L4=;
        b=ARgnInOvFykHikP924+1Hp9B8S2TINGZiXnz7KGkOzogNCvrPcZp0yicygd+SI5Kk8
         PjSaQ8Re+iEqsCgD1aAQDh1+HVycmmvv9VnKSj2PIExTib+SIxLcRZpe+4BQxQcD/130
         OUqLB6kjY+wmNgMYCcyO7BjpR0q4RX+skLrLVH7Genl1W+6NsXvNDLBwPOVf6tHS9yQC
         WjnMdVshlRRbnC3WDev1/e5VYu/SQF8p8KvT2U7P/QWDo7hjDUG/zs/avvfGFmDWmPkQ
         iNprRxjuoFqweuVwIslhOgMkG71xqkVck62PIS9VxGPy9Vmj4gg5hX0zQ4fv6x0zT7f5
         wiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7D13JogXFe1JCEV8qFRYg97/dIBd9Yj2YknwY62/3L4=;
        b=RTD/tYJIsVJqGRhUvvZ0lD9lJES+atxa9o/sv9/TAOUqxFVgDxnJ7+nF9u7JJ5/QRK
         RyvDTOBlvLGEZ6Elw5O6/GgHQ93iU4+oFV1YScugPlRTFExZwFsyKvRRuI33EmTEVWFs
         5jda2P2O2LHyvax6NOOsvRhrNv7xG/j4/4NaDbCcsYCmau1L8gePHFlbLKS0vfaIDWc2
         Wxw5NDZXDGZFd6kkbLCfbNJPt3wfbnir0Pe+9Wg3i94KtUVnhbycDZkVnUTaX0AtXlos
         ++ErC5Ppmne9eRUFJFJctE7sA/Mt179CWNTSI+MKhJjn+kGzcfdt1pXP0YnTcrA4v40u
         1pCQ==
X-Gm-Message-State: AGi0Pub/xfMx6/nXCFMTJW8zvn7fxLohEnzt6UQkyKKkXD1prxvGt/S2
        mE7M/aKZ0KiDq9s4wPG3y1oytKhVR28=
X-Google-Smtp-Source: APiQypJx6NsRs9SY9caqTGgYqn5+wm7yGe4hGaWQCw0+1OR08cUUraxMJUL2D7/bSE59GiFYRoBSRQA5Yf0=
X-Received: by 2002:a63:64c4:: with SMTP id y187mr5096645pgb.36.1586318255191;
 Tue, 07 Apr 2020 20:57:35 -0700 (PDT)
Date:   Tue,  7 Apr 2020 20:56:54 -0700
In-Reply-To: <20200408035654.247908-1-satyat@google.com>
Message-Id: <20200408035654.247908-13-satyat@google.com>
Mime-Version: 1.0
References: <20200408035654.247908-1-satyat@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v10 12/12] ext4: add inline encryption support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

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
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/admin-guide/ext4.rst |  6 ++++++
 fs/buffer.c                        |  7 ++++---
 fs/ext4/inode.c                    |  4 ++--
 fs/ext4/page-io.c                  |  6 ++++--
 fs/ext4/readpage.c                 | 11 ++++++++---
 fs/ext4/super.c                    |  9 +++++++++
 6 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
index 9443fcef18760..ed997e3766781 100644
--- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -395,6 +395,12 @@ When mounting an ext4 filesystem, the following option are accepted:
         Documentation/filesystems/dax.txt.  Note that this option is
         incompatible with data=journal.
 
+  inlinecrypt
+        Encrypt/decrypt the contents of encrypted files using the blk-crypto
+        framework rather than filesystem-layer encryption. This allows the use
+        of inline encryption hardware. The on-disk format is unaffected. For
+        more details, see Documentation/block/inline-encryption.rst.
+
 Data Mode
 =========
 There are 3 different data modes:
diff --git a/fs/buffer.c b/fs/buffer.c
index f73276d746bbf..8b5d7c857fa76 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -328,9 +328,8 @@ static void decrypt_bh(struct work_struct *work)
 static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
 {
 	/* Decrypt if needed */
-	if (uptodate && IS_ENABLED(CONFIG_FS_ENCRYPTION) &&
-	    IS_ENCRYPTED(bh->b_page->mapping->host) &&
-	    S_ISREG(bh->b_page->mapping->host->i_mode)) {
+	if (uptodate &&
+	    fscrypt_inode_uses_fs_layer_crypto(bh->b_page->mapping->host)) {
 		struct decrypt_bh_ctx *ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
 
 		if (ctx) {
@@ -3036,6 +3035,8 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	 */
 	bio = bio_alloc(GFP_NOIO, 1);
 
+	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
+
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e416096fc0813..9b5ca088b9a7b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1088,7 +1088,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 	}
 	if (unlikely(err)) {
 		page_zero_new_buffers(page, from, to);
-	} else if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode)) {
+	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
 
@@ -3738,7 +3738,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		/* Uhhuh. Read error. Complain and punt. */
 		if (!buffer_uptodate(bh))
 			goto unlock;
-		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode)) {
+		if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 			/* We expect the key to be set. */
 			BUG_ON(!fscrypt_has_encryption_key(inode));
 			err = fscrypt_decrypt_pagecache_blocks(page, blocksize,
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index de6fe969f7737..defd2e10dfd10 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -402,6 +402,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
 	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
+	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_end_io = ext4_end_bio;
@@ -418,7 +419,8 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 {
 	int ret;
 
-	if (io->io_bio && bh->b_blocknr != io->io_next_block) {
+	if (io->io_bio && (bh->b_blocknr != io->io_next_block ||
+			   !fscrypt_mergeable_bio_bh(io->io_bio, bh))) {
 submit_and_retry:
 		ext4_io_submit(io);
 	}
@@ -506,7 +508,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	 * (e.g. holes) to be unnecessarily encrypted, but this is rare and
 	 * can't happen in the common case of blocksize == PAGE_SIZE.
 	 */
-	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) && nr_to_submit) {
+	if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
 		gfp_t gfp_flags = GFP_NOFS;
 		unsigned int enc_bytes = round_up(len, i_blocksize(inode));
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index c1769afbf7995..68eac0aeffad3 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -195,7 +195,7 @@ static void ext4_set_bio_post_read_ctx(struct bio *bio,
 {
 	unsigned int post_read_steps = 0;
 
-	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
+	if (fscrypt_inode_uses_fs_layer_crypto(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
 
 	if (ext4_need_verity(inode, first_idx))
@@ -232,6 +232,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
 	const unsigned blkbits = inode->i_blkbits;
 	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
 	const unsigned blocksize = 1 << blkbits;
+	sector_t next_block;
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
@@ -264,7 +265,8 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		if (page_has_buffers(page))
 			goto confused;
 
-		block_in_file = (sector_t)page->index << (PAGE_SHIFT - blkbits);
+		block_in_file = next_block =
+			(sector_t)page->index << (PAGE_SHIFT - blkbits);
 		last_block = block_in_file + nr_pages * blocks_per_page;
 		last_block_in_file = (ext4_readpage_limit(inode) +
 				      blocksize - 1) >> blkbits;
@@ -364,7 +366,8 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		 * This page will go to BIO.  Do we need to send this
 		 * BIO off first?
 		 */
-		if (bio && (last_block_in_bio != blocks[0] - 1)) {
+		if (bio && (last_block_in_bio != blocks[0] - 1 ||
+			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
 		submit_and_realloc:
 			submit_bio(bio);
 			bio = NULL;
@@ -376,6 +379,8 @@ int ext4_mpage_readpages(struct address_space *mapping,
 			 */
 			bio = bio_alloc(GFP_KERNEL,
 				min_t(int, nr_pages, BIO_MAX_PAGES));
+			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
+						  GFP_KERNEL);
 			ext4_set_bio_post_read_ctx(bio, inode, page->index);
 			bio_set_dev(bio, bdev);
 			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9728e7b0e84fc..2ad28a075cdf7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1511,6 +1511,7 @@ enum {
 	Opt_journal_path, Opt_journal_checksum, Opt_journal_async_commit,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_data_err_abort, Opt_data_err_ignore, Opt_test_dummy_encryption,
+	Opt_inlinecrypt,
 	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
 	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
 	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
@@ -1608,6 +1609,7 @@ static const match_table_t tokens = {
 	{Opt_noinit_itable, "noinit_itable"},
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
+	{Opt_inlinecrypt, "inlinecrypt"},
 	{Opt_nombcache, "nombcache"},
 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
 	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
@@ -1895,6 +1897,13 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 	case Opt_nolazytime:
 		sb->s_flags &= ~SB_LAZYTIME;
 		return 1;
+	case Opt_inlinecrypt:
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+		sb->s_flags |= SB_INLINECRYPT;
+#else
+		ext4_msg(sb, KERN_ERR, "inline encryption not supported");
+#endif
+		return 1;
 	}
 
 	for (m = ext4_mount_opts; m->token != Opt_err; m++)
-- 
2.26.0.110.g2183baf09c-goog

