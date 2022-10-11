Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C505FBD20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 23:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJKVll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 17:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKVlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0349A02F7;
        Tue, 11 Oct 2022 14:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C81DD608C0;
        Tue, 11 Oct 2022 21:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E5CC433D6;
        Tue, 11 Oct 2022 21:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665524495;
        bh=i0m1nXSGQ7El8zKzDjINCWdp5TGe82jc/TYesmzF5iE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BxVPDy7544JIgvkVqmCAsUmBwUC+QkgAdtyfDN26P27d3ZwGZr1KYoUXoDAoOWlEh
         5Va9mHXs9PXPW9GxorQePLAkVQtT8vsgpFOGYgxb5Dp7n6MbdaKkzjpXpoTMgvgm0Z
         UcOfs+7AwSrHEEItI+UBKXlSa33oGVn6vyquazKRciv4T97UcOqliEEUxGtwuTpogb
         QFa+4+8ZXsXj8DAt49C8gVgPzfbhO7B6ejBjhDaKD+R6eANOyYode7LJps5xRoVmAR
         w1SNI7ll/J4AkmGcLGwT3rw6SSUrD6SoPwFGoXAzz9fPX4Qo/X6erxfCQ/qd/LCMSX
         KEncYvs4YMOHQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+104c2a89561289cec13e@syzkaller.appspotmail.com
Subject: [PATCH] fscrypt: fix keyring memory leak on mount failure
Date:   Tue, 11 Oct 2022 14:38:38 -0700
Message-Id: <20221011213838.209879-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <0000000000009aad5e05eac85f36@google.com>
References: <0000000000009aad5e05eac85f36@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Commit d7e7b9af104c ("fscrypt: stop using keyrings subsystem for
fscrypt_master_key") moved the keyring destruction from __put_super() to
generic_shutdown_super() so that the filesystem's block device(s) are
still available.  Unfortunately, this causes a memory leak in the case
where a mount is attempted with the test_dummy_encryption mount option,
but the mount fails after the option has already been processed.

To fix this, attempt the keyring destruction in both places.

Reported-by: syzbot+104c2a89561289cec13e@syzkaller.appspotmail.com
Fixes: d7e7b9af104c ("fscrypt: stop using keyrings subsystem for fscrypt_master_key")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keyring.c     | 17 +++++++++++------
 fs/super.c              |  3 ++-
 include/linux/fscrypt.h |  4 ++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 1cca09aa43f8b..2a24b1f0ae688 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -205,14 +205,19 @@ static int allocate_filesystem_keyring(struct super_block *sb)
 }
 
 /*
- * This is called at unmount time to release all encryption keys that have been
- * added to the filesystem, along with the keyring that contains them.
+ * Release all encryption keys that have been added to the filesystem, along
+ * with the keyring that contains them.
  *
- * Note that besides clearing and freeing memory, this might need to evict keys
- * from the keyslots of an inline crypto engine.  Therefore, this must be called
- * while the filesystem's underlying block device(s) are still available.
+ * This is called at unmount time.  The filesystem's underlying block device(s)
+ * are still available at this time; this is important because after user file
+ * accesses have been allowed, this function may need to evict keys from the
+ * keyslots of an inline crypto engine, which requires the block device(s).
+ *
+ * This is also called when the super_block is being freed.  This is needed to
+ * avoid a memory leak if mounting fails after the "test_dummy_encryption"
+ * option was processed, as in that case the unmount-time call isn't made.
  */
-void fscrypt_sb_delete(struct super_block *sb)
+void fscrypt_destroy_keyring(struct super_block *sb)
 {
 	struct fscrypt_keyring *keyring = sb->s_master_keys;
 	size_t i;
diff --git a/fs/super.c b/fs/super.c
index 6a82660e1adba..8d39e4f11cfa3 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -291,6 +291,7 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
 		security_sb_free(s);
+		fscrypt_destroy_keyring(s);
 		put_user_ns(s->s_user_ns);
 		kfree(s->s_subtype);
 		call_rcu(&s->rcu, destroy_super_rcu);
@@ -479,7 +480,7 @@ void generic_shutdown_super(struct super_block *sb)
 		evict_inodes(sb);
 		/* only nonzero refcount inodes can have marks */
 		fsnotify_sb_delete(sb);
-		fscrypt_sb_delete(sb);
+		fscrypt_destroy_keyring(sb);
 		security_sb_delete(sb);
 
 		if (sb->s_dio_done_wq) {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index cad78b569c7ef..4f5f8a6512132 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -307,7 +307,7 @@ fscrypt_free_dummy_policy(struct fscrypt_dummy_policy *dummy_policy)
 }
 
 /* keyring.c */
-void fscrypt_sb_delete(struct super_block *sb);
+void fscrypt_destroy_keyring(struct super_block *sb);
 int fscrypt_ioctl_add_key(struct file *filp, void __user *arg);
 int fscrypt_add_test_dummy_key(struct super_block *sb,
 			       const struct fscrypt_dummy_policy *dummy_policy);
@@ -521,7 +521,7 @@ fscrypt_free_dummy_policy(struct fscrypt_dummy_policy *dummy_policy)
 }
 
 /* keyring.c */
-static inline void fscrypt_sb_delete(struct super_block *sb)
+static inline void fscrypt_destroy_keyring(struct super_block *sb)
 {
 }
 

base-commit: 041bc24d867a2a577a06534d6d25e500b24a01ef
-- 
2.37.3

