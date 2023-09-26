Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E333E7AE9AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 11:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjIZJ4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjIZJ4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:56:09 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5B1BB;
        Tue, 26 Sep 2023 02:55:55 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6DAF221BC;
        Tue, 26 Sep 2023 09:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695721803;
        bh=Nf2tlL8ndkT5fumOF9aSaoVeSNGQzhIY6kDh91oVRUE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ncv0G8arOqm3X0jid+4L2MVE689rRbad7e+k+2BtujmZbDit/pHvyARgZuZx771R8
         G/gat1h2aicoRanLAt5Kgn0z0Vtgcy1QHRdoGKO9Wev7FT3X2wi0O54CLxk46+waT6
         tAL85kb0QqmYZYfglW65WrgRuZDzW3+v3hnWcVbg=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id BC64A1D45;
        Tue, 26 Sep 2023 09:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695722153;
        bh=Nf2tlL8ndkT5fumOF9aSaoVeSNGQzhIY6kDh91oVRUE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=iiibi4ADh06yd/BR2C+7DGZUaIaGB5nAQx2rdMPVvbAHFhoW2q0ApmU24dyT7+e/V
         SHf1Z9nkn0L5Y96wEVu+wEa/PxzC5SI8UzgatQ9S+FCm4geVL0Tip2yPrqTutDdc6E
         0h4Ox3DQLEdMQEdWIIyfRU7i0lv4LVt9yMs00yDY=
Received: from [172.16.192.129] (192.168.211.137) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 Sep 2023 12:55:53 +0300
Message-ID: <1f95ab55-ce05-4c11-8c14-8df260514208@paragon-software.com>
Date:   Tue, 26 Sep 2023 12:55:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/8] fs/ntfs3: Fix alternative boot searching
Content-Language: en-US
From:   Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
In-Reply-To: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.137]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/super.c | 10 +++++++---
  1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 71c80c578feb..d2951b23f52a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -846,7 +846,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      struct ntfs_sb_info *sbi = sb->s_fs_info;
      int err;
      u32 mb, gb, boot_sector_size, sct_per_clst, record_size;
-    u64 sectors, clusters, mlcn, mlcn2;
+    u64 sectors, clusters, mlcn, mlcn2, dev_size0;
      struct NTFS_BOOT *boot;
      struct buffer_head *bh;
      struct MFT_REC *rec;
@@ -855,6 +855,9 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      u32 boot_off = 0;
      const char *hint = "Primary boot";

+    /* Save original dev_size. Used with alternative boot. */
+    dev_size0 = dev_size;
+
      sbi->volume.blocks = dev_size >> PAGE_SHIFT;

      bh = ntfs_bread(sb, 0);
@@ -1087,9 +1090,9 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      }

  out:
-    if (err == -EINVAL && !bh->b_blocknr && dev_size > PAGE_SHIFT) {
+    if (err == -EINVAL && !bh->b_blocknr && dev_size0 > PAGE_SHIFT) {
          u32 block_size = min_t(u32, sector_size, PAGE_SIZE);
-        u64 lbo = dev_size - sizeof(*boot);
+        u64 lbo = dev_size0 - sizeof(*boot);

          /*
            * Try alternative boot (last sector)
@@ -1103,6 +1106,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,

          boot_off = lbo & (block_size - 1);
          hint = "Alternative boot";
+        dev_size = dev_size0; /* restore original size. */
          goto check_boot;
      }
      brelse(bh);
-- 
2.34.1

