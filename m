Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E571DACBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgETH5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 03:57:09 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:36440 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETH5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 03:57:09 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 1F3913A46D0;
        Wed, 20 May 2020 16:57:04 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 49RlTD0PMszRkGk;
        Wed, 20 May 2020 16:57:04 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr06.melco.co.jp (Postfix) with ESMTP id 49RlTD05FwzRkCw;
        Wed, 20 May 2020 16:57:04 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 49RlTC74mSzRjmf;
        Wed, 20 May 2020 16:57:03 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf03.melco.co.jp (Postfix) with ESMTP id 49RlTC6SbhzRjc0;
        Wed, 20 May 2020 16:57:03 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 04K7v3TS024160;
        Wed, 20 May 2020 16:57:03 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id AFC1017E07A;
        Wed, 20 May 2020 16:57:03 +0900 (JST)
Received: from tux554.tad.melco.co.jp (mailgw1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id A2CD317E079;
        Wed, 20 May 2020 16:57:03 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 04K7v30F018804;
        Wed, 20 May 2020 16:57:03 +0900
From:   Tetsuhiro Kohada <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
To:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp
Cc:     mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: optimize dir-cache
Date:   Wed, 20 May 2020 16:56:41 +0900
Message-Id: <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Optimize directory access based on exfat_entry_set_cache.
 - Hold bh instead of copied d-entry.
 - Modify bh->data directly instead of the copied d-entry.
 - Write back the retained bh instead of rescanning the d-entry-set.
And
 - Remove unused cache related definitions.

Signed-off-by: Tetsuhiro Kohada <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
---
 fs/exfat/dir.c      | 197 +++++++++++++++++---------------------------
 fs/exfat/exfat_fs.h |  27 +++---
 fs/exfat/file.c     |  15 ++--
 fs/exfat/inode.c    |  53 +++++-------
 fs/exfat/namei.c    |  14 ++--
 5 files changed, 124 insertions(+), 182 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index b5a237c33d50..2902d285bf20 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -32,35 +32,30 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 		struct exfat_chain *p_dir, int entry, unsigned short *uniname)
 {
 	int i;
-	struct exfat_dentry *ep;
 	struct exfat_entry_set_cache *es;
 
-	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES, &ep);
+	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
 	if (!es)
 		return;
 
-	if (es->num_entries < 3)
-		goto free_es;
-
-	ep += 2;
-
 	/*
 	 * First entry  : file entry
 	 * Second entry : stream-extension entry
 	 * Third entry  : first file-name entry
 	 * So, the index of first file-name dentry should start from 2.
 	 */
-	for (i = 2; i < es->num_entries; i++, ep++) {
+	for (i = 2; i < es->num_entries; i++) {
+		struct exfat_dentry *ep = exfat_get_dentry_cached(es, i);
+
 		/* end of name entry */
 		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
-			goto free_es;
+			break;
 
 		exfat_extract_uni_name(ep, uniname);
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
-free_es:
-	kfree(es);
+	exfat_free_dentry_set(es, false);
 }
 
 /* read a directory entry from the opened directory */
@@ -590,62 +585,33 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
 	return 0;
 }
 
-int exfat_update_dir_chksum_with_entry_set(struct super_block *sb,
-		struct exfat_entry_set_cache *es, int sync)
+void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 {
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct buffer_head *bh;
-	sector_t sec = es->sector;
-	unsigned int off = es->offset;
-	int chksum_type = CS_DIR_ENTRY, i, num_entries = es->num_entries;
-	unsigned int buf_off = (off - es->offset);
-	unsigned int remaining_byte_in_sector, copy_entries, clu;
+	int chksum_type = CS_DIR_ENTRY, i;
 	unsigned short chksum = 0;
+	struct exfat_dentry *ep;
 
-	for (i = 0; i < num_entries; i++) {
-		chksum = exfat_calc_chksum_2byte(&es->entries[i], DENTRY_SIZE,
-			chksum, chksum_type);
+	for (i = 0; i < es->num_entries; i++) {
+		ep = exfat_get_dentry_cached(es, i);
+		chksum = exfat_calc_chksum_2byte(ep, DENTRY_SIZE, chksum,
+						 chksum_type);
 		chksum_type = CS_DEFAULT;
 	}
+	ep = exfat_get_dentry_cached(es, 0);
+	ep->dentry.file.checksum = cpu_to_le16(chksum);
+	es->modified = true;
+}
 
-	es->entries[0].dentry.file.checksum = cpu_to_le16(chksum);
+void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
+{
+	int i;
 
-	while (num_entries) {
-		/* write per sector base */
-		remaining_byte_in_sector = (1 << sb->s_blocksize_bits) - off;
-		copy_entries = min_t(int,
-			EXFAT_B_TO_DEN(remaining_byte_in_sector),
-			num_entries);
-		bh = sb_bread(sb, sec);
-		if (!bh)
-			goto err_out;
-		memcpy(bh->b_data + off,
-			(unsigned char *)&es->entries[0] + buf_off,
-			EXFAT_DEN_TO_B(copy_entries));
-		exfat_update_bh(sb, bh, sync);
-		brelse(bh);
-		num_entries -= copy_entries;
-
-		if (num_entries) {
-			/* get next sector */
-			if (exfat_is_last_sector_in_cluster(sbi, sec)) {
-				clu = exfat_sector_to_cluster(sbi, sec);
-				if (es->alloc_flag == ALLOC_NO_FAT_CHAIN)
-					clu++;
-				else if (exfat_get_next_cluster(sb, &clu))
-					goto err_out;
-				sec = exfat_cluster_to_sector(sbi, clu);
-			} else {
-				sec++;
-			}
-			off = 0;
-			buf_off += EXFAT_DEN_TO_B(copy_entries);
-		}
+	for (i = 0; i < es->num_bh; i++) {
+		if (es->modified)
+			exfat_update_bh(es->sb, es->bh[i], sync);
+		brelse(es->bh[i]);
 	}
-
-	return 0;
-err_out:
-	return -EIO;
+	kfree(es);
 }
 
 static int exfat_walk_fat_chain(struct super_block *sb,
@@ -820,34 +786,40 @@ static bool exfat_validate_entry(unsigned int type,
 	}
 }
 
+struct exfat_dentry *exfat_get_dentry_cached(
+	struct exfat_entry_set_cache *es, int num)
+{
+	int off = es->start_off + num * DENTRY_SIZE;
+	struct buffer_head *bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
+	char *p = bh->b_data + EXFAT_BLK_OFFSET(off, es->sb);
+
+	return (struct exfat_dentry *)p;
+}
+
 /*
  * Returns a set of dentries for a file or dir.
  *
- * Note that this is a copy (dump) of dentries so that user should
- * call write_entry_set() to apply changes made in this entry set
- * to the real device.
+ * Note It provides a direct pointer to bh->data via exfat_get_dentry_cached().
+ * User should call exfat_get_dentry_set() after setting 'modified' to apply
+ * changes made in this entry set to the real device.
  *
  * in:
  *   sb+p_dir+entry: indicates a file/dir
  *   type:  specifies how many dentries should be included.
- * out:
- *   file_ep: will point the first dentry(= file dentry) on success
  * return:
  *   pointer of entry set on success,
  *   NULL on failure.
  */
 struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
-		struct exfat_chain *p_dir, int entry, unsigned int type,
-		struct exfat_dentry **file_ep)
+		struct exfat_chain *p_dir, int entry, unsigned int type)
 {
-	int ret;
+	int ret, i, num_bh;
 	unsigned int off, byte_offset, clu = 0;
-	unsigned int entry_type;
 	sector_t sec;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_entry_set_cache *es;
-	struct exfat_dentry *ep, *pos;
-	unsigned char num_entries;
+	struct exfat_dentry *ep;
+	int num_entries;
 	enum exfat_validate_dentry_mode mode = ES_MODE_STARTED;
 	struct buffer_head *bh;
 
@@ -861,11 +833,18 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	if (ret)
 		return NULL;
 
+	es = kzalloc(sizeof(*es), GFP_KERNEL);
+	if (!es)
+		return NULL;
+	es->sb = sb;
+	es->modified = false;
+
 	/* byte offset in cluster */
 	byte_offset = EXFAT_CLU_OFFSET(byte_offset, sbi);
 
 	/* byte offset in sector */
 	off = EXFAT_BLK_OFFSET(byte_offset, sb);
+	es->start_off = off;
 
 	/* sector offset in cluster */
 	sec = EXFAT_B_TO_BLK(byte_offset, sb);
@@ -873,72 +852,46 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 
 	bh = sb_bread(sb, sec);
 	if (!bh)
-		return NULL;
-
-	ep = (struct exfat_dentry *)(bh->b_data + off);
-	entry_type = exfat_get_entry_type(ep);
+		goto free_es;
+	es->bh[es->num_bh++] = bh;
 
-	if (entry_type != TYPE_FILE && entry_type != TYPE_DIR)
-		goto release_bh;
+	ep = exfat_get_dentry_cached(es, 0);
+	if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
+		goto free_es;
 
 	num_entries = type == ES_ALL_ENTRIES ?
 		ep->dentry.file.num_ext + 1 : type;
-	es = kmalloc(struct_size(es, entries, num_entries), GFP_KERNEL);
-	if (!es)
-		goto release_bh;
-
 	es->num_entries = num_entries;
-	es->sector = sec;
-	es->offset = off;
-	es->alloc_flag = p_dir->flags;
-
-	pos = &es->entries[0];
-
-	while (num_entries) {
-		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
-			goto free_es;
 
-		/* copy dentry */
-		memcpy(pos, ep, sizeof(struct exfat_dentry));
-
-		if (--num_entries == 0)
-			break;
-
-		if (((off + DENTRY_SIZE) & (sb->s_blocksize - 1)) <
-		    (off & (sb->s_blocksize - 1))) {
-			/* get the next sector */
-			if (exfat_is_last_sector_in_cluster(sbi, sec)) {
-				if (es->alloc_flag == ALLOC_NO_FAT_CHAIN)
-					clu++;
-				else if (exfat_get_next_cluster(sb, &clu))
-					goto free_es;
-				sec = exfat_cluster_to_sector(sbi, clu);
-			} else {
-				sec++;
-			}
-
-			brelse(bh);
-			bh = sb_bread(sb, sec);
-			if (!bh)
+	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
+	for (i = 1; i < num_bh; i++) {
+		/* get the next sector */
+		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
+			if (p_dir->flags == ALLOC_NO_FAT_CHAIN)
+				clu++;
+			else if (exfat_get_next_cluster(sb, &clu))
 				goto free_es;
-			off = 0;
-			ep = (struct exfat_dentry *)bh->b_data;
+			sec = exfat_cluster_to_sector(sbi, clu);
 		} else {
-			ep++;
-			off += DENTRY_SIZE;
+			sec++;
 		}
-		pos++;
+
+		bh = sb_bread(sb, sec);
+		if (!bh)
+			goto free_es;
+		es->bh[es->num_bh++] = bh;
 	}
 
-	if (file_ep)
-		*file_ep = &es->entries[0];
-	brelse(bh);
+	/* validiate cached dentries */
+	for (i = 1; i < num_entries; i++) {
+		ep = exfat_get_dentry_cached(es, i);
+		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
+			goto free_es;
+	}
 	return es;
 
 free_es:
-	kfree(es);
-release_bh:
-	brelse(bh);
+	exfat_free_dentry_set(es, false);
 	return NULL;
 }
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 294aa7792bc3..5caad1380818 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -71,10 +71,8 @@ enum {
 #define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
 #define MAX_VFSNAME_BUF_SIZE	((MAX_NAME_LENGTH + 1) * MAX_CHARSET_SIZE)
 
-#define FAT_CACHE_SIZE		128
-#define FAT_CACHE_HASH_SIZE	64
-#define BUF_CACHE_SIZE		256
-#define BUF_CACHE_HASH_SIZE	64
+/* Enough size to hold 256 dentry (even 512 Byte sector) */
+#define DIR_CACHE_SIZE		(256*sizeof(struct exfat_dentry)/512+1)
 
 #define EXFAT_HINT_NONE		-1
 #define EXFAT_MIN_SUBDIR	2
@@ -170,14 +168,12 @@ struct exfat_hint {
 };
 
 struct exfat_entry_set_cache {
-	/* sector number that contains file_entry */
-	sector_t sector;
-	/* byte offset in the sector */
-	unsigned int offset;
-	/* flag in stream entry. 01 for cluster chain, 03 for contig. */
-	int alloc_flag;
+	struct super_block *sb;
+	bool modified;
+	unsigned int start_off;
+	int num_bh;
+	struct buffer_head *bh[DIR_CACHE_SIZE];
 	unsigned int num_entries;
-	struct exfat_dentry entries[];
 };
 
 struct exfat_dir_entry {
@@ -451,8 +447,7 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
 		int entry, int order, int num_entries);
 int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 		int entry);
-int exfat_update_dir_chksum_with_entry_set(struct super_block *sb,
-		struct exfat_entry_set_cache *es, int sync);
+void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
@@ -463,9 +458,11 @@ int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
 struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 		struct exfat_chain *p_dir, int entry, struct buffer_head **bh,
 		sector_t *sector);
+struct exfat_dentry *exfat_get_dentry_cached(
+	struct exfat_entry_set_cache *es, int num);
 struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
-		struct exfat_chain *p_dir, int entry, unsigned int type,
-		struct exfat_dentry **file_ep);
+		struct exfat_chain *p_dir, int entry, unsigned int type);
+void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
 
 /* inode.c */
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 84f3d31a3a55..8e3f0eef45d7 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -96,11 +96,9 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 	unsigned int num_clusters_new, num_clusters_phys;
 	unsigned int last_clu = EXFAT_FREE_CLUSTER;
 	struct exfat_chain clu;
-	struct exfat_dentry *ep, *ep2;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	struct exfat_entry_set_cache *es = NULL;
 	int evict = (ei->dir.dir == DIR_DELETED) ? 1 : 0;
 
 	/* check if the given file ID is opened */
@@ -153,12 +151,15 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 	/* update the directory entry */
 	if (!evict) {
 		struct timespec64 ts;
+		struct exfat_dentry *ep, *ep2;
+		struct exfat_entry_set_cache *es;
 
 		es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
-				ES_ALL_ENTRIES, &ep);
+				ES_ALL_ENTRIES);
 		if (!es)
 			return -EIO;
-		ep2 = ep + 1;
+		ep = exfat_get_dentry_cached(es, 0);
+		ep2 = exfat_get_dentry_cached(es, 1);
 
 		ts = current_time(inode);
 		exfat_set_entry_time(sbi, &ts,
@@ -185,10 +186,8 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 			ep2->dentry.stream.start_clu = EXFAT_FREE_CLUSTER;
 		}
 
-		if (exfat_update_dir_chksum_with_entry_set(sb, es,
-		    inode_needs_sync(inode)))
-			return -EIO;
-		kfree(es);
+		exfat_update_dir_chksum_with_entry_set(es);
+		exfat_free_dentry_set(es, inode_needs_sync(inode));
 	}
 
 	/* cut off from the FAT chain */
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 3f367d081cd6..ef7cf7a6d187 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -19,7 +19,6 @@
 
 static int __exfat_write_inode(struct inode *inode, int sync)
 {
-	int ret = -EIO;
 	unsigned long long on_disk_size;
 	struct exfat_dentry *ep, *ep2;
 	struct exfat_entry_set_cache *es = NULL;
@@ -43,11 +42,11 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	exfat_set_vol_flags(sb, VOL_DIRTY);
 
 	/* get the directory entry of given file or directory */
-	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES,
-		&ep);
+	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES);
 	if (!es)
 		return -EIO;
-	ep2 = ep + 1;
+	ep = exfat_get_dentry_cached(es, 0);
+	ep2 = exfat_get_dentry_cached(es, 1);
 
 	ep->dentry.file.attr = cpu_to_le16(exfat_make_attr(inode));
 
@@ -77,9 +76,9 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	ep2->dentry.stream.valid_size = cpu_to_le64(on_disk_size);
 	ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
 
-	ret = exfat_update_dir_chksum_with_entry_set(sb, es, sync);
-	kfree(es);
-	return ret;
+	exfat_update_dir_chksum_with_entry_set(es);
+	exfat_free_dentry_set(es, sync);
+	return 0;
 }
 
 int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
@@ -110,8 +109,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	int ret, modified = false;
 	unsigned int last_clu;
 	struct exfat_chain new_clu;
-	struct exfat_dentry *ep;
-	struct exfat_entry_set_cache *es = NULL;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
@@ -222,34 +219,28 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		num_clusters += num_to_be_allocated;
 		*clu = new_clu.dir;
 
-		if (ei->dir.dir != DIR_DELETED) {
+		if (ei->dir.dir != DIR_DELETED && modified) {
+			struct exfat_dentry *ep;
+			struct exfat_entry_set_cache *es;
+
 			es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
-				ES_ALL_ENTRIES, &ep);
+				ES_ALL_ENTRIES);
 			if (!es)
 				return -EIO;
 			/* get stream entry */
-			ep++;
+			ep = exfat_get_dentry_cached(es, 1);
 
 			/* update directory entry */
-			if (modified) {
-				if (ep->dentry.stream.flags != ei->flags)
-					ep->dentry.stream.flags = ei->flags;
-
-				if (le32_to_cpu(ep->dentry.stream.start_clu) !=
-						ei->start_clu)
-					ep->dentry.stream.start_clu =
-						cpu_to_le32(ei->start_clu);
-
-				ep->dentry.stream.valid_size =
-					cpu_to_le64(i_size_read(inode));
-				ep->dentry.stream.size =
-					ep->dentry.stream.valid_size;
-			}
-
-			if (exfat_update_dir_chksum_with_entry_set(sb, es,
-			    inode_needs_sync(inode)))
-				return -EIO;
-			kfree(es);
+			ep->dentry.stream.flags = ei->flags;
+			ep->dentry.stream.start_clu =
+				cpu_to_le32(ei->start_clu);
+			ep->dentry.stream.valid_size =
+				cpu_to_le64(i_size_read(inode));
+			ep->dentry.stream.size =
+				ep->dentry.stream.valid_size;
+
+			exfat_update_dir_chksum_with_entry_set(es);
+			exfat_free_dentry_set(es, inode_needs_sync(inode));
 
 		} /* end of if != DIR_DELETED */
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 48f4df883f3b..5b0f35329d63 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -600,8 +600,6 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	int ret, dentry, num_entries, count;
 	struct exfat_chain cdir;
 	struct exfat_uni_name uni_name;
-	struct exfat_dentry *ep, *ep2;
-	struct exfat_entry_set_cache *es = NULL;
 	struct super_block *sb = dir->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(dir);
@@ -660,10 +658,14 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 
 		info->num_subdirs = count;
 	} else {
-		es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES, &ep);
+		struct exfat_dentry *ep, *ep2;
+		struct exfat_entry_set_cache *es;
+
+		es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
 		if (!es)
 			return -EIO;
-		ep2 = ep + 1;
+		ep = exfat_get_dentry_cached(es, 0);
+		ep2 = exfat_get_dentry_cached(es, 1);
 
 		info->type = exfat_get_entry_type(ep);
 		info->attr = le16_to_cpu(ep->dentry.file.attr);
@@ -681,7 +683,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 			exfat_fs_error(sb,
 				"non-zero size file starts with zero cluster (size : %llu, p_dir : %u, entry : 0x%08x)",
 				i_size_read(dir), ei->dir.dir, ei->entry);
-			kfree(es);
+			exfat_free_dentry_set(es, false);
 			return -EIO;
 		}
 
@@ -700,7 +702,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 				ep->dentry.file.access_time,
 				ep->dentry.file.access_date,
 				0);
-		kfree(es);
+		exfat_free_dentry_set(es, false);
 
 		if (info->type == TYPE_DIR) {
 			exfat_chain_set(&cdir, info->start_clu,
-- 
2.25.0

