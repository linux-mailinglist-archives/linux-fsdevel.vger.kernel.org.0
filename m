Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DACB356F33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348793AbhDGOtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 10:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348763AbhDGOti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:49:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C8DC061756;
        Wed,  7 Apr 2021 07:49:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id DF4D91F45089
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: [PATCH v7 2/4] fs: unicode: Rename function names from utf8 to unicode
Date:   Wed,  7 Apr 2021 20:18:43 +0530
Message-Id: <20210407144845.53266-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407144845.53266-1-shreeya.patel@collabora.com>
References: <20210407144845.53266-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

utf8data.h_shipped has a large database table which is an auto-generated
decodification trie for the unicode normalization functions and it is not
necessary to carry this large table in the kernel.
Goal is to make UTF-8 encoding loadable by converting it into a module
and adding a unicode subsystem layer between the filesystems and the
utf8 module.

This layer will load the module whenever any filesystem that
needs unicode is mounted.
Currently, only UTF-8 encoding is supported but if any other encodings
are supported in future then the layer file would be responsible for
loading the desired encoding module.

utf8-core will be converted into this layer file in the future patches.
Rename the function names from utf8 to unicode which will denote the
functions as the unicode subsystem layer functions and this will also be
the first step towards the transformation of utf8-core file into the
unicode subsystem layer file.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 fs/ext4/hash.c             |  2 +-
 fs/ext4/namei.c            | 12 ++++----
 fs/ext4/super.c            |  6 ++--
 fs/f2fs/dir.c              | 12 ++++----
 fs/f2fs/super.c            |  6 ++--
 fs/libfs.c                 |  6 ++--
 fs/unicode/utf8-core.c     | 57 +++++++++++++++++++-------------------
 fs/unicode/utf8-selftest.c |  8 +++---
 include/linux/unicode.h    | 32 ++++++++++-----------
 9 files changed, 70 insertions(+), 71 deletions(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index a92eb79de0cc..8890a76abe86 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -285,7 +285,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 		if (!buff)
 			return -ENOMEM;
 
-		dlen = utf8_casefold(um, &qstr, buff, PATH_MAX);
+		dlen = unicode_casefold(um, &qstr, buff, PATH_MAX);
 		if (dlen < 0) {
 			kfree(buff);
 			goto opaque_seq;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 686bf982c84e..dde5ce795416 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1290,9 +1290,9 @@ int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 	int ret;
 
 	if (quick)
-		ret = utf8_strncasecmp_folded(um, name, entry);
+		ret = unicode_strncasecmp_folded(um, name, entry);
 	else
-		ret = utf8_strncasecmp(um, name, entry);
+		ret = unicode_strncasecmp(um, name, entry);
 
 	if (ret < 0) {
 		/* Handle invalid character sequence as either an error
@@ -1324,9 +1324,9 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	if (!cf_name->name)
 		return;
 
-	len = utf8_casefold(dir->i_sb->s_encoding,
-			    iname, cf_name->name,
-			    EXT4_NAME_LEN);
+	len = unicode_casefold(dir->i_sb->s_encoding,
+			       iname, cf_name->name,
+			       EXT4_NAME_LEN);
 	if (len <= 0) {
 		kfree(cf_name->name);
 		cf_name->name = NULL;
@@ -2201,7 +2201,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 
 #ifdef CONFIG_UNICODE
 	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
-	    sb->s_encoding && utf8_validate(sb->s_encoding, &dentry->d_name))
+	    sb->s_encoding && unicode_validate(sb->s_encoding, &dentry->d_name))
 		return -EINVAL;
 #endif
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ad34a37278cd..2fb845752c90 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1259,7 +1259,7 @@ static void ext4_put_super(struct super_block *sb)
 	fs_put_dax(sbi->s_daxdev);
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
 #ifdef CONFIG_UNICODE
-	utf8_unload(sb->s_encoding);
+	unicode_unload(sb->s_encoding);
 #endif
 	kfree(sbi);
 }
@@ -4304,7 +4304,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			goto failed_mount;
 		}
 
-		encoding = utf8_load(encoding_info->version);
+		encoding = unicode_load(encoding_info->version);
 		if (IS_ERR(encoding)) {
 			ext4_msg(sb, KERN_ERR,
 				 "can't mount with superblock charset: %s-%s "
@@ -5165,7 +5165,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		crypto_free_shash(sbi->s_chksum_driver);
 
 #ifdef CONFIG_UNICODE
-	utf8_unload(sb->s_encoding);
+	unicode_unload(sb->s_encoding);
 #endif
 
 #ifdef CONFIG_QUOTA
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index e6270a867be1..f160f9dd667d 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -84,10 +84,10 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 						   GFP_NOFS);
 		if (!fname->cf_name.name)
 			return -ENOMEM;
-		fname->cf_name.len = utf8_casefold(sb->s_encoding,
-						   fname->usr_fname,
-						   fname->cf_name.name,
-						   F2FS_NAME_LEN);
+		fname->cf_name.len = unicode_casefold(sb->s_encoding,
+						      fname->usr_fname,
+						      fname->cf_name.name,
+						      F2FS_NAME_LEN);
 		if ((int)fname->cf_name.len <= 0) {
 			kfree(fname->cf_name.name);
 			fname->cf_name.name = NULL;
@@ -237,7 +237,7 @@ static int f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
 		entry.len = decrypted_name.len;
 	}
 
-	res = utf8_strncasecmp_folded(um, name, &entry);
+	res = unicode_strncasecmp_folded(um, name, &entry);
 	/*
 	 * In strict mode, ignore invalid names.  In non-strict mode,
 	 * fall back to treating them as opaque byte sequences.
@@ -246,7 +246,7 @@ static int f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
 		res = name->len == entry.len &&
 				memcmp(name->name, entry.name, name->len) == 0;
 	} else {
-		/* utf8_strncasecmp_folded returns 0 on match */
+		/* unicode_strncasecmp_folded returns 0 on match */
 		res = (res == 0);
 	}
 out:
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7069793752f1..b4a92e763e27 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1430,7 +1430,7 @@ static void f2fs_put_super(struct super_block *sb)
 	for (i = 0; i < NR_PAGE_TYPE; i++)
 		kvfree(sbi->write_io[i]);
 #ifdef CONFIG_UNICODE
-	utf8_unload(sb->s_encoding);
+	unicode_unload(sb->s_encoding);
 #endif
 	kfree(sbi);
 }
@@ -3560,7 +3560,7 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 			return -EINVAL;
 		}
 
-		encoding = utf8_load(encoding_info->version);
+		encoding = unicode_load(encoding_info->version);
 		if (IS_ERR(encoding)) {
 			f2fs_err(sbi,
 				 "can't mount with superblock charset: %s-%s "
@@ -4073,7 +4073,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		kvfree(sbi->write_io[i]);
 
 #ifdef CONFIG_UNICODE
-	utf8_unload(sb->s_encoding);
+	unicode_unload(sb->s_encoding);
 	sb->s_encoding = NULL;
 #endif
 free_options:
diff --git a/fs/libfs.c b/fs/libfs.c
index e2de5401abca..766556165bb5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1404,7 +1404,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 	 * If the dentry name is stored in-line, then it may be concurrently
 	 * modified by a rename.  If this happens, the VFS will eventually retry
 	 * the lookup, so it doesn't matter what ->d_compare() returns.
-	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
+	 * However, it's unsafe to call unicode_strncasecmp() with an unstable
 	 * string.  Therefore, we have to copy the name into a temporary buffer.
 	 */
 	if (len <= DNAME_INLINE_LEN - 1) {
@@ -1414,7 +1414,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 		/* prevent compiler from optimizing out the temporary buffer */
 		barrier();
 	}
-	ret = utf8_strncasecmp(um, name, &qstr);
+	ret = unicode_strncasecmp(um, name, &qstr);
 	if (ret >= 0)
 		return ret;
 
@@ -1443,7 +1443,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	if (!dir || !needs_casefold(dir))
 		return 0;
 
-	ret = utf8_casefold_hash(um, dentry, str);
+	ret = unicode_casefold_hash(um, dentry, str);
 	if (ret < 0 && sb_has_strict_encoding(sb))
 		return -EINVAL;
 	return 0;
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index f9e6a2718aba..730dbaedf593 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -10,7 +10,7 @@
 
 #include "utf8n.h"
 
-int utf8_validate(const struct unicode_map *um, const struct qstr *str)
+int unicode_validate(const struct unicode_map *um, const struct qstr *str)
 {
 	const struct utf8data *data = utf8nfdi(um->version);
 
@@ -18,10 +18,10 @@ int utf8_validate(const struct unicode_map *um, const struct qstr *str)
 		return -1;
 	return 0;
 }
-EXPORT_SYMBOL(utf8_validate);
+EXPORT_SYMBOL(unicode_validate);
 
-int utf8_strncmp(const struct unicode_map *um,
-		 const struct qstr *s1, const struct qstr *s2)
+int unicode_strncmp(const struct unicode_map *um,
+		    const struct qstr *s1, const struct qstr *s2)
 {
 	const struct utf8data *data = utf8nfdi(um->version);
 	struct utf8cursor cur1, cur2;
@@ -45,10 +45,10 @@ int utf8_strncmp(const struct unicode_map *um,
 
 	return 0;
 }
-EXPORT_SYMBOL(utf8_strncmp);
+EXPORT_SYMBOL(unicode_strncmp);
 
-int utf8_strncasecmp(const struct unicode_map *um,
-		     const struct qstr *s1, const struct qstr *s2)
+int unicode_strncasecmp(const struct unicode_map *um,
+			const struct qstr *s1, const struct qstr *s2)
 {
 	const struct utf8data *data = utf8nfdicf(um->version);
 	struct utf8cursor cur1, cur2;
@@ -72,14 +72,14 @@ int utf8_strncasecmp(const struct unicode_map *um,
 
 	return 0;
 }
-EXPORT_SYMBOL(utf8_strncasecmp);
+EXPORT_SYMBOL(unicode_strncasecmp);
 
 /* String cf is expected to be a valid UTF-8 casefolded
  * string.
  */
-int utf8_strncasecmp_folded(const struct unicode_map *um,
-			    const struct qstr *cf,
-			    const struct qstr *s1)
+int unicode_strncasecmp_folded(const struct unicode_map *um,
+			       const struct qstr *cf,
+			       const struct qstr *s1)
 {
 	const struct utf8data *data = utf8nfdicf(um->version);
 	struct utf8cursor cur1;
@@ -100,10 +100,10 @@ int utf8_strncasecmp_folded(const struct unicode_map *um,
 
 	return 0;
 }
-EXPORT_SYMBOL(utf8_strncasecmp_folded);
+EXPORT_SYMBOL(unicode_strncasecmp_folded);
 
-int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
-		  unsigned char *dest, size_t dlen)
+int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
+		     unsigned char *dest, size_t dlen)
 {
 	const struct utf8data *data = utf8nfdicf(um->version);
 	struct utf8cursor cur;
@@ -123,10 +123,10 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 	}
 	return -EINVAL;
 }
-EXPORT_SYMBOL(utf8_casefold);
+EXPORT_SYMBOL(unicode_casefold);
 
-int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
-		       struct qstr *str)
+int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
+			  struct qstr *str)
 {
 	const struct utf8data *data = utf8nfdicf(um->version);
 	struct utf8cursor cur;
@@ -144,10 +144,10 @@ int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
 	str->hash = end_name_hash(hash);
 	return 0;
 }
-EXPORT_SYMBOL(utf8_casefold_hash);
+EXPORT_SYMBOL(unicode_casefold_hash);
 
-int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
-		   unsigned char *dest, size_t dlen)
+int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
+		      unsigned char *dest, size_t dlen)
 {
 	const struct utf8data *data = utf8nfdi(um->version);
 	struct utf8cursor cur;
@@ -167,11 +167,10 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 	}
 	return -EINVAL;
 }
+EXPORT_SYMBOL(unicode_normalize);
 
-EXPORT_SYMBOL(utf8_normalize);
-
-static int utf8_parse_version(const char *version, unsigned int *maj,
-			      unsigned int *min, unsigned int *rev)
+static int unicode_parse_version(const char *version, unsigned int *maj,
+				 unsigned int *min, unsigned int *rev)
 {
 	substring_t args[3];
 	char version_string[12];
@@ -194,7 +193,7 @@ static int utf8_parse_version(const char *version, unsigned int *maj,
 	return 0;
 }
 
-struct unicode_map *utf8_load(const char *version)
+struct unicode_map *unicode_load(const char *version)
 {
 	struct unicode_map *um = NULL;
 	int unicode_version;
@@ -202,7 +201,7 @@ struct unicode_map *utf8_load(const char *version)
 	if (version) {
 		unsigned int maj, min, rev;
 
-		if (utf8_parse_version(version, &maj, &min, &rev) < 0)
+		if (unicode_parse_version(version, &maj, &min, &rev) < 0)
 			return ERR_PTR(-EINVAL);
 
 		if (!utf8version_is_supported(maj, min, rev))
@@ -227,12 +226,12 @@ struct unicode_map *utf8_load(const char *version)
 
 	return um;
 }
-EXPORT_SYMBOL(utf8_load);
+EXPORT_SYMBOL(unicode_load);
 
-void utf8_unload(struct unicode_map *um)
+void unicode_unload(struct unicode_map *um)
 {
 	kfree(um);
 }
-EXPORT_SYMBOL(utf8_unload);
+EXPORT_SYMBOL(unicode_unload);
 
 MODULE_LICENSE("GPL v2");
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 6fe8af7edccb..796c1ed922ea 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -235,7 +235,7 @@ static void check_utf8_nfdicf(void)
 static void check_utf8_comparisons(void)
 {
 	int i;
-	struct unicode_map *table = utf8_load("12.1.0");
+	struct unicode_map *table = unicode_load("12.1.0");
 
 	if (IS_ERR(table)) {
 		pr_err("%s: Unable to load utf8 %d.%d.%d. Skipping.\n",
@@ -249,7 +249,7 @@ static void check_utf8_comparisons(void)
 		const struct qstr s2 = {.name = nfdi_test_data[i].dec,
 					.len = sizeof(nfdi_test_data[i].dec)};
 
-		test_f(!utf8_strncmp(table, &s1, &s2),
+		test_f(!unicode_strncmp(table, &s1, &s2),
 		       "%s %s comparison mismatch\n", s1.name, s2.name);
 	}
 
@@ -259,11 +259,11 @@ static void check_utf8_comparisons(void)
 		const struct qstr s2 = {.name = nfdicf_test_data[i].ncf,
 					.len = sizeof(nfdicf_test_data[i].ncf)};
 
-		test_f(!utf8_strncasecmp(table, &s1, &s2),
+		test_f(!unicode_strncasecmp(table, &s1, &s2),
 		       "%s %s comparison mismatch\n", s1.name, s2.name);
 	}
 
-	utf8_unload(table);
+	unicode_unload(table);
 }
 
 static void check_supported_versions(void)
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 74484d44c755..de23f9ee720b 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -10,27 +10,27 @@ struct unicode_map {
 	int version;
 };
 
-int utf8_validate(const struct unicode_map *um, const struct qstr *str);
+int unicode_validate(const struct unicode_map *um, const struct qstr *str);
 
-int utf8_strncmp(const struct unicode_map *um,
-		 const struct qstr *s1, const struct qstr *s2);
+int unicode_strncmp(const struct unicode_map *um,
+		    const struct qstr *s1, const struct qstr *s2);
 
-int utf8_strncasecmp(const struct unicode_map *um,
-		 const struct qstr *s1, const struct qstr *s2);
-int utf8_strncasecmp_folded(const struct unicode_map *um,
-			    const struct qstr *cf,
-			    const struct qstr *s1);
+int unicode_strncasecmp(const struct unicode_map *um,
+			const struct qstr *s1, const struct qstr *s2);
+int unicode_strncasecmp_folded(const struct unicode_map *um,
+			       const struct qstr *cf,
+			       const struct qstr *s1);
 
-int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
-		   unsigned char *dest, size_t dlen);
+int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
+		      unsigned char *dest, size_t dlen);
 
-int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
-		  unsigned char *dest, size_t dlen);
+int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
+		     unsigned char *dest, size_t dlen);
 
-int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
-		       struct qstr *str);
+int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
+			  struct qstr *str);
 
-struct unicode_map *utf8_load(const char *version);
-void utf8_unload(struct unicode_map *um);
+struct unicode_map *unicode_load(const char *version);
+void unicode_unload(struct unicode_map *um);
 
 #endif /* _LINUX_UNICODE_H */
-- 
2.30.2

