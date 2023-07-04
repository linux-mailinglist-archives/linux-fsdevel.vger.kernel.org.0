Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2409747108
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGDMXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjGDMWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:22:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC2F10D9;
        Tue,  4 Jul 2023 05:22:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4140C20567;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sv6zbBELQNdBo4LWXFyltsCcFrQxbmkTmOjmsQTGqoo=;
        b=wNxO136vMN5h6P1TOfBUcK/Wq5A9vQIDSWiZKk9Oyyeou8ng+7m4zjV+Mlx8AttK1QDTc6
        SX7b1KvQAknDbyhlmzkS9L4zX9woHEbBLbaOVs2KljjNERJzG8kkIz2uCRmiLmA6QyV3zk
        bFJecRtFkN2Iecs9yasuL3IQ7Hpe/7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sv6zbBELQNdBo4LWXFyltsCcFrQxbmkTmOjmsQTGqoo=;
        b=BjCS1L+sc54JD5m6ts19mjjoSvkexXFp/mnqw3m61e0rWAk6k/U5iGVXZCm8NUl9phPwra
        L/3jvwdafzP/RXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FE661346D;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IQWtCwIPpGQ6MAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E821EA0774; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 15/32] s390/dasd: Convert to blkdev_get_handle_by_path()
Date:   Tue,  4 Jul 2023 14:21:42 +0200
Message-Id: <20230704122224.16257-15-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6108; i=jack@suse.cz; h=from:subject; bh=NBDkzEoul8WWwq8hJesDDPRwVqLkL/nBohAK9k5HjE4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7XD0swbhIQYEbA5f1M/fHIud1VZj7p+sQqq4RU tc2/xjiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO1wAKCRCcnaoHP2RA2UjFB/ 40txPIFSoGJmutaVWyd8vT8I45yJe6Sjq5l8XSLfM+gPvzzmqYtBHg7NmQFrMEaZs0Ke8ApH8FtC0y i4TlM1ol63jJwOr6Sv0sFAdvMIL13+HiPUXsZiDh5HMHuT3NVsmvnV+1zh/qcQmUXiEZ4rs5waymaS yMs1YsKhWlvRYCs3Cu4CB241WDWmA4WCIDpDVDJt7o3u3/HziKiHHp0y46btGF6lT4n3bRXtsRrrzO EUUV5tX6i95RbcjgOrvYx+t6B2QqepHFEeaYjXJobgZ3uDTYW653mEcJvRtFeqrAL+9ey60iQxFzsk Sj8hnUDx9vjJlXonQgLcaBFbJC+Na/
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert dasd to use blkdev_get_handle_by_path() and pass the handle
around.

CC: linux-s390@vger.kernel.org
CC: Christian Borntraeger <borntraeger@linux.ibm.com>
CC: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/s390/block/dasd.c       | 12 +++++----
 drivers/s390/block/dasd_genhd.c | 45 ++++++++++++++++-----------------
 drivers/s390/block/dasd_int.h   |  2 +-
 drivers/s390/block/dasd_ioctl.c |  2 +-
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index edcbf77852c3..bd46d37a7c92 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -412,7 +412,8 @@ dasd_state_ready_to_online(struct dasd_device * device)
 					KOBJ_CHANGE);
 			return 0;
 		}
-		disk_uevent(device->block->bdev->bd_disk, KOBJ_CHANGE);
+		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
+			    KOBJ_CHANGE);
 	}
 	return 0;
 }
@@ -432,7 +433,8 @@ static int dasd_state_online_to_ready(struct dasd_device *device)
 
 	device->state = DASD_STATE_READY;
 	if (device->block && !(device->features & DASD_FEATURE_USERAW))
-		disk_uevent(device->block->bdev->bd_disk, KOBJ_CHANGE);
+		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
+			    KOBJ_CHANGE);
 	return 0;
 }
 
@@ -3580,7 +3582,7 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 	 * in the other openers.
 	 */
 	if (device->block) {
-		max_count = device->block->bdev ? 0 : -1;
+		max_count = device->block->bdev_handle ? 0 : -1;
 		open_count = atomic_read(&device->block->open_count);
 		if (open_count > max_count) {
 			if (open_count > 0)
@@ -3626,8 +3628,8 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 		 * so sync bdev first and then wait for our queues to become
 		 * empty
 		 */
-		if (device->block) {
-			rc = fsync_bdev(device->block->bdev);
+		if (device->block && device->block->bdev_handle) {
+			rc = fsync_bdev(device->block->bdev_handle->bdev);
 			if (rc != 0)
 				goto interrupted;
 		}
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index fe5108a1b332..1c22a5ee2ce7 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -127,15 +127,15 @@ void dasd_gendisk_free(struct dasd_block *block)
  */
 int dasd_scan_partitions(struct dasd_block *block)
 {
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	int rc;
 
-	bdev = blkdev_get_by_dev(disk_devt(block->gdp), BLK_OPEN_READ, NULL,
-				 NULL);
-	if (IS_ERR(bdev)) {
+	bdev_handle = blkdev_get_handle_by_dev(disk_devt(block->gdp),
+				BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(bdev_handle)) {
 		DBF_DEV_EVENT(DBF_ERR, block->base,
 			      "scan partitions error, blkdev_get returned %ld",
-			      PTR_ERR(bdev));
+			      PTR_ERR(bdev_handle));
 		return -ENODEV;
 	}
 
@@ -147,16 +147,15 @@ int dasd_scan_partitions(struct dasd_block *block)
 				"scan partitions error, rc %d", rc);
 
 	/*
-	 * Since the matching blkdev_put call to the blkdev_get in
-	 * this function is not called before dasd_destroy_partitions
-	 * the offline open_count limit needs to be increased from
-	 * 0 to 1. This is done by setting device->bdev (see
-	 * dasd_generic_set_offline). As long as the partition
-	 * detection is running no offline should be allowed. That
-	 * is why the assignment to device->bdev is done AFTER
-	 * the BLKRRPART ioctl.
+	 * Since the matching blkdev_handle_put() call to the
+	 * blkdev_get_handle_by_path() in this function is not called before
+	 * dasd_destroy_partitions the offline open_count limit needs to be
+	 * increased from 0 to 1. This is done by setting device->bdev_handle
+	 * (see dasd_generic_set_offline). As long as the partition detection
+	 * is running no offline should be allowed. That is why the assignment
+	 * to block->bdev_handle is done AFTER the BLKRRPART ioctl.
 	 */
-	block->bdev = bdev;
+	block->bdev_handle = bdev_handle;
 	return 0;
 }
 
@@ -166,21 +165,21 @@ int dasd_scan_partitions(struct dasd_block *block)
  */
 void dasd_destroy_partitions(struct dasd_block *block)
 {
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 
 	/*
-	 * Get the bdev pointer from the device structure and clear
-	 * device->bdev to lower the offline open_count limit again.
+	 * Get the bdev_handle pointer from the device structure and clear
+	 * device->bdev_handle to lower the offline open_count limit again.
 	 */
-	bdev = block->bdev;
-	block->bdev = NULL;
+	bdev_handle = block->bdev_handle;
+	block->bdev_handle = NULL;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
-	bdev_disk_changed(bdev->bd_disk, true);
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_lock(&bdev_handle->bdev->bd_disk->open_mutex);
+	bdev_disk_changed(bdev_handle->bdev->bd_disk, true);
+	mutex_unlock(&bdev_handle->bdev->bd_disk->open_mutex);
 
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
-	blkdev_put(bdev, NULL);
+	blkdev_handle_put(bdev_handle);
 }
 
 int dasd_gendisk_init(void)
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 0aa56351da72..73c5eb0ae6ad 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -646,7 +646,7 @@ struct dasd_block {
 	struct gendisk *gdp;
 	spinlock_t request_queue_lock;
 	struct blk_mq_tag_set tag_set;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	atomic_t open_count;
 
 	unsigned long blocks;	   /* size of volume in blocks */
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 513a7e6eee63..2657508349f6 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -536,7 +536,7 @@ static int __dasd_ioctl_information(struct dasd_block *block,
 	 * This must be hidden from user-space.
 	 */
 	dasd_info->open_count = atomic_read(&block->open_count);
-	if (!block->bdev)
+	if (!block->bdev_handle)
 		dasd_info->open_count++;
 
 	/*
-- 
2.35.3

