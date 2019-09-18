Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9AEB6345
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 14:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfIRMcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 08:32:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfIRMcF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:32:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9643E23F11B82F483979;
        Wed, 18 Sep 2019 20:31:56 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Sep 2019
 20:31:47 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>,
        <yuchao0@huawei.com>
CC:     <sunqiuyang@huawei.com>
Subject: [PATCH 1/1] f2fs: update multi-dev metadata in resize_fs
Date:   Wed, 18 Sep 2019 20:51:58 +0800
Message-ID: <20190918125158.12126-1-sunqiuyang@huawei.com>
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

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/gc.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5877bd7..a2b8cbe 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1431,26 +1431,46 @@ static void update_sb_metadata(struct f2fs_sb_info *sbi, int secs)
 	int segment_count_main = le32_to_cpu(raw_sb->segment_count_main);
 	long long block_count = le64_to_cpu(raw_sb->block_count);
 	int segs = secs * sbi->segs_per_sec;
+	int ndevs = sbi->s_ndevs;
 
 	raw_sb->section_count = cpu_to_le32(section_count + secs);
 	raw_sb->segment_count = cpu_to_le32(segment_count + segs);
 	raw_sb->segment_count_main = cpu_to_le32(segment_count_main + segs);
 	raw_sb->block_count = cpu_to_le64(block_count +
 					(long long)segs * sbi->blocks_per_seg);
+	if (ndevs > 1) {
+		int dev_segs =
+			le32_to_cpu(raw_sb->devs[ndevs - 1].total_segments);
+
+		raw_sb->devs[ndevs - 1].total_segments =
+						cpu_to_le32(dev_segs + segs);
+	}
 }
 
 static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 {
 	int segs = secs * sbi->segs_per_sec;
+	long long blks = (long long)segs * sbi->blocks_per_seg;
 	long long user_block_count =
 				le64_to_cpu(F2FS_CKPT(sbi)->user_block_count);
+	int ndevs = sbi->s_ndevs;
 
 	SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
 	MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
 	FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
 	FREE_I(sbi)->free_segments = (int)FREE_I(sbi)->free_segments + segs;
-	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count +
-					(long long)segs * sbi->blocks_per_seg);
+	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count + blks);
+
+	if (ndevs > 1) {
+		FDEV(ndevs - 1).total_segments =
+				(int)FDEV(ndevs - 1).total_segments + segs;
+		FDEV(ndevs - 1).end_blk =
+				(long long)FDEV(ndevs - 1).end_blk + blks;
+#ifdef CONFIG_BLK_DEV_ZONED
+		FDEV(ndevs - 1).nr_blkz = (int)FDEV(ndevs - 1).nr_blkz +
+					(int)(blks >> sbi->log_blocks_per_blkz);
+#endif
+	}
 }
 
 int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
@@ -1465,6 +1485,14 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 	if (block_count > old_block_count)
 		return -EINVAL;
 
+	if (sbi->s_ndevs > 1) {
+		__u64 last_segs = FDEV(sbi->s_ndevs - 1).total_segments;
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

