Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276777924C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjIEP7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbjIEBEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72FE1B8;
        Mon,  4 Sep 2023 18:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DE0560ED6;
        Tue,  5 Sep 2023 01:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FBEC433CA;
        Tue,  5 Sep 2023 01:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693875866;
        bh=G/v2LTjl9mO7BgSolxUEpe0QgWSe5wHmD/t2lQSPLFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAaa1vgqTwUBhkcf3bq5obFu3WlI0xHPpHTAW5xZp/ieUWxjrUb+G05lbBkU/21DZ
         vOnDduL44PNOgPH2hryqSPdljyAIAMxxDkQL0bZHXTePAgOKQydVyn6ssf83/Gv680
         fV8gHX6wLtXhDQ0bcIzAErmNy/CR69OHK+4WCbvDSYCxyCVMPmbhAGH50lSejpSxQA
         3njqXdS1nnLX0JlfvpA0b7R/x1DUqh80GnNfLFotCoMYdqRzJxSJkWJQS6gSR5n8Bj
         h4uyuWJETlxxYGANT2OtR2oNEWie7Ht2luUv3KhYRubleqbhPvdkRTiMD+q/A8YuFg
         cFuoP2ZcO3Qmg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] fscrypt: make it extra clear that key_prefix is deprecated
Date:   Mon,  4 Sep 2023 17:58:26 -0700
Message-ID: <20230905005830.365985-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230905005830.365985-1-ebiggers@kernel.org>
References: <20230905005830.365985-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
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
index c895b12737a19..85574282c7e52 100644
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
+	 * accepted for "logon" keys for v1 fscrypt policies, in addition to the
+	 * generic prefix "fscrypt:".  This functionality is deprecated in favor
+	 * of "fscrypt:", which itself is deprecated in favor of the filesystem
+	 * keyring ioctls such as FS_IOC_ADD_ENCRYPTION_KEY.  Filesystems that
+	 * are newly adding fscrypt support should not set this field.
 	 */
-	const char *key_prefix;
+	const char *legacy_key_prefix_for_backcompat;
 
 	/*
 	 * Get the fscrypt context of the given inode.
-- 
2.42.0

