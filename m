Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD8F274E37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 03:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgIWBJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 21:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgIWBJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:09:22 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3594C0613D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 18:09:21 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id t5so605954pji.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 18:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UXkehzvVthn+mSRYJPA6+Coe+VvF582hmhtC0z8KVqE=;
        b=u0JwnoVImdURydjwn3HArbGhXoAmo6RQnPRzjFw04Mg4rfEOAkeC01SIFO2xawCovC
         XvkmFHEMDFi1Z0RtossatswoPLYZxplfwSeFTMAx5+eQ3NNAK7OEi6vaOH/jWJURsKHj
         K1XY3YICbYrc2VoY0vr/K6MqAzfFg9AHTtVF+c66sCeoVNbv7u8eT0sxFmI38sYZafPP
         H8RThDcMbdy/aP7Y3j/9+XPwA4gazkAniVL/ngTGNRb1vqfbk1BMw/JK1KDSb8txakt1
         OcTz63KltG0EZ9DR1OEcp5vNNpioBoyNcIF/RIxa7NY4UMwS243gNv28xQoLfNAXgBCm
         Z68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UXkehzvVthn+mSRYJPA6+Coe+VvF582hmhtC0z8KVqE=;
        b=e6rsRHivhxxH5JCOB8+dM7Fe9q2hnPw2pdCKLPpPHpVkQJukaZvokPCjzTZKjy/zaj
         iB1ekrrhr3FvGfdzdmzMslKzaHIm4e750FemIRFH62TOaN2uXtUk16zwLFkQQYdxXPhy
         gRe+BL/MAy/UyHrvxhbzzvH0zbgcJMU1YDzZcFBqFWev1TtiE6tD0bHbCn/T2+CchEUU
         +GJEdHpnynhrZBhDcSMObQIKQY1JJ5kPu1KIOvxIzAXVotn5vOLD+PbL/vo6CBGI0+1E
         U4VMRmXynNiK0lKggBBvvJz7+nzKR4krQzgnvZkvv6EKiBrar66Cy5pmR5jfvXSeE4a9
         gAzQ==
X-Gm-Message-State: AOAM533/hPcGoKe6rj4WywLxqmwxOVnBdBe9jEf/JX76BNVCycWwW0J2
        w6smKhTmX4nAMXbIk3FXaYvieZL/TOs=
X-Google-Smtp-Source: ABdhPJxbF6owFPI+Iummby4MAlem6Vnjkco0sWyz/Q/+FUr42s2yBkcY6VBDGXuR9x4zNFzE7ccvEmfxt3U=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a17:902:bd90:b029:d2:439c:385a with SMTP id
 q16-20020a170902bd90b02900d2439c385amr4536126pls.35.1600823361238; Tue, 22
 Sep 2020 18:09:21 -0700 (PDT)
Date:   Wed, 23 Sep 2020 01:01:47 +0000
In-Reply-To: <20200923010151.69506-1-drosen@google.com>
Message-Id: <20200923010151.69506-2-drosen@google.com>
Mime-Version: 1.0
References: <20200923010151.69506-1-drosen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 1/5] ext4: Use generic casefolding support
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
index 523e00d7b392..5df0fbd6add4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1411,14 +1411,6 @@ struct ext4_super_block {
 
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
@@ -1468,10 +1460,6 @@ struct ext4_sb_info {
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
index 2924261226e0..a92eb79de0cc 100644
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
index 153a9fbe1dd0..ea7dee80c8a4 100644
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
@@ -2181,9 +2181,6 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	struct buffer_head *bh = NULL;
 	struct ext4_dir_entry_2 *de;
 	struct super_block *sb;
-#ifdef CONFIG_UNICODE
-	struct ext4_sb_info *sbi;
-#endif
 	struct ext4_filename fname;
 	int	retval;
 	int	dx_fallback=0;
@@ -2200,9 +2197,8 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
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
index ea425b49b345..8a261a6bb608 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1106,7 +1106,7 @@ static void ext4_put_super(struct super_block *sb)
 	fs_put_dax(sbi->s_daxdev);
 	fscrypt_free_dummy_context(&sbi->s_dummy_enc_ctx);
 #ifdef CONFIG_UNICODE
-	utf8_unload(sbi->s_encoding);
+	utf8_unload(sb->s_encoding);
 #endif
 	kfree(sbi);
 }
@@ -4077,7 +4077,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 
 #ifdef CONFIG_UNICODE
-	if (ext4_has_feature_casefold(sb) && !sbi->s_encoding) {
+	if (ext4_has_feature_casefold(sb) && !sb->s_encoding) {
 		const struct ext4_sb_encodings *encoding_info;
 		struct unicode_map *encoding;
 		__u16 encoding_flags;
@@ -4108,8 +4108,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			 "%s-%s with flags 0x%hx", encoding_info->name,
 			 encoding_info->version?:"\b", encoding_flags);
 
-		sbi->s_encoding = encoding;
-		sbi->s_encoding_flags = encoding_flags;
+		sb->s_encoding = encoding;
+		sb->s_encoding_flags = encoding_flags;
 	}
 #endif
 
@@ -4720,7 +4720,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 #ifdef CONFIG_UNICODE
-	if (sbi->s_encoding)
+	if (sb->s_encoding)
 		sb->s_d_op = &ext4_dentry_ops;
 #endif
 
@@ -4928,7 +4928,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		crypto_free_shash(sbi->s_chksum_driver);
 
 #ifdef CONFIG_UNICODE
-	utf8_unload(sbi->s_encoding);
+	utf8_unload(sb->s_encoding);
 #endif
 
 #ifdef CONFIG_QUOTA
-- 
2.28.0.681.g6f77f65b4e-goog

