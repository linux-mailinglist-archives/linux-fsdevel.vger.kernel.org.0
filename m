Return-Path: <linux-fsdevel+bounces-57208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363AB1F913
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C757F3BD67E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D03242D62;
	Sun, 10 Aug 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1YmITnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E723B610;
	Sun, 10 Aug 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812808; cv=none; b=cG14ntLLKGN5x0WQzOLaGjMqV+1BLUsnnKfSPwubnTi+oNa0sZh7hmkos9QTMzlkE7wTFBFdlz+FL/kVp/W/qpCep4zfUXCzZBUOMSiLhHvp8lQ304P38TQztrjmS+rWodGAoz02qDKXW7n4IWFC25nBqT8Ctc1xC1dGDI7SAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812808; c=relaxed/simple;
	bh=ogrPRs7G8yJ7ig6hN3bBPR4xal7BchcvqoEaGpf5IUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BInKnTyejcHTwzdnK4eIpJtfHhtIXr32URpQWs6BtM7s7rz+1ThIEs74HEIxHv8MBBPN+kQOVbuEd2xcU2iGGRccpCE17U/BEPyTInvkLsQnVTExTr2at3OLGKKL8ZJtPH4w1RcRS7vA1G3zIgH9ZqDhPdZl8j7grMvhiJkFB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1YmITnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6BCC4CEF9;
	Sun, 10 Aug 2025 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812808;
	bh=ogrPRs7G8yJ7ig6hN3bBPR4xal7BchcvqoEaGpf5IUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q1YmITnlvaUyFNILQ9X6zKvnnJFYBQMzjjrSzIQnyhUY75fRncZJvRAdxol91udiy
	 w37urZcJ7FyOFVRrTXWwLPbh/n7aubfjoQvS4xABWoW0bcdmXOn5AQdtEgpkihqiMd
	 PtbmWiIqTXVjb3aI7kvSH6OAwiIzdLi3zw/jZPpN2x8UHp0WgwX6w9wyik2QOk6ndb
	 P9JyeU137aToIcR8T/QsP5eW1aRVM3CiW8OEm0dYWxgCwG2/fhO+QrNJeVWxtEZ6F+
	 KqiZgi2Y6Hb3SLfdwzPz/e0u+gCVe/djINSJ0Kuaf/aMXeZwyZ4v7Uc488OzI2JmqD
	 IZclhf1nQlgww==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v5 01/13] fscrypt: replace raw loads of info pointer with helper function
Date: Sun, 10 Aug 2025 00:56:54 -0700
Message-ID: <20250810075706.172910-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810075706.172910-1-ebiggers@kernel.org>
References: <20250810075706.172910-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add and use a helper function fscrypt_get_inode_info_raw().  It loads an
inode's fscrypt info pointer using a raw dereference, which is
appropriate when the caller knows the key setup already happened.

This eliminates most occurrences of inode::i_crypt_info in the source,
in preparation for replacing that with a filesystem-specific field.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/crypto/bio.c          |  2 +-
 fs/crypto/crypto.c       | 14 ++++++++------
 fs/crypto/fname.c        | 11 ++++++-----
 fs/crypto/hooks.c        |  2 +-
 fs/crypto/inline_crypt.c | 12 +++++++-----
 fs/crypto/policy.c       |  7 ++++---
 include/linux/fscrypt.h  | 16 ++++++++++++++++
 7 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 486fcb2ecf13e..0d746de4cd103 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -111,11 +111,11 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
  * Return: 0 on success; -errno on failure.
  */
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			  sector_t pblk, unsigned int len)
 {
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
 	const unsigned int du_size = 1U << du_bits;
 	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
 	const unsigned int du_per_page = 1U << du_per_page_bits;
 	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index b6ccab524fdef..07f9cbfe3ea41 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -171,11 +171,11 @@ int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
  */
 struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
 		size_t len, size_t offs, gfp_t gfp_flags)
 {
 	const struct inode *inode = folio->mapping->host;
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
 	const unsigned int du_size = 1U << du_bits;
 	struct page *ciphertext_page;
 	u64 index = ((u64)folio->index << (PAGE_SHIFT - du_bits)) +
 		    (offs >> du_bits);
@@ -230,12 +230,13 @@ int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
 				  u64 lblk_num)
 {
 	if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units))
 		return -EOPNOTSUPP;
-	return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_ENCRYPT,
-				       lblk_num, page, page, len, offs);
+	return fscrypt_crypt_data_unit(fscrypt_get_inode_info_raw(inode),
+				       FS_ENCRYPT, lblk_num, page, page, len,
+				       offs);
 }
 EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
 
 /**
  * fscrypt_decrypt_pagecache_blocks() - Decrypt data from a pagecache folio
@@ -253,11 +254,11 @@ EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
  */
 int fscrypt_decrypt_pagecache_blocks(struct folio *folio, size_t len,
 				     size_t offs)
 {
 	const struct inode *inode = folio->mapping->host;
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
 	const unsigned int du_size = 1U << du_bits;
 	u64 index = ((u64)folio->index << (PAGE_SHIFT - du_bits)) +
 		    (offs >> du_bits);
 	size_t i;
@@ -303,12 +304,13 @@ int fscrypt_decrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
 				  u64 lblk_num)
 {
 	if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units))
 		return -EOPNOTSUPP;
-	return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_DECRYPT,
-				       lblk_num, page, page, len, offs);
+	return fscrypt_crypt_data_unit(fscrypt_get_inode_info_raw(inode),
+				       FS_DECRYPT, lblk_num, page, page, len,
+				       offs);
 }
 EXPORT_SYMBOL(fscrypt_decrypt_block_inplace);
 
 /**
  * fscrypt_initialize() - allocate major buffers for fs encryption.
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index f9f6713e144f7..fb77ad1ca74a2 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -92,11 +92,11 @@ static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
  * Return: 0 on success, -errno on failure
  */
 int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 			  u8 *out, unsigned int olen)
 {
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	struct crypto_sync_skcipher *tfm = ci->ci_enc_key.tfm;
 	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
 	union fscrypt_iv iv;
 	struct scatterlist sg;
 	int err;
@@ -136,11 +136,11 @@ EXPORT_SYMBOL_GPL(fscrypt_fname_encrypt);
  */
 static int fname_decrypt(const struct inode *inode,
 			 const struct fscrypt_str *iname,
 			 struct fscrypt_str *oname)
 {
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 	struct crypto_sync_skcipher *tfm = ci->ci_enc_key.tfm;
 	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
 	union fscrypt_iv iv;
 	struct scatterlist src_sg, dst_sg;
 	int err;
@@ -272,12 +272,13 @@ bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
  *	   fill out encrypted_len_ret with the length (up to max_len).
  */
 bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
 				  u32 max_len, u32 *encrypted_len_ret)
 {
-	return __fscrypt_fname_encrypted_size(&inode->i_crypt_info->ci_policy,
-					      orig_len, max_len,
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
+
+	return __fscrypt_fname_encrypted_size(&ci->ci_policy, orig_len, max_len,
 					      encrypted_len_ret);
 }
 EXPORT_SYMBOL_GPL(fscrypt_fname_encrypted_size);
 
 /**
@@ -541,11 +542,11 @@ EXPORT_SYMBOL_GPL(fscrypt_match_name);
  *
  * Return: the SipHash of @name using the hash key of @dir
  */
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name)
 {
-	const struct fscrypt_inode_info *ci = dir->i_crypt_info;
+	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(dir);
 
 	WARN_ON_ONCE(!ci->ci_dirhash_key_initialized);
 
 	return siphash(name->name, name->len, &ci->ci_dirhash_key);
 }
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index e0b32ac841f76..7a5d4c168c49e 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -197,11 +197,11 @@ int fscrypt_prepare_setflags(struct inode *inode,
 	 */
 	if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL)) {
 		err = fscrypt_require_key(inode);
 		if (err)
 			return err;
-		ci = inode->i_crypt_info;
+		ci = fscrypt_get_inode_info_raw(inode);
 		if (ci->ci_policy.version != FSCRYPT_POLICY_V2)
 			return -EINVAL;
 		mk = ci->ci_master_key;
 		down_read(&mk->mk_sem);
 		if (mk->mk_present)
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index caaff809765b2..5dee7c498bc8c 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -261,11 +261,11 @@ int fscrypt_derive_sw_secret(struct super_block *sb,
 	return err;
 }
 
 bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 {
-	return inode->i_crypt_info->ci_inlinecrypt;
+	return fscrypt_get_inode_info_raw(inode)->ci_inlinecrypt;
 }
 EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);
 
 static void fscrypt_generate_dun(const struct fscrypt_inode_info *ci,
 				 u64 lblk_num,
@@ -305,11 +305,11 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 	const struct fscrypt_inode_info *ci;
 	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 
 	if (!fscrypt_inode_uses_inline_crypto(inode))
 		return;
-	ci = inode->i_crypt_info;
+	ci = fscrypt_get_inode_info_raw(inode);
 
 	fscrypt_generate_dun(ci, first_lblk, dun);
 	bio_crypt_set_ctx(bio, ci->ci_enc_key.blk_key, dun, gfp_mask);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
@@ -383,26 +383,28 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
  */
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 			   u64 next_lblk)
 {
 	const struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+	const struct fscrypt_inode_info *ci;
 	u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 
 	if (!!bc != fscrypt_inode_uses_inline_crypto(inode))
 		return false;
 	if (!bc)
 		return true;
+	ci = fscrypt_get_inode_info_raw(inode);
 
 	/*
 	 * Comparing the key pointers is good enough, as all I/O for each key
 	 * uses the same pointer.  I.e., there's currently no need to support
 	 * merging requests where the keys are the same but the pointers differ.
 	 */
-	if (bc->bc_key != inode->i_crypt_info->ci_enc_key.blk_key)
+	if (bc->bc_key != ci->ci_enc_key.blk_key)
 		return false;
 
-	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
+	fscrypt_generate_dun(ci, next_lblk, next_dun);
 	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
 
 /**
@@ -500,11 +502,11 @@ u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 		return nr_blocks;
 
 	if (nr_blocks <= 1)
 		return nr_blocks;
 
-	ci = inode->i_crypt_info;
+	ci = fscrypt_get_inode_info_raw(inode);
 	if (!(fscrypt_policy_flags(&ci->ci_policy) &
 	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
 		return nr_blocks;
 
 	/* With IV_INO_LBLK_32, the DUN can wrap around from U32_MAX to 0. */
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 6ad30ae07c065..9d51f3500de37 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -725,11 +725,11 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
 
 	if (IS_ENCRYPTED(dir)) {
 		err = fscrypt_require_key(dir);
 		if (err)
 			return ERR_PTR(err);
-		return &dir->i_crypt_info->ci_policy;
+		return &fscrypt_get_inode_info_raw(dir)->ci_policy;
 	}
 
 	return fscrypt_get_dummy_policy(dir->i_sb);
 }
 
@@ -744,11 +744,11 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
  *
  * Return: size of the resulting context or a negative error code.
  */
 int fscrypt_context_for_new_inode(void *ctx, struct inode *inode)
 {
-	struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
 
 	BUILD_BUG_ON(sizeof(union fscrypt_context) !=
 			FSCRYPT_SET_CONTEXT_MAX_SIZE);
 
 	/* fscrypt_prepare_new_inode() should have set up the key already. */
@@ -769,11 +769,11 @@ EXPORT_SYMBOL_GPL(fscrypt_context_for_new_inode);
  *
  * Return: 0 on success, -errno on failure
  */
 int fscrypt_set_context(struct inode *inode, void *fs_data)
 {
-	struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	struct fscrypt_inode_info *ci;
 	union fscrypt_context ctx;
 	int ctxsize;
 
 	ctxsize = fscrypt_context_for_new_inode(&ctx, inode);
 	if (ctxsize < 0)
@@ -781,10 +781,11 @@ int fscrypt_set_context(struct inode *inode, void *fs_data)
 
 	/*
 	 * This may be the first time the inode number is available, so do any
 	 * delayed key setup that requires the inode number.
 	 */
+	ci = fscrypt_get_inode_info_raw(inode);
 	if (ci->ci_policy.version == FSCRYPT_POLICY_V2 &&
 	    (ci->ci_policy.v2.flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
 		fscrypt_hash_inode_number(ci, ci->ci_master_key);
 
 	return inode->i_sb->s_cop->set_context(inode, &ctx, ctxsize, fs_data);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 10dd161690a28..23c5198612d1a 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -193,10 +193,26 @@ struct fscrypt_operations {
 };
 
 int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
 			 struct dentry *dentry, unsigned int flags);
 
+/*
+ * Load the inode's fscrypt info pointer, using a raw dereference.  Since this
+ * uses a raw dereference with no memory barrier, it is appropriate to use only
+ * when the caller knows the inode's key setup already happened, resulting in
+ * non-NULL fscrypt info.  E.g., the file contents en/decryption functions use
+ * this, since fscrypt_file_open() set up the key.
+ */
+static inline struct fscrypt_inode_info *
+fscrypt_get_inode_info_raw(const struct inode *inode)
+{
+	struct fscrypt_inode_info *ci = inode->i_crypt_info;
+
+	VFS_WARN_ON_ONCE(ci == NULL);
+	return ci;
+}
+
 static inline struct fscrypt_inode_info *
 fscrypt_get_inode_info(const struct inode *inode)
 {
 	/*
 	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
-- 
2.50.1


