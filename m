Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6B67ACFAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 07:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjIYF7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 01:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjIYF7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:59:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325FF112;
        Sun, 24 Sep 2023 22:58:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8020DC433C8;
        Mon, 25 Sep 2023 05:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695621538;
        bh=idiVzlkasc6EOKYjPFwNaxxpxVhmkIQdbuE4cRL0Tzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qd9ipEV70X7+ByaaCBd7HAb+BHhngMqY7dpRA/jPvTYup4xniVJ91BMtXoo5Sr35f
         6ONvHB4Yw2HGU9DRLYDTcdhq033DvfAPl4w90ommQ9+5w0dZRhTR0+3DMQ9vB7hue5
         8wo/OJb2lAf0B0Jp74s8nVrYNXjTqWO3vXQ/IxIIaKyR5WsTK4BTo88HrCyxXDwapK
         T6FMGs+vM0hSUM/LF4ERbrlSapj8atL5o1cLkPg6BUG5dVKN26Wg7TMz36/D/c6Xhm
         S4QVUJAR5/Fu8d/OlogAZo5LmHB6l0P2tqTRZ0GTMeKgaP8gwJtkaN+IpgFSAJ7knu
         Qy72UYYc6vkoQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3 1/5] fscrypt: make it clearer that key_prefix is deprecated
Date:   Sun, 24 Sep 2023 22:54:47 -0700
Message-ID: <20230925055451.59499-2-ebiggers@kernel.org>
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

fscrypt_operations::key_prefix should not be set by any filesystems that
aren't setting it already.  This is already documented, but apparently
it's not sufficiently clear, as both ceph and btrfs have tried to set
it.  Rename the field to legacy_key_prefix and improve the documentation
to hopefully make it clearer.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keysetup_v1.c |  5 +++--
 fs/ext4/crypto.c        |  2 +-
 fs/f2fs/super.c         |  2 +-
 fs/ubifs/crypto.c       |  2 +-
 include/linux/fscrypt.h | 14 +++++++++-----
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 75dabd9b27f9b..86b48a2b47d1b 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -292,29 +292,30 @@ static int setup_v1_file_key_derived(struct fscrypt_info *ci,
 int fscrypt_setup_v1_file_key(struct fscrypt_info *ci, const u8 *raw_master_key)
 {
 	if (ci->ci_policy.v1.flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
 		return setup_v1_file_key_direct(ci, raw_master_key);
 	else
 		return setup_v1_file_key_derived(ci, raw_master_key);
 }
 
 int fscrypt_setup_v1_file_key_via_subscribed_keyrings(struct fscrypt_info *ci)
 {
+	const struct super_block *sb = ci->ci_inode->i_sb;
 	struct key *key;
 	const struct fscrypt_key *payload;
 	int err;
 
 	key = find_and_lock_process_key(FSCRYPT_KEY_DESC_PREFIX,
 					ci->ci_policy.v1.master_key_descriptor,
 					ci->ci_mode->keysize, &payload);
-	if (key == ERR_PTR(-ENOKEY) && ci->ci_inode->i_sb->s_cop->key_prefix) {
-		key = find_and_lock_process_key(ci->ci_inode->i_sb->s_cop->key_prefix,
+	if (key == ERR_PTR(-ENOKEY) && sb->s_cop->legacy_key_prefix) {
+		key = find_and_lock_process_key(sb->s_cop->legacy_key_prefix,
 						ci->ci_policy.v1.master_key_descriptor,
 						ci->ci_mode->keysize, &payload);
 	}
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
 	err = fscrypt_setup_v1_file_key(ci, payload->raw);
 	up_read(&key->sem);
 	key_put(key);
 	return err;
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 453d4da5de520..99a4769a53f63 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -233,18 +233,18 @@ static bool ext4_has_stable_inodes(struct super_block *sb)
 }
 
 static void ext4_get_ino_and_lblk_bits(struct super_block *sb,
 				       int *ino_bits_ret, int *lblk_bits_ret)
 {
 	*ino_bits_ret = 8 * sizeof(EXT4_SB(sb)->s_es->s_inodes_count);
 	*lblk_bits_ret = 8 * sizeof(ext4_lblk_t);
 }
 
 const struct fscrypt_operations ext4_cryptops = {
-	.key_prefix		= "ext4:",
+	.legacy_key_prefix	= "ext4:",
 	.get_context		= ext4_get_context,
 	.set_context		= ext4_set_context,
 	.get_dummy_policy	= ext4_get_dummy_policy,
 	.empty_dir		= ext4_empty_dir,
 	.has_stable_inodes	= ext4_has_stable_inodes,
 	.get_ino_and_lblk_bits	= ext4_get_ino_and_lblk_bits,
 };
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a8c8232852bb1..f60062b558fd1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3224,21 +3224,21 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 	if (!devs)
 		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < sbi->s_ndevs; i++)
 		devs[i] = FDEV(i).bdev;
 	*num_devs = sbi->s_ndevs;
 	return devs;
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
-	.key_prefix		= "f2fs:",
+	.legacy_key_prefix	= "f2fs:",
 	.get_context		= f2fs_get_context,
 	.set_context		= f2fs_set_context,
 	.get_dummy_policy	= f2fs_get_dummy_policy,
 	.empty_dir		= f2fs_empty_dir,
 	.has_stable_inodes	= f2fs_has_stable_inodes,
 	.get_ino_and_lblk_bits	= f2fs_get_ino_and_lblk_bits,
 	.get_devices		= f2fs_get_devices,
 };
 #endif
 
diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index 3125e76376ee6..1be3e11da3b3e 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -82,15 +82,15 @@ int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 		ubifs_err(c, "fscrypt_decrypt_block_inplace() failed: %d", err);
 		return err;
 	}
 	*out_len = clen;
 
 	return 0;
 }
 
 const struct fscrypt_operations ubifs_crypt_operations = {
 	.flags			= FS_CFLG_OWN_PAGES,
-	.key_prefix		= "ubifs:",
+	.legacy_key_prefix	= "ubifs:",
 	.get_context		= ubifs_crypt_get_context,
 	.set_context		= ubifs_crypt_set_context,
 	.empty_dir		= ubifs_crypt_empty_dir,
 };
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index c895b12737a19..b0037566ce308 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -66,26 +66,30 @@ struct fscrypt_name {
  */
 #define FS_CFLG_OWN_PAGES (1U << 1)
 
 /* Crypto operations for filesystems */
 struct fscrypt_operations {
 
 	/* Set of optional flags; see above for allowed flags */
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
+	const char *legacy_key_prefix;
 
 	/*
 	 * Get the fscrypt context of the given inode.
 	 *
 	 * @inode: the inode whose context to get
 	 * @ctx: the buffer into which to get the context
 	 * @len: length of the @ctx buffer in bytes
 	 *
 	 * Return: On success, returns the length of the context in bytes; this
 	 *	   may be less than @len.  On failure, returns -ENODATA if the

base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.42.0

