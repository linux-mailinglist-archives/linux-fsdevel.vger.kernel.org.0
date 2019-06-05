Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADC636817
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 01:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFEX3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 19:29:12 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:43339 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfFEX3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:29:11 -0400
Received: by mail-oi1-f202.google.com with SMTP id l12so64635oii.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 16:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IFpE5yY4uVy5eFXAmN1frsf7z5fTOKO1cmVK9sZaWVc=;
        b=FU8rnwe1RegyvrOecsJEpG1pFQI4RUd1Vo1UIoIR/SrsVO41rWV6cbVPHlVWDb0v7B
         z0kmjgINHwJPLmeAyFbuf8K1xWTRBYbt/mv7lg4uuGqr0OxoCg+7nkCKGgkLLjAZNo6w
         0yIEwWTHEQRcrBpFxvJpsJkFnIdnbKmITJaZHaSuIGjY0akBDFK7E7gjWWqfQZGlTziO
         q1bjOfoBiNfAIIyYGTYb2wh1SASy6ipB+5MebW9rxKc1346omXSSLOjJFXvfyjXZK6fu
         BZ4DotlesX6doWgd5LqUXcXJ6AxeiEN6sq+RzhXUmiPrMWABtugBhDRlja86zAVld5oJ
         NPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IFpE5yY4uVy5eFXAmN1frsf7z5fTOKO1cmVK9sZaWVc=;
        b=aoewfhwcKzleUX6f+Lx7k+feC7i10decSb56sSectJWslrbFS3aMuXYesRBCjA3lCJ
         6nGBq+V9l+sl1RB85d0fQ4ad0vN/OWseImAbTGNY433OlvPTsu+tBI2V5oKOUOsDZZAr
         KIsLKFrwZ0UNxWeGxz2DFqRWoQPJOZl5oaStrkv4LskmlaVxjQZNwvU3z7f5JhVtHyBt
         Whi0sC/kKJmigXHE6K5leq2u148nqRya4aM9LxNmMEHerNqS3mVYoLxgoTOy9PEzzA9+
         Da9zy81nAOJq7SpC1Y6cefSOxeaGkd/yqoBkV9gA/8n6KWIx4y91rx0DQfuBbZ+PabMD
         Al2A==
X-Gm-Message-State: APjAAAXpAOVLtCJ+pu4dAo5mD6+YYOCWVYyGcqfFBEvYbTEIVEcORIIE
        Kj9NuTwl9K2owuWcqQxBnc3/fmT/ptI=
X-Google-Smtp-Source: APXvYqwCyWWOaof96qMS2G9ax3JA8Spbk2YLf/KWQHCJlpezMKSHXZq/bfr1w/bkaJPp4DPNAoIaOhJw/dY=
X-Received: by 2002:aca:f582:: with SMTP id t124mr2372182oih.71.1559777350673;
 Wed, 05 Jun 2019 16:29:10 -0700 (PDT)
Date:   Wed,  5 Jun 2019 16:28:37 -0700
In-Reply-To: <20190605232837.31545-1-satyat@google.com>
Message-Id: <20190605232837.31545-9-satyat@google.com>
Mime-Version: 1.0
References: <20190605232837.31545-1-satyat@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH v2 8/8] f2fs: Wire up f2fs to use inline encryption via fscrypt
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/f2fs/data.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++++---
 fs/f2fs/super.c |  1 +
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index eda4181d2092..25e691947fb4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -142,6 +142,8 @@ static bool f2fs_bio_post_read_required(struct bio *bio)
 
 static void f2fs_read_end_io(struct bio *bio)
 {
+	fscrypt_unset_bio_crypt_ctx(bio);
+
 	if (time_to_inject(F2FS_P_SB(bio_first_page_all(bio)),
 						FAULT_READ_IO)) {
 		f2fs_show_injection_info(FAULT_READ_IO);
@@ -165,6 +167,8 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
+	fscrypt_unset_bio_crypt_ctx(bio);
+
 	if (time_to_inject(sbi, FAULT_WRITE_IO)) {
 		f2fs_show_injection_info(FAULT_WRITE_IO);
 		bio->bi_status = BLK_STS_IOERR;
@@ -282,9 +286,18 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 	return bio;
 }
 
+static inline u64 hw_crypt_dun(struct inode *inode, pgoff_t offset)
+{
+	return (((u64)inode->i_ino) << 32) | lower_32_bits(offset);
+}
+
 static inline void __submit_bio(struct f2fs_sb_info *sbi,
 				struct bio *bio, enum page_type type)
 {
+	struct page *page;
+	struct inode *inode;
+	int err = 0;
+
 	if (!is_read_io(bio_op(bio))) {
 		unsigned int start;
 
@@ -326,7 +339,22 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 		trace_f2fs_submit_read_bio(sbi->sb, type, bio);
 	else
 		trace_f2fs_submit_write_bio(sbi->sb, type, bio);
-	submit_bio(bio);
+
+	if (bio_has_data(bio)) {
+		page = bio_page(bio);
+		if (page && page->mapping && page->mapping->host) {
+			inode = page->mapping->host;
+			err = fscrypt_set_bio_crypt_ctx(inode, bio,
+						hw_crypt_dun(inode,
+							     page->index));
+		}
+	}
+	if (err) {
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+	} else {
+		submit_bio(bio);
+	}
 }
 
 static void __submit_merged_bio(struct f2fs_bio_info *io)
@@ -487,6 +515,9 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
 	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
 	struct page *bio_page;
+	struct inode *fio_inode, *bio_inode;
+	struct page *first_page;
+	u64 next_dun = 0;
 
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
@@ -513,10 +544,27 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 
 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
 
+	fio_inode = fio->page->mapping->host;
+	bio_inode = NULL;
+	first_page = NULL;
+	next_dun = 0;
+	if (io->bio && bio_page(io->bio)->mapping) {
+		first_page = bio_page(io->bio);
+		bio_inode = first_page->mapping->host;
+		if (fscrypt_inode_is_hw_encrypted(bio_inode)) {
+			next_dun = hw_crypt_dun(bio_inode, first_page->index) +
+				   (io->bio->bi_iter.bi_size >> PAGE_SHIFT);
+		}
+	}
 	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
 	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags) ||
-			!__same_bdev(sbi, fio->new_blkaddr, io->bio)))
+			!__same_bdev(sbi, fio->new_blkaddr, io->bio) ||
+			!fscrypt_inode_crypt_mergeable(bio_inode, fio_inode) ||
+			(fscrypt_inode_is_hw_encrypted(bio_inode) &&
+			 next_dun != hw_crypt_dun(fio_inode,
+						  fio->page->index))))
 		__submit_merged_bio(io);
+
 alloc_new:
 	if (io->bio == NULL) {
 		if ((fio->type == DATA || fio->type == NODE) &&
@@ -568,7 +616,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	bio->bi_end_io = f2fs_read_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
 
-	if (f2fs_encrypted_file(inode))
+	if (f2fs_encrypted_file(inode) && !fscrypt_inode_is_hw_encrypted(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
 	if (post_read_steps) {
 		ctx = mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
@@ -1519,6 +1567,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 					struct f2fs_map_blocks *map,
 					struct bio **bio_ret,
 					sector_t *last_block_in_bio,
+					u64 *next_dun,
 					bool is_readahead)
 {
 	struct bio *bio = *bio_ret;
@@ -1592,6 +1641,13 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
 		bio = NULL;
 	}
+
+	if (bio && fscrypt_inode_is_hw_encrypted(inode) &&
+	    *next_dun != hw_crypt_dun(inode, page->index)) {
+		__submit_bio(F2FS_I_SB(inode), bio, DATA);
+		bio = NULL;
+	}
+
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
 				is_readahead ? REQ_RAHEAD : 0);
@@ -1611,6 +1667,9 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	if (bio_add_page(bio, page, blocksize, 0) < blocksize)
 		goto submit_and_realloc;
 
+	if (fscrypt_inode_is_hw_encrypted(inode))
+		*next_dun = hw_crypt_dun(inode, page->index) + 1;
+
 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 	ClearPageError(page);
 	*last_block_in_bio = block_nr;
@@ -1644,6 +1703,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct f2fs_map_blocks map;
 	int ret = 0;
+	u64 next_dun = 0;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -1667,7 +1727,8 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		}
 
 		ret = f2fs_read_single_page(inode, page, nr_pages, &map, &bio,
-					&last_block_in_bio, is_readahead);
+					&last_block_in_bio, &next_dun,
+					is_readahead);
 		if (ret) {
 			SetPageError(page);
 			zero_user_segment(page, 0, PAGE_SIZE);
@@ -2617,6 +2678,8 @@ static void f2fs_dio_end_io(struct bio *bio)
 {
 	struct f2fs_private_dio *dio = bio->bi_private;
 
+	fscrypt_unset_bio_crypt_ctx(bio);
+
 	dec_page_count(F2FS_I_SB(dio->inode),
 			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
 
@@ -2633,12 +2696,18 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
 {
 	struct f2fs_private_dio *dio;
 	bool write = (bio_op(bio) == REQ_OP_WRITE);
+	u64 data_unit_num = hw_crypt_dun(inode, file_offset >> PAGE_SHIFT);
 
 	dio = f2fs_kzalloc(F2FS_I_SB(inode),
 			sizeof(struct f2fs_private_dio), GFP_NOFS);
 	if (!dio)
 		goto out;
 
+	if (fscrypt_set_bio_crypt_ctx(inode, bio, data_unit_num) != 0) {
+		kvfree(dio);
+		goto out;
+	}
+
 	dio->inode = inode;
 	dio->orig_end_io = bio->bi_end_io;
 	dio->orig_private = bio->bi_private;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6b959bbb336a..6399373777ce 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2229,6 +2229,7 @@ static const struct fscrypt_operations f2fs_cryptops = {
 	.dummy_context	= f2fs_dummy_context,
 	.empty_dir	= f2fs_empty_dir,
 	.max_namelen	= F2FS_NAME_LEN,
+	.hw_crypt_supp	= true,
 };
 #endif
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

