Return-Path: <linux-fsdevel+bounces-68891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8873C67B34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA76E4F0F24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C7D2E7BBA;
	Tue, 18 Nov 2025 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VZoS19wu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4E2E62A9;
	Tue, 18 Nov 2025 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446951; cv=none; b=PPWw15nTnKd94ZKTQkR6FxdiPSdJPLZvEmv/4n8EUG/cIqvZTZLC5dikq5ZmLOE8Cpxj1P58kg75isT+06x9VH7Z8yQDyiGb4owjY8MO8iZoKR9Yla811UsYFTdBTIPeD644wkHo1K5hRn7fXKZUCOIkowZme1Enp2yn9saxjto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446951; c=relaxed/simple;
	bh=8wNGwrE103y8R2A0oa4rl/wCSnoiQk2bAi8MKdQci2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivkYdzC7veXccxhB0q9eF/6JbFCd5wYpeDvpTQUoVIyoRda4K5kr8rPMjSEC3RPke0fM+xP4cA8yCkhGEwCe6D+sF21F+z8zteqMTQBAm5RwskerMmKuObJcemKpPrBvtWMWNV67wEFXC6Ln//YWgmZt5AuMVhGCyu0rCqKpJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VZoS19wu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TAin3/W8srS40RHgLntcNUfNJVb6TACxP2TpbGdvN8Y=; b=VZoS19wu7+1lO80jOH9DA6NCw7
	Eijphx1cC2Tpo4pOKx0dKjuyAcAU1adn/p/KkrO2nKet9WbM0fkaPfvQtUAsQUG9kw/NNM2tTrBEP
	uAOxN3lKROUCE3FR8ZFU3Z2FsATbDQiqXaK9FQdaBm4mprrSfYC0S9zoa8GIeNoROH7/xtGJE+q9Z
	ZwZroD1clQxfEhwEtPONUtAaVn6v0ZW2hkzIfXHJv5JmqwCvkXl9+iE8rmklWx1HaTKeQGs73I8ph
	e22qX6/Z9kyxY9n1QsKmVkWnYaUMdqAdcwn9qsaZLlv/fq1IF+pVj9O9Rr/DxP2OAMALOGzxucs/5
	Bxjz0Y1w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF6h-0000000HUP7-3I8f;
	Tue, 18 Nov 2025 06:22:29 +0000
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
Subject: [PATCH 04/11] fscrypt: pass a byte offset to fscrypt_mergeable_bio
Date: Tue, 18 Nov 2025 07:21:47 +0100
Message-ID: <20251118062159.2358085-5-hch@lst.de>
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
Switch fscrypt_mergeable_bio to that convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/bio.c          | 3 ++-
 fs/crypto/inline_crypt.c | 9 +++++----
 fs/ext4/readpage.c       | 3 ++-
 fs/f2fs/data.c           | 3 ++-
 include/linux/fscrypt.h  | 4 ++--
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index c2b3ca100f8d..fce401c9df98 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -100,7 +100,8 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 			len -= blocks_this_page;
 			lblk += blocks_this_page;
 			sector += (bytes_this_page >> SECTOR_SHIFT);
-			if (!len || !fscrypt_mergeable_bio(bio, inode, lblk))
+			if (!len || !fscrypt_mergeable_bio(bio, inode,
+			    		(loff_t)lblk << blockbits))
 				break;
 		}
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 1773dd7ea7cf..aba830e0827d 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -361,7 +361,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
  * fscrypt_mergeable_bio() - test whether data can be added to a bio
  * @bio: the bio being built up
  * @inode: the inode for the next part of the I/O
- * @next_lblk: the next file logical block number in the I/O
+ * @pos: the next file logical offset (in bytes) in the I/O
  *
  * When building a bio which may contain data which should undergo inline
  * encryption (or decryption) via fscrypt, filesystems should call this function
@@ -379,7 +379,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
  * Return: true iff the I/O is mergeable
  */
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
-			   u64 next_lblk)
+			   loff_t pos)
 {
 	const struct bio_crypt_ctx *bc = bio->bi_crypt_context;
 	const struct fscrypt_inode_info *ci;
@@ -399,7 +399,7 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	if (bc->bc_key != ci->ci_enc_key.blk_key)
 		return false;
 
-	fscrypt_generate_dun(ci, next_lblk << inode->i_blkbits, next_dun);
+	fscrypt_generate_dun(ci, pos, next_dun);
 	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
@@ -423,7 +423,8 @@ bool fscrypt_mergeable_bio_bh(struct bio *bio,
 	if (!bh_get_inode_and_lblk_num(next_bh, &inode, &next_lblk))
 		return !bio->bi_crypt_context;
 
-	return fscrypt_mergeable_bio(bio, inode, next_lblk);
+	return fscrypt_mergeable_bio(bio, inode,
+		(loff_t)next_lblk << inode->i_blkbits);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index f329daf6e5c7..371f34a14084 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -346,7 +346,8 @@ int ext4_mpage_readpages(struct inode *inode,
 		 * BIO off first?
 		 */
 		if (bio && (last_block_in_bio != first_block - 1 ||
-			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
+			    !fscrypt_mergeable_bio(bio, inode,
+				(loff_t)next_block << blkbits))) {
 		submit_and_realloc:
 			submit_bio(bio);
 			bio = NULL;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 775aa4f63aa3..dd3c98fbe6b5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -503,7 +503,8 @@ static bool f2fs_crypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	if (fio && fio->encrypted_page)
 		return !bio_has_crypt_ctx(bio);
 
-	return fscrypt_mergeable_bio(bio, inode, next_idx);
+	return fscrypt_mergeable_bio(bio, inode,
+			(loff_t)next_idx << inode->i_blkbits);
 }
 
 void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 516aba5b858b..5f2e02a61401 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -874,7 +874,7 @@ void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
 				  gfp_t gfp_mask);
 
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
-			   u64 next_lblk);
+			   loff_t pos);
 
 bool fscrypt_mergeable_bio_bh(struct bio *bio,
 			      const struct buffer_head *next_bh);
@@ -901,7 +901,7 @@ static inline void fscrypt_set_bio_crypt_ctx_bh(
 
 static inline bool fscrypt_mergeable_bio(struct bio *bio,
 					 const struct inode *inode,
-					 u64 next_lblk)
+					 loff_t pos)
 {
 	return true;
 }
-- 
2.47.3


