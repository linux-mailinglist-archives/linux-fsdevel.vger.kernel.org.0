Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386E77B0085
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjI0Jfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjI0JfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:35:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8700F199;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D15D1FD67;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGo/Xq8dFzoPwHSosGXMbKjBfEsi3qnA9TbO9PgxH+A=;
        b=0jfiCN9Ss/zEWjO3Uz7Xxyr/uusA+ODC+6C8wy+Gsot4f+CtYzJyZFkcIDwn7OsXowIwc/
        lTxlcG4DXCatyv6iGJmNNTQhWvuopAHh1c4PO3gibAIdph4d8p0PBHL7fbAeIohJZtUm1e
        jxQaoeqR5H6LxcR35DHeWE4ExNxB6WQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGo/Xq8dFzoPwHSosGXMbKjBfEsi3qnA9TbO9PgxH+A=;
        b=lrqZh9bmOwrSKtF9MM4lXxbaOHik1cdQoiB/IpznvfdkB6GTRpNeB8v8aaNqG8WqwkL0Uk
        yTzbXH+Fam4EVkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 404AA13A74;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I0GmDzT3E2UfEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4DAB5A07E3; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/29] s390/dasd: Convert to bdev_open_by_path()
Date:   Wed, 27 Sep 2023 11:34:20 +0200
Message-Id: <20230927093442.25915-14-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6267; i=jack@suse.cz; h=from:subject; bh=eF9knwTfYejhPzvKMsCrLPavANvwOJ7CsSrEpPUTdz4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cd5GR94VDq1NxHlNaHPVCA1xSXhbvs50sJL2R6 3JywsL6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3HQAKCRCcnaoHP2RA2fY/B/ 9Spv9aycQ/FEPs2otEHRgni79oo39Dg6NdSWrGMRiGOTDZfTl/0lqnz8eEtPsLQ6bd8VLn1tQXHQWr qoOJgGnACdamDZDI2XzydPRfNk4J8RUnjwDrtV/hI0bDe588YRrlxbua3pXUqK4JbCxrcS9M27l2RE e9ptxTdEYZV8oMp5ZJbJ+U3oLs92GWvJOGRR1FaUBtEePEtzs4haRYtlXkygaLv7Ur7+ZVje7fDThW qd3th454IapTaeWMg0I1MUAkFAMAFoVoSf5/4iRgdz4kepyVIPh78mAZfUo9zJqx3ubg23z5p38cli wtD9pSM7no+oVcuPm69MzLnIJLHc6K
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert dasd to use bdev_open_by_path() and pass the handle around.

CC: linux-s390@vger.kernel.org
CC: Christian Borntraeger <borntraeger@linux.ibm.com>
CC: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/s390/block/dasd.c       | 12 +++++----
 drivers/s390/block/dasd_genhd.c | 45 ++++++++++++++++-----------------
 drivers/s390/block/dasd_int.h   |  2 +-
 drivers/s390/block/dasd_ioctl.c |  2 +-
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 215597f73be4..16a2d631a169 100644
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
 
@@ -3590,7 +3592,7 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 	 * in the other openers.
 	 */
 	if (device->block) {
-		max_count = device->block->bdev ? 0 : -1;
+		max_count = device->block->bdev_handle ? 0 : -1;
 		open_count = atomic_read(&device->block->open_count);
 		if (open_count > max_count) {
 			if (open_count > 0)
@@ -3636,8 +3638,8 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 		 * so sync bdev first and then wait for our queues to become
 		 * empty
 		 */
-		if (device->block)
-			bdev_mark_dead(device->block->bdev, false);
+		if (device->block && device->block->bdev_handle) {
+			bdev_mark_dead(device->block->bdev_handle->bdev, false);
 		dasd_schedule_device_bh(device);
 		rc = wait_event_interruptible(shutdown_waitq,
 					      _wait_for_empty_queues(device));
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index fe5108a1b332..55e3abe94cde 100644
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
+	bdev_handle = bdev_open_by_dev(disk_devt(block->gdp), BLK_OPEN_READ,
+				       NULL, NULL);
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
+	 * Since the matching bdev_release() call to the
+	 * bdev_open_by_path() in this function is not called before
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
+	bdev_release(bdev_handle);
 }
 
 int dasd_gendisk_init(void)
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 8a4dbe9d7741..2e663131adaf 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -650,7 +650,7 @@ struct dasd_block {
 	struct gendisk *gdp;
 	spinlock_t request_queue_lock;
 	struct blk_mq_tag_set tag_set;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	atomic_t open_count;
 
 	unsigned long blocks;	   /* size of volume in blocks */
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index d55862605b82..61b9675e2a67 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -537,7 +537,7 @@ static int __dasd_ioctl_information(struct dasd_block *block,
 	 * This must be hidden from user-space.
 	 */
 	dasd_info->open_count = atomic_read(&block->open_count);
-	if (!block->bdev)
+	if (!block->bdev_handle)
 		dasd_info->open_count++;
 
 	/*
-- 
2.35.3

