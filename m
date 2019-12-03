Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB410F6CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfLCFMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:12:00 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33407 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfLCFL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:11:26 -0500
Received: by mail-pf1-f202.google.com with SMTP id t13so1464087pfh.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 21:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fjDzYP4akxITglcH3eYkmUeETy7YJmWTmEYTLRKX/0M=;
        b=hbPWGUEtK2jN8yaTm9Zv+Q/61kQAWMlhNlq+s6pZOiY+aFGPsX1qPRakzazbIbIsvF
         N/P7H7X7ZllbDi/doW4qa/0i6iICr7x8vzkZgvbJ8vMGfLDGek2/+uxlmyNrsQwDqZAA
         igtYjR2XLx0uk3QUms4Fpzr9e4mz5AA9LDbpMETCTg1g9eY0MqIUWO2Bqh9HUXM4fnqz
         hj+Cdj5X+Y25MqFEqWP8FaX9TmhL5DiUTp77pcLil21Fumc8/X4otJkPZ241kPtzxUad
         LXEkMTZ+oMtXBpp1lOVs3P4tkvgn/UuW0lFyAsk6aIVqdYPFnO9eLBPjc7OzeJmfNH7z
         yFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fjDzYP4akxITglcH3eYkmUeETy7YJmWTmEYTLRKX/0M=;
        b=cEgz2E9kEaAhWzenQOzojAEu8AgwOI/Sg7kNdcfpYlDAaPnHs/uK5zIg+YG2in5h11
         L3e2+6viHQZ02S9rYLrelSgwQG7Qg23FxDIDwLIE3a87D9qW3kCPAJII3fhBQUkjhPZi
         v8jF8H6V5sgWOlAlIKG9T/a6ZFXJaKsYBu2SleW2GQUvthVYJSMoAy9SzZWDhRDo44f9
         1Yv1QRdQTNqdkGpiNEo8maZTOWvYM3OpAhc+tRIp8uSiv0Mmr3T+KGZ49kyGcD6Axkz8
         kNetIupHDLCKGFs3os7NepMxDDCiNMZ583D/G7Lm+eA0Tx4CVFypf0skurhaP+8I7zlj
         fYAA==
X-Gm-Message-State: APjAAAWsPyAYq8cF/IO8QGI2LSR2E9hEFApt9yOLSkOV3IC9kVsERkqE
        9J6QA7iHCz0vH4g09YhCGHI6Cz6jTn0=
X-Google-Smtp-Source: APXvYqwN6Ss7aRyiPUKI0kGpB0NmUeDfnOPXypeRPMIQb/7yTu5lxeNLysIa1CsoGdNc1/LgcJZ1XDTsCiA=
X-Received: by 2002:a65:5281:: with SMTP id y1mr1916819pgp.327.1575349885592;
 Mon, 02 Dec 2019 21:11:25 -0800 (PST)
Date:   Mon,  2 Dec 2019 21:10:44 -0800
In-Reply-To: <20191203051049.44573-1-drosen@google.com>
Message-Id: <20191203051049.44573-4-drosen@google.com>
Mime-Version: 1.0
References: <20191203051049.44573-1-drosen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 3/8] fscrypt: Change format of no-key token
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

Encrypted and casefolded names always require a dirtree hash, since
their hash values cannot be generated without the key.

In the new format, we always base64 encode the same structure. For names
that are less than 149 characters, we concatenate the provided hash and
ciphertext. If the name is longer than 149 characters, we also include
the sha256 of the remaining parts of the name. We then base64 encode the
resulting data to get a representation of the name that is at most 252
characters long, with a very low collision rate. We avoid needing to
compute the sha256 apart from in the case of a very long filename, and
then only need to compute the sha256 of possible matches if their
ciphertext is also longer than 149.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/crypto/Kconfig       |   1 +
 fs/crypto/fname.c       | 182 +++++++++++++++++++++++++++++-----------
 include/linux/fscrypt.h |  92 ++++++--------------
 3 files changed, 160 insertions(+), 115 deletions(-)

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index ff5a1746cbae..6e0d56f0b993 100644
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
index b33f03b9f892..03c837c461f2 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -14,8 +14,46 @@
 #include <linux/scatterlist.h>
 #include <linux/siphash.h>
 #include <crypto/skcipher.h>
+#include <crypto/hash.h>
 #include "fscrypt_private.h"
 
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
+			if (PTR_ERR(tfm) == -ENOENT) {
+				fscrypt_warn(NULL,
+					     "Missing crypto API support for SHA-256");
+				return -ENOPKG;
+			}
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
@@ -208,8 +246,7 @@ int fscrypt_fname_alloc_buffer(const struct inode *inode,
 			       struct fscrypt_str *crypto_str)
 {
 	const u32 max_encoded_len =
-		max_t(u32, BASE64_CHARS(FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE),
-		      1 + BASE64_CHARS(sizeof(struct fscrypt_digested_name)));
+		      BASE64_CHARS(sizeof(struct fscrypt_nokey_name));
 	u32 max_presented_len;
 
 	max_presented_len = max(max_encoded_len, max_encrypted_len);
@@ -243,8 +280,9 @@ EXPORT_SYMBOL(fscrypt_fname_free_buffer);
  * The caller must have allocated sufficient memory for the @oname string.
  *
  * If the key is available, we'll decrypt the disk name; otherwise, we'll encode
- * it for presentation.  Short names are directly base64-encoded, while long
- * names are encoded in fscrypt_digested_name format.
+ * it for presentation.  The usr name is the base64 encoding of the dirtree hash
+ * value, the first 149 characters of the name, and the sha256 of the rest of
+ * the name, if longer than 149 characters.
  *
  * Return: 0 on success, -errno on failure
  */
@@ -254,7 +292,9 @@ int fscrypt_fname_disk_to_usr(struct inode *inode,
 			struct fscrypt_str *oname)
 {
 	const struct qstr qname = FSTR_TO_QSTR(iname);
-	struct fscrypt_digested_name digested_name;
+	struct fscrypt_nokey_name nokey_name;
+	u32 size;
+	int err = 0;
 
 	if (fscrypt_is_dot_dotdot(&qname)) {
 		oname->name[0] = '.';
@@ -269,25 +309,29 @@ int fscrypt_fname_disk_to_usr(struct inode *inode,
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
 
@@ -319,7 +363,6 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 			      int lookup, struct fscrypt_name *fname)
 {
 	int ret;
-	int digested;
 
 	memset(fname, 0, sizeof(struct fscrypt_name));
 	fname->usr_fname = iname;
@@ -359,42 +402,32 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
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
+	ret = base64_decode(iname->name, iname->len,
 			    fname->crypto_buf.name);
 	if (ret < 0) {
 		ret = -ENOENT;
 		goto errout;
 	}
-	fname->crypto_buf.len = ret;
-	if (digested) {
-		const struct fscrypt_digested_name *n =
-			(const void *)fname->crypto_buf.name;
-		fname->hash = n->hash;
-		fname->minor_hash = n->minor_hash;
-	} else {
-		fname->disk_name.name = fname->crypto_buf.name;
-		fname->disk_name.len = fname->crypto_buf.len;
+	if (ret > (int)offsetofend(struct fscrypt_nokey_name, sha256)) {
+		ret = -EINVAL;
+		goto errout;
+	}
+
+	{
+		struct fscrypt_nokey_name *n =
+				(void *)fname->crypto_buf.name;
+		fname->crypto_buf.len = ret;
+
+		fname->hash = n->dirtree_hash[0];
+		fname->minor_hash = n->dirtree_hash[1];
+		return 0;
 	}
-	return 0;
 
 errout:
 	kfree(fname->crypto_buf.name);
@@ -402,6 +435,61 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 }
 EXPORT_SYMBOL(fscrypt_setup_filename);
 
+/**
+ * fscrypt_match_name() - test whether the given name matches a directory entry
+ * @fname: the name being searched for
+ * @de_name: the name from the directory entry
+ * @de_name_len: the length of @de_name in bytes
+ *
+ * Normally @fname->disk_name will be set, and in that case we simply compare
+ * that to the name stored in the directory entry.  The only exception is that
+ * if we don't have the key for an encrypted directory and a filename in it is
+ * very long, then we won't have the full disk_name and we'll instead need to
+ * match against the fscrypt_digested_name.
+ *
+ * Return: %true if the name matches, otherwise %false.
+ */
+bool fscrypt_match_name(const struct fscrypt_name *fname,
+				      const u8 *de_name, u32 de_name_len)
+{
+	if (unlikely(!fname->disk_name.name)) {
+		const struct fscrypt_nokey_name *n =
+			(const void *)fname->crypto_buf.name;
+		u32 len;
+		bool check_sha256 = false;
+		u8 sha256[SHA256_DIGEST_SIZE];
+
+		if (fname->crypto_buf.len ==
+			    offsetofend(struct fscrypt_nokey_name, sha256)) {
+			len = FSCRYPT_FNAME_UNDIGESTED_SIZE;
+			check_sha256 = true;
+		} else {
+			len = fname->crypto_buf.len -
+				offsetof(struct fscrypt_nokey_name, bytes);
+		}
+		if (!check_sha256 && de_name_len != len)
+			return false;
+		if (check_sha256 && de_name_len <= len)
+			return false;
+		if (memcmp(de_name, n->bytes, len) != 0)
+			return false;
+		if (check_sha256) {
+			fscrypt_do_sha256(sha256,
+				&de_name[FSCRYPT_FNAME_UNDIGESTED_SIZE],
+				de_name_len - FSCRYPT_FNAME_UNDIGESTED_SIZE);
+			if (memcmp(sha256, n->sha256, sizeof(sha256)) != 0)
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
 /**
  * fscrypt_fname_siphash() - Calculate the siphash for a file name
  * @dir: the parent directory
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 028aed925e51..ddb7245ba92b 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <crypto/sha.h>
 #include <uapi/linux/fscrypt.h>
 
 #define FS_CRYPTO_BLOCK_SIZE		16
@@ -160,79 +161,34 @@ extern int fscrypt_fname_disk_to_usr(struct inode *, u32, u32,
 extern u64 fscrypt_fname_siphash(const struct inode *dir,
 					const struct qstr *name);
 
-#define FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE	32
-
-/* Extracts the second-to-last ciphertext block; see explanation below */
-#define FSCRYPT_FNAME_DIGEST(name, len)	\
-	((name) + round_down((len) - FS_CRYPTO_BLOCK_SIZE - 1, \
-			     FS_CRYPTO_BLOCK_SIZE))
-
-#define FSCRYPT_FNAME_DIGEST_SIZE	FS_CRYPTO_BLOCK_SIZE
-
 /**
- * fscrypt_digested_name - alternate identifier for an on-disk filename
+ * fscrypt_nokey_name - identifier for on-disk filenames when key is not present
  *
- * When userspace lists an encrypted directory without access to the key,
- * filenames whose ciphertext is longer than FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE
- * bytes are shown in this abbreviated form (base64-encoded) rather than as the
- * full ciphertext (base64-encoded).  This is necessary to allow supporting
- * filenames up to NAME_MAX bytes, since base64 encoding expands the length.
+ * When userspace lists an encrypted directory without access to the key, we
+ * must present them with a unique identifier for the file. base64 encoding will
+ * expand the space, so we use this format to avoid most collisions.
  *
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
  */
-struct fscrypt_digested_name {
-	u32 hash;
-	u32 minor_hash;
-	u8 digest[FSCRYPT_FNAME_DIGEST_SIZE];
-};
 
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
+#define FSCRYPT_FNAME_UNDIGESTED_SIZE 149
+struct fscrypt_nokey_name {
+	u32 dirtree_hash[2];
+	u8 bytes[FSCRYPT_FNAME_UNDIGESTED_SIZE];
+	u8 sha256[SHA256_DIGEST_SIZE];
+};
 
-	if (de_name_len != fname->disk_name.len)
-		return false;
-	return !memcmp(de_name, fname->disk_name.name, fname->disk_name.len);
-}
+extern bool fscrypt_match_name(const struct fscrypt_name *fname,
+				      const u8 *de_name, u32 de_name_len);
 
 /* bio.c */
 extern void fscrypt_decrypt_bio(struct bio *);
@@ -448,7 +404,7 @@ static inline void fscrypt_fname_free_buffer(struct fscrypt_str *crypto_str)
 }
 
 static inline int fscrypt_fname_disk_to_usr(struct inode *inode,
-					    u32 hash, u32 minor_hash,
+					    u32 dirtree_hash, u32 minor_hash,
 					    const struct fscrypt_str *iname,
 					    struct fscrypt_str *oname)
 {
-- 
2.24.0.393.g34dc348eaf-goog

