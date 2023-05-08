Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22BF6FB039
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjEHMiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjEHMiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 08:38:16 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B318DC41;
        Mon,  8 May 2023 05:38:12 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 0BB2221C3;
        Mon,  8 May 2023 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549204;
        bh=ozLaxeqLvZ1koAu7iHKobUtKETfbqwTAtHlsxw0uvGA=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=Tuy+0aG7q59X0miTQqawIcroIrb0MO6DRbdAf33UgW6iBCm2NMR7pLt3UIdczne9/
         bYF0sZRpzlk6eux3NkIBH9aFhnv+4IDSafaJ7AULTAArckZcq2JFYaCPiootiaRXRs
         7SrXmHgkoo6zk0XSUM6pKAlIwg3+ColKFUQXF2V0=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:38:10 +0300
Message-ID: <45f18870-379f-fa88-382c-5600e31d33a6@paragon-software.com>
Date:   Mon, 8 May 2023 16:38:09 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 05/10] fs/ntfs3: Do not update primary boot in
 ntfs_init_from_boot()
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

'cause it may be faked boot.
Let ntfs to be mounted and update boot later.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/super.c | 58 ++++++++++++++++++++++++++++++++----------------
  1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ecf899d571d8..2b48b45238ea 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -711,9 +711,16 @@ static u32 true_sectors_per_clst(const struct 
NTFS_BOOT *boot)

  /*
   * ntfs_init_from_boot - Init internal info from on-disk boot sector.
+ *
+ * NTFS mount begins from boot - special formatted 512 bytes.
+ * There are two boots: the first and the last 512 bytes of volume.
+ * The content of boot is not changed during ntfs life.
+ *
+ * NOTE: ntfs.sys checks only first (primary) boot.
+ * chkdsk checks both boots.
   */
  static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
-                   u64 dev_size)
+                   u64 dev_size, struct NTFS_BOOT **boot2)
  {
      struct ntfs_sb_info *sbi = sb->s_fs_info;
      int err;
@@ -937,23 +944,11 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,

      if (bh->b_blocknr && !sb_rdonly(sb)) {
          /*
-          * Alternative boot is ok but primary is not ok.
-          * Update primary boot.
-         */
-        struct buffer_head *bh0 = sb_getblk(sb, 0);
-        if (bh0) {
-            if (buffer_locked(bh0))
-                __wait_on_buffer(bh0);
-
-            lock_buffer(bh0);
-            memcpy(bh0->b_data, boot, sizeof(*boot));
-            set_buffer_uptodate(bh0);
-            mark_buffer_dirty(bh0);
-            unlock_buffer(bh0);
-            if (!sync_dirty_buffer(bh0))
-                ntfs_warn(sb, "primary boot is updated");
-            put_bh(bh0);
-        }
+         * Alternative boot is ok but primary is not ok.
+         * Do not update primary boot here 'cause it may be faked boot.
+         * Let ntfs to be mounted and update boot later.
+         */
+        *boot2 = kmemdup(boot, sizeof(*boot), GFP_NOFS | __GFP_NOWARN);
      }

  out:
@@ -1000,6 +995,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      u16 *shared;
      struct MFT_REF ref;
      bool ro = sb_rdonly(sb);
+    struct NTFS_BOOT *boot2 = NULL;

      ref.high = 0;

@@ -1030,7 +1026,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)

      /* Parse boot. */
      err = ntfs_init_from_boot(sb, bdev_logical_block_size(bdev),
-                  bdev_nr_bytes(bdev));
+                  bdev_nr_bytes(bdev), &boot2);
      if (err)
          goto out;

@@ -1412,6 +1408,29 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
          goto put_inode_out;
      }

+    if (boot2) {
+        /*
+         * Alternative boot is ok but primary is not ok.
+         * Volume is recognized as NTFS. Update primary boot.
+         */
+        struct buffer_head *bh0 = sb_getblk(sb, 0);
+        if (bh0) {
+            if (buffer_locked(bh0))
+                __wait_on_buffer(bh0);
+
+            lock_buffer(bh0);
+            memcpy(bh0->b_data, boot2, sizeof(*boot2));
+            set_buffer_uptodate(bh0);
+            mark_buffer_dirty(bh0);
+            unlock_buffer(bh0);
+            if (!sync_dirty_buffer(bh0))
+                ntfs_warn(sb, "primary boot is updated");
+            put_bh(bh0);
+        }
+
+        kfree(boot2);
+    }
+
      return 0;

  put_inode_out:
@@ -1424,6 +1443,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      put_mount_options(sbi->options);
      put_ntfs(sbi);
      sb->s_fs_info = NULL;
+    kfree(boot2);

      return err;
  }
-- 
2.34.1

