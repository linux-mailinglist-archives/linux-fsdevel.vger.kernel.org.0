Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92609785624
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjHWKud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjHWKuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:50:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F997E5C;
        Wed, 23 Aug 2023 03:49:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9975C2074E;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gtvKl0NfsHO8JHkLE0cuVXIiAj+C8VAx7zuDTuFkO0=;
        b=CABKYBRF3yM+9JgT7Exs+R7xjbNFtDWjQL7LUHuj9WmtNCPsOoSSAmvOxkA6ccHTRh2ee4
        8QGziz6ShwUuP8q7XogjjdXAW9/Je2/ClPmLUEBGA/MMnyah2wRMd7xXpDxjaABYo9cy++
        N26utEOEN3xgj0Ukpu+PHV4EZKI+/4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gtvKl0NfsHO8JHkLE0cuVXIiAj+C8VAx7zuDTuFkO0=;
        b=AscAiqOdJ+JJcFHJ9zy1V1JCMjVOUwmutR5rxmKM3eTkGzwAwk1T/3HT4x+4hBMjegLZ2c
        +PABs97BbzW6CjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 868BC13A1B;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u7TZIBrk5WRHIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5B437A078E; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/29] s390/dasd: Convert to bdev_open_by_path()
Date:   Wed, 23 Aug 2023 12:48:25 +0200
Message-Id: <20230823104857.11437-14-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6217; i=jack@suse.cz; h=from:subject; bh=+XrMCFOgQM1AzqlSeLoPponKS4AG2cfn0I/kpH6C150=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP6o7BWHCIoj5lJBB2O7UwUusqmrNU9lvT6299k teLovmKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj+gAKCRCcnaoHP2RA2XYMB/ 9Kptk9IyD9pIfhLdH9xABmzkvzfu1M8s5IifYFGt4wUmKfHXrHP0V8/Vhkwa4eXBlFojK5kGPACtJl g/zwOTg1jsFtK/w2GYglrM1MYp+0+m/1hx42rBHBALPVNm53nfgpAV0H6XcMoF6PPcFGOp1BwwmW9M ilec6icsXwsCXuztrPokUzANninTJPcX9tpWaWAM+wK4Ay5uXt0I4FnMPIlAdp85suQW3lzdVhYoMo ToQralYq2Qsrv5a3voSpl5T78BHJ7tZ5V615bJDg0kxx5ap/qGl56Ddv56D3J4E85vi18VZUPISuCK acsiI5CFQsBZvD622YsJfiwteTGkZt
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

