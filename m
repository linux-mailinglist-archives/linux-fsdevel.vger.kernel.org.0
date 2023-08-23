Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556C878561D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjHWKub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjHWKuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:50:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3519E5A;
        Wed, 23 Aug 2023 03:49:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD73121F46;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLp8wxdpKpq8KTQotrZDbbnw1nZi05RZ0xIeaAOP2x4=;
        b=i4MLB5+BZGRlAVIOnQNWV2KtbDqP1LLiqJk8XnLozBQIqF4hGi7oPeFBJH2l60Ho8NJGSa
        38FppjxGs16pCwGz/xlaVDAcpkTn7I/iorICvcjpqttBqIEKG5T561IX5lFk2wHLktBgIt
        aw+PKxy0GOtQ4H23RIQ7UOWko3SI/PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLp8wxdpKpq8KTQotrZDbbnw1nZi05RZ0xIeaAOP2x4=;
        b=kUSs9Z3bn6eUI+XIoAhTpobeuWWFRDqiEp52dbKNrSXgOuxDaXisMSpHLNC6FJnimgg8cv
        /UadFtIImI/NKUCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C35EA13592;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eyenLxrk5WRTIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 60F96A078F; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/29] scsi: target: Convert to bdev_open_by_path()
Date:   Wed, 23 Aug 2023 12:48:26 +0200
Message-Id: <20230823104857.11437-15-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5419; i=jack@suse.cz; h=from:subject; bh=6kZvIq8BZizDHY8AGnmJ3i/dK8lV3iBpu+CtF7nME7M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP7oIFf66pcHWOaFjbkKBeqFiapoWsAciZgdrSG K/m0GauJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj+wAKCRCcnaoHP2RA2f9CCA CDmUs+SH0RqU6uC1VVkYLvqWDeQV/uOmRnoGAWfEvQ98+vHWaRygHr9PXLFYuCT+I4H/caIfK6Chma wQAvV1jLDwita3AK8vwlMF1/7pioa1XLFQQErVXXUUW3gtIxERfB0+ew2qJEs1TGFc+nqWNEKZtUKo NyCeyCR8ViEFw9XP8kR0bi3rJ9stipaMNRm4oH2C8HZEitR09hdGB5S26BeNgZNB6C+p1W7bs340// OX9+ivxqM65EbX4frfp75G+jrdY7aOfpDaD9HTOs6G9xgkBoq/pWOMDNci9AiriBXOnJkk5dWolPcG gWBu8s0+jJkIspiGCW2u3LDKCZE4mA
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert iblock and pscsi drivers to use bdev_open_by_path() and pass the
handle around.

CC: target-devel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/target/target_core_iblock.c | 19 +++++++++++--------
 drivers/target/target_core_iblock.h |  1 +
 drivers/target/target_core_pscsi.c  | 26 +++++++++++++-------------
 drivers/target/target_core_pscsi.h  |  2 +-
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 3d1b511ea284..3695a9f8d8a5 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -91,7 +91,8 @@ static int iblock_configure_device(struct se_device *dev)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 	struct request_queue *q;
-	struct block_device *bd = NULL;
+	struct bdev_handle *bdev_handle;
+	struct block_device *bd;
 	struct blk_integrity *bi;
 	blk_mode_t mode = BLK_OPEN_READ;
 	unsigned int max_write_zeroes_sectors;
@@ -116,12 +117,14 @@ static int iblock_configure_device(struct se_device *dev)
 	else
 		dev->dev_flags |= DF_READ_ONLY;
 
-	bd = blkdev_get_by_path(ib_dev->ibd_udev_path, mode, ib_dev, NULL);
-	if (IS_ERR(bd)) {
-		ret = PTR_ERR(bd);
+	bdev_handle = bdev_open_by_path(ib_dev->ibd_udev_path, mode, ib_dev,
+					NULL);
+	if (IS_ERR(bdev_handle)) {
+		ret = PTR_ERR(bdev_handle);
 		goto out_free_bioset;
 	}
-	ib_dev->ibd_bd = bd;
+	ib_dev->ibd_bdev_handle = bdev_handle;
+	ib_dev->ibd_bd = bd = bdev_handle->bdev;
 
 	q = bdev_get_queue(bd);
 
@@ -177,7 +180,7 @@ static int iblock_configure_device(struct se_device *dev)
 	return 0;
 
 out_blkdev_put:
-	blkdev_put(ib_dev->ibd_bd, ib_dev);
+	bdev_release(ib_dev->ibd_bdev_handle);
 out_free_bioset:
 	bioset_exit(&ib_dev->ibd_bio_set);
 out:
@@ -202,8 +205,8 @@ static void iblock_destroy_device(struct se_device *dev)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 
-	if (ib_dev->ibd_bd != NULL)
-		blkdev_put(ib_dev->ibd_bd, ib_dev);
+	if (ib_dev->ibd_bdev_handle)
+		bdev_release(ib_dev->ibd_bdev_handle);
 	bioset_exit(&ib_dev->ibd_bio_set);
 }
 
diff --git a/drivers/target/target_core_iblock.h b/drivers/target/target_core_iblock.h
index 8c55375d2f75..683f9a55945b 100644
--- a/drivers/target/target_core_iblock.h
+++ b/drivers/target/target_core_iblock.h
@@ -32,6 +32,7 @@ struct iblock_dev {
 	u32	ibd_flags;
 	struct bio_set	ibd_bio_set;
 	struct block_device *ibd_bd;
+	struct bdev_handle *ibd_bdev_handle;
 	bool ibd_readonly;
 	struct iblock_dev_plug *ibd_plug;
 } ____cacheline_aligned;
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 0d4f09693ef4..41b7489d37ce 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -352,7 +352,7 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 	struct pscsi_hba_virt *phv = dev->se_hba->hba_ptr;
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
 	struct Scsi_Host *sh = sd->host;
-	struct block_device *bd;
+	struct bdev_handle *bdev_handle;
 	int ret;
 
 	if (scsi_device_get(sd)) {
@@ -366,18 +366,18 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 	 * Claim exclusive struct block_device access to struct scsi_device
 	 * for TYPE_DISK and TYPE_ZBC using supplied udev_path
 	 */
-	bd = blkdev_get_by_path(dev->udev_path, BLK_OPEN_WRITE | BLK_OPEN_READ,
-				pdv, NULL);
-	if (IS_ERR(bd)) {
-		pr_err("pSCSI: blkdev_get_by_path() failed\n");
+	bdev_handle = bdev_open_by_path(dev->udev_path,
+				BLK_OPEN_WRITE | BLK_OPEN_READ, pdv, NULL);
+	if (IS_ERR(bdev_handle)) {
+		pr_err("pSCSI: bdev_open_by_path() failed\n");
 		scsi_device_put(sd);
-		return PTR_ERR(bd);
+		return PTR_ERR(bdev_handle);
 	}
-	pdv->pdv_bd = bd;
+	pdv->pdv_bdev_handle = bdev_handle;
 
 	ret = pscsi_add_device_to_list(dev, sd);
 	if (ret) {
-		blkdev_put(pdv->pdv_bd, pdv);
+		bdev_release(bdev_handle);
 		scsi_device_put(sd);
 		return ret;
 	}
@@ -564,9 +564,9 @@ static void pscsi_destroy_device(struct se_device *dev)
 		 * from pscsi_create_type_disk()
 		 */
 		if ((sd->type == TYPE_DISK || sd->type == TYPE_ZBC) &&
-		    pdv->pdv_bd) {
-			blkdev_put(pdv->pdv_bd, pdv);
-			pdv->pdv_bd = NULL;
+		    pdv->pdv_bdev_handle) {
+			bdev_release(pdv->pdv_bdev_handle);
+			pdv->pdv_bdev_handle = NULL;
 		}
 		/*
 		 * For HBA mode PHV_LLD_SCSI_HOST_NO, release the reference
@@ -994,8 +994,8 @@ static sector_t pscsi_get_blocks(struct se_device *dev)
 {
 	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
 
-	if (pdv->pdv_bd)
-		return bdev_nr_sectors(pdv->pdv_bd);
+	if (pdv->pdv_bdev_handle)
+		return bdev_nr_sectors(pdv->pdv_bdev_handle->bdev);
 	return 0;
 }
 
diff --git a/drivers/target/target_core_pscsi.h b/drivers/target/target_core_pscsi.h
index 23d9a6e340d4..b0a3ef136592 100644
--- a/drivers/target/target_core_pscsi.h
+++ b/drivers/target/target_core_pscsi.h
@@ -37,7 +37,7 @@ struct pscsi_dev_virt {
 	int	pdv_channel_id;
 	int	pdv_target_id;
 	int	pdv_lun_id;
-	struct block_device *pdv_bd;
+	struct bdev_handle *pdv_bdev_handle;
 	struct scsi_device *pdv_sd;
 	struct Scsi_Host *pdv_lld_host;
 } ____cacheline_aligned;
-- 
2.35.3

