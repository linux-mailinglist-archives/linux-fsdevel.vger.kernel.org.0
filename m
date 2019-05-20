Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDAF423EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392976AbfETR3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 13:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390882AbfETR2s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 13:28:48 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9C0214AE;
        Mon, 20 May 2019 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558373327;
        bh=z/EHnbQc0cxIaON8bp7K15K0Nx1xDAVh20INTKfDNXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHVSVRqN1KZT96/RmbjTIB1uTE1llIif5WSKFe7M2xfuLaSI42qhdCWRiyhpWX9SO
         dNYljl/UsmAVwJVJiG4IDI/KCjhjoRw6KF346Qcy5Hm5egiSbguVWai36C/WxBosI0
         SSxDwml88RyYSamrWJCCDQHsQmqIyXghCBRUqo4g=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, keyrings@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>
Subject: [PATCH v6 03/16] fscrypt: use FSCRYPT_* definitions, not FS_*
Date:   Mon, 20 May 2019 10:25:39 -0700
Message-Id: <20190520172552.217253-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520172552.217253-1-ebiggers@kernel.org>
References: <20190520172552.217253-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Update fs/crypto/ to use the new names for the UAPI constants rather
than the old names, then make the old definitions conditional on
!__KERNEL__.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/crypto.c           |  2 +-
 fs/crypto/fname.c            |  2 +-
 fs/crypto/fscrypt_private.h  | 16 +++++------
 fs/crypto/keyinfo.c          | 53 ++++++++++++++++++------------------
 fs/crypto/policy.c           | 14 +++++-----
 include/uapi/linux/fscrypt.h |  2 ++
 6 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 68e2ca4c4af63..b10f375ecee81 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -133,7 +133,7 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 	memset(iv, 0, ci->ci_mode->ivsize);
 	iv->lblk_num = cpu_to_le64(lblk_num);
 
-	if (ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY)
+	if (ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
 		memcpy(iv->nonce, ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE);
 
 	if (ci->ci_essiv_tfm != NULL)
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index eccea3d8f9234..65f1bda87c3c9 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -187,7 +187,7 @@ bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
 				  u32 max_len, u32 *encrypted_len_ret)
 {
 	int padding = 4 << (inode->i_crypt_info->ci_flags &
-			    FS_POLICY_FLAGS_PAD_MASK);
+			    FSCRYPT_POLICY_FLAGS_PAD_MASK);
 	u32 encrypted_len;
 
 	if (orig_len > max_len)
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 7da2761595933..52e09ef40bfa6 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -34,7 +34,7 @@ struct fscrypt_context {
 	u8 contents_encryption_mode;
 	u8 filenames_encryption_mode;
 	u8 flags;
-	u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
+	u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
 	u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
 } __packed;
 
@@ -84,7 +84,7 @@ struct fscrypt_info {
 	u8 ci_data_mode;
 	u8 ci_filename_mode;
 	u8 ci_flags;
-	u8 ci_master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
+	u8 ci_master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
 	u8 ci_nonce[FS_KEY_DERIVATION_NONCE_SIZE];
 };
 
@@ -99,16 +99,16 @@ typedef enum {
 static inline bool fscrypt_valid_enc_modes(u32 contents_mode,
 					   u32 filenames_mode)
 {
-	if (contents_mode == FS_ENCRYPTION_MODE_AES_128_CBC &&
-	    filenames_mode == FS_ENCRYPTION_MODE_AES_128_CTS)
+	if (contents_mode == FSCRYPT_MODE_AES_128_CBC &&
+	    filenames_mode == FSCRYPT_MODE_AES_128_CTS)
 		return true;
 
-	if (contents_mode == FS_ENCRYPTION_MODE_AES_256_XTS &&
-	    filenames_mode == FS_ENCRYPTION_MODE_AES_256_CTS)
+	if (contents_mode == FSCRYPT_MODE_AES_256_XTS &&
+	    filenames_mode == FSCRYPT_MODE_AES_256_CTS)
 		return true;
 
-	if (contents_mode == FS_ENCRYPTION_MODE_ADIANTUM &&
-	    filenames_mode == FS_ENCRYPTION_MODE_ADIANTUM)
+	if (contents_mode == FSCRYPT_MODE_ADIANTUM &&
+	    filenames_mode == FSCRYPT_MODE_ADIANTUM)
 		return true;
 
 	return false;
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index dcd91a3fbe49a..479389a4e0559 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -21,7 +21,7 @@
 
 static struct crypto_shash *essiv_hash_tfm;
 
-/* Table of keys referenced by FS_POLICY_FLAG_DIRECT_KEY policies */
+/* Table of keys referenced by DIRECT_KEY policies */
 static DEFINE_HASHTABLE(fscrypt_master_keys, 6); /* 6 bits = 64 buckets */
 static DEFINE_SPINLOCK(fscrypt_master_keys_lock);
 
@@ -78,7 +78,7 @@ static int derive_key_aes(const u8 *master_key,
  */
 static struct key *
 find_and_lock_process_key(const char *prefix,
-			  const u8 descriptor[FS_KEY_DESCRIPTOR_SIZE],
+			  const u8 descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE],
 			  unsigned int min_keysize,
 			  const struct fscrypt_key **payload_ret)
 {
@@ -88,7 +88,7 @@ find_and_lock_process_key(const char *prefix,
 	const struct fscrypt_key *payload;
 
 	description = kasprintf(GFP_NOFS, "%s%*phN", prefix,
-				FS_KEY_DESCRIPTOR_SIZE, descriptor);
+				FSCRYPT_KEY_DESCRIPTOR_SIZE, descriptor);
 	if (!description)
 		return ERR_PTR(-ENOMEM);
 
@@ -106,7 +106,7 @@ find_and_lock_process_key(const char *prefix,
 	payload = (const struct fscrypt_key *)ukp->data;
 
 	if (ukp->datalen != sizeof(struct fscrypt_key) ||
-	    payload->size < 1 || payload->size > FS_MAX_KEY_SIZE) {
+	    payload->size < 1 || payload->size > FSCRYPT_MAX_KEY_SIZE) {
 		fscrypt_warn(NULL,
 			     "key with description '%s' has invalid payload",
 			     key->description);
@@ -130,32 +130,32 @@ find_and_lock_process_key(const char *prefix,
 }
 
 static struct fscrypt_mode available_modes[] = {
-	[FS_ENCRYPTION_MODE_AES_256_XTS] = {
+	[FSCRYPT_MODE_AES_256_XTS] = {
 		.friendly_name = "AES-256-XTS",
 		.cipher_str = "xts(aes)",
 		.keysize = 64,
 		.ivsize = 16,
 	},
-	[FS_ENCRYPTION_MODE_AES_256_CTS] = {
+	[FSCRYPT_MODE_AES_256_CTS] = {
 		.friendly_name = "AES-256-CTS-CBC",
 		.cipher_str = "cts(cbc(aes))",
 		.keysize = 32,
 		.ivsize = 16,
 	},
-	[FS_ENCRYPTION_MODE_AES_128_CBC] = {
+	[FSCRYPT_MODE_AES_128_CBC] = {
 		.friendly_name = "AES-128-CBC",
 		.cipher_str = "cbc(aes)",
 		.keysize = 16,
 		.ivsize = 16,
 		.needs_essiv = true,
 	},
-	[FS_ENCRYPTION_MODE_AES_128_CTS] = {
+	[FSCRYPT_MODE_AES_128_CTS] = {
 		.friendly_name = "AES-128-CTS-CBC",
 		.cipher_str = "cts(cbc(aes))",
 		.keysize = 16,
 		.ivsize = 16,
 	},
-	[FS_ENCRYPTION_MODE_ADIANTUM] = {
+	[FSCRYPT_MODE_ADIANTUM] = {
 		.friendly_name = "Adiantum",
 		.cipher_str = "adiantum(xchacha12,aes)",
 		.keysize = 32,
@@ -194,7 +194,7 @@ static int find_and_derive_key(const struct inode *inode,
 	const struct fscrypt_key *payload;
 	int err;
 
-	key = find_and_lock_process_key(FS_KEY_DESC_PREFIX,
+	key = find_and_lock_process_key(FSCRYPT_KEY_DESC_PREFIX,
 					ctx->master_key_descriptor,
 					mode->keysize, &payload);
 	if (key == ERR_PTR(-ENOKEY) && inode->i_sb->s_cop->key_prefix) {
@@ -205,7 +205,7 @@ static int find_and_derive_key(const struct inode *inode,
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
-	if (ctx->flags & FS_POLICY_FLAG_DIRECT_KEY) {
+	if (ctx->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
 		if (mode->ivsize < offsetofend(union fscrypt_iv, nonce)) {
 			fscrypt_warn(inode->i_sb,
 				     "direct key mode not allowed with %s",
@@ -269,14 +269,14 @@ allocate_skcipher_for_mode(struct fscrypt_mode *mode, const u8 *raw_key,
 	return ERR_PTR(err);
 }
 
-/* Master key referenced by FS_POLICY_FLAG_DIRECT_KEY policy */
+/* Master key referenced by DIRECT_KEY policy */
 struct fscrypt_master_key {
 	struct hlist_node mk_node;
 	refcount_t mk_refcount;
 	const struct fscrypt_mode *mk_mode;
 	struct crypto_skcipher *mk_ctfm;
-	u8 mk_descriptor[FS_KEY_DESCRIPTOR_SIZE];
-	u8 mk_raw[FS_MAX_KEY_SIZE];
+	u8 mk_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+	u8 mk_raw[FSCRYPT_MAX_KEY_SIZE];
 };
 
 static void free_master_key(struct fscrypt_master_key *mk)
@@ -317,13 +317,13 @@ find_or_insert_master_key(struct fscrypt_master_key *to_insert,
 	 * raw key, and use crypto_memneq() when comparing raw keys.
 	 */
 
-	BUILD_BUG_ON(sizeof(hash_key) > FS_KEY_DESCRIPTOR_SIZE);
+	BUILD_BUG_ON(sizeof(hash_key) > FSCRYPT_KEY_DESCRIPTOR_SIZE);
 	memcpy(&hash_key, ci->ci_master_key_descriptor, sizeof(hash_key));
 
 	spin_lock(&fscrypt_master_keys_lock);
 	hash_for_each_possible(fscrypt_master_keys, mk, mk_node, hash_key) {
 		if (memcmp(ci->ci_master_key_descriptor, mk->mk_descriptor,
-			   FS_KEY_DESCRIPTOR_SIZE) != 0)
+			   FSCRYPT_KEY_DESCRIPTOR_SIZE) != 0)
 			continue;
 		if (mode != mk->mk_mode)
 			continue;
@@ -367,7 +367,7 @@ fscrypt_get_master_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
 		goto err_free_mk;
 	}
 	memcpy(mk->mk_descriptor, ci->ci_master_key_descriptor,
-	       FS_KEY_DESCRIPTOR_SIZE);
+	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
 	memcpy(mk->mk_raw, raw_key, mode->keysize);
 
 	return find_or_insert_master_key(mk, raw_key, mode, ci);
@@ -445,8 +445,8 @@ void __exit fscrypt_essiv_cleanup(void)
 
 /*
  * Given the encryption mode and key (normally the derived key, but for
- * FS_POLICY_FLAG_DIRECT_KEY mode it's the master key), set up the inode's
- * symmetric cipher transform object(s).
+ * DIRECT_KEY mode it's the master key), set up the inode's symmetric cipher
+ * transform object(s).
  */
 static int setup_crypto_transform(struct fscrypt_info *ci,
 				  struct fscrypt_mode *mode,
@@ -456,7 +456,7 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
 	struct crypto_skcipher *ctfm;
 	int err;
 
-	if (ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY) {
+	if (ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
 		mk = fscrypt_get_master_key(ci, mode, raw_key, inode);
 		if (IS_ERR(mk))
 			return PTR_ERR(mk);
@@ -473,7 +473,7 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
 	if (mode->needs_essiv) {
 		/* ESSIV implies 16-byte IVs which implies !DIRECT_KEY */
 		WARN_ON(mode->ivsize != AES_BLOCK_SIZE);
-		WARN_ON(ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY);
+		WARN_ON(ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY);
 
 		err = init_essiv_generator(ci, raw_key, mode->keysize);
 		if (err) {
@@ -523,9 +523,10 @@ int fscrypt_get_encryption_info(struct inode *inode)
 		/* Fake up a context for an unencrypted directory */
 		memset(&ctx, 0, sizeof(ctx));
 		ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
-		ctx.contents_encryption_mode = FS_ENCRYPTION_MODE_AES_256_XTS;
-		ctx.filenames_encryption_mode = FS_ENCRYPTION_MODE_AES_256_CTS;
-		memset(ctx.master_key_descriptor, 0x42, FS_KEY_DESCRIPTOR_SIZE);
+		ctx.contents_encryption_mode = FSCRYPT_MODE_AES_256_XTS;
+		ctx.filenames_encryption_mode = FSCRYPT_MODE_AES_256_CTS;
+		memset(ctx.master_key_descriptor, 0x42,
+		       FSCRYPT_KEY_DESCRIPTOR_SIZE);
 	} else if (res != sizeof(ctx)) {
 		return -EINVAL;
 	}
@@ -533,7 +534,7 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	if (ctx.format != FS_ENCRYPTION_CONTEXT_FORMAT_V1)
 		return -EINVAL;
 
-	if (ctx.flags & ~FS_POLICY_FLAGS_VALID)
+	if (ctx.flags & ~FSCRYPT_POLICY_FLAGS_VALID)
 		return -EINVAL;
 
 	crypt_info = kmem_cache_zalloc(fscrypt_info_cachep, GFP_NOFS);
@@ -544,7 +545,7 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	crypt_info->ci_data_mode = ctx.contents_encryption_mode;
 	crypt_info->ci_filename_mode = ctx.filenames_encryption_mode;
 	memcpy(crypt_info->ci_master_key_descriptor, ctx.master_key_descriptor,
-	       FS_KEY_DESCRIPTOR_SIZE);
+	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
 	memcpy(crypt_info->ci_nonce, ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
 
 	mode = select_encryption_mode(crypt_info, inode);
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index d536889ac31bf..18f1bf300ec44 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -22,7 +22,7 @@ static bool is_encryption_context_consistent_with_policy(
 				const struct fscrypt_policy *policy)
 {
 	return memcmp(ctx->master_key_descriptor, policy->master_key_descriptor,
-		      FS_KEY_DESCRIPTOR_SIZE) == 0 &&
+		      FSCRYPT_KEY_DESCRIPTOR_SIZE) == 0 &&
 		(ctx->flags == policy->flags) &&
 		(ctx->contents_encryption_mode ==
 		 policy->contents_encryption_mode) &&
@@ -37,13 +37,13 @@ static int create_encryption_context_from_policy(struct inode *inode,
 
 	ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
 	memcpy(ctx.master_key_descriptor, policy->master_key_descriptor,
-					FS_KEY_DESCRIPTOR_SIZE);
+					FSCRYPT_KEY_DESCRIPTOR_SIZE);
 
 	if (!fscrypt_valid_enc_modes(policy->contents_encryption_mode,
 				     policy->filenames_encryption_mode))
 		return -EINVAL;
 
-	if (policy->flags & ~FS_POLICY_FLAGS_VALID)
+	if (policy->flags & ~FSCRYPT_POLICY_FLAGS_VALID)
 		return -EINVAL;
 
 	ctx.contents_encryption_mode = policy->contents_encryption_mode;
@@ -126,7 +126,7 @@ int fscrypt_ioctl_get_policy(struct file *filp, void __user *arg)
 	policy.filenames_encryption_mode = ctx.filenames_encryption_mode;
 	policy.flags = ctx.flags;
 	memcpy(policy.master_key_descriptor, ctx.master_key_descriptor,
-				FS_KEY_DESCRIPTOR_SIZE);
+				FSCRYPT_KEY_DESCRIPTOR_SIZE);
 
 	if (copy_to_user(arg, &policy, sizeof(policy)))
 		return -EFAULT;
@@ -200,7 +200,7 @@ int fscrypt_has_permitted_context(struct inode *parent, struct inode *child)
 	if (parent_ci && child_ci) {
 		return memcmp(parent_ci->ci_master_key_descriptor,
 			      child_ci->ci_master_key_descriptor,
-			      FS_KEY_DESCRIPTOR_SIZE) == 0 &&
+			      FSCRYPT_KEY_DESCRIPTOR_SIZE) == 0 &&
 			(parent_ci->ci_data_mode == child_ci->ci_data_mode) &&
 			(parent_ci->ci_filename_mode ==
 			 child_ci->ci_filename_mode) &&
@@ -217,7 +217,7 @@ int fscrypt_has_permitted_context(struct inode *parent, struct inode *child)
 
 	return memcmp(parent_ctx.master_key_descriptor,
 		      child_ctx.master_key_descriptor,
-		      FS_KEY_DESCRIPTOR_SIZE) == 0 &&
+		      FSCRYPT_KEY_DESCRIPTOR_SIZE) == 0 &&
 		(parent_ctx.contents_encryption_mode ==
 		 child_ctx.contents_encryption_mode) &&
 		(parent_ctx.filenames_encryption_mode ==
@@ -255,7 +255,7 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
 	ctx.filenames_encryption_mode = ci->ci_filename_mode;
 	ctx.flags = ci->ci_flags;
 	memcpy(ctx.master_key_descriptor, ci->ci_master_key_descriptor,
-	       FS_KEY_DESCRIPTOR_SIZE);
+	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
 	get_random_bytes(ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
 	BUILD_BUG_ON(sizeof(ctx) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
 	res = parent->i_sb->s_cop->set_context(child, &ctx,
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index f9b99cc028bc6..3bbc5dfbde211 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -53,6 +53,7 @@ struct fscrypt_key {
 /**********************************************************************/
 
 /* old names; don't add anything new here! */
+#ifndef __KERNEL__
 #define FS_KEY_DESCRIPTOR_SIZE		FSCRYPT_KEY_DESCRIPTOR_SIZE
 #define FS_POLICY_FLAGS_PAD_4		FSCRYPT_POLICY_FLAGS_PAD_4
 #define FS_POLICY_FLAGS_PAD_8		FSCRYPT_POLICY_FLAGS_PAD_8
@@ -74,5 +75,6 @@ struct fscrypt_key {
 #define FS_KEY_DESC_PREFIX		FSCRYPT_KEY_DESC_PREFIX
 #define FS_KEY_DESC_PREFIX_SIZE		FSCRYPT_KEY_DESC_PREFIX_SIZE
 #define FS_MAX_KEY_SIZE			FSCRYPT_MAX_KEY_SIZE
+#endif /* !__KERNEL__ */
 
 #endif /* _UAPI_LINUX_FSCRYPT_H */
-- 
2.21.0.1020.gf2820cf01a-goog

