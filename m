Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB3E1195
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 07:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbfJWF22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 01:28:28 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44828 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389237AbfJWF22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:28:28 -0400
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9N5SRUZ019982
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:27 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9N5SMI8021384
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:27 -0400
Received: by mail-qt1-f200.google.com with SMTP id h20so20088292qto.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 22:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MqAbiLur5D+uHRypbIqnaB77RhB+Sc+h3HCzI8vBmBo=;
        b=bOLsbptARZ57KO6Zc2kUmOaauu00Pvxcaf0NJcDY/QH2ktwV3YxCNpPNNThASeBYmL
         e81x60ahztFTYCSRQWKp4jBih5AgTAjWfzYt2UIE30ccxqHWYN4k8nHwOgmI96/Gbt67
         Vzl9c3MDTLJd0Cg6Nvs2KLjxkC6uwhMg+wo0G4DSnvHVH2bKF+l2VlxVZAD2LGpD9Z6g
         fI7v5BfeYvJSeiEHOnZHYvHnQx1k3UBkCDS0hZBp2+w3yQLnZkybfQpykYZsrg7I2zQa
         NgNZBrHbzt6zRjT+TsHUdLCfjx+rsgGZC7CZ8BYh+z5v3PVYghumHboEDsCbtLPg7S//
         OWLQ==
X-Gm-Message-State: APjAAAWWT8LEp2+gfiQGRDuoumuq/ttcRX6zYYRTsO1LczyAe/WOxm1v
        ArY7cvUgV44T5kFmjAWXTu7ePx94ONEXSy23tVRCqmsD1zAM0IfFAcC6XmuuLFLLBRPz47CVGsd
        QY/pQ2Yb/lZuB0h26Uas9FKp0MJlCj8irG+dk
X-Received: by 2002:ac8:4656:: with SMTP id f22mr7280164qto.154.1571808501485;
        Tue, 22 Oct 2019 22:28:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZvkG+dshyYHrPEOmZevnuiQhqYv0WRghnxRFA7+eghHmtEmvEoAeToM1QjGH3Vgj+KQqdng==
X-Received: by 2002:ac8:4656:: with SMTP id f22mr7280145qto.154.1571808501087;
        Tue, 22 Oct 2019 22:28:21 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 14sm10397445qtb.54.2019.10.22.22.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 22:28:19 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valdis.Kletnieks@vt.edu
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: exfat: Remove FAT/VFAT mount support, part 1
Date:   Wed, 23 Oct 2019 01:27:45 -0400
Message-Id: <20191023052752.693689-3-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
References: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the top-level mount functionality, to make this driver handle
only exfat file systems.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/Kconfig       |   9 --
 drivers/staging/exfat/exfat.h       |   2 -
 drivers/staging/exfat/exfat_core.c  | 142 ----------------------------
 drivers/staging/exfat/exfat_super.c |   8 +-
 4 files changed, 1 insertion(+), 160 deletions(-)

diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
index ce32dfe33bec..0130019cbec2 100644
--- a/drivers/staging/exfat/Kconfig
+++ b/drivers/staging/exfat/Kconfig
@@ -6,15 +6,6 @@ config EXFAT_FS
 	help
 	  This adds support for the exFAT file system.
 
-config EXFAT_DONT_MOUNT_VFAT
-	bool "Prohibit mounting of fat/vfat filesystems by exFAT"
-	depends on EXFAT_FS
-	default y
-	help
-	  By default, the exFAT driver will only mount exFAT filesystems, and refuse
-	  to mount fat/vfat filesystems.  Set this to 'n' to allow the exFAT driver
-	  to mount these filesystems.
-
 config EXFAT_DISCARD
 	bool "enable discard support"
 	depends on EXFAT_FS
diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 0c779c8dd858..c2db3e9e9785 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -935,8 +935,6 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 static s32 resolve_name(u8 *name, u8 **arg);
 
 /* file operation functions */
-static s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
-static s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
 s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
 s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	       struct uni_name_t *p_uniname, struct file_id_t *fid);
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 0260e4fe3762..fd481b21f8b6 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2980,148 +2980,6 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 /*
  *  File Operation Functions
  */
-static struct fs_func fat_fs_func = {
-	.alloc_cluster = fat_alloc_cluster,
-	.free_cluster = fat_free_cluster,
-	.count_used_clusters = fat_count_used_clusters,
-
-	.init_dir_entry = fat_init_dir_entry,
-	.init_ext_entry = fat_init_ext_entry,
-	.find_dir_entry = fat_find_dir_entry,
-	.delete_dir_entry = fat_delete_dir_entry,
-	.get_uni_name_from_ext_entry = fat_get_uni_name_from_ext_entry,
-	.count_ext_entries = fat_count_ext_entries,
-	.calc_num_entries = fat_calc_num_entries,
-
-	.get_entry_type = fat_get_entry_type,
-	.set_entry_type = fat_set_entry_type,
-	.get_entry_attr = fat_get_entry_attr,
-	.set_entry_attr = fat_set_entry_attr,
-	.get_entry_flag = fat_get_entry_flag,
-	.set_entry_flag = fat_set_entry_flag,
-	.get_entry_clu0 = fat_get_entry_clu0,
-	.set_entry_clu0 = fat_set_entry_clu0,
-	.get_entry_size = fat_get_entry_size,
-	.set_entry_size = fat_set_entry_size,
-	.get_entry_time = fat_get_entry_time,
-	.set_entry_time = fat_set_entry_time,
-};
-
-static s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
-{
-	s32 num_reserved, num_root_sectors;
-	struct bpb16_t *p_bpb = (struct bpb16_t *)p_pbr->bpb;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-
-	if (p_bpb->num_fats == 0)
-		return FFS_FORMATERR;
-
-	num_root_sectors = GET16(p_bpb->num_root_entries) << DENTRY_SIZE_BITS;
-	num_root_sectors = ((num_root_sectors - 1) >>
-			    p_bd->sector_size_bits) + 1;
-
-	p_fs->sectors_per_clu = p_bpb->sectors_per_clu;
-	p_fs->sectors_per_clu_bits = ilog2(p_bpb->sectors_per_clu);
-	p_fs->cluster_size_bits = p_fs->sectors_per_clu_bits +
-				  p_bd->sector_size_bits;
-	p_fs->cluster_size = 1 << p_fs->cluster_size_bits;
-
-	p_fs->num_FAT_sectors = GET16(p_bpb->num_fat_sectors);
-
-	p_fs->FAT1_start_sector = p_fs->PBR_sector + GET16(p_bpb->num_reserved);
-	if (p_bpb->num_fats == 1)
-		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector;
-	else
-		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector +
-					  p_fs->num_FAT_sectors;
-
-	p_fs->root_start_sector = p_fs->FAT2_start_sector +
-				  p_fs->num_FAT_sectors;
-	p_fs->data_start_sector = p_fs->root_start_sector + num_root_sectors;
-
-	p_fs->num_sectors = GET16(p_bpb->num_sectors);
-	if (p_fs->num_sectors == 0)
-		p_fs->num_sectors = GET32(p_bpb->num_huge_sectors);
-
-	num_reserved = p_fs->data_start_sector - p_fs->PBR_sector;
-	p_fs->num_clusters = ((p_fs->num_sectors - num_reserved) >>
-			      p_fs->sectors_per_clu_bits) + 2;
-	/* because the cluster index starts with 2 */
-
-	if (p_fs->num_clusters < FAT12_THRESHOLD)
-		p_fs->vol_type = FAT12;
-	else
-		p_fs->vol_type = FAT16;
-	p_fs->vol_id = GET32(p_bpb->vol_serial);
-
-	p_fs->root_dir = 0;
-	p_fs->dentries_in_root = GET16(p_bpb->num_root_entries);
-	p_fs->dentries_per_clu = 1 << (p_fs->cluster_size_bits -
-				       DENTRY_SIZE_BITS);
-
-	p_fs->vol_flag = VOL_CLEAN;
-	p_fs->clu_srch_ptr = 2;
-	p_fs->used_clusters = UINT_MAX;
-
-	p_fs->fs_func = &fat_fs_func;
-
-	return FFS_SUCCESS;
-}
-
-static s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
-{
-	s32 num_reserved;
-	struct bpb32_t *p_bpb = (struct bpb32_t *)p_pbr->bpb;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-
-	if (p_bpb->num_fats == 0)
-		return FFS_FORMATERR;
-
-	p_fs->sectors_per_clu = p_bpb->sectors_per_clu;
-	p_fs->sectors_per_clu_bits = ilog2(p_bpb->sectors_per_clu);
-	p_fs->cluster_size_bits = p_fs->sectors_per_clu_bits +
-				  p_bd->sector_size_bits;
-	p_fs->cluster_size = 1 << p_fs->cluster_size_bits;
-
-	p_fs->num_FAT_sectors = GET32(p_bpb->num_fat32_sectors);
-
-	p_fs->FAT1_start_sector = p_fs->PBR_sector + GET16(p_bpb->num_reserved);
-	if (p_bpb->num_fats == 1)
-		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector;
-	else
-		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector +
-					  p_fs->num_FAT_sectors;
-
-	p_fs->root_start_sector = p_fs->FAT2_start_sector +
-				  p_fs->num_FAT_sectors;
-	p_fs->data_start_sector = p_fs->root_start_sector;
-
-	p_fs->num_sectors = GET32(p_bpb->num_huge_sectors);
-	num_reserved = p_fs->data_start_sector - p_fs->PBR_sector;
-
-	p_fs->num_clusters = ((p_fs->num_sectors - num_reserved) >>
-			      p_fs->sectors_per_clu_bits) + 2;
-	/* because the cluster index starts with 2 */
-
-	p_fs->vol_type = FAT32;
-	p_fs->vol_id = GET32(p_bpb->vol_serial);
-
-	p_fs->root_dir = GET32(p_bpb->root_cluster);
-	p_fs->dentries_in_root = 0;
-	p_fs->dentries_per_clu = 1 << (p_fs->cluster_size_bits -
-				       DENTRY_SIZE_BITS);
-
-	p_fs->vol_flag = VOL_CLEAN;
-	p_fs->clu_srch_ptr = 2;
-	p_fs->used_clusters = UINT_MAX;
-
-	p_fs->fs_func = &fat_fs_func;
-
-	return FFS_SUCCESS;
-}
-
 static struct fs_func exfat_fs_func = {
 	.alloc_cluster = exfat_alloc_cluster,
 	.free_cluster = exfat_free_cluster,
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 86ace780a60b..0264be92c2be 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -394,16 +394,10 @@ static int ffsMountVol(struct super_block *sb)
 			break;
 
 	if (i < 53) {
-#ifdef CONFIG_EXFAT_DONT_MOUNT_VFAT
+		/* Not sure how we'd get here, but complain if it does */
 		ret = -EINVAL;
 		printk(KERN_INFO "EXFAT: Attempted to mount VFAT filesystem\n");
 		goto out;
-#else
-		if (GET16(p_pbr->bpb + 11)) /* num_fat_sectors */
-			ret = fat16_mount(sb, p_pbr);
-		else
-			ret = fat32_mount(sb, p_pbr);
-#endif
 	} else {
 		ret = exfat_mount(sb, p_pbr);
 	}
-- 
2.23.0

