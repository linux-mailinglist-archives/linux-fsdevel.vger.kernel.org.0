Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46E96F9D49
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 03:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjEHBRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 21:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjEHBRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 21:17:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E3C4696;
        Sun,  7 May 2023 18:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7N2aWPQ8XCHjo4VaLBoJ4vkX7xgNUHvf+Che6sVxE/c=; b=Mk/AHci/Q3UUXoCjFDMPoLi29K
        mavuKQCge2eNvZIBFJUZPcgcVtyY0faVKurSaI/kHv5Ap9ASwox68N87P7y8BEl12UNJycciCBou0
        6MUdQjNasce4sDW8Fe1tTBAFms95DrXOZFgCxPPqYDLI+rYy7BS3svFO7/PgCxBbzFp4T4V0IDxtM
        /aEEzy6BC72QC8tLW4A3IFHG2l1SS6DvXw99FamBjLYf8bk7SRV/zbkhrrXvlD7haiw7xR2aQHuSq
        /MtpYTgT1S76Sgb8+6PKGnZGcj0TpvzPgbgKyVA939aCwMxKGKdVkh8UeBJ4eLTjmBUVOPNixnh/t
        q7JYo6tQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvpV7-00GvZ2-2u;
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
Subject: [PATCH 3/6] fs: distinguish between user initiated freeze and kernel initiated freeze
Date:   Sun,  7 May 2023 18:17:14 -0700
Message-Id: <20230508011717.4034511-4-mcgrof@kernel.org>
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

Userspace can initiate a freeze call using ioctls. If the kernel decides
to freeze a filesystem later it must be able to distinguish if userspace
had initiated the freeze, so that it does not unfreeze it later
automatically on resume.

Likewise if the kernel is initiating a freeze on its own it should *not*
fail to freeze a filesystem if a user had already frozen it on our behalf.
This same concept applies to thawing, even if its not possible for
userspace to beat the kernel in thawing a filesystem. This logic however
has never applied to userspace freezing and thawing, two consecutive
userspace freeze calls will results in only the first one succeeding, so
we must retain the same behaviour in userspace.

This doesn't implement yet kernel initiated filesystem freeze calls,
this will be done in subsequent calls. This change should introduce
no functional changes, it just extends the definitions of a frozen
filesystem to account for future kernel initiated filesystem freeze
and let's us keep record of when userpace initiated it so the kernel
can respect a userspace initiated freeze upon kernel initiated freeze
and its respective thaw cycle.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c       |  4 ++--
 fs/f2fs/gc.c       |  4 ++--
 fs/gfs2/glops.c    |  2 +-
 fs/gfs2/super.c    |  2 +-
 fs/gfs2/sys.c      |  4 ++--
 fs/gfs2/util.c     |  2 +-
 fs/ioctl.c         |  4 ++--
 fs/super.c         | 29 +++++++++++++++++++++++++----
 include/linux/fs.h | 16 ++++++++++++++--
 9 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index dc54a2a1c46e..04f7b2c99845 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -250,7 +250,7 @@ int freeze_bdev(struct block_device *bdev)
 	if (sb->s_op->freeze_super)
 		error = sb->s_op->freeze_super(sb);
 	else
-		error = freeze_super(sb);
+		error = freeze_super(sb, true);
 	deactivate_locked_super(sb);
 
 	if (error) {
@@ -295,7 +295,7 @@ int thaw_bdev(struct block_device *bdev)
 	if (sb->s_op->thaw_super)
 		error = sb->s_op->thaw_super(sb);
 	else
-		error = thaw_super(sb);
+		error = thaw_super(sb, true);
 	if (error)
 		bdev->bd_fsfreeze_count++;
 	else
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e31d6791d3e3..a5891055d85d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2168,7 +2168,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 
 	if (!get_active_super(sbi->sb->s_bdev))
 		return -ENOTTY;
-	freeze_super(sbi->sb);
+	freeze_super(sbi->sb, true);
 
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_down_write(&sbi->cp_global_sem);
@@ -2221,7 +2221,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 	f2fs_up_write(&sbi->cp_global_sem);
 	f2fs_up_write(&sbi->gc_lock);
 	/* We use the same active reference from freeze */
-	thaw_super(sbi->sb);
+	thaw_super(sbi->sb, true);
 	deactivate_locked_super(sbi->sb);
 	return err;
 }
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 01d433ed6ce7..8fd37508f9a0 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -584,7 +584,7 @@ static int freeze_go_sync(struct gfs2_glock *gl)
 	if (gl->gl_state == LM_ST_SHARED && !gfs2_withdrawn(sdp) &&
 	    !test_bit(SDF_NORECOVERY, &sdp->sd_flags)) {
 		atomic_set(&sdp->sd_freeze_state, SFS_STARTING_FREEZE);
-		error = freeze_super(sdp->sd_vfs);
+		error = freeze_super(sdp->sd_vfs, true);
 		if (error) {
 			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
 				error);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e57cb593e2f3..f2641891de43 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -687,7 +687,7 @@ void gfs2_freeze_func(struct work_struct *work)
 		gfs2_assert_withdraw(sdp, 0);
 	} else {
 		atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
-		error = thaw_super(sb);
+		error = thaw_super(sb, true);
 		if (error) {
 			fs_info(sdp, "GFS2: couldn't thaw filesystem: %d\n",
 				error);
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index e80c827acd09..9e0398f99674 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -169,10 +169,10 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 
 	switch (n) {
 	case 0:
-		error = thaw_super(sdp->sd_vfs);
+		error = thaw_super(sdp->sd_vfs, true);
 		break;
 	case 1:
-		error = freeze_super(sdp->sd_vfs);
+		error = freeze_super(sdp->sd_vfs, true);
 		break;
 	default:
 		deactivate_locked_super(sb);
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 3a0cd5e9ad84..be9705d618ec 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -191,7 +191,7 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 		/* Make sure gfs2_unfreeze works if partially-frozen */
 		flush_work(&sdp->sd_freeze_work);
 		atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
-		thaw_super(sdp->sd_vfs);
+		thaw_super(sdp->sd_vfs, true);
 	} else {
 		wait_on_bit(&i_gl->gl_flags, GLF_DEMOTE,
 			    TASK_UNINTERRUPTIBLE);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1d20af762e0d..3cc79b82a5dc 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -401,7 +401,7 @@ static int ioctl_fsfreeze(struct file *filp)
 	/* Freeze */
 	if (sb->s_op->freeze_super)
 		ret = sb->s_op->freeze_super(sb);
-	ret = freeze_super(sb);
+	ret = freeze_super(sb, true);
 
 	deactivate_locked_super(sb);
 
@@ -418,7 +418,7 @@ static int ioctl_fsthaw(struct file *filp)
 	/* Thaw */
 	if (sb->s_op->thaw_super)
 		return sb->s_op->thaw_super(sb);
-	return thaw_super(sb);
+	return thaw_super(sb, true);
 }
 
 static int ioctl_file_dedupe_range(struct file *file,
diff --git a/fs/super.c b/fs/super.c
index 46c6475fc765..16ccbb9dd230 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1026,7 +1026,7 @@ static void do_thaw_all_callback(struct super_block *sb)
 		return;
 	if (sb->s_root && sb->s_flags & SB_BORN) {
 		emergency_thaw_bdev(sb);
-		thaw_super(sb);
+		thaw_super(sb, true);
 	}
 	deactivate_locked_super(sb);
 }
@@ -1636,6 +1636,8 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
 /**
  * freeze_super - force a filesystem backed by a block device into a consistent state
  * @sb: the super to lock
+ * @usercall: whether or not userspace initiated this via an ioctl or if it
+ * 	was a kernel freeze
  *
  * Used by filesystems and the kernel to freeze a fileystem backed by a block
  * device into a consistent state. Callers must use get_active_super(bdev) to
@@ -1669,10 +1671,13 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
  *
  * sb->s_writers.frozen is protected by sb->s_umount.
  */
-int freeze_super(struct super_block *sb)
+int freeze_super(struct super_block *sb, bool usercall)
 {
 	int ret;
 
+	if (!usercall && sb_is_frozen(sb))
+		return 0;
+
 	if (!sb_is_unfrozen(sb))
 		return -EBUSY;
 
@@ -1682,6 +1687,7 @@ int freeze_super(struct super_block *sb)
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+		sb->s_writers.frozen_by_user = usercall;
 		return 0;
 	}
 
@@ -1699,6 +1705,7 @@ int freeze_super(struct super_block *sb)
 	ret = sync_filesystem(sb);
 	if (ret) {
 		sb->s_writers.frozen = SB_UNFROZEN;
+		sb->s_writers.frozen_by_user = false;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
 		wake_up(&sb->s_writers.wait_unfrozen);
 		return ret;
@@ -1724,6 +1731,7 @@ int freeze_super(struct super_block *sb)
 	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
 	 */
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+	sb->s_writers.frozen_by_user = usercall;
 	lockdep_sb_freeze_release(sb);
 	return 0;
 }
@@ -1732,21 +1740,33 @@ EXPORT_SYMBOL(freeze_super);
 /**
  * thaw_super -- unlock a filesystem backed by a block device
  * @sb: the super to thaw
+ * @usercall: whether or not userspace initiated this thaw or if it was the
+ * 	kernel which initiated it
  *
  * Used by filesystems and the kernel to thaw a fileystem backed by a block
  * device. Callers must use get_active_super(bdev) to lock the @sb and when
  * done must unlock it with deactivate_locked_super(). Once done, this marks
  * the filesystem as writeable.
  */
-int thaw_super(struct super_block *sb)
+int thaw_super(struct super_block *sb, bool usercall)
 {
 	int error;
 
-	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
+	if (!usercall) {
+		/*
+		 * If userspace initiated the freeze don't let the kernel
+		 * thaw it on return from a kernel initiated freeze.
+		 */
+		if (sb_is_unfrozen(sb) || sb_is_frozen_by_user(sb))
+			return 0;
+	}
+
+	if (!sb_is_frozen(sb))
 		return -EINVAL;
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
+		sb->s_writers.frozen_by_user = false;
 		goto out;
 	}
 
@@ -1763,6 +1783,7 @@ int thaw_super(struct super_block *sb)
 	}
 
 	sb->s_writers.frozen = SB_UNFROZEN;
+	sb->s_writers.frozen_by_user = false;
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 90b5bdc4071a..d9b46c858103 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1146,6 +1146,7 @@ enum {
 
 struct sb_writers {
 	int				frozen;		/* Is sb frozen? */
+	bool				frozen_by_user;	/* User freeze? */
 	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
@@ -1632,6 +1633,17 @@ static inline bool sb_is_frozen(struct super_block *sb)
 	return sb->s_writers.frozen == SB_FREEZE_COMPLETE;
 }
 
+/**
+ * sb_is_frozen_by_user - was the superblock frozen by userspace?
+ * @sb: the super to check
+ *
+ * Returns true if the super is frozen by userspace, such as an ioctl.
+ */
+static inline bool sb_is_frozen_by_user(struct super_block *sb)
+{
+	return sb_is_frozen(sb) && sb->s_writers.frozen_by_user;
+}
+
 /**
  * sb_is_unfrozen - is superblock unfrozen
  * @sb: the super to check
@@ -2308,8 +2320,8 @@ extern int unregister_filesystem(struct file_system_type *);
 extern int vfs_statfs(const struct path *, struct kstatfs *);
 extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
-extern int freeze_super(struct super_block *super);
-extern int thaw_super(struct super_block *super);
+extern int freeze_super(struct super_block *super, bool usercall);
+extern int thaw_super(struct super_block *super, bool usercall);
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);
-- 
2.39.2

