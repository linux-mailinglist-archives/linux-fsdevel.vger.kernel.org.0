Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6C131EFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 06:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgAGFRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 00:17:19 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:51890 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgAGFQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:16:55 -0500
Received: by mail-pj1-f73.google.com with SMTP id h2so1414306pji.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 21:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vzXdSIsEojq73FEORsLXu+PkIiu+YZoKMnrWbVJQ3sA=;
        b=bSDM6P5lwrnQqy0+knVjDNM3VdSBum37LipgBlpnEJmcLoqOtGayJA8DsAtg/QXpH2
         aRKFifDr/nldojgMNsvAN9zEpMnZqrzOtexuBcvs/6/vgAZH5sjO9B/lhkqsw7o/E+le
         TxBpLlTLeuUt4FqWziZtzGQnAY98mCTLU3Jc5qpbPPcN8exnC4PqrCnESsJ5aolTqY4M
         kvq8Wri7fbNXCF7a7GDEEPGK19Y7xj6uDi5W1VJnkR9pbBnCe6ycWWpPx9PjWN/FRx3q
         YBHj8XvfNKoYu9Y77JEyJWkYHsMz7SmgNTxHeA9lv4pgrv2fciq9rdaOVBTX2T6MtQF2
         7vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vzXdSIsEojq73FEORsLXu+PkIiu+YZoKMnrWbVJQ3sA=;
        b=eKIUoigtg0tPWW1Z6Vql9w5PXoDZzBFibWydbFL6cJ5RXmYSn/Czor+MQCEO866eH2
         hYRHR06XJ5i+7UK4GMfnV5l/Sdi0sbMD+auHUIbHB9LAKcTkTDMRKWDBlkhZ9eFShYQd
         d7FztoYU2QUrn6+uZ9tWdCAkXMq4EtgkcZFPp0KTKJnbp+7mpVpMyDkFatDQHiLALRs2
         2dBsQYRJ/FGD7VNKmJfZbsfOB9Sc2uy/Yz5Ijmku4l7OGYAbKqP+Yn8WDTklRItHRZJ0
         RZYSorD3ZFKbG+XHLgE51hm58+0JNDiNGnwiHCqOvN6ap3O+lZe2kIe1Gevp1w4xKyuW
         rt9g==
X-Gm-Message-State: APjAAAWGVfayZIzp/hEaXSL2cytxHHhptLNATBivujIseeWh7SLy2y4q
        BJXqlTHXF2Zg69uzZ0NSGQLwgLRY/Cw=
X-Google-Smtp-Source: APXvYqztPoik0vPIHjE5rBg4E8PiC1A1GPMPe22X0HOJeFJO9PM7YFj12dG3TqPMXe8lSl7uQBF+l7zLC1M=
X-Received: by 2002:a63:1204:: with SMTP id h4mr112041557pgl.288.1578374214632;
 Mon, 06 Jan 2020 21:16:54 -0800 (PST)
Date:   Mon,  6 Jan 2020 21:16:35 -0800
In-Reply-To: <20200107051638.40893-1-drosen@google.com>
Message-Id: <20200107051638.40893-4-drosen@google.com>
Mime-Version: 1.0
References: <20200107051638.40893-1-drosen@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 3/6] f2fs: Handle casefolding with Encryption
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

This expands f2fs's casefolding support to include encrypted
directories. For encrypted directories, we use the siphash of the
casefolded name. This ensures there is no direct way to go from an
unencrypted name to the stored hash on disk without knowledge of the
encryption policy keys.

Additionally, we switch to using the vfs layer's casefolding support
instead of storing this information inside of f2fs's private data.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
After the fscrypt changes go in, f2fs_ci_compare can have parent made
const again

 fs/f2fs/dir.c    | 114 ++++++++++++++++++-----------------------------
 fs/f2fs/f2fs.h   |  14 +++---
 fs/f2fs/hash.c   |  25 +++++++----
 fs/f2fs/inline.c |   9 ++--
 fs/f2fs/super.c  |  17 +++----
 fs/f2fs/sysfs.c  |   8 ++--
 6 files changed, 80 insertions(+), 107 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c967cacf979ef..3aeaa82accdec 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -111,31 +111,50 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
  * Returns: 0 if the directory entry matches, more than 0 if it
  * doesn't match or less than zero on error.
  */
-int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
-				const struct qstr *entry, bool quick)
+int f2fs_ci_compare(struct inode *parent, const struct qstr *name,
+		    unsigned char *name2, size_t len, bool quick)
 {
 	const struct f2fs_sb_info *sbi = F2FS_SB(parent->i_sb);
-	const struct unicode_map *um = sbi->s_encoding;
+	const struct unicode_map *um = sbi->sb->s_encoding;
+	const struct fscrypt_str crypt_entry = FSTR_INIT(name2, len);
+	struct fscrypt_str decrypted_entry;
+	struct qstr decrypted;
+	struct qstr entry = QSTR_INIT(name2, len);
 	int ret;
 
+	decrypted_entry.name = NULL;
+
+	if (IS_ENCRYPTED(parent) && fscrypt_has_encryption_key(parent)) {
+		decrypted_entry.name = kmalloc(len, GFP_ATOMIC);
+		decrypted.name = decrypted_entry.name;
+		decrypted_entry.len = len;
+		decrypted.len = len;
+		if (!decrypted.name)
+			return -ENOMEM;
+		fscrypt_fname_disk_to_usr(parent, 0, 0, &crypt_entry,
+							&decrypted_entry);
+	}
+
 	if (quick)
-		ret = utf8_strncasecmp_folded(um, name, entry);
+		ret = utf8_strncasecmp_folded(um, name, decrypted_entry.name ?
+							&decrypted : &entry);
 	else
-		ret = utf8_strncasecmp(um, name, entry);
-
+		ret = utf8_strncasecmp(um, name, decrypted_entry.name ?
+							&decrypted : &entry);
 	if (ret < 0) {
 		/* Handle invalid character sequence as either an error
 		 * or as an opaque byte sequence.
 		 */
-		if (f2fs_has_strict_mode(sbi))
+		if (sb_has_enc_strict_mode(sbi->sb))
 			return -EINVAL;
 
-		if (name->len != entry->len)
+		if (name->len != len)
 			return 1;
 
-		return !!memcmp(name->name, entry->name, name->len);
+		ret = !!memcmp(name->name,
+				decrypted_entry.name ?: name2, name->len);
 	}
-
+	kfree(decrypted_entry.name);
 	return ret;
 }
 
@@ -154,7 +173,7 @@ static void f2fs_fname_setup_ci_filename(struct inode *dir,
 	if (!cf_name->name)
 		return;
 
-	cf_name->len = utf8_casefold(sbi->s_encoding,
+	cf_name->len = utf8_casefold(dir->i_sb->s_encoding,
 					iname, cf_name->name,
 					F2FS_NAME_LEN);
 	if ((int)cf_name->len <= 0) {
@@ -173,24 +192,24 @@ static inline bool f2fs_match_name(struct f2fs_dentry_ptr *d,
 {
 #ifdef CONFIG_UNICODE
 	struct inode *parent = d->inode;
-	struct f2fs_sb_info *sbi = F2FS_I_SB(parent);
-	struct qstr entry;
+	unsigned char *name;
+	int len;
 #endif
 
 	if (de->hash_code != namehash)
 		return false;
 
 #ifdef CONFIG_UNICODE
-	entry.name = d->filename[bit_pos];
-	entry.len = de->name_len;
+	name = d->filename[bit_pos];
+	len = de->name_len;
 
-	if (sbi->s_encoding && IS_CASEFOLDED(parent)) {
+	if (needs_casefold(parent)) {
 		if (cf_str->name) {
 			struct qstr cf = {.name = cf_str->name,
 					  .len = cf_str->len};
-			return !f2fs_ci_compare(parent, &cf, &entry, true);
+			return !f2fs_ci_compare(parent, &cf, name, len, true);
 		}
-		return !f2fs_ci_compare(parent, fname->usr_fname, &entry,
+		return !f2fs_ci_compare(parent, fname->usr_fname, name, len,
 					false);
 	}
 #endif
@@ -357,8 +376,8 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 	int err;
 
 #ifdef CONFIG_UNICODE
-	if (f2fs_has_strict_mode(F2FS_I_SB(dir)) && IS_CASEFOLDED(dir) &&
-			utf8_validate(F2FS_I_SB(dir)->s_encoding, child)) {
+	if (sb_has_enc_strict_mode(dir->i_sb) && IS_CASEFOLDED(dir) &&
+			utf8_validate(dir->i_sb->s_encoding, child)) {
 		*res_page = ERR_PTR(-EINVAL);
 		return NULL;
 	}
@@ -602,13 +621,13 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 
 int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 				const struct qstr *orig_name,
+				f2fs_hash_t dentry_hash,
 				struct inode *inode, nid_t ino, umode_t mode)
 {
 	unsigned int bit_pos;
 	unsigned int level;
 	unsigned int current_depth;
 	unsigned long bidx, block;
-	f2fs_hash_t dentry_hash;
 	unsigned int nbucket, nblock;
 	struct page *dentry_page = NULL;
 	struct f2fs_dentry_block *dentry_blk = NULL;
@@ -618,7 +637,6 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 
 	level = 0;
 	slots = GET_DENTRY_SLOTS(new_name->len);
-	dentry_hash = f2fs_dentry_hash(dir, new_name, NULL);
 
 	current_depth = F2FS_I(dir)->i_current_depth;
 	if (F2FS_I(dir)->chash == dentry_hash) {
@@ -704,17 +722,19 @@ int f2fs_add_dentry(struct inode *dir, struct fscrypt_name *fname,
 				struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct qstr new_name;
+	f2fs_hash_t dentry_hash;
 	int err = -EAGAIN;
 
 	new_name.name = fname_name(fname);
 	new_name.len = fname_len(fname);
 
 	if (f2fs_has_inline_dentry(dir))
-		err = f2fs_add_inline_entry(dir, &new_name, fname->usr_fname,
+		err = f2fs_add_inline_entry(dir, &new_name, fname,
 							inode, ino, mode);
+	dentry_hash = f2fs_dentry_hash(dir, &new_name, fname);
 	if (err == -EAGAIN)
 		err = f2fs_add_regular_entry(dir, &new_name, fname->usr_fname,
-							inode, ino, mode);
+						dentry_hash, inode, ino, mode);
 
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
 	return err;
@@ -1064,49 +1084,3 @@ const struct file_operations f2fs_dir_operations = {
 #endif
 };
 
-#ifdef CONFIG_UNICODE
-static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
-			  const char *str, const struct qstr *name)
-{
-	struct qstr qstr = {.name = str, .len = len };
-
-	if (!IS_CASEFOLDED(dentry->d_parent->d_inode)) {
-		if (len != name->len)
-			return -1;
-		return memcmp(str, name, len);
-	}
-
-	return f2fs_ci_compare(dentry->d_parent->d_inode, name, &qstr, false);
-}
-
-static int f2fs_d_hash(const struct dentry *dentry, struct qstr *str)
-{
-	struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
-	const struct unicode_map *um = sbi->s_encoding;
-	unsigned char *norm;
-	int len, ret = 0;
-
-	if (!IS_CASEFOLDED(dentry->d_inode))
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
-const struct dentry_operations f2fs_dentry_ops = {
-	.d_hash = f2fs_d_hash,
-	.d_compare = f2fs_d_compare,
-};
-#endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a888a063c7f1..a4864ed76dd8a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1184,10 +1184,6 @@ struct f2fs_sb_info {
 	int valid_super_block;			/* valid super block no */
 	unsigned long s_flag;				/* flags for sbi */
 	struct mutex writepages;		/* mutex for writepages() */
-#ifdef CONFIG_UNICODE
-	struct unicode_map *s_encoding;
-	__u16 s_encoding_flags;
-#endif
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
@@ -2969,9 +2965,9 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 							bool hot, bool set);
 struct dentry *f2fs_get_parent(struct dentry *child);
 
-extern int f2fs_ci_compare(const struct inode *parent,
+extern int f2fs_ci_compare(struct inode *parent,
 			   const struct qstr *name,
-			   const struct qstr *entry,
+			   unsigned char *name2, size_t len,
 			   bool quick);
 
 /*
@@ -3005,7 +3001,7 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 			const struct qstr *name, f2fs_hash_t name_hash,
 			unsigned int bit_pos);
 int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
-			const struct qstr *orig_name,
+			const struct qstr *orig_name, f2fs_hash_t dentry_hash,
 			struct inode *inode, nid_t ino, umode_t mode);
 int f2fs_add_dentry(struct inode *dir, struct fscrypt_name *fname,
 			struct inode *inode, nid_t ino, umode_t mode);
@@ -3038,7 +3034,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
  * hash.c
  */
 f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
-		const struct qstr *name_info, struct fscrypt_name *fname);
+		const struct qstr *name_info, const struct fscrypt_name *fname);
 
 /*
  * node.c
@@ -3517,7 +3513,7 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 			struct page *ipage);
 int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
-			const struct qstr *orig_name,
+			const struct fscrypt_name *fname,
 			struct inode *inode, nid_t ino, umode_t mode);
 void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry,
 				struct page *page, struct inode *dir,
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index 5bc4dcd8fc03f..954d03dee4506 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -68,8 +68,9 @@ static void str2hashbuf(const unsigned char *msg, size_t len,
 		*buf++ = pad;
 }
 
-static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
-				struct fscrypt_name *fname)
+static f2fs_hash_t __f2fs_dentry_hash(const struct inode *dir,
+				const struct qstr *name_info,
+				const struct fscrypt_name *fname)
 {
 	__u32 hash;
 	f2fs_hash_t f2fs_hash;
@@ -85,6 +86,11 @@ static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
 	if (is_dot_dotdot(name_info))
 		return 0;
 
+	if (IS_CASEFOLDED(dir) && IS_ENCRYPTED(dir)) {
+		f2fs_hash = fscrypt_fname_siphash(dir, name_info);
+		return f2fs_hash;
+	}
+
 	/* Initialize the default seed for the hash checksum functions */
 	buf[0] = 0x67452301;
 	buf[1] = 0xefcdab89;
@@ -106,35 +112,38 @@ static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
 }
 
 f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
-		const struct qstr *name_info, struct fscrypt_name *fname)
+		const struct qstr *name_info, const struct fscrypt_name *fname)
 {
 #ifdef CONFIG_UNICODE
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
-	const struct unicode_map *um = sbi->s_encoding;
+	const struct unicode_map *um = sbi->sb->s_encoding;
 	int r, dlen;
 	unsigned char *buff;
 	struct qstr folded;
+	const struct qstr *name = fname ? fname->usr_fname : name_info;
 
 	if (!name_info->len || !IS_CASEFOLDED(dir))
 		goto opaque_seq;
 
+	if (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir))
+		goto opaque_seq;
+
 	buff = f2fs_kzalloc(sbi, sizeof(char) * PATH_MAX, GFP_KERNEL);
 	if (!buff)
 		return -ENOMEM;
-
-	dlen = utf8_casefold(um, name_info, buff, PATH_MAX);
+	dlen = utf8_casefold(um, name, buff, PATH_MAX);
 	if (dlen < 0) {
 		kvfree(buff);
 		goto opaque_seq;
 	}
 	folded.name = buff;
 	folded.len = dlen;
-	r = __f2fs_dentry_hash(&folded, fname);
+	r = __f2fs_dentry_hash(dir, &folded, fname);
 
 	kvfree(buff);
 	return r;
 
 opaque_seq:
 #endif
-	return __f2fs_dentry_hash(name_info, fname);
+	return __f2fs_dentry_hash(dir, name_info, fname);
 }
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 896db0416f0e6..3c37720941539 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -465,8 +465,8 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 		ino = le32_to_cpu(de->ino);
 		fake_mode = f2fs_get_de_type(de) << S_SHIFT;
 
-		err = f2fs_add_regular_entry(dir, &new_name, NULL, NULL,
-							ino, fake_mode);
+		err = f2fs_add_regular_entry(dir, &new_name, NULL,
+					de->hash_code, NULL, ino, fake_mode);
 		if (err)
 			goto punch_dentry_pages;
 
@@ -540,7 +540,7 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 }
 
 int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
-				const struct qstr *orig_name,
+				const struct fscrypt_name *fname,
 				struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
@@ -551,6 +551,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 	struct f2fs_dentry_ptr d;
 	int slots = GET_DENTRY_SLOTS(new_name->len);
 	struct page *page = NULL;
+	const struct qstr *orig_name = fname->usr_fname;
 	int err = 0;
 
 	ipage = f2fs_get_node_page(sbi, dir->i_ino);
@@ -581,7 +582,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 
 	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 
-	name_hash = f2fs_dentry_hash(dir, new_name, NULL);
+	name_hash = f2fs_dentry_hash(dir, new_name, fname);
 	f2fs_update_dentry(ino, mode, &d, new_name, name_hash, bit_pos);
 
 	set_page_dirty(ipage);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5111e1ffe58ab..5e4e76332c4ca 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1144,7 +1144,7 @@ static void f2fs_put_super(struct super_block *sb)
 	for (i = 0; i < NR_PAGE_TYPE; i++)
 		kvfree(sbi->write_io[i]);
 #ifdef CONFIG_UNICODE
-	utf8_unload(sbi->s_encoding);
+	utf8_unload(sbi->sb->s_encoding);
 #endif
 	kvfree(sbi);
 }
@@ -3136,17 +3136,11 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 {
 #ifdef CONFIG_UNICODE
-	if (f2fs_sb_has_casefold(sbi) && !sbi->s_encoding) {
+	if (f2fs_sb_has_casefold(sbi) && !sbi->sb->s_encoding) {
 		const struct f2fs_sb_encodings *encoding_info;
 		struct unicode_map *encoding;
 		__u16 encoding_flags;
 
-		if (f2fs_sb_has_encrypt(sbi)) {
-			f2fs_err(sbi,
-				"Can't mount with encoding and encryption");
-			return -EINVAL;
-		}
-
 		if (f2fs_sb_read_encoding(sbi->raw_super, &encoding_info,
 					  &encoding_flags)) {
 			f2fs_err(sbi,
@@ -3167,9 +3161,8 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 			 "%s-%s with flags 0x%hx", encoding_info->name,
 			 encoding_info->version?:"\b", encoding_flags);
 
-		sbi->s_encoding = encoding;
-		sbi->s_encoding_flags = encoding_flags;
-		sbi->sb->s_d_op = &f2fs_dentry_ops;
+		sbi->sb->s_encoding = encoding;
+		sbi->sb->s_encoding_flags = encoding_flags;
 	}
 #else
 	if (f2fs_sb_has_casefold(sbi)) {
@@ -3637,7 +3630,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		kvfree(sbi->write_io[i]);
 
 #ifdef CONFIG_UNICODE
-	utf8_unload(sbi->s_encoding);
+	utf8_unload(sbi->sb->s_encoding);
 #endif
 free_options:
 #ifdef CONFIG_QUOTA
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 70945ceb9c0ca..7fd37c8c9733a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -88,10 +88,10 @@ static ssize_t encoding_show(struct f2fs_attr *a,
 #ifdef CONFIG_UNICODE
 	if (f2fs_sb_has_casefold(sbi))
 		return snprintf(buf, PAGE_SIZE, "%s (%d.%d.%d)\n",
-			sbi->s_encoding->charset,
-			(sbi->s_encoding->version >> 16) & 0xff,
-			(sbi->s_encoding->version >> 8) & 0xff,
-			sbi->s_encoding->version & 0xff);
+			sbi->sb->s_encoding->charset,
+			(sbi->sb->s_encoding->version >> 16) & 0xff,
+			(sbi->sb->s_encoding->version >> 8) & 0xff,
+			sbi->sb->s_encoding->version & 0xff);
 #endif
 	return snprintf(buf, PAGE_SIZE, "(none)");
 }
-- 
2.24.1.735.g03f4e72817-goog

