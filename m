Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413FE1CA91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 16:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfENOkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 10:40:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbfENOkp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 10:40:45 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E5AB338BE2D5AAD6E6A2;
        Tue, 14 May 2019 22:40:42 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 May 2019
 22:40:35 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <miaoxie@huawei.com>
Subject: [PATCH 1/2] block: add info when opening an exclusive opened block device for write
Date:   Tue, 14 May 2019 22:45:05 +0800
Message-ID: <1557845106-60163-2-git-send-email-yi.zhang@huawei.com>
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

Opening an exclusive opened block device for write make the exclusive
open isn't exclusive enough, it may lead to data corruption when some
one writing data through the counterpart raw block device, such as
corrupt a mounted file system. This patch add an info message when
opening an exclusive opened block device for write to hint the
potential data corruption.

Note that there are some legal cases such as file system or device
mapper online resize, so this message is just a hint and isn't always
mean that a risky written happens.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/block_dev.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index bb28e2e..d92aa45 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1667,13 +1667,13 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 
 	res = __blkdev_get(bdev, mode, 0);
 
+	mutex_lock(&bdev->bd_mutex);
+	spin_lock(&bdev_lock);
+
 	if (whole) {
 		struct gendisk *disk = whole->bd_disk;
 
 		/* finish claiming */
-		mutex_lock(&bdev->bd_mutex);
-		spin_lock(&bdev_lock);
-
 		if (!res) {
 			BUG_ON(!bd_may_claim(bdev, whole, holder));
 			/*
@@ -1710,6 +1710,22 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 
 		mutex_unlock(&bdev->bd_mutex);
 		bdput(whole);
+	} else {
+		if (!res && (mode & FMODE_WRITE) && bdev->bd_holders) {
+			char name[BDEVNAME_SIZE];
+
+			/*
+			 * Open an exclusive opened device for write may
+			 * probability corrupt the device, such as a
+			 * mounted file system, give a hint here.
+			 */
+			pr_info_ratelimited("VFS: Open an exclusive opened "
+				    "block device for write %s [%d %s].\n",
+				    bdevname(bdev, name), current->pid,
+				    current->comm);
+		}
+		spin_unlock(&bdev_lock);
+		mutex_unlock(&bdev->bd_mutex);
 	}
 
 	return res;
-- 
2.7.4

