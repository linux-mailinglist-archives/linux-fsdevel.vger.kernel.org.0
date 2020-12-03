Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3F72CCC86
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgLCCYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:24:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgLCCYI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:24:08 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v2 5/9] fscrypt: introduce fscrypt_prepare_readdir()
Date:   Wed,  2 Dec 2020 18:20:37 -0800
Message-Id: <20201203022041.230976-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203022041.230976-1-ebiggers@kernel.org>
References: <20201203022041.230976-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The last remaining use of fscrypt_get_encryption_info() from filesystems
is for readdir (->iterate_shared()).  Every other call is now in
fs/crypto/ as part of some other higher-level operation.

We need to add a new argument to fscrypt_get_encryption_info() to
indicate whether the encryption policy is allowed to be unrecognized or
not.  Doing this is easier if we can work with high-level operations
rather than direct filesystem use of fscrypt_get_encryption_info().

So add a function fscrypt_prepare_readdir() which wraps the call to
fscrypt_get_encryption_info() for the readdir use case.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/hooks.c       |  6 ++++++
 fs/ext4/dir.c           |  8 +++-----
 fs/ext4/namei.c         |  2 +-
 fs/f2fs/dir.c           |  2 +-
 fs/ubifs/dir.c          |  2 +-
 include/linux/fscrypt.h | 24 ++++++++++++++++++++++++
 6 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index c809a4afa057e..82f351d3113ac 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -114,6 +114,12 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
 
+int __fscrypt_prepare_readdir(struct inode *dir)
+{
+	return fscrypt_get_encryption_info(dir);
+}
+EXPORT_SYMBOL_GPL(__fscrypt_prepare_readdir);
+
 /**
  * fscrypt_prepare_setflags() - prepare to change flags with FS_IOC_SETFLAGS
  * @inode: the inode on which flags are being changed
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 16bfbdd5007c7..c6d16353326a9 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -118,11 +118,9 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 	struct buffer_head *bh = NULL;
 	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
 
-	if (IS_ENCRYPTED(inode)) {
-		err = fscrypt_get_encryption_info(inode);
-		if (err)
-			return err;
-	}
+	err = fscrypt_prepare_readdir(inode);
+	if (err)
+		return err;
 
 	if (is_dx_dir(inode)) {
 		err = ext4_dx_readdir(file, ctx);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 7b31aea3e0253..5fa8436cd5fae 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1004,7 +1004,7 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 					   EXT4_DIR_REC_LEN(0));
 	/* Check if the directory is encrypted */
 	if (IS_ENCRYPTED(dir)) {
-		err = fscrypt_get_encryption_info(dir);
+		err = fscrypt_prepare_readdir(dir);
 		if (err < 0) {
 			brelse(bh);
 			return err;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 47bee953fc8d8..049500f1e764c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1022,7 +1022,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	int err = 0;
 
 	if (IS_ENCRYPTED(inode)) {
-		err = fscrypt_get_encryption_info(inode);
+		err = fscrypt_prepare_readdir(inode);
 		if (err)
 			goto out;
 
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 009fbf844d3e6..1f33a5598b93f 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -514,7 +514,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	if (encrypted) {
-		err = fscrypt_get_encryption_info(dir);
+		err = fscrypt_prepare_readdir(dir);
 		if (err)
 			return err;
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 0c9e64969b736..8cbb26f556952 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -242,6 +242,7 @@ int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 			     unsigned int flags);
 int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 			     struct fscrypt_name *fname);
+int __fscrypt_prepare_readdir(struct inode *dir);
 int fscrypt_prepare_setflags(struct inode *inode,
 			     unsigned int oldflags, unsigned int flags);
 int fscrypt_prepare_symlink(struct inode *dir, const char *target,
@@ -537,6 +538,11 @@ static inline int __fscrypt_prepare_lookup(struct inode *dir,
 	return -EOPNOTSUPP;
 }
 
+static inline int __fscrypt_prepare_readdir(struct inode *dir)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int fscrypt_prepare_setflags(struct inode *inode,
 					   unsigned int oldflags,
 					   unsigned int flags)
@@ -795,6 +801,24 @@ static inline int fscrypt_prepare_lookup(struct inode *dir,
 	return 0;
 }
 
+/**
+ * fscrypt_prepare_readdir() - prepare to read a possibly-encrypted directory
+ * @dir: the directory inode
+ *
+ * If the directory is encrypted and it doesn't already have its encryption key
+ * set up, try to set it up so that the filenames will be listed in plaintext
+ * form rather than in no-key form.
+ *
+ * Return: 0 on success; -errno on error.  Note that the encryption key being
+ *	   unavailable is not considered an error.
+ */
+static inline int fscrypt_prepare_readdir(struct inode *dir)
+{
+	if (IS_ENCRYPTED(dir))
+		return __fscrypt_prepare_readdir(dir);
+	return 0;
+}
+
 /**
  * fscrypt_prepare_setattr() - prepare to change a possibly-encrypted inode's
  *			       attributes
-- 
2.29.2

