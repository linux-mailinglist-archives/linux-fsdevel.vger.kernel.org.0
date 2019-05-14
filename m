Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4271CA94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfENOlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 10:41:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbfENOlF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 10:41:05 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E18EF30A146388AB2E1F;
        Tue, 14 May 2019 22:40:42 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 May 2019
 22:40:35 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <miaoxie@huawei.com>
Subject: [PATCH 2/2] block: add info when opening a write opend block device exclusively
Date:   Tue, 14 May 2019 22:45:06 +0800
Message-ID: <1557845106-60163-3-git-send-email-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557845106-60163-1-git-send-email-yi.zhang@huawei.com>
References: <1557845106-60163-1-git-send-email-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just like open an exclusive opened block device for write, open a block
device exclusively which has been opened for write by some other
processes may also lead to potential data corruption. This patch record
the write openers and give a hint if that happens.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/block_dev.c     | 20 ++++++++++++++++++--
 include/linux/fs.h |  1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d92aa45..c278195 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1606,6 +1606,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	bdev->bd_openers++;
 	if (for_part)
 		bdev->bd_part_count++;
+	if (mode & FMODE_WRITE)
+		bdev->bd_write_openers++;
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
 	/* only one opener holds refs to the module and disk */
@@ -1654,6 +1656,7 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 {
 	struct block_device *whole = NULL;
 	int res;
+	char name[BDEVNAME_SIZE];
 
 	WARN_ON_ONCE((mode & FMODE_EXCL) && !holder);
 
@@ -1673,6 +1676,19 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 	if (whole) {
 		struct gendisk *disk = whole->bd_disk;
 
+		/*
+		 * Open an write opened block device exclusively, the
+		 * writing process may probability corrupt the device,
+		 * such as a mounted file system, give a hint here.
+		 */
+		if (!res && (bdev->bd_write_openers >
+		    ((mode & FMODE_WRITE) ? 1 : 0)) && !bdev->bd_holders) {
+			pr_info_ratelimited("VFS: Open an write opened "
+				"block device exclusively %s [%d %s].\n",
+				bdevname(bdev, name), current->pid,
+				current->comm);
+		}
+
 		/* finish claiming */
 		if (!res) {
 			BUG_ON(!bd_may_claim(bdev, whole, holder));
@@ -1712,8 +1728,6 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 		bdput(whole);
 	} else {
 		if (!res && (mode & FMODE_WRITE) && bdev->bd_holders) {
-			char name[BDEVNAME_SIZE];
-
 			/*
 			 * Open an exclusive opened device for write may
 			 * probability corrupt the device, such as a
@@ -1848,6 +1862,8 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 	struct block_device *victim = NULL;
 
 	mutex_lock_nested(&bdev->bd_mutex, for_part);
+	if (mode & FMODE_WRITE)
+		bdev->bd_write_openers--;
 	if (for_part)
 		bdev->bd_part_count--;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28e76..0dc066d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -463,6 +463,7 @@ struct request_queue;
 struct block_device {
 	dev_t			bd_dev;  /* not a kdev_t - it's a search key */
 	int			bd_openers;
+	int			bd_write_openers;
 	struct inode *		bd_inode;	/* will die */
 	struct super_block *	bd_super;
 	struct mutex		bd_mutex;	/* open/close mutex */
-- 
2.7.4

