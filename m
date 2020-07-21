Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9158228C55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 01:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbgGUXBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 19:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgGUXBA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:01:00 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED9DF2073A;
        Tue, 21 Jul 2020 23:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595372459;
        bh=i10MleHpPiD+UlqvEBbCBk40R3U1eodRZ9LmKRTef48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2UrKh8jVKP4YqMR+ott79ppUtxS+O7gHH9ShvxNTAuNFBZmTmqlCG5CWy9w79n+Cg
         XiIpP7yNESIvQqfvRZiaQZxEVS7x37eKyEqXzXOksAXo5PoR6DPlVSMqDfBnF9DnxQ
         6p9F6n2gtDZpXH1niAqfrcTbH+cjpR+CZkOdM19g=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH 1/5] fscrypt: switch fscrypt_do_sha256() to use the SHA-256 library
Date:   Tue, 21 Jul 2020 15:59:16 -0700
Message-Id: <20200721225920.114347-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721225920.114347-1-ebiggers@kernel.org>
References: <20200721225920.114347-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

fscrypt_do_sha256() is only used for hashing encrypted filenames to
create no-key tokens, which isn't performance-critical.  Therefore a C
implementation of SHA-256 is sufficient.

Also, the logic to create no-key tokens is always potentially needed.
This differs from fscrypt's other dependencies on crypto API algorithms,
which are conditionally needed depending on what encryption policies
userspace is using.  Therefore, for fscrypt there isn't much benefit to
allowing SHA-256 to be a loadable module.

So, make fscrypt_do_sha256() use the SHA-256 library instead of the
crypto_shash API.  This is much simpler, since it avoids having to
implement one-time-init (which is hard to do correctly, and in fact was
implemented incorrectly) and handle failures to allocate the
crypto_shash object.

Fixes: edc440e3d27f ("fscrypt: improve format of no-key names")
Cc: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/Kconfig |  2 +-
 fs/crypto/fname.c | 41 ++++++++++-------------------------------
 2 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index f1f11a6228eb..a5f5c30368a2 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -4,6 +4,7 @@ config FS_ENCRYPTION
 	select CRYPTO
 	select CRYPTO_HASH
 	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_SHA256
 	select KEYS
 	help
 	  Enable encryption of files and directories.  This
@@ -21,7 +22,6 @@ config FS_ENCRYPTION_ALGS
 	select CRYPTO_CTS
 	select CRYPTO_ECB
 	select CRYPTO_HMAC
-	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_XTS
 
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index d828e3df898b..011830f84d8d 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -61,30 +61,13 @@ struct fscrypt_nokey_name {
  */
 #define FSCRYPT_NOKEY_NAME_MAX	offsetofend(struct fscrypt_nokey_name, sha256)
 
-static struct crypto_shash *sha256_hash_tfm;
-
-static int fscrypt_do_sha256(const u8 *data, unsigned int data_len, u8 *result)
+static void fscrypt_do_sha256(const u8 *data, unsigned int data_len, u8 *result)
 {
-	struct crypto_shash *tfm = READ_ONCE(sha256_hash_tfm);
-
-	if (unlikely(!tfm)) {
-		struct crypto_shash *prev_tfm;
-
-		tfm = crypto_alloc_shash("sha256", 0, 0);
-		if (IS_ERR(tfm)) {
-			fscrypt_err(NULL,
-				    "Error allocating SHA-256 transform: %ld",
-				    PTR_ERR(tfm));
-			return PTR_ERR(tfm);
-		}
-		prev_tfm = cmpxchg(&sha256_hash_tfm, NULL, tfm);
-		if (prev_tfm) {
-			crypto_free_shash(tfm);
-			tfm = prev_tfm;
-		}
-	}
+	struct sha256_state sctx;
 
-	return crypto_shash_tfm_digest(tfm, data, data_len, result);
+	sha256_init(&sctx);
+	sha256_update(&sctx, data, data_len);
+	sha256_final(&sctx, result);
 }
 
 static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
@@ -349,7 +332,6 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 	const struct qstr qname = FSTR_TO_QSTR(iname);
 	struct fscrypt_nokey_name nokey_name;
 	u32 size; /* size of the unencoded no-key name */
-	int err;
 
 	if (fscrypt_is_dot_dotdot(&qname)) {
 		oname->name[0] = '.';
@@ -387,11 +369,9 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 	} else {
 		memcpy(nokey_name.bytes, iname->name, sizeof(nokey_name.bytes));
 		/* Compute strong hash of remaining part of name. */
-		err = fscrypt_do_sha256(&iname->name[sizeof(nokey_name.bytes)],
-					iname->len - sizeof(nokey_name.bytes),
-					nokey_name.sha256);
-		if (err)
-			return err;
+		fscrypt_do_sha256(&iname->name[sizeof(nokey_name.bytes)],
+				  iname->len - sizeof(nokey_name.bytes),
+				  nokey_name.sha256);
 		size = FSCRYPT_NOKEY_NAME_MAX;
 	}
 	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
@@ -530,9 +510,8 @@ bool fscrypt_match_name(const struct fscrypt_name *fname,
 		return false;
 	if (memcmp(de_name, nokey_name->bytes, sizeof(nokey_name->bytes)))
 		return false;
-	if (fscrypt_do_sha256(&de_name[sizeof(nokey_name->bytes)],
-			      de_name_len - sizeof(nokey_name->bytes), sha256))
-		return false;
+	fscrypt_do_sha256(&de_name[sizeof(nokey_name->bytes)],
+			  de_name_len - sizeof(nokey_name->bytes), sha256);
 	return !memcmp(sha256, nokey_name->sha256, sizeof(sha256));
 }
 EXPORT_SYMBOL_GPL(fscrypt_match_name);
-- 
2.27.0

