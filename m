Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C12A1328F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 15:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgAGOdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 09:33:47 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50232 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727559AbgAGOdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:33:46 -0500
Received: from faui01j.informatik.uni-erlangen.de (faui01j.informatik.uni-erlangen.de [IPv6:2001:638:a000:4160:131:188:60:136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 8B4E4241732;
        Tue,  7 Jan 2020 15:33:42 +0100 (CET)
Received: by faui01j.informatik.uni-erlangen.de (Postfix, from userid 66565)
        id 854BFC8120D; Tue,  7 Jan 2020 15:33:42 +0100 (CET)
From:   Julian Preis <julian.preis@fau.de>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Julian Preis <julian.preis@fau.de>,
        Johannes Weidner <johannes.weidner@fau.de>
Subject: [PATCH v4] drivers/staging/exfat/exfat_super.c: Clean up ffsCamelCase function names
Date:   Tue,  7 Jan 2020 15:33:37 +0100
Message-Id: <20200107143337.11419-1-julian.preis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename every instance of <ffsCamelCaseExample> to <ffs_camel_case_example>
in file exfat_super.c. Fix resulting overlong lines.

Co-developed-by: Johannes Weidner <johannes.weidner@fau.de>
Signed-off-by: Johannes Weidner <johannes.weidner@fau.de>
Signed-off-by: Julian Preis <julian.preis@fau.de>
---
Changes in v4:
- Resolve name conflicts for functions create_file, move_file, remove_file and
  create_dir by adding a "ffs_" prefix  for these four functions.

Changes in v3:
- Change renaming from <ffs_camel_case_example> to <camel_case_example>

Changes in v2:
- Add email recipients according to get_maintainer.pl
- Add patch versions
- Use in-reply-to
---
 drivers/staging/exfat/exfat_super.c | 97 +++++++++++++++--------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 744344a2521c..9561144972b7 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -343,7 +343,7 @@ static inline void exfat_save_attr(struct inode *inode, u32 attr)
 		EXFAT_I(inode)->fid.attr = attr & (ATTR_RWMASK | ATTR_READONLY);
 }
 
-static int ffsMountVol(struct super_block *sb)
+static int mount_vol(struct super_block *sb)
 {
 	int i, ret;
 	struct pbr_sector_t *p_pbr;
@@ -439,7 +439,7 @@ static int ffsMountVol(struct super_block *sb)
 	return ret;
 }
 
-static int ffsUmountVol(struct super_block *sb)
+static int umount_vol(struct super_block *sb)
 {
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	int err = 0;
@@ -479,7 +479,7 @@ static int ffsUmountVol(struct super_block *sb)
 	return err;
 }
 
-static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
+static int get_vol_info(struct super_block *sb, struct vol_info_t *info)
 {
 	int err = 0;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -509,7 +509,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	return err;
 }
 
-static int ffsSyncVol(struct super_block *sb, bool do_sync)
+static int sync_vol(struct super_block *sb, bool do_sync)
 {
 	int err = 0;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -534,7 +534,7 @@ static int ffsSyncVol(struct super_block *sb, bool do_sync)
 /*  File Operation Functions                                            */
 /*----------------------------------------------------------------------*/
 
-static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
+static int lookup_file(struct inode *inode, char *path, struct file_id_t *fid)
 {
 	int ret, dentry, num_entries;
 	struct chain_t dir;
@@ -621,8 +621,8 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 	return ret;
 }
 
-static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
-			 struct file_id_t *fid)
+static int ffs_create_file(struct inode *inode, char *path, u8 mode,
+			   struct file_id_t *fid)
 {
 	struct chain_t dir;
 	struct uni_name_t uni_name;
@@ -662,8 +662,8 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 	return ret;
 }
 
-static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
-		       u64 count, u64 *rcount)
+static int read_file(struct inode *inode, struct file_id_t *fid, void *buffer,
+		     u64 count, u64 *rcount)
 {
 	s32 offset, sec_offset, clu_offset;
 	u32 clu;
@@ -788,8 +788,8 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 	return ret;
 }
 
-static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
-			void *buffer, u64 count, u64 *wcount)
+static int write_file(struct inode *inode, struct file_id_t *fid,
+		      void *buffer, u64 count, u64 *wcount)
 {
 	bool modified = false;
 	s32 offset, sec_offset, clu_offset;
@@ -1031,7 +1031,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 	return ret;
 }
 
-static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
+static int truncate_file(struct inode *inode, u64 old_size, u64 new_size)
 {
 	s32 num_clusters;
 	u32 last_clu = CLUSTER_32(0);
@@ -1167,8 +1167,8 @@ static void update_parent_info(struct file_id_t *fid,
 	}
 }
 
-static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
-		       struct inode *new_parent_inode, struct dentry *new_dentry)
+static int ffs_move_file(struct inode *old_parent_inode, struct file_id_t *fid,
+			 struct inode *new_parent_inode,
+			 struct dentry *new_dentry)
 {
 	s32 ret;
 	s32 dentry;
@@ -1296,7 +1296,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	return ret;
 }
 
-static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
+static int ffs_remove_file(struct inode *inode, struct file_id_t *fid)
 {
 	s32 dentry;
 	int ret = 0;
@@ -1360,7 +1360,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 
 #if 0
 /* Not currently wired up */
-static int ffsSetAttr(struct inode *inode, u32 attr)
+static int set_attr(struct inode *inode, u32 attr)
 {
 	u32 type;
 	int ret = 0;
@@ -1435,7 +1435,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 }
 #endif
 
-static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
+static int read_stat(struct inode *inode, struct dir_entry_t *info)
 {
 	s32 count;
 	int ret = 0;
@@ -1565,7 +1565,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	return ret;
 }
 
-static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
+static int write_stat(struct inode *inode, struct dir_entry_t *info)
 {
 	int ret = 0;
 	struct timestamp_t tm;
@@ -1638,7 +1638,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	return ret;
 }
 
-static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
+static int map_cluster(struct inode *inode, s32 clu_offset, u32 *clu)
 {
 	s32 num_clusters, num_alloced;
 	bool modified = false;
@@ -1778,7 +1778,8 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 /*  Directory Operation Functions                                       */
 /*----------------------------------------------------------------------*/
 
-static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
+static int ffs_create_dir(struct inode *inode, char *path,
+			  struct file_id_t *fid)
 {
 	int ret = 0;
 	struct chain_t dir;
@@ -1818,7 +1819,7 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 	return ret;
 }
 
-static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
+static int read_dir(struct inode *inode, struct dir_entry_t *dir_entry)
 {
 	int i, dentry, clu_offset;
 	int ret = 0;
@@ -2005,7 +2006,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 	return ret;
 }
 
-static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
+static int ffs_remove_dir(struct inode *inode, struct file_id_t *fid)
 {
 	s32 dentry;
 	int ret = 0;
@@ -2114,7 +2115,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 	EXFAT_I(inode)->fid.rwoffset = cpos >> DENTRY_SIZE_BITS;
 
-	err = ffsReadDir(inode, &de);
+	err = read_dir(inode, &de);
 	if (err) {
 		/* at least we tried to read a sector
 		 * move cpos to next sector position (should be aligned)
@@ -2235,7 +2236,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	pr_debug("%s entered\n", __func__);
 
-	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_REGULAR, &fid);
+	err = ffs_create_file(dir, (u8 *)dentry->d_name.name, FM_REGULAR, &fid);
 	if (err)
 		goto out;
 
@@ -2282,7 +2283,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	if (qname->len == 0)
 		return -ENOENT;
 
-	err = ffsLookupFile(dir, (u8 *)qname->name, fid);
+	err = lookup_file(dir, (u8 *)qname->name, fid);
 	if (err)
 		return -ENOENT;
 
@@ -2332,8 +2333,8 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 			err = -ENOMEM;
 			goto error;
 		}
-		ffsReadFile(dir, &fid, EXFAT_I(inode)->target,
-			    i_size_read(inode), &ret);
+		read_file(dir, &fid, EXFAT_I(inode)->target,
+			  i_size_read(inode), &ret);
 		*(EXFAT_I(inode)->target + i_size_read(inode)) = '\0';
 	}
 
@@ -2402,7 +2403,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
-	err = ffsRemoveFile(dir, &(EXFAT_I(inode)->fid));
+	err = ffs_remove_file(dir, &(EXFAT_I(inode)->fid));
 	if (err)
 		goto out;
 
@@ -2444,15 +2445,15 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 
 	pr_debug("%s entered\n", __func__);
 
-	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_SYMLINK, &fid);
+	err = ffs_create_file(dir, (u8 *)dentry->d_name.name, FM_SYMLINK, &fid);
 	if (err)
 		goto out;
 
 
-	err = ffsWriteFile(dir, &fid, (char *)target, len, &ret);
+	err = write_file(dir, &fid, (char *)target, len, &ret);
 
 	if (err) {
-		ffsRemoveFile(dir, &fid);
+		ffs_remove_file(dir, &fid);
 		goto out;
 	}
 
@@ -2508,7 +2509,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	pr_debug("%s entered\n", __func__);
 
-	err = ffsCreateDir(dir, (u8 *)dentry->d_name.name, &fid);
+	err = ffs_create_dir(dir, (u8 *)dentry->d_name.name, &fid);
 	if (err)
 		goto out;
 
@@ -2559,7 +2560,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
-	err = ffsRemoveDir(dir, &(EXFAT_I(inode)->fid));
+	err = ffs_remove_dir(dir, &(EXFAT_I(inode)->fid));
 	if (err)
 		goto out;
 
@@ -2608,8 +2609,8 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	EXFAT_I(old_inode)->fid.size = i_size_read(old_inode);
 
-	err = ffsMoveFile(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
-			  new_dentry);
+	err = ffs_move_file(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
+			    new_dentry);
 	if (err)
 		goto out;
 
@@ -2766,7 +2767,7 @@ static void exfat_truncate(struct inode *inode, loff_t old_size)
 	if (EXFAT_I(inode)->fid.start_clu == 0)
 		goto out;
 
-	err = ffsTruncateFile(inode, old_size, i_size_read(inode));
+	err = truncate_file(inode, old_size, i_size_read(inode));
 	if (err)
 		goto out;
 
@@ -2902,7 +2903,7 @@ static int exfat_file_release(struct inode *inode, struct file *filp)
 	struct super_block *sb = inode->i_sb;
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
-	ffsSyncVol(sb, false);
+	sync_vol(sb, false);
 	return 0;
 }
 
@@ -2957,7 +2958,7 @@ static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
-	err = ffsMapCluster(inode, clu_offset, &cluster);
+	err = map_cluster(inode, clu_offset, &cluster);
 
 	if (!err && (cluster != CLUSTER_32(~0))) {
 		*phys = START_SECTOR(cluster) + sec_offset;
@@ -3150,7 +3151,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 
 	memcpy(&(EXFAT_I(inode)->fid), fid, sizeof(struct file_id_t));
 
-	ffsReadStat(inode, &info);
+	read_stat(inode, &info);
 
 	EXFAT_I(inode)->i_pos = 0;
 	EXFAT_I(inode)->target = NULL;
@@ -3266,7 +3267,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	exfat_time_unix2fat(&inode->i_ctime, &info.CreateTimestamp);
 	exfat_time_unix2fat(&inode->i_atime, &info.AccessTimestamp);
 
-	ffsWriteStat(inode, &info);
+	write_stat(inode, &info);
 
 	return 0;
 }
@@ -3304,7 +3305,7 @@ static void exfat_put_super(struct super_block *sb)
 	if (__is_sb_dirty(sb))
 		exfat_write_super(sb);
 
-	ffsUmountVol(sb);
+	umount_vol(sb);
 
 	sb->s_fs_info = NULL;
 	exfat_free_super(sbi);
@@ -3317,7 +3318,7 @@ static void exfat_write_super(struct super_block *sb)
 	__set_sb_clean(sb);
 
 	if (!sb_rdonly(sb))
-		ffsSyncVol(sb, true);
+		sync_vol(sb, true);
 
 	__unlock_super(sb);
 }
@@ -3329,7 +3330,7 @@ static int exfat_sync_fs(struct super_block *sb, int wait)
 	if (__is_sb_dirty(sb)) {
 		__lock_super(sb);
 		__set_sb_clean(sb);
-		err = ffsSyncVol(sb, true);
+		err = sync_vol(sb, true);
 		__unlock_super(sb);
 	}
 
@@ -3344,7 +3345,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct vol_info_t info;
 
 	if (p_fs->used_clusters == UINT_MAX) {
-		if (ffsGetVolInfo(sb, &info) == -EIO)
+		if (get_vol_info(sb, &info) == -EIO)
 			return -EIO;
 
 	} else {
@@ -3646,7 +3647,7 @@ static int exfat_read_root(struct inode *inode)
 
 	EXFAT_I(inode)->target = NULL;
 
-	ffsReadStat(inode, &info);
+	read_stat(inode, &info);
 
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
@@ -3713,10 +3714,10 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	sb_min_blocksize(sb, 512);
 	sb->s_maxbytes = 0x7fffffffffffffffLL;    /* maximum file size */
 
-	ret = ffsMountVol(sb);
+	ret = mount_vol(sb);
 	if (ret) {
 		if (!silent)
-			pr_err("[EXFAT] ffsMountVol failed\n");
+			pr_err("[EXFAT] mount_vol failed\n");
 
 		goto out_fail;
 	}
@@ -3756,7 +3757,7 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 
 out_fail2:
-	ffsUmountVol(sb);
+	umount_vol(sb);
 out_fail:
 	if (root_inode)
 		iput(root_inode);
-- 
2.20.1

