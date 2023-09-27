Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7557B0082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjI0Jf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjI0JfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:35:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D7E6;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B9D4E1FD6A;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZcBKgFhDz6Zlcy4gzpBIWscbD+3OVMhK5a7eMfa0eo=;
        b=vWhj3QU91xwl+5mvoWoWg8EXlHdfc7eUJ/3eRQeuqk9TKLf7k04wzgH5qOy8h+u8k6vTWg
        CnjLfl1oWLr7KnklmF4T+DnJ+JNmHpJWLJyvqc4HBKelhInP1WSNAr4OSyTT/fRod068+j
        +42d9qqGl11K37V2Ez1Y5Z5XTOPCozU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZcBKgFhDz6Zlcy4gzpBIWscbD+3OVMhK5a7eMfa0eo=;
        b=3US4qTh1bJnafaHoEW5Qq8jSFB13Nt9J5HRhitEqczGnx0ZU/4Hx2yw4/4gofGFM9wb7F6
        JY2809Z6IhznYjDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A657D13AD9;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5AeaKDT3E2UqEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 55963A07E5; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/29] scsi: target: Convert to bdev_open_by_path()
Date:   Wed, 27 Sep 2023 11:34:21 +0200
Message-Id: <20230927093442.25915-15-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5469; i=jack@suse.cz; h=from:subject; bh=ibO7h/+DEH1VvG/YxXH9GJR9Seqh+17DKgac2b74+OQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/ceQnF7uT1MIkoDAvLOo0kUkps+OUf4vFppFPKj XzJ3jNmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3HgAKCRCcnaoHP2RA2WPPCA CTFIOOexK9NkfKzOvDWOZtf6xw/0bGNdxT1hJN/lTCx/I4jDRJRlYqk4h8VLAZN+ZgspdfKSyQv20M gBBwnvCr9oXQHaVVehuclXceYkIcrhh/PdQgpac8oRe4gXplINNX8hyncyC+rxkQqkj8c56gfp3zc/ 5a7AiEptMivd/JbFMf0Ju1s7MSuu+Mg21zx6+WsEhTBEVwgsgKxd2/pPD7/RZd8poPzrqdar3+Juxl 4dfHHZ/Gpc75B14zD7N515M5P9ErnpVHlO1WmWDy+I6q5PpD8YiJuE6ZmT1RX5JIMJFF/hFIzhbd/H Sbqa6fOWi0VaS9+ySSSCGEjPHRaagZ
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

Convert iblock and pscsi drivers to use bdev_open_by_path() and pass the
handle around.

CC: target-devel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/target/target_core_iblock.c | 19 +++++++++++--------
 drivers/target/target_core_iblock.h |  1 +
 drivers/target/target_core_pscsi.c  | 26 +++++++++++++-------------
 drivers/target/target_core_pscsi.h  |  2 +-
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index a6a06a5f7483..8eb9eb7ce5df 100644
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

