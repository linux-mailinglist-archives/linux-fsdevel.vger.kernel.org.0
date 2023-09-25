Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118ED7ACFC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 07:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjIYF7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 01:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjIYF7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:59:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92B483;
        Sun, 24 Sep 2023 22:59:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909E4C43391;
        Mon, 25 Sep 2023 05:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695621539;
        bh=P4XXzfXmBd2ZsU81W5VRDXuURTQb5JAgKi2e49GGlH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BA5zj75utpgqUp5t0l/PAjwByEhX1yoswdZgONErPl+WfsKGA+WMIZ1Lkq4yCjs72
         /erzRHh+70uUjTKOzm4qjHYfne2LiqjnYWDF4C8nJieKGku/xmMHi8fw6sRdmszy/L
         xKJFhdqgTJcd0zkTtPhUDF0h8jB+GDk8S2lCDMzYDv5cpSwj+RZ/Pgxp4DikhgPph0
         ZZ40osh6OpC9JB7unRffK2lWtwhAR6OkwAXfYkcBRJP8WxKUu00b4jp0Fy8UXPePhI
         KNoX+FTnMlNmAc5rqD5PA8ZzrxRi7OQBIbPw8WIMDod7NoeiexV7k9+c4DleDN4t6/
         6IwoePTcxGMkg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3 4/5] fscrypt: replace get_ino_and_lblk_bits with just has_32bit_inodes
Date:   Sun, 24 Sep 2023 22:54:50 -0700
Message-ID: <20230925055451.59499-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925055451.59499-1-ebiggers@kernel.org>
References: <20230925055451.59499-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 7b34949e49de6..32709dad9762b 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -111,25 +111,25 @@ static bool supported_direct_key_modes(const struct inode *inode,
 
 	if (mode->ivsize < offsetofend(union fscrypt_iv, nonce)) {
 		fscrypt_warn(inode, "Direct key flag not allowed with %s",
 			     mode->friendly_name);
 		return false;
 	}
 	return true;
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
 	 * currently the only known use case for them involves AES-256-XTS.
 	 * That's also all we test currently.  For these reasons, for now only
 	 * allow AES-256-XTS here.  This can be relaxed later if a use case for
 	 * IV_INO_LBLK_* with other encryption modes arises.
 	 */
 	if (policy->contents_encryption_mode != FSCRYPT_MODE_AES_256_XTS) {
 		fscrypt_warn(inode,
@@ -142,23 +142,29 @@ static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
 	 * It's unsafe to include inode numbers in the IVs if the filesystem can
 	 * potentially renumber inodes, e.g. via filesystem shrinking.
 	 */
 	if (!sb->s_cop->has_stable_inodes ||
 	    !sb->s_cop->has_stable_inodes(sb)) {
 		fscrypt_warn(inode,
 			     "Can't use %s policy on filesystem '%s' because it doesn't have stable inode numbers",
 			     type, sb->s_id);
 		return false;
 	}
-	if (sb->s_cop->get_ino_and_lblk_bits)
-		sb->s_cop->get_ino_and_lblk_bits(sb, &ino_bits, &lblk_bits);
-	if (ino_bits > max_ino_bits) {
+
+	/*
+	 * IV_INO_LBLK_64 and IV_INO_LBLK_32 both require that inode numbers fit
+	 * in 32 bits.  In principle, IV_INO_LBLK_32 could support longer inode
+	 * numbers because it hashes the inode number; however, currently the
+	 * inode number is gotten from inode::i_ino which is 'unsigned long'.
+	 * So for now the implementation limit is 32 bits.
+	 */
+	if (!sb->s_cop->has_32bit_inodes) {
 		fscrypt_warn(inode,
 			     "Can't use %s policy on filesystem '%s' because its inode numbers are too long",
 			     type, sb->s_id);
 		return false;
 	}
 
 	/*
 	 * IV_INO_LBLK_64 and IV_INO_LBLK_32 both require that file logical
 	 * block numbers fit in 32 bits.
 	 */
@@ -235,32 +241,23 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 		fscrypt_warn(inode, "Mutually exclusive encryption flags (0x%02x)",
 			     policy->flags);
 		return false;
 	}
 
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) &&
 	    !supported_direct_key_modes(inode, policy->contents_encryption_mode,
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
 		fscrypt_warn(inode, "Reserved bits set in encryption policy");
 		return false;
 	}
 
 	return true;
 }
 
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 5cd7bcfae46b2..9e36731701baa 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -225,27 +225,20 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 static const union fscrypt_policy *ext4_get_dummy_policy(struct super_block *sb)
 {
 	return EXT4_SB(sb)->s_dummy_enc_policy.policy;
 }
 
 static bool ext4_has_stable_inodes(struct super_block *sb)
 {
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
 	.legacy_key_prefix	= "ext4:",
 	.get_context		= ext4_get_context,
 	.set_context		= ext4_set_context,
 	.get_dummy_policy	= ext4_get_dummy_policy,
 	.empty_dir		= ext4_empty_dir,
 	.has_stable_inodes	= ext4_has_stable_inodes,
-	.get_ino_and_lblk_bits	= ext4_get_ino_and_lblk_bits,
 };
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 55aa0ed531f22..c449157132643 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3196,27 +3196,20 @@ static int f2fs_set_context(struct inode *inode, const void *ctx, size_t len,
 static const union fscrypt_policy *f2fs_get_dummy_policy(struct super_block *sb)
 {
 	return F2FS_OPTION(F2FS_SB(sb)).dummy_enc_policy.policy;
 }
 
 static bool f2fs_has_stable_inodes(struct super_block *sb)
 {
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
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct block_device **devs;
 	int i;
 
 	if (!f2fs_is_multi_device(sbi))
 		return NULL;
 
@@ -3225,27 +3218,27 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < sbi->s_ndevs; i++)
 		devs[i] = FDEV(i).bdev;
 	*num_devs = sbi->s_ndevs;
 	return devs;
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
 	.needs_bounce_pages	= 1,
+	.has_32bit_inodes	= 1,
 	.legacy_key_prefix	= "f2fs:",
 	.get_context		= f2fs_get_context,
 	.set_context		= f2fs_set_context,
 	.get_dummy_policy	= f2fs_get_dummy_policy,
 	.empty_dir		= f2fs_empty_dir,
 	.has_stable_inodes	= f2fs_has_stable_inodes,
-	.get_ino_and_lblk_bits	= f2fs_get_ino_and_lblk_bits,
 	.get_devices		= f2fs_get_devices,
 };
 #endif
 
 static struct inode *f2fs_nfs_get_inode(struct super_block *sb,
 		u64 ino, u32 generation)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct inode *inode;
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 4505078e89b7e..09a3cacbf62ad 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -67,20 +67,31 @@ struct fscrypt_operations {
 	 * first time an encryption key is set up for a file.  The bounce page
 	 * pool is required by the following functions:
 	 *
 	 * - fscrypt_encrypt_pagecache_blocks()
 	 * - fscrypt_zeroout_range() for files not using inline crypto
 	 *
 	 * If the filesystem doesn't use those, it doesn't need to set this.
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
 	 * contains the filesystem-specific key description prefix that is
 	 * accepted for "logon" keys for v1 fscrypt policies.  This
 	 * functionality is deprecated in favor of the generic prefix
 	 * "fscrypt:", which itself is deprecated in favor of the filesystem
 	 * keyring ioctls such as FS_IOC_ADD_ENCRYPTION_KEY.  Filesystems that
 	 * are newly adding fscrypt support should not set this field.
 	 */
@@ -144,35 +155,20 @@ struct fscrypt_operations {
 	 * Filesystems only need to implement this function if they want to
 	 * support the FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{32,64} flags.  These
 	 * flags are designed to work around the limitations of UFS and eMMC
 	 * inline crypto hardware, and they shouldn't be used in scenarios where
 	 * such hardware isn't being used.
 	 *
 	 * Leaving this NULL is equivalent to always returning false.
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
 	 * only has a single such block device, or an ERR_PTR() on error.
 	 *
 	 * On successful non-NULL return, *num_devs is set to the number of
 	 * devices in the returned array.  The caller must free the returned
 	 * array using kfree().
 	 *
 	 * If the filesystem can use multiple block devices (other than block
-- 
2.42.0

