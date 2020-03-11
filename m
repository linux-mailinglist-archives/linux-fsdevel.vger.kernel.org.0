Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43E2181639
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 11:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgCKKww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 06:52:52 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:35961 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgCKKww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:52:52 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 9C0353A4424;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 48cphK3sl5zRk4t;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr06.melco.co.jp (Postfix) with ESMTP id 48cphK3YxrzRjys;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 48cphK3Yn6zRkBS;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf03.melco.co.jp (Postfix) with ESMTP id 48cphK35pBzRk9Z;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 02BAqnIb028966;
        Wed, 11 Mar 2020 19:52:49 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 2DD5917E075;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from tux554.tad.melco.co.jp (mailgw1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id 2155C17E073;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 02BAqm0v017644;
        Wed, 11 Mar 2020 19:52:49 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: exfat: consolidate boot sector analysis
Date:   Wed, 11 Mar 2020 19:52:43 +0900
Message-Id: <20200311105245.125564-3-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311105245.125564-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
References: <20200311105245.125564-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Consolidate boot sector analysis into read_boot_sector().

 - Move boot sector analysis from exfat_mount() to read_boot_sector().
 - Fix num_fats check in read_boot_sector().
 - Consolidate p_fs->boot_bh initialization/release into mount/umount.

This fixes vol_flags inconsistency at read failed in fs_set_vol_flags(),
and tmp_bh leak in exfat_mount(). :-)

Reviewed-by: Takahiro Mori <Mori.Takahiro@ab.MitsubishiElectric.co.jp>
Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 drivers/staging/exfat/exfat_core.c | 106 ++++++++++++-----------------
 1 file changed, 45 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 2d88ce85217c..3faa7f35c77c 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -89,11 +89,6 @@ void fs_set_vol_flags(struct super_block *sb, u32 new_flag)
 
 	p_fs->vol_flag = new_flag;
 
-	if (!p_fs->boot_bh) {
-		if (sector_read(sb, 0, &p_fs->boot_bh, 1) != 0)
-			return;
-	}
-
 	p_boot = (struct boot_sector_t *)p_fs->boot_bh->b_data;
 	p_boot->vol_flags = cpu_to_le16(new_flag);
 
@@ -531,8 +526,6 @@ static s32 load_alloc_bitmap(struct super_block *sb)
 						return ret;
 					}
 				}
-
-				p_fs->boot_bh = NULL;
 				return 0;
 			}
 		}
@@ -549,9 +542,7 @@ static void free_alloc_bitmap(struct super_block *sb)
 	int i;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	brelse(p_fs->boot_bh);
-
-	for (i = 0; i < p_fs->map_sectors; i++)
+	for (i = 0; i < p_fs->map_sectors && p_fs->vol_amap; i++)
 		__brelse(p_fs->vol_amap[i]);
 
 	kfree(p_fs->vol_amap);
@@ -763,7 +754,7 @@ static void free_upcase_table(struct super_block *sb)
 	u16 **upcase_table;
 
 	upcase_table = p_fs->vol_utbl;
-	for (i = 0; i < UTBL_COL_COUNT; i++)
+	for (i = 0; i < UTBL_COL_COUNT && upcase_table; i++)
 		kfree(upcase_table[i]);
 
 	kfree(p_fs->vol_utbl);
@@ -2062,15 +2053,31 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	return 0;
 }
 
-static s32 read_boot_sector(struct super_block *sb,
-			    struct boot_sector_t *p_boot)
+static int read_boot_sector(struct super_block *sb)
 {
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
+	struct boot_sector_t *p_boot;
+	int i;
+
+	p_boot = (struct boot_sector_t *)p_fs->boot_bh->b_data;
 
-	if (p_boot->num_fats == 0)
+	/* check the validity of BOOT sector */
+	if (le16_to_cpu(p_boot->boot_signature) != BOOT_SIGNATURE)
 		return -EFSCORRUPTED;
 
+	/* check the byte range consumed as BPB for FAT12/16/32 volumes */
+	for (i = 0; i < 53; i++) {
+		if (p_boot->must_be_zero[i]) {
+			pr_info("EXFAT: Attempted to mount VFAT filesystem\n");
+			return -EFSCORRUPTED;
+		}
+	}
+
+	if (p_boot->num_fats != 1 && p_boot->num_fats != 2)
+		return -EFSCORRUPTED;
+
+	/* fill fs_info */
 	p_fs->sectors_per_clu = 1 << p_boot->sectors_per_clu_shift;
 	p_fs->sectors_per_clu_bits = p_boot->sectors_per_clu_shift;
 	p_fs->cluster_size_bits = p_fs->sectors_per_clu_bits +
@@ -2080,11 +2087,9 @@ static s32 read_boot_sector(struct super_block *sb,
 	p_fs->num_FAT_sectors = le32_to_cpu(p_boot->fat_length);
 
 	p_fs->FAT1_start_sector = le32_to_cpu(p_boot->fat_offset);
-	if (p_boot->num_fats == 1)
-		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector;
-	else
-		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector +
-					  p_fs->num_FAT_sectors;
+	p_fs->FAT2_start_sector = p_fs->FAT1_start_sector;
+	if (p_boot->num_fats == 2)
+		p_fs->FAT2_start_sector += p_fs->num_FAT_sectors;
 
 	p_fs->root_start_sector = le32_to_cpu(p_boot->clu_offset);
 	p_fs->data_start_sector = p_fs->root_start_sector;
@@ -2109,71 +2114,50 @@ static s32 read_boot_sector(struct super_block *sb,
 
 s32 exfat_mount(struct super_block *sb)
 {
-	int i, ret;
-	struct boot_sector_t *p_boot;
-	struct buffer_head *tmp_bh = NULL;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+	int ret;
 
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
-		ret = read_boot_sector(sb, p_boot);
-	}
+	p_fs->vol_utbl = NULL;
+	p_fs->vol_amap = NULL;
 
-	brelse(tmp_bh);
+	/* read Sector 0 */
+	ret = sector_read(sb, 0, &p_fs->boot_bh, 1);
+	if (ret)
+		goto err_out;
 
+	ret = read_boot_sector(sb);
 	if (ret)
-		goto out;
+		goto err_out;
 
 	ret = load_alloc_bitmap(sb);
 	if (ret)
-		goto out;
+		goto err_out;
 
 	ret = load_upcase_table(sb);
-	if (ret) {
-		free_alloc_bitmap(sb);
-		goto out;
-	}
+	if (ret)
+		goto err_out;
 
 	if (p_fs->dev_ejected) {
-		free_upcase_table(sb);
-		free_alloc_bitmap(sb);
 		ret = -EIO;
-		goto out;
+		goto err_out;
 	}
 
 	pr_info("[EXFAT] mounted successfully\n");
-out:
+	return 0;
+
+err_out:
+	exfat_umount(sb);
 	return ret;
 }
 
 void exfat_umount(struct super_block *sb)
 {
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+
 	free_upcase_table(sb);
 	free_alloc_bitmap(sb);
+	brelse(p_fs->boot_bh);
+	p_fs->boot_bh = NULL;
 }
 
 s32 create_dir(struct inode *inode, struct chain_t *p_dir,
-- 
2.25.1

