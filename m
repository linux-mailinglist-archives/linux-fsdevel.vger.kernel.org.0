Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50192EAAE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 13:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbhAEMaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 07:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730226AbhAEM2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:28:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C25C061574;
        Tue,  5 Jan 2021 04:27:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v3so16262372plz.13;
        Tue, 05 Jan 2021 04:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCJpwmdnZwt/uKHRtY639LOCKcFjRCkpFiLLDLiMMTA=;
        b=PpZvIHnwPrR7ghtYY4A7PxSbHFOQgPwblp/MQCEEf5Bv+Tzumyt6ZOoqnVARIheYG9
         DB1JTZwlUWKoyoQNgTS8+AUchogb3rYh9144A8Y7JFhwydB8/vxeOs/BWPBXOt8odHGD
         sTTuGXq561TDfKTh+LwvPyhtrY0Np5Oa+FzC1/Vipwx069MuOSP1WVSL/Dxq1jgeZKov
         3ADMhysUDyvbFMAixgKb3HfgKoNj+UtcnnsY3vzUVZGdnUqCN03hv7ZyLKaLqLEYn9r+
         CuuYQr0P08+1/uyWNv3vp1CIhxP9iqTdHV5NT6kDAYQvqx2b29njNkkuk+uX50JdU4a+
         R5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCJpwmdnZwt/uKHRtY639LOCKcFjRCkpFiLLDLiMMTA=;
        b=sdgE2D1htVzchi27+Lxb/ntrapLfj99CED6vq1IPIJKWjjNrfZAx463lKvBrbRyFxm
         fEKh9mkqiSRVFC0YLYyouYIYDG6VuaAuQkOyWITstAJohqI7gMOv+UHUma0+PyumI5vX
         TGnl40f6NUFQlCn7c1Yq+0I9QQdEJZp/zJJlpQS9c0+OSOQHH1H39bmTtyYZ4Qo6++oB
         fLgUGE0JTOyRaei2iZqpc/Zz1IJlCbbIDJvOL2IrwnGtUhr4LMTPMq0nmmthi/zHnvnL
         20EbPMQH6hswBX8smuTIjOr/sc6Sg7XsBtolfK6FL1rdgbWMDtlv8HPOV+Ir00SNpj9L
         qlsg==
X-Gm-Message-State: AOAM531J0RSy3HVG3Ne3T7b0uOX9UMNTqYGceVgmkoYkbC5uUZEHNFy7
        rJvEvwvTLF/LjMYyQaWib4koo9yPFACiKA==
X-Google-Smtp-Source: ABdhPJxHmldIRQrvO77IFzCFAUMwQikmaQIQwCUv1MOp5bwFqwX7c01BVi88X+weOQ5v4sUVoZ1Fdg==
X-Received: by 2002:a17:90a:5509:: with SMTP id b9mr3874173pji.230.1609849658703;
        Tue, 05 Jan 2021 04:27:38 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id gw7sm2599647pjb.36.2021.01.05.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:38 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V4 1/1] block: reject I/O for same fd if block size changed
Date:   Tue,  5 Jan 2021 21:27:17 +0900
Message-Id: <20210105122717.2568-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105122717.2568-1-minwoo.im.dev@gmail.com>
References: <20210105122717.2568-1-minwoo.im.dev@gmail.com>
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
index 9293045e128c..8056a412a3d1 100644
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

