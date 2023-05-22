Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE24170CF9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 02:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjEWAkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjEWAGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 20:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE3995;
        Mon, 22 May 2023 16:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E0E6202F;
        Mon, 22 May 2023 23:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13475C433D2;
        Mon, 22 May 2023 23:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684798921;
        bh=N6kv/5McifazKgNnuizUSRLrcRrnxq8b8JoyRkwM7+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLt9j7F6mtU+hZMWozRng8oVG7209X8FV0lKdaQUualgujQ7N6jM29zeBP0OwG1VS
         YUDrFejCYUSawGylnutJCY9DYPbUF68Kwq4nQ1x162kGNr1EgctxYtS1WjHKVS6Vq1
         W9EqPn8NH3Y/Rs3hvsTOb+Onpd/KF0fE1nEi7CtsYMIchNUsDMUl7w8vv3i/+Sz0ar
         hSq+PrPlOxX7Uqe8YBkEdZuHNRIeMtw7qaaYMuQ7QX9y/SR5gBzynUS1jQ0NEI38L9
         u6xdGFBVa0g4X40sHGOIzA/LnZWlRmSKXopplc2VO1hG7bon1e1YEgOFqIoJYZJ3ao
         quLHANLeX7nkw==
Date:   Mon, 22 May 2023 16:42:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, sandeen@sandeen.net, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230522234200.GC11598@frogsfrogsfrogs>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-4-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

How about this as an alternative patch?  Kernel and userspace freeze
state are stored in s_writers; each type cannot block the other (though
you still can't have nested kernel or userspace freezes); and the freeze
is maintained until /both/ freeze types are dropped.

AFAICT this should work for the two other usecases (quiescing pagefaults
for fsdax pmem pre-removal; and freezing fses during suspend) besides
online fsck for xfs.

--D

From: Darrick J. Wong <djwong@kernel.org>
Subject: fs: distinguish between user initiated freeze and kernel initiated freeze

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

Inspired-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/super.c         |  172 +++++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/fs.h |    8 ++
 2 files changed, 170 insertions(+), 10 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 34afe411cf2b..7496d51affb9 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -39,7 +39,7 @@
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
-static int thaw_super_locked(struct super_block *sb);
+static int thaw_super_locked(struct super_block *sb, unsigned short who);
 
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
@@ -1636,13 +1636,21 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
 }
 
 /**
- * freeze_super - lock the filesystem and force it into a consistent state
+ * __freeze_super - lock the filesystem and force it into a consistent state
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
@@ -1668,12 +1676,61 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
  *
  * sb->s_writers.frozen is protected by sb->s_umount.
  */
-int freeze_super(struct super_block *sb)
+static int __freeze_super(struct super_block *sb, unsigned short who)
 {
+	struct sb_writers *sbw = &sb->s_writers;
 	int ret;
 
 	atomic_inc(&sb->s_active);
 	down_write(&sb->s_umount);
+
+	if (sbw->frozen == SB_FREEZE_COMPLETE) {
+		switch (who) {
+		case FREEZE_HOLDER_KERNEL:
+			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
+				/*
+				 * Kernel freeze already in effect; caller can
+				 * try again.
+				 */
+				deactivate_locked_super(sb);
+				return -EBUSY;
+			}
+			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
+				/*
+				 * Share the freeze state with the userspace
+				 * freeze already in effect.
+				 */
+				sbw->freeze_holders |= who;
+				deactivate_locked_super(sb);
+				return 0;
+			}
+			break;
+		case FREEZE_HOLDER_USERSPACE:
+			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
+				/*
+				 * Userspace freeze already in effect; tell
+				 * the caller we're busy.
+				 */
+				deactivate_locked_super(sb);
+				return -EBUSY;
+			}
+			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
+				/*
+				 * Share the freeze state with the kernel
+				 * freeze already in effect.
+				 */
+				sbw->freeze_holders |= who;
+				deactivate_locked_super(sb);
+				return 0;
+			}
+			break;
+		default:
+			BUG();
+			deactivate_locked_super(sb);
+			return -EINVAL;
+		}
+	}
+
 	if (sb->s_writers.frozen != SB_UNFROZEN) {
 		deactivate_locked_super(sb);
 		return -EBUSY;
@@ -1686,6 +1743,7 @@ int freeze_super(struct super_block *sb)
 
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
+		sb->s_writers.freeze_holders |= who;
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 		up_write(&sb->s_umount);
 		return 0;
@@ -1731,23 +1789,103 @@ int freeze_super(struct super_block *sb)
 	 * For debugging purposes so that fs can warn if it sees write activity
 	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
 	 */
+	sb->s_writers.freeze_holders |= who;
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 	lockdep_sb_freeze_release(sb);
 	up_write(&sb->s_umount);
 	return 0;
 }
+
+/*
+ * freeze_super - lock the filesystem and force it into a consistent state
+ * @sb: the super to lock
+ *
+ * Syncs the super to make sure the filesystem is consistent and calls the fs's
+ * freeze_fs.  Subsequent calls to this without first calling thaw_super will
+ * return -EBUSY.  See the comment for __freeze_super for more information.
+ */
+int freeze_super(struct super_block *sb)
+{
+	return __freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+}
 EXPORT_SYMBOL(freeze_super);
 
-static int thaw_super_locked(struct super_block *sb)
+/**
+ * freeze_super_kernel - lock the filesystem for an internal kernel operation
+ * and force it into a consistent state.
+ * @sb: the super to lock
+ *
+ * Syncs the super to make sure the filesystem is consistent and calls the fs's
+ * freeze_fs.  Subsequent calls to this without first calling thaw_super_excl
+ * will return -EBUSY.
+ */
+int freeze_super_kernel(struct super_block *sb)
 {
+	return __freeze_super(sb, FREEZE_HOLDER_KERNEL);
+}
+EXPORT_SYMBOL_GPL(freeze_super_kernel);
+
+/*
+ * Undoes the effect of a freeze_super_locked call.  If the filesystem is
+ * frozen both by userspace and the kernel, a thaw call from either source
+ * removes that state without releasing the other state or unlocking the
+ * filesystem.
+ */
+static int thaw_super_locked(struct super_block *sb, unsigned short who)
+{
+	struct sb_writers *sbw = &sb->s_writers;
 	int error;
 
+	if (sbw->frozen == SB_FREEZE_COMPLETE) {
+		switch (who) {
+		case FREEZE_HOLDER_KERNEL:
+			if (!(sbw->freeze_holders & FREEZE_HOLDER_KERNEL)) {
+				/* Caller doesn't hold a kernel freeze. */
+				up_write(&sb->s_umount);
+				return -EINVAL;
+			}
+			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
+				/*
+				 * We were sharing the freeze with userspace,
+				 * so drop the userspace freeze but exit
+				 * without unfreezing.
+				 */
+				sbw->freeze_holders &= ~who;
+				up_write(&sb->s_umount);
+				return 0;
+			}
+			break;
+		case FREEZE_HOLDER_USERSPACE:
+			if (!(sbw->freeze_holders & FREEZE_HOLDER_USERSPACE)) {
+				/* Caller doesn't hold a userspace freeze. */
+				up_write(&sb->s_umount);
+				return -EINVAL;
+			}
+			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
+				/*
+				 * We were sharing the freeze with the kernel,
+				 * so drop the kernel freeze but exit without
+				 * unfreezing.
+				 */
+				sbw->freeze_holders &= ~who;
+				up_write(&sb->s_umount);
+				return 0;
+			}
+			break;
+		default:
+			BUG();
+			up_write(&sb->s_umount);
+			return -EINVAL;
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
@@ -1765,6 +1903,7 @@ static int thaw_super_locked(struct super_block *sb)
 		}
 	}
 
+	sb->s_writers.freeze_holders &= ~who;
 	sb->s_writers.frozen = SB_UNFROZEN;
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
@@ -1774,18 +1913,33 @@ static int thaw_super_locked(struct super_block *sb)
 }
 
 /**
- * thaw_super -- unlock filesystem
+ * thaw_super -- unlock filesystem frozen with freeze_super
  * @sb: the super to thaw
  *
- * Unlocks the filesystem and marks it writeable again after freeze_super().
+ * Unlocks the filesystem after freeze_super, and make it writeable again if
+ * there is not a freeze_super_kernel still in effect.
  */
 int thaw_super(struct super_block *sb)
 {
 	down_write(&sb->s_umount);
-	return thaw_super_locked(sb);
+	return thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
 }
 EXPORT_SYMBOL(thaw_super);
 
+/**
+ * thaw_super_kernel -- unlock filesystem frozen with freeze_super_kernel
+ * @sb: the super to thaw
+ *
+ * Unlocks the filesystem after freeze_super_kernel, and make it writeable
+ * again if there is not a freeze_super still in effect.
+ */
+int thaw_super_kernel(struct super_block *sb)
+{
+	down_write(&sb->s_umount);
+	return thaw_super_locked(sb, FREEZE_HOLDER_KERNEL);
+}
+EXPORT_SYMBOL_GPL(thaw_super_kernel);
+
 /*
  * Create workqueue for deferred direct IO completions. We allocate the
  * workqueue when it's first needed. This avoids creating workqueue for
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..147644b5d648 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1145,11 +1145,15 @@ enum {
 #define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE - 1)
 
 struct sb_writers {
-	int				frozen;		/* Is sb frozen? */
+	unsigned short			frozen;		/* Is sb frozen? */
+	unsigned short			freeze_holders;	/* Who froze fs? */
 	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
+#define FREEZE_HOLDER_USERSPACE	(1U << 1)	/* userspace froze fs */
+#define FREEZE_HOLDER_KERNEL	(1U << 2)	/* kernel froze fs */
+
 struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	dev_t			s_dev;		/* search index; _not_ kdev_t */
@@ -2288,6 +2292,8 @@ extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
 extern int freeze_super(struct super_block *super);
 extern int thaw_super(struct super_block *super);
+extern int freeze_super_kernel(struct super_block *super);
+extern int thaw_super_kernel(struct super_block *super);
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);
