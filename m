Return-Path: <linux-fsdevel+bounces-78507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHjeIfJeoGlViwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:55:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B231A8110
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB6F314883E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B643E8C7A;
	Thu, 26 Feb 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MI9lZyVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536BC2E5D17;
	Thu, 26 Feb 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117405; cv=none; b=rwaf1urr6E8k0RUPAY5P3HhOHRXjrYh1b72GIRHoNNmNHDvbzg/AdQlbDSXzLLp5UHmlWmJvKs/206jghoYiPalqA1vO1NEKiWqFzi4mQjTffMz7hEihJhiuZLE8E490pve4yRIXWKaVow2KraCagKb5lQCYghzbkyvkw8H7HK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117405; c=relaxed/simple;
	bh=yh98ANxYPWg1IUIzizSbZiQpU3V6AK8NPZs95anRHoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVCwfUE+tGhAPBzSSnFyb4owfUNPozLyY2tR4h5oOiWpz2ordZ3/4Rlr3pqRWe0wWm3H24wITCbTInl+01E1rUkutl076lm9VWVo8QKID0ADgcV4eMVYnPiF0cFJoAbu//nuXxmkAnWyFIYFb+jK/sjw5ovAq6/t5DrGhurR2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MI9lZyVB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YXm9tkK3++Dl59MDk39tLjDPOguQDj50r5UTIND47go=; b=MI9lZyVBl02XkmlSMxRcOUCyPz
	rWQOmVL4nAY6lNrmxOWAgoDDhQINiDBHBuU1078hRnWYROIt11LceSqICGDQY9S3w/PNsDxSxT2Za
	9fX9vVQifKNL2loQc7G0zKxA+myBYquSWzBBSSRwL1WXCnPG9v0OOQYxdbwDPRL3E2YsQa6l+Oo8t
	azMkbJhABnqVFT+JNzkOQfSQncjqUl4vEoOiDm6efBGFD6ikBK0udFI2wIUr7ZoYxvYs9h1Q6G71S
	D1bDkPVeHFNiml3cnzkYP/cQ03RY9V8ww29qA6cJCyyGxP3+mGN02mscSaNsCcPrcS9icNYVJSBHi
	QQgaH+Ug==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcgf-00000006NbY-2hYg;
	Thu, 26 Feb 2026 14:49:57 +0000
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
Subject: [PATCH 08/14] fscrypt: pass a byte offset to fscrypt_set_bio_crypt_ctx
Date: Thu, 26 Feb 2026 06:49:28 -0800
Message-ID: <20260226144954.142278-9-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226144954.142278-1-hch@lst.de>
References: <20260226144954.142278-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78507-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 27B231A8110
X-Rspamd-Action: no action

Logical offsets into an inode are usually expressed as bytes in the VFS.
Switch fscrypt_set_bio_crypt_ctx to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c              | 7 ++-----
 fs/crypto/bio.c          | 8 ++++----
 fs/crypto/inline_crypt.c | 6 +++---
 fs/ext4/page-io.c        | 4 +---
 fs/ext4/readpage.c       | 4 ++--
 fs/f2fs/data.c           | 4 +++-
 fs/iomap/direct-io.c     | 6 ++----
 include/linux/fscrypt.h  | 7 +++----
 8 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e1e95463e06b..4e3edaffbf43 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2778,8 +2778,6 @@ static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
 				  gfp_t gfp_mask)
 {
 	const struct address_space *mapping = folio_mapping(bh->b_folio);
-	const struct inode *inode;
-	u64 lblk;
 
 	/*
 	 * The ext4 journal (jbd2) can submit a buffer_head it directly created
@@ -2787,9 +2785,8 @@ static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
 	 */
 	if (!mapping)
 		return;
-	inode = mapping->host;
-	lblk = (folio_pos(bh->b_folio) + bh_offset(bh)) >> inode->i_blkbits;
-	fscrypt_set_bio_crypt_ctx(bio, inode, lblk, gfp_mask);
+	fscrypt_set_bio_crypt_ctx(bio, mapping->host,
+			folio_pos(bh->b_folio) + bh_offset(bh), gfp_mask);
 }
 
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 0a701d4a17ef..e7fb2fdd9728 100644
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
-					(loff_t)lblk << blockbits))
+			if (!len || !fscrypt_mergeable_bio(bio, inode, pos))
 				break;
 		}
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index b0954d17904b..37d42d357925 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -285,7 +285,7 @@ static void fscrypt_generate_dun(const struct fscrypt_inode_info *ci,
  * fscrypt_set_bio_crypt_ctx() - prepare a file contents bio for inline crypto
  * @bio: a bio which will eventually be submitted to the file
  * @inode: the file's inode
- * @first_lblk: the first file logical block number in the I/O
+ * @pos: the first file position (in bytes) in the I/O
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
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 5df5e7e6adde..2c776af75916 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -428,9 +428,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 */
 	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
 	fscrypt_set_bio_crypt_ctx(bio, inode,
-			(folio_pos(io_folio) + bh_offset(bh)) >>
-				inode->i_blkbits,
-			GFP_NOIO);
+			folio_pos(io_folio) + bh_offset(bh), GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index ba7cfddd6038..fbfa4d830d9a 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -355,8 +355,8 @@ static int ext4_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 			 */
 			bio = bio_alloc(bdev, bio_max_segs(nr_pages),
 					REQ_OP_READ, GFP_KERNEL);
-			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
-						  GFP_KERNEL);
+			fscrypt_set_bio_crypt_ctx(bio, inode,
+					(loff_t)next_block << blkbits, GFP_KERNEL);
 			ext4_set_bio_post_read_ctx(bio, inode, vi);
 			bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dca273fedfde..07b4ed6bb0cc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -527,7 +527,9 @@ static void f2fs_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
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
index 95254aa1b654..b4ee4465f4db 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -298,8 +298,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 
 	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs,
 				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
-	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
-				  GFP_KERNEL);
+	fscrypt_set_bio_crypt_ctx(bio, inode, pos, GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
@@ -329,8 +328,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 		nr_vecs = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 
 	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs, op);
-	fscrypt_set_bio_crypt_ctx(bio, iter->inode,
-			pos >> iter->inode->i_blkbits, GFP_KERNEL);
+	fscrypt_set_bio_crypt_ctx(bio, iter->inode, pos, GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_write_hint = iter->inode->i_write_hint;
 	bio->bi_ioprio = dio->iocb->ki_ioprio;
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 98fb14660d40..90f75fe0e1c9 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -865,9 +865,8 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 
 bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode);
 
-void fscrypt_set_bio_crypt_ctx(struct bio *bio,
-			       const struct inode *inode, u64 first_lblk,
-			       gfp_t gfp_mask);
+void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
+			       loff_t pos, gfp_t gfp_mask);
 
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 			   loff_t pos);
@@ -885,7 +884,7 @@ static inline bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 
 static inline void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 					     const struct inode *inode,
-					     u64 first_lblk, gfp_t gfp_mask) { }
+					     loff_t pos, gfp_t gfp_mask) { }
 
 static inline bool fscrypt_mergeable_bio(struct bio *bio,
 					 const struct inode *inode,
-- 
2.47.3


