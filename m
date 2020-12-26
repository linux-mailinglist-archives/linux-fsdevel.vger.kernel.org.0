Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104312E2EEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Dec 2020 19:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgLZSDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Dec 2020 13:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLZSDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Dec 2020 13:03:40 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC7FC061757;
        Sat, 26 Dec 2020 10:03:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b5so4230644pjl.0;
        Sat, 26 Dec 2020 10:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4Y9ogSPZ5hMKc7DdJiGJQd2mRtdieX3VWNe0j8nL7fs=;
        b=oFzNCb19GRT8pD+LMUtLpzqB7x0DS2l3VE5mW0qt2uThPZgjTqulgHPnz85BlJkLSx
         bs4sdbwrPDLWPSOnXUDofSnCWETl7KE2mu4/HlYuKgVftBKLo4LPZFHXGP12FbFJo1jK
         n5LIsRKAALfaG8B+KuBrC1W/beB9FwWZwjNuNSdGGUDmSp+Lype/0IRV2ZpBh0rqIfmM
         uyuR6xd0lHnx9RES/VR8t/Y0oYR9QBJfzqrV1Bbu9BPlkmNTNCG/Em5jEOOD04oWMrRN
         jroJNH+Vq/FFFDv63UUMegnuKbTT2PgIoMvowhp4mcqYov+yKV4oQRqg0wYcZThXf1qW
         nE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Y9ogSPZ5hMKc7DdJiGJQd2mRtdieX3VWNe0j8nL7fs=;
        b=e4TaFy+SkGJ8pEWT/xXiADkOFQxI4ilWa60sAKmzyNOS0vOEGFQv5t01eBnbcLHW+w
         YBSByJHyQ+jYm+44+l1wiNYZPq2s4bUEIQTc6/emoWvzRPT/3vSdc5k3JJM6O9Hd4X0M
         MpXnRNF/eZ4wT4+jjZgtlnCyeejEOh7bZHVpRcEin+2dNN/mfvjcxx7U9m3hqNLJbQ6r
         3WjWSJwd4aKKgQ+0J/yVZ6LLdfwnQJ19ozScwOxpa67kwvBnyszrncWv/Xptwfkdbdnw
         R8foOKdyl7QY5FBnwISXW+fQNkC3CqgpPO7uYwoKv7EsgvKUosbnerApXopU+jpOiK0U
         IXBA==
X-Gm-Message-State: AOAM531FQ938ibJo0mo2aFiSj9ZEOTsRvTqW/MonaYHkNs5Q/o+AbxcF
        lV7cS0bztwImYx0+HAtdwSnogY/jFEt0Xw==
X-Google-Smtp-Source: ABdhPJz1uhDLovrvbxwVJp0TqNK5JCQe3WYP09y4W3OhTDX1X//+4z1RlU16CKm+TeuGFRktfNgoIw==
X-Received: by 2002:a17:90a:b395:: with SMTP id e21mr13617612pjr.197.1609005779506;
        Sat, 26 Dec 2020 10:02:59 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id e24sm8467038pjt.16.2020.12.26.10.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 10:02:58 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [RFC] block: reject I/O in BLKRRPART if block size changed
Date:   Sun, 27 Dec 2020 03:02:32 +0900
Message-Id: <20201226180232.12276-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Background:
  Let's say we have 2 LBA format for 4096B and 512B LBA size for a
NVMe namespace.  Assume that current LBA format is 4096B and in case
we convert namespace to 512B and 4096B back again:

  nvme format /dev/nvme0n1 --lbaf=1 --force  # to 512B LBA
  nvme format /dev/nvme0n1 --lbaf=0 --force  # to 4096B LBA

  Then we can see the following errors during the BLKRRPART ioctl from
the nvme-cli format subcommand:

  [   10.771740] blk_update_request: operation not supported error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
  [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async page read
  ...

  Also, we can see the Read commands followed by the Format command due
to BLKRRPART ioctl with Number of LBAs to 65535(0xffff) which is
under-flowed because the request for the Read commands are coming with
512B and this is because it's playing around with i_blkbits from the
block_device inode which needs to be avoided as [1].

  kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=216, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=65535, ctrl=0x0, dsmgmt=0, reftag=0)
  ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=216, res=0x0, retries=0, flags=0x0, status=0x4002
  ...

  Before we have commit 5ff9f19231a0 ("block: simplify
set_init_blocksize"), block size used to be bumped up to the
4K(PAGE_SIZE) in this example and we have not seen these errors.  But
with this patch, we have to make sure that bdev->bd_inode->i_blkbits to
make sure that BLKRRPART ioctl pass proper request length based on the
changed logical block size.

Description:
  As the previous discussion [1], this patch introduced a gendisk flag
to indicate that block size has been changed in the runtime.  This flag
is set when logical block size is changed in the runtime with sector
capacity itself.  It will be cleared when the file descriptor for the
block devie is opened again which means __blkdev_get() updates the block
size via set_init_blocksize().
  This patch rejects I/O from the path of add_partitions() and
application should open the file descriptor again to update the block
size of the block device inode.

[1] https://lore.kernel.org/linux-nvme/20201223183143.GB13354@localhost.localdomain/T/#t

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 block/genhd.c           |  3 +++
 block/partitions/core.c | 11 +++++++++++
 fs/block_dev.c          |  6 ++++++
 include/linux/genhd.h   |  1 +
 4 files changed, 21 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index b84b8671e627..1f64907fac3d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -79,6 +79,9 @@ bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 	 */
 	if (!capacity || !size)
 		return false;
+
+	disk->flags |= GENHD_FL_BLOCK_SIZE_CHANGED;
+
 	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
 	return true;
 }
diff --git a/block/partitions/core.c b/block/partitions/core.c
index deca253583bd..7dfcda96be9e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -617,6 +617,17 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
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
index 9e56ee1f2652..813361ad77c1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -132,6 +132,12 @@ EXPORT_SYMBOL(truncate_bdev_range);
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

