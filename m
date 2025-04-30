Return-Path: <linux-fsdevel+bounces-47770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186A9AA56EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9692F9A169B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968672D0AD6;
	Wed, 30 Apr 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aSzWsYZ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479662BD93D;
	Wed, 30 Apr 2025 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048138; cv=none; b=WBk7/1Mof9yd9unTXMsOAyE5XlNkYIqjS7q1/OG2Ee1DULeHdyw8ee7fXjs3guhkHqDj/F49iCZT5A9sfjlrcOyC5B73hRBLzoU4Zw9JoDblZC8HCDhrfM+3tPFfq9ivag8GKtcXKRD4GEwjQBERTSM/rIqsXc9cRRPOyzMR5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048138; c=relaxed/simple;
	bh=kZxYqHMeCvO3obwZb1UCxWEkZAqy5CcK7x6zaQfPvH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc4Im1ACJbuTzsMaOzc71UwshrPdHPVxAT7ShcP4TYruHweVl8moGF4sAWBRsAEssPgXCawaLLSIzPtdxZtEoXfG6Dj0hncJUfUeSwRBUe5852l2q0OD8LX2dt2UJWrPEfG/jq4hpFn20yJEnuQRNvMgWOaYRbXDQhhg3jV8jlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aSzWsYZ5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=harAFCKxAzdg6ngHKCbmAMKmfOSY5x70uKf/m7XKvmk=; b=aSzWsYZ58/UNlM4AJT6Wh/3UsZ
	R92US5B/A0UDd4MaDIPk6dUWqA7beiGEmIzpbJzX6gBVg3gqZaCg7iWhX3G5+OWnZsbyA+T6blgHL
	0aYuqiTWwT7+OgXlM/t1QaFQGeYyx8oyCTjcmr0AB3GioF5KvMyDIL9+1pQfLBF10WBBd2yCeUf/T
	l9nk0vuoxeKyn2s9cNaxprcJc3XWKjYND7ppYzpYgsoDQhGNnJKP4Wo+teD3U+5Vly93mi8E5kszk
	rn8914D5DWojVwER32OQsRoZMnKLywjiCgqD28Pq6Ps2E6PvPuPPaFiYAT5wwd0FyvbraBdUN0hnW
	VTLV3ajw==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEsh-0000000E2Y2-17UA;
	Wed, 30 Apr 2025 21:22:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/19] block: remove the q argument from blk_rq_map_kern
Date: Wed, 30 Apr 2025 16:21:35 -0500
Message-ID: <20250430212159.2865803-6-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430212159.2865803-1-hch@lst.de>
References: <20250430212159.2865803-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Remove the q argument from blk_rq_map_kern and the internal helpers
called by it as the queue can trivially be derived from the request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-map.c            | 24 ++++++++++--------------
 drivers/block/pktcdvd.c    |  2 +-
 drivers/block/ublk_drv.c   |  3 +--
 drivers/block/virtio_blk.c |  4 ++--
 drivers/nvme/host/core.c   |  2 +-
 drivers/scsi/scsi_ioctl.c  |  2 +-
 drivers/scsi/scsi_lib.c    |  3 +--
 include/linux/blk-mq.h     |  4 ++--
 8 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index d2f22744b3d1..0cbceb2671c9 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -319,7 +319,6 @@ static void bio_map_kern_endio(struct bio *bio)
 
 /**
  *	bio_map_kern	-	map kernel address into bio
- *	@q: the struct request_queue for the bio
  *	@data: pointer to buffer to map
  *	@len: length in bytes
  *	@gfp_mask: allocation flags for bio allocation
@@ -327,8 +326,7 @@ static void bio_map_kern_endio(struct bio *bio)
  *	Map the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *bio_map_kern(struct request_queue *q, void *data,
-		unsigned int len, gfp_t gfp_mask)
+static struct bio *bio_map_kern(void *data, unsigned int len, gfp_t gfp_mask)
 {
 	unsigned long kaddr = (unsigned long)data;
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -402,7 +400,6 @@ static void bio_copy_kern_endio_read(struct bio *bio)
 
 /**
  *	bio_copy_kern	-	copy kernel address into bio
- *	@q: the struct request_queue for the bio
  *	@data: pointer to buffer to copy
  *	@len: length in bytes
  *	@gfp_mask: allocation flags for bio and page allocation
@@ -411,8 +408,8 @@ static void bio_copy_kern_endio_read(struct bio *bio)
  *	copy the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *bio_copy_kern(struct request_queue *q, void *data,
-		unsigned int len, gfp_t gfp_mask, int reading)
+static struct bio *bio_copy_kern(void *data, unsigned int len, gfp_t gfp_mask,
+		int reading)
 {
 	unsigned long kaddr = (unsigned long)data;
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -689,7 +686,6 @@ EXPORT_SYMBOL(blk_rq_unmap_user);
 
 /**
  * blk_rq_map_kern - map kernel data to a request, for passthrough requests
- * @q:		request queue where request should be inserted
  * @rq:		request to fill
  * @kbuf:	the kernel buffer
  * @len:	length of user data
@@ -700,24 +696,24 @@ EXPORT_SYMBOL(blk_rq_unmap_user);
  *    buffer is used. Can be called multiple times to append multiple
  *    buffers.
  */
-int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
-		    unsigned int len, gfp_t gfp_mask)
+int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
+		gfp_t gfp_mask)
 {
 	int reading = rq_data_dir(rq) == READ;
 	unsigned long addr = (unsigned long) kbuf;
 	struct bio *bio;
 	int ret;
 
-	if (len > (queue_max_hw_sectors(q) << 9))
+	if (len > (queue_max_hw_sectors(rq->q) << SECTOR_SHIFT))
 		return -EINVAL;
 	if (!len || !kbuf)
 		return -EINVAL;
 
-	if (!blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf) ||
-	    blk_queue_may_bounce(q))
-		bio = bio_copy_kern(q, kbuf, len, gfp_mask, reading);
+	if (!blk_rq_aligned(rq->q, addr, len) || object_is_on_stack(kbuf) ||
+	    blk_queue_may_bounce(rq->q))
+		bio = bio_copy_kern(kbuf, len, gfp_mask, reading);
 	else
-		bio = bio_map_kern(q, kbuf, len, gfp_mask);
+		bio = bio_map_kern(kbuf, len, gfp_mask);
 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 65b96c083b3c..d5cc7bd2875c 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -725,7 +725,7 @@ static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *
 	scmd = blk_mq_rq_to_pdu(rq);
 
 	if (cgc->buflen) {
-		ret = blk_rq_map_kern(q, rq, cgc->buffer, cgc->buflen,
+		ret = blk_rq_map_kern(rq, cgc->buffer, cgc->buflen,
 				      GFP_NOIO);
 		if (ret)
 			goto out;
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a183aa7648c3..c40ac1287904 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -363,8 +363,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 		if (ret)
 			goto free_req;
 
-		ret = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
-					GFP_KERNEL);
+		ret = blk_rq_map_kern(req, buffer, buffer_length, GFP_KERNEL);
 		if (ret)
 			goto erase_desc;
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7cffea01d868..30bca8cb7106 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -571,7 +571,7 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
 	vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, sector);
 
-	err = blk_rq_map_kern(q, req, report_buf, report_len, GFP_KERNEL);
+	err = blk_rq_map_kern(req, report_buf, report_len, GFP_KERNEL);
 	if (err)
 		goto out;
 
@@ -817,7 +817,7 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
 	vbr->out_hdr.sector = 0;
 
-	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
+	err = blk_rq_map_kern(req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
 	if (err)
 		goto out;
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb6ea8acb3cc..34d2abdb2f89 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1157,7 +1157,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 
 	if (buffer && bufflen) {
-		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
+		ret = blk_rq_map_kern(req, buffer, bufflen, GFP_KERNEL);
 		if (ret)
 			goto out;
 	}
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 2fa45556e1ea..0ddc95bafc71 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -601,7 +601,7 @@ static int sg_scsi_ioctl(struct request_queue *q, bool open_for_write,
 	}
 
 	if (bytes) {
-		err = blk_rq_map_kern(q, rq, buffer, bytes, GFP_NOIO);
+		err = blk_rq_map_kern(rq, buffer, bytes, GFP_NOIO);
 		if (err)
 			goto error;
 	}
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0d29470e86b0..f313fcd30269 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -313,8 +313,7 @@ int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
 		return PTR_ERR(req);
 
 	if (bufflen) {
-		ret = blk_rq_map_kern(sdev->request_queue, req,
-				      buffer, bufflen, GFP_NOIO);
+		ret = blk_rq_map_kern(req, buffer, bufflen, GFP_NOIO);
 		if (ret)
 			goto out;
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8eb9b3310167..8901347c778b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1031,8 +1031,8 @@ int blk_rq_map_user_io(struct request *, struct rq_map_data *,
 int blk_rq_map_user_iov(struct request_queue *, struct request *,
 		struct rq_map_data *, const struct iov_iter *, gfp_t);
 int blk_rq_unmap_user(struct bio *);
-int blk_rq_map_kern(struct request_queue *, struct request *, void *,
-		unsigned int, gfp_t);
+int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
+		gfp_t gfp);
 int blk_rq_append_bio(struct request *rq, struct bio *bio);
 void blk_execute_rq_nowait(struct request *rq, bool at_head);
 blk_status_t blk_execute_rq(struct request *rq, bool at_head);
-- 
2.47.2


