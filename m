Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED4B3CC6FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jul 2021 02:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhGRAG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 20:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhGRAG4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 20:06:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44FF061103;
        Sun, 18 Jul 2021 00:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626566638;
        bh=IOhyIEB2KuZMWjJK/8EyucCV2qY4utt0nQWmhqiSoSc=;
        h=From:To:Cc:Subject:Date:From;
        b=lCt6t+4NXOuj0XHYGF5NKolSLmMm40+4+tRnDlSEpO/NlClbUHHJW2rohmJ8NdDYN
         X6r36DRL0GEWFm2v8gVo05DdIpPI3RZPvtzmorJ5Gs5zFSvy10WPWqZfjUo9iuYOgg
         wzBD5mmAaQ9vZNYYWLvyi0BiafmmHijZW1OUjbyFDfm14cUBu4rQZjc5YTDb0GKMRT
         2jpYCoJBlZrFhfcIBkCZRdBlO5ph9X96N8jYXY/vq5HWd3/vtGEZejpGgSUYlA3d5s
         Et3HhpfJsWpGmYuWwdnqTSVFBao3H0f/xqSwU16fPPvBJwXS5gSQMyGX0lP4qVy4O0
         RSKSy2se5EhlA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] fscrypt: align Base64 encoding with RFC 4648 base64url
Date:   Sat, 17 Jul 2021 19:01:25 -0500
Message-Id: <20210718000125.59701-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

fscrypt uses a Base64 encoding to encode no-key filenames (the filenames
that are presented to userspace when a directory is listed without its
encryption key).  There are many variants of Base64, but the most common
ones are specified by RFC 4648.  fscrypt can't use the regular RFC 4648
"base64" variant because "base64" uses the '/' character, which isn't
allowed in filenames.  However, RFC 4648 also specifies a "base64url"
variant for use in URLs and filenames.  "base64url" is less common than
"base64", but it's still implemented in many programming libraries.

Unfortunately, what fscrypt actually uses is a custom Base64 variant
that differs from "base64url" in several ways:

- The binary data is divided into 6-bit chunks differently.

- Values 62 and 63 are encoded with '+' and ',' instead of '-' and '_'.

- '='-padding isn't used.  This isn't a problem per se, as the padding
  isn't technically necessary, and RFC 4648 doesn't strictly require it.
  But it needs to be properly documented.

There have been two attempts to copy the fscrypt Base64 code into lib/
(https://lkml.kernel.org/r/20200821182813.52570-6-jlayton@kernel.org and
https://lkml.kernel.org/r/20210716110428.9727-5-hare@suse.de), and both
have been caught up by the fscrypt Base64 variant being nonstandard and
not properly documented.  Also, the planned use of the fscrypt Base64
code in the CephFS storage back-end will prevent it from being changed
later (whereas currently it can still be changed), so we need to choose
an encoding that we're happy with before it's too late.

Therefore, switch the fscrypt Base64 variant to base64url, in order to
align more closely with RFC 4648 and other implementations and uses of
Base64.  However, I opted not to implement '='-padding, as '='-padding
adds complexity, is unnecessary, and isn't required by the RFC.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst |  10 +--
 fs/crypto/fname.c                     | 106 ++++++++++++++++----------
 2 files changed, 70 insertions(+), 46 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 44b67ebd6e40..968938b1a9ff 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1235,12 +1235,12 @@ the user-supplied name to get the ciphertext.
 
 Lookups without the key are more complicated.  The raw ciphertext may
 contain the ``\0`` and ``/`` characters, which are illegal in
-filenames.  Therefore, readdir() must base64-encode the ciphertext for
-presentation.  For most filenames, this works fine; on ->lookup(), the
-filesystem just base64-decodes the user-supplied name to get back to
-the raw ciphertext.
+filenames.  Therefore, readdir() must base64url-encode the ciphertext
+for presentation.  For most filenames, this works fine; on ->lookup(),
+the filesystem just base64url-decodes the user-supplied name to get
+back to the raw ciphertext.
 
-However, for very long filenames, base64 encoding would cause the
+However, for very long filenames, base64url encoding would cause the
 filename length to exceed NAME_MAX.  To prevent this, readdir()
 actually presents long filenames in an abbreviated form which encodes
 a strong "hash" of the ciphertext filename, along with the optional
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index d00455440d08..c61fc3708c64 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -26,7 +26,7 @@
  * it to find the directory entry again if requested.  Naively, that would just
  * mean using the ciphertext filenames.  However, since the ciphertext filenames
  * can contain illegal characters ('\0' and '/'), they must be encoded in some
- * way.  We use base64.  But that can cause names to exceed NAME_MAX (255
+ * way.  We use base64url.  But that can cause names to exceed NAME_MAX (255
  * bytes), so we also need to use a strong hash to abbreviate long names.
  *
  * The filesystem may also need another kind of hash, the "dirhash", to quickly
@@ -38,7 +38,7 @@
  * casefolded directories use this type of dirhash.  At least in these cases,
  * each no-key name must include the name's dirhash too.
  *
- * To meet all these requirements, we base64-encode the following
+ * To meet all these requirements, we base64url-encode the following
  * variable-length structure.  It contains the dirhash, or 0's if the filesystem
  * didn't provide one; up to 149 bytes of the ciphertext name; and for
  * ciphertexts longer than 149 bytes, also the SHA-256 of the remaining bytes.
@@ -52,15 +52,19 @@ struct fscrypt_nokey_name {
 	u32 dirhash[2];
 	u8 bytes[149];
 	u8 sha256[SHA256_DIGEST_SIZE];
-}; /* 189 bytes => 252 bytes base64-encoded, which is <= NAME_MAX (255) */
+}; /* 189 bytes => 252 bytes base64url-encoded, which is <= NAME_MAX (255) */
 
 /*
- * Decoded size of max-size nokey name, i.e. a name that was abbreviated using
+ * Decoded size of max-size no-key name, i.e. a name that was abbreviated using
  * the strong hash and thus includes the 'sha256' field.  This isn't simply
  * sizeof(struct fscrypt_nokey_name), as the padding at the end isn't included.
  */
 #define FSCRYPT_NOKEY_NAME_MAX	offsetofend(struct fscrypt_nokey_name, sha256)
 
+/* Encoded size of max-size no-key name */
+#define FSCRYPT_NOKEY_NAME_MAX_ENCODED \
+		FSCRYPT_BASE64URL_CHARS(FSCRYPT_NOKEY_NAME_MAX)
+
 static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
 {
 	if (str->len == 1 && str->name[0] == '.')
@@ -175,62 +179,82 @@ static int fname_decrypt(const struct inode *inode,
 	return 0;
 }
 
-static const char lookup_table[65] =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
+static const char base64url_table[65] =
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
 
-#define BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
+#define FSCRYPT_BASE64URL_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
 
 /**
- * base64_encode() - base64-encode some bytes
- * @src: the bytes to encode
- * @len: number of bytes to encode
- * @dst: (output) the base64-encoded string.  Not NUL-terminated.
+ * fscrypt_base64url_encode() - base64url-encode some binary data
+ * @src: the binary data to encode
+ * @srclen: the length of @src in bytes
+ * @dst: (output) the base64url-encoded string.  Not NUL-terminated.
  *
- * Encodes the input string using characters from the set [A-Za-z0-9+,].
- * The encoded string is roughly 4/3 times the size of the input string.
+ * Encodes data using base64url encoding, i.e. the "Base 64 Encoding with URL
+ * and Filename Safe Alphabet" specified by RFC 4648.  '='-padding isn't used,
+ * as it's unneeded and not required by the RFC.  base64url is used instead of
+ * base64 to avoid the '/' character, which isn't allowed in filenames.
  *
- * Return: length of the encoded string
+ * Return: length of the resulting base64url-encoded string in bytes.
+ *	   This will be equal to FSCRYPT_BASE64URL_CHARS(srclen).
  */
-static int base64_encode(const u8 *src, int len, char *dst)
+static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
 {
-	int i, bits = 0, ac = 0;
+	u32 ac = 0;
+	int bits = 0;
+	int i;
 	char *cp = dst;
 
-	for (i = 0; i < len; i++) {
-		ac += src[i] << bits;
+	for (i = 0; i < srclen; i++) {
+		ac = (ac << 8) | src[i];
 		bits += 8;
 		do {
-			*cp++ = lookup_table[ac & 0x3f];
-			ac >>= 6;
 			bits -= 6;
+			*cp++ = base64url_table[(ac >> bits) & 0x3f];
 		} while (bits >= 6);
 	}
 	if (bits)
-		*cp++ = lookup_table[ac & 0x3f];
+		*cp++ = base64url_table[(ac << (6 - bits)) & 0x3f];
 	return cp - dst;
 }
 
-static int base64_decode(const char *src, int len, u8 *dst)
+/**
+ * fscrypt_base64url_decode() - base64url-decode a string
+ * @src: the string to decode.  Doesn't need to be NUL-terminated.
+ * @srclen: the length of @src in bytes
+ * @dst: (output) the decoded binary data
+ *
+ * Decodes a string using base64url encoding, i.e. the "Base 64 Encoding with
+ * URL and Filename Safe Alphabet" specified by RFC 4648.  '='-padding isn't
+ * accepted, nor are non-encoding characters such as whitespace.
+ *
+ * This implementation hasn't been optimized for performance.
+ *
+ * Return: the length of the resulting decoded binary data in bytes,
+ *	   or -1 if the string isn't a valid base64url string.
+ */
+static int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
 {
-	int i, bits = 0, ac = 0;
-	const char *p;
-	u8 *cp = dst;
+	u32 ac = 0;
+	int bits = 0;
+	int i;
+	u8 *bp = dst;
+
+	for (i = 0; i < srclen; i++) {
+		const char *p = strchr(base64url_table, src[i]);
 
-	for (i = 0; i < len; i++) {
-		p = strchr(lookup_table, src[i]);
 		if (p == NULL || src[i] == 0)
-			return -2;
-		ac += (p - lookup_table) << bits;
+			return -1;
+		ac = (ac << 6) | (p - base64url_table);
 		bits += 6;
 		if (bits >= 8) {
-			*cp++ = ac & 0xff;
-			ac >>= 8;
 			bits -= 8;
+			*bp++ = (u8)(ac >> bits);
 		}
 	}
-	if (ac)
+	if (ac & ((1 << bits) - 1))
 		return -1;
-	return cp - dst;
+	return bp - dst;
 }
 
 bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
@@ -263,10 +287,8 @@ bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 int fscrypt_fname_alloc_buffer(u32 max_encrypted_len,
 			       struct fscrypt_str *crypto_str)
 {
-	const u32 max_encoded_len = BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX);
-	u32 max_presented_len;
-
-	max_presented_len = max(max_encoded_len, max_encrypted_len);
+	u32 max_presented_len = max_t(u32, FSCRYPT_NOKEY_NAME_MAX_ENCODED,
+				      max_encrypted_len);
 
 	crypto_str->name = kmalloc(max_presented_len + 1, GFP_NOFS);
 	if (!crypto_str->name)
@@ -342,7 +364,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 		     offsetof(struct fscrypt_nokey_name, bytes));
 	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
 		     offsetof(struct fscrypt_nokey_name, sha256));
-	BUILD_BUG_ON(BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
+	BUILD_BUG_ON(FSCRYPT_NOKEY_NAME_MAX_ENCODED > NAME_MAX);
 
 	nokey_name.dirhash[0] = hash;
 	nokey_name.dirhash[1] = minor_hash;
@@ -358,7 +380,8 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 		       nokey_name.sha256);
 		size = FSCRYPT_NOKEY_NAME_MAX;
 	}
-	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
+	oname->len = fscrypt_base64url_encode((const u8 *)&nokey_name, size,
+					      oname->name);
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
@@ -432,14 +455,15 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	 * user-supplied name
 	 */
 
-	if (iname->len > BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX))
+	if (iname->len > FSCRYPT_NOKEY_NAME_MAX_ENCODED)
 		return -ENOENT;
 
 	fname->crypto_buf.name = kmalloc(FSCRYPT_NOKEY_NAME_MAX, GFP_KERNEL);
 	if (fname->crypto_buf.name == NULL)
 		return -ENOMEM;
 
-	ret = base64_decode(iname->name, iname->len, fname->crypto_buf.name);
+	ret = fscrypt_base64url_decode(iname->name, iname->len,
+				       fname->crypto_buf.name);
 	if (ret < (int)offsetof(struct fscrypt_nokey_name, bytes[1]) ||
 	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
 	     ret != FSCRYPT_NOKEY_NAME_MAX)) {

base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.32.0

