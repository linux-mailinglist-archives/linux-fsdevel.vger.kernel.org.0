Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673A514C34D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgA1XEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:04:41 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52608 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgA1XEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:04:35 -0500
Received: by mail-pg1-f202.google.com with SMTP id w21so9552863pgf.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 15:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lKtpwaZKWL1neBB1NRO1dY7byN6w+Jp1l7lnT/R4Qwg=;
        b=p3xievYCqztxTXmXD7nJZEAigVvj3Lda/BhlRwqAqO3SHUrWy2KYwJJwqzA8kdttn8
         3TIN0DSCPxI/tQj9BFFSLm5x3SCKosBBV/eNJr/2VeRvzqmfRGnotjqSAyndL+8WFt45
         FkX3jQVFdZ8y4oYU8mXKWI2R4ERFZgPxktIQWSRfSxxvZ3bo7U6lWkYUiJ4lmO3/H7Rb
         0STyMPQ6ZvSaQPRdK8Ao/z1soK7+JoyEfVcC7MSfrhsdalSrG0/9OK1giramiXMhLRQd
         Cu8SkgQXkfjMz2vFSlGeWDNfUmjVaXeoWo8gBcYGVT7wMS7I8+XCGB2JR4jiyvoKg9ZM
         o26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lKtpwaZKWL1neBB1NRO1dY7byN6w+Jp1l7lnT/R4Qwg=;
        b=Go+kqbWRtV3lnulZhPTX082upTSe1b7s/oHCEDaSf+YqtoBopox3ey2blcoU3kT10d
         Xeh63hnQD5DCzhRR/29/ye9p+oeTU110YabXLFAEndD/oDn/3y6VOJNNPSsAY3hR9XPG
         Ii/YDbEdXOikJ4BFYr2M+ar/EP81jJ4Ki9xHPEZj0dQyrFFOFkmOgX1a4UxijxgEfYvw
         GaBnQkTuMoz8Yegf9ftpGkG8rQKyVWscxi/dB0VqzjZOqa8F8gfcMXqtgv0h4X0w7qbA
         yZKyHHUyNQhOs1XZPFcQ6d+EvdUejaiOrfvyaQ8lfLiv/zq1YHJqximsF3dbcbPOGyXL
         Cyug==
X-Gm-Message-State: APjAAAVV7JgXR8lsyAIRTL7ftFEKzstjQKBs4pOmIGN2PSc2VKshsO5x
        Cqz8QGxSPqJDZ74EbF+wVjSoe9S5KIE=
X-Google-Smtp-Source: APXvYqzwNNdtCy4iCwCQ2KSsoF41ni/QDiHqIzFEGbpe3KPgiI9lT4VFk2Fyd9CKHJyFxrWurF7cknATqZE=
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr28473962pgb.315.1580252674948;
 Tue, 28 Jan 2020 15:04:34 -0800 (PST)
Date:   Tue, 28 Jan 2020 15:03:28 -0800
In-Reply-To: <20200128230328.183524-1-drosen@google.com>
Message-Id: <20200128230328.183524-6-drosen@google.com>
Mime-Version: 1.0
References: <20200128230328.183524-1-drosen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 5/5] ext4: Optimize match for casefolded encrypted dirs
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
index 64c7375bc3f65..c69b2bd66b201 100644
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
index 4fc543f459aed..25541d08f648b 100644
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
 
@@ -1352,19 +1354,21 @@ int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
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
@@ -2037,15 +2045,11 @@ void ext4_insert_dentry(struct inode *dir,
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
 
@@ -2196,10 +2200,9 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
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

