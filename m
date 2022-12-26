Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFE065630D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiLZOWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLZOWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED411140;
        Mon, 26 Dec 2022 06:22:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C9DC60E16;
        Mon, 26 Dec 2022 14:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57260C433F0;
        Mon, 26 Dec 2022 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064523;
        bh=+iN0Mmisxx535Wrdu3nGmwSoR4sCrIL6dvBb31QghsE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fxaBgKBUOjxEifZXzIHKavSrzqT4XX0H1ndS42m2r4CDPpQyo6npRkR0RrBwlVTW5
         Vjr/NW77j/sgtdxZ2bttJm5DXQMYqX//OQwM5IIWXQL7/wMyhkDWaudLae5d0m8Jz/
         2e++wXrdHcc4sLwcEd0vCAN3aX9ZpZj4nnrs0RH6h62DiL3X7Zpi+Nc1f4vxMT10BG
         EC8DMCpenOPsU/lffuSNAx9k4daYC7FyakkBBVmPFsjl9pCgNAwB77/SzaMevnkhCo
         SKBqrBSkjUiG53YI2wiP9oED5K4iHk2R5KoPvM47cfbB0S58OTj5GLvO1nbw3Sq7R4
         oRR0LsAiwQ0CA==
Received: by pali.im (Postfix)
        id 16AC19E4; Mon, 26 Dec 2022 15:22:01 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 01/18] fat: Fix iocharset=utf8 mount option
Date:   Mon, 26 Dec 2022 15:21:33 +0100
Message-Id: <20221226142150.13324-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226142150.13324-1-pali@kernel.org>
References: <20221226142150.13324-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 Documentation/filesystems/vfat.rst | 13 ++-----------
 fs/fat/Kconfig                     | 19 +------------------
 fs/fat/dir.c                       | 17 +++++++----------
 fs/fat/fat.h                       | 22 ++++++++++++++++++++++
 fs/fat/inode.c                     | 28 +++++++++++-----------------
 fs/fat/namei_vfat.c                | 26 +++++++++++++++++++-------
 6 files changed, 62 insertions(+), 63 deletions(-)

diff --git a/Documentation/filesystems/vfat.rst b/Documentation/filesystems/vfat.rst
index 760a4d83fdf9..28cacba7bb9a 100644
--- a/Documentation/filesystems/vfat.rst
+++ b/Documentation/filesystems/vfat.rst
@@ -65,19 +65,10 @@ VFAT MOUNT OPTIONS
 	in Unicode format, but Unix for the most part doesn't
 	know how to deal with Unicode.
 	By default, FAT_DEFAULT_IOCHARSET setting is used.
-
-	There is also an option of doing UTF-8 translations
-	with the utf8 option.
-
-.. note:: ``iocharset=utf8`` is not recommended. If unsure, you should consider
-	  the utf8 option instead.
+	**utf8** is supported too and recommended to use.
 
 **utf8=<bool>**
-	UTF-8 is the filesystem safe version of Unicode that
-	is used by the console. It can be enabled or disabled
-	for the filesystem with this option.
-	If 'uni_xlate' gets set, UTF-8 gets disabled.
-	By default, FAT_DEFAULT_UTF8 setting is used.
+	Alias for ``iocharset=utf8`` mount option.
 
 **uni_xlate=<bool>**
 	Translate unhandled Unicode characters to special
diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index 238cc55f84c4..e98aaa3bb55b 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -93,29 +93,12 @@ config FAT_DEFAULT_IOCHARSET
 	  like FAT to use. It should probably match the character set
 	  that most of your FAT filesystems use, and can be overridden
 	  with the "iocharset" mount option for FAT filesystems.
-	  Note that "utf8" is not recommended for FAT filesystems.
-	  If unsure, you shouldn't set "utf8" here - select the next option
-	  instead if you would like to use UTF-8 encoded file names by default.
+	  "utf8" is supported too and recommended to use.
 	  See <file:Documentation/filesystems/vfat.rst> for more information.
 
 	  Enable any character sets you need in File Systems/Native Language
 	  Support.
 
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
-
 config FAT_KUNIT_TEST
 	tristate "Unit Tests for FAT filesystems" if !KUNIT_ALL_TESTS
 	depends on KUNIT && FAT_FS
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 00235b8a1823..15166b0c4a6e 100644
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
index a415c02ede39..6b0a6041c8d7 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -311,6 +311,28 @@ static inline void fatwchar_to16(__u8 *dst, const wchar_t *src, size_t len)
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
index d99b8549ec8f..818c9c37b419 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -956,7 +956,9 @@ static int fat_show_options(struct seq_file *m, struct dentry *root)
 		/* strip "cp" prefix from displayed option */
 		seq_printf(m, ",codepage=%s", &sbi->nls_disk->charset[2]);
 	if (isvfat) {
-		if (sbi->nls_io)
+		if (opts->utf8)
+			seq_puts(m, ",iocharset=utf8");
+		else if (sbi->nls_io)
 			seq_printf(m, ",iocharset=%s", sbi->nls_io->charset);
 
 		switch (opts->shortname) {
@@ -993,8 +995,6 @@ static int fat_show_options(struct seq_file *m, struct dentry *root)
 		if (opts->nocase)
 			seq_puts(m, ",nocase");
 	} else {
-		if (opts->utf8)
-			seq_puts(m, ",utf8");
 		if (opts->unicode_xlate)
 			seq_puts(m, ",uni_xlate");
 		if (!opts->numtail)
@@ -1156,8 +1156,6 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
 	opts->errors = FAT_ERRORS_RO;
 	*debug = 0;
 
-	opts->utf8 = IS_ENABLED(CONFIG_FAT_DEFAULT_UTF8) && is_vfat;
-
 	if (!options)
 		goto out;
 
@@ -1318,10 +1316,14 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
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
@@ -1359,18 +1361,11 @@ static int parse_options(struct super_block *sb, char *options, int is_vfat,
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
@@ -1828,8 +1823,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 		goto out_fail;
 	}
 
-	/* FIXME: utf8 is using iocharset for upper/lower conversion */
-	if (sbi->options.isvfat) {
+	if (sbi->options.isvfat && !sbi->options.utf8) {
 		sbi->nls_io = load_nls(sbi->options.iocharset);
 		if (!sbi->nls_io) {
 			fat_msg(sb, KERN_ERR, "IO charset %s not found",
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 21620054e1c4..5c585e79d863 100644
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

