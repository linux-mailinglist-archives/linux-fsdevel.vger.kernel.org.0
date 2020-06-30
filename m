Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE320F450
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 14:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbgF3MO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 08:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387558AbgF3MOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:14:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08822C03E97A
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 05:14:51 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id cl23so5557748pjb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XiMkoZLpRAbnL7Do5oOmsmyQ0pkBy4LUO8LUjQLXzMU=;
        b=Bt0tzzeWnh1sghQRMdPCSBY97YdRc5DuXzMFabsdFBf5SSbDI62SjsmoWiFYB702vb
         XMksumvSgiFN1g2qp5ik31KAfM4Jc5YAgsE2wq3RkADAjq0RbxHXhwwS8WibPeNMO5x6
         e9cJ/8Mdv2I6XP1Ep4q2ySQGSjhitbhycE6A6/KIa1jYIqMlGj8LaR8V5KIYTbTwOXBq
         AL8ioBDdFHEyGsAgFJo06zVSkelkJduca2tDLAH8KcNaidksYGtT0c5emHsf/aLOND9Z
         MYPIAuWBJ4Ldeu/npm31qCUTa47D6/EzLRCClL4tBTc6OxLXfRIKciXxiMR2NUWWseVC
         uRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XiMkoZLpRAbnL7Do5oOmsmyQ0pkBy4LUO8LUjQLXzMU=;
        b=U9hGDgPpx7S26DRQEntFg0IHIvZkrq2aSGjY4bEDHE+5xSBfA5aNuTlH3w1tiqtkBN
         PzRGGJdZwscIlc9SCuMjJwDSyUULRKAqnWPpixywWY/D6UM1M+g9WlIg+Pyxn0HAQAxC
         dduVTm4Nd8Nag8bb1RJWpOvwiJqeEHjopHxiQaMQYcQ82Bwz1QhJrVlch8dkdlZC7D8/
         Nm3Eyfm+6f+5+1mOUbjZANwVUbXDPqB3bGJE2jHc1b5UzGg28Y7MnQKurbVX1rcWwqQh
         GPMC4txxz/f6G7Ue7nA/GewEKOes6a6dx/5pm2xlfMJcfKqhpd/65SnCIIwvuN8/6QJd
         uBEg==
X-Gm-Message-State: AOAM533m63y16IxnAP4OZJDFiI2INLs56kj4Pazx0nZzKfiKTGqdGtRL
        qT5LVIKcA3EXEPO605gUNWQEWVxrksA=
X-Google-Smtp-Source: ABdhPJxpROaRCv3YH/iNZWpQgcE0hMe1duis6Avh4BQxSKZxDDFcXhCg1fNASAbJtaPjK/kA67uAWdMh5vw=
X-Received: by 2002:a63:db18:: with SMTP id e24mr11437142pgg.192.1593519290502;
 Tue, 30 Jun 2020 05:14:50 -0700 (PDT)
Date:   Tue, 30 Jun 2020 12:14:38 +0000
In-Reply-To: <20200630121438.891320-1-satyat@google.com>
Message-Id: <20200630121438.891320-5-satyat@google.com>
Mime-Version: 1.0
References: <20200630121438.891320-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3 4/4] ext4: add inline encryption support
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>,
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
 Documentation/admin-guide/ext4.rst |  7 +++++++
 fs/buffer.c                        |  7 ++++---
 fs/ext4/inode.c                    |  4 ++--
 fs/ext4/page-io.c                  |  6 ++++--
 fs/ext4/readpage.c                 | 11 ++++++++---
 fs/ext4/super.c                    | 12 ++++++++++++
 6 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
index 9443fcef1876..2162d7909970 100644
--- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -395,6 +395,13 @@ When mounting an ext4 filesystem, the following option are accepted:
         Documentation/filesystems/dax.txt.  Note that this option is
         incompatible with data=journal.
 
+  inlinecrypt
+        When possible, encrypt/decrypt the contents of encrypted files using the
+        blk-crypto framework rather than filesystem-layer encryption. This
+        allows the use of inline encryption hardware. The on-disk format is
+        unaffected. For more details, see
+        Documentation/block/inline-encryption.rst.
+
 Data Mode
 =========
 There are 3 different data modes:
diff --git a/fs/buffer.c b/fs/buffer.c
index 64fe82ec65ff..dc5e05b47646 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -320,9 +320,8 @@ static void decrypt_bh(struct work_struct *work)
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
@@ -3046,6 +3045,8 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	 */
 	bio = bio_alloc(GFP_NOIO, 1);
 
+	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
+
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10dd470876b3..44bad4bb8831 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1096,7 +1096,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 	}
 	if (unlikely(err)) {
 		page_zero_new_buffers(page, from, to);
-	} else if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode)) {
+	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
 
@@ -3737,7 +3737,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 		/* Uhhuh. Read error. Complain and punt. */
 		if (!buffer_uptodate(bh))
 			goto unlock;
-		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode)) {
+		if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 			/* We expect the key to be set. */
 			BUG_ON(!fscrypt_has_encryption_key(inode));
 			err = fscrypt_decrypt_pagecache_blocks(page, blocksize,
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index de6fe969f773..defd2e10dfd1 100644
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
index 5761e9961682..f2df2db0786c 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -195,7 +195,7 @@ static void ext4_set_bio_post_read_ctx(struct bio *bio,
 {
 	unsigned int post_read_steps = 0;
 
-	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
+	if (fscrypt_inode_uses_fs_layer_crypto(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
 
 	if (ext4_need_verity(inode, first_idx))
@@ -230,6 +230,7 @@ int ext4_mpage_readpages(struct inode *inode,
 	const unsigned blkbits = inode->i_blkbits;
 	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
 	const unsigned blocksize = 1 << blkbits;
+	sector_t next_block;
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
@@ -258,7 +259,8 @@ int ext4_mpage_readpages(struct inode *inode,
 		if (page_has_buffers(page))
 			goto confused;
 
-		block_in_file = (sector_t)page->index << (PAGE_SHIFT - blkbits);
+		block_in_file = next_block =
+			(sector_t)page->index << (PAGE_SHIFT - blkbits);
 		last_block = block_in_file + nr_pages * blocks_per_page;
 		last_block_in_file = (ext4_readpage_limit(inode) +
 				      blocksize - 1) >> blkbits;
@@ -358,7 +360,8 @@ int ext4_mpage_readpages(struct inode *inode,
 		 * This page will go to BIO.  Do we need to send this
 		 * BIO off first?
 		 */
-		if (bio && (last_block_in_bio != blocks[0] - 1)) {
+		if (bio && (last_block_in_bio != blocks[0] - 1 ||
+			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
 		submit_and_realloc:
 			submit_bio(bio);
 			bio = NULL;
@@ -370,6 +373,8 @@ int ext4_mpage_readpages(struct inode *inode,
 			 */
 			bio = bio_alloc(GFP_KERNEL,
 				min_t(int, nr_pages, BIO_MAX_PAGES));
+			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
+						  GFP_KERNEL);
 			ext4_set_bio_post_read_ctx(bio, inode, page->index);
 			bio_set_dev(bio, bdev);
 			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957ed1f05..0907f907c47d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1508,6 +1508,7 @@ enum {
 	Opt_journal_path, Opt_journal_checksum, Opt_journal_async_commit,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_data_err_abort, Opt_data_err_ignore, Opt_test_dummy_encryption,
+	Opt_inlinecrypt,
 	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
 	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
 	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
@@ -1610,6 +1611,7 @@ static const match_table_t tokens = {
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
+	{Opt_inlinecrypt, "inlinecrypt"},
 	{Opt_nombcache, "nombcache"},
 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
 	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
@@ -1946,6 +1948,13 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
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
@@ -2404,6 +2413,9 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 
 	fscrypt_show_test_dummy_encryption(seq, sep, sb);
 
+	if (sb->s_flags & SB_INLINECRYPT)
+		SEQ_OPTS_PUTS("inlinecrypt");
+
 	if (test_opt(sb, DAX_ALWAYS)) {
 		if (IS_EXT2_SB(sb))
 			SEQ_OPTS_PUTS("dax");
-- 
2.27.0.212.ge8ba1cc988-goog

