Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBCFBACFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 06:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfIWECZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 00:02:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfIWECY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 00:02:24 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15F0A4B3AC57B70D4077;
        Mon, 23 Sep 2019 12:02:23 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Sep 2019
 12:02:14 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>,
        <yuchao0@huawei.com>
CC:     <sunqiuyang@huawei.com>
Subject: [PATCH 1/1] f2fs: check total_segments from devices in raw_super
Date:   Mon, 23 Sep 2019 12:22:35 +0800
Message-ID: <20190923042235.37286-1-sunqiuyang@huawei.com>
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

For multi-device F2FS, we should check if the sum of total_segments from
all devices matches segment_count.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/super.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 04788a6..9a09d59 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2602,6 +2602,21 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return -EFSCORRUPTED;
 	}
 
+	if (RDEV(0).path[0]) {
+		block_t dev_seg_count = le32_to_cpu(RDEV(0).total_segments);
+		int i = 1;
+
+		while (i < MAX_DEVICES && RDEV(i).path[0]) {
+			dev_seg_count += le32_to_cpu(RDEV(i).total_segments);
+			i++;
+		}
+		if (segment_count != dev_seg_count) {
+			f2fs_info(sbi, "Segment count (%u) mismatch with total segments from devices (%u)",
+					segment_count, dev_seg_count);
+			return -EFSCORRUPTED;
+		}
+	}
+
 	if (secs_per_zone > total_sections || !secs_per_zone) {
 		f2fs_info(sbi, "Wrong secs_per_zone / total_sections (%u, %u)",
 			  secs_per_zone, total_sections);
-- 
1.8.3.1

