Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E22C778CC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjHKLFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjHKLFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553F410DE;
        Fri, 11 Aug 2023 04:05:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC4722187D;
        Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62K7rmAiQlT4QiIMgUmahyvAENx33WnRwusS+e6awFw=;
        b=WuD5vrmr3XVc5ZKVXU6zY5Sj6T7x7AAbovLYbdZRYlo4zkKtj5e/PC5sqzL0Jy1dwdnKNd
        vwcMX2ea8HiOWZ/XQ4VV6hxcWOBjUicu8SN+0VmCJQRtnqy1CxBPBwY4VY5iyqS9yZJMy9
        BieoyqKkgh46CTDBUJQomtmHOInJGJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62K7rmAiQlT4QiIMgUmahyvAENx33WnRwusS+e6awFw=;
        b=b47DlquH2y42BUs1Euci8FoHZUSNF39JrvbebZkC90UwuMarbXPt68wJanMAP18jEBUXCK
        178cJac1+fMd9dDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDE9813A95;
        Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bohBMuEV1mRQRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 14967A078D; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 14/29] s390/dasd: Convert to bdev_open_by_path()
Date:   Fri, 11 Aug 2023 13:04:45 +0200
Message-Id: <20230811110504.27514-14-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6080; i=jack@suse.cz; h=from:subject; bh=0WZHEI2sSL3SXZX4/9rho4Z8TGlkksR/XxY1b45NdMo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXPEqbPsRCUjAJyCIIc5SLwP3SUthUfb22xCLNc Td93p/KJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYVzwAKCRCcnaoHP2RA2bgACA Cs2ku6xgO5K/MLN8y3rKpyYxbylHofMZz5gwtrRpxbHXPz0kC9YTkiOs+QQk99UP8ZQ8e1qv3aiVX2 BAshT3HdlrcqZyBtnOppmgz5y7c9gCrdTyCig+ipFHuLJCe/QsNP1tOdZJcO/wZCSO+hfXP0UXT2m0 gbFNebziHdqnuXRp6L8pNZrXvNQKguOHNwXCpblaRbqpHQ1BYyMfZSXh0qHmGGDewCg5sBQY1zYuWk +KO9joJ5X6d76p8iEhQ24NgwMSeoUdPBzWYfZj+p52cvStdP/VUudO5YTaDGWQeGsDI+DJvlpqfW2K dZ/QqQtjO3iAE+P67b5HwcsXTIRIPK
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert dasd to use bdev_open_by_path() and pass the handle around.

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
index 50a5ff70814a..b12f5719193f 100644
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
-		if (device->block) {
-			rc = fsync_bdev(device->block->bdev);
+		if (device->block && device->block->bdev_handle) {
+			rc = fsync_bdev(device->block->bdev_handle->bdev);
 			if (rc != 0)
 				goto interrupted;
 		}
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

