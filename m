Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12393345A15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 09:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCWIwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 04:52:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51947 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCWIwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:52:31 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lOcm3-0005JG-Gg; Tue, 23 Mar 2021 08:52:28 +0000
From:   chris.chiu@canonical.com
To:     viro@zeniv.linux.org.uk, hch@lst.de, axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] block: clear GD_NEED_PART_SCAN later in bdev_disk_changed
Date:   Tue, 23 Mar 2021 16:52:19 +0800
Message-Id: <20210323085219.24428-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

The GD_NEED_PART_SCAN is set by bdev_check_media_change to initiate
a partition scan while removing a block device. It should be cleared
after blk_drop_paritions because blk_drop_paritions could return
-EBUSY and then the consequence __blkdev_get has no chance to do
delete_partition if GD_NEED_PART_SCAN already cleared.

It causes some problems on some card readers. Ex. Realtek card
reader 0bda:0328 and 0bda:0158. The device node of the partition
will not disappear after the memory card removed. Thus the user
applications can not update the device mapping correctly.

BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1920874
Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 fs/block_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 92ed7d5df677..28d583fcdc2c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1240,13 +1240,13 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
-	clear_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
-
 rescan:
 	ret = blk_drop_partitions(bdev);
 	if (ret)
 		return ret;
 
+	clear_bit(GD_NEED_PART_SCAN, &disk->state);
+
 	/*
 	 * Historically we only set the capacity to zero for devices that
 	 * support partitions (independ of actually having partitions created).
-- 
2.20.1

