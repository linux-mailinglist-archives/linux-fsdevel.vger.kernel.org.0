Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F845181638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 11:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgCKKwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 06:52:51 -0400
Received: from mx05.melco.co.jp ([192.218.140.145]:50711 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgCKKwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:52:51 -0400
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 565C03A4441;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 48cphK22d7zRk8k;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr05.melco.co.jp (Postfix) with ESMTP id 48cphK1kQkzRk81;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 48cphK1mVVzRkBS;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf03.melco.co.jp (Postfix) with ESMTP id 48cphK1GWQzRk9Z;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 02BAqnvT028963;
        Wed, 11 Mar 2020 19:52:49 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id EABBF17E075;
        Wed, 11 Mar 2020 19:52:48 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tadpost1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id DE2B017E073;
        Wed, 11 Mar 2020 19:52:48 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 02BAqm0u017644;
        Wed, 11 Mar 2020 19:52:48 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: exfat: separate and move exFAT-mount core processing.
Date:   Wed, 11 Mar 2020 19:52:42 +0900
Message-Id: <20200311105245.125564-2-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311105245.125564-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
References: <20200311105245.125564-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Separate the mount process related to the exFAT specification in ffsMountVol() and move it to exfat_mount.c.

 - Rename exfat_mount() to read_boot_sector().
 - Separate exFAT-mount core process and move to exfat_mount.c as NEW exfat_mount().
 - Move free_upcase_table()/free_alloc_bitmap() to exfat_mount.c as exfat_umount().
 - Change some functions to static.

This also fixes the exfat_bdev_close() leak. :-)

Reviewed-by: Takahiro Mori <Mori.Takahiro@ab.MitsubishiElectric.co.jp>
Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 drivers/staging/exfat/exfat.h       | 11 +---
 drivers/staging/exfat/exfat_core.c  | 82 +++++++++++++++++++++++++++--
 drivers/staging/exfat/exfat_super.c | 66 ++---------------------
 3 files changed, 83 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 0f730090cb30..95c2a6ef0e71 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -581,14 +581,6 @@ void fs_error(struct super_block *sb);
 s32 count_num_clusters(struct super_block *sb, struct chain_t *dir);
 void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len);
 
-/* allocation bitmap management functions */
-s32 load_alloc_bitmap(struct super_block *sb);
-void free_alloc_bitmap(struct super_block *sb);
-
-/* upcase table management functions */
-s32 load_upcase_table(struct super_block *sb);
-void free_upcase_table(struct super_block *sb);
-
 /* dir entry management functions */
 struct timestamp_t *tm_current(struct timestamp_t *tm);
 
@@ -616,7 +608,8 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 		 struct uni_name_t *p_uniname);
 
 /* file operation functions */
-s32 exfat_mount(struct super_block *sb, struct boot_sector_t *p_boot);
+s32 exfat_mount(struct super_block *sb);
+void exfat_umount(struct super_block *sb);
 s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	       struct uni_name_t *p_uniname, struct file_id_t *fid);
 s32 create_file(struct inode *inode, struct chain_t *p_dir,
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index ca1039b7977c..2d88ce85217c 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -472,7 +472,7 @@ void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len)
  *  Allocation Bitmap Management Functions
  */
 
-s32 load_alloc_bitmap(struct super_block *sb)
+static s32 load_alloc_bitmap(struct super_block *sb)
 {
 	int i, j, ret;
 	u32 map_size;
@@ -544,7 +544,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 	return -EFSCORRUPTED;
 }
 
-void free_alloc_bitmap(struct super_block *sb)
+static void free_alloc_bitmap(struct super_block *sb)
 {
 	int i;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -561,6 +561,8 @@ void free_alloc_bitmap(struct super_block *sb)
 /*
  *  Upcase table Management Functions
  */
+static void free_upcase_table(struct super_block *sb);
+
 static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 			       u32 num_sectors, u32 utbl_checksum)
 {
@@ -706,7 +708,7 @@ static s32 __load_default_upcase_table(struct super_block *sb)
 	return ret;
 }
 
-s32 load_upcase_table(struct super_block *sb)
+static s32 load_upcase_table(struct super_block *sb)
 {
 	int i;
 	u32 tbl_clu, tbl_size;
@@ -754,7 +756,7 @@ s32 load_upcase_table(struct super_block *sb)
 	return __load_default_upcase_table(sb);
 }
 
-void free_upcase_table(struct super_block *sb)
+static void free_upcase_table(struct super_block *sb)
 {
 	u32 i;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -2060,7 +2062,8 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	return 0;
 }
 
-s32 exfat_mount(struct super_block *sb, struct boot_sector_t *p_boot)
+static s32 read_boot_sector(struct super_block *sb,
+			    struct boot_sector_t *p_boot)
 {
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
@@ -2104,6 +2107,75 @@ s32 exfat_mount(struct super_block *sb, struct boot_sector_t *p_boot)
 	return 0;
 }
 
+s32 exfat_mount(struct super_block *sb)
+{
+	int i, ret;
+	struct boot_sector_t *p_boot;
+	struct buffer_head *tmp_bh = NULL;
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+
+	/* read Sector 0 */
+	if (sector_read(sb, 0, &tmp_bh, 1) != 0) {
+		ret = -EIO;
+		goto out;
+	}
+
+	p_boot = (struct boot_sector_t *)tmp_bh->b_data;
+
+	/* check the validity of BOOT sector */
+	if (le16_to_cpu(p_boot->boot_signature) != BOOT_SIGNATURE) {
+		brelse(tmp_bh);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
+
+	/* fill fs_struct */
+	for (i = 0; i < 53; i++)
+		if (p_boot->must_be_zero[i])
+			break;
+
+	if (i < 53) {
+		/* Not sure how we'd get here, but complain if it does */
+		ret = -EINVAL;
+		pr_info("EXFAT: Attempted to mount VFAT filesystem\n");
+		goto out;
+	} else {
+		ret = read_boot_sector(sb, p_boot);
+	}
+
+	brelse(tmp_bh);
+
+	if (ret)
+		goto out;
+
+	ret = load_alloc_bitmap(sb);
+	if (ret)
+		goto out;
+
+	ret = load_upcase_table(sb);
+	if (ret) {
+		free_alloc_bitmap(sb);
+		goto out;
+	}
+
+	if (p_fs->dev_ejected) {
+		free_upcase_table(sb);
+		free_alloc_bitmap(sb);
+		ret = -EIO;
+		goto out;
+	}
+
+	pr_info("[EXFAT] mounted successfully\n");
+out:
+	return ret;
+}
+
+void exfat_umount(struct super_block *sb)
+{
+	free_upcase_table(sb);
+	free_alloc_bitmap(sb);
+}
+
 s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	       struct uni_name_t *p_uniname, struct file_id_t *fid)
 {
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index bd257d401f7b..978e1d5172ee 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -343,9 +343,7 @@ static inline void exfat_save_attr(struct inode *inode, u32 attr)
 
 static int ffsMountVol(struct super_block *sb)
 {
-	int i, ret;
-	struct boot_sector_t *p_boot;
-	struct buffer_head *tmp_bh = NULL;
+	int ret;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
@@ -370,66 +368,11 @@ static int ffsMountVol(struct super_block *sb)
 	if (p_bd->sector_size > sb->s_blocksize)
 		sb_set_blocksize(sb, p_bd->sector_size);
 
-	/* read Sector 0 */
-	if (sector_read(sb, 0, &tmp_bh, 1) != 0) {
-		ret = -EIO;
-		goto out;
-	}
-
-	p_boot = (struct boot_sector_t *)tmp_bh->b_data;
-
-	/* check the validity of BOOT sector */
-	if (le16_to_cpu(p_boot->boot_signature) != BOOT_SIGNATURE) {
-		brelse(tmp_bh);
-		exfat_bdev_close(sb);
-		ret = -EFSCORRUPTED;
-		goto out;
-	}
-
-	/* fill fs_struct */
-	for (i = 0; i < 53; i++)
-		if (p_boot->must_be_zero[i])
-			break;
-
-	if (i < 53) {
-		/* Not sure how we'd get here, but complain if it does */
-		ret = -EINVAL;
-		pr_info("EXFAT: Attempted to mount VFAT filesystem\n");
-		goto out;
-	} else {
-		ret = exfat_mount(sb, p_boot);
-	}
-
-	brelse(tmp_bh);
-
-	if (ret) {
-		exfat_bdev_close(sb);
-		goto out;
-	}
-
-	ret = load_alloc_bitmap(sb);
-	if (ret) {
-		exfat_bdev_close(sb);
-		goto out;
-	}
-	ret = load_upcase_table(sb);
+	ret = exfat_mount(sb);
+out:
 	if (ret) {
-		free_alloc_bitmap(sb);
 		exfat_bdev_close(sb);
-		goto out;
 	}
-
-	if (p_fs->dev_ejected) {
-		free_upcase_table(sb);
-		free_alloc_bitmap(sb);
-		exfat_bdev_close(sb);
-		ret = -EIO;
-		goto out;
-	}
-
-	pr_info("[EXFAT] mounted successfully\n");
-
-out:
 	mutex_unlock(&z_mutex);
 
 	return ret;
@@ -450,8 +393,7 @@ static int ffsUmountVol(struct super_block *sb)
 	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 
-	free_upcase_table(sb);
-	free_alloc_bitmap(sb);
+	exfat_umount(sb);
 
 	exfat_fat_release_all(sb);
 	exfat_buf_release_all(sb);
-- 
2.25.1

