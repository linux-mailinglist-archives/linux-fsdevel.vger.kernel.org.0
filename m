Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227811E0DC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 13:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbgEYLvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 07:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388697AbgEYLvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 07:51:13 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9797CC061A0E;
        Mon, 25 May 2020 04:51:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so7403814plq.12;
        Mon, 25 May 2020 04:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+cV+B94asZZ/7gT7USNnklXwNK87VKFcwbJZH4mw41Q=;
        b=CcPulbWUhsMWJd8cKUtnAZWfZh9/f7CReyfLbH8MwtcaTC3X5vDxUj11vNQog6a/b6
         OcTyOCEsGm9tHLRxyEXd1LCwW4tii6cKei9tBikm6owtgQ4RVLtV5Rqj9Pogm8icMx92
         q7LBIT/RPsSRwEWWuLkLVQbFWqN6IeiEJzW3FzJe0fDufJdT9ki1UQEyrXatWYFzVLd+
         EsM/HyiXBGA104/3grNN1r89OLJn4ZMB1AKNhLNdzSmcK6HK+9jr2Y4N+iLoA6/4VfXP
         +MsWDtxv1WAZRa2fgb+/4A1NYNbQf4g5bUkgnMZ1Y023PC3dAiZ1BE9697QN4TBePlB6
         mMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+cV+B94asZZ/7gT7USNnklXwNK87VKFcwbJZH4mw41Q=;
        b=BBLRBEavCqc6XA2Qb0n0Xzhbx0UTNmN2rYd1Z6xVn39X+S63zf6OrueuAFq25Kc/lw
         1eJR8WSG0ZRYPIMlvPmSdAHqPNUgXsBpWk3xuUMssNa23uoo/Ssv2hN2snOlBqtuj7AJ
         iCbZ9l7w54hw50lg1Dt+yCFsxo5jF7i/DYbf0lCopU7ceH1F8nLqprESymkWD1YUX/eC
         k2SdUYsXnFs27NH+gMb11FXqMhJAoqk1okKHfiuv6VAG4/42DG5HZCpK0dRVvTTTnrqR
         mSup3mAudGcTVzsgCFu3hoCve3+irFBSQiPhMJHNR/xvMt+GhMtw0ClOq6YFGr/Xs5rF
         /1IA==
X-Gm-Message-State: AOAM532lghFzmd10twwn25mAUOEQcLLJWTh+04HkM2LjDOXf3apF2lws
        Q9Bj0wUuhwLHzl/cKlgZUPY=
X-Google-Smtp-Source: ABdhPJyznXDdIEvvNy2XZQ+GLuctI3UJZVPyQl+Exhs3fOoLBYqz7TRxNdmlq41EUxTpWkdYzkeNnA==
X-Received: by 2002:a17:90a:2a03:: with SMTP id i3mr20245504pjd.29.1590407473115;
        Mon, 25 May 2020 04:51:13 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:b9cb:9f91:3c10:565c])
        by smtp.gmail.com with ESMTPSA id h16sm13017537pfq.56.2020.05.25.04.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 04:51:12 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] exfat: separate the boot sector analysis
Date:   Mon, 25 May 2020 20:50:49 +0900
Message-Id: <20200525115052.19243-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200525115052.19243-1-kohada.t2@gmail.com>
References: <20200525115052.19243-1-kohada.t2@gmail.com>
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

