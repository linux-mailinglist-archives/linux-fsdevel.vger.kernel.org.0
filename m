Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50462E7AD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 17:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgL3QCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 11:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3QCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 11:02:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8F5C061799;
        Wed, 30 Dec 2020 08:01:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lb18so3572046pjb.5;
        Wed, 30 Dec 2020 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VLdvPWDa7LCErUP/uLe8+ItMhW4ZRtvNz7er1dEOMvM=;
        b=lLCnPptM7LYsfNHKsi/3Pbh0EnF+AbW96IKA4yofZcicmevcklJIGRv11R1QNBPMO6
         Rvs+Xw/Z+7E35G5/31rf9GP6V+22E05yFSmlAqzRxcHVvIF7/20XZC6AxalH9IqmDuUo
         b+M5Ta+QiiS2dvNaibFOsSRAnyqn+SIgqelekK9lhDaQZ2QqU8OEFK06dLnfHksTUX4t
         7Ul9AURhKoCIdGhlNT2GvjZKYnZdbyAU5eLv1ljSERz1jH2kazlLXY7bdJDHKB9XS2Ag
         g8owlA9dZG0QknWFhondp4HIN1u/CHDqlbsYwZMjgg3fdqmcI2n/Itmvkk7Ht51FJ6zs
         PFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VLdvPWDa7LCErUP/uLe8+ItMhW4ZRtvNz7er1dEOMvM=;
        b=ePOpxIi4bjYo2oT5+QON0RBzJJgy2noUfSSsHBE17TwXY0V2IARrZXjRVWkqbUjRQ8
         xaEU7Z9HTpKQ2lPHrUbLRVL5naNZIFeEzDyQXX+cgQzFPNSlQvjpIEG1yDIGmcjVuPQ8
         kMGdrRpvGZOIzo0zVLXCkE5yFeFlzfEdMXx94odnJVEpEJhUopUkXx7oxF/wsoC2k12C
         1TJ7NoksMETdduUy5qMyzdoRzPowPZ9wmo3ekGZlsBKKs2gxNgXZB+6y2xG2nBwU3O5q
         1mPN/GuMlxi3ITEJE99R3Co5QFpiRRvVo71F77KiCNc6S87u2zDutbBfmYvFwt+Dkolf
         KulQ==
X-Gm-Message-State: AOAM533A7sVAN+mKSuRGgOhJTR5SS8m6s3xPDilDik4V/3IdyChydnUg
        XaGbm3GqzjFEFEkx4h3m8wKDIvaOu5YIyQ==
X-Google-Smtp-Source: ABdhPJwWElenlBNj0qZFmQEZkHC+eKVHm2nrmbRXHXtpWV0VWeSuGOfqx+yCAXwynQ+lEBK6LcZ/bg==
X-Received: by 2002:a17:90b:1202:: with SMTP id gl2mr9429539pjb.123.1609344094804;
        Wed, 30 Dec 2020 08:01:34 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id y8sm7590524pji.55.2020.12.30.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 08:01:34 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [RFC V2] block: reject I/O for same fd if block size changed
Date:   Thu, 31 Dec 2020 01:01:29 +0900
Message-Id: <20201230160129.23731-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's say, for example of NVMe device, Format command to change out
LBA format to another logical block size and BLKRRPART to re-read
partition information with a same file descriptor like:

	fd = open("/dev/nvme0n1", O_RDONLY);

	nvme_format(fd, ...);
	if (ioctl(fd, BLKRRPART) < 0)
		..

In this case, ioctl causes invalid Read operations which are triggered
by buffer_head I/O path to re-read partition information.  This is
because it's still playing around with i_blksize and i_blkbits.  So,
512 -> 4096 -> 512 logical block size changes will cause an under-flowed
length of Read operations.

Case for NVMe:
  (LBAF 1 512B, LBAF 0 4K logical block size)

  nvme format /dev/nvme0n1 --lbaf=1 --force  # to 512B LBA
  nvme format /dev/nvme0n1 --lbaf=0 --force  # to 4096B LBA

[dmesg-snip]
  [   10.771740] blk_update_request: operation not supported error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
  [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async page read

[event-snip]
  kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=216, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=65535, ctrl=0x0, dsmgmt=0, reftag=0)
   ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=216, res=0x0, retries=0, flags=0x0, status=0x4002

As the previous discussion [1], this patch introduced a gendisk flag
to indicate that block size has been changed in the runtime.  This flag
is set when logical block size is changed in the runtime in the block
layer.  It will be cleared when the file descriptor for the
block devie is opened again through __blkdev_get() which updates the block
size via set_init_blocksize().

This patch rejects I/O from the path of add_partitions() to avoid
issuing invalid Read operations to device.  It also sets a flag to
gendisk in blk_queue_logical_block_size to minimize caller-side updates.

[1] https://lore.kernel.org/linux-nvme/20201223183143.GB13354@localhost.localdomain/T/#t

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 block/blk-settings.c    |  7 +++++++
 block/genhd.c           |  1 +
 block/partitions/core.c | 11 +++++++++++
 fs/block_dev.c          |  6 ++++++
 include/linux/genhd.h   |  1 +
 5 files changed, 26 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 43990b1d148b..205822ffcaef 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -328,6 +328,13 @@ EXPORT_SYMBOL(blk_queue_max_segment_size);
 void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
 {
 	struct queue_limits *limits = &q->limits;
+	struct block_device *bdev;
+
+	if (q->backing_dev_info && q->backing_dev_info->owner &&
+			limits->logical_block_size != size) {
+		bdev = blkdev_get_no_open(q->backing_dev_info->owner->devt);
+		bdev->bd_disk->flags |= GENHD_FL_BLOCK_SIZE_CHANGED;
+	}
 
 	limits->logical_block_size = size;
 
diff --git a/block/genhd.c b/block/genhd.c
index 73faec438e49..c3a73cba7c88 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -81,6 +81,7 @@ bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 	 */
 	if (!capacity || !size)
 		return false;
+
 	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
 	return true;
 }
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

