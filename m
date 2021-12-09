Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE8E46EB80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbhLIPka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbhLIPk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8602C061746;
        Thu,  9 Dec 2021 07:36:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E07DCE267B;
        Thu,  9 Dec 2021 15:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8BEC341C3;
        Thu,  9 Dec 2021 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064211;
        bh=ksNkDk9t/OgjIxqMxnE6r5FX+UARNlCcyMijyI05TK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSjIe7PIwkpaBKYC6OgejD3FuRquI7Kd1daxKT37c7N5R8AzDNC6oO4lozmJJSJxS
         ENn2mWDOvFINJZ3IU88UzNBDrD8syiNveXSmGBkbHOoHRNA1ql9+V7WJLk4ziLZntX
         nsoGml2/WGbzCi4CFp2qTa1o1qUOIbOrRVDuEVfTwbu1+FVL/OFCklrYPLl0gMt85t
         otNXuPrYNHHg2r+Xj0dQJNsJv6D+glX0QITPYankfYdIpyCZHinXmKRmzdjS+2BJn8
         Rm2XNv6nlGjJCRos2TNMLZa4d6zji/qpHJ4UGDxtWdseqA1hNQtRA0XC/8/Q/UoSP6
         KuVS9X4JigBqQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/36] fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
Date:   Thu,  9 Dec 2021 10:36:14 -0500
Message-Id: <20211209153647.58953-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
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
 fs/crypto/fname.c           | 32 +++++++++++++++++++++++++++-----
 fs/crypto/fscrypt_private.h |  9 +++------
 fs/crypto/hooks.c           |  6 +++---
 include/linux/fscrypt.h     |  4 ++++
 4 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 8fa23d525b5c..3be04b5aa570 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -130,6 +130,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 
 	return 0;
 }
+EXPORT_SYMBOL(fscrypt_fname_encrypt);
 
 /**
  * fname_decrypt() - decrypt a filename
@@ -257,9 +258,9 @@ int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
 }
 EXPORT_SYMBOL(fscrypt_base64url_decode);
 
-bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
-				  u32 orig_len, u32 max_len,
-				  u32 *encrypted_len_ret)
+bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
+				    u32 orig_len, u32 max_len,
+				    u32 *encrypted_len_ret)
 {
 	int padding = 4 << (fscrypt_policy_flags(policy) &
 			    FSCRYPT_POLICY_FLAGS_PAD_MASK);
@@ -273,6 +274,28 @@ bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 	return true;
 }
 
+/**
+ * fscrypt_fname_encrypted_size() - calculate length of encrypted filename
+ * @inode: 		parent inode of dentry name being encrypted
+ * @orig_len:		length of the original filename
+ * @max_len:		maximum length to return
+ * @encrypted_len_ret:	where calculated length should be returned (on success)
+ *
+ * Filenames must be padded out to at least the end of an fscrypt block before
+ * encrypting them. This calculates the length of an encrypted filename.
+ *
+ * Return: false if the orig_len is shorter than max_len. Otherwise, true and
+ * 	   fill out encrypted_len_ret with the length (up to max_len).
+ */
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
@@ -428,8 +451,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 		return ret;
 
 	if (fscrypt_has_encryption_key(dir)) {
-		if (!fscrypt_fname_encrypted_size(&dir->i_crypt_info->ci_policy,
-						  iname->len, NAME_MAX,
+		if (!fscrypt_fname_encrypted_size(dir, iname->len, NAME_MAX,
 						  &fname->crypto_buf.len))
 			return -ENAMETOOLONG;
 		fname->crypto_buf.name = kmalloc(fname->crypto_buf.len,
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 5b0a9e6478b5..51e42767dbd6 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -297,14 +297,11 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
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
index af74599ae1cf..7c01025879b3 100644
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
index 671181d196a8..c90e176b5843 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -308,8 +308,12 @@ void fscrypt_free_inode(struct inode *inode);
 int fscrypt_drop_inode(struct inode *inode);
 
 /* fname.c */
+int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
+			  u8 *out, unsigned int olen);
 int fscrypt_base64url_encode(const u8 *src, int len, char *dst);
 int fscrypt_base64url_decode(const char *src, int len, u8 *dst);
+bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
+				  u32 max_len, u32 *encrypted_len_ret);
 int fscrypt_setup_filename(struct inode *inode, const struct qstr *iname,
 			   int lookup, struct fscrypt_name *fname);
 
-- 
2.33.1

