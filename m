Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8247C1E7A41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgE2KPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2KPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:15:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3EC03E969;
        Fri, 29 May 2020 03:15:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cx22so1078566pjb.1;
        Fri, 29 May 2020 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9mXH7jGoi+PijDuGicg3w5YkkYoolZZKAt0TntrvrI=;
        b=CuKwdwamyCm7TziILq733yIqDKSBZ/AyUWRYU22h+aZVaAvowVCwmEHV0FPYFxAJkz
         qfxMhHDoS4zHnx1AyfGZyob1otWN1ViW3gow/BxRKsFRJ7ttob83vPlqu5eNC82rbgsg
         ta3vBW/ccnEWIfSibftanL5BnDRTmMRhiJiDIhf5E/9u41nqnAZnO1v2I3GQ3FwFNhhd
         XKJQghyeqGPlFQl743nM/z8bQj5wHjPP6EU4v4KNnKA1VT6cqx2hm2XGdf5t/ZIp0PQn
         CtUjkDMnwiFxd5vyUcaW5xp2/XKp2n7pBTkztYN+16Hb1sf+0KlMQVZEgKBbmZH9v5+M
         RyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9mXH7jGoi+PijDuGicg3w5YkkYoolZZKAt0TntrvrI=;
        b=lIPKvp+21b238hZNVlFZ4UD10mzrlW5TwpXgPJ5VUNz1Iyy8kzYjErZ6OBYw3nGumU
         GveNVlr6e5uNPWvQilP8ffopa+JENBe34Z3RqUn85oVmLyQq8xBk6g7NZdBxRfmRfqCf
         inMMINP2unkxywiktbIQLYtvKgmZrUHDjN/wbJGsdZdv5JIu5wmypvPT8pQYVV7xZc27
         sevYcEoenunMwVZ1C7sWgSUplsh0AsOUA5pLeYKDvviw9JjDsybnJuxRuqIJKiBMfEye
         BnSJ8XiJobpQpPZVB5piylfzYiFISQkTnJvkMC3poO5z6KKBmWzAvkYTwcSL3hLAOF1N
         xjsg==
X-Gm-Message-State: AOAM53296BWn/A82/N3kEfJr4wLpbK4j4fg9IPgdCCPvqinswfrEL3xz
        CjzbwkoegRAc0FywYkfxz+4=
X-Google-Smtp-Source: ABdhPJw+Vy5dKbC3FL9DJMi02yay9XMXkCN8GfxZN3enp1K/ImeGatgITr8p8tMB41dmwvHt4hWzMw==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr8409539ply.122.1590747321439;
        Fri, 29 May 2020 03:15:21 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:3c0d:7bea:2bcd:e53b])
        by smtp.gmail.com with ESMTPSA id u4sm10839260pjf.3.2020.05.29.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:15:19 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4 v3] exfat: redefine PBR as boot_sector
Date:   Fri, 29 May 2020 19:14:56 +0900
Message-Id: <20200529101459.8546-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Aggregate PBR related definitions and redefine as "boot_sector" to comply
with the exFAT specification.
And, rename variable names including 'pbr'.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - rebase with patch 'optimize dir-cache' applied
Changes in v3:
 - rename BOOTSEC_OEM_NAME_LEN to BOOTSEC_FS_NAME_LEN
 - rename oem_name to fs_name in struct boot_sector

 fs/exfat/exfat_fs.h  |  2 +-
 fs/exfat/exfat_raw.h | 79 +++++++++++++++--------------------------
 fs/exfat/super.c     | 84 ++++++++++++++++++++++----------------------
 3 files changed, 72 insertions(+), 93 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 5caad1380818..9673e2d31045 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -227,7 +227,7 @@ struct exfat_sb_info {
 	unsigned int root_dir; /* root dir cluster */
 	unsigned int dentries_per_clu; /* num of dentries per cluster */
 	unsigned int vol_flag; /* volume dirty flag */
-	struct buffer_head *pbr_bh; /* buffer_head of PBR sector */
+	struct buffer_head *boot_bh; /* buffer_head of BOOT sector */
 
 	unsigned int map_clu; /* allocation bitmap start cluster */
 	unsigned int map_sectors; /* num of allocation bitmap sectors */
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 8d6c64a7546d..07f74190df44 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -8,7 +8,8 @@
 
 #include <linux/types.h>
 
-#define PBR_SIGNATURE		0xAA55
+#define BOOT_SIGNATURE		0xAA55
+#define EXBOOT_SIGNATURE	0xAA550000
 
 #define EXFAT_MAX_FILE_LEN	255
 
@@ -55,7 +56,7 @@
 
 /* checksum types */
 #define CS_DIR_ENTRY		0
-#define CS_PBR_SECTOR		1
+#define CS_BOOT_SECTOR		1
 #define CS_DEFAULT		2
 
 /* file attributes */
@@ -69,57 +70,35 @@
 #define ATTR_RWMASK		(ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME | \
 				 ATTR_SUBDIR | ATTR_ARCHIVE)
 
-#define PBR64_JUMP_BOOT_LEN		3
-#define PBR64_OEM_NAME_LEN		8
-#define PBR64_RESERVED_LEN		53
+#define BOOTSEC_JUMP_BOOT_LEN		3
+#define BOOTSEC_FS_NAME_LEN		8
+#define BOOTSEC_OLDBPB_LEN		53
 
 #define EXFAT_FILE_NAME_LEN		15
 
-/* EXFAT BIOS parameter block (64 bytes) */
-struct bpb64 {
-	__u8 jmp_boot[PBR64_JUMP_BOOT_LEN];
-	__u8 oem_name[PBR64_OEM_NAME_LEN];
-	__u8 res_zero[PBR64_RESERVED_LEN];
-} __packed;
-
-/* EXFAT EXTEND BIOS parameter block (56 bytes) */
-struct bsx64 {
-	__le64 vol_offset;
-	__le64 vol_length;
-	__le32 fat_offset;
-	__le32 fat_length;
-	__le32 clu_offset;
-	__le32 clu_count;
-	__le32 root_cluster;
-	__le32 vol_serial;
-	__u8 fs_version[2];
-	__le16 vol_flags;
-	__u8 sect_size_bits;
-	__u8 sect_per_clus_bits;
-	__u8 num_fats;
-	__u8 phy_drv_no;
-	__u8 perc_in_use;
-	__u8 reserved2[7];
-} __packed;
-
-/* EXFAT PBR[BPB+BSX] (120 bytes) */
-struct pbr64 {
-	struct bpb64 bpb;
-	struct bsx64 bsx;
-} __packed;
-
-/* Common PBR[Partition Boot Record] (512 bytes) */
-struct pbr {
-	union {
-		__u8 raw[64];
-		struct bpb64 f64;
-	} bpb;
-	union {
-		__u8 raw[56];
-		struct bsx64 f64;
-	} bsx;
-	__u8 boot_code[390];
-	__le16 signature;
+/* EXFAT: Main and Backup Boot Sector (512 bytes) */
+struct boot_sector {
+	__u8	jmp_boot[BOOTSEC_JUMP_BOOT_LEN];
+	__u8	fs_name[BOOTSEC_FS_NAME_LEN];
+	__u8	must_be_zero[BOOTSEC_OLDBPB_LEN];
+	__le64	partition_offset;
+	__le64	vol_length;
+	__le32	fat_offset;
+	__le32	fat_length;
+	__le32	clu_offset;
+	__le32	clu_count;
+	__le32	root_cluster;
+	__le32	vol_serial;
+	__u8	fs_revision[2];
+	__le16	vol_flags;
+	__u8	sect_size_bits;
+	__u8	sect_per_clus_bits;
+	__u8	num_fats;
+	__u8	drv_sel;
+	__u8	percent_in_use;
+	__u8	reserved[7];
+	__u8	boot_code[390];
+	__le16	signature;
 } __packed;
 
 struct exfat_dentry {
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index c1f47f4071a8..e60d28e73ff0 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -49,7 +49,7 @@ static void exfat_put_super(struct super_block *sb)
 		sync_blockdev(sb->s_bdev);
 	exfat_set_vol_flags(sb, VOL_CLEAN);
 	exfat_free_bitmap(sbi);
-	brelse(sbi->pbr_bh);
+	brelse(sbi->boot_bh);
 	mutex_unlock(&sbi->s_lock);
 
 	call_rcu(&sbi->rcu, exfat_delayed_free);
@@ -101,7 +101,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct pbr64 *bpb = (struct pbr64 *)sbi->pbr_bh->b_data;
+	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
 	bool sync;
 
 	/* flags are not changed */
@@ -116,18 +116,18 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 	if (sb_rdonly(sb))
 		return 0;
 
-	bpb->bsx.vol_flags = cpu_to_le16(new_flag);
+	p_boot->vol_flags = cpu_to_le16(new_flag);
 
-	if (new_flag == VOL_DIRTY && !buffer_dirty(sbi->pbr_bh))
+	if (new_flag == VOL_DIRTY && !buffer_dirty(sbi->boot_bh))
 		sync = true;
 	else
 		sync = false;
 
-	set_buffer_uptodate(sbi->pbr_bh);
-	mark_buffer_dirty(sbi->pbr_bh);
+	set_buffer_uptodate(sbi->boot_bh);
+	mark_buffer_dirty(sbi->boot_bh);
 
 	if (sync)
-		sync_dirty_buffer(sbi->pbr_bh);
+		sync_dirty_buffer(sbi->boot_bh);
 	return 0;
 }
 
@@ -366,13 +366,14 @@ static int exfat_read_root(struct inode *inode)
 	return 0;
 }
 
-static struct pbr *exfat_read_pbr_with_logical_sector(struct super_block *sb)
+static struct boot_sector *exfat_read_boot_with_logical_sector(
+		struct super_block *sb)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct pbr *p_pbr = (struct pbr *) (sbi->pbr_bh)->b_data;
+	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
 	unsigned short logical_sect = 0;
 
-	logical_sect = 1 << p_pbr->bsx.f64.sect_size_bits;
+	logical_sect = 1 << p_boot->sect_size_bits;
 
 	if (!is_power_of_2(logical_sect) ||
 	    logical_sect < 512 || logical_sect > 4096) {
@@ -387,49 +388,48 @@ static struct pbr *exfat_read_pbr_with_logical_sector(struct super_block *sb)
 	}
 
 	if (logical_sect > sb->s_blocksize) {
-		brelse(sbi->pbr_bh);
-		sbi->pbr_bh = NULL;
+		brelse(sbi->boot_bh);
+		sbi->boot_bh = NULL;
 
 		if (!sb_set_blocksize(sb, logical_sect)) {
 			exfat_err(sb, "unable to set blocksize %u",
 				  logical_sect);
 			return NULL;
 		}
-		sbi->pbr_bh = sb_bread(sb, 0);
-		if (!sbi->pbr_bh) {
+		sbi->boot_bh = sb_bread(sb, 0);
+		if (!sbi->boot_bh) {
 			exfat_err(sb, "unable to read boot sector (logical sector size = %lu)",
 				  sb->s_blocksize);
 			return NULL;
 		}
 
-		p_pbr = (struct pbr *)sbi->pbr_bh->b_data;
+		p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
 	}
-	return p_pbr;
+	return p_boot;
 }
 
 /* mount the file system volume */
 static int __exfat_fill_super(struct super_block *sb)
 {
 	int ret;
-	struct pbr *p_pbr;
-	struct pbr64 *p_bpb;
+	struct boot_sector *p_boot;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	/* set block size to read super block */
 	sb_min_blocksize(sb, 512);
 
 	/* read boot sector */
-	sbi->pbr_bh = sb_bread(sb, 0);
-	if (!sbi->pbr_bh) {
+	sbi->boot_bh = sb_bread(sb, 0);
+	if (!sbi->boot_bh) {
 		exfat_err(sb, "unable to read boot sector");
 		return -EIO;
 	}
 
 	/* PRB is read */
-	p_pbr = (struct pbr *)sbi->pbr_bh->b_data;
+	p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
 
-	/* check the validity of PBR */
-	if (le16_to_cpu((p_pbr->signature)) != PBR_SIGNATURE) {
+	/* check the validity of BOOT */
+	if (le16_to_cpu((p_boot->signature)) != BOOT_SIGNATURE) {
 		exfat_err(sb, "invalid boot record signature");
 		ret = -EINVAL;
 		goto free_bh;
@@ -437,8 +437,8 @@ static int __exfat_fill_super(struct super_block *sb)
 
 
 	/* check logical sector size */
-	p_pbr = exfat_read_pbr_with_logical_sector(sb);
-	if (!p_pbr) {
+	p_boot = exfat_read_boot_with_logical_sector(sb);
+	if (!p_boot) {
 		ret = -EIO;
 		goto free_bh;
 	}
@@ -447,43 +447,43 @@ static int __exfat_fill_super(struct super_block *sb)
 	 * res_zero field must be filled with zero to prevent mounting
 	 * from FAT volume.
 	 */
-	if (memchr_inv(p_pbr->bpb.f64.res_zero, 0,
-			sizeof(p_pbr->bpb.f64.res_zero))) {
+	if (memchr_inv(p_boot->must_be_zero, 0,
+			sizeof(p_boot->must_be_zero))) {
 		ret = -EINVAL;
 		goto free_bh;
 	}
 
-	p_bpb = (struct pbr64 *)p_pbr;
-	if (!p_bpb->bsx.num_fats) {
+	p_boot = (struct boot_sector *)p_boot;
+	if (!p_boot->num_fats) {
 		exfat_err(sb, "bogus number of FAT structure");
 		ret = -EINVAL;
 		goto free_bh;
 	}
 
-	sbi->sect_per_clus = 1 << p_bpb->bsx.sect_per_clus_bits;
-	sbi->sect_per_clus_bits = p_bpb->bsx.sect_per_clus_bits;
+	sbi->sect_per_clus = 1 << p_boot->sect_per_clus_bits;
+	sbi->sect_per_clus_bits = p_boot->sect_per_clus_bits;
 	sbi->cluster_size_bits = sbi->sect_per_clus_bits + sb->s_blocksize_bits;
 	sbi->cluster_size = 1 << sbi->cluster_size_bits;
-	sbi->num_FAT_sectors = le32_to_cpu(p_bpb->bsx.fat_length);
-	sbi->FAT1_start_sector = le32_to_cpu(p_bpb->bsx.fat_offset);
-	sbi->FAT2_start_sector = p_bpb->bsx.num_fats == 1 ?
+	sbi->num_FAT_sectors = le32_to_cpu(p_boot->fat_length);
+	sbi->FAT1_start_sector = le32_to_cpu(p_boot->fat_offset);
+	sbi->FAT2_start_sector = p_boot->num_fats == 1 ?
 		sbi->FAT1_start_sector :
 			sbi->FAT1_start_sector + sbi->num_FAT_sectors;
-	sbi->data_start_sector = le32_to_cpu(p_bpb->bsx.clu_offset);
-	sbi->num_sectors = le64_to_cpu(p_bpb->bsx.vol_length);
+	sbi->data_start_sector = le32_to_cpu(p_boot->clu_offset);
+	sbi->num_sectors = le64_to_cpu(p_boot->vol_length);
 	/* because the cluster index starts with 2 */
-	sbi->num_clusters = le32_to_cpu(p_bpb->bsx.clu_count) +
+	sbi->num_clusters = le32_to_cpu(p_boot->clu_count) +
 		EXFAT_RESERVED_CLUSTERS;
 
-	sbi->root_dir = le32_to_cpu(p_bpb->bsx.root_cluster);
+	sbi->root_dir = le32_to_cpu(p_boot->root_cluster);
 	sbi->dentries_per_clu = 1 <<
 		(sbi->cluster_size_bits - DENTRY_SIZE_BITS);
 
-	sbi->vol_flag = le16_to_cpu(p_bpb->bsx.vol_flags);
+	sbi->vol_flag = le16_to_cpu(p_boot->vol_flags);
 	sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
 	sbi->used_clusters = EXFAT_CLUSTERS_UNTRACKED;
 
-	if (le16_to_cpu(p_bpb->bsx.vol_flags) & VOL_DIRTY) {
+	if (le16_to_cpu(p_boot->vol_flags) & VOL_DIRTY) {
 		sbi->vol_flag |= VOL_DIRTY;
 		exfat_warn(sb, "Volume was not properly unmounted. Some data may be corrupt. Please run fsck.");
 	}
@@ -517,7 +517,7 @@ static int __exfat_fill_super(struct super_block *sb)
 free_upcase_table:
 	exfat_free_upcase_table(sbi);
 free_bh:
-	brelse(sbi->pbr_bh);
+	brelse(sbi->boot_bh);
 	return ret;
 }
 
@@ -608,7 +608,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 free_table:
 	exfat_free_upcase_table(sbi);
 	exfat_free_bitmap(sbi);
-	brelse(sbi->pbr_bh);
+	brelse(sbi->boot_bh);
 
 check_nls_io:
 	unload_nls(sbi->nls_io);
-- 
2.25.1

