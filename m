Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8664D156267
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 02:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgBHBgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 20:36:19 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43159 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgBHBgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 20:36:16 -0500
Received: by mail-pf1-f201.google.com with SMTP id x199so813918pfc.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 17:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jezUd818PVSIqYNtA0ccbF6QkEzuHEy5btO6fArvPPs=;
        b=MrdeH4pOG0VhjokrPO+C8+7Nf4YOufJfkN9hYYa2/oz3ncPTo4B2SAZ8SdkjjAqgI1
         gcExPRszzjqxMxAI7pSi2N38MMxvBlIzg5R/elCsep46b5vsrYA45ae/KmPa+q4Ouk91
         c/okvWEhds0a0XG3T3/I+z0lw4v2NpT9X+AdWMEJ6lbWF9L3qSuv6oaZ67EXyrvSWucb
         sWDhoPGRdiNt6Q+XJvutoqEzlECTf6P0ehHD0Ak4VyqjCl/0YUaAFWSA021IZBlEBUUg
         r82CuKDO4kctqrNqVbqOFTYdVY+CddgLIrKbJ1vraccZdPyeOoPdSm9/nMpCQv88T4FL
         8mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jezUd818PVSIqYNtA0ccbF6QkEzuHEy5btO6fArvPPs=;
        b=UOcAIMB/OhNz3J8UI8ZbVOtDHjqk3tsjIopFjwOA55RnSAbtKOIFe8eU4sxOmU2Rn3
         7MTcrVEZQQTluA6+1h/asUEU9IuAYhIgZ/xM/ZbAcbKjdr3pYH/afOpQSrUnXxKUbGAx
         IibzYEIaVa0CCmD2WAA6e+LYM40BQyKwxjF66f9MsVQjucofSqffEflnli119COJTdx6
         SNUryTTcfT7BYo9dG0kd9NIEsnMhgF8ZcRRbuIB+AVz+SXPU4LTBcww+Gkc0LjfJgzrt
         BMRlTPT05ik6rJBSjluxPjDWoS0vFTcpsfNwWaNhiasBUERSekRth4vu7bnlmF1QRIO4
         30qw==
X-Gm-Message-State: APjAAAXtrBQvk6SDCeV6bde0k/GoURDK04ZbfEtRYFvU6XhzfmyxsNMO
        OmnVz5dpDG/cOvASYrLCHysB4E7/2hw=
X-Google-Smtp-Source: APXvYqx9coZlALyzfO6iVzfy3zszXhSMPRNvtVEhoXY1QpczQRWlKN91DMplS8LE25PZWL4IYB6a7K8Z1Tc=
X-Received: by 2002:a63:551a:: with SMTP id j26mr2073418pgb.370.1581125776137;
 Fri, 07 Feb 2020 17:36:16 -0800 (PST)
Date:   Fri,  7 Feb 2020 17:35:52 -0800
In-Reply-To: <20200208013552.241832-1-drosen@google.com>
Message-Id: <20200208013552.241832-9-drosen@google.com>
Mime-Version: 1.0
References: <20200208013552.241832-1-drosen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7 8/8] ext4: Optimize match for casefolded encrypted dirs
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

Matching names with casefolded encrypting directories requires
decrypting entries to confirm case since we are case preserving. We can
avoid needing to decrypt if our hash values don't match.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/ext4/ext4.h  | 17 ++++++++-------
 fs/ext4/namei.c | 55 ++++++++++++++++++++++++++-----------------------
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9ee9cdd686ce0..40cf3171ef005 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2447,9 +2447,9 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
 ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
 #ifdef CONFIG_UNICODE
-extern void ext4_fname_setup_ci_filename(struct inode *dir,
+extern int ext4_fname_setup_ci_filename(struct inode *dir,
 					 const struct qstr *iname,
-					 struct fscrypt_str *fname);
+					 struct ext4_filename *fname);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -2480,9 +2480,9 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 	ext4_fname_from_fscrypt_name(fname, &name);
 
 #ifdef CONFIG_UNICODE
-	ext4_fname_setup_ci_filename(dir, iname, &fname->cf_name);
+	err = ext4_fname_setup_ci_filename(dir, iname, fname);
 #endif
-	return 0;
+	return err;
 }
 
 static inline int ext4_fname_prepare_lookup(struct inode *dir,
@@ -2499,9 +2499,9 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 	ext4_fname_from_fscrypt_name(fname, &name);
 
 #ifdef CONFIG_UNICODE
-	ext4_fname_setup_ci_filename(dir, &dentry->d_name, &fname->cf_name);
+	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
 #endif
-	return 0;
+	return err;
 }
 
 static inline void ext4_fname_free_filename(struct ext4_filename *fname)
@@ -2526,15 +2526,16 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
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
index ae53c6f759740..ac848b22f0ad3 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -791,7 +791,9 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	if (hinfo->hash_version <= DX_HASH_TEA)
 		hinfo->hash_version += EXT4_SB(dir->i_sb)->s_hash_unsigned;
 	hinfo->seed = EXT4_SB(dir->i_sb)->s_hash_seed;
-	if (fname && fname_name(fname))
+	/* hash is already computed for encrypted casefolded directory */
+	if (fname && fname_name(fname) &&
+				!(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)))
 		ext4fs_dirhash(dir, fname_name(fname), fname_len(fname), hinfo);
 	hash = hinfo->hash;
 
@@ -1356,19 +1358,21 @@ int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
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
 
 	if (!needs_casefold(dir)) {
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
@@ -1376,10 +1380,18 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
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
 
@@ -1409,16 +1421,12 @@ static bool ext4_match(struct inode *parent,
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
@@ -2043,15 +2051,11 @@ void ext4_insert_dentry(struct inode *dir,
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
 
@@ -2202,10 +2206,9 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
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
2.25.0.341.g760bfbb309-goog

