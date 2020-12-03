Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413E52CCC8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgLCCYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbgLCCYI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:24:08 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v2 8/9] fscrypt: unexport fscrypt_get_encryption_info()
Date:   Wed,  2 Dec 2020 18:20:40 -0800
Message-Id: <20201203022041.230976-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203022041.230976-1-ebiggers@kernel.org>
References: <20201203022041.230976-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that fscrypt_get_encryption_info() is only called from files in
fs/crypto/ (due to all key setup now being handled by higher-level
helper functions instead of directly by filesystems), unexport it and
move its declaration to fscrypt_private.h.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h | 2 ++
 fs/crypto/keysetup.c        | 1 -
 include/linux/fscrypt.h     | 7 +------
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 16dd55080127a..c1c302656c345 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -571,6 +571,8 @@ int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
 void fscrypt_hash_inode_number(struct fscrypt_info *ci,
 			       const struct fscrypt_master_key *mk);
 
+int fscrypt_get_encryption_info(struct inode *inode);
+
 /**
  * fscrypt_require_key() - require an inode's encryption key
  * @inode: the inode we need the key for
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 50675b42d5b7c..6339b3069a400 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -589,7 +589,6 @@ int fscrypt_get_encryption_info(struct inode *inode)
 		res = 0;
 	return res;
 }
-EXPORT_SYMBOL(fscrypt_get_encryption_info);
 
 /**
  * fscrypt_prepare_new_inode() - prepare to create a new inode in a directory
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index a07610f279266..4b163f5e58e9f 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -75,7 +75,7 @@ struct fscrypt_operations {
 static inline struct fscrypt_info *fscrypt_get_info(const struct inode *inode)
 {
 	/*
-	 * Pairs with the cmpxchg_release() in fscrypt_get_encryption_info().
+	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
 	 * I.e., another task may publish ->i_crypt_info concurrently, executing
 	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
 	 * ACQUIRE the memory the other task published.
@@ -200,7 +200,6 @@ int fscrypt_ioctl_remove_key_all_users(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_key_status(struct file *filp, void __user *arg);
 
 /* keysetup.c */
-int fscrypt_get_encryption_info(struct inode *inode);
 int fscrypt_prepare_new_inode(struct inode *dir, struct inode *inode,
 			      bool *encrypt_ret);
 void fscrypt_put_encryption_info(struct inode *inode);
@@ -408,10 +407,6 @@ static inline int fscrypt_ioctl_get_key_status(struct file *filp,
 }
 
 /* keysetup.c */
-static inline int fscrypt_get_encryption_info(struct inode *inode)
-{
-	return -EOPNOTSUPP;
-}
 
 static inline int fscrypt_prepare_new_inode(struct inode *dir,
 					    struct inode *inode,
-- 
2.29.2

