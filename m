Return-Path: <linux-fsdevel+bounces-14403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B8487BF46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 15:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25CF1F2115D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754EC71723;
	Thu, 14 Mar 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taAbA3gy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346558104;
	Thu, 14 Mar 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427676; cv=none; b=tsVFUU/N0bxvWY5menQxf+9elXRPX/9QHa8ZUW29wzw+eIUsIaopZPk/zC2wSqKYjAg9T84UN2mbt5AzNXxoSFPYg1hmfDiFJGFu2M/Vo48V+dLaMdeCEGRbNDgcMjRqg6DmdNtmaJyucMufqBZ03WYVtTyrVsG/8Sg2hZZqpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427676; c=relaxed/simple;
	bh=d8NWfY0GhHJyd0+xMMvY88LD3k6G8Y5qwteiUz8SGYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8obXgp0WLKquNVBP6Drj1eHMn7dJIALW2xdffmui5F+vFaTzfUhqFYfe/pv2izX1Lv7jLWPrDnllLaK5ehSkzftoOIT6N9fWi/2Rm7wc/ddHl5FjoJnrlLFYKPB0xuFGcKXIzA9/JmXQp+vZVhfl6qrGhFsCAwK+r+gI5mx/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taAbA3gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C266C433F1;
	Thu, 14 Mar 2024 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427676;
	bh=d8NWfY0GhHJyd0+xMMvY88LD3k6G8Y5qwteiUz8SGYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=taAbA3gypO+K/rNSO5jHsRe68pQ2T2YfNkw+KH4gw4qYH62mXpFzlo1aFmmISUDYn
	 ANGWrV8XJnZhLD6R/wvakydrpqt+8DRkmE+F4xjD2WXR4WjReYcIBDL+vlDbqVSY1n
	 UQ5PqU9BZbxnd210+0UVpzug1HuGkI8sRM/l5goOGf7JlbBTUteaahuxCeI6tWmTCs
	 BIwowu78VrnCRa4+wriVFa+7rRp7RyEOmJj4ZbK9aIqnmoxzhLxzqwutKxWDuvs/KD
	 zXuW0y0vGx/9L/11j971XG7F7k0JDShAmIyMFbVRi3OXH1Du4KHynG346f2fm+5ejW
	 g7zQYBEA6wgDw==
Date: Thu, 14 Mar 2024 15:47:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/34] bdev: open block device as files
Message-ID: <20240314-entbehren-folglich-8c8fef0cd49b@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
 <ZfEQQ9jZZVes0WCZ@infradead.org>
 <20240314-anfassen-teilnahm-20890c4a22c3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240314-anfassen-teilnahm-20890c4a22c3@brauner>

On Thu, Mar 14, 2024 at 12:10:59PM +0100, Christian Brauner wrote:
> On Tue, Mar 12, 2024 at 07:32:35PM -0700, Christoph Hellwig wrote:
> > Now that this is in mainline it seems to cause blktests to crash
> > nbd/003 with a rather non-obvious oops for me:
> 
> Ok, will be looking into that next.

Ok, I know what's going on. Basically, fput() on the block device runs
asynchronously which means that bdev->bd_holder can still be set to @sb
after it has already been freed. Let me illustrate what I mean:

P1                                                 P2
mount(sb)                                          fd = open("/dev/nbd", ...)
-> file = bdev_file_open_by_dev(..., sb, ...)
   bdev->bd_holder = sb;

// Later on:

umount(sb)
->kill_block_super(sb)
|----> [fput() -> deferred via task work]
-> put_super(sb) -> frees the sb via rcu
|
|                                                 nbd_ioctl(NBD_CLEAR_SOCK)
|                                                 -> disk_force_media_change()
|                                                    -> bdev_mark_dead()
|                                                       -> fs_mark_dead()
|                                                          // Finds bdev->bd_holder == sb
|-> file->release::bdev_release()                          // Tries to get reference to it but it's freed; frees it again
   bdev->bd_holder = NULL;

Two solutions that come to my mind:

[1] Indicate to fput() that this is an internal block devices open and
    thus just close it synchronously. This is fine. First, because the block
    device superblock is never unmounted or anything so there's no risk
    from hanging there for any reason. Second, bdev_release() also ran
    synchronously so any issue that we'd see from calling
    file->f_op->release::bdev_release() we would have seen from
    bdev_release() itself. See [1.1] for a patch.

(2) Take a temporary reference to the holder when opening the block
    device. This is also fine afaict because we differentiate between
    passive and active references on superblocks and what we already do
    in fs_bdev_mark_dead() and friends. This mean we don't have to mess
    around with fput(). See [1.2] for a patch.

(3) Revert and cry. No patch.

Personally, I think (2) is more desirable because we don't lose the
async property of fput() and we don't need to have a new FMODE_* flag.
I'd like to do some more testing with this. Thoughts?

[1.1]:
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c       | 1 +
 fs/file_table.c    | 5 +++++
 include/linux/fs.h | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index e7adaaf1c219..d0c208a04b04 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -969,6 +969,7 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		return bdev_file;
 	}
 	ihold(bdev->bd_inode);
+	bdev_file->f_mode |= FMODE_BLOCKDEV;
 
 	ret = bdev_open(bdev, mode, holder, hops, bdev_file);
 	if (ret) {
diff --git a/fs/file_table.c b/fs/file_table.c
index 4f03beed4737..48d35dd67020 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -473,6 +473,11 @@ void fput(struct file *file)
 	if (atomic_long_dec_and_test(&file->f_count)) {
 		struct task_struct *task = current;
 
+		if (unlikely((file->f_mode & FMODE_BLOCKDEV))) {
+			__fput(file);
+			return;
+		}
+
 		if (unlikely(!(file->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
 			file_free(file);
 			return;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d5d5a4ee24f0..ceac9c0316a6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -121,6 +121,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_PWRITE		((__force fmode_t)0x10)
 /* File is opened for execution with sys_execve / sys_uselib */
 #define FMODE_EXEC		((__force fmode_t)0x20)
+
+/* File is opened as block device. */
+#define FMODE_BLOCKDEV		((__force fmode_t)0x100)
 /* 32bit hashes as llseek() offset (for directories) */
 #define FMODE_32BITHASH         ((__force fmode_t)0x200)
 /* 64bit hashes as llseek() offset (for directories) */
-- 
2.43.0

[1.2]:
Sketched-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           |  4 ++++
 fs/super.c             | 17 +++++++++++++++++
 include/linux/blkdev.h |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index e7adaaf1c219..a0d5960dc2b9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -627,6 +627,8 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		whole->bd_holder = NULL;
 	mutex_unlock(&bdev_lock);
 
+	if (bdev->bd_holder_ops && bdev->bd_holder_ops->put_holder)
+		bdev->bd_holder_ops->put_holder(holder);
 	/*
 	 * If this was the last claim, remove holder link and unblock evpoll if
 	 * it was a write holder.
@@ -902,6 +904,8 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		bdev_file->f_mode |= FMODE_NOWAIT;
 	bdev_file->f_mapping = bdev->bd_inode->i_mapping;
 	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
+	if (hops && hops->get_holder)
+		hops->get_holder(holder);
 	bdev_file->private_data = holder;
 
 	return 0;
diff --git a/fs/super.c b/fs/super.c
index ee05ab6b37e7..64dbbdbed93a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1515,11 +1515,28 @@ static int fs_bdev_thaw(struct block_device *bdev)
 	return error;
 }
 
+static void fs_bdev_super_get(void *data)
+{
+	struct super_block *sb = data;
+
+	spin_lock(&sb_lock);
+	sb->s_count++;
+	spin_unlock(&sb_lock);
+}
+
+static void fs_bdev_super_put(void *data)
+{
+	struct super_block *sb = data;
+	put_super(sb);
+}
+
 const struct blk_holder_ops fs_holder_ops = {
 	.mark_dead		= fs_bdev_mark_dead,
 	.sync			= fs_bdev_sync,
 	.freeze			= fs_bdev_freeze,
 	.thaw			= fs_bdev_thaw,
+	.get_holder		= fs_bdev_super_get,
+	.put_holder		= fs_bdev_super_put,
 };
 EXPORT_SYMBOL_GPL(fs_holder_ops);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f9b87c39cab0..d919e8bcb2c1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1505,6 +1505,9 @@ struct blk_holder_ops {
 	 * Thaw the file system mounted on the block device.
 	 */
 	int (*thaw)(struct block_device *bdev);
+
+	void (*get_holder)(void *holder);
+	void (*put_holder)(void *holder);
 };
 
 /*
-- 
2.43.0


