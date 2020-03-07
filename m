Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC5917CB21
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 03:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgCGCg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 21:36:59 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43939 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgCGCgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:36:54 -0500
Received: by mail-pf1-f202.google.com with SMTP id s19so2803670pfh.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 18:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mbSCqVUYsnIV+cLLJ35DwGW8CF8pxOBGx9X2YJa7W5A=;
        b=v55qsSlmj6KPgwppD919LB4e5MLayF+9OHifCmMfY+6IwLjAYR3unbkr0DvU0ZDsk/
         Qs1AhMrxR9jro8Fh/sFu0F85lxTisoRZxj3BCnjzR2JLAOfdt9AegKSGCHdVNVcY/B0Q
         UzRlPdSD6CUFo1Ro65FELJgTrFyDykRmnVfFNVpKbgz6wwtQUIOYfn3c7ZA5zHcf8vQT
         SfHu4dXi96R7I9PJSRw9OEymQnZeDTmRsWQVMnCRdQN/4K8AUaDjW/dQJv6zfMgTj+eY
         bonC6oiU3gh8k9F7QbrGJf9dVTznXm6LZdxVt49P3ZsQS+23PbFAfxS8A+UQrvj9jnNh
         6Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mbSCqVUYsnIV+cLLJ35DwGW8CF8pxOBGx9X2YJa7W5A=;
        b=XCab+eAlLxhLySFWjFPGJy5WONBrZjqExvJl7ywB7nJrc/kZLPNDgA4sZSXyzbSH1g
         OvBoDZXB3uNhxL0fOjwttjLm0ex1RmmrbP+QQPyI+NWgYC4YciiHlnIdDquLLrzuP1ls
         YO7Aj7aXkizjlVe2TiY+ZeS3x54NT9OyRNhRGtMTmidhK/PX7ZeRAyS6rO2nzvB2QZti
         kOmtWEQH0VhZ6udBhVw0pdHGw1bKlROcZ+JLPjU4s0S5uiffPqZcQffGmT1FrBNUO5tY
         MFntVkDUNZBYeqqLC8/+hmD80+gOitMAOZ9kdRfhhZq8Men/Rpyk7W5ZZiIt6dkiCHNC
         vt1g==
X-Gm-Message-State: ANhLgQ0uDEsCoCLIaE/VMWpO2OEqMAidNLFd1hXY8x/KmjnBFLF9Qlcv
        p9lXgOGgR7rKwElitUP8cs7awu8rZ5E=
X-Google-Smtp-Source: ADFU+vuEFap3y2E+U2aW1h962HS/As8NxYR1OkskyglzuBOm8x/hofEjI32w2rXvNz6fQnj0ASTidkp6DNQ=
X-Received: by 2002:a17:90a:a0b:: with SMTP id o11mr6429761pjo.151.1583548613011;
 Fri, 06 Mar 2020 18:36:53 -0800 (PST)
Date:   Fri,  6 Mar 2020 18:36:11 -0800
In-Reply-To: <20200307023611.204708-1-drosen@google.com>
Message-Id: <20200307023611.204708-9-drosen@google.com>
Mime-Version: 1.0
References: <20200307023611.204708-1-drosen@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 8/8] f2fs: Handle casefolding with Encryption
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

This expands f2fs's casefolding support to include encrypted
directories. For encrypted directories, we use the siphash of the
casefolded name. This ensures there is no direct way to go from an
unencrypted name to the stored hash on disk without knowledge of the
encryption policy keys.

Additionally, we switch to using the vfs layer's casefolding support
instead of storing this information inside of f2fs's private data.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/dir.c    | 65 +++++++++++++++++++++++++++++++-----------------
 fs/f2fs/f2fs.h   | 11 +++-----
 fs/f2fs/hash.c   | 25 +++++++++++++------
 fs/f2fs/inline.c |  9 ++++---
 fs/f2fs/super.c  |  6 -----
 5 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 38c0e6d589be4..a2a21b651c8b3 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -108,34 +108,52 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
  * Test whether a case-insensitive directory entry matches the filename
  * being searched for.
  *
+ * Only called for encrypted names if the key is available.
+ *
  * Returns: 0 if the directory entry matches, more than 0 if it
  * doesn't match or less than zero on error.
  */
-int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
-				const struct qstr *entry, bool quick)
+static int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
+			   u8 *de_name, size_t de_name_len, bool quick)
 {
 	const struct super_block *sb = parent->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
+	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
+	struct qstr entry = QSTR_INIT(de_name, de_name_len);
 	int ret;
 
+	if (IS_ENCRYPTED(parent)) {
+		const struct fscrypt_str encrypted_name =
+				FSTR_INIT(de_name, de_name_len);
+
+		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		if (!decrypted_name.name)
+			return -ENOMEM;
+		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
+						&decrypted_name);
+		if (ret < 0)
+			goto out;
+		entry.name = decrypted_name.name;
+		entry.len = decrypted_name.len;
+	}
+
 	if (quick)
-		ret = utf8_strncasecmp_folded(um, name, entry);
+		ret = utf8_strncasecmp_folded(um, name, &entry);
 	else
-		ret = utf8_strncasecmp(um, name, entry);
-
+		ret = utf8_strncasecmp(um, name, &entry);
 	if (ret < 0) {
 		/* Handle invalid character sequence as either an error
 		 * or as an opaque byte sequence.
 		 */
 		if (sb_has_enc_strict_mode(sb))
-			return -EINVAL;
-
-		if (name->len != entry->len)
-			return 1;
-
-		return !!memcmp(name->name, entry->name, name->len);
+			ret = -EINVAL;
+		else if (name->len != entry.len)
+			ret = 1;
+		else
+			ret = !!memcmp(name->name, entry.name, entry.len);
 	}
-
+out:
+	kfree(decrypted_name.name);
 	return ret;
 }
 
@@ -173,24 +191,24 @@ static inline bool f2fs_match_name(struct f2fs_dentry_ptr *d,
 {
 #ifdef CONFIG_UNICODE
 	struct inode *parent = d->inode;
-	struct super_block *sb = parent->i_sb;
-	struct qstr entry;
+	u8 *name;
+	int len;
 #endif
 
 	if (de->hash_code != namehash)
 		return false;
 
 #ifdef CONFIG_UNICODE
-	entry.name = d->filename[bit_pos];
-	entry.len = de->name_len;
+	name = d->filename[bit_pos];
+	len = le16_to_cpu(de->name_len);
 
-	if (sb->s_encoding && IS_CASEFOLDED(parent)) {
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
@@ -616,13 +634,13 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 
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
@@ -632,7 +650,6 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 
 	level = 0;
 	slots = GET_DENTRY_SLOTS(new_name->len);
-	dentry_hash = f2fs_dentry_hash(dir, new_name, NULL);
 
 	current_depth = F2FS_I(dir)->i_current_depth;
 	if (F2FS_I(dir)->chash == dentry_hash) {
@@ -718,17 +735,19 @@ int f2fs_add_dentry(struct inode *dir, struct fscrypt_name *fname,
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
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0fc153b5a5c09..0937befccc578 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3073,11 +3073,6 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 							bool hot, bool set);
 struct dentry *f2fs_get_parent(struct dentry *child);
 
-extern int f2fs_ci_compare(const struct inode *parent,
-			   const struct qstr *name,
-			   const struct qstr *entry,
-			   bool quick);
-
 /*
  * dir.c
  */
@@ -3111,7 +3106,7 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 			const struct qstr *name, f2fs_hash_t name_hash,
 			unsigned int bit_pos);
 int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
-			const struct qstr *orig_name,
+			const struct qstr *orig_name, f2fs_hash_t dentry_hash,
 			struct inode *inode, nid_t ino, umode_t mode);
 int f2fs_add_dentry(struct inode *dir, struct fscrypt_name *fname,
 			struct inode *inode, nid_t ino, umode_t mode);
@@ -3144,7 +3139,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
  * hash.c
  */
 f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
-		const struct qstr *name_info, struct fscrypt_name *fname);
+		const struct qstr *name_info, const struct fscrypt_name *fname);
 
 /*
  * node.c
@@ -3656,7 +3651,7 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 			struct page *ipage);
 int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
-			const struct qstr *orig_name,
+			const struct fscrypt_name *fname,
 			struct inode *inode, nid_t ino, umode_t mode);
 void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry,
 				struct page *page, struct inode *dir,
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index 28acb24e7a7a8..23df352b969a1 100644
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
@@ -79,12 +80,17 @@ static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
 	size_t len = name_info->len;
 
 	/* encrypted bigname case */
-	if (fname && !fname->disk_name.name)
+	if (fname && !fname->is_ciphertext_name)
 		return cpu_to_le32(fname->hash);
 
 	if (is_dot_dotdot(name_info))
 		return 0;
 
+	if (IS_CASEFOLDED(dir) && IS_ENCRYPTED(dir)) {
+		f2fs_hash = cpu_to_le32(fscrypt_fname_siphash(dir, name_info));
+		return f2fs_hash;
+	}
+
 	/* Initialize the default seed for the hash checksum functions */
 	buf[0] = 0x67452301;
 	buf[1] = 0xefcdab89;
@@ -106,7 +112,7 @@ static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
 }
 
 f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
-		const struct qstr *name_info, struct fscrypt_name *fname)
+		const struct qstr *name_info, const struct fscrypt_name *fname)
 {
 #ifdef CONFIG_UNICODE
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
@@ -114,27 +120,30 @@ f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
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
index 4167e54081518..4b8fc643df735 100644
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
 
@@ -578,7 +578,7 @@ int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry)
 }
 
 int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
-				const struct qstr *orig_name,
+				const struct fscrypt_name *fname,
 				struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
@@ -589,6 +589,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 	struct f2fs_dentry_ptr d;
 	int slots = GET_DENTRY_SLOTS(new_name->len);
 	struct page *page = NULL;
+	const struct qstr *orig_name = fname->usr_fname;
 	int err = 0;
 
 	ipage = f2fs_get_node_page(sbi, dir->i_ino);
@@ -619,7 +620,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 
 	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 
-	name_hash = f2fs_dentry_hash(dir, new_name, NULL);
+	name_hash = f2fs_dentry_hash(dir, new_name, fname);
 	f2fs_update_dentry(ino, mode, &d, new_name, name_hash, bit_pos);
 
 	set_page_dirty(ipage);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7520a9c04c75e..b30925a44ac71 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3228,12 +3228,6 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
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
-- 
2.25.1.481.gfbce0eb801-goog

