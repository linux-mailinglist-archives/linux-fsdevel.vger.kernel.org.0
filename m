Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34386FB034
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjEHMhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 08:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjEHMhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 08:37:45 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6881B1FCF;
        Mon,  8 May 2023 05:37:43 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D959E21C3;
        Mon,  8 May 2023 12:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549174;
        bh=eUdOqgEPzuhDm6m+TY/pQxrmqpwlAoPXqQwZwQwVKkY=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=YxxnbcMTWh4mPw9jfZnz2qtaaE5AKm89YFCKlmka7B2ABUXDCnuRFM+YZRqEYPRRA
         cjSDow7lrBVbtKBfUaGg6r9QQgVja4CER6+m7RwDrYrb6lc3E8YQmp7oDGtTUe4JdN
         EbncVRwCMDXO4mpXEVRPLmhqOayU70+JZ3EPAIyQ=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 861E12191;
        Mon,  8 May 2023 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549461;
        bh=eUdOqgEPzuhDm6m+TY/pQxrmqpwlAoPXqQwZwQwVKkY=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=HgClNu2/GVnhUC7bcq6YJjoYakmdbi9vxn15wOUXoU35l5qCHFF2DrDNHy/GYrLmW
         OHodTeo94tL3x8cqCKd5b9Zy3DB3h3RjybM69L7G6hC69mVW0rHEJxenUGWPCC5CjI
         Z6hXSAe5sajP2XzLMXRUZd3+9V4pu4NSS5C2i2xA=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:37:41 +0300
Message-ID: <24e18e44-b97b-b896-f1b0-0c7e58f23a1c@paragon-software.com>
Date:   Mon, 8 May 2023 16:37:40 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 04/10] fs/ntfs3: Alternative boot if primary boot is corrupted
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <b21a4bc9-166d-2631-d73b-cb4e802ff69e@paragon-software.com>
In-Reply-To: <b21a4bc9-166d-2631-d73b-cb4e802ff69e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some code refactoring added also.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/super.c | 98 +++++++++++++++++++++++++++++++++++-------------
  1 file changed, 71 insertions(+), 27 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 5158dd31fd97..ecf899d571d8 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -724,6 +724,8 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      struct MFT_REC *rec;
      u16 fn, ao;
      u8 cluster_bits;
+    u32 boot_off = 0;
+    const char *hint = "Primary boot";

      sbi->volume.blocks = dev_size >> PAGE_SHIFT;

@@ -731,11 +733,12 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      if (!bh)
          return -EIO;

+check_boot:
      err = -EINVAL;
-    boot = (struct NTFS_BOOT *)bh->b_data;
+    boot = (struct NTFS_BOOT *)Add2Ptr(bh->b_data, boot_off);

      if (memcmp(boot->system_id, "NTFS    ", sizeof("NTFS    ") - 1)) {
-        ntfs_err(sb, "Boot's signature is not NTFS.");
+        ntfs_err(sb, "%s signature is not NTFS.", hint);
          goto out;
      }

@@ -748,14 +751,16 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
                 boot->bytes_per_sector[0];
      if (boot_sector_size < SECTOR_SIZE ||
          !is_power_of_2(boot_sector_size)) {
-        ntfs_err(sb, "Invalid bytes per sector %u.", boot_sector_size);
+        ntfs_err(sb, "%s: invalid bytes per sector %u.", hint,
+             boot_sector_size);
          goto out;
      }

      /* cluster size: 512, 1K, 2K, 4K, ... 2M */
      sct_per_clst = true_sectors_per_clst(boot);
      if ((int)sct_per_clst < 0 || !is_power_of_2(sct_per_clst)) {
-        ntfs_err(sb, "Invalid sectors per cluster %u.", sct_per_clst);
+        ntfs_err(sb, "%s: invalid sectors per cluster %u.", hint,
+             sct_per_clst);
          goto out;
      }

@@ -771,8 +776,8 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      if (mlcn * sct_per_clst >= sectors || mlcn2 * sct_per_clst >= 
sectors) {
          ntfs_err(
              sb,
-            "Start of MFT 0x%llx (0x%llx) is out of volume 0x%llx.",
-            mlcn, mlcn2, sectors);
+            "%s: start of MFT 0x%llx (0x%llx) is out of volume 0x%llx.",
+            hint, mlcn, mlcn2, sectors);
          goto out;
      }

@@ -784,7 +789,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,

      /* Check MFT record size. */
      if (record_size < SECTOR_SIZE || !is_power_of_2(record_size)) {
-        ntfs_err(sb, "Invalid bytes per MFT record %u (%d).",
+        ntfs_err(sb, "%s: invalid bytes per MFT record %u (%d).", hint,
               record_size, boot->record_size);
          goto out;
      }
@@ -801,13 +806,13 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,

      /* Check index record size. */
      if (sbi->index_size < SECTOR_SIZE || 
!is_power_of_2(sbi->index_size)) {
-        ntfs_err(sb, "Invalid bytes per index %u(%d).", sbi->index_size,
-             boot->index_size);
+        ntfs_err(sb, "%s: invalid bytes per index %u(%d).", hint,
+             sbi->index_size, boot->index_size);
          goto out;
      }

      if (sbi->index_size > MAXIMUM_BYTES_PER_INDEX) {
-        ntfs_err(sb, "Unsupported bytes per index %u.",
+        ntfs_err(sb, "%s: unsupported bytes per index %u.", hint,
               sbi->index_size);
          goto out;
      }
@@ -834,7 +839,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,

      /* Compare boot's cluster and sector. */
      if (sbi->cluster_size < boot_sector_size) {
-        ntfs_err(sb, "Invalid bytes per cluster (%u).",
+        ntfs_err(sb, "%s: invalid bytes per cluster (%u).", hint,
               sbi->cluster_size);
          goto out;
      }
@@ -930,7 +935,46 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,

      err = 0;

+    if (bh->b_blocknr && !sb_rdonly(sb)) {
+        /*
+          * Alternative boot is ok but primary is not ok.
+          * Update primary boot.
+         */
+        struct buffer_head *bh0 = sb_getblk(sb, 0);
+        if (bh0) {
+            if (buffer_locked(bh0))
+                __wait_on_buffer(bh0);
+
+            lock_buffer(bh0);
+            memcpy(bh0->b_data, boot, sizeof(*boot));
+            set_buffer_uptodate(bh0);
+            mark_buffer_dirty(bh0);
+            unlock_buffer(bh0);
+            if (!sync_dirty_buffer(bh0))
+                ntfs_warn(sb, "primary boot is updated");
+            put_bh(bh0);
+        }
+    }
+
  out:
+    if (err == -EINVAL && !bh->b_blocknr && dev_size > PAGE_SHIFT) {
+        u32 block_size = min_t(u32, sector_size, PAGE_SIZE);
+        u64 lbo = dev_size - sizeof(*boot);
+
+        /*
+          * Try alternative boot (last sector)
+         */
+        brelse(bh);
+
+        sb_set_blocksize(sb, block_size);
+        bh = ntfs_bread(sb, lbo >> blksize_bits(block_size));
+        if (!bh)
+            return -EINVAL;
+
+        boot_off = lbo & (block_size - 1);
+        hint = "Alternative boot";
+        goto check_boot;
+    }
      brelse(bh);

      return err;
@@ -955,6 +999,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      struct ATTR_DEF_ENTRY *t;
      u16 *shared;
      struct MFT_REF ref;
+    bool ro = sb_rdonly(sb);

      ref.high = 0;

@@ -1035,6 +1080,10 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
      sbi->volume.minor_ver = info->minor_ver;
      sbi->volume.flags = info->flags;
      sbi->volume.ni = ni;
+    if (info->flags & VOLUME_FLAG_DIRTY) {
+        sbi->volume.real_dirty = true;
+        ntfs_info(sb, "It is recommened to use chkdsk.");
+    }

      /* Load $MFTMirr to estimate recs_mirr. */
      ref.low = cpu_to_le32(MFT_REC_MIRR);
@@ -1069,21 +1118,16 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)

      iput(inode);

-    if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
-        if (!sb_rdonly(sb)) {
-            ntfs_warn(sb,
-                  "failed to replay log file. Can't mount rw!");
-            err = -EINVAL;
-            goto out;
-        }
-    } else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
-        if (!sb_rdonly(sb) && !options->force) {
-            ntfs_warn(
-                sb,
-                "volume is dirty and \"force\" flag is not set!");
-            err = -EINVAL;
-            goto out;
-        }
+    if ((sbi->flags & NTFS_FLAGS_NEED_REPLAY) && !ro) {
+        ntfs_warn(sb, "failed to replay log file. Can't mount rw!");
+        err = -EINVAL;
+        goto out;
+    }
+
+    if ((sbi->volume.flags & VOLUME_FLAG_DIRTY) && !ro && 
!options->force) {
+        ntfs_warn(sb, "volume is dirty and \"force\" flag is not set!");
+        err = -EINVAL;
+        goto out;
      }

      /* Load $MFT. */
@@ -1173,7 +1217,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)

          bad_len += len;
          bad_frags += 1;
-        if (sb_rdonly(sb))
+        if (ro)
              continue;

          if (wnd_set_used_safe(&sbi->used.bitmap, lcn, len, &tt) || tt) {
-- 
2.34.1

