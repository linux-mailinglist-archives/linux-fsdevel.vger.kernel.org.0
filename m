Return-Path: <linux-fsdevel+bounces-3855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE47F933F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 16:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4221D1C20CE2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9D78BF7;
	Sun, 26 Nov 2023 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7B8814
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 15:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7E6C433C8;
	Sun, 26 Nov 2023 15:04:58 +0000 (UTC)
Date: Sun, 26 Nov 2023 10:04:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing/eventfs: Fixes for v6.7-rc2
Message-ID: <20231126100356.389c325d@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Linus,

eventfs fixes:

- With the usage of simple_recursive_remove() recommended by Al Viro,
  the code should not be calling "d_invalidate()" itself. Doing so
  is causing crashes. The code was calling d_invalidate() on the race
  of trying to look up a file while the parent was being deleted.
  This was detected, and the added dentry was having d_invalidate() called
  on it, but the deletion of the directory was also calling d_invalidate()
  on that same dentry.

- A fix to not free the eventfs_inode (ei) until the last dput() was called
  on its ei->dentry made the ei->dentry exist even after it was marked
  for free by setting the ei->is_freed. But code elsewhere still was
  checking if ei->dentry was NULL if ei->is_freed is set and would
  trigger WARN_ON if that was the case. That's no longer true and there
  should not be any warnings when it is true.

- Use GFP_NOFS for allocations done under eventfs_mutex.
  The eventfs_mutex can be taken on file system reclaim, make sure
  that allocations done under that mutex do not trigger file system
  reclaim.

- Clean up code by moving the taking of inode_lock out of the helper
  functions and into where they are needed, and not use the
  parameter to know to take it or not. It must always be held but
  some callers of the helper function have it taken when they were
  called.

- Warn if the inode_lock is not held in the helper functions.

- Warn if eventfs_start_creating() is called without a parent.
  As eventfs is underneath tracefs, all files created will have
  a parent (the top one will have a tracefs parent).

Tracing update;

- Add Mathieu Desnoyers as an official reviewer of the tracing sub system.


Please pull the latest trace-v6.7-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.7-rc2

Tag SHA1: 94eabb90d0195e49d78e7714be7b239284ee1e96
Head SHA1: 76d9eafff4484547ed9e606c8227ac9799a9f2da


Mathieu Desnoyers (1):
      MAINTAINERS: TRACING: Add Mathieu Desnoyers as Reviewer

Steven Rostedt (Google) (6):
      eventfs: Remove expectation that ei->is_freed means ei->dentry == NULL
      eventfs: Do not invalidate dentry in create_file/dir_dentry()
      eventfs: Use GFP_NOFS for allocation when eventfs_mutex is held
      eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()
      eventfs: Do not allow NULL parent to eventfs_start_creating()
      eventfs: Make sure that parent->d_inode is locked in creating files/dirs

----
 MAINTAINERS              |  1 +
 fs/tracefs/event_inode.c | 65 +++++++++++++++++++-----------------------------
 fs/tracefs/inode.c       | 13 +++-------
 3 files changed, 31 insertions(+), 48 deletions(-)
---------------------------
diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af79..a2d4ef4d90f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22078,6 +22078,7 @@ F:	drivers/watchdog/tqmx86_wdt.c
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
+R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f8a594a50ae6..0b90869fd805 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -27,16 +27,16 @@
 /*
  * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
  * to the ei->dentry must be done under this mutex and after checking
- * if ei->is_freed is not set. The ei->dentry is released under the
- * mutex at the same time ei->is_freed is set. If ei->is_freed is set
- * then the ei->dentry is invalid.
+ * if ei->is_freed is not set. When ei->is_freed is set, the dentry
+ * is on its way to being freed after the last dput() is made on it.
  */
 static DEFINE_MUTEX(eventfs_mutex);
 
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
  * its parent's list and will have is_freed set (under eventfs_mutex).
- * After the SRCU grace period is over, the ei may be freed.
+ * After the SRCU grace period is over and the last dput() is called
+ * the ei is freed.
  */
 DEFINE_STATIC_SRCU(eventfs_srcu);
 
@@ -95,7 +95,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
 		if (!ei->entry_attrs) {
 			ei->entry_attrs = kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
-						  GFP_KERNEL);
+						  GFP_NOFS);
 			if (!ei->entry_attrs) {
 				ret = -ENOMEM;
 				goto out;
@@ -326,7 +326,8 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 	struct eventfs_attr *attr = NULL;
 	struct dentry **e_dentry = &ei->d_children[idx];
 	struct dentry *dentry;
-	bool invalidate = false;
+
+	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
 
 	mutex_lock(&eventfs_mutex);
 	if (ei->is_freed) {
@@ -348,15 +349,8 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 
 	mutex_unlock(&eventfs_mutex);
 
-	/* The lookup already has the parent->d_inode locked */
-	if (!lookup)
-		inode_lock(parent->d_inode);
-
 	dentry = create_file(name, mode, attr, parent, data, fops);
 
-	if (!lookup)
-		inode_unlock(parent->d_inode);
-
 	mutex_lock(&eventfs_mutex);
 
 	if (IS_ERR_OR_NULL(dentry)) {
@@ -365,12 +359,14 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 		 * created the dentry for this e_dentry. In which case
 		 * use that one.
 		 *
-		 * Note, with the mutex held, the e_dentry cannot have content
-		 * and the ei->is_freed be true at the same time.
+		 * If ei->is_freed is set, the e_dentry is currently on its
+		 * way to being freed, don't return it. If e_dentry is NULL
+		 * it means it was already freed.
 		 */
-		dentry = *e_dentry;
-		if (WARN_ON_ONCE(dentry && ei->is_freed))
+		if (ei->is_freed)
 			dentry = NULL;
+		else
+			dentry = *e_dentry;
 		/* The lookup does not need to up the dentry refcount */
 		if (dentry && !lookup)
 			dget(dentry);
@@ -387,17 +383,14 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 		 * Otherwise it means two dentries exist with the same name.
 		 */
 		WARN_ON_ONCE(!ei->is_freed);
-		invalidate = true;
+		dentry = NULL;
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	if (invalidate)
-		d_invalidate(dentry);
-
-	if (lookup || invalidate)
+	if (lookup)
 		dput(dentry);
 
-	return invalidate ? NULL : dentry;
+	return dentry;
 }
 
 /**
@@ -437,9 +430,10 @@ static struct dentry *
 create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		  struct dentry *parent, bool lookup)
 {
-	bool invalidate = false;
 	struct dentry *dentry = NULL;
 
+	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
+
 	mutex_lock(&eventfs_mutex);
 	if (pei->is_freed || ei->is_freed) {
 		mutex_unlock(&eventfs_mutex);
@@ -456,15 +450,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	/* The lookup already has the parent->d_inode locked */
-	if (!lookup)
-		inode_lock(parent->d_inode);
-
 	dentry = create_dir(ei, parent);
 
-	if (!lookup)
-		inode_unlock(parent->d_inode);
-
 	mutex_lock(&eventfs_mutex);
 
 	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
@@ -473,8 +460,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		 * created the dentry for this e_dentry. In which case
 		 * use that one.
 		 *
-		 * Note, with the mutex held, the e_dentry cannot have content
-		 * and the ei->is_freed be true at the same time.
+		 * If ei->is_freed is set, the e_dentry is currently on its
+		 * way to being freed.
 		 */
 		dentry = ei->dentry;
 		if (dentry && !lookup)
@@ -493,16 +480,14 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		 * Otherwise it means two dentries exist with the same name.
 		 */
 		WARN_ON_ONCE(!ei->is_freed);
-		invalidate = true;
+		dentry = NULL;
 	}
 	mutex_unlock(&eventfs_mutex);
-	if (invalidate)
-		d_invalidate(dentry);
 
-	if (lookup || invalidate)
+	if (lookup)
 		dput(dentry);
 
-	return invalidate ? NULL : dentry;
+	return dentry;
 }
 
 /**
@@ -632,7 +617,7 @@ static int add_dentries(struct dentry ***dentries, struct dentry *d, int cnt)
 {
 	struct dentry **tmp;
 
-	tmp = krealloc(*dentries, sizeof(d) * (cnt + 2), GFP_KERNEL);
+	tmp = krealloc(*dentries, sizeof(d) * (cnt + 2), GFP_NOFS);
 	if (!tmp)
 		return -1;
 	tmp[cnt] = d;
@@ -698,6 +683,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
+	inode_lock(parent->d_inode);
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 		d = create_dir_dentry(ei, ei_child, parent, false);
@@ -730,6 +716,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 			cnt++;
 		}
 	}
+	inode_unlock(parent->d_inode);
 	srcu_read_unlock(&eventfs_srcu, idx);
 	ret = dcache_dir_open(inode, file);
 
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5b54948514fe..ae648deed019 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -509,20 +509,15 @@ struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 	int error;
 
+	/* Must always have a parent. */
+	if (WARN_ON_ONCE(!parent))
+		return ERR_PTR(-EINVAL);
+
 	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
 			      &tracefs_mount_count);
 	if (error)
 		return ERR_PTR(error);
 
-	/*
-	 * If the parent is not specified, we create it in the root.
-	 * We need the root dentry to do this, which is in the super
-	 * block. A pointer to that is in the struct vfsmount that we
-	 * have around.
-	 */
-	if (!parent)
-		parent = tracefs_mount->mnt_root;
-
 	if (unlikely(IS_DEADDIR(parent->d_inode)))
 		dentry = ERR_PTR(-ENOENT);
 	else

