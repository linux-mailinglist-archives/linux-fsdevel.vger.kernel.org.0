Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F023034C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbhAZF1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbhAZBuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:50:07 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA260C0617AB;
        Mon, 25 Jan 2021 16:29:10 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 31so8684371plb.10;
        Mon, 25 Jan 2021 16:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1AHl1Jx34jtswhTgBtYxAYHOD6t8RmqegigD5lUsac8=;
        b=gA4LrW6ezNXmg9lXnOFBzmx/WQMapGLtPz5AUxxxYPROCquUMiYgpVgeuoDZfQwacZ
         4dwqRAO46GYB0vGxgzBJMA8HtmO7z8E2myH0rDY7GGbj75orW39T2cCO7wJlVrrCHZs4
         T542gosGDAcQv4rrktCCBwIxVTnEoNVBt4IFMKEz3q4DGsy2H5H0cQAngiUZo9W5c0XD
         oIjhCm5Pte2gNHuMjGQAOjE6RD3RKzvryxAdnLW5Z8vzBJsmAnJ/VXpCoXoPEafELaqj
         kKUiE6NfY5mXfU7bPtet06Qrjx9hlY/AiYeufbcwvfF85q/JbGN6IHuPHlbpVYvZc2RO
         lnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1AHl1Jx34jtswhTgBtYxAYHOD6t8RmqegigD5lUsac8=;
        b=sqkxBdMz3C/9MnBtGa+waful/ugk6VE6La3cn2tcyGolty1rirkmWxkVufTYzKk27G
         ACGX2crGItmOxG+6cMkn6yFVeVovnUnuc5ngvq+CNLv6jXSmaFnESQkq7ZBySl2Zs+ru
         mhmTN4qPWGNWa1rVcboS0uafRCawkHcgTUB/lRvP4pbTkDLY1iuLku29eIHn2mNuF/nE
         C2yHYX2KE3vhEHWjWkwRzenjJJUOMGcgVm+s2Ro0+J2kGeozBZGMadns+R7xNwCKJhAq
         JDYVbuhFg2rKFSDS7Q6p2ljJAwIxTegBH7QxFnlSrOvLFasvRVRBzXGBo7kxtAq2kmLS
         19KA==
X-Gm-Message-State: AOAM533ddv5zrNYfVvIlB2xoHOScUuIOCGW2S68CLE9S5ifqpxCLkQ1Q
        1RyeqGptc+9wUxv/tTRBoEejpTcYuh748w==
X-Google-Smtp-Source: ABdhPJyE9yobq1Vsf/eirkfosewjx3+aPxw3rFxwL5/dV9oYN0s9MY6mWyTofZqBXmFwH8TqPbigWA==
X-Received: by 2002:a17:90b:350:: with SMTP id fh16mr3029352pjb.232.1611620950036;
        Mon, 25 Jan 2021 16:29:10 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id 14sm16999418pfi.131.2021.01.25.16.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 16:29:09 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V6 1/1] block: reject I/O for same fd if block size changed
Date:   Tue, 26 Jan 2021 09:29:01 +0900
Message-Id: <20210126002901.5533-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126002901.5533-1-minwoo.im.dev@gmail.com>
References: <20210126002901.5533-1-minwoo.im.dev@gmail.com>
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
issuing invalid Read operations to device.  It sets a flag to
request_queue in blk_queue_logical_block_size to minimize caller-side
updates.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c    |  3 +++
 block/partitions/core.c | 12 ++++++++++++
 fs/block_dev.c          |  8 ++++++++
 include/linux/blkdev.h  |  1 +
 4 files changed, 24 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 4c974340f1a9..5b1e0bf54d7e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -329,6 +329,9 @@ void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
 {
 	struct queue_limits *limits = &q->limits;
 
+	if (limits->logical_block_size != size)
+		blk_queue_flag_set(QUEUE_FLAG_LBSZ_CHANGED, q);
+
 	limits->logical_block_size = size;
 
 	if (limits->physical_block_size < size)
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b1cdf88f96e2..092d6712c7fc 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -601,12 +601,24 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 {
+	struct request_queue *q = bdev_get_queue(bdev);
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p;
 
 	if (!disk_part_scan_enabled(disk))
 		return 0;
 
+	/*
+	 * Reject to check partition information if block size has been changed
+	 * in the runtime.  If block size of a block device has been changed,
+	 * the file descriptor should be opened agian to update the blkbits.
+	 */
+	if (test_bit(QUEUE_FLAG_LBSZ_CHANGED, &q->queue_flags)) {
+		pr_warn("%s: rejecting checking partition. fd should be opened again.\n",
+				disk->disk_name);
+		return -EBADFD;
+	}
+
 	state = check_partition(disk, bdev);
 	if (!state)
 		return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6f5bd9950baf..8555308c503d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -130,7 +130,15 @@ EXPORT_SYMBOL(truncate_bdev_range);
 
 static void set_init_blocksize(struct block_device *bdev)
 {
+	struct request_queue *q = bdev_get_queue(bdev);
+
 	bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
+
+	/*
+	 * Allow I/O commands for this block device.  We can say that this
+	 * block device has proper blkbits updated.
+	 */
+	blk_queue_flag_clear(QUEUE_FLAG_LBSZ_CHANGED, q);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 20f3706b6b2e..f725e933db40 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -621,6 +621,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_LBSZ_CHANGED	30	/* logical block size changed */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
-- 
2.17.1

