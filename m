Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58245274E32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 03:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgIWBJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 21:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgIWBJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:09:30 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DDCC0613D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 18:09:30 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t4so12833030qvr.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 18:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lqgM8oadNkPm8Fe218rhEmZBJx+Ca+DUOMlSvGhuVQA=;
        b=wOkIUBGVgChISjZmRtkAY7aWbnpSNQ8a5fzHhYT0H5LeS9eNg/OaAk8Jwf0DKYXG13
         5ZtxxjSydHSJokLrLOQQc9f+Zj+NcDQTPLPv3IZmq4W/kS81InLBfNmsIaYF5GCzWdn3
         7cgrM72VexYPE/vTZ3ayKrKlnoG/WayAL28zMz+4c8D1H2Y++OlsXLfZfYoY2qcj/Yho
         PZ7Xfd0n66r6DEkRFg0O12d7WEzAfUxtkG0/GYkV5jkJ6+Tls6KdT9BitHsz1tvjKd2Q
         BdE5wJSOQ9QX5DtWdBbh0OdhJUPWPU2r5s9LNMXIRuquE2SSK7xWbBJFaSqIoyVv1lmH
         LwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lqgM8oadNkPm8Fe218rhEmZBJx+Ca+DUOMlSvGhuVQA=;
        b=CuQFwkEeOqxibEvJRuVavaEWkPdX7Axg/9DwixgTcosdyXXgbc6GWs2cAQDpVC6CC1
         PK0DIGm1Py8Y+rWEw1qaeVLjRxnxaU7mTpWoRcCpap3zloGM62XqJt1rR6avWitiAV2f
         2/oBcwXKfCDsZzn3tQ/1ab+kk+didHBrUJLeH8fdnegwCB4etsA3YyK0LSUdFfohxPEB
         3FpjY0aLJ0KQCZriJelRqh1PmkyQXSAnDACjO3dpnH9RpSAHhADQBVvfa2fJH5QtU4sS
         7ox7KaA3juLVz6/VeqN28o8CotdQn0KKceNHdmjy8RZAHycPgoaCoIp0WaXVQnh7+MgY
         6QIg==
X-Gm-Message-State: AOAM533I6DLsS1uv6gkQkYxG+/RyGwSnUIDmz2WZRT7FpXuYjRwpu3PE
        mNuswjxt0K29mIWidNeUuGgREuoepGM=
X-Google-Smtp-Source: ABdhPJybJDCLesGRmXosZksow4wlCsDrrHoz1rIa/Dw9+CsDU/5/heMGncoMbOrKHxR0JEUJNlhYmu5UuZU=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:ad4:57cc:: with SMTP id y12mr8997020qvx.48.1600823369094;
 Tue, 22 Sep 2020 18:09:29 -0700 (PDT)
Date:   Wed, 23 Sep 2020 01:01:50 +0000
In-Reply-To: <20200923010151.69506-1-drosen@google.com>
Message-Id: <20200923010151.69506-5-drosen@google.com>
Mime-Version: 1.0
References: <20200923010151.69506-1-drosen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 4/5] fscrypt: Have filesystems handle their d_ops
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
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
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
---
 fs/crypto/fname.c       | 4 ----
 fs/crypto/hooks.c       | 1 -
 fs/ext4/dir.c           | 7 -------
 fs/ext4/ext4.h          | 4 ----
 fs/ext4/namei.c         | 1 +
 fs/ext4/super.c         | 5 -----
 fs/f2fs/dir.c           | 7 -------
 fs/f2fs/f2fs.h          | 3 ---
 fs/f2fs/namei.c         | 1 +
 fs/f2fs/super.c         | 1 -
 fs/ubifs/dir.c          | 1 +
 include/linux/fscrypt.h | 5 +++--
 12 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index d45db23ff6c4..efa942e3ab53 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -581,7 +581,3 @@ int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return valid;
 }
 EXPORT_SYMBOL_GPL(fscrypt_d_revalidate);
-
-const struct dentry_operations fscrypt_d_ops = {
-	.d_revalidate = fscrypt_d_revalidate,
-};
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 09fb8aa0f2e9..7d6898ca152a 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -118,7 +118,6 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_ENCRYPTED_NAME;
 		spin_unlock(&dentry->d_lock);
-		d_set_d_op(dentry, &fscrypt_d_ops);
 	}
 	return err;
 }
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index b437120f0b3f..f0135042c2ad 100644
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
index 5df0fbd6add4..cbde8447eddd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3247,10 +3247,6 @@ static inline void ext4_unlock_group(struct super_block *sb,
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
index ea7dee80c8a4..592ea2f8ea19 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1615,6 +1615,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	struct buffer_head *bh;
 
 	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
+	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		return NULL;
 	if (err)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8a261a6bb608..ce67540bd882 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4719,11 +4719,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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
index a18f839b6fb2..0766e6250a88 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1106,10 +1106,3 @@ const struct file_operations f2fs_dir_operations = {
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
index 61fd78b1b1bd..af1d469e8c1e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3774,9 +3774,6 @@ static inline void f2fs_update_sit_info(struct f2fs_sb_info *sbi) {}
 #endif
 
 extern const struct file_operations f2fs_dir_operations;
-#ifdef CONFIG_UNICODE
-extern const struct dentry_operations f2fs_dentry_ops;
-#endif
 extern const struct file_operations f2fs_file_operations;
 extern const struct inode_operations f2fs_file_inode_operations;
 extern const struct address_space_operations f2fs_dblock_aops;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 90565432559c..70a8e516fd32 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -492,6 +492,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	err = f2fs_prepare_lookup(dir, dentry, &fname);
+	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		goto out_splice;
 	if (err)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5fe614011e41..63c744c6aeff 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3410,7 +3410,6 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 
 		sbi->sb->s_encoding = encoding;
 		sbi->sb->s_encoding_flags = encoding_flags;
-		sbi->sb->s_d_op = &f2fs_dentry_ops;
 	}
 #else
 	if (f2fs_sb_has_casefold(sbi)) {
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 9d042942d8b2..fdae78934c02 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -209,6 +209,7 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	dbg_gen("'%pd' in dir ino %lu", dentry, dir->i_ino);
 
 	err = fscrypt_prepare_lookup(dir, dentry, &nm);
+	generic_set_encrypted_ci_d_ops(dentry);
 	if (err == -ENOENT)
 		return d_splice_alias(NULL, dentry);
 	if (err)
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 265b1e9119dc..fc04452921b4 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -740,8 +740,9 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
  * filenames are presented in encrypted form.  Therefore, we'll try to set up
  * the directory's encryption key, but even without it the lookup can continue.
  *
- * This also installs a custom ->d_revalidate() method which will invalidate the
- * dentry if it was created without the key and the key is later added.
+ * After calling this function, a filesystem should ensure that its dentry
+ * operations contain fscrypt_d_revalidate if DCACHE_ENCRYPTED_NAME was set,
+ * so that the dentry can be invalidated if the key is later added.
  *
  * Return: 0 on success; -ENOENT if key is unavailable but the filename isn't a
  * correctly formed encoded ciphertext name, so a negative dentry should be
-- 
2.28.0.681.g6f77f65b4e-goog

