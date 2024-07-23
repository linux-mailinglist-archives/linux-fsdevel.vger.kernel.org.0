Return-Path: <linux-fsdevel+bounces-24122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A43939F07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 12:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A41F2822D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D9C14F117;
	Tue, 23 Jul 2024 10:54:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DD3D6A;
	Tue, 23 Jul 2024 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721732088; cv=none; b=ItmL+yhjiWuSHnboIByBpDay2qkJovsWfQ0xF+zsrqdqhZv9y59tD5o07/Oppp5plFiCQGkqgqa3J9O3F+LKC0KMOlkuwYsCIsZ/SdaEUZBsjli6FGtUgk1XjYzaJxy+BmcdvB2E7Kj1Mbei3c4gcVKXxzqZcEZWznYdR4yqUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721732088; c=relaxed/simple;
	bh=+OXyQttzSBWk5BPWVEFqYBJuog0q02ZEg5NvIb1084M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ebn+6r/E/FhJmeiJux+8u/ehYf69/31mO+/DfgtWUDJt6rxgTz7PMAdOtjlWs711gGTBFInQnXz1imTzDkDFL/er4t1XrJaAEh4HaXg1SD/oDe+g8tSo729j6q24ARaixACdFgxWQ2ZXQ9JhijDFSQ6ImD8WdamidVfDm76q1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46NAsGKk085229;
	Tue, 23 Jul 2024 18:54:16 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WSv5N3cvfz2KfVC9;
	Tue, 23 Jul 2024 18:48:40 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 23 Jul 2024 18:54:14 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <linkinjeon@kernel.org>, <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>,
        <dongliang.cui@unisoc.com>, <cuidongliang390@gmail.com>,
        Zhiguo Niu
	<zhiguo.niu@unisoc.com>
Subject: [PATCH v2] exfat: check disk status during buffer write
Date: Tue, 23 Jul 2024 18:54:12 +0800
Message-ID: <20240723105412.3615926-1-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 46NAsGKk085229

We found that when writing a large file through buffer write, if the
disk is inaccessible, exFAT does not return an error normally, which
leads to the writing process not stopping properly.

To easily reproduce this issue, you can follow the steps below:

1. format a device to exFAT and then mount (with a full disk erase)
2. dd if=/dev/zero of=/exfat_mount/test.img bs=1M count=8192
3. eject the device

You may find that the dd process does not stop immediately and may
continue for a long time.

The root cause of this issue is that during buffer write process,
exFAT does not need to access the disk to look up directory entries
or the FAT table (whereas FAT would do) every time data is written.
Instead, exFAT simply marks the buffer as dirty and returns,
delegating the writeback operation to the writeback process.

If the disk cannot be accessed at this time, the error will only be
returned to the writeback process, and the original process will not
receive the error, so it cannot be returned to the user side.

When the disk cannot be accessed normally, an error should be returned
to stop the writing process.

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
Changes in v2:
 - Refer to the block_device_ejected in ext4 for determining the
   device status.
 - Change the disk_check process to exfat_get_block to cover all
   buffer write scenarios.
---
---
 fs/exfat/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index dd894e558c91..463cebb19852 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -8,6 +8,7 @@
 #include <linux/mpage.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/backing-dev-defs.h>
 #include <linux/time.h>
 #include <linux/writeback.h>
 #include <linux/uio.h>
@@ -275,6 +276,13 @@ static int exfat_map_new_buffer(struct exfat_inode_info *ei,
 	return 0;
 }
 
+static int exfat_block_device_ejected(struct super_block *sb)
+{
+	struct backing_dev_info *bdi = sb->s_bdi;
+
+	return bdi->dev == NULL;
+}
+
 static int exfat_get_block(struct inode *inode, sector_t iblock,
 		struct buffer_head *bh_result, int create)
 {
@@ -290,6 +298,9 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	sector_t valid_blks;
 	loff_t pos;
 
+	if (exfat_block_device_ejected(sb))
+		return -ENODEV;
+
 	mutex_lock(&sbi->s_lock);
 	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);
 	if (iblock >= last_block && !create)
-- 
2.25.1


