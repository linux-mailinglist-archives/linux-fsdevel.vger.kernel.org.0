Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962AC7B0041
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjI0Jex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjI0Jer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EA5EB;
        Wed, 27 Sep 2023 02:34:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 961561F8D7;
        Wed, 27 Sep 2023 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QgpIQnjDmNXXTfavf15cac4MJ+WybBbUuZeOxK5ajkw=;
        b=U2PqreetOnT3j/f5rjV7qKgeTqCuWsixJaxaGcSTaced0tCEJh7RPZBbZbt54kNw4+/d/B
        S/8JbDIEUJ2cWmTzyWi31jLA0mt6HCd6FQBcaBOo+8YD3xm9ePFZ8vSVHZ/51HfoUvQQdS
        PphjUCX1rgXog7mD3C1fuKkTe1xTwsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807283;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QgpIQnjDmNXXTfavf15cac4MJ+WybBbUuZeOxK5ajkw=;
        b=Wdab9lgHzRmyJtM85frXJgBVrgGZsHhXZ1W6W8r+VcZHLrAa1yWH53mNl55q/PiWs/aRRw
        4BTVfuOlK/N6u1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8150013AD9;
        Wed, 27 Sep 2023 09:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v2QiHzP3E2UBEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F3807A07D0; Wed, 27 Sep 2023 11:34:42 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        drbd-dev@lists.linbit.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/29] drdb: Convert to use bdev_open_by_path()
Date:   Wed, 27 Sep 2023 11:34:10 +0200
Message-Id: <20230927093442.25915-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6072; i=jack@suse.cz; h=from:subject; bh=gnl3Ub57L77QVOFb0BLPTCxgH1FTQqMd1qtaB+Q5WHU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cUbkwPHxD2sqvKqMISxkVgj5H+oP0WetrFCMYm iVehma6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3FAAKCRCcnaoHP2RA2dBoCA CyC5zlBxdMUKtvhcGYwclIRxatRH5EJ+O5QenpvqG6H0+DDn5Xcaqe9RDSOO5++S++mGGjF1mWlaOV Wycrp9zX+pkGmCpBPdlXlJ9l2H++eM/FdinBfACIUHu/Fu/gxy6FaEx85qnoio0bGzNDMnXXB6WN/e CowvfUjd9WkgP0gZ9Se+AeOh8B4aZnyVWnkdaBnvdmTu7xnAh14zoRFuzDBGRdGEL8I6IBq1WVsGHz qCY1S0NmnWeo9RCCDBkODCYRApq+kMiN5Rs0w4ldv5gVO1V4nubf0xMXWyL1kvKeEsWz+TGe1nMJdd 3QgWrKFFeLgjalKE2zpYCfc+viBjXq
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

Convert drdb to use bdev_open_by_path().

CC: drbd-dev@lists.linbit.com
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/drbd/drbd_int.h |  2 ++
 drivers/block/drbd/drbd_nl.c  | 65 +++++++++++++++++------------------
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index a30a5ed811be..f017e917612b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -524,7 +524,9 @@ struct drbd_md {
 
 struct drbd_backing_dev {
 	struct block_device *backing_bdev;
+	struct bdev_handle *backing_bdev_handle;
 	struct block_device *md_bdev;
+	struct bdev_handle *md_bdev_handle;
 	struct drbd_md md;
 	struct disk_conf *disk_conf; /* RCU, for updates: resource->conf_update */
 	sector_t known_size; /* last known size of that backing device */
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d3538bd83fb3..43747a1aae43 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -82,7 +82,7 @@ static atomic_t notify_genl_seq = ATOMIC_INIT(2); /* two. */
 
 DEFINE_MUTEX(notification_mutex);
 
-/* used blkdev_get_by_path, to claim our meta data device(s) */
+/* used bdev_open_by_path, to claim our meta data device(s) */
 static char *drbd_m_holder = "Hands off! this is DRBD's meta data device.";
 
 static void drbd_adm_send_reply(struct sk_buff *skb, struct genl_info *info)
@@ -1635,43 +1635,45 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static struct block_device *open_backing_dev(struct drbd_device *device,
+static struct bdev_handle *open_backing_dev(struct drbd_device *device,
 		const char *bdev_path, void *claim_ptr, bool do_bd_link)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
 	int err = 0;
 
-	bdev = blkdev_get_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				  claim_ptr, NULL);
-	if (IS_ERR(bdev)) {
+	handle = bdev_open_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
+				   claim_ptr, NULL);
+	if (IS_ERR(handle)) {
 		drbd_err(device, "open(\"%s\") failed with %ld\n",
-				bdev_path, PTR_ERR(bdev));
-		return bdev;
+				bdev_path, PTR_ERR(handle));
+		return handle;
 	}
 
 	if (!do_bd_link)
-		return bdev;
+		return handle;
 
-	err = bd_link_disk_holder(bdev, device->vdisk);
+	err = bd_link_disk_holder(handle->bdev, device->vdisk);
 	if (err) {
-		blkdev_put(bdev, claim_ptr);
+		bdev_release(handle);
 		drbd_err(device, "bd_link_disk_holder(\"%s\", ...) failed with %d\n",
 				bdev_path, err);
-		bdev = ERR_PTR(err);
+		handle = ERR_PTR(err);
 	}
-	return bdev;
+	return handle;
 }
 
 static int open_backing_devices(struct drbd_device *device,
 		struct disk_conf *new_disk_conf,
 		struct drbd_backing_dev *nbc)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
 
-	bdev = open_backing_dev(device, new_disk_conf->backing_dev, device, true);
-	if (IS_ERR(bdev))
+	handle = open_backing_dev(device, new_disk_conf->backing_dev, device,
+				  true);
+	if (IS_ERR(handle))
 		return ERR_OPEN_DISK;
-	nbc->backing_bdev = bdev;
+	nbc->backing_bdev = handle->bdev;
+	nbc->backing_bdev_handle = handle;
 
 	/*
 	 * meta_dev_idx >= 0: external fixed size, possibly multiple
@@ -1681,7 +1683,7 @@ static int open_backing_devices(struct drbd_device *device,
 	 * should check it for you already; but if you don't, or
 	 * someone fooled it, we need to double check here)
 	 */
-	bdev = open_backing_dev(device, new_disk_conf->meta_dev,
+	handle = open_backing_dev(device, new_disk_conf->meta_dev,
 		/* claim ptr: device, if claimed exclusively; shared drbd_m_holder,
 		 * if potentially shared with other drbd minors */
 			(new_disk_conf->meta_dev_idx < 0) ? (void*)device : (void*)drbd_m_holder,
@@ -1689,20 +1691,21 @@ static int open_backing_devices(struct drbd_device *device,
 		 * as would happen with internal metadata. */
 			(new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_FLEX_INT &&
 			 new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_INTERNAL));
-	if (IS_ERR(bdev))
+	if (IS_ERR(handle))
 		return ERR_OPEN_MD_DISK;
-	nbc->md_bdev = bdev;
+	nbc->md_bdev = handle->bdev;
+	nbc->md_bdev_handle = handle;
 	return NO_ERROR;
 }
 
-static void close_backing_dev(struct drbd_device *device, struct block_device *bdev,
-		void *claim_ptr, bool do_bd_unlink)
+static void close_backing_dev(struct drbd_device *device,
+		struct bdev_handle *handle, bool do_bd_unlink)
 {
-	if (!bdev)
+	if (!handle)
 		return;
 	if (do_bd_unlink)
-		bd_unlink_disk_holder(bdev, device->vdisk);
-	blkdev_put(bdev, claim_ptr);
+		bd_unlink_disk_holder(handle->bdev, device->vdisk);
+	bdev_release(handle);
 }
 
 void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev)
@@ -1710,11 +1713,9 @@ void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *
 	if (ldev == NULL)
 		return;
 
-	close_backing_dev(device, ldev->md_bdev,
-			  ldev->md.meta_dev_idx < 0 ?
-				(void *)device : (void *)drbd_m_holder,
+	close_backing_dev(device, ldev->md_bdev_handle,
 			  ldev->md_bdev != ldev->backing_bdev);
-	close_backing_dev(device, ldev->backing_bdev, device, true);
+	close_backing_dev(device, ldev->backing_bdev_handle, true);
 
 	kfree(ldev->disk_conf);
 	kfree(ldev);
@@ -2130,11 +2131,9 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
  fail:
 	conn_reconfig_done(connection);
 	if (nbc) {
-		close_backing_dev(device, nbc->md_bdev,
-			  nbc->disk_conf->meta_dev_idx < 0 ?
-				(void *)device : (void *)drbd_m_holder,
+		close_backing_dev(device, nbc->md_bdev_handle,
 			  nbc->md_bdev != nbc->backing_bdev);
-		close_backing_dev(device, nbc->backing_bdev, device, true);
+		close_backing_dev(device, nbc->backing_bdev_handle, true);
 		kfree(nbc);
 	}
 	kfree(new_disk_conf);
-- 
2.35.3

