Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659C62E4D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 20:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfE2Syx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 14:54:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54630 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2Syw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 14:54:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 114A127FDAE
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH] ext4: Optimize case-insensitive lookups
Date:   Wed, 29 May 2019 14:54:46 -0400
Message-Id: <20190529185446.22757-1-krisman@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Temporarily cache a casefolded version of the file name under lookup in
ext4_filename, to avoid repeatedly casefolding it.

This gives me some performance gains on the lookup patch, when
performing cold dcache case-insensitive lookups on directories with a
high number of entries.

Below is a measure of average speedup of several runs with the patch
applied; where the baseline is the currently ext4 code, and the rows are
for different number of directory entries/number of lookup performed.
The speedup is not linear with the number of dentries, which I believe
is because of the changing format of the htree.

| entries | avg speedup |
| 1000    |  1.15	|
| 10000   |  1.19	|
| 50000   |  1.25	|
| 70000   |  1.20	|
| 100000  |  1.13	|

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/dir.c           |  2 +-
 fs/ext4/ext4.h          | 32 +++++++++++++++++++++++++++++---
 fs/ext4/namei.c         | 41 +++++++++++++++++++++++++++++++++++------
 fs/unicode/utf8-core.c  | 25 +++++++++++++++++++++++++
 include/linux/unicode.h |  3 +++
 5 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index c7843b149a1e..0a427e18584a 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -674,7 +674,7 @@ static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
 		return memcmp(str, name->name, len);
 	}
 
-	return ext4_ci_compare(dentry->d_parent->d_inode, name, &qstr);
+	return ext4_ci_compare(dentry->d_parent->d_inode, name, &qstr, false);
 }
 
 static int ext4_d_hash(const struct dentry *dentry, struct qstr *str)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c18ab748d20d..e3809cfda9f4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2078,6 +2078,10 @@ struct ext4_filename {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_str crypto_buf;
 #endif
+#ifdef CONFIG_UNICODE
+	int cf_len;
+	unsigned char cf_name[EXT4_NAME_LEN];
+#endif
 };
 
 #define fname_name(p) ((p)->disk_name.name)
@@ -2303,6 +2307,12 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
 					      struct ext4_group_desc *gdp);
 ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
+#ifdef CONFIG_UNICODE
+extern void ext4_setup_ci_filename(struct inode *dir,
+				   const struct qstr *iname,
+				   struct ext4_filename *fname);
+#endif
+
 #ifdef CONFIG_FS_ENCRYPTION
 static inline int ext4_fname_setup_filename(struct inode *dir,
 			const struct qstr *iname,
@@ -2313,6 +2323,9 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 
 	memset(fname, 0, sizeof(struct ext4_filename));
 
+#ifdef CONFIG_UNICODE
+	ext4_setup_ci_filename(dir, iname, fname);
+#endif
 	err = fscrypt_setup_filename(dir, iname, lookup, &name);
 
 	fname->usr_fname = name.usr_fname;
@@ -2333,18 +2346,31 @@ static inline void ext4_fname_free_filename(struct ext4_filename *fname)
 	fname->crypto_buf.name = NULL;
 	fname->usr_fname = NULL;
 	fname->disk_name.name = NULL;
+#ifdef CONFIG_UNICODE
+	fname->cf_len = 0;
+#endif
 }
 #else
 static inline int ext4_fname_setup_filename(struct inode *dir,
 		const struct qstr *iname,
 		int lookup, struct ext4_filename *fname)
 {
+
+#ifdef CONFIG_UNICODE
+	ext4_setup_ci_filename(dir, iname, fname);
+#endif
 	fname->usr_fname = iname;
 	fname->disk_name.name = (unsigned char *) iname->name;
 	fname->disk_name.len = iname->len;
 	return 0;
 }
-static inline void ext4_fname_free_filename(struct ext4_filename *fname) { }
+
+static inline void ext4_fname_free_filename(struct ext4_filename *fname)
+{
+#ifdef CONFIG_UNICODE
+	fname->cf_len = 0;
+#endif
+}
 
 #endif
 
@@ -3088,8 +3114,8 @@ extern int ext4_handle_dirty_dirent_node(handle_t *handle,
 					 struct inode *inode,
 					 struct buffer_head *bh);
 extern int ext4_ci_compare(const struct inode *parent,
-			   const struct qstr *name,
-			   const struct qstr *entry);
+			   const struct qstr *fname,
+			   const struct qstr *entry, bool quick);
 
 #define S_SHIFT 12
 static const unsigned char ext4_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index ac7457fef9e6..082f941520f3 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1259,19 +1259,25 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 #ifdef CONFIG_UNICODE
 /*
  * Test whether a case-insensitive directory entry matches the filename
- * being searched for.
+ * being searched for.  If quick is set, assume the name being looked up
+ * is already in the casefolded form.
  *
  * Returns: 0 if the directory entry matches, more than 0 if it
  * doesn't match or less than zero on error.
  */
-int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
-		    const struct qstr *entry)
+int ext4_ci_compare(const struct inode *parent,
+		    const struct qstr *name,
+		    const struct qstr *entry, bool quick)
 {
 	const struct ext4_sb_info *sbi = EXT4_SB(parent->i_sb);
 	const struct unicode_map *um = sbi->s_encoding;
 	int ret;
 
-	ret = utf8_strncasecmp(um, name, entry);
+	if (quick)
+		ret = utf8_strncasecmp_folded(um, name, entry);
+	else
+		ret = utf8_strncasecmp(um, name, entry);
+
 	if (ret < 0) {
 		/* Handle invalid character sequence as either an error
 		 * or as an opaque byte sequence.
@@ -1287,6 +1293,21 @@ int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 
 	return ret;
 }
+
+void ext4_setup_ci_filename(struct inode *dir,
+			    const struct qstr *iname,
+			    struct ext4_filename *fname)
+{
+	int len = EXT4_NAME_LEN;
+
+	fname->cf_len = 0;
+	if (IS_CASEFOLDED(dir)) {
+		len = utf8_casefold(EXT4_SB(dir->i_sb)->s_encoding,
+				    iname, fname->cf_name, len);
+		if (len >= 0)
+			fname->cf_len = len;
+	}
+}
 #endif
 
 /*
@@ -1313,8 +1334,16 @@ static inline bool ext4_match(const struct inode *parent,
 #endif
 
 #ifdef CONFIG_UNICODE
-	if (EXT4_SB(parent->i_sb)->s_encoding && IS_CASEFOLDED(parent))
-		return (ext4_ci_compare(parent, fname->usr_fname, &entry) == 0);
+	if (EXT4_SB(parent->i_sb)->s_encoding && IS_CASEFOLDED(parent)) {
+		if (fname->cf_len) {
+			struct qstr cf = {.name = fname->cf_name,
+					  .len = fname->cf_len};
+			return !ext4_ci_compare(parent, &cf,
+						&entry, true);
+		}
+		return !ext4_ci_compare(parent, fname->usr_fname,
+						&entry, false);
+	}
 #endif
 
 	return fscrypt_match_name(&f, de->name, de->name_len);
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 6afab4fdce90..1d74de2778e9 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -73,6 +73,31 @@ int utf8_strncasecmp(const struct unicode_map *um,
 }
 EXPORT_SYMBOL(utf8_strncasecmp);
 
+int utf8_strncasecmp_folded(const struct unicode_map *um,
+			    const struct qstr *normalized,
+			    const struct qstr *s1)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur1;
+	int c1, c2;
+	int i = 0;
+
+	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
+		return -EINVAL;
+
+	do {
+		c1 = utf8byte(&cur1);
+		c2 = normalized->name[i++];
+		if (c1 < 0)
+			return -EINVAL;
+		if (c1 != c2)
+			return 1;
+	} while (c1);
+
+	return 0;
+}
+EXPORT_SYMBOL(utf8_strncasecmp_folded);
+
 int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 		  unsigned char *dest, size_t dlen)
 {
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index aec2c6d800aa..e89bf3ecef21 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -17,6 +17,9 @@ int utf8_strncmp(const struct unicode_map *um,
 
 int utf8_strncasecmp(const struct unicode_map *um,
 		 const struct qstr *s1, const struct qstr *s2);
+int utf8_strncasecmp_folded(const struct unicode_map *um,
+			    const struct qstr *normalized,
+			    const struct qstr *s1);
 
 int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 		   unsigned char *dest, size_t dlen);
-- 
2.20.1

