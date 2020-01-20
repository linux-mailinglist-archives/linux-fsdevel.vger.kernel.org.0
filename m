Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1EA142272
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 05:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgATEtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 23:49:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbgATEtA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:49:00 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E0B4207FD;
        Mon, 20 Jan 2020 04:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579495738;
        bh=IGMkQrNx58sdKreblrpAmaCSG7NKWX7RBzLDowk/gQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uP4y8S6Sbevk8dvMhLVIb831GY794EJX9PsZGN7nVCy1vVSY4KaeCte0xIUAZ607Q
         C49r4+tv6DTUXTsr4vr4eLhrwn9AH4XmW3nDT6uKyaoxGtG3WekOdjdGMH+YyaDYsl
         iXLdqxuIjeCy7nqYpEv4tcmelA00QaSCvzQKApTY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH v4 4/4] fscrypt: improve format of no-key names
Date:   Sun, 19 Jan 2020 20:44:01 -0800
Message-Id: <20200120044401.325453-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120044401.325453-1-ebiggers@kernel.org>
References: <20200120044401.325453-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Daniel Rosenberg <drosen@google.com>

When an encrypted directory is listed without the key, the filesystem
must show "no-key names" that uniquely identify directory entries, are
at most 255 (NAME_MAX) bytes long, and don't contain '/' or '\0'.
Currently, for short names the no-key name is the base64 encoding of the
ciphertext filename, while for long names it's the base64 encoding of
the ciphertext filename's dirhash and second-to-last 16-byte block.

This format has the following problems:

- Since it doesn't always include the dirhash, it's incompatible with
  directories that will use a secret-keyed dirhash over the plaintext
  filenames.  In this case, the dirhash won't be computable from the
  ciphertext name without the key, so it instead must be retrieved from
  the directory entry and always included in the no-key name.
  Casefolded encrypted directories will use this type of dirhash.

- It's ambiguous: it's possible to craft two filenames that map to the
  same no-key name, since the method used to abbreviate long filenames
  doesn't use a proper cryptographic hash function.

Solve both these problems by switching to a new no-key name format that
is the base64-encoding of a variable-length structure that contains the
dirhash, up to 149 bytes of the ciphertext filename, and (if any bytes
remain) the SHA-256 of the remaining bytes of the ciphertext filename.

This ensures that each no-key name contains everything needed to find
the directory entry again, contains only legal characters, doesn't
exceed NAME_MAX, is unambiguous unless there's a SHA-256 collision, and
that we only take the performance hit of SHA-256 on very long filenames.

Note: this change does *not* address the existing issue where users can
modify the 'dirhash' part of a no-key name and the filesystem may still
accept the name.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
[EB: improved comments and commit message, fixed checking return value
 of base64_decode(), check for SHA-256 error, continue to set disk_name
 for short names to keep matching simpler, and many other cleanups]
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst |   2 +-
 fs/crypto/Kconfig                     |   1 +
 fs/crypto/fname.c                     | 218 ++++++++++++++++++++------
 include/linux/fscrypt.h               |  76 +--------
 4 files changed, 171 insertions(+), 126 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index d5b1b49c3d002..01e909245fcde 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1202,7 +1202,7 @@ filesystem-specific hash(es) needed for directory lookups.  This
 allows the filesystem to still, with a high degree of confidence, map
 the filename given in ->lookup() back to a particular directory entry
 that was previously listed by readdir().  See :c:type:`struct
-fscrypt_digested_name` in the source for more details.
+fscrypt_nokey_name` in the source for more details.
 
 Note that the precise way that filenames are presented to userspace
 without the key is subject to change in the future.  It is only meant
diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index 02df95b44331d..8046d7c7a3e9c 100644
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
index 2d0d5a934e170..938220292e8de 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -13,9 +13,85 @@
 
 #include <linux/namei.h>
 #include <linux/scatterlist.h>
+#include <crypto/hash.h>
+#include <crypto/sha.h>
 #include <crypto/skcipher.h>
 #include "fscrypt_private.h"
 
+/**
+ * struct fscrypt_nokey_name - identifier for directory entry when key is absent
+ *
+ * When userspace lists an encrypted directory without access to the key, the
+ * filesystem must present a unique "no-key name" for each filename that allows
+ * it to find the directory entry again if requested.  Naively, that would just
+ * mean using the ciphertext filenames.  However, since the ciphertext filenames
+ * can contain illegal characters ('\0' and '/'), they must be encoded in some
+ * way.  We use base64.  But that can cause names to exceed NAME_MAX (255
+ * bytes), so we also need to use a strong hash to abbreviate long names.
+ *
+ * The filesystem may also need another kind of hash, the "dirhash", to quickly
+ * find the directory entry.  Since filesystems normally compute the dirhash
+ * over the on-disk filename (i.e. the ciphertext), it's not computable from
+ * no-key names that abbreviate the ciphertext using the strong hash to fit in
+ * NAME_MAX.  It's also not computable if it's a keyed hash taken over the
+ * plaintext (but it may still be available in the on-disk directory entry);
+ * casefolded directories use this type of dirhash.  At least in these cases,
+ * each no-key name must include the name's dirhash too.
+ *
+ * To meet all these requirements, we base64-encode the following
+ * variable-length structure.  It contains the dirhash, or 0's if the filesystem
+ * didn't provide one; up to 149 bytes of the ciphertext name; and for
+ * ciphertexts longer than 149 bytes, also the SHA-256 of the remaining bytes.
+ *
+ * This ensures that each no-key name contains everything needed to find the
+ * directory entry again, contains only legal characters, doesn't exceed
+ * NAME_MAX, is unambiguous unless there's a SHA-256 collision, and that we only
+ * take the performance hit of SHA-256 on very long filenames (which are rare).
+ */
+struct fscrypt_nokey_name {
+	u32 dirhash[2];
+	u8 bytes[149];
+	u8 sha256[SHA256_DIGEST_SIZE];
+}; /* 189 bytes => 252 bytes base64-encoded, which is <= NAME_MAX (255) */
+
+/*
+ * Decoded size of max-size nokey name, i.e. a name that was abbreviated using
+ * the strong hash and thus includes the 'sha256' field.  This isn't simply
+ * sizeof(struct fscrypt_nokey_name), as the padding at the end isn't included.
+ */
+#define FSCRYPT_NOKEY_NAME_MAX	offsetofend(struct fscrypt_nokey_name, sha256)
+
+static struct crypto_shash *sha256_hash_tfm;
+
+static int fscrypt_do_sha256(const u8 *data, unsigned int data_len, u8 *result)
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
@@ -207,9 +283,7 @@ int fscrypt_fname_alloc_buffer(const struct inode *inode,
 			       u32 max_encrypted_len,
 			       struct fscrypt_str *crypto_str)
 {
-	const u32 max_encoded_len =
-		max_t(u32, BASE64_CHARS(FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE),
-		      1 + BASE64_CHARS(sizeof(struct fscrypt_digested_name)));
+	const u32 max_encoded_len = BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX);
 	u32 max_presented_len;
 
 	max_presented_len = max(max_encoded_len, max_encrypted_len);
@@ -242,9 +316,9 @@ EXPORT_SYMBOL(fscrypt_fname_free_buffer);
  *
  * The caller must have allocated sufficient memory for the @oname string.
  *
- * If the key is available, we'll decrypt the disk name; otherwise, we'll encode
- * it for presentation.  Short names are directly base64-encoded, while long
- * names are encoded in fscrypt_digested_name format.
+ * If the key is available, we'll decrypt the disk name.  Otherwise, we'll
+ * encode it for presentation in fscrypt_nokey_name format.
+ * See struct fscrypt_nokey_name for details.
  *
  * Return: 0 on success, -errno on failure
  */
@@ -254,7 +328,9 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 			      struct fscrypt_str *oname)
 {
 	const struct qstr qname = FSTR_TO_QSTR(iname);
-	struct fscrypt_digested_name digested_name;
+	struct fscrypt_nokey_name nokey_name;
+	u32 size; /* size of the unencoded no-key name */
+	int err;
 
 	if (fscrypt_is_dot_dotdot(&qname)) {
 		oname->name[0] = '.';
@@ -269,24 +345,37 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 	if (fscrypt_has_encryption_key(inode))
 		return fname_decrypt(inode, iname, oname);
 
-	if (iname->len <= FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE) {
-		oname->len = base64_encode(iname->name, iname->len,
-					   oname->name);
-		return 0;
-	}
+	/*
+	 * Sanity check that struct fscrypt_nokey_name doesn't have padding
+	 * between fields and that its encoded size never exceeds NAME_MAX.
+	 */
+	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, dirhash) !=
+		     offsetof(struct fscrypt_nokey_name, bytes));
+	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
+		     offsetof(struct fscrypt_nokey_name, sha256));
+	BUILD_BUG_ON(BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
+
 	if (hash) {
-		digested_name.hash = hash;
-		digested_name.minor_hash = minor_hash;
+		nokey_name.dirhash[0] = hash;
+		nokey_name.dirhash[1] = minor_hash;
+	} else {
+		nokey_name.dirhash[0] = 0;
+		nokey_name.dirhash[1] = 0;
+	}
+	if (iname->len <= sizeof(nokey_name.bytes)) {
+		memcpy(nokey_name.bytes, iname->name, iname->len);
+		size = offsetof(struct fscrypt_nokey_name, bytes[iname->len]);
 	} else {
-		digested_name.hash = 0;
-		digested_name.minor_hash = 0;
+		memcpy(nokey_name.bytes, iname->name, sizeof(nokey_name.bytes));
+		/* Compute strong hash of remaining part of name. */
+		err = fscrypt_do_sha256(&iname->name[sizeof(nokey_name.bytes)],
+					iname->len - sizeof(nokey_name.bytes),
+					nokey_name.sha256);
+		if (err)
+			return err;
+		size = FSCRYPT_NOKEY_NAME_MAX;
 	}
-	memcpy(digested_name.digest,
-	       FSCRYPT_FNAME_DIGEST(iname->name, iname->len),
-	       FSCRYPT_FNAME_DIGEST_SIZE);
-	oname->name[0] = '_';
-	oname->len = 1 + base64_encode((const u8 *)&digested_name,
-				       sizeof(digested_name), oname->name + 1);
+	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
@@ -307,8 +396,7 @@ EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
  * get the disk_name.
  *
  * Else, for keyless @lookup operations, @iname is the presented ciphertext, so
- * we decode it to get either the ciphertext disk_name (for short names) or the
- * fscrypt_digested_name (for long names).  Non-@lookup operations will be
+ * we decode it to get the fscrypt_nokey_name.  Non-@lookup operations will be
  * impossible in this case, so we fail them with ENOKEY.
  *
  * If successful, fscrypt_free_filename() must be called later to clean up.
@@ -318,8 +406,8 @@ EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
 int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 			      int lookup, struct fscrypt_name *fname)
 {
+	struct fscrypt_nokey_name *nokey_name;
 	int ret;
-	int digested;
 
 	memset(fname, 0, sizeof(struct fscrypt_name));
 	fname->usr_fname = iname;
@@ -359,40 +447,31 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
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
 
-	fname->crypto_buf.name =
-		kmalloc(max_t(size_t, FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE,
-			      sizeof(struct fscrypt_digested_name)),
-			GFP_KERNEL);
+	if (iname->len > BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX))
+		return -ENOENT;
+
+	fname->crypto_buf.name = kmalloc(FSCRYPT_NOKEY_NAME_MAX, GFP_KERNEL);
 	if (fname->crypto_buf.name == NULL)
 		return -ENOMEM;
 
-	ret = base64_decode(iname->name + digested, iname->len - digested,
-			    fname->crypto_buf.name);
-	if (ret < 0) {
+	ret = base64_decode(iname->name, iname->len, fname->crypto_buf.name);
+	if (ret < (int)offsetof(struct fscrypt_nokey_name, bytes[1]) ||
+	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
+	     ret != FSCRYPT_NOKEY_NAME_MAX)) {
 		ret = -ENOENT;
 		goto errout;
 	}
 	fname->crypto_buf.len = ret;
-	if (digested) {
-		const struct fscrypt_digested_name *n =
-			(const void *)fname->crypto_buf.name;
-		fname->hash = n->hash;
-		fname->minor_hash = n->minor_hash;
-	} else {
-		fname->disk_name.name = fname->crypto_buf.name;
-		fname->disk_name.len = fname->crypto_buf.len;
+
+	nokey_name = (void *)fname->crypto_buf.name;
+	fname->hash = nokey_name->dirhash[0];
+	fname->minor_hash = nokey_name->dirhash[1];
+	if (ret != FSCRYPT_NOKEY_NAME_MAX) {
+		/* The full ciphertext filename is available. */
+		fname->disk_name.name = nokey_name->bytes;
+		fname->disk_name.len =
+			ret - offsetof(struct fscrypt_nokey_name, bytes);
 	}
 	return 0;
 
@@ -402,6 +481,43 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
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
+ * if we don't have the key for an encrypted directory and the name we're
+ * looking for is very long, then we won't have the full disk_name and instead
+ * we'll need to match against a fscrypt_nokey_name that includes a strong hash.
+ *
+ * Return: %true if the name matches, otherwise %false.
+ */
+bool fscrypt_match_name(const struct fscrypt_name *fname,
+			const u8 *de_name, u32 de_name_len)
+{
+	const struct fscrypt_nokey_name *nokey_name =
+		(const void *)fname->crypto_buf.name;
+	u8 sha256[SHA256_DIGEST_SIZE];
+
+	if (likely(fname->disk_name.name)) {
+		if (de_name_len != fname->disk_name.len)
+			return false;
+		return !memcmp(de_name, fname->disk_name.name, de_name_len);
+	}
+	if (de_name_len <= sizeof(nokey_name->bytes))
+		return false;
+	if (memcmp(de_name, nokey_name->bytes, sizeof(nokey_name->bytes)))
+		return false;
+	if (fscrypt_do_sha256(&de_name[sizeof(nokey_name->bytes)],
+			      de_name_len - sizeof(nokey_name->bytes), sha256))
+		return false;
+	return !memcmp(sha256, nokey_name->sha256, sizeof(sha256));
+}
+EXPORT_SYMBOL_GPL(fscrypt_match_name);
+
 /**
  * fscrypt_fname_siphash() - calculate the SipHash of a filename
  * @dir: the parent directory
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 2bb43a772f361..556f4adf5dc58 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -172,83 +172,11 @@ extern int fscrypt_fname_disk_to_usr(const struct inode *inode,
 				     u32 hash, u32 minor_hash,
 				     const struct fscrypt_str *iname,
 				     struct fscrypt_str *oname);
+extern bool fscrypt_match_name(const struct fscrypt_name *fname,
+			       const u8 *de_name, u32 de_name_len);
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
-
 /* bio.c */
 extern void fscrypt_decrypt_bio(struct bio *);
 extern int fscrypt_zeroout_range(const struct inode *, pgoff_t, sector_t,
-- 
2.25.0

