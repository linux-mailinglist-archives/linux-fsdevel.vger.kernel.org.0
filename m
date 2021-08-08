Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B973E3B83
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhHHQZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhHHQZe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA04660EE7;
        Sun,  8 Aug 2021 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439915;
        bh=y+p38IXi4M4D7x3ldT5SvR2OPbx9cSHtqSZfSJc2Zfk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=omiygZMOfnHVGZb4pf5LQ1AISMQgpo8hBzt1XPXlbcr2KiKk/xK1/QC8z8UVqwr1d
         4Jy0eoyJnI8Cvl7IWzK/XPX9dpGB1fAAx4vuk+jipiW1+UsVlf4f5Oe326O0pisHFA
         z9AsZ2NMLrn/YizILTnl9PYbIdHcmZ15/eSPpZ9wUC2sn/Q70+ClY8WC0/2BG6HXAj
         px94HOOKjVr1u/I7pXslkJnjr4fjXsj7ifrAQKHE0OIMLPknoo6Tq3kMEQdmZqIXdS
         F+iwEXJtZY311qYsdWI1l8xBm7tbdDw1ncM5H2W3ISvZdBejo4vWXBooZKhAYqQ5Od
         RMhL/RJ7NT/7A==
Received: by pali.im (Postfix)
        id DE4691430; Sun,  8 Aug 2021 18:25:12 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 01/20] fat: Fix iocharset=utf8 mount option
Date:   Sun,  8 Aug 2021 18:24:34 +0200
Message-Id: <20210808162453.1653-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently iocharset=utf8 mount option is broken and error is printed to
dmesg when it is used. To use UTF-8 as iocharset, it is required to use
utf8=1 mount option.

Fix iocharset=utf8 mount option to use be equivalent to the utf8=1 mount
option and remove printing error from dmesg.

FAT by definition is case-insensitive but current Linux implementation is
case-sensitive for non-ASCII characters when UTF-8 is used. This patch does
not change this UTF-8 behavior. Only more comments in fat_utf8_strnicmp()
function are added about it.

After this patch iocharset=utf8 starts working, so there is no need to have
separate config option FAT_DEFAULT_UTF8 as FAT_DEFAULT_IOCHARSET for utf8
also starts working. So remove redundant config option FAT_DEFAULT_UTF8.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/fat/Kconfig      | 15 ---------------
 fs/fat/dir.c        | 17 +++++++----------
 fs/fat/fat.h        | 22 ++++++++++++++++++++++
 fs/fat/inode.c      | 28 +++++++++++-----------------
 fs/fat/namei_vfat.c | 26 +++++++++++++++++++-------
 5 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index 66532a71e8fd..a31594137d5e 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -100,18 +100,3 @@ config FAT_DEFAULT_IOCHARSET
 
 	  Enable any character sets you need in File Systems/Native Language
 	  Support.
-
-config FAT_DEFAULT_UTF8
-	bool "Enable FAT UTF-8 option by default"
-	depends on VFAT_FS
-	default n
-	help
-	  Set this if you would like to have "utf8" mount option set
-	  by default when mounting FAT filesystems.
-
-	  Even if you say Y here can always disable UTF-8 for
-	  particular mount by adding "utf8=0" to mount options.
-
-	  Say Y if you use UTF-8 encoding for file names, N otherwise.
-
-	  See <file:Documentation/filesystems/vfat.rst> for more information.
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index c4a274285858..49fe8dc6e5f0 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -33,11 +33,6 @@
 #define FAT_MAX_UNI_CHARS	((MSDOS_SLOTS - 1) * 13 + 1)
 #define FAT_MAX_UNI_SIZE	(FAT_MAX_UNI_CHARS * sizeof(wchar_t))
 
-static inline unsigned char fat_tolower(unsigned char c)
-{
-	return ((c >= 'A') && (c <= 'Z')) ? c+32 : c;
-}
-
 static inline loff_t fat_make_i_pos(struct super_block *sb,
 				    struct buffer_head *bh,
 				    struct msdos_dir_entry *de)
@@ -258,10 +253,12 @@ static inline int fat_name_match(struct msdos_sb_info *sbi,
 	if (a_len != b_len)
 		return 0;
 
-	if (sbi->options.name_check != 's')
-		return !nls_strnicmp(sbi->nls_io, a, b, a_len);
-	else
+	if (sbi->options.name_check == 's')
 		return !memcmp(a, b, a_len);
+	else if (sbi->options.utf8)
+		return !fat_utf8_strnicmp(a, b, a_len);
+	else
+		return !nls_strnicmp(sbi->nls_io, a, b, a_len);
 }
 
 enum { PARSE_INVALID = 1, PARSE_NOT_LONGNAME, PARSE_EOF, };
@@ -384,7 +381,7 @@ static int fat_parse_short(struct super_block *sb,
 					de->lcase & CASE_LOWER_BASE);
 		if (chl <= 1) {
 			if (!isvfat)
-				ptname[i] = nocase ? c : fat_tolower(c);
+				ptname[i] = nocase ? c : fat_ascii_to_lower(c);
 			i++;
 			if (c != ' ') {
 				name_len = i;
@@ -421,7 +418,7 @@ static int fat_parse_short(struct super_block *sb,
 		if (chl <= 1) {
 			k++;
 			if (!isvfat)
-				ptname[i] = nocase ? c : fat_tolower(c);
+				ptname[i] = nocase ? c : fat_ascii_to_lower(c);
 			i++;
 			if (c != ' ') {
 				name_len = i;
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 02d4d4234956..0cd15fb3b042 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -310,6 +310,28 @@ static inline void fatwchar_to16(__u8 *dst, const wchar_t *src, size_t len)
 #endif
 }
 
+static inline unsigned char fat_ascii_to_lower(unsigned char c)
+{
+	return ((c >= 'A') && (c <= 'Z')) ? c+32 : c;
+}
+
+static inline int fat_utf8_strnicmp(const unsigned char *a,
+				    const unsigned char *b,
+				    int len)
+{
+	int i;
+
+	/*
+	 * FIXME: UTF-8 doesn't provide FAT semantics
+	 * Case-insensitive support is only for 7-bit ASCII characters
+	 */
+	for (i = 0; i < len; i++) {
+		if (fat_ascii_to_lower(a[i]) != fat_ascii_to_lower(b[i]))
+			return 1;
+	}
+	return 0;
+}
+
 /* fat/cache.c */
 extern void fat_cache_inval_inode(struct inode *inode);
 extern int fat_get_cluster(struct inode *inode, int cluster,
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index de0c9b013a85..f8c8a739f8f0 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -957,7 +957,9 @@ static int fat_show_options(struct seq_file *m, struct dentry *root)
 		/* strip "cp" prefix from displayed option */
 		seq_printf(m, ",codepage=%s", &sbi->nls_disk->charset[2]);
 	if (isvfat) {
-		if (sbi->nls_io)
+		if (opts->utf8)
+			seq_printf(m, ",iocharset=utf8");
+		else if (sbi->nls_io)
 			seq_printf(m, ",iocharset=%s", sbi->nls_io->charset);
 
 		switch (opts->shortname) {
@@ -994,8 +996,6 @@ static int fat_show_options(struct seq_file *m, struct dentry *root)
 		if (opts->nocase)
 			seq_puts(m, ",nocase");
 	} else {
-		if (opts->utf8)
-			seq_puts(m, ",utf8");
 		if (opts->unicode_xlate)
 			seq_puts(m, ",uni_xlate");
 		if (!opts->numtail)
@@ -1157,8 +1157,6 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
 	opts->errors = FAT_ERRORS_RO;
 	*debug = 0;
 
-	opts->utf8 = IS_ENABLED(CONFIG_FAT_DEFAULT_UTF8) && is_vfat;
-
 	if (!options)
 		goto out;
 
@@ -1319,10 +1317,14 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
 					| VFAT_SFN_CREATE_WIN95;
 			break;
 		case Opt_utf8_no:		/* 0 or no or false */
-			opts->utf8 = 0;
+			fat_reset_iocharset(opts);
 			break;
 		case Opt_utf8_yes:		/* empty or 1 or yes or true */
-			opts->utf8 = 1;
+			fat_reset_iocharset(opts);
+			iocharset = kstrdup("utf8", GFP_KERNEL);
+			if (!iocharset)
+				return -ENOMEM;
+			opts->iocharset = iocharset;
 			break;
 		case Opt_uni_xl_no:		/* 0 or no or false */
 			opts->unicode_xlate = 0;
@@ -1360,18 +1362,11 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
 	}
 
 out:
-	/* UTF-8 doesn't provide FAT semantics */
-	if (!strcmp(opts->iocharset, "utf8")) {
-		fat_msg(sb, KERN_WARNING, "utf8 is not a recommended IO charset"
-		       " for FAT filesystems, filesystem will be "
-		       "case sensitive!");
-	}
+	opts->utf8 = !strcmp(opts->iocharset, "utf8") && is_vfat;
 
 	/* If user doesn't specify allow_utime, it's initialized from dmask. */
 	if (opts->allow_utime == (unsigned short)-1)
 		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
-	if (opts->unicode_xlate)
-		opts->utf8 = 0;
 	if (opts->nfs == FAT_NFS_NOSTALE_RO) {
 		sb->s_flags |= SB_RDONLY;
 		sb->s_export_op = &fat_export_ops_nostale;
@@ -1832,8 +1827,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 		goto out_fail;
 	}
 
-	/* FIXME: utf8 is using iocharset for upper/lower conversion */
-	if (sbi->options.isvfat) {
+	if (sbi->options.isvfat && !sbi->options.utf8) {
 		sbi->nls_io = load_nls(sbi->options.iocharset);
 		if (!sbi->nls_io) {
 			fat_msg(sb, KERN_ERR, "IO charset %s not found",
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 5369d82e0bfb..efb3cb9ea8a8 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -134,6 +134,7 @@ static int vfat_hash(const struct dentry *dentry, struct qstr *qstr)
 static int vfat_hashi(const struct dentry *dentry, struct qstr *qstr)
 {
 	struct nls_table *t = MSDOS_SB(dentry->d_sb)->nls_io;
+	int utf8 = MSDOS_SB(dentry->d_sb)->options.utf8;
 	const unsigned char *name;
 	unsigned int len;
 	unsigned long hash;
@@ -142,8 +143,17 @@ static int vfat_hashi(const struct dentry *dentry, struct qstr *qstr)
 	len = vfat_striptail_len(qstr);
 
 	hash = init_name_hash(dentry);
-	while (len--)
-		hash = partial_name_hash(nls_tolower(t, *name++), hash);
+	if (utf8) {
+		/*
+		 * FIXME: UTF-8 doesn't provide FAT semantics
+		 * Case-insensitive support is only for 7-bit ASCII characters
+		 */
+		while (len--)
+			hash = partial_name_hash(fat_ascii_to_lower(*name++), hash);
+	} else {
+		while (len--)
+			hash = partial_name_hash(nls_tolower(t, *name++), hash);
+	}
 	qstr->hash = end_name_hash(hash);
 
 	return 0;
@@ -156,16 +166,18 @@ static int vfat_cmpi(const struct dentry *dentry,
 		unsigned int len, const char *str, const struct qstr *name)
 {
 	struct nls_table *t = MSDOS_SB(dentry->d_sb)->nls_io;
+	int utf8 = MSDOS_SB(dentry->d_sb)->options.utf8;
 	unsigned int alen, blen;
 
 	/* A filename cannot end in '.' or we treat it like it has none */
 	alen = vfat_striptail_len(name);
 	blen = __vfat_striptail_len(len, str);
-	if (alen == blen) {
-		if (nls_strnicmp(t, name->name, str, alen) == 0)
-			return 0;
-	}
-	return 1;
+	if (alen != blen)
+		return 1;
+	else if (utf8)
+		return fat_utf8_strnicmp(name->name, str, alen);
+	else
+		return nls_strnicmp(t, name->name, str, alen);
 }
 
 /*
-- 
2.20.1

