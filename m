Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B79143406
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 23:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgATWeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 17:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbgATWeU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:34:20 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F28224653;
        Mon, 20 Jan 2020 22:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579559658;
        bh=3GsTwrhKWubkVOsog2c7B6F+lDuYVeeynMA/s90tqzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iiQV6zQShw6vXY9eYKMzoDDlLg4Z5+7Zz+Apw4p8beyOOIuzj7ENWAsm3911e3aFm
         nLH6VTCqKwvLstz0uoPDZQKkLZu/gBGLR/QPxlsboE9RSnzrizXJR86xeiLNJeiTQn
         Hv72riL4fjRKz3rvJ6LX3kN7Onb0WHw/Uo7YG/98=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH v5 3/6] fscrypt: clarify what is meant by a per-file key
Date:   Mon, 20 Jan 2020 14:31:58 -0800
Message-Id: <20200120223201.241390-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120223201.241390-1-ebiggers@kernel.org>
References: <20200120223201.241390-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that there's sometimes a second type of per-file key (the dirhash
key), clarify some function names, macros, and documentation that
specifically deal with per-file *encryption* keys.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 24 ++++++++---------
 fs/crypto/fscrypt_private.h           |  6 ++---
 fs/crypto/keysetup.c                  | 39 ++++++++++++++-------------
 fs/crypto/keysetup_v1.c               |  4 +--
 4 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index c45f5bcc13e17..d5b1b49c3d002 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -234,8 +234,8 @@ HKDF is more flexible, is nonreversible, and evenly distributes
 entropy from the master key.  HKDF is also standardized and widely
 used by other software, whereas the AES-128-ECB based KDF is ad-hoc.
 
-Per-file keys
--------------
+Per-file encryption keys
+------------------------
 
 Since each master key can protect many files, it is necessary to
 "tweak" the encryption of each file so that the same plaintext in two
@@ -268,9 +268,9 @@ is greater than that of an AES-256-XTS key.
 Therefore, to improve performance and save memory, for Adiantum a
 "direct key" configuration is supported.  When the user has enabled
 this by setting FSCRYPT_POLICY_FLAG_DIRECT_KEY in the fscrypt policy,
-per-file keys are not used.  Instead, whenever any data (contents or
-filenames) is encrypted, the file's 16-byte nonce is included in the
-IV.  Moreover:
+per-file encryption keys are not used.  Instead, whenever any data
+(contents or filenames) is encrypted, the file's 16-byte nonce is
+included in the IV.  Moreover:
 
 - For v1 encryption policies, the encryption is done directly with the
   master key.  Because of this, users **must not** use the same master
@@ -335,11 +335,11 @@ used.
 Adiantum is a (primarily) stream cipher-based mode that is fast even
 on CPUs without dedicated crypto instructions.  It's also a true
 wide-block mode, unlike XTS.  It can also eliminate the need to derive
-per-file keys.  However, it depends on the security of two primitives,
-XChaCha12 and AES-256, rather than just one.  See the paper
-"Adiantum: length-preserving encryption for entry-level processors"
-(https://eprint.iacr.org/2018/720.pdf) for more details.  To use
-Adiantum, CONFIG_CRYPTO_ADIANTUM must be enabled.  Also, fast
+per-file encryption keys.  However, it depends on the security of two
+primitives, XChaCha12 and AES-256, rather than just one.  See the
+paper "Adiantum: length-preserving encryption for entry-level
+processors" (https://eprint.iacr.org/2018/720.pdf) for more details.
+To use Adiantum, CONFIG_CRYPTO_ADIANTUM must be enabled.  Also, fast
 implementations of ChaCha and NHPoly1305 should be enabled, e.g.
 CONFIG_CRYPTO_CHACHA20_NEON and CONFIG_CRYPTO_NHPOLY1305_NEON for ARM.
 
@@ -1149,8 +1149,8 @@ The context structs contain the same information as the corresponding
 policy structs (see `Setting an encryption policy`_), except that the
 context structs also contain a nonce.  The nonce is randomly generated
 by the kernel and is used as KDF input or as a tweak to cause
-different files to be encrypted differently; see `Per-file keys`_ and
-`DIRECT_KEY policies`_.
+different files to be encrypted differently; see `Per-file encryption
+keys`_ and `DIRECT_KEY policies`_.
 
 Data path changes
 -----------------
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index e79d5fd6236a8..f0b0bfae5fa2d 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -268,7 +268,7 @@ extern int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
  * output doesn't reveal another.
  */
 #define HKDF_CONTEXT_KEY_IDENTIFIER	1
-#define HKDF_CONTEXT_PER_FILE_KEY	2
+#define HKDF_CONTEXT_PER_FILE_ENC_KEY	2
 #define HKDF_CONTEXT_DIRECT_KEY		3
 #define HKDF_CONTEXT_IV_INO_LBLK_64_KEY	4
 #define HKDF_CONTEXT_DIRHASH_KEY	5
@@ -440,8 +440,8 @@ extern struct crypto_skcipher *
 fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
 			  const struct inode *inode);
 
-extern int fscrypt_set_derived_key(struct fscrypt_info *ci,
-				   const u8 *derived_key);
+extern int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci,
+					const u8 *raw_key);
 
 extern int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
 				      const struct fscrypt_master_key *mk);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 74d61d827d913..65cb09fa6ead9 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -107,12 +107,12 @@ struct crypto_skcipher *fscrypt_allocate_skcipher(struct fscrypt_mode *mode,
 	return ERR_PTR(err);
 }
 
-/* Given the per-file key, set up the file's crypto transform object */
-int fscrypt_set_derived_key(struct fscrypt_info *ci, const u8 *derived_key)
+/* Given a per-file encryption key, set up the file's crypto transform object */
+int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci, const u8 *raw_key)
 {
 	struct crypto_skcipher *tfm;
 
-	tfm = fscrypt_allocate_skcipher(ci->ci_mode, derived_key, ci->ci_inode);
+	tfm = fscrypt_allocate_skcipher(ci->ci_mode, raw_key, ci->ci_inode);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
@@ -121,10 +121,10 @@ int fscrypt_set_derived_key(struct fscrypt_info *ci, const u8 *derived_key)
 	return 0;
 }
 
-static int setup_per_mode_key(struct fscrypt_info *ci,
-			      struct fscrypt_master_key *mk,
-			      struct crypto_skcipher **tfms,
-			      u8 hkdf_context, bool include_fs_uuid)
+static int setup_per_mode_enc_key(struct fscrypt_info *ci,
+				  struct fscrypt_master_key *mk,
+				  struct crypto_skcipher **tfms,
+				  u8 hkdf_context, bool include_fs_uuid)
 {
 	const struct inode *inode = ci->ci_inode;
 	const struct super_block *sb = inode->i_sb;
@@ -196,15 +196,15 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 
 	if (ci->ci_policy.v2.flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) {
 		/*
-		 * DIRECT_KEY: instead of deriving per-file keys, the per-file
-		 * nonce will be included in all the IVs.  But unlike v1
-		 * policies, for v2 policies in this case we don't encrypt with
-		 * the master key directly but rather derive a per-mode key.
-		 * This ensures that the master key is consistently used only
-		 * for HKDF, avoiding key reuse issues.
+		 * DIRECT_KEY: instead of deriving per-file encryption keys, the
+		 * per-file nonce will be included in all the IVs.  But unlike
+		 * v1 policies, for v2 policies in this case we don't encrypt
+		 * with the master key directly but rather derive a per-mode
+		 * encryption key.  This ensures that the master key is
+		 * consistently used only for HKDF, avoiding key reuse issues.
 		 */
-		err = setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
-					 HKDF_CONTEXT_DIRECT_KEY, false);
+		err = setup_per_mode_enc_key(ci, mk, mk->mk_direct_tfms,
+					     HKDF_CONTEXT_DIRECT_KEY, false);
 	} else if (ci->ci_policy.v2.flags &
 		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
 		/*
@@ -213,20 +213,21 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * the IVs.  This format is optimized for use with inline
 		 * encryption hardware compliant with the UFS or eMMC standards.
 		 */
-		err = setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
-					 HKDF_CONTEXT_IV_INO_LBLK_64_KEY, true);
+		err = setup_per_mode_enc_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
+					     HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
+					     true);
 	} else {
 		u8 derived_key[FSCRYPT_MAX_KEY_SIZE];
 
 		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
-					  HKDF_CONTEXT_PER_FILE_KEY,
+					  HKDF_CONTEXT_PER_FILE_ENC_KEY,
 					  ci->ci_nonce,
 					  FS_KEY_DERIVATION_NONCE_SIZE,
 					  derived_key, ci->ci_mode->keysize);
 		if (err)
 			return err;
 
-		err = fscrypt_set_derived_key(ci, derived_key);
+		err = fscrypt_set_per_file_enc_key(ci, derived_key);
 		memzero_explicit(derived_key, ci->ci_mode->keysize);
 	}
 	if (err)
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 3578c1c607c51..801b48c0cd7f3 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -9,7 +9,7 @@
  * This file implements compatibility functions for the original encryption
  * policy version ("v1"), including:
  *
- * - Deriving per-file keys using the AES-128-ECB based KDF
+ * - Deriving per-file encryption keys using the AES-128-ECB based KDF
  *   (rather than the new method of using HKDF-SHA512)
  *
  * - Retrieving fscrypt master keys from process-subscribed keyrings
@@ -283,7 +283,7 @@ static int setup_v1_file_key_derived(struct fscrypt_info *ci,
 	if (err)
 		goto out;
 
-	err = fscrypt_set_derived_key(ci, derived_key);
+	err = fscrypt_set_per_file_enc_key(ci, derived_key);
 out:
 	kzfree(derived_key);
 	return err;
-- 
2.25.0

