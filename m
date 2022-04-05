Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347A14F4D03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383163AbiDEXhZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573558AbiDETWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:22:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87644091B;
        Tue,  5 Apr 2022 12:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 123EACE1FB7;
        Tue,  5 Apr 2022 19:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C385AC385A5;
        Tue,  5 Apr 2022 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186441;
        bh=VavI1xtUqjkJNyDAit+vwUdU1iO1gYw4vnwxHnE4eZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F02a4y98R/WYeJZOnGcn1AJn7z5GbL1pSyDrlpN2Ut7UTvTP0SiWeqP97gKYizkFq
         +qUwBrNobxeg/XX4c8ccrrXr2R+3AtwFDmKZfNgW8xAktn9HPGBtfOwx4nhKWcTtFx
         +nx/1zZ5gpudtUCWEKpdARBi8ASsoQjDbak0arHoYHDKd2jjOL/cz1luz6vyCYq9cr
         e1cox2Nl1Sd8IkjulzRYRwTO8yrbk3mM5X0402aJklwBuuiHb1yQ0eOmB+zkp93tiD
         A30F01ofcAiJsTRGONWR/e1G6zNqWGmlzILQsqcXyVDBi6hqRke6+P5lah8DON0iVK
         hXHYHmGRMSUfA==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de, Eric Biggers <ebiggers@google.com>
Subject: [PATCH v13 10/59] fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
Date:   Tue,  5 Apr 2022 15:19:41 -0400
Message-Id: <20220405192030.178326-11-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For ceph, we want to use our own scheme for handling filenames that are
are longer than NAME_MAX after encryption and Base64 encoding. This
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

Acked-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/fname.c           | 36 ++++++++++++++++++++++++++++++------
 fs/crypto/fscrypt_private.h |  9 +++------
 fs/crypto/hooks.c           |  6 +++---
 include/linux/fscrypt.h     |  4 ++++
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 1e4233c95005..77d38188a168 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -79,7 +79,8 @@ static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
 /**
  * fscrypt_fname_encrypt() - encrypt a filename
  * @inode: inode of the parent directory (for regular filenames)
- *	   or of the symlink (for symlink targets)
+ *	   or of the symlink (for symlink targets). Key must already be
+ *	   set up.
  * @iname: the filename to encrypt
  * @out: (output) the encrypted filename
  * @olen: size of the encrypted filename.  It must be at least @iname->len.
@@ -130,6 +131,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(fscrypt_fname_encrypt);
 
 /**
  * fname_decrypt() - decrypt a filename
@@ -257,9 +259,9 @@ int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
 }
 EXPORT_SYMBOL_GPL(fscrypt_base64url_decode);
 
-bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
-				  u32 orig_len, u32 max_len,
-				  u32 *encrypted_len_ret)
+bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
+				    u32 orig_len, u32 max_len,
+				    u32 *encrypted_len_ret)
 {
 	int padding = 4 << (fscrypt_policy_flags(policy) &
 			    FSCRYPT_POLICY_FLAGS_PAD_MASK);
@@ -273,6 +275,29 @@ bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 	return true;
 }
 
+/**
+ * fscrypt_fname_encrypted_size() - calculate length of encrypted filename
+ * @inode:		parent inode of dentry name being encrypted. Key must
+ *			already be set up.
+ * @orig_len:		length of the original filename
+ * @max_len:		maximum length to return
+ * @encrypted_len_ret:	where calculated length should be returned (on success)
+ *
+ * Filenames that are shorter than the maximum length may have their lengths
+ * increased slightly by encryption, due to padding that is applied.
+ *
+ * Return: false if the orig_len is greater than max_len. Otherwise, true and
+ *	   fill out encrypted_len_ret with the length (up to max_len).
+ */
+bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
+				  u32 max_len, u32 *encrypted_len_ret)
+{
+	return __fscrypt_fname_encrypted_size(&inode->i_crypt_info->ci_policy,
+					      orig_len, max_len,
+					      encrypted_len_ret);
+}
+EXPORT_SYMBOL_GPL(fscrypt_fname_encrypted_size);
+
 /**
  * fscrypt_fname_alloc_buffer() - allocate a buffer for presented filenames
  * @max_encrypted_len: maximum length of encrypted filenames the buffer will be
@@ -428,8 +453,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 		return ret;
 
 	if (fscrypt_has_encryption_key(dir)) {
-		if (!fscrypt_fname_encrypted_size(&dir->i_crypt_info->ci_policy,
-						  iname->len, NAME_MAX,
+		if (!fscrypt_fname_encrypted_size(dir, iname->len, NAME_MAX,
 						  &fname->crypto_buf.len))
 			return -ENAMETOOLONG;
 		fname->crypto_buf.name = kmalloc(fname->crypto_buf.len,
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 5b0a9e6478b5..f3e6e566daff 100644
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
+				    u32 *encrypted_len_ret);
 
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
index 629ccd09e095..84b363665162 100644
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
2.35.1

