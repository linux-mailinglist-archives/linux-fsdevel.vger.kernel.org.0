Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAD3F8BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbhHZQVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243090AbhHZQVG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB3AA610C9;
        Thu, 26 Aug 2021 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994818;
        bh=KDf+Ejjz61/nofxenZDZwdXerxSurduPHmXRYSgcDMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bG1IKNlRyMWwMipVLQHKGyPYnJICS8zqBN15VCLKTN4tgWQQv4AtDT6CuzDXOxZQd
         6mHDUttCxethpEcKSVxmi0MJjFip43LsAbaBx5y8koUqejdnTB3jsH6mJzMQ/tj+Hs
         gjjDurgmfe3+PbPOge4xHzlLZ3T5yoZs6xQODdKYemDkwZVCN3heJJWHBtlBcMNjvv
         Z01A3ie449tXnEICxHYw3Fr5J5tEiwr8LnwNch26sM19Pu/bE8GyZzwTkPTMTh27La
         jTVLczoAUrvKpvKt66UIkswmuNg74gsoZsTmJWdZYiovSAoqfy81sg38uDf4Q8nDgF
         xDww1bfciEdTQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org
Subject: [RFC PATCH v8 02/24] fscrypt: export fscrypt_base64url_encode and fscrypt_base64url_decode
Date:   Thu, 26 Aug 2021 12:19:52 -0400
Message-Id: <20210826162014.73464-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826162014.73464-1-jlayton@kernel.org>
References: <20210826162014.73464-1-jlayton@kernel.org>
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
index c61fc3708c64..02555a31875a 100644
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
  * Return: length of the resulting base64url-encoded string in bytes.
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
index 2ea1387bb497..07144330f975 100644
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
  * fscrypt superblock flags
@@ -207,6 +210,8 @@ void fscrypt_free_inode(struct inode *inode);
 int fscrypt_drop_inode(struct inode *inode);
 
 /* fname.c */
+int fscrypt_base64url_encode(const u8 *src, int len, char *dst);
+int fscrypt_base64url_decode(const char *src, int len, u8 *dst);
 int fscrypt_setup_filename(struct inode *inode, const struct qstr *iname,
 			   int lookup, struct fscrypt_name *fname);
 
-- 
2.31.1

