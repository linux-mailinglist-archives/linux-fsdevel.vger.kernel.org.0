Return-Path: <linux-fsdevel+bounces-68892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E062C67B49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5B0C02905A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0872E7F21;
	Tue, 18 Nov 2025 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E+vK4oO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1112E62A9;
	Tue, 18 Nov 2025 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446955; cv=none; b=F2WsBhYfOCx08th0NgoEnk+IW9y3fYIrN7kSl0v864VDNhLtmW9OF7POsZc/FMIuvj5w7tjxjMdpAoMhdcVt6wWvaYPGkAgJ70CxjUFOQTzgO/ifYhOk5h1IhOypv5umYt5roMdC5x1oShtatJCfgVUAS61oPgEb4BDX99dFFDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446955; c=relaxed/simple;
	bh=KB4egdA8Ks7Mg8RgmZ0I2R4yRoDU7PAYgCe25/CwaiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o10w/T0KGrpGv3MGcmTvu8IbBQnnb6uvPBrFEtp7CkpJ7JCt82e+VGmnNuwqDiBAYiXPB2W3sf3YAAKgto9UewUFOlzXBf3ALLRL5v6B8EtXV0oOEm6mUdDA0cFBTNVFIiiJX5wsQc23k3XzJVyj3Gi37pAc9Xdy61j6Bn1xzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E+vK4oO9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OPIzFSk2TSTMy8PDNKkZIvullfOau/EvrnIO40ungf8=; b=E+vK4oO9q9RxN/X6DrsIjv5N3W
	yuyGN/pxLD0dke7KtYXTlzM3XdGxf+gWc4Sk0b72l5y22QXpHJoblK9AZrWWjkpxb7s77cvIvr0vH
	zVQsGe4CxeALx7MqQ8Im0iujo3AR3Ueu70AuB5f6fmHbwZ7JJHSjXni2X5TND78MJ0zF+gkWQLVG8
	mfUNdAQqxOj6a4cCzPHfvohV7Co8yYPpp0snLB8VARm42Jz/mmNs2nvL15zXV40VYM+9Kzmql7sCJ
	gXfSBbOQhhT2JRLYK6TVT9z3Vp0xuoxi4HIixsWXhNwOZu0p8sRmEYHGBuMe6MqV7nxRja+Zel1Qv
	Qlq+Uzcw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF6n-0000000HUPY-0cXV;
	Tue, 18 Nov 2025 06:22:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/11] fscrypt: pass a byte offset to fscrypt_set_bio_crypt_ctx
Date: Tue, 18 Nov 2025 07:21:48 +0100
Message-ID: <20251118062159.2358085-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118062159.2358085-1-hch@lst.de>
References: <20251118062159.2358085-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Logical offsets into an inode are usually expresssed as bytes in the VFS.
Switch fscrypt_set_bio_crypt_ctx to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c          | 8 ++++----
 fs/crypto/inline_crypt.c | 9 +++++----
 fs/ext4/readpage.c       | 4 ++--
 fs/f2fs/data.c           | 4 +++-
 fs/iomap/direct-io.c     | 6 ++----
 include/linux/fscrypt.h  | 7 +++----
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index fce401c9df98..3a7e3b37ac02 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -75,6 +75,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 {
 	const unsigned int blockbits = inode->i_blkbits;
 	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
+	loff_t pos = (loff_t)lblk << blockbits;
 	struct fscrypt_zero_done done = {
 		.pending	= ATOMIC_INIT(1),
 		.done		= COMPLETION_INITIALIZER_ONSTACK(done.done),
@@ -89,7 +90,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 		bio->bi_iter.bi_sector = sector;
 		bio->bi_private = &done;
 		bio->bi_end_io = fscrypt_zeroout_range_end_io;
-		fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOFS);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos, GFP_NOFS);
 
 		for (n = 0; n < BIO_MAX_VECS; n++) {
 			unsigned int blocks_this_page =
@@ -98,10 +99,9 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 
 			__bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
 			len -= blocks_this_page;
-			lblk += blocks_this_page;
+			pos += bytes_this_page;
 			sector += (bytes_this_page >> SECTOR_SHIFT);
-			if (!len || !fscrypt_mergeable_bio(bio, inode,
-			    		(loff_t)lblk << blockbits))
+			if (!len || !fscrypt_mergeable_bio(bio, inode, pos))
 				break;
 		}
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index aba830e0827d..c069958c4819 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -285,7 +285,7 @@ static void fscrypt_generate_dun(const struct fscrypt_inode_info *ci,
  * fscrypt_set_bio_crypt_ctx() - prepare a file contents bio for inline crypto
  * @bio: a bio which will eventually be submitted to the file
  * @inode: the file's inode
- * @first_lblk: the first file logical block number in the I/O
+ * @pos: the first file logical offset (in bytes) in the I/O
  * @gfp_mask: memory allocation flags - these must be a waiting mask so that
  *					bio_crypt_set_ctx can't fail.
  *
@@ -298,7 +298,7 @@ static void fscrypt_generate_dun(const struct fscrypt_inode_info *ci,
  * The encryption context will be freed automatically when the bio is freed.
  */
 void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
-			       u64 first_lblk, gfp_t gfp_mask)
+			       loff_t pos, gfp_t gfp_mask)
 {
 	const struct fscrypt_inode_info *ci;
 	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
@@ -307,7 +307,7 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 		return;
 	ci = fscrypt_get_inode_info_raw(inode);
 
-	fscrypt_generate_dun(ci, first_lblk << inode->i_blkbits, dun);
+	fscrypt_generate_dun(ci, pos, dun);
 	bio_crypt_set_ctx(bio, ci->ci_enc_key.blk_key, dun, gfp_mask);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
@@ -353,7 +353,8 @@ void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
 	u64 first_lblk;
 
 	if (bh_get_inode_and_lblk_num(first_bh, &inode, &first_lblk))
-		fscrypt_set_bio_crypt_ctx(bio, inode, first_lblk, gfp_mask);
+		fscrypt_set_bio_crypt_ctx(bio, inode,
+			first_lblk << inode->i_blkbits, gfp_mask);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 371f34a14084..ac3965040f85 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -359,8 +359,8 @@ int ext4_mpage_readpages(struct inode *inode,
 			 */
 			bio = bio_alloc(bdev, bio_max_segs(nr_pages),
 					REQ_OP_READ, GFP_KERNEL);
-			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
-						  GFP_KERNEL);
+			fscrypt_set_bio_crypt_ctx(bio, inode,
+					(loff_t)next_block << blkbits, GFP_KERNEL);
 			ext4_set_bio_post_read_ctx(bio, inode, folio->index);
 			bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dd3c98fbe6b5..270770c611cf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -489,7 +489,9 @@ static void f2fs_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 	 * read/write raw data without encryption.
 	 */
 	if (!fio || !fio->encrypted_page)
-		fscrypt_set_bio_crypt_ctx(bio, inode, first_idx, gfp_mask);
+		fscrypt_set_bio_crypt_ctx(bio, inode,
+				(loff_t)first_idx << inode->i_blkbits,
+				gfp_mask);
 }
 
 static bool f2fs_crypt_mergeable_bio(struct bio *bio, const struct inode *inode,
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d5d63efbd57..01b4a8c44cc2 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -295,8 +295,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		return -EINVAL;
 
 	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
-	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
-				  GFP_KERNEL);
+	fscrypt_set_bio_crypt_ctx(bio, inode, pos, GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
@@ -425,8 +424,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		}
 
 		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
-		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
-					  GFP_KERNEL);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos, GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = inode->i_write_hint;
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 5f2e02a61401..5b86d7d0d367 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -865,9 +865,8 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 
 bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode);
 
-void fscrypt_set_bio_crypt_ctx(struct bio *bio,
-			       const struct inode *inode, u64 first_lblk,
-			       gfp_t gfp_mask);
+void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
+			       loff_t pos, gfp_t gfp_mask);
 
 void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
 				  const struct buffer_head *first_bh,
@@ -892,7 +891,7 @@ static inline bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 
 static inline void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 					     const struct inode *inode,
-					     u64 first_lblk, gfp_t gfp_mask) { }
+					     loff_t pos, gfp_t gfp_mask) { }
 
 static inline void fscrypt_set_bio_crypt_ctx_bh(
 					 struct bio *bio,
-- 
2.47.3


