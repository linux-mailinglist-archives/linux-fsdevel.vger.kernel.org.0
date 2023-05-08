Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771B46F9D4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 03:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjEHBRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 21:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjEHBRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 21:17:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA9F4698;
        Sun,  7 May 2023 18:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kBqqORDo5ZDeQubFLWt/Ze74JpFUmhricU9x7bL4UTQ=; b=h6trr0sC7qNp8uHXMnyvLn/Jan
        KuDgv/M0kH9YyEtN4IrpZFJUwK1NTw7h9L9jpf6EUCv1sZrwsCz+lMaZc+aH4aVNg8nnH0ma+sRJB
        ylWv14+go3Hzo+xUegcVMxLMqWhtgrChqPj+Aev5wfVx5RXmksHRgOxgoXLwDVIM45xCWi+pFwiwe
        LMLVkKI+DfSF+H3RTMBIVKVxTX8GXCADgFs3jMf8WRo9048F/FFDL9WYOYaPNRePTBmbOVNGzWUnz
        aZ6/KzqhZ9w8lM7pexORnK8MU4U5TMyUCnGr2uR933XScy2l6La3PNEao+QMr6LHDIgRHZyNVQFuY
        lycRanxA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvpV7-00GvYy-2e;
        Mon, 08 May 2023 01:17:17 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/6] fs: unify locking semantics for fs freeze / thaw
Date:   Sun,  7 May 2023 18:17:12 -0700
Message-Id: <20230508011717.4034511-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508011717.4034511-1-mcgrof@kernel.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now freeze_super()  and thaw_super() are called with
different locking contexts. To expand on this is messy, so
just unify the requirement to require grabbing an active
reference and keep the superblock locked.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c    |  5 +++-
 fs/f2fs/gc.c    |  5 ++++
 fs/gfs2/super.c |  9 +++++--
 fs/gfs2/sys.c   |  6 +++++
 fs/gfs2/util.c  |  5 ++++
 fs/ioctl.c      | 12 ++++++++--
 fs/super.c      | 62 ++++++++++++++++++-------------------------------
 7 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 21c63bfef323..dc54a2a1c46e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -251,7 +251,7 @@ int freeze_bdev(struct block_device *bdev)
 		error = sb->s_op->freeze_super(sb);
 	else
 		error = freeze_super(sb);
-	deactivate_super(sb);
+	deactivate_locked_super(sb);
 
 	if (error) {
 		bdev->bd_fsfreeze_count--;
@@ -289,6 +289,8 @@ int thaw_bdev(struct block_device *bdev)
 	sb = bdev->bd_fsfreeze_sb;
 	if (!sb)
 		goto out;
+	if (!get_active_super(bdev))
+		goto out;
 
 	if (sb->s_op->thaw_super)
 		error = sb->s_op->thaw_super(sb);
@@ -298,6 +300,7 @@ int thaw_bdev(struct block_device *bdev)
 		bdev->bd_fsfreeze_count++;
 	else
 		bdev->bd_fsfreeze_sb = NULL;
+	deactivate_locked_super(sb);
 out:
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	return error;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 61c5f9d26018..e31d6791d3e3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2166,7 +2166,10 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 	if (err)
 		return err;
 
+	if (!get_active_super(sbi->sb->s_bdev))
+		return -ENOTTY;
 	freeze_super(sbi->sb);
+
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_down_write(&sbi->cp_global_sem);
 
@@ -2217,6 +2220,8 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 out_err:
 	f2fs_up_write(&sbi->cp_global_sem);
 	f2fs_up_write(&sbi->gc_lock);
+	/* We use the same active reference from freeze */
 	thaw_super(sbi->sb);
+	deactivate_locked_super(sbi->sb);
 	return err;
 }
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 5eed8c237500..e57cb593e2f3 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -676,7 +676,12 @@ void gfs2_freeze_func(struct work_struct *work)
 	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_freeze_work);
 	struct super_block *sb = sdp->sd_vfs;
 
-	atomic_inc(&sb->s_active);
+	if (!get_active_super(sb->s_bdev)) {
+		fs_info(sdp, "GFS2: couldn't grap super for thaw for filesystem\n");
+		gfs2_assert_withdraw(sdp, 0);
+		return;
+	}
+
 	error = gfs2_freeze_lock(sdp, &freeze_gh, 0);
 	if (error) {
 		gfs2_assert_withdraw(sdp, 0);
@@ -690,7 +695,7 @@ void gfs2_freeze_func(struct work_struct *work)
 		}
 		gfs2_freeze_unlock(&freeze_gh);
 	}
-	deactivate_super(sb);
+	deactivate_locked_super(sb);
 	clear_bit_unlock(SDF_FS_FROZEN, &sdp->sd_flags);
 	wake_up_bit(&sdp->sd_flags, SDF_FS_FROZEN);
 	return;
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 454dc2ff8b5e..cbb71c3520c0 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -164,6 +164,9 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (!get_active_super(sb->s_bdev))
+		return -ENOTTY;
+
 	switch (n) {
 	case 0:
 		error = thaw_super(sdp->sd_vfs);
@@ -172,9 +175,12 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 		error = freeze_super(sdp->sd_vfs);
 		break;
 	default:
+		deactivate_locked_super(sb);
 		return -EINVAL;
 	}
 
+	deactivate_locked_super(sb);
+
 	if (error) {
 		fs_warn(sdp, "freeze %d error %d\n", n, error);
 		return error;
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 7a6aeffcdf5c..3a0cd5e9ad84 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -345,10 +345,15 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 	set_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
 
 	if (sdp->sd_args.ar_errors == GFS2_ERRORS_WITHDRAW) {
+		if (!get_active_super(sb->s_bdev)) {
+			fs_err(sdp, "could not grab super on withdraw for file system\n");
+			return -1;
+		}
 		fs_err(sdp, "about to withdraw this file system\n");
 		BUG_ON(sdp->sd_args.ar_debug);
 
 		signal_our_withdraw(sdp);
+		deactivate_locked_super(sb);
 
 		kobject_uevent(&sdp->sd_kobj, KOBJ_OFFLINE);
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 5b2481cd4750..1d20af762e0d 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -386,6 +386,7 @@ static int ioctl_fioasync(unsigned int fd, struct file *filp,
 static int ioctl_fsfreeze(struct file *filp)
 {
 	struct super_block *sb = file_inode(filp)->i_sb;
+	int ret;
 
 	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -394,10 +395,17 @@ static int ioctl_fsfreeze(struct file *filp)
 	if (sb->s_op->freeze_fs == NULL && sb->s_op->freeze_super == NULL)
 		return -EOPNOTSUPP;
 
+	if (!get_active_super(sb->s_bdev))
+		return -ENOTTY;
+
 	/* Freeze */
 	if (sb->s_op->freeze_super)
-		return sb->s_op->freeze_super(sb);
-	return freeze_super(sb);
+		ret = sb->s_op->freeze_super(sb);
+	ret = freeze_super(sb);
+
+	deactivate_locked_super(sb);
+
+	return ret;
 }
 
 static int ioctl_fsthaw(struct file *filp)
diff --git a/fs/super.c b/fs/super.c
index 34afe411cf2b..0e9d48846684 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -39,8 +39,6 @@
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
-static int thaw_super_locked(struct super_block *sb);
-
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
 
@@ -851,13 +849,13 @@ struct super_block *get_active_super(struct block_device *bdev)
 		if (sb->s_bdev == bdev) {
 			if (!grab_super(sb))
 				goto restart;
-			up_write(&sb->s_umount);
 			return sb;
 		}
 	}
 	spin_unlock(&sb_lock);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(get_active_super);
 
 struct super_block *user_get_super(dev_t dev, bool excl)
 {
@@ -1024,13 +1022,13 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb)
 {
-	down_write(&sb->s_umount);
+	if (!get_active_super(sb->s_bdev))
+		return;
 	if (sb->s_root && sb->s_flags & SB_BORN) {
 		emergency_thaw_bdev(sb);
-		thaw_super_locked(sb);
-	} else {
-		up_write(&sb->s_umount);
+		thaw_super(sb);
 	}
+	deactivate_locked_super(sb);
 }
 
 static void do_thaw_all(struct work_struct *work)
@@ -1636,10 +1634,13 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
 }
 
 /**
- * freeze_super - lock the filesystem and force it into a consistent state
+ * freeze_super - force a filesystem backed by a block device into a consistent state
  * @sb: the super to lock
  *
- * Syncs the super to make sure the filesystem is consistent and calls the fs's
+ * Used by filesystems and the kernel to freeze a fileystem backed by a block
+ * device into a consistent state. Callers must use get_active_super(bdev) to
+ * lock the @sb and when done must unlock it with deactivate_locked_super().
+ * Syncs the filesystem backed by the @sb and calls the filesystem's optional
  * freeze_fs.  Subsequent calls to this without first thawing the fs will return
  * -EBUSY.
  *
@@ -1672,22 +1673,15 @@ int freeze_super(struct super_block *sb)
 {
 	int ret;
 
-	atomic_inc(&sb->s_active);
-	down_write(&sb->s_umount);
-	if (sb->s_writers.frozen != SB_UNFROZEN) {
-		deactivate_locked_super(sb);
+	if (sb->s_writers.frozen != SB_UNFROZEN)
 		return -EBUSY;
-	}
 
-	if (!(sb->s_flags & SB_BORN)) {
-		up_write(&sb->s_umount);
+	if (!(sb->s_flags & SB_BORN))
 		return 0;	/* sic - it's "nothing to do" */
-	}
 
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
-		up_write(&sb->s_umount);
 		return 0;
 	}
 
@@ -1707,7 +1701,6 @@ int freeze_super(struct super_block *sb)
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
 		wake_up(&sb->s_writers.wait_unfrozen);
-		deactivate_locked_super(sb);
 		return ret;
 	}
 
@@ -1723,7 +1716,6 @@ int freeze_super(struct super_block *sb)
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
 			wake_up(&sb->s_writers.wait_unfrozen);
-			deactivate_locked_super(sb);
 			return ret;
 		}
 	}
@@ -1733,19 +1725,25 @@ int freeze_super(struct super_block *sb)
 	 */
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 	lockdep_sb_freeze_release(sb);
-	up_write(&sb->s_umount);
 	return 0;
 }
 EXPORT_SYMBOL(freeze_super);
 
-static int thaw_super_locked(struct super_block *sb)
+/**
+ * thaw_super -- unlock a filesystem backed by a block device
+ * @sb: the super to thaw
+ *
+ * Used by filesystems and the kernel to thaw a fileystem backed by a block
+ * device. Callers must use get_active_super(bdev) to lock the @sb and when
+ * done must unlock it with deactivate_locked_super(). Once done, this marks
+ * the filesystem as writeable.
+ */
+int thaw_super(struct super_block *sb)
 {
 	int error;
 
-	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
-		up_write(&sb->s_umount);
+	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
 		return -EINVAL;
-	}
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
@@ -1760,7 +1758,6 @@ static int thaw_super_locked(struct super_block *sb)
 			printk(KERN_ERR
 				"VFS:Filesystem thaw failed\n");
 			lockdep_sb_freeze_release(sb);
-			up_write(&sb->s_umount);
 			return error;
 		}
 	}
@@ -1769,21 +1766,8 @@ static int thaw_super_locked(struct super_block *sb)
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);
-	deactivate_locked_super(sb);
 	return 0;
 }
-
-/**
- * thaw_super -- unlock filesystem
- * @sb: the super to thaw
- *
- * Unlocks the filesystem and marks it writeable again after freeze_super().
- */
-int thaw_super(struct super_block *sb)
-{
-	down_write(&sb->s_umount);
-	return thaw_super_locked(sb);
-}
 EXPORT_SYMBOL(thaw_super);
 
 /*
-- 
2.39.2

