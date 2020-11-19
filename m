Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4EB2B8B55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 07:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgKSGJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 01:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgKSGJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:09:13 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150F3C061A04
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 22:09:12 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t1so3169996pgo.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 22:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ASfozbX9dlgLzgxgwAZr2FPSqoUUc7MVGsIEm0OoYhM=;
        b=AW3Z8WWiOVbD+uQNqVRm2eQiELCwcw1wvO6zPB9mg0x9FiI5ZlmannbAwUUMnCtAkQ
         GTUUf5Lbd+fH/fVT2bq5dttg2FO5uJKDyyBGue09e6hf4yACkyoMDhLC2nwZqyMglyde
         kknBKS2pVb98NYBZibeMbXOmt5l/biiRFvgZFCoM7ZOr/KYmCvybwiREnAkwnxUE+Fut
         U0uJiaBt2OTuymSvnlpAlQw2QBi/w5ZlpXvUSPh8AXlmPF2DdWuDi1aAlUJ4qfbQq1NX
         HJBG6uip98sgZk0Sb6ZUr29HQj4iyQO0kWqX9NBpn8Bo+wVtn4p7DecOp4/6v2iobCcr
         FYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ASfozbX9dlgLzgxgwAZr2FPSqoUUc7MVGsIEm0OoYhM=;
        b=k15ssCPWqtMUkVoEFTvRTczHnnfKQvFGaM2NNgSV5p52Yf98/Dr37pBx5B+t4rCVgJ
         PRjlKA6qSuYyU08hZxqMbLQtXkPziG8hzOUwc5cCrpAgSPWK0iqwakBazUF7jd1aHcLN
         QoIYoEPf+yUDj1WYFqvxHDUxEdWZyRawNLTTjXw9vs0bCvuzrGJak+X21oM0PRgOllpL
         IwQ/uD17ru79yCyrnQ2LwvhIlarfqRODo+0urBRzmsZgsT0WWqS9YlfJFo4ePe0itpV+
         cQP39BChukPkfrS13lsIimKrafEnKQONrQSjZ6Wo+My/E5oeNGr+pPJM18sQGPr1bNiC
         ADPQ==
X-Gm-Message-State: AOAM530A0R187dT2SabSyGUmQO3kS+k8eWh76RqvfYZUCl36wvfyoJjN
        gOsa8mZBMVbwQxa5LQYb/hLDrJNgYgY=
X-Google-Smtp-Source: ABdhPJyhf9nsBfme/+EOPTNEDMTBuG2lheUyKxSfVtCQMLky9zcvZXiSqrCY6Pwd3FQ3qwNi6gxXIpA9X4Q=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a63:e70c:: with SMTP id b12mr6241414pgi.220.1605766151561;
 Wed, 18 Nov 2020 22:09:11 -0800 (PST)
Date:   Thu, 19 Nov 2020 06:09:03 +0000
In-Reply-To: <20201119060904.463807-1-drosen@google.com>
Message-Id: <20201119060904.463807-3-drosen@google.com>
Mime-Version: 1.0
References: <20201119060904.463807-1-drosen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v4 2/3] fscrypt: Have filesystems handle their d_ops
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This shifts the responsibility of setting up dentry operations from
fscrypt to the individual filesystems, allowing them to have their own
operations while still setting fscrypt's d_revalidate as appropriate.

Most filesystems can just use generic_set_encrypted_ci_d_ops, unless
they have their own specific dentry operations as well. That operation
will set the minimal d_ops required under the circumstances.

Since the fscrypt d_ops are set later on, we must set all d_ops there,
since we cannot adjust those later on. This should not result in any
change in behavior.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Acked-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fname.c           | 4 ----
 fs/crypto/fscrypt_private.h | 1 -
 fs/crypto/hooks.c           | 1 -
 fs/ext4/dir.c               | 7 -------
 fs/ext4/ext4.h              | 4 ----
 fs/ext4/namei.c             | 1 +
 fs/ext4/super.c             | 5 -----
 fs/f2fs/dir.c               | 7 -------
 fs/f2fs/f2fs.h              | 3 ---
 fs/f2fs/namei.c             | 1 +
 fs/f2fs/super.c             | 1 -
 fs/ubifs/dir.c              | 1 +
 include/linux/fscrypt.h     | 7 +++++--
 13 files changed, 8 insertions(+), 35 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 1fbe6c24d705..cb3cfa6329ba 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -570,7 +570,3 @@ int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return valid;
 }
 EXPORT_SYMBOL_GPL(fscrypt_d_revalidate);
-
-const struct dentry_operations fscrypt_d_ops = {
-	.d_revalidate = fscrypt_d_revalidate,
-};
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 4f5806a3b73d..df9c48c1fbf7 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -294,7 +294,6 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 				  u32 orig_len, u32 max_len,
 				  u32 *encrypted_len_ret);
-extern const struct dentry_operations fscrypt_d_ops;
 
 /* hkdf.c */
 
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 20b0df47fe6a..9006fa983335 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -117,7 +117,6 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_NOKEY_NAME;
 		spin_unlock(&dentry->d_lock);
-		d_set_d_op(dentry, &fscrypt_d_ops);
 	}
 	return err;
 }
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ca50c90adc4c..e757319a4472 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -667,10 +667,3 @@ const struct file_operations ext4_dir_operations = {
 	.open		= ext4_dir_open,
 	.release	= ext4_release_dir,
 };
-
-#ifdef CONFIG_UNICODE
-const struct dentry_operations ext4_dentry_ops = {
-	.d_hash = generic_ci_d_hash,
-	.d_compare = generic_ci_d_compare,
-};
-#endif
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf9429484462..ad77f01d9e20 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3380,10 +3380,6 @@ static inline void ext4_unlock_group(struct super_block *sb,
 /* dir.c */
 extern const struct file_operations ext4_dir_operations;
 
-#ifdef CONFIG_UNICODE
-extern const struct dentry_operations ext4_dentry_ops;
-#endif
-
 /* file.c */
 extern const struct inode_operations ext4_file_inode_operations;
 extern const struct file_operations ext4_file_operations;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 33509266f5a0..12a417ff5648 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1614,6 +1614,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	struct buffer_head *bh;
 
 	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
+	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		return NULL;
 	if (err)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6633b20224d5..0288bedf46e1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4968,11 +4968,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount4;
 	}
 
-#ifdef CONFIG_UNICODE
-	if (sb->s_encoding)
-		sb->s_d_op = &ext4_dentry_ops;
-#endif
-
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
 		ext4_msg(sb, KERN_ERR, "get root dentry failed");
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 4b9ef8bbfa4a..71fdf5076461 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1099,10 +1099,3 @@ const struct file_operations f2fs_dir_operations = {
 	.compat_ioctl   = f2fs_compat_ioctl,
 #endif
 };
-
-#ifdef CONFIG_UNICODE
-const struct dentry_operations f2fs_dentry_ops = {
-	.d_hash = generic_ci_d_hash,
-	.d_compare = generic_ci_d_compare,
-};
-#endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cb700d797296..62b4f31d30e2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3767,9 +3767,6 @@ static inline void f2fs_update_sit_info(struct f2fs_sb_info *sbi) {}
 #endif
 
 extern const struct file_operations f2fs_dir_operations;
-#ifdef CONFIG_UNICODE
-extern const struct dentry_operations f2fs_dentry_ops;
-#endif
 extern const struct file_operations f2fs_file_operations;
 extern const struct inode_operations f2fs_file_inode_operations;
 extern const struct address_space_operations f2fs_dblock_aops;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 8fa37d1434de..6edb1ab579a1 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -497,6 +497,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	err = f2fs_prepare_lookup(dir, dentry, &fname);
+	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		goto out_splice;
 	if (err)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 00eff2f51807..f51d52591c99 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3427,7 +3427,6 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 
 		sbi->sb->s_encoding = encoding;
 		sbi->sb->s_encoding_flags = encoding_flags;
-		sbi->sb->s_d_op = &f2fs_dentry_ops;
 	}
 #else
 	if (f2fs_sb_has_casefold(sbi)) {
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 155521e51ac5..7a920434d741 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -203,6 +203,7 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	dbg_gen("'%pd' in dir ino %lu", dentry, dir->i_ino);
 
 	err = fscrypt_prepare_lookup(dir, dentry, &nm);
+	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		return d_splice_alias(NULL, dentry);
 	if (err)
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index a8f7a43f031b..e72f80482671 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -741,8 +741,11 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
  * directory's encryption key is available, then the lookup is assumed to be by
  * plaintext name; otherwise, it is assumed to be by no-key name.
  *
- * This also installs a custom ->d_revalidate() method which will invalidate the
- * dentry if it was created without the key and the key is later added.
+ * This will set DCACHE_NOKEY_NAME on the dentry if the lookup is by no-key
+ * name.  In this case the filesystem must assign the dentry a dentry_operations
+ * which contains fscrypt_d_revalidate (or contains a d_revalidate method that
+ * calls fscrypt_d_revalidate), so that the dentry will be invalidated if the
+ * directory's encryption key is later added.
  *
  * Return: 0 on success; -ENOENT if the directory's key is unavailable but the
  * filename isn't a valid no-key name, so a negative dentry should be created;
-- 
2.29.2.454.gaff20da3a2-goog

