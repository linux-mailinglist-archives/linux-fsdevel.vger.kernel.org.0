Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AFA181641
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 11:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgCKKwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 06:52:51 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:35958 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCKKwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:52:51 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 0CF7B3A4426;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 48cphJ74D6zRk04;
        Wed, 11 Mar 2020 19:52:48 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr06.melco.co.jp (Postfix) with ESMTP id 48cphJ6lyVzRjys;
        Wed, 11 Mar 2020 19:52:48 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 48cphJ6g15zRjFt;
        Wed, 11 Mar 2020 19:52:48 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf04.melco.co.jp (Postfix) with ESMTP id 48cphJ62pqzRjFp;
        Wed, 11 Mar 2020 19:52:48 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 02BAqmqc028960;
        Wed, 11 Mar 2020 19:52:48 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 9FC3E17E075;
        Wed, 11 Mar 2020 19:52:48 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tux100.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id 9323E17E073;
        Wed, 11 Mar 2020 19:52:48 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 02BAqm0t017644;
        Wed, 11 Mar 2020 19:52:48 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] staging: exfat: conform 'pbr_sector_t' definition to exFAT specification
Date:   Wed, 11 Mar 2020 19:52:41 +0900
Message-Id: <20200311105245.125564-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Redefine 'pbr_sector_t' as 'boot_sector_t' to comply with exFAT specification.
 - Redefine 'pbr_sector_t' as 'boot_sector_t'.
 - Rename variable names including 'pbr'.
 - Replace GET**()/SET**() macro with cpu_to_le**()/le**_ to_cpu().
 - Remove fs_info_t.PBR_sector (always 0).
 - Remove unused definitions.

Reviewed-by: Takahiro Mori <Mori.Takahiro@ab.MitsubishiElectric.co.jp>
Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 drivers/staging/exfat/exfat.h       | 139 +++++++---------------------
 drivers/staging/exfat/exfat_core.c  |  62 ++++++-------
 drivers/staging/exfat/exfat_super.c |  14 ++-
 3 files changed, 65 insertions(+), 150 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index c863d7566b57..0f730090cb30 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -35,17 +35,12 @@
 #define DENTRY_SIZE		32	/* dir entry size */
 #define DENTRY_SIZE_BITS	5
 
-/* PBR entries */
-#define PBR_SIGNATURE	0xAA55
-#define EXT_SIGNATURE	0xAA550000
-#define VOL_LABEL	"NO NAME    "	/* size should be 11 */
-#define OEM_NAME	"MSWIN4.1"	/* size should be 8 */
-#define STR_FAT12	"FAT12   "	/* size should be 8 */
-#define STR_FAT16	"FAT16   "	/* size should be 8 */
-#define STR_FAT32	"FAT32   "	/* size should be 8 */
-#define STR_EXFAT	"EXFAT   "	/* size should be 8 */
-#define VOL_CLEAN	0x0000
-#define VOL_DIRTY	0x0002
+/* exFAT: 3 Main and Backup Boot Regions */
+#define BOOT_SIGNATURE		0xAA55
+#define EXBOOT_SIGNATURE	0xAA550000
+#define STR_EXFAT		"EXFAT   "	/* size should be 8 */
+#define VOL_CLEAN		0x0000
+#define VOL_DIRTY		0x0002
 
 /* max number of clusters */
 #define FAT12_THRESHOLD		4087		/* 2^12 - 1 + 2 (clu 0 & 1) */
@@ -81,7 +76,7 @@
 
 /* checksum types */
 #define CS_DIR_ENTRY		0
-#define CS_PBR_SECTOR		1
+#define CS_BOOT_SECTOR		1
 #define CS_DEFAULT		2
 
 #define CLUSTER_16(x)		((u16)(x))
@@ -267,98 +262,29 @@ struct timestamp_t {
 	u16      year;       /* 0 ~ 127 (since 1980) */
 };
 
-/* MS_DOS FAT partition boot record (512 bytes) */
-struct pbr_sector_t {
-	u8       jmp_boot[3];
-	u8       oem_name[8];
-	u8       bpb[109];
-	u8       boot_code[390];
-	u8       signature[2];
-};
-
-/* MS-DOS FAT12/16 BIOS parameter block (51 bytes) */
-struct bpb16_t {
-	u8       sector_size[2];
-	u8       sectors_per_clu;
-	u8       num_reserved[2];
-	u8       num_fats;
-	u8       num_root_entries[2];
-	u8       num_sectors[2];
-	u8       media_type;
-	u8       num_fat_sectors[2];
-	u8       sectors_in_track[2];
-	u8       num_heads[2];
-	u8       num_hid_sectors[4];
-	u8       num_huge_sectors[4];
-
-	u8       phy_drv_no;
-	u8       reserved;
-	u8       ext_signature;
-	u8       vol_serial[4];
-	u8       vol_label[11];
-	u8       vol_type[8];
-};
-
-/* MS-DOS FAT32 BIOS parameter block (79 bytes) */
-struct bpb32_t {
-	u8       sector_size[2];
-	u8       sectors_per_clu;
-	u8       num_reserved[2];
-	u8       num_fats;
-	u8       num_root_entries[2];
-	u8       num_sectors[2];
-	u8       media_type;
-	u8       num_fat_sectors[2];
-	u8       sectors_in_track[2];
-	u8       num_heads[2];
-	u8       num_hid_sectors[4];
-	u8       num_huge_sectors[4];
-	u8       num_fat32_sectors[4];
-	u8       ext_flags[2];
-	u8       fs_version[2];
-	u8       root_cluster[4];
-	u8       fsinfo_sector[2];
-	u8       backup_sector[2];
-	u8       reserved[12];
-
-	u8       phy_drv_no;
-	u8       ext_reserved;
-	u8       ext_signature;
-	u8       vol_serial[4];
-	u8       vol_label[11];
-	u8       vol_type[8];
-};
-
-/* MS-DOS EXFAT BIOS parameter block (109 bytes) */
-struct bpbex_t {
-	u8       reserved1[53];
-	u8       vol_offset[8];
-	u8       vol_length[8];
-	u8       fat_offset[4];
-	u8       fat_length[4];
-	u8       clu_offset[4];
-	u8       clu_count[4];
-	u8       root_cluster[4];
-	u8       vol_serial[4];
-	u8       fs_version[2];
-	u8       vol_flags[2];
-	u8       sector_size_bits;
-	u8       sectors_per_clu_bits;
-	u8       num_fats;
-	u8       phy_drv_no;
-	u8       perc_in_use;
-	u8       reserved2[7];
-};
-
-/* MS-DOS FAT file system information sector (512 bytes) */
-struct fsi_sector_t {
-	u8       signature1[4];
-	u8       reserved1[480];
-	u8       signature2[4];
-	u8       free_cluster[4];
-	u8       next_cluster[4];
-	u8       reserved2[14];
-	u8       signature3[2];
+/* exFAT: 3.1 Main and Backup Boot Sector (512 bytes) */
+struct boot_sector_t {
+	__u8	jmp_boot[3];
+	__u8	fs_name[8];
+	__u8	must_be_zero[53];
+	__le64	partition_offset;
+	__le64	vol_length;
+	__le32	fat_offset;
+	__le32	fat_length;
+	__le32	clu_offset;
+	__le32	clu_count;
+	__le32	root_cluster;
+	__le32	vol_serial;
+	__le16	fs_revision;
+	__le16	vol_flags;
+	__u8	bytes_per_sector_shift;
+	__u8	sectors_per_clu_shift;
+	__u8	num_fats;
+	__u8	drv_sel;
+	__u8	percent_in_use;
+	__u8	reserved[7];
+	__u8	boot_code[390];
+	__le16	boot_signature;
 };
 
 /* MS-DOS FAT directory entry (32 bytes) */
@@ -469,7 +395,6 @@ struct fs_info_t {
 	u32      sectors_per_clu;        /* cluster size in sectors */
 	u32      sectors_per_clu_bits;
 
-	u32      PBR_sector;             /* PBR sector */
 	u32      FAT1_start_sector;      /* FAT1 start sector */
 	u32      FAT2_start_sector;      /* FAT2 start sector */
 	u32      root_start_sector;      /* root dir start sector */
@@ -481,7 +406,7 @@ struct fs_info_t {
 	u32      dentries_per_clu;       /* num of dentries per cluster */
 
 	u32      vol_flag;               /* volume dirty flag */
-	struct buffer_head *pbr_bh;         /* PBR sector */
+	struct buffer_head *boot_bh;     /* BOOT sector */
 
 	u32      map_clu;                /* allocation bitmap start cluster */
 	u32      map_sectors;            /* num of allocation bitmap sectors */
@@ -691,7 +616,7 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 		 struct uni_name_t *p_uniname);
 
 /* file operation functions */
-s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
+s32 exfat_mount(struct super_block *sb, struct boot_sector_t *p_boot);
 s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	       struct uni_name_t *p_uniname, struct file_id_t *fid);
 s32 create_file(struct inode *inode, struct chain_t *p_dir,
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 374a4fe183f5..ca1039b7977c 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -81,8 +81,7 @@ static inline void exfat_bitmap_clear(u8 *bitmap, int i)
 
 void fs_set_vol_flags(struct super_block *sb, u32 new_flag)
 {
-	struct pbr_sector_t *p_pbr;
-	struct bpbex_t *p_bpb;
+	struct boot_sector_t *p_boot;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	if (p_fs->vol_flag == new_flag)
@@ -90,23 +89,21 @@ void fs_set_vol_flags(struct super_block *sb, u32 new_flag)
 
 	p_fs->vol_flag = new_flag;
 
-	if (!p_fs->pbr_bh) {
-		if (sector_read(sb, p_fs->PBR_sector,
-				&p_fs->pbr_bh, 1) != 0)
+	if (!p_fs->boot_bh) {
+		if (sector_read(sb, 0, &p_fs->boot_bh, 1) != 0)
 			return;
 	}
 
-	p_pbr = (struct pbr_sector_t *)p_fs->pbr_bh->b_data;
-	p_bpb = (struct bpbex_t *)p_pbr->bpb;
-	SET16(p_bpb->vol_flags, (u16)new_flag);
+	p_boot = (struct boot_sector_t *)p_fs->boot_bh->b_data;
+	p_boot->vol_flags = cpu_to_le16(new_flag);
 
 	/* XXX duyoung
 	 * what can we do here? (cuz fs_set_vol_flags() is void)
 	 */
-	if ((new_flag == VOL_DIRTY) && (!buffer_dirty(p_fs->pbr_bh)))
-		sector_write(sb, p_fs->PBR_sector, p_fs->pbr_bh, 1);
+	if ((new_flag == VOL_DIRTY) && (!buffer_dirty(p_fs->boot_bh)))
+		sector_write(sb, 0, p_fs->boot_bh, 1);
 	else
-		sector_write(sb, p_fs->PBR_sector, p_fs->pbr_bh, 0);
+		sector_write(sb, 0, p_fs->boot_bh, 0);
 }
 
 void fs_error(struct super_block *sb)
@@ -535,7 +532,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 					}
 				}
 
-				p_fs->pbr_bh = NULL;
+				p_fs->boot_bh = NULL;
 				return 0;
 			}
 		}
@@ -552,7 +549,7 @@ void free_alloc_bitmap(struct super_block *sb)
 	int i;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	brelse(p_fs->pbr_bh);
+	brelse(p_fs->boot_bh);
 
 	for (i = 0; i < p_fs->map_sectors; i++)
 		__brelse(p_fs->vol_amap[i]);
@@ -2063,45 +2060,44 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	return 0;
 }
 
-s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
+s32 exfat_mount(struct super_block *sb, struct boot_sector_t *p_boot)
 {
-	struct bpbex_t *p_bpb = (struct bpbex_t *)p_pbr->bpb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
-	if (p_bpb->num_fats == 0)
+	if (p_boot->num_fats == 0)
 		return -EFSCORRUPTED;
 
-	p_fs->sectors_per_clu = 1 << p_bpb->sectors_per_clu_bits;
-	p_fs->sectors_per_clu_bits = p_bpb->sectors_per_clu_bits;
+	p_fs->sectors_per_clu = 1 << p_boot->sectors_per_clu_shift;
+	p_fs->sectors_per_clu_bits = p_boot->sectors_per_clu_shift;
 	p_fs->cluster_size_bits = p_fs->sectors_per_clu_bits +
 				  p_bd->sector_size_bits;
 	p_fs->cluster_size = 1 << p_fs->cluster_size_bits;
 
-	p_fs->num_FAT_sectors = GET32(p_bpb->fat_length);
+	p_fs->num_FAT_sectors = le32_to_cpu(p_boot->fat_length);
 
-	p_fs->FAT1_start_sector = p_fs->PBR_sector + GET32(p_bpb->fat_offset);
-	if (p_bpb->num_fats == 1)
+	p_fs->FAT1_start_sector = le32_to_cpu(p_boot->fat_offset);
+	if (p_boot->num_fats == 1)
 		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector;
 	else
 		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector +
 					  p_fs->num_FAT_sectors;
 
-	p_fs->root_start_sector = p_fs->PBR_sector + GET32(p_bpb->clu_offset);
+	p_fs->root_start_sector = le32_to_cpu(p_boot->clu_offset);
 	p_fs->data_start_sector = p_fs->root_start_sector;
 
-	p_fs->num_sectors = GET64(p_bpb->vol_length);
-	p_fs->num_clusters = GET32(p_bpb->clu_count) + 2;
+	p_fs->num_sectors = le64_to_cpu(p_boot->vol_length);
+	p_fs->num_clusters = le32_to_cpu(p_boot->clu_count) + 2;
 	/* because the cluster index starts with 2 */
 
-	p_fs->vol_id = GET32(p_bpb->vol_serial);
+	p_fs->vol_id = le32_to_cpu(p_boot->vol_serial);
 
-	p_fs->root_dir = GET32(p_bpb->root_cluster);
+	p_fs->root_dir = le32_to_cpu(p_boot->root_cluster);
 	p_fs->dentries_in_root = 0;
 	p_fs->dentries_per_clu = 1 << (p_fs->cluster_size_bits -
 				       DENTRY_SIZE_BITS);
 
-	p_fs->vol_flag = (u32)GET16(p_bpb->vol_flags);
+	p_fs->vol_flag = (u32)le16_to_cpu(p_boot->vol_flags);
 	p_fs->clu_srch_ptr = 2;
 	p_fs->used_clusters = UINT_MAX;
 
@@ -2431,8 +2427,7 @@ int sector_read(struct super_block *sb, sector_t sec, struct buffer_head **bh,
 	s32 ret = -EIO;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	if ((sec >= (p_fs->PBR_sector + p_fs->num_sectors)) &&
-	    (p_fs->num_sectors > 0)) {
+	if ((sec >= p_fs->num_sectors) && (p_fs->num_sectors > 0)) {
 		pr_err("[EXFAT] %s: out of range error! (sec = %llu)\n",
 		       __func__, (unsigned long long)sec);
 		fs_error(sb);
@@ -2454,8 +2449,7 @@ int sector_write(struct super_block *sb, sector_t sec, struct buffer_head *bh,
 	s32 ret = -EIO;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	if (sec >= (p_fs->PBR_sector + p_fs->num_sectors) &&
-	    (p_fs->num_sectors > 0)) {
+	if (sec >= p_fs->num_sectors && (p_fs->num_sectors > 0)) {
 		pr_err("[EXFAT] %s: out of range error! (sec = %llu)\n",
 		       __func__, (unsigned long long)sec);
 		fs_error(sb);
@@ -2483,8 +2477,7 @@ int multi_sector_read(struct super_block *sb, sector_t sec,
 	s32 ret = -EIO;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	if (((sec + num_secs) > (p_fs->PBR_sector + p_fs->num_sectors)) &&
-	    (p_fs->num_sectors > 0)) {
+	if (((sec + num_secs) > p_fs->num_sectors) && (p_fs->num_sectors > 0)) {
 		pr_err("[EXFAT] %s: out of range error! (sec = %llu, num_secs = %d)\n",
 		       __func__, (unsigned long long)sec, num_secs);
 		fs_error(sb);
@@ -2506,8 +2499,7 @@ int multi_sector_write(struct super_block *sb, sector_t sec,
 	s32 ret = -EIO;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	if ((sec + num_secs) > (p_fs->PBR_sector + p_fs->num_sectors) &&
-	    (p_fs->num_sectors > 0)) {
+	if ((sec + num_secs) > p_fs->num_sectors && (p_fs->num_sectors > 0)) {
 		pr_err("[EXFAT] %s: out of range error! (sec = %llu, num_secs = %d)\n",
 		       __func__, (unsigned long long)sec, num_secs);
 		fs_error(sb);
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 75813d0fe7a7..bd257d401f7b 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -344,7 +344,7 @@ static inline void exfat_save_attr(struct inode *inode, u32 attr)
 static int ffsMountVol(struct super_block *sb)
 {
 	int i, ret;
-	struct pbr_sector_t *p_pbr;
+	struct boot_sector_t *p_boot;
 	struct buffer_head *tmp_bh = NULL;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
@@ -376,12 +376,10 @@ static int ffsMountVol(struct super_block *sb)
 		goto out;
 	}
 
-	p_fs->PBR_sector = 0;
+	p_boot = (struct boot_sector_t *)tmp_bh->b_data;
 
-	p_pbr = (struct pbr_sector_t *)tmp_bh->b_data;
-
-	/* check the validity of PBR */
-	if (GET16_A(p_pbr->signature) != PBR_SIGNATURE) {
+	/* check the validity of BOOT sector */
+	if (le16_to_cpu(p_boot->boot_signature) != BOOT_SIGNATURE) {
 		brelse(tmp_bh);
 		exfat_bdev_close(sb);
 		ret = -EFSCORRUPTED;
@@ -390,7 +388,7 @@ static int ffsMountVol(struct super_block *sb)
 
 	/* fill fs_struct */
 	for (i = 0; i < 53; i++)
-		if (p_pbr->bpb[i])
+		if (p_boot->must_be_zero[i])
 			break;
 
 	if (i < 53) {
@@ -399,7 +397,7 @@ static int ffsMountVol(struct super_block *sb)
 		pr_info("EXFAT: Attempted to mount VFAT filesystem\n");
 		goto out;
 	} else {
-		ret = exfat_mount(sb, p_pbr);
+		ret = exfat_mount(sb, p_boot);
 	}
 
 	brelse(tmp_bh);
-- 
2.25.1

