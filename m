Return-Path: <linux-fsdevel+bounces-45519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BD9A790B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 16:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D96B16FF6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE6323BCFC;
	Wed,  2 Apr 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuVughTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176E38DE1;
	Wed,  2 Apr 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602901; cv=none; b=fpH7+RmoNjIC+slgqwc39i1hVDyeF49w783z+yYVaKAk6vpigde03dQzjv/bYS1m3fkreBTU9KYsQAUiBqYj1IWz2fhkIOVZ4vHs0VdVe2L4fEir8erLah6LhMzyLnLm6+qi4r1yWQewueIFGlB0k0h9y7cCL5gEFlFM1NWKW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602901; c=relaxed/simple;
	bh=Cc7nPmgWOc9KXIrYzUf39/EBs1UlZGbW17HXPUFVD78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnKu+2mkp9PWs3KfjHCGpA24FOfMZLYfWLIe9JRJAYocPCiigPL3J1wmJVH3fo0SPxHfvqev9PUDZxakbJjN4aHVTxrdbXifWfz1O7qZbOsHsSl9hU40KNe7KCFOEvLbi8ZOBAUQEZlYpuWpiorD+NBz+tjhEvKKCZYlch0w/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuVughTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC29C4CEDD;
	Wed,  2 Apr 2025 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743602901;
	bh=Cc7nPmgWOc9KXIrYzUf39/EBs1UlZGbW17HXPUFVD78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuVughTb691kdC7d86JjNwMuo/tZSFVloEAlw8HWOHgACcsMvQGHNTXE2AtLhFdTZ
	 ThG+QgYKLKULPIBkjV2i8iivliHPSqTDUFmudriNHlpbGJq+w3QzWvvgNIDxVMh1Da
	 WClejCAvYrU1yZb44ZTMHAhdYjix0tcsfmfKMi+bQgBL/OseOtVpSZtbL3E06OALoJ
	 rOYHypaZukiKjaXqhi6LGrkdb1pLY6srW9Z/t6I8wm/5zgIo3MKVA2tRT0Bp3sTeqC
	 hYN2Z3s/PxdLwjOJVXcT89O5HsI+FOMeut02boc7g2HH3z1+QevA/vXR1nEKkmukC5
	 O6Y/C8wq2KX1Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH v2 1/4] fs: add owner of freeze/thaw
Date: Wed,  2 Apr 2025 16:07:31 +0200
Message-ID: <20250402-work-freeze-v2-1-6719a97b52ac@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=19518; i=brauner@kernel.org; h=from:subject:message-id; bh=Cc7nPmgWOc9KXIrYzUf39/EBs1UlZGbW17HXPUFVD78=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/dVl55GfhE92WiDVxP9dbMBrcqFxx4tIMta9fKxhu1 914q8li21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRa7MY/kr6Gdt0fhbuvz3v ps6aq3JclZ8mLElw53vzaZpI2y+mptmMDDtKLB4pGvwNUVT+vZ9Dq9/uVNq5PTfb2sK8lu/07VG exAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

For some kernel subsystems it is paramount that they are guaranteed that
they are the owner of the freeze to avoid any risk of deadlocks. This is
the case for the power subsystem. Enable it to recognize whether it did
actually freeze the filesystem.

If userspace has 10 filesystems and suspend/hibernate manges to freeze 5
and then fails on the 6th for whatever odd reason (current or future)
then power needs to undo the freeze of the first 5 filesystems. It can't
just walk the list again because while it's unlikely that a new
filesystem got added in the meantime it still cannot tell which
filesystems the power subsystem actually managed to get a freeze
reference count on that needs to be dropped during thaw.

There's various ways out of this ugliness. For example, record the
filesystems the power subsystem managed to freeze on a temporary list in
the callbacks and then walk that list backwards during thaw to undo the
freezing or make sure that the power subsystem just actually exclusively
freezes things it can freeze and marking such filesystems as being owned
by power for the duration of the suspend or resume cycle. I opted for
the latter as that seemed the clean thing to do even if it means more
code changes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/f2fs/gc.c                |  6 ++--
 fs/gfs2/super.c             | 20 ++++++------
 fs/gfs2/sys.c               |  4 +--
 fs/ioctl.c                  |  8 ++---
 fs/super.c                  | 76 ++++++++++++++++++++++++++++++++++++---------
 fs/xfs/scrub/fscounters.c   |  4 +--
 fs/xfs/xfs_notify_failure.c |  6 ++--
 include/linux/fs.h          | 13 +++++---
 8 files changed, 95 insertions(+), 42 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2b8f9239bede..3e8af62c9e15 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2271,12 +2271,12 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	if (err)
 		return err;
 
-	err = freeze_super(sbi->sb, FREEZE_HOLDER_USERSPACE);
+	err = freeze_super(sbi->sb, FREEZE_HOLDER_USERSPACE, NULL);
 	if (err)
 		return err;
 
 	if (f2fs_readonly(sbi->sb)) {
-		err = thaw_super(sbi->sb, FREEZE_HOLDER_USERSPACE);
+		err = thaw_super(sbi->sb, FREEZE_HOLDER_USERSPACE, NULL);
 		if (err)
 			return err;
 		return -EROFS;
@@ -2333,6 +2333,6 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 out_err:
 	f2fs_up_write(&sbi->cp_global_sem);
 	f2fs_up_write(&sbi->gc_lock);
-	thaw_super(sbi->sb, FREEZE_HOLDER_USERSPACE);
+	thaw_super(sbi->sb, FREEZE_HOLDER_USERSPACE, NULL);
 	return err;
 }
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 44e5658b896c..519943189109 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -674,7 +674,7 @@ static int gfs2_sync_fs(struct super_block *sb, int wait)
 	return sdp->sd_log_error;
 }
 
-static int gfs2_do_thaw(struct gfs2_sbd *sdp)
+static int gfs2_do_thaw(struct gfs2_sbd *sdp, enum freeze_holder who, const void *freeze_owner)
 {
 	struct super_block *sb = sdp->sd_vfs;
 	int error;
@@ -682,7 +682,7 @@ static int gfs2_do_thaw(struct gfs2_sbd *sdp)
 	error = gfs2_freeze_lock_shared(sdp);
 	if (error)
 		goto fail;
-	error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+	error = thaw_super(sb, who, freeze_owner);
 	if (!error)
 		return 0;
 
@@ -703,14 +703,14 @@ void gfs2_freeze_func(struct work_struct *work)
 	if (test_bit(SDF_FROZEN, &sdp->sd_flags))
 		goto freeze_failed;
 
-	error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+	error = freeze_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
 	if (error)
 		goto freeze_failed;
 
 	gfs2_freeze_unlock(sdp);
 	set_bit(SDF_FROZEN, &sdp->sd_flags);
 
-	error = gfs2_do_thaw(sdp);
+	error = gfs2_do_thaw(sdp, FREEZE_HOLDER_USERSPACE, NULL);
 	if (error)
 		goto out;
 
@@ -731,7 +731,8 @@ void gfs2_freeze_func(struct work_struct *work)
  *
  */
 
-static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
+static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who,
+			     const void *freeze_owner)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int error;
@@ -744,7 +745,7 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 	}
 
 	for (;;) {
-		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = freeze_super(sb, who, freeze_owner);
 		if (error) {
 			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
 				error);
@@ -758,7 +759,7 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 			break;
 		}
 
-		error = gfs2_do_thaw(sdp);
+		error = gfs2_do_thaw(sdp, who, freeze_owner);
 		if (error)
 			goto out;
 
@@ -799,7 +800,8 @@ static int gfs2_freeze_fs(struct super_block *sb)
  *
  */
 
-static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
+static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who,
+			   const void *freeze_owner)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int error;
@@ -814,7 +816,7 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
 	atomic_inc(&sb->s_active);
 	gfs2_freeze_unlock(sdp);
 
-	error = gfs2_do_thaw(sdp);
+	error = gfs2_do_thaw(sdp, who, freeze_owner);
 
 	if (!error) {
 		clear_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index ecc699f8d9fc..748125653d6c 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -174,10 +174,10 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 
 	switch (n) {
 	case 0:
-		error = thaw_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE);
+		error = thaw_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE, NULL);
 		break;
 	case 1:
-		error = freeze_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE);
+		error = freeze_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE, NULL);
 		break;
 	default:
 		return -EINVAL;
diff --git a/fs/ioctl.c b/fs/ioctl.c
index c91fd2b46a77..bedc83fc2f20 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -396,8 +396,8 @@ static int ioctl_fsfreeze(struct file *filp)
 
 	/* Freeze */
 	if (sb->s_op->freeze_super)
-		return sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
-	return freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+		return sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
+	return freeze_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
 }
 
 static int ioctl_fsthaw(struct file *filp)
@@ -409,8 +409,8 @@ static int ioctl_fsthaw(struct file *filp)
 
 	/* Thaw */
 	if (sb->s_op->thaw_super)
-		return sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
-	return thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+		return sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
+	return thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
 }
 
 static int ioctl_file_dedupe_range(struct file *file,
diff --git a/fs/super.c b/fs/super.c
index 3c4a496d6438..3ddded4360c6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -39,7 +39,8 @@
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
-static int thaw_super_locked(struct super_block *sb, enum freeze_holder who);
+static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
+			     const void *freeze_owner);
 
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
@@ -1148,7 +1149,7 @@ static void do_thaw_all_callback(struct super_block *sb, void *unused)
 	if (IS_ENABLED(CONFIG_BLOCK))
 		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
 			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
-	thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
+	thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE, NULL);
 	return;
 }
 
@@ -1195,9 +1196,9 @@ static void filesystems_freeze_callback(struct super_block *sb, void *unused)
 		return;
 
 	if (sb->s_op->freeze_super)
-		sb->s_op->freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+		sb->s_op->freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
 	else
-		freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+		freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
 
 	deactivate_super(sb);
 }
@@ -1217,9 +1218,9 @@ static void filesystems_thaw_callback(struct super_block *sb, void *unused)
 		return;
 
 	if (sb->s_op->thaw_super)
-		sb->s_op->thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+		sb->s_op->thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
 	else
-		thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+		thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
 
 	deactivate_super(sb);
 }
@@ -1522,10 +1523,10 @@ static int fs_bdev_freeze(struct block_device *bdev)
 
 	if (sb->s_op->freeze_super)
 		error = sb->s_op->freeze_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE);
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
 	else
 		error = freeze_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE);
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
 	if (!error)
 		error = sync_blockdev(bdev);
 	deactivate_super(sb);
@@ -1571,10 +1572,10 @@ static int fs_bdev_thaw(struct block_device *bdev)
 
 	if (sb->s_op->thaw_super)
 		error = sb->s_op->thaw_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE);
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
 	else
 		error = thaw_super(sb,
-				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE);
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
 	deactivate_super(sb);
 	return error;
 }
@@ -1946,7 +1947,7 @@ static int wait_for_partially_frozen(struct super_block *sb)
 }
 
 #define FREEZE_HOLDERS (FREEZE_HOLDER_KERNEL | FREEZE_HOLDER_USERSPACE)
-#define FREEZE_FLAGS (FREEZE_HOLDERS | FREEZE_MAY_NEST)
+#define FREEZE_FLAGS (FREEZE_HOLDERS | FREEZE_MAY_NEST | FREEZE_EXCL)
 
 static inline int freeze_inc(struct super_block *sb, enum freeze_holder who)
 {
@@ -1977,6 +1978,21 @@ static inline bool may_freeze(struct super_block *sb, enum freeze_holder who)
 	WARN_ON_ONCE((who & ~FREEZE_FLAGS));
 	WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
 
+	if (who & FREEZE_EXCL) {
+		if (WARN_ON_ONCE(!(who & FREEZE_HOLDER_KERNEL)))
+			return false;
+
+		if (who & ~(FREEZE_EXCL | FREEZE_HOLDER_KERNEL))
+			return false;
+
+		return (sb->s_writers.freeze_kcount +
+			sb->s_writers.freeze_ucount) == 0;
+	}
+
+	/* This filesystem is already exclusively frozen. */
+	if (sb->s_writers.freeze_owner)
+		return false;
+
 	if (who & FREEZE_HOLDER_KERNEL)
 		return (who & FREEZE_MAY_NEST) ||
 		       sb->s_writers.freeze_kcount == 0;
@@ -1986,10 +2002,30 @@ static inline bool may_freeze(struct super_block *sb, enum freeze_holder who)
 	return false;
 }
 
+static inline bool may_unfreeze(struct super_block *sb, enum freeze_holder who,
+				const void *freeze_owner)
+{
+	WARN_ON_ONCE((who & ~FREEZE_FLAGS));
+	WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
+
+	if (who & FREEZE_EXCL) {
+		if (WARN_ON_ONCE(sb->s_writers.freeze_owner == NULL))
+			return false;
+		if (WARN_ON_ONCE(!(who & FREEZE_HOLDER_KERNEL)))
+			return false;
+		if (who & ~(FREEZE_EXCL | FREEZE_HOLDER_KERNEL))
+			return false;
+		return sb->s_writers.freeze_owner == freeze_owner;
+	}
+
+	return sb->s_writers.freeze_owner == NULL;
+}
+
 /**
  * freeze_super - lock the filesystem and force it into a consistent state
  * @sb: the super to lock
  * @who: context that wants to freeze
+ * @freeze_owner: owner of the freeze
  *
  * Syncs the super to make sure the filesystem is consistent and calls the fs's
  * freeze_fs.  Subsequent calls to this without first thawing the fs may return
@@ -2041,7 +2077,7 @@ static inline bool may_freeze(struct super_block *sb, enum freeze_holder who)
  * Return: If the freeze was successful zero is returned. If the freeze
  *         failed a negative error code is returned.
  */
-int freeze_super(struct super_block *sb, enum freeze_holder who)
+int freeze_super(struct super_block *sb, enum freeze_holder who, const void *freeze_owner)
 {
 	int ret;
 
@@ -2075,6 +2111,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
 		WARN_ON_ONCE(freeze_inc(sb, who) > 1);
+		sb->s_writers.freeze_owner = freeze_owner;
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 		wake_up_var(&sb->s_writers.frozen);
 		super_unlock_excl(sb);
@@ -2122,6 +2159,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
 	 */
 	WARN_ON_ONCE(freeze_inc(sb, who) > 1);
+	sb->s_writers.freeze_owner = freeze_owner;
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 	wake_up_var(&sb->s_writers.frozen);
 	lockdep_sb_freeze_release(sb);
@@ -2136,13 +2174,17 @@ EXPORT_SYMBOL(freeze_super);
  * removes that state without releasing the other state or unlocking the
  * filesystem.
  */
-static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
+static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
+			     const void *freeze_owner)
 {
 	int error = -EINVAL;
 
 	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
 		goto out_unlock;
 
+	if (!may_unfreeze(sb, who, freeze_owner))
+		goto out_unlock;
+
 	/*
 	 * All freezers share a single active reference.
 	 * So just unlock in case there are any left.
@@ -2152,6 +2194,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
+		sb->s_writers.freeze_owner = NULL;
 		wake_up_var(&sb->s_writers.frozen);
 		goto out_deactivate;
 	}
@@ -2169,6 +2212,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 	}
 
 	sb->s_writers.frozen = SB_UNFROZEN;
+	sb->s_writers.freeze_owner = NULL;
 	wake_up_var(&sb->s_writers.frozen);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out_deactivate:
@@ -2184,6 +2228,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
  * thaw_super -- unlock filesystem
  * @sb: the super to thaw
  * @who: context that wants to freeze
+ * @freeze_owner: owner of the freeze
  *
  * Unlocks the filesystem and marks it writeable again after freeze_super()
  * if there are no remaining freezes on the filesystem.
@@ -2197,13 +2242,14 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
  * have been frozen through the block layer via multiple block devices.
  * The filesystem remains frozen until all block devices are unfrozen.
  */
-int thaw_super(struct super_block *sb, enum freeze_holder who)
+int thaw_super(struct super_block *sb, enum freeze_holder who,
+	       const void *freeze_owner)
 {
 	if (!super_lock_excl(sb)) {
 		WARN_ON_ONCE("Dying superblock while thawing!");
 		return -EINVAL;
 	}
-	return thaw_super_locked(sb, who);
+	return thaw_super_locked(sb, who, freeze_owner);
 }
 EXPORT_SYMBOL(thaw_super);
 
diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index e629663e460a..9b598c5790ad 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -123,7 +123,7 @@ xchk_fsfreeze(
 {
 	int			error;
 
-	error = freeze_super(sc->mp->m_super, FREEZE_HOLDER_KERNEL);
+	error = freeze_super(sc->mp->m_super, FREEZE_HOLDER_KERNEL, NULL);
 	trace_xchk_fsfreeze(sc, error);
 	return error;
 }
@@ -135,7 +135,7 @@ xchk_fsthaw(
 	int			error;
 
 	/* This should always succeed, we have a kernel freeze */
-	error = thaw_super(sc->mp->m_super, FREEZE_HOLDER_KERNEL);
+	error = thaw_super(sc->mp->m_super, FREEZE_HOLDER_KERNEL, NULL);
 	trace_xchk_fsthaw(sc, error);
 	return error;
 }
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index ed8d8ed42f0a..3545dc1d953c 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -127,7 +127,7 @@ xfs_dax_notify_failure_freeze(
 	struct super_block	*sb = mp->m_super;
 	int			error;
 
-	error = freeze_super(sb, FREEZE_HOLDER_KERNEL);
+	error = freeze_super(sb, FREEZE_HOLDER_KERNEL, NULL);
 	if (error)
 		xfs_emerg(mp, "already frozen by kernel, err=%d", error);
 
@@ -143,7 +143,7 @@ xfs_dax_notify_failure_thaw(
 	int			error;
 
 	if (kernel_frozen) {
-		error = thaw_super(sb, FREEZE_HOLDER_KERNEL);
+		error = thaw_super(sb, FREEZE_HOLDER_KERNEL, NULL);
 		if (error)
 			xfs_emerg(mp, "still frozen after notify failure, err=%d",
 				error);
@@ -153,7 +153,7 @@ xfs_dax_notify_failure_thaw(
 	 * Also thaw userspace call anyway because the device is about to be
 	 * removed immediately.
 	 */
-	thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+	thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
 }
 
 static int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1aa578412f1b..b379a46b5576 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1307,6 +1307,7 @@ struct sb_writers {
 	unsigned short			frozen;		/* Is sb frozen? */
 	int				freeze_kcount;	/* How many kernel freeze requests? */
 	int				freeze_ucount;	/* How many userspace freeze requests? */
+	const void			*freeze_owner;	/* Owner of the freeze */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
@@ -2270,6 +2271,7 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
  * @FREEZE_HOLDER_KERNEL: kernel wants to freeze or thaw filesystem
  * @FREEZE_HOLDER_USERSPACE: userspace wants to freeze or thaw filesystem
  * @FREEZE_MAY_NEST: whether nesting freeze and thaw requests is allowed
+ * @FREEZE_EXCL: whether actual freezing must be done by the caller
  *
  * Indicate who the owner of the freeze or thaw request is and whether
  * the freeze needs to be exclusive or can nest.
@@ -2283,6 +2285,7 @@ enum freeze_holder {
 	FREEZE_HOLDER_KERNEL	= (1U << 0),
 	FREEZE_HOLDER_USERSPACE	= (1U << 1),
 	FREEZE_MAY_NEST		= (1U << 2),
+	FREEZE_EXCL		= (1U << 3),
 };
 
 struct super_operations {
@@ -2296,9 +2299,9 @@ struct super_operations {
 	void (*evict_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
 	int (*sync_fs)(struct super_block *sb, int wait);
-	int (*freeze_super) (struct super_block *, enum freeze_holder who);
+	int (*freeze_super) (struct super_block *, enum freeze_holder who, const void *owner);
 	int (*freeze_fs) (struct super_block *);
-	int (*thaw_super) (struct super_block *, enum freeze_holder who);
+	int (*thaw_super) (struct super_block *, enum freeze_holder who, const void *owner);
 	int (*unfreeze_fs) (struct super_block *);
 	int (*statfs) (struct dentry *, struct kstatfs *);
 	int (*remount_fs) (struct super_block *, int *, char *);
@@ -2706,8 +2709,10 @@ extern int unregister_filesystem(struct file_system_type *);
 extern int vfs_statfs(const struct path *, struct kstatfs *);
 extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
-int freeze_super(struct super_block *super, enum freeze_holder who);
-int thaw_super(struct super_block *super, enum freeze_holder who);
+int freeze_super(struct super_block *super, enum freeze_holder who,
+		 const void *freeze_owner);
+int thaw_super(struct super_block *super, enum freeze_holder who,
+	       const void *freeze_owner);
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);

-- 
2.47.2


