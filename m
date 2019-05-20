Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A1623EC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 19:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392967AbfETR3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 13:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392935AbfETR2x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 13:28:53 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3228521783;
        Mon, 20 May 2019 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558373330;
        bh=eabhokJLhXT0JNgvm34EvknXYP+4p+Jqt4Zm1WNN4AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OB8D3I8OCJiHmWfxOTcALDchX4YxobQnGcZ1gT0jfKWwuVFVz0y2aIYkuu0BaRBy4
         1QFlSX40Sy06H0cCfoNHGqZYecNzhrcpFxB6lbP6eVQVqr6dTF1ERwNfh6qqhVg1WN
         OTbLY1tjh4stxxymZjd+JzIOnRADDGtNGFK7hTAo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, keyrings@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>
Subject: [PATCH v6 10/16] fscrypt: v2 encryption policy support
Date:   Mon, 20 May 2019 10:25:46 -0700
Message-Id: <20190520172552.217253-11-ebiggers@kernel.org>
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

Add a new fscrypt policy version, "v2".  It has the following changes
from the original policy version, which we call "v1" (*):

- Master keys (the user-provided encryption keys) are only ever used as
  input to HKDF-SHA512.  This is more flexible and less error-prone, and
  it avoids the quirks and limitations of the AES-128-ECB based KDF.
  Three classes of cryptographically isolated subkeys are defined:

    - Per-file keys, like used in v1 policies except for the new KDF.

    - Per-mode keys.  These implement the semantics of the DIRECT_KEY
      flag, which for v1 policies made the master key be used directly.
      These are also planned to be used for inline encryption when
      support for it is added.

    - Key identifiers (see below).

- Each master key is identified by a 16-byte master_key_identifier,
  which is derived from the key itself using HKDF-SHA512.  This prevents
  users from associating the wrong key with an encrypted file or
  directory.  This was easily possible with v1 policies, which
  identified the key by an arbitrary 8-byte master_key_descriptor.

- The key must be provided in the filesystem-level keyring, not in a
  process-subscribed keyring.

The following UAPI additions are made:

- The existing ioctl FS_IOC_SET_ENCRYPTION_POLICY can now be passed a
  fscrypt_policy_v2 to set a v2 encryption policy.  It's disambiguated
  from fscrypt_policy/fscrypt_policy_v1 by the version code prefix.

- A new ioctl FS_IOC_GET_ENCRYPTION_POLICY_EX is added.  It allows
  getting the v1 or v2 encryption policy of an encrypted file or
  directory.  The existing FS_IOC_GET_ENCRYPTION_POLICY ioctl could not
  be used because it did not have a way for userspace to indicate which
  policy structure is expected.  The new ioctl includes a size field, so
  it is extensible to future fscrypt policy versions.

- The ioctls FS_IOC_ADD_ENCRYPTION_KEY, FS_IOC_REMOVE_ENCRYPTION_KEY,
  and FS_IOC_GET_ENCRYPTION_KEY_STATUS now support managing keys for v2
  encryption policies.  Such keys are kept logically separate from keys
  for v1 encryption policies, and are identified by 'identifier' rather
  than by 'descriptor'.  The 'identifier' need not be provided when
  adding a key, since the kernel will calculate it anyway.

This patch temporarily keeps adding/removing v2 policy keys behind the
same permission check done for adding/removing v1 policy keys:
capable(CAP_SYS_ADMIN).  However, the next patch will carefully take
advantage of the cryptographically secure master_key_identifier to allow
non-root users to add/remove v2 policy keys, thus providing a full
replacement for v1 policies.

(*) Actually, in the API fscrypt_policy::version is 0 while on-disk
    fscrypt_context::format is 1.  But I believe it makes the most sense
    to advance both to '2' to have them be in sync, and to consider the
    numbering to start at 1 except for the API quirk.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/crypto.c           |   3 +-
 fs/crypto/fname.c            |   3 +-
 fs/crypto/fscrypt_private.h  | 182 ++++++++++++++---
 fs/crypto/keyring.c          |  37 +++-
 fs/crypto/keysetup.c         | 174 ++++++++++++----
 fs/crypto/keysetup_legacy.c  |  18 +-
 fs/crypto/policy.c           | 386 +++++++++++++++++++++++++----------
 include/linux/fscrypt.h      |   9 +-
 include/uapi/linux/fscrypt.h |  42 +++-
 9 files changed, 671 insertions(+), 183 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 3fe287952ac95..45da5b46c1f88 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -26,7 +26,6 @@
 #include <linux/ratelimit.h>
 #include <linux/dcache.h>
 #include <linux/namei.h>
-#include <crypto/aes.h>
 #include <crypto/skcipher.h>
 #include "fscrypt_private.h"
 
@@ -133,7 +132,7 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 	memset(iv, 0, ci->ci_mode->ivsize);
 	iv->lblk_num = cpu_to_le64(lblk_num);
 
-	if (ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
+	if (fscrypt_is_direct_key_policy(&ci->ci_policy))
 		memcpy(iv->nonce, ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE);
 
 	if (ci->ci_essiv_tfm != NULL)
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 65f1bda87c3c9..e024d459c9bc5 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -186,7 +186,8 @@ static int digest_decode(const char *src, int len, char *dst)
 bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
 				  u32 max_len, u32 *encrypted_len_ret)
 {
-	int padding = 4 << (inode->i_crypt_info->ci_flags &
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	int padding = 4 << (fscrypt_policy_flags(&ci->ci_policy) &
 			    FSCRYPT_POLICY_FLAGS_PAD_MASK);
 	u32 encrypted_len;
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index e2a65189eb578..9591f5fd72b33 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -20,27 +20,127 @@
 
 #define FSCRYPT_MIN_KEY_SIZE		16
 
-/**
- * Encryption context for inode
- *
- * Protector format:
- *  1 byte: Protector format (1 = this version)
- *  1 byte: File contents encryption mode
- *  1 byte: File names encryption mode
- *  1 byte: Flags
- *  8 bytes: Master Key descriptor
- *  16 bytes: Encryption Key derivation nonce
- */
-struct fscrypt_context {
-	u8 format;
+#define FSCRYPT_CONTEXT_V1	1
+#define FSCRYPT_CONTEXT_V2	2
+
+struct fscrypt_context_v1 {
+	u8 version; /* FSCRYPT_CONTEXT_V1 */
 	u8 contents_encryption_mode;
 	u8 filenames_encryption_mode;
 	u8 flags;
 	u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
 	u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
-} __packed;
+};
+
+struct fscrypt_context_v2 {
+	u8 version; /* FSCRYPT_CONTEXT_V2 */
+	u8 contents_encryption_mode;
+	u8 filenames_encryption_mode;
+	u8 flags;
+	u8 __reserved[4];
+	u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+	u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
+};
+
+/**
+ * fscrypt_context - the encryption context of an inode
+ *
+ * This is the on-disk equivalent of an fscrypt_policy, stored alongside each
+ * encrypted file usually in a hidden extended attribute.  It contains the
+ * fields from the fscrypt_policy, in order to identify the encryption algorithm
+ * and key with which the file is encrypted.  It also contains a nonce that was
+ * randomly generated by fscrypt itself; this is used as KDF input or as a tweak
+ * to cause different files to be encrypted differently.
+ */
+union fscrypt_context {
+	u8 version;
+	struct fscrypt_context_v1 v1;
+	struct fscrypt_context_v2 v2;
+};
+
+/*
+ * Return the size expected for the given fscrypt_context based on its version
+ * number, or 0 if the context version is unrecognized.
+ */
+static inline int fscrypt_context_size(const union fscrypt_context *ctx)
+{
+	switch (ctx->version) {
+	case FSCRYPT_CONTEXT_V1:
+		BUILD_BUG_ON(sizeof(ctx->v1) != 28);
+		return sizeof(ctx->v1);
+	case FSCRYPT_CONTEXT_V2:
+		BUILD_BUG_ON(sizeof(ctx->v2) != 40);
+		return sizeof(ctx->v2);
+	}
+	return 0;
+}
+
+#undef fscrypt_policy
+union fscrypt_policy {
+	__u8 version;
+	struct fscrypt_policy_v1 v1;
+	struct fscrypt_policy_v2 v2;
+};
+
+/*
+ * Return the size expected for the given fscrypt_policy based on its version
+ * number, or 0 if the policy version is unrecognized.
+ */
+static inline int fscrypt_policy_size(const union fscrypt_policy *policy)
+{
+	switch (policy->version) {
+	case FSCRYPT_POLICY_V1:
+		return sizeof(policy->v1);
+	case FSCRYPT_POLICY_V2:
+		return sizeof(policy->v2);
+	}
+	return 0;
+}
 
-#define FS_ENCRYPTION_CONTEXT_FORMAT_V1		1
+/* Return the contents encryption mode of a valid encryption policy */
+static inline u8
+fscrypt_policy_contents_mode(const union fscrypt_policy *policy)
+{
+	switch (policy->version) {
+	case FSCRYPT_POLICY_V1:
+		return policy->v1.contents_encryption_mode;
+	case FSCRYPT_POLICY_V2:
+		return policy->v2.contents_encryption_mode;
+	}
+	BUG();
+}
+
+/* Return the filenames encryption mode of a valid encryption policy */
+static inline u8
+fscrypt_policy_fnames_mode(const union fscrypt_policy *policy)
+{
+	switch (policy->version) {
+	case FSCRYPT_POLICY_V1:
+		return policy->v1.filenames_encryption_mode;
+	case FSCRYPT_POLICY_V2:
+		return policy->v2.filenames_encryption_mode;
+	}
+	BUG();
+}
+
+/* Return the flags (FSCRYPT_POLICY_FLAG*) of a valid encryption policy */
+static inline u8
+fscrypt_policy_flags(const union fscrypt_policy *policy)
+{
+	switch (policy->version) {
+	case FSCRYPT_POLICY_V1:
+		return policy->v1.flags;
+	case FSCRYPT_POLICY_V2:
+		return policy->v2.flags;
+	}
+	BUG();
+}
+
+static inline bool
+fscrypt_is_direct_key_policy(const union fscrypt_policy *policy)
+{
+	return fscrypt_policy_flags(policy) & FSCRYPT_POLICY_FLAG_DIRECT_KEY;
+}
 
 /**
  * For encrypted symlinks, the ciphertext length is stored at the beginning
@@ -70,8 +170,8 @@ struct fscrypt_info {
 	struct crypto_cipher *ci_essiv_tfm;
 
 	/*
-	 * Encryption mode used for this inode.  It corresponds to either
-	 * ci_data_mode or ci_filename_mode, depending on the inode type.
+	 * Encryption mode used for this inode.  It corresponds to either the
+	 * contents or filenames encryption mode, depending on the inode type.
 	 */
 	struct fscrypt_mode *ci_mode;
 
@@ -97,11 +197,10 @@ struct fscrypt_info {
 	 */
 	struct fscrypt_direct_key *ci_direct_key;
 
-	/* fields from the fscrypt_context */
-	u8 ci_data_mode;
-	u8 ci_filename_mode;
-	u8 ci_flags;
-	u8 ci_master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+	/* The encryption policy used by this inode */
+	union fscrypt_policy ci_policy;
+
+	/* This inode's nonce, copied from the fscrypt_context */
 	u8 ci_nonce[FS_KEY_DERIVATION_NONCE_SIZE];
 };
 
@@ -184,6 +283,17 @@ struct fscrypt_hkdf {
 extern int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 			     unsigned int master_key_size);
 
+/*
+ * The list of contexts in which fscrypt uses HKDF.  These values are used as
+ * the first byte of the HKDF application-specific info string to guarantee that
+ * info strings are never repeated between contexts.  This ensures that all HKDF
+ * outputs are unique and cryptographically isolated, i.e. knowledge of one
+ * output doesn't reveal another.
+ */
+#define HKDF_CONTEXT_KEY_IDENTIFIER	1
+#define HKDF_CONTEXT_PER_FILE_KEY	2
+#define HKDF_CONTEXT_PER_MODE_KEY	3
+
 extern int fscrypt_hkdf_expand(struct fscrypt_hkdf *hkdf, u8 context,
 			       const u8 *info, unsigned int infolen,
 			       u8 *okm, unsigned int okmlen);
@@ -197,10 +307,16 @@ extern void fscrypt_destroy_hkdf(struct fscrypt_hkdf *hkdf);
  */
 struct fscrypt_master_key_secret {
 
-	/* Size of the raw key in bytes */
+	/*
+	 * For v2 policy keys: HKDF context keyed by this master key.
+	 * For v1 policy keys: not set (hkdf.hmac_tfm == NULL).
+	 */
+	struct fscrypt_hkdf	hkdf;
+
+	/* Size of the raw key in bytes.  Set even if ->raw isn't set. */
 	u32			size;
 
-	/* The raw key */
+	/* For v1 policy keys: the raw key.  Wiped for v2 policy keys. */
 	u8			raw[FSCRYPT_MAX_KEY_SIZE];
 
 } __randomize_layout;
@@ -226,7 +342,12 @@ struct fscrypt_master_key {
 	 */
 	struct fscrypt_master_key_secret	mk_secret;
 
-	/* Arbitrary key descriptor which was assigned by userspace */
+	/*
+	 * For v1 policy keys: an arbitrary key descriptor which was assigned by
+	 * userspace (->descriptor).
+	 *
+	 * For v2 policy keys: a cryptographic hash of this key (->identifier).
+	 */
 	struct fscrypt_key_specifier		mk_spec;
 
 	/*
@@ -245,6 +366,9 @@ struct fscrypt_master_key {
 	struct list_head	mk_decrypted_inodes;
 	spinlock_t		mk_decrypted_inodes_lock;
 
+	/* Per-mode tfms for DIRECT_KEY policies, allocated on-demand */
+	struct crypto_skcipher	*mk_mode_keys[__FSCRYPT_MODE_MAX + 1];
+
 } __randomize_layout;
 
 static inline bool
@@ -302,5 +426,13 @@ extern int fscrypt_setup_v1_file_key(struct fscrypt_info *ci,
 
 extern int fscrypt_setup_v1_file_key_via_subscribed_keyrings(
 					struct fscrypt_info *ci);
+/* policy.c */
+
+extern bool fscrypt_policies_equal(const union fscrypt_policy *policy1,
+				   const union fscrypt_policy *policy2);
+extern bool fscrypt_supported_policy(const union fscrypt_policy *policy_u);
+extern int fscrypt_policy_from_context(union fscrypt_policy *policy_u,
+				       const union fscrypt_context *ctx_u,
+				       int ctx_size);
 
 #endif /* _FSCRYPT_PRIVATE_H */
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 97e1360e4610c..fb1d247898f93 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -14,6 +14,7 @@
  * - FS_IOC_GET_ENCRYPTION_KEY_STATUS: get key status
  */
 
+#include <crypto/skcipher.h>
 #include <linux/key-type.h>
 #include <linux/seq_file.h>
 
@@ -21,6 +22,7 @@
 
 static void wipe_master_key_secret(struct fscrypt_master_key_secret *secret)
 {
+	fscrypt_destroy_hkdf(&secret->hkdf);
 	memzero_explicit(secret, sizeof(*secret));
 }
 
@@ -33,7 +35,13 @@ static void move_master_key_secret(struct fscrypt_master_key_secret *dst,
 
 static void free_master_key(struct fscrypt_master_key *mk)
 {
+	size_t i;
+
 	wipe_master_key_secret(&mk->mk_secret);
+
+	for (i = 0; i < ARRAY_SIZE(mk->mk_mode_keys); i++)
+		crypto_free_skcipher(mk->mk_mode_keys[i]);
+
 	kzfree(mk);
 }
 
@@ -42,6 +50,8 @@ static inline int master_key_spec_len(const struct fscrypt_key_specifier *spec)
 	switch (spec->type) {
 	case FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR:
 		return FSCRYPT_KEY_DESCRIPTOR_SIZE;
+	case FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER:
+		return FSCRYPT_KEY_IDENTIFIER_SIZE;
 	}
 	return 0;
 }
@@ -115,7 +125,7 @@ static struct key *search_fscrypt_keyring(struct key *keyring,
 #define FSCRYPT_FS_KEYRING_DESCRIPTION_SIZE	\
 	(CONST_STRLEN("fscrypt-") + FIELD_SIZEOF(struct super_block, s_id))
 
-#define FSCRYPT_MK_DESCRIPTION_SIZE	(2 * FSCRYPT_KEY_DESCRIPTOR_SIZE + 1)
+#define FSCRYPT_MK_DESCRIPTION_SIZE	(2 * FSCRYPT_KEY_IDENTIFIER_SIZE + 1)
 
 static void format_fs_keyring_description(
 			char description[FSCRYPT_FS_KEYRING_DESCRIPTION_SIZE],
@@ -319,6 +329,31 @@ int fscrypt_ioctl_add_key(struct file *filp, void __user *_uarg)
 	if (!capable(CAP_SYS_ADMIN))
 		goto out_wipe_secret;
 
+	if (arg.key_spec.type != FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR) {
+		err = fscrypt_init_hkdf(&secret.hkdf, secret.raw, secret.size);
+		if (err)
+			goto out_wipe_secret;
+
+		/*
+		 * Now that the HKDF context is initialized, the raw key is no
+		 * longer needed.
+		 */
+		memzero_explicit(secret.raw, secret.size);
+
+		/* Calculate the key identifier and return it to userspace. */
+		err = fscrypt_hkdf_expand(&secret.hkdf,
+					  HKDF_CONTEXT_KEY_IDENTIFIER,
+					  NULL, 0, arg.key_spec.u.identifier,
+					  FSCRYPT_KEY_IDENTIFIER_SIZE);
+		if (err)
+			goto out_wipe_secret;
+		err = -EFAULT;
+		if (copy_to_user(uarg->key_spec.u.identifier,
+				 arg.key_spec.u.identifier,
+				 FSCRYPT_KEY_IDENTIFIER_SIZE))
+			goto out_wipe_secret;
+	}
+
 	err = add_master_key(sb, &secret, &arg.key_spec);
 out_wipe_secret:
 	wipe_master_key_secret(&secret);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 55cb146a8a617..e88524b730ac0 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -52,21 +52,14 @@ static struct fscrypt_mode available_modes[] = {
 };
 
 static struct fscrypt_mode *
-select_encryption_mode(const struct fscrypt_info *ci, const struct inode *inode)
+select_encryption_mode(const union fscrypt_policy *policy,
+		       const struct inode *inode)
 {
-	if (!fscrypt_valid_enc_modes(ci->ci_data_mode, ci->ci_filename_mode)) {
-		fscrypt_warn(inode->i_sb,
-			     "inode %lu uses unsupported encryption modes (contents mode %d, filenames mode %d)",
-			     inode->i_ino, ci->ci_data_mode,
-			     ci->ci_filename_mode);
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (S_ISREG(inode->i_mode))
-		return &available_modes[ci->ci_data_mode];
+		return &available_modes[fscrypt_policy_contents_mode(policy)];
 
 	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
-		return &available_modes[ci->ci_filename_mode];
+		return &available_modes[fscrypt_policy_fnames_mode(policy)];
 
 	WARN_ONCE(1, "fscrypt: filesystem tried to load encryption info for inode %lu, which is not encryptable (file type %d)\n",
 		  inode->i_ino, (inode->i_mode & S_IFMT));
@@ -207,6 +200,83 @@ int fscrypt_set_derived_key(struct fscrypt_info *ci, const u8 *derived_key)
 	return 0;
 }
 
+static int setup_per_mode_key(struct fscrypt_info *ci,
+			      struct fscrypt_master_key *mk)
+{
+	struct fscrypt_mode *mode = ci->ci_mode;
+	u8 mode_num = mode - available_modes;
+	struct crypto_skcipher *tfm, *prev_tfm;
+	u8 mode_key[FSCRYPT_MAX_KEY_SIZE];
+	int err;
+
+	if (WARN_ON(mode_num >= ARRAY_SIZE(mk->mk_mode_keys)))
+		return -EINVAL;
+
+	/* pairs with cmpxchg() below */
+	tfm = READ_ONCE(mk->mk_mode_keys[mode_num]);
+	if (likely(tfm != NULL))
+		goto done;
+
+	BUILD_BUG_ON(sizeof(mode_num) != 1);
+	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+				  HKDF_CONTEXT_PER_MODE_KEY,
+				  &mode_num, sizeof(mode_num),
+				  mode_key, mode->keysize);
+	if (err)
+		return err;
+	tfm = fscrypt_allocate_skcipher(mode, mode_key, ci->ci_inode);
+	memzero_explicit(mode_key, mode->keysize);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	/* pairs with READ_ONCE() above */
+	prev_tfm = cmpxchg(&mk->mk_mode_keys[mode_num], NULL, tfm);
+	if (prev_tfm != NULL) {
+		crypto_free_skcipher(tfm);
+		tfm = prev_tfm;
+	}
+done:
+	ci->ci_ctfm = tfm;
+	return 0;
+}
+
+static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
+				     struct fscrypt_master_key *mk)
+{
+	u8 derived_key[FSCRYPT_MAX_KEY_SIZE];
+	int err;
+
+	if (ci->ci_policy.v2.flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
+		/*
+		 * DIRECT_KEY: instead of deriving per-file keys, the per-file
+		 * nonce will be included in all the IVs.  But unlike v1
+		 * policies, for v2 policies in this case we don't encrypt with
+		 * the master key directly but rather derive a per-mode key.
+		 * This ensures that the master key is consistently used only
+		 * for HKDF, avoiding key reuse issues.
+		 */
+		if (!fscrypt_mode_supports_direct_key(ci->ci_mode)) {
+			fscrypt_warn(ci->ci_inode->i_sb,
+				     "direct key flag not allowed with %s",
+				     ci->ci_mode->friendly_name);
+			return -EINVAL;
+		}
+		return setup_per_mode_key(ci, mk);
+	}
+
+	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+				  HKDF_CONTEXT_PER_FILE_KEY,
+				  ci->ci_nonce,
+				  FS_KEY_DERIVATION_NONCE_SIZE,
+				  derived_key, ci->ci_mode->keysize);
+	if (err)
+		return err;
+
+	err = fscrypt_set_derived_key(ci, derived_key);
+	memzero_explicit(derived_key, ci->ci_mode->keysize);
+	return err;
+}
+
 /*
  * Find the master key, then set up the inode's actual encryption key.
  *
@@ -225,15 +295,30 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 	struct fscrypt_key_specifier mk_spec;
 	int err;
 
-	mk_spec.type = FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR;
-	memcpy(mk_spec.u.descriptor, ci->ci_master_key_descriptor,
-	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
+	if (ci->ci_policy.version == FSCRYPT_POLICY_V1) {
+		mk_spec.type = FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR;
+		memcpy(mk_spec.u.descriptor,
+		       ci->ci_policy.v1.master_key_descriptor,
+		       FSCRYPT_KEY_DESCRIPTOR_SIZE);
+	} else {
+		mk_spec.type = FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER;
+		memcpy(mk_spec.u.identifier,
+		       ci->ci_policy.v2.master_key_identifier,
+		       FSCRYPT_KEY_IDENTIFIER_SIZE);
+	}
 
 	key = fscrypt_find_master_key(ci->ci_inode->i_sb, &mk_spec);
 	if (IS_ERR(key)) {
-		if (key != ERR_PTR(-ENOKEY))
+		if (key != ERR_PTR(-ENOKEY) ||
+		    ci->ci_policy.version != FSCRYPT_POLICY_V1)
 			return PTR_ERR(key);
 
+		/*
+		 * As a legacy fallback for v1 policies, search for the key in
+		 * the current task's subscribed keyrings too.  Don't move this
+		 * to before the search of ->s_master_keys, since users
+		 * shouldn't be able to override filesystem-level keys.
+		 */
 		return fscrypt_setup_v1_file_key_via_subscribed_keyrings(ci);
 	}
 
@@ -246,6 +331,12 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 		goto out_release_key;
 	}
 
+	/*
+	 * Require that the master key be at least as long as the derived key.
+	 * Otherwise, the derived key cannot possibly contain as much entropy as
+	 * that required by the encryption mode it will be used for.  For v1
+	 * policies it's also required for the KDF to work at all.
+	 */
 	if (mk->mk_secret.size < ci->ci_mode->keysize) {
 		fscrypt_warn(NULL,
 			     "key with description '%s' is too short (got %u bytes, need %u+ bytes)",
@@ -255,7 +346,10 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 		goto out_release_key;
 	}
 
-	err = fscrypt_setup_v1_file_key(ci, mk->mk_secret.raw);
+	if (ci->ci_policy.version == FSCRYPT_POLICY_V1)
+		err = fscrypt_setup_v1_file_key(ci, mk->mk_secret.raw);
+	else
+		err = fscrypt_setup_v2_file_key(ci, mk);
 	if (err)
 		goto out_release_key;
 
@@ -277,7 +371,8 @@ static void put_crypt_info(struct fscrypt_info *ci)
 
 	if (ci->ci_direct_key) {
 		fscrypt_put_direct_key(ci->ci_direct_key);
-	} else {
+	} else if ((ci->ci_ctfm != NULL || ci->ci_essiv_tfm != NULL) &&
+		   !fscrypt_is_direct_key_policy(&ci->ci_policy)) {
 		crypto_free_skcipher(ci->ci_ctfm);
 		crypto_free_cipher(ci->ci_essiv_tfm);
 	}
@@ -307,7 +402,7 @@ static void put_crypt_info(struct fscrypt_info *ci)
 int fscrypt_get_encryption_info(struct inode *inode)
 {
 	struct fscrypt_info *crypt_info;
-	struct fscrypt_context ctx;
+	union fscrypt_context ctx;
 	struct fscrypt_mode *mode;
 	struct key *master_key = NULL;
 	int res;
@@ -326,35 +421,40 @@ int fscrypt_get_encryption_info(struct inode *inode)
 			return res;
 		/* Fake up a context for an unencrypted directory */
 		memset(&ctx, 0, sizeof(ctx));
-		ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
-		ctx.contents_encryption_mode = FSCRYPT_MODE_AES_256_XTS;
-		ctx.filenames_encryption_mode = FSCRYPT_MODE_AES_256_CTS;
-		memset(ctx.master_key_descriptor, 0x42,
+		ctx.version = FSCRYPT_CONTEXT_V1;
+		ctx.v1.contents_encryption_mode = FSCRYPT_MODE_AES_256_XTS;
+		ctx.v1.filenames_encryption_mode = FSCRYPT_MODE_AES_256_CTS;
+		memset(ctx.v1.master_key_descriptor, 0x42,
 		       FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	} else if (res != sizeof(ctx)) {
-		return -EINVAL;
+		res = sizeof(ctx.v1);
 	}
 
-	if (ctx.format != FS_ENCRYPTION_CONTEXT_FORMAT_V1)
-		return -EINVAL;
-
-	if (ctx.flags & ~FSCRYPT_POLICY_FLAGS_VALID)
-		return -EINVAL;
-
 	crypt_info = kmem_cache_zalloc(fscrypt_info_cachep, GFP_NOFS);
 	if (!crypt_info)
 		return -ENOMEM;
 
 	crypt_info->ci_inode = inode;
 
-	crypt_info->ci_flags = ctx.flags;
-	crypt_info->ci_data_mode = ctx.contents_encryption_mode;
-	crypt_info->ci_filename_mode = ctx.filenames_encryption_mode;
-	memcpy(crypt_info->ci_master_key_descriptor, ctx.master_key_descriptor,
-	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	memcpy(crypt_info->ci_nonce, ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
+	res = fscrypt_policy_from_context(&crypt_info->ci_policy, &ctx, res);
+	if (res)
+		goto out;
+
+	if (ctx.version == FSCRYPT_CONTEXT_V1)
+		memcpy(crypt_info->ci_nonce, ctx.v1.nonce,
+		       FS_KEY_DERIVATION_NONCE_SIZE);
+	else
+		memcpy(crypt_info->ci_nonce, ctx.v2.nonce,
+		       FS_KEY_DERIVATION_NONCE_SIZE);
+
+	if (!fscrypt_supported_policy(&crypt_info->ci_policy)) {
+		fscrypt_warn(inode->i_sb,
+			     "inode %lu uses unsupported encryption policy",
+			     inode->i_ino);
+		res = -EINVAL;
+		goto out;
+	}
 
-	mode = select_encryption_mode(crypt_info, inode);
+	mode = select_encryption_mode(&crypt_info->ci_policy, inode);
 	if (IS_ERR(mode)) {
 		res = PTR_ERR(mode);
 		goto out;
diff --git a/fs/crypto/keysetup_legacy.c b/fs/crypto/keysetup_legacy.c
index 407daa0b64d82..1ec420b189f0f 100644
--- a/fs/crypto/keysetup_legacy.c
+++ b/fs/crypto/keysetup_legacy.c
@@ -189,12 +189,13 @@ find_or_insert_direct_key(struct fscrypt_direct_key *to_insert,
 	 */
 
 	BUILD_BUG_ON(sizeof(hash_key) > FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	memcpy(&hash_key, ci->ci_master_key_descriptor, sizeof(hash_key));
+	memcpy(&hash_key, ci->ci_policy.v1.master_key_descriptor,
+	       sizeof(hash_key));
 
 	spin_lock(&fscrypt_direct_keys_lock);
 	hash_for_each_possible(fscrypt_direct_keys, dk, dk_node, hash_key) {
-		if (memcmp(ci->ci_master_key_descriptor, dk->dk_descriptor,
-			   FSCRYPT_KEY_DESCRIPTOR_SIZE) != 0)
+		if (memcmp(ci->ci_policy.v1.master_key_descriptor,
+			   dk->dk_descriptor, FSCRYPT_KEY_DESCRIPTOR_SIZE) != 0)
 			continue;
 		if (ci->ci_mode != dk->dk_mode)
 			continue;
@@ -237,7 +238,7 @@ fscrypt_get_direct_key(const struct fscrypt_info *ci, const u8 *raw_key)
 		dk->dk_ctfm = NULL;
 		goto err_free_dk;
 	}
-	memcpy(dk->dk_descriptor, ci->ci_master_key_descriptor,
+	memcpy(dk->dk_descriptor, ci->ci_policy.v1.master_key_descriptor,
 	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
 	memcpy(dk->dk_raw, raw_key, ci->ci_mode->keysize);
 
@@ -262,7 +263,8 @@ static int setup_v1_file_key_direct(struct fscrypt_info *ci,
 		return -EINVAL;
 	}
 
-	if (ci->ci_data_mode != ci->ci_filename_mode) {
+	if (ci->ci_policy.v1.contents_encryption_mode !=
+	    ci->ci_policy.v1.filenames_encryption_mode) {
 		fscrypt_warn(ci->ci_inode->i_sb,
 			     "direct key flag not allowed with different contents and filenames modes");
 		return -EINVAL;
@@ -308,7 +310,7 @@ static int setup_v1_file_key_derived(struct fscrypt_info *ci,
 
 int fscrypt_setup_v1_file_key(struct fscrypt_info *ci, const u8 *raw_master_key)
 {
-	if (ci->ci_flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
+	if (ci->ci_policy.v1.flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
 		return setup_v1_file_key_direct(ci, raw_master_key);
 	else
 		return setup_v1_file_key_derived(ci, raw_master_key);
@@ -321,11 +323,11 @@ int fscrypt_setup_v1_file_key_via_subscribed_keyrings(struct fscrypt_info *ci)
 	int err;
 
 	key = find_and_lock_process_key(FSCRYPT_KEY_DESC_PREFIX,
-					ci->ci_master_key_descriptor,
+					ci->ci_policy.v1.master_key_descriptor,
 					ci->ci_mode->keysize, &payload);
 	if (key == ERR_PTR(-ENOKEY) && ci->ci_inode->i_sb->s_cop->key_prefix) {
 		key = find_and_lock_process_key(ci->ci_inode->i_sb->s_cop->key_prefix,
-						ci->ci_master_key_descriptor,
+						ci->ci_policy.v1.master_key_descriptor,
 						ci->ci_mode->keysize, &payload);
 	}
 	if (IS_ERR(key))
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 18f1bf300ec44..3643156a511a7 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -5,8 +5,9 @@
  * Copyright (C) 2015, Google, Inc.
  * Copyright (C) 2015, Motorola Mobility.
  *
- * Written by Michael Halcrow, 2015.
+ * Originally written by Michael Halcrow, 2015.
  * Modified by Jaegeuk Kim, 2015.
+ * Modified by Eric Biggers, 2019 for v2 policy support.
  */
 
 #include <linux/random.h>
@@ -14,84 +15,265 @@
 #include <linux/mount.h>
 #include "fscrypt_private.h"
 
-/*
- * check whether an encryption policy is consistent with an encryption context
+/**
+ * fscrypt_policies_equal - check whether two encryption policies are the same
+ *
+ * Return: %true if equal, else %false
+ */
+bool fscrypt_policies_equal(const union fscrypt_policy *policy1,
+			    const union fscrypt_policy *policy2)
+{
+	if (policy1->version != policy2->version)
+		return false;
+
+	return !memcmp(policy1, policy2, fscrypt_policy_size(policy1));
+}
+
+/**
+ * fscrypt_supported_policy - check whether an encryption policy is supported
+ *
+ * Given an encryption policy, check whether all its encryption modes and other
+ * settings are supported by this kernel.  (But we don't currently don't check
+ * for crypto API support here, so attempting to use an algorithm not configured
+ * into the crypto API will still fail later.)
+ *
+ * Return: %true if supported, else %false
  */
-static bool is_encryption_context_consistent_with_policy(
-				const struct fscrypt_context *ctx,
-				const struct fscrypt_policy *policy)
+bool fscrypt_supported_policy(const union fscrypt_policy *policy_u)
 {
-	return memcmp(ctx->master_key_descriptor, policy->master_key_descriptor,
-		      FSCRYPT_KEY_DESCRIPTOR_SIZE) == 0 &&
-		(ctx->flags == policy->flags) &&
-		(ctx->contents_encryption_mode ==
-		 policy->contents_encryption_mode) &&
-		(ctx->filenames_encryption_mode ==
-		 policy->filenames_encryption_mode);
+	switch (policy_u->version) {
+	case FSCRYPT_POLICY_V1: {
+		const struct fscrypt_policy_v1 *policy = &policy_u->v1;
+
+		if (!fscrypt_valid_enc_modes(policy->contents_encryption_mode,
+					     policy->filenames_encryption_mode))
+			return false;
+
+		if (policy->flags & ~FSCRYPT_POLICY_FLAGS_VALID)
+			return false;
+
+		return true;
+	}
+	case FSCRYPT_POLICY_V2: {
+		const struct fscrypt_policy_v2 *policy = &policy_u->v2;
+
+		if (!fscrypt_valid_enc_modes(policy->contents_encryption_mode,
+					     policy->filenames_encryption_mode))
+			return false;
+
+		if (policy->flags & ~FSCRYPT_POLICY_FLAGS_VALID)
+			return false;
+
+		if (memchr_inv(policy->__reserved, 0,
+			       sizeof(policy->__reserved)))
+			return false;
+
+		return true;
+	}
+	}
+	return false;
 }
 
-static int create_encryption_context_from_policy(struct inode *inode,
-				const struct fscrypt_policy *policy)
+/**
+ * fscrypt_new_context_from_policy - create a new fscrypt_context from a policy
+ *
+ * Create an fscrypt_context for an inode that is being assigned the given
+ * encryption policy.  A new nonce is randomly generated.
+ *
+ * Return: the size of the new context in bytes.
+ */
+static int fscrypt_new_context_from_policy(union fscrypt_context *ctx_u,
+					   const union fscrypt_policy *policy_u)
 {
-	struct fscrypt_context ctx;
+	memset(ctx_u, 0, sizeof(*ctx_u));
+
+	switch (policy_u->version) {
+	case FSCRYPT_POLICY_V1: {
+		const struct fscrypt_policy_v1 *policy = &policy_u->v1;
+		struct fscrypt_context_v1 *ctx = &ctx_u->v1;
+
+		ctx->version = FSCRYPT_CONTEXT_V1;
+		ctx->contents_encryption_mode =
+			policy->contents_encryption_mode;
+		ctx->filenames_encryption_mode =
+			policy->filenames_encryption_mode;
+		ctx->flags = policy->flags;
+		memcpy(ctx->master_key_descriptor,
+		       policy->master_key_descriptor,
+		       sizeof(ctx->master_key_descriptor));
+		get_random_bytes(ctx->nonce, sizeof(ctx->nonce));
+		return sizeof(*ctx);
+	}
+	case FSCRYPT_POLICY_V2: {
+		const struct fscrypt_policy_v2 *policy = &policy_u->v2;
+		struct fscrypt_context_v2 *ctx = &ctx_u->v2;
+
+		ctx->version = FSCRYPT_CONTEXT_V2;
+		ctx->contents_encryption_mode =
+			policy->contents_encryption_mode;
+		ctx->filenames_encryption_mode =
+			policy->filenames_encryption_mode;
+		ctx->flags = policy->flags;
+		memcpy(ctx->master_key_identifier,
+		       policy->master_key_identifier,
+		       sizeof(ctx->master_key_identifier));
+		get_random_bytes(ctx->nonce, sizeof(ctx->nonce));
+		return sizeof(*ctx);
+	}
+	}
+	BUG();
+}
 
-	ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
-	memcpy(ctx.master_key_descriptor, policy->master_key_descriptor,
-					FSCRYPT_KEY_DESCRIPTOR_SIZE);
+/**
+ * fscrypt_policy_from_context - convert an fscrypt_context to an fscrypt_policy
+ *
+ * Given an fscrypt_context, build the corresponding fscrypt_policy.
+ *
+ * Return: 0 on success, or -EINVAL if the fscrypt_context has an unrecognized
+ * version number or size.
+ *
+ * This does *not* validate the settings within the policy itself, e.g. the
+ * modes, flags, and reserved bits.  Use fscrypt_supported_policy() for that.
+ */
+int fscrypt_policy_from_context(union fscrypt_policy *policy_u,
+				const union fscrypt_context *ctx_u,
+				int ctx_size)
+{
+	memset(policy_u, 0, sizeof(*policy_u));
 
-	if (!fscrypt_valid_enc_modes(policy->contents_encryption_mode,
-				     policy->filenames_encryption_mode))
+	if (ctx_size <= 0 || ctx_size != fscrypt_context_size(ctx_u))
 		return -EINVAL;
 
-	if (policy->flags & ~FSCRYPT_POLICY_FLAGS_VALID)
+	switch (ctx_u->version) {
+	case FSCRYPT_CONTEXT_V1: {
+		const struct fscrypt_context_v1 *ctx = &ctx_u->v1;
+		struct fscrypt_policy_v1 *policy = &policy_u->v1;
+
+		policy->version = FSCRYPT_POLICY_V1;
+		policy->contents_encryption_mode =
+			ctx->contents_encryption_mode;
+		policy->filenames_encryption_mode =
+			ctx->filenames_encryption_mode;
+		policy->flags = ctx->flags;
+		memcpy(policy->master_key_descriptor,
+		       ctx->master_key_descriptor,
+		       sizeof(policy->master_key_descriptor));
+		return 0;
+	}
+	case FSCRYPT_CONTEXT_V2: {
+		const struct fscrypt_context_v2 *ctx = &ctx_u->v2;
+		struct fscrypt_policy_v2 *policy = &policy_u->v2;
+
+		policy->version = FSCRYPT_POLICY_V2;
+		policy->contents_encryption_mode =
+			ctx->contents_encryption_mode;
+		policy->filenames_encryption_mode =
+			ctx->filenames_encryption_mode;
+		policy->flags = ctx->flags;
+		memcpy(policy->__reserved, ctx->__reserved,
+		       sizeof(policy->__reserved));
+		memcpy(policy->master_key_identifier,
+		       ctx->master_key_identifier,
+		       sizeof(policy->master_key_identifier));
+		return 0;
+	}
+	}
+	/* unreachable */
+	return -EINVAL;
+}
+
+/* Retrieve an inode's encryption policy */
+static int fscrypt_get_policy(struct inode *inode, union fscrypt_policy *policy)
+{
+	const struct fscrypt_info *ci;
+	union fscrypt_context ctx;
+	int ret;
+
+	ci = READ_ONCE(inode->i_crypt_info);
+	if (ci) {
+		/* key available, use the cached policy */
+		*policy = ci->ci_policy;
+		return 0;
+	}
+
+	if (!IS_ENCRYPTED(inode))
+		return -ENODATA;
+
+	ret = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
+	if (ret < 0)
+		return (ret == -ERANGE) ? -EINVAL : ret;
+
+	return fscrypt_policy_from_context(policy, &ctx, ret);
+}
+
+static int set_encryption_policy(struct inode *inode,
+				 const union fscrypt_policy *policy)
+{
+	union fscrypt_context ctx;
+	int ctxsize;
+
+	if (!fscrypt_supported_policy(policy))
 		return -EINVAL;
 
-	ctx.contents_encryption_mode = policy->contents_encryption_mode;
-	ctx.filenames_encryption_mode = policy->filenames_encryption_mode;
-	ctx.flags = policy->flags;
-	BUILD_BUG_ON(sizeof(ctx.nonce) != FS_KEY_DERIVATION_NONCE_SIZE);
-	get_random_bytes(ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
+	if (policy->version == FSCRYPT_POLICY_V1) {
+		/*
+		 * The original encryption policy version provided no way of
+		 * verifying that the correct master key was supplied, which was
+		 * insecure in scenarios where multiple users have access to the
+		 * same encrypted files (even just read-only access).  The new
+		 * encryption policy version fixes this and also implies use of
+		 * an improved key derivation function and allows non-root users
+		 * to securely remove keys.  So as long as compatibility with
+		 * old kernels isn't required, it is recommended to use the new
+		 * policy version for all new encrypted directories.
+		 */
+		pr_warn_once("%s (pid %d) is setting deprecated v1 encryption policy; recommend upgrading to v2.\n",
+			     current->comm, current->pid);
+	}
+
+	ctxsize = fscrypt_new_context_from_policy(&ctx, policy);
 
-	return inode->i_sb->s_cop->set_context(inode, &ctx, sizeof(ctx), NULL);
+	return inode->i_sb->s_cop->set_context(inode, &ctx, ctxsize, NULL);
 }
 
 int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg)
 {
-	struct fscrypt_policy policy;
+	union fscrypt_policy policy;
+	union fscrypt_policy existing_policy;
 	struct inode *inode = file_inode(filp);
+	int size;
 	int ret;
-	struct fscrypt_context ctx;
 
-	if (copy_from_user(&policy, arg, sizeof(policy)))
+	if (get_user(policy.version, (const u8 __user *)arg))
+		return -EFAULT;
+
+	size = fscrypt_policy_size(&policy);
+	if (size <= 0)
+		return -EINVAL;
+
+	if (copy_from_user((u8 *)&policy + 1, arg + 1, size - 1))
 		return -EFAULT;
 
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
-	if (policy.version != 0)
-		return -EINVAL;
-
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
 
 	inode_lock(inode);
 
-	ret = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
+	ret = fscrypt_get_policy(inode, &existing_policy);
 	if (ret == -ENODATA) {
 		if (!S_ISDIR(inode->i_mode))
 			ret = -ENOTDIR;
 		else if (!inode->i_sb->s_cop->empty_dir(inode))
 			ret = -ENOTEMPTY;
 		else
-			ret = create_encryption_context_from_policy(inode,
-								    &policy);
-	} else if (ret == sizeof(ctx) &&
-		   is_encryption_context_consistent_with_policy(&ctx,
-								&policy)) {
-		/* The file already uses the same encryption policy. */
-		ret = 0;
-	} else if (ret >= 0 || ret == -ERANGE) {
+			ret = set_encryption_policy(inode, &policy);
+	} else if (ret == -EINVAL ||
+		   (ret == 0 && !fscrypt_policies_equal(&policy,
+							&existing_policy))) {
 		/* The file already uses a different encryption policy. */
 		ret = -EEXIST;
 	}
@@ -103,37 +285,57 @@ int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg)
 }
 EXPORT_SYMBOL(fscrypt_ioctl_set_policy);
 
+/* Original ioctl version; can only get the original policy version */
 int fscrypt_ioctl_get_policy(struct file *filp, void __user *arg)
 {
-	struct inode *inode = file_inode(filp);
-	struct fscrypt_context ctx;
-	struct fscrypt_policy policy;
-	int res;
+	union fscrypt_policy policy;
+	int err;
 
-	if (!IS_ENCRYPTED(inode))
-		return -ENODATA;
+	err = fscrypt_get_policy(file_inode(filp), &policy);
+	if (err)
+		return err;
 
-	res = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
-	if (res < 0 && res != -ERANGE)
-		return res;
-	if (res != sizeof(ctx))
-		return -EINVAL;
-	if (ctx.format != FS_ENCRYPTION_CONTEXT_FORMAT_V1)
+	if (policy.version != FSCRYPT_POLICY_V1)
 		return -EINVAL;
 
-	policy.version = 0;
-	policy.contents_encryption_mode = ctx.contents_encryption_mode;
-	policy.filenames_encryption_mode = ctx.filenames_encryption_mode;
-	policy.flags = ctx.flags;
-	memcpy(policy.master_key_descriptor, ctx.master_key_descriptor,
-				FSCRYPT_KEY_DESCRIPTOR_SIZE);
-
-	if (copy_to_user(arg, &policy, sizeof(policy)))
+	if (copy_to_user(arg, &policy, sizeof(policy.v1)))
 		return -EFAULT;
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_ioctl_get_policy);
 
+/* Extended ioctl version; can get policies of any version */
+int fscrypt_ioctl_get_policy_ex(struct file *filp, void __user *uarg)
+{
+	struct fscrypt_get_policy_ex_arg arg;
+	union fscrypt_policy *policy = (union fscrypt_policy *)&arg.policy;
+	size_t policy_size;
+	int err;
+
+	/* arg is policy_size, then policy */
+	BUILD_BUG_ON(offsetof(typeof(arg), policy_size) != 0);
+	BUILD_BUG_ON(offsetofend(typeof(arg), policy_size) !=
+		     offsetof(typeof(arg), policy));
+	BUILD_BUG_ON(sizeof(arg.policy) != sizeof(*policy));
+
+	err = fscrypt_get_policy(file_inode(filp), policy);
+	if (err)
+		return err;
+	policy_size = fscrypt_policy_size(policy);
+
+	if (copy_from_user(&arg, uarg, sizeof(arg.policy_size)))
+		return -EFAULT;
+
+	if (policy_size > arg.policy_size)
+		return -EOVERFLOW;
+	arg.policy_size = policy_size;
+
+	if (copy_to_user(uarg, &arg, sizeof(arg.policy_size) + policy_size))
+		return -EFAULT;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fscrypt_ioctl_get_policy_ex);
+
 /**
  * fscrypt_has_permitted_context() - is a file's encryption policy permitted
  *				     within its directory?
@@ -155,10 +357,8 @@ EXPORT_SYMBOL(fscrypt_ioctl_get_policy);
  */
 int fscrypt_has_permitted_context(struct inode *parent, struct inode *child)
 {
-	const struct fscrypt_operations *cops = parent->i_sb->s_cop;
-	const struct fscrypt_info *parent_ci, *child_ci;
-	struct fscrypt_context parent_ctx, child_ctx;
-	int res;
+	union fscrypt_policy parent_policy, child_policy;
+	int err;
 
 	/* No restrictions on file types which are never encrypted */
 	if (!S_ISREG(child->i_mode) && !S_ISDIR(child->i_mode) &&
@@ -188,41 +388,22 @@ int fscrypt_has_permitted_context(struct inode *parent, struct inode *child)
 	 * In any case, if an unexpected error occurs, fall back to "forbidden".
 	 */
 
-	res = fscrypt_get_encryption_info(parent);
-	if (res)
+	err = fscrypt_get_encryption_info(parent);
+	if (err)
 		return 0;
-	res = fscrypt_get_encryption_info(child);
-	if (res)
+	err = fscrypt_get_encryption_info(child);
+	if (err)
 		return 0;
-	parent_ci = READ_ONCE(parent->i_crypt_info);
-	child_ci = READ_ONCE(child->i_crypt_info);
-
-	if (parent_ci && child_ci) {
-		return memcmp(parent_ci->ci_master_key_descriptor,
-			      child_ci->ci_master_key_descriptor,
-			      FSCRYPT_KEY_DESCRIPTOR_SIZE) == 0 &&
-			(parent_ci->ci_data_mode == child_ci->ci_data_mode) &&
-			(parent_ci->ci_filename_mode ==
-			 child_ci->ci_filename_mode) &&
-			(parent_ci->ci_flags == child_ci->ci_flags);
-	}
 
-	res = cops->get_context(parent, &parent_ctx, sizeof(parent_ctx));
-	if (res != sizeof(parent_ctx))
+	err = fscrypt_get_policy(parent, &parent_policy);
+	if (err)
 		return 0;
 
-	res = cops->get_context(child, &child_ctx, sizeof(child_ctx));
-	if (res != sizeof(child_ctx))
+	err = fscrypt_get_policy(child, &child_policy);
+	if (err)
 		return 0;
 
-	return memcmp(parent_ctx.master_key_descriptor,
-		      child_ctx.master_key_descriptor,
-		      FSCRYPT_KEY_DESCRIPTOR_SIZE) == 0 &&
-		(parent_ctx.contents_encryption_mode ==
-		 child_ctx.contents_encryption_mode) &&
-		(parent_ctx.filenames_encryption_mode ==
-		 child_ctx.filenames_encryption_mode) &&
-		(parent_ctx.flags == child_ctx.flags);
+	return fscrypt_policies_equal(&parent_policy, &child_policy);
 }
 EXPORT_SYMBOL(fscrypt_has_permitted_context);
 
@@ -238,7 +419,8 @@ EXPORT_SYMBOL(fscrypt_has_permitted_context);
 int fscrypt_inherit_context(struct inode *parent, struct inode *child,
 						void *fs_data, bool preload)
 {
-	struct fscrypt_context ctx;
+	union fscrypt_context ctx;
+	int ctxsize;
 	struct fscrypt_info *ci;
 	int res;
 
@@ -250,16 +432,10 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
 	if (ci == NULL)
 		return -ENOKEY;
 
-	ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
-	ctx.contents_encryption_mode = ci->ci_data_mode;
-	ctx.filenames_encryption_mode = ci->ci_filename_mode;
-	ctx.flags = ci->ci_flags;
-	memcpy(ctx.master_key_descriptor, ci->ci_master_key_descriptor,
-	       FSCRYPT_KEY_DESCRIPTOR_SIZE);
-	get_random_bytes(ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
+	ctxsize = fscrypt_new_context_from_policy(&ctx, &ci->ci_policy);
+
 	BUILD_BUG_ON(sizeof(ctx) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
-	res = parent->i_sb->s_cop->set_context(child, &ctx,
-						sizeof(ctx), fs_data);
+	res = parent->i_sb->s_cop->set_context(child, &ctx, ctxsize, fs_data);
 	if (res)
 		return res;
 	return preload ? fscrypt_get_encryption_info(child): 0;
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 4441a74b967b4..1ee0945614d80 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -43,7 +43,7 @@ struct fscrypt_name {
 #define fname_len(p)		((p)->disk_name.len)
 
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
-#define FSCRYPT_SET_CONTEXT_MAX_SIZE	28
+#define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
 
 #ifdef CONFIG_FS_ENCRYPTION
 /*
@@ -123,6 +123,7 @@ extern void fscrypt_restore_control_page(struct page *);
 /* policy.c */
 extern int fscrypt_ioctl_set_policy(struct file *, const void __user *);
 extern int fscrypt_ioctl_get_policy(struct file *, void __user *);
+extern int fscrypt_ioctl_get_policy_ex(struct file *, void __user *);
 extern int fscrypt_has_permitted_context(struct inode *, struct inode *);
 extern int fscrypt_inherit_context(struct inode *, struct inode *,
 					void *, bool);
@@ -331,6 +332,12 @@ static inline int fscrypt_ioctl_get_policy(struct file *filp, void __user *arg)
 	return -EOPNOTSUPP;
 }
 
+static inline int fscrypt_ioctl_get_policy_ex(struct file *filp,
+					      void __user *arg)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int fscrypt_has_permitted_context(struct inode *parent,
 						struct inode *child)
 {
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index 042e70a4ff7ee..26879e669dfa0 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -8,7 +8,6 @@
  * File system encryption support
  */
 /* Policy provided via an ioctl on the topmost directory */
-#define FSCRYPT_KEY_DESCRIPTOR_SIZE	8
 
 /* Encryption policy flags */
 #define FSCRYPT_POLICY_FLAGS_PAD_4		0x00
@@ -16,7 +15,7 @@
 #define FSCRYPT_POLICY_FLAGS_PAD_16		0x02
 #define FSCRYPT_POLICY_FLAGS_PAD_32		0x03
 #define FSCRYPT_POLICY_FLAGS_PAD_MASK		0x03
-#define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04	/* use master key directly */
+#define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04
 #define FSCRYPT_POLICY_FLAGS_VALID		0x07
 
 /* Encryption algorithms */
@@ -25,14 +24,24 @@
 #define FSCRYPT_MODE_AES_128_CBC		5
 #define FSCRYPT_MODE_AES_128_CTS		6
 #define FSCRYPT_MODE_ADIANTUM			9
+#define __FSCRYPT_MODE_MAX			9
 
-struct fscrypt_policy {
+/*
+ * Legacy policy version; ad-hoc KDF and no key verification.
+ * For new encrypted directories, use fscrypt_policy_v2 instead.
+ *
+ * Careful: the .version field for this is actually 0, not 1.
+ */
+#define FSCRYPT_POLICY_V1		0
+#define FSCRYPT_KEY_DESCRIPTOR_SIZE	8
+struct fscrypt_policy_v1 {
 	__u8 version;
 	__u8 contents_encryption_mode;
 	__u8 filenames_encryption_mode;
 	__u8 flags;
 	__u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
 };
+#define fscrypt_policy	fscrypt_policy_v1
 
 /*
  * Process-subscribed "logon" key description prefix and payload format.
@@ -47,13 +56,39 @@ struct fscrypt_key {
 	__u32 size;
 };
 
+/*
+ * New policy version with HKDF and key verification (recommended).
+ */
+#define FSCRYPT_POLICY_V2		2
+#define FSCRYPT_KEY_IDENTIFIER_SIZE	16
+struct fscrypt_policy_v2 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 __reserved[4];
+	__u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+};
+
+/* Struct passed to FS_IOC_GET_ENCRYPTION_POLICY_EX */
+struct fscrypt_get_policy_ex_arg {
+	__u64 policy_size; /* input/output */
+	union {
+		__u8 version;
+		struct fscrypt_policy_v1 v1;
+		struct fscrypt_policy_v2 v2;
+	} policy; /* output */
+};
+
 struct fscrypt_key_specifier {
 #define FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR	1
+#define FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER	2
 	__u32 type;
 	__u32 __reserved;
 	union {
 		__u8 __reserved[32]; /* reserve some extra space */
 		__u8 descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+		__u8 identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
 	} u;
 };
 
@@ -88,6 +123,7 @@ struct fscrypt_get_key_status_arg {
 #define FS_IOC_SET_ENCRYPTION_POLICY	  _IOR('f', 19, struct fscrypt_policy)
 #define FS_IOC_GET_ENCRYPTION_PWSALT	  _IOW('f', 20, __u8[16])
 #define FS_IOC_GET_ENCRYPTION_POLICY	  _IOW('f', 21, struct fscrypt_policy)
+#define FS_IOC_GET_ENCRYPTION_POLICY_EX	 _IOWR('f', 22, __u8[9]) /* size + version */
 #define FS_IOC_ADD_ENCRYPTION_KEY	 _IOWR('f', 23, struct fscrypt_add_key_arg)
 #define FS_IOC_REMOVE_ENCRYPTION_KEY	  _IOW('f', 24, struct fscrypt_remove_key_arg)
 #define FS_IOC_GET_ENCRYPTION_KEY_STATUS _IOWR('f', 25, struct fscrypt_get_key_status_arg)
-- 
2.21.0.1020.gf2820cf01a-goog

