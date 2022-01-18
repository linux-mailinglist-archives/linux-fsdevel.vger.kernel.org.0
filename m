Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342F2491F91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 07:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiARG4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 01:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiARG4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:56:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97962C061574;
        Mon, 17 Jan 2022 22:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=o/UcdyiAIg925Jywt5F3Je9svPf/ulQBu9faTwApEjM=; b=3ir5IvGqXuJIkq9fy6Aow1EQQq
        Er7f8hXL0EGonpq5ewXIaCiNpF9+ZfYvoULMLjT5qjFk4pL1Rvro2hr1RNW3y2Zrrd+8oMpl6PFnJ
        1mrvig7HbXZexhp0frjue/YlfJ5EDJkNGTGEeY9Q5a08r1xlBXNjYtupfEr4+zfjDWHu7uR6/e2dT
        KWn1XWG4le1hn3Sai2tOsr+HZOxDzyLDuNdYR+ZSzah7ub/4X090XZ7OqajfuzQoRmsG9zQLXhId9
        joXES3ytj3zbhucfCnwRPA+mBWNw9He+PLOTod/xFo2uIyy1BzS6qkbZ9LE6qcP7zwb7MAah6EoXs
        vuKORNGw==;
Received: from [2001:4bb8:184:72a4:a4a9:19c0:5242:7768] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9iPg-000UtP-NF; Tue, 18 Jan 2022 06:56:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH] unicode: clean up the Kconfig symbol confusion
Date:   Tue, 18 Jan 2022 07:56:14 +0100
Message-Id: <20220118065614.1241470-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn the CONFIG_UNICODE symbol into a tristate that generates some always
built in code and remove the confusing CONFIG_UNICODE_UTF8_DATA symbol.

Note that a lot of the IS_ENALBED() checks could be turned from cpp
statements into normal ifs, but this change is intended to be fairly
mechanic, so that should be cleaned up later.

Fixes: 2b3d04787012 ("unicode: Add utf8-data module")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/Makefile         |  2 +-
 fs/ext4/ext4.h      | 14 +++++++-------
 fs/ext4/hash.c      |  2 +-
 fs/ext4/namei.c     | 12 ++++++------
 fs/ext4/super.c     | 10 +++++-----
 fs/ext4/sysfs.c     |  8 ++++----
 fs/f2fs/dir.c       | 10 +++++-----
 fs/f2fs/f2fs.h      |  2 +-
 fs/f2fs/hash.c      |  2 +-
 fs/f2fs/namei.c     |  4 ++--
 fs/f2fs/recovery.c  |  4 ++--
 fs/f2fs/super.c     | 10 +++++-----
 fs/f2fs/sysfs.c     | 10 +++++-----
 fs/libfs.c          | 10 +++++-----
 fs/unicode/Kconfig  | 18 +++++-------------
 fs/unicode/Makefile |  6 ++++--
 include/linux/fs.h  |  2 +-
 17 files changed, 60 insertions(+), 66 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index 84c5e4cdfee5a..c71ee0127866b 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -94,7 +94,7 @@ obj-$(CONFIG_EXPORTFS)		+= exportfs/
 obj-$(CONFIG_NFSD)		+= nfsd/
 obj-$(CONFIG_LOCKD)		+= lockd/
 obj-$(CONFIG_NLS)		+= nls/
-obj-$(CONFIG_UNICODE)		+= unicode/
+obj-y				+= unicode/
 obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_SMBFS_COMMON)	+= smbfs_common/
 obj-$(CONFIG_CIFS)		+= cifs/
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 71a3cdceaa030..242e74cfb0606 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2485,7 +2485,7 @@ struct ext4_filename {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_str crypto_buf;
 #endif
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	struct fscrypt_str cf_name;
 #endif
 };
@@ -2721,7 +2721,7 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
 					      struct ext4_group_desc *gdp);
 ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 extern int ext4_fname_setup_ci_filename(struct inode *dir,
 					 const struct qstr *iname,
 					 struct ext4_filename *fname);
@@ -2754,7 +2754,7 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 
 	ext4_fname_from_fscrypt_name(fname, &name);
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, iname, fname);
 #endif
 	return err;
@@ -2773,7 +2773,7 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 
 	ext4_fname_from_fscrypt_name(fname, &name);
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
 #endif
 	return err;
@@ -2790,7 +2790,7 @@ static inline void ext4_fname_free_filename(struct ext4_filename *fname)
 	fname->usr_fname = NULL;
 	fname->disk_name.name = NULL;
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	kfree(fname->cf_name.name);
 	fname->cf_name.name = NULL;
 #endif
@@ -2806,7 +2806,7 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 	fname->disk_name.name = (unsigned char *) iname->name;
 	fname->disk_name.len = iname->len;
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	err = ext4_fname_setup_ci_filename(dir, iname, fname);
 #endif
 
@@ -2822,7 +2822,7 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 
 static inline void ext4_fname_free_filename(struct ext4_filename *fname)
 {
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	kfree(fname->cf_name.name);
 	fname->cf_name.name = NULL;
 #endif
diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index f34f4176c1e7c..147b5241dd94f 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -290,7 +290,7 @@ static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 		   struct dx_hash_info *hinfo)
 {
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	const struct unicode_map *um = dir->i_sb->s_encoding;
 	int r, dlen;
 	unsigned char *buff;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 52c9bd154122a..269d2d051edeb 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1317,7 +1317,7 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 	dx_set_count(entries, count + 1);
 }
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 /*
  * Test whether a case-insensitive directory entry matches the filename
  * being searched for.  If quick is set, assume the name being looked up
@@ -1428,7 +1428,7 @@ static bool ext4_match(struct inode *parent,
 	f.crypto_buf = fname->crypto_buf;
 #endif
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
 		if (fname->cf_name.name) {
@@ -1800,7 +1800,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		}
 	}
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	if (!inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
@@ -2308,7 +2308,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	if (fscrypt_is_nokey_name(dentry))
 		return -ENOKEY;
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
 	    sb->s_encoding && utf8_validate(sb->s_encoding, &dentry->d_name))
 		return -EINVAL;
@@ -3126,7 +3126,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	ext4_fc_track_unlink(handle, dentry);
 	retval = ext4_mark_inode_dirty(handle, dir);
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
@@ -3231,7 +3231,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	retval = __ext4_unlink(handle, dir, &dentry->d_name, d_inode(dentry));
 	if (!retval)
 		ext4_fc_track_unlink(handle, dentry);
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index db9fe48435293..52be1ca38eef6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1302,7 +1302,7 @@ static void ext4_put_super(struct super_block *sb)
 	kfree(sbi->s_blockgroup_lock);
 	fs_put_dax(sbi->s_daxdev);
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
 	kfree(sbi);
@@ -1962,7 +1962,7 @@ static const struct mount_opts {
 	{Opt_err, 0, 0}
 };
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 static const struct ext4_sb_encodings {
 	__u16 magic;
 	char *name;
@@ -3609,7 +3609,7 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 		return 0;
 	}
 
-#ifndef CONFIG_UNICODE
+#if !IS_ENABLED(CONFIG_UNICODE)
 	if (ext4_has_feature_casefold(sb)) {
 		ext4_msg(sb, KERN_ERR,
 			 "Filesystem with casefold feature cannot be "
@@ -4613,7 +4613,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (err < 0)
 		goto failed_mount;
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	if (ext4_has_feature_casefold(sb) && !sb->s_encoding) {
 		const struct ext4_sb_encodings *encoding_info;
 		struct unicode_map *encoding;
@@ -5517,7 +5517,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
 
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index f61e65ae27d8d..d233c24ea3425 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -309,7 +309,7 @@ EXT4_ATTR_FEATURE(meta_bg_resize);
 EXT4_ATTR_FEATURE(encryption);
 EXT4_ATTR_FEATURE(test_dummy_encryption_v2);
 #endif
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 EXT4_ATTR_FEATURE(casefold);
 #endif
 #ifdef CONFIG_FS_VERITY
@@ -317,7 +317,7 @@ EXT4_ATTR_FEATURE(verity);
 #endif
 EXT4_ATTR_FEATURE(metadata_csum_seed);
 EXT4_ATTR_FEATURE(fast_commit);
-#if defined(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
+#if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
 EXT4_ATTR_FEATURE(encrypted_casefold);
 #endif
 
@@ -329,7 +329,7 @@ static struct attribute *ext4_feat_attrs[] = {
 	ATTR_LIST(encryption),
 	ATTR_LIST(test_dummy_encryption_v2),
 #endif
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	ATTR_LIST(casefold),
 #endif
 #ifdef CONFIG_FS_VERITY
@@ -337,7 +337,7 @@ static struct attribute *ext4_feat_attrs[] = {
 #endif
 	ATTR_LIST(metadata_csum_seed),
 	ATTR_LIST(fast_commit),
-#if defined(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
+#if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
 	ATTR_LIST(encrypted_casefold),
 #endif
 	NULL,
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 1820e9c106f7d..166f086233625 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -16,7 +16,7 @@
 #include "xattr.h"
 #include <trace/events/f2fs.h>
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 extern struct kmem_cache *f2fs_cf_name_slab;
 #endif
 
@@ -79,7 +79,7 @@ unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de)
 int f2fs_init_casefolded_name(const struct inode *dir,
 			      struct f2fs_filename *fname)
 {
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	struct super_block *sb = dir->i_sb;
 
 	if (IS_CASEFOLDED(dir)) {
@@ -174,7 +174,7 @@ void f2fs_free_filename(struct f2fs_filename *fname)
 	kfree(fname->crypto_buf.name);
 	fname->crypto_buf.name = NULL;
 #endif
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	if (fname->cf_name.name) {
 		kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
 		fname->cf_name.name = NULL;
@@ -208,7 +208,7 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 	return f2fs_find_target_dentry(&d, fname, max_slots);
 }
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 /*
  * Test whether a case-insensitive directory entry matches the filename
  * being searched for.
@@ -266,7 +266,7 @@ static inline int f2fs_match_name(const struct inode *dir,
 {
 	struct fscrypt_name f;
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	if (fname->cf_name.name) {
 		struct qstr cf = FSTR_TO_QSTR(&fname->cf_name);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d0d6031871719..4da88928ffb52 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -487,7 +487,7 @@ struct f2fs_filename {
 	 */
 	struct fscrypt_str crypto_buf;
 #endif
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	/*
 	 * For casefolded directories: the casefolded name, but it's left NULL
 	 * if the original name is not valid Unicode, if the directory is both
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index e3beac546c63a..3cb1e7a24740f 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -105,7 +105,7 @@ void f2fs_hash_filename(const struct inode *dir, struct f2fs_filename *fname)
 		return;
 	}
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	if (IS_CASEFOLDED(dir)) {
 		/*
 		 * If the casefolded name is provided, hash it instead of the
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a728a0af9ce0c..5f213f05556dc 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -561,7 +561,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_iput;
 	}
 out_splice:
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	if (!inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
@@ -622,7 +622,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		goto fail;
 	}
 	f2fs_delete_entry(de, page, dir, inode);
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d1664a0567efe..2fbbc820c00ab 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -46,7 +46,7 @@
 
 static struct kmem_cache *fsync_entry_slab;
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 extern struct kmem_cache *f2fs_cf_name_slab;
 #endif
 
@@ -149,7 +149,7 @@ static int init_recovered_filename(const struct inode *dir,
 		if (err)
 			return err;
 		f2fs_hash_filename(dir, fname);
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 		/* Case-sensitive match is fine for recovery */
 		kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
 		fname->cf_name.name = NULL;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 15f12ece0ac63..b870c6459fa12 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -256,7 +256,7 @@ void f2fs_printk(struct f2fs_sb_info *sbi, const char *fmt, ...)
 	va_end(args);
 }
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 static const struct f2fs_sb_encodings {
 	__u16 magic;
 	char *name;
@@ -1218,7 +1218,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 #endif
-#ifndef CONFIG_UNICODE
+#if !IS_ENABLED(CONFIG_UNICODE)
 	if (f2fs_sb_has_casefold(sbi)) {
 		f2fs_err(sbi,
 			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
@@ -1578,7 +1578,7 @@ static void f2fs_put_super(struct super_block *sb)
 	f2fs_destroy_iostat(sbi);
 	for (i = 0; i < NR_PAGE_TYPE; i++)
 		kvfree(sbi->write_io[i]);
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
 	kfree(sbi);
@@ -3861,7 +3861,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 {
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	if (f2fs_sb_has_casefold(sbi) && !sbi->sb->s_encoding) {
 		const struct f2fs_sb_encodings *encoding_info;
 		struct unicode_map *encoding;
@@ -4412,7 +4412,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	for (i = 0; i < NR_PAGE_TYPE; i++)
 		kvfree(sbi->write_io[i]);
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 	sb->s_encoding = NULL;
 #endif
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 8408f77764e85..fa3d9cb2d69b8 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -192,7 +192,7 @@ static ssize_t unusable_show(struct f2fs_attr *a,
 static ssize_t encoding_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	struct super_block *sb = sbi->sb;
 
 	if (f2fs_sb_has_casefold(sbi))
@@ -756,7 +756,7 @@ F2FS_GENERAL_RO_ATTR(avg_vblocks);
 #ifdef CONFIG_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption);
 F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2);
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 F2FS_FEATURE_RO_ATTR(encrypted_casefold);
 #endif
 #endif /* CONFIG_FS_ENCRYPTION */
@@ -775,7 +775,7 @@ F2FS_FEATURE_RO_ATTR(lost_found);
 F2FS_FEATURE_RO_ATTR(verity);
 #endif
 F2FS_FEATURE_RO_ATTR(sb_checksum);
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 F2FS_FEATURE_RO_ATTR(casefold);
 #endif
 F2FS_FEATURE_RO_ATTR(readonly);
@@ -886,7 +886,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_FS_ENCRYPTION
 	ATTR_LIST(encryption),
 	ATTR_LIST(test_dummy_encryption_v2),
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	ATTR_LIST(encrypted_casefold),
 #endif
 #endif /* CONFIG_FS_ENCRYPTION */
@@ -905,7 +905,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(verity),
 #endif
 	ATTR_LIST(sb_checksum),
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	ATTR_LIST(casefold),
 #endif
 	ATTR_LIST(readonly),
diff --git a/fs/libfs.c b/fs/libfs.c
index ba7438ab93710..974125270a428 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1379,7 +1379,7 @@ bool is_empty_dir_inode(struct inode *inode)
 		(inode->i_op == &empty_dir_inode_operations);
 }
 
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 /*
  * Determine if the name of a dentry should be casefolded.
  *
@@ -1473,7 +1473,7 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 };
 #endif
 
-#if defined(CONFIG_FS_ENCRYPTION) && defined(CONFIG_UNICODE)
+#if defined(CONFIG_FS_ENCRYPTION) && IS_ENABLED(CONFIG_UNICODE)
 static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
@@ -1508,10 +1508,10 @@ void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
 #ifdef CONFIG_FS_ENCRYPTION
 	bool needs_encrypt_ops = dentry->d_flags & DCACHE_NOKEY_NAME;
 #endif
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	bool needs_ci_ops = dentry->d_sb->s_encoding;
 #endif
-#if defined(CONFIG_FS_ENCRYPTION) && defined(CONFIG_UNICODE)
+#if defined(CONFIG_FS_ENCRYPTION) && IS_ENABLED(CONFIG_UNICODE)
 	if (needs_encrypt_ops && needs_ci_ops) {
 		d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
 		return;
@@ -1523,7 +1523,7 @@ void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
 		return;
 	}
 #endif
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	if (needs_ci_ops) {
 		d_set_d_op(dentry, &generic_ci_dentry_ops);
 		return;
diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
index 610d7bc05d6e3..da786a687fdc7 100644
--- a/fs/unicode/Kconfig
+++ b/fs/unicode/Kconfig
@@ -3,21 +3,13 @@
 # UTF-8 normalization
 #
 config UNICODE
-	bool "UTF-8 normalization and casefolding support"
+	tristate "UTF-8 normalization and casefolding support"
 	help
 	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
-	  support.
-
-config UNICODE_UTF8_DATA
-	tristate "UTF-8 normalization and casefolding tables"
-	depends on UNICODE
-	default UNICODE
-	help
-	  This contains a large table of case foldings, which can be loaded as
-	  a separate module if you say M here.  To be on the safe side stick
-	  to the default of Y.  Saying N here makes no sense, if you do not want
-	  utf8 casefolding support, disable CONFIG_UNICODE instead.
+	  support.  If you say M here the large table of case foldings will
+	  be a separate loadable module that gets requested only when a file
+	  system actually use it.
 
 config UNICODE_NORMALIZATION_SELFTEST
 	tristate "Test UTF-8 normalization support"
-	depends on UNICODE_UTF8_DATA
+	depends on UNICODE
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index 2f9d9188852b5..0cc87423de828 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -1,8 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_UNICODE) += unicode.o
+ifneq ($(CONFIG_UNICODE),)
+obj-y			+= unicode.o
+endif
+obj-$(CONFIG_UNICODE)	+= utf8data.o
 obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
-obj-$(CONFIG_UNICODE_UTF8_DATA) += utf8data.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c8510da6cc6dc..fdac22d16c2b8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1490,7 +1490,7 @@ struct super_block {
 #ifdef CONFIG_FS_VERITY
 	const struct fsverity_operations *s_vop;
 #endif
-#ifdef CONFIG_UNICODE
+#if IS_ENABLED(CONFIG_UNICODE)
 	struct unicode_map *s_encoding;
 	__u16 s_encoding_flags;
 #endif
-- 
2.30.2

