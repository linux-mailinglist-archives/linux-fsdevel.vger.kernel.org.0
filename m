Return-Path: <linux-fsdevel+bounces-1754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2A57DE587
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 18:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86991C20DD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1905D18021;
	Wed,  1 Nov 2023 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w8FV8Scf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0nBcvimE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6848B567B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 17:43:32 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8C8A2;
	Wed,  1 Nov 2023 10:43:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52D80219E9;
	Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698860606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMIoF0inTaosbwWde8+j7j13+H+INUH3fz6LsHWjOU4=;
	b=w8FV8ScfCq87E5op8uCEbUPpwD0FAOB4fUMs2eIU82Jpk3B+dUJiNF7UqbVJAFLqBYNwh9
	I6nwklwiQRRw0p41XEstZurH7zM6N0b0XoS8hlJDZ5+IdBvD8NwmDkqHuB3fpuNX82QUuU
	ZxeQkb1CmLhchKNZVX635hQl0GKo8o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698860606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMIoF0inTaosbwWde8+j7j13+H+INUH3fz6LsHWjOU4=;
	b=0nBcvimER85KlyUHmdGE5E2igEJJwI0Cc88vu6Wok/vTeK+EzoN6qWLCt1kJRAnQLoWNiS
	3p3Rr8bY/ymFQQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 434BE1348D;
	Wed,  1 Nov 2023 17:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jLFkED6OQmUeYQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 01 Nov 2023 17:43:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D724CA0766; Wed,  1 Nov 2023 18:43:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>,
	<linux-xfs@vger.kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/7] block: Add config option to not allow writing to mounted devices
Date: Wed,  1 Nov 2023 18:43:08 +0100
Message-Id: <20231101174325.10596-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231101173542.23597-1-jack@suse.cz>
References: <20231101173542.23597-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7299; i=jack@suse.cz; h=from:subject; bh=Io/HLB5m0IwEZ8NtYmCUZJhK6j2St7OcHbbQHkzcxho=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlQo4sjypRwYB9k5A709UjDC3q/Jz8wurCuh+Aue8h FNhtX0+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZUKOLAAKCRCcnaoHP2RA2c5rB/ wL3Az6qAn6ilgz/Gy0iFe+EF5zW3WUxaGfn30PQtP7FNkIyiOsC0d20VyhKKEeWeIlv2bwDAnjUDex v2teGClU+4FPCGujM4LlJlG2K/kgi8YNBn7EDA6dooQINEZ5r3Ne1yuV/Dl2ejt0OD+xgYJt4q+s6G hlvZA/SgPx1lPpeRpjXD3LGBgzQMkPl9iijTbyzzYYY1turcSDkxNhgPqQ98aP3NJ57IN49lLxWvQn jfteyV4NTPIpChHBq50T0aLOZLb1fhTuaK5gLOlEdMl+jbYFFNZ+D21h8UsALl/eb58YbwxYaatFlS ih9c/W2f//+sOQuJOhKbcyROyoLgkV
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit

Writing to mounted devices is dangerous and can lead to filesystem
corruption as well as crashes. Furthermore syzbot comes with more and
more involved examples how to corrupt block device under a mounted
filesystem leading to kernel crashes and reports we can do nothing
about. Add tracking of writers to each block device and a kernel cmdline
argument which controls whether other writeable opens to block devices
open with BLK_OPEN_RESTRICT_WRITES flag are allowed. We will make
filesystems use this flag for used devices.

Note that this effectively only prevents modification of the particular
block device's page cache by other writers. The actual device content
can still be modified by other means - e.g. by issuing direct scsi
commands, by doing writes through devices lower in the storage stack
(e.g. in case loop devices, DM, or MD are involved) etc. But blocking
direct modifications of the block device page cache is enough to give
filesystems a chance to perform data validation when loading data from
the underlying storage and thus prevent kernel crashes.

Syzbot can use this cmdline argument option to avoid uninteresting
crashes. Also users whose userspace setup does not need writing to
mounted block devices can set this option for hardening.

Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/Kconfig             | 20 +++++++++++++
 block/bdev.c              | 62 ++++++++++++++++++++++++++++++++++++++-
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    |  2 ++
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index f1364d1c0d93..ca04b657e058 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -78,6 +78,26 @@ config BLK_DEV_INTEGRITY_T10
 	select CRC_T10DIF
 	select CRC64_ROCKSOFT
 
+config BLK_DEV_WRITE_MOUNTED
+	bool "Allow writing to mounted block devices"
+	default y
+	help
+	When a block device is mounted, writing to its buffer cache is very
+	likely going to cause filesystem corruption. It is also rather easy to
+	crash the kernel in this way since the filesystem has no practical way
+	of detecting these writes to buffer cache and verifying its metadata
+	integrity. However there are some setups that need this capability
+	like running fsck on read-only mounted root device, modifying some
+	features on mounted ext4 filesystem, and similar. If you say N, the
+	kernel will prevent processes from writing to block devices that are
+	mounted by filesystems which provides some more protection from runaway
+	privileged processes and generally makes it much harder to crash
+	filesystem drivers. Note however that this does not prevent
+	underlying device(s) from being modified by other means, e.g. by
+	directly submitting SCSI commands or through access to lower layers of
+	storage stack. If in doubt, say Y. The configuration can be overridden
+	with the bdev_allow_write_mounted boot option.
+
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
 	select MQ_IOSCHED_DEADLINE
diff --git a/block/bdev.c b/block/bdev.c
index 3f27939e02c6..d75dd7dd2b31 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -30,6 +30,9 @@
 #include "../fs/internal.h"
 #include "blk.h"
 
+/* Should we allow writing to mounted block devices? */
+static bool bdev_allow_write_mounted = IS_ENABLED(CONFIG_BLK_DEV_WRITE_MOUNTED);
+
 struct bdev_inode {
 	struct block_device bdev;
 	struct inode vfs_inode;
@@ -730,7 +733,34 @@ void blkdev_put_no_open(struct block_device *bdev)
 {
 	put_device(&bdev->bd_device);
 }
-	
+
+static bool bdev_writes_blocked(struct block_device *bdev)
+{
+	return bdev->bd_writers == -1;
+}
+
+static void bdev_block_writes(struct block_device *bdev)
+{
+	bdev->bd_writers = -1;
+}
+
+static void bdev_unblock_writes(struct block_device *bdev)
+{
+	bdev->bd_writers = 0;
+}
+
+static bool blkdev_open_compatible(struct block_device *bdev, blk_mode_t mode)
+{
+	if (!bdev_allow_write_mounted) {
+		/* Writes blocked? */
+		if (mode & BLK_OPEN_WRITE && bdev_writes_blocked(bdev))
+			return false;
+		if (mode & BLK_OPEN_RESTRICT_WRITES && bdev->bd_writers > 0)
+			return false;
+	}
+	return true;
+}
+
 /**
  * bdev_open_by_dev - open a block device by device number
  * @dev: device number of block device to open
@@ -773,6 +803,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	if (ret)
 		goto free_handle;
 
+	/* Blocking writes requires exclusive opener */
+	if (mode & BLK_OPEN_RESTRICT_WRITES && !holder)
+		return ERR_PTR(-EINVAL);
+
 	bdev = blkdev_get_no_open(dev);
 	if (!bdev) {
 		ret = -ENXIO;
@@ -800,12 +834,21 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		goto abort_claiming;
 	if (!try_module_get(disk->fops->owner))
 		goto abort_claiming;
+	ret = -EBUSY;
+	if (!blkdev_open_compatible(bdev, mode))
+		goto abort_claiming;
 	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
 	else
 		ret = blkdev_get_whole(bdev, mode);
 	if (ret)
 		goto put_module;
+	if (!bdev_allow_write_mounted) {
+		if (mode & BLK_OPEN_RESTRICT_WRITES)
+			bdev_block_writes(bdev);
+		else if (mode & BLK_OPEN_WRITE)
+			bdev->bd_writers++;
+	}
 	if (holder) {
 		bd_finish_claiming(bdev, holder, hops);
 
@@ -901,6 +944,14 @@ void bdev_release(struct bdev_handle *handle)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
+	if (!bdev_allow_write_mounted) {
+		/* The exclusive opener was blocking writes? Unblock them. */
+		if (handle->mode & BLK_OPEN_RESTRICT_WRITES)
+			bdev_unblock_writes(bdev);
+		else if (handle->mode & BLK_OPEN_WRITE)
+			bdev->bd_writers--;
+	}
+
 	if (handle->holder)
 		bd_end_claim(bdev, handle->holder);
 
@@ -1069,3 +1120,12 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 
 	blkdev_put_no_open(bdev);
 }
+
+static int __init setup_bdev_allow_write_mounted(char *str)
+{
+	if (kstrtobool(str, &bdev_allow_write_mounted))
+		pr_warn("Invalid option string for bdev_allow_write_mounted:"
+			" '%s'\n", str);
+	return 1;
+}
+__setup("bdev_allow_write_mounted=", setup_bdev_allow_write_mounted);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 749203277fee..52e264d5a830 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -66,6 +66,7 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
+	int			bd_writers;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
 	 * path
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7afc10315dd5..0e0c0186aa32 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -124,6 +124,8 @@ typedef unsigned int __bitwise blk_mode_t;
 #define BLK_OPEN_NDELAY		((__force blk_mode_t)(1 << 3))
 /* open for "writes" only for ioctls (specialy hack for floppy.c) */
 #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
+/* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
+#define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
 
 struct gendisk {
 	/*
-- 
2.35.3


