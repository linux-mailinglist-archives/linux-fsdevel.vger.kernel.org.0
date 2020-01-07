Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC56131DAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 03:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgAGCdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 21:33:51 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51039 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgAGCdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:33:51 -0500
Received: by mail-pg1-f201.google.com with SMTP id d129so10208772pgc.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 18:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V+wAP1kX7+6UK7TNvBv96MVnOQ7c2kmsQF2olyv9A3k=;
        b=kXjeJNAHJVJ5GJnz5AC3hX+2SRU4qA1q5yhIgbXudKQK9RUNe2/yLftqniXAzHbJSy
         L5Q6fpBnRlc8bn0YA9c/fyMThrqwgpYGrYyIT6F7YSzwqYXvINtkW/Uj2bqhTT3t/XTV
         9364CGvTy8ZzcLPBrB/eHnn33IKmiVtTRyhh1uTcOx6B9JzzwKHh7JM0Dfg3sj+F+G8A
         AX7iehbYSuXLwkSJoP2Fa1oUK7Aw2HUvId5k4MTkNLveWPTLM+gT1mYwzhYPRgdX4RJA
         GBY95VmYMFy2OJJONVZgnMPNdquu7P1U0PdfvtRDpVvSSHMFZM6e1kCVm7DmUypeehkp
         iIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V+wAP1kX7+6UK7TNvBv96MVnOQ7c2kmsQF2olyv9A3k=;
        b=KDXZOy75WgYpOacfV90vt7DQq3AjYFY75WxuHDbZFjfR909i+gzucFwx4s7Bw5pwNO
         hAlvyeVTGmYewkcwW2enPz2rBy6bSF/5IEOgajMU5eEVLzj8GskaCldIcrY+QPwsw4sV
         Z1CWRKYxEHkVcVg9AQTc0VekU/sQC5x7awmDu26noUTdZGN3wiGwdPMHHEDU497d9ktB
         6ki+n7jV7WD11RIhTghrzCksRiKT/WXNqvVet0LaXEgbzfb6oZnSddyhVulmVlT6KciA
         3CaOfqe/cMXQt6/MEaD9bto64pbujT0J5TfThucvJPynRX+whFrIjxh9BzqmIlqh58mg
         48dQ==
X-Gm-Message-State: APjAAAW/gxSvZiyBQ8rwQu7Einoz45QboZ0NufcOe/wf0ZDq6hRm/MHl
        nsUegxDIMpkLCdCR64G4NWx3nUVnkw4=
X-Google-Smtp-Source: APXvYqz67MX0yzL84Ea7ryCS0j2l69Pn2Gbbf6ouCiS+ENw2ax0hXdsBhNy2rQHjerwkP9jgM6r0EEQNGfk=
X-Received: by 2002:a65:55cd:: with SMTP id k13mr109943631pgs.197.1578364429933;
 Mon, 06 Jan 2020 18:33:49 -0800 (PST)
Date:   Mon,  6 Jan 2020 18:33:23 -0800
In-Reply-To: <20200107023323.38394-1-drosen@google.com>
Message-Id: <20200107023323.38394-4-drosen@google.com>
Mime-Version: 1.0
References: <20200107023323.38394-1-drosen@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 3/3] fscrypt: Change format of no-key token
From:   Daniel Rosenberg <drosen@google.com>
To:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fscrypt supplies a no-key token in place of file names when the name is
encrypted and the key is not present. In the current scheme, the no-key
token is the base64 encoded ciphertext of the name, unless the name is
longer than a certain amount, after which it uses an alternative scheme
which includes the directory hash of the file name and an abbreviated
form of the ciphertext. Encrypted and casefolded names always require a
dirtree hash, since their values cannot be generated without the key.

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
 fs/crypto/fname.c       | 210 ++++++++++++++++++++++++++++++----------
 include/linux/fscrypt.h |  75 +-------------
 3 files changed, 162 insertions(+), 124 deletions(-)

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index 02df95b44331..8046d7c7a3e9 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -21,5 +21,6 @@ config FS_ENCRYPTION_ALGS
 	select CRYPTO_CTS
 	select CRYPTO_ECB
 	select CRYPTO_HMAC
+	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_XTS
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 371e8f01d1c8..4006ffd59ffa 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -13,9 +13,69 @@
 
 #include <linux/namei.h>
 #include <linux/scatterlist.h>
+#include <crypto/hash.h>
+#include <crypto/sha.h>
 #include <crypto/skcipher.h>
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
@@ -208,8 +268,7 @@ int fscrypt_fname_alloc_buffer(const struct inode *inode,
 			       struct fscrypt_str *crypto_str)
 {
 	const u32 max_encoded_len =
-		max_t(u32, BASE64_CHARS(FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE),
-		      1 + BASE64_CHARS(sizeof(struct fscrypt_digested_name)));
+		      BASE64_CHARS(sizeof(struct fscrypt_nokey_name));
 	u32 max_presented_len;
 
 	max_presented_len = max(max_encoded_len, max_encrypted_len);
@@ -242,9 +301,9 @@ EXPORT_SYMBOL(fscrypt_fname_free_buffer);
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
@@ -254,7 +313,9 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 			      struct fscrypt_str *oname)
 {
 	const struct qstr qname = FSTR_TO_QSTR(iname);
-	struct fscrypt_digested_name digested_name;
+	struct fscrypt_nokey_name nokey_name;
+	u32 size;
+	int err = 0;
 
 	if (fscrypt_is_dot_dotdot(&qname)) {
 		oname->name[0] = '.';
@@ -269,25 +330,29 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 	if (fscrypt_has_encryption_key(inode))
 		return fname_decrypt(inode, iname, oname);
 
-	if (iname->len <= FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE) {
-		oname->len = base64_encode(iname->name, iname->len,
-					   oname->name);
-		return 0;
-	}
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
+	if (iname->len <= FSCRYPT_FNAME_UNDIGESTED_SIZE) {
+		memcpy(nokey_name.bytes, iname->name, iname->len);
+		size = offsetof(struct fscrypt_nokey_name, bytes[iname->len]);
+	} else {
+		memcpy(nokey_name.bytes, iname->name,
+		       FSCRYPT_FNAME_UNDIGESTED_SIZE);
+		/* compute sha256 of remaining name */
+		err = fscrypt_do_sha256(nokey_name.sha256,
+				&iname->name[FSCRYPT_FNAME_UNDIGESTED_SIZE],
+				iname->len - FSCRYPT_FNAME_UNDIGESTED_SIZE);
+		if (err)
+			return err;
+		size = offsetofend(struct fscrypt_nokey_name, sha256);
+	}
+	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
+	return err;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
 
@@ -307,8 +372,7 @@ EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
  * get the disk_name.
  *
  * Else, for keyless @lookup operations, @iname is the presented ciphertext, so
- * we decode it to get either the ciphertext disk_name (for short names) or the
- * fscrypt_digested_name (for long names).  Non-@lookup operations will be
+ * we decode it to get the fscrypt_nokey_name. Non-@lookup operations will be
  * impossible in this case, so we fail them with ENOKEY.
  *
  * If successful, fscrypt_free_filename() must be called later to clean up.
@@ -318,8 +382,8 @@ EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
 int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 			      int lookup, struct fscrypt_name *fname)
 {
+	struct fscrypt_nokey_name *nokey_name;
 	int ret;
-	int digested;
 
 	memset(fname, 0, sizeof(struct fscrypt_name));
 	fname->usr_fname = iname;
@@ -359,41 +423,29 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
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
-			    fname->crypto_buf.name);
-	if (ret < 0) {
+	if (iname->len > BASE64_CHARS(sizeof(struct fscrypt_nokey_name))) {
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
+	ret = base64_decode(iname->name, iname->len, fname->crypto_buf.name);
+	if ((int)ret < offsetof(struct fscrypt_nokey_name, bytes[1]) ||
+	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
+	     ret != offsetofend(struct fscrypt_nokey_name, sha256))) {
+		ret = -ENOENT;
+		goto errout;
 	}
+
+	nokey_name = (void *)fname->crypto_buf.name;
+	fname->crypto_buf.len = ret;
+
+	fname->hash = nokey_name->dirtree_hash[0];
+	fname->minor_hash = nokey_name->dirtree_hash[1];
 	return 0;
 
 errout:
@@ -402,6 +454,62 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
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
 /**
  * fscrypt_fname_siphash() - Calculate the siphash for a file name
  * @dir: the parent directory
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 2c292f19c6b9..14a727759a81 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -179,79 +179,8 @@ extern int fscrypt_fname_disk_to_usr(const struct inode *inode,
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
-- 
2.24.1.735.g03f4e72817-goog

