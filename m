Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5716C23D4EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 03:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHFBCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 21:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHFBCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 21:02:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5CAC061574;
        Wed,  5 Aug 2020 18:02:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so5608212pjx.5;
        Wed, 05 Aug 2020 18:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXI2Cfg2OOvbPMbVbcs5r+BVhLUB8nxOX4a5E/f1xXo=;
        b=QMKrELLtQH+fhIQ90tnkRkKM6jffybu//m7bx7u6/2AtjlF9a1tzs3/uTXezik99Tm
         RHeopm32BNmTJW17v7TdT8jiZ0W8DDRD+VVdXoivKLD0oOxgoBLM6K5jSq94+Ku58mHB
         +i5WCjDyLzQ8se+3RdLVjCB8r/cZ2V8WaTpb/3DI/iB5Kx/Eq7YnGmNNU6cljkcllZUV
         BcDFyfmIOukCDxr4JXeoynhoxrrGR8uhaAp4Y+qLWdQ1QTEQcDliD0eJL83wDe7w+JW1
         KZ1ktJvuQu02FrrYWFJvlBBqbnhzV/QBX0V9NhrQi2k84pv1beA9urZmObj7omIAxjOe
         qfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXI2Cfg2OOvbPMbVbcs5r+BVhLUB8nxOX4a5E/f1xXo=;
        b=Z7Zarvr1LjJfGkDcv3quVEcxTvUjzd/a2mnUoqxd4tewbDCc0KB39ZJ3pyafTDUk1R
         zb44GqcBjy6P9boF3/vO67OelNE9+EW6HoPN0eejHZQcs5ANHv5MPY3880TWbTYYQCKg
         P7zukgFIh/MNtjt4QXVLYM2mCWyVbuH+pkqSgesAGxK2XknQPXTAYuqDdpAMY+2i2LAV
         ekpV+klXQVdVjEK6MGvGdhhlsEdnUUVCjemXWvtoGOgidb20P7FT6wjzqQ82LGYCyOBZ
         rOiFtAR8ERXL24F3AGvBPGaZUkDWOYuQML06HyMhCI/IRrwb5Mj/XfGy93idmCi00G/q
         11ig==
X-Gm-Message-State: AOAM531J//9oW1zj7w0+Jn1q5KDg7TAyn0qUVMZL8j6JkOgl0JTTSWSk
        hBc5Fqegd3BMl1hbal79/hI=
X-Google-Smtp-Source: ABdhPJyv3zvRyZQK+CynaeCEkjYoIZkGH9xCZUem5o4s7WXm2bzUB5pT3fxqkqecPxSgiIv/iuy25Q==
X-Received: by 2002:a17:90a:94c4:: with SMTP id j4mr5830250pjw.155.1596675766386;
        Wed, 05 Aug 2020 18:02:46 -0700 (PDT)
Received: from dc803.localdomain (FL1-218-42-16-224.hyg.mesh.ad.jp. [218.42.16.224])
        by smtp.gmail.com with ESMTPSA id z5sm4633134pfk.15.2020.08.05.18.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 18:02:45 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] exfat: integrates dir-entry getting and validation
Date:   Thu,  6 Aug 2020 10:02:29 +0900
Message-Id: <20200806010229.24690-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add validation for num, bh and type on getting dir-entry.
Renamed exfat_get_dentry_cached() to exfat_get_validated_dentry() due to
a change in functionality.

Integrate type-validation with simplified.
This will also recognize a dir-entry set that contains 'benign secondary'
dir-entries.

Pre-Validated 'file' and 'stream-ext' dir-entries are provided as member
variables of exfat_entry_set_cache.

And, rename TYPE_EXTEND to TYPE_NAME.

Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
Suggested-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - Change verification order
 - Verification loop start with index 2
Changes in v3
 - Fix indent 
 - Fix comment of exfat_get_dentry_set()
 - Add de_file/de_stream in exfat_entry_set_cache
 - Add srtuct tag name for each dir-entry type in exfat_dentry
 - Add description about de_file/de_stream to commit-log

 fs/exfat/dir.c       | 147 +++++++++++++++++--------------------------
 fs/exfat/exfat_fs.h  |  17 +++--
 fs/exfat/exfat_raw.h |  10 +--
 fs/exfat/file.c      |  25 ++++----
 fs/exfat/inode.c     |  49 ++++++---------
 fs/exfat/namei.c     |  36 +++++------
 6 files changed, 122 insertions(+), 162 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 573659bfbc55..91cdbede0fd1 100644
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
@@ -594,13 +591,12 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 	struct exfat_dentry *ep;
 
 	for (i = 0; i < es->num_entries; i++) {
-		ep = exfat_get_dentry_cached(es, i);
+		ep = exfat_get_validated_dentry(es, i, TYPE_ALL);
 		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
 					     chksum_type);
 		chksum_type = CS_DEFAULT;
 	}
-	ep = exfat_get_dentry_cached(es, 0);
-	ep->dentry.file.checksum = cpu_to_le16(chksum);
+	es->de_file->checksum = cpu_to_le16(chksum);
 	es->modified = true;
 }
 
@@ -741,92 +737,64 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
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
+		int num, unsigned int type)
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
@@ -844,13 +812,13 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
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
@@ -861,15 +829,13 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		goto free_es;
 	es->bh[es->num_bh++] = bh;
 
-	ep = exfat_get_dentry_cached(es, 0);
-	if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
+	ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
+	if (!ep)
 		goto free_es;
+	es->de_file = &ep->dentry.file;
+	es->num_entries = min(es->de_file->num_ext + 1, max_entries);
 
-	num_entries = type == ES_ALL_ENTRIES ?
-		ep->dentry.file.num_ext + 1 : type;
-	es->num_entries = num_entries;
-
-	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
+	num_bh = EXFAT_B_TO_BLK_ROUND_UP(es->start_off  + es->num_entries * DENTRY_SIZE, sb);
 	for (i = 1; i < num_bh; i++) {
 		/* get the next sector */
 		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
@@ -889,11 +855,16 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	}
 
 	/* validiate cached dentries */
-	for (i = 1; i < num_entries; i++) {
-		ep = exfat_get_dentry_cached(es, i);
-		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
+	ep = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
+	if (!ep)
+		goto free_es;
+	es->de_stream = &ep->dentry.stream;
+
+	for (i = 2; i < es->num_entries; i++) {
+		if (!exfat_get_validated_dentry(es, i, TYPE_SECONDARY))
 			goto free_es;
 	}
+
 	return es;
 
 free_es:
@@ -1028,7 +999,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			}
 
 			brelse(bh);
-			if (entry_type == TYPE_EXTEND) {
+			if (entry_type == TYPE_NAME) {
 				unsigned short entry_uniname[16], unichar;
 
 				if (step != DIRENT_STEP_NAME) {
@@ -1144,7 +1115,7 @@ int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
 
 		type = exfat_get_entry_type(ext_ep);
 		brelse(bh);
-		if (type == TYPE_EXTEND || type == TYPE_STREAM)
+		if (type == TYPE_NAME || type == TYPE_STREAM)
 			count++;
 		else
 			break;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 95d717f8620c..b88b7abc25bd 100644
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
@@ -171,7 +174,9 @@ struct exfat_entry_set_cache {
 	unsigned int start_off;
 	int num_bh;
 	struct buffer_head *bh[DIR_CACHE_SIZE];
-	unsigned int num_entries;
+	int num_entries;
+	struct exfat_de_file *de_file;
+	struct exfat_de_stream *de_stream;
 };
 
 struct exfat_dir_entry {
@@ -458,10 +463,10 @@ int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
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
 
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 6aec6288e1f2..b2ece0bf4ecd 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -105,7 +105,7 @@ struct boot_sector {
 struct exfat_dentry {
 	__u8 type;
 	union {
-		struct {
+		struct exfat_de_file {
 			__u8 num_ext;
 			__le16 checksum;
 			__le16 attr;
@@ -123,7 +123,7 @@ struct exfat_dentry {
 			__u8 access_tz;
 			__u8 reserved2[7];
 		} __packed file; /* file directory entry */
-		struct {
+		struct exfat_de_stream {
 			__u8 flags;
 			__u8 reserved1;
 			__u8 name_len;
@@ -134,17 +134,17 @@ struct exfat_dentry {
 			__le32 start_clu;
 			__le64 size;
 		} __packed stream; /* stream extension directory entry */
-		struct {
+		struct exfat_de_name {
 			__u8 flags;
 			__le16 unicode_0_14[EXFAT_FILE_NAME_LEN];
 		} __packed name; /* file name directory entry */
-		struct {
+		struct exfat_de_bitmap {
 			__u8 flags;
 			__u8 reserved[18];
 			__le32 start_clu;
 			__le64 size;
 		} __packed bitmap; /* allocation bitmap directory entry */
-		struct {
+		struct exfat_de_upcase {
 			__u8 reserved1[3];
 			__le32 checksum;
 			__u8 reserved2[12];
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f41f523a58ad..04f6cc79ed43 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -152,7 +152,6 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 	/* update the directory entry */
 	if (!evict) {
 		struct timespec64 ts;
-		struct exfat_dentry *ep, *ep2;
 		struct exfat_entry_set_cache *es;
 		int err;
 
@@ -160,32 +159,30 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 				ES_ALL_ENTRIES);
 		if (!es)
 			return -EIO;
-		ep = exfat_get_dentry_cached(es, 0);
-		ep2 = exfat_get_dentry_cached(es, 1);
 
 		ts = current_time(inode);
 		exfat_set_entry_time(sbi, &ts,
-				&ep->dentry.file.modify_tz,
-				&ep->dentry.file.modify_time,
-				&ep->dentry.file.modify_date,
-				&ep->dentry.file.modify_time_cs);
-		ep->dentry.file.attr = cpu_to_le16(ei->attr);
+				&es->de_file->modify_tz,
+				&es->de_file->modify_time,
+				&es->de_file->modify_date,
+				&es->de_file->modify_time_cs);
+		es->de_file->attr = cpu_to_le16(ei->attr);
 
 		/* File size should be zero if there is no cluster allocated */
 		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
-			ep2->dentry.stream.valid_size = 0;
-			ep2->dentry.stream.size = 0;
+			es->de_stream->valid_size = 0;
+			es->de_stream->size = 0;
 		} else {
-			ep2->dentry.stream.valid_size = cpu_to_le64(new_size);
-			ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
+			es->de_stream->valid_size = cpu_to_le64(new_size);
+			es->de_stream->size = es->de_stream->valid_size;
 		}
 
 		if (new_size == 0) {
 			/* Any directory can not be truncated to zero */
 			WARN_ON(ei->type != TYPE_FILE);
 
-			ep2->dentry.stream.flags = ALLOC_FAT_CHAIN;
-			ep2->dentry.stream.start_clu = EXFAT_FREE_CLUSTER;
+			es->de_stream->flags = ALLOC_FAT_CHAIN;
+			es->de_stream->start_clu = EXFAT_FREE_CLUSTER;
 		}
 
 		exfat_update_dir_chksum_with_entry_set(es);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 7f90204adef5..358457c82270 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -20,7 +20,6 @@
 static int __exfat_write_inode(struct inode *inode, int sync)
 {
 	unsigned long long on_disk_size;
-	struct exfat_dentry *ep, *ep2;
 	struct exfat_entry_set_cache *es = NULL;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -45,26 +44,24 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES);
 	if (!es)
 		return -EIO;
-	ep = exfat_get_dentry_cached(es, 0);
-	ep2 = exfat_get_dentry_cached(es, 1);
 
-	ep->dentry.file.attr = cpu_to_le16(exfat_make_attr(inode));
+	es->de_file->attr = cpu_to_le16(exfat_make_attr(inode));
 
 	/* set FILE_INFO structure using the acquired struct exfat_dentry */
 	exfat_set_entry_time(sbi, &ei->i_crtime,
-			&ep->dentry.file.create_tz,
-			&ep->dentry.file.create_time,
-			&ep->dentry.file.create_date,
-			&ep->dentry.file.create_time_cs);
+			&es->de_file->create_tz,
+			&es->de_file->create_time,
+			&es->de_file->create_date,
+			&es->de_file->create_time_cs);
 	exfat_set_entry_time(sbi, &inode->i_mtime,
-			&ep->dentry.file.modify_tz,
-			&ep->dentry.file.modify_time,
-			&ep->dentry.file.modify_date,
-			&ep->dentry.file.modify_time_cs);
+			&es->de_file->modify_tz,
+			&es->de_file->modify_time,
+			&es->de_file->modify_date,
+			&es->de_file->modify_time_cs);
 	exfat_set_entry_time(sbi, &inode->i_atime,
-			&ep->dentry.file.access_tz,
-			&ep->dentry.file.access_time,
-			&ep->dentry.file.access_date,
+			&es->de_file->access_tz,
+			&es->de_file->access_time,
+			&es->de_file->access_date,
 			NULL);
 
 	/* File size should be zero if there is no cluster allocated */
@@ -73,8 +70,8 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	if (ei->start_clu == EXFAT_EOF_CLUSTER)
 		on_disk_size = 0;
 
-	ep2->dentry.stream.valid_size = cpu_to_le64(on_disk_size);
-	ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
+	es->de_stream->valid_size = cpu_to_le64(on_disk_size);
+	es->de_stream->size = es->de_stream->valid_size;
 
 	exfat_update_dir_chksum_with_entry_set(es);
 	return exfat_free_dentry_set(es, sync);
@@ -219,7 +216,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		*clu = new_clu.dir;
 
 		if (ei->dir.dir != DIR_DELETED && modified) {
-			struct exfat_dentry *ep;
 			struct exfat_entry_set_cache *es;
 			int err;
 
@@ -227,17 +223,12 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				ES_ALL_ENTRIES);
 			if (!es)
 				return -EIO;
-			/* get stream entry */
-			ep = exfat_get_dentry_cached(es, 1);
-
-			/* update directory entry */
-			ep->dentry.stream.flags = ei->flags;
-			ep->dentry.stream.start_clu =
-				cpu_to_le32(ei->start_clu);
-			ep->dentry.stream.valid_size =
-				cpu_to_le64(i_size_read(inode));
-			ep->dentry.stream.size =
-				ep->dentry.stream.valid_size;
+
+			/* update stream directory entry */
+			es->de_stream->flags = ei->flags;
+			es->de_stream->start_clu = cpu_to_le32(ei->start_clu);
+			es->de_stream->valid_size = cpu_to_le64(i_size_read(inode));
+			es->de_stream->size = es->de_stream->valid_size;
 
 			exfat_update_dir_chksum_with_entry_set(es);
 			err = exfat_free_dentry_set(es, inode_needs_sync(inode));
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e73f20f66cb2..a65d60ef93f4 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -658,25 +658,21 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 
 		info->num_subdirs = count;
 	} else {
-		struct exfat_dentry *ep, *ep2;
 		struct exfat_entry_set_cache *es;
 
 		es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
 		if (!es)
 			return -EIO;
-		ep = exfat_get_dentry_cached(es, 0);
-		ep2 = exfat_get_dentry_cached(es, 1);
 
-		info->type = exfat_get_entry_type(ep);
-		info->attr = le16_to_cpu(ep->dentry.file.attr);
-		info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
+		info->attr = le16_to_cpu(es->de_file->attr);
+		info->type = (info->attr & ATTR_SUBDIR) ? TYPE_DIR : TYPE_FILE;
+		info->size = le64_to_cpu(es->de_stream->valid_size);
 		if ((info->type == TYPE_FILE) && (info->size == 0)) {
 			info->flags = ALLOC_NO_FAT_CHAIN;
 			info->start_clu = EXFAT_EOF_CLUSTER;
 		} else {
-			info->flags = ep2->dentry.stream.flags;
-			info->start_clu =
-				le32_to_cpu(ep2->dentry.stream.start_clu);
+			info->flags = es->de_stream->flags;
+			info->start_clu = le32_to_cpu(es->de_stream->start_clu);
 		}
 
 		if (ei->start_clu == EXFAT_FREE_CLUSTER) {
@@ -688,19 +684,19 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 		}
 
 		exfat_get_entry_time(sbi, &info->crtime,
-				ep->dentry.file.create_tz,
-				ep->dentry.file.create_time,
-				ep->dentry.file.create_date,
-				ep->dentry.file.create_time_cs);
+				es->de_file->create_tz,
+				es->de_file->create_time,
+				es->de_file->create_date,
+				es->de_file->create_time_cs);
 		exfat_get_entry_time(sbi, &info->mtime,
-				ep->dentry.file.modify_tz,
-				ep->dentry.file.modify_time,
-				ep->dentry.file.modify_date,
-				ep->dentry.file.modify_time_cs);
+				es->de_file->modify_tz,
+				es->de_file->modify_time,
+				es->de_file->modify_date,
+				es->de_file->modify_time_cs);
 		exfat_get_entry_time(sbi, &info->atime,
-				ep->dentry.file.access_tz,
-				ep->dentry.file.access_time,
-				ep->dentry.file.access_date,
+				es->de_file->access_tz,
+				es->de_file->access_time,
+				es->de_file->access_date,
 				0);
 		exfat_free_dentry_set(es, false);
 
-- 
2.25.1

