Return-Path: <linux-fsdevel+bounces-51763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62809ADB2E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A350A16BABA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B171C84B2;
	Mon, 16 Jun 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8LxQnmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875481DB122
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082579; cv=none; b=SRe3P6dVBhrFDbXPe0pPRDXa6yRm4FRdua51XSnkF+bmiIPrvimW3TOokpV5nopO6C7SOEfvIujBZ1jwLqX0ZFCE00KaxrGfXle2ZuukmbfkOEyC3IWnbTHrG546FxHvcbijLTGkN6L2P07PaxJ4dgAZKJcBdzjJhZMvIceUATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082579; c=relaxed/simple;
	bh=ZwOw9nuyKUQ8mqqMpJ8ZwwDVzqnpw4P9hsgbOjsuR1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLrfNZEGJku3qUp2JsRml2jIPjWFtPjxoSV97R7bk7DZ+sViB2b5BpsglLb3tLmY4h5TrcYJPM5zB+9MBG6w+Gn+eA/KuHghZ0/Zp1ZopZXJYorS0HXWUdhx3VjuADFc4cIKweRJ5F0SnUBDU8aU0AY8H+XPZe98e2eRlqhx96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8LxQnmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81484C4CEF6;
	Mon, 16 Jun 2025 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750082579;
	bh=ZwOw9nuyKUQ8mqqMpJ8ZwwDVzqnpw4P9hsgbOjsuR1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k8LxQnmgFfV/Hq3GUOc1yW0tZVi9joRYJ0/v8L9l4pWFRqBxo+iDFpqeiFrN9LNv8
	 mMDINGJ1Mp3bBR5Sss9sFrQpaOp4xPzttKvFQ5+wFrDFLac0Zc6dajG4mDszhvzRSd
	 bm77OEPF327zpD0Cmr1OCFV+2HkGWDUPPhSbF/OXEiMTKiWI0EtzxeZGYSWVhTfZuz
	 kfQc1sbHrcL6DkeTKIRL7yTvoA5DmOHk8VMK2fNI7jlqDuKtybs4BQ+gnQvidpkuGt
	 8yLYlQcE7xBwjrO0nvBQVm8Ys9WBZCwlmAGsM8GfSTdqylVs3ttL+HxdJ899SfjCas
	 9zMuXRbT0q57g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Jun 2025 16:02:47 +0200
Subject: [PATCH RFC 1/2] pidfs: keep pidfs dentry stashed once created
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-work-pidfs-v1-1-a3babc8aa62b@kernel.org>
References: <20250616-work-pidfs-v1-0-a3babc8aa62b@kernel.org>
In-Reply-To: <20250616-work-pidfs-v1-0-a3babc8aa62b@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=12927; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZwOw9nuyKUQ8mqqMpJ8ZwwDVzqnpw4P9hsgbOjsuR1s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEqAhcXGF6IWZmi3vQhslh8gu1C5PVDkx5yD4hbrqvR
 PTjTf9fdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE5AbDPxPlc+F/rN+fSJwq
 vV4onX/Zh1tMvIWdqSKCMpFCDuc0pzL8lWZns3+41cfr3z8JeznFufuXbWg79LJlzrybd+aavjo
 jzQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Keep pidfs dentries around after a pidfd has been created for it.
Such pidfs dentry will only be cleaned up once the struct pid gets
reaped. This also allows us to fix a race condition that currently
exists in the code.

The current scheme allocated pidfs dentries on-demand repeatedly.

If someone opens a pidfd for a struct pid a pidfs dentry is allocated
and stashed in pid->stashed. Once the last pidfd for the struct pid is
closed the pidfs dentry is released and removed from pid->stashed.

So if 10 callers create a pidfs for the same struct pid sequentially,
i.e., each closing the pidfd before the other creates a new one then a
new pidfs dentry is allocated every time.

Because multiple tasks acquiring and releasing a pidfd for the same
struct pid can race with each other a task may still find a valid pidfs
entry from the previous task in pid->stashed and reuse it. Or it might
find a dead dentry in there and fail to reuse it and so stashes a new
pidfs dentry. Multiple tasks may race to stash a new pidfs dentry but
only one will succeed, the other ones will put their dentry.

The current scheme ensures that a reference to a struct pid can only be
taken if the task is still alive or if a pidfs dentry already existed
and exit information has been stashed in the pidfs inode.

Except that it's also buggy. If a pidfs dentry is stashed in
pid->stashed after pidfs_exit() but before __unhash_process() is called
we will return a pidfd for a reaped task without exit information being
available.

The pidfds_pid_valid() check does not guard against this race as it
doens't sync at all with pidfs_exit(). The pid_has_task() check might be
successful simply because we're before __unhash_process() but after
pidfs_exit().

The current scheme also makes it more difficult to pin information that
needs to be available even after the task has been reaped such as exit
or coredump information.

This switches to a scheme were pidfs entries are retained after a pidfd
was created for the struct pid. So retain a reference is retained that
belongs to the exit path and that will be put once the task does get
reaped. In the new model pidfs dentries are still allocated on-demand
but then kept until the task gets reaped.

The synchronization mechanism used the pid->wait_pidfd.lock in struct
pid. If the path_from_stashed() fastpath fails a new pidfs dentry is
allocated and afterwards the pid->wait_pidfd.lock is taken. If no other
task managed to stash its dentry there the callers will be stashed.

Similarly when a pidfs dentry is pruned via
dentry->d_prune::pidfs_dentry_prune() the pid->wait_pidfd.lock is also
taken.

And finally the pid->wait_pidfd.lock is taken during pidfs_exit(). This
allows us to fix the bug mentioned earlier where we hand out a pidfd for
a reaped task without having exit information set.

Once pidfs_exit() holds the pid->wait_pidfd.lock and sees that no pidfs
dentry is available in pid->stashed it knows that no new dentry can be
stashed while it holds the pid->wait_pidfd.lock. It thus sets a
ERR_PTR(-ESRCH) sentinel in pid->stashed. That sentinel allows
pidfs_stash_dentry() to detect that the struct pid has already been
reaped and refuse to stash a new dentry in pid->stashed.

This also has some subtle interactions with the path_from_stashed()
fastpath that need to be considered. The path_from_stashed() fast path
will try go get a reference to the pidfs dentry in pid->stashed to avoid
having to allocate and stash a pidfs dentry. If it finds dentry in there
it will return it.

To not confuse path_from_stashed() pidfs_exit() must not replace a pidfs
dentry stashed in pid->stashed with the ERR_PTR(-ESRCH) sentinel as
path_from_stashed() could legitimately obtain another reference before
pidfs_exit() was able to call dput() to put the final pidfs dentry
reference. If it were to put the sentinel into pid->stashed it would
invalidate a struct pid even though a pidfd was just created for it.

So if a pidfs dentry is stashed in pid->stashed pidfs_exit() must leave
clearing out pid->stashed to dentry->d_prune::pidfs_dentry_prune().
Concurrent calls to path_from_stashed() will see a dead dentry in there
and will be forced into the slowpath.

Inversely, path_from_stashed() must take care to not try and take a
reference on the ERR_PTR(-ESRCH) sentinel. So stashed_dentry_get() must
be prepared to see a ERR_PTR(-ESRCH) sentinel in pid->stashed.

Note that it doesn't matter whether the path_from_stashed() fast path
sees NULL, a dead dentry, or the ERR_PTR(-ESRCH) sentinel in
pid->stashed. Any of those forces path_from_stashed() into the slowpath
at which point pid->wait_pidfd.lock must be acquired serializing against
pidfs_exit() and pidfs_dentry_prune().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h |   2 +
 fs/libfs.c    |  22 ++++++++---
 fs/pidfs.c    | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 124 insertions(+), 21 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 393f6c5c24f6..180b367c192b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -322,6 +322,8 @@ struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
 struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
 void mnt_idmap_put(struct mnt_idmap *idmap);
 struct stashed_operations {
+	struct dentry *(*stash_dentry)(struct dentry **stashed,
+				       struct dentry *dentry);
 	void (*put_data)(void *data);
 	int (*init_inode)(struct inode *inode, void *data);
 };
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a8..f496373869fb 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2128,6 +2128,8 @@ struct dentry *stashed_dentry_get(struct dentry **stashed)
 	dentry = rcu_dereference(*stashed);
 	if (!dentry)
 		return NULL;
+	if (IS_ERR(dentry))
+		return dentry;
 	if (!lockref_get_not_dead(&dentry->d_lockref))
 		return NULL;
 	return dentry;
@@ -2218,12 +2220,15 @@ static struct dentry *stash_dentry(struct dentry **stashed,
 int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		      struct path *path)
 {
-	struct dentry *dentry;
+	struct dentry *dentry, *res;
 	const struct stashed_operations *sops = mnt->mnt_sb->s_fs_info;
 
 	/* See if dentry can be reused. */
-	path->dentry = stashed_dentry_get(stashed);
-	if (path->dentry) {
+	res = stashed_dentry_get(stashed);
+	if (IS_ERR(res))
+		return PTR_ERR(res);
+	if (res) {
+		path->dentry = res;
 		sops->put_data(data);
 		goto out_path;
 	}
@@ -2234,8 +2239,15 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		return PTR_ERR(dentry);
 
 	/* Added a new dentry. @data is now owned by the filesystem. */
-	path->dentry = stash_dentry(stashed, dentry);
-	if (path->dentry != dentry)
+	if (sops->stash_dentry)
+		res = sops->stash_dentry(stashed, dentry);
+	else
+		res = stash_dentry(stashed, dentry);
+	if (IS_ERR(res))
+		return PTR_ERR(res);
+	path->dentry = res;
+	/* A dentry was reused. */
+	if (res != dentry)
 		dput(dentry);
 
 out_path:
diff --git a/fs/pidfs.c b/fs/pidfs.c
index c1f0a067be40..69b10ec9b993 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -25,6 +25,16 @@
 #include "internal.h"
 #include "mount.h"
 
+/*
+ * Usage:
+ * pid->wait_pidfd.lock protects:
+ *   - insertion of dentry into pid->stashed
+ *   - deletion of dentry into pid->stashed
+ *   - deletion of pid[PIDTYPE_TGID] task linkage
+ */
+
+#define PIDFS_PID_DEAD ERR_PTR(-ESRCH)
+
 static struct kmem_cache *pidfs_cachep __ro_after_init;
 
 /*
@@ -552,30 +562,47 @@ struct pid *pidfd_pid(const struct file *file)
  * task has been reaped which cannot happen until we're out of
  * release_task().
  *
- * If this struct pid is referred to by a pidfd then
- * stashed_dentry_get() will return the dentry and inode for that struct
- * pid. Since we've taken a reference on it there's now an additional
- * reference from the exit path on it. Which is fine. We're going to put
- * it again in a second and we know that the pid is kept alive anyway.
+ * If this struct pid has at least once been referred to by a pidfd then
+ * pid->stashed will contain a dentry. One reference exclusively belongs
+ * to pidfs_exit(). There might of course be other references.
  *
  * Worst case is that we've filled in the info and immediately free the
- * dentry and inode afterwards since the pidfd has been closed. Since
- * pidfs_exit() currently is placed after exit_task_work() we know that
- * it cannot be us aka the exiting task holding a pidfd to ourselves.
+ * dentry and inode afterwards when no one holds an open pidfd anymore.
+ * Since pidfs_exit() currently is placed after exit_task_work() we know
+ * that it cannot be us aka the exiting task holding a pidfd to itself.
  */
 void pidfs_exit(struct task_struct *tsk)
 {
 	struct dentry *dentry;
+	struct pid *pid = task_pid(tsk);
 
 	might_sleep();
 
-	dentry = stashed_dentry_get(&task_pid(tsk)->stashed);
-	if (dentry) {
-		struct inode *inode = d_inode(dentry);
-		struct pidfs_exit_info *exit_info = &pidfs_i(inode)->__pei;
+	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
+		struct inode *inode;
+		struct pidfs_exit_info *exit_info;
 #ifdef CONFIG_CGROUPS
 		struct cgroup *cgrp;
+#endif
 
+		dentry = pid->stashed;
+		if (!dentry) {
+			/*
+			 * No one held a pidfd for this struct pid.
+			 * Mark it as dead so no one can add a pidfs
+			 * entry anymore. We're about to be reaped and
+			 * so no exit information would be available.
+			 */
+			rcu_assign_pointer(pid->stashed, PIDFS_PID_DEAD);
+			return;
+		}
+
+		/* We own a reference assert that clearly. */
+		VFS_WARN_ON_ONCE(__lockref_is_dead(&dentry->d_lockref));
+		inode = d_inode(dentry);
+		exit_info = &pidfs_i(inode)->__pei;
+
+#ifdef CONFIG_CGROUPS
 		rcu_read_lock();
 		cgrp = task_dfl_cgroup(tsk);
 		exit_info->cgroupid = cgroup_id(cgrp);
@@ -585,8 +612,15 @@ void pidfs_exit(struct task_struct *tsk)
 
 		/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
 		smp_store_release(&pidfs_i(inode)->exit_info, &pidfs_i(inode)->__pei);
-		dput(dentry);
 	}
+
+	/*
+	 * If there was a dentry in there we own a reference to it. So
+	 * accessing pid->stashed is safe. Note, pid->stashed will be
+	 * cleared by pidfs. Leave it alone as we could end up in a
+	 * legitimate race with path_from_stashed()'s fast path.
+	 */
+	dput(dentry);
 }
 
 #ifdef CONFIG_COREDUMP
@@ -683,9 +717,30 @@ static char *pidfs_dname(struct dentry *dentry, char *buffer, int buflen)
 	return dynamic_dname(buffer, buflen, "anon_inode:[pidfd]");
 }
 
+static void pidfs_dentry_prune(struct dentry *dentry)
+{
+	struct dentry **stashed = dentry->d_fsdata;
+	struct inode *inode = d_inode(dentry);
+	struct pid *pid;
+
+	if (WARN_ON_ONCE(!stashed))
+		return;
+
+	if (!inode)
+		return;
+
+	pid = inode->i_private;
+	VFS_WARN_ON_ONCE(!pid);
+	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
+		VFS_WARN_ON_ONCE(!__lockref_is_dead(&dentry->d_lockref));
+		VFS_WARN_ON_ONCE(*stashed != dentry);
+		rcu_assign_pointer(*stashed, PIDFS_PID_DEAD);
+	}
+}
+
 const struct dentry_operations pidfs_dentry_operations = {
 	.d_dname	= pidfs_dname,
-	.d_prune	= stashed_dentry_prune,
+	.d_prune	= pidfs_dentry_prune,
 };
 
 static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
@@ -878,9 +933,43 @@ static void pidfs_put_data(void *data)
 	put_pid(pid);
 }
 
+static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
+					 struct dentry *dentry)
+{
+	struct pid *pid = d_inode(dentry)->i_private;
+
+	VFS_WARN_ON_ONCE(stashed != &pid->stashed);
+
+	/* We need to synchronize with pidfs_exit(). */
+	guard(spinlock_irq)(&pid->wait_pidfd.lock);
+
+	/*
+	 * There's nothing stashed in here so no pidfs dentry exists for
+	 * this task yet and we're definitely not past pidfs_exit().
+	 */
+	if (likely(!pid->stashed)) {
+		rcu_assign_pointer(pid->stashed, dget(dentry));
+		return dentry;
+	}
+
+	/*
+	 * We're past pidfs_exit() so we can't return a pidfd for this
+	 * reaped struct pid as no exit information would be available.
+	 */
+	if (pid->stashed == PIDFS_PID_DEAD)
+		return ERR_PTR(-ESRCH);
+
+	/* Another task might've raced us and added a pidfs dentry. */
+	dentry = stashed_dentry_get(&pid->stashed);
+	VFS_WARN_ON_ONCE(!dentry);
+	VFS_WARN_ON_ONCE(IS_ERR(dentry));
+	return dentry;
+}
+
 static const struct stashed_operations pidfs_stashed_ops = {
-	.init_inode = pidfs_init_inode,
-	.put_data = pidfs_put_data,
+	.stash_dentry	= pidfs_stash_dentry,
+	.init_inode	= pidfs_init_inode,
+	.put_data	= pidfs_put_data,
 };
 
 static int pidfs_init_fs_context(struct fs_context *fc)

-- 
2.47.2


