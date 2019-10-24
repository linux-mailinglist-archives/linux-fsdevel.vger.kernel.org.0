Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4AE3E97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 23:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfJXV5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 17:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbfJXV5J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:57:09 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B26F12084C;
        Thu, 24 Oct 2019 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571954228;
        bh=bdDRsPfD3r15EfayDfyLRE0dB6GZF3eQ3hudMIkcIvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TT499C0T2IS9Ui/x4aMgcSb38sDhHcIYpm+iZi2x3TiO+K0GOrC7W8s7qI3GGQ7xS
         ZgynJB50TJOWgN1H1Ua00WnkfZB9tX+5AqggOI4AJyv3JljdZdWG9FNwxrcBmtd1yh
         GA0Q0TBeSYCzSZYeH/1Wf+nSxmjFQIwUGR6JJ+5U=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2 1/3] fscrypt: add support for IV_INO_LBLK_64 policies
Date:   Thu, 24 Oct 2019 14:54:36 -0700
Message-Id: <20191024215438.138489-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191024215438.138489-1-ebiggers@kernel.org>
References: <20191024215438.138489-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Inline encryption hardware compliant with the UFS v2.1 standard or with
the upcoming version of the eMMC standard has the following properties:

(1) Per I/O request, the encryption key is specified by a previously
    loaded keyslot.  There might be only a small number of keyslots.

(2) Per I/O request, the starting IV is specified by a 64-bit "data unit
    number" (DUN).  IV bits 64-127 are assumed to be 0.  The hardware
    automatically increments the DUN for each "data unit" of
    configurable size in the request, e.g. for each filesystem block.

Property (1) makes it inefficient to use the traditional fscrypt
per-file keys.  Property (2) precludes the use of the existing
DIRECT_KEY fscrypt policy flag, which needs at least 192 IV bits.

Therefore, add a new fscrypt policy flag IV_INO_LBLK_64 which causes the
encryption to modified as follows:

- The encryption keys are derived from the master key, encryption mode
  number, and filesystem UUID.

- The IVs are chosen as (inode_number << 32) | file_logical_block_num.
  For filenames encryption, file_logical_block_num is 0.

Since the file nonces aren't used in the key derivation, many files may
share the same encryption key.  This is much more efficient on the
target hardware.  Including the inode number in the IVs and mixing the
filesystem UUID into the keys ensures that data in different files is
nevertheless still encrypted differently.

Additionally, limiting the inode and block numbers to 32 bits and
placing the block number in the low bits maintains compatibility with
the 64-bit DUN convention (property (2) above).

Since this scheme assumes that inode numbers are stable (which may
preclude filesystem shrinking) and that inode and file logical block
numbers are at most 32-bit, IV_INO_LBLK_64 will only be allowed on
filesystems that meet these constraints.  These are acceptable
limitations for the cases where this format would actually be used.

Note that IV_INO_LBLK_64 is an on-disk format, not an implementation.
This patch just adds support for it using the existing filesystem layer
encryption.  A later patch will add support for inline encryption.

Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 63 +++++++++++++++++----------
 fs/crypto/crypto.c                    | 10 ++++-
 fs/crypto/fscrypt_private.h           | 16 +++++--
 fs/crypto/keyring.c                   |  6 ++-
 fs/crypto/keysetup.c                  | 45 ++++++++++++++-----
 fs/crypto/policy.c                    | 41 ++++++++++++++++-
 include/linux/fscrypt.h               |  3 ++
 include/uapi/linux/fscrypt.h          |  3 +-
 8 files changed, 146 insertions(+), 41 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 6ec459be3de16..471a511c75088 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -256,13 +256,8 @@ alternative master keys or to support rotating master keys.  Instead,
 the master keys may be wrapped in userspace, e.g. as is done by the
 `fscrypt <https://github.com/google/fscrypt>`_ tool.
 
-Including the inode number in the IVs was considered.  However, it was
-rejected as it would have prevented ext4 filesystems from being
-resized, and by itself still wouldn't have been sufficient to prevent
-the same key from being directly reused for both XTS and CTS-CBC.
-
-DIRECT_KEY and per-mode keys
-----------------------------
+DIRECT_KEY policies
+-------------------
 
 The Adiantum encryption mode (see `Encryption modes and usage`_) is
 suitable for both contents and filenames encryption, and it accepts
@@ -285,6 +280,21 @@ IV.  Moreover:
   key derived using the KDF.  Users may use the same master key for
   other v2 encryption policies.
 
+IV_INO_LBLK_64 policies
+-----------------------
+
+When FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64 is set in the fscrypt policy,
+the encryption keys are derived from the master key, encryption mode
+number, and filesystem UUID.  This normally results in all files
+protected by the same master key sharing a single contents encryption
+key and a single filenames encryption key.  To still encrypt different
+files' data differently, inode numbers are included in the IVs.
+Consequently, shrinking the filesystem may not be allowed.
+
+This format is optimized for use with inline encryption hardware
+compliant with the UFS or eMMC standards, which support only 64 IV
+bits per I/O request and may have only a small number of keyslots.
+
 Key identifiers
 ---------------
 
@@ -342,10 +352,16 @@ a little endian number, except that:
   is encrypted with AES-256 where the AES-256 key is the SHA-256 hash
   of the file's data encryption key.
 
-- In the "direct key" configuration (FSCRYPT_POLICY_FLAG_DIRECT_KEY
-  set in the fscrypt_policy), the file's nonce is also appended to the
-  IV.  Currently this is only allowed with the Adiantum encryption
-  mode.
+- With `DIRECT_KEY policies`_, the file's nonce is appended to the IV.
+  Currently this is only allowed with the Adiantum encryption mode.
+
+- With `IV_INO_LBLK_64 policies`_, the logical block number is limited
+  to 32 bits and is placed in bits 0-31 of the IV.  The inode number
+  (which is also limited to 32 bits) is placed in bits 32-63.
+
+Note that because file logical block numbers are included in the IVs,
+filesystems must enforce that blocks are never shifted around within
+encrypted files, e.g. via "collapse range" or "insert range".
 
 Filenames encryption
 --------------------
@@ -355,10 +371,10 @@ the requirements to retain support for efficient directory lookups and
 filenames of up to 255 bytes, the same IV is used for every filename
 in a directory.
 
-However, each encrypted directory still uses a unique key; or
-alternatively (for the "direct key" configuration) has the file's
-nonce included in the IVs.  Thus, IV reuse is limited to within a
-single directory.
+However, each encrypted directory still uses a unique key, or
+alternatively has the file's nonce (for `DIRECT_KEY policies`_) or
+inode number (for `IV_INO_LBLK_64 policies`_) included in the IVs.
+Thus, IV reuse is limited to within a single directory.
 
 With CTS-CBC, the IV reuse means that when the plaintext filenames
 share a common prefix at least as long as the cipher block size (16
@@ -432,12 +448,15 @@ This structure must be initialized as follows:
   (1) for ``contents_encryption_mode`` and FSCRYPT_MODE_AES_256_CTS
   (4) for ``filenames_encryption_mode``.
 
-- ``flags`` must contain a value from ``<linux/fscrypt.h>`` which
-  identifies the amount of NUL-padding to use when encrypting
-  filenames.  If unsure, use FSCRYPT_POLICY_FLAGS_PAD_32 (0x3).
-  Additionally, if the encryption modes are both
-  FSCRYPT_MODE_ADIANTUM, this can contain
-  FSCRYPT_POLICY_FLAG_DIRECT_KEY; see `DIRECT_KEY and per-mode keys`_.
+- ``flags`` contains optional flags from ``<linux/fscrypt.h>``:
+
+  - FSCRYPT_POLICY_FLAGS_PAD_*: The amount of NUL padding to use when
+    encrypting filenames.  If unsure, use FSCRYPT_POLICY_FLAGS_PAD_32
+    (0x3).
+  - FSCRYPT_POLICY_FLAG_DIRECT_KEY: See `DIRECT_KEY policies`_.
+  - FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64: See `IV_INO_LBLK_64
+    policies`_.  This is mutually exclusive with DIRECT_KEY and is not
+    supported on v1 policies.
 
 - For v2 encryption policies, ``__reserved`` must be zeroed.
 
@@ -1090,7 +1109,7 @@ policy structs (see `Setting an encryption policy`_), except that the
 context structs also contain a nonce.  The nonce is randomly generated
 by the kernel and is used as KDF input or as a tweak to cause
 different files to be encrypted differently; see `Per-file keys`_ and
-`DIRECT_KEY and per-mode keys`_.
+`DIRECT_KEY policies`_.
 
 Data path changes
 -----------------
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index ced8ad9f2d019..3719efa546c65 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -73,11 +73,17 @@ EXPORT_SYMBOL(fscrypt_free_bounce_page);
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 			 const struct fscrypt_info *ci)
 {
+	u8 flags = fscrypt_policy_flags(&ci->ci_policy);
+
 	memset(iv, 0, ci->ci_mode->ivsize);
-	iv->lblk_num = cpu_to_le64(lblk_num);
 
-	if (fscrypt_is_direct_key_policy(&ci->ci_policy))
+	if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
+		WARN_ON_ONCE((u32)lblk_num != lblk_num);
+		lblk_num |= (u64)ci->ci_inode->i_ino << 32;
+	} else if (flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
 		memcpy(iv->nonce, ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE);
+	}
+	iv->lblk_num = cpu_to_le64(lblk_num);
 }
 
 /* Encrypt or decrypt a single filesystem block of file contents */
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index dacf8fcbac3be..b44e445b43a8a 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -163,6 +163,9 @@ struct fscrypt_info {
 	/* The actual crypto transform used for encryption and decryption */
 	struct crypto_skcipher *ci_ctfm;
 
+	/* True if the key should be freed when this fscrypt_info is freed */
+	bool ci_owns_key;
+
 	/*
 	 * Encryption mode used for this inode.  It corresponds to either the
 	 * contents or filenames encryption mode, depending on the inode type.
@@ -281,7 +284,8 @@ extern int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
  */
 #define HKDF_CONTEXT_KEY_IDENTIFIER	1
 #define HKDF_CONTEXT_PER_FILE_KEY	2
-#define HKDF_CONTEXT_PER_MODE_KEY	3
+#define HKDF_CONTEXT_DIRECT_KEY		3
+#define HKDF_CONTEXT_IV_INO_LBLK_64_KEY	4
 
 extern int fscrypt_hkdf_expand(struct fscrypt_hkdf *hkdf, u8 context,
 			       const u8 *info, unsigned int infolen,
@@ -378,8 +382,14 @@ struct fscrypt_master_key {
 	struct list_head	mk_decrypted_inodes;
 	spinlock_t		mk_decrypted_inodes_lock;
 
-	/* Per-mode tfms for DIRECT_KEY policies, allocated on-demand */
-	struct crypto_skcipher	*mk_mode_keys[__FSCRYPT_MODE_MAX + 1];
+	/* Crypto API transforms for DIRECT_KEY policies, allocated on-demand */
+	struct crypto_skcipher	*mk_direct_tfms[__FSCRYPT_MODE_MAX + 1];
+
+	/*
+	 * Crypto API transforms for filesystem-layer implementation of
+	 * IV_INO_LBLK_64 policies, allocated on-demand.
+	 */
+	struct crypto_skcipher	*mk_iv_ino_lblk_64_tfms[__FSCRYPT_MODE_MAX + 1];
 
 } __randomize_layout;
 
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index c34fa7c61b43b..040df1f5e1c8b 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -43,8 +43,10 @@ static void free_master_key(struct fscrypt_master_key *mk)
 
 	wipe_master_key_secret(&mk->mk_secret);
 
-	for (i = 0; i < ARRAY_SIZE(mk->mk_mode_keys); i++)
-		crypto_free_skcipher(mk->mk_mode_keys[i]);
+	for (i = 0; i <= __FSCRYPT_MODE_MAX; i++) {
+		crypto_free_skcipher(mk->mk_direct_tfms[i]);
+		crypto_free_skcipher(mk->mk_iv_ino_lblk_64_tfms[i]);
+	}
 
 	key_put(mk->mk_users);
 	kzfree(mk);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index b03b33643e4b2..f87ab930b92a6 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -116,40 +116,54 @@ int fscrypt_set_derived_key(struct fscrypt_info *ci, const u8 *derived_key)
 		return PTR_ERR(tfm);
 
 	ci->ci_ctfm = tfm;
+	ci->ci_owns_key = true;
 	return 0;
 }
 
 static int setup_per_mode_key(struct fscrypt_info *ci,
-			      struct fscrypt_master_key *mk)
+			      struct fscrypt_master_key *mk,
+			      struct crypto_skcipher **tfms,
+			      u8 hkdf_context, bool include_fs_uuid)
 {
+	const struct inode *inode = ci->ci_inode;
+	const struct super_block *sb = inode->i_sb;
 	struct fscrypt_mode *mode = ci->ci_mode;
 	u8 mode_num = mode - available_modes;
 	struct crypto_skcipher *tfm, *prev_tfm;
 	u8 mode_key[FSCRYPT_MAX_KEY_SIZE];
+	u8 hkdf_info[sizeof(mode_num) + sizeof(sb->s_uuid)];
+	unsigned int hkdf_infolen = 0;
 	int err;
 
-	if (WARN_ON(mode_num >= ARRAY_SIZE(mk->mk_mode_keys)))
+	if (WARN_ON(mode_num > __FSCRYPT_MODE_MAX))
 		return -EINVAL;
 
 	/* pairs with cmpxchg() below */
-	tfm = READ_ONCE(mk->mk_mode_keys[mode_num]);
+	tfm = READ_ONCE(tfms[mode_num]);
 	if (likely(tfm != NULL))
 		goto done;
 
 	BUILD_BUG_ON(sizeof(mode_num) != 1);
+	BUILD_BUG_ON(sizeof(sb->s_uuid) != 16);
+	BUILD_BUG_ON(sizeof(hkdf_info) != 17);
+	hkdf_info[hkdf_infolen++] = mode_num;
+	if (include_fs_uuid) {
+		memcpy(&hkdf_info[hkdf_infolen], &sb->s_uuid,
+		       sizeof(sb->s_uuid));
+		hkdf_infolen += sizeof(sb->s_uuid);
+	}
 	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
-				  HKDF_CONTEXT_PER_MODE_KEY,
-				  &mode_num, sizeof(mode_num),
+				  hkdf_context, hkdf_info, hkdf_infolen,
 				  mode_key, mode->keysize);
 	if (err)
 		return err;
-	tfm = fscrypt_allocate_skcipher(mode, mode_key, ci->ci_inode);
+	tfm = fscrypt_allocate_skcipher(mode, mode_key, inode);
 	memzero_explicit(mode_key, mode->keysize);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
 	/* pairs with READ_ONCE() above */
-	prev_tfm = cmpxchg(&mk->mk_mode_keys[mode_num], NULL, tfm);
+	prev_tfm = cmpxchg(&tfms[mode_num], NULL, tfm);
 	if (prev_tfm != NULL) {
 		crypto_free_skcipher(tfm);
 		tfm = prev_tfm;
@@ -180,7 +194,19 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 				     ci->ci_mode->friendly_name);
 			return -EINVAL;
 		}
-		return setup_per_mode_key(ci, mk);
+		return setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
+					  HKDF_CONTEXT_DIRECT_KEY, false);
+	} else if (ci->ci_policy.v2.flags &
+		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
+		/*
+		 * IV_INO_LBLK_64: encryption keys are derived from (master_key,
+		 * mode_num, filesystem_uuid), and inode number is included in
+		 * the IVs.  This format is optimized for use with inline
+		 * encryption hardware compliant with the UFS or eMMC standards.
+		 */
+		return setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
+					  HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
+					  true);
 	}
 
 	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
@@ -304,8 +330,7 @@ static void put_crypt_info(struct fscrypt_info *ci)
 
 	if (ci->ci_direct_key)
 		fscrypt_put_direct_key(ci->ci_direct_key);
-	else if (ci->ci_ctfm != NULL &&
-		 !fscrypt_is_direct_key_policy(&ci->ci_policy))
+	else if (ci->ci_owns_key)
 		crypto_free_skcipher(ci->ci_ctfm);
 
 	key = ci->ci_master_key;
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 4072ba644595b..96f528071bed3 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -29,6 +29,40 @@ bool fscrypt_policies_equal(const union fscrypt_policy *policy1,
 	return !memcmp(policy1, policy2, fscrypt_policy_size(policy1));
 }
 
+static bool supported_iv_ino_lblk_64_policy(
+					const struct fscrypt_policy_v2 *policy,
+					const struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	int ino_bits = 64, lblk_bits = 64;
+
+	if (policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
+		fscrypt_warn(inode,
+			     "The DIRECT_KEY and IV_INO_LBLK_64 flags are mutually exclusive");
+		return false;
+	}
+	/*
+	 * It's unsafe to include inode numbers in the IVs if the filesystem can
+	 * potentially renumber inodes, e.g. via filesystem shrinking.
+	 */
+	if (!sb->s_cop->has_stable_inodes ||
+	    !sb->s_cop->has_stable_inodes(sb)) {
+		fscrypt_warn(inode,
+			     "Can't use IV_INO_LBLK_64 policy on filesystem '%s' because it doesn't have stable inode numbers",
+			     sb->s_id);
+		return false;
+	}
+	if (sb->s_cop->get_ino_and_lblk_bits)
+		sb->s_cop->get_ino_and_lblk_bits(sb, &ino_bits, &lblk_bits);
+	if (ino_bits > 32 || lblk_bits > 32) {
+		fscrypt_warn(inode,
+			     "Can't use IV_INO_LBLK_64 policy on filesystem '%s' because it doesn't use 32-bit inode and block numbers",
+			     sb->s_id);
+		return false;
+	}
+	return true;
+}
+
 /**
  * fscrypt_supported_policy - check whether an encryption policy is supported
  *
@@ -55,7 +89,8 @@ bool fscrypt_supported_policy(const union fscrypt_policy *policy_u,
 			return false;
 		}
 
-		if (policy->flags & ~FSCRYPT_POLICY_FLAGS_VALID) {
+		if (policy->flags & ~(FSCRYPT_POLICY_FLAGS_PAD_MASK |
+				      FSCRYPT_POLICY_FLAG_DIRECT_KEY)) {
 			fscrypt_warn(inode,
 				     "Unsupported encryption flags (0x%02x)",
 				     policy->flags);
@@ -83,6 +118,10 @@ bool fscrypt_supported_policy(const union fscrypt_policy *policy_u,
 			return false;
 		}
 
+		if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) &&
+		    !supported_iv_ino_lblk_64_policy(policy, inode))
+			return false;
+
 		if (memchr_inv(policy->__reserved, 0,
 			       sizeof(policy->__reserved))) {
 			fscrypt_warn(inode,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 04f5ed6284454..1a7bffe78ed56 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -61,6 +61,9 @@ struct fscrypt_operations {
 	bool (*dummy_context)(struct inode *);
 	bool (*empty_dir)(struct inode *);
 	unsigned int max_namelen;
+	bool (*has_stable_inodes)(struct super_block *sb);
+	void (*get_ino_and_lblk_bits)(struct super_block *sb,
+				      int *ino_bits_ret, int *lblk_bits_ret);
 };
 
 static inline bool fscrypt_has_encryption_key(const struct inode *inode)
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index 39ccfe9311c38..1beb174ad9505 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -17,7 +17,8 @@
 #define FSCRYPT_POLICY_FLAGS_PAD_32		0x03
 #define FSCRYPT_POLICY_FLAGS_PAD_MASK		0x03
 #define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04
-#define FSCRYPT_POLICY_FLAGS_VALID		0x07
+#define FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64	0x08
+#define FSCRYPT_POLICY_FLAGS_VALID		0x0F
 
 /* Encryption algorithms */
 #define FSCRYPT_MODE_AES_256_XTS		1
-- 
2.24.0.rc0.303.g954a862665-goog

