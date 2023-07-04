Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863BB7470F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjGDMXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjGDMWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:22:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD7E10E0;
        Tue,  4 Jul 2023 05:22:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59FE522871;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1q0Ly+TYRzz+Lbzs+DrPFFtN8sDBK0YXsnFAlKqtUI=;
        b=cPdR/YWBMZtUS1MC+nSSm+Wv9pwVAeD0wQSTHOF/nWt8ti7TofknDxU1cSiuA5lS+QDNh2
        MQ8pTgWSPL0vVTSSlQ8ZYL0qeyS3J3FOc+rP5LZ/zGOrM49w/KBwmgdxZHtxuNMShEJ0M5
        DyXeOo+AHb/oEgwLODnEXo33Ty3UEso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1q0Ly+TYRzz+Lbzs+DrPFFtN8sDBK0YXsnFAlKqtUI=;
        b=+PjF+mi5ltlR0aaOdtaNLHJ8hzb/Vvm7MU3GCPqy6aB9BSL9haAv6StxNk47POovWVIJip
        jsT5biRekBh9J9Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48A16139ED;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6oO4EQIPpGRCMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EE9BEA0775; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 16/32] scsi: target: Convert to blkdev_get_handle_by_path()
Date:   Tue,  4 Jul 2023 14:21:43 +0200
Message-Id: <20230704122224.16257-16-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5428; i=jack@suse.cz; h=from:subject; bh=vF8qjFI4A/3rD5h/Et69Ec9Qeo6QiVYCndYccNSvPHk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7YX+6hWorwQoJjZkyQ3dg5LYwJKQg7ih6pPHV5 Jq3sVjeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO2AAKCRCcnaoHP2RA2Wo7B/ 4hD/I8EkJLrLY5uM7AFP9Y/pVXKnrLUk8VHGTW6V3K1ZA6MczawCPX8XapgnrOl4mFfwL5o9iYLnNJ YwsW85NRpZ8zjXGpUg6BgeD3y+G7wFU+yl8jE3WJQMwDLfba/pLXSw0pvFrT9+3tmNN+aKayT5BFC1 IiCkhOYVSCX3ie3p2Q9v8Ar0r4LT+3Wq/Bi4aVi9StU5+uKNHfIlDkgiLafqBcPiWCyxBl5cuJ0Hxq 4c/5P5mvDBOZTX3gT6qPOGubdhVcpwPygZBR/6EJjPVGKv4Ki2A+2+hlnBG4HJMvbfqeB4QLGRv4xp d/ik3OB1Hd1J1+/lbkiJj4AeI3B54P
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

Convert iblock and pscsi drivers to use blkdev_get_handle_by_path() and
pass the handle around.

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
index a3c5f3558a33..979b0cfbea4a 100644
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
+	bdev_handle = blkdev_get_handle_by_path(ib_dev->ibd_udev_path, mode,
+				ib_dev, NULL);
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
+	blkdev_handle_put(ib_dev->ibd_bdev_handle);
 out_free_bioset:
 	bioset_exit(&ib_dev->ibd_bio_set);
 out:
@@ -202,8 +205,8 @@ static void iblock_destroy_device(struct se_device *dev)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 
-	if (ib_dev->ibd_bd != NULL)
-		blkdev_put(ib_dev->ibd_bd, ib_dev);
+	if (ib_dev->ibd_bdev_handle)
+		blkdev_handle_put(ib_dev->ibd_bdev_handle);
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
index 0d4f09693ef4..9ea2b29e95bf 100644
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
+	bdev_handle = blkdev_get_handle_by_path(dev->udev_path,
+				BLK_OPEN_WRITE | BLK_OPEN_READ, pdv, NULL);
+	if (IS_ERR(bdev_handle)) {
+		pr_err("pSCSI: blkdev_get_handle_by_path() failed\n");
 		scsi_device_put(sd);
-		return PTR_ERR(bd);
+		return PTR_ERR(bdev_handle);
 	}
-	pdv->pdv_bd = bd;
+	pdv->pdv_bdev_handle = bdev_handle;
 
 	ret = pscsi_add_device_to_list(dev, sd);
 	if (ret) {
-		blkdev_put(pdv->pdv_bd, pdv);
+		blkdev_handle_put(bdev_handle);
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
+			blkdev_handle_put(pdv->pdv_bdev_handle);
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

