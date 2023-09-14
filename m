Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7579FE10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 10:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjINIPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 04:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbjINIOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:14:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796391BE6;
        Thu, 14 Sep 2023 01:14:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B6CC433CC;
        Thu, 14 Sep 2023 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694679291;
        bh=8faNDw+GOJRWczEDSbzCDhk91ZpNbMMHeLKRuECXN2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unbAEKy1HMONJfoSVoOu4s0IXItaJZMM8cuDgvR5xyP7EQUooffUXLYkpEMYcu5Xd
         IMP5btd0WRcI1BiYirRlOwrmXQjArMiF5xydT4kXP8satBrLVqbcJ0P+TAnUeY/94S
         kKHJV9lTPskWdL04NAW8zNfUxHD8BF8HEjzjnkU6QoYxAMtsbQBTMVYevaipeWcRja
         Wywr30LsGI1tUcXk/E5E28GgpNrhtCrX0a6HU+vHiVNJhUAA+RWYZv7o7ALCOGX+Sh
         LQTMm4IA3+ofWV4Uybom0h0xMinJ7f7B9RNgKX9phjPKqYSEKXK/c8BFr8uZOT9Nkh
         k6hJNfCkA5wCg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 4/5] fscrypt: replace get_ino_and_lblk_bits with just has_32bit_inodes
Date:   Thu, 14 Sep 2023 01:12:54 -0700
Message-ID: <20230914081255.193502-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914081255.193502-1-ebiggers@kernel.org>
References: <20230914081255.193502-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that fs/crypto/ computes the filesystem's lblk_bits from its maximum
file size, it is no longer necessary for filesystems to provide
lblk_bits via fscrypt_operations::get_ino_and_lblk_bits.

It is still necessary for fs/crypto/ to retrieve ino_bits from the
filesystem.  However, this is used only to decide whether inode numbers
fit in 32 bits.  Also, ino_bits is static for all relevant filesystems,
i.e. it doesn't depend on the filesystem instance.

Therefore, in the interest of keeping things as simple as possible,
replace 'get_ino_and_lblk_bits' with a flag 'has_32bit_inodes'.  This
can always be changed back to a function if a filesystem needs it to be
dynamic, but for now a static flag is all that's needed.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/policy.c      | 33 +++++++++++++++------------------
 fs/ext4/crypto.c        |  9 +--------
 fs/f2fs/super.c         |  9 +--------
 include/linux/fscrypt.h | 26 +++++++++++---------------
 4 files changed, 28 insertions(+), 49 deletions(-)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 36bffc4d6228d..c8072a634af8f 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -118,11 +118,11 @@ static bool supported_direct_key_modes(const struct inode *inode,
 }
 
 static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
-					 const struct inode *inode,
-					 const char *type, int max_ino_bits)
+					 const struct inode *inode)
 {
+	const char *type = (policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64)
+				? "IV_INO_LBLK_64" : "IV_INO_LBLK_32";
 	struct super_block *sb = inode->i_sb;
-	int ino_bits = 64, lblk_bits = 64;
 
 	/*
 	 * IV_INO_LBLK_* exist only because of hardware limitations, and
@@ -149,9 +149,15 @@ static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
 			     type, sb->s_id);
 		return false;
 	}
-	if (sb->s_cop->get_ino_and_lblk_bits)
-		sb->s_cop->get_ino_and_lblk_bits(sb, &ino_bits, &lblk_bits);
-	if (ino_bits > max_ino_bits) {
+
+	/*
+	 * IV_INO_LBLK_64 requires that inode numbers fit in 32 bits.
+	 * IV_INO_LBLK_32 hashes the inode number, so in principle it can
+	 * support any length; however, currently the inode number is gotten
+	 * from inode::i_ino which is 'unsigned long'.  So for now the
+	 * implementation limit is 32 bits, the same as IV_INO_LBLK_64.
+	 */
+	if (!sb->s_cop->has_32bit_inodes) {
 		fscrypt_warn(inode,
 			     "Can't use %s policy on filesystem '%s' because its maximum inode number is too large",
 			     type, sb->s_id);
@@ -242,18 +248,9 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 					policy->filenames_encryption_mode))
 		return false;
 
-	if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) &&
-	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_64", 32))
-		return false;
-
-	/*
-	 * IV_INO_LBLK_32 hashes the inode number, so in principle it can
-	 * support any ino_bits.  However, currently the inode number is gotten
-	 * from inode::i_ino which is 'unsigned long'.  So for now the
-	 * implementation limit is 32 bits.
-	 */
-	if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) &&
-	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_32", 32))
+	if ((policy->flags & (FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64 |
+			      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32)) &&
+	    !supported_iv_ino_lblk_policy(policy, inode))
 		return false;
 
 	if (memchr_inv(policy->__reserved, 0, sizeof(policy->__reserved))) {
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index a9221be67f2a7..2859d9569aa74 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -232,20 +232,13 @@ static bool ext4_has_stable_inodes(struct super_block *sb)
 	return ext4_has_feature_stable_inodes(sb);
 }
 
-static void ext4_get_ino_and_lblk_bits(struct super_block *sb,
-				       int *ino_bits_ret, int *lblk_bits_ret)
-{
-	*ino_bits_ret = 8 * sizeof(EXT4_SB(sb)->s_es->s_inodes_count);
-	*lblk_bits_ret = 8 * sizeof(ext4_lblk_t);
-}
-
 const struct fscrypt_operations ext4_cryptops = {
 	.needs_bounce_pages	= 1,
+	.has_32bit_inodes	= 1,
 	.legacy_key_prefix_for_backcompat = "ext4:",
 	.get_context		= ext4_get_context,
 	.set_context		= ext4_set_context,
 	.get_dummy_policy	= ext4_get_dummy_policy,
 	.empty_dir		= ext4_empty_dir,
 	.has_stable_inodes	= ext4_has_stable_inodes,
-	.get_ino_and_lblk_bits	= ext4_get_ino_and_lblk_bits,
 };
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 276535af5bf3c..7e8e510ef77af 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3203,13 +3203,6 @@ static bool f2fs_has_stable_inodes(struct super_block *sb)
 	return true;
 }
 
-static void f2fs_get_ino_and_lblk_bits(struct super_block *sb,
-				       int *ino_bits_ret, int *lblk_bits_ret)
-{
-	*ino_bits_ret = 8 * sizeof(nid_t);
-	*lblk_bits_ret = 8 * sizeof(block_t);
-}
-
 static struct block_device **f2fs_get_devices(struct super_block *sb,
 					      unsigned int *num_devs)
 {
@@ -3232,13 +3225,13 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 
 static const struct fscrypt_operations f2fs_cryptops = {
 	.needs_bounce_pages	= 1,
+	.has_32bit_inodes	= 1,
 	.legacy_key_prefix_for_backcompat = "f2fs:",
 	.get_context		= f2fs_get_context,
 	.set_context		= f2fs_set_context,
 	.get_dummy_policy	= f2fs_get_dummy_policy,
 	.empty_dir		= f2fs_empty_dir,
 	.has_stable_inodes	= f2fs_has_stable_inodes,
-	.get_ino_and_lblk_bits	= f2fs_get_ino_and_lblk_bits,
 	.get_devices		= f2fs_get_devices,
 };
 #endif
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 32290e5fa9abb..32a3b59bea276 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -73,6 +73,17 @@ struct fscrypt_operations {
 	 */
 	unsigned int needs_bounce_pages : 1;
 
+	/*
+	 * If set, then fs/crypto/ will allow the use of encryption settings
+	 * that assume inode numbers fit in 32 bits (i.e.
+	 * FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{32,64}), provided that the other
+	 * prerequisites for these settings are also met.  This is only useful
+	 * if the filesystem wants to support inline encryption hardware that is
+	 * limited to 32-bit or 64-bit data unit numbers and where programming
+	 * keyslots is very slow.
+	 */
+	unsigned int has_32bit_inodes : 1;
+
 	/*
 	 * This field exists only for backwards compatibility reasons and should
 	 * only be set by the filesystems that are setting it already.  It
@@ -150,21 +161,6 @@ struct fscrypt_operations {
 	 */
 	bool (*has_stable_inodes)(struct super_block *sb);
 
-	/*
-	 * Get the number of bits that the filesystem uses to represent inode
-	 * numbers and file logical block numbers.
-	 *
-	 * By default, both of these are assumed to be 64-bit.  This function
-	 * can be implemented to declare that either or both of these numbers is
-	 * shorter, which may allow the use of the
-	 * FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{32,64} flags and/or the use of
-	 * inline crypto hardware whose maximum DUN length is less than 64 bits
-	 * (e.g., eMMC v5.2 spec compliant hardware).  This function only needs
-	 * to be implemented if support for one of these features is needed.
-	 */
-	void (*get_ino_and_lblk_bits)(struct super_block *sb,
-				      int *ino_bits_ret, int *lblk_bits_ret);
-
 	/*
 	 * Return an array of pointers to the block devices to which the
 	 * filesystem may write encrypted file contents, NULL if the filesystem
-- 
2.42.0

