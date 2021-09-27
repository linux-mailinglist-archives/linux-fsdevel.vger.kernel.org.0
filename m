Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924B1419838
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 17:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhI0PuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 11:50:19 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:44082 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235231AbhI0PuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:50:19 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id A7B26120;
        Mon, 27 Sep 2021 18:48:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632757719;
        bh=qL18HyCFaFHFkqGxBjeCI6PXU23yRo9JfoQV5XI5yB8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=fF/MxMJ/BrBMyMNqjlyUYhVjg0THkpqZ2QzJn374ulWGA2qY40K+rwjcsFZ2yJ+II
         KGybvtP4dJ38fTtTXORbVD/KoTHZjV+2oCsjmeSKtbhoqcJKUQfHf1nek0xxmqY+By
         5+BSD0rMXVK5ca9JWsEeLFZaXuJDLPqUpDcx1p0U=
Received: from [192.168.211.27] (192.168.211.27) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 27 Sep 2021 18:48:39 +0300
Message-ID: <aa2b5ad6-dd9e-3feb-d3bd-248cb311d050@paragon-software.com>
Date:   Mon, 27 Sep 2021 18:48:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH 3/3] fs/ntfs3: Refactoring of ntfs_init_from_boot
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <16cbff75-f705-37cb-ad3f-43d433352f6b@paragon-software.com>
In-Reply-To: <16cbff75-f705-37cb-ad3f-43d433352f6b@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.27]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove ntfs_sb_info members sector_size and sector_bits.
Print details why mount failed.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/ntfs_fs.h |  2 --
 fs/ntfs3/super.c   | 32 +++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 6731b5d9e2d8..38b7c1a9dc52 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -211,10 +211,8 @@ struct ntfs_sb_info {
 	u32 blocks_per_cluster; // cluster_size / sb->s_blocksize
 
 	u32 record_size;
-	u32 sector_size;
 	u32 index_size;
 
-	u8 sector_bits;
 	u8 cluster_bits;
 	u8 record_bits;
 
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 193f9a98f6ab..5fe9484c6781 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -682,7 +682,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	int err;
 	u32 mb, gb, boot_sector_size, sct_per_clst, record_size;
-	u64 sectors, clusters, fs_size, mlcn, mlcn2;
+	u64 sectors, clusters, mlcn, mlcn2;
 	struct NTFS_BOOT *boot;
 	struct buffer_head *bh;
 	struct MFT_REC *rec;
@@ -740,20 +740,20 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		goto out;
 	}
 
-	sbi->sector_size = boot_sector_size;
-	sbi->sector_bits = blksize_bits(boot_sector_size);
-	fs_size = (sectors + 1) << sbi->sector_bits;
+	sbi->volume.size = sectors * boot_sector_size;
 
-	gb = format_size_gb(fs_size, &mb);
+	gb = format_size_gb(sbi->volume.size + boot_sector_size, &mb);
 
 	/*
 	 * - Volume formatted and mounted with the same sector size.
 	 * - Volume formatted 4K and mounted as 512.
 	 * - Volume formatted 512 and mounted as 4K.
 	 */
-	if (sbi->sector_size != sector_size) {
-		ntfs_warn(sb,
-			  "Different NTFS' sector size and media sector size");
+	if (boot_sector_size != sector_size) {
+		ntfs_warn(
+			sb,
+			"Different NTFS' sector size (%u) and media sector size (%u)",
+			boot_sector_size, sector_size);
 		dev_size += sector_size - 1;
 	}
 
@@ -764,12 +764,19 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
 
 	/* Compare boot's cluster and sector. */
-	if (sbi->cluster_size < sbi->sector_size)
+	if (sbi->cluster_size < boot_sector_size)
 		goto out;
 
 	/* Compare boot's cluster and media sector. */
-	if (sbi->cluster_size < sector_size)
-		goto out; /* No way to use ntfs_get_block in this case. */
+	if (sbi->cluster_size < sector_size) {
+		/* No way to use ntfs_get_block in this case. */
+		ntfs_err(
+			sb,
+			"Failed to mount 'cause NTFS's cluster size (%u) is "
+			"less than media sector size (%u)",
+			sbi->cluster_size, sector_size);
+		goto out;
+	}
 
 	sbi->cluster_mask = sbi->cluster_size - 1;
 	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
@@ -794,10 +801,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 				  : (u32)boot->index_size << sbi->cluster_bits;
 
 	sbi->volume.ser_num = le64_to_cpu(boot->serial_num);
-	sbi->volume.size = sectors << sbi->sector_bits;
 
 	/* Warning if RAW volume. */
-	if (dev_size < fs_size) {
+	if (dev_size < sbi->volume.size + boot_sector_size) {
 		u32 mb0, gb0;
 
 		gb0 = format_size_gb(dev_size, &mb0);
-- 
2.33.0


