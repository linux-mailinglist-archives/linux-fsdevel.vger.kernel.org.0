Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4C79FE09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjINIO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbjINIOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:14:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC7CD8;
        Thu, 14 Sep 2023 01:14:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D28C433CD;
        Thu, 14 Sep 2023 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694679290;
        bh=RAiVZPublUwjcJuMfMGOxmIRZcVfSyOVrgtX9Ga/1do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLrzR7uF9eUw+cLDmeDe0Pz5r9agG/iG6ygBeNtKPqUZLSyUNgdx61ZhqBC6ZA2Su
         c457mPTQ0Txo/eXX9XmwxJy4TxemYt/rBg9xTEQuGDn6iogf9T+bppbvVvm3CCRoAU
         OlExjI5snUC7QM3KenicFSNZPT6s9chdabsBa5yQ4YFcEbtPwm4JRT7mvjb3sHdPnU
         TJFkdL5tnwgl+ImuKPf9Q1XFxTYunUkxpu/NgJUIFmYqwKP5ubOZIXZM8zrHeWMhTc
         A6amiVS7nGYfLYgm3OoLLuCnjLYare8aOb3lNoLVqi55LEqSK37/TTOVxzAU7RKxrl
         ObBpSngIyZA4g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 3/5] fscrypt: use s_maxbytes instead of filesystem lblk_bits
Date:   Thu, 14 Sep 2023 01:12:53 -0700
Message-ID: <20230914081255.193502-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914081255.193502-1-ebiggers@kernel.org>
References: <20230914081255.193502-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

For a given filesystem, the number of bits used by the maximum file
logical block number is computable from the maximum file size and block
size.  These values are always present in struct super_block.
Therefore, compute it this way instead of using the value from
fscrypt_operations::get_ino_and_lblk_bits.  Since filesystems always
have to set the super_block fields anyway, this avoids having to provide
this information redundantly via fscrypt_operations.

This change is in preparation for adding support for sub-block data
units.  For that, the value that is needed will become "the maximum file
data unit index".  A hardcoded value won't suffice for that; it will
need to be computed anyway.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h | 10 ++++++++++
 fs/crypto/inline_crypt.c    |  7 ++-----
 fs/crypto/policy.c          | 20 +++++++++++---------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 2d63da48635ab..4b113214b53af 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -296,6 +296,16 @@ union fscrypt_iv {
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 			 const struct fscrypt_info *ci);
 
+/*
+ * Return the number of bits used by the maximum file logical block number that
+ * is possible on the given filesystem.
+ */
+static inline int
+fscrypt_max_file_lblk_bits(const struct super_block *sb)
+{
+	return fls64(sb->s_maxbytes - 1) - sb->s_blocksize_bits;
+}
+
 /* fname.c */
 bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 				    u32 orig_len, u32 max_len,
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 8bfb3ce864766..7d9f6c167de58 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -41,9 +41,8 @@ static struct block_device **fscrypt_get_devices(struct super_block *sb,
 
 static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
 {
-	struct super_block *sb = ci->ci_inode->i_sb;
+	const struct super_block *sb = ci->ci_inode->i_sb;
 	unsigned int flags = fscrypt_policy_flags(&ci->ci_policy);
-	int ino_bits = 64, lblk_bits = 64;
 
 	if (flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
 		return offsetofend(union fscrypt_iv, nonce);
@@ -55,9 +54,7 @@ static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
 		return sizeof(__le32);
 
 	/* Default case: IVs are just the file logical block number */
-	if (sb->s_cop->get_ino_and_lblk_bits)
-		sb->s_cop->get_ino_and_lblk_bits(sb, &ino_bits, &lblk_bits);
-	return DIV_ROUND_UP(lblk_bits, 8);
+	return DIV_ROUND_UP(fscrypt_max_file_lblk_bits(sb), 8);
 }
 
 /*
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index f4456ecb3f877..36bffc4d6228d 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -119,8 +119,7 @@ static bool supported_direct_key_modes(const struct inode *inode,
 
 static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
 					 const struct inode *inode,
-					 const char *type,
-					 int max_ino_bits, int max_lblk_bits)
+					 const char *type, int max_ino_bits)
 {
 	struct super_block *sb = inode->i_sb;
 	int ino_bits = 64, lblk_bits = 64;
@@ -154,13 +153,18 @@ static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
 		sb->s_cop->get_ino_and_lblk_bits(sb, &ino_bits, &lblk_bits);
 	if (ino_bits > max_ino_bits) {
 		fscrypt_warn(inode,
-			     "Can't use %s policy on filesystem '%s' because its inode numbers are too long",
+			     "Can't use %s policy on filesystem '%s' because its maximum inode number is too large",
 			     type, sb->s_id);
 		return false;
 	}
-	if (lblk_bits > max_lblk_bits) {
+
+	/*
+	 * IV_INO_LBLK_64 and IV_INO_LBLK_32 both require that file logical
+	 * block numbers fit in 32 bits.
+	 */
+	if (fscrypt_max_file_lblk_bits(sb) > 32) {
 		fscrypt_warn(inode,
-			     "Can't use %s policy on filesystem '%s' because its block numbers are too long",
+			     "Can't use %s policy on filesystem '%s' because its maximum file size is too large",
 			     type, sb->s_id);
 		return false;
 	}
@@ -239,8 +243,7 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 		return false;
 
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) &&
-	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_64",
-					  32, 32))
+	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_64", 32))
 		return false;
 
 	/*
@@ -250,8 +253,7 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 	 * implementation limit is 32 bits.
 	 */
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) &&
-	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_32",
-					  32, 32))
+	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_32", 32))
 		return false;
 
 	if (memchr_inv(policy->__reserved, 0, sizeof(policy->__reserved))) {
-- 
2.42.0

