Return-Path: <linux-fsdevel+bounces-68890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14DC67B73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 158E4366701
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612652E6CDE;
	Tue, 18 Nov 2025 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3y/HK/UN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF8231A32;
	Tue, 18 Nov 2025 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763446945; cv=none; b=doZrbv99Nk4HOvh4rFWKGo1eRhFoudNfs93Anen2JlZTxdcQ8lOiHU4Ds4txbW6icIu7TxcOgRWMGSxO6wIVVK3LABqzbpMwMZyso9xLakCME+PXnzNtLQ35h0uLZyI9ay4tsDxulq+bjljxYTwJUq7fOhMvx0FsDs5EpOhjApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763446945; c=relaxed/simple;
	bh=XxF+zO7fOAwbgNNxYcy2IDvY4wgVYWlmULcrL5CYZ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwOI0yLYv8PON7+dN+lDZHo91Fx2LeH3huLdtBgyFs1Jrf2uo8+wSIeVWpYtNv88ZeFHzrM6DsRITalBx6bjVfVMthHgkAlvTW0m3t70AvUSkwJ7dPPrOOphICMInZgKGrQ2C49Q/5UtJrbNur06FFVn1Ruz3wEBJCgTevS/D3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3y/HK/UN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=i6+fGKzHN3lDbRkojfVRWpWl5kuHKUdtJvBCaJ8GUS8=; b=3y/HK/UNEdCM1bwfjg6RKHP3RO
	uf876hLPwGoAnL74opaeFjsY3zqSM9epO3KTWP5I6Za2h33Ysst3d2W2Oxd0kGE7e/GZS1xJ/qrWE
	Bc6C8srmr5dyMYOSTGjuJTA+YD5btEIg5ObI7l5e3WCwIs3COrhfJJyULjTuB705dEAURIVNH1fTP
	PbxmxeK40VLfIzc97pjXHY9sxjs4ojK4p7MZbGEPhLYWK1f9078/Ow/0S1WJzFYBLtMc4PJpsNTW4
	1q5c8/4uTFy83fXMemiX98RxyAih1jQChMGXr/uMFm9eBx1NhVq8X6pRdazFLwPWFQwhbtrryj/fL
	KFsW/lkg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLF6d-0000000HUOn-25mJ;
	Tue, 18 Nov 2025 06:22:23 +0000
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
Subject: [PATCH 03/11] fscrypt: pass a byte offset to fscrypt_generate_dun
Date: Tue, 18 Nov 2025 07:21:46 +0100
Message-ID: <20251118062159.2358085-4-hch@lst.de>
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
Switch fscrypt_generate_dun to that convention and remove the
ci_data_units_per_block_bits member in struct fscrypt_inode_info that
was only used to cache the DUN shift based on the logical block size
granularity.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/fscrypt_private.h |  3 ---
 fs/crypto/inline_crypt.c    | 10 ++++------
 fs/crypto/keysetup.c        |  2 --
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 4e8e82a9ccf9..8d3c278a7591 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -278,9 +278,6 @@ struct fscrypt_inode_info {
 	 */
 	u8 ci_data_unit_bits;
 
-	/* Cached value: log2 of number of data units per FS block */
-	u8 ci_data_units_per_block_bits;
-
 	/* Hashed inode number.  Only set for IV_INO_LBLK_32 */
 	u32 ci_hashed_ino;
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index ed6e926226b5..1773dd7ea7cf 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -268,14 +268,12 @@ bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);
 
 static void fscrypt_generate_dun(const struct fscrypt_inode_info *ci,
-				 u64 lblk_num,
-				 u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
+				 loff_t pos, u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
 {
-	u64 index = lblk_num << ci->ci_data_units_per_block_bits;
 	union fscrypt_iv iv;
 	int i;
 
-	fscrypt_generate_iv(&iv, index, ci);
+	fscrypt_generate_iv(&iv, pos >> ci->ci_data_unit_bits, ci);
 
 	BUILD_BUG_ON(FSCRYPT_MAX_IV_SIZE > BLK_CRYPTO_MAX_IV_SIZE);
 	memset(dun, 0, BLK_CRYPTO_MAX_IV_SIZE);
@@ -309,7 +307,7 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 		return;
 	ci = fscrypt_get_inode_info_raw(inode);
 
-	fscrypt_generate_dun(ci, first_lblk, dun);
+	fscrypt_generate_dun(ci, first_lblk << inode->i_blkbits, dun);
 	bio_crypt_set_ctx(bio, ci->ci_enc_key.blk_key, dun, gfp_mask);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
@@ -401,7 +399,7 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	if (bc->bc_key != ci->ci_enc_key.blk_key)
 		return false;
 
-	fscrypt_generate_dun(ci, next_lblk, next_dun);
+	fscrypt_generate_dun(ci, next_lblk << inode->i_blkbits, next_dun);
 	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 4bd3918f50e3..f8a96d729dfc 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -609,8 +609,6 @@ fscrypt_setup_encryption_info(struct inode *inode,
 
 	crypt_info->ci_data_unit_bits =
 		fscrypt_policy_du_bits(&crypt_info->ci_policy, inode);
-	crypt_info->ci_data_units_per_block_bits =
-		inode->i_blkbits - crypt_info->ci_data_unit_bits;
 
 	res = setup_file_encryption_key(crypt_info, need_dirhash_key, &mk);
 	if (res)
-- 
2.47.3


