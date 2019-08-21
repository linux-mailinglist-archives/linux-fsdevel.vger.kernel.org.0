Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9CE49743D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfHUH5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 03:57:41 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54500 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfHUH5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:57:39 -0400
Received: by mail-pl1-f202.google.com with SMTP id g9so986964plo.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Za7w9RhqOvx+rbdwwS8b0CPcodToPB6Hjzwh7+A6Syg=;
        b=DkO7Nn7D2Xk3T8cG9p5c6N+nZxrZ4col+9+vVnpt+G8JRphS7kgWTTlgn5Bd5a7AEr
         2+F74HCdI8eYIHLUkOCPVnjF6FETFobs//509xgwEM6D2QXn5fWkqtj1OYtyNK9jLmcb
         nUKfbKW2EpHKT2STSUPVMDF1nO/bLvyj7TNB7z7JrveFvkG+H83icRhL4TabD7m81QWd
         rLvILk0GUc37LAVeI9NTyikh6FTn203V3g/QNWZMD7plUmU3b9axvSOM/g4hUsLM+MdH
         qocPUAm3Qz2URW8cy40aN8EXQVmgiiGAjvgjxDT2Zlcia441Z0Tq6MJ7LfZvRRBZ/kxa
         m3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Za7w9RhqOvx+rbdwwS8b0CPcodToPB6Hjzwh7+A6Syg=;
        b=rUu0xIHwxbKq4W+vfJBSGd3/VHaH9LhI+zqQGoF6WtMcxb1Bh9EOWEk/qzB+zqCYh6
         BO7fQAZ3xMvw+ubqAE8su8sVMdVVbmcVKCwMjkmOL2SwUByonPR43l5S+DkNFDyc11qZ
         HGL8aS5T8BL507mYYca0K0zDeir21LHjzmsZ7vxqRJKvbeeCMv1ca4IG6bXShCcQHGl3
         uXPo73N/D4oXo0m8S9RwRrzu+gd8vet017EWwwLbUIvNhZPXP/HFgYKgp/hfqeld8mWX
         CICJcUOYAxIpLCSJvVDKkHjFWQMd1ORq69gkRLTxrS8bBSNR9GZ06Vl+9c2xD1gpmV7K
         FFjg==
X-Gm-Message-State: APjAAAXLh7E4h67W20VIXB4HuoPDItrOCGF8OgOUMv0ZY2jop64tKfOz
        +zJhLz1sYvClOavhhX4q2/zUQOH+qac=
X-Google-Smtp-Source: APXvYqxT3jAgizDP+6vcOIt7t24Pqk/vf2IKzBLMg5jcFQikXJNxIrCVsY+Yz+Wd8/Yvw1kXif/HLfUjnzU=
X-Received: by 2002:a63:ab08:: with SMTP id p8mr29238085pgf.340.1566374258557;
 Wed, 21 Aug 2019 00:57:38 -0700 (PDT)
Date:   Wed, 21 Aug 2019 00:57:14 -0700
In-Reply-To: <20190821075714.65140-1-satyat@google.com>
Message-Id: <20190821075714.65140-9-satyat@google.com>
Mime-Version: 1.0
References: <20190821075714.65140-1-satyat@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v4 8/8] f2fs: Wire up f2fs to use inline encryption via fscrypt
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/f2fs/data.c  | 127 ++++++++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/super.c |  15 +++---
 2 files changed, 126 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index abbf14e9bd72..a7294edce173 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -143,6 +143,8 @@ static bool f2fs_bio_post_read_required(struct bio *bio)
 
 static void f2fs_read_end_io(struct bio *bio)
 {
+	fscrypt_unset_bio_crypt_ctx(bio);
+
 	if (time_to_inject(F2FS_P_SB(bio_first_page_all(bio)),
 						FAULT_READ_IO)) {
 		f2fs_show_injection_info(FAULT_READ_IO);
@@ -166,6 +168,8 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
+	fscrypt_unset_bio_crypt_ctx(bio);
+
 	if (time_to_inject(sbi, FAULT_WRITE_IO)) {
 		f2fs_show_injection_info(FAULT_WRITE_IO);
 		bio->bi_status = BLK_STS_IOERR;
@@ -283,6 +287,53 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 	return bio;
 }
 
+static int f2fs_init_bio_crypt_ctx(struct bio *bio, struct inode *inode,
+				   struct f2fs_io_info *fio, bool no_fail)
+{
+	gfp_t gfp_mask = GFP_NOIO;
+	/*
+	 * This function should be called with NULL inode iff the pages
+	 * being added to the bio are to be handled without inline
+	 * en/decryption.
+	 */
+	if (!inode)
+		return 0;
+
+	/*
+	 * If the fio has an encrypted page, that means we want to read/write
+	 * it without inline encryption (for e.g. when moving blocks)
+	 */
+	if (fio && fio->encrypted_page)
+		return 0;
+
+	if (no_fail)
+		gfp_mask |= __GFP_NOFAIL;
+
+	return fscrypt_set_bio_crypt_ctx(bio, inode, 0, gfp_mask);
+}
+
+static inline u64 inline_crypt_dun(struct inode *inode, pgoff_t offset)
+{
+	return (((u64)inode->i_ino) << 32) | lower_32_bits(offset);
+}
+
+bool f2fs_page_crypt_back_mergeable(const struct bio *bio,
+				    const struct page *page)
+{
+	struct inode *bio_inode = bio && bio_page(bio)->mapping ?
+				    bio_page(bio)->mapping->host : NULL;
+	struct inode *page_inode = page && page->mapping ? page->mapping->host
+							 : NULL;
+
+	if (!fscrypt_inode_crypt_mergeable(page_inode, bio_inode))
+		return false;
+	if (!bio_inode || !fscrypt_inode_is_inline_crypted(bio_inode))
+		return true;
+	return inline_crypt_dun(bio_inode, bio_page(bio)->index) +
+	       (bio->bi_iter.bi_size >> PAGE_SHIFT) ==
+	       inline_crypt_dun(page_inode, page->index);
+}
+
 static inline void __submit_bio(struct f2fs_sb_info *sbi,
 				struct bio *bio, enum page_type type)
 {
@@ -327,6 +378,14 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 		trace_f2fs_submit_read_bio(sbi->sb, type, bio);
 	else
 		trace_f2fs_submit_write_bio(sbi->sb, type, bio);
+
+	if (bio_has_data(bio) && bio_has_crypt_ctx(bio)) {
+		struct page *page = bio_page(bio);
+
+		bio_set_data_unit_num(bio, inline_crypt_dun(page->mapping->host,
+							    page->index));
+	}
+
 	submit_bio(bio);
 }
 
@@ -451,6 +510,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	struct bio *bio;
 	struct page *page = fio->encrypted_page ?
 			fio->encrypted_page : fio->page;
+	int err;
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
 			fio->is_por ? META_POR : (__is_meta_io(fio) ?
@@ -464,9 +524,15 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
 				1, is_read_io(fio->op), fio->type, fio->temp);
 
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
+	err = f2fs_init_bio_crypt_ctx(bio, fio->page->mapping->host, fio,
+				      false);
+
+	if (!err && bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
+		err = -EFAULT;
+
+	if (err) {
 		bio_put(bio);
-		return -EFAULT;
+		return err;
 	}
 
 	if (fio->io_wbc && !is_read_io(fio->op))
@@ -486,6 +552,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	struct bio *bio = *fio->bio;
 	struct page *page = fio->encrypted_page ?
 			fio->encrypted_page : fio->page;
+	int err;
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
 			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
@@ -495,7 +562,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	f2fs_trace_ios(fio, 0);
 
 	if (bio && (*fio->last_block + 1 != fio->new_blkaddr ||
-			!__same_bdev(fio->sbi, fio->new_blkaddr, bio))) {
+			!__same_bdev(fio->sbi, fio->new_blkaddr, bio) ||
+			!f2fs_page_crypt_back_mergeable(bio, page))) {
 		__submit_bio(fio->sbi, bio, fio->type);
 		bio = NULL;
 	}
@@ -503,6 +571,12 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	if (!bio) {
 		bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
 				BIO_MAX_PAGES, false, fio->type, fio->temp);
+		err = f2fs_init_bio_crypt_ctx(bio, fio->page->mapping->host,
+					      fio, false);
+		if (err) {
+			bio_put(bio);
+			return err;
+		}
 		bio_set_op_attrs(bio, fio->op, fio->op_flags);
 	}
 
@@ -570,8 +644,10 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 
 	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
 	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags) ||
-			!__same_bdev(sbi, fio->new_blkaddr, io->bio)))
+			!__same_bdev(sbi, fio->new_blkaddr, io->bio) ||
+			!f2fs_page_crypt_back_mergeable(io->bio, bio_page)))
 		__submit_merged_bio(io);
+
 alloc_new:
 	if (io->bio == NULL) {
 		if ((fio->type == DATA || fio->type == NODE) &&
@@ -583,6 +659,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		io->bio = __bio_alloc(sbi, fio->new_blkaddr, fio->io_wbc,
 						BIO_MAX_PAGES, false,
 						fio->type, fio->temp);
+		f2fs_init_bio_crypt_ctx(io->bio, fio->page->mapping->host,
+					fio, true);
 		io->fio = *fio;
 	}
 
@@ -615,16 +693,24 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	struct bio *bio;
 	struct bio_post_read_ctx *ctx;
 	unsigned int post_read_steps = 0;
+	int err;
 
 	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
+	err = f2fs_init_bio_crypt_ctx(bio, inode, NULL, false);
+	if (err) {
+		bio_put(bio);
+		return ERR_PTR(err);
+	}
+
 	f2fs_target_device(sbi, blkaddr, bio);
 	bio->bi_end_io = f2fs_read_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
 
-	if (f2fs_encrypted_file(inode))
+	if (fscrypt_needs_fs_layer_crypto(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
+
 	if (post_read_steps) {
 		ctx = mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
 		if (!ctx) {
@@ -1574,6 +1660,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 					struct f2fs_map_blocks *map,
 					struct bio **bio_ret,
 					sector_t *last_block_in_bio,
+					u64 *next_dun,
 					bool is_readahead)
 {
 	struct bio *bio = *bio_ret;
@@ -1648,6 +1735,13 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
 		bio = NULL;
 	}
+
+	if (bio && fscrypt_inode_is_inline_crypted(inode) &&
+	    *next_dun != inline_crypt_dun(inode, page->index)) {
+		__submit_bio(F2FS_I_SB(inode), bio, DATA);
+		bio = NULL;
+	}
+
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
 				is_readahead ? REQ_RAHEAD : 0);
@@ -1667,6 +1761,9 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	if (bio_add_page(bio, page, blocksize, 0) < blocksize)
 		goto submit_and_realloc;
 
+	if (fscrypt_inode_is_inline_crypted(inode))
+		*next_dun = inline_crypt_dun(inode, page->index) + 1;
+
 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 	ClearPageError(page);
 	*last_block_in_bio = block_nr;
@@ -1700,6 +1797,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct f2fs_map_blocks map;
 	int ret = 0;
+	u64 next_dun = 0;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -1723,7 +1821,8 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		}
 
 		ret = f2fs_read_single_page(inode, page, nr_pages, &map, &bio,
-					&last_block_in_bio, is_readahead);
+					&last_block_in_bio, &next_dun,
+					is_readahead);
 		if (ret) {
 			SetPageError(page);
 			zero_user_segment(page, 0, PAGE_SIZE);
@@ -1777,12 +1876,12 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 	struct page *mpage;
 	gfp_t gfp_flags = GFP_NOFS;
 
-	if (!f2fs_encrypted_file(inode))
-		return 0;
-
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
 
+	if (!fscrypt_needs_fs_layer_crypto(inode))
+		return 0;
+
 retry_encrypt:
 	fio->encrypted_page = fscrypt_encrypt_pagecache_blocks(fio->page,
 							       PAGE_SIZE, 0,
@@ -1957,7 +2056,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 			f2fs_unlock_op(fio->sbi);
 		err = f2fs_inplace_write_data(fio);
 		if (err) {
-			if (f2fs_encrypted_file(inode))
+			if (fscrypt_needs_fs_layer_crypto(inode))
 				fscrypt_finalize_bounce_page(&fio->encrypted_page);
 			if (PageWriteback(page))
 				end_page_writeback(page);
@@ -2692,6 +2791,8 @@ static void f2fs_dio_end_io(struct bio *bio)
 {
 	struct f2fs_private_dio *dio = bio->bi_private;
 
+	fscrypt_unset_bio_crypt_ctx(bio);
+
 	dec_page_count(F2FS_I_SB(dio->inode),
 			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
 
@@ -2708,12 +2809,18 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
 {
 	struct f2fs_private_dio *dio;
 	bool write = (bio_op(bio) == REQ_OP_WRITE);
+	u64 data_unit_num = inline_crypt_dun(inode, file_offset >> PAGE_SHIFT);
 
 	dio = f2fs_kzalloc(F2FS_I_SB(inode),
 			sizeof(struct f2fs_private_dio), GFP_NOFS);
 	if (!dio)
 		goto out;
 
+	if (fscrypt_set_bio_crypt_ctx(bio, inode, data_unit_num, GFP_NOIO)) {
+		kvfree(dio);
+		goto out;
+	}
+
 	dio->inode = inode;
 	dio->orig_end_io = bio->bi_end_io;
 	dio->orig_private = bio->bi_private;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78a1b873e48a..196145cb42f9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2223,12 +2223,15 @@ static bool f2fs_dummy_context(struct inode *inode)
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
-	.key_prefix	= "f2fs:",
-	.get_context	= f2fs_get_context,
-	.set_context	= f2fs_set_context,
-	.dummy_context	= f2fs_dummy_context,
-	.empty_dir	= f2fs_empty_dir,
-	.max_namelen	= F2FS_NAME_LEN,
+	.key_prefix		= "f2fs:",
+	.get_context		= f2fs_get_context,
+	.set_context		= f2fs_set_context,
+	.dummy_context		= f2fs_dummy_context,
+	.empty_dir		= f2fs_empty_dir,
+	.max_namelen		= F2FS_NAME_LEN,
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+	.inline_crypt_supp	= true,
+#endif
 };
 #endif
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

