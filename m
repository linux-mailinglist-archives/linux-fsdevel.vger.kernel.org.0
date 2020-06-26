Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076A620AC23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 08:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgFZGKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 02:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFZGKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:10:07 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EDEC08C5C1;
        Thu, 25 Jun 2020 23:10:07 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so3877317plb.11;
        Thu, 25 Jun 2020 23:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GkhNt6JHaeDg/KOivBzaYViQHGtdYS7S+DIM0YJHQM=;
        b=JINu5zP8rOsBatZpzUC9YYEKaRUVdkHhBecXaIx5sLHag9CzFXaxcAeACc8Ul2Zoho
         Wd0zUjz8TP1VPxalHLHf3BaRT6YnUL18iQY3Ijl6TY5yjZJPFdY8caUH9AzZWgSDn+nz
         ocXhY4SqV4WQtpe2cF5ffOhhICteMWUKjqTxu+LcH5vT34PB49/gP5AyEavFk5k+hTsh
         pYgRwRooz2L/IQzQXfLVsZm8yq6m1ovq+eBSqTvJKwW0HOW4Ad3mE+ORJCOKm6OEAf+n
         V7pFSqF7Vgu80H9Y076vUmKOHTcH4iBW20HPdc4+TwUNaFUVBnkOwxxTyR5/U+4skgLT
         nFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GkhNt6JHaeDg/KOivBzaYViQHGtdYS7S+DIM0YJHQM=;
        b=qVNZ4lhg7auZ3JXKSkt+/AtJrPIl07fk0/idBE/9Vo/aVkksTlQFKHfVMmiKHt3d8I
         x1BWBNGX4NrTQwACfMjbz0H6Hhw4zj7S3cUgqsQm+O2p0EZl/5ZpfWI/iVEZkwKJ9KLx
         peGUB6Ncx8Chor5BvbttSkC9Al6Ffuj3vHGWBE5LIOiglkPZKtO3Xq4fR2Hja+Goddfz
         Dz6NjX0Ax73ZjVPnXTL6aRGRHQiFTsLZPv++7WROKIp07FCQx87qHhxW4qOCbHRdH+Qz
         lSqP9/mvIw2p/W9fEJTujIyiKW0bT6liERHh0Z6hRyM/MfWFEa3QjiuMgc5Z8dNdyo8t
         jYxQ==
X-Gm-Message-State: AOAM533SNa5hoKpqoc1oUSm6W9cSLsr2eQbnBDhe1dBUieGVyGNhw54S
        bV58Yx3JbQFiDrQhqR81dwA=
X-Google-Smtp-Source: ABdhPJxPplkerxSavZoPtGoU/OsBxy09QHNZ0xcq1pnmp/zrYb541eigQ4eGxFyMl5+Z8ycB4qtHsA==
X-Received: by 2002:a17:90a:ad87:: with SMTP id s7mr1768955pjq.225.1593151806205;
        Thu, 25 Jun 2020 23:10:06 -0700 (PDT)
Received: from dc803.localdomain (FL1-125-199-162-203.hyg.mesh.ad.jp. [125.199.162.203])
        by smtp.gmail.com with ESMTPSA id w18sm25017230pfq.121.2020.06.25.23.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:10:05 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC]PATCH] exfat: integrates dir-entry getting and validation
Date:   Fri, 26 Jun 2020 15:09:47 +0900
Message-Id: <20200626060947.24709-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add validation for num, bh and type on getting dir-entry.
('file' and 'stream-ext' dir-entries are pre-validated to ensure success)
Renamed exfat_get_dentry_cached() to exfat_get_validated_dentry() due to
a change in functionality.

Integrate type-validation with simplified.
This will also recognize a dir-entry set that contains 'benign secondary'
dir-entries.

And, rename TYPE_EXTEND to TYPE_NAME.

Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c      | 144 ++++++++++++++++++--------------------------
 fs/exfat/exfat_fs.h |  15 +++--
 fs/exfat/file.c     |   4 +-
 fs/exfat/inode.c    |   6 +-
 fs/exfat/namei.c    |   4 +-
 5 files changed, 73 insertions(+), 100 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index f4cea9a7fd02..e029e0986edc 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -33,6 +33,7 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 {
 	int i;
 	struct exfat_entry_set_cache *es;
+	struct exfat_dentry *ep;
 
 	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
 	if (!es)
@@ -44,13 +45,9 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 	 * Third entry  : first file-name entry
 	 * So, the index of first file-name dentry should start from 2.
 	 */
-	for (i = 2; i < es->num_entries; i++) {
-		struct exfat_dentry *ep = exfat_get_dentry_cached(es, i);
-
-		/* end of name entry */
-		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
-			break;
 
+	i = 2;
+	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
 		exfat_extract_uni_name(ep, uniname);
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
@@ -372,7 +369,7 @@ unsigned int exfat_get_entry_type(struct exfat_dentry *ep)
 		if (ep->type == EXFAT_STREAM)
 			return TYPE_STREAM;
 		if (ep->type == EXFAT_NAME)
-			return TYPE_EXTEND;
+			return TYPE_NAME;
 		if (ep->type == EXFAT_ACL)
 			return TYPE_ACL;
 		return TYPE_CRITICAL_SEC;
@@ -388,7 +385,7 @@ static void exfat_set_entry_type(struct exfat_dentry *ep, unsigned int type)
 		ep->type &= EXFAT_DELETE;
 	} else if (type == TYPE_STREAM) {
 		ep->type = EXFAT_STREAM;
-	} else if (type == TYPE_EXTEND) {
+	} else if (type == TYPE_NAME) {
 		ep->type = EXFAT_NAME;
 	} else if (type == TYPE_BITMAP) {
 		ep->type = EXFAT_BITMAP;
@@ -421,7 +418,7 @@ static void exfat_init_name_entry(struct exfat_dentry *ep,
 {
 	int i;
 
-	exfat_set_entry_type(ep, TYPE_EXTEND);
+	exfat_set_entry_type(ep, TYPE_NAME);
 	ep->dentry.name.flags = 0x0;
 
 	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
@@ -594,12 +591,12 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 	struct exfat_dentry *ep;
 
 	for (i = 0; i < es->num_entries; i++) {
-		ep = exfat_get_dentry_cached(es, i);
+		ep = exfat_get_validated_dentry(es, i, TYPE_ALL);
 		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
 					     chksum_type);
 		chksum_type = CS_DEFAULT;
 	}
-	ep = exfat_get_dentry_cached(es, 0);
+	ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
 	ep->dentry.file.checksum = cpu_to_le16(chksum);
 	es->modified = true;
 }
@@ -741,92 +738,66 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 	return (struct exfat_dentry *)((*bh)->b_data + off);
 }
 
-enum exfat_validate_dentry_mode {
-	ES_MODE_STARTED,
-	ES_MODE_GET_FILE_ENTRY,
-	ES_MODE_GET_STRM_ENTRY,
-	ES_MODE_GET_NAME_ENTRY,
-	ES_MODE_GET_CRITICAL_SEC_ENTRY,
-};
-
-static bool exfat_validate_entry(unsigned int type,
-		enum exfat_validate_dentry_mode *mode)
-{
-	if (type == TYPE_UNUSED || type == TYPE_DELETED)
-		return false;
-
-	switch (*mode) {
-	case ES_MODE_STARTED:
-		if  (type != TYPE_FILE && type != TYPE_DIR)
-			return false;
-		*mode = ES_MODE_GET_FILE_ENTRY;
-		return true;
-	case ES_MODE_GET_FILE_ENTRY:
-		if (type != TYPE_STREAM)
-			return false;
-		*mode = ES_MODE_GET_STRM_ENTRY;
-		return true;
-	case ES_MODE_GET_STRM_ENTRY:
-		if (type != TYPE_EXTEND)
-			return false;
-		*mode = ES_MODE_GET_NAME_ENTRY;
-		return true;
-	case ES_MODE_GET_NAME_ENTRY:
-		if (type == TYPE_STREAM)
-			return false;
-		if (type != TYPE_EXTEND) {
-			if (!(type & TYPE_CRITICAL_SEC))
-				return false;
-			*mode = ES_MODE_GET_CRITICAL_SEC_ENTRY;
-		}
-		return true;
-	case ES_MODE_GET_CRITICAL_SEC_ENTRY:
-		if (type == TYPE_EXTEND || type == TYPE_STREAM)
-			return false;
-		if ((type & TYPE_CRITICAL_SEC) != TYPE_CRITICAL_SEC)
-			return false;
-		return true;
-	default:
-		WARN_ON_ONCE(1);
-		return false;
-	}
-}
-
-struct exfat_dentry *exfat_get_dentry_cached(
-	struct exfat_entry_set_cache *es, int num)
+struct exfat_dentry *exfat_get_validated_dentry(struct exfat_entry_set_cache *es,
+						int num, unsigned int type)
 {
 	int off = es->start_off + num * DENTRY_SIZE;
-	struct buffer_head *bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
-	char *p = bh->b_data + EXFAT_BLK_OFFSET(off, es->sb);
+	struct buffer_head *bh;
+	struct exfat_dentry *ep;
 
-	return (struct exfat_dentry *)p;
+	if (num >= es->num_entries)
+		return NULL;
+
+	bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
+	if (!bh)
+		return NULL;
+
+	ep = (struct exfat_dentry *)
+		(bh->b_data + EXFAT_BLK_OFFSET(off, es->sb));
+
+	switch (type) {
+	case TYPE_ALL: /* accept any */
+		break;
+	case TYPE_FILE:
+		if (ep->type != EXFAT_FILE)
+			return NULL;
+		break;
+	case TYPE_SECONDARY:
+		if (!(type & exfat_get_entry_type(ep)))
+			return NULL;
+		break;
+	default:
+		if (type != exfat_get_entry_type(ep))
+			return NULL;
+	}
+	return ep;
 }
 
 /*
  * Returns a set of dentries for a file or dir.
  *
- * Note It provides a direct pointer to bh->data via exfat_get_dentry_cached().
+ * Note It provides a direct pointer to bh->data via exfat_get_validated_dentry().
  * User should call exfat_get_dentry_set() after setting 'modified' to apply
  * changes made in this entry set to the real device.
  *
  * in:
  *   sb+p_dir+entry: indicates a file/dir
- *   type:  specifies how many dentries should be included.
+ *   max_entries:  specifies how many dentries should be included.
  * return:
  *   pointer of entry set on success,
  *   NULL on failure.
+ * note:
+ *   On success, guarantee the correct 'file' and 'stream-ext' dir-entries.
  */
 struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
-		struct exfat_chain *p_dir, int entry, unsigned int type)
+		struct exfat_chain *p_dir, int entry, int max_entries)
 {
 	int ret, i, num_bh;
-	unsigned int off, byte_offset, clu = 0;
+	unsigned int byte_offset, clu = 0;
 	sector_t sec;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_entry_set_cache *es;
 	struct exfat_dentry *ep;
-	int num_entries;
-	enum exfat_validate_dentry_mode mode = ES_MODE_STARTED;
 	struct buffer_head *bh;
 
 	if (p_dir->dir == DIR_DELETED) {
@@ -844,13 +815,13 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		return NULL;
 	es->sb = sb;
 	es->modified = false;
+	es->num_entries = 1;
 
 	/* byte offset in cluster */
 	byte_offset = EXFAT_CLU_OFFSET(byte_offset, sbi);
 
 	/* byte offset in sector */
-	off = EXFAT_BLK_OFFSET(byte_offset, sb);
-	es->start_off = off;
+	es->start_off = EXFAT_BLK_OFFSET(byte_offset, sb);
 
 	/* sector offset in cluster */
 	sec = EXFAT_B_TO_BLK(byte_offset, sb);
@@ -861,15 +832,12 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		goto free_es;
 	es->bh[es->num_bh++] = bh;
 
-	ep = exfat_get_dentry_cached(es, 0);
-	if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
+	ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
+	if (!ep)
 		goto free_es;
+	es->num_entries = min(ep->dentry.file.num_ext + 1, max_entries);
 
-	num_entries = type == ES_ALL_ENTRIES ?
-		ep->dentry.file.num_ext + 1 : type;
-	es->num_entries = num_entries;
-
-	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
+	num_bh = EXFAT_B_TO_BLK_ROUND_UP(es->start_off  + es->num_entries * DENTRY_SIZE, sb);
 	for (i = 1; i < num_bh; i++) {
 		/* get the next sector */
 		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
@@ -889,11 +857,13 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	}
 
 	/* validiate cached dentries */
-	for (i = 1; i < num_entries; i++) {
-		ep = exfat_get_dentry_cached(es, i);
-		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
+	for (i = 1; i < es->num_entries; i++) {
+		if (!exfat_get_validated_dentry(es, i, TYPE_SECONDARY))
 			goto free_es;
 	}
+	if (!exfat_get_validated_dentry(es, 1, TYPE_STREAM))
+		goto free_es;
+
 	return es;
 
 free_es:
@@ -1028,7 +998,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			}
 
 			brelse(bh);
-			if (entry_type == TYPE_EXTEND) {
+			if (entry_type == TYPE_NAME) {
 				unsigned short entry_uniname[16], unichar;
 
 				if (step != DIRENT_STEP_NAME) {
@@ -1144,7 +1114,7 @@ int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
 
 		type = exfat_get_entry_type(ext_ep);
 		brelse(bh);
-		if (type == TYPE_EXTEND || type == TYPE_STREAM)
+		if (type == TYPE_NAME || type == TYPE_STREAM)
 			count++;
 		else
 			break;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 3aed8e22087a..93e11908d28d 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -40,7 +40,7 @@ enum {
  * Type Definitions
  */
 #define ES_2_ENTRIES		2
-#define ES_ALL_ENTRIES		0
+#define ES_ALL_ENTRIES		256
 
 #define DIR_DELETED		0xFFFF0321
 
@@ -56,7 +56,7 @@ enum {
 #define TYPE_FILE		0x011F
 #define TYPE_CRITICAL_SEC	0x0200
 #define TYPE_STREAM		0x0201
-#define TYPE_EXTEND		0x0202
+#define TYPE_NAME		0x0202
 #define TYPE_ACL		0x0203
 #define TYPE_BENIGN_PRI		0x0400
 #define TYPE_GUID		0x0401
@@ -65,6 +65,9 @@ enum {
 #define TYPE_BENIGN_SEC		0x0800
 #define TYPE_ALL		0x0FFF
 
+#define TYPE_PRIMARY		(TYPE_CRITICAL_PRI | TYPE_BENIGN_PRI)
+#define TYPE_SECONDARY		(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)
+
 #define MAX_CHARSET_SIZE	6 /* max size of multi-byte character */
 #define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
 #define MAX_VFSNAME_BUF_SIZE	((MAX_NAME_LENGTH + 1) * MAX_CHARSET_SIZE)
@@ -171,7 +174,7 @@ struct exfat_entry_set_cache {
 	unsigned int start_off;
 	int num_bh;
 	struct buffer_head *bh[DIR_CACHE_SIZE];
-	unsigned int num_entries;
+	int num_entries;
 };
 
 struct exfat_dir_entry {
@@ -456,10 +459,10 @@ int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
 struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 		struct exfat_chain *p_dir, int entry, struct buffer_head **bh,
 		sector_t *sector);
-struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
-		int num);
+struct exfat_dentry *exfat_get_validated_dentry(struct exfat_entry_set_cache *es,
+		int num, unsigned int type);
 struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
-		struct exfat_chain *p_dir, int entry, unsigned int type);
+		struct exfat_chain *p_dir, int entry, int max_entries);
 int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
 
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 6707f3eb09b5..b6b458e6f5e3 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -160,8 +160,8 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 				ES_ALL_ENTRIES);
 		if (!es)
 			return -EIO;
-		ep = exfat_get_dentry_cached(es, 0);
-		ep2 = exfat_get_dentry_cached(es, 1);
+		ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
+		ep2 = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
 
 		ts = current_time(inode);
 		exfat_set_entry_time(sbi, &ts,
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index f0160a7892a8..e7bc1ee1761a 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -45,8 +45,8 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES);
 	if (!es)
 		return -EIO;
-	ep = exfat_get_dentry_cached(es, 0);
-	ep2 = exfat_get_dentry_cached(es, 1);
+	ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
+	ep2 = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
 
 	ep->dentry.file.attr = cpu_to_le16(exfat_make_attr(inode));
 
@@ -228,7 +228,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 			if (!es)
 				return -EIO;
 			/* get stream entry */
-			ep = exfat_get_dentry_cached(es, 1);
+			ep = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
 
 			/* update directory entry */
 			ep->dentry.stream.flags = ei->flags;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 126ed3ba8f47..47fef6b75f28 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -664,8 +664,8 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 		es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
 		if (!es)
 			return -EIO;
-		ep = exfat_get_dentry_cached(es, 0);
-		ep2 = exfat_get_dentry_cached(es, 1);
+		ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
+		ep2 = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
 
 		info->type = exfat_get_entry_type(ep);
 		info->attr = le16_to_cpu(ep->dentry.file.attr);
-- 
2.25.1

