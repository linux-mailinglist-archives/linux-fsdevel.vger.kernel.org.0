Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAD0697DA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBONks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBONkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:40:46 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5E239BA7;
        Wed, 15 Feb 2023 05:40:32 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A6769214E;
        Wed, 15 Feb 2023 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676468180;
        bh=usEtSMeyYHIotqRXwOxKAue/XOIiNzAb2X5xWL5CEHs=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=EvLNcaibd1xUrg3e27fMIGoIUwE91WtIo38z+Jbkhq3ssj459GNS2nJUK2LRr6bQt
         1BxZKj09/ACU3rLC74LodHWsNLyxi+MBA4pAM0/ue8IrvSjOjvs924IC0kQupzPpO2
         OWDcVyQ3GKstUv6Gi/ppbtZd4CV/9zymLxEqQQPA=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 0CEA31E70;
        Wed, 15 Feb 2023 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676468431;
        bh=usEtSMeyYHIotqRXwOxKAue/XOIiNzAb2X5xWL5CEHs=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=iShuC2vNW9lGaviqam1oMitCEJxghHzmEpT82bYltbqSz2yEBgdo4Ugb1ycGkGcE1
         vUtp925KMDlb8D3ZSMhOmCjBfOFqwiBMNhqI5bFqvG7Zo3x8uF2BK9JpQzFFu6QESl
         CZZAuzILkXtwCXlMNESk9tj1CKqJU5Da/hspyoNQ=
Received: from [192.168.211.36] (192.168.211.36) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Feb 2023 16:40:30 +0300
Message-ID: <48ebd481-dc1f-66fc-6888-5e82fd14af6e@paragon-software.com>
Date:   Wed, 15 Feb 2023 17:40:29 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 11/11] fs/ntfs3: Print details about mount fails
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
In-Reply-To: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.36]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added error mesages with error codes.
Minor refactoring and code formatting.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/frecord.c |   2 +-
  fs/ntfs3/fsntfs.c  |  40 +++++------
  fs/ntfs3/super.c   | 172 +++++++++++++++++++++++++++------------------
  3 files changed, 122 insertions(+), 92 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 481219f2a7cf..2bfcf1a989c9 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3360,7 +3360,7 @@ int ni_write_inode(struct inode *inode, int sync, 
const char *hint)
      ni_unlock(ni);

      if (err) {
-        ntfs_err(sb, "%s r=%lx failed, %d.", hint, inode->i_ino, err);
+        ntfs_inode_err(inode, "%s failed, %d.", hint, err);
          ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
          return err;
      }
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 0a82b1bf3ec2..28cc421102e5 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -223,7 +223,7 @@ int ntfs_extend_init(struct ntfs_sb_info *sbi)
      inode = ntfs_iget5(sb, &ref, &NAME_EXTEND);
      if (IS_ERR(inode)) {
          err = PTR_ERR(inode);
-        ntfs_err(sb, "Failed to load $Extend.");
+        ntfs_err(sb, "Failed to load $Extend (%d).", err);
          inode = NULL;
          goto out;
      }
@@ -282,7 +282,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, 
struct ntfs_sb_info *sbi)

      /* Check for 4GB. */
      if (ni->vfs_inode.i_size >= 0x100000000ull) {
-        ntfs_err(sb, "\x24LogFile is too big");
+        ntfs_err(sb, "\x24LogFile is large than 4G.");
          err = -EINVAL;
          goto out;
      }
@@ -1863,7 +1863,7 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
      inode = ntfs_iget5(sb, &ref, &NAME_SECURE);
      if (IS_ERR(inode)) {
          err = PTR_ERR(inode);
-        ntfs_err(sb, "Failed to load $Secure.");
+        ntfs_err(sb, "Failed to load $Secure (%d).", err);
          inode = NULL;
          goto out;
      }
@@ -1874,45 +1874,43 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)

      attr = ni_find_attr(ni, NULL, &le, ATTR_ROOT, SDH_NAME,
                  ARRAY_SIZE(SDH_NAME), NULL, NULL);
-    if (!attr) {
-        err = -EINVAL;
-        goto out;
-    }
-
-    if(!(root_sdh = resident_data_ex(attr, sizeof(struct INDEX_ROOT))) ||
+    if (!attr ||
+        !(root_sdh = resident_data_ex(attr, sizeof(struct INDEX_ROOT))) ||
          root_sdh->type != ATTR_ZERO ||
          root_sdh->rule != NTFS_COLLATION_TYPE_SECURITY_HASH ||
          offsetof(struct INDEX_ROOT, ihdr) +
-            le32_to_cpu(root_sdh->ihdr.used) >
-            le32_to_cpu(attr->res.data_size)) {
+                le32_to_cpu(root_sdh->ihdr.used) >
+            le32_to_cpu(attr->res.data_size)) {
+        ntfs_err(sb, "$Secure::$SDH is corrupted.");
          err = -EINVAL;
          goto out;
      }

      err = indx_init(indx_sdh, sbi, attr, INDEX_MUTEX_SDH);
-    if (err)
+    if (err) {
+        ntfs_err(sb, "Failed to initialize $Secure::$SDH (%d).", err);
          goto out;
+    }

      attr = ni_find_attr(ni, attr, &le, ATTR_ROOT, SII_NAME,
                  ARRAY_SIZE(SII_NAME), NULL, NULL);
-    if (!attr) {
-        err = -EINVAL;
-        goto out;
-    }
-
-    if(!(root_sii = resident_data_ex(attr, sizeof(struct INDEX_ROOT))) ||
+    if (!attr ||
+        !(root_sii = resident_data_ex(attr, sizeof(struct INDEX_ROOT))) ||
          root_sii->type != ATTR_ZERO ||
          root_sii->rule != NTFS_COLLATION_TYPE_UINT ||
          offsetof(struct INDEX_ROOT, ihdr) +
-            le32_to_cpu(root_sii->ihdr.used) >
-            le32_to_cpu(attr->res.data_size)) {
+                le32_to_cpu(root_sii->ihdr.used) >
+            le32_to_cpu(attr->res.data_size)) {
+        ntfs_err(sb, "$Secure::$SII is corrupted.");
          err = -EINVAL;
          goto out;
      }

      err = indx_init(indx_sii, sbi, attr, INDEX_MUTEX_SII);
-    if (err)
+    if (err) {
+        ntfs_err(sb, "Failed to initialize $Secure::$SII (%d).", err);
          goto out;
+    }

      fnd_sii = fnd_get();
      if (!fnd_sii) {
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 521ce31d67a1..e0f78b306f15 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -734,48 +734,81 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      err = -EINVAL;
      boot = (struct NTFS_BOOT *)bh->b_data;

-    if (memcmp(boot->system_id, "NTFS    ", sizeof("NTFS    ") - 1))
+    if (memcmp(boot->system_id, "NTFS    ", sizeof("NTFS    ") - 1)) {
+        ntfs_err(sb, "Boot's signature is not NTFS.");
          goto out;
+    }

      /* 0x55AA is not mandaroty. Thanks Maxim Suhanov*/
      /*if (0x55 != boot->boot_magic[0] || 0xAA != boot->boot_magic[1])
       *    goto out;
       */

-    boot_sector_size = (u32)boot->bytes_per_sector[1] << 8;
-    if (boot->bytes_per_sector[0] || boot_sector_size < SECTOR_SIZE ||
+    boot_sector_size = ((u32)boot->bytes_per_sector[1] << 8) |
+               boot->bytes_per_sector[0];
+    if (boot_sector_size < SECTOR_SIZE ||
          !is_power_of_2(boot_sector_size)) {
+        ntfs_err(sb, "Invalid bytes per sector %u.", boot_sector_size);
          goto out;
      }

      /* cluster size: 512, 1K, 2K, 4K, ... 2M */
      sct_per_clst = true_sectors_per_clst(boot);
-    if ((int)sct_per_clst < 0)
-        goto out;
-    if (!is_power_of_2(sct_per_clst))
+    if ((int)sct_per_clst < 0 || !is_power_of_2(sct_per_clst)) {
+        ntfs_err(sb, "Invalid sectors per cluster %u.", sct_per_clst);
          goto out;
+    }
+
+    sbi->cluster_size = boot_sector_size * sct_per_clst;
+    sbi->cluster_bits = cluster_bits = blksize_bits(sbi->cluster_size);
+    sbi->cluster_mask = sbi->cluster_size - 1;
+    sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;

      mlcn = le64_to_cpu(boot->mft_clst);
      mlcn2 = le64_to_cpu(boot->mft2_clst);
      sectors = le64_to_cpu(boot->sectors_per_volume);

-    if (mlcn * sct_per_clst >= sectors)
+    if (mlcn * sct_per_clst >= sectors || mlcn2 * sct_per_clst >= 
sectors) {
+        ntfs_err(
+            sb,
+            "Start of MFT 0x%llx (0x%llx) is out of volume 0x%llx.",
+            mlcn, mlcn2, sectors);
          goto out;
+    }

-    if (mlcn2 * sct_per_clst >= sectors)
-        goto out;
+    sbi->record_size = record_size =
+        boot->record_size < 0 ? 1 << (-boot->record_size) :
+                          (u32)boot->record_size << cluster_bits;
+    sbi->record_bits = blksize_bits(record_size);
+    sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes

      /* Check MFT record size. */
-    if ((boot->record_size < 0 &&
-         SECTOR_SIZE > (2U << (-boot->record_size))) ||
-        (boot->record_size >= 0 && !is_power_of_2(boot->record_size))) {
+    if (record_size < SECTOR_SIZE || !is_power_of_2(record_size)) {
+        ntfs_err(sb, "Invalid bytes per MFT record %u (%d).",
+             record_size, boot->record_size);
+        goto out;
+    }
+
+    if (record_size > MAXIMUM_BYTES_PER_MFT) {
+        ntfs_err(sb, "Unsupported bytes per MFT record %u.",
+             record_size);
          goto out;
      }

+    sbi->index_size = boot->index_size < 0 ?
+                    1u << (-boot->index_size) :
+                    (u32)boot->index_size << cluster_bits;
+
      /* Check index record size. */
-    if ((boot->index_size < 0 &&
-         SECTOR_SIZE > (2U << (-boot->index_size))) ||
-        (boot->index_size >= 0 && !is_power_of_2(boot->index_size))) {
+    if (sbi->index_size < SECTOR_SIZE || !is_power_of_2(sbi->index_size)) {
+        ntfs_err(sb, "Invalid bytes per index %u(%d).", sbi->index_size,
+             boot->index_size);
+        goto out;
+    }
+
+    if (sbi->index_size > MAXIMUM_BYTES_PER_INDEX) {
+        ntfs_err(sb, "Unsupported bytes per index %u.",
+             sbi->index_size);
          goto out;
      }

@@ -796,15 +829,15 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
          dev_size += sector_size - 1;
      }

-    sbi->cluster_size = boot_sector_size * sct_per_clst;
-    sbi->cluster_bits = blksize_bits(sbi->cluster_size);
-
      sbi->mft.lbo = mlcn << cluster_bits;
      sbi->mft.lbo2 = mlcn2 << cluster_bits;

      /* Compare boot's cluster and sector. */
-    if (sbi->cluster_size < boot_sector_size)
+    if (sbi->cluster_size < boot_sector_size) {
+        ntfs_err(sb, "Invalid bytes per cluster (%u).",
+             sbi->cluster_size);
          goto out;
+    }

      /* Compare boot's cluster and media sector. */
      if (sbi->cluster_size < sector_size) {
@@ -816,28 +849,11 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
          goto out;
      }

-    sbi->cluster_mask = sbi->cluster_size - 1;
-    sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
-    sbi->record_size = record_size = boot->record_size < 0
-                         ? 1 << (-boot->record_size)
-                         : (u32)boot->record_size
-                               << sbi->cluster_bits;
-
-    if (record_size > MAXIMUM_BYTES_PER_MFT || record_size < SECTOR_SIZE)
-        goto out;
-
-    sbi->record_bits = blksize_bits(record_size);
-    sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes
-
      sbi->max_bytes_per_attr =
          record_size - ALIGN(MFTRECORD_FIXUP_OFFSET_1, 8) -
          ALIGN(((record_size >> SECTOR_SHIFT) * sizeof(short)), 8) -
          ALIGN(sizeof(enum ATTR_TYPE), 8);

-    sbi->index_size = boot->index_size < 0
-                  ? 1u << (-boot->index_size)
-                  : (u32)boot->index_size << sbi->cluster_bits;
-
      sbi->volume.ser_num = le64_to_cpu(boot->serial_num);

      /* Warning if RAW volume. */
@@ -928,6 +944,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      int err;
      struct ntfs_sb_info *sbi = sb->s_fs_info;
      struct block_device *bdev = sb->s_bdev;
+    struct ntfs_mount_options *options;
      struct inode *inode;
      struct ntfs_inode *ni;
      size_t i, tt, bad_len, bad_frags;
@@ -942,7 +959,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      ref.high = 0;

      sbi->sb = sb;
-    sbi->options = fc->fs_private;
+    sbi->options = options = fc->fs_private;
      fc->fs_private = NULL;
      sb->s_flags |= SB_NODIRATIME;
      sb->s_magic = 0x7366746e; // "ntfs"
@@ -950,12 +967,12 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      sb->s_export_op = &ntfs_export_ops;
      sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
      sb->s_xattr = ntfs_xattr_handlers;
-    sb->s_d_op = sbi->options->nocase ? &ntfs_dentry_ops : NULL;
+    sb->s_d_op = options->nocase ? &ntfs_dentry_ops : NULL;

-    sbi->options->nls = ntfs_load_nls(sbi->options->nls_name);
-    if (IS_ERR(sbi->options->nls)) {
-        sbi->options->nls = NULL;
-        errorf(fc, "Cannot load nls %s", sbi->options->nls_name);
+    options->nls = ntfs_load_nls(options->nls_name);
+    if (IS_ERR(options->nls)) {
+        options->nls = NULL;
+        errorf(fc, "Cannot load nls %s", options->nls_name);
          err = -EINVAL;
          goto out;
      }
@@ -980,8 +997,8 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      ref.seq = cpu_to_le16(MFT_REC_VOL);
      inode = ntfs_iget5(sb, &ref, &NAME_VOLUME);
      if (IS_ERR(inode)) {
-        ntfs_err(sb, "Failed to load $Volume.");
          err = PTR_ERR(inode);
+        ntfs_err(sb, "Failed to load $Volume (%d).", err);
          goto out;
      }

@@ -1007,13 +1024,9 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
      }

      attr = ni_find_attr(ni, attr, NULL, ATTR_VOL_INFO, NULL, 0, NULL, 
NULL);
-    if (!attr || is_attr_ext(attr)) {
-        err = -EINVAL;
-        goto put_inode_out;
-    }
-
-    info = resident_data_ex(attr, SIZEOF_ATTRIBUTE_VOLUME_INFO);
-    if (!info) {
+    if (!attr || is_attr_ext(attr) ||
+        !(info = resident_data_ex(attr, SIZEOF_ATTRIBUTE_VOLUME_INFO))) {
+        ntfs_err(sb, "$Volume is corrupted.");
          err = -EINVAL;
          goto put_inode_out;
      }
@@ -1028,13 +1041,13 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
      ref.seq = cpu_to_le16(MFT_REC_MIRR);
      inode = ntfs_iget5(sb, &ref, &NAME_MIRROR);
      if (IS_ERR(inode)) {
-        ntfs_err(sb, "Failed to load $MFTMirr.");
          err = PTR_ERR(inode);
+        ntfs_err(sb, "Failed to load $MFTMirr (%d).", err);
          goto out;
      }

-    sbi->mft.recs_mirr =
-        ntfs_up_cluster(sbi, inode->i_size) >> sbi->record_bits;
+    sbi->mft.recs_mirr = ntfs_up_cluster(sbi, inode->i_size) >>
+                 sbi->record_bits;

      iput(inode);

@@ -1043,8 +1056,8 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      ref.seq = cpu_to_le16(MFT_REC_LOG);
      inode = ntfs_iget5(sb, &ref, &NAME_LOGFILE);
      if (IS_ERR(inode)) {
-        ntfs_err(sb, "Failed to load \x24LogFile.");
          err = PTR_ERR(inode);
+        ntfs_err(sb, "Failed to load \x24LogFile (%d).", err);
          goto out;
      }

@@ -1064,7 +1077,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
              goto out;
          }
      } else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
-        if (!sb_rdonly(sb) && !sbi->options->force) {
+        if (!sb_rdonly(sb) && !options->force) {
              ntfs_warn(
                  sb,
                  "volume is dirty and \"force\" flag is not set!");
@@ -1079,8 +1092,8 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)

      inode = ntfs_iget5(sb, &ref, &NAME_MFT);
      if (IS_ERR(inode)) {
-        ntfs_err(sb, "Failed to load $MFT.");
          err = PTR_ERR(inode);
+        ntfs_err(sb, "Failed to load $MFT (%d).", err);
          goto out;
      }

@@ -1095,8 +1108,10 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
          goto put_inode_out;

      err = ni_load_all_mi(ni);
-    if (err)
+    if (err) {
+        ntfs_err(sb, "Failed to load $MFT's subrecords (%d).", err);
          goto put_inode_out;
+    }

      sbi->mft.ni = ni;

@@ -1105,8 +1120,8 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      ref.seq = cpu_to_le16(MFT_REC_BITMAP);
      inode = ntfs_iget5(sb, &ref, &NAME_BITMAP);
      if (IS_ERR(inode)) {
-        ntfs_err(sb, "Failed to load $Bitmap.");
          err = PTR_ERR(inode);
+        ntfs_err(sb, "Failed to load $Bitmap (%d).", err);
          goto out;
      }

@@ -1120,20 +1135,25 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
      /* Check bitmap boundary. */
      tt = sbi->used.bitmap.nbits;
      if (inode->i_size < bitmap_size(tt)) {
+        ntfs_err(sb, "$Bitmap is corrupted.");
          err = -EINVAL;
          goto put_inode_out;
      }

      err = wnd_init(&sbi->used.bitmap, sb, tt);
-    if (err)
+    if (err) {
+        ntfs_err(sb, "Failed to initialize $Bitmap (%d).", err);
          goto put_inode_out;
+    }

      iput(inode);

      /* Compute the MFT zone. */
      err = ntfs_refresh_zone(sbi);
-    if (err)
+    if (err) {
+        ntfs_err(sb, "Failed to initialize MFT zone (%d).", err);
          goto out;
+    }

      /* Load $BadClus. */
      ref.low = cpu_to_le32(MFT_REC_BADCLUST);
@@ -1178,8 +1198,8 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      ref.seq = cpu_to_le16(MFT_REC_ATTR);
      inode = ntfs_iget5(sb, &ref, &NAME_ATTRDEF);
      if (IS_ERR(inode)) {
-        ntfs_err(sb, "Failed to load $AttrDef -> %d", err);
          err = PTR_ERR(inode);
+        ntfs_err(sb, "Failed to load $AttrDef (%d)", err);
          goto out;
      }

@@ -1208,6 +1228,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)

          if (IS_ERR(page)) {
              err = PTR_ERR(page);
+            ntfs_err(sb, "Failed to read $AttrDef (%d).", err);
              goto put_inode_out;
          }
          memcpy(Add2Ptr(t, done), page_address(page),
@@ -1215,6 +1236,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
          ntfs_unmap_page(page);

          if (!idx && ATTR_STD != t->type) {
+            ntfs_err(sb, "$AttrDef is corrupted.");
              err = -EINVAL;
              goto put_inode_out;
          }
@@ -1249,13 +1271,14 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
      ref.seq = cpu_to_le16(MFT_REC_UPCASE);
      inode = ntfs_iget5(sb, &ref, &NAME_UPCASE);
      if (IS_ERR(inode)) {
-        ntfs_err(sb, "Failed to load $UpCase.");
          err = PTR_ERR(inode);
+        ntfs_err(sb, "Failed to load $UpCase (%d).", err);
          goto out;
      }

      if (inode->i_size != 0x10000 * sizeof(short)) {
          err = -EINVAL;
+        ntfs_err(sb, "$UpCase is corrupted.");
          goto put_inode_out;
      }

@@ -1266,6 +1289,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)

          if (IS_ERR(page)) {
              err = PTR_ERR(page);
+            ntfs_err(sb, "Failed to read $UpCase (%d).", err);
              goto put_inode_out;
          }

@@ -1291,23 +1315,31 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
      if (is_ntfs3(sbi)) {
          /* Load $Secure. */
          err = ntfs_security_init(sbi);
-        if (err)
+        if (err) {
+            ntfs_err(sb, "Failed to initialize $Secure (%d).", err);
              goto out;
+        }

          /* Load $Extend. */
          err = ntfs_extend_init(sbi);
-        if (err)
+        if (err) {
+            ntfs_warn(sb, "Failed to initialize $Extend.");
              goto load_root;
+        }

-        /* Load $Extend\$Reparse. */
+        /* Load $Extend/$Reparse. */
          err = ntfs_reparse_init(sbi);
-        if (err)
+        if (err) {
+            ntfs_warn(sb, "Failed to initialize $Extend/$Reparse.");
              goto load_root;
+        }

-        /* Load $Extend\$ObjId. */
+        /* Load $Extend/$ObjId. */
          err = ntfs_objid_init(sbi);
-        if (err)
+        if (err) {
+            ntfs_warn(sb, "Failed to initialize $Extend/$ObjId.");
              goto load_root;
+        }
      }

  load_root:
@@ -1316,8 +1348,8 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      ref.seq = cpu_to_le16(MFT_REC_ROOT);
      inode = ntfs_iget5(sb, &ref, &NAME_ROOT);
      if (IS_ERR(inode) || !inode->i_op) {
-        ntfs_err(sb, "Failed to load root.");
-        err = IS_ERR(inode) ? PTR_ERR(inode) : -EINVAL;
+        err = PTR_ERR(inode);
+        ntfs_err(sb, "Failed to load root (%d).", err);
          goto out;
      }

-- 
2.34.1

