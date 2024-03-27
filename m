Return-Path: <linux-fsdevel+bounces-15385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BE88D9AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 09:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB201C23FD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139F43418B;
	Wed, 27 Mar 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN3+gpdK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CEB24205;
	Wed, 27 Mar 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529824; cv=none; b=WB8CpRRZ5Kbqs0sj70Xhv3ljThFJ0CO5XeMt3KZ7bSGTWFfd03TDrdXe66QoR8e3+z6m4+Cl1NnLFjAcddiIr4P8A2k6fY4clz1FTmBnmkaeCmXEGzrWD13ahKaFSFyTQxXSFaA5ZF6wgJMmdYRj4boJCvnj1WzdStx2E2SDtAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529824; c=relaxed/simple;
	bh=CPyt8dOdJgPOfXoxtqI4K1qh0sy7SN32hWmqkLuhppo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk111ryq3zHSzVlk8tBVUrO5lwDhK7M3kiypIPkjEYbW/RsGYeyTR3ufN1GwJrPyhpPYR657xiQwwthN4Qe1cJ5HokZ0LIvSygkUmmGeJNNCbNQQ9a83SOSwmSCfM3pbU2AGGiNqXTfbZxMfDaFDETDnSNMzX1OPcFaHw5M8/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN3+gpdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68624C433C7;
	Wed, 27 Mar 2024 08:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711529824;
	bh=CPyt8dOdJgPOfXoxtqI4K1qh0sy7SN32hWmqkLuhppo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rN3+gpdKsuQyrfEKh2lnr9CBilSBTnzNu4+Q/RFGDBZzWUu6gdMo7XAZg1kU0xq/+
	 FQHc/CQ9N3GaOgl4fELb2/woyzLBFnf1O4KCQG+Jv7IcVAK6pS3LHl3EG3O49k1s9B
	 7W/NLaDfg4+1zPds50ZE6Nx1R8DsoHFQxD68l0HbtSPb1SZRyowmDlQ5Em+NuEZ6kk
	 TVoTD3Gw4p5RdH9O+HW1U0NnM1ENf+oAw4/9OshF2z7sxx4drf8lz2hv8qwlFLBxJx
	 EjBuxTz6OT9W70TP0CKAIfNu05c0/m9g0vxxf76W1e9uCjJjr2kSyTKCE3hGuEG0Sy
	 5ObkMzZsDlliQ==
Date: Wed, 27 Mar 2024 09:56:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs,block: yield devices early
Message-ID: <20240327-befanden-morsen-9f691f5624f9@brauner>
References: <20240326-vfs-bdev-end_holder-v1-1-20af85202918@kernel.org>
 <20240326223213.ytrsxxjsq3twfsxy@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gzws4rsal6aab534"
Content-Disposition: inline
In-Reply-To: <20240326223213.ytrsxxjsq3twfsxy@quack3>


--gzws4rsal6aab534
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Mar 26, 2024 at 11:32:13PM +0100, Jan Kara wrote:
> On Tue 26-03-24 13:47:22, Christian Brauner wrote:
> > Currently a device is only really released once the umount returns to
> > userspace due to how file closing works. That ultimately could cause
> > an old umount assumption to be violated that concurrent umount and mount
> > don't fail. So an exclusively held device with a temporary holder should
> > be yielded before the filesystem is gone. Add a helper that allows
> > callers to do that. This also allows us to remove the two holder ops
> > that Linus wasn't excited about.
> > 
> > Fixes: f3a608827d1f ("bdev: open block device as files") # mainline only
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> ...
> > @@ -1012,6 +1005,29 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
> >  }
> >  EXPORT_SYMBOL(bdev_file_open_by_path);
> >  
> > +static inline void bd_yield_claim(struct file *bdev_file)
> > +{
> > +	struct block_device *bdev = file_bdev(bdev_file);
> > +	struct bdev_inode *bd_inode = BDEV_I(bdev_file->f_mapping->host);
> > +	void *holder = bdev_file->private_data;
> > +
> > +	lockdep_assert_held(&bdev->bd_disk->open_mutex);
> > +
> > +	if (WARN_ON_ONCE(IS_ERR_OR_NULL(holder)))
> > +		return;
> > +
> > +	if (holder != bd_inode) {
> > +		bdev_yield_write_access(bdev_file);
> 
> Hum, what if we teached bdev_yield_write_access() about special bd_inode
> holder and kept bdev_yield_write_access() and bd_yield_claim() separate as
> they were before this patch? IMHO it would make code a bit more
> understandable. Otherwise the patch looks good.

Ok, see appended patch where I folded in your suggestion.

--gzws4rsal6aab534
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fs-block-yield-devices-early.patch"

From 817d36e90a009dc63e28f9b3440b9c9f6a97fe6f Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 26 Mar 2024 13:47:22 +0100
Subject: [PATCH] fs,block: yield devices early

Currently a device is only really released once the umount returns to
userspace due to how file closing works. That ultimately could cause
an old umount assumption to be violated that concurrent umount and mount
don't fail. So an exclusively held device with a temporary holder should
be yielded before the filesystem is gone. Add a helper that allows
callers to do that. This also allows us to remove the two holder ops
that Linus wasn't excited about.

Link: https://lore.kernel.org/r/20240326-vfs-bdev-end_holder-v1-1-20af85202918@kernel.org
Fixes: f3a608827d1f ("bdev: open block device as files") # mainline only
Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 64 ++++++++++++++++++++++++++++++++++++------
 fs/bcachefs/super-io.c |  2 +-
 fs/cramfs/inode.c      |  2 +-
 fs/ext4/super.c        |  8 +++---
 fs/f2fs/super.c        |  2 +-
 fs/jfs/jfs_logmgr.c    |  4 +--
 fs/reiserfs/journal.c  |  2 +-
 fs/romfs/super.c       |  2 +-
 fs/super.c             | 24 ++--------------
 fs/xfs/xfs_buf.c       |  2 +-
 fs/xfs/xfs_super.c     |  6 ++--
 include/linux/blkdev.h | 11 +-------
 12 files changed, 75 insertions(+), 54 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index a1946a902df3..b8e32d933a63 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -583,9 +583,6 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder,
 	mutex_unlock(&bdev->bd_holder_lock);
 	bd_clear_claiming(whole, holder);
 	mutex_unlock(&bdev_lock);
-
-	if (hops && hops->get_holder)
-		hops->get_holder(holder);
 }
 
 /**
@@ -608,7 +605,6 @@ EXPORT_SYMBOL(bd_abort_claiming);
 static void bd_end_claim(struct block_device *bdev, void *holder)
 {
 	struct block_device *whole = bdev_whole(bdev);
-	const struct blk_holder_ops *hops = bdev->bd_holder_ops;
 	bool unblock = false;
 
 	/*
@@ -631,9 +627,6 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		whole->bd_holder = NULL;
 	mutex_unlock(&bdev_lock);
 
-	if (hops && hops->put_holder)
-		hops->put_holder(holder);
-
 	/*
 	 * If this was the last claim, remove holder link and unblock evpoll if
 	 * it was a write holder.
@@ -813,6 +806,11 @@ static void bdev_claim_write_access(struct block_device *bdev, blk_mode_t mode)
 		bdev->bd_writers++;
 }
 
+static inline bool bdev_unclaimed(const struct file *bdev_file)
+{
+	return bdev_file->private_data == BDEV_I(bdev_file->f_mapping->host);
+}
+
 static void bdev_yield_write_access(struct file *bdev_file)
 {
 	struct block_device *bdev;
@@ -820,6 +818,9 @@ static void bdev_yield_write_access(struct file *bdev_file)
 	if (bdev_allow_write_mounted)
 		return;
 
+	if (bdev_unclaimed(bdev_file))
+		return;
+
 	bdev = file_bdev(bdev_file);
 
 	if (bdev_file->f_mode & FMODE_WRITE_RESTRICTED)
@@ -1012,6 +1013,20 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(bdev_file_open_by_path);
 
+static inline void bd_yield_claim(struct file *bdev_file)
+{
+	struct block_device *bdev = file_bdev(bdev_file);
+	void *holder = bdev_file->private_data;
+
+	lockdep_assert_held(&bdev->bd_disk->open_mutex);
+
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(holder)))
+		return;
+
+	if (!bdev_unclaimed(bdev_file))
+		bd_end_claim(bdev, holder);
+}
+
 void bdev_release(struct file *bdev_file)
 {
 	struct block_device *bdev = file_bdev(bdev_file);
@@ -1036,7 +1051,7 @@ void bdev_release(struct file *bdev_file)
 	bdev_yield_write_access(bdev_file);
 
 	if (holder)
-		bd_end_claim(bdev, holder);
+		bd_yield_claim(bdev_file);
 
 	/*
 	 * Trigger event checking and tell drivers to flush MEDIA_CHANGE
@@ -1056,6 +1071,39 @@ void bdev_release(struct file *bdev_file)
 	blkdev_put_no_open(bdev);
 }
 
+/**
+ * bdev_fput - yield claim to the block device and put the file
+ * @bdev_file: open block device
+ *
+ * Yield claim on the block device and put the file. Ensure that the
+ * block device can be reclaimed before the file is closed which is a
+ * deferred operation.
+ */
+void bdev_fput(struct file *bdev_file)
+{
+	if (WARN_ON_ONCE(bdev_file->f_op != &def_blk_fops))
+		return;
+
+	if (bdev_file->private_data) {
+		struct block_device *bdev = file_bdev(bdev_file);
+		struct gendisk *disk = bdev->bd_disk;
+
+		mutex_lock(&disk->open_mutex);
+		bdev_yield_write_access(bdev_file);
+		bd_yield_claim(bdev_file);
+		/*
+		 * Tell release we already gave up our hold on the
+		 * device and if write restrictions are available that
+		 * we already gave up write access to the device.
+		 */
+		bdev_file->private_data = BDEV_I(bdev_file->f_mapping->host);
+		mutex_unlock(&disk->open_mutex);
+	}
+
+	fput(bdev_file);
+}
+EXPORT_SYMBOL(bdev_fput);
+
 /**
  * lookup_bdev() - Look up a struct block_device by name.
  * @pathname: Name of the block device in the filesystem.
diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index ad28e370b640..cb7b4de11a49 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -143,7 +143,7 @@ void bch2_free_super(struct bch_sb_handle *sb)
 {
 	kfree(sb->bio);
 	if (!IS_ERR_OR_NULL(sb->s_bdev_file))
-		fput(sb->s_bdev_file);
+		bdev_fput(sb->s_bdev_file);
 	kfree(sb->holder);
 	kfree(sb->sb_name);
 
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 39e75131fd5a..9901057a15ba 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -495,7 +495,7 @@ static void cramfs_kill_sb(struct super_block *sb)
 		sb->s_mtd = NULL;
 	} else if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV) && sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		fput(sb->s_bdev_file);
+		bdev_fput(sb->s_bdev_file);
 	}
 	kfree(sbi);
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cfb8449c731f..044135796f2b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5668,7 +5668,7 @@ failed_mount9: __maybe_unused
 	brelse(sbi->s_sbh);
 	if (sbi->s_journal_bdev_file) {
 		invalidate_bdev(file_bdev(sbi->s_journal_bdev_file));
-		fput(sbi->s_journal_bdev_file);
+		bdev_fput(sbi->s_journal_bdev_file);
 	}
 out_fail:
 	invalidate_bdev(sb->s_bdev);
@@ -5913,7 +5913,7 @@ static struct file *ext4_get_journal_blkdev(struct super_block *sb,
 out_bh:
 	brelse(bh);
 out_bdev:
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 	return ERR_PTR(errno);
 }
 
@@ -5952,7 +5952,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 out_journal:
 	jbd2_journal_destroy(journal);
 out_bdev:
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 	return ERR_PTR(errno);
 }
 
@@ -7327,7 +7327,7 @@ static void ext4_kill_sb(struct super_block *sb)
 	kill_block_super(sb);
 
 	if (bdev_file)
-		fput(bdev_file);
+		bdev_fput(bdev_file);
 }
 
 static struct file_system_type ext4_fs_type = {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a6867f26f141..a4bc26dfdb1a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1558,7 +1558,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
 		if (i > 0)
-			fput(FDEV(i).bdev_file);
+			bdev_fput(FDEV(i).bdev_file);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 73389c68e251..9609349e92e5 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1141,7 +1141,7 @@ int lmLogOpen(struct super_block *sb)
 	lbmLogShutdown(log);
 
       close:		/* close external log device */
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 
       free:		/* free log descriptor */
 	mutex_unlock(&jfs_log_mutex);
@@ -1485,7 +1485,7 @@ int lmLogClose(struct super_block *sb)
 	bdev_file = log->bdev_file;
 	rc = lmLogShutdown(log);
 
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 
 	kfree(log);
 
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 6474529c4253..e539ccd39e1e 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2589,7 +2589,7 @@ static void journal_list_init(struct super_block *sb)
 static void release_journal_dev(struct reiserfs_journal *journal)
 {
 	if (journal->j_bdev_file) {
-		fput(journal->j_bdev_file);
+		bdev_fput(journal->j_bdev_file);
 		journal->j_bdev_file = NULL;
 	}
 }
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 2be227532f39..2cbb92462074 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -594,7 +594,7 @@ static void romfs_kill_sb(struct super_block *sb)
 #ifdef CONFIG_ROMFS_ON_BLOCK
 	if (sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		fput(sb->s_bdev_file);
+		bdev_fput(sb->s_bdev_file);
 	}
 #endif
 }
diff --git a/fs/super.c b/fs/super.c
index 71d9779c42b1..69ce6c600968 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1515,29 +1515,11 @@ static int fs_bdev_thaw(struct block_device *bdev)
 	return error;
 }
 
-static void fs_bdev_super_get(void *data)
-{
-	struct super_block *sb = data;
-
-	spin_lock(&sb_lock);
-	sb->s_count++;
-	spin_unlock(&sb_lock);
-}
-
-static void fs_bdev_super_put(void *data)
-{
-	struct super_block *sb = data;
-
-	put_super(sb);
-}
-
 const struct blk_holder_ops fs_holder_ops = {
 	.mark_dead		= fs_bdev_mark_dead,
 	.sync			= fs_bdev_sync,
 	.freeze			= fs_bdev_freeze,
 	.thaw			= fs_bdev_thaw,
-	.get_holder		= fs_bdev_super_get,
-	.put_holder		= fs_bdev_super_put,
 };
 EXPORT_SYMBOL_GPL(fs_holder_ops);
 
@@ -1562,7 +1544,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	 * writable from userspace even for a read-only block device.
 	 */
 	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
-		fput(bdev_file);
+		bdev_fput(bdev_file);
 		return -EACCES;
 	}
 
@@ -1573,7 +1555,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	if (atomic_read(&bdev->bd_fsfreeze_count) > 0) {
 		if (fc)
 			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		fput(bdev_file);
+		bdev_fput(bdev_file);
 		return -EBUSY;
 	}
 	spin_lock(&sb_lock);
@@ -1693,7 +1675,7 @@ void kill_block_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
-		fput(sb->s_bdev_file);
+		bdev_fput(sb->s_bdev_file);
 	}
 }
 
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 1a18c381127e..f0fa02264eda 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2030,7 +2030,7 @@ xfs_free_buftarg(
 	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
 	/* the main block device is closed by kill_block_super */
 	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
-		fput(btp->bt_bdev_file);
+		bdev_fput(btp->bt_bdev_file);
 	kfree(btp);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index c21f10ab0f5d..bce020374c5e 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -485,7 +485,7 @@ xfs_open_devices(
 		mp->m_logdev_targp = mp->m_ddev_targp;
 		/* Handle won't be used, drop it */
 		if (logdev_file)
-			fput(logdev_file);
+			bdev_fput(logdev_file);
 	}
 
 	return 0;
@@ -497,10 +497,10 @@ xfs_open_devices(
 	xfs_free_buftarg(mp->m_ddev_targp);
  out_close_rtdev:
 	 if (rtdev_file)
-		fput(rtdev_file);
+		bdev_fput(rtdev_file);
  out_close_logdev:
 	if (logdev_file)
-		fput(logdev_file);
+		bdev_fput(logdev_file);
 	return error;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be..172c91879999 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1505,16 +1505,6 @@ struct blk_holder_ops {
 	 * Thaw the file system mounted on the block device.
 	 */
 	int (*thaw)(struct block_device *bdev);
-
-	/*
-	 * If needed, get a reference to the holder.
-	 */
-	void (*get_holder)(void *holder);
-
-	/*
-	 * Release the holder.
-	 */
-	void (*put_holder)(void *holder);
 };
 
 /*
@@ -1585,6 +1575,7 @@ static inline int early_lookup_bdev(const char *pathname, dev_t *dev)
 
 int bdev_freeze(struct block_device *bdev);
 int bdev_thaw(struct block_device *bdev);
+void bdev_fput(struct file *bdev_file);
 
 struct io_comp_batch {
 	struct request *req_list;
-- 
2.43.0


--gzws4rsal6aab534--

