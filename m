Return-Path: <linux-fsdevel+bounces-54985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE8B061D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9515A7577
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF119CCF5;
	Tue, 15 Jul 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgBuWJhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341CA1922C0
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590138; cv=none; b=U7IRTVDOdzNmUxU9oxxXZTOf3AiF/T79ZwwL9UovASD20d2TfUaoBSw9r1GJjnNP7ZJWd2E3mwF5kPKD2SgdWNy+s09hz+v4wOM9xTdnHwrYgcIjNDlUMDDzz1S1W1K0acjaMWwQVEtfoZYV2M5EnDmDAt3sjwoHEP3VV3coM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590138; c=relaxed/simple;
	bh=XHbkHMyjy6BHswJAsDanjO1JkBUBx53mBhOjdORP/z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=neYmwfQb/NHJSUM3ufG1dbF1Qc0BJrpvivZ/guum07uZRc/qyxKtUT3DYy2ekeLZGLTiPsKaEeNzy2k7T/7XLqfSPWkSLEq/Px+XT3ef5++gTaSeJdp5EpCRKM5pYlfLlLzXdT1K6q6X3tmupAW4N997Q1uriatDCx/DsFt8RUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgBuWJhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF463C4CEF1;
	Tue, 15 Jul 2025 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590137;
	bh=XHbkHMyjy6BHswJAsDanjO1JkBUBx53mBhOjdORP/z8=;
	h=From:Date:Subject:To:Cc:From;
	b=sgBuWJhyXkxwnnTO+2o2vzd7HHa001JV+bm62GPJiusbcN15sWvIfWHccj2rpQTHg
	 DedzONQsGCxlcTPrKycrvVMDSgGOTEcR4Jj2+xeP2vzya2rv+SFwlvILA5IipWLpdm
	 ibOFTxmpP7bH9QMx7q4Dpxz2JweUnlWGnfNzn2TB/OZPM/oa5jS9LafTyLOLlZa7te
	 fAa57FOTbOHLX5GhJo+K4jVFLO4X2SyuGcaZfRLB7TL3l5xwpqWNgYjv2hj9f/Bxqx
	 WNFjq8yd+j4LvRgedHAHstJtfMeQ5Kgt3P8g/hCg+lQLOP/YOfzcd2GhwqYp2Bbt/V
	 XXmzrlnyUdesA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Jul 2025 16:35:24 +0200
Subject: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
X-B4-Tracking: v=1; b=H4sIACtndmgC/x2N0QqCMBiFX0X+6yZu4qTuKhOCSDC7ii62+Zsjm
 rKJFeG7N7073wfnnB84tBodbIIfWBy1053xQFcBqFaYBxJdewYWsSRKaULenX0SbboaSeOU/fY
 DYZLHkqUc03UMvthbbPRnGb1Bme9nl5XbvFpCcbici2p3PZ4yuHshhUMirTCqnY9ewg1ow5GHl
 BOrKEzTH01RqTSlAAAA
X-Change-ID: 20250715-work-inode-fscrypt-2b63b276e793
To: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=22045; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XHbkHMyjy6BHswJAsDanjO1JkBUBx53mBhOjdORP/z8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUpZurRDmxC4ps28H6+ue9oIhf+2TnqE7XWf538j7bF
 +/rbzc97ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIiw8jw9XbOku2r92cq7z7
 YtFja8+Q9b+6Hgk0S3UeavwUZX8iSpORYe2khUH1zHEC3860pMTri3wuuPdXP2KNRfbWzEKHQ1p
 XOAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

struct inode is bloated as everyone is aware and we should try and
shrink it as that's potentially a lot of memory savings. I've already
freed up around 8 bytes but we can probably do better.

There's a bunch of stuff that got shoved into struct inode that I don't
think deserves a spot in there. There are two members I'm currently
particularly interested in:

(1) #ifdef CONFIG_FS_ENCRYPTION
            struct fscrypt_inode_info *i_crypt_info;
    #endif

    ceph, ext4, f2fs, ubifs

(2) #ifdef CONFIG_FS_VERITY
            struct fsverity_info *i_verity_info;
    #endif

    btrfs, ext4, f2fs

So we have 4 users for fscrypt and 3 users for fsverity with both
features having been around for a decent amount of time.

For all other filesystems the 16 bytes are just wasted bloating inodes
for every pseudo filesystem and most other regular filesystems.

We should be able to move both of these out of struct inode by adding
inode operations and making it the filesystem's responsibility to
accommodate the information in their respective inodes.

Unless there are severe performance penalties for the extra pointer
dereferences getting our hands on 16 bytes is a good reason to at least
consider doing this.

I've drafted one way of doing this using ext4 as my victim^wexample. I'd
like to hear some early feedback whether this is something we would want
to pursue.

Build failures very much expected!

Not-Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/crypto/bio.c             |  2 +-
 fs/crypto/crypto.c          |  8 ++++----
 fs/crypto/fname.c           |  8 ++++----
 fs/crypto/fscrypt_private.h |  3 +--
 fs/crypto/hooks.c           |  2 +-
 fs/crypto/inline_crypt.c    | 10 +++++-----
 fs/crypto/keysetup.c        | 21 ++++----------------
 fs/crypto/policy.c          |  8 ++++----
 fs/ext4/ext4.h              |  9 +++++++++
 fs/ext4/file.c              |  4 ++++
 fs/ext4/namei.c             | 22 +++++++++++++++++++++
 fs/ext4/super.c             |  6 +++++-
 fs/ext4/symlink.c           | 12 ++++++++++++
 include/linux/fs.h          |  9 +++++----
 include/linux/fscrypt.h     | 47 ++++++++++++++++++++++++++++++---------------
 15 files changed, 112 insertions(+), 59 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 0ad8c30b8fa5..f541e6b3a9cc 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -111,7 +111,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			  sector_t pblk, unsigned int len)
 {
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = inode->i_op->get_fscrypt(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
 	const unsigned int du_size = 1U << du_bits;
 	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index b74b5937e695..c480f6867101 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -181,7 +181,7 @@ struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
 		size_t len, size_t offs, gfp_t gfp_flags)
 {
 	const struct inode *inode = folio->mapping->host;
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = inode->i_op->get_fscrypt(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
 	const unsigned int du_size = 1U << du_bits;
 	struct page *ciphertext_page;
@@ -241,7 +241,7 @@ int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
 {
 	if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units))
 		return -EOPNOTSUPP;
-	return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_ENCRYPT,
+	return fscrypt_crypt_data_unit(inode->i_op->get_fscrypt(inode), FS_ENCRYPT,
 				       lblk_num, page, page, len, offs,
 				       gfp_flags);
 }
@@ -265,7 +265,7 @@ int fscrypt_decrypt_pagecache_blocks(struct folio *folio, size_t len,
 				     size_t offs)
 {
 	const struct inode *inode = folio->mapping->host;
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = inode->i_op->get_fscrypt(inode);
 	const unsigned int du_bits = ci->ci_data_unit_bits;
 	const unsigned int du_size = 1U << du_bits;
 	u64 index = ((u64)folio->index << (PAGE_SHIFT - du_bits)) +
@@ -316,7 +316,7 @@ int fscrypt_decrypt_block_inplace(const struct inode *inode, struct page *page,
 {
 	if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units))
 		return -EOPNOTSUPP;
-	return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_DECRYPT,
+	return fscrypt_crypt_data_unit(inode->i_op->get_fscrypt(inode), FS_DECRYPT,
 				       lblk_num, page, page, len, offs,
 				       GFP_NOFS);
 }
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 010f9c0a4c2f..a0317df113a9 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -94,7 +94,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 {
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = inode->i_op->get_fscrypt(inode);
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	union fscrypt_iv iv;
 	struct scatterlist sg;
@@ -151,7 +151,7 @@ static int fname_decrypt(const struct inode *inode,
 	struct skcipher_request *req = NULL;
 	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist src_sg, dst_sg;
-	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_inode_info *ci = inode->i_op->get_fscrypt(inode);
 	struct crypto_skcipher *tfm = ci->ci_enc_key.tfm;
 	union fscrypt_iv iv;
 	int res;
@@ -293,7 +293,7 @@ bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
 				  u32 max_len, u32 *encrypted_len_ret)
 {
-	return __fscrypt_fname_encrypted_size(&inode->i_crypt_info->ci_policy,
+	return __fscrypt_fname_encrypted_size(&inode->i_op->get_fscrypt(inode)->ci_policy,
 					      orig_len, max_len,
 					      encrypted_len_ret);
 }
@@ -562,7 +562,7 @@ EXPORT_SYMBOL_GPL(fscrypt_match_name);
  */
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name)
 {
-	const struct fscrypt_inode_info *ci = dir->i_crypt_info;
+	const struct fscrypt_inode_info *ci = dir->i_op->get_fscrypt(dir);
 
 	WARN_ON_ONCE(!ci->ci_dirhash_key_initialized);
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index c1d92074b65c..ddc3c86494cf 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -231,8 +231,7 @@ struct fscrypt_prepared_key {
  * fscrypt_inode_info - the "encryption key" for an inode
  *
  * When an encrypted file's key is made available, an instance of this struct is
- * allocated and stored in ->i_crypt_info.  Once created, it remains until the
- * inode is evicted.
+ * allocated and stored.  Once created, it remains until the inode is evicted.
  */
 struct fscrypt_inode_info {
 
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index d8d5049b8fe1..a45763da352e 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -197,7 +197,7 @@ int fscrypt_prepare_setflags(struct inode *inode,
 		err = fscrypt_require_key(inode);
 		if (err)
 			return err;
-		ci = inode->i_crypt_info;
+		ci = inode->i_op->get_fscrypt(inode);
 		if (ci->ci_policy.version != FSCRYPT_POLICY_V2)
 			return -EINVAL;
 		mk = ci->ci_master_key;
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 1d008c440cb6..f5a6560a9c2e 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -262,7 +262,7 @@ int fscrypt_derive_sw_secret(struct super_block *sb,
 
 bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 {
-	return inode->i_crypt_info->ci_inlinecrypt;
+	return inode->i_op->get_fscrypt(inode)->ci_inlinecrypt;
 }
 EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);
 
@@ -306,7 +306,7 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 
 	if (!fscrypt_inode_uses_inline_crypto(inode))
 		return;
-	ci = inode->i_crypt_info;
+	ci = inode->i_op->get_fscrypt(inode);
 
 	fscrypt_generate_dun(ci, first_lblk, dun);
 	bio_crypt_set_ctx(bio, ci->ci_enc_key.blk_key, dun, gfp_mask);
@@ -396,10 +396,10 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	 * uses the same pointer.  I.e., there's currently no need to support
 	 * merging requests where the keys are the same but the pointers differ.
 	 */
-	if (bc->bc_key != inode->i_crypt_info->ci_enc_key.blk_key)
+	if (bc->bc_key != inode->i_op->get_fscrypt(inode)->ci_enc_key.blk_key)
 		return false;
 
-	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
+	fscrypt_generate_dun(inode->i_op->get_fscrypt(inode), next_lblk, next_dun);
 	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
@@ -501,7 +501,7 @@ u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 	if (nr_blocks <= 1)
 		return nr_blocks;
 
-	ci = inode->i_crypt_info;
+	ci = inode->i_op->get_fscrypt(inode);
 	if (!(fscrypt_policy_flags(&ci->ci_policy) &
 	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
 		return nr_blocks;
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 0d71843af946..90e1ea83c573 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -568,7 +568,7 @@ static int setup_file_encryption_key(struct fscrypt_inode_info *ci,
 	return err;
 }
 
-static void put_crypt_info(struct fscrypt_inode_info *ci)
+void put_crypt_info(struct fscrypt_inode_info *ci)
 {
 	struct fscrypt_master_key *mk;
 
@@ -597,6 +597,7 @@ static void put_crypt_info(struct fscrypt_inode_info *ci)
 	memzero_explicit(ci, sizeof(*ci));
 	kmem_cache_free(fscrypt_inode_info_cachep, ci);
 }
+EXPORT_SYMBOL(put_crypt_info);
 
 static int
 fscrypt_setup_encryption_info(struct inode *inode,
@@ -644,7 +645,7 @@ fscrypt_setup_encryption_info(struct inode *inode,
 	 * fscrypt_get_inode_info().  I.e., here we publish ->i_crypt_info with
 	 * a RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
-	if (cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info) == NULL) {
+	if (!inode->i_op->set_fscrypt(crypt_info, inode)) {
 		/*
 		 * We won the race and set ->i_crypt_info to our crypt_info.
 		 * Now link it into the master key's inode list.
@@ -788,20 +789,6 @@ int fscrypt_prepare_new_inode(struct inode *dir, struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(fscrypt_prepare_new_inode);
 
-/**
- * fscrypt_put_encryption_info() - free most of an inode's fscrypt data
- * @inode: an inode being evicted
- *
- * Free the inode's fscrypt_inode_info.  Filesystems must call this when the
- * inode is being evicted.  An RCU grace period need not have elapsed yet.
- */
-void fscrypt_put_encryption_info(struct inode *inode)
-{
-	put_crypt_info(inode->i_crypt_info);
-	inode->i_crypt_info = NULL;
-}
-EXPORT_SYMBOL(fscrypt_put_encryption_info);
-
 /**
  * fscrypt_free_inode() - free an inode's fscrypt data requiring RCU delay
  * @inode: an inode being freed
@@ -830,7 +817,7 @@ EXPORT_SYMBOL(fscrypt_free_inode);
  */
 int fscrypt_drop_inode(struct inode *inode)
 {
-	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info(inode);
+	const struct fscrypt_inode_info *ci = inode->i_op->get_fscrypt(inode);
 
 	/*
 	 * If ci is NULL, then the inode doesn't have an encryption key set up
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 701259991277..694d1ed26eeb 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -436,7 +436,7 @@ static int fscrypt_get_policy(struct inode *inode, union fscrypt_policy *policy)
 	union fscrypt_context ctx;
 	int ret;
 
-	ci = fscrypt_get_inode_info(inode);
+	ci = inode->i_op->get_fscrypt(inode);
 	if (ci) {
 		/* key available, use the cached policy */
 		*policy = ci->ci_policy;
@@ -725,7 +725,7 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
 		err = fscrypt_require_key(dir);
 		if (err)
 			return ERR_PTR(err);
-		return &dir->i_crypt_info->ci_policy;
+		return &dir->i_op->get_fscrypt(dir)->ci_policy;
 	}
 
 	return fscrypt_get_dummy_policy(dir->i_sb);
@@ -744,7 +744,7 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
  */
 int fscrypt_context_for_new_inode(void *ctx, struct inode *inode)
 {
-	struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	struct fscrypt_inode_info *ci = inode->i_op->get_fscrypt(inode);
 
 	BUILD_BUG_ON(sizeof(union fscrypt_context) !=
 			FSCRYPT_SET_CONTEXT_MAX_SIZE);
@@ -769,7 +769,7 @@ EXPORT_SYMBOL_GPL(fscrypt_context_for_new_inode);
  */
 int fscrypt_set_context(struct inode *inode, void *fs_data)
 {
-	struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	struct fscrypt_inode_info *ci = inode->i_op->get_fscrypt(inode);
 	union fscrypt_context ctx;
 	int ctxsize;
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18373de980f2..34685eec6245 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1197,6 +1197,10 @@ struct ext4_inode_info {
 	__u32 i_csum_seed;
 
 	kprojid_t i_projid;
+
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info	*i_fscrypt_info;
+#endif
 };
 
 /*
@@ -3904,6 +3908,11 @@ static inline bool ext4_inode_can_atomic_write(struct inode *inode)
 extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 				  loff_t pos, unsigned len,
 				  get_block_t *get_block);
+#ifdef CONFIG_FS_ENCRYPTION
+struct fscrypt_inode_info *ext4_get_fscrypt(const struct inode *inode);
+int ext4_set_fscrypt(struct fscrypt_inode_info *fscrypt_info,struct inode *inode);
+#endif
+
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 21df81347147..676d33a7d842 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -989,5 +989,9 @@ const struct inode_operations ext4_file_inode_operations = {
 	.fiemap		= ext4_fiemap,
 	.fileattr_get	= ext4_fileattr_get,
 	.fileattr_set	= ext4_fileattr_set,
+#ifdef CONFIG_FS_ENCRYPTION
+	.get_fscrypt	= ext4_get_fscrypt,
+	.set_fscrypt	= ext4_set_fscrypt,
+#endif
 };
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a178ac229489..a27c5925c836 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4203,6 +4203,20 @@ static int ext4_rename2(struct mnt_idmap *idmap,
 	return ext4_rename(idmap, old_dir, old_dentry, new_dir, new_dentry, flags);
 }
 
+#ifdef CONFIG_FS_ENCRYPTION
+struct fscrypt_inode_info *ext4_get_fscrypt(const struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	return fscrypt_inode_info_get(&ei->i_fscrypt_info);
+}
+
+int ext4_set_fscrypt(struct fscrypt_inode_info *fscrypt_info, struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	return fscrypt_inode_info_set(fscrypt_info, &ei->i_fscrypt_info);
+}
+#endif
+
 /*
  * directories can handle most operations...
  */
@@ -4225,6 +4239,10 @@ const struct inode_operations ext4_dir_inode_operations = {
 	.fiemap         = ext4_fiemap,
 	.fileattr_get	= ext4_fileattr_get,
 	.fileattr_set	= ext4_fileattr_set,
+#ifdef CONFIG_FS_ENCRYPTION
+	.get_fscrypt	= ext4_get_fscrypt,
+	.set_fscrypt	= ext4_set_fscrypt,
+#endif
 };
 
 const struct inode_operations ext4_special_inode_operations = {
@@ -4233,4 +4251,8 @@ const struct inode_operations ext4_special_inode_operations = {
 	.listxattr	= ext4_listxattr,
 	.get_inode_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
+#ifdef CONFIG_FS_ENCRYPTION
+	.get_fscrypt	= ext4_get_fscrypt,
+	.set_fscrypt	= ext4_set_fscrypt,
+#endif
 };
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733..972b057b0d00 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1412,6 +1412,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	spin_lock_init(&ei->i_fc_lock);
+#ifdef CONFIG_FS_ENCRYPTION
+	ei->i_fscrypt_info = NULL;
+#endif
 	return &ei->vfs_inode;
 }
 
@@ -1509,7 +1512,8 @@ void ext4_clear_inode(struct inode *inode)
 		jbd2_free_inode(EXT4_I(inode)->jinode);
 		EXT4_I(inode)->jinode = NULL;
 	}
-	fscrypt_put_encryption_info(inode);
+	put_crypt_info(EXT4_I(inode)->i_fscrypt_info);
+	EXT4_I(inode)->i_fscrypt_info = NULL;
 	fsverity_cleanup_inode(inode);
 }
 
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 645240cc0229..ee3f71e406ce 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -119,6 +119,10 @@ const struct inode_operations ext4_encrypted_symlink_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_encrypted_symlink_getattr,
 	.listxattr	= ext4_listxattr,
+#ifdef CONFIG_FS_ENCRYPTION
+	.get_fscrypt	= ext4_get_fscrypt,
+	.set_fscrypt	= ext4_set_fscrypt,
+#endif
 };
 
 const struct inode_operations ext4_symlink_inode_operations = {
@@ -126,6 +130,10 @@ const struct inode_operations ext4_symlink_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
+#ifdef CONFIG_FS_ENCRYPTION
+	.get_fscrypt	= ext4_get_fscrypt,
+	.set_fscrypt	= ext4_set_fscrypt,
+#endif
 };
 
 const struct inode_operations ext4_fast_symlink_inode_operations = {
@@ -133,4 +141,8 @@ const struct inode_operations ext4_fast_symlink_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
+#ifdef CONFIG_FS_ENCRYPTION
+	.get_fscrypt	= ext4_get_fscrypt,
+	.set_fscrypt	= ext4_set_fscrypt,
+#endif
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..600b878f41ab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -778,10 +778,6 @@ struct inode {
 	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
 #endif
 
-#ifdef CONFIG_FS_ENCRYPTION
-	struct fscrypt_inode_info	*i_crypt_info;
-#endif
-
 #ifdef CONFIG_FS_VERITY
 	struct fsverity_info	*i_verity_info;
 #endif
@@ -2257,6 +2253,11 @@ struct inode_operations {
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *(*get_fscrypt)(const struct inode *inode);
+	int (*set_fscrypt)(struct fscrypt_inode_info *fscrypt_info,
+			   struct inode *inode);
+#endif
 } ____cacheline_aligned;
 
 /* Did the driver provide valid mmap hook configuration? */
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 56fad33043d5..7ac612fec6bb 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -195,18 +195,6 @@ struct fscrypt_operations {
 int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
 			 struct dentry *dentry, unsigned int flags);
 
-static inline struct fscrypt_inode_info *
-fscrypt_get_inode_info(const struct inode *inode)
-{
-	/*
-	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
-	 * I.e., another task may publish ->i_crypt_info concurrently, executing
-	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
-	 * ACQUIRE the memory the other task published.
-	 */
-	return smp_load_acquire(&inode->i_crypt_info);
-}
-
 /**
  * fscrypt_needs_contents_encryption() - check whether an inode needs
  *					 contents encryption
@@ -385,7 +373,7 @@ int fscrypt_ioctl_get_key_status(struct file *filp, void __user *arg);
 /* keysetup.c */
 int fscrypt_prepare_new_inode(struct inode *dir, struct inode *inode,
 			      bool *encrypt_ret);
-void fscrypt_put_encryption_info(struct inode *inode);
+void put_crypt_info(struct fscrypt_inode_info *ci);
 void fscrypt_free_inode(struct inode *inode);
 int fscrypt_drop_inode(struct inode *inode);
 
@@ -446,10 +434,37 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 {
 	sb->s_cop = s_cop;
 }
+
+static inline int fscrypt_inode_info_set(struct fscrypt_inode_info *crypt_info,
+					 struct fscrypt_inode_info **p)
+{
+	if (cmpxchg_release(p, NULL, crypt_info) != NULL)
+		return -EEXIST;
+	return 0;
+}
+
+static inline struct fscrypt_inode_info *
+fscrypt_inode_info_get(struct fscrypt_inode_info **crypt_info)
+{
+	/*
+	 * Pairs with the cmpxchg_release() in fscrypt_inode_info_set(). I.e.,
+	 * another task may publish crypt_info concurrently, executing a
+	 * RELEASE barrier.  We need to use smp_load_acquire() here to safely
+	 * ACQUIRE the memory the other task published (could be a READ_ONCE()
+	 * really).
+	 */
+	return smp_load_acquire(crypt_info);
+}
 #else  /* !CONFIG_FS_ENCRYPTION */
 
+static inline int fscrypt_inode_info_set(struct fscrypt_inode_info *crypt_info,
+					 struct fscrypt_inode_info **p)
+{
+	return 0;
+}
+
 static inline struct fscrypt_inode_info *
-fscrypt_get_inode_info(const struct inode *inode)
+fscrypt_inode_info_get(const struct fscrypt_inode_info **crypt_info)
 {
 	return NULL;
 }
@@ -639,7 +654,7 @@ static inline int fscrypt_prepare_new_inode(struct inode *dir,
 	return 0;
 }
 
-static inline void fscrypt_put_encryption_info(struct inode *inode)
+static inline void put_crypt_info(struct fscrypt_inode_info *ci)
 {
 	return;
 }
@@ -930,7 +945,7 @@ static inline bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
  */
 static inline bool fscrypt_has_encryption_key(const struct inode *inode)
 {
-	return fscrypt_get_inode_info(inode) != NULL;
+	return inode->i_op->get_fscrypt(inode) != NULL;
 }
 
 /**

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250715-work-inode-fscrypt-2b63b276e793


