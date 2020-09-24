Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D632767DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 06:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgIXE3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 00:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgIXE3C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:29:02 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21041238D6;
        Thu, 24 Sep 2020 04:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600921741;
        bh=O1BPWmS0nDcBXKHTSqB+q3k9JtbCvkyYKK42a+iy7L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehSyDEp3qjOv4/OH0nOoWQHDG3FBvBr+o+8GDbnCY6waBzmguHWIyBO3N8B5om25h
         UGJI6O/ZGkdTdkv46nMz0jWzho9zVow+TuTueiW9EBClTZU3ZBQ4pTUk7PbWP9Ly/i
         xPsbB9sfSBMRj7lRcGv1Qsx8JcxGHCkB5E9lbqw0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 1/2] fscrypt: don't call no-key names "ciphertext names"
Date:   Wed, 23 Sep 2020 21:26:23 -0700
Message-Id: <20200924042624.98439-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924042624.98439-1-ebiggers@kernel.org>
References: <20200924042624.98439-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Currently we're using the term "ciphertext name" ambiguously because it
can mean either the actual ciphertext filename, or the encoded filename
that is shown when an encrypted directory is listed without its key.
The latter we're now usually calling the "no-key name"; and while it's
derived from the ciphertext name, it's not the same thing.

To avoid this ambiguity, rename fscrypt_name::is_ciphertext_name to
fscrypt_name::is_nokey_name, and update comments that say "ciphertext
name" (or "encrypted name") to say "no-key name" instead when warranted.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fname.c       | 16 ++++++++--------
 fs/crypto/hooks.c       |  6 +++---
 fs/f2fs/dir.c           |  2 +-
 include/linux/fscrypt.h | 15 +++++++--------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index f47b581d8a94..391acea4bc96 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -382,9 +382,9 @@ EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
  * directory's encryption key, then @iname is the plaintext, so we encrypt it to
  * get the disk_name.
  *
- * Else, for keyless @lookup operations, @iname is the presented ciphertext, so
- * we decode it to get the fscrypt_nokey_name.  Non-@lookup operations will be
- * impossible in this case, so we fail them with ENOKEY.
+ * Else, for keyless @lookup operations, @iname should be a no-key name, so we
+ * decode it to get the struct fscrypt_nokey_name.  Non-@lookup operations will
+ * be impossible in this case, so we fail them with ENOKEY.
  *
  * If successful, fscrypt_free_filename() must be called later to clean up.
  *
@@ -429,7 +429,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	}
 	if (!lookup)
 		return -ENOKEY;
-	fname->is_ciphertext_name = true;
+	fname->is_nokey_name = true;
 
 	/*
 	 * We don't have the key and we are doing a lookup; decode the
@@ -538,17 +538,17 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 
 	/*
 	 * Plaintext names are always valid, since fscrypt doesn't support
-	 * reverting to ciphertext names without evicting the directory's inode
+	 * reverting to no-key names without evicting the directory's inode
 	 * -- which implies eviction of the dentries in the directory.
 	 */
 	if (!(dentry->d_flags & DCACHE_ENCRYPTED_NAME))
 		return 1;
 
 	/*
-	 * Ciphertext name; valid if the directory's key is still unavailable.
+	 * No-key name; valid if the directory's key is still unavailable.
 	 *
-	 * Although fscrypt forbids rename() on ciphertext names, we still must
-	 * use dget_parent() here rather than use ->d_parent directly.  That's
+	 * Although fscrypt forbids rename() on no-key names, we still must use
+	 * dget_parent() here rather than use ->d_parent directly.  That's
 	 * because a corrupted fs image may contain directory hard links, which
 	 * the VFS handles by moving the directory's dentry tree in the dcache
 	 * each time ->lookup() finds the directory and it already has a dentry
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 42f5ee9f592d..ca996e1c92d9 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -60,7 +60,7 @@ int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 	if (err)
 		return err;
 
-	/* ... in case we looked up ciphertext name before key was added */
+	/* ... in case we looked up no-key name before key was added */
 	if (dentry->d_flags & DCACHE_ENCRYPTED_NAME)
 		return -ENOKEY;
 
@@ -85,7 +85,7 @@ int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		return err;
 
-	/* ... in case we looked up ciphertext name(s) before key was added */
+	/* ... in case we looked up no-key name(s) before key was added */
 	if ((old_dentry->d_flags | new_dentry->d_flags) &
 	    DCACHE_ENCRYPTED_NAME)
 		return -ENOKEY;
@@ -114,7 +114,7 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 	if (err && err != -ENOENT)
 		return err;
 
-	if (fname->is_ciphertext_name) {
+	if (fname->is_nokey_name) {
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_ENCRYPTED_NAME;
 		spin_unlock(&dentry->d_lock);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 414bc94fbd54..53fbc4dd6e48 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -111,7 +111,7 @@ static int __f2fs_setup_filename(const struct inode *dir,
 #ifdef CONFIG_FS_ENCRYPTION
 	fname->crypto_buf = crypt_name->crypto_buf;
 #endif
-	if (crypt_name->is_ciphertext_name) {
+	if (crypt_name->is_nokey_name) {
 		/* hash was decoded from the no-key name */
 		fname->hash = cpu_to_le32(crypt_name->hash);
 	} else {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index fc67c4cbaa96..bc9ec727e993 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -35,7 +35,7 @@ struct fscrypt_name {
 	u32 hash;
 	u32 minor_hash;
 	struct fscrypt_str crypto_buf;
-	bool is_ciphertext_name;
+	bool is_nokey_name;
 };
 
 #define FSTR_INIT(n, l)		{ .name = n, .len = l }
@@ -730,17 +730,16 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
  * @fname: (output) the name to use to search the on-disk directory
  *
  * Prepare for ->lookup() in a directory which may be encrypted by determining
- * the name that will actually be used to search the directory on-disk.  Lookups
- * can be done with or without the directory's encryption key; without the key,
- * filenames are presented in encrypted form.  Therefore, we'll try to set up
- * the directory's encryption key, but even without it the lookup can continue.
+ * the name that will actually be used to search the directory on-disk.  If the
+ * directory's encryption key is available, then the lookup is assumed to be by
+ * plaintext name; otherwise, it is assumed to be by no-key name.
  *
  * This also installs a custom ->d_revalidate() method which will invalidate the
  * dentry if it was created without the key and the key is later added.
  *
- * Return: 0 on success; -ENOENT if key is unavailable but the filename isn't a
- * correctly formed encoded ciphertext name, so a negative dentry should be
- * created; or another -errno code.
+ * Return: 0 on success; -ENOENT if the directory's key is unavailable but the
+ * filename isn't a valid no-key name, so a negative dentry should be created;
+ * or another -errno code.
  */
 static inline int fscrypt_prepare_lookup(struct inode *dir,
 					 struct dentry *dentry,
-- 
2.28.0

