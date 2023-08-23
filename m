Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D293C7855F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjHWKtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjHWKt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:49:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C2EE6A;
        Wed, 23 Aug 2023 03:49:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5126E2074A;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGpPJQoBBwDi6Zmq6zBHnc0/JwjNTfnYDjBQKQlSFUQ=;
        b=KZGTwi48zocm2YAI8DNeiCG24ayDkgUoedUgyHQOtypzc3JprS9kFe7Iqz99IdEfmMufuN
        zVHdXTEmVT7mF0XVgyx+mANTwbDshVJLcPn6r1nDK7vw02t7D9y4jOS2JBxM7KvNq5KDRK
        EaJdiV6P7CaeZy97QhFTy7wPeihMOX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGpPJQoBBwDi6Zmq6zBHnc0/JwjNTfnYDjBQKQlSFUQ=;
        b=JopvXMWhkEDcmEsEpBKlIjv1COvwFbYXYR3jbo3HhrXbUA9gBPcbGPTOu5QtIOEhDZAe1i
        +Jyv6ZuBingTO3Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4257913592;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NEwyEBrk5WQ4IAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2814EA077E; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/29] pktcdvd: Convert to bdev_open_by_dev()
Date:   Wed, 23 Aug 2023 12:48:16 +0200
Message-Id: <20230823104857.11437-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8835; i=jack@suse.cz; h=from:subject; bh=hA+ZWA2tdplrXhDPoT1eEfW0WDejc+/Jj+yJ8mS0km0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5ePy6JBOlC8VuXbdwxPUBEEnIGyLm55Eok7juAjP 9qZbw/GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj8gAKCRCcnaoHP2RA2TZeB/ 9uJNWMsIve5Cuynt8WCBntCZZ6Nlyt5nl1L1LHbFqdpEg8cBD0jH0N7KpFhlPNijfHVy0CSGtrP+RT +HXvM0Ku3wvEEfvD9xjF1sgZNHN+Ig4rh2cwUQAxIrU/zoqEjY47LWIIjCXGNpgyMwtp70xScj5vpi aC5tWSR/vOt0TLEkgA4FjgymDv39E2PytOk2k1abHADX+WU1aSxVX86dCCLC2aURDiRYbz9iZydEIl N6zNu1W5onyBglxMLZjIFVKLoDE0b7yw6dsgdM9WMZUIfFVH+PuyaxJ4Ym4dhbMnEyPsCCnYgtk85f aMD/wKE1hFqetgn9myuMLW96invE9y
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert pktcdvd to use bdev_open_by_dev().

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/pktcdvd.c | 76 ++++++++++++++++++++++-------------------
 include/linux/pktcdvd.h |  4 ++-
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a1428538bda5..d56d972aadb3 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -340,8 +340,8 @@ static ssize_t device_map_show(const struct class *c, const struct class_attribu
 		n += sysfs_emit_at(data, n, "%s %u:%u %u:%u\n",
 			pd->disk->disk_name,
 			MAJOR(pd->pkt_dev), MINOR(pd->pkt_dev),
-			MAJOR(pd->bdev->bd_dev),
-			MINOR(pd->bdev->bd_dev));
+			MAJOR(pd->bdev_handle->bdev->bd_dev),
+			MINOR(pd->bdev_handle->bdev->bd_dev));
 	}
 	mutex_unlock(&ctl_mutex);
 	return n;
@@ -437,7 +437,8 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 	char *msg;
 	int states[PACKET_NUM_STATES];
 
-	seq_printf(m, "Writer %s mapped to %pg:\n", pd->disk->disk_name, pd->bdev);
+	seq_printf(m, "Writer %s mapped to %pg:\n", pd->disk->disk_name,
+		   pd->bdev_handle->bdev);
 
 	seq_printf(m, "\nSettings:\n");
 	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
@@ -714,7 +715,7 @@ static void pkt_rbtree_insert(struct pktcdvd_device *pd, struct pkt_rb_node *nod
  */
 static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *cgc)
 {
-	struct request_queue *q = bdev_get_queue(pd->bdev);
+	struct request_queue *q = bdev_get_queue(pd->bdev_handle->bdev);
 	struct scsi_cmnd *scmd;
 	struct request *rq;
 	int ret = 0;
@@ -1047,7 +1048,8 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 			continue;
 
 		bio = pkt->r_bios[f];
-		bio_init(bio, pd->bdev, bio->bi_inline_vecs, 1, REQ_OP_READ);
+		bio_init(bio, pd->bdev_handle->bdev, bio->bi_inline_vecs, 1,
+			 REQ_OP_READ);
 		bio->bi_iter.bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
 		bio->bi_end_io = pkt_end_io_read;
 		bio->bi_private = pkt;
@@ -1262,8 +1264,8 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	struct device *ddev = disk_to_dev(pd->disk);
 	int f;
 
-	bio_init(pkt->w_bio, pd->bdev, pkt->w_bio->bi_inline_vecs, pkt->frames,
-		 REQ_OP_WRITE);
+	bio_init(pkt->w_bio, pd->bdev_handle->bdev, pkt->w_bio->bi_inline_vecs,
+		 pkt->frames, REQ_OP_WRITE);
 	pkt->w_bio->bi_iter.bi_sector = pkt->sector;
 	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
 	pkt->w_bio->bi_private = pkt;
@@ -2160,18 +2162,20 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	int ret;
 	long lba;
 	struct request_queue *q;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 
 	/*
 	 * We need to re-open the cdrom device without O_NONBLOCK to be able
 	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
 	 * so open should not fail.
 	 */
-	bdev = blkdev_get_by_dev(pd->bdev->bd_dev, BLK_OPEN_READ, pd, NULL);
-	if (IS_ERR(bdev)) {
-		ret = PTR_ERR(bdev);
+	bdev_handle = bdev_open_by_dev(pd->bdev_handle->bdev->bd_dev,
+				       BLK_OPEN_READ, pd, NULL);
+	if (IS_ERR(bdev_handle)) {
+		ret = PTR_ERR(bdev_handle);
 		goto out;
 	}
+	pd->open_bdev_handle = bdev_handle;
 
 	ret = pkt_get_last_written(pd, &lba);
 	if (ret) {
@@ -2180,9 +2184,9 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	}
 
 	set_capacity(pd->disk, lba << 2);
-	set_capacity_and_notify(pd->bdev->bd_disk, lba << 2);
+	set_capacity_and_notify(pd->bdev_handle->bdev->bd_disk, lba << 2);
 
-	q = bdev_get_queue(pd->bdev);
+	q = bdev_get_queue(pd->bdev_handle->bdev);
 	if (write) {
 		ret = pkt_open_write(pd);
 		if (ret)
@@ -2214,7 +2218,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	return 0;
 
 out_putdev:
-	blkdev_put(bdev, pd);
+	bdev_release(bdev_handle);
 out:
 	return ret;
 }
@@ -2233,7 +2237,8 @@ static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 	pkt_lock_door(pd, 0);
 
 	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
-	blkdev_put(pd->bdev, pd);
+	bdev_release(pd->open_bdev_handle);
+	pd->open_bdev_handle = NULL;
 
 	pkt_shrink_pktlist(pd);
 }
@@ -2321,8 +2326,8 @@ static void pkt_end_io_read_cloned(struct bio *bio)
 
 static void pkt_make_request_read(struct pktcdvd_device *pd, struct bio *bio)
 {
-	struct bio *cloned_bio =
-		bio_alloc_clone(pd->bdev, bio, GFP_NOIO, &pkt_bio_set);
+	struct bio *cloned_bio = bio_alloc_clone(pd->bdev_handle->bdev, bio,
+		GFP_NOIO, &pkt_bio_set);
 	struct packet_stacked_data *psd = mempool_alloc(&psd_pool, GFP_NOIO);
 
 	psd->pd = pd;
@@ -2492,7 +2497,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 {
 	struct device *ddev = disk_to_dev(pd->disk);
 	int i;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	struct scsi_device *sdev;
 
 	if (pd->pkt_dev == dev) {
@@ -2503,8 +2508,9 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		struct pktcdvd_device *pd2 = pkt_devs[i];
 		if (!pd2)
 			continue;
-		if (pd2->bdev->bd_dev == dev) {
-			dev_err(ddev, "%pg already setup\n", pd2->bdev);
+		if (pd2->bdev_handle->bdev->bd_dev == dev) {
+			dev_err(ddev, "%pg already setup\n",
+				pd2->bdev_handle->bdev);
 			return -EBUSY;
 		}
 		if (pd2->pkt_dev == dev) {
@@ -2513,13 +2519,13 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		}
 	}
 
-	bdev = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY, NULL,
-				 NULL);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
-	sdev = scsi_device_from_queue(bdev->bd_disk->queue);
+	bdev_handle = bdev_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY,
+				       NULL, NULL);
+	if (IS_ERR(bdev_handle))
+		return PTR_ERR(bdev_handle);
+	sdev = scsi_device_from_queue(bdev_handle->bdev->bd_disk->queue);
 	if (!sdev) {
-		blkdev_put(bdev, NULL);
+		bdev_release(bdev_handle);
 		return -EINVAL;
 	}
 	put_device(&sdev->sdev_gendev);
@@ -2527,8 +2533,8 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	pd->bdev = bdev;
-	set_blocksize(bdev, CD_FRAMESIZE);
+	pd->bdev_handle = bdev_handle;
+	set_blocksize(bdev_handle->bdev, CD_FRAMESIZE);
 
 	pkt_init_queue(pd);
 
@@ -2540,11 +2546,11 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	}
 
 	proc_create_single_data(pd->disk->disk_name, 0, pkt_proc, pkt_seq_show, pd);
-	dev_notice(ddev, "writer mapped to %pg\n", bdev);
+	dev_notice(ddev, "writer mapped to %pg\n", bdev_handle->bdev);
 	return 0;
 
 out_mem:
-	blkdev_put(bdev, NULL);
+	bdev_release(bdev_handle);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return -ENOMEM;
@@ -2599,9 +2605,9 @@ static unsigned int pkt_check_events(struct gendisk *disk,
 
 	if (!pd)
 		return 0;
-	if (!pd->bdev)
+	if (!pd->bdev_handle)
 		return 0;
-	attached_disk = pd->bdev->bd_disk;
+	attached_disk = pd->bdev_handle->bdev->bd_disk;
 	if (!attached_disk || !attached_disk->fops->check_events)
 		return 0;
 	return attached_disk->fops->check_events(attached_disk, clearing);
@@ -2686,7 +2692,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 		goto out_mem2;
 
 	/* inherit events of the host device */
-	disk->events = pd->bdev->bd_disk->events;
+	disk->events = pd->bdev_handle->bdev->bd_disk->events;
 
 	ret = add_disk(disk);
 	if (ret)
@@ -2751,7 +2757,7 @@ static int pkt_remove_dev(dev_t pkt_dev)
 	pkt_debugfs_dev_remove(pd);
 	pkt_sysfs_dev_remove(pd);
 
-	blkdev_put(pd->bdev, NULL);
+	bdev_release(pd->bdev_handle);
 
 	remove_proc_entry(pd->disk->disk_name, pkt_proc);
 	dev_notice(ddev, "writer unmapped\n");
@@ -2778,7 +2784,7 @@ static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
 
 	pd = pkt_find_dev_from_minor(ctrl_cmd->dev_index);
 	if (pd) {
-		ctrl_cmd->dev = new_encode_dev(pd->bdev->bd_dev);
+		ctrl_cmd->dev = new_encode_dev(pd->bdev_handle->bdev->bd_dev);
 		ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
 	} else {
 		ctrl_cmd->dev = 0;
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 80cb00db42a4..79594aeb160d 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -154,7 +154,9 @@ struct packet_stacked_data
 
 struct pktcdvd_device
 {
-	struct block_device	*bdev;		/* dev attached */
+	struct bdev_handle	*bdev_handle;	/* dev attached */
+	/* handle acquired for bdev during pkt_open_dev() */
+	struct bdev_handle	*open_bdev_handle;
 	dev_t			pkt_dev;	/* our dev */
 	struct packet_settings	settings;
 	struct packet_stats	stats;
-- 
2.35.3

