Return-Path: <linux-fsdevel+bounces-7190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E73D822DAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677D81C21746
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D01A5B1;
	Wed,  3 Jan 2024 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7UkfKkL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3DC1A5A6;
	Wed,  3 Jan 2024 12:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928A3C433CC;
	Wed,  3 Jan 2024 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286547;
	bh=9fpEPAsW69T9BRTbIsSVjhgwkRf2MLnDuWXV8LEcSF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J7UkfKkLUdEPvfbtgxkC9mO3TduR7KA2yefMDL/OwmAQ+do4UCdTi3+pwEriHgVeg
	 Tub1uSvayBb+cEONgF8yvjrXlauB+Y1ZXFZ1soMM8M9sU4PLzIU61tGiY5gwmbzTUW
	 JKDl/WlwpoYHDn1NT5a3pSfc2rZynOrht4o4hESG/UlJq/8ZWTvYYcu6wPef3CksYn
	 vKS2YGAcdQn+kk2E90nhqmSCdkM0GNjM2KsqJfF2vAjHOh9HMV6lOQ143KSK07pVvd
	 OvCm920slGe6he1KSsL/CMQdO9JR4gyzp3qIfzp14WQhKl5G0x3U/BGuv+9YkDm7Ct
	 NKbbJHVB6AtSQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:07 +0100
Subject: [PATCH RFC 09/34] pktcdvd: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-9-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=8695; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9fpEPAsW69T9BRTbIsSVjhgwkRf2MLnDuWXV8LEcSF8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbTZrPGoOq3q+dLMy5HhERLfZn/7HHJtrU5cyu/VW
 rPmn5UU6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIBxdGhi2iShnTT+6vqH/T
 G85dtubaxAOqH1PsVS7ZyAtkmcotyWJkWHF75ZXNtr7+6lP1rhXqXWyayb0w5Z9otsN9gUqliTN
 52AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/pktcdvd.c | 68 ++++++++++++++++++++++++-------------------------
 include/linux/pktcdvd.h |  4 +--
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index d56d972aadb3..02ab52e55229 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -340,8 +340,8 @@ static ssize_t device_map_show(const struct class *c, const struct class_attribu
 		n += sysfs_emit_at(data, n, "%s %u:%u %u:%u\n",
 			pd->disk->disk_name,
 			MAJOR(pd->pkt_dev), MINOR(pd->pkt_dev),
-			MAJOR(pd->bdev_handle->bdev->bd_dev),
-			MINOR(pd->bdev_handle->bdev->bd_dev));
+			MAJOR(F_BDEV(pd->f_bdev)->bd_dev),
+			MINOR(F_BDEV(pd->f_bdev)->bd_dev));
 	}
 	mutex_unlock(&ctl_mutex);
 	return n;
@@ -438,7 +438,7 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 	int states[PACKET_NUM_STATES];
 
 	seq_printf(m, "Writer %s mapped to %pg:\n", pd->disk->disk_name,
-		   pd->bdev_handle->bdev);
+		   F_BDEV(pd->f_bdev));
 
 	seq_printf(m, "\nSettings:\n");
 	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
@@ -715,7 +715,7 @@ static void pkt_rbtree_insert(struct pktcdvd_device *pd, struct pkt_rb_node *nod
  */
 static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *cgc)
 {
-	struct request_queue *q = bdev_get_queue(pd->bdev_handle->bdev);
+	struct request_queue *q = bdev_get_queue(F_BDEV(pd->f_bdev));
 	struct scsi_cmnd *scmd;
 	struct request *rq;
 	int ret = 0;
@@ -1048,7 +1048,7 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 			continue;
 
 		bio = pkt->r_bios[f];
-		bio_init(bio, pd->bdev_handle->bdev, bio->bi_inline_vecs, 1,
+		bio_init(bio, F_BDEV(pd->f_bdev), bio->bi_inline_vecs, 1,
 			 REQ_OP_READ);
 		bio->bi_iter.bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
 		bio->bi_end_io = pkt_end_io_read;
@@ -1264,7 +1264,7 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	struct device *ddev = disk_to_dev(pd->disk);
 	int f;
 
-	bio_init(pkt->w_bio, pd->bdev_handle->bdev, pkt->w_bio->bi_inline_vecs,
+	bio_init(pkt->w_bio, F_BDEV(pd->f_bdev), pkt->w_bio->bi_inline_vecs,
 		 pkt->frames, REQ_OP_WRITE);
 	pkt->w_bio->bi_iter.bi_sector = pkt->sector;
 	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
@@ -2162,20 +2162,20 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	int ret;
 	long lba;
 	struct request_queue *q;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 
 	/*
 	 * We need to re-open the cdrom device without O_NONBLOCK to be able
 	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
 	 * so open should not fail.
 	 */
-	bdev_handle = bdev_open_by_dev(pd->bdev_handle->bdev->bd_dev,
+	f_bdev = bdev_file_open_by_dev(F_BDEV(pd->f_bdev)->bd_dev,
 				       BLK_OPEN_READ, pd, NULL);
-	if (IS_ERR(bdev_handle)) {
-		ret = PTR_ERR(bdev_handle);
+	if (IS_ERR(f_bdev)) {
+		ret = PTR_ERR(f_bdev);
 		goto out;
 	}
-	pd->open_bdev_handle = bdev_handle;
+	pd->f_open_bdev = f_bdev;
 
 	ret = pkt_get_last_written(pd, &lba);
 	if (ret) {
@@ -2184,9 +2184,9 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	}
 
 	set_capacity(pd->disk, lba << 2);
-	set_capacity_and_notify(pd->bdev_handle->bdev->bd_disk, lba << 2);
+	set_capacity_and_notify(F_BDEV(pd->f_bdev)->bd_disk, lba << 2);
 
-	q = bdev_get_queue(pd->bdev_handle->bdev);
+	q = bdev_get_queue(F_BDEV(pd->f_bdev));
 	if (write) {
 		ret = pkt_open_write(pd);
 		if (ret)
@@ -2218,7 +2218,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	return 0;
 
 out_putdev:
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 out:
 	return ret;
 }
@@ -2237,8 +2237,8 @@ static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 	pkt_lock_door(pd, 0);
 
 	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
-	bdev_release(pd->open_bdev_handle);
-	pd->open_bdev_handle = NULL;
+	fput(pd->f_open_bdev);
+	pd->f_open_bdev = NULL;
 
 	pkt_shrink_pktlist(pd);
 }
@@ -2326,7 +2326,7 @@ static void pkt_end_io_read_cloned(struct bio *bio)
 
 static void pkt_make_request_read(struct pktcdvd_device *pd, struct bio *bio)
 {
-	struct bio *cloned_bio = bio_alloc_clone(pd->bdev_handle->bdev, bio,
+	struct bio *cloned_bio = bio_alloc_clone(F_BDEV(pd->f_bdev), bio,
 		GFP_NOIO, &pkt_bio_set);
 	struct packet_stacked_data *psd = mempool_alloc(&psd_pool, GFP_NOIO);
 
@@ -2497,7 +2497,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 {
 	struct device *ddev = disk_to_dev(pd->disk);
 	int i;
-	struct bdev_handle *bdev_handle;
+	struct file *f_bdev;
 	struct scsi_device *sdev;
 
 	if (pd->pkt_dev == dev) {
@@ -2508,9 +2508,9 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		struct pktcdvd_device *pd2 = pkt_devs[i];
 		if (!pd2)
 			continue;
-		if (pd2->bdev_handle->bdev->bd_dev == dev) {
+		if (F_BDEV(pd2->f_bdev)->bd_dev == dev) {
 			dev_err(ddev, "%pg already setup\n",
-				pd2->bdev_handle->bdev);
+				F_BDEV(pd2->f_bdev));
 			return -EBUSY;
 		}
 		if (pd2->pkt_dev == dev) {
@@ -2519,13 +2519,13 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		}
 	}
 
-	bdev_handle = bdev_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY,
+	f_bdev = bdev_file_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY,
 				       NULL, NULL);
-	if (IS_ERR(bdev_handle))
-		return PTR_ERR(bdev_handle);
-	sdev = scsi_device_from_queue(bdev_handle->bdev->bd_disk->queue);
+	if (IS_ERR(f_bdev))
+		return PTR_ERR(f_bdev);
+	sdev = scsi_device_from_queue(F_BDEV(f_bdev)->bd_disk->queue);
 	if (!sdev) {
-		bdev_release(bdev_handle);
+		fput(f_bdev);
 		return -EINVAL;
 	}
 	put_device(&sdev->sdev_gendev);
@@ -2533,8 +2533,8 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	pd->bdev_handle = bdev_handle;
-	set_blocksize(bdev_handle->bdev, CD_FRAMESIZE);
+	pd->f_bdev = f_bdev;
+	set_blocksize(F_BDEV(f_bdev), CD_FRAMESIZE);
 
 	pkt_init_queue(pd);
 
@@ -2546,11 +2546,11 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	}
 
 	proc_create_single_data(pd->disk->disk_name, 0, pkt_proc, pkt_seq_show, pd);
-	dev_notice(ddev, "writer mapped to %pg\n", bdev_handle->bdev);
+	dev_notice(ddev, "writer mapped to %pg\n", F_BDEV(f_bdev));
 	return 0;
 
 out_mem:
-	bdev_release(bdev_handle);
+	fput(f_bdev);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return -ENOMEM;
@@ -2605,9 +2605,9 @@ static unsigned int pkt_check_events(struct gendisk *disk,
 
 	if (!pd)
 		return 0;
-	if (!pd->bdev_handle)
+	if (!pd->f_bdev)
 		return 0;
-	attached_disk = pd->bdev_handle->bdev->bd_disk;
+	attached_disk = F_BDEV(pd->f_bdev)->bd_disk;
 	if (!attached_disk || !attached_disk->fops->check_events)
 		return 0;
 	return attached_disk->fops->check_events(attached_disk, clearing);
@@ -2692,7 +2692,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 		goto out_mem2;
 
 	/* inherit events of the host device */
-	disk->events = pd->bdev_handle->bdev->bd_disk->events;
+	disk->events = F_BDEV(pd->f_bdev)->bd_disk->events;
 
 	ret = add_disk(disk);
 	if (ret)
@@ -2757,7 +2757,7 @@ static int pkt_remove_dev(dev_t pkt_dev)
 	pkt_debugfs_dev_remove(pd);
 	pkt_sysfs_dev_remove(pd);
 
-	bdev_release(pd->bdev_handle);
+	fput(pd->f_bdev);
 
 	remove_proc_entry(pd->disk->disk_name, pkt_proc);
 	dev_notice(ddev, "writer unmapped\n");
@@ -2784,7 +2784,7 @@ static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
 
 	pd = pkt_find_dev_from_minor(ctrl_cmd->dev_index);
 	if (pd) {
-		ctrl_cmd->dev = new_encode_dev(pd->bdev_handle->bdev->bd_dev);
+		ctrl_cmd->dev = new_encode_dev(F_BDEV(pd->f_bdev)->bd_dev);
 		ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
 	} else {
 		ctrl_cmd->dev = 0;
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 79594aeb160d..e202ec04b7e0 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -154,9 +154,9 @@ struct packet_stacked_data
 
 struct pktcdvd_device
 {
-	struct bdev_handle	*bdev_handle;	/* dev attached */
+	struct file		*f_bdev;	/* dev attached */
 	/* handle acquired for bdev during pkt_open_dev() */
-	struct bdev_handle	*open_bdev_handle;
+	struct file		*f_open_bdev;
 	dev_t			pkt_dev;	/* our dev */
 	struct packet_settings	settings;
 	struct packet_stats	stats;

-- 
2.42.0


