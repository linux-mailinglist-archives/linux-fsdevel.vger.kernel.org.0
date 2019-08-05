Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0610182251
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfHEQ3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbfHEQ2d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:28:33 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FBD3217F4;
        Mon,  5 Aug 2019 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565022512;
        bh=pOgq0OpPHqH7iz3z5urithoByK1gUgoz9W7hUirsWIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ad4F3SzWKFCz6Oc0jQoQXGjA0Wcg18sTdBIe4uGu3hSe0UGmY4/8K9Gk6liOzdJtR
         XAS47OKbK1aoIg6c+CGp+6Pmfj0Tk9QXZQiJzJYKGF4V0UGfveOSYTfLOVVCJbAyJT
         Fq3Xmo+LQxMs3hl2+i18U3lR7dbbzpNb6vzQ+Sjo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v8 05/20] fscrypt: rename fscrypt_master_key to fscrypt_direct_key
Date:   Mon,  5 Aug 2019 09:25:06 -0700
Message-Id: <20190805162521.90882-6-ebiggers@kernel.org>
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

In preparation for introducing a filesystem-level keyring which will
contain fscrypt master keys, rename the existing 'struct
fscrypt_master_key' to 'struct fscrypt_direct_key'.  This is the
structure in the existing table of master keys that's maintained to
deduplicate the crypto transforms for v1 DIRECT_KEY policies.

I've chosen to keep this table as-is rather than make it automagically
add/remove the keys to/from the filesystem-level keyring, since that
would add a lot of extra complexity to the filesystem-level keyring.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h |   7 +-
 fs/crypto/keyinfo.c         | 130 ++++++++++++++++++------------------
 2 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index d345a7d28df8c2..80d15a1bf60685 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -77,11 +77,10 @@ struct fscrypt_info {
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
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index 2d45a86f09db25..c4650071df2772 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -21,8 +21,8 @@
 static struct crypto_shash *essiv_hash_tfm;
 
 /* Table of keys referenced by DIRECT_KEY policies */
-static DEFINE_HASHTABLE(fscrypt_master_keys, 6); /* 6 bits = 64 buckets */
-static DEFINE_SPINLOCK(fscrypt_master_keys_lock);
+static DEFINE_HASHTABLE(fscrypt_direct_keys, 6); /* 6 bits = 64 buckets */
+static DEFINE_SPINLOCK(fscrypt_direct_keys_lock);
 
 /*
  * Key derivation function.  This generates the derived key by encrypting the
@@ -273,46 +273,46 @@ allocate_skcipher_for_mode(struct fscrypt_mode *mode, const u8 *raw_key,
 }
 
 /* Master key referenced by DIRECT_KEY policy */
-struct fscrypt_master_key {
-	struct hlist_node mk_node;
-	refcount_t mk_refcount;
-	const struct fscrypt_mode *mk_mode;
-	struct crypto_skcipher *mk_ctfm;
-	u8 mk_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
-	u8 mk_raw[FSCRYPT_MAX_KEY_SIZE];
+struct fscrypt_direct_key {
+	struct hlist_node		dk_node;
+	refcount_t			dk_refcount;
+	const struct fscrypt_mode	*dk_mode;
+	struct crypto_skcipher		*dk_ctfm;
+	u8				dk_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+	u8				dk_raw[FSCRYPT_MAX_KEY_SIZE];
 };
 
-static void free_master_key(struct fscrypt_master_key *mk)
+static void free_direct_key(struct fscrypt_direct_key *dk)
 {
-	if (mk) {
-		crypto_free_skcipher(mk->mk_ctfm);
-		kzfree(mk);
+	if (dk) {
+		crypto_free_skcipher(dk->dk_ctfm);
+		kzfree(dk);
 	}
 }
 
-static void put_master_key(struct fscrypt_master_key *mk)
+static void put_direct_key(struct fscrypt_direct_key *dk)
 {
-	if (!refcount_dec_and_lock(&mk->mk_refcount, &fscrypt_master_keys_lock))
+	if (!refcount_dec_and_lock(&dk->dk_refcount, &fscrypt_direct_keys_lock))
 		return;
-	hash_del(&mk->mk_node);
-	spin_unlock(&fscrypt_master_keys_lock);
+	hash_del(&dk->dk_node);
+	spin_unlock(&fscrypt_direct_keys_lock);
 
-	free_master_key(mk);
+	free_direct_key(dk);
 }
 
 /*
- * Find/insert the given master key into the fscrypt_master_keys table.  If
- * found, it is returned with elevated refcount, and 'to_insert' is freed if
- * non-NULL.  If not found, 'to_insert' is inserted and returned if it's
- * non-NULL; otherwise NULL is returned.
+ * Find/insert the given key into the fscrypt_direct_keys table.  If found, it
+ * is returned with elevated refcount, and 'to_insert' is freed if non-NULL.  If
+ * not found, 'to_insert' is inserted and returned if it's non-NULL; otherwise
+ * NULL is returned.
  */
-static struct fscrypt_master_key *
-find_or_insert_master_key(struct fscrypt_master_key *to_insert,
+static struct fscrypt_direct_key *
+find_or_insert_direct_key(struct fscrypt_direct_key *to_insert,
 			  const u8 *raw_key, const struct fscrypt_mode *mode,
 			  const struct fscrypt_info *ci)
 {
 	unsigned long hash_key;
-	struct fscrypt_master_key *mk;
+	struct fscrypt_direct_key *dk;
 
 	/*
 	 * Careful: to avoid potentially leaking secret key bytes via timing
@@ -323,60 +323,60 @@ find_or_insert_master_key(struct fscrypt_master_key *to_insert,
 	BUILD_BUG_ON(sizeof(hash_key) > FSCRYPT_KEY_DESCRIPTOR_SIZE);
 	memcpy(&hash_key, ci->ci_master_key_descriptor, sizeof(hash_key));
 
-	spin_lock(&fscrypt_master_keys_lock);
-	hash_for_each_possible(fscrypt_master_keys, mk, mk_node, hash_key) {
-		if (memcmp(ci->ci_master_key_descriptor, mk->mk_descriptor,
+	spin_lock(&fscrypt_direct_keys_lock);
+	hash_for_each_possible(fscrypt_direct_keys, dk, dk_node, hash_key) {
+		if (memcmp(ci->ci_master_key_descriptor, dk->dk_descriptor,
 			   FSCRYPT_KEY_DESCRIPTOR_SIZE) != 0)
 			continue;
-		if (mode != mk->mk_mode)
+		if (mode != dk->dk_mode)
 			continue;
-		if (crypto_memneq(raw_key, mk->mk_raw, mode->keysize))
+		if (crypto_memneq(raw_key, dk->dk_raw, mode->keysize))
 			continue;
 		/* using existing tfm with same (descriptor, mode, raw_key) */
-		refcount_inc(&mk->mk_refcount);
-		spin_unlock(&fscrypt_master_keys_lock);
-		free_master_key(to_insert);
-		return mk;
+		refcount_inc(&dk->dk_refcount);
+		spin_unlock(&fscrypt_direct_keys_lock);
+		free_direct_key(to_insert);
+		return dk;
 	}
 	if (to_insert)
-		hash_add(fscrypt_master_keys, &to_insert->mk_node, hash_key);
-	spin_unlock(&fscrypt_master_keys_lock);
+		hash_add(fscrypt_direct_keys, &to_insert->dk_node, hash_key);
+	spin_unlock(&fscrypt_direct_keys_lock);
 	return to_insert;
 }
 
 /* Prepare to encrypt directly using the master key in the given mode */
-static struct fscrypt_master_key *
-fscrypt_get_master_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
+static struct fscrypt_direct_key *
+fscrypt_get_direct_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
 		       const u8 *raw_key, const struct inode *inode)
 {
-	struct fscrypt_master_key *mk;
+	struct fscrypt_direct_key *dk;
 	int err;
 
 	/* Is there already a tfm for this key? */
-	mk = find_or_insert_master_key(NULL, raw_key, mode, ci);
-	if (mk)
-		return mk;
+	dk = find_or_insert_direct_key(NULL, raw_key, mode, ci);
+	if (dk)
+		return dk;
 
 	/* Nope, allocate one. */
-	mk = kzalloc(sizeof(*mk), GFP_NOFS);
-	if (!mk)
+	dk = kzalloc(sizeof(*dk), GFP_NOFS);
+	if (!dk)
 		return ERR_PTR(-ENOMEM);
-	refcount_set(&mk->mk_refcount, 1);
-	mk->mk_mode = mode;
-	mk->mk_ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
-	if (IS_ERR(mk->mk_ctfm)) {
-		err = PTR_ERR(mk->mk_ctfm);
-		mk->mk_ctfm = NULL;
-		goto err_free_mk;
+	refcount_set(&dk->dk_refcount, 1);
+	dk->dk_mode = mode;
+	dk->dk_ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
+	if (IS_ERR(dk->dk_ctfm)) {
+		err = PTR_ERR(dk->dk_ctfm);
+		dk->dk_ctfm = NULL;
+		goto err_free_dk;
 	}
-	memcpy(mk->mk_descriptor, ci->ci_master_key_descriptor,
+	memcpy(dk->dk_descriptor, ci->ci_master_key_descriptor,
 	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	memcpy(mk->mk_raw, raw_key, mode->keysize);
+	memcpy(dk->dk_raw, raw_key, mode->keysize);
 
-	return find_or_insert_master_key(mk, raw_key, mode, ci);
+	return find_or_insert_direct_key(dk, raw_key, mode, ci);
 
-err_free_mk:
-	free_master_key(mk);
+err_free_dk:
+	free_direct_key(dk);
 	return ERR_PTR(err);
 }
 
@@ -455,22 +455,22 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
 				  struct fscrypt_mode *mode,
 				  const u8 *raw_key, const struct inode *inode)
 {
-	struct fscrypt_master_key *mk;
+	struct fscrypt_direct_key *dk;
 	struct crypto_skcipher *ctfm;
 	int err;
 
 	if (ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
-		mk = fscrypt_get_master_key(ci, mode, raw_key, inode);
-		if (IS_ERR(mk))
-			return PTR_ERR(mk);
-		ctfm = mk->mk_ctfm;
+		dk = fscrypt_get_direct_key(ci, mode, raw_key, inode);
+		if (IS_ERR(dk))
+			return PTR_ERR(dk);
+		ctfm = dk->dk_ctfm;
 	} else {
-		mk = NULL;
+		dk = NULL;
 		ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
 		if (IS_ERR(ctfm))
 			return PTR_ERR(ctfm);
 	}
-	ci->ci_master_key = mk;
+	ci->ci_direct_key = dk;
 	ci->ci_ctfm = ctfm;
 
 	if (mode->needs_essiv) {
@@ -494,8 +494,8 @@ static void put_crypt_info(struct fscrypt_info *ci)
 	if (!ci)
 		return;
 
-	if (ci->ci_master_key) {
-		put_master_key(ci->ci_master_key);
+	if (ci->ci_direct_key) {
+		put_direct_key(ci->ci_direct_key);
 	} else {
 		crypto_free_skcipher(ci->ci_ctfm);
 		crypto_free_cipher(ci->ci_essiv_tfm);
-- 
2.22.0.770.g0f2c4a37fd-goog

