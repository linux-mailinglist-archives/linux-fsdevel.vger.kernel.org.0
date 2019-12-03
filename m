Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0023B10F6B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfLCFL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:11:29 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50987 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfLCFL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:11:29 -0500
Received: by mail-pg1-f202.google.com with SMTP id u197so1075276pgc.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 21:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s9Z9LjD9ymkQQUZ+VH0GlQne8IEw1wiPyT49On1Az6o=;
        b=mdyqPGowQAy57ke3pYs7WyHpLTx6DoPtf9TfYQjz/Wk+gjXPr/XwnFzpjLq1XJAKqG
         8m7yKkkZyQCRvikIWLKWiJWZZ8l+6pxhzmbcNvJpzaMlCXhj3rSFjcbTILSy6YQY+/KO
         RS8sSTcxK2ZxwMHN0CzjpfBjQ3UxxQ+dIN9EdvRVCjVvok8k3J1TtYBTNAcQEx7hKcjs
         bSiyKlUYClbhnsNkTXpmB2dvoNA+CnskMavt1ePN4tih7Hv4me1ERZ9j2B4TbRAC5M42
         2rSl/cLdZzgns+5G12aLkOv8bx67rCXuk95KPGZvnZR6e55nK4gM1UhZ1PK78G9DV48O
         g1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s9Z9LjD9ymkQQUZ+VH0GlQne8IEw1wiPyT49On1Az6o=;
        b=RO6fFzkCyv2l9IEMKHX9CZNyH9ZjGyGFjhsqAbFw6aQkZ1UOtjl2Sf6s9GB2eAN29g
         V/UqddJ0iTm5cO7extgJ9E15SnbiNtRbhxGNJA2acUlLGGbYO86CkjCR4W1LIW/o0KSH
         Js6XilgdYjxKUrUOwNFPD5I+Hl7gdjXN5JiTu0bXmE9tInZASLX22OOmq3aLG4Sh1S/w
         jSuXp4s2csL/5WdqKEnnzaw8IETBdEW301QDR9hh22sSBUryimr/V3btHucQtHyux5Gt
         eE+knt64dpcSp8akTgFgZEtNyufnBfMjYffY5TusKftVLnabGVOTCeW49GkeVKuGq0RL
         LPzA==
X-Gm-Message-State: APjAAAWcrsdS3ae8qZcfpb+jKTu4Xx3hAxfl6z1uP9llXdgw0i9P/FmE
        nVt9+ecPsyLS4AS1aJugdIwBG/5B3Yo=
X-Google-Smtp-Source: APXvYqwC9P8HaWM223eOEegLFhN5JV0hs/CGnhSkDLW2WnMpfDSnC18x/rIf914nZTxS1PdDesEi4SVAvns=
X-Received: by 2002:a63:480f:: with SMTP id v15mr3361962pga.201.1575349888187;
 Mon, 02 Dec 2019 21:11:28 -0800 (PST)
Date:   Mon,  2 Dec 2019 21:10:45 -0800
In-Reply-To: <20191203051049.44573-1-drosen@google.com>
Message-Id: <20191203051049.44573-5-drosen@google.com>
Mime-Version: 1.0
References: <20191203051049.44573-1-drosen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 4/8] vfs: Fold casefolding into vfs
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ext4 and F2fs are both using casefolding, and they, along with any other
filesystem that adds the feature, will be using identical dentry_ops.
Additionally, those dentry ops interfere with the dentry_ops required
for fscrypt once we add support for casefolding and encryption.
Moving this into the vfs removes code duplication as well as the
complication with encryption.

Currently this is pretty close to just moving the existing f2fs/ext4
code up a level into the vfs, although there is a lot of room for
improvement now.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/dcache.c        | 35 +++++++++++++++++++++++++++++++++++
 fs/namei.c         | 43 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/fs.h | 12 ++++++++++++
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f7931b682a0d..575f3c2c3f77 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/unicode.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -228,6 +229,13 @@ static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char
 
 #endif
 
+bool needs_casefold(const struct inode *dir)
+{
+	return IS_CASEFOLDED(dir) &&
+			(!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir));
+}
+EXPORT_SYMBOL(needs_casefold);
+
 static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *ct, unsigned tcount)
 {
 	/*
@@ -247,7 +255,19 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 	 * be no NUL in the ct/tcount data)
 	 */
 	const unsigned char *cs = READ_ONCE(dentry->d_name.name);
+#ifdef CONFIG_UNICODE
+	struct inode *parent = dentry->d_parent->d_inode;
 
+	if (unlikely(needs_casefold(parent))) {
+		const struct qstr n1 = QSTR_INIT(cs, tcount);
+		const struct qstr n2 = QSTR_INIT(ct, tcount);
+		int result = utf8_strncasecmp(dentry->d_sb->s_encoding,
+						&n1, &n2);
+
+		if (result >= 0 || sb_has_enc_strict_mode(dentry->d_sb))
+			return result;
+	}
+#endif
 	return dentry_string_cmp(cs, ct, tcount);
 }
 
@@ -2404,7 +2424,22 @@ struct dentry *d_hash_and_lookup(struct dentry *dir, struct qstr *name)
 	 * calculate the standard hash first, as the d_op->d_hash()
 	 * routine may choose to leave the hash value unchanged.
 	 */
+#ifdef CONFIG_UNICODE
+	unsigned char *hname = NULL;
+	int hlen = name->len;
+
+	if (IS_CASEFOLDED(dir->d_inode)) {
+		hname = kmalloc(PATH_MAX, GFP_ATOMIC);
+		if (!hname)
+			return ERR_PTR(-ENOMEM);
+		hlen = utf8_casefold(dir->d_sb->s_encoding,
+					name, hname, PATH_MAX);
+	}
+	name->hash = full_name_hash(dir, hname ?: name->name, hlen);
+	kfree(hname);
+#else
 	name->hash = full_name_hash(dir, name->name, name->len);
+#endif
 	if (dir->d_flags & DCACHE_OP_HASH) {
 		int err = dir->d_op->d_hash(dir, name);
 		if (unlikely(err < 0))
diff --git a/fs/namei.c b/fs/namei.c
index 2dda552bcf7a..b8d5cb0994ec 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -39,6 +39,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/unicode.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -2062,6 +2063,10 @@ static inline u64 hash_name(const void *salt, const char *name)
 static int link_path_walk(const char *name, struct nameidata *nd)
 {
 	int err;
+#ifdef CONFIG_UNICODE
+	char *hname = NULL;
+	int hlen = 0;
+#endif
 
 	if (IS_ERR(name))
 		return PTR_ERR(name);
@@ -2078,9 +2083,21 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		err = may_lookup(nd);
 		if (err)
 			return err;
-
+#ifdef CONFIG_UNICODE
+		if (needs_casefold(nd->path.dentry->d_inode)) {
+			struct qstr str = QSTR_INIT(name, PATH_MAX);
+
+			hname = kmalloc(PATH_MAX, GFP_ATOMIC);
+			if (!hname)
+				return -ENOMEM;
+			hlen = utf8_casefold(nd->path.dentry->d_sb->s_encoding,
+						&str, hname, PATH_MAX);
+		}
+		hash_len = hash_name(nd->path.dentry, hname ?: name);
+		kfree(hname);
+#else
 		hash_len = hash_name(nd->path.dentry, name);
-
+#endif
 		type = LAST_NORM;
 		if (name[0] == '.') switch (hashlen_len(hash_len)) {
 			case 2:
@@ -2452,9 +2469,29 @@ EXPORT_SYMBOL(vfs_path_lookup);
 static int lookup_one_len_common(const char *name, struct dentry *base,
 				 int len, struct qstr *this)
 {
+#ifdef CONFIG_UNICODE
+	char *hname = NULL;
+	int hlen = len;
+
+	if (needs_casefold(base->d_inode)) {
+		struct qstr str = QSTR_INIT(name, len);
+
+		hname = kmalloc(PATH_MAX, GFP_ATOMIC);
+		if (!hname)
+			return -ENOMEM;
+		hlen = utf8_casefold(base->d_sb->s_encoding,
+					&str, hname, PATH_MAX);
+	}
+	this->hash = full_name_hash(base, hname ?: name, hlen);
+	kvfree(hname);
+#else
+	this->hash = full_name_hash(base, name, len);
+#endif
 	this->name = name;
 	this->len = len;
-	this->hash = full_name_hash(base, name, len);
+#ifdef CONFIG_UNICODE
+	kfree(hname);
+#endif
 	if (!len)
 		return -EACCES;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c159a8bdee8b..38d1c20f3e6f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1382,6 +1382,12 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_ACTIVE	(1<<30)
 #define SB_NOUSER	(1<<31)
 
+/* These flags relate to encoding and casefolding */
+#define SB_ENC_STRICT_MODE_FL	(1 << 0)
+
+#define sb_has_enc_strict_mode(sb) \
+	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
+
 /*
  *	Umount options
  */
@@ -1449,6 +1455,10 @@ struct super_block {
 #endif
 #ifdef CONFIG_FS_VERITY
 	const struct fsverity_operations *s_vop;
+#endif
+#ifdef CONFIG_UNICODE
+	struct unicode_map *s_encoding;
+	__u16 s_encoding_flags;
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
@@ -2044,6 +2054,8 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
 
+extern bool needs_casefold(const struct inode *dir);
+
 static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 {
 	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
-- 
2.24.0.393.g34dc348eaf-goog

