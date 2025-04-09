Return-Path: <linux-fsdevel+bounces-46128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936AA82E79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 20:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4257AE709
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 18:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DCB277032;
	Wed,  9 Apr 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXvVOBnn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD461C5F23;
	Wed,  9 Apr 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222762; cv=none; b=C0qjb/fVH0UKFqFsHLeEeysUhZF6NM28mjZ/qXPIsbHHubBy4gNtvZteB/792m84ax07qnwEFOda0pxKXKNhxVIJ7eJm9PbvJmWidVDei94H7v0eYCXEtUY39tw6PHJzELnvb3CbbRRIV49Bpc6cSeUyBq928SVYhH0oNyZgjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222762; c=relaxed/simple;
	bh=WejBdoRPjchDP+2aS+M1B7jTNfwEzrO0CEc9FW4eZTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl2Jxg0SjFZqbQXAClY4oqbOVlNd3A/fE+6CQN7gTEY5y9BwGYqRkLTpVOyqLQLplYdO3XeCYSjcToINs0s/bKNgf+hXMFSksjT1z4UQsbUvpfIui5hmZstxxtUhVL5HqWk5SEOPNF6gqCfpK/IE/dahfWUsaS3zgAycSgsm+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXvVOBnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE47C4CEE2;
	Wed,  9 Apr 2025 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744222761;
	bh=WejBdoRPjchDP+2aS+M1B7jTNfwEzrO0CEc9FW4eZTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXvVOBnnQRSFuPSkraU8YZNo4LGZFwHc7t6a8QPOl7NHz3dr85Dqj4rJjwLW2gXl7
	 6w6AulG4p58V4vAIF6MagI1AsPBIy2V1eviseTd8eksSdd07EkDbLEobMOmycglHMT
	 WVzbLTQZDe8dWAEWFB/r0hbkBcPb68mHUpDjBE4SJbU3yD362ekZtpOVzqcNH+VXWM
	 P4UqPoP9UXP9TM/RwKJdIIH39PFzEMClUUzS1UzUaD5Ug49j8vrN+bhHB/ZnPFgQfa
	 WfGarRybZIXxjNCQ+xDSFsaqb92zfXSWyHh/rN7jNEgufaSN8iysCgW7SaF4xNQrEM
	 FxwZzkaudzeVQ==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>,
	linux-kernel@vger.kernel.org,
	Peter Ziljstra <peterz@infradead.org>
Subject: [RFC PATCH] pidfs: ensure consistent ENOENT/ESRCH reporting
Date: Wed,  9 Apr 2025 20:18:58 +0200
Message-ID: <20250409-rohstoff-ungnade-d1afa571f32c@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409-sesshaft-absurd-35d97607142c@brauner>
References: <20250409-sesshaft-absurd-35d97607142c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3895; i=brauner@kernel.org; h=from:subject:message-id; bh=WejBdoRPjchDP+2aS+M1B7jTNfwEzrO0CEc9FW4eZTM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/2yUUafg74wtjSsKjTxY2resDlsfXLFzBrXFwl7FOq y6P5JM9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5zcHIMOfvYZ6uJ0+VpbvZ W68y3q2u6Co4ayHvyPJlQvANv711JxkZ/u9jVotMzCib2phx7vXjT/O6Th1gSKye8f6SbuCLW7w zGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

In a prior patch series we tried to cleanly differentiate between:

(1) The task has already been reaped.
(2) The caller requested a pidfd for a thread-group leader but the pid
    actually references a struct pid that isn't used as a thread-group
    leader.

as this was causing issues for non-threaded workloads.

But there's cases where the current simple logic is wrong. Specifically,
if the pid was a leader pid and the check races with __unhash_process().

Stabilize this by using a sequence counter associated with tasklist_lock
and retry while we're in __unhash_process(). The seqcounter might be
useful independent of pidfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/pid.h |  1 +
 kernel/exit.c       | 11 +++++++++++
 kernel/fork.c       | 22 ++++++++++++----------
 kernel/pid.c        |  1 +
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 311ecebd7d56..b54a4c1ef602 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -65,6 +65,7 @@ struct pid
 	struct hlist_head inodes;
 	/* wait queue for pidfd notifications */
 	wait_queue_head_t wait_pidfd;
+	seqcount_rwlock_t pid_seq;
 	struct rcu_head rcu;
 	struct upid numbers[];
 };
diff --git a/kernel/exit.c b/kernel/exit.c
index 1b51dc099f1e..8050572fe682 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -133,17 +133,28 @@ struct release_task_post {
 static void __unhash_process(struct release_task_post *post, struct task_struct *p,
 			     bool group_dead)
 {
+	struct pid *pid;
+
+	lockdep_assert_held_write(&tasklist_lock);
+
 	nr_threads--;
+
+	pid = task_pid(p);
+	raw_write_seqcount_begin(&pid->pid_seq);
 	detach_pid(post->pids, p, PIDTYPE_PID);
 	if (group_dead) {
 		detach_pid(post->pids, p, PIDTYPE_TGID);
 		detach_pid(post->pids, p, PIDTYPE_PGID);
 		detach_pid(post->pids, p, PIDTYPE_SID);
+	}
+	raw_write_seqcount_end(&pid->pid_seq);
 
+	if (group_dead) {
 		list_del_rcu(&p->tasks);
 		list_del_init(&p->sibling);
 		__this_cpu_dec(process_counts);
 	}
+
 	list_del_rcu(&p->thread_node);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 4a2080b968c8..1480bf6f5f38 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2109,24 +2109,26 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
 	int err = 0;
+	unsigned int seq;
 
-	if (!(flags & PIDFD_THREAD)) {
+	do {
+		seq = raw_seqcount_begin(&pid->pid_seq);
 		/*
 		 * If this is struct pid isn't used as a thread-group
 		 * leader pid but the caller requested to create a
 		 * thread-group leader pidfd then report ENOENT to the
 		 * caller as a hint.
 		 */
-		if (!pid_has_task(pid, PIDTYPE_TGID))
+		if (!(flags & PIDFD_THREAD) && !pid_has_task(pid, PIDTYPE_TGID))
 			err = -ENOENT;
-	}
-
-	/*
-	 * If this wasn't a thread-group leader struct pid or the task
-	 * got reaped in the meantime report -ESRCH to userspace.
-	 */
-	if (!pid_has_task(pid, PIDTYPE_PID))
-		err = -ESRCH;
+		/*
+		 * If this wasn't a thread-group leader struct pid or
+		 * the task got reaped in the meantime report -ESRCH to
+		 * userspace.
+		 */
+		if (!pid_has_task(pid, PIDTYPE_PID))
+			err = -ESRCH;
+	} while (read_seqcount_retry(&pid->pid_seq, seq));
 	if (err)
 		return err;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 4ac2ce46817f..bbca61f62faa 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -271,6 +271,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	upid = pid->numbers + ns->level;
 	idr_preload(GFP_KERNEL);
 	spin_lock(&pidmap_lock);
+	seqcount_rwlock_init(&pid->pid_seq, &tasklist_lock);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
 		goto out_unlock;
 	pidfs_add_pid(pid);
-- 
2.47.2


