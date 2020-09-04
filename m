Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0734F25DF39
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgIDQHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgIDQFq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:46 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2A7120796;
        Fri,  4 Sep 2020 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235546;
        bh=3MYNF7bBsJX+WWzvNJzDftLayX5rr+SPepr6lTi27zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHKuSZBgVxvHLb1Zl1piBkAmgeaYcow+WbwN9BfDFRRof/urxpSufQBwb9ugCHqxm
         qH4VoFa2z228iW9+IWP5mWyj8Lf0iav+4EYU6+Vh1WTZGXzfBJQPRPB2tokUDyOIHE
         z2a3TRzkUzDzFi+n9Fy7Jae2TgrEcCWhUp5Pap/o=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 07/18] lib: lift fscrypt base64 conversion into lib/
Date:   Fri,  4 Sep 2020 12:05:26 -0400
Message-Id: <20200904160537.76663-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Once we allow encrypted filenames on ceph we'll end up with names that
may have illegal characters in them (embedded '\0' or '/'), or
characters that aren't printable.

It will be safer to use strings that are printable. It turns out that the
MDS doesn't really care about the length of filenames, so we can just
base64 encode and decode filenames before writing and reading them.

Lift the base64 implementation that's in fscrypt into lib/. Make fscrypt
select it when it's enabled.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/Kconfig            |  1 +
 fs/crypto/fname.c            | 64 ++------------------------------
 include/linux/base64_fname.h | 11 ++++++
 lib/Kconfig                  |  3 ++
 lib/Makefile                 |  1 +
 lib/base64_fname.c           | 71 ++++++++++++++++++++++++++++++++++++
 6 files changed, 90 insertions(+), 61 deletions(-)
 create mode 100644 include/linux/base64_fname.h
 create mode 100644 lib/base64_fname.c

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index a5f5c30368a2..6b27d105420c 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -6,6 +6,7 @@ config FS_ENCRYPTION
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_SHA256
 	select KEYS
+	select BASE64_FNAME
 	help
 	  Enable encryption of files and directories.  This
 	  feature is similar to ecryptfs, but it is more memory
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 09f09def87fc..89e26e923547 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -11,6 +11,7 @@
  * This has not yet undergone a rigorous security audit.
  */
 
+#include <linux/base64_fname.h>
 #include <linux/namei.h>
 #include <linux/scatterlist.h>
 #include <crypto/hash.h>
@@ -184,64 +185,6 @@ static int fname_decrypt(const struct inode *inode,
 	return 0;
 }
 
-static const char lookup_table[65] =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
-
-#define BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
-
-/**
- * base64_encode() - base64-encode some bytes
- * @src: the bytes to encode
- * @len: number of bytes to encode
- * @dst: (output) the base64-encoded string.  Not NUL-terminated.
- *
- * Encodes the input string using characters from the set [A-Za-z0-9+,].
- * The encoded string is roughly 4/3 times the size of the input string.
- *
- * Return: length of the encoded string
- */
-static int base64_encode(const u8 *src, int len, char *dst)
-{
-	int i, bits = 0, ac = 0;
-	char *cp = dst;
-
-	for (i = 0; i < len; i++) {
-		ac += src[i] << bits;
-		bits += 8;
-		do {
-			*cp++ = lookup_table[ac & 0x3f];
-			ac >>= 6;
-			bits -= 6;
-		} while (bits >= 6);
-	}
-	if (bits)
-		*cp++ = lookup_table[ac & 0x3f];
-	return cp - dst;
-}
-
-static int base64_decode(const char *src, int len, u8 *dst)
-{
-	int i, bits = 0, ac = 0;
-	const char *p;
-	u8 *cp = dst;
-
-	for (i = 0; i < len; i++) {
-		p = strchr(lookup_table, src[i]);
-		if (p == NULL || src[i] == 0)
-			return -2;
-		ac += (p - lookup_table) << bits;
-		bits += 6;
-		if (bits >= 8) {
-			*cp++ = ac & 0xff;
-			ac >>= 8;
-			bits -= 8;
-		}
-	}
-	if (ac)
-		return -1;
-	return cp - dst;
-}
-
 bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
 				  u32 max_len, u32 *encrypted_len_ret)
 {
@@ -335,7 +278,7 @@ void fscrypt_encode_nokey_name(u32 hash, u32 minor_hash,
 				  nokey_name.sha256);
 		size = FSCRYPT_NOKEY_NAME_MAX;
 	}
-	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
+	oname->len = base64_encode_fname((const u8 *)&nokey_name, size, oname->name);
 }
 EXPORT_SYMBOL(fscrypt_encode_nokey_name);
 
@@ -380,7 +323,6 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 	if (fscrypt_has_encryption_key(inode))
 		return fname_decrypt(inode, iname, oname);
 
-	fscrypt_encode_nokey_name(hash, minor_hash, iname, oname);
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
@@ -460,7 +402,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	if (fname->crypto_buf.name == NULL)
 		return -ENOMEM;
 
-	ret = base64_decode(iname->name, iname->len, fname->crypto_buf.name);
+	ret = base64_decode_fname(iname->name, iname->len, fname->crypto_buf.name);
 	if (ret < (int)offsetof(struct fscrypt_nokey_name, bytes[1]) ||
 	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
 	     ret != FSCRYPT_NOKEY_NAME_MAX)) {
diff --git a/include/linux/base64_fname.h b/include/linux/base64_fname.h
new file mode 100644
index 000000000000..d98d79b4c95c
--- /dev/null
+++ b/include/linux/base64_fname.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef _LIB_BASE64_FNAME_H
+#define _LIB_BASE64_FNAME_H
+#include <linux/types.h>
+
+#define BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
+
+int base64_encode_fname(const u8 *src, int len, char *dst);
+int base64_decode_fname(const char *src, int len, u8 *dst);
+#endif /* _LIB_BASE64_FNAME_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index b4b98a03ff98..94f3939c4cfa 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -684,3 +684,6 @@ config GENERIC_LIB_UCMPDI2
 config PLDMFW
 	bool
 	default n
+
+config BASE64_FNAME
+	tristate
diff --git a/lib/Makefile b/lib/Makefile
index a4a4c6864f51..4e77167d6252 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -171,6 +171,7 @@ obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
 obj-$(CONFIG_CRC8)	+= crc8.o
 obj-$(CONFIG_XXHASH)	+= xxhash.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
+obj-$(CONFIG_BASE64_FNAME) += base64_fname.o
 
 obj-$(CONFIG_842_COMPRESS) += 842/
 obj-$(CONFIG_842_DECOMPRESS) += 842/
diff --git a/lib/base64_fname.c b/lib/base64_fname.c
new file mode 100644
index 000000000000..7638c45e4035
--- /dev/null
+++ b/lib/base64_fname.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Modified base64 encode/decode functions, suitable for use as filename components.
+ *
+ * Originally lifted from fs/crypto/fname.c
+ *
+ * Copyright (C) 2015, Jaegeuk Kim
+ * Copyright (C) 2015, Eric Biggers
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/string.h>
+
+static const char lookup_table[65] =
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
+
+/**
+ * base64_encode() - base64-encode some bytes
+ * @src: the bytes to encode
+ * @len: number of bytes to encode
+ * @dst: (output) the base64-encoded string.  Not NUL-terminated.
+ *
+ * Encodes the input string using characters from the set [A-Za-z0-9+,].
+ * The encoded string is roughly 4/3 times the size of the input string.
+ *
+ * Return: length of the encoded string
+ */
+int base64_encode_fname(const u8 *src, int len, char *dst)
+{
+	int i, bits = 0, ac = 0;
+	char *cp = dst;
+
+	for (i = 0; i < len; i++) {
+		ac += src[i] << bits;
+		bits += 8;
+		do {
+			*cp++ = lookup_table[ac & 0x3f];
+			ac >>= 6;
+			bits -= 6;
+		} while (bits >= 6);
+	}
+	if (bits)
+		*cp++ = lookup_table[ac & 0x3f];
+	return cp - dst;
+}
+EXPORT_SYMBOL(base64_encode_fname);
+
+int base64_decode_fname(const char *src, int len, u8 *dst)
+{
+	int i, bits = 0, ac = 0;
+	const char *p;
+	u8 *cp = dst;
+
+	for (i = 0; i < len; i++) {
+		p = strchr(lookup_table, src[i]);
+		if (p == NULL || src[i] == 0)
+			return -2;
+		ac += (p - lookup_table) << bits;
+		bits += 6;
+		if (bits >= 8) {
+			*cp++ = ac & 0xff;
+			ac >>= 8;
+			bits -= 8;
+		}
+	}
+	if (ac)
+		return -1;
+	return cp - dst;
+}
+EXPORT_SYMBOL(base64_decode_fname);
-- 
2.26.2

