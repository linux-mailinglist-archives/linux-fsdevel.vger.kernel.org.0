Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88D110F6BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfLCFLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:11:42 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49258 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfLCFLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:11:39 -0500
Received: by mail-pf1-f202.google.com with SMTP id b15so1437470pfo.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 21:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8c3eVVk8ABGDZTJOomUNLBljUeAWHPLfmm8OYMOygK0=;
        b=oteLf7N3qbZYVjncqfLGA35MNoLNyK5bhXImCiwSRn+6fiSbsFuJbMRE6gWfyVjNPe
         Og932LtndCbABZdP1w0ocZDRInigouXSWrDI3b8o3dKLEFTZKzkADdIKDQYo4b/DHdFk
         mbMDSCm3b0aqMpX0xNVYs8YjTftAE9V3OzJr1klNESjbku9d/N6rK+PeOBegUEgZ0CII
         cIVtfx0krdmO0+9m0DyAzo4H+HvtdeikT93i5iYvInW+TE3f7JX61Ee4NEmpN632Mw83
         CnGeO3lKi2fHV9V7pvjyUBedXrE45c7uAyu85CRsKhyQsT3S3O3fPS8xBRflmMvRYGPr
         YR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8c3eVVk8ABGDZTJOomUNLBljUeAWHPLfmm8OYMOygK0=;
        b=cCFNQgXVm7n4WDnCevPgQ1t4W9ymSuq0JSf69eyVWAWmVEOtu6t+23var+3hEwT+i4
         18UrxK5p9iQlMxLVsdzJ1AIscqeAjKC7CnLIiwguU2VlD3X92l+dszM7fOJYAaniAQ1s
         EAWkqjMDdA2weJ24547fMleugPj4uY6vO+oNjfDOOY/m1iX7+upEoubC7BEf0GHW+CKD
         0kurYTf5DlC6sgc+On7yLzZmeIxb2wbfnwEW3u55JKWTpe/HtHm3tXK8BVRWHtdfVZtu
         twQM9N/UDhYwEKvQkdld5G/ed++831TmG6GObsZjjN1oNOrMkvtf2SY2Oi3dR2AvwRqa
         5dVw==
X-Gm-Message-State: APjAAAVfx0MzrZfMCSgJH1lueVKJlUxzp+U3ioQTn2tUxEOuUEjyLixs
        EDYkshtfda68riikgi+c+PPllL52i5I=
X-Google-Smtp-Source: APXvYqxs0GmfjTuZRzU9OqqYkBnp2/dJZPB77L72bpUcJ78IvKiht+67nFiNcmf43OSpi5CswMqkIUEsYvs=
X-Received: by 2002:a63:c849:: with SMTP id l9mr3486754pgi.330.1575349898899;
 Mon, 02 Dec 2019 21:11:38 -0800 (PST)
Date:   Mon,  2 Dec 2019 21:10:49 -0800
In-Reply-To: <20191203051049.44573-1-drosen@google.com>
Message-Id: <20191203051049.44573-9-drosen@google.com>
Mime-Version: 1.0
References: <20191203051049.44573-1-drosen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 8/8] ext4: Optimize match for casefolded encrypted dirs
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

Matching names with casefolded encrypting directories requires
decrypting entries to confirm case since we are case preserving. We can
avoid needing to decrypt if our hash values don't match.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/ext4/ext4.h  | 17 ++++++++-------
 fs/ext4/namei.c | 57 ++++++++++++++++++++++++++-----------------------
 2 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f06bab489d37..f104c46a6895 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2393,9 +2393,9 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
 ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
 #ifdef CONFIG_UNICODE
-extern void ext4_fname_setup_ci_filename(struct inode *dir,
+extern int ext4_fname_setup_ci_filename(struct inode *dir,
 					 const struct qstr *iname,
-					 struct fscrypt_str *fname);
+					 struct ext4_filename *fname);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -2426,9 +2426,9 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 	ext4_fname_from_fscrypt_name(fname, &name);
 
 #ifdef CONFIG_UNICODE
-	ext4_fname_setup_ci_filename(dir, iname, &fname->cf_name);
+	err = ext4_fname_setup_ci_filename(dir, iname, fname);
 #endif
-	return 0;
+	return err;
 }
 
 static inline int ext4_fname_prepare_lookup(struct inode *dir,
@@ -2445,9 +2445,9 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 	ext4_fname_from_fscrypt_name(fname, &name);
 
 #ifdef CONFIG_UNICODE
-	ext4_fname_setup_ci_filename(dir, &dentry->d_name, &fname->cf_name);
+	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
 #endif
-	return 0;
+	return err;
 }
 
 static inline void ext4_fname_free_filename(struct ext4_filename *fname)
@@ -2472,15 +2472,16 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 					    int lookup,
 					    struct ext4_filename *fname)
 {
+	int err = 0;
 	fname->usr_fname = iname;
 	fname->disk_name.name = (unsigned char *) iname->name;
 	fname->disk_name.len = iname->len;
 
 #ifdef CONFIG_UNICODE
-	ext4_fname_setup_ci_filename(dir, iname, &fname->cf_name);
+	err = ext4_fname_setup_ci_filename(dir, iname, fname);
 #endif
 
-	return 0;
+	return err;
 }
 
 static inline int ext4_fname_prepare_lookup(struct inode *dir,
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index f536cfc626bd..58b58fb532ba 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -784,7 +784,9 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	if (hinfo->hash_version <= DX_HASH_TEA)
 		hinfo->hash_version += EXT4_SB(dir->i_sb)->s_hash_unsigned;
 	hinfo->seed = EXT4_SB(dir->i_sb)->s_hash_seed;
-	if (fname && fname_name(fname))
+	/* hash is already computed for encrypted casefolded directory */
+	if (fname && fname_name(fname) &&
+				!(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)))
 		ext4fs_dirhash(dir, fname_name(fname), fname_len(fname), hinfo);
 	hash = hinfo->hash;
 
@@ -1352,19 +1354,21 @@ int ext4_ci_compare(struct inode *parent, const struct qstr *name,
 	return ret;
 }
 
-void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
-				  struct fscrypt_str *cf_name)
+int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
+				  struct ext4_filename *name)
 {
+	struct fscrypt_str *cf_name = &name->cf_name;
+	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
-	if (!IS_CASEFOLDED(dir) || !dir->i_sb->s_encoding) {
+	if (!needs_casefold(dir) || !dir->i_sb->s_encoding) {
 		cf_name->name = NULL;
-		return;
+		return 0;
 	}
 
 	cf_name->name = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
 	if (!cf_name->name)
-		return;
+		return -ENOMEM;
 
 	len = utf8_casefold(dir->i_sb->s_encoding,
 			    iname, cf_name->name,
@@ -1372,10 +1376,18 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	if (len <= 0) {
 		kfree(cf_name->name);
 		cf_name->name = NULL;
-		return;
 	}
 	cf_name->len = (unsigned) len;
+	if (!IS_ENCRYPTED(dir))
+		return 0;
 
+	hinfo->hash_version = DX_HASH_SIPHASH;
+	hinfo->seed = NULL;
+	if (cf_name->name)
+		ext4fs_dirhash(dir, cf_name->name, cf_name->len, hinfo);
+	else
+		ext4fs_dirhash(dir, iname->name, iname->len, hinfo);
+	return 0;
 }
 #endif
 
@@ -1405,16 +1417,12 @@ static bool ext4_match(struct inode *parent,
 			struct qstr cf = {.name = fname->cf_name.name,
 					  .len = fname->cf_name.len};
 			if (IS_ENCRYPTED(parent)) {
-				struct dx_hash_info hinfo;
-
-				hinfo.hash_version = DX_HASH_SIPHASH;
-				hinfo.seed = NULL;
-				ext4fs_dirhash(parent, fname->cf_name.name,
-						fname_len(fname), &hinfo);
-				if (hinfo.hash != EXT4_DIRENT_HASH(de) ||
-						hinfo.minor_hash !=
-						    EXT4_DIRENT_MINOR_HASH(de))
+				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
+					fname->hinfo.minor_hash !=
+						EXT4_DIRENT_MINOR_HASH(de)) {
+
 					return 0;
+				}
 			}
 			return !ext4_ci_compare(parent, &cf, de->name,
 							de->name_len, true);
@@ -2036,15 +2044,11 @@ void ext4_insert_dentry(struct inode *dir,
 	de->name_len = fname_len(fname);
 	memcpy(de->name, fname_name(fname), fname_len(fname));
 	if (ext4_hash_in_dirent(dir)) {
-		struct dx_hash_info hinfo;
+		struct dx_hash_info *hinfo = &fname->hinfo;
 
-		hinfo.hash_version = DX_HASH_SIPHASH;
-		hinfo.seed = NULL;
-		ext4fs_dirhash(dir, fname_usr_name(fname),
-				fname_len(fname), &hinfo);
-		EXT4_EXTENDED_DIRENT(de)->hash = cpu_to_le32(hinfo.hash);
+		EXT4_EXTENDED_DIRENT(de)->hash = cpu_to_le32(hinfo->hash);
 		EXT4_EXTENDED_DIRENT(de)->minor_hash =
-				cpu_to_le32(hinfo.minor_hash);
+						cpu_to_le32(hinfo->minor_hash);
 	}
 }
 
@@ -2195,10 +2199,9 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	if (fname->hinfo.hash_version <= DX_HASH_TEA)
 		fname->hinfo.hash_version += EXT4_SB(dir->i_sb)->s_hash_unsigned;
 	fname->hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
-	if (ext4_hash_in_dirent(dir))
-		ext4fs_dirhash(dir, fname_usr_name(fname),
-				fname_len(fname), &fname->hinfo);
-	else
+
+	/* casefolded encrypted hashes are computed on fname setup */
+	if (!ext4_hash_in_dirent(dir))
 		ext4fs_dirhash(dir, fname_name(fname),
 				fname_len(fname), &fname->hinfo);
 
-- 
2.24.0.393.g34dc348eaf-goog

