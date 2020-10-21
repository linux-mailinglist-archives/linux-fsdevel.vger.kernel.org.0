Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDB3294ADA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 11:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438336AbgJUJzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 05:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409250AbgJUJzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:55:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004AC0613CE;
        Wed, 21 Oct 2020 02:55:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r10so962521plx.3;
        Wed, 21 Oct 2020 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6k/4J6OvZuIqXhxPKyXGCkgEt7hOkAiREw5nnzbvuk=;
        b=X1FvWPOek5z7xbeDrZWIFiwtwCEcpxtStNMvaQt1meJaOAQWKEGpG2/EuK2eCeijDu
         jMFNpPyfZ+58WnvE1rQNmnw5IDue9riS/jF/nrIfnewW/FV2nec11iKk4tIi9zLqndQE
         4tBEiF4XRzJ1BSCoZz+Zyvd8RYMZM1fmyjXTmgto96mSc3JDL3nvxtNhTw8VrVu4BTOB
         lf0FqaihUP1WT3SA2IWFOOlg9JdGJ9K7yXQCr4BS88VVPoSM6NCx9hTbPoxTvD0fxZ+c
         z60fx96fpyji/2Cr0ugiOmimlzMbD+3Xh8qmX9egg27lmVbHWDLEXUTXfFfLB42CkBRM
         Qy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6k/4J6OvZuIqXhxPKyXGCkgEt7hOkAiREw5nnzbvuk=;
        b=L6WD2/J4L7T8odKEGopNBHPf3wNM3zDTEJ0A5CYAMKo+SwTF/YFFiGFzqN592iTvvL
         tf31MWg00QcJYs8vcDG+JJb4avoPf4f8r0PtWup20fG9Xr00H0/2qIdFDVWjGDdcUGGP
         6erACSD/xgzYefD3rD7Dtp15nf7SGYokVjt05VRIaLzKBDVEQoPZZgXswwoFwk4o11UH
         y+2N+h0R8gw/bIk1V1LoXV33hyrbWiqmv9atDRK5aymefT4CjLWMKTY/Vs6YQH7h5cGN
         P5SjIoiJe/Foy55rkDSaJTjeGz4OHvYVI69YUCqFgrDwdsDsUVzjAUH+9oq2U18oCOoJ
         NSPQ==
X-Gm-Message-State: AOAM532ZufGRypoUBfANJTAKvHkJosLYl01VLptTvJnijuHPDbSBIv+R
        /gyOlNiboswEPI8QuJ2RHA0=
X-Google-Smtp-Source: ABdhPJysOQsQ72FENs7CgBjI2a6iwNNIFoC+cQPn1H9EjmoV3V/3u0xVyghSuVyvujyO527TPEFtjw==
X-Received: by 2002:a17:902:c410:b029:d3:d4ae:87fb with SMTP id k16-20020a170902c410b02900d3d4ae87fbmr2942401plk.81.1603274140557;
        Wed, 21 Oct 2020 02:55:40 -0700 (PDT)
Received: from dc803.localdomain (FL1-133-208-230-116.hyg.mesh.ad.jp. [133.208.230.116])
        by smtp.gmail.com with ESMTPSA id v24sm180813pgi.91.2020.10.21.02.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 02:55:40 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] exfat: commonize getting information from dir-entries
Date:   Wed, 21 Oct 2020 18:55:33 +0900
Message-Id: <20201021095533.9140-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move 'getting dir-entries information' from exfat_find() to
exfat_find_dir_entry(), and make it common in exfat_readdir().
And, remove unused parameter in exfat_find_dir_entry().

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c      | 75 +++++++++++++++++++++++++++++----------------
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/namei.c    | 51 +++---------------------------
 3 files changed, 53 insertions(+), 75 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 916797077aad..ff809239a540 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -58,6 +58,37 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 	exfat_free_dentry_set(es, false);
 }
 
+static void exfat_get_dentry_info(struct exfat_sb_info *sbi, struct exfat_dentry de[2],
+		struct exfat_dir_entry *info)
+{
+	info->attr = le16_to_cpu(de[0].dentry.file.attr);
+	info->type = (info->attr & ATTR_SUBDIR) ? TYPE_DIR : TYPE_FILE;
+
+	exfat_get_entry_time(sbi, &info->crtime,
+			     de[0].dentry.file.create_tz,
+			     de[0].dentry.file.create_time,
+			     de[0].dentry.file.create_date,
+			     de[0].dentry.file.create_time_cs);
+	exfat_get_entry_time(sbi, &info->mtime,
+			     de[0].dentry.file.modify_tz,
+			     de[0].dentry.file.modify_time,
+			     de[0].dentry.file.modify_date,
+			     de[0].dentry.file.modify_time_cs);
+	exfat_get_entry_time(sbi, &info->atime,
+			     de[0].dentry.file.access_tz,
+			     de[0].dentry.file.access_time,
+			     de[0].dentry.file.access_date,
+			     0);
+
+	info->flags = de[1].dentry.stream.flags;
+	info->start_clu = le32_to_cpu(de[1].dentry.stream.start_clu);
+	info->size = le64_to_cpu(de[1].dentry.stream.valid_size);
+	if ((info->type == TYPE_FILE) && (info->size == 0)) {
+		info->flags = ALLOC_NO_FAT_CHAIN;
+		info->start_clu = EXFAT_EOF_CLUSTER;
+	}
+}
+
 /* read a directory entry from the opened directory */
 static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_entry *dir_entry)
 {
@@ -66,7 +97,7 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 	sector_t sector;
 	struct exfat_chain dir, clu;
 	struct exfat_uni_name uni_name;
-	struct exfat_dentry *ep;
+	struct exfat_dentry *ep, de[2];
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
@@ -128,22 +159,7 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 			}
 
 			num_ext = ep->dentry.file.num_ext;
-			dir_entry->attr = le16_to_cpu(ep->dentry.file.attr);
-			exfat_get_entry_time(sbi, &dir_entry->crtime,
-					ep->dentry.file.create_tz,
-					ep->dentry.file.create_time,
-					ep->dentry.file.create_date,
-					ep->dentry.file.create_time_cs);
-			exfat_get_entry_time(sbi, &dir_entry->mtime,
-					ep->dentry.file.modify_tz,
-					ep->dentry.file.modify_time,
-					ep->dentry.file.modify_date,
-					ep->dentry.file.modify_time_cs);
-			exfat_get_entry_time(sbi, &dir_entry->atime,
-					ep->dentry.file.access_tz,
-					ep->dentry.file.access_time,
-					ep->dentry.file.access_date,
-					0);
+			de[0] = *ep;
 
 			*uni_name.name = 0x0;
 			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
@@ -156,10 +172,10 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 			ep = exfat_get_dentry(sb, &clu, i + 1, &bh, NULL);
 			if (!ep)
 				return -EIO;
-			dir_entry->size =
-				le64_to_cpu(ep->dentry.stream.valid_size);
+			de[1] = *ep;
 			dir_entry->entry = dentry;
 			brelse(bh);
+			exfat_get_dentry_info(sbi, de, dir_entry);
 
 			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
 			ei->hint_bmap.clu = clu.dir;
@@ -913,7 +929,7 @@ enum {
  */
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type)
+		int num_entries, struct exfat_dir_entry *info)
 {
 	int i, rewind = 0, dentry = 0, end_eidx = 0, num_ext = 0, len;
 	int order, step, name_len = 0;
@@ -924,6 +940,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 	struct exfat_hint *hint_stat = &ei->hint_stat;
 	struct exfat_hint_femp candi_empty;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_dentry de[2];
 
 	dentries_per_clu = sbi->dentries_per_clu;
 
@@ -989,11 +1006,9 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			candi_empty.eidx = EXFAT_HINT_NONE;
 
 			if (entry_type == TYPE_FILE || entry_type == TYPE_DIR) {
-				step = DIRENT_STEP_FILE;
-				if (type == TYPE_ALL || type == entry_type) {
-					num_ext = ep->dentry.file.num_ext;
-					step = DIRENT_STEP_STRM;
-				}
+				num_ext = ep->dentry.file.num_ext;
+				de[0] = *ep;
+				step = DIRENT_STEP_STRM;
 				brelse(bh);
 				continue;
 			}
@@ -1015,6 +1030,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 					step = DIRENT_STEP_NAME;
 					order = 1;
 					name_len = 0;
+					de[1] = *ep;
 				}
 				brelse(bh);
 				continue;
@@ -1096,6 +1112,11 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 	return -ENOENT;
 
 found:
+	info->dir = *p_dir;
+	info->entry = dentry - num_ext;
+	info->num_subdirs = 0;
+	exfat_get_dentry_info(sbi, de, info);
+
 	/* next dentry we'll find is out of this cluster */
 	if (!((dentry + 1) & (dentries_per_clu - 1))) {
 		int ret = 0;
@@ -1113,13 +1134,13 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			/* just initialized hint_stat */
 			hint_stat->clu = p_dir->dir;
 			hint_stat->eidx = 0;
-			return (dentry - num_ext);
+			return 0;
 		}
 	}
 
 	hint_stat->clu = clu.dir;
 	hint_stat->eidx = dentry + 1;
-	return dentry - num_ext;
+	return 0;
 }
 
 int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index b8f0e829ecbd..f1402fed3302 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -450,7 +450,7 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type);
+		int num_entries, struct exfat_dir_entry *info);
 int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
 int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
 		int entry, sector_t *sector, int *offset);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 2932b23a3b6c..54f54624d7e5 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -588,14 +588,12 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 static int exfat_find(struct inode *dir, struct qstr *qname,
 		struct exfat_dir_entry *info)
 {
-	int ret, dentry, num_entries, count;
+	int ret, num_entries, count;
 	struct exfat_chain cdir;
 	struct exfat_uni_name uni_name;
 	struct super_block *sb = dir->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(dir);
-	struct exfat_dentry *ep, *ep2;
-	struct exfat_entry_set_cache *es;
 
 	if (qname->len == 0)
 		return -ENOENT;
@@ -618,50 +616,9 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	}
 
 	/* search the file name for directories */
-	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name,
-			num_entries, TYPE_ALL);
-
-	if (dentry < 0)
-		return dentry; /* -error value */
-
-	info->dir = cdir;
-	info->entry = dentry;
-	info->num_subdirs = 0;
-
-	es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
-	if (!es)
-		return -EIO;
-	ep = exfat_get_dentry_cached(es, 0);
-	ep2 = exfat_get_dentry_cached(es, 1);
-
-	info->type = exfat_get_entry_type(ep);
-	info->attr = le16_to_cpu(ep->dentry.file.attr);
-	info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
-	if ((info->type == TYPE_FILE) && (info->size == 0)) {
-		info->flags = ALLOC_NO_FAT_CHAIN;
-		info->start_clu = EXFAT_EOF_CLUSTER;
-	} else {
-		info->flags = ep2->dentry.stream.flags;
-		info->start_clu =
-			le32_to_cpu(ep2->dentry.stream.start_clu);
-	}
-
-	exfat_get_entry_time(sbi, &info->crtime,
-			     ep->dentry.file.create_tz,
-			     ep->dentry.file.create_time,
-			     ep->dentry.file.create_date,
-			     ep->dentry.file.create_time_cs);
-	exfat_get_entry_time(sbi, &info->mtime,
-			     ep->dentry.file.modify_tz,
-			     ep->dentry.file.modify_time,
-			     ep->dentry.file.modify_date,
-			     ep->dentry.file.modify_time_cs);
-	exfat_get_entry_time(sbi, &info->atime,
-			     ep->dentry.file.access_tz,
-			     ep->dentry.file.access_time,
-			     ep->dentry.file.access_date,
-			     0);
-	exfat_free_dentry_set(es, false);
+	ret = exfat_find_dir_entry(sb, ei, &cdir, &uni_name, num_entries, info);
+	if (ret)
+		return ret; /* -error value */
 
 	if (ei->start_clu == EXFAT_FREE_CLUSTER) {
 		exfat_fs_error(sb,
-- 
2.25.1

