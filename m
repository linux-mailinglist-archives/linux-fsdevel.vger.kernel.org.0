Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C31E7A44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgE2KPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2KPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:15:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E878C03E969;
        Fri, 29 May 2020 03:15:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so1238450pgn.5;
        Fri, 29 May 2020 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05zY2bLWBHviW/2VYEGgkUv7VUYcbDzkmzQsI45oyY8=;
        b=sa4ei5RTfr9fGyUeQIvRfYW6yNACF/1kk5zVJUjMXT3AGYXZm7KZgo0x+DZPWru6DL
         /bnjkPQpg3AL12h9I5UoYwlH8PDM3Fu1O15qJKg7B0iyRqUUQO1DyetocesEqfdMr0uS
         BlNDy1oXhC/TzkPWOevj6322GNNMfmp7AYqpEfuCiSP+yDe4dtVjhgY+1fMyzj8+MXD3
         NwXHyJxBiMq5Q2nGiw/nzrxj04fdJnLt5oHEDcaxP4vJZ7RjOBPbzB0rNbD8stgCqq46
         D4IstDcyBe7hJew+4ofBaIq53zzQ/FqXVbWAOZB92PWMXUwAM9saK4nWWvlt/DNq6L6P
         P1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05zY2bLWBHviW/2VYEGgkUv7VUYcbDzkmzQsI45oyY8=;
        b=sNqQgv/aniA4RCqnQvd7tMZ326bqwhUYZeLmuu9ozU8+xUmI4LwaOSgnPGkOA1D5fR
         B+jQXfUsK+9YRRx3OGNy0noEUan/jEwUGMb23JcLTkUQQXM5vmfl8k+wwlA6rSdh3wyD
         PTCwdfqwV3xOWd1dIOk0JHY6WH+FXDcb+Z9IBAZ6ZSHAKxetwpdBmJJvRz2AmER/hc+I
         8YgcfemcS1iIqnbBUWLW7P7vERfQH5XGvykBxsYw/G1t2vQkUO5rzy3OOdCfyTloih9C
         hyfAG8WlvhyQxcVVvsAXUe3FgxBanx8KJFy2SVS0dIGRCQpfyMdrYVtRRAFsE99+Gnpn
         Betw==
X-Gm-Message-State: AOAM533rqvoWjadlRnaOzMB0zI5M0AfKe7sSBnSrs1mxusW5poRa3now
        nWlm/nZGOefqPLXApgfQbdc=
X-Google-Smtp-Source: ABdhPJxosPI4G/cLM8XuW1mmH+fOe2QJPi5xBLrW1NO9FNBy5AZ4zduOIDKh1WAcQuuDmUafoLFljg==
X-Received: by 2002:a63:c311:: with SMTP id c17mr7710085pgd.103.1590747347986;
        Fri, 29 May 2020 03:15:47 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:3c0d:7bea:2bcd:e53b])
        by smtp.gmail.com with ESMTPSA id u4sm10839260pjf.3.2020.05.29.03.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:15:47 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4 v3] exfat: separate the boot sector analysis
Date:   Fri, 29 May 2020 19:14:57 +0900
Message-Id: <20200529101459.8546-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529101459.8546-1-kohada.t2@gmail.com>
References: <20200529101459.8546-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Separate the boot sector analysis to read_boot_sector().
And add a check for the fs_name field.
Furthermore, add a strict consistency check, because overlapping areas
can cause serious corruption.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - rebase with patch 'optimize dir-cache' applied
Changes in v3:
 - add a check for the fs_name field

 fs/exfat/exfat_raw.h |  2 +
 fs/exfat/super.c     | 97 ++++++++++++++++++++++++--------------------
 2 files changed, 56 insertions(+), 43 deletions(-)

diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 07f74190df44..350ce59cc324 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -10,11 +10,13 @@
 
 #define BOOT_SIGNATURE		0xAA55
 #define EXBOOT_SIGNATURE	0xAA550000
+#define STR_EXFAT		"EXFAT   "	/* size should be 8 */
 
 #define EXFAT_MAX_FILE_LEN	255
 
 #define VOL_CLEAN		0x0000
 #define VOL_DIRTY		0x0002
+#define ERR_MEDIUM		0x0004
 
 #define EXFAT_EOF_CLUSTER	0xFFFFFFFFu
 #define EXFAT_BAD_CLUSTER	0xFFFFFFF7u
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e60d28e73ff0..6a1330be5a9a 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -366,25 +366,20 @@ static int exfat_read_root(struct inode *inode)
 	return 0;
 }
 
-static struct boot_sector *exfat_read_boot_with_logical_sector(
-		struct super_block *sb)
+static int exfat_calibrate_blocksize(struct super_block *sb, int logical_sect)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
-	unsigned short logical_sect = 0;
-
-	logical_sect = 1 << p_boot->sect_size_bits;
 
 	if (!is_power_of_2(logical_sect) ||
 	    logical_sect < 512 || logical_sect > 4096) {
 		exfat_err(sb, "bogus logical sector size %u", logical_sect);
-		return NULL;
+		return -EIO;
 	}
 
 	if (logical_sect < sb->s_blocksize) {
 		exfat_err(sb, "logical sector size too small for device (logical sector size = %u)",
 			  logical_sect);
-		return NULL;
+		return -EIO;
 	}
 
 	if (logical_sect > sb->s_blocksize) {
@@ -394,24 +389,20 @@ static struct boot_sector *exfat_read_boot_with_logical_sector(
 		if (!sb_set_blocksize(sb, logical_sect)) {
 			exfat_err(sb, "unable to set blocksize %u",
 				  logical_sect);
-			return NULL;
+			return -EIO;
 		}
 		sbi->boot_bh = sb_bread(sb, 0);
 		if (!sbi->boot_bh) {
 			exfat_err(sb, "unable to read boot sector (logical sector size = %lu)",
 				  sb->s_blocksize);
-			return NULL;
+			return -EIO;
 		}
-
-		p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
 	}
-	return p_boot;
+	return 0;
 }
 
-/* mount the file system volume */
-static int __exfat_fill_super(struct super_block *sb)
+static int exfat_read_boot_sector(struct super_block *sb)
 {
-	int ret;
 	struct boot_sector *p_boot;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
@@ -424,51 +415,41 @@ static int __exfat_fill_super(struct super_block *sb)
 		exfat_err(sb, "unable to read boot sector");
 		return -EIO;
 	}
-
-	/* PRB is read */
 	p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
 
 	/* check the validity of BOOT */
 	if (le16_to_cpu((p_boot->signature)) != BOOT_SIGNATURE) {
 		exfat_err(sb, "invalid boot record signature");
-		ret = -EINVAL;
-		goto free_bh;
+		return -EINVAL;
 	}
 
-
-	/* check logical sector size */
-	p_boot = exfat_read_boot_with_logical_sector(sb);
-	if (!p_boot) {
-		ret = -EIO;
-		goto free_bh;
+	if (memcmp(p_boot->fs_name, STR_EXFAT, BOOTSEC_FS_NAME_LEN)) {
+		exfat_err(sb, "invalid fs_name"); /* fs_name may unprintable */
+		return -EINVAL;
 	}
 
 	/*
-	 * res_zero field must be filled with zero to prevent mounting
+	 * must_be_zero field must be filled with zero to prevent mounting
 	 * from FAT volume.
 	 */
-	if (memchr_inv(p_boot->must_be_zero, 0,
-			sizeof(p_boot->must_be_zero))) {
-		ret = -EINVAL;
-		goto free_bh;
-	}
+	if (memchr_inv(p_boot->must_be_zero, 0, sizeof(p_boot->must_be_zero)))
+		return -EINVAL;
 
-	p_boot = (struct boot_sector *)p_boot;
-	if (!p_boot->num_fats) {
+	if (p_boot->num_fats != 1 && p_boot->num_fats != 2) {
 		exfat_err(sb, "bogus number of FAT structure");
-		ret = -EINVAL;
-		goto free_bh;
+		return -EINVAL;
 	}
 
 	sbi->sect_per_clus = 1 << p_boot->sect_per_clus_bits;
 	sbi->sect_per_clus_bits = p_boot->sect_per_clus_bits;
-	sbi->cluster_size_bits = sbi->sect_per_clus_bits + sb->s_blocksize_bits;
+	sbi->cluster_size_bits = p_boot->sect_per_clus_bits +
+		p_boot->sect_size_bits;
 	sbi->cluster_size = 1 << sbi->cluster_size_bits;
 	sbi->num_FAT_sectors = le32_to_cpu(p_boot->fat_length);
 	sbi->FAT1_start_sector = le32_to_cpu(p_boot->fat_offset);
-	sbi->FAT2_start_sector = p_boot->num_fats == 1 ?
-		sbi->FAT1_start_sector :
-			sbi->FAT1_start_sector + sbi->num_FAT_sectors;
+	sbi->FAT2_start_sector = le32_to_cpu(p_boot->fat_offset);
+	if (p_boot->num_fats == 2)
+		sbi->FAT2_start_sector += sbi->num_FAT_sectors;
 	sbi->data_start_sector = le32_to_cpu(p_boot->clu_offset);
 	sbi->num_sectors = le64_to_cpu(p_boot->vol_length);
 	/* because the cluster index starts with 2 */
@@ -483,15 +464,45 @@ static int __exfat_fill_super(struct super_block *sb)
 	sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
 	sbi->used_clusters = EXFAT_CLUSTERS_UNTRACKED;
 
-	if (le16_to_cpu(p_boot->vol_flags) & VOL_DIRTY) {
-		sbi->vol_flag |= VOL_DIRTY;
-		exfat_warn(sb, "Volume was not properly unmounted. Some data may be corrupt. Please run fsck.");
+	/* check consistencies */
+	if (sbi->num_FAT_sectors << p_boot->sect_size_bits <
+	    sbi->num_clusters * 4) {
+		exfat_err(sb, "bogus fat length");
+		return -EINVAL;
+	}
+	if (sbi->data_start_sector <
+	    sbi->FAT1_start_sector + sbi->num_FAT_sectors * p_boot->num_fats) {
+		exfat_err(sb, "bogus data start sector");
+		return -EINVAL;
 	}
+	if (sbi->vol_flag & VOL_DIRTY)
+		exfat_warn(sb, "Volume was not properly unmounted. Some data may be corrupt. Please run fsck.");
+	if (sbi->vol_flag & ERR_MEDIUM)
+		exfat_warn(sb, "Medium has reported failures. Some data may be lost.");
 
 	/* exFAT file size is limited by a disk volume size */
 	sb->s_maxbytes = (u64)(sbi->num_clusters - EXFAT_RESERVED_CLUSTERS) <<
 		sbi->cluster_size_bits;
 
+	/* check logical sector size */
+	if (exfat_calibrate_blocksize(sb, 1 << p_boot->sect_size_bits))
+		return -EIO;
+
+	return 0;
+}
+
+/* mount the file system volume */
+static int __exfat_fill_super(struct super_block *sb)
+{
+	int ret;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	ret = exfat_read_boot_sector(sb);
+	if (ret) {
+		exfat_err(sb, "failed to read boot sector");
+		goto free_bh;
+	}
+
 	ret = exfat_create_upcase_table(sb);
 	if (ret) {
 		exfat_err(sb, "failed to load upcase table");
-- 
2.25.1

