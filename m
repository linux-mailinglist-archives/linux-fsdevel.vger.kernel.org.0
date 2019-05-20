Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2A23E9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 19:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392955AbfETR2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 13:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392925AbfETR2v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 13:28:51 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B56ED2173B;
        Mon, 20 May 2019 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558373328;
        bh=tGympd3OC6z9eHgkISNLWzW5dVy23vkOyOW9DDh9sqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1LgZRrfg6PqygeQuI6cKpTjxSDFAn1NiRi/bVKG745P+SJuzSym+pHmNfP6TwL5b
         uHjoBnIBIiy4M/4EKe5peciitG9TQVZg1rQhgeb9oPoN6vQe4StElWEkHqW8QxTGRR
         Mhv9ppouj1qcW2EU3XYhhiKyAhvpndVOYZmyTBUQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, keyrings@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>
Subject: [PATCH v6 05/16] fscrypt: refactor v1 policy key setup into keysetup_legacy.c
Date:   Mon, 20 May 2019 10:25:41 -0700
Message-Id: <20190520172552.217253-6-ebiggers@kernel.org>
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

In preparation for introducing v2 encryption policies which will find
and derive encryption keys differently from the current v1 encryption
policies, refactor the v1 policy-specific key setup code from keyinfo.c
into keysetup_legacy.c.  Then rename keyinfo.c to keysetup.c.

Note: the code moved into keysetup_legacy.c includes the table of master
keys referenced by v1 DIRECT_KEY policies.  I've chosen to keep this
table as-is rather than trying to replace it with using the
filesystem-level keyring, since the latter would add more complexity
than it would save especially given the requirement to continue to
support the keys actually being provided in a process-subscribed
keyring.  However, to distinguish the structures in this table from the
structures that will go in the filesystem-level keyring, I renamed them
from 'struct fscrypt_master_key' to 'struct fscrypt_direct_key'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/Makefile          |   8 +-
 fs/crypto/fscrypt_private.h |  37 ++-
 fs/crypto/keyinfo.c         | 615 ------------------------------------
 fs/crypto/keysetup.c        | 329 +++++++++++++++++++
 fs/crypto/keysetup_legacy.c | 338 ++++++++++++++++++++
 include/linux/fscrypt.h     |   4 +-
 6 files changed, 705 insertions(+), 626 deletions(-)
 delete mode 100644 fs/crypto/keyinfo.c
 create mode 100644 fs/crypto/keysetup.c
 create mode 100644 fs/crypto/keysetup_legacy.c

diff --git a/fs/crypto/Makefile b/fs/crypto/Makefile
index cb496989a6b69..75c0c29fcc627 100644
--- a/fs/crypto/Makefile
+++ b/fs/crypto/Makefile
@@ -1,4 +1,10 @@
 obj-$(CONFIG_FS_ENCRYPTION)	+= fscrypto.o
 
-fscrypto-y := crypto.o fname.o hooks.o keyinfo.o policy.o
+fscrypto-y := crypto.o \
+	      fname.o \
+	      hooks.o \
+	      keysetup.o \
+	      keysetup_legacy.o \
+	      policy.o
+
 fscrypto-$(CONFIG_BLOCK) += bio.o
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index ac24edfc297f1..c5a8181fc26c1 100644
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
@@ -77,11 +76,10 @@ struct fscrypt_info {
 	struct inode *ci_inode;
 
 	/*
-	 * If non-NULL, then this inode uses a master key directly rather than a
-	 * derived key, and ci_ctfm will equal ci_master_key->mk_ctfm.
-	 * Otherwise, this inode uses a derived key.
+	 * If non-NULL, then encryption is done using the master key directly
+	 * and ci_ctfm will equal ci_direct_key->dk_ctfm.
 	 */
-	struct fscrypt_master_key *ci_master_key;
+	struct fscrypt_direct_key *ci_direct_key;
 
 	/* fields from the fscrypt_context */
 	u8 ci_data_mode;
@@ -161,7 +159,7 @@ extern bool fscrypt_fname_encrypted_size(const struct inode *inode,
 					 u32 orig_len, u32 max_len,
 					 u32 *encrypted_len_ret);
 
-/* keyinfo.c */
+/* keysetup.c */
 
 struct fscrypt_mode {
 	const char *friendly_name;
@@ -172,6 +170,29 @@ struct fscrypt_mode {
 	bool needs_essiv;
 };
 
+static inline bool
+fscrypt_mode_supports_direct_key(const struct fscrypt_mode *mode)
+{
+	return mode->ivsize >= offsetofend(union fscrypt_iv, nonce);
+}
+
+extern struct crypto_skcipher *
+fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
+			  const struct inode *inode);
+
+extern int fscrypt_set_derived_key(struct fscrypt_info *ci,
+				   const u8 *derived_key);
+
 extern void __exit fscrypt_essiv_cleanup(void);
 
+/* keysetup_legacy.c */
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
deleted file mode 100644
index 49764d335c370..0000000000000
--- a/fs/crypto/keyinfo.c
+++ /dev/null
@@ -1,615 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * key management facility for FS encryption support.
- *
- * Copyright (C) 2015, Google, Inc.
- *
- * This contains encryption key functions.
- *
- * Written by Michael Halcrow, Ildar Muslukhov, and Uday Savagaonkar, 2015.
- */
-
-#include <keys/user-type.h>
-#include <linux/hashtable.h>
-#include <linux/scatterlist.h>
-#include <linux/ratelimit.h>
-#include <crypto/aes.h>
-#include <crypto/algapi.h>
-#include <crypto/sha.h>
-#include <crypto/skcipher.h>
-#include "fscrypt_private.h"
-
-static struct crypto_shash *essiv_hash_tfm;
-
-/* Table of keys referenced by DIRECT_KEY policies */
-static DEFINE_HASHTABLE(fscrypt_master_keys, 6); /* 6 bits = 64 buckets */
-static DEFINE_SPINLOCK(fscrypt_master_keys_lock);
-
-/*
- * Key derivation function.  This generates the derived key by encrypting the
- * master key with AES-128-ECB using the inode's nonce as the AES key.
- *
- * The master key must be at least as long as the derived key.  If the master
- * key is longer, then only the first 'derived_keysize' bytes are used.
- */
-static int derive_key_aes(const u8 *master_key,
-			  const struct fscrypt_context *ctx,
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
-	res = crypto_skcipher_setkey(tfm, ctx->nonce, sizeof(ctx->nonce));
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
-static struct fscrypt_mode available_modes[] = {
-	[FSCRYPT_MODE_AES_256_XTS] = {
-		.friendly_name = "AES-256-XTS",
-		.cipher_str = "xts(aes)",
-		.keysize = 64,
-		.ivsize = 16,
-	},
-	[FSCRYPT_MODE_AES_256_CTS] = {
-		.friendly_name = "AES-256-CTS-CBC",
-		.cipher_str = "cts(cbc(aes))",
-		.keysize = 32,
-		.ivsize = 16,
-	},
-	[FSCRYPT_MODE_AES_128_CBC] = {
-		.friendly_name = "AES-128-CBC",
-		.cipher_str = "cbc(aes)",
-		.keysize = 16,
-		.ivsize = 16,
-		.needs_essiv = true,
-	},
-	[FSCRYPT_MODE_AES_128_CTS] = {
-		.friendly_name = "AES-128-CTS-CBC",
-		.cipher_str = "cts(cbc(aes))",
-		.keysize = 16,
-		.ivsize = 16,
-	},
-	[FSCRYPT_MODE_ADIANTUM] = {
-		.friendly_name = "Adiantum",
-		.cipher_str = "adiantum(xchacha12,aes)",
-		.keysize = 32,
-		.ivsize = 32,
-	},
-};
-
-static struct fscrypt_mode *
-select_encryption_mode(const struct fscrypt_info *ci, const struct inode *inode)
-{
-	if (!fscrypt_valid_enc_modes(ci->ci_data_mode, ci->ci_filename_mode)) {
-		fscrypt_warn(inode->i_sb,
-			     "inode %lu uses unsupported encryption modes (contents mode %d, filenames mode %d)",
-			     inode->i_ino, ci->ci_data_mode,
-			     ci->ci_filename_mode);
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (S_ISREG(inode->i_mode))
-		return &available_modes[ci->ci_data_mode];
-
-	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
-		return &available_modes[ci->ci_filename_mode];
-
-	WARN_ONCE(1, "fscrypt: filesystem tried to load encryption info for inode %lu, which is not encryptable (file type %d)\n",
-		  inode->i_ino, (inode->i_mode & S_IFMT));
-	return ERR_PTR(-EINVAL);
-}
-
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
-			fscrypt_warn(inode->i_sb,
-				     "direct key mode not allowed with %s",
-				     mode->friendly_name);
-			err = -EINVAL;
-		} else if (ctx->contents_encryption_mode !=
-			   ctx->filenames_encryption_mode) {
-			fscrypt_warn(inode->i_sb,
-				     "direct key mode not allowed with different contents and filenames modes");
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
-static struct crypto_skcipher *
-allocate_skcipher_for_mode(struct fscrypt_mode *mode, const u8 *raw_key,
-			   const struct inode *inode)
-{
-	struct crypto_skcipher *tfm;
-	int err;
-
-	tfm = crypto_alloc_skcipher(mode->cipher_str, 0, 0);
-	if (IS_ERR(tfm)) {
-		fscrypt_warn(inode->i_sb,
-			     "error allocating '%s' transform for inode %lu: %ld",
-			     mode->cipher_str, inode->i_ino, PTR_ERR(tfm));
-		return tfm;
-	}
-	if (unlikely(!mode->logged_impl_name)) {
-		/*
-		 * fscrypt performance can vary greatly depending on which
-		 * crypto algorithm implementation is used.  Help people debug
-		 * performance problems by logging the ->cra_driver_name the
-		 * first time a mode is used.  Note that multiple threads can
-		 * race here, but it doesn't really matter.
-		 */
-		mode->logged_impl_name = true;
-		pr_info("fscrypt: %s using implementation \"%s\"\n",
-			mode->friendly_name,
-			crypto_skcipher_alg(tfm)->base.cra_driver_name);
-	}
-	crypto_skcipher_set_flags(tfm, CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
-	err = crypto_skcipher_setkey(tfm, raw_key, mode->keysize);
-	if (err)
-		goto err_free_tfm;
-
-	return tfm;
-
-err_free_tfm:
-	crypto_free_skcipher(tfm);
-	return ERR_PTR(err);
-}
-
-/* Master key referenced by DIRECT_KEY policy */
-struct fscrypt_master_key {
-	struct hlist_node mk_node;
-	refcount_t mk_refcount;
-	const struct fscrypt_mode *mk_mode;
-	struct crypto_skcipher *mk_ctfm;
-	u8 mk_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
-	u8 mk_raw[FSCRYPT_MAX_KEY_SIZE];
-};
-
-static void free_master_key(struct fscrypt_master_key *mk)
-{
-	if (mk) {
-		crypto_free_skcipher(mk->mk_ctfm);
-		kzfree(mk);
-	}
-}
-
-static void put_master_key(struct fscrypt_master_key *mk)
-{
-	if (!refcount_dec_and_lock(&mk->mk_refcount, &fscrypt_master_keys_lock))
-		return;
-	hash_del(&mk->mk_node);
-	spin_unlock(&fscrypt_master_keys_lock);
-
-	free_master_key(mk);
-}
-
-/*
- * Find/insert the given master key into the fscrypt_master_keys table.  If
- * found, it is returned with elevated refcount, and 'to_insert' is freed if
- * non-NULL.  If not found, 'to_insert' is inserted and returned if it's
- * non-NULL; otherwise NULL is returned.
- */
-static struct fscrypt_master_key *
-find_or_insert_master_key(struct fscrypt_master_key *to_insert,
-			  const u8 *raw_key, const struct fscrypt_mode *mode,
-			  const struct fscrypt_info *ci)
-{
-	unsigned long hash_key;
-	struct fscrypt_master_key *mk;
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
-	spin_lock(&fscrypt_master_keys_lock);
-	hash_for_each_possible(fscrypt_master_keys, mk, mk_node, hash_key) {
-		if (memcmp(ci->ci_master_key_descriptor, mk->mk_descriptor,
-			   FSCRYPT_KEY_DESCRIPTOR_SIZE) != 0)
-			continue;
-		if (mode != mk->mk_mode)
-			continue;
-		if (crypto_memneq(raw_key, mk->mk_raw, mode->keysize))
-			continue;
-		/* using existing tfm with same (descriptor, mode, raw_key) */
-		refcount_inc(&mk->mk_refcount);
-		spin_unlock(&fscrypt_master_keys_lock);
-		free_master_key(to_insert);
-		return mk;
-	}
-	if (to_insert)
-		hash_add(fscrypt_master_keys, &to_insert->mk_node, hash_key);
-	spin_unlock(&fscrypt_master_keys_lock);
-	return to_insert;
-}
-
-/* Prepare to encrypt directly using the master key in the given mode */
-static struct fscrypt_master_key *
-fscrypt_get_master_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
-		       const u8 *raw_key, const struct inode *inode)
-{
-	struct fscrypt_master_key *mk;
-	int err;
-
-	/* Is there already a tfm for this key? */
-	mk = find_or_insert_master_key(NULL, raw_key, mode, ci);
-	if (mk)
-		return mk;
-
-	/* Nope, allocate one. */
-	mk = kzalloc(sizeof(*mk), GFP_NOFS);
-	if (!mk)
-		return ERR_PTR(-ENOMEM);
-	refcount_set(&mk->mk_refcount, 1);
-	mk->mk_mode = mode;
-	mk->mk_ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
-	if (IS_ERR(mk->mk_ctfm)) {
-		err = PTR_ERR(mk->mk_ctfm);
-		mk->mk_ctfm = NULL;
-		goto err_free_mk;
-	}
-	memcpy(mk->mk_descriptor, ci->ci_master_key_descriptor,
-	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	memcpy(mk->mk_raw, raw_key, mode->keysize);
-
-	return find_or_insert_master_key(mk, raw_key, mode, ci);
-
-err_free_mk:
-	free_master_key(mk);
-	return ERR_PTR(err);
-}
-
-static int derive_essiv_salt(const u8 *key, int keysize, u8 *salt)
-{
-	struct crypto_shash *tfm = READ_ONCE(essiv_hash_tfm);
-
-	/* init hash transform on demand */
-	if (unlikely(!tfm)) {
-		struct crypto_shash *prev_tfm;
-
-		tfm = crypto_alloc_shash("sha256", 0, 0);
-		if (IS_ERR(tfm)) {
-			fscrypt_warn(NULL,
-				     "error allocating SHA-256 transform: %ld",
-				     PTR_ERR(tfm));
-			return PTR_ERR(tfm);
-		}
-		prev_tfm = cmpxchg(&essiv_hash_tfm, NULL, tfm);
-		if (prev_tfm) {
-			crypto_free_shash(tfm);
-			tfm = prev_tfm;
-		}
-	}
-
-	{
-		SHASH_DESC_ON_STACK(desc, tfm);
-		desc->tfm = tfm;
-
-		return crypto_shash_digest(desc, key, keysize, salt);
-	}
-}
-
-static int init_essiv_generator(struct fscrypt_info *ci, const u8 *raw_key,
-				int keysize)
-{
-	int err;
-	struct crypto_cipher *essiv_tfm;
-	u8 salt[SHA256_DIGEST_SIZE];
-
-	essiv_tfm = crypto_alloc_cipher("aes", 0, 0);
-	if (IS_ERR(essiv_tfm))
-		return PTR_ERR(essiv_tfm);
-
-	ci->ci_essiv_tfm = essiv_tfm;
-
-	err = derive_essiv_salt(raw_key, keysize, salt);
-	if (err)
-		goto out;
-
-	/*
-	 * Using SHA256 to derive the salt/key will result in AES-256 being
-	 * used for IV generation. File contents encryption will still use the
-	 * configured keysize (AES-128) nevertheless.
-	 */
-	err = crypto_cipher_setkey(essiv_tfm, salt, sizeof(salt));
-	if (err)
-		goto out;
-
-out:
-	memzero_explicit(salt, sizeof(salt));
-	return err;
-}
-
-void __exit fscrypt_essiv_cleanup(void)
-{
-	crypto_free_shash(essiv_hash_tfm);
-}
-
-/*
- * Given the encryption mode and key (normally the derived key, but for
- * DIRECT_KEY mode it's the master key), set up the inode's symmetric cipher
- * transform object(s).
- */
-static int setup_crypto_transform(struct fscrypt_info *ci,
-				  struct fscrypt_mode *mode,
-				  const u8 *raw_key, const struct inode *inode)
-{
-	struct fscrypt_master_key *mk;
-	struct crypto_skcipher *ctfm;
-	int err;
-
-	if (ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
-		mk = fscrypt_get_master_key(ci, mode, raw_key, inode);
-		if (IS_ERR(mk))
-			return PTR_ERR(mk);
-		ctfm = mk->mk_ctfm;
-	} else {
-		mk = NULL;
-		ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
-		if (IS_ERR(ctfm))
-			return PTR_ERR(ctfm);
-	}
-	ci->ci_master_key = mk;
-	ci->ci_ctfm = ctfm;
-
-	if (mode->needs_essiv) {
-		/* ESSIV implies 16-byte IVs which implies !DIRECT_KEY */
-		WARN_ON(mode->ivsize != AES_BLOCK_SIZE);
-		WARN_ON(ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY);
-
-		err = init_essiv_generator(ci, raw_key, mode->keysize);
-		if (err) {
-			fscrypt_warn(inode->i_sb,
-				     "error initializing ESSIV generator for inode %lu: %d",
-				     inode->i_ino, err);
-			return err;
-		}
-	}
-	return 0;
-}
-
-static void put_crypt_info(struct fscrypt_info *ci)
-{
-	if (!ci)
-		return;
-
-	if (ci->ci_master_key) {
-		put_master_key(ci->ci_master_key);
-	} else {
-		crypto_free_skcipher(ci->ci_ctfm);
-		crypto_free_cipher(ci->ci_essiv_tfm);
-	}
-	kmem_cache_free(fscrypt_info_cachep, ci);
-}
-
-int fscrypt_get_encryption_info(struct inode *inode)
-{
-	struct fscrypt_info *crypt_info;
-	struct fscrypt_context ctx;
-	struct fscrypt_mode *mode;
-	u8 *raw_key = NULL;
-	int res;
-
-	if (fscrypt_has_encryption_key(inode))
-		return 0;
-
-	res = fscrypt_initialize(inode->i_sb->s_cop->flags);
-	if (res)
-		return res;
-
-	res = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
-	if (res < 0) {
-		if (!fscrypt_dummy_context_enabled(inode) ||
-		    IS_ENCRYPTED(inode))
-			return res;
-		/* Fake up a context for an unencrypted directory */
-		memset(&ctx, 0, sizeof(ctx));
-		ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
-		ctx.contents_encryption_mode = FSCRYPT_MODE_AES_256_XTS;
-		ctx.filenames_encryption_mode = FSCRYPT_MODE_AES_256_CTS;
-		memset(ctx.master_key_descriptor, 0x42,
-		       FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	} else if (res != sizeof(ctx)) {
-		return -EINVAL;
-	}
-
-	if (ctx.format != FS_ENCRYPTION_CONTEXT_FORMAT_V1)
-		return -EINVAL;
-
-	if (ctx.flags & ~FSCRYPT_POLICY_FLAGS_VALID)
-		return -EINVAL;
-
-	crypt_info = kmem_cache_zalloc(fscrypt_info_cachep, GFP_NOFS);
-	if (!crypt_info)
-		return -ENOMEM;
-
-	crypt_info->ci_inode = inode;
-
-	crypt_info->ci_flags = ctx.flags;
-	crypt_info->ci_data_mode = ctx.contents_encryption_mode;
-	crypt_info->ci_filename_mode = ctx.filenames_encryption_mode;
-	memcpy(crypt_info->ci_master_key_descriptor, ctx.master_key_descriptor,
-	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	memcpy(crypt_info->ci_nonce, ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
-
-	mode = select_encryption_mode(crypt_info, inode);
-	if (IS_ERR(mode)) {
-		res = PTR_ERR(mode);
-		goto out;
-	}
-	WARN_ON(mode->ivsize > FSCRYPT_MAX_IV_SIZE);
-	crypt_info->ci_mode = mode;
-
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
-	if (res)
-		goto out;
-
-	if (cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info) == NULL)
-		crypt_info = NULL;
-out:
-	if (res == -ENOKEY)
-		res = 0;
-	put_crypt_info(crypt_info);
-	kzfree(raw_key);
-	return res;
-}
-EXPORT_SYMBOL(fscrypt_get_encryption_info);
-
-/**
- * fscrypt_put_encryption_info - free most of an inode's fscrypt data
- *
- * Free the inode's fscrypt_info.  Filesystems must call this when the inode is
- * being evicted.  An RCU grace period need not have elapsed yet.
- */
-void fscrypt_put_encryption_info(struct inode *inode)
-{
-	put_crypt_info(inode->i_crypt_info);
-	inode->i_crypt_info = NULL;
-}
-EXPORT_SYMBOL(fscrypt_put_encryption_info);
-
-/**
- * fscrypt_free_inode - free an inode's fscrypt data requiring RCU delay
- *
- * Free the inode's cached decrypted symlink target, if any.  Filesystems must
- * call this after an RCU grace period, just before they free the inode.
- */
-void fscrypt_free_inode(struct inode *inode)
-{
-	if (IS_ENCRYPTED(inode) && S_ISLNK(inode->i_mode)) {
-		kfree(inode->i_link);
-		inode->i_link = NULL;
-	}
-}
-EXPORT_SYMBOL(fscrypt_free_inode);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
new file mode 100644
index 0000000000000..d9748999f3a68
--- /dev/null
+++ b/fs/crypto/keysetup.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Key setup facility for FS encryption support.
+ *
+ * Copyright (C) 2015, Google, Inc.
+ *
+ * Originally written by Michael Halcrow, Ildar Muslukhov, and Uday Savagaonkar.
+ * Heavily modified since then.
+ */
+
+#include <crypto/aes.h>
+#include <crypto/sha.h>
+#include <crypto/skcipher.h>
+#include <linux/key.h>
+
+#include "fscrypt_private.h"
+
+static struct crypto_shash *essiv_hash_tfm;
+
+static struct fscrypt_mode available_modes[] = {
+	[FSCRYPT_MODE_AES_256_XTS] = {
+		.friendly_name = "AES-256-XTS",
+		.cipher_str = "xts(aes)",
+		.keysize = 64,
+		.ivsize = 16,
+	},
+	[FSCRYPT_MODE_AES_256_CTS] = {
+		.friendly_name = "AES-256-CTS-CBC",
+		.cipher_str = "cts(cbc(aes))",
+		.keysize = 32,
+		.ivsize = 16,
+	},
+	[FSCRYPT_MODE_AES_128_CBC] = {
+		.friendly_name = "AES-128-CBC",
+		.cipher_str = "cbc(aes)",
+		.keysize = 16,
+		.ivsize = 16,
+		.needs_essiv = true,
+	},
+	[FSCRYPT_MODE_AES_128_CTS] = {
+		.friendly_name = "AES-128-CTS-CBC",
+		.cipher_str = "cts(cbc(aes))",
+		.keysize = 16,
+		.ivsize = 16,
+	},
+	[FSCRYPT_MODE_ADIANTUM] = {
+		.friendly_name = "Adiantum",
+		.cipher_str = "adiantum(xchacha12,aes)",
+		.keysize = 32,
+		.ivsize = 32,
+	},
+};
+
+static struct fscrypt_mode *
+select_encryption_mode(const struct fscrypt_info *ci, const struct inode *inode)
+{
+	if (!fscrypt_valid_enc_modes(ci->ci_data_mode, ci->ci_filename_mode)) {
+		fscrypt_warn(inode->i_sb,
+			     "inode %lu uses unsupported encryption modes (contents mode %d, filenames mode %d)",
+			     inode->i_ino, ci->ci_data_mode,
+			     ci->ci_filename_mode);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (S_ISREG(inode->i_mode))
+		return &available_modes[ci->ci_data_mode];
+
+	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
+		return &available_modes[ci->ci_filename_mode];
+
+	WARN_ONCE(1, "fscrypt: filesystem tried to load encryption info for inode %lu, which is not encryptable (file type %d)\n",
+		  inode->i_ino, (inode->i_mode & S_IFMT));
+	return ERR_PTR(-EINVAL);
+}
+
+/* Create a symmetric cipher object for the given encryption mode and key */
+struct crypto_skcipher *fscrypt_allocate_skcipher(struct fscrypt_mode *mode,
+						  const u8 *raw_key,
+						  const struct inode *inode)
+{
+	struct crypto_skcipher *tfm;
+	int err;
+
+	tfm = crypto_alloc_skcipher(mode->cipher_str, 0, 0);
+	if (IS_ERR(tfm)) {
+		fscrypt_warn(inode->i_sb,
+			     "error allocating '%s' transform for inode %lu: %ld",
+			     mode->cipher_str, inode->i_ino, PTR_ERR(tfm));
+		return tfm;
+	}
+	if (unlikely(!mode->logged_impl_name)) {
+		/*
+		 * fscrypt performance can vary greatly depending on which
+		 * crypto algorithm implementation is used.  Help people debug
+		 * performance problems by logging the ->cra_driver_name the
+		 * first time a mode is used.  Note that multiple threads can
+		 * race here, but it doesn't really matter.
+		 */
+		mode->logged_impl_name = true;
+		pr_info("fscrypt: %s using implementation \"%s\"\n",
+			mode->friendly_name,
+			crypto_skcipher_alg(tfm)->base.cra_driver_name);
+	}
+	crypto_skcipher_set_flags(tfm, CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
+	err = crypto_skcipher_setkey(tfm, raw_key, mode->keysize);
+	if (err)
+		goto err_free_tfm;
+
+	return tfm;
+
+err_free_tfm:
+	crypto_free_skcipher(tfm);
+	return ERR_PTR(err);
+}
+
+static int derive_essiv_salt(const u8 *key, int keysize, u8 *salt)
+{
+	struct crypto_shash *tfm = READ_ONCE(essiv_hash_tfm);
+
+	/* init hash transform on demand */
+	if (unlikely(!tfm)) {
+		struct crypto_shash *prev_tfm;
+
+		tfm = crypto_alloc_shash("sha256", 0, 0);
+		if (IS_ERR(tfm)) {
+			fscrypt_warn(NULL,
+				     "error allocating SHA-256 transform: %ld",
+				     PTR_ERR(tfm));
+			return PTR_ERR(tfm);
+		}
+		prev_tfm = cmpxchg(&essiv_hash_tfm, NULL, tfm);
+		if (prev_tfm) {
+			crypto_free_shash(tfm);
+			tfm = prev_tfm;
+		}
+	}
+
+	{
+		SHASH_DESC_ON_STACK(desc, tfm);
+		desc->tfm = tfm;
+
+		return crypto_shash_digest(desc, key, keysize, salt);
+	}
+}
+
+static int init_essiv_generator(struct fscrypt_info *ci, const u8 *raw_key,
+				int keysize)
+{
+	int err;
+	struct crypto_cipher *essiv_tfm;
+	u8 salt[SHA256_DIGEST_SIZE];
+
+	if (WARN_ON(ci->ci_mode->ivsize != AES_BLOCK_SIZE))
+		return -EINVAL;
+
+	essiv_tfm = crypto_alloc_cipher("aes", 0, 0);
+	if (IS_ERR(essiv_tfm))
+		return PTR_ERR(essiv_tfm);
+
+	ci->ci_essiv_tfm = essiv_tfm;
+
+	err = derive_essiv_salt(raw_key, keysize, salt);
+	if (err)
+		goto out;
+
+	/*
+	 * Using SHA256 to derive the salt/key will result in AES-256 being
+	 * used for IV generation. File contents encryption will still use the
+	 * configured keysize (AES-128) nevertheless.
+	 */
+	err = crypto_cipher_setkey(essiv_tfm, salt, sizeof(salt));
+	if (err)
+		goto out;
+
+out:
+	memzero_explicit(salt, sizeof(salt));
+	return err;
+}
+
+void __exit fscrypt_essiv_cleanup(void)
+{
+	crypto_free_shash(essiv_hash_tfm);
+}
+
+/* Given the per-file key, set up the file's crypto transform object(s) */
+int fscrypt_set_derived_key(struct fscrypt_info *ci, const u8 *derived_key)
+{
+	struct fscrypt_mode *mode = ci->ci_mode;
+	struct crypto_skcipher *ctfm;
+	int err;
+
+	ctfm = fscrypt_allocate_skcipher(mode, derived_key, ci->ci_inode);
+	if (IS_ERR(ctfm))
+		return PTR_ERR(ctfm);
+
+	ci->ci_ctfm = ctfm;
+
+	if (mode->needs_essiv) {
+		err = init_essiv_generator(ci, derived_key, mode->keysize);
+		if (err) {
+			fscrypt_warn(ci->ci_inode->i_sb,
+				     "error initializing ESSIV generator for inode %lu: %d",
+				     ci->ci_inode->i_ino, err);
+			return err;
+		}
+	}
+	return 0;
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
+static void put_crypt_info(struct fscrypt_info *ci)
+{
+	if (!ci)
+		return;
+
+	if (ci->ci_direct_key) {
+		fscrypt_put_direct_key(ci->ci_direct_key);
+	} else {
+		crypto_free_skcipher(ci->ci_ctfm);
+		crypto_free_cipher(ci->ci_essiv_tfm);
+	}
+	kmem_cache_free(fscrypt_info_cachep, ci);
+}
+
+int fscrypt_get_encryption_info(struct inode *inode)
+{
+	struct fscrypt_info *crypt_info;
+	struct fscrypt_context ctx;
+	struct fscrypt_mode *mode;
+	int res;
+
+	if (fscrypt_has_encryption_key(inode))
+		return 0;
+
+	res = fscrypt_initialize(inode->i_sb->s_cop->flags);
+	if (res)
+		return res;
+
+	res = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
+	if (res < 0) {
+		if (!fscrypt_dummy_context_enabled(inode) ||
+		    IS_ENCRYPTED(inode))
+			return res;
+		/* Fake up a context for an unencrypted directory */
+		memset(&ctx, 0, sizeof(ctx));
+		ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
+		ctx.contents_encryption_mode = FSCRYPT_MODE_AES_256_XTS;
+		ctx.filenames_encryption_mode = FSCRYPT_MODE_AES_256_CTS;
+		memset(ctx.master_key_descriptor, 0x42,
+		       FSCRYPT_KEY_DESCRIPTOR_SIZE);
+	} else if (res != sizeof(ctx)) {
+		return -EINVAL;
+	}
+
+	if (ctx.format != FS_ENCRYPTION_CONTEXT_FORMAT_V1)
+		return -EINVAL;
+
+	if (ctx.flags & ~FSCRYPT_POLICY_FLAGS_VALID)
+		return -EINVAL;
+
+	crypt_info = kmem_cache_zalloc(fscrypt_info_cachep, GFP_NOFS);
+	if (!crypt_info)
+		return -ENOMEM;
+
+	crypt_info->ci_inode = inode;
+
+	crypt_info->ci_flags = ctx.flags;
+	crypt_info->ci_data_mode = ctx.contents_encryption_mode;
+	crypt_info->ci_filename_mode = ctx.filenames_encryption_mode;
+	memcpy(crypt_info->ci_master_key_descriptor, ctx.master_key_descriptor,
+	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
+	memcpy(crypt_info->ci_nonce, ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
+
+	mode = select_encryption_mode(crypt_info, inode);
+	if (IS_ERR(mode)) {
+		res = PTR_ERR(mode);
+		goto out;
+	}
+	WARN_ON(mode->ivsize > FSCRYPT_MAX_IV_SIZE);
+	crypt_info->ci_mode = mode;
+
+	res = setup_file_encryption_key(crypt_info);
+	if (res)
+		goto out;
+
+	if (cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info) == NULL)
+		crypt_info = NULL;
+out:
+	if (res == -ENOKEY)
+		res = 0;
+	put_crypt_info(crypt_info);
+	return res;
+}
+EXPORT_SYMBOL(fscrypt_get_encryption_info);
+
+/**
+ * fscrypt_put_encryption_info - free most of an inode's fscrypt data
+ *
+ * Free the inode's fscrypt_info.  Filesystems must call this when the inode is
+ * being evicted.  An RCU grace period need not have elapsed yet.
+ */
+void fscrypt_put_encryption_info(struct inode *inode)
+{
+	put_crypt_info(inode->i_crypt_info);
+	inode->i_crypt_info = NULL;
+}
+EXPORT_SYMBOL(fscrypt_put_encryption_info);
+
+/**
+ * fscrypt_free_inode - free an inode's fscrypt data requiring RCU delay
+ *
+ * Free the inode's cached decrypted symlink target, if any.  Filesystems must
+ * call this after an RCU grace period, just before they free the inode.
+ */
+void fscrypt_free_inode(struct inode *inode)
+{
+	if (IS_ENCRYPTED(inode) && S_ISLNK(inode->i_mode)) {
+		kfree(inode->i_link);
+		inode->i_link = NULL;
+	}
+}
+EXPORT_SYMBOL(fscrypt_free_inode);
diff --git a/fs/crypto/keysetup_legacy.c b/fs/crypto/keysetup_legacy.c
new file mode 100644
index 0000000000000..407daa0b64d82
--- /dev/null
+++ b/fs/crypto/keysetup_legacy.c
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
+ * Legacy key derivation function.  This generates the derived key by encrypting
+ * the master key with AES-128-ECB using the nonce as the AES key.  This
+ * provides a unique derived key with sufficient entropy for each inode.
+ * However, it's nonstandard, non-extensible, doesn't evenly distribute the
+ * entropy from the master key, and is trivially reversible: an attacker who
+ * compromises a derived key can "decrypt" it to get back to the master key,
+ * then derive any other key.  For all new code, use HKDF instead.
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
+		fscrypt_warn(ci->ci_inode->i_sb,
+			     "direct key flag not allowed with %s",
+			     mode->friendly_name);
+		return -EINVAL;
+	}
+
+	if (ci->ci_data_mode != ci->ci_filename_mode) {
+		fscrypt_warn(ci->ci_inode->i_sb,
+			     "direct key flag not allowed with different contents and filenames modes");
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
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index a2b2ceaf33a85..f9d63986c4310 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -126,7 +126,7 @@ extern int fscrypt_ioctl_get_policy(struct file *, void __user *);
 extern int fscrypt_has_permitted_context(struct inode *, struct inode *);
 extern int fscrypt_inherit_context(struct inode *, struct inode *,
 					void *, bool);
-/* keyinfo.c */
+/* keysetup.c */
 extern int fscrypt_get_encryption_info(struct inode *);
 extern void fscrypt_put_encryption_info(struct inode *);
 extern void fscrypt_free_inode(struct inode *);
@@ -337,7 +337,7 @@ static inline int fscrypt_inherit_context(struct inode *parent,
 	return -EOPNOTSUPP;
 }
 
-/* keyinfo.c */
+/* keysetup.c */
 static inline int fscrypt_get_encryption_info(struct inode *inode)
 {
 	return -EOPNOTSUPP;
-- 
2.21.0.1020.gf2820cf01a-goog

