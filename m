Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8820F15022F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 09:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgBCICb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 03:02:31 -0500
Received: from mx04.melco.co.jp ([192.218.140.144]:43962 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgBCICa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:02:30 -0500
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 9560F3A3ED6;
        Mon,  3 Feb 2020 17:02:27 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 48B0fq483zzRk0G;
        Mon,  3 Feb 2020 17:02:27 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr04.melco.co.jp (Postfix) with ESMTP id 48B0fq3qg1zRjjK;
        Mon,  3 Feb 2020 17:02:27 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 48B0fq3nyJzRk5V;
        Mon,  3 Feb 2020 17:02:27 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf04.melco.co.jp (Postfix) with ESMTP id 48B0fq39TRzRk4x;
        Mon,  3 Feb 2020 17:02:27 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 01382RZN022510;
        Mon, 3 Feb 2020 17:02:27 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 3032617E075;
        Mon,  3 Feb 2020 17:02:27 +0900 (JST)
Received: from tux554.tad.melco.co.jp (mailgw1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id 23E9917E073;
        Mon,  3 Feb 2020 17:02:27 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 01382Rc1022824;
        Mon, 3 Feb 2020 17:02:27 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp,
        Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp
Subject: [PATCH 1/2] staging: exfat: remove DOSNAMEs.
Date:   Tue,  4 Feb 2020 01:31:17 +0900
Message-Id: <20200203163118.31332-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

remove 'dos_name','ShortName' and related definitions.

'dos_name' and 'ShortName' are definitions before VFAT.
These are never used in exFAT.

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 drivers/staging/exfat/exfat.h       | 52 +++--------------------------
 drivers/staging/exfat/exfat_core.c  | 47 +++++++++-----------------
 drivers/staging/exfat/exfat_super.c | 38 ++++++++-------------
 3 files changed, 34 insertions(+), 103 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 4d87360fab35..62aba0feda12 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -189,8 +189,6 @@ static inline u16 get_row_index(u16 i)
 #define MAX_PATH_DEPTH		15	/* max depth of path name */
 #define MAX_NAME_LENGTH		256	/* max len of filename including NULL */
 #define MAX_PATH_LENGTH		260	/* max len of pathname including NULL */
-#define DOS_NAME_LENGTH		11	/* DOS filename length excluding NULL */
-#define DOS_PATH_LENGTH		80	/* DOS pathname length excluding NULL */
 
 /* file attributes */
 #define ATTR_NORMAL		0x0000
@@ -210,9 +208,6 @@ static inline u16 get_row_index(u16 i)
 
 #define NUM_UPCASE              2918
 
-#define DOS_CUR_DIR_NAME        ".          "
-#define DOS_PAR_DIR_NAME        "..         "
-
 #ifdef __LITTLE_ENDIAN
 #define UNI_CUR_DIR_NAME        ".\0"
 #define UNI_PAR_DIR_NAME        ".\0.\0"
@@ -271,10 +266,6 @@ struct file_id_t {
 
 struct dir_entry_t {
 	char Name[MAX_NAME_LENGTH * MAX_CHARSET_SIZE];
-
-	/* used only for FAT12/16/32, not used for exFAT */
-	char ShortName[DOS_NAME_LENGTH + 2];
-
 	u32 Attr;
 	u64 Size;
 	u32 NumSubdirs;
@@ -391,33 +382,6 @@ struct dentry_t {
 	u8       dummy[32];
 };
 
-struct dos_dentry_t {
-	u8       name[DOS_NAME_LENGTH];
-	u8       attr;
-	u8       lcase;
-	u8       create_time_ms;
-	u8       create_time[2];
-	u8       create_date[2];
-	u8       access_date[2];
-	u8       start_clu_hi[2];
-	u8       modify_time[2];
-	u8       modify_date[2];
-	u8       start_clu_lo[2];
-	u8       size[4];
-};
-
-/* MS-DOS FAT extended directory entry (32 bytes) */
-struct ext_dentry_t {
-	u8       order;
-	u8       unicode_0_4[10];
-	u8       attr;
-	u8       sysid;
-	u8       checksum;
-	u8       unicode_5_10[12];
-	u8       start_clu[2];
-	u8       unicode_11_12[4];
-};
-
 /* MS-DOS EXFAT file directory entry (32 bytes) */
 struct file_dentry_t {
 	u8       type;
@@ -492,12 +456,6 @@ struct uentry_t {
 	struct chain_t     clu;
 };
 
-/* DOS name structure */
-struct dos_name_t {
-	u8       name[DOS_NAME_LENGTH];
-	u8       name_case;
-};
-
 /* unicode name structure */
 struct uni_name_t {
 	u16      name[MAX_NAME_LENGTH];
@@ -736,8 +694,7 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 					       u32 type,
 					       struct dentry_t **file_ep);
 void release_entry_set(struct entry_set_cache_t *es);
-s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
-			   u32 type);
+s32 count_entries(struct super_block *sb, struct chain_t *p_dir, u32 type);
 void update_dir_checksum(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry);
 void update_dir_checksum_with_entry_set(struct super_block *sb,
@@ -745,9 +702,8 @@ void update_dir_checksum_with_entry_set(struct super_block *sb,
 bool is_dir_empty(struct super_block *sb, struct chain_t *p_dir);
 
 /* name conversion functions */
-s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
-				 struct uni_name_t *p_uniname, s32 *entries,
-				 struct dos_name_t *p_dosname);
+s32 get_num_entries(struct super_block *sb, struct chain_t *p_dir,
+		    struct uni_name_t *p_uniname, s32 *entries);
 u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type);
 
 /* name resolution functions */
@@ -795,7 +751,7 @@ s32 exfat_count_used_clusters(struct super_block *sb);
 /* dir operation functions */
 s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 struct uni_name_t *p_uniname, s32 num_entries,
-			 struct dos_name_t *p_dosname, u32 type);
+			 u32 type);
 void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, s32 order, s32 num_entries);
 void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 07b460d01334..188349eeef5f 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1044,8 +1044,7 @@ static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 
 static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 				s32 entry, s32 num_entries,
-				struct uni_name_t *p_uniname,
-				struct dos_name_t *p_dosname)
+				struct uni_name_t *p_uniname)
 {
 	int i;
 	sector_t sector;
@@ -1691,7 +1690,7 @@ static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *unina
  */
 s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 struct uni_name_t *p_uniname, s32 num_entries,
-			 struct dos_name_t *p_dosname, u32 type)
+			 u32 type)
 {
 	int i = 0, dentry = 0, num_ext_entries = 0, len, step;
 	s32 order = 0;
@@ -1855,8 +1854,7 @@ s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 	return count;
 }
 
-s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
-			   u32 type)
+s32 count_entries(struct super_block *sb, struct chain_t *p_dir, u32 type)
 {
 	int i, count = 0;
 	s32 dentries_per_clu;
@@ -1976,11 +1974,10 @@ bool is_dir_empty(struct super_block *sb, struct chain_t *p_dir)
  */
 
 /* input  : dir, uni_name
- * output : num_of_entry, dos_name(format : aaaaaa~1.bbb)
+ * output : num_of_entry
  */
-s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
-				 struct uni_name_t *p_uniname, s32 *entries,
-				 struct dos_name_t *p_dosname)
+s32 get_num_entries(struct super_block *sb, struct chain_t *p_dir,
+		    struct uni_name_t *p_uniname, s32 *entries)
 {
 	s32 num_entries;
 
@@ -2149,12 +2146,10 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	s32 ret, dentry, num_entries;
 	u64 size;
 	struct chain_t clu;
-	struct dos_name_t dos_name;
 	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	ret = get_num_entries_and_dos_name(sb, p_dir, p_uniname, &num_entries,
-					   &dos_name);
+	ret = get_num_entries(sb, p_dir, p_uniname, &num_entries);
 	if (ret)
 		return ret;
 
@@ -2187,8 +2182,7 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	if (ret != 0)
 		return ret;
 
-	ret = exfat_init_ext_entry(sb, p_dir, dentry, num_entries, p_uniname,
-				   &dos_name);
+	ret = exfat_init_ext_entry(sb, p_dir, dentry, num_entries, p_uniname);
 	if (ret != 0)
 		return ret;
 
@@ -2213,12 +2207,10 @@ s32 create_file(struct inode *inode, struct chain_t *p_dir,
 		struct uni_name_t *p_uniname, u8 mode, struct file_id_t *fid)
 {
 	s32 ret, dentry, num_entries;
-	struct dos_name_t dos_name;
 	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	ret = get_num_entries_and_dos_name(sb, p_dir, p_uniname, &num_entries,
-					   &dos_name);
+	ret = get_num_entries(sb, p_dir, p_uniname, &num_entries);
 	if (ret)
 		return ret;
 
@@ -2228,7 +2220,7 @@ s32 create_file(struct inode *inode, struct chain_t *p_dir,
 		return -ENOSPC;
 
 	/* (1) update the directory entry */
-	/* fill the dos name directory entry information of the created file.
+	/* fill the directory entry information of the created file.
 	 * the first cluster is not determined yet. (0)
 	 */
 	ret = exfat_init_dir_entry(sb, p_dir, dentry, TYPE_FILE | mode,
@@ -2236,8 +2228,7 @@ s32 create_file(struct inode *inode, struct chain_t *p_dir,
 	if (ret != 0)
 		return ret;
 
-	ret = exfat_init_ext_entry(sb, p_dir, dentry, num_entries, p_uniname,
-				   &dos_name);
+	ret = exfat_init_ext_entry(sb, p_dir, dentry, num_entries, p_uniname);
 	if (ret != 0)
 		return ret;
 
@@ -2290,7 +2281,6 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 {
 	s32 ret, newentry = -1, num_old_entries, num_new_entries;
 	sector_t sector_old, sector_new;
-	struct dos_name_t dos_name;
 	struct dentry_t *epold, *epnew;
 	struct super_block *sb = inode->i_sb;
 
@@ -2309,8 +2299,7 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 	}
 	num_old_entries++;
 
-	ret = get_num_entries_and_dos_name(sb, p_dir, p_uniname,
-					   &num_new_entries, &dos_name);
+	ret = get_num_entries(sb, p_dir, p_uniname, &num_new_entries);
 	if (ret) {
 		exfat_buf_unlock(sb, sector_old);
 		return ret;
@@ -2355,8 +2344,7 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 		exfat_buf_unlock(sb, sector_old);
 
 		ret = exfat_init_ext_entry(sb, p_dir, newentry,
-					   num_new_entries, p_uniname,
-					   &dos_name);
+					   num_new_entries, p_uniname);
 		if (ret != 0)
 			return ret;
 
@@ -2374,8 +2362,7 @@ s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 		exfat_buf_unlock(sb, sector_old);
 
 		ret = exfat_init_ext_entry(sb, p_dir, oldentry,
-					   num_new_entries, p_uniname,
-					   &dos_name);
+					   num_new_entries, p_uniname);
 		if (ret != 0)
 			return ret;
 
@@ -2392,7 +2379,6 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 {
 	s32 ret, newentry, num_new_entries, num_old_entries;
 	sector_t sector_mov, sector_new;
-	struct dos_name_t dos_name;
 	struct dentry_t *epmov, *epnew;
 	struct super_block *sb = inode->i_sb;
 
@@ -2416,8 +2402,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	}
 	num_old_entries++;
 
-	ret = get_num_entries_and_dos_name(sb, p_newdir, p_uniname,
-					   &num_new_entries, &dos_name);
+	ret = get_num_entries(sb, p_newdir, p_uniname, &num_new_entries);
 	if (ret) {
 		exfat_buf_unlock(sb, sector_mov);
 		return ret;
@@ -2459,7 +2444,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	exfat_buf_unlock(sb, sector_mov);
 
 	ret = exfat_init_ext_entry(sb, p_newdir, newentry, num_new_entries,
-				   p_uniname, &dos_name);
+				   p_uniname);
 	if (ret != 0)
 		return ret;
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index b81d2a87b82e..ae666f79ff48 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -539,7 +539,6 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 	int ret, dentry, num_entries;
 	struct chain_t dir;
 	struct uni_name_t uni_name;
-	struct dos_name_t dos_name;
 	struct dentry_t *ep, *ep2;
 	struct entry_set_cache_t *es = NULL;
 	struct super_block *sb = inode->i_sb;
@@ -559,14 +558,13 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 	if (ret)
 		goto out;
 
-	ret = get_num_entries_and_dos_name(sb, &dir, &uni_name, &num_entries,
-					   &dos_name);
+	ret = get_num_entries(sb, &dir, &uni_name, &num_entries);
 	if (ret)
 		goto out;
 
 	/* search the file name for directories */
 	dentry = exfat_find_dir_entry(sb, &dir, &uni_name, num_entries,
-				      &dos_name, TYPE_ALL);
+				      TYPE_ALL);
 	if (dentry < -1) {
 		ret = -ENOENT;
 		goto out;
@@ -1464,7 +1462,6 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 			       sizeof(struct date_time_t));
 			memset((char *)&info->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
-			strcpy(info->ShortName, ".");
 			strcpy(info->Name, ".");
 
 			dir.dir = p_fs->root_dir;
@@ -1479,7 +1476,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 						p_fs->cluster_size_bits;
 			}
 
-			count = count_dos_name_entries(sb, &dir, TYPE_DIR);
+			count = count_entries(sb, &dir, TYPE_DIR);
 			if (count < 0) {
 				ret = count; /* propagate error upward */
 				goto out;
@@ -1546,7 +1543,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 			info->Size = (u64)count_num_clusters(sb, &dir) <<
 					p_fs->cluster_size_bits;
 
-		count = count_dos_name_entries(sb, &dir, TYPE_DIR);
+		count = count_entries(sb, &dir, TYPE_DIR);
 		if (count < 0) {
 			ret = count; /* propagate error upward */
 			goto out;
@@ -2077,8 +2074,9 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 	struct fs_info_t *p_fs = &sbi->fs_info;
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 	struct dir_entry_t de;
+	struct inode *tmp;
 	unsigned long inum;
-	loff_t cpos;
+	loff_t cpos, i_pos;
 	int err = 0;
 
 	__lock_super(sb);
@@ -2129,21 +2127,15 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 	if (!de.Name[0])
 		goto end_of_dir;
 
-	if (!memcmp(de.ShortName, DOS_CUR_DIR_NAME, DOS_NAME_LENGTH)) {
-		inum = inode->i_ino;
-	} else if (!memcmp(de.ShortName, DOS_PAR_DIR_NAME, DOS_NAME_LENGTH)) {
-		inum = parent_ino(filp->f_path.dentry);
-	} else {
-		loff_t i_pos = ((loff_t)EXFAT_I(inode)->fid.start_clu << 32) |
-				((EXFAT_I(inode)->fid.rwoffset - 1) & 0xffffffff);
-		struct inode *tmp = exfat_iget(sb, i_pos);
+	i_pos = ((loff_t)EXFAT_I(inode)->fid.start_clu << 32) |
+		((EXFAT_I(inode)->fid.rwoffset - 1) & 0xffffffff);
+	tmp = exfat_iget(sb, i_pos);
 
-		if (tmp) {
-			inum = tmp->i_ino;
-			iput(tmp);
-		} else {
-			inum = iunique(sb, EXFAT_ROOT_INO);
-		}
+	if (tmp) {
+		inum = tmp->i_ino;
+		iput(tmp);
+	} else {
+		inum = iunique(sb, EXFAT_ROOT_INO);
 	}
 
 	if (!dir_emit(ctx, de.Name, strlen(de.Name), inum,
@@ -3847,8 +3839,6 @@ static int __init init_exfat(void)
 	int err;
 
 	BUILD_BUG_ON(sizeof(struct dentry_t) != DENTRY_SIZE);
-	BUILD_BUG_ON(sizeof(struct dos_dentry_t) != DENTRY_SIZE);
-	BUILD_BUG_ON(sizeof(struct ext_dentry_t) != DENTRY_SIZE);
 	BUILD_BUG_ON(sizeof(struct file_dentry_t) != DENTRY_SIZE);
 	BUILD_BUG_ON(sizeof(struct strm_dentry_t) != DENTRY_SIZE);
 	BUILD_BUG_ON(sizeof(struct name_dentry_t) != DENTRY_SIZE);
-- 
2.25.0

