Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63AB2F4D40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 15:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbhAMOgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 09:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbhAMOgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:36:11 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E5AC0617A2;
        Wed, 13 Jan 2021 06:34:56 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q7so1614263pgm.5;
        Wed, 13 Jan 2021 06:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sesLVgnwP7XNfVw93uzCMsBbwsNC3kfCmoQy7b5qpcU=;
        b=Al8dE884+Wrc0UtcjaEyhg6+sY/riXv3MPBpQSUXyVCsKo/DWWk5fTBIT7bGVv42NW
         ghzzdWQQTuTg+zvmVGt5GGGWHCPmiH61wePLhNE4TSHBIynRqHJJCpHmdqRM1mmAofI5
         yzgEbOLVJU3q3rJbhPHV6CVVkFji31C4hlWEKCrzOcrNTrkkLxBQBJrR69ZktvuLKa2i
         blayoM+5CE4jsvH7V1Xv+AzXT4o3N+misMO8/aIacaC/6eRXXW86OZ55k6VxvNrgM9EJ
         wAi81rQz6KQSzZJnFvVjYzbxLgFNpcsA5O5a4lj82NV19Od2K0O0zghr+NM7pdN/nMwb
         O4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sesLVgnwP7XNfVw93uzCMsBbwsNC3kfCmoQy7b5qpcU=;
        b=rJSVqMvL4qTXiAWRM6fV2FqzR8hYzY8J+p1hXemnN1J7mBs1tcXol8D6n4wzTIaYMG
         S1X+NylK9wFZoudElwtryLWh2Fh1iJXa4MNgFW3nzh1MAmGyvwVAPzRW51Y1P994tgjO
         0G1eXirVBi/AB7SgoXgxaMagDWJVnu/PRp1fzyOMPmipO4qi7T2zJrpEfkTR1vnMhXxH
         WEEtGd9FKl5mcMxBbBXduORK+cEqcLGosZJwbO/D6LzDENDxlgjF/s7SKqUpR3NNbab1
         WXBksMeSbeCmgWZNMtDQrnm9C5LLAoHCQLE/PS0W4IeKjaWdORk+VS5TwvSFNWQi7Gi6
         tE7w==
X-Gm-Message-State: AOAM5318CBV9IB7/4RySCN4jstRliCGOHoF31icSXs6VkkTRuGBAw+qd
        b1UpuGIdI2nvChlxstMEi7/BHBajpKLG+g==
X-Google-Smtp-Source: ABdhPJwoNupYnLwb/wY+pl4lhOoDXLr0wKJVFe7in+OkRGY/maIa1t6wRz7GDD9EwP6+10SAKB3QOA==
X-Received: by 2002:a62:5b85:0:b029:19e:432a:2717 with SMTP id p127-20020a625b850000b029019e432a2717mr2430275pfb.73.1610548496073;
        Wed, 13 Jan 2021 06:34:56 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id c5sm3248265pjo.4.2021.01.13.06.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:34:55 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V5 1/1] block: reject I/O for same fd if block size changed
Date:   Wed, 13 Jan 2021 23:34:32 +0900
Message-Id: <20210113143432.426-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210113143432.426-1-minwoo.im.dev@gmail.com>
References: <20210113143432.426-1-minwoo.im.dev@gmail.com>
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
index 43990b1d148b..48a6fc7bb5f5 100644
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
index e7d776db803b..6f175ea18ff3 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -612,12 +612,24 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 {
+	struct request_queue *q = bdev_get_queue(bdev);
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p, highest;
 
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
index 3b8963e228a1..db5b0b75f0be 100644
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
index 070de09425ad..6d0542434be6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -625,6 +625,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_LBSZ_CHANGED	30	/* logical block size changed */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
-- 
2.17.1

