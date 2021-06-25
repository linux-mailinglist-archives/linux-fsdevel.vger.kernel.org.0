Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F373B44F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhFYOBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 10:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:32956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231501AbhFYOA6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:00:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8564961973;
        Fri, 25 Jun 2021 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624629518;
        bh=mSG1QVt+EH7WelVVxV/wENNIVCMwFz8jZSehCgSPyeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lslq3PUfP5MT7Si22a2HSYVU6YD/jeYzpBImZksotsSnfePGhBNvc87vvqH10lane
         KyEvHVYhxn2hRWNg6h1ugzQ8RG00c+s9k86PgOZeNOLYnCF2K2frr7LuMApi1S0SNu
         PL3WQFQYVxNvJp/nWcrQWT62zgJr5OrL9HkHJH5emphMOpklgJr7ewG+HErYaUg4mq
         WSlIJAnAolRFVw3BtMfOIgE9WQd2sCmKraljWwFHwooGTJyz1t3SDnr56gK/pKEUZW
         ZLetDh6qW0fdFytNs7/+FK7Z9km6SZUeo/j66ryAIfFX6ikR4GGX8wmWTqTpvlCdsR
         29foj8ysIxnXw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: [RFC PATCH v7 03/24] fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
Date:   Fri, 25 Jun 2021 09:58:13 -0400
Message-Id: <20210625135834.12934-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625135834.12934-1-jlayton@kernel.org>
References: <20210625135834.12934-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For ceph, we want to use our own scheme for handling filenames that are
are longer than NAME_MAX after encryption and base64 encoding. This
allows us to have a consistent view of the encrypted filenames for
clients that don't support fscrypt and clients that do but that don't
have the key.

Currently, fs/crypto only supports encrypting filenames using
fscrypt_setup_filename, but that also handles encoding nokey names. Ceph
can't use that because it handles nokey names in a different way.

Export fscrypt_fname_encrypt. Rename fscrypt_fname_encrypted_size to
__fscrypt_fname_encrypted_size and add a new wrapper called
fscrypt_fname_encrypted_size that takes an inode argument rather than a
pointer to a fscrypt_policy union.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/fname.c           | 19 ++++++++++++++-----
 fs/crypto/fscrypt_private.h |  9 +++------
 fs/crypto/hooks.c           |  6 +++---
 include/linux/fscrypt.h     |  4 ++++
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 32b1f50433ba..5a794de7f61d 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -126,6 +126,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 
 	return 0;
 }
+EXPORT_SYMBOL(fscrypt_fname_encrypt);
 
 /**
  * fname_decrypt() - decrypt a filename
@@ -244,9 +245,9 @@ int fscrypt_base64_decode(const char *src, int len, u8 *dst)
 }
 EXPORT_SYMBOL(fscrypt_base64_decode);
 
-bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
-				  u32 orig_len, u32 max_len,
-				  u32 *encrypted_len_ret)
+bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
+				    u32 orig_len, u32 max_len,
+				    u32 *encrypted_len_ret)
 {
 	int padding = 4 << (fscrypt_policy_flags(policy) &
 			    FSCRYPT_POLICY_FLAGS_PAD_MASK);
@@ -260,6 +261,15 @@ bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 	return true;
 }
 
+bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
+				  u32 max_len, u32 *encrypted_len_ret)
+{
+	return __fscrypt_fname_encrypted_size(&inode->i_crypt_info->ci_policy,
+					      orig_len, max_len,
+					      encrypted_len_ret);
+}
+EXPORT_SYMBOL(fscrypt_fname_encrypted_size);
+
 /**
  * fscrypt_fname_alloc_buffer() - allocate a buffer for presented filenames
  * @max_encrypted_len: maximum length of encrypted filenames the buffer will be
@@ -422,8 +432,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 		return ret;
 
 	if (fscrypt_has_encryption_key(dir)) {
-		if (!fscrypt_fname_encrypted_size(&dir->i_crypt_info->ci_policy,
-						  iname->len,
+		if (!fscrypt_fname_encrypted_size(dir, iname->len,
 						  dir->i_sb->s_cop->max_namelen,
 						  &fname->crypto_buf.len))
 			return -ENAMETOOLONG;
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 3fa965eb3336..195de6d0db40 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -292,14 +292,11 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 			 const struct fscrypt_info *ci);
 
 /* fname.c */
-int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
-			  u8 *out, unsigned int olen);
-bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
-				  u32 orig_len, u32 max_len,
-				  u32 *encrypted_len_ret);
+bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
+				    u32 orig_len, u32 max_len,
+                                    u32 *encrypted_len_ret);
 
 /* hkdf.c */
-
 struct fscrypt_hkdf {
 	struct crypto_shash *hmac_tfm;
 };
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index a73b0376e6f3..e65c19aae041 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -228,9 +228,9 @@ int fscrypt_prepare_symlink(struct inode *dir, const char *target,
 	 * counting it (even though it is meaningless for ciphertext) is simpler
 	 * for now since filesystems will assume it is there and subtract it.
 	 */
-	if (!fscrypt_fname_encrypted_size(policy, len,
-					  max_len - sizeof(struct fscrypt_symlink_data),
-					  &disk_link->len))
+	if (!__fscrypt_fname_encrypted_size(policy, len,
+					    max_len - sizeof(struct fscrypt_symlink_data),
+					    &disk_link->len))
 		return -ENAMETOOLONG;
 	disk_link->len += sizeof(struct fscrypt_symlink_data);
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index e300f6145ddc..b5c31baaa8bf 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -212,6 +212,10 @@ int fscrypt_drop_inode(struct inode *inode);
 /* fname.c */
 int fscrypt_base64_encode(const u8 *src, int len, char *dst);
 int fscrypt_base64_decode(const char *src, int len, u8 *dst);
+bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
+				  u32 max_len, u32 *encrypted_len_ret);
+int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
+			  u8 *out, unsigned int olen);
 int fscrypt_setup_filename(struct inode *inode, const struct qstr *iname,
 			   int lookup, struct fscrypt_name *fname);
 
-- 
2.31.1

