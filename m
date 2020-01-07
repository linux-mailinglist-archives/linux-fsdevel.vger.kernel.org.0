Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9702131EE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 06:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgAGFQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 00:16:50 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:33429 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgAGFQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:16:50 -0500
Received: by mail-qv1-f73.google.com with SMTP id g6so2411326qvp.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 21:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=buIPXaVPzxxAl1sWdksfpf61XOrBhuY6VzHCsIRwcfQ=;
        b=rmHTyJel98cC8cgPRbCKLvfT/Z/bvN6a+oFPcvaJ/Yp7e+6XN+1dPxVaGP3lju/3e7
         K4TOdOyU3/2OrFHeYk5Pg/77CIUGIl/W4//eQqcsSsjrz/bHATBKiqp09SNHWVJHhSrK
         77F1vFhqwnHXDpgoslamZ7m3kFHnbkwkNwmv4nPbCRwYr9sskbYzZt8PYvRG2qJRoABm
         cotK1qHhPwfbGiSm4aYwzUO4kx6Jp2CjUrw5lfWYFD0+wu7SzTqbL87QhAYJ7qhacqCh
         Nqmk7ywxkPsTH/DfwemmS0SblkP7/4NDtjouXeA9zGErJMemGIH5NUwQXC1HxKvaOZkn
         pOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=buIPXaVPzxxAl1sWdksfpf61XOrBhuY6VzHCsIRwcfQ=;
        b=X9SWwc0M+TUFLo5i3NrbPpA+iu6pOv9ppDlFsH9PBemfzSuy+rb2fAm1YaDtRAZnen
         6e584VAcMAHNnqiVmco1VrOV/cslXsTZJfwfVIN2MRQcLaNehedmXKPavfJEeZK34eEV
         V6mqq7/bQdGDdiY/amy3A14xfAtDhpu5m552XFfxm4Xh0CQKNULeWufx3hMiqOUPKq54
         KIg3BqIer+2fOhSoQagAfvVffEvpIv0/7qyZ/s2medWFC7/wT0ZduNiNQpaOpfnWztWq
         phTYXjihd19oPGwJ8PDkQhd/c3GhzFE+Ir0vdBCzrw33nrVEJls925nFkK8R64wZnxih
         fxvQ==
X-Gm-Message-State: APjAAAV3LXs0HhA+usarnQQog12M7Nn4fq/Wrz0sgYdyyQJf0tlL/Xr1
        h1EwAZNaAIohxbeOO2z2uA3tSsTrkis=
X-Google-Smtp-Source: APXvYqwNfjyBHyOhTUSKFud1rgxcsayp63IvwAGn++ftC7miwUnxLl5S4rXQO4n36IepFbjJ6z+SeIg9FHw=
X-Received: by 2002:a0c:f8ce:: with SMTP id h14mr81661822qvo.91.1578374208474;
 Mon, 06 Jan 2020 21:16:48 -0800 (PST)
Date:   Mon,  6 Jan 2020 21:16:33 -0800
In-Reply-To: <20200107051638.40893-1-drosen@google.com>
Message-Id: <20200107051638.40893-2-drosen@google.com>
Mime-Version: 1.0
References: <20200107051638.40893-1-drosen@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 1/6] TMP: fscrypt: Add support for casefolding with encryption
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a placeholder patch for the patches that were based
on the fscypt dev patch. The only affect for the other
patches is that they're missing a const or two that top of
tree fscrypt would allow.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
This patch is just a placeholder so the rest don't need to be applied
to fscrypt's dev branch.
 fs/crypto/Kconfig           |   1 +
 fs/crypto/fname.c           | 234 ++++++++++++++++++++++++++++--------
 fs/crypto/fscrypt_private.h |   9 ++
 fs/crypto/keysetup.c        |  32 +++--
 fs/crypto/policy.c          |  45 ++++++-
 fs/inode.c                  |   7 ++
 include/linux/fscrypt.h     |  96 ++++-----------
 7 files changed, 289 insertions(+), 135 deletions(-)

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index ff5a1746cbae4..6e0d56f0b993e 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -9,6 +9,7 @@ config FS_ENCRYPTION
 	select CRYPTO_CTS
 	select CRYPTO_SHA512
 	select CRYPTO_HMAC
+	select CRYPTO_SHA256
 	select KEYS
 	help
 	  Enable encryption of files and directories.  This
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 3da3707c10e33..bf5605143138d 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -12,9 +12,69 @@
  */
 
 #include <linux/scatterlist.h>
+#include <linux/siphash.h>
 #include <crypto/skcipher.h>
+#include <crypto/hash.h>
 #include "fscrypt_private.h"
 
+/**
+ * fscrypt_nokey_name - identifier for on-disk filenames when key is not present
+ *
+ * When userspace lists an encrypted directory without access to the key, we
+ * must present them with a unique identifier for the file. base64 encoding will
+ * expand the space, so we use this format to avoid most collisions.
+ *
+ * Filesystems may rely on the hash being present to look up a file on disk.
+ * For filenames that are both casefolded and encrypted, it is not possible to
+ * calculate the hash without the key. Additionally, if the ciphertext is longer
+ * than what we can base64 encode, we cannot generate the hash from the partial
+ * name. For simplicity, we always store the hash at the front of the name,
+ * followed by the first 149 bytes of the ciphertext, and then the sha256 of the
+ * remainder of the name if the ciphertext was longer than 149 bytes. For the
+ * usual case of relatively short filenames, this allows us to avoid needing to
+ * compute the sha256. This results in an encoded name that is at most 252 bytes
+ * long.
+ */
+
+#define FSCRYPT_FNAME_UNDIGESTED_SIZE 149
+struct fscrypt_nokey_name {
+	u32 dirtree_hash[2];
+	u8 bytes[FSCRYPT_FNAME_UNDIGESTED_SIZE];
+	u8 sha256[SHA256_DIGEST_SIZE];
+};
+
+static struct crypto_shash *sha256_hash_tfm;
+
+static int fscrypt_do_sha256(unsigned char *result,
+	     const u8 *data, unsigned int data_len)
+{
+	struct crypto_shash *tfm = READ_ONCE(sha256_hash_tfm);
+
+	if (unlikely(!tfm)) {
+		struct crypto_shash *prev_tfm;
+
+		tfm = crypto_alloc_shash("sha256", 0, 0);
+		if (IS_ERR(tfm)) {
+			fscrypt_err(NULL,
+				    "Error allocating SHA-256 transform: %ld",
+				    PTR_ERR(tfm));
+			return PTR_ERR(tfm);
+		}
+		prev_tfm = cmpxchg(&sha256_hash_tfm, NULL, tfm);
+		if (prev_tfm) {
+			crypto_free_shash(tfm);
+			tfm = prev_tfm;
+		}
+	}
+	{
+		SHASH_DESC_ON_STACK(desc, tfm);
+
+		desc->tfm = tfm;
+
+		return crypto_shash_digest(desc, data, data_len, result);
+	}
+}
+
 static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
 {
 	if (str->len == 1 && str->name[0] == '.')
@@ -207,8 +267,7 @@ int fscrypt_fname_alloc_buffer(const struct inode *inode,
 			       struct fscrypt_str *crypto_str)
 {
 	const u32 max_encoded_len =
-		max_t(u32, BASE64_CHARS(FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE),
-		      1 + BASE64_CHARS(sizeof(struct fscrypt_digested_name)));
+		      BASE64_CHARS(sizeof(struct fscrypt_nokey_name));
 	u32 max_presented_len;
 
 	max_presented_len = max(max_encoded_len, max_encrypted_len);
@@ -241,9 +300,9 @@ EXPORT_SYMBOL(fscrypt_fname_free_buffer);
  *
  * The caller must have allocated sufficient memory for the @oname string.
  *
- * If the key is available, we'll decrypt the disk name; otherwise, we'll encode
- * it for presentation.  Short names are directly base64-encoded, while long
- * names are encoded in fscrypt_digested_name format.
+ * If the key is available, we'll decrypt the disk name;
+ * otherwise, we'll encode it for presentation in fscrypt_nokey_name format.
+ * See struct fscrypt_nokey_name for details.
  *
  * Return: 0 on success, -errno on failure
  */
@@ -253,7 +312,9 @@ int fscrypt_fname_disk_to_usr(struct inode *inode,
 			struct fscrypt_str *oname)
 {
 	const struct qstr qname = FSTR_TO_QSTR(iname);
-	struct fscrypt_digested_name digested_name;
+	struct fscrypt_nokey_name nokey_name;
+	u32 size;
+	int err = 0;
 
 	if (fscrypt_is_dot_dotdot(&qname)) {
 		oname->name[0] = '.';
@@ -268,25 +329,29 @@ int fscrypt_fname_disk_to_usr(struct inode *inode,
 	if (fscrypt_has_encryption_key(inode))
 		return fname_decrypt(inode, iname, oname);
 
-	if (iname->len <= FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE) {
-		oname->len = base64_encode(iname->name, iname->len,
-					   oname->name);
-		return 0;
-	}
+	size = min_t(u32, iname->len, FSCRYPT_FNAME_UNDIGESTED_SIZE);
+		memcpy(nokey_name.bytes, iname->name, size);
+
 	if (hash) {
-		digested_name.hash = hash;
-		digested_name.minor_hash = minor_hash;
+		nokey_name.dirtree_hash[0] = hash;
+		nokey_name.dirtree_hash[1] = minor_hash;
 	} else {
-		digested_name.hash = 0;
-		digested_name.minor_hash = 0;
+		nokey_name.dirtree_hash[0] = 0;
+		nokey_name.dirtree_hash[1] = 0;
 	}
-	memcpy(digested_name.digest,
-	       FSCRYPT_FNAME_DIGEST(iname->name, iname->len),
-	       FSCRYPT_FNAME_DIGEST_SIZE);
-	oname->name[0] = '_';
-	oname->len = 1 + base64_encode((const u8 *)&digested_name,
-				       sizeof(digested_name), oname->name + 1);
-	return 0;
+	size += sizeof(nokey_name.dirtree_hash);
+
+	if (iname->len > FSCRYPT_FNAME_UNDIGESTED_SIZE) {
+		/* compute sha256 of remaining name */
+		err = fscrypt_do_sha256(nokey_name.sha256,
+				&iname->name[FSCRYPT_FNAME_UNDIGESTED_SIZE],
+				iname->len - FSCRYPT_FNAME_UNDIGESTED_SIZE);
+		if (err)
+			return err;
+		size += sizeof(nokey_name.sha256);
+	}
+	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
+	return err;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
 
@@ -306,8 +371,7 @@ EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
  * get the disk_name.
  *
  * Else, for keyless @lookup operations, @iname is the presented ciphertext, so
- * we decode it to get either the ciphertext disk_name (for short names) or the
- * fscrypt_digested_name (for long names).  Non-@lookup operations will be
+ * we decode it to get the fscrypt_nokey_name. Non-@lookup operations will be
  * impossible in this case, so we fail them with ENOKEY.
  *
  * If successful, fscrypt_free_filename() must be called later to clean up.
@@ -317,8 +381,8 @@ EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
 int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 			      int lookup, struct fscrypt_name *fname)
 {
+	struct fscrypt_nokey_name *nokey_name;
 	int ret;
-	int digested;
 
 	memset(fname, 0, sizeof(struct fscrypt_name));
 	fname->usr_fname = iname;
@@ -358,41 +422,35 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	 * We don't have the key and we are doing a lookup; decode the
 	 * user-supplied name
 	 */
-	if (iname->name[0] == '_') {
-		if (iname->len !=
-		    1 + BASE64_CHARS(sizeof(struct fscrypt_digested_name)))
-			return -ENOENT;
-		digested = 1;
-	} else {
-		if (iname->len >
-		    BASE64_CHARS(FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE))
-			return -ENOENT;
-		digested = 0;
-	}
 
 	fname->crypto_buf.name =
-		kmalloc(max_t(size_t, FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE,
-			      sizeof(struct fscrypt_digested_name)),
-			GFP_KERNEL);
+			kmalloc(sizeof(struct fscrypt_nokey_name), GFP_KERNEL);
 	if (fname->crypto_buf.name == NULL)
 		return -ENOMEM;
 
-	ret = base64_decode(iname->name + digested, iname->len - digested,
+	if (iname->len > BASE64_CHARS(
+			(int)offsetofend(struct fscrypt_nokey_name, sha256))) {
+		ret = -ENOENT;
+		goto errout;
+	}
+	if (iname->len <
+		BASE64_CHARS((int)offsetofend(struct fscrypt_nokey_name,
+					      dirtree_hash))) {
+		ret = -ENOENT;
+		goto errout;
+	}
+	ret = base64_decode(iname->name, iname->len,
 			    fname->crypto_buf.name);
 	if (ret < 0) {
 		ret = -ENOENT;
 		goto errout;
 	}
+
+	nokey_name = (void *)fname->crypto_buf.name;
 	fname->crypto_buf.len = ret;
-	if (digested) {
-		const struct fscrypt_digested_name *n =
-			(const void *)fname->crypto_buf.name;
-		fname->hash = n->hash;
-		fname->minor_hash = n->minor_hash;
-	} else {
-		fname->disk_name.name = fname->crypto_buf.name;
-		fname->disk_name.len = fname->crypto_buf.len;
-	}
+
+	fname->hash = nokey_name->dirtree_hash[0];
+	fname->minor_hash = nokey_name->dirtree_hash[1];
 	return 0;
 
 errout:
@@ -400,3 +458,81 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	return ret;
 }
 EXPORT_SYMBOL(fscrypt_setup_filename);
+
+/**
+ * fscrypt_match_name() - test whether the given name matches a directory entry
+ * @fname: the name being searched for
+ * @de_name: the name from the directory entry
+ * @de_name_len: the length of @de_name in bytes
+ *
+ * Normally @fname->disk_name will be set, and in that case we simply compare
+ * that to the name stored in the directory entry.  The only exception is that
+ * if we don't have the key for an encrypted directory we'll instead need to
+ * match against the fscrypt_nokey_name.
+ *
+ * Return: %true if the name matches, otherwise %false.
+ */
+bool fscrypt_match_name(const struct fscrypt_name *fname,
+				      const u8 *de_name, u32 de_name_len)
+{
+	BUILD_BUG_ON(BASE64_CHARS(offsetofend(struct fscrypt_nokey_name,
+					      sha256)) > NAME_MAX);
+	if (unlikely(!fname->disk_name.name)) {
+		const struct fscrypt_nokey_name *n =
+			(const void *)fname->crypto_buf.name;
+
+		if (fname->crypto_buf.len ==
+			    offsetofend(struct fscrypt_nokey_name, sha256)) {
+			u8 sha256[SHA256_DIGEST_SIZE];
+
+			if (de_name_len <= FSCRYPT_FNAME_UNDIGESTED_SIZE)
+				return false;
+			if (memcmp(de_name, n->bytes,
+				   FSCRYPT_FNAME_UNDIGESTED_SIZE) != 0)
+				return false;
+			fscrypt_do_sha256(sha256,
+				&de_name[FSCRYPT_FNAME_UNDIGESTED_SIZE],
+				de_name_len - FSCRYPT_FNAME_UNDIGESTED_SIZE);
+			if (memcmp(sha256, n->sha256, sizeof(sha256)) != 0)
+				return false;
+		} else {
+			u32 len = fname->crypto_buf.len -
+				offsetof(struct fscrypt_nokey_name, bytes);
+
+			if (de_name_len != len)
+				return false;
+
+			if (memcmp(de_name, n->bytes, len) != 0)
+				return false;
+		}
+
+		return true;
+	}
+
+	if (de_name_len != fname->disk_name.len)
+		return false;
+	return !memcmp(de_name, fname->disk_name.name, fname->disk_name.len);
+}
+EXPORT_SYMBOL(fscrypt_match_name);
+
+/**
+ * fscrypt_fname_siphash() - Calculate the siphash for a file name
+ * @dir: the parent directory
+ * @name: the name of the file to get the siphash of
+ *
+ * Given a user-provided filename @name, this function calculates the siphash of
+ * that name using the hash key stored with the directory's policy.
+ *
+ * This assumes the directory uses a v2 policy, and the key is available.
+ *
+ * Return: the siphash of @name using the hash key of @dir
+ */
+u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name)
+{
+	struct fscrypt_info *ci = dir->i_crypt_info;
+
+	WARN_ON(!ci->ci_hash_key_initialized);
+
+	return siphash(name->name, name->len, &ci->ci_hash_key);
+}
+EXPORT_SYMBOL(fscrypt_fname_siphash);
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 130b50e5a0115..f0dfef9921ded 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -12,6 +12,7 @@
 #define _FSCRYPT_PRIVATE_H
 
 #include <linux/fscrypt.h>
+#include <linux/siphash.h>
 #include <crypto/hash.h>
 
 #define CONST_STRLEN(str)	(sizeof(str) - 1)
@@ -194,6 +195,13 @@ struct fscrypt_info {
 	 */
 	struct fscrypt_direct_key *ci_direct_key;
 
+	/*
+	 * With v2 policies, this can be used with siphash
+	 * When the key has been set, ci_hash_key_initialized is set to true
+	 */
+	siphash_key_t ci_hash_key;
+	bool ci_hash_key_initialized;
+
 	/* The encryption policy used by this inode */
 	union fscrypt_policy ci_policy;
 
@@ -286,6 +294,7 @@ extern int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 #define HKDF_CONTEXT_PER_FILE_KEY	2
 #define HKDF_CONTEXT_DIRECT_KEY		3
 #define HKDF_CONTEXT_IV_INO_LBLK_64_KEY	4
+#define HKDF_CONTEXT_FNAME_HASH_KEY     5
 
 extern int fscrypt_hkdf_expand(struct fscrypt_hkdf *hkdf, u8 context,
 			       const u8 *info, unsigned int infolen,
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index f577bb6613f93..8b23540ede4f8 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -192,7 +192,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 				     ci->ci_mode->friendly_name);
 			return -EINVAL;
 		}
-		return setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
+		err = setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
 					  HKDF_CONTEXT_DIRECT_KEY, false);
 	} else if (ci->ci_policy.v2.flags &
 		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
@@ -202,20 +202,34 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * the IVs.  This format is optimized for use with inline
 		 * encryption hardware compliant with the UFS or eMMC standards.
 		 */
-		return setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
+		err = setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
 					  HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
 					  true);
+	} else {
+		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+					  HKDF_CONTEXT_PER_FILE_KEY,
+					  ci->ci_nonce,
+					  FS_KEY_DERIVATION_NONCE_SIZE,
+					  derived_key, ci->ci_mode->keysize);
+		if (err)
+			return err;
+
+		err = fscrypt_set_derived_key(ci, derived_key);
+		memzero_explicit(derived_key, ci->ci_mode->keysize);
 	}
-
-	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
-				  HKDF_CONTEXT_PER_FILE_KEY,
-				  ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE,
-				  derived_key, ci->ci_mode->keysize);
 	if (err)
 		return err;
 
-	err = fscrypt_set_derived_key(ci, derived_key);
-	memzero_explicit(derived_key, ci->ci_mode->keysize);
+	if (S_ISDIR(ci->ci_inode->i_mode)) {
+		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+					  HKDF_CONTEXT_FNAME_HASH_KEY,
+					  ci->ci_nonce,
+					  FS_KEY_DERIVATION_NONCE_SIZE,
+					  (u8 *)&ci->ci_hash_key,
+					  sizeof(ci->ci_hash_key));
+		if (!err)
+			ci->ci_hash_key_initialized = true;
+	}
 	return err;
 }
 
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 96f528071bed3..0c67a154dae83 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -67,9 +67,9 @@ static bool supported_iv_ino_lblk_64_policy(
  * fscrypt_supported_policy - check whether an encryption policy is supported
  *
  * Given an encryption policy, check whether all its encryption modes and other
- * settings are supported by this kernel.  (But we don't currently don't check
- * for crypto API support here, so attempting to use an algorithm not configured
- * into the crypto API will still fail later.)
+ * settings are supported by this kernel on the given inode.  (But we don't
+ * currently don't check for crypto API support here, so attempting to use an
+ * algorithm not configured into the crypto API will still fail later.)
  *
  * Return: %true if supported, else %false
  */
@@ -97,6 +97,12 @@ bool fscrypt_supported_policy(const union fscrypt_policy *policy_u,
 			return false;
 		}
 
+		if (IS_CASEFOLDED(inode)) {
+			fscrypt_warn(inode,
+				     "v1 policy does not support casefolded directories");
+			return false;
+		}
+
 		return true;
 	}
 	case FSCRYPT_POLICY_V2: {
@@ -530,3 +536,36 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
 	return preload ? fscrypt_get_encryption_info(child): 0;
 }
 EXPORT_SYMBOL(fscrypt_inherit_context);
+
+static int fscrypt_set_casefolding_allowed(struct inode *inode)
+{
+	union fscrypt_policy policy;
+	int err = fscrypt_get_policy(inode, &policy);
+
+	if (err)
+		return err;
+
+	if (policy.version != FSCRYPT_POLICY_V2)
+		return -EINVAL;
+
+	return 0;
+}
+
+int fscrypt_ioc_setflags_prepare(struct inode *inode,
+				 unsigned int oldflags,
+				 unsigned int flags)
+{
+	int err;
+
+	/*
+	 * When a directory is encrypted, the CASEFOLD flag can only be turned
+	 * on if the fscrypt policy supports it.
+	 */
+	if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL)) {
+		err = fscrypt_set_casefolding_allowed(inode);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/fs/inode.c b/fs/inode.c
index 96d62d97694ef..77f3e6e2e9342 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -20,6 +20,7 @@
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
+#include <linux/fscrypt.h>
 #include <trace/events/writeback.h>
 #include "internal.h"
 
@@ -2242,6 +2243,8 @@ EXPORT_SYMBOL(current_time);
 int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 			     unsigned int flags)
 {
+	int err;
+
 	/*
 	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
 	 * the relevant capability.
@@ -2252,6 +2255,10 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 	    !capable(CAP_LINUX_IMMUTABLE))
 		return -EPERM;
 
+	err = fscrypt_ioc_setflags_prepare(inode, oldflags, flags);
+	if (err)
+		return err;
+
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 1a7bffe78ed56..be2922ad005c9 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <crypto/sha.h>
 #include <uapi/linux/fscrypt.h>
 
 #define FS_CRYPTO_BLOCK_SIZE		16
@@ -127,6 +128,10 @@ extern int fscrypt_ioctl_get_policy_ex(struct file *, void __user *);
 extern int fscrypt_has_permitted_context(struct inode *, struct inode *);
 extern int fscrypt_inherit_context(struct inode *, struct inode *,
 					void *, bool);
+extern int fscrypt_ioc_setflags_prepare(struct inode *inode,
+					unsigned int oldflags,
+					unsigned int flags);
+
 /* keyring.c */
 extern void fscrypt_sb_free(struct super_block *sb);
 extern int fscrypt_ioctl_add_key(struct file *filp, void __user *arg);
@@ -155,80 +160,11 @@ extern int fscrypt_fname_alloc_buffer(const struct inode *, u32,
 extern void fscrypt_fname_free_buffer(struct fscrypt_str *);
 extern int fscrypt_fname_disk_to_usr(struct inode *, u32, u32,
 			const struct fscrypt_str *, struct fscrypt_str *);
+extern u64 fscrypt_fname_siphash(const struct inode *dir,
+				 const struct qstr *name);
 
-#define FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE	32
-
-/* Extracts the second-to-last ciphertext block; see explanation below */
-#define FSCRYPT_FNAME_DIGEST(name, len)	\
-	((name) + round_down((len) - FS_CRYPTO_BLOCK_SIZE - 1, \
-			     FS_CRYPTO_BLOCK_SIZE))
-
-#define FSCRYPT_FNAME_DIGEST_SIZE	FS_CRYPTO_BLOCK_SIZE
-
-/**
- * fscrypt_digested_name - alternate identifier for an on-disk filename
- *
- * When userspace lists an encrypted directory without access to the key,
- * filenames whose ciphertext is longer than FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE
- * bytes are shown in this abbreviated form (base64-encoded) rather than as the
- * full ciphertext (base64-encoded).  This is necessary to allow supporting
- * filenames up to NAME_MAX bytes, since base64 encoding expands the length.
- *
- * To make it possible for filesystems to still find the correct directory entry
- * despite not knowing the full on-disk name, we encode any filesystem-specific
- * 'hash' and/or 'minor_hash' which the filesystem may need for its lookups,
- * followed by the second-to-last ciphertext block of the filename.  Due to the
- * use of the CBC-CTS encryption mode, the second-to-last ciphertext block
- * depends on the full plaintext.  (Note that ciphertext stealing causes the
- * last two blocks to appear "flipped".)  This makes accidental collisions very
- * unlikely: just a 1 in 2^128 chance for two filenames to collide even if they
- * share the same filesystem-specific hashes.
- *
- * However, this scheme isn't immune to intentional collisions, which can be
- * created by anyone able to create arbitrary plaintext filenames and view them
- * without the key.  Making the "digest" be a real cryptographic hash like
- * SHA-256 over the full ciphertext would prevent this, although it would be
- * less efficient and harder to implement, especially since the filesystem would
- * need to calculate it for each directory entry examined during a search.
- */
-struct fscrypt_digested_name {
-	u32 hash;
-	u32 minor_hash;
-	u8 digest[FSCRYPT_FNAME_DIGEST_SIZE];
-};
-
-/**
- * fscrypt_match_name() - test whether the given name matches a directory entry
- * @fname: the name being searched for
- * @de_name: the name from the directory entry
- * @de_name_len: the length of @de_name in bytes
- *
- * Normally @fname->disk_name will be set, and in that case we simply compare
- * that to the name stored in the directory entry.  The only exception is that
- * if we don't have the key for an encrypted directory and a filename in it is
- * very long, then we won't have the full disk_name and we'll instead need to
- * match against the fscrypt_digested_name.
- *
- * Return: %true if the name matches, otherwise %false.
- */
-static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
-				      const u8 *de_name, u32 de_name_len)
-{
-	if (unlikely(!fname->disk_name.name)) {
-		const struct fscrypt_digested_name *n =
-			(const void *)fname->crypto_buf.name;
-		if (WARN_ON_ONCE(fname->usr_fname->name[0] != '_'))
-			return false;
-		if (de_name_len <= FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE)
-			return false;
-		return !memcmp(FSCRYPT_FNAME_DIGEST(de_name, de_name_len),
-			       n->digest, FSCRYPT_FNAME_DIGEST_SIZE);
-	}
-
-	if (de_name_len != fname->disk_name.len)
-		return false;
-	return !memcmp(de_name, fname->disk_name.name, fname->disk_name.len);
-}
+extern bool fscrypt_match_name(const struct fscrypt_name *fname,
+				      const u8 *de_name, u32 de_name_len);
 
 /* bio.c */
 extern void fscrypt_decrypt_bio(struct bio *);
@@ -359,6 +295,12 @@ static inline int fscrypt_inherit_context(struct inode *parent,
 	return -EOPNOTSUPP;
 }
 
+static inline int fscrypt_ioc_setflags_prepare(struct inode *inode,
+					unsigned int oldflags,
+					unsigned int flags) {
+	return 0;
+}
+
 /* keyring.c */
 static inline void fscrypt_sb_free(struct super_block *sb)
 {
@@ -439,13 +381,19 @@ static inline void fscrypt_fname_free_buffer(struct fscrypt_str *crypto_str)
 }
 
 static inline int fscrypt_fname_disk_to_usr(struct inode *inode,
-					    u32 hash, u32 minor_hash,
+					    u32 dirtree_hash, u32 minor_hash,
 					    const struct fscrypt_str *iname,
 					    struct fscrypt_str *oname)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline u64 fscrypt_fname_siphash(const struct inode *dir,
+					const struct qstr *name)
+{
+	return 0;
+}
+
 static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
 				      const u8 *de_name, u32 de_name_len)
 {
-- 
2.24.1.735.g03f4e72817-goog

