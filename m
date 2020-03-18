Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0800189B48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 12:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgCRLwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 07:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgCRLwZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:52:25 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C494120770;
        Wed, 18 Mar 2020 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584532343;
        bh=5GLWT1f9E683xDdoXqNUxPS3l1Q+Rt9YCz4xV7Th2WQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gqVorwm6ZZJFKDnX+/RkNZB7QEWGyZCOQyAdkUbfdmn0rSyCgjp80B81QdwcNa/8a
         A86BASt5L6Hp3xDtLhizhVLCozZFitehHCeMzwLIlB3MVvqhtqp1R+zd7Ou3DxN+mU
         zUIqmU28QphTL6+b3FQultdJXBD8QnFbBDhxqiJc=
From:   Jeff Layton <jlayton@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangerkun@huawei.com, neilb@suse.de, sfrench@samba.org,
        viro@zeniv.linux.org.uk, bfields@fieldses.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH] locks: reinstate locks_delete_block optimization
Date:   Wed, 18 Mar 2020 07:52:21 -0400
Message-Id: <20200318115221.13870-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

There is measurable performance impact in some synthetic tests due to
commit 6d390e4b5d48 (locks: fix a potential use-after-free problem when
wakeup a waiter). Fix the race condition instead by clearing the
fl_blocker pointer after the wake_up, using explicit acquire/release
semantics.

This does mean that we can no longer use the clearing of fl_blocker as
the wait condition, so switch the waiters over to checking whether the
fl_blocked_member list_head is empty.

Reviewed-by: yangerkun <yangerkun@huawei.com>
Reviewed-by: NeilBrown <neilb@suse.de>
Fixes: 6d390e4b5d48 (locks: fix a potential use-after-free problem when wakeup a waiter)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cifs/file.c |  3 ++-
 fs/locks.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 7 deletions(-)

Hi Linus,

Sending this individually since it's just a single patch. If you'd
prefer a pull request, let me know.

-- Jeff

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 3b942ecdd4be..8f9d849a0012 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1169,7 +1169,8 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 	rc = posix_lock_file(file, flock, NULL);
 	up_write(&cinode->lock_sem);
 	if (rc == FILE_LOCK_DEFERRED) {
-		rc = wait_event_interruptible(flock->fl_wait, !flock->fl_blocker);
+		rc = wait_event_interruptible(flock->fl_wait,
+					list_empty(&flock->fl_blocked_member));
 		if (!rc)
 			goto try_again;
 		locks_delete_block(flock);
diff --git a/fs/locks.c b/fs/locks.c
index 426b55d333d5..b8a31c1c4fff 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -725,7 +725,6 @@ static void __locks_delete_block(struct file_lock *waiter)
 {
 	locks_delete_global_blocked(waiter);
 	list_del_init(&waiter->fl_blocked_member);
-	waiter->fl_blocker = NULL;
 }
 
 static void __locks_wake_up_blocks(struct file_lock *blocker)
@@ -740,6 +739,13 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 			waiter->fl_lmops->lm_notify(waiter);
 		else
 			wake_up(&waiter->fl_wait);
+
+		/*
+		 * The setting of fl_blocker to NULL marks the "done"
+		 * point in deleting a block. Paired with acquire at the top
+		 * of locks_delete_block().
+		 */
+		smp_store_release(&waiter->fl_blocker, NULL);
 	}
 }
 
@@ -753,11 +759,42 @@ int locks_delete_block(struct file_lock *waiter)
 {
 	int status = -ENOENT;
 
+	/*
+	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
+	 * the lock and is the only one that might try to claim the lock.
+	 *
+	 * We use acquire/release to manage fl_blocker so that we can
+	 * optimize away taking the blocked_lock_lock in many cases.
+	 *
+	 * The smp_load_acquire guarantees two things:
+	 *
+	 * 1/ that fl_blocked_requests can be tested locklessly. If something
+	 * was recently added to that list it must have been in a locked region
+	 * *before* the locked region when fl_blocker was set to NULL.
+	 *
+	 * 2/ that no other thread is accessing 'waiter', so it is safe to free
+	 * it.  __locks_wake_up_blocks is careful not to touch waiter after
+	 * fl_blocker is released.
+	 *
+	 * If a lockless check of fl_blocker shows it to be NULL, we know that
+	 * no new locks can be inserted into its fl_blocked_requests list, and
+	 * can avoid doing anything further if the list is empty.
+	 */
+	if (!smp_load_acquire(&waiter->fl_blocker) &&
+	    list_empty(&waiter->fl_blocked_requests))
+		return status;
+
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_blocker)
 		status = 0;
 	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
+
+	/*
+	 * The setting of fl_blocker to NULL marks the "done" point in deleting
+	 * a block. Paired with acquire at the top of this function.
+	 */
+	smp_store_release(&waiter->fl_blocker, NULL);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }
@@ -1350,7 +1387,8 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = posix_lock_inode(inode, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+					list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -1435,7 +1473,8 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
 		error = posix_lock_inode(inode, &fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl.fl_wait, !fl.fl_blocker);
+		error = wait_event_interruptible(fl.fl_wait,
+					list_empty(&fl.fl_blocked_member));
 		if (!error) {
 			/*
 			 * If we've been sleeping someone might have
@@ -1638,7 +1677,8 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 
 	locks_dispose_list(&dispose);
 	error = wait_event_interruptible_timeout(new_fl->fl_wait,
-						!new_fl->fl_blocker, break_time);
+					list_empty(&new_fl->fl_blocked_member),
+					break_time);
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
@@ -2122,7 +2162,8 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = flock_lock_inode(inode, fl);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+				list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -2399,7 +2440,8 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 		error = vfs_lock_file(filp, cmd, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+					list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
-- 
2.24.1

