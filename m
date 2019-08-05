Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8EF821CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfHEQ2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbfHEQ2f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:28:35 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65CE3217F5;
        Mon,  5 Aug 2019 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565022513;
        bh=D7WR2Ks2HrM82YydDDgixOVlWNqv2WknokNhm8hJDtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNrEPtzH8qFZ61TDxQJprQ0rCBOngdy5MZ4CzJHvD+YCwdSd+R++tC/DW6YhBEEcA
         tpSYzbyE0+YCN9CXlVcfA5zIwriAFoj+b8OQDS7ug91CFjopKdjLM7Ymm7EFikcEQg
         db9k9ih2d/N2/ybNtz9/y9isC4f3E8PH/h7Nkn1g=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v8 07/20] fscrypt: move v1 policy key setup to keysetup_v1.c
Date:   Mon,  5 Aug 2019 09:25:08 -0700
Message-Id: <20190805162521.90882-8-ebiggers@kernel.org>
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

In preparation for introducing v2 encryption policies which will find
and derive encryption keys differently from the current v1 encryption
policies, move the v1 policy-specific key setup code from keyinfo.c into
keysetup_v1.c.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/Makefile          |   8 +-
 fs/crypto/fscrypt_private.h |  17 ++
 fs/crypto/keyinfo.c         | 328 +---------------------------------
 fs/crypto/keysetup_v1.c     | 338 ++++++++++++++++++++++++++++++++++++
 4 files changed, 369 insertions(+), 322 deletions(-)
 create mode 100644 fs/crypto/keysetup_v1.c

diff --git a/fs/crypto/Makefile b/fs/crypto/Makefile
index 4f0df5e682e49f..1fba255c34ca56 100644
--- a/fs/crypto/Makefile
+++ b/fs/crypto/Makefile
@@ -1,5 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_FS_ENCRYPTION)	+= fscrypto.o
 
-fscrypto-y := crypto.o fname.o hooks.o keyinfo.o policy.o
+fscrypto-y := crypto.o \
+	      fname.o \
+	      hooks.o \
+	      keyinfo.o \
+	      keysetup_v1.o \
+	      policy.o
+
 fscrypto-$(CONFIG_BLOCK) += bio.o
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 56bac5c7ef408a..387b44b255f6ab 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -173,4 +173,21 @@ fscrypt_mode_supports_direct_key(const struct fscrypt_mode *mode)
 	return mode->ivsize >= offsetofend(union fscrypt_iv, nonce);
 }
 
+extern struct crypto_skcipher *
+fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
+			  const struct inode *inode);
+
+extern int fscrypt_set_derived_key(struct fscrypt_info *ci,
+				   const u8 *derived_key);
+
+/* keysetup_v1.c */
+
+extern void fscrypt_put_direct_key(struct fscrypt_direct_key *dk);
+
+extern int fscrypt_setup_v1_file_key(struct fscrypt_info *ci,
+				     const u8 *raw_master_key);
+
+extern int fscrypt_setup_v1_file_key_via_subscribed_keyrings(
+					struct fscrypt_info *ci);
+
 #endif /* _FSCRYPT_PRIVATE_H */
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index c6bf44d6411189..f4a47448e9efa1 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -8,130 +8,15 @@
  * Heavily modified since then.
  */
 
-#include <keys/user-type.h>
-#include <linux/hashtable.h>
-#include <linux/scatterlist.h>
 #include <crypto/aes.h>
-#include <crypto/algapi.h>
 #include <crypto/sha.h>
 #include <crypto/skcipher.h>
+#include <linux/key.h>
+
 #include "fscrypt_private.h"
 
 static struct crypto_shash *essiv_hash_tfm;
 
-/* Table of keys referenced by DIRECT_KEY policies */
-static DEFINE_HASHTABLE(fscrypt_direct_keys, 6); /* 6 bits = 64 buckets */
-static DEFINE_SPINLOCK(fscrypt_direct_keys_lock);
-
-/*
- * v1 key derivation function.  This generates the derived key by encrypting the
- * master key with AES-128-ECB using the nonce as the AES key.  This provides a
- * unique derived key with sufficient entropy for each inode.  However, it's
- * nonstandard, non-extensible, doesn't evenly distribute the entropy from the
- * master key, and is trivially reversible: an attacker who compromises a
- * derived key can "decrypt" it to get back to the master key, then derive any
- * other key.  For all new code, use HKDF instead.
- *
- * The master key must be at least as long as the derived key.  If the master
- * key is longer, then only the first 'derived_keysize' bytes are used.
- */
-static int derive_key_aes(const u8 *master_key,
-			  const u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE],
-			  u8 *derived_key, unsigned int derived_keysize)
-{
-	int res = 0;
-	struct skcipher_request *req = NULL;
-	DECLARE_CRYPTO_WAIT(wait);
-	struct scatterlist src_sg, dst_sg;
-	struct crypto_skcipher *tfm = crypto_alloc_skcipher("ecb(aes)", 0, 0);
-
-	if (IS_ERR(tfm)) {
-		res = PTR_ERR(tfm);
-		tfm = NULL;
-		goto out;
-	}
-	crypto_skcipher_set_flags(tfm, CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
-	req = skcipher_request_alloc(tfm, GFP_NOFS);
-	if (!req) {
-		res = -ENOMEM;
-		goto out;
-	}
-	skcipher_request_set_callback(req,
-			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
-			crypto_req_done, &wait);
-	res = crypto_skcipher_setkey(tfm, nonce, FS_KEY_DERIVATION_NONCE_SIZE);
-	if (res < 0)
-		goto out;
-
-	sg_init_one(&src_sg, master_key, derived_keysize);
-	sg_init_one(&dst_sg, derived_key, derived_keysize);
-	skcipher_request_set_crypt(req, &src_sg, &dst_sg, derived_keysize,
-				   NULL);
-	res = crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
-out:
-	skcipher_request_free(req);
-	crypto_free_skcipher(tfm);
-	return res;
-}
-
-/*
- * Search the current task's subscribed keyrings for a "logon" key with
- * description prefix:descriptor, and if found acquire a read lock on it and
- * return a pointer to its validated payload in *payload_ret.
- */
-static struct key *
-find_and_lock_process_key(const char *prefix,
-			  const u8 descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE],
-			  unsigned int min_keysize,
-			  const struct fscrypt_key **payload_ret)
-{
-	char *description;
-	struct key *key;
-	const struct user_key_payload *ukp;
-	const struct fscrypt_key *payload;
-
-	description = kasprintf(GFP_NOFS, "%s%*phN", prefix,
-				FSCRYPT_KEY_DESCRIPTOR_SIZE, descriptor);
-	if (!description)
-		return ERR_PTR(-ENOMEM);
-
-	key = request_key(&key_type_logon, description, NULL);
-	kfree(description);
-	if (IS_ERR(key))
-		return key;
-
-	down_read(&key->sem);
-	ukp = user_key_payload_locked(key);
-
-	if (!ukp) /* was the key revoked before we acquired its semaphore? */
-		goto invalid;
-
-	payload = (const struct fscrypt_key *)ukp->data;
-
-	if (ukp->datalen != sizeof(struct fscrypt_key) ||
-	    payload->size < 1 || payload->size > FSCRYPT_MAX_KEY_SIZE) {
-		fscrypt_warn(NULL,
-			     "key with description '%s' has invalid payload",
-			     key->description);
-		goto invalid;
-	}
-
-	if (payload->size < min_keysize) {
-		fscrypt_warn(NULL,
-			     "key with description '%s' is too short (got %u bytes, need %u+ bytes)",
-			     key->description, payload->size, min_keysize);
-		goto invalid;
-	}
-
-	*payload_ret = payload;
-	return key;
-
-invalid:
-	up_read(&key->sem);
-	key_put(key);
-	return ERR_PTR(-ENOKEY);
-}
-
 static struct fscrypt_mode available_modes[] = {
 	[FSCRYPT_MODE_AES_256_XTS] = {
 		.friendly_name = "AES-256-XTS",
@@ -188,9 +73,9 @@ select_encryption_mode(const struct fscrypt_info *ci, const struct inode *inode)
 }
 
 /* Create a symmetric cipher object for the given encryption mode and key */
-static struct crypto_skcipher *
-fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
-			  const struct inode *inode)
+struct crypto_skcipher *fscrypt_allocate_skcipher(struct fscrypt_mode *mode,
+						  const u8 *raw_key,
+						  const struct inode *inode)
 {
 	struct crypto_skcipher *tfm;
 	int err;
@@ -232,113 +117,6 @@ fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
 	return ERR_PTR(err);
 }
 
-/* Master key referenced by DIRECT_KEY policy */
-struct fscrypt_direct_key {
-	struct hlist_node		dk_node;
-	refcount_t			dk_refcount;
-	const struct fscrypt_mode	*dk_mode;
-	struct crypto_skcipher		*dk_ctfm;
-	u8				dk_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
-	u8				dk_raw[FSCRYPT_MAX_KEY_SIZE];
-};
-
-static void free_direct_key(struct fscrypt_direct_key *dk)
-{
-	if (dk) {
-		crypto_free_skcipher(dk->dk_ctfm);
-		kzfree(dk);
-	}
-}
-
-static void put_direct_key(struct fscrypt_direct_key *dk)
-{
-	if (!refcount_dec_and_lock(&dk->dk_refcount, &fscrypt_direct_keys_lock))
-		return;
-	hash_del(&dk->dk_node);
-	spin_unlock(&fscrypt_direct_keys_lock);
-
-	free_direct_key(dk);
-}
-
-/*
- * Find/insert the given key into the fscrypt_direct_keys table.  If found, it
- * is returned with elevated refcount, and 'to_insert' is freed if non-NULL.  If
- * not found, 'to_insert' is inserted and returned if it's non-NULL; otherwise
- * NULL is returned.
- */
-static struct fscrypt_direct_key *
-find_or_insert_direct_key(struct fscrypt_direct_key *to_insert,
-			  const u8 *raw_key, const struct fscrypt_info *ci)
-{
-	unsigned long hash_key;
-	struct fscrypt_direct_key *dk;
-
-	/*
-	 * Careful: to avoid potentially leaking secret key bytes via timing
-	 * information, we must key the hash table by descriptor rather than by
-	 * raw key, and use crypto_memneq() when comparing raw keys.
-	 */
-
-	BUILD_BUG_ON(sizeof(hash_key) > FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	memcpy(&hash_key, ci->ci_master_key_descriptor, sizeof(hash_key));
-
-	spin_lock(&fscrypt_direct_keys_lock);
-	hash_for_each_possible(fscrypt_direct_keys, dk, dk_node, hash_key) {
-		if (memcmp(ci->ci_master_key_descriptor, dk->dk_descriptor,
-			   FSCRYPT_KEY_DESCRIPTOR_SIZE) != 0)
-			continue;
-		if (ci->ci_mode != dk->dk_mode)
-			continue;
-		if (crypto_memneq(raw_key, dk->dk_raw, ci->ci_mode->keysize))
-			continue;
-		/* using existing tfm with same (descriptor, mode, raw_key) */
-		refcount_inc(&dk->dk_refcount);
-		spin_unlock(&fscrypt_direct_keys_lock);
-		free_direct_key(to_insert);
-		return dk;
-	}
-	if (to_insert)
-		hash_add(fscrypt_direct_keys, &to_insert->dk_node, hash_key);
-	spin_unlock(&fscrypt_direct_keys_lock);
-	return to_insert;
-}
-
-/* Prepare to encrypt directly using the master key in the given mode */
-static struct fscrypt_direct_key *
-fscrypt_get_direct_key(const struct fscrypt_info *ci, const u8 *raw_key)
-{
-	struct fscrypt_direct_key *dk;
-	int err;
-
-	/* Is there already a tfm for this key? */
-	dk = find_or_insert_direct_key(NULL, raw_key, ci);
-	if (dk)
-		return dk;
-
-	/* Nope, allocate one. */
-	dk = kzalloc(sizeof(*dk), GFP_NOFS);
-	if (!dk)
-		return ERR_PTR(-ENOMEM);
-	refcount_set(&dk->dk_refcount, 1);
-	dk->dk_mode = ci->ci_mode;
-	dk->dk_ctfm = fscrypt_allocate_skcipher(ci->ci_mode, raw_key,
-						ci->ci_inode);
-	if (IS_ERR(dk->dk_ctfm)) {
-		err = PTR_ERR(dk->dk_ctfm);
-		dk->dk_ctfm = NULL;
-		goto err_free_dk;
-	}
-	memcpy(dk->dk_descriptor, ci->ci_master_key_descriptor,
-	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	memcpy(dk->dk_raw, raw_key, ci->ci_mode->keysize);
-
-	return find_or_insert_direct_key(dk, raw_key, ci);
-
-err_free_dk:
-	free_direct_key(dk);
-	return ERR_PTR(err);
-}
-
 static int derive_essiv_salt(const u8 *key, int keysize, u8 *salt)
 {
 	struct crypto_shash *tfm = READ_ONCE(essiv_hash_tfm);
@@ -409,8 +187,7 @@ static int init_essiv_generator(struct fscrypt_info *ci, const u8 *raw_key,
 }
 
 /* Given the per-file key, set up the file's crypto transform object(s) */
-static int fscrypt_set_derived_key(struct fscrypt_info *ci,
-				   const u8 *derived_key)
+int fscrypt_set_derived_key(struct fscrypt_info *ci, const u8 *derived_key)
 {
 	struct fscrypt_mode *mode = ci->ci_mode;
 	struct crypto_skcipher *ctfm;
@@ -434,97 +211,6 @@ static int fscrypt_set_derived_key(struct fscrypt_info *ci,
 	return 0;
 }
 
-/* v1 policy, DIRECT_KEY: use the master key directly */
-static int setup_v1_file_key_direct(struct fscrypt_info *ci,
-				    const u8 *raw_master_key)
-{
-	const struct fscrypt_mode *mode = ci->ci_mode;
-	struct fscrypt_direct_key *dk;
-
-	if (!fscrypt_mode_supports_direct_key(mode)) {
-		fscrypt_warn(ci->ci_inode,
-			     "Direct key mode not allowed with %s",
-			     mode->friendly_name);
-		return -EINVAL;
-	}
-
-	if (ci->ci_data_mode != ci->ci_filename_mode) {
-		fscrypt_warn(ci->ci_inode,
-			     "Direct key mode not allowed with different contents and filenames modes");
-		return -EINVAL;
-	}
-
-	/* ESSIV implies 16-byte IVs which implies !DIRECT_KEY */
-	if (WARN_ON(mode->needs_essiv))
-		return -EINVAL;
-
-	dk = fscrypt_get_direct_key(ci, raw_master_key);
-	if (IS_ERR(dk))
-		return PTR_ERR(dk);
-	ci->ci_direct_key = dk;
-	ci->ci_ctfm = dk->dk_ctfm;
-	return 0;
-}
-
-/* v1 policy, !DIRECT_KEY: derive the file's encryption key */
-static int setup_v1_file_key_derived(struct fscrypt_info *ci,
-				     const u8 *raw_master_key)
-{
-	u8 *derived_key;
-	int err;
-
-	/*
-	 * This cannot be a stack buffer because it will be passed to the
-	 * scatterlist crypto API during derive_key_aes().
-	 */
-	derived_key = kmalloc(ci->ci_mode->keysize, GFP_NOFS);
-	if (!derived_key)
-		return -ENOMEM;
-
-	err = derive_key_aes(raw_master_key, ci->ci_nonce,
-			     derived_key, ci->ci_mode->keysize);
-	if (err)
-		goto out;
-
-	err = fscrypt_set_derived_key(ci, derived_key);
-out:
-	kzfree(derived_key);
-	return err;
-}
-
-static int fscrypt_setup_v1_file_key(struct fscrypt_info *ci,
-				     const u8 *raw_master_key)
-{
-	if (ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
-		return setup_v1_file_key_direct(ci, raw_master_key);
-	else
-		return setup_v1_file_key_derived(ci, raw_master_key);
-}
-
-static int fscrypt_setup_v1_file_key_via_subscribed_keyrings(
-						struct fscrypt_info *ci)
-{
-	struct key *key;
-	const struct fscrypt_key *payload;
-	int err;
-
-	key = find_and_lock_process_key(FSCRYPT_KEY_DESC_PREFIX,
-					ci->ci_master_key_descriptor,
-					ci->ci_mode->keysize, &payload);
-	if (key == ERR_PTR(-ENOKEY) && ci->ci_inode->i_sb->s_cop->key_prefix) {
-		key = find_and_lock_process_key(ci->ci_inode->i_sb->s_cop->key_prefix,
-						ci->ci_master_key_descriptor,
-						ci->ci_mode->keysize, &payload);
-	}
-	if (IS_ERR(key))
-		return PTR_ERR(key);
-
-	err = fscrypt_setup_v1_file_key(ci, payload->raw);
-	up_read(&key->sem);
-	key_put(key);
-	return err;
-}
-
 /*
  * Find the master key, then set up the inode's actual encryption key.
  */
@@ -539,7 +225,7 @@ static void put_crypt_info(struct fscrypt_info *ci)
 		return;
 
 	if (ci->ci_direct_key) {
-		put_direct_key(ci->ci_direct_key);
+		fscrypt_put_direct_key(ci->ci_direct_key);
 	} else {
 		crypto_free_skcipher(ci->ci_ctfm);
 		crypto_free_cipher(ci->ci_essiv_tfm);
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
new file mode 100644
index 00000000000000..631690bb6ed54c
--- /dev/null
+++ b/fs/crypto/keysetup_v1.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Key setup for v1 encryption policies
+ *
+ * Copyright 2015, 2019 Google LLC
+ */
+
+/*
+ * This file implements compatibility functions for the original encryption
+ * policy version ("v1"), including:
+ *
+ * - Deriving per-file keys using the AES-128-ECB based KDF
+ *   (rather than the new method of using HKDF-SHA512)
+ *
+ * - Retrieving fscrypt master keys from process-subscribed keyrings
+ *   (rather than the new method of using a filesystem-level keyring)
+ *
+ * - Handling policies with the DIRECT_KEY flag set using a master key table
+ *   (rather than the new method of implementing DIRECT_KEY with per-mode keys
+ *    managed alongside the master keys in the filesystem-level keyring)
+ */
+
+#include <crypto/algapi.h>
+#include <crypto/skcipher.h>
+#include <keys/user-type.h>
+#include <linux/hashtable.h>
+#include <linux/scatterlist.h>
+
+#include "fscrypt_private.h"
+
+/* Table of keys referenced by DIRECT_KEY policies */
+static DEFINE_HASHTABLE(fscrypt_direct_keys, 6); /* 6 bits = 64 buckets */
+static DEFINE_SPINLOCK(fscrypt_direct_keys_lock);
+
+/*
+ * v1 key derivation function.  This generates the derived key by encrypting the
+ * master key with AES-128-ECB using the nonce as the AES key.  This provides a
+ * unique derived key with sufficient entropy for each inode.  However, it's
+ * nonstandard, non-extensible, doesn't evenly distribute the entropy from the
+ * master key, and is trivially reversible: an attacker who compromises a
+ * derived key can "decrypt" it to get back to the master key, then derive any
+ * other key.  For all new code, use HKDF instead.
+ *
+ * The master key must be at least as long as the derived key.  If the master
+ * key is longer, then only the first 'derived_keysize' bytes are used.
+ */
+static int derive_key_aes(const u8 *master_key,
+			  const u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE],
+			  u8 *derived_key, unsigned int derived_keysize)
+{
+	int res = 0;
+	struct skcipher_request *req = NULL;
+	DECLARE_CRYPTO_WAIT(wait);
+	struct scatterlist src_sg, dst_sg;
+	struct crypto_skcipher *tfm = crypto_alloc_skcipher("ecb(aes)", 0, 0);
+
+	if (IS_ERR(tfm)) {
+		res = PTR_ERR(tfm);
+		tfm = NULL;
+		goto out;
+	}
+	crypto_skcipher_set_flags(tfm, CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
+	req = skcipher_request_alloc(tfm, GFP_NOFS);
+	if (!req) {
+		res = -ENOMEM;
+		goto out;
+	}
+	skcipher_request_set_callback(req,
+			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+			crypto_req_done, &wait);
+	res = crypto_skcipher_setkey(tfm, nonce, FS_KEY_DERIVATION_NONCE_SIZE);
+	if (res < 0)
+		goto out;
+
+	sg_init_one(&src_sg, master_key, derived_keysize);
+	sg_init_one(&dst_sg, derived_key, derived_keysize);
+	skcipher_request_set_crypt(req, &src_sg, &dst_sg, derived_keysize,
+				   NULL);
+	res = crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
+out:
+	skcipher_request_free(req);
+	crypto_free_skcipher(tfm);
+	return res;
+}
+
+/*
+ * Search the current task's subscribed keyrings for a "logon" key with
+ * description prefix:descriptor, and if found acquire a read lock on it and
+ * return a pointer to its validated payload in *payload_ret.
+ */
+static struct key *
+find_and_lock_process_key(const char *prefix,
+			  const u8 descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE],
+			  unsigned int min_keysize,
+			  const struct fscrypt_key **payload_ret)
+{
+	char *description;
+	struct key *key;
+	const struct user_key_payload *ukp;
+	const struct fscrypt_key *payload;
+
+	description = kasprintf(GFP_NOFS, "%s%*phN", prefix,
+				FSCRYPT_KEY_DESCRIPTOR_SIZE, descriptor);
+	if (!description)
+		return ERR_PTR(-ENOMEM);
+
+	key = request_key(&key_type_logon, description, NULL);
+	kfree(description);
+	if (IS_ERR(key))
+		return key;
+
+	down_read(&key->sem);
+	ukp = user_key_payload_locked(key);
+
+	if (!ukp) /* was the key revoked before we acquired its semaphore? */
+		goto invalid;
+
+	payload = (const struct fscrypt_key *)ukp->data;
+
+	if (ukp->datalen != sizeof(struct fscrypt_key) ||
+	    payload->size < 1 || payload->size > FSCRYPT_MAX_KEY_SIZE) {
+		fscrypt_warn(NULL,
+			     "key with description '%s' has invalid payload",
+			     key->description);
+		goto invalid;
+	}
+
+	if (payload->size < min_keysize) {
+		fscrypt_warn(NULL,
+			     "key with description '%s' is too short (got %u bytes, need %u+ bytes)",
+			     key->description, payload->size, min_keysize);
+		goto invalid;
+	}
+
+	*payload_ret = payload;
+	return key;
+
+invalid:
+	up_read(&key->sem);
+	key_put(key);
+	return ERR_PTR(-ENOKEY);
+}
+
+/* Master key referenced by DIRECT_KEY policy */
+struct fscrypt_direct_key {
+	struct hlist_node		dk_node;
+	refcount_t			dk_refcount;
+	const struct fscrypt_mode	*dk_mode;
+	struct crypto_skcipher		*dk_ctfm;
+	u8				dk_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+	u8				dk_raw[FSCRYPT_MAX_KEY_SIZE];
+};
+
+static void free_direct_key(struct fscrypt_direct_key *dk)
+{
+	if (dk) {
+		crypto_free_skcipher(dk->dk_ctfm);
+		kzfree(dk);
+	}
+}
+
+void fscrypt_put_direct_key(struct fscrypt_direct_key *dk)
+{
+	if (!refcount_dec_and_lock(&dk->dk_refcount, &fscrypt_direct_keys_lock))
+		return;
+	hash_del(&dk->dk_node);
+	spin_unlock(&fscrypt_direct_keys_lock);
+
+	free_direct_key(dk);
+}
+
+/*
+ * Find/insert the given key into the fscrypt_direct_keys table.  If found, it
+ * is returned with elevated refcount, and 'to_insert' is freed if non-NULL.  If
+ * not found, 'to_insert' is inserted and returned if it's non-NULL; otherwise
+ * NULL is returned.
+ */
+static struct fscrypt_direct_key *
+find_or_insert_direct_key(struct fscrypt_direct_key *to_insert,
+			  const u8 *raw_key, const struct fscrypt_info *ci)
+{
+	unsigned long hash_key;
+	struct fscrypt_direct_key *dk;
+
+	/*
+	 * Careful: to avoid potentially leaking secret key bytes via timing
+	 * information, we must key the hash table by descriptor rather than by
+	 * raw key, and use crypto_memneq() when comparing raw keys.
+	 */
+
+	BUILD_BUG_ON(sizeof(hash_key) > FSCRYPT_KEY_DESCRIPTOR_SIZE);
+	memcpy(&hash_key, ci->ci_master_key_descriptor, sizeof(hash_key));
+
+	spin_lock(&fscrypt_direct_keys_lock);
+	hash_for_each_possible(fscrypt_direct_keys, dk, dk_node, hash_key) {
+		if (memcmp(ci->ci_master_key_descriptor, dk->dk_descriptor,
+			   FSCRYPT_KEY_DESCRIPTOR_SIZE) != 0)
+			continue;
+		if (ci->ci_mode != dk->dk_mode)
+			continue;
+		if (crypto_memneq(raw_key, dk->dk_raw, ci->ci_mode->keysize))
+			continue;
+		/* using existing tfm with same (descriptor, mode, raw_key) */
+		refcount_inc(&dk->dk_refcount);
+		spin_unlock(&fscrypt_direct_keys_lock);
+		free_direct_key(to_insert);
+		return dk;
+	}
+	if (to_insert)
+		hash_add(fscrypt_direct_keys, &to_insert->dk_node, hash_key);
+	spin_unlock(&fscrypt_direct_keys_lock);
+	return to_insert;
+}
+
+/* Prepare to encrypt directly using the master key in the given mode */
+static struct fscrypt_direct_key *
+fscrypt_get_direct_key(const struct fscrypt_info *ci, const u8 *raw_key)
+{
+	struct fscrypt_direct_key *dk;
+	int err;
+
+	/* Is there already a tfm for this key? */
+	dk = find_or_insert_direct_key(NULL, raw_key, ci);
+	if (dk)
+		return dk;
+
+	/* Nope, allocate one. */
+	dk = kzalloc(sizeof(*dk), GFP_NOFS);
+	if (!dk)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&dk->dk_refcount, 1);
+	dk->dk_mode = ci->ci_mode;
+	dk->dk_ctfm = fscrypt_allocate_skcipher(ci->ci_mode, raw_key,
+						ci->ci_inode);
+	if (IS_ERR(dk->dk_ctfm)) {
+		err = PTR_ERR(dk->dk_ctfm);
+		dk->dk_ctfm = NULL;
+		goto err_free_dk;
+	}
+	memcpy(dk->dk_descriptor, ci->ci_master_key_descriptor,
+	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
+	memcpy(dk->dk_raw, raw_key, ci->ci_mode->keysize);
+
+	return find_or_insert_direct_key(dk, raw_key, ci);
+
+err_free_dk:
+	free_direct_key(dk);
+	return ERR_PTR(err);
+}
+
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
+int fscrypt_setup_v1_file_key(struct fscrypt_info *ci, const u8 *raw_master_key)
+{
+	if (ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
+		return setup_v1_file_key_direct(ci, raw_master_key);
+	else
+		return setup_v1_file_key_derived(ci, raw_master_key);
+}
+
+int fscrypt_setup_v1_file_key_via_subscribed_keyrings(struct fscrypt_info *ci)
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
-- 
2.22.0.770.g0f2c4a37fd-goog

