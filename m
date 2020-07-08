Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C715217D59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 05:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgGHDGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 23:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgGHDGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:06:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9784C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 20:06:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k127so45184156ybk.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5nkJ8+oFRw79lut00n63xD+rfJ2Q+7+cyGuaN1iEOi0=;
        b=Hsc85EsrZAqVPTiTz4Sm1HZZlpIpv7CbK5mb2ygwR7pRTzeK5Fq2zzP/rasX1++hut
         /9ysR5yt2Sp8I/9d8UjFmkz71fI15poYJS68mXJeI4+l4rwqXFsSuiideuf8XUmJex9m
         +NY8x8vWWdZviZ1PQ4VPlXSYao8Hw4Rsj3hPTgcCSYJBjfKl3epMYflcTgjEa6lbEJ8n
         npm4ZCw6AgZF2QQklli0fneO3MLaTTUapdv2Pc2QBz+XqxBr7hoGDdQB/i548iVby0UH
         lq0r7eWoGjOvt885GtdTrH0siVPe6aIVe1AeYsHbrNXWHS7NTzxaZbsJv3KKTlix74vM
         KfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5nkJ8+oFRw79lut00n63xD+rfJ2Q+7+cyGuaN1iEOi0=;
        b=tLR/LfB/ssKdvm9tRSljspuSBooHc1iD6xtOgKuOxvSI/IBB61Txzl5EYBB3EIB5oa
         juAbNF9fb//JKRV0K/k4w1HDVdes8uuuqC2jOshLrE00tRpMJPAChTizz7xUXL9bza6G
         RZylFV5pfRkpRYJuENeXItGtQS9vz5/fIZM3fyAJpL3Gn0wAmXjqg10wJmAwR1xjd2cW
         Vw05xup/FnmtxgRmWXP+dWJneu8NnxqlXHuKvnYx+x1Jg7rtmbmwZhQVheXL4LnoBjwW
         o68INkTdO9rKdhjSlfQNJCnVuObRCBz0Dxqm6dSl/ykc1vEXAV18O6t3KvYOZUcI1IjW
         KJGA==
X-Gm-Message-State: AOAM530hlWoEFr3dXBttNMAFpa7pPlQ77zNFK3n09EZnqDyg2RwHHlfJ
        XU5pMAZ4Nf9FNeqxhJTF1PM3ExuKRwI=
X-Google-Smtp-Source: ABdhPJwdqkMfMk+77SMXKZi5nTGPs6OokrAG8YKeZtdVkw0rAkY7XWRfX6IZ3bwp5r9x3k6VXadZtEoqKSI=
X-Received: by 2002:a25:b68d:: with SMTP id s13mr1070851ybj.330.1594177562876;
 Tue, 07 Jul 2020 20:06:02 -0700 (PDT)
Date:   Tue,  7 Jul 2020 20:05:51 -0700
In-Reply-To: <20200708030552.3829094-1-drosen@google.com>
Message-Id: <20200708030552.3829094-4-drosen@google.com>
Mime-Version: 1.0
References: <20200708030552.3829094-1-drosen@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v11 3/4] f2fs: Use generic casefolding support
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This switches f2fs over to the generic support provided in
the previous patch.

Since casefolded dentries behave the same in ext4 and f2fs, we decrease
the maintenance burden by unifying them, and any optimizations will
immediately apply to both.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/dir.c           | 84 +++++------------------------------------
 fs/f2fs/f2fs.h          |  4 --
 fs/f2fs/super.c         | 10 ++---
 fs/f2fs/sysfs.c         | 10 +++--
 include/linux/f2fs_fs.h |  3 --
 5 files changed, 20 insertions(+), 91 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d35976785e8c..ff61f3a9c11d 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -75,21 +75,22 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 			      struct f2fs_filename *fname)
 {
 #ifdef CONFIG_UNICODE
-	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
+	struct super_block *sb = dir->i_sb;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 
 	if (IS_CASEFOLDED(dir)) {
 		fname->cf_name.name = f2fs_kmalloc(sbi, F2FS_NAME_LEN,
 						   GFP_NOFS);
 		if (!fname->cf_name.name)
 			return -ENOMEM;
-		fname->cf_name.len = utf8_casefold(sbi->s_encoding,
+		fname->cf_name.len = utf8_casefold(sb->s_encoding,
 						   fname->usr_fname,
 						   fname->cf_name.name,
 						   F2FS_NAME_LEN);
 		if ((int)fname->cf_name.len <= 0) {
 			kfree(fname->cf_name.name);
 			fname->cf_name.name = NULL;
-			if (f2fs_has_strict_mode(sbi))
+			if (sb_has_strict_encoding(sb))
 				return -EINVAL;
 			/* fall back to treating name as opaque byte sequence */
 		}
@@ -215,8 +216,8 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 static bool f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
 			       const u8 *de_name, u32 de_name_len)
 {
-	const struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
-	const struct unicode_map *um = sbi->s_encoding;
+	const struct super_block *sb = dir->i_sb;
+	const struct unicode_map *um = sb->s_encoding;
 	struct qstr entry = QSTR_INIT(de_name, de_name_len);
 	int res;
 
@@ -226,7 +227,7 @@ static bool f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
 		 * In strict mode, ignore invalid names.  In non-strict mode,
 		 * fall back to treating them as opaque byte sequences.
 		 */
-		if (f2fs_has_strict_mode(sbi) || name->len != entry.len)
+		if (sb_has_strict_encoding(sb) || name->len != entry.len)
 			return false;
 		return !memcmp(name->name, entry.name, name->len);
 	}
@@ -1107,75 +1108,8 @@ const struct file_operations f2fs_dir_operations = {
 };
 
 #ifdef CONFIG_UNICODE
-static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
-			  const char *str, const struct qstr *name)
-{
-	const struct dentry *parent = READ_ONCE(dentry->d_parent);
-	const struct inode *dir = READ_ONCE(parent->d_inode);
-	const struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
-	struct qstr entry = QSTR_INIT(str, len);
-	char strbuf[DNAME_INLINE_LEN];
-	int res;
-
-	if (!dir || !IS_CASEFOLDED(dir))
-		goto fallback;
-
-	/*
-	 * If the dentry name is stored in-line, then it may be concurrently
-	 * modified by a rename.  If this happens, the VFS will eventually retry
-	 * the lookup, so it doesn't matter what ->d_compare() returns.
-	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
-	 * string.  Therefore, we have to copy the name into a temporary buffer.
-	 */
-	if (len <= DNAME_INLINE_LEN - 1) {
-		memcpy(strbuf, str, len);
-		strbuf[len] = 0;
-		entry.name = strbuf;
-		/* prevent compiler from optimizing out the temporary buffer */
-		barrier();
-	}
-
-	res = utf8_strncasecmp(sbi->s_encoding, name, &entry);
-	if (res >= 0)
-		return res;
-
-	if (f2fs_has_strict_mode(sbi))
-		return -EINVAL;
-fallback:
-	if (len != name->len)
-		return 1;
-	return !!memcmp(str, name->name, len);
-}
-
-static int f2fs_d_hash(const struct dentry *dentry, struct qstr *str)
-{
-	struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
-	const struct unicode_map *um = sbi->s_encoding;
-	const struct inode *inode = READ_ONCE(dentry->d_inode);
-	unsigned char *norm;
-	int len, ret = 0;
-
-	if (!inode || !IS_CASEFOLDED(inode))
-		return 0;
-
-	norm = f2fs_kmalloc(sbi, PATH_MAX, GFP_ATOMIC);
-	if (!norm)
-		return -ENOMEM;
-
-	len = utf8_casefold(um, str, norm, PATH_MAX);
-	if (len < 0) {
-		if (f2fs_has_strict_mode(sbi))
-			ret = -EINVAL;
-		goto out;
-	}
-	str->hash = full_name_hash(dentry, norm, len);
-out:
-	kvfree(norm);
-	return ret;
-}
-
 const struct dentry_operations f2fs_dentry_ops = {
-	.d_hash = f2fs_d_hash,
-	.d_compare = f2fs_d_compare,
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
 };
 #endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b35a50f4953c..d11ffe26bfde 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1402,10 +1402,6 @@ struct f2fs_sb_info {
 	int valid_super_block;			/* valid super block no */
 	unsigned long s_flag;				/* flags for sbi */
 	struct mutex writepages;		/* mutex for writepages() */
-#ifdef CONFIG_UNICODE
-	struct unicode_map *s_encoding;
-	__u16 s_encoding_flags;
-#endif
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 20e56b0fa46a..cca7a83ffa08 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1257,7 +1257,7 @@ static void f2fs_put_super(struct super_block *sb)
 	for (i = 0; i < NR_PAGE_TYPE; i++)
 		kvfree(sbi->write_io[i]);
 #ifdef CONFIG_UNICODE
-	utf8_unload(sbi->s_encoding);
+	utf8_unload(sb->s_encoding);
 #endif
 	kvfree(sbi);
 }
@@ -3278,7 +3278,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 {
 #ifdef CONFIG_UNICODE
-	if (f2fs_sb_has_casefold(sbi) && !sbi->s_encoding) {
+	if (f2fs_sb_has_casefold(sbi) && !sbi->sb->s_encoding) {
 		const struct f2fs_sb_encodings *encoding_info;
 		struct unicode_map *encoding;
 		__u16 encoding_flags;
@@ -3309,8 +3309,8 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 			 "%s-%s with flags 0x%hx", encoding_info->name,
 			 encoding_info->version?:"\b", encoding_flags);
 
-		sbi->s_encoding = encoding;
-		sbi->s_encoding_flags = encoding_flags;
+		sbi->sb->s_encoding = encoding;
+		sbi->sb->s_encoding_flags = encoding_flags;
 		sbi->sb->s_d_op = &f2fs_dentry_ops;
 	}
 #else
@@ -3806,7 +3806,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		kvfree(sbi->write_io[i]);
 
 #ifdef CONFIG_UNICODE
-	utf8_unload(sbi->s_encoding);
+	utf8_unload(sb->s_encoding);
 #endif
 free_options:
 #ifdef CONFIG_QUOTA
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e877c59b9fdb..8bee99ab3978 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -176,12 +176,14 @@ static ssize_t encoding_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
 #ifdef CONFIG_UNICODE
+	struct super_block *sb = sbi->sb;
+
 	if (f2fs_sb_has_casefold(sbi))
 		return snprintf(buf, PAGE_SIZE, "%s (%d.%d.%d)\n",
-			sbi->s_encoding->charset,
-			(sbi->s_encoding->version >> 16) & 0xff,
-			(sbi->s_encoding->version >> 8) & 0xff,
-			sbi->s_encoding->version & 0xff);
+			sb->s_encoding->charset,
+			(sb->s_encoding->version >> 16) & 0xff,
+			(sb->s_encoding->version >> 8) & 0xff,
+			sb->s_encoding->version & 0xff);
 #endif
 	return sprintf(buf, "(none)");
 }
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 3c383ddd92dd..a5dbb57a687f 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -38,9 +38,6 @@
 #define F2FS_MAX_QUOTAS		3
 
 #define F2FS_ENC_UTF8_12_1	1
-#define F2FS_ENC_STRICT_MODE_FL	(1 << 0)
-#define f2fs_has_strict_mode(sbi) \
-	(sbi->s_encoding_flags & F2FS_ENC_STRICT_MODE_FL)
 
 #define F2FS_IO_SIZE(sbi)	(1 << F2FS_OPTION(sbi).write_io_size_bits) /* Blocks */
 #define F2FS_IO_SIZE_KB(sbi)	(1 << (F2FS_OPTION(sbi).write_io_size_bits + 2)) /* KB */
-- 
2.27.0.383.g050319c2ae-goog

