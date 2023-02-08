Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3ED68E82A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 07:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjBHGVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 01:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHGVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:21:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EDD23861;
        Tue,  7 Feb 2023 22:21:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F27BE614E5;
        Wed,  8 Feb 2023 06:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8D2C4339C;
        Wed,  8 Feb 2023 06:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675837296;
        bh=9FKAgPpudsEY1b71O+8Pdv2NPJKqQ94hKa6qzZM+f/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2gSotr/T2tuDmj7eKZmGldsLfnOOCW8QnUhI2J1RVyfsgRQkq6H/4aUYesDQqe5u
         p9xk2PzVPdD3+GWILcUbgcq3lYj62oT2jWOjX9pvjpMINlDn9DM8Ba7BMJtgrazy7L
         MQnl1SYZ/1vlQofGYyiIllHv+nQqLWAQJKdkHMJRW0XXpjuq+/53oHp4oNTNvW0uXB
         DGMASFJ6wcbYlRfKN9HQJ83ru/vWVpJ761mzUoHLe2g8zHMOvokUupC6LVJnjhERJI
         HXgyqcAzu02y7ZMxIXGiHqkJumxfzUmZ6lJ7AZurqZgLD7eZw3M/uzoUunaFzn/wNP
         zEVtwiPO+49gw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/5] fscrypt: clean up fscrypt_add_test_dummy_key()
Date:   Tue,  7 Feb 2023 22:21:07 -0800
Message-Id: <20230208062107.199831-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
References: <20230208062107.199831-1-ebiggers@kernel.org>
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

Now that fscrypt_add_test_dummy_key() is only called by
setup_file_encryption_key() and not by the individual filesystems,
un-export it.  Also change its prototype to take the
fscrypt_key_specifier directly, as the caller already has it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h |  3 +++
 fs/crypto/keyring.c         | 26 +++++++-------------------
 fs/crypto/keysetup.c        |  4 +---
 include/linux/fscrypt.h     |  9 ---------
 4 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 17dd33d9a522e..0fec2dfc36ebe 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -573,6 +573,9 @@ fscrypt_find_master_key(struct super_block *sb,
 int fscrypt_get_test_dummy_key_identifier(
 			  u8 key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE]);
 
+int fscrypt_add_test_dummy_key(struct super_block *sb,
+			       struct fscrypt_key_specifier *key_spec);
+
 int fscrypt_verify_key_added(struct super_block *sb,
 			     const u8 identifier[FSCRYPT_KEY_IDENTIFIER_SIZE]);
 
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 78dd2ff306bd7..78086f8dbda52 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -211,10 +211,6 @@ static int allocate_filesystem_keyring(struct super_block *sb)
  * are still available at this time; this is important because after user file
  * accesses have been allowed, this function may need to evict keys from the
  * keyslots of an inline crypto engine, which requires the block device(s).
- *
- * This is also called when the super_block is being freed.  This is needed to
- * avoid a memory leak if mounting fails after the "test_dummy_encryption"
- * option was processed, as in that case the unmount-time call isn't made.
  */
 void fscrypt_destroy_keyring(struct super_block *sb)
 {
@@ -778,34 +774,26 @@ int fscrypt_get_test_dummy_key_identifier(
 /**
  * fscrypt_add_test_dummy_key() - add the test dummy encryption key
  * @sb: the filesystem instance to add the key to
- * @dummy_policy: the encryption policy for test_dummy_encryption
+ * @key_spec: the key specifier of the test dummy encryption key
  *
- * If needed, add the key for the test_dummy_encryption mount option to the
- * filesystem.  To prevent misuse of this mount option, a per-boot random key is
- * used instead of a hardcoded one.  This makes it so that any encrypted files
- * created using this option won't be accessible after a reboot.
+ * Add the key for the test_dummy_encryption mount option to the filesystem.  To
+ * prevent misuse of this mount option, a per-boot random key is used instead of
+ * a hardcoded one.  This makes it so that any encrypted files created using
+ * this option won't be accessible after a reboot.
  *
  * Return: 0 on success, -errno on failure
  */
 int fscrypt_add_test_dummy_key(struct super_block *sb,
-			       const struct fscrypt_dummy_policy *dummy_policy)
+			       struct fscrypt_key_specifier *key_spec)
 {
-	const union fscrypt_policy *policy = dummy_policy->policy;
-	struct fscrypt_key_specifier key_spec;
 	struct fscrypt_master_key_secret secret;
 	int err;
 
-	if (!policy)
-		return 0;
-	err = fscrypt_policy_to_key_spec(policy, &key_spec);
-	if (err)
-		return err;
 	fscrypt_get_test_dummy_secret(&secret);
-	err = add_master_key(sb, &secret, &key_spec);
+	err = add_master_key(sb, &secret, key_spec);
 	wipe_master_key_secret(&secret);
 	return err;
 }
-EXPORT_SYMBOL_GPL(fscrypt_add_test_dummy_key);
 
 /*
  * Verify that the current user has added a master key with the given identifier
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 20323c0ba4c5e..aa94fba9d17e7 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -464,9 +464,7 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 		 */
 		if (dummy_policy &&
 		    fscrypt_policies_equal(dummy_policy, &ci->ci_policy)) {
-			struct fscrypt_dummy_policy tmp = { dummy_policy };
-
-			err = fscrypt_add_test_dummy_key(sb, &tmp);
+			err = fscrypt_add_test_dummy_key(sb, &mk_spec);
 			if (err)
 				return err;
 			mk = fscrypt_find_master_key(sb, &mk_spec);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 4f5f8a6512132..44848d870046a 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -309,8 +309,6 @@ fscrypt_free_dummy_policy(struct fscrypt_dummy_policy *dummy_policy)
 /* keyring.c */
 void fscrypt_destroy_keyring(struct super_block *sb);
 int fscrypt_ioctl_add_key(struct file *filp, void __user *arg);
-int fscrypt_add_test_dummy_key(struct super_block *sb,
-			       const struct fscrypt_dummy_policy *dummy_policy);
 int fscrypt_ioctl_remove_key(struct file *filp, void __user *arg);
 int fscrypt_ioctl_remove_key_all_users(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_key_status(struct file *filp, void __user *arg);
@@ -530,13 +528,6 @@ static inline int fscrypt_ioctl_add_key(struct file *filp, void __user *arg)
 	return -EOPNOTSUPP;
 }
 
-static inline int
-fscrypt_add_test_dummy_key(struct super_block *sb,
-			   const struct fscrypt_dummy_policy *dummy_policy)
-{
-	return 0;
-}
-
 static inline int fscrypt_ioctl_remove_key(struct file *filp, void __user *arg)
 {
 	return -EOPNOTSUPP;
-- 
2.39.1

