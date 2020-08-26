Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EAF252D29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgHZL6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 07:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgHZL6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:58:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02F0C061574;
        Wed, 26 Aug 2020 04:58:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i13so781286pjv.0;
        Wed, 26 Aug 2020 04:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nG1I6ysepStFkKWusfeLNaZsIB8olAVLLnRxLQYwzhk=;
        b=cENh3QzgekiyePs0qsZ7NwENiNaVoB3bK1qnc8nWYR45fYg6kEZXOuEbhaUInh+FT8
         p3M5vbmMqRADy1syTWhJLx/tbrE/bpsEI2UoHkbfZYOgzqjdtO+r+XNdEsNf4wdpBP5p
         jYKasXPzU0H50cP+nfq+jc0e8Chx8fuRWnX32XsPlx0RfSB4CJnyRSr5A5aP7YCi8i3b
         RA4ENpix0MoRWJrbjc+uKJ/TsQHFn7DxwQHlTsPWizmzkKuH9ub/jDiwxeX2sh8amcG0
         IP558abMKtiSA7mYY6dKx/lvki+MCp86My3TGMjYdRnHlzx66aLvOHxFRbZ0K3D6px5x
         WYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nG1I6ysepStFkKWusfeLNaZsIB8olAVLLnRxLQYwzhk=;
        b=PmftjZluBLJMNUplvhm6NzBmELFNIGPomy6BpGmsGO9DsaelzawomRxUEF8EWU19+7
         Ty++i1rD7Tn77m7UcScnFl03sdL6KjNLw+x6THhvYTTwZCi5llJWG2Mny4dp9R70iy74
         Bs646mwqYM6hCsm87GYrJnqWjBcUs26TFv/T/S+b8MKaUqZqgCzhsToScdFz3iVzeaDR
         rQEotzA5UF19ueL4H7he/rCmqBLMdGsjUF752GKmFWcuXoDbjy7brhNbR8ZDymm5sXJM
         0hSeAILFBic8GcyYpXUInQpZKGIdAuIsdhxJOOewvytzmWd+S6zXmWn8dI4Q5Dp2t1s+
         TTDg==
X-Gm-Message-State: AOAM5321PpYB+pIJTKacDLuMvYW4K9BpKDnRsEfBWG/icVdU2yQZ6JH6
        dzzLXoDFOwSxb77o1br73GA=
X-Google-Smtp-Source: ABdhPJy5kqutUpfO+g+VJvvPJlX60QSusLdxezXXXjeQcX/yTrUM5xVlV90uASopwnZNNRTS71qrYg==
X-Received: by 2002:a17:90a:df0d:: with SMTP id gp13mr5529564pjb.76.1598443097393;
        Wed, 26 Aug 2020 04:58:17 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id v1sm1957904pjh.16.2020.08.26.04.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 04:58:17 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] exfat: unify name extraction
Date:   Wed, 26 Aug 2020 20:57:39 +0900
Message-Id: <20200826115742.21207-3-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826115742.21207-1-kohada.t2@gmail.com>
References: <20200826115742.21207-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Name extraction in exfat_find_dir_entry() also doesn't care NameLength,
so the name may be incorrect.
Replace the name extraction in exfat_find_dir_entry() with using
exfat_entry_set_cache and exfat_get_uniname_from_name_entries(),
like exfat_readdir().
Replace the name extraction with using exfat_entry_set_cache and
exfat_get_uniname_from_name_entries(), like exfat_readdir().
And, remove unused functions/parameters.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - Add error check when extracting name
 - Remove temporary exfat_get_dentry_set() with ES_2_ENTRIES
 - Remove duplicate parts in commit message
Changes in v3:
 - Nothing
Changes in v4:
 - Into patch series '[PATCH v4] exfat: integrates dir-entry getting and validation'

 fs/exfat/dir.c      | 156 +++++++++-----------------------------------
 fs/exfat/exfat_fs.h |   2 +-
 fs/exfat/namei.c    |   4 +-
 3 files changed, 32 insertions(+), 130 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 99d9e6d119d6..cd37091844fa 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -10,24 +10,6 @@
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 
-static int exfat_extract_uni_name(struct exfat_dentry *ep,
-		unsigned short *uniname)
-{
-	int i, len = 0;
-
-	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
-		*uniname = le16_to_cpu(ep->dentry.name.unicode_0_14[i]);
-		if (*uniname == 0x0)
-			return len;
-		uniname++;
-		len++;
-	}
-
-	*uniname = 0x0;
-	return len;
-
-}
-
 static int exfat_get_uniname_from_name_entries(struct exfat_entry_set_cache *es,
 		struct exfat_uni_name *uniname)
 {
@@ -871,13 +853,6 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	return NULL;
 }
 
-enum {
-	DIRENT_STEP_FILE,
-	DIRENT_STEP_STRM,
-	DIRENT_STEP_NAME,
-	DIRENT_STEP_SECD,
-};
-
 /*
  * return values:
  *   >= 0	: return dir entiry position with the name in dir
@@ -887,13 +862,12 @@ enum {
  */
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type)
+		int num_entries)
 {
-	int i, rewind = 0, dentry = 0, end_eidx = 0, num_ext = 0, len;
-	int order, step, name_len = 0;
+	int i, rewind = 0, dentry = 0, end_eidx = 0, num_ext = 0;
+	int name_len = 0;
 	int dentries_per_clu, num_empty = 0;
 	unsigned int entry_type;
-	unsigned short *uniname = NULL;
 	struct exfat_chain clu;
 	struct exfat_hint *hint_stat = &ei->hint_stat;
 	struct exfat_hint_femp candi_empty;
@@ -911,27 +885,34 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 
 	candi_empty.eidx = EXFAT_HINT_NONE;
 rewind:
-	order = 0;
-	step = DIRENT_STEP_FILE;
 	while (clu.dir != EXFAT_EOF_CLUSTER) {
 		i = dentry & (dentries_per_clu - 1);
 		for (; i < dentries_per_clu; i++, dentry++) {
 			struct exfat_dentry *ep;
 			struct buffer_head *bh;
+			struct exfat_entry_set_cache *es;
+			struct exfat_uni_name uni_name;
+			u16 name_hash;
+			bool found;
 
 			if (rewind && dentry == end_eidx)
 				goto not_found;
 
+			/* skip secondary dir-entries in previous dir-entry set */
+			if (num_ext) {
+				num_ext--;
+				continue;
+			}
+
 			ep = exfat_get_dentry(sb, &clu, i, &bh, NULL);
 			if (!ep)
 				return -EIO;
 
 			entry_type = exfat_get_entry_type(ep);
+			brelse(bh);
 
 			if (entry_type == TYPE_UNUSED ||
 			    entry_type == TYPE_DELETED) {
-				step = DIRENT_STEP_FILE;
-
 				num_empty++;
 				if (candi_empty.eidx == EXFAT_HINT_NONE &&
 						num_empty == 1) {
@@ -956,7 +937,6 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 					}
 				}
 
-				brelse(bh);
 				if (entry_type == TYPE_UNUSED)
 					goto not_found;
 				continue;
@@ -965,80 +945,30 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			num_empty = 0;
 			candi_empty.eidx = EXFAT_HINT_NONE;
 
-			if (entry_type == TYPE_FILE || entry_type == TYPE_DIR) {
-				step = DIRENT_STEP_FILE;
-				if (type == TYPE_ALL || type == entry_type) {
-					num_ext = ep->dentry.file.num_ext;
-					step = DIRENT_STEP_STRM;
-				}
-				brelse(bh);
+			if (entry_type != TYPE_FILE && entry_type != TYPE_DIR)
 				continue;
-			}
 
-			if (entry_type == TYPE_STREAM) {
-				u16 name_hash;
-
-				if (step != DIRENT_STEP_STRM) {
-					step = DIRENT_STEP_FILE;
-					brelse(bh);
-					continue;
-				}
-				step = DIRENT_STEP_FILE;
-				name_hash = le16_to_cpu(
-						ep->dentry.stream.name_hash);
-				if (p_uniname->name_hash == name_hash &&
-				    p_uniname->name_len ==
-						ep->dentry.stream.name_len) {
-					step = DIRENT_STEP_NAME;
-					order = 1;
-					name_len = 0;
-				}
-				brelse(bh);
+			es = exfat_get_dentry_set(sb, &ei->dir, dentry, ES_ALL_ENTRIES);
+			if (!es)
 				continue;
-			}
 
-			brelse(bh);
-			if (entry_type == TYPE_NAME) {
-				unsigned short entry_uniname[16], unichar;
+			num_ext = ES_FILE(es).num_ext;
+			name_hash = le16_to_cpu(ES_STREAM(es).name_hash);
+			name_len = ES_STREAM(es).name_len;
 
-				if (step != DIRENT_STEP_NAME) {
-					step = DIRENT_STEP_FILE;
-					continue;
-				}
-
-				if (++order == 2)
-					uniname = p_uniname->name;
-				else
-					uniname += EXFAT_FILE_NAME_LEN;
-
-				len = exfat_extract_uni_name(ep, entry_uniname);
-				name_len += len;
-
-				unichar = *(uniname+len);
-				*(uniname+len) = 0x0;
-
-				if (exfat_uniname_ncmp(sb, uniname,
-					entry_uniname, len)) {
-					step = DIRENT_STEP_FILE;
-				} else if (p_uniname->name_len == name_len) {
-					if (order == num_ext)
-						goto found;
-					step = DIRENT_STEP_SECD;
-				}
+			found = p_uniname->name_hash == name_hash &&
+				p_uniname->name_len == name_len &&
+				!exfat_get_uniname_from_name_entries(es, &uni_name) &&
+				!exfat_uniname_ncmp(sb, p_uniname->name, uni_name.name, name_len);
 
-				*(uniname+len) = unichar;
-				continue;
-			}
+			exfat_free_dentry_set(es, false);
 
-			if (entry_type &
-					(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)) {
-				if (step == DIRENT_STEP_SECD) {
-					if (++order == num_ext)
-						goto found;
-					continue;
-				}
+			if (found) {
+				/* set the last used position as hint */
+				hint_stat->clu = clu.dir;
+				hint_stat->eidx = dentry;
+				return dentry;
 			}
-			step = DIRENT_STEP_FILE;
 		}
 
 		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
@@ -1071,32 +1001,6 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 	hint_stat->clu = p_dir->dir;
 	hint_stat->eidx = 0;
 	return -ENOENT;
-
-found:
-	/* next dentry we'll find is out of this cluster */
-	if (!((dentry + 1) & (dentries_per_clu - 1))) {
-		int ret = 0;
-
-		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-			if (--clu.size > 0)
-				clu.dir++;
-			else
-				clu.dir = EXFAT_EOF_CLUSTER;
-		} else {
-			ret = exfat_get_next_cluster(sb, &clu.dir);
-		}
-
-		if (ret || clu.dir == EXFAT_EOF_CLUSTER) {
-			/* just initialized hint_stat */
-			hint_stat->clu = p_dir->dir;
-			hint_stat->eidx = 0;
-			return (dentry - num_ext);
-		}
-	}
-
-	hint_stat->clu = clu.dir;
-	hint_stat->eidx = dentry + 1;
-	return dentry - num_ext;
 }
 
 int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index e46f3e0c16b7..7057e64b405d 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -458,7 +458,7 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type);
+		int num_entries);
 int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
 int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
 		int entry, sector_t *sector, int *offset);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 6a034f504d83..d2b9044d0b31 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -625,9 +625,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	}
 
 	/* search the file name for directories */
-	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name,
-			num_entries, TYPE_ALL);
-
+	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name, num_entries);
 	if ((dentry < 0) && (dentry != -EEXIST))
 		return dentry; /* -error value */
 
-- 
2.25.1

