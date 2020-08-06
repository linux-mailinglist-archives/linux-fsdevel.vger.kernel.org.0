Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0944323D6A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 07:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgHFF50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 01:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHFF5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:57:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20642C061574;
        Wed,  5 Aug 2020 22:57:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so2206703pjb.2;
        Wed, 05 Aug 2020 22:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JOPXdb+4K11YEWrmqvFK1kn/p1WKkVdQUjEhCffmpnE=;
        b=sWJV7wIcoGbFRd2TM9lDycfqByaYU7XZiWpKeXwTSZGyyjK5bSUAYkLranxYEd/63J
         9C6bBTKOCwXT20jN5jR30cZjX+Cufs1HTMP3CVb5Yx0UZaHl7yuFbggylct/onK0uHs+
         hmJ4pPM3FgP2BRRivCII56X8RKvt1Ajilk/Z060BOZguv6IiBfmZXQOflnsyOhfvv7e0
         bghFPrG2tjuDeNUp2h6S/z7BWvjiCm3MMf3yi069JHY0IMx6EUs3praRcr1eY6qLhI/h
         ZPDemmqjPAVdw8UfVAwoa4y/oJ2OLhjC+HUVe/iyPKTVqLBA/s4zgxmTNvoBI90R9FnW
         VELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOPXdb+4K11YEWrmqvFK1kn/p1WKkVdQUjEhCffmpnE=;
        b=OammKpxLRu+MwBroBbyuphZz93Kzz4qgDqYyFPh2rnhuTrzmhbdbaMdRa8EU6BYPcD
         Uc1Bh0j60I+qHqPb1Cow4R0ccGDMe0877SUd2F/1ziTyK6eS6t/U1MmVYMaX0+T2cn9a
         80huD45iYnw979k13ucQqO4UxiY8ol8Y0CRS3E7VsOyFNnu03eDD6iDvX4cLr6jqRw02
         7JuOwgfothwY/rhjhpDr4FTbAu+OVCZuTWzPHKgNNP/Pzn6O5E7430Hn4PNg7iKNSgIp
         ApNrT5y4eH1QAOGN1dUchj/dhjTTfOHpmqFIwYX7hycd3Xzt47l+Ye+JuiUxq8RZC+Ph
         8DJg==
X-Gm-Message-State: AOAM531a4b3/t2YmWOYjOuWOpz3HA9HTrK6JhZ/7uq7CEhHNFLmlT9pr
        yFv6+4yk9wuElTgy0K7qhI+b7YUM
X-Google-Smtp-Source: ABdhPJydO6tSa0uWZkyK/rlqfPKwxBascM4aIXs2BDhjjuK9+UB19yH0kGqAC0Do5vW0hHfmUFPK6g==
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr6301946plo.153.1596693443600;
        Wed, 05 Aug 2020 22:57:23 -0700 (PDT)
Received: from dc803.localdomain (FL1-218-42-16-224.hyg.mesh.ad.jp. [218.42.16.224])
        by smtp.gmail.com with ESMTPSA id g129sm6056784pfb.33.2020.08.05.22.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 22:57:23 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] exfat: unify name extraction
Date:   Thu,  6 Aug 2020 14:56:53 +0900
Message-Id: <20200806055653.9329-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806055653.9329-1-kohada.t2@gmail.com>
References: <20200806055653.9329-1-kohada.t2@gmail.com>
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

** This patch depends on:
  '[PATCH v3] exfat: integrates dir-entry getting and validation'.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c      | 161 ++++++++++----------------------------------
 fs/exfat/exfat_fs.h |   2 +-
 fs/exfat/namei.c    |   4 +-
 3 files changed, 38 insertions(+), 129 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 545bb73b95e9..c9715c7a55a1 100644
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
@@ -869,13 +851,6 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
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
@@ -885,13 +860,12 @@ enum {
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
@@ -909,27 +883,33 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 
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
@@ -954,7 +934,6 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 					}
 				}
 
-				brelse(bh);
 				if (entry_type == TYPE_UNUSED)
 					goto not_found;
 				continue;
@@ -963,80 +942,38 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
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
-
-			if (entry_type == TYPE_STREAM) {
-				u16 name_hash;
 
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
+			es = exfat_get_dentry_set(sb, &ei->dir, dentry, ES_2_ENTRIES);
+			if (!es)
 				continue;
-			}
 
-			brelse(bh);
-			if (entry_type == TYPE_NAME) {
-				unsigned short entry_uniname[16], unichar;
-
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
+			num_ext = es->de_file->num_ext;
+			name_hash = le16_to_cpu(es->de_stream->name_hash);
+			name_len = es->de_stream->name_len;
+			exfat_free_dentry_set(es, false);
 
-				if (exfat_uniname_ncmp(sb, uniname,
-					entry_uniname, len)) {
-					step = DIRENT_STEP_FILE;
-				} else if (p_uniname->name_len == name_len) {
-					if (order == num_ext)
-						goto found;
-					step = DIRENT_STEP_SECD;
-				}
+			if (p_uniname->name_hash != name_hash ||
+			    p_uniname->name_len != name_len)
+				continue;
 
-				*(uniname+len) = unichar;
+			es = exfat_get_dentry_set(sb, &ei->dir, dentry, ES_ALL_ENTRIES);
+			if (!es)
 				continue;
-			}
 
-			if (entry_type &
-					(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)) {
-				if (step == DIRENT_STEP_SECD) {
-					if (++order == num_ext)
-						goto found;
-					continue;
-				}
+			exfat_get_uniname_from_name_entries(es, &uni_name);
+			exfat_free_dentry_set(es, false);
+
+			if (!exfat_uniname_ncmp(sb,
+						p_uniname->name,
+						uni_name.name,
+						name_len)) {
+				/* set the last used position as hint */
+				hint_stat->clu = clu.dir;
+				hint_stat->eidx = dentry;
+				return dentry;
 			}
-			step = DIRENT_STEP_FILE;
 		}
 
 		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
@@ -1069,32 +1006,6 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
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
index b88b7abc25bd..62a4768a4f6e 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -456,7 +456,7 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type);
+		int num_entries);
 int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
 int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
 		int entry, sector_t *sector, int *offset);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index a65d60ef93f4..c59d523547ca 100644
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

