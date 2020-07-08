Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C2A217D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 05:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgGHDGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 23:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgGHDGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:06:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B84C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 20:06:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id o34so33914450pgm.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 20:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G27tBbHNYNifBmu52vtQ20nF/LRgtln5mcnSaFhYvNA=;
        b=CKgoqUeVYi/DsD+rkEOlOID5hBNX4cchFp0H7n9C4fEWMMUQvZLm6+SxzweySreRTo
         svmSUPdRCrtkt2+OlsQ3jRiMT9Objjz4W2XNZvWYBYOBc2201+pfSOT/e/drMLMoDHI0
         iXouIBG9mn4gD4bn7xbSOneCQ/W6Fb98C09tzDV8jlCzoJfl4QYODLUCjZiHvhDMSC+o
         DP0cApPKTAEz9FeeVtWVBiefZCAwDqUn8JZSrI+iQY0ZXrg+sCkyq7aCbLdNC8X+rUyV
         AaRnjNgtsKlL4C7F1RMKGwBfuYSzHkk3T9HtiyooywwB/BWo7X6HMvNQUyYRJtcdJDiP
         WodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G27tBbHNYNifBmu52vtQ20nF/LRgtln5mcnSaFhYvNA=;
        b=a+wX1lSx5nf6LtWKNoi5Vh0nGo+pp/O1a07SW/yk2B9ZwXkMqZhyoikIroLDRHOiYG
         vEY+1LKIdGppcurm/7VlyrLm/pLab0zWd3eUFBGyMVNMPRFrnKaX3VAsgDuj6EsfGjsZ
         b1N0198A9gsfMDezEKuLcTDll/cFZ6BfjzRRaU+pHrE+/yBAR/aG3GKlKTFCqoSaxqZ6
         ssLiHXZkWzMwDLbbYOaCCr4Yjn5O2aT7TjksrbyAySN9pJOd7j/fOTbctrou5Oe0OxCV
         4G/I68l24wQZqLkEjTosqWCuMmA4mSE6YoGcPCe4tZ8GjS/7jZYkeSj72hk82N5/pa0C
         7FDQ==
X-Gm-Message-State: AOAM533ED3UDxlvKfvYX/2COzEkOL/9Tysm0BPDMvS+81miLc2T4iPfJ
        5yt9jydbFC5zeVtADPG3/1Wu6er615k=
X-Google-Smtp-Source: ABdhPJxdrc8A4bDG93CQStR9efk1lpW2i6Hxe2kguKUZwdKpaObLJ0VmZu/tjGO55r7poc9tAoHaeaoFANE=
X-Received: by 2002:a63:7741:: with SMTP id s62mr46612376pgc.332.1594177564826;
 Tue, 07 Jul 2020 20:06:04 -0700 (PDT)
Date:   Tue,  7 Jul 2020 20:05:52 -0700
In-Reply-To: <20200708030552.3829094-1-drosen@google.com>
Message-Id: <20200708030552.3829094-5-drosen@google.com>
Mime-Version: 1.0
References: <20200708030552.3829094-1-drosen@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v11 4/4] ext4: Use generic casefolding support
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

This switches ext4 over to the generic support provided in
the previous patch.

Since casefolded dentries behave the same in ext4 and f2fs, we decrease
the maintenance burden by unifying them, and any optimizations will
immediately apply to both.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/dir.c   | 64 ++-----------------------------------------------
 fs/ext4/ext4.h  | 12 ----------
 fs/ext4/hash.c  |  2 +-
 fs/ext4/namei.c | 20 +++++++---------
 fs/ext4/super.c | 12 +++++-----
 5 files changed, 17 insertions(+), 93 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 1d82336b1cd4..b437120f0b3f 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -669,68 +669,8 @@ const struct file_operations ext4_dir_operations = {
 };
 
 #ifdef CONFIG_UNICODE
-static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
-			  const char *str, const struct qstr *name)
-{
-	struct qstr qstr = {.name = str, .len = len };
-	const struct dentry *parent = READ_ONCE(dentry->d_parent);
-	const struct inode *inode = READ_ONCE(parent->d_inode);
-	char strbuf[DNAME_INLINE_LEN];
-
-	if (!inode || !IS_CASEFOLDED(inode) ||
-	    !EXT4_SB(inode->i_sb)->s_encoding) {
-		if (len != name->len)
-			return -1;
-		return memcmp(str, name->name, len);
-	}
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
-		qstr.name = strbuf;
-		/* prevent compiler from optimizing out the temporary buffer */
-		barrier();
-	}
-
-	return ext4_ci_compare(inode, name, &qstr, false);
-}
-
-static int ext4_d_hash(const struct dentry *dentry, struct qstr *str)
-{
-	const struct ext4_sb_info *sbi = EXT4_SB(dentry->d_sb);
-	const struct unicode_map *um = sbi->s_encoding;
-	const struct inode *inode = READ_ONCE(dentry->d_inode);
-	unsigned char *norm;
-	int len, ret = 0;
-
-	if (!inode || !IS_CASEFOLDED(inode) || !um)
-		return 0;
-
-	norm = kmalloc(PATH_MAX, GFP_ATOMIC);
-	if (!norm)
-		return -ENOMEM;
-
-	len = utf8_casefold(um, str, norm, PATH_MAX);
-	if (len < 0) {
-		if (ext4_has_strict_mode(sbi))
-			ret = -EINVAL;
-		goto out;
-	}
-	str->hash = full_name_hash(dentry, norm, len);
-out:
-	kfree(norm);
-	return ret;
-}
-
 const struct dentry_operations ext4_dentry_ops = {
-	.d_hash = ext4_d_hash,
-	.d_compare = ext4_d_compare,
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
 };
 #endif
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42f5060f3cdf..5cd8be24a4fd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1393,14 +1393,6 @@ struct ext4_super_block {
 
 #define EXT4_ENC_UTF8_12_1	1
 
-/*
- * Flags for ext4_sb_info.s_encoding_flags.
- */
-#define EXT4_ENC_STRICT_MODE_FL	(1 << 0)
-
-#define ext4_has_strict_mode(sbi) \
-	(sbi->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL)
-
 /*
  * fourth extended-fs super-block data in memory
  */
@@ -1450,10 +1442,6 @@ struct ext4_sb_info {
 	struct kobject s_kobj;
 	struct completion s_kobj_unregister;
 	struct super_block *s_sb;
-#ifdef CONFIG_UNICODE
-	struct unicode_map *s_encoding;
-	__u16 s_encoding_flags;
-#endif
 
 	/* Journaling */
 	struct journal_s *s_journal;
diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 3e133793a5a3..143b0073b3f4 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -275,7 +275,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 		   struct dx_hash_info *hinfo)
 {
 #ifdef CONFIG_UNICODE
-	const struct unicode_map *um = EXT4_SB(dir->i_sb)->s_encoding;
+	const struct unicode_map *um = dir->i_sb->s_encoding;
 	int r, dlen;
 	unsigned char *buff;
 	struct qstr qstr = {.name = name, .len = len };
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 56738b538ddf..6ffd53e6455e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1286,8 +1286,8 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 		    const struct qstr *entry, bool quick)
 {
-	const struct ext4_sb_info *sbi = EXT4_SB(parent->i_sb);
-	const struct unicode_map *um = sbi->s_encoding;
+	const struct super_block *sb = parent->i_sb;
+	const struct unicode_map *um = sb->s_encoding;
 	int ret;
 
 	if (quick)
@@ -1299,7 +1299,7 @@ int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 		/* Handle invalid character sequence as either an error
 		 * or as an opaque byte sequence.
 		 */
-		if (ext4_has_strict_mode(sbi))
+		if (sb_has_strict_encoding(sb))
 			return -EINVAL;
 
 		if (name->len != entry->len)
@@ -1316,7 +1316,7 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 {
 	int len;
 
-	if (!IS_CASEFOLDED(dir) || !EXT4_SB(dir->i_sb)->s_encoding) {
+	if (!IS_CASEFOLDED(dir) || !dir->i_sb->s_encoding) {
 		cf_name->name = NULL;
 		return;
 	}
@@ -1325,7 +1325,7 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	if (!cf_name->name)
 		return;
 
-	len = utf8_casefold(EXT4_SB(dir->i_sb)->s_encoding,
+	len = utf8_casefold(dir->i_sb->s_encoding,
 			    iname, cf_name->name,
 			    EXT4_NAME_LEN);
 	if (len <= 0) {
@@ -1362,7 +1362,7 @@ static inline bool ext4_match(const struct inode *parent,
 #endif
 
 #ifdef CONFIG_UNICODE
-	if (EXT4_SB(parent->i_sb)->s_encoding && IS_CASEFOLDED(parent)) {
+	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent)) {
 		if (fname->cf_name.name) {
 			struct qstr cf = {.name = fname->cf_name.name,
 					  .len = fname->cf_name.len};
@@ -2171,9 +2171,6 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	struct buffer_head *bh = NULL;
 	struct ext4_dir_entry_2 *de;
 	struct super_block *sb;
-#ifdef CONFIG_UNICODE
-	struct ext4_sb_info *sbi;
-#endif
 	struct ext4_filename fname;
 	int	retval;
 	int	dx_fallback=0;
@@ -2190,9 +2187,8 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 		return -EINVAL;
 
 #ifdef CONFIG_UNICODE
-	sbi = EXT4_SB(sb);
-	if (ext4_has_strict_mode(sbi) && IS_CASEFOLDED(dir) &&
-	    sbi->s_encoding && utf8_validate(sbi->s_encoding, &dentry->d_name))
+	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
+	    sb->s_encoding && utf8_validate(sb->s_encoding, &dentry->d_name))
 		return -EINVAL;
 #endif
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957ed1f05..d097771a374f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1102,7 +1102,7 @@ static void ext4_put_super(struct super_block *sb)
 	fs_put_dax(sbi->s_daxdev);
 	fscrypt_free_dummy_context(&sbi->s_dummy_enc_ctx);
 #ifdef CONFIG_UNICODE
-	utf8_unload(sbi->s_encoding);
+	utf8_unload(sb->s_encoding);
 #endif
 	kfree(sbi);
 }
@@ -4035,7 +4035,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 
 #ifdef CONFIG_UNICODE
-	if (ext4_has_feature_casefold(sb) && !sbi->s_encoding) {
+	if (ext4_has_feature_casefold(sb) && !sb->s_encoding) {
 		const struct ext4_sb_encodings *encoding_info;
 		struct unicode_map *encoding;
 		__u16 encoding_flags;
@@ -4066,8 +4066,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			 "%s-%s with flags 0x%hx", encoding_info->name,
 			 encoding_info->version?:"\b", encoding_flags);
 
-		sbi->s_encoding = encoding;
-		sbi->s_encoding_flags = encoding_flags;
+		sb->s_encoding = encoding;
+		sb->s_encoding_flags = encoding_flags;
 	}
 #endif
 
@@ -4678,7 +4678,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 #ifdef CONFIG_UNICODE
-	if (sbi->s_encoding)
+	if (sb->s_encoding)
 		sb->s_d_op = &ext4_dentry_ops;
 #endif
 
@@ -4873,7 +4873,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		crypto_free_shash(sbi->s_chksum_driver);
 
 #ifdef CONFIG_UNICODE
-	utf8_unload(sbi->s_encoding);
+	utf8_unload(sb->s_encoding);
 #endif
 
 #ifdef CONFIG_QUOTA
-- 
2.27.0.383.g050319c2ae-goog

