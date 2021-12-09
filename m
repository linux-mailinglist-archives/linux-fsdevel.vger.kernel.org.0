Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507CC46EB7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbhLIPk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42320 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbhLIPk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7BCE3CE2686;
        Thu,  9 Dec 2021 15:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E400C341C8;
        Thu,  9 Dec 2021 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064210;
        bh=nLc8wIZdwxKXjnFZBmULvKbnBy/LSEkw6z9iC5alpx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aabZG1cxH4PSFaQfh59RGZNDMHvzuPfLdk48fsI/LSGfGu/1PwmPbYKaibIN75/Cr
         a+Ax/qSAww5Ij6FiGxrTpkmNBbvyG007rc/UTQlEftm/XN1nT3opWic9NA0hFXLjBM
         ZAWFzX5ZDrVxKqujhOXuy5DPCAdhOiDvRS941YEyu2hReq9WqwZT7aEivxQCmFKu+k
         zJY7oyyTyiSd9jVUnsW+s7DSOgm757lSi58TRc4ZKXLdsM5KNm+vRIFyD3Hh5Wo5oH
         GXfaPKFLF9yjgWzgxGMQUE+QnbCIpFGb9onJCiE9qjyBTNr+I2XB5wcKGDpj+FsfAE
         LSEdU3nFaQ09w==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/36] fscrypt: export fscrypt_base64url_encode and fscrypt_base64url_decode
Date:   Thu,  9 Dec 2021 10:36:13 -0500
Message-Id: <20211209153647.58953-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph is going to add fscrypt support, but we still want encrypted
filenames to be composed of printable characters, so we can maintain
compatibility with clients that don't support fscrypt.

We could just adopt fscrypt's current nokey name format, but that is
subject to change in the future, and it also contains dirhash fields
that we don't need for cephfs. Because of this, we're going to concoct
our own scheme for encoding encrypted filenames. It's very similar to
fscrypt's current scheme, but doesn't bother with the dirhash fields.

The ceph encoding scheme will use base64 encoding as well, and we also
want it to avoid characters that are illegal in filenames. Export the
fscrypt base64 encoding/decoding routines so we can use them in ceph's
fscrypt implementation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/fname.c       | 8 ++++----
 include/linux/fscrypt.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index a9be4bc74a94..8fa23d525b5c 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -182,8 +182,6 @@ static int fname_decrypt(const struct inode *inode,
 static const char base64url_table[65] =
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
 
-#define FSCRYPT_BASE64URL_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
-
 /**
  * fscrypt_base64url_encode() - base64url-encode some binary data
  * @src: the binary data to encode
@@ -198,7 +196,7 @@ static const char base64url_table[65] =
  * Return: the length of the resulting base64url-encoded string in bytes.
  *	   This will be equal to FSCRYPT_BASE64URL_CHARS(srclen).
  */
-static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
+int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
 {
 	u32 ac = 0;
 	int bits = 0;
@@ -217,6 +215,7 @@ static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
 		*cp++ = base64url_table[(ac << (6 - bits)) & 0x3f];
 	return cp - dst;
 }
+EXPORT_SYMBOL(fscrypt_base64url_encode);
 
 /**
  * fscrypt_base64url_decode() - base64url-decode a string
@@ -233,7 +232,7 @@ static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
  * Return: the length of the resulting decoded binary data in bytes,
  *	   or -1 if the string isn't a valid base64url string.
  */
-static int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
+int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
 {
 	u32 ac = 0;
 	int bits = 0;
@@ -256,6 +255,7 @@ static int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
 		return -1;
 	return bp - dst;
 }
+EXPORT_SYMBOL(fscrypt_base64url_decode);
 
 bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 				  u32 orig_len, u32 max_len,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 91ea9477e9bd..671181d196a8 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -46,6 +46,9 @@ struct fscrypt_name {
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
 
+/* len of resulting string (sans NUL terminator) after base64 encoding nbytes */
+#define FSCRYPT_BASE64URL_CHARS(nbytes)		DIV_ROUND_UP((nbytes) * 4, 3)
+
 #ifdef CONFIG_FS_ENCRYPTION
 
 /*
@@ -305,6 +308,8 @@ void fscrypt_free_inode(struct inode *inode);
 int fscrypt_drop_inode(struct inode *inode);
 
 /* fname.c */
+int fscrypt_base64url_encode(const u8 *src, int len, char *dst);
+int fscrypt_base64url_decode(const char *src, int len, u8 *dst);
 int fscrypt_setup_filename(struct inode *inode, const struct qstr *iname,
 			   int lookup, struct fscrypt_name *fname);
 
-- 
2.33.1

