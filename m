Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FE4BB093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 05:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiBREOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 23:14:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiBREOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:14:45 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0909C583B3;
        Thu, 17 Feb 2022 20:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645157671; x=1676693671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmPIjpewGCJOu9G/+dKDKauMFI4fs+l1B9VuuJ5HnYI=;
  b=l1xL4+YCWJhtewoNt2WpWb30i08iY73hhMlXYJOXd4atbedUOu8+DIVN
   MSsPMupPdkrkXKTx4L6Vr/S6T7RXJL3bF3HqK/vKhTDHRf5rFwD+iknhO
   mI/g0Q9ISNYv+OEJ90/aFcQ+rYoVnpwj5rGRFgYiIZEsTKBQyrdTsxjoh
   p9IcfgRq4X1gTkhoVTP0T0LwLB0QwGjuLqcMRWapmhpn5xqXRpqDjYcVD
   OlqW8TdxA8V1ZhctRU0HdGc9NSOunnkACC9HVMKJvXKLJdtxP46nqKlEf
   bgJ+1/34zyEVUQNpCs/BoSWUpZ3Hp7arLIaw5BI55+EZHhh/JPUI8RqKO
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,377,1635177600"; 
   d="scan'208";a="194229488"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 12:14:26 +0800
IronPort-SDR: E3ulqe1AqestnOeiUVPYps+N4OpQlX0OtXWtHeG5zP9lx7x+KcA6OzKgVPll4bQWRxFtaXoCux
 1AEJZHQiXsPU1bj0ieg/BgEe2UwNTEGFPWoF2PpgTvGlRMjlaaWGV2TceElqbHVtxQ4fA/ZKhV
 h2/48otwJEePK55duhhE7TC9CU/8vD/5V5csT205csn1w825vr0o5Nb4PaCt+rQZfanAvWfSHn
 yu5t43tAFHNTi6wGU7w/4qM1gCSh/zyy0QPXTgiDBn+FE36zbu/iCMpkY/7fBWW2Zziq42NFzU
 Z9iEYVwMECnf5CA1BIl9RByM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:46:03 -0800
IronPort-SDR: 3Dx7Myu9COEzxVpaLXuXsPaJn+hPnNSP0mtOh0u8UpNlZxlfeZlc28k2bUrL4pFnaCTLtgVHZu
 2x/CBgIoNKvlgufg7ZCDr3/yCzHq7VJ37qkmgb4XCfzCw/O41kanwrbWjz6lEDOVN7xHR0+REx
 koetYnyyklbjDvkcaxaGAWlv46paxAlLSA2YXJQwLvLkFASennI+Hz+XnlwTDvXMl5l/wb1Ghp
 WnqEcpg4lETghUlK74DMyNviV18s6wRugLEXXsGriBYQeDB/WJciSRV07TVWTa23RclBx9Ri0e
 KHY=
WDCIronportException: Internal
Received: from fdxrrn2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.54.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Feb 2022 20:14:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 2/2] btrfs: zoned: mark relocation as writing
Date:   Fri, 18 Feb 2022 13:14:19 +0900
Message-Id: <01fa2ddededefc7f03ca4d6df2cccfdbf550aa26.1645157220.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645157220.git.naohiro.aota@wdc.com>
References: <cover.1645157220.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a hung_task issue with running generic/068 on an SMR
device. The hang occurs while a process is trying to thaw the
filesystem. The process is trying to take sb->s_umount to thaw the
FS. The lock is held by fsstress, which calls btrfs_sync_fs() and is
waiting for an ordered extent to finish. However, as the FS is frozen,
the ordered extent never finish.

Having an ordered extent while the FS is frozen is the root cause of
the hang. The ordered extent is initiated from btrfs_relocate_chunk()
which is called from btrfs_reclaim_bgs_work().

This commit add sb_*_write() around btrfs_relocate_chunk() call
site. For the usual "btrfs balance" command, we already call it with
mnt_want_file() in btrfs_ioctl_balance().

Additionally, add an ASSERT in btrfs_relocate_chunk() to check it is
properly called.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
Cc: stable@vger.kernel.org # 5.13+
Link: https://github.com/naota/linux/issues/56
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 8 +++++++-
 fs/btrfs/volumes.c     | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3113f6d7f335..c22d287e020b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1522,8 +1522,12 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
 
-	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
+	sb_start_write(fs_info->sb);
+
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
+		sb_end_write(fs_info->sb);
 		return;
+	}
 
 	/*
 	 * Long running balances can keep us blocked here for eternity, so
@@ -1531,6 +1535,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	 */
 	if (!mutex_trylock(&fs_info->reclaim_bgs_lock)) {
 		btrfs_exclop_finish(fs_info);
+		sb_end_write(fs_info->sb);
 		return;
 	}
 
@@ -1605,6 +1610,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_exclop_finish(fs_info);
+	sb_end_write(fs_info->sb);
 }
 
 void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa7fee09e39b..74c8024d8f96 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3240,6 +3240,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	u64 length;
 	int ret;
 
+	/* Assert we called sb_start_write(), not to race with FS freezing */
+	ASSERT(sb_write_started(fs_info->sb));
+
 	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
 		btrfs_err(fs_info,
 			  "relocate: not supported on extent tree v2 yet");
@@ -8304,10 +8307,12 @@ static int relocating_repair_kthread(void *data)
 	target = cache->start;
 	btrfs_put_block_group(cache);
 
+	sb_start_write(fs_info->sb);
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
 		btrfs_info(fs_info,
 			   "zoned: skip relocating block group %llu to repair: EBUSY",
 			   target);
+		sb_end_write(fs_info->sb);
 		return -EBUSY;
 	}
 
@@ -8335,6 +8340,7 @@ static int relocating_repair_kthread(void *data)
 		btrfs_put_block_group(cache);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_exclop_finish(fs_info);
+	sb_end_write(fs_info->sb);
 
 	return ret;
 }
-- 
2.35.1

