Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5C7206B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 06:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbgFXEeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 00:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388754AbgFXEeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:34:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810AFC061797
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2020 21:34:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e82so994938ybh.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2020 21:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oIpugbU5sR1v5cx83NdeAHw6WTgb3IE7fApUBh/rIXg=;
        b=AB9aLx/MqLoeRt0OUFmAUYHpCwdCqbxRZf8hJhcfAjUIi9edm8K33AoKanIpw57jXK
         j0043wSEcQEM0/izVowsZ19//M0wA7aW1w8Ijp43zr+Sqd1zDqy+GfpF3EeGmXd0J1rY
         1c+SZ7T9tjg2nGKWfUm89s8a7Uvkb5gL5a6vTlo04TJ8k8UAwlgRrbWfctULFLpbJnd3
         hiUN0NGLOQH41zwXynPjNcoIgU5obJg/mbhtmMv/fg50rry7q9qjcf+wP8oWpCnIg14s
         PvSSArv1aI2kvu1g26ehFi8i7TLVdHhXCSxkjkWnRBvdeEcbBE1PaRIzW2potMHM9LLD
         olwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oIpugbU5sR1v5cx83NdeAHw6WTgb3IE7fApUBh/rIXg=;
        b=fN5/Qmae3lQh2U6SF3uEb7zAPtLWMyEif4ABo25XRtsDEqMuxNttPAphdhd9+mCRYY
         ykqK/dJ/5iLo7h6GvylKwfvvwHdWUYuciD7K4CYbRuG4PTP5fikOZMpxhwTGM8esPKn3
         /YXoSDoPafoAlyhBO3+1BZvND/kmOcbrucypWfpe1t8yNSI0H3fMr6RScgJTYIH1EIuL
         YO4FwZ9gH76ZwVK/rB/ZqjE7GJ7bpH/gVqk/nNeP+SXa/wT4bK3uZwDgDaHbGfHvIaZj
         zTisRU7uCMvDPYPF9px0qJkvg/x9C4DtW6ovnQ5+lOtRZoEwppmi3FYM1Awv7uo5Cmno
         E5gA==
X-Gm-Message-State: AOAM530QGPR2SIZrnSbBFEmOEDdmtQoAiHhRebxqF2+aQBIbRZeS0wuQ
        aV6/qW4ZR35AmDQ6F67rZd8EQw1rZEI=
X-Google-Smtp-Source: ABdhPJweodiV0+TIT1CXhXTbUD/WmocgCV4NsBOBycExmdY1sXG4JLzocVFiN+F9ie03D7wAROaCpUB/c2A=
X-Received: by 2002:a25:e747:: with SMTP id e68mr38463609ybh.341.1592973241706;
 Tue, 23 Jun 2020 21:34:01 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:33:40 -0700
In-Reply-To: <20200624043341.33364-1-drosen@google.com>
Message-Id: <20200624043341.33364-4-drosen@google.com>
Mime-Version: 1.0
References: <20200624043341.33364-1-drosen@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v9 3/4] f2fs: Use generic casefolding support
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This switches f2fs over to the generic support provided in
commit 5f829feca774 ("fs: Add standard casefolding support")

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/dir.c           | 84 +++++------------------------------------
 fs/f2fs/f2fs.h          |  4 --
 fs/f2fs/super.c         | 10 ++---
 fs/f2fs/sysfs.c         | 10 +++--
 include/linux/f2fs_fs.h |  3 --
 5 files changed, 21 insertions(+), 90 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d35976785e8c5..b59c2673daa09 100644
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
+			if (sb_has_enc_strict_mode(sb))
 				return -EINVAL;
 			/* fall back to treating name as opaque byte sequence */
 		}
@@ -215,8 +216,9 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 static bool f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
 			       const u8 *de_name, u32 de_name_len)
 {
-	const struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
-	const struct unicode_map *um = sbi->s_encoding;
+	const struct super_block *sb = dir->i_sb;
+	const struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	const struct unicode_map *um = sb->s_encoding;
 	struct qstr entry = QSTR_INIT(de_name, de_name_len);
 	int res;
 
@@ -226,7 +228,7 @@ static bool f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
 		 * In strict mode, ignore invalid names.  In non-strict mode,
 		 * fall back to treating them as opaque byte sequences.
 		 */
-		if (f2fs_has_strict_mode(sbi) || name->len != entry.len)
+		if (sb_has_enc_strict_mode(sb) || name->len != entry.len)
 			return false;
 		return !memcmp(name->name, entry.name, name->len);
 	}
@@ -1107,75 +1109,9 @@ const struct file_operations f2fs_dir_operations = {
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
 
 const struct dentry_operations f2fs_dentry_ops = {
-	.d_hash = f2fs_d_hash,
-	.d_compare = f2fs_d_compare,
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
 };
 #endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b35a50f4953c5..d11ffe26bfded 100644
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
index 20e56b0fa46a9..cca7a83ffa089 100644
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
index e877c59b9fdb4..8bee99ab3978e 100644
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
index 3c383ddd92ddd..a5dbb57a687fb 100644
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
2.27.0.111.gc72c7da667-goog

