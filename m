Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E1A72B5D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 05:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjFLDP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 23:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjFLDP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:15:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2CBB;
        Sun, 11 Jun 2023 20:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C075261DB4;
        Mon, 12 Jun 2023 03:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295FCC433D2;
        Mon, 12 Jun 2023 03:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686539723;
        bh=i25gJ8aHvZCp1kE9b2V8twq6peEngvat0QHP4rshTvc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mhRGMvIbQjwxwHq/auw8TCDNGzSlphgclyZBKeEQEBkQYhTtcRTmkRg2gEXvGtPeU
         OCoE6I8HUIaQddYUWWL65i+pEc1UPJY2VG2/UBBYxluSGog8FIwUyRzLLOiOXroPfs
         8tjJ6+VG1P98ZgIxrzfr39k9eXyQI+FTdxhtfyk2dsUVRhxjzZx6ys7fsM1gQ9pOaY
         W5w1l1rVwf1bJAmwF0PXSPckzmzFDzxyRfzQVBidoWIM+lzDG3uezseVnOrn1iZRlZ
         Uduy2TfK0oRobEaqxTR5G8R7ILSRv3TpyahKKBKMGN4m3DYmeeAgffuNvgt/sO5QbO
         oXGZrv62DYMdA==
Subject: [PATCH 1/3] fs: distinguish between user initiated freeze and kernel
 initiated freeze
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, jack@suse.cz,
        hch@infradead.org, ruansy.fnst@fujitsu.com
Date:   Sun, 11 Jun 2023 20:15:22 -0700
Message-ID: <168653972267.755178.18328538743442432037.stgit@frogsfrogsfrogs>
In-Reply-To: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Userspace can freeze a filesystem using the FIFREEZE ioctl or by
suspending the block device; this state persists until userspace thaws
the filesystem with the FITHAW ioctl or resuming the block device.
Since commit 18e9e5104fcd ("Introduce freeze_super and thaw_super for
the fsfreeze ioctl") we only allow the first freeze command to succeed.

The kernel may decide that it is necessary to freeze a filesystem for
its own internal purposes, such as suspends in progress, filesystem fsck
activities, or quiescing a device prior to removal.  Userspace thaw
commands must never break a kernel freeze, and kernel thaw commands
shouldn't undo userspace's freeze command.

Introduce a couple of freeze holder flags and wire it into the
sb_writers state.  One kernel and one userspace freeze are allowed to
coexist at the same time; the filesystem will not thaw until both are
lifted.

I wonder if the f2fs/gfs2 code should be using a kernel freeze here, but
for now we'll use FREEZE_HOLDER_USERSPACE to preserve existing
behaviors.

Cc: mcgrof@kernel.org
Cc: jack@suse.cz
Cc: hch@infradead.org
Cc: ruansy.fnst@fujitsu.com
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 Documentation/filesystems/vfs.rst |    4 +-
 block/bdev.c                      |    8 ++--
 fs/f2fs/gc.c                      |    4 +-
 fs/gfs2/glops.c                   |    2 -
 fs/gfs2/super.c                   |    6 +--
 fs/gfs2/sys.c                     |    4 +-
 fs/gfs2/util.c                    |    2 -
 fs/ioctl.c                        |    8 ++--
 fs/super.c                        |   79 +++++++++++++++++++++++++++++++++----
 include/linux/fs.h                |   15 +++++--
 10 files changed, 100 insertions(+), 32 deletions(-)


diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 769be5230210..41cf2a56cbca 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -260,9 +260,9 @@ filesystem.  The following members are defined:
 		void (*evict_inode) (struct inode *);
 		void (*put_super) (struct super_block *);
 		int (*sync_fs)(struct super_block *sb, int wait);
-		int (*freeze_super) (struct super_block *);
+		int (*freeze_super) (struct super_block *, enum freeze_holder who);
 		int (*freeze_fs) (struct super_block *);
-		int (*thaw_super) (struct super_block *);
+		int (*thaw_super) (struct super_block *, enum freeze_wholder who);
 		int (*unfreeze_fs) (struct super_block *);
 		int (*statfs) (struct dentry *, struct kstatfs *);
 		int (*remount_fs) (struct super_block *, int *, char *);
diff --git a/block/bdev.c b/block/bdev.c
index 21c63bfef323..e8032c5beae0 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -248,9 +248,9 @@ int freeze_bdev(struct block_device *bdev)
 	if (!sb)
 		goto sync;
 	if (sb->s_op->freeze_super)
-		error = sb->s_op->freeze_super(sb);
+		error = sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
 	else
-		error = freeze_super(sb);
+		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
 	deactivate_super(sb);
 
 	if (error) {
@@ -291,9 +291,9 @@ int thaw_bdev(struct block_device *bdev)
 		goto out;
 
 	if (sb->s_op->thaw_super)
-		error = sb->s_op->thaw_super(sb);
+		error = sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
 	else
-		error = thaw_super(sb);
+		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
 	if (error)
 		bdev->bd_fsfreeze_count++;
 	else
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 61c5f9d26018..bca4e75c14e0 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2166,7 +2166,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 	if (err)
 		return err;
 
-	freeze_super(sbi->sb);
+	freeze_super(sbi->sb, FREEZE_HOLDER_USERSPACE);
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_down_write(&sbi->cp_global_sem);
 
@@ -2217,6 +2217,6 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 out_err:
 	f2fs_up_write(&sbi->cp_global_sem);
 	f2fs_up_write(&sbi->gc_lock);
-	thaw_super(sbi->sb);
+	thaw_super(sbi->sb, FREEZE_HOLDER_USERSPACE);
 	return err;
 }
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 01d433ed6ce7..6bffb7609d01 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -584,7 +584,7 @@ static int freeze_go_sync(struct gfs2_glock *gl)
 	if (gl->gl_state == LM_ST_SHARED && !gfs2_withdrawn(sdp) &&
 	    !test_bit(SDF_NORECOVERY, &sdp->sd_flags)) {
 		atomic_set(&sdp->sd_freeze_state, SFS_STARTING_FREEZE);
-		error = freeze_super(sdp->sd_vfs);
+		error = freeze_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE);
 		if (error) {
 			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
 				error);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index a84bf6444bba..3965b00a7503 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -682,7 +682,7 @@ void gfs2_freeze_func(struct work_struct *work)
 		gfs2_assert_withdraw(sdp, 0);
 	} else {
 		atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
-		error = thaw_super(sb);
+		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
 		if (error) {
 			fs_info(sdp, "GFS2: couldn't thaw filesystem: %d\n",
 				error);
@@ -702,7 +702,7 @@ void gfs2_freeze_func(struct work_struct *work)
  *
  */
 
-static int gfs2_freeze(struct super_block *sb)
+static int gfs2_freeze(struct super_block *sb, enum freeze_holder who)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int error;
@@ -747,7 +747,7 @@ static int gfs2_freeze(struct super_block *sb)
  *
  */
 
-static int gfs2_unfreeze(struct super_block *sb)
+static int gfs2_unfreeze(struct super_block *sb, enum freeze_holder who)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 454dc2ff8b5e..9d04a2907869 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -166,10 +166,10 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 
 	switch (n) {
 	case 0:
-		error = thaw_super(sdp->sd_vfs);
+		error = thaw_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE);
 		break;
 	case 1:
-		error = freeze_super(sdp->sd_vfs);
+		error = freeze_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE);
 		break;
 	default:
 		return -EINVAL;
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 7a6aeffcdf5c..357457b7c5b3 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -191,7 +191,7 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 		/* Make sure gfs2_unfreeze works if partially-frozen */
 		flush_work(&sdp->sd_freeze_work);
 		atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
-		thaw_super(sdp->sd_vfs);
+		thaw_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE);
 	} else {
 		wait_on_bit(&i_gl->gl_flags, GLF_DEMOTE,
 			    TASK_UNINTERRUPTIBLE);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 5b2481cd4750..a56cbceedcd1 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -396,8 +396,8 @@ static int ioctl_fsfreeze(struct file *filp)
 
 	/* Freeze */
 	if (sb->s_op->freeze_super)
-		return sb->s_op->freeze_super(sb);
-	return freeze_super(sb);
+		return sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+	return freeze_super(sb, FREEZE_HOLDER_USERSPACE);
 }
 
 static int ioctl_fsthaw(struct file *filp)
@@ -409,8 +409,8 @@ static int ioctl_fsthaw(struct file *filp)
 
 	/* Thaw */
 	if (sb->s_op->thaw_super)
-		return sb->s_op->thaw_super(sb);
-	return thaw_super(sb);
+		return sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+	return thaw_super(sb, FREEZE_HOLDER_USERSPACE);
 }
 
 static int ioctl_file_dedupe_range(struct file *file,
diff --git a/fs/super.c b/fs/super.c
index 34afe411cf2b..36adccecc828 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -39,7 +39,7 @@
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
-static int thaw_super_locked(struct super_block *sb);
+static int thaw_super_locked(struct super_block *sb, enum freeze_holder who);
 
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
@@ -1027,7 +1027,7 @@ static void do_thaw_all_callback(struct super_block *sb)
 	down_write(&sb->s_umount);
 	if (sb->s_root && sb->s_flags & SB_BORN) {
 		emergency_thaw_bdev(sb);
-		thaw_super_locked(sb);
+		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
 	} else {
 		up_write(&sb->s_umount);
 	}
@@ -1635,14 +1635,34 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
 		percpu_up_write(sb->s_writers.rw_sem + level);
 }
 
+static int freeze_frozen_super(struct super_block *sb, enum freeze_holder who)
+{
+	/* Someone else already holds this type of freeze */
+	if (sb->s_writers.freeze_holders & who)
+		return -EBUSY;
+
+	WARN_ON(sb->s_writers.freeze_holders == 0);
+
+	sb->s_writers.freeze_holders |= who;
+	return 0;
+}
+
 /**
  * freeze_super - lock the filesystem and force it into a consistent state
  * @sb: the super to lock
+ * @who: FREEZE_HOLDER_USERSPACE if userspace wants to freeze the fs;
+ * FREEZE_HOLDER_KERNEL if the kernel wants to freeze it
  *
  * Syncs the super to make sure the filesystem is consistent and calls the fs's
- * freeze_fs.  Subsequent calls to this without first thawing the fs will return
+ * freeze_fs.  Subsequent calls to this without first thawing the fs may return
  * -EBUSY.
  *
+ * The @who argument distinguishes between the kernel and userspace trying to
+ * freeze the filesystem.  Although there cannot be multiple kernel freezes or
+ * multiple userspace freezes in effect at any given time, the kernel and
+ * userspace can both hold a filesystem frozen.  The filesystem remains frozen
+ * until there are no kernel or userspace freezes in effect.
+ *
  * During this function, sb->s_writers.frozen goes through these values:
  *
  * SB_UNFROZEN: File system is normal, all writes progress as usual.
@@ -1668,12 +1688,19 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
  *
  * sb->s_writers.frozen is protected by sb->s_umount.
  */
-int freeze_super(struct super_block *sb)
+int freeze_super(struct super_block *sb, enum freeze_holder who)
 {
 	int ret;
 
 	atomic_inc(&sb->s_active);
 	down_write(&sb->s_umount);
+
+	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
+		ret = freeze_frozen_super(sb, who);
+		deactivate_locked_super(sb);
+		return ret;
+	}
+
 	if (sb->s_writers.frozen != SB_UNFROZEN) {
 		deactivate_locked_super(sb);
 		return -EBUSY;
@@ -1684,8 +1711,10 @@ int freeze_super(struct super_block *sb)
 		return 0;	/* sic - it's "nothing to do" */
 	}
 
+
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
+		sb->s_writers.freeze_holders |= who;
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 		up_write(&sb->s_umount);
 		return 0;
@@ -1731,6 +1760,7 @@ int freeze_super(struct super_block *sb)
 	 * For debugging purposes so that fs can warn if it sees write activity
 	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
 	 */
+	sb->s_writers.freeze_holders |= who;
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 	lockdep_sb_freeze_release(sb);
 	up_write(&sb->s_umount);
@@ -1738,16 +1768,47 @@ int freeze_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(freeze_super);
 
-static int thaw_super_locked(struct super_block *sb)
+static int try_thaw_shared_super(struct super_block *sb, enum freeze_holder who)
+{
+	/* Freeze is not held by this type? */
+	if (!(sb->s_writers.freeze_holders & who))
+		return -EINVAL;
+
+	/* Also frozen for someone else? */
+	if (sb->s_writers.freeze_holders & ~who) {
+		sb->s_writers.freeze_holders &= ~who;
+		return 0;
+	}
+
+	/* Magic value to proceed with thaw */
+	return 1;
+}
+
+/*
+ * Undoes the effect of a freeze_super_locked call.  If the filesystem is
+ * frozen both by userspace and the kernel, a thaw call from either source
+ * removes that state without releasing the other state or unlocking the
+ * filesystem.
+ */
+static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 {
 	int error;
 
+	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
+		error = try_thaw_shared_super(sb, who);
+		if (error != 1) {
+			up_write(&sb->s_umount);
+			return error;
+		}
+	}
+
 	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
 		up_write(&sb->s_umount);
 		return -EINVAL;
 	}
 
 	if (sb_rdonly(sb)) {
+		sb->s_writers.freeze_holders &= ~who;
 		sb->s_writers.frozen = SB_UNFROZEN;
 		goto out;
 	}
@@ -1765,6 +1826,7 @@ static int thaw_super_locked(struct super_block *sb)
 		}
 	}
 
+	sb->s_writers.freeze_holders &= ~who;
 	sb->s_writers.frozen = SB_UNFROZEN;
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
@@ -1777,12 +1839,13 @@ static int thaw_super_locked(struct super_block *sb)
  * thaw_super -- unlock filesystem
  * @sb: the super to thaw
  *
- * Unlocks the filesystem and marks it writeable again after freeze_super().
+ * Unlocks the filesystem and marks it writeable again after freeze_super()
+ * if there are no remaining freezes on the filesystem.
  */
-int thaw_super(struct super_block *sb)
+int thaw_super(struct super_block *sb, enum freeze_holder who)
 {
 	down_write(&sb->s_umount);
-	return thaw_super_locked(sb);
+	return thaw_super_locked(sb, who);
 }
 EXPORT_SYMBOL(thaw_super);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 133f0640fb24..c58a560569b3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1145,7 +1145,8 @@ enum {
 #define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE - 1)
 
 struct sb_writers {
-	int				frozen;		/* Is sb frozen? */
+	unsigned short			frozen;		/* Is sb frozen? */
+	unsigned short			freeze_holders;	/* Who froze fs? */
 	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
@@ -1899,6 +1900,10 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
 
+enum freeze_holder {
+	FREEZE_HOLDER_KERNEL	= (1U << 0),
+	FREEZE_HOLDER_USERSPACE	= (1U << 1),
+};
 
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
@@ -1911,9 +1916,9 @@ struct super_operations {
 	void (*evict_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
 	int (*sync_fs)(struct super_block *sb, int wait);
-	int (*freeze_super) (struct super_block *);
+	int (*freeze_super) (struct super_block *, enum freeze_holder who);
 	int (*freeze_fs) (struct super_block *);
-	int (*thaw_super) (struct super_block *);
+	int (*thaw_super) (struct super_block *, enum freeze_holder who);
 	int (*unfreeze_fs) (struct super_block *);
 	int (*statfs) (struct dentry *, struct kstatfs *);
 	int (*remount_fs) (struct super_block *, int *, char *);
@@ -2286,8 +2291,8 @@ extern int unregister_filesystem(struct file_system_type *);
 extern int vfs_statfs(const struct path *, struct kstatfs *);
 extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
-extern int freeze_super(struct super_block *super);
-extern int thaw_super(struct super_block *super);
+extern int freeze_super(struct super_block *super, enum freeze_holder who);
+extern int thaw_super(struct super_block *super, enum freeze_holder who);
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);

