Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBB4A63E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbiBASck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 13:32:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238536AbiBASch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643740356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2+kPpQkeGwptu2FIiaGFwmP+bRttMDFCpZIexnY/bA=;
        b=WgRZRGevUrq1k9yTXEe+xtTBaCkHQT9qEVJC/PQ5wQ/jEq2Qd2Rzj1owL3nudXNpKoxMfB
        As4FOliJ7XgvTx3m3FmECLN5MpKalIoQE5LfQunwK3laSGgnu2q40O0+px9bn1sSe1t8aN
        W/G3hYR8uJKet5WT17dM5WSIzQvuSHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-zM0pccnlOqul8pTSNwqcUg-1; Tue, 01 Feb 2022 13:32:33 -0500
X-MC-Unique: zM0pccnlOqul8pTSNwqcUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49F171091DA1;
        Tue,  1 Feb 2022 18:32:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF3FC84783;
        Tue,  1 Feb 2022 18:32:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 211IWTvb019426;
        Tue, 1 Feb 2022 13:32:29 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 211IWTjA019422;
        Tue, 1 Feb 2022 13:32:29 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 1 Feb 2022 13:32:29 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     =?ISO-8859-15?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 1/3] block: add copy offload support
In-Reply-To: <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com> <20220201102122.4okwj2gipjbvuyux@mpHalley-2> <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add generic copy offload support to the block layer.

We add two new bio types: REQ_OP_COPY_READ_TOKEN and
REQ_OP_COPY_WRITE_TOKEN. Their bio vector has one entry - a page
containing the token.

When we need to copy data, we send REQ_OP_COPY_READ_TOKEN to the source
device and then we send REQ_OP_COPY_WRITE_TOKEN to the destination device.

This patch introduces a new ioctl BLKCOPY that submits the copy operation.
BLKCOPY argument has four 64-bit numbers - source offset, destination
offset and length. The last number is returned by the ioctl and it is the
number of bytes that were actually copied.

For in-kernel users, we introduce a function blkdev_issue_copy.

Copying may fail anytime, the caller is required to fallback to explicit
copy.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 block/blk-core.c          |    7 +++
 block/blk-lib.c           |   89 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-settings.c      |   12 ++++++
 block/blk-sysfs.c         |    7 +++
 block/blk.h               |    3 +
 block/ioctl.c             |   56 ++++++++++++++++++++++++++++
 include/linux/blk_types.h |    4 ++
 include/linux/blkdev.h    |   18 +++++++++
 include/uapi/linux/fs.h   |    1 
 9 files changed, 197 insertions(+)

Index: linux-2.6/block/blk-settings.c
===================================================================
--- linux-2.6.orig/block/blk-settings.c	2022-01-26 19:12:30.000000000 +0100
+++ linux-2.6/block/blk-settings.c	2022-01-27 20:43:27.000000000 +0100
@@ -57,6 +57,7 @@ void blk_set_default_limits(struct queue
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
+	lim->max_copy_sectors = 0;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
@@ -365,6 +366,17 @@ void blk_queue_zone_write_granularity(st
 EXPORT_SYMBOL_GPL(blk_queue_zone_write_granularity);
 
 /**
+ * blk_queue_max_copy_sectors - set maximum copy offload sectors for the queue
+ * @q:  the request queue for the device
+ * @size:  the maximum copy offload sectors
+ */
+void blk_queue_max_copy_sectors(struct request_queue *q, unsigned int size)
+{
+	q->limits.max_copy_sectors = size;
+}
+EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors);
+
+/**
  * blk_queue_alignment_offset - set physical block alignment offset
  * @q:	the request queue for the device
  * @offset: alignment offset in bytes
Index: linux-2.6/include/linux/blkdev.h
===================================================================
--- linux-2.6.orig/include/linux/blkdev.h	2022-01-26 19:12:30.000000000 +0100
+++ linux-2.6/include/linux/blkdev.h	2022-01-29 17:46:03.000000000 +0100
@@ -103,6 +103,7 @@ struct queue_limits {
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
+	unsigned int		max_copy_sectors;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
@@ -706,6 +707,7 @@ extern void blk_queue_max_zone_append_se
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 void blk_queue_zone_write_granularity(struct request_queue *q,
 				      unsigned int size);
+void blk_queue_max_copy_sectors(struct request_queue *q, unsigned int size);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
 void disk_update_readahead(struct gendisk *disk);
@@ -862,6 +864,10 @@ extern int __blkdev_issue_zeroout(struct
 extern int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned flags);
 
+extern int blkdev_issue_copy(struct block_device *bdev1, sector_t sector1,
+		      struct block_device *bdev2, sector_t sector2,
+		      sector_t nr_sects, sector_t *copied, gfp_t gfp_mask);
+
 static inline int sb_issue_discard(struct super_block *sb, sector_t block,
 		sector_t nr_blocks, gfp_t gfp_mask, unsigned long flags)
 {
@@ -1001,6 +1007,18 @@ bdev_zone_write_granularity(struct block
 	return queue_zone_write_granularity(bdev_get_queue(bdev));
 }
 
+static inline unsigned int
+queue_max_copy_sectors(const struct request_queue *q)
+{
+	return q->limits.max_copy_sectors;
+}
+
+static inline unsigned int
+bdev_max_copy_sectors(struct block_device *bdev)
+{
+	return queue_max_copy_sectors(bdev_get_queue(bdev));
+}
+
 static inline int queue_alignment_offset(const struct request_queue *q)
 {
 	if (q->limits.misaligned)
Index: linux-2.6/block/blk-sysfs.c
===================================================================
--- linux-2.6.orig/block/blk-sysfs.c	2022-01-26 19:12:30.000000000 +0100
+++ linux-2.6/block/blk-sysfs.c	2022-01-26 19:12:30.000000000 +0100
@@ -230,6 +230,11 @@ static ssize_t queue_zone_write_granular
 	return queue_var_show(queue_zone_write_granularity(q), page);
 }
 
+static ssize_t queue_max_copy_sectors_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(queue_max_copy_sectors(q), page);
+}
+
 static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
 {
 	unsigned long long max_sectors = q->limits.max_zone_append_sectors;
@@ -591,6 +596,7 @@ QUEUE_RO_ENTRY(queue_write_same_max, "wr
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
+QUEUE_RO_ENTRY(queue_max_copy_sectors, "max_copy_sectors");
 
 QUEUE_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
@@ -647,6 +653,7 @@ static struct attribute *queue_attrs[] =
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
+	&queue_max_copy_sectors_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
Index: linux-2.6/include/linux/blk_types.h
===================================================================
--- linux-2.6.orig/include/linux/blk_types.h	2022-01-06 18:55:01.000000000 +0100
+++ linux-2.6/include/linux/blk_types.h	2022-01-29 17:47:44.000000000 +0100
@@ -371,6 +371,10 @@ enum req_opf {
 	/* reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	= 17,
 
+	/* copy offload bios */
+	REQ_OP_COPY_READ_TOKEN	= 18,
+	REQ_OP_COPY_WRITE_TOKEN	= 19,
+
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= 34,
 	REQ_OP_DRV_OUT		= 35,
Index: linux-2.6/block/blk-lib.c
===================================================================
--- linux-2.6.orig/block/blk-lib.c	2021-08-18 13:59:55.000000000 +0200
+++ linux-2.6/block/blk-lib.c	2022-01-30 17:33:04.000000000 +0100
@@ -440,3 +440,92 @@ retry:
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_zeroout);
+
+static void bio_wake_completion(struct bio *bio)
+{
+	struct completion *comp = bio->bi_private;
+	complete(comp);
+}
+
+int blkdev_issue_copy(struct block_device *bdev1, sector_t sector1,
+		      struct block_device *bdev2, sector_t sector2,
+		      sector_t nr_sects, sector_t *copied, gfp_t gfp_mask)
+{
+	struct page *token;
+	sector_t m;
+	int r = 0;
+	struct completion comp;
+
+	*copied = 0;
+
+	m = min(bdev_max_copy_sectors(bdev1), bdev_max_copy_sectors(bdev2));
+	if (!m)
+		return -EOPNOTSUPP;
+	m = min(m, (sector_t)round_down(UINT_MAX, PAGE_SIZE) >> 9);
+
+	if (unlikely(bdev_read_only(bdev2)))
+		return -EPERM;
+
+	token = alloc_page(gfp_mask);
+	if (unlikely(!token))
+		return -ENOMEM;
+
+	while (nr_sects) {
+		struct bio *read_bio, *write_bio;
+		sector_t this_step = min(nr_sects, m);
+
+		read_bio = bio_alloc(gfp_mask, 1);
+		if (unlikely(!read_bio)) {
+			r = -ENOMEM;
+			break;
+		}
+		bio_set_op_attrs(read_bio, REQ_OP_COPY_READ_TOKEN, REQ_NOMERGE);
+		bio_set_dev(read_bio, bdev1);
+		__bio_add_page(read_bio, token, PAGE_SIZE, 0);
+		read_bio->bi_iter.bi_sector = sector1;
+		read_bio->bi_iter.bi_size = this_step << 9;
+		read_bio->bi_private = &comp;
+		read_bio->bi_end_io = bio_wake_completion;
+		init_completion(&comp);
+		submit_bio(read_bio);
+		wait_for_completion(&comp);
+		if (unlikely(read_bio->bi_status != BLK_STS_OK)) {
+			r = blk_status_to_errno(read_bio->bi_status);
+			bio_put(read_bio);
+			break;
+		}
+		bio_put(read_bio);
+
+		write_bio = bio_alloc(gfp_mask, 1);
+		if (unlikely(!write_bio)) {
+			r = -ENOMEM;
+			break;
+		}
+		bio_set_op_attrs(write_bio, REQ_OP_COPY_WRITE_TOKEN, REQ_NOMERGE);
+		bio_set_dev(write_bio, bdev2);
+		__bio_add_page(write_bio, token, PAGE_SIZE, 0);
+		write_bio->bi_iter.bi_sector = sector2;
+		write_bio->bi_iter.bi_size = this_step << 9;
+		write_bio->bi_private = &comp;
+		write_bio->bi_end_io = bio_wake_completion;
+		reinit_completion(&comp);
+		submit_bio(write_bio);
+		wait_for_completion(&comp);
+		if (unlikely(write_bio->bi_status != BLK_STS_OK)) {
+			r = blk_status_to_errno(write_bio->bi_status);
+			bio_put(write_bio);
+			break;
+		}
+		bio_put(write_bio);
+
+		sector1 += this_step;
+		sector2 += this_step;
+		nr_sects -= this_step;
+		*copied += this_step;
+	}
+
+	__free_page(token);
+
+	return r;
+}
+EXPORT_SYMBOL(blkdev_issue_copy);
Index: linux-2.6/block/ioctl.c
===================================================================
--- linux-2.6.orig/block/ioctl.c	2022-01-24 15:10:40.000000000 +0100
+++ linux-2.6/block/ioctl.c	2022-01-30 13:43:35.000000000 +0100
@@ -165,6 +165,60 @@ fail:
 	return err;
 }
 
+static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
+		unsigned long arg)
+{
+	uint64_t range[4];
+	uint64_t start1, start2, end1, end2, len;
+	sector_t copied = 0;
+	struct inode *inode = bdev->bd_inode;
+	int err;
+
+	if (!(mode & FMODE_WRITE)) {
+		err = -EBADF;
+		goto fail1;
+	}
+
+	if (copy_from_user(range, (void __user *)arg, 24)) {
+		err = -EFAULT;
+		goto fail1;
+	}
+
+	start1 = range[0];
+	start2 = range[1];
+	len = range[2];
+	end1 = start1 + len - 1;
+	end2 = start2 + len - 1;
+
+	if ((start1 | start2 | len) & 511)
+		return -EINVAL;
+	if (end1 >= (uint64_t)bdev_nr_bytes(bdev))
+		return -EINVAL;
+	if (end2 >= (uint64_t)bdev_nr_bytes(bdev))
+		return -EINVAL;
+	if (end1 < start1)
+		return -EINVAL;
+	if (end2 < start2)
+		return -EINVAL;
+
+	filemap_invalidate_lock(inode->i_mapping);
+	err = truncate_bdev_range(bdev, mode, start2, end2);
+	if (err)
+		goto fail2;
+
+	err = blkdev_issue_copy(bdev, start1 >> 9, bdev, start2 >> 9, len >> 9, &copied, GFP_KERNEL);
+
+fail2:
+	filemap_invalidate_unlock(inode->i_mapping);
+
+fail1:
+	range[3] = (uint64_t)copied << 9;
+	if (copy_to_user((void __user *)(arg + 24), &range[3], 8))
+		err = -EFAULT;
+
+	return err;
+}
+
 static int put_ushort(unsigned short __user *argp, unsigned short val)
 {
 	return put_user(val, argp);
@@ -459,6 +513,8 @@ static int blkdev_common_ioctl(struct bl
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
 		return put_u64(argp, bdev->bd_disk->diskseq);
+	case BLKCOPY:
+		return blk_ioctl_copy(bdev, mode, arg);
 	case BLKREPORTZONE:
 		return blkdev_report_zones_ioctl(bdev, mode, cmd, arg);
 	case BLKRESETZONE:
Index: linux-2.6/include/uapi/linux/fs.h
===================================================================
--- linux-2.6.orig/include/uapi/linux/fs.h	2021-09-23 17:07:02.000000000 +0200
+++ linux-2.6/include/uapi/linux/fs.h	2022-01-27 19:05:46.000000000 +0100
@@ -185,6 +185,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+#define BLKCOPY _IO(0x12,129)
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
Index: linux-2.6/block/blk.h
===================================================================
--- linux-2.6.orig/block/blk.h	2022-01-24 15:10:40.000000000 +0100
+++ linux-2.6/block/blk.h	2022-01-29 18:10:28.000000000 +0100
@@ -288,6 +288,9 @@ static inline bool blk_may_split(struct
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE_SAME:
 		return true; /* non-trivial splitting decisions */
+	case REQ_OP_COPY_READ_TOKEN:
+	case REQ_OP_COPY_WRITE_TOKEN:
+		return false;
 	default:
 		break;
 	}
Index: linux-2.6/block/blk-core.c
===================================================================
--- linux-2.6.orig/block/blk-core.c	2022-01-24 15:10:40.000000000 +0100
+++ linux-2.6/block/blk-core.c	2022-02-01 15:53:39.000000000 +0100
@@ -124,6 +124,8 @@ static const char *const blk_op_name[] =
 	REQ_OP_NAME(ZONE_APPEND),
 	REQ_OP_NAME(WRITE_SAME),
 	REQ_OP_NAME(WRITE_ZEROES),
+	REQ_OP_NAME(COPY_READ_TOKEN),
+	REQ_OP_NAME(COPY_WRITE_TOKEN),
 	REQ_OP_NAME(DRV_IN),
 	REQ_OP_NAME(DRV_OUT),
 };
@@ -758,6 +760,11 @@ noinline_for_stack bool submit_bio_check
 		if (!q->limits.max_write_zeroes_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_COPY_READ_TOKEN:
+	case REQ_OP_COPY_WRITE_TOKEN:
+		if (!q->limits.max_copy_sectors)
+			goto not_supported;
+		break;
 	default:
 		break;
 	}

