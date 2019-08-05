Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41C3821DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfHEQ2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbfHEQ2i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:28:38 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ABEF21882;
        Mon,  5 Aug 2019 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565022517;
        bh=VjAaNT/bB/mmrNPRrRj2ZZRW/GYtz3hszPigcawoqzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/Z2qEREoFm/mmXKw0i8w5vAqkR/mAb7ptX3C3G4hUGzHmRT1I+2nh4hBecUKx7qP
         qBhsWoKbVZ1N1GU379pIrI8rEbMfoI9deXoMQu2LigEP21H3iI02xzcwQUzPrjanzh
         kdeLKNiBRCc55d1D1wuKOC8WZUtDl/AbFtSL7UFA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v8 15/20] fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS ioctl
Date:   Mon,  5 Aug 2019 09:25:16 -0700
Message-Id: <20190805162521.90882-16-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805162521.90882-1-ebiggers@kernel.org>
References: <20190805162521.90882-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a root-only variant of the FS_IOC_REMOVE_ENCRYPTION_KEY ioctl which
removes all users' claims of the key, not just the current user's claim.
I.e., it always removes the key itself, no matter how many users have
added it.

This is useful for forcing a directory to be locked, without having to
figure out which user ID(s) the key was added under.  This is planned to
be used by a command like 'sudo fscrypt lock DIR --all-users' in the
fscrypt userspace tool (http://github.com/google/fscrypt).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keyring.c          | 29 ++++++++++++++++++++++++-----
 include/linux/fscrypt.h      |  8 ++++++++
 include/uapi/linux/fscrypt.h |  1 +
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 2f47464f8cf603..86bfcc02b31fcf 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -11,6 +11,7 @@
  *
  * - FS_IOC_ADD_ENCRYPTION_KEY
  * - FS_IOC_REMOVE_ENCRYPTION_KEY
+ * - FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS
  * - FS_IOC_GET_ENCRYPTION_KEY_STATUS
  *
  * See the "User API" section of Documentation/filesystems/fscrypt.rst for more
@@ -699,8 +700,10 @@ static int try_to_lock_encrypted_files(struct super_block *sb,
 /*
  * Try to remove an fscrypt master encryption key.
  *
- * This removes the current user's claim to the key, then removes the key itself
- * if no other users have claims.
+ * FS_IOC_REMOVE_ENCRYPTION_KEY (all_users=false) removes the current user's
+ * claim to the key, then removes the key itself if no other users have claims.
+ * FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS (all_users=true) always removes the
+ * key itself.
  *
  * To "remove the key itself", first we wipe the actual master key secret, so
  * that no more inodes can be unlocked with it.  Then we try to evict all cached
@@ -715,7 +718,7 @@ static int try_to_lock_encrypted_files(struct super_block *sb,
  * For more details, see the "Removing keys" section of
  * Documentation/filesystems/fscrypt.rst.
  */
-int fscrypt_ioctl_remove_key(struct file *filp, void __user *_uarg)
+static int do_remove_key(struct file *filp, void __user *_uarg, bool all_users)
 {
 	struct super_block *sb = file_inode(filp)->i_sb;
 	struct fscrypt_remove_key_arg __user *uarg = _uarg;
@@ -751,9 +754,12 @@ int fscrypt_ioctl_remove_key(struct file *filp, void __user *_uarg)
 
 	down_write(&key->sem);
 
-	/* If relevant, remove current user's claim to the key */
+	/* If relevant, remove current user's (or all users) claim to the key */
 	if (mk->mk_users && mk->mk_users->keys.nr_leaves_on_tree != 0) {
-		err = remove_master_key_user(mk);
+		if (all_users)
+			err = keyring_clear(mk->mk_users);
+		else
+			err = remove_master_key_user(mk);
 		if (err) {
 			up_write(&key->sem);
 			goto out_put_key;
@@ -806,8 +812,21 @@ int fscrypt_ioctl_remove_key(struct file *filp, void __user *_uarg)
 		err = put_user(status_flags, &uarg->removal_status_flags);
 	return err;
 }
+
+int fscrypt_ioctl_remove_key(struct file *filp, void __user *uarg)
+{
+	return do_remove_key(filp, uarg, false);
+}
 EXPORT_SYMBOL_GPL(fscrypt_ioctl_remove_key);
 
+int fscrypt_ioctl_remove_key_all_users(struct file *filp, void __user *uarg)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	return do_remove_key(filp, uarg, true);
+}
+EXPORT_SYMBOL_GPL(fscrypt_ioctl_remove_key_all_users);
+
 /*
  * Retrieve the status of an fscrypt master encryption key.
  *
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 8b8ff048404297..f622f7460ed8c6 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -143,6 +143,8 @@ extern int fscrypt_inherit_context(struct inode *, struct inode *,
 extern void fscrypt_sb_free(struct super_block *sb);
 extern int fscrypt_ioctl_add_key(struct file *filp, void __user *arg);
 extern int fscrypt_ioctl_remove_key(struct file *filp, void __user *arg);
+extern int fscrypt_ioctl_remove_key_all_users(struct file *filp,
+					      void __user *arg);
 extern int fscrypt_ioctl_get_key_status(struct file *filp, void __user *arg);
 
 /* keysetup.c */
@@ -396,6 +398,12 @@ static inline int fscrypt_ioctl_remove_key(struct file *filp, void __user *arg)
 	return -EOPNOTSUPP;
 }
 
+static inline int fscrypt_ioctl_remove_key_all_users(struct file *filp,
+						     void __user *arg)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int fscrypt_ioctl_get_key_status(struct file *filp,
 					       void __user *arg)
 {
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index b9fb775e3db8e4..39ccfe9311c387 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -148,6 +148,7 @@ struct fscrypt_get_key_status_arg {
 #define FS_IOC_GET_ENCRYPTION_POLICY_EX		_IOWR('f', 22, __u8[9]) /* size + version */
 #define FS_IOC_ADD_ENCRYPTION_KEY		_IOWR('f', 23, struct fscrypt_add_key_arg)
 #define FS_IOC_REMOVE_ENCRYPTION_KEY		_IOWR('f', 24, struct fscrypt_remove_key_arg)
+#define FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS	_IOWR('f', 25, struct fscrypt_remove_key_arg)
 #define FS_IOC_GET_ENCRYPTION_KEY_STATUS	_IOWR('f', 26, struct fscrypt_get_key_status_arg)
 
 /**********************************************************************/
-- 
2.22.0.770.g0f2c4a37fd-goog

