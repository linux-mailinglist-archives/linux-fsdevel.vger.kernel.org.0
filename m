Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25E34AD72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCZRcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhCZRce (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:32:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6026961A13;
        Fri, 26 Mar 2021 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616779950;
        bh=Iaj45ElCCWOZw4jfTCgJUxP8Jlh7dU/5VBQsawn972s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmqlGL71PMXydkzgmzQkoJJ10BiYFYdYxLxPbQ9y+oQo4QjT0IcKl4CVcE872nXVn
         HdU3LGGFxJJs44HjUQeiSmTo5HnXq+twxP7bTCbE4Xk9C1LgcU875tSoZB4z0oLEOg
         IQqsQmb+Rq9zOb6pKC6/9ytJuEwCIKXkV1e1XsN9+5ab7WD8jyYyE9xAj5S0Gctwtv
         e05B+hBR4iVbqVYWmcsL7LDNn3JK8F5rHCGPptPPzXBP+uyfbVbSN0AJpJ2a2O782U
         PlHzHZyCbCu01Xm6hFt7+PIfpfFoldunv6oFFRR1jOqq8MqQ421nqji60WtrN/bhr2
         Tsxb4N3GSoLMA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v5 02/19] fscrypt: export fscrypt_base64_encode and fscrypt_base64_decode
Date:   Fri, 26 Mar 2021 13:32:10 -0400
Message-Id: <20210326173227.96363-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph will need to base64-encode some encrypted filenames, so make
these routines, and FSCRYPT_BASE64_CHARS available to modules.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/fname.c       | 34 ++++++++++++++++++++++++----------
 include/linux/fscrypt.h |  5 +++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 6ca7d16593ff..32b1f50433ba 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -178,10 +178,8 @@ static int fname_decrypt(const struct inode *inode,
 static const char lookup_table[65] =
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
 
-#define BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
-
 /**
- * base64_encode() - base64-encode some bytes
+ * fscrypt_base64_encode() - base64-encode some bytes
  * @src: the bytes to encode
  * @len: number of bytes to encode
  * @dst: (output) the base64-encoded string.  Not NUL-terminated.
@@ -191,7 +189,7 @@ static const char lookup_table[65] =
  *
  * Return: length of the encoded string
  */
-static int base64_encode(const u8 *src, int len, char *dst)
+int fscrypt_base64_encode(const u8 *src, int len, char *dst)
 {
 	int i, bits = 0, ac = 0;
 	char *cp = dst;
@@ -209,8 +207,20 @@ static int base64_encode(const u8 *src, int len, char *dst)
 		*cp++ = lookup_table[ac & 0x3f];
 	return cp - dst;
 }
+EXPORT_SYMBOL(fscrypt_base64_encode);
 
-static int base64_decode(const char *src, int len, u8 *dst)
+/**
+ * fscrypt_base64_decode() - base64-decode some bytes
+ * @src: the bytes to decode
+ * @len: number of bytes to decode
+ * @dst: (output) decoded binary data
+ *
+ * Decode an input string that was previously encoded using
+ * fscrypt_base64_encode.
+ *
+ * Return: length of the decoded binary data
+ */
+int fscrypt_base64_decode(const char *src, int len, u8 *dst)
 {
 	int i, bits = 0, ac = 0;
 	const char *p;
@@ -232,6 +242,7 @@ static int base64_decode(const char *src, int len, u8 *dst)
 		return -1;
 	return cp - dst;
 }
+EXPORT_SYMBOL(fscrypt_base64_decode);
 
 bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 				  u32 orig_len, u32 max_len,
@@ -263,8 +274,9 @@ bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 int fscrypt_fname_alloc_buffer(u32 max_encrypted_len,
 			       struct fscrypt_str *crypto_str)
 {
-	const u32 max_encoded_len = BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX);
 	u32 max_presented_len;
+	const u32 max_encoded_len =
+		FSCRYPT_BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX);
 
 	max_presented_len = max(max_encoded_len, max_encrypted_len);
 
@@ -342,7 +354,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 		     offsetof(struct fscrypt_nokey_name, bytes));
 	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
 		     offsetof(struct fscrypt_nokey_name, sha256));
-	BUILD_BUG_ON(BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
+	BUILD_BUG_ON(FSCRYPT_BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
 
 	if (hash) {
 		nokey_name.dirhash[0] = hash;
@@ -362,7 +374,8 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 		       nokey_name.sha256);
 		size = FSCRYPT_NOKEY_NAME_MAX;
 	}
-	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
+	oname->len = fscrypt_base64_encode((const u8 *)&nokey_name, size,
+					   oname->name);
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
@@ -436,14 +449,15 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	 * user-supplied name
 	 */
 
-	if (iname->len > BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX))
+	if (iname->len > FSCRYPT_BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX))
 		return -ENOENT;
 
 	fname->crypto_buf.name = kmalloc(FSCRYPT_NOKEY_NAME_MAX, GFP_KERNEL);
 	if (fname->crypto_buf.name == NULL)
 		return -ENOMEM;
 
-	ret = base64_decode(iname->name, iname->len, fname->crypto_buf.name);
+	ret = fscrypt_base64_decode(iname->name, iname->len,
+				    fname->crypto_buf.name);
 	if (ret < (int)offsetof(struct fscrypt_nokey_name, bytes[1]) ||
 	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
 	     ret != FSCRYPT_NOKEY_NAME_MAX)) {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 2ea1387bb497..e300f6145ddc 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -46,6 +46,9 @@ struct fscrypt_name {
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
 
+/* Calculate worst-case base64 encoding inflation */
+#define FSCRYPT_BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
+
 #ifdef CONFIG_FS_ENCRYPTION
 /*
  * fscrypt superblock flags
@@ -207,6 +210,8 @@ void fscrypt_free_inode(struct inode *inode);
 int fscrypt_drop_inode(struct inode *inode);
 
 /* fname.c */
+int fscrypt_base64_encode(const u8 *src, int len, char *dst);
+int fscrypt_base64_decode(const char *src, int len, u8 *dst);
 int fscrypt_setup_filename(struct inode *inode, const struct qstr *iname,
 			   int lookup, struct fscrypt_name *fname);
 
-- 
2.30.2

