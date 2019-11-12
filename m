Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91ECFF9BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 22:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfKLVNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 16:13:54 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44516 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727529AbfKLVNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:53 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLDqTA012844
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:52 -0500
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLDlC7007463
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:52 -0500
Received: by mail-qv1-f71.google.com with SMTP id i11so6974qvh.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wN3d2kdOZvUd019MrkFxf+wV1r/QbnQ8i3gbsIy65Ko=;
        b=fS2IgAfjjXFu6Wx9W6mDhqn+gsbcdOi++MU+K3+TjOx7/n/StjGqBCn5qYkVJ10G5e
         ApmNOkmUomT4auEq7zq/ZWeSHk7Vq7X5dZ5wxpWleJfwtmGvIcyDfJfKyPxjPHVi9BKS
         A9cgtudRAeb55stBT4VAZIqKAiB0m2vrFCX5+SrKlwOLCMtcbxUR90kc41Vy6G0N5Zo0
         /0LdoPT+KvjFx47GkHY6XQgk5Sk63hWmEB5dpEl11/MKyak8Tm74ufXDeiJObc1y8xkM
         W34Hdye3LWvPDzqORMxzCH46nL2SbNYgtiQqQr9Fvf6CkR/SqL1mOY7Y/KpKHjQBgVb8
         4vpw==
X-Gm-Message-State: APjAAAV9XgNIGM7B8BFwEQoYehUGVxaHIAip5zEAyjVpWAz7AqxyUeOH
        2BxgpxgH3SDb5gQsN8gD8qy8YfsEcZ2Ib1GocCNTVPcnms+uNLXBCgudbn/jda7Vv5roBufN35f
        TAFLii5MdHeItlK329Ke7CY6azqDjmYAlxun+
X-Received: by 2002:ac8:7948:: with SMTP id r8mr30671909qtt.91.1573593227568;
        Tue, 12 Nov 2019 13:13:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmCzOqCxP74DHU8hfkkqnBRILROjpy5RY655uzzcyNQR3UJouQiu943RxUjpFtf3PhN9woJQ==
X-Received: by 2002:ac8:7948:: with SMTP id r8mr30671872qtt.91.1573593227202;
        Tue, 12 Nov 2019 13:13:47 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:13:46 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] staging: exfat: Clean up the namespace pollution part 5
Date:   Tue, 12 Nov 2019 16:12:35 -0500
Message-Id: <20191112211238.156490-10-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
References: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some more functions that can be moved and made static

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      |   3 -
 drivers/staging/exfat/exfat_core.c | 182 ++++++++++++++---------------
 2 files changed, 91 insertions(+), 94 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 48267dd11e9d..c41fc3ec9f29 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -764,9 +764,6 @@ void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len);
 /* allocation bitmap management functions */
 s32 load_alloc_bitmap(struct super_block *sb);
 void free_alloc_bitmap(struct super_block *sb);
-s32 set_alloc_bitmap(struct super_block *sb, u32 clu);
-s32 clr_alloc_bitmap(struct super_block *sb, u32 clu);
-u32 test_alloc_bitmap(struct super_block *sb, u32 clu);
 void sync_alloc_bitmap(struct super_block *sb);
 
 /* upcase table management functions */
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 24700b251acb..8d38f70c9726 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -156,6 +156,97 @@ static s32 clear_cluster(struct super_block *sb, u32 clu)
 	return ret;
 }
 
+static s32 set_alloc_bitmap(struct super_block *sb, u32 clu)
+{
+	int i, b;
+	sector_t sector;
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
+
+	i = clu >> (p_bd->sector_size_bits + 3);
+	b = clu & ((p_bd->sector_size << 3) - 1);
+
+	sector = START_SECTOR(p_fs->map_clu) + i;
+
+	exfat_bitmap_set((u8 *)p_fs->vol_amap[i]->b_data, b);
+
+	return sector_write(sb, sector, p_fs->vol_amap[i], 0);
+}
+
+static s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
+{
+	int i, b;
+	sector_t sector;
+#ifdef CONFIG_EXFAT_DISCARD
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_mount_options *opts = &sbi->options;
+	int ret;
+#endif /* CONFIG_EXFAT_DISCARD */
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
+
+	i = clu >> (p_bd->sector_size_bits + 3);
+	b = clu & ((p_bd->sector_size << 3) - 1);
+
+	sector = START_SECTOR(p_fs->map_clu) + i;
+
+	exfat_bitmap_clear((u8 *)p_fs->vol_amap[i]->b_data, b);
+
+	return sector_write(sb, sector, p_fs->vol_amap[i], 0);
+
+#ifdef CONFIG_EXFAT_DISCARD
+	if (opts->discard) {
+		ret = sb_issue_discard(sb, START_SECTOR(clu),
+				       (1 << p_fs->sectors_per_clu_bits),
+				       GFP_NOFS, 0);
+		if (ret == -EOPNOTSUPP) {
+			pr_warn("discard not supported by device, disabling");
+			opts->discard = 0;
+		}
+	}
+#endif /* CONFIG_EXFAT_DISCARD */
+}
+
+static u32 test_alloc_bitmap(struct super_block *sb, u32 clu)
+{
+	int i, map_i, map_b;
+	u32 clu_base, clu_free;
+	u8 k, clu_mask;
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
+
+	clu_base = (clu & ~(0x7)) + 2;
+	clu_mask = (1 << (clu - clu_base + 2)) - 1;
+
+	map_i = clu >> (p_bd->sector_size_bits + 3);
+	map_b = (clu >> 3) & p_bd->sector_size_mask;
+
+	for (i = 2; i < p_fs->num_clusters; i += 8) {
+		k = *(((u8 *)p_fs->vol_amap[map_i]->b_data) + map_b);
+		if (clu_mask > 0) {
+			k |= clu_mask;
+			clu_mask = 0;
+		}
+		if (k < 0xFF) {
+			clu_free = clu_base + free_bit[k];
+			if (clu_free < p_fs->num_clusters)
+				return clu_free;
+		}
+		clu_base += 8;
+
+		if (((++map_b) >= p_bd->sector_size) ||
+		    (clu_base >= p_fs->num_clusters)) {
+			if ((++map_i) >= p_fs->map_sectors) {
+				clu_base = 2;
+				map_i = 0;
+			}
+			map_b = 0;
+		}
+	}
+
+	return CLUSTER_32(~0);
+}
+
 static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 			struct chain_t *p_chain)
 {
@@ -468,97 +559,6 @@ void free_alloc_bitmap(struct super_block *sb)
 	p_fs->vol_amap = NULL;
 }
 
-s32 set_alloc_bitmap(struct super_block *sb, u32 clu)
-{
-	int i, b;
-	sector_t sector;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-
-	i = clu >> (p_bd->sector_size_bits + 3);
-	b = clu & ((p_bd->sector_size << 3) - 1);
-
-	sector = START_SECTOR(p_fs->map_clu) + i;
-
-	exfat_bitmap_set((u8 *)p_fs->vol_amap[i]->b_data, b);
-
-	return sector_write(sb, sector, p_fs->vol_amap[i], 0);
-}
-
-s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
-{
-	int i, b;
-	sector_t sector;
-#ifdef CONFIG_EXFAT_DISCARD
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct exfat_mount_options *opts = &sbi->options;
-	int ret;
-#endif /* CONFIG_EXFAT_DISCARD */
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-
-	i = clu >> (p_bd->sector_size_bits + 3);
-	b = clu & ((p_bd->sector_size << 3) - 1);
-
-	sector = START_SECTOR(p_fs->map_clu) + i;
-
-	exfat_bitmap_clear((u8 *)p_fs->vol_amap[i]->b_data, b);
-
-	return sector_write(sb, sector, p_fs->vol_amap[i], 0);
-
-#ifdef CONFIG_EXFAT_DISCARD
-	if (opts->discard) {
-		ret = sb_issue_discard(sb, START_SECTOR(clu),
-				       (1 << p_fs->sectors_per_clu_bits),
-				       GFP_NOFS, 0);
-		if (ret == -EOPNOTSUPP) {
-			pr_warn("discard not supported by device, disabling");
-			opts->discard = 0;
-		}
-	}
-#endif /* CONFIG_EXFAT_DISCARD */
-}
-
-u32 test_alloc_bitmap(struct super_block *sb, u32 clu)
-{
-	int i, map_i, map_b;
-	u32 clu_base, clu_free;
-	u8 k, clu_mask;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-
-	clu_base = (clu & ~(0x7)) + 2;
-	clu_mask = (1 << (clu - clu_base + 2)) - 1;
-
-	map_i = clu >> (p_bd->sector_size_bits + 3);
-	map_b = (clu >> 3) & p_bd->sector_size_mask;
-
-	for (i = 2; i < p_fs->num_clusters; i += 8) {
-		k = *(((u8 *)p_fs->vol_amap[map_i]->b_data) + map_b);
-		if (clu_mask > 0) {
-			k |= clu_mask;
-			clu_mask = 0;
-		}
-		if (k < 0xFF) {
-			clu_free = clu_base + free_bit[k];
-			if (clu_free < p_fs->num_clusters)
-				return clu_free;
-		}
-		clu_base += 8;
-
-		if (((++map_b) >= p_bd->sector_size) ||
-		    (clu_base >= p_fs->num_clusters)) {
-			if ((++map_i) >= p_fs->map_sectors) {
-				clu_base = 2;
-				map_i = 0;
-			}
-			map_b = 0;
-		}
-	}
-
-	return CLUSTER_32(~0);
-}
-
 void sync_alloc_bitmap(struct super_block *sb)
 {
 	int i;
-- 
2.24.0

