Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8481E5BA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 11:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgE1JQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 05:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgE1JQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 05:16:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135B5C05BD1E;
        Thu, 28 May 2020 02:16:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 131so4894638pfv.13;
        Thu, 28 May 2020 02:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yu4RgcWIOOp8McPfFqo6P0ubfGT/mtUPREpMqIZc7D0=;
        b=s7mwzhwR1bpY5etg88nOLosVGoJJPXPbq63qTDPR4NTZl8IkMR/yV4AE0m809Awqm+
         FZ/7q3NPiCIurY6SvLSOwO50lhnij1nIDZPrU7dGYQBNWkJoeHT5jEurXeCt7w6tOT1k
         y7MX9+HvvnMhfy84ybfg2DcGz3p3aQQurqo+9bo5jh9eiiUyGU9Y+BavXloxAn1VtlSA
         1ud1g2ugsstYpyb7wcpALlQYL7+NfuZJ69UwozJphLMalerYW2GP35lL11+g0+1X0X1V
         EotyyaCaTThxpgxCcuVqhaFT/0lvLrUw7UzqEu1o+bDIFpjb0yskCSRJDnpSPjJ72Njc
         fyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yu4RgcWIOOp8McPfFqo6P0ubfGT/mtUPREpMqIZc7D0=;
        b=ab1wUb468mpBRJoUe1shWq8YIocU+Tp8LfOppv2DeM1fz1gk3gBGj3V7GOqdKnx/VA
         oiziEWmUzEbRfkuFzUtTmw8o3nPhx+NnWSL8B5zwf80qHHo/BKm0bjveec9+WozbNJ7G
         zw+jqeeZwams9vR81ZK/tGO/HkoJo8IwJtGCY/hOJgKQHQS4mx7ObA6Pl5gCpcHWD5ly
         T+BU50exbYe6rO0wT10c41rNWf+Bkh/ApI8xlMzMu3y70A2yf0rQcSsUW0jg56mV5eP+
         dIMGTslhlEMZ1jbZTYQGqNo2cwS9nUYnkzd8pD3yN60y3MdjZ8o6z4Va6yxPsuotl4Lu
         OkjA==
X-Gm-Message-State: AOAM533HsTCqGLDvClrjlhGbp38nFkI8H0RCL0/AZfFHq/lJ9gHSMGV7
        lT8QSnd+KWqZVwWStLZnmpY=
X-Google-Smtp-Source: ABdhPJwN9gmVbQzj+ryKFUUOQkzdNBiHHJ2xWKwbJE5aikshPEjsLjKwTVCg0vsJPW1u6pkHDgt7ow==
X-Received: by 2002:a63:b606:: with SMTP id j6mr2076035pgf.334.1590657408592;
        Thu, 28 May 2020 02:16:48 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:295a:ef64:e071:39ab])
        by smtp.gmail.com with ESMTPSA id d15sm5856185pjc.0.2020.05.28.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 02:16:48 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4 v2] exfat: separate the boot sector analysis
Date:   Thu, 28 May 2020 18:16:02 +0900
Message-Id: <20200528091605.13016-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528091605.13016-1-kohada.t2@gmail.com>
References: <20200528091605.13016-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Separate the boot sector analysis to read_boot_sector().
Furthermore, add a strict consistency check, because overlapping areas
can cause serious corruption.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - rebase with patch 'optimize dir-cache' applied

 fs/exfat/exfat_raw.h |  1 +
 fs/exfat/super.c     | 96 +++++++++++++++++++++++---------------------
 2 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index b373dc4e099f..65f884785192 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -15,6 +15,7 @@
 
 #define VOL_CLEAN		0x0000
 #define VOL_DIRTY		0x0002
+#define ERR_MEDIUM		0x0004
 
 #define EXFAT_EOF_CLUSTER	0xFFFFFFFFu
 #define EXFAT_BAD_CLUSTER	0xFFFFFFF7u
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e60d28e73ff0..95909b4d5e75 100644
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
 
@@ -424,51 +415,36 @@ static int __exfat_fill_super(struct super_block *sb)
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
-	}
-
-
-	/* check logical sector size */
-	p_boot = exfat_read_boot_with_logical_sector(sb);
-	if (!p_boot) {
-		ret = -EIO;
-		goto free_bh;
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
@@ -483,15 +459,45 @@ static int __exfat_fill_super(struct super_block *sb)
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

