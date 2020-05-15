Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078631D5AF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 22:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEOUuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 16:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEOUuj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 16:50:39 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91FBE205CB;
        Fri, 15 May 2020 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589575837;
        bh=1e5UpyXyOVQ2roaAqLYWD/RlEY2d4JJDJJ17tmmKfIc=;
        h=From:To:Cc:Subject:Date:From;
        b=tCmI6VqGbf6hwa3/FMO9MeNnenXiEjCb3/Tj3dz6OvPetJwKnGmjQb6mq0zTuqAXP
         loN7Ou2EHg84XReiF/X8M/OVesZv3IbXs8DdEOBus0omHV8kDhS2qWSk1UNkv9qTX2
         ONsrdifGVhLv3OoPIoX8yw838L8+DxIc+3yd6U/c=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-mmc@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Satya Tangirala <satyat@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Paul Crowley <paulcrowley@google.com>
Subject: [PATCH] fscrypt: add support for IV_INO_LBLK_32 policies
Date:   Fri, 15 May 2020 13:41:41 -0700
Message-Id: <20200515204141.251098-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The eMMC inline crypto standard will only specify 32 DUN bits (a.k.a. IV
bits), unlike UFS's 64.  IV_INO_LBLK_64 is therefore not applicable, but
an encryption format which uses one key per policy and permits the
moving of encrypted file contents (as f2fs's garbage collector requires)
is still desirable.

To support such hardware, add a new encryption format IV_INO_LBLK_32
that makes the best use of the 32 bits: the IV is set to
'SipHash-2-4(inode_number) + file_logical_block_number mod 2^32', where
the SipHash key is derived from the fscrypt master key.  We hash only
the inode number and not also the block number, because we need to
maintain contiguity of DUNs to merge bios.

Unlike with IV_INO_LBLK_64, with this format IV reuse is possible; this
is unavoidable given the size of the DUN.  This means this format should
only be used where the requirements of the first paragraph apply.
However, the hash spreads out the IVs in the whole usable range, and the
use of a keyed hash makes it difficult for an attacker to determine
which files use which IVs.

Besides the above differences, this flag works like IV_INO_LBLK_64 in
that on ext4 it is only allowed if the stable_inodes feature has been
enabled to prevent inode numbers and the filesystem UUID from changing.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 33 +++++++++--
 fs/crypto/crypto.c                    |  6 +-
 fs/crypto/fscrypt_private.h           | 20 +++++--
 fs/crypto/keyring.c                   |  5 +-
 fs/crypto/keysetup.c                  | 85 +++++++++++++++++++++------
 fs/crypto/policy.c                    | 51 +++++++++++-----
 include/uapi/linux/fscrypt.h          |  3 +-
 7 files changed, 157 insertions(+), 46 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index aa072112cfff2eb..f517af8ec11c884 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -292,8 +292,22 @@ files' data differently, inode numbers are included in the IVs.
 Consequently, shrinking the filesystem may not be allowed.
 
 This format is optimized for use with inline encryption hardware
-compliant with the UFS or eMMC standards, which support only 64 IV
-bits per I/O request and may have only a small number of keyslots.
+compliant with the UFS standard, which supports only 64 IV bits per
+I/O request and may have only a small number of keyslots.
+
+IV_INO_LBLK_32 policies
+-----------------------
+
+IV_INO_LBLK_32 policies work like IV_INO_LBLK_64, except that for
+IV_INO_LBLK_32, the inode number is hashed with SipHash-2-4 (where the
+SipHash key is derived from the master key) and added to the file
+logical block number mod 2^32 to produce a 32-bit IV.
+
+This format is optimized for use with inline encryption hardware
+compliant with the eMMC v5.2 standard, which supports only 32 IV bits
+per I/O request and may have only a small number of keyslots.  This
+format results in some level of IV reuse, so it should only be used
+when necessary due to hardware limitations.
 
 Key identifiers
 ---------------
@@ -369,6 +383,10 @@ a little endian number, except that:
   to 32 bits and is placed in bits 0-31 of the IV.  The inode number
   (which is also limited to 32 bits) is placed in bits 32-63.
 
+- With `IV_INO_LBLK_32 policies`_, the logical block number is limited
+  to 32 bits and is placed in bits 0-31 of the IV.  The inode number
+  is then hashed and added mod 2^32.
+
 Note that because file logical block numbers are included in the IVs,
 filesystems must enforce that blocks are never shifted around within
 encrypted files, e.g. via "collapse range" or "insert range".
@@ -465,8 +483,15 @@ This structure must be initialized as follows:
     (0x3).
   - FSCRYPT_POLICY_FLAG_DIRECT_KEY: See `DIRECT_KEY policies`_.
   - FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64: See `IV_INO_LBLK_64
-    policies`_.  This is mutually exclusive with DIRECT_KEY and is not
-    supported on v1 policies.
+    policies`_.
+  - FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32: See `IV_INO_LBLK_32
+    policies`_.
+
+  v1 encryption policies only support the PAD_* and DIRECT_KEY flags.
+  The other flags are only supported by v2 encryption policies.
+
+  The DIRECT_KEY, IV_INO_LBLK_64, and IV_INO_LBLK_32 flags are
+  mutually exclusive.
 
 - For v2 encryption policies, ``__reserved`` must be zeroed.
 
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 1ecaac7ee3cb8e0..97dc694dca8ce8f 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -76,8 +76,12 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 	memset(iv, 0, ci->ci_mode->ivsize);
 
 	if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
-		WARN_ON_ONCE((u32)lblk_num != lblk_num);
+		WARN_ON_ONCE(lblk_num > U32_MAX);
+		WARN_ON_ONCE(ci->ci_inode->i_ino > U32_MAX);
 		lblk_num |= (u64)ci->ci_inode->i_ino << 32;
+	} else if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) {
+		WARN_ON_ONCE(lblk_num > U32_MAX);
+		lblk_num = (u32)(ci->ci_hashed_ino + lblk_num);
 	} else if (flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
 		memcpy(iv->nonce, ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE);
 	}
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index dbced2937ec8954..fff9c0df5f7233c 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -222,6 +222,9 @@ struct fscrypt_info {
 
 	/* This inode's nonce, copied from the fscrypt_context */
 	u8 ci_nonce[FS_KEY_DERIVATION_NONCE_SIZE];
+
+	/* Hashed inode number.  Only set for IV_INO_LBLK_32 */
+	u32 ci_hashed_ino;
 };
 
 typedef enum {
@@ -293,6 +296,8 @@ extern int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 #define HKDF_CONTEXT_DIRECT_KEY		3
 #define HKDF_CONTEXT_IV_INO_LBLK_64_KEY	4
 #define HKDF_CONTEXT_DIRHASH_KEY	5
+#define HKDF_CONTEXT_IV_INO_LBLK_32_KEY	6
+#define HKDF_CONTEXT_INODE_HASH_KEY	7
 
 extern int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 			       const u8 *info, unsigned int infolen,
@@ -389,14 +394,17 @@ struct fscrypt_master_key {
 	struct list_head	mk_decrypted_inodes;
 	spinlock_t		mk_decrypted_inodes_lock;
 
-	/* Crypto API transforms for DIRECT_KEY policies, allocated on-demand */
-	struct crypto_skcipher	*mk_direct_tfms[__FSCRYPT_MODE_MAX + 1];
-
 	/*
-	 * Crypto API transforms for filesystem-layer implementation of
-	 * IV_INO_LBLK_64 policies, allocated on-demand.
+	 * Per-mode encryption keys for the various types of encryption policies
+	 * that use them.  Allocated and derived on-demand.
 	 */
-	struct crypto_skcipher	*mk_iv_ino_lblk_64_tfms[__FSCRYPT_MODE_MAX + 1];
+	struct crypto_skcipher *mk_direct_keys[__FSCRYPT_MODE_MAX + 1];
+	struct crypto_skcipher *mk_iv_ino_lblk_64_keys[__FSCRYPT_MODE_MAX + 1];
+	struct crypto_skcipher *mk_iv_ino_lblk_32_keys[__FSCRYPT_MODE_MAX + 1];
+
+	/* Hash key for inode numbers.  Initialized only when needed. */
+	siphash_key_t		mk_ino_hash_key;
+	bool			mk_ino_hash_key_initialized;
 
 } __randomize_layout;
 
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index ab41b25d4fa1ba3..ae0e111c4199fa4 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -44,8 +44,9 @@ static void free_master_key(struct fscrypt_master_key *mk)
 	wipe_master_key_secret(&mk->mk_secret);
 
 	for (i = 0; i <= __FSCRYPT_MODE_MAX; i++) {
-		crypto_free_skcipher(mk->mk_direct_tfms[i]);
-		crypto_free_skcipher(mk->mk_iv_ino_lblk_64_tfms[i]);
+		crypto_free_skcipher(mk->mk_direct_keys[i]);
+		crypto_free_skcipher(mk->mk_iv_ino_lblk_64_keys[i]);
+		crypto_free_skcipher(mk->mk_iv_ino_lblk_32_keys[i]);
 	}
 
 	key_put(mk->mk_users);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 302375e9f719ebb..5f26095edd93de8 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -46,6 +46,8 @@ struct fscrypt_mode fscrypt_modes[] = {
 	},
 };
 
+static DEFINE_MUTEX(fscrypt_mode_key_setup_mutex);
+
 static struct fscrypt_mode *
 select_encryption_mode(const union fscrypt_policy *policy,
 		       const struct inode *inode)
@@ -130,7 +132,7 @@ static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 	const struct super_block *sb = inode->i_sb;
 	struct fscrypt_mode *mode = ci->ci_mode;
 	const u8 mode_num = mode - fscrypt_modes;
-	struct crypto_skcipher *tfm, *prev_tfm;
+	struct crypto_skcipher *tfm;
 	u8 mode_key[FSCRYPT_MAX_KEY_SIZE];
 	u8 hkdf_info[sizeof(mode_num) + sizeof(sb->s_uuid)];
 	unsigned int hkdf_infolen = 0;
@@ -139,10 +141,17 @@ static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 	if (WARN_ON(mode_num > __FSCRYPT_MODE_MAX))
 		return -EINVAL;
 
-	/* pairs with cmpxchg() below */
+	/* pairs with smp_store_release() below */
 	tfm = READ_ONCE(tfms[mode_num]);
-	if (likely(tfm != NULL))
-		goto done;
+	if (likely(tfm != NULL)) {
+		ci->ci_ctfm = tfm;
+		return 0;
+	}
+
+	mutex_lock(&fscrypt_mode_key_setup_mutex);
+
+	if (tfms[mode_num])
+		goto done_unlock;
 
 	BUILD_BUG_ON(sizeof(mode_num) != 1);
 	BUILD_BUG_ON(sizeof(sb->s_uuid) != 16);
@@ -157,21 +166,21 @@ static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 				  hkdf_context, hkdf_info, hkdf_infolen,
 				  mode_key, mode->keysize);
 	if (err)
-		return err;
+		goto out_unlock;
 	tfm = fscrypt_allocate_skcipher(mode, mode_key, inode);
 	memzero_explicit(mode_key, mode->keysize);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	/* pairs with READ_ONCE() above */
-	prev_tfm = cmpxchg(&tfms[mode_num], NULL, tfm);
-	if (prev_tfm != NULL) {
-		crypto_free_skcipher(tfm);
-		tfm = prev_tfm;
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto out_unlock;
 	}
-done:
+	/* pairs with READ_ONCE() above */
+	smp_store_release(&tfms[mode_num], tfm);
+done_unlock:
 	ci->ci_ctfm = tfm;
-	return 0;
+	err = 0;
+out_unlock:
+	mutex_unlock(&fscrypt_mode_key_setup_mutex);
+	return err;
 }
 
 int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
@@ -189,6 +198,43 @@ int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
 	return 0;
 }
 
+static int fscrypt_setup_iv_ino_lblk_32_key(struct fscrypt_info *ci,
+					    struct fscrypt_master_key *mk)
+{
+	int err;
+
+	err = setup_per_mode_enc_key(ci, mk, mk->mk_iv_ino_lblk_32_keys,
+				     HKDF_CONTEXT_IV_INO_LBLK_32_KEY, true);
+	if (err)
+		return err;
+
+	/* pairs with smp_store_release() below */
+	if (!smp_load_acquire(&mk->mk_ino_hash_key_initialized)) {
+
+		mutex_lock(&fscrypt_mode_key_setup_mutex);
+
+		if (mk->mk_ino_hash_key_initialized)
+			goto unlock;
+
+		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+					  HKDF_CONTEXT_INODE_HASH_KEY, NULL, 0,
+					  (u8 *)&mk->mk_ino_hash_key,
+					  sizeof(mk->mk_ino_hash_key));
+		if (err)
+			goto unlock;
+		/* pairs with smp_load_acquire() above */
+		smp_store_release(&mk->mk_ino_hash_key_initialized, true);
+unlock:
+		mutex_unlock(&fscrypt_mode_key_setup_mutex);
+		if (err)
+			return err;
+	}
+
+	ci->ci_hashed_ino = (u32)siphash_1u64(ci->ci_inode->i_ino,
+					      &mk->mk_ino_hash_key);
+	return 0;
+}
+
 static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 				     struct fscrypt_master_key *mk)
 {
@@ -203,7 +249,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * encryption key.  This ensures that the master key is
 		 * consistently used only for HKDF, avoiding key reuse issues.
 		 */
-		err = setup_per_mode_enc_key(ci, mk, mk->mk_direct_tfms,
+		err = setup_per_mode_enc_key(ci, mk, mk->mk_direct_keys,
 					     HKDF_CONTEXT_DIRECT_KEY, false);
 	} else if (ci->ci_policy.v2.flags &
 		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
@@ -211,11 +257,14 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * IV_INO_LBLK_64: encryption keys are derived from (master_key,
 		 * mode_num, filesystem_uuid), and inode number is included in
 		 * the IVs.  This format is optimized for use with inline
-		 * encryption hardware compliant with the UFS or eMMC standards.
+		 * encryption hardware compliant with the UFS standard.
 		 */
-		err = setup_per_mode_enc_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
+		err = setup_per_mode_enc_key(ci, mk, mk->mk_iv_ino_lblk_64_keys,
 					     HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
 					     true);
+	} else if (ci->ci_policy.v2.flags &
+		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) {
+		err = fscrypt_setup_iv_ino_lblk_32_key(ci, mk);
 	} else {
 		u8 derived_key[FSCRYPT_MAX_KEY_SIZE];
 
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 10ccf945020ce5e..04d2f531a3a1954 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -66,18 +66,14 @@ static bool supported_direct_key_modes(const struct inode *inode,
 	return true;
 }
 
-static bool supported_iv_ino_lblk_64_policy(
-					const struct fscrypt_policy_v2 *policy,
-					const struct inode *inode)
+static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
+					 const struct inode *inode,
+					 const char *type,
+					 int max_ino_bits, int max_lblk_bits)
 {
 	struct super_block *sb = inode->i_sb;
 	int ino_bits = 64, lblk_bits = 64;
 
-	if (policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
-		fscrypt_warn(inode,
-			     "The DIRECT_KEY and IV_INO_LBLK_64 flags are mutually exclusive");
-		return false;
-	}
 	/*
 	 * It's unsafe to include inode numbers in the IVs if the filesystem can
 	 * potentially renumber inodes, e.g. via filesystem shrinking.
@@ -85,16 +81,22 @@ static bool supported_iv_ino_lblk_64_policy(
 	if (!sb->s_cop->has_stable_inodes ||
 	    !sb->s_cop->has_stable_inodes(sb)) {
 		fscrypt_warn(inode,
-			     "Can't use IV_INO_LBLK_64 policy on filesystem '%s' because it doesn't have stable inode numbers",
-			     sb->s_id);
+			     "Can't use %s policy on filesystem '%s' because it doesn't have stable inode numbers",
+			     type, sb->s_id);
 		return false;
 	}
 	if (sb->s_cop->get_ino_and_lblk_bits)
 		sb->s_cop->get_ino_and_lblk_bits(sb, &ino_bits, &lblk_bits);
-	if (ino_bits > 32 || lblk_bits > 32) {
+	if (ino_bits > max_ino_bits) {
+		fscrypt_warn(inode,
+			     "Can't use %s policy on filesystem '%s' because its inode numbers are too long",
+			     type, sb->s_id);
+		return false;
+	}
+	if (lblk_bits > max_lblk_bits) {
 		fscrypt_warn(inode,
-			     "Can't use IV_INO_LBLK_64 policy on filesystem '%s' because it doesn't use 32-bit inode and block numbers",
-			     sb->s_id);
+			     "Can't use %s policy on filesystem '%s' because its block numbers are too long",
+			     type, sb->s_id);
 		return false;
 	}
 	return true;
@@ -137,6 +139,8 @@ static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
 static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 					const struct inode *inode)
 {
+	int count = 0;
+
 	if (!fscrypt_valid_enc_modes(policy->contents_encryption_mode,
 				     policy->filenames_encryption_mode)) {
 		fscrypt_warn(inode,
@@ -152,13 +156,29 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 		return false;
 	}
 
+	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY);
+	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64);
+	count += !!(policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32);
+	if (count > 1) {
+		fscrypt_warn(inode, "Mutually exclusive encryption flags (0x%02x)",
+			     policy->flags);
+		return false;
+	}
+
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) &&
 	    !supported_direct_key_modes(inode, policy->contents_encryption_mode,
 					policy->filenames_encryption_mode))
 		return false;
 
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) &&
-	    !supported_iv_ino_lblk_64_policy(policy, inode))
+	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_64",
+					  32, 32))
+		return false;
+
+	if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) &&
+	    /* This uses hashed inode numbers, so ino_bits doesn't matter. */
+	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_32",
+					  INT_MAX, 32))
 		return false;
 
 	if (memchr_inv(policy->__reserved, 0, sizeof(policy->__reserved))) {
@@ -354,6 +374,9 @@ static int set_encryption_policy(struct inode *inode,
 					       policy->v2.master_key_identifier);
 		if (err)
 			return err;
+		if (policy->v2.flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32)
+			pr_warn_once("%s (pid %d) is setting an IV_INO_LBLK_32 encryption policy.  This should only be used if there are certain hardware limitations.\n",
+				     current->comm, current->pid);
 		break;
 	default:
 		WARN_ON(1);
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index a10e3cdc2839489..7875709ccfebff2 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -19,7 +19,8 @@
 #define FSCRYPT_POLICY_FLAGS_PAD_MASK		0x03
 #define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04
 #define FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64	0x08
-#define FSCRYPT_POLICY_FLAGS_VALID		0x0F
+#define FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32	0x10
+#define FSCRYPT_POLICY_FLAGS_VALID		0x1F
 
 /* Encryption algorithms */
 #define FSCRYPT_MODE_AES_256_XTS		1
-- 
2.26.2

