Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49F182245
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfHEQ3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729839AbfHEQ2e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:28:34 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEAE2186A;
        Mon,  5 Aug 2019 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565022513;
        bh=4C39xGz+w1yz5859asOTjs2/MZ9vB+SPQahRmSSHccA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loz7ZfzhWc9t9MxHyzjO0hQT4YUIF5GexhrTBaYVBoMPxutX4uEc4AnJsNeEYfP3+
         c3VbNKSqlNNdDhYR4Uj1VZTe2XNx4zmp5gXh4WBv5ExZisECXNRlpnpATK9T1CHN0o
         q6HulJMNNTka1fnT/egmpaQjiwcNTARMYpRduEGw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v8 06/20] fscrypt: refactor key setup code in preparation for v2 policies
Date:   Mon,  5 Aug 2019 09:25:07 -0700
Message-Id: <20190805162521.90882-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805162521.90882-1-ebiggers@kernel.org>
References: <20190805162521.90882-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Do some more refactoring of the key setup code, in preparation for
introducing a filesystem-level keyring and v2 encryption policies:

- Now that ci_inode exists, don't pass around the inode unnecessarily.

- Define a function setup_file_encryption_key() which handles the crypto
  key setup given an under-construction fscrypt_info.  Don't pass the
  fscrypt_context, since everything is in the fscrypt_info.
  [This will be extended for v2 policies and the fs-level keyring.]

- Define a function fscrypt_set_derived_key() which sets the per-file
  key, without depending on anything specific to v1 policies.
  [This will also be used for v2 policies.]

- Define a function fscrypt_setup_v1_file_key() which takes the raw
  master key, thus separating finding the key from using it.
  [This will also be used if the key is found in the fs-level keyring.]

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h |  11 +-
 fs/crypto/keyinfo.c         | 247 ++++++++++++++++++++----------------
 2 files changed, 146 insertions(+), 112 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 80d15a1bf60685..56bac5c7ef408a 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -4,9 +4,8 @@
  *
  * Copyright (C) 2015, Google, Inc.
  *
- * This contains encryption key functions.
- *
- * Written by Michael Halcrow, Ildar Muslukhov, and Uday Savagaonkar, 2015.
+ * Originally written by Michael Halcrow, Ildar Muslukhov, and Uday Savagaonkar.
+ * Heavily modified since then.
  */
 
 #ifndef _FSCRYPT_PRIVATE_H
@@ -168,4 +167,10 @@ struct fscrypt_mode {
 	bool needs_essiv;
 };
 
+static inline bool
+fscrypt_mode_supports_direct_key(const struct fscrypt_mode *mode)
+{
+	return mode->ivsize >= offsetofend(union fscrypt_iv, nonce);
+}
+
 #endif /* _FSCRYPT_PRIVATE_H */
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index c4650071df2772..c6bf44d6411189 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * key management facility for FS encryption support.
+ * Key setup facility for FS encryption support.
  *
  * Copyright (C) 2015, Google, Inc.
  *
- * This contains encryption key functions.
- *
- * Written by Michael Halcrow, Ildar Muslukhov, and Uday Savagaonkar, 2015.
+ * Originally written by Michael Halcrow, Ildar Muslukhov, and Uday Savagaonkar.
+ * Heavily modified since then.
  */
 
 #include <keys/user-type.h>
@@ -25,14 +24,19 @@ static DEFINE_HASHTABLE(fscrypt_direct_keys, 6); /* 6 bits = 64 buckets */
 static DEFINE_SPINLOCK(fscrypt_direct_keys_lock);
 
 /*
- * Key derivation function.  This generates the derived key by encrypting the
- * master key with AES-128-ECB using the inode's nonce as the AES key.
+ * v1 key derivation function.  This generates the derived key by encrypting the
+ * master key with AES-128-ECB using the nonce as the AES key.  This provides a
+ * unique derived key with sufficient entropy for each inode.  However, it's
+ * nonstandard, non-extensible, doesn't evenly distribute the entropy from the
+ * master key, and is trivially reversible: an attacker who compromises a
+ * derived key can "decrypt" it to get back to the master key, then derive any
+ * other key.  For all new code, use HKDF instead.
  *
  * The master key must be at least as long as the derived key.  If the master
  * key is longer, then only the first 'derived_keysize' bytes are used.
  */
 static int derive_key_aes(const u8 *master_key,
-			  const struct fscrypt_context *ctx,
+			  const u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE],
 			  u8 *derived_key, unsigned int derived_keysize)
 {
 	int res = 0;
@@ -55,7 +59,7 @@ static int derive_key_aes(const u8 *master_key,
 	skcipher_request_set_callback(req,
 			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
 			crypto_req_done, &wait);
-	res = crypto_skcipher_setkey(tfm, ctx->nonce, sizeof(ctx->nonce));
+	res = crypto_skcipher_setkey(tfm, nonce, FS_KEY_DERIVATION_NONCE_SIZE);
 	if (res < 0)
 		goto out;
 
@@ -183,54 +187,10 @@ select_encryption_mode(const struct fscrypt_info *ci, const struct inode *inode)
 	return ERR_PTR(-EINVAL);
 }
 
-/* Find the master key, then derive the inode's actual encryption key */
-static int find_and_derive_key(const struct inode *inode,
-			       const struct fscrypt_context *ctx,
-			       u8 *derived_key, const struct fscrypt_mode *mode)
-{
-	struct key *key;
-	const struct fscrypt_key *payload;
-	int err;
-
-	key = find_and_lock_process_key(FSCRYPT_KEY_DESC_PREFIX,
-					ctx->master_key_descriptor,
-					mode->keysize, &payload);
-	if (key == ERR_PTR(-ENOKEY) && inode->i_sb->s_cop->key_prefix) {
-		key = find_and_lock_process_key(inode->i_sb->s_cop->key_prefix,
-						ctx->master_key_descriptor,
-						mode->keysize, &payload);
-	}
-	if (IS_ERR(key))
-		return PTR_ERR(key);
-
-	if (ctx->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
-		if (mode->ivsize < offsetofend(union fscrypt_iv, nonce)) {
-			fscrypt_warn(inode,
-				     "Direct key mode not allowed with %s",
-				     mode->friendly_name);
-			err = -EINVAL;
-		} else if (ctx->contents_encryption_mode !=
-			   ctx->filenames_encryption_mode) {
-			fscrypt_warn(inode,
-				     "Direct key mode not allowed with different contents and filenames modes");
-			err = -EINVAL;
-		} else {
-			memcpy(derived_key, payload->raw, mode->keysize);
-			err = 0;
-		}
-	} else {
-		err = derive_key_aes(payload->raw, ctx, derived_key,
-				     mode->keysize);
-	}
-	up_read(&key->sem);
-	key_put(key);
-	return err;
-}
-
-/* Allocate and key a symmetric cipher object for the given encryption mode */
+/* Create a symmetric cipher object for the given encryption mode and key */
 static struct crypto_skcipher *
-allocate_skcipher_for_mode(struct fscrypt_mode *mode, const u8 *raw_key,
-			   const struct inode *inode)
+fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
+			  const struct inode *inode)
 {
 	struct crypto_skcipher *tfm;
 	int err;
@@ -308,8 +268,7 @@ static void put_direct_key(struct fscrypt_direct_key *dk)
  */
 static struct fscrypt_direct_key *
 find_or_insert_direct_key(struct fscrypt_direct_key *to_insert,
-			  const u8 *raw_key, const struct fscrypt_mode *mode,
-			  const struct fscrypt_info *ci)
+			  const u8 *raw_key, const struct fscrypt_info *ci)
 {
 	unsigned long hash_key;
 	struct fscrypt_direct_key *dk;
@@ -328,9 +287,9 @@ find_or_insert_direct_key(struct fscrypt_direct_key *to_insert,
 		if (memcmp(ci->ci_master_key_descriptor, dk->dk_descriptor,
 			   FSCRYPT_KEY_DESCRIPTOR_SIZE) != 0)
 			continue;
-		if (mode != dk->dk_mode)
+		if (ci->ci_mode != dk->dk_mode)
 			continue;
-		if (crypto_memneq(raw_key, dk->dk_raw, mode->keysize))
+		if (crypto_memneq(raw_key, dk->dk_raw, ci->ci_mode->keysize))
 			continue;
 		/* using existing tfm with same (descriptor, mode, raw_key) */
 		refcount_inc(&dk->dk_refcount);
@@ -346,14 +305,13 @@ find_or_insert_direct_key(struct fscrypt_direct_key *to_insert,
 
 /* Prepare to encrypt directly using the master key in the given mode */
 static struct fscrypt_direct_key *
-fscrypt_get_direct_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
-		       const u8 *raw_key, const struct inode *inode)
+fscrypt_get_direct_key(const struct fscrypt_info *ci, const u8 *raw_key)
 {
 	struct fscrypt_direct_key *dk;
 	int err;
 
 	/* Is there already a tfm for this key? */
-	dk = find_or_insert_direct_key(NULL, raw_key, mode, ci);
+	dk = find_or_insert_direct_key(NULL, raw_key, ci);
 	if (dk)
 		return dk;
 
@@ -362,8 +320,9 @@ fscrypt_get_direct_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
 	if (!dk)
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&dk->dk_refcount, 1);
-	dk->dk_mode = mode;
-	dk->dk_ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
+	dk->dk_mode = ci->ci_mode;
+	dk->dk_ctfm = fscrypt_allocate_skcipher(ci->ci_mode, raw_key,
+						ci->ci_inode);
 	if (IS_ERR(dk->dk_ctfm)) {
 		err = PTR_ERR(dk->dk_ctfm);
 		dk->dk_ctfm = NULL;
@@ -371,9 +330,9 @@ fscrypt_get_direct_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
 	}
 	memcpy(dk->dk_descriptor, ci->ci_master_key_descriptor,
 	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	memcpy(dk->dk_raw, raw_key, mode->keysize);
+	memcpy(dk->dk_raw, raw_key, ci->ci_mode->keysize);
 
-	return find_or_insert_direct_key(dk, raw_key, mode, ci);
+	return find_or_insert_direct_key(dk, raw_key, ci);
 
 err_free_dk:
 	free_direct_key(dk);
@@ -422,6 +381,9 @@ static int init_essiv_generator(struct fscrypt_info *ci, const u8 *raw_key,
 	struct crypto_cipher *essiv_tfm;
 	u8 salt[SHA256_DIGEST_SIZE];
 
+	if (WARN_ON(ci->ci_mode->ivsize != AES_BLOCK_SIZE))
+		return -EINVAL;
+
 	essiv_tfm = crypto_alloc_cipher("aes", 0, 0);
 	if (IS_ERR(essiv_tfm))
 		return PTR_ERR(essiv_tfm);
@@ -446,41 +408,24 @@ static int init_essiv_generator(struct fscrypt_info *ci, const u8 *raw_key,
 	return err;
 }
 
-/*
- * Given the encryption mode and key (normally the derived key, but for
- * DIRECT_KEY mode it's the master key), set up the inode's symmetric cipher
- * transform object(s).
- */
-static int setup_crypto_transform(struct fscrypt_info *ci,
-				  struct fscrypt_mode *mode,
-				  const u8 *raw_key, const struct inode *inode)
+/* Given the per-file key, set up the file's crypto transform object(s) */
+static int fscrypt_set_derived_key(struct fscrypt_info *ci,
+				   const u8 *derived_key)
 {
-	struct fscrypt_direct_key *dk;
+	struct fscrypt_mode *mode = ci->ci_mode;
 	struct crypto_skcipher *ctfm;
 	int err;
 
-	if (ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
-		dk = fscrypt_get_direct_key(ci, mode, raw_key, inode);
-		if (IS_ERR(dk))
-			return PTR_ERR(dk);
-		ctfm = dk->dk_ctfm;
-	} else {
-		dk = NULL;
-		ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
-		if (IS_ERR(ctfm))
-			return PTR_ERR(ctfm);
-	}
-	ci->ci_direct_key = dk;
+	ctfm = fscrypt_allocate_skcipher(mode, derived_key, ci->ci_inode);
+	if (IS_ERR(ctfm))
+		return PTR_ERR(ctfm);
+
 	ci->ci_ctfm = ctfm;
 
 	if (mode->needs_essiv) {
-		/* ESSIV implies 16-byte IVs which implies !DIRECT_KEY */
-		WARN_ON(mode->ivsize != AES_BLOCK_SIZE);
-		WARN_ON(ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY);
-
-		err = init_essiv_generator(ci, raw_key, mode->keysize);
+		err = init_essiv_generator(ci, derived_key, mode->keysize);
 		if (err) {
-			fscrypt_warn(inode,
+			fscrypt_warn(ci->ci_inode,
 				     "Error initializing ESSIV generator: %d",
 				     err);
 			return err;
@@ -489,6 +434,105 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
 	return 0;
 }
 
+/* v1 policy, DIRECT_KEY: use the master key directly */
+static int setup_v1_file_key_direct(struct fscrypt_info *ci,
+				    const u8 *raw_master_key)
+{
+	const struct fscrypt_mode *mode = ci->ci_mode;
+	struct fscrypt_direct_key *dk;
+
+	if (!fscrypt_mode_supports_direct_key(mode)) {
+		fscrypt_warn(ci->ci_inode,
+			     "Direct key mode not allowed with %s",
+			     mode->friendly_name);
+		return -EINVAL;
+	}
+
+	if (ci->ci_data_mode != ci->ci_filename_mode) {
+		fscrypt_warn(ci->ci_inode,
+			     "Direct key mode not allowed with different contents and filenames modes");
+		return -EINVAL;
+	}
+
+	/* ESSIV implies 16-byte IVs which implies !DIRECT_KEY */
+	if (WARN_ON(mode->needs_essiv))
+		return -EINVAL;
+
+	dk = fscrypt_get_direct_key(ci, raw_master_key);
+	if (IS_ERR(dk))
+		return PTR_ERR(dk);
+	ci->ci_direct_key = dk;
+	ci->ci_ctfm = dk->dk_ctfm;
+	return 0;
+}
+
+/* v1 policy, !DIRECT_KEY: derive the file's encryption key */
+static int setup_v1_file_key_derived(struct fscrypt_info *ci,
+				     const u8 *raw_master_key)
+{
+	u8 *derived_key;
+	int err;
+
+	/*
+	 * This cannot be a stack buffer because it will be passed to the
+	 * scatterlist crypto API during derive_key_aes().
+	 */
+	derived_key = kmalloc(ci->ci_mode->keysize, GFP_NOFS);
+	if (!derived_key)
+		return -ENOMEM;
+
+	err = derive_key_aes(raw_master_key, ci->ci_nonce,
+			     derived_key, ci->ci_mode->keysize);
+	if (err)
+		goto out;
+
+	err = fscrypt_set_derived_key(ci, derived_key);
+out:
+	kzfree(derived_key);
+	return err;
+}
+
+static int fscrypt_setup_v1_file_key(struct fscrypt_info *ci,
+				     const u8 *raw_master_key)
+{
+	if (ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
+		return setup_v1_file_key_direct(ci, raw_master_key);
+	else
+		return setup_v1_file_key_derived(ci, raw_master_key);
+}
+
+static int fscrypt_setup_v1_file_key_via_subscribed_keyrings(
+						struct fscrypt_info *ci)
+{
+	struct key *key;
+	const struct fscrypt_key *payload;
+	int err;
+
+	key = find_and_lock_process_key(FSCRYPT_KEY_DESC_PREFIX,
+					ci->ci_master_key_descriptor,
+					ci->ci_mode->keysize, &payload);
+	if (key == ERR_PTR(-ENOKEY) && ci->ci_inode->i_sb->s_cop->key_prefix) {
+		key = find_and_lock_process_key(ci->ci_inode->i_sb->s_cop->key_prefix,
+						ci->ci_master_key_descriptor,
+						ci->ci_mode->keysize, &payload);
+	}
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	err = fscrypt_setup_v1_file_key(ci, payload->raw);
+	up_read(&key->sem);
+	key_put(key);
+	return err;
+}
+
+/*
+ * Find the master key, then set up the inode's actual encryption key.
+ */
+static int setup_file_encryption_key(struct fscrypt_info *ci)
+{
+	return fscrypt_setup_v1_file_key_via_subscribed_keyrings(ci);
+}
+
 static void put_crypt_info(struct fscrypt_info *ci)
 {
 	if (!ci)
@@ -508,7 +552,6 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	struct fscrypt_info *crypt_info;
 	struct fscrypt_context ctx;
 	struct fscrypt_mode *mode;
-	u8 *raw_key = NULL;
 	int res;
 
 	if (fscrypt_has_encryption_key(inode))
@@ -573,20 +616,7 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	WARN_ON(mode->ivsize > FSCRYPT_MAX_IV_SIZE);
 	crypt_info->ci_mode = mode;
 
-	/*
-	 * This cannot be a stack buffer because it may be passed to the
-	 * scatterlist crypto API as part of key derivation.
-	 */
-	res = -ENOMEM;
-	raw_key = kmalloc(mode->keysize, GFP_NOFS);
-	if (!raw_key)
-		goto out;
-
-	res = find_and_derive_key(inode, &ctx, raw_key, mode);
-	if (res)
-		goto out;
-
-	res = setup_crypto_transform(crypt_info, mode, raw_key, inode);
+	res = setup_file_encryption_key(crypt_info);
 	if (res)
 		goto out;
 
@@ -596,7 +626,6 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	if (res == -ENOKEY)
 		res = 0;
 	put_crypt_info(crypt_info);
-	kzfree(raw_key);
 	return res;
 }
 EXPORT_SYMBOL(fscrypt_get_encryption_info);
-- 
2.22.0.770.g0f2c4a37fd-goog

