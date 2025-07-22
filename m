Return-Path: <linux-fsdevel+bounces-55728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23561B0E42A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4ADA5814B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BCB28505E;
	Tue, 22 Jul 2025 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1xJWPxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC72836BF;
	Tue, 22 Jul 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212478; cv=none; b=FlavKtljGuiKZyZC679U61PsBZBR6WlhilH2suVpqRYueDnYhriq6grJ2SoWbitD6LBRtcF97ZCxNUefjzwNVyfusED2MjjyaDGIH/mF8LulmtHRJwhkHULUB5xgIlxWZT6wGjmO65xMDwn/hHRM/W8J5mK8seIxkzs8rQoghmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212478; c=relaxed/simple;
	bh=DWq67MKVwZeH+EfZGWXxPEcgWVJ0S1OXm3vCyOFCFz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrlwTonQXYnmeI0SO8Yatq75HuReOFLdMKtZEh5wRmFukMuXfWvfM/co7IvDT1fP4Zj0FBD111OYZBnJY6t2IUFsp8IGg/znuzXB3UlBeNA/5yxlZJGMDmhNwZsRZT6Dw2SQ/jUByn9E41GhUUF617EjwU9s+Wq65v2BqZCCYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1xJWPxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7CCC4CEEB;
	Tue, 22 Jul 2025 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212478;
	bh=DWq67MKVwZeH+EfZGWXxPEcgWVJ0S1OXm3vCyOFCFz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1xJWPxjPekxWtUgR3RCnSW6qckRXrbVZ4f1WGkTkYhlEcx0jsS3NO/jq0s5RI2Xo
	 MIsjWdqQR36rp9BkfaLgUor4dJnVJfesT1RXGfGC7BR1gROM2j5OE3R3n9fwFnRXIP
	 beykH7JlbwHr6SHyRCmDQOhKP+RTS/IyIz65YJtd3U1u3Pas6RoX3sCKWnThVaIlG2
	 HljzXNVlf5uyY4ltApsz1siplrLPNH/EH6PRRnNmI/LlycwGTI/KT8nnrpDuaRIyTY
	 PieV23VKWmknSOWRqAPNyFVJWBjBHy40JJtzGLRxCD19IBBuPG5sUh75buulhDc3Zt
	 m/QWRNR9LPgdg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v3 02/13] fs/crypto: use accessors
Date: Tue, 22 Jul 2025 21:27:20 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-2-bdc1033420a0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=11372; i=brauner@kernel.org; h=from:subject:message-id; bh=DWq67MKVwZeH+EfZGWXxPEcgWVJ0S1OXm3vCyOFCFz8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5NpcgtoNQrz0NNsEXkabHOfMfGGwPzKM1PDczJjK mer/4jpKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEhoPMMf7ruNdgvkZTOr3U7G nBGPW7Znc0Fpc+TJdwuvrlLtvPhTk5HhlND/XZ/n/jxhY20od8LCaoKzxHRv8zl5Fi8nXm4+8KW YBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Use accessor to get and set the fscrypt info from the filesystem.
They can be removed once all filesystems have been converted to make
room for fscrypt info in their own inodes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/crypto/bio.c          |  2 +-
 fs/crypto/crypto.c       |  8 ++++----
 fs/crypto/fname.c        |  8 ++++----
 fs/crypto/hooks.c        |  2 +-
 fs/crypto/inline_crypt.c | 10 +++++-----
 fs/crypto/keysetup.c     | 12 +++++++++---
 fs/crypto/policy.c       |  6 +++---
 include/linux/fscrypt.h  | 36 ++++++++++++++++++++++++++++++++++++
 8 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 0ad8c30b8fa5..73e46d2af511 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -111,7 +111,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			  sector_t pblk, unsigned int len)
 {
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
 	const unsigned int du_size = 1U << du_bits;
 	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index b74b5937e695..c27ea8baaf52 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -181,7 +181,7 @@ struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
 		size_t len, size_t offs, gfp_t gfp_flags)
 {
 	const struct inode *inode = folio->mapping->host;
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
 	const unsigned int du_size = 1U << du_bits;
 	struct page *ciphertext_page;
@@ -241,7 +241,7 @@ int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
 {
 	if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units))
 		return -EOPNOTSUPP;
-	return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_ENCRYPT,
+	return fscrypt_crypt_data_unit(fscrypt_get_inode_info_raw(inode), FS_ENCRYPT,
 				       lblk_num, page, page, len, offs,
 				       gfp_flags);
 }
@@ -265,7 +265,7 @@ int fscrypt_decrypt_pagecache_blocks(struct folio *folio, size_t len,
 				     size_t offs)
 {
 	const struct inode *inode = folio->mapping->host;
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
 	const unsigned int du_size = 1U << du_bits;
 	u64 index = ((u64)folio->index << (PAGE_SHIFT - du_bits)) +
@@ -316,7 +316,7 @@ int fscrypt_decrypt_block_inplace(const struct inode *inode, struct page *page,
 {
 	if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units))
 		return -EOPNOTSUPP;
-	return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_DECRYPT,
+	return fscrypt_crypt_data_unit(fscrypt_get_inode_info_raw(inode), FS_DECRYPT,
 				       lblk_num, page, page, len, offs,
 				       GFP_NOFS);
 }
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 010f9c0a4c2f..674b5fb11ac1 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -94,7 +94,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 {
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	union fscrypt_iv iv;
 	struct scatterlist sg;
@@ -151,7 +151,7 @@ static int fname_decrypt(const struct inode *inode,
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist src_sg, dst_sg;
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	union fscrypt_iv iv;
 	int res;
@@ -293,7 +293,7 @@ bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
 				  u32 max_len, u32 *encrypted_len_ret)
 {
-	return __fscrypt_fname_encrypted_size(&inode->i_crypt_info->ci_policy,
+	return __fscrypt_fname_encrypted_size(&fscrypt_get_inode_info_raw(inode)->ci_policy,
 					      orig_len, max_len,
 					      encrypted_len_ret);
 }
@@ -562,7 +562,7 @@ EXPORT_SYMBOL_GPL(fscrypt_match_name);
  */
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name)
 {
-	const struct fscrypt_inode_info *ci = dir->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(dir);
 
 	WARN_ON_ONCE(!ci->ci_dirhash_key_initialized);
 
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index d8d5049b8fe1..61bbe7d46df4 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -197,7 +197,7 @@ int fscrypt_prepare_setflags(struct inode *inode,
 		err = fscrypt_require_key(inode);
 		if (err)
 			return err;
-		ci = inode->i_crypt_info;
+		ci = fscrypt_get_inode_info_raw(inode);
 		if (ci->ci_policy.version != FSCRYPT_POLICY_V2)
 			return -EINVAL;
 		mk = ci->ci_master_key;
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 1d008c440cb6..6c2784b8e67a 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -262,7 +262,7 @@ int fscrypt_derive_sw_secret(struct super_block *sb,
 
 bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 {
-	return inode->i_crypt_info->ci_inlinecrypt;
+	return fscrypt_get_inode_info_raw(inode)->ci_inlinecrypt;
 }
 EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);
 
@@ -306,7 +306,7 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 
 	if (!fscrypt_inode_uses_inline_crypto(inode))
 		return;
-	ci = inode->i_crypt_info;
+	ci = fscrypt_get_inode_info_raw(inode);
 
 	fscrypt_generate_dun(ci, first_lblk, dun);
 	bio_crypt_set_ctx(bio, ci->ci_enc_key.blk_key, dun, gfp_mask);
@@ -396,10 +396,10 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	 * uses the same pointer.  I.e., there's currently no need to support
 	 * merging requests where the keys are the same but the pointers differ.
 	 */
-	if (bc->bc_key != inode->i_crypt_info->ci_enc_key.blk_key)
+	if (bc->bc_key != fscrypt_get_inode_info_raw(inode)->ci_enc_key.blk_key)
 		return false;
 
-	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
+	fscrypt_generate_dun(fscrypt_get_inode_info_raw(inode), next_lblk, next_dun);
 	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
@@ -501,7 +501,7 @@ u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 	if (nr_blocks <= 1)
 		return nr_blocks;
 
-	ci = inode->i_crypt_info;
+	ci = fscrypt_get_inode_info_raw(inode);
 	if (!(fscrypt_policy_flags(&ci->ci_policy) &
 	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
 		return nr_blocks;
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 0d71843af946..0f0ebe819783 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -644,7 +644,7 @@ fscrypt_setup_encryption_info(struct inode *inode,
 	 * fscrypt_get_inode_info().  I.e., here we publish ->i_crypt_info with
 	 * a RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
-	if (cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info) == NULL) {
+	if (fscrypt_set_inode_info(inode, crypt_info)) {
 		/*
 		 * We won the race and set ->i_crypt_info to our crypt_info.
 		 * Now link it into the master key's inode list.
@@ -797,8 +797,14 @@ EXPORT_SYMBOL_GPL(fscrypt_prepare_new_inode);
  */
 void fscrypt_put_encryption_info(struct inode *inode)
 {
-	put_crypt_info(inode->i_crypt_info);
-	inode->i_crypt_info = NULL;
+	struct fscrypt_inode_info **crypt_info;
+
+	if (inode->i_sb->s_op->i_fscrypt)
+		crypt_info = fscrypt_addr(inode);
+	else
+		crypt_info = &inode->i_crypt_info;
+	put_crypt_info(*crypt_info);
+	*crypt_info = NULL;
 }
 EXPORT_SYMBOL(fscrypt_put_encryption_info);
 
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 701259991277..d9fb2898a14a 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -725,7 +725,7 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
 		err = fscrypt_require_key(dir);
 		if (err)
 			return ERR_PTR(err);
-		return &dir->i_crypt_info->ci_policy;
+		return &fscrypt_get_inode_info_raw(dir)->ci_policy;
 	}
 
 	return fscrypt_get_dummy_policy(dir->i_sb);
@@ -744,7 +744,7 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
  */
 int fscrypt_context_for_new_inode(void *ctx, struct inode *inode)
 {
-	struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 
 	BUILD_BUG_ON(sizeof(union fscrypt_context) !=
 			FSCRYPT_SET_CONTEXT_MAX_SIZE);
@@ -769,7 +769,7 @@ EXPORT_SYMBOL_GPL(fscrypt_context_for_new_inode);
  */
 int fscrypt_set_context(struct inode *inode, void *fs_data)
 {
-	struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	union fscrypt_context ctx;
 	int ctxsize;
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 56fad33043d5..685780ce3579 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -195,6 +195,38 @@ struct fscrypt_operations {
 int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
 			 struct dentry *dentry, unsigned int flags);
 
+static inline struct fscrypt_inode_info **fscrypt_addr(const struct inode *inode)
+{
+	return ((void *)inode + inode->i_sb->s_op->i_fscrypt);
+}
+
+static inline bool fscrypt_set_inode_info(struct inode *inode,
+					  struct fscrypt_inode_info *crypt_info)
+{
+	void *p;
+
+	/*
+	 * For existing inodes, multiple tasks may race to set ->i_crypt_info.
+	 * So use cmpxchg_release().  This pairs with the smp_load_acquire() in
+	 * fscrypt_get_inode_info().  I.e., here we publish ->i_crypt_info with
+	 * a RELEASE barrier so that other tasks can ACQUIRE it.
+	 */
+
+	if (inode->i_sb->s_op->i_fscrypt)
+		p = cmpxchg_release(fscrypt_addr(inode), NULL, crypt_info);
+	else
+		p = cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info);
+	return p == NULL;
+}
+
+static inline struct fscrypt_inode_info *
+fscrypt_get_inode_info_raw(const struct inode *inode)
+{
+	if (inode->i_sb->s_op->i_fscrypt)
+		return *fscrypt_addr(inode);
+	return inode->i_crypt_info;
+}
+
 static inline struct fscrypt_inode_info *
 fscrypt_get_inode_info(const struct inode *inode)
 {
@@ -204,6 +236,10 @@ fscrypt_get_inode_info(const struct inode *inode)
 	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
 	 * ACQUIRE the memory the other task published.
 	 */
+
+	if (inode->i_sb->s_op->i_fscrypt)
+		return smp_load_acquire(fscrypt_addr(inode));
+
 	return smp_load_acquire(&inode->i_crypt_info);
 }
 

-- 
2.47.2


