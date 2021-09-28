Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB09E41B4DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 19:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbhI1RUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 13:20:37 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:51953 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241944AbhI1RUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:20:35 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 3D00081FE6;
        Tue, 28 Sep 2021 20:18:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632849534;
        bh=i+cGIy2AJpvD7O/sVrttkVOcPHv1UdmtVuUIhGbNZgU=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=aMIaN8Ho4uflrCtms3P6phOtWmt1y8Q40dZ4G+1S49eTFDB7PTf2yV3Dr0mAUTt5z
         IF5ecxTViwfGZhBH0R1uzM4dmPaLDg2U5laD1atDEoIdRnIRMxKS8OjBJsuS4wakkf
         jCCC82+RTj2D52ywn/SH5RsQcNzH9JsKIwm4vD1s=
Received: from [192.168.211.85] (192.168.211.85) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 28 Sep 2021 20:18:53 +0300
Message-ID: <445f7411-160c-84fc-7390-7b170cc5831e@paragon-software.com>
Date:   Tue, 28 Sep 2021 20:18:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH v2 3/3] fs/ntfs3: Refactoring of ntfs_init_from_boot
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kari.argillander@gmail.com>
References: <a7c2e6d3-68a1-25f7-232e-935ae9e5f6c8@paragon-software.com>
In-Reply-To: <a7c2e6d3-68a1-25f7-232e-935ae9e5f6c8@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.85]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove ntfs_sb_info members sector_size and sector_bits.
Print details why mount failed.

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/ntfs_fs.h |  2 --
 fs/ntfs3/super.c   | 19 +++++++++----------
 2 files changed, 9 insertions(+), 12 deletions(-)

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
index 890c5d9d6d60..1c70871a3758 100644
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
 
@@ -800,10 +800,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
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


