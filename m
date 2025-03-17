Return-Path: <linux-fsdevel+bounces-44204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56BA654D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 16:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30AE17319F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA843241690;
	Mon, 17 Mar 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxPON4j5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA90143748
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223663; cv=none; b=Cr3AW9ZY7RKhVnWSl1XLMgk+nH8FOFoInEjnsC75tCcKexZ2+N3pe7Y5LLs0RQgA/va+P7M4MghsU68I8UrlDFb4AixxuAS1LYwobIPcJYmJ0lOLum2hgsk6B808PaOoTeyrW2ZLd/zDpg9ikneuaq6g1wqKpkJpyaj7GkbyWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223663; c=relaxed/simple;
	bh=93FxWXzqDcEOVqdT/JiJMJDAMwJ9JFW9WoXZFU+rQDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9z1Dg1Pn7GinsNf0/EoTW8IRyzOroHuRjIfA9oqj8NGIggeNCnJrGin6IFJiE4uhGx5513Q3vcfSUqX6zGsmMf95md/0JcRirHaCgyfeKXKH1Z1K2CuXf45tSuOD3yIvzZbB7/tj1uyjvpddh9dAxdMXcwGp7ab5yahwVrPcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxPON4j5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E9DC4CEED;
	Mon, 17 Mar 2025 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742223662;
	bh=93FxWXzqDcEOVqdT/JiJMJDAMwJ9JFW9WoXZFU+rQDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mxPON4j5n1sOfVka/YmtWDUci1NfNg8m8zYMua07ctqoZb5OOI8vgtRnbSxd9NGqT
	 Rl/VH4Y2rNnGJ7Gl2O1Ayl/0XiEUvyevvLQfcaNtB5+YvAIL4TEKRstStEbLaj+yLS
	 +9TrmW1YXRoTR6leWoUfQvsw0X2ldWAz93q+pqx5zka/DDDojWHMQzfCoAIvbHQZUl
	 czlA00p8sIWQXkZyoKoR+zYX38cG+yopRidx/jwMAgMbq5sWoffvFFPqyPtXgrUw1b
	 dCp1jRHWDnRXa9IIYPSh4Yq12piqLF32CzdAjX6RnsVhbHYdQBcO+VKFLvja+MsbZi
	 A97nfB3NTdI2g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Mar 2025 16:00:43 +0100
Subject: [PATCH RFC 1/2] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-work-pidfs-thread_group-v1-1-bc9e5ed283e9@kernel.org>
References: <20250317-work-pidfs-thread_group-v1-0-bc9e5ed283e9@kernel.org>
In-Reply-To: <20250317-work-pidfs-thread_group-v1-0-bc9e5ed283e9@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=6907; i=brauner@kernel.org;
 h=from:subject:message-id; bh=93FxWXzqDcEOVqdT/JiJMJDAMwJ9JFW9WoXZFU+rQDY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfsNTaM6nKcL7E1iuTfW2c1Cqt3wen2gb9YNu489f7N
 YZ3glOTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZScJGR4Z37DK058tmC9ea/
 HTIW53L/OzT38dmZDGHLOiX+2c5aVsXwv/Lc9GWhhbWnN97r1u/6Nsc2OeSC0PEvK25cnFVuvjX
 blQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This is another attempt trying to make pidfd polling for multi-threaded
exec and premature thread-group leader exit consistent.

A quick recap of these two cases:

(1) During a multi-threaded exec by a subthread, i.e., non-thread-group
    leader thread, all other threads in the thread-group including the
    thread-group leader are killed and the struct pid of the
    thread-group leader will be taken over by the subthread that called
    exec. IOW, two tasks change their TIDs.

(2) A premature thread-group leader exit means that the thread-group
    leader exited before all of the other subthreads in the thread-group
    have exited.

Both cases lead to inconsistencies for pidfd polling with PIDFD_THREAD.
Any caller that holds a PIDFD_THREAD pidfd to the current thread-group
leader may or may not see an exit notification on the file descriptor
depending on when poll is performed. If the poll is performed before the
exec of the subthread has concluded an exit notification is generated
for the old thread-group leader. If the poll is performed after the exec
of the subthread has concluded no exit notification is generated for the
old thread-group leader.

The correct behavior would be to simply not generate an exit
notification on the struct pid of a subhthread exec because the struct
pid is taken over by the subthread and thus remains alive.

But this is difficult to handle because a thread-group may exit
prematurely as mentioned in (2). In that case an exit notification is
reliably generated but the subthreads may continue to run for an
indeterminate amount of time and thus also may exec at some point.

So far there was no way to distinguish between (1) and (2) internally.
This tiny series tries to address this problem by remembering a
premature leader exit in struct pid and forgetting it when a subthread
execs and takes over the old thread-group leaders struct pid.

This can be done without growing struct pid. The 32-bit pid namespace
level indicator can be split into two 16-bit integers as only 32 levels
of pid namespace nesting are allowed. Even with 16-bit the nesting level
can in the future be bumped up to 65,535 (which isn't feasible/sensible
for a lot of reasons).

The second 16-bit are used as an indicator for a premature thread-group
leader exec which is cleared when the last subthread gets autoreaped and
the prematurely exited thread-group leader is notified.

If that works correctly then no exit notifications are generated for a
PIDFD_THREAD pidfd for a thread-group leader until all subthreads have
been reaped. If a subthread should exec aftewards no exit notification
will be generated until that task exits or it creates subthreads and
repeates the cycle.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c          | 28 ++++++++++++++++++++++++++--
 include/linux/pid.h |  3 ++-
 kernel/exit.c       | 24 ++++++++++++++++++++++--
 kernel/pid.c        |  9 +++++++++
 4 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index d980f779c213..f63e29ad8edc 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -223,8 +223,32 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	task = pid_task(pid, PIDTYPE_PID);
 	if (!task)
 		poll_flags = EPOLLIN | EPOLLRDNORM | EPOLLHUP;
-	else if (task->exit_state && (thread || thread_group_empty(task)))
-		poll_flags = EPOLLIN | EPOLLRDNORM;
+	else if (task->exit_state) {
+		if (thread) {
+			/*
+			 * If this is a regular thread exit then notify
+			 * the PIDFD_THREAD waiters.
+			 *
+			 * Don't notify in the following circumstances:
+			 *
+			 * (1) If this is a premature thread-group
+			 *     leader exit then delay the exit nofication
+			 *     until the last thread in the thread-group
+			 *     gets autoreaped as there might still be a
+			 *     thread that execs and revives the struct
+			 *     pid of the old thread-group leader.
+			 * (2) There's a multi-threaded exec commencing
+			 *     and @pid is the current and therefore new
+			 *     thread-group leader's pid.
+			 */
+			if (likely(!READ_ONCE(pid->delayed_leader) &&
+				   !(pid_task(pid, PIDTYPE_TGID) && READ_ONCE(task->signal->group_exec_task))))
+				poll_flags = EPOLLIN | EPOLLRDNORM;
+		}
+
+		if (thread_group_empty(task))
+			poll_flags = EPOLLIN | EPOLLRDNORM;
+	}
 
 	return poll_flags;
 }
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 98837a1ff0f3..e6dade16caad 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -55,7 +55,8 @@ struct upid {
 struct pid
 {
 	refcount_t count;
-	unsigned int level;
+	u16 level;
+	u16 delayed_leader;
 	spinlock_t lock;
 	struct dentry *stashed;
 	u64 ino;
diff --git a/kernel/exit.c b/kernel/exit.c
index 9916305e34d3..f01ee0a08707 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -267,6 +267,11 @@ void release_task(struct task_struct *p)
 	leader = p->group_leader;
 	if (leader != p && thread_group_empty(leader)
 			&& leader->exit_state == EXIT_ZOMBIE) {
+		struct pid *pid;
+
+		pid = task_pid(leader);
+		WRITE_ONCE(pid->delayed_leader, 0);
+
 		/*
 		 * If we were the last child thread and the leader has
 		 * exited already, and the leader's parent ignores SIGCHLD,
@@ -746,8 +751,23 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 	 * sub-thread or delay_group_leader(), wake up the
 	 * PIDFD_THREAD waiters.
 	 */
-	if (!thread_group_empty(tsk))
-		do_notify_pidfd(tsk);
+	if (!thread_group_empty(tsk)) {
+		if (delay_group_leader(tsk)) {
+			struct pid *pid;
+
+			/*
+			 * This is a thread-group leader exiting before
+			 * all of its subthreads have exited allow pidfd
+			 * polling to detect this case and delay exit
+			 * notification until the last thread has
+			 * exited.
+			 */
+			pid = task_pid(tsk);
+			WRITE_ONCE(pid->delayed_leader, 1);
+		} else {
+			do_notify_pidfd(tsk);
+		}
+	}
 
 	if (unlikely(tsk->ptrace)) {
 		int sig = thread_group_leader(tsk) &&
diff --git a/kernel/pid.c b/kernel/pid.c
index 22f5d2b2e290..f112d7c8c986 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -386,6 +386,15 @@ void exchange_tids(struct task_struct *left, struct task_struct *right)
 	struct hlist_head *head1 = &pid1->tasks[PIDTYPE_PID];
 	struct hlist_head *head2 = &pid2->tasks[PIDTYPE_PID];
 
+	/*
+	 * If delayed leader marker is set then this was a malformed
+	 * thread-group exec. The thread-group leader had exited before
+	 * all of its subthreads and then one of the subthreads execed.
+	 * The struct pid continues it's existence so remove the
+	 * premature thread-group leader exit indicator.
+	 */
+	WRITE_ONCE(pid2->delayed_leader, 0);
+
 	/* Swap the single entry tid lists */
 	hlists_swap_heads_rcu(head1, head2);
 

-- 
2.47.2


