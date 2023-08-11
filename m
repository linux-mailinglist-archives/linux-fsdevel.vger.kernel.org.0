Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63781778CFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjHKLGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbjHKLF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2313910FB;
        Fri, 11 Aug 2023 04:05:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 29E461F898;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFvICVv8x2uT8joIddq2/IlE5HMWsq6yIuMM3UeaW0c=;
        b=NCY85/ZBr5LJLZTzRqPhlWXWi2rE/qC4EnA25opYrELrKKhdtjPato0kqToDLOXmEMIF4X
        VRGzAA6Qnle77gp5/trO3BFZC46cIDUv6seG+Fz0I/aJri6NZ29//v9ApIYsKmTStt4PbU
        r4WldRacNfRGo269Yy/Wo04yZlfcauY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFvICVv8x2uT8joIddq2/IlE5HMWsq6yIuMM3UeaW0c=;
        b=cuHmqysKxxWKOeMGGp2c6+ivSdWpdqAjBpubGx52jeuqDZ9L2IhSShExlSBJd1euPaPW3t
        f5vxyh6HKCruq/BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D1FE13592;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uCgZB+IV1mRaRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1AA5BA078E; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 15/29] scsi: target: Convert to bdev_open_by_path()
Date:   Fri, 11 Aug 2023 13:04:46 +0200
Message-Id: <20230811110504.27514-15-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5377; i=jack@suse.cz; h=from:subject; bh=FYADzj9bzqF0mg50YmbIzoyWzhnJKTLZDGnb02uEND8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXQrMDXRsTAoVCRqQysMiYCMgT203gLRtlgd8/n xZIOYE+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYV0AAKCRCcnaoHP2RA2YPeB/ wMPZWYqaDGgo2j245iJUQzIIXDZhpYYTFCu8MJU0rssUdiBqH/UlepC9BH3+B4Q+AfMdbBbiLI0GGL WALPz+P4NWsf49B5KMMFqcZQdEoGpuPuIf4SfeRrBavqKpMQgVTJ5lAwzFL6KXu+7YDxmkwGRPvcar Rc/RjmRvEOvGarPqSc/DJlN/77N8HDLVob3GvUT8PXSEowTHG4kkN8QtENmoNOSf76Owny/jlGwV2Z t6+TXfU6P7MlrgV4PbDgcgujD/fH3Nll8rjoOjBzbz71tdfCb6YDVsYriB0ZDmMyISMrkGMST66EC+ 3vDS5DlkQjgcuGrCSxR3jsEreIFRVn
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

Convert iblock and pscsi drivers to use bdev_open_by_path() and pass the
handle around.

CC: target-devel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
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

