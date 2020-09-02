Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF5F25A70D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBHxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 03:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIBHxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:53:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217BBC061244;
        Wed,  2 Sep 2020 00:53:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f18so2387305pfa.10;
        Wed, 02 Sep 2020 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LyVGVFWeGnGW5oXJW/+2ofmfwIGF+YTe8JQqIo5wBKU=;
        b=lPJIJizehy2dCypNCUmL0krf9h4oqtpEYgnmT6xaA3bvSGxADn7U5C+pOdMCfYNiwz
         xL/c7/Xfvs47EBCHtCirMrqdBzUkDWDcJ/gPz9Ng+xAvE0YToIatNVIHyCi6FeEXDCiH
         gU2KyFXaepUfkaFuGsHQbhYm6NVqj5w2xTYevFp7UO/h2E5a3+Hi8642I7hROiehaOJ+
         shapiS03WxupoRp/1/JPfGonzdN6KlD7dOFE9bMYNN43TL1iv9qaawRbH3+wWid2lUeM
         7K+yU1gyuPnFtO0FnEhru8p+FJpaquE+qfhgROYkXowCUwn9CZiD0VAPzHkX5Ziel2O0
         tlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LyVGVFWeGnGW5oXJW/+2ofmfwIGF+YTe8JQqIo5wBKU=;
        b=arHUY1SzXnXzA1ibl+JGSdJ/c8f2BSOpFGQjDR6F6stxGsiXCWwEtYcX8P5r5e9FzV
         7q8JdrMNnoHa5eHTwSdzt9nSMvXzENn0qQirMXAFelEWdLRlYSeejQWDl9ZUat+C57Hs
         buycn4Km66RkUtA/FHyGBsADfZ1W2oD1kXZVko2CHmFSpUb2+O/sKd85SdFyvyBg3wcg
         rc+1pDi5zgifavJjIODC/cCgFkYp290wAYcW77VuSaOLWSs8ZoJ5eO9jsd59Iw1QRlxl
         W73PtQ8mxXz8KwRoq4FvP1iXQvqqOigg6tRc8PFEws64BAwseWpcaOXt4/qalNqfRbtr
         Jv9w==
X-Gm-Message-State: AOAM530prCcss/FJ1IbFw7raTyBrq5jybXemUh9trFcHjF+FP8j5aCbm
        IfuQGoNooHwoXg751XvhTqI=
X-Google-Smtp-Source: ABdhPJzPNahkvNiSzoHbJgJRCZaQf5SeE5mE8X3hFOQB/JO1kHhsSN94D/JIm4GiynMq6Wn0s3LQHQ==
X-Received: by 2002:a63:d409:: with SMTP id a9mr994667pgh.312.1599033195510;
        Wed, 02 Sep 2020 00:53:15 -0700 (PDT)
Received: from dc803.localdomain (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id j2sm4613593pga.12.2020.09.02.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 00:53:15 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: eliminate dead code in exfat_find()
Date:   Wed,  2 Sep 2020 16:53:06 +0900
Message-Id: <20200902075306.8439-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The exfat_find_dir_entry() called by exfat_find() doesn't return -EEXIST.
Therefore, the root-dir information setting is never executed.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c   |   1 -
 fs/exfat/namei.c | 120 +++++++++++++++++++----------------------------
 2 files changed, 47 insertions(+), 74 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 573659bfbc55..a9b13ae3f325 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -911,7 +911,6 @@ enum {
 /*
  * return values:
  *   >= 0	: return dir entiry position with the name in dir
- *   -EEXIST	: (root dir, ".") it is the root dir itself
  *   -ENOENT	: entry with the name does not exist
  *   -EIO	: I/O error
  */
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 0b12033e1577..b966b9120c9c 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -604,6 +604,8 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	struct super_block *sb = dir->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(dir);
+	struct exfat_dentry *ep, *ep2;
+	struct exfat_entry_set_cache *es;
 
 	if (qname->len == 0)
 		return -ENOENT;
@@ -629,91 +631,63 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name,
 			num_entries, TYPE_ALL);
 
-	if ((dentry < 0) && (dentry != -EEXIST))
+	if (dentry < 0)
 		return dentry; /* -error value */
 
 	memcpy(&info->dir, &cdir.dir, sizeof(struct exfat_chain));
 	info->entry = dentry;
 	info->num_subdirs = 0;
 
-	/* root directory itself */
-	if (unlikely(dentry == -EEXIST)) {
-		int num_clu = 0;
+	es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
+	if (!es)
+		return -EIO;
+	ep = exfat_get_dentry_cached(es, 0);
+	ep2 = exfat_get_dentry_cached(es, 1);
+
+	info->type = exfat_get_entry_type(ep);
+	info->attr = le16_to_cpu(ep->dentry.file.attr);
+	info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
+	if ((info->type == TYPE_FILE) && (info->size == 0)) {
+		info->flags = ALLOC_NO_FAT_CHAIN;
+		info->start_clu = EXFAT_EOF_CLUSTER;
+	} else {
+		info->flags = ep2->dentry.stream.flags;
+		info->start_clu =
+			le32_to_cpu(ep2->dentry.stream.start_clu);
+	}
 
-		info->type = TYPE_DIR;
-		info->attr = ATTR_SUBDIR;
-		info->flags = ALLOC_FAT_CHAIN;
-		info->start_clu = sbi->root_dir;
-		memset(&info->crtime, 0, sizeof(info->crtime));
-		memset(&info->mtime, 0, sizeof(info->mtime));
-		memset(&info->atime, 0, sizeof(info->atime));
-
-		exfat_chain_set(&cdir, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
-		if (exfat_count_num_clusters(sb, &cdir, &num_clu))
-			return -EIO;
-		info->size = num_clu << sbi->cluster_size_bits;
+	exfat_get_entry_time(sbi, &info->crtime,
+			     ep->dentry.file.create_tz,
+			     ep->dentry.file.create_time,
+			     ep->dentry.file.create_date,
+			     ep->dentry.file.create_time_cs);
+	exfat_get_entry_time(sbi, &info->mtime,
+			     ep->dentry.file.modify_tz,
+			     ep->dentry.file.modify_time,
+			     ep->dentry.file.modify_date,
+			     ep->dentry.file.modify_time_cs);
+	exfat_get_entry_time(sbi, &info->atime,
+			     ep->dentry.file.access_tz,
+			     ep->dentry.file.access_time,
+			     ep->dentry.file.access_date,
+			     0);
+	exfat_free_dentry_set(es, false);
+
+	if (ei->start_clu == EXFAT_FREE_CLUSTER) {
+		exfat_fs_error(sb,
+			       "non-zero size file starts with zero cluster (size : %llu, p_dir : %u, entry : 0x%08x)",
+			       i_size_read(dir), ei->dir.dir, ei->entry);
+		return -EIO;
+	}
 
+	if (info->type == TYPE_DIR) {
+		exfat_chain_set(&cdir, info->start_clu,
+				EXFAT_B_TO_CLU(info->size, sbi), info->flags);
 		count = exfat_count_dir_entries(sb, &cdir);
 		if (count < 0)
 			return -EIO;
 
-		info->num_subdirs = count;
-	} else {
-		struct exfat_dentry *ep, *ep2;
-		struct exfat_entry_set_cache *es;
-
-		es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
-		if (!es)
-			return -EIO;
-		ep = exfat_get_dentry_cached(es, 0);
-		ep2 = exfat_get_dentry_cached(es, 1);
-
-		info->type = exfat_get_entry_type(ep);
-		info->attr = le16_to_cpu(ep->dentry.file.attr);
-		info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
-		if ((info->type == TYPE_FILE) && (info->size == 0)) {
-			info->flags = ALLOC_NO_FAT_CHAIN;
-			info->start_clu = EXFAT_EOF_CLUSTER;
-		} else {
-			info->flags = ep2->dentry.stream.flags;
-			info->start_clu =
-				le32_to_cpu(ep2->dentry.stream.start_clu);
-		}
-
-		if (ei->start_clu == EXFAT_FREE_CLUSTER) {
-			exfat_fs_error(sb,
-				"non-zero size file starts with zero cluster (size : %llu, p_dir : %u, entry : 0x%08x)",
-				i_size_read(dir), ei->dir.dir, ei->entry);
-			exfat_free_dentry_set(es, false);
-			return -EIO;
-		}
-
-		exfat_get_entry_time(sbi, &info->crtime,
-				ep->dentry.file.create_tz,
-				ep->dentry.file.create_time,
-				ep->dentry.file.create_date,
-				ep->dentry.file.create_time_cs);
-		exfat_get_entry_time(sbi, &info->mtime,
-				ep->dentry.file.modify_tz,
-				ep->dentry.file.modify_time,
-				ep->dentry.file.modify_date,
-				ep->dentry.file.modify_time_cs);
-		exfat_get_entry_time(sbi, &info->atime,
-				ep->dentry.file.access_tz,
-				ep->dentry.file.access_time,
-				ep->dentry.file.access_date,
-				0);
-		exfat_free_dentry_set(es, false);
-
-		if (info->type == TYPE_DIR) {
-			exfat_chain_set(&cdir, info->start_clu,
-				EXFAT_B_TO_CLU(info->size, sbi), info->flags);
-			count = exfat_count_dir_entries(sb, &cdir);
-			if (count < 0)
-				return -EIO;
-
-			info->num_subdirs = count + EXFAT_MIN_SUBDIR;
-		}
+		info->num_subdirs = count + EXFAT_MIN_SUBDIR;
 	}
 	return 0;
 }
-- 
2.25.1

