Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792CFBACF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 06:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfIWEBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 00:01:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfIWEBV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 00:01:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 609AE3DBB045AC9296C6;
        Mon, 23 Sep 2019 12:01:19 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Sep 2019
 12:01:12 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>,
        <yuchao0@huawei.com>
CC:     <sunqiuyang@huawei.com>
Subject: [PATCH v2 1/1] f2fs: update multi-dev metadata in resize_fs
Date:   Mon, 23 Sep 2019 12:21:39 +0800
Message-ID: <20190923042139.36470-1-sunqiuyang@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qiuyang Sun <sunqiuyang@huawei.com>

Multi-device metadata should be updated in resize_fs as well.

Also, we check that the new FS size still reaches the last device.

--
Changelog v1 => v2:
Use f2fs_is_multi_device() and some minor cleanup.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/gc.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5877bd7..ef7686a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1437,11 +1437,20 @@ static void update_sb_metadata(struct f2fs_sb_info *sbi, int secs)
 	raw_sb->segment_count_main = cpu_to_le32(segment_count_main + segs);
 	raw_sb->block_count = cpu_to_le64(block_count +
 					(long long)segs * sbi->blocks_per_seg);
+	if (f2fs_is_multi_device(sbi)) {
+		int last_dev = sbi->s_ndevs - 1;
+		int dev_segs =
+			le32_to_cpu(raw_sb->devs[last_dev].total_segments);
+
+		raw_sb->devs[last_dev].total_segments =
+						cpu_to_le32(dev_segs + segs);
+	}
 }
 
 static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 {
 	int segs = secs * sbi->segs_per_sec;
+	long long blks = (long long)segs * sbi->blocks_per_seg;
 	long long user_block_count =
 				le64_to_cpu(F2FS_CKPT(sbi)->user_block_count);
 
@@ -1449,8 +1458,20 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
 	FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
 	FREE_I(sbi)->free_segments = (int)FREE_I(sbi)->free_segments + segs;
-	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count +
-					(long long)segs * sbi->blocks_per_seg);
+	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count + blks);
+
+	if (f2fs_is_multi_device(sbi)) {
+		int last_dev = sbi->s_ndevs - 1;
+
+		FDEV(last_dev).total_segments =
+				(int)FDEV(last_dev).total_segments + segs;
+		FDEV(last_dev).end_blk =
+				(long long)FDEV(last_dev).end_blk + blks;
+#ifdef CONFIG_BLK_DEV_ZONED
+		FDEV(last_dev).nr_blkz = (int)FDEV(last_dev).nr_blkz +
+					(int)(blks >> sbi->log_blocks_per_blkz);
+#endif
+	}
 }
 
 int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
@@ -1465,6 +1486,15 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 	if (block_count > old_block_count)
 		return -EINVAL;
 
+	if (f2fs_is_multi_device(sbi)) {
+		int last_dev = sbi->s_ndevs - 1;
+		__u64 last_segs = FDEV(last_dev).total_segments;
+
+		if (block_count + last_segs * sbi->blocks_per_seg <=
+								old_block_count)
+			return -EINVAL;
+	}
+
 	/* new fs size should align to section size */
 	div_u64_rem(block_count, BLKS_PER_SEC(sbi), &rem);
 	if (rem)
-- 
1.8.3.1

