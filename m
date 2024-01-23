Return-Path: <linux-fsdevel+bounces-8554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FE838FF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4059290CE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D76086C;
	Tue, 23 Jan 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjSdY/fK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B525D8E7;
	Tue, 23 Jan 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016441; cv=none; b=S2Yo4Z6eF2dw4sz/0S48QgKC1EqITpoGyYTNULE0a91f0iKdAqFNNRxi0pjXgJWhkHdRNo+7yEw+zzH4AQ4CPqYMzRm2TEge5OuTK7/AJmDIJ8Rzeq3mkVPi7auyeECuC6Ej/fooSTRDoDOS2ytdVkqjySJy+1Q6ZccX1D45Bgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016441; c=relaxed/simple;
	bh=AAdcIir+Ilfk/XNUrOeOom28O/1kvtCAeWXZZyCgRII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEuuVlgJZF15FGrM8PQDd8f3QCNY/rVBmL3btoG1xvS2zH7aqYugUJq/Iyvci1wdnujVGNxYCfQ9r6F2mdUjQyUv2vVaVCyX5Hg8osVszT9VT6QNKeorxDOGIhaCT7mSPsyKuu21aiZVqaJMgcWJ/h4Ucicymp1n5kPEWTi9BpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjSdY/fK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587A4C32780;
	Tue, 23 Jan 2024 13:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016441;
	bh=AAdcIir+Ilfk/XNUrOeOom28O/1kvtCAeWXZZyCgRII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HjSdY/fKkW4rjOblSj9Vhk2hjotyQecq6UjuB8/YIEe5GiSu9uFo7GY0KHA9VaQ67
	 TV/BShV4Amc/J/+tcphB3DT+jk/3fn3KWIbWaC0xuMjWnuq+PQZncircYJX7mTPw9l
	 kB2yttEBVVPnRem+9evCBFVUEbdzl+e/EIwnts5XacS8poiHdHlmYy1qNfT04YbzOR
	 YonpTlt2vP8Gk+PE+/7ozpYVXNGPmNyNnepH2/cbZc9bko8Ppg25wgEdX9u+tJ07Lb
	 hNIQlBdY209GHNycp3mAWOYbOk43ZV+4njR9JEV1ruwo5LRvbXigy7N5t/IMqSA4wa
	 KZoLyoJj32OOQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:26 +0100
Subject: [PATCH v2 09/34] pktcdvd: port block device access to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-9-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=8854; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AAdcIir+Ilfk/XNUrOeOom28O/1kvtCAeWXZZyCgRII=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3ze/tKT3b6/G8a3aPNXeFzKlDi2cv3rvhhd2j+sa2
 /ernljA11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAROylGhp3Xv7M6v/lrK2X1
 YIfwsehpTaZss1S/SBz6b9GhHMoWNoHhn/ZN54cVcdrX3ZQNey+nct7qatuTFT6BYd0x7fWMh9O
 uMAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/pktcdvd.c | 68 ++++++++++++++++++++++++-------------------------
 include/linux/pktcdvd.h |  4 +--
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index d56d972aadb3..c21444716e43 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -340,8 +340,8 @@ static ssize_t device_map_show(const struct class *c, const struct class_attribu
 		n += sysfs_emit_at(data, n, "%s %u:%u %u:%u\n",
 			pd->disk->disk_name,
 			MAJOR(pd->pkt_dev), MINOR(pd->pkt_dev),
-			MAJOR(pd->bdev_handle->bdev->bd_dev),
-			MINOR(pd->bdev_handle->bdev->bd_dev));
+			MAJOR(file_bdev(pd->bdev_file)->bd_dev),
+			MINOR(file_bdev(pd->bdev_file)->bd_dev));
 	}
 	mutex_unlock(&ctl_mutex);
 	return n;
@@ -438,7 +438,7 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 	int states[PACKET_NUM_STATES];
 
 	seq_printf(m, "Writer %s mapped to %pg:\n", pd->disk->disk_name,
-		   pd->bdev_handle->bdev);
+		   file_bdev(pd->bdev_file));
 
 	seq_printf(m, "\nSettings:\n");
 	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
@@ -715,7 +715,7 @@ static void pkt_rbtree_insert(struct pktcdvd_device *pd, struct pkt_rb_node *nod
  */
 static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *cgc)
 {
-	struct request_queue *q = bdev_get_queue(pd->bdev_handle->bdev);
+	struct request_queue *q = bdev_get_queue(file_bdev(pd->bdev_file));
 	struct scsi_cmnd *scmd;
 	struct request *rq;
 	int ret = 0;
@@ -1048,7 +1048,7 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 			continue;
 
 		bio = pkt->r_bios[f];
-		bio_init(bio, pd->bdev_handle->bdev, bio->bi_inline_vecs, 1,
+		bio_init(bio, file_bdev(pd->bdev_file), bio->bi_inline_vecs, 1,
 			 REQ_OP_READ);
 		bio->bi_iter.bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
 		bio->bi_end_io = pkt_end_io_read;
@@ -1264,7 +1264,7 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	struct device *ddev = disk_to_dev(pd->disk);
 	int f;
 
-	bio_init(pkt->w_bio, pd->bdev_handle->bdev, pkt->w_bio->bi_inline_vecs,
+	bio_init(pkt->w_bio, file_bdev(pd->bdev_file), pkt->w_bio->bi_inline_vecs,
 		 pkt->frames, REQ_OP_WRITE);
 	pkt->w_bio->bi_iter.bi_sector = pkt->sector;
 	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
@@ -2162,20 +2162,20 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	int ret;
 	long lba;
 	struct request_queue *q;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 
 	/*
 	 * We need to re-open the cdrom device without O_NONBLOCK to be able
 	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
 	 * so open should not fail.
 	 */
-	bdev_handle = bdev_open_by_dev(pd->bdev_handle->bdev->bd_dev,
+	bdev_file = bdev_file_open_by_dev(file_bdev(pd->bdev_file)->bd_dev,
 				       BLK_OPEN_READ, pd, NULL);
-	if (IS_ERR(bdev_handle)) {
-		ret = PTR_ERR(bdev_handle);
+	if (IS_ERR(bdev_file)) {
+		ret = PTR_ERR(bdev_file);
 		goto out;
 	}
-	pd->open_bdev_handle = bdev_handle;
+	pd->f_open_bdev = bdev_file;
 
 	ret = pkt_get_last_written(pd, &lba);
 	if (ret) {
@@ -2184,9 +2184,9 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	}
 
 	set_capacity(pd->disk, lba << 2);
-	set_capacity_and_notify(pd->bdev_handle->bdev->bd_disk, lba << 2);
+	set_capacity_and_notify(file_bdev(pd->bdev_file)->bd_disk, lba << 2);
 
-	q = bdev_get_queue(pd->bdev_handle->bdev);
+	q = bdev_get_queue(file_bdev(pd->bdev_file));
 	if (write) {
 		ret = pkt_open_write(pd);
 		if (ret)
@@ -2218,7 +2218,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	return 0;
 
 out_putdev:
-	bdev_release(bdev_handle);
+	fput(bdev_file);
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
+	struct bio *cloned_bio = bio_alloc_clone(file_bdev(pd->bdev_file), bio,
 		GFP_NOIO, &pkt_bio_set);
 	struct packet_stacked_data *psd = mempool_alloc(&psd_pool, GFP_NOIO);
 
@@ -2497,7 +2497,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 {
 	struct device *ddev = disk_to_dev(pd->disk);
 	int i;
-	struct bdev_handle *bdev_handle;
+	struct file *bdev_file;
 	struct scsi_device *sdev;
 
 	if (pd->pkt_dev == dev) {
@@ -2508,9 +2508,9 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		struct pktcdvd_device *pd2 = pkt_devs[i];
 		if (!pd2)
 			continue;
-		if (pd2->bdev_handle->bdev->bd_dev == dev) {
+		if (file_bdev(pd2->bdev_file)->bd_dev == dev) {
 			dev_err(ddev, "%pg already setup\n",
-				pd2->bdev_handle->bdev);
+				file_bdev(pd2->bdev_file));
 			return -EBUSY;
 		}
 		if (pd2->pkt_dev == dev) {
@@ -2519,13 +2519,13 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		}
 	}
 
-	bdev_handle = bdev_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY,
+	bdev_file = bdev_file_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY,
 				       NULL, NULL);
-	if (IS_ERR(bdev_handle))
-		return PTR_ERR(bdev_handle);
-	sdev = scsi_device_from_queue(bdev_handle->bdev->bd_disk->queue);
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+	sdev = scsi_device_from_queue(file_bdev(bdev_file)->bd_disk->queue);
 	if (!sdev) {
-		bdev_release(bdev_handle);
+		fput(bdev_file);
 		return -EINVAL;
 	}
 	put_device(&sdev->sdev_gendev);
@@ -2533,8 +2533,8 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	pd->bdev_handle = bdev_handle;
-	set_blocksize(bdev_handle->bdev, CD_FRAMESIZE);
+	pd->bdev_file = bdev_file;
+	set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
 
 	pkt_init_queue(pd);
 
@@ -2546,11 +2546,11 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	}
 
 	proc_create_single_data(pd->disk->disk_name, 0, pkt_proc, pkt_seq_show, pd);
-	dev_notice(ddev, "writer mapped to %pg\n", bdev_handle->bdev);
+	dev_notice(ddev, "writer mapped to %pg\n", file_bdev(bdev_file));
 	return 0;
 
 out_mem:
-	bdev_release(bdev_handle);
+	fput(bdev_file);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return -ENOMEM;
@@ -2605,9 +2605,9 @@ static unsigned int pkt_check_events(struct gendisk *disk,
 
 	if (!pd)
 		return 0;
-	if (!pd->bdev_handle)
+	if (!pd->bdev_file)
 		return 0;
-	attached_disk = pd->bdev_handle->bdev->bd_disk;
+	attached_disk = file_bdev(pd->bdev_file)->bd_disk;
 	if (!attached_disk || !attached_disk->fops->check_events)
 		return 0;
 	return attached_disk->fops->check_events(attached_disk, clearing);
@@ -2692,7 +2692,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 		goto out_mem2;
 
 	/* inherit events of the host device */
-	disk->events = pd->bdev_handle->bdev->bd_disk->events;
+	disk->events = file_bdev(pd->bdev_file)->bd_disk->events;
 
 	ret = add_disk(disk);
 	if (ret)
@@ -2757,7 +2757,7 @@ static int pkt_remove_dev(dev_t pkt_dev)
 	pkt_debugfs_dev_remove(pd);
 	pkt_sysfs_dev_remove(pd);
 
-	bdev_release(pd->bdev_handle);
+	fput(pd->bdev_file);
 
 	remove_proc_entry(pd->disk->disk_name, pkt_proc);
 	dev_notice(ddev, "writer unmapped\n");
@@ -2784,7 +2784,7 @@ static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
 
 	pd = pkt_find_dev_from_minor(ctrl_cmd->dev_index);
 	if (pd) {
-		ctrl_cmd->dev = new_encode_dev(pd->bdev_handle->bdev->bd_dev);
+		ctrl_cmd->dev = new_encode_dev(file_bdev(pd->bdev_file)->bd_dev);
 		ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
 	} else {
 		ctrl_cmd->dev = 0;
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 79594aeb160d..2f1b952d596a 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -154,9 +154,9 @@ struct packet_stacked_data
 
 struct pktcdvd_device
 {
-	struct bdev_handle	*bdev_handle;	/* dev attached */
+	struct file		*bdev_file;	/* dev attached */
 	/* handle acquired for bdev during pkt_open_dev() */
-	struct bdev_handle	*open_bdev_handle;
+	struct file		*f_open_bdev;
 	dev_t			pkt_dev;	/* our dev */
 	struct packet_settings	settings;
 	struct packet_stats	stats;

-- 
2.43.0


