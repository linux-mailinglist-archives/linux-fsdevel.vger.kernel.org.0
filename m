Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599A926957F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgINTTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgINTRM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:12 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EAC12193E;
        Mon, 14 Sep 2020 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111031;
        bh=RRG5jWfcXLR0NrlKhOgSI036PP3peERr9S0AbL7B7c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gfY9GNwSlmqnef92uhj28oEPQT0aAN6HWWIf5STBosQlxJE9JNmnPoRdsrcRc1/gB
         3r2EAjNKV1SDJqCMCtWuEdp85ppiL9hxV9NH+GvVsUw3325okehKEeUckY9NMSNofY
         5DPf1HESkux37u8oDV/KgFkfRHYNAkNNYhLiw/2o=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 02/16] fscrypt: export fscrypt_base64_encode and fscrypt_base64_decode
Date:   Mon, 14 Sep 2020 15:16:53 -0400
Message-Id: <20200914191707.380444-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph will need to base64-encode some encrypted inode names, so make
these routines, and FSCRYPT_BASE64_CHARS available to modules.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/fname.c       | 59 ++++++++++++++++++++++++++++++++++-------
 include/linux/fscrypt.h |  4 +++
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index eb13408b50a7..a1cb6c2c50c4 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -187,10 +187,8 @@ static int fname_decrypt(const struct inode *inode,
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
@@ -200,7 +198,7 @@ static const char lookup_table[65] =
  *
  * Return: length of the encoded string
  */
-static int base64_encode(const u8 *src, int len, char *dst)
+int fscrypt_base64_encode(const u8 *src, int len, char *dst)
 {
 	int i, bits = 0, ac = 0;
 	char *cp = dst;
@@ -218,8 +216,9 @@ static int base64_encode(const u8 *src, int len, char *dst)
 		*cp++ = lookup_table[ac & 0x3f];
 	return cp - dst;
 }
+EXPORT_SYMBOL(fscrypt_base64_encode);
 
-static int base64_decode(const char *src, int len, u8 *dst)
+int fscrypt_base64_decode(const char *src, int len, u8 *dst)
 {
 	int i, bits = 0, ac = 0;
 	const char *p;
@@ -241,6 +240,7 @@ static int base64_decode(const char *src, int len, u8 *dst)
 		return -1;
 	return cp - dst;
 }
+EXPORT_SYMBOL(fscrypt_base64_decode);
 
 bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 				  u32 orig_len, u32 max_len,
@@ -272,7 +272,7 @@ bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 int fscrypt_fname_alloc_buffer(u32 max_encrypted_len,
 			       struct fscrypt_str *crypto_str)
 {
-	const u32 max_encoded_len = BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX);
+	const u32 max_encoded_len = FSCRYPT_BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX);
 	u32 max_presented_len;
 
 	max_presented_len = max(max_encoded_len, max_encrypted_len);
@@ -300,6 +300,45 @@ void fscrypt_fname_free_buffer(struct fscrypt_str *crypto_str)
 }
 EXPORT_SYMBOL(fscrypt_fname_free_buffer);
 
+void fscrypt_encode_nokey_name(u32 hash, u32 minor_hash,
+			     const struct fscrypt_str *iname,
+			     struct fscrypt_str *oname)
+{
+	struct fscrypt_nokey_name nokey_name;
+	u32 size; /* size of the unencoded no-key name */
+
+	/*
+	 * Sanity check that struct fscrypt_nokey_name doesn't have padding
+	 * between fields and that its encoded size never exceeds NAME_MAX.
+	 */
+	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, dirhash) !=
+		     offsetof(struct fscrypt_nokey_name, bytes));
+	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
+		     offsetof(struct fscrypt_nokey_name, sha256));
+	BUILD_BUG_ON(FSCRYPT_BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
+
+	if (hash) {
+		nokey_name.dirhash[0] = hash;
+		nokey_name.dirhash[1] = minor_hash;
+	} else {
+		nokey_name.dirhash[0] = 0;
+		nokey_name.dirhash[1] = 0;
+	}
+	if (iname->len <= sizeof(nokey_name.bytes)) {
+		memcpy(nokey_name.bytes, iname->name, iname->len);
+		size = offsetof(struct fscrypt_nokey_name, bytes[iname->len]);
+	} else {
+		memcpy(nokey_name.bytes, iname->name, sizeof(nokey_name.bytes));
+		/* Compute strong hash of remaining part of name. */
+		fscrypt_do_sha256(&iname->name[sizeof(nokey_name.bytes)],
+				  iname->len - sizeof(nokey_name.bytes),
+				  nokey_name.sha256);
+		size = FSCRYPT_NOKEY_NAME_MAX;
+	}
+	oname->len = fscrypt_base64_encode((const u8 *)&nokey_name, size, oname->name);
+}
+EXPORT_SYMBOL(fscrypt_encode_nokey_name);
+
 /**
  * fscrypt_fname_disk_to_usr() - convert an encrypted filename to
  *				 user-presentable form
@@ -351,7 +390,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 		     offsetof(struct fscrypt_nokey_name, bytes));
 	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
 		     offsetof(struct fscrypt_nokey_name, sha256));
-	BUILD_BUG_ON(BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
+	BUILD_BUG_ON(FSCRYPT_BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
 
 	if (hash) {
 		nokey_name.dirhash[0] = hash;
@@ -371,7 +410,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 				  nokey_name.sha256);
 		size = FSCRYPT_NOKEY_NAME_MAX;
 	}
-	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
+	oname->len = fscrypt_base64_encode((const u8 *)&nokey_name, size, oname->name);
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
@@ -445,14 +484,14 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	 * user-supplied name
 	 */
 
-	if (iname->len > BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX))
+	if (iname->len > FSCRYPT_BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX))
 		return -ENOENT;
 
 	fname->crypto_buf.name = kmalloc(FSCRYPT_NOKEY_NAME_MAX, GFP_KERNEL);
 	if (fname->crypto_buf.name == NULL)
 		return -ENOMEM;
 
-	ret = base64_decode(iname->name, iname->len, fname->crypto_buf.name);
+	ret = fscrypt_base64_decode(iname->name, iname->len, fname->crypto_buf.name);
 	if (ret < (int)offsetof(struct fscrypt_nokey_name, bytes[1]) ||
 	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
 	     ret != FSCRYPT_NOKEY_NAME_MAX)) {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index b3b0c5675c6b..95dddba3ed00 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -182,6 +182,10 @@ void fscrypt_free_inode(struct inode *inode);
 int fscrypt_drop_inode(struct inode *inode);
 
 /* fname.c */
+#define FSCRYPT_BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
+
+int fscrypt_base64_encode(const u8 *src, int len, char *dst);
+int fscrypt_base64_decode(const char *src, int len, u8 *dst);
 int fscrypt_setup_filename(struct inode *inode, const struct qstr *iname,
 			   int lookup, struct fscrypt_name *fname);
 
-- 
2.26.2

