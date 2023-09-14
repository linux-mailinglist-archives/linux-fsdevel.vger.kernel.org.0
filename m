Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7479FE06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 10:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjINIOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 04:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjINIOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:14:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CC3CD8;
        Thu, 14 Sep 2023 01:14:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88CEC433CA;
        Thu, 14 Sep 2023 08:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694679290;
        bh=mYxCTQ86ndfR+rG1ZcbI1ZmUOxowNicifI01Yc/k8I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LV7fZB0rZqk2cvNIBfNYL2D33oreK0M1zQ1KB8VRklLb8/KFbhnpTkpesrBb/wD5l
         7sUG+9PCGS8EUpen1ZDr8ChULNm2ucgrYD5vXclqazioUfLOVB3vrxaZJ1xkJGOx8e
         gmz1U/gegdppvfSVLPb/dmRZYsU8VTUDcnGgchOhSgVbdjvx9as0+EanPwd+nRhRyd
         SiM83ZWhTex1PD/YlhzByi2wLq+6HzBEkfW51I4DJAu3Vu1FdmocCcUZ4Xec6Jpg3j
         c2cQuygHevgwYOQpSL3dPp7JAWg2eHNgimNJwHeW8XF6LtzZg/e9cZdG+NMfJWRExA
         QoRocWk+jmrfA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 1/5] fscrypt: make it extra clear that key_prefix is deprecated
Date:   Thu, 14 Sep 2023 01:12:51 -0700
Message-ID: <20230914081255.193502-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914081255.193502-1-ebiggers@kernel.org>
References: <20230914081255.193502-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

fscrypt_operations::key_prefix should not be set by any filesystems that
aren't setting it already.  This is already documented, but apparently
it's not sufficiently clear, as both ceph and btrfs have tried to set
it.  Rename the field to 'legacy_key_prefix_for_backcompat' and improve
the documentation to hopefully make it clearer.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keysetup_v1.c |  5 +++--
 fs/ext4/crypto.c        |  2 +-
 fs/f2fs/super.c         |  2 +-
 fs/ubifs/crypto.c       |  2 +-
 include/linux/fscrypt.h | 14 +++++++++-----
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 75dabd9b27f9b..df44d0d2d44ea 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -299,6 +299,7 @@ int fscrypt_setup_v1_file_key(struct fscrypt_info *ci, const u8 *raw_master_key)
 
 int fscrypt_setup_v1_file_key_via_subscribed_keyrings(struct fscrypt_info *ci)
 {
+	const struct super_block *sb = ci->ci_inode->i_sb;
 	struct key *key;
 	const struct fscrypt_key *payload;
 	int err;
@@ -306,8 +307,8 @@ int fscrypt_setup_v1_file_key_via_subscribed_keyrings(struct fscrypt_info *ci)
 	key = find_and_lock_process_key(FSCRYPT_KEY_DESC_PREFIX,
 					ci->ci_policy.v1.master_key_descriptor,
 					ci->ci_mode->keysize, &payload);
-	if (key == ERR_PTR(-ENOKEY) && ci->ci_inode->i_sb->s_cop->key_prefix) {
-		key = find_and_lock_process_key(ci->ci_inode->i_sb->s_cop->key_prefix,
+	if (key == ERR_PTR(-ENOKEY) && sb->s_cop->legacy_key_prefix_for_backcompat) {
+		key = find_and_lock_process_key(sb->s_cop->legacy_key_prefix_for_backcompat,
 						ci->ci_policy.v1.master_key_descriptor,
 						ci->ci_mode->keysize, &payload);
 	}
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 453d4da5de520..8cdb7bbc655b0 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -240,7 +240,7 @@ static void ext4_get_ino_and_lblk_bits(struct super_block *sb,
 }
 
 const struct fscrypt_operations ext4_cryptops = {
-	.key_prefix		= "ext4:",
+	.legacy_key_prefix_for_backcompat = "ext4:",
 	.get_context		= ext4_get_context,
 	.set_context		= ext4_set_context,
 	.get_dummy_policy	= ext4_get_dummy_policy,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a8c8232852bb1..8de799a8bad04 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3231,7 +3231,7 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
-	.key_prefix		= "f2fs:",
+	.legacy_key_prefix_for_backcompat = "f2fs:",
 	.get_context		= f2fs_get_context,
 	.set_context		= f2fs_set_context,
 	.get_dummy_policy	= f2fs_get_dummy_policy,
diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index 3125e76376ee6..fab90f9a8eaff 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -89,7 +89,7 @@ int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 
 const struct fscrypt_operations ubifs_crypt_operations = {
 	.flags			= FS_CFLG_OWN_PAGES,
-	.key_prefix		= "ubifs:",
+	.legacy_key_prefix_for_backcompat = "ubifs:",
 	.get_context		= ubifs_crypt_get_context,
 	.set_context		= ubifs_crypt_set_context,
 	.empty_dir		= ubifs_crypt_empty_dir,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index c895b12737a19..70e0d4917dd59 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -73,12 +73,16 @@ struct fscrypt_operations {
 	unsigned int flags;
 
 	/*
-	 * If set, this is a filesystem-specific key description prefix that
-	 * will be accepted for "logon" keys for v1 fscrypt policies, in
-	 * addition to the generic prefix "fscrypt:".  This functionality is
-	 * deprecated, so new filesystems shouldn't set this field.
+	 * This field exists only for backwards compatibility reasons and should
+	 * only be set by the filesystems that are setting it already.  It
+	 * contains the filesystem-specific key description prefix that is
+	 * accepted for "logon" keys for v1 fscrypt policies.  This
+	 * functionality is deprecated in favor of the generic prefix
+	 * "fscrypt:", which itself is deprecated in favor of the filesystem
+	 * keyring ioctls such as FS_IOC_ADD_ENCRYPTION_KEY.  Filesystems that
+	 * are newly adding fscrypt support should not set this field.
 	 */
-	const char *key_prefix;
+	const char *legacy_key_prefix_for_backcompat;
 
 	/*
 	 * Get the fscrypt context of the given inode.
-- 
2.42.0

