Return-Path: <linux-fsdevel+bounces-78506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFVqBldkoGnrjAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:18:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE161A8748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A839D3001CC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D9B3E8C70;
	Thu, 26 Feb 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z8WthAZ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B833B8D62;
	Thu, 26 Feb 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117404; cv=none; b=oAPDq1DaYzPf3i9XMRBNAkqQFjYjin3F3VkBBd+JW8rdJZplB5+WGk7vfVtPcP0GvYVqtsWZAZNIbjjlPAupBSC0ui2LYgephyZ5onx1ph44IKdIV88xPNSzPqmp1A91dz4WOehg+gVKTVLtjv+6NLTSDaThbNg49Xn8RAQmLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117404; c=relaxed/simple;
	bh=WTEt7FNvV9kFUcbgwDH3ORHWG4p2d3yw+kV/7yRq+RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjhgw3DKOg1WvJfzbtiKv8Qsk1rtfXKmYRsAgg03CPSi6E4+tlH5ogSHhVszgxQdmsZUO06HrZEdX7rhA4DGVefuZfmtRfZvvPIXfAbni+Bpdc9su0YAuxR89/BYsbYhWEznQGY/j5DNbdWhObtqmAXKzqss21X7YX2Ax3CEbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z8WthAZ7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CvEhxu1jDUgHPuJ6XjlwS8JGVnwgBWdyt3k5o8ZsoXw=; b=Z8WthAZ7WKgVtkgBGZe3gde+uf
	0OEjgVOVzGLDwstnfUGSB63Xcoe2RkWydUFL6Dv0a6YqtNimE3FPP4GHPojlcf1OPTETSj1nK1/ho
	7nEtH1hudN/xRt2zstLwoUBgBKJqHxcP/t/PSHOPQFMg8qn/q/WEZrrI9oWXW90OlnrO6cUK32cSt
	uM8tDbGc+4zSib1ayULYztvwp07j6S7hTiRBbZldAmPZtwvItswnhIeVSUlHOzWIpd8otS6KiBuR9
	oPIbJFUhQ/icfVWKx9kUoCfYn91gokGc4uU0+KAP4LvcNJIkWD8nGlm1rXZGG1223GtNfdtq8WAtS
	hXDDe+hQ==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcgf-00000006NbN-1rG3;
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
Subject: [PATCH 07/14] fscrypt: pass a byte offset to fscrypt_mergeable_bio
Date: Thu, 26 Feb 2026 06:49:27 -0800
Message-ID: <20260226144954.142278-8-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78506-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 2CE161A8748
X-Rspamd-Action: no action

Logical offsets into an inode are usually expressed as bytes in the VFS.
Switch fscrypt_mergeable_bio to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c          | 3 ++-
 fs/crypto/inline_crypt.c | 6 +++---
 fs/ext4/page-io.c        | 3 +--
 fs/ext4/readpage.c       | 3 ++-
 fs/f2fs/data.c           | 3 ++-
 include/linux/fscrypt.h  | 4 ++--
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 6da683ea69dc..0a701d4a17ef 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -100,7 +100,8 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 			len -= blocks_this_page;
 			lblk += blocks_this_page;
 			sector += (bytes_this_page >> SECTOR_SHIFT);
-			if (!len || !fscrypt_mergeable_bio(bio, inode, lblk))
+			if (!len || !fscrypt_mergeable_bio(bio, inode,
+					(loff_t)lblk << blockbits))
 				break;
 		}
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 5279565e9846..b0954d17904b 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -316,7 +316,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
  * fscrypt_mergeable_bio() - test whether data can be added to a bio
  * @bio: the bio being built up
  * @inode: the inode for the next part of the I/O
- * @next_lblk: the next file logical block number in the I/O
+ * @pos: the next file position (in bytes) in the I/O
  *
  * When building a bio which may contain data which should undergo inline
  * encryption (or decryption) via fscrypt, filesystems should call this function
@@ -334,7 +334,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
  * Return: true iff the I/O is mergeable
  */
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
-			   u64 next_lblk)
+			   loff_t pos)
 {
 	const struct bio_crypt_ctx *bc = bio->bi_crypt_context;
 	const struct fscrypt_inode_info *ci;
@@ -354,7 +354,7 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	if (bc->bc_key != ci->ci_enc_key.blk_key)
 		return false;
 
-	fscrypt_generate_dun(ci, next_lblk << inode->i_blkbits, next_dun);
+	fscrypt_generate_dun(ci, pos, next_dun);
 	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 3db3c19a29e5..5df5e7e6adde 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -448,8 +448,7 @@ static bool io_submit_need_new_bio(struct ext4_io_submit *io,
 	if (bh->b_blocknr != io->io_next_block)
 		return true;
 	if (!fscrypt_mergeable_bio(io->io_bio, inode,
-			(folio_pos(io_folio) + bh_offset(bh)) >>
-			 inode->i_blkbits))
+			folio_pos(io_folio) + bh_offset(bh)))
 		return true;
 	return false;
 }
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 830f3b8a321f..ba7cfddd6038 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -342,7 +342,8 @@ static int ext4_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 		 * BIO off first?
 		 */
 		if (bio && (last_block_in_bio != first_block - 1 ||
-			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
+			    !fscrypt_mergeable_bio(bio, inode,
+				(loff_t)next_block << blkbits))) {
 		submit_and_realloc:
 			blk_crypto_submit_bio(bio);
 			bio = NULL;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 338df7a2aea6..dca273fedfde 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -541,7 +541,8 @@ static bool f2fs_crypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	if (fio && fio->encrypted_page)
 		return !bio_has_crypt_ctx(bio);
 
-	return fscrypt_mergeable_bio(bio, inode, next_idx);
+	return fscrypt_mergeable_bio(bio, inode,
+			(loff_t)next_idx << inode->i_blkbits);
 }
 
 void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 26561b7994e0..98fb14660d40 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -870,7 +870,7 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 			       gfp_t gfp_mask);
 
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
-			   u64 next_lblk);
+			   loff_t pos);
 
 bool fscrypt_dio_supported(struct inode *inode);
 
@@ -889,7 +889,7 @@ static inline void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 
 static inline bool fscrypt_mergeable_bio(struct bio *bio,
 					 const struct inode *inode,
-					 u64 next_lblk)
+					 loff_t pos)
 {
 	return true;
 }
-- 
2.47.3


