Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66033416AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 08:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhCSHer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbhCSHeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:34:22 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74F1C061760
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 00:34:22 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id f65so8721089pfa.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nbnKhdVcsKcWt4bFQ9bWyl6lOm5l04clTzstRcPKGGE=;
        b=UHJV9tgxOpol1BPi4OBljpOrGXaGDE6FMvkKa7inNrbhZ8zoHg2Oi1qQR/B1mOxW2I
         hW8pNOIRn7X8bhWJl42RvsXzBEwXQRsItfoudH6mtmDDklNphfn/HLscjV2hSaJcaI+B
         g8xIsOgERPfH28kAF0KjTMK/+BoMwvDfXGEg6wHG4ahrbHy7CVMJ0pRyJ8WWWk0kShCU
         cBdPRHb3KPv7AsrQvZ9+q7rurJyCB6EvZaSxcOWq/R74QvtlIfCKAcD1yOyt19km5xNS
         imOjLPfoW9dKTqxaFKVjCDvRXblMxUCKnkIIyfvtNuhfW0ticBVULABHQ2+Bb5MRFIk4
         apHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nbnKhdVcsKcWt4bFQ9bWyl6lOm5l04clTzstRcPKGGE=;
        b=PA1D/0vjv3PZkhS9/pQIe7eGL6bivCVRFrL2cpWKSqOMwAqQhC8UlHeCDzl/kJQdI9
         ocXyKht480hwf8k2GrQmbrenTC6w4+FS8vZgFXMZ/LuzgGwsH2jMa2fBlhsTTcqoku2D
         uvs0PKFlNC7nvPvY0VPxJhiPZoBK+ZftiCt9HqSVql5S9uq3xxBmhI6nCzjFb6hvvSMI
         EbKsVTWk6AKtmIxwiCUh89oaSXmLElgWl4RuiejX4/uFXMizFKYR9zyxQuYX6Pk33l+5
         TEgypEZiqYee7J5Deg+33L3lVIMVyfRInP+SLJAADD43PG5Y5cuVKjs39utEg/ACCpP2
         6b8w==
X-Gm-Message-State: AOAM531pr/xAgLgRzPvw8U07h7o0DicM8ORIvlro00B4sO3KSEHIGyN4
        vFuR+Kp+61oRg8c3OMb1e/tOTyg4th0=
X-Google-Smtp-Source: ABdhPJwEpfh6Q6H8LbbI8UyUTjo3GMxpYhBRSG8+8Z6Vb3PBynEyNnxQLPcHVc51hAYZd9r+TL0ei+y7YHY=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a17:903:228c:b029:e6:a755:1cc6 with SMTP id
 b12-20020a170903228cb02900e6a7551cc6mr13289578plh.83.1616139262143; Fri, 19
 Mar 2021 00:34:22 -0700 (PDT)
Date:   Fri, 19 Mar 2021 07:34:14 +0000
In-Reply-To: <20210319073414.1381041-1-drosen@google.com>
Message-Id: <20210319073414.1381041-3-drosen@google.com>
Mime-Version: 1.0
References: <20210319073414.1381041-1-drosen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 2/2] ext4: Optimize match for casefolded encrypted dirs
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
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
index dafa528c4d9f..181d07791efb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2637,9 +2637,9 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
 ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
 #ifdef CONFIG_UNICODE
-extern void ext4_fname_setup_ci_filename(struct inode *dir,
+extern int ext4_fname_setup_ci_filename(struct inode *dir,
 					 const struct qstr *iname,
-					 struct fscrypt_str *fname);
+					 struct ext4_filename *fname);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -2670,9 +2670,9 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 	ext4_fname_from_fscrypt_name(fname, &name);
 
 #ifdef CONFIG_UNICODE
-	ext4_fname_setup_ci_filename(dir, iname, &fname->cf_name);
+	err = ext4_fname_setup_ci_filename(dir, iname, fname);
 #endif
-	return 0;
+	return err;
 }
 
 static inline int ext4_fname_prepare_lookup(struct inode *dir,
@@ -2689,9 +2689,9 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 	ext4_fname_from_fscrypt_name(fname, &name);
 
 #ifdef CONFIG_UNICODE
-	ext4_fname_setup_ci_filename(dir, &dentry->d_name, &fname->cf_name);
+	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
 #endif
-	return 0;
+	return err;
 }
 
 static inline void ext4_fname_free_filename(struct ext4_filename *fname)
@@ -2716,15 +2716,16 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
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
index 97d2755b9775..1fb7128220ce 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -816,7 +816,9 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	if (hinfo->hash_version <= DX_HASH_TEA)
 		hinfo->hash_version += EXT4_SB(dir->i_sb)->s_hash_unsigned;
 	hinfo->seed = EXT4_SB(dir->i_sb)->s_hash_seed;
-	if (fname && fname_name(fname))
+	/* hash is already computed for encrypted casefolded directory */
+	if (fname && fname_name(fname) &&
+				!(IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)))
 		ext4fs_dirhash(dir, fname_name(fname), fname_len(fname), hinfo);
 	hash = hinfo->hash;
 
@@ -1367,19 +1369,21 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
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
 
 	if (!IS_CASEFOLDED(dir) || !dir->i_sb->s_encoding) {
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
@@ -1387,10 +1391,18 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
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
 
@@ -1420,16 +1432,12 @@ static bool ext4_match(struct inode *parent,
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
@@ -2058,15 +2066,11 @@ void ext4_insert_dentry(struct inode *dir,
 	de->name_len = fname_len(fname);
 	memcpy(de->name, fname_name(fname), fname_len(fname));
 	if (ext4_hash_in_dirent(dir)) {
-		struct dx_hash_info hinfo;
+		struct dx_hash_info *hinfo = &fname->hinfo;
 
-		hinfo.hash_version = DX_HASH_SIPHASH;
-		hinfo.seed = NULL;
-		ext4fs_dirhash(dir, fname_usr_name(fname),
-				fname_len(fname), &hinfo);
-		EXT4_DIRENT_HASHES(de)->hash = cpu_to_le32(hinfo.hash);
+		EXT4_DIRENT_HASHES(de)->hash = cpu_to_le32(hinfo->hash);
 		EXT4_DIRENT_HASHES(de)->minor_hash =
-				cpu_to_le32(hinfo.minor_hash);
+						cpu_to_le32(hinfo->minor_hash);
 	}
 }
 
@@ -2216,10 +2220,9 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
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
2.31.0.rc2.261.g7f71774620-goog

