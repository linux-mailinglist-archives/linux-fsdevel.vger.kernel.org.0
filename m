Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FAC2E959A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 14:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbhADNIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 08:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbhADNIH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:08:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CB2C061794;
        Mon,  4 Jan 2021 05:07:26 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b5so10845600pjk.2;
        Mon, 04 Jan 2021 05:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b1nywf6L60SmI9ZxVA0bUc4AidIu1KLiq6fBICYuXas=;
        b=eoqPwHxa2w/HIdzENiSVcV9Fj0kFoNN99+KWTCjmPuACB1GmmKWDz4sq9kdd6tWlH5
         PQUDWrFzOr892t//WfI44QVM/oM1PUYDkKAxSnpdRI9zr4eRhLtVKrebf2lOOeMJejEB
         nZ10TX9rG9J0koa+xyrtihpFJhXkmhEpu5whkNw/ScnWLUFMj94RVva7TPYxCynHJwnd
         Xz3cbudYvDB32ftkI14O/In+Wn9roqrMwiVnIbA8Hr3bYj24yOoGnORWNrHhRgqkUeJa
         cDlQf1J8sEQzcj9+y18qnIZLNXlNcS/TL4D+MJthpqyu1Z0Io7DeZulAIPLpWaNgB+2o
         2BEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b1nywf6L60SmI9ZxVA0bUc4AidIu1KLiq6fBICYuXas=;
        b=MKrU6OwujtCgt7Obn96PN0zot2n9CL8KLqCgOm2W2fblJB5YNPlX2NH5IZou8X4aIz
         SlHoARNFCu8bNs+C694/uQniP6xi4L0oo+j5SYSImBdORnvR2x2UCNZrKCXAOYSwMY+4
         N1zwDc8TvFT/FM5pAAznC9upoDBALaNM3FCA5LQYwzBA1QirMZU7NmTtPDf0/OFgJoh8
         k3vd+JqCqXFXlanxtmBiDKIH8mYdlGtcIZyJYqOHHjZYPdAODNia7mwz3Nndk/mThTB/
         aeEniLzXB65hLnPGpV2okmCl4RI+TywEGmAF1kj3ZukoIfiQsMxgKj5Ylsiemj6zMtwM
         pFDw==
X-Gm-Message-State: AOAM531eefQd5tym/vSL3GO+UlU31Yq2EkMDpmIY7213Er5q+uvkgmhV
        mMdEw8lriJrL8ceB7tNlQOGY0Wy8wgk=
X-Google-Smtp-Source: ABdhPJwnW1RvrcVODnW70uNtPrYbnrpCk9WOqcxhEq9h1Nv1rIwy4bvzp7Yhn53VtkNUphXFsu0vOg==
X-Received: by 2002:a17:902:7b83:b029:db:d71b:2c4d with SMTP id w3-20020a1709027b83b02900dbd71b2c4dmr72142144pll.81.1609765646299;
        Mon, 04 Jan 2021 05:07:26 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id b189sm55303786pfb.194.2021.01.04.05.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 05:07:25 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [RFC PATCH V3 1/1] block: reject I/O for same fd if block size changed
Date:   Mon,  4 Jan 2021 22:06:59 +0900
Message-Id: <20210104130659.22511-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210104130659.22511-1-minwoo.im.dev@gmail.com>
References: <20210104130659.22511-1-minwoo.im.dev@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch fixes I/O errors during BLKRRPART ioctl() behavior right
after format operation that changed logical block size of the block
device with a same file descriptor opened.

This issue can be easily reproduced with a single format command in case
of NVMe (logical block size 512B to 4096B).

	nvme format /dev/nvme0n1 --lbaf=1 --force

This is because the application, nvme-cli format subcommand issues an
admin command followed by BLKRRPART ioctl to re-read partition
information without closing the file descriptor.  If file descriptor
stays opened, __blkdev_get() will not be invoked at all even logical
block size has been changed.

It will cause I/O errors with invalid Read operations during the
BLKRRPART ioctl due to i_blkbits mismatch. The invalid operations in
BLKRRPART happens with under-flowed Number of LBA(NLB) values
0xffff(65535) because i_blkbits is still set to 9 even the logical block
size has been updated to 4096.  The BLKRRPART will lead buffer_head to
hold 512B data which is less than the logical lock size of the block
device.

The root cause, which is because i_blkbits of inode of the block device
is not updated, can be solved easily by re-opening file descriptor
again from application.  But, that's just for application's business
and kernel should reject invalid Read operations during the BLKRRPART
ioctl.

This patch rejects I/O from the path of add_partitions() to avoid
issuing invalid Read operations to device.  It also sets a flag to
gendisk in blk_queue_logical_block_size to minimize caller-side updates.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 block/blk-settings.c    |  8 ++++++++
 block/partitions/core.c | 11 +++++++++++
 fs/block_dev.c          |  6 ++++++
 include/linux/genhd.h   |  1 +
 4 files changed, 26 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 43990b1d148b..84136ea4e2a4 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -328,6 +328,14 @@ EXPORT_SYMBOL(blk_queue_max_segment_size);
 void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
 {
 	struct queue_limits *limits = &q->limits;
+	struct block_device *bdev;
+
+	if (q->backing_dev_info && q->backing_dev_info->owner &&
+			limits->logical_block_size != size) {
+		bdev = blkdev_get_no_open(q->backing_dev_info->owner->devt);
+		bdev->bd_disk->flags |= GENHD_FL_BLOCK_SIZE_CHANGED;
+		blkdev_put_no_open(bdev);
+	}
 
 	limits->logical_block_size = size;
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index e7d776db803b..5a0330c1b6f9 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -618,6 +618,17 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	if (!disk_part_scan_enabled(disk))
 		return 0;
 
+	/*
+	 * Reject to check partition information if block size has been changed
+	 * in the runtime.  If block size of a block device has been changed,
+	 * the file descriptor should be opened agian to update the blkbits.
+	 */
+	if (disk->flags & GENHD_FL_BLOCK_SIZE_CHANGED) {
+		pr_warn("%s: rejecting checking partition. fd should be opened again.\n",
+				disk->disk_name);
+		return -EBADFD;
+	}
+
 	state = check_partition(disk, bdev);
 	if (!state)
 		return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9293045e128c..c996de3d6084 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -131,6 +131,12 @@ EXPORT_SYMBOL(truncate_bdev_range);
 static void set_init_blocksize(struct block_device *bdev)
 {
 	bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
+
+	/*
+	 * Allow I/O commands for this block device.  We can say that this
+	 * block device has been set to a proper block size.
+	 */
+	bdev->bd_disk->flags &= ~GENHD_FL_BLOCK_SIZE_CHANGED;
 }
 
 int set_blocksize(struct block_device *bdev, int size)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 809aaa32d53c..0e0e24917003 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -103,6 +103,7 @@ struct partition_meta_info {
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
+#define GENHD_FL_BLOCK_SIZE_CHANGED		0x0800
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
-- 
2.17.1

