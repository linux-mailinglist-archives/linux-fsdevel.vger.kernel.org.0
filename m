Return-Path: <linux-fsdevel+bounces-48140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA4AAA010
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 00:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CAC16C876
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 22:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E335328DEFE;
	Mon,  5 May 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX07YPAt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782A27A932;
	Mon,  5 May 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483401; cv=none; b=eFhVH9RfA/uR/ehydrTXjLA3l8r7WrdhKgD7370Fml3WXoshJ0UxRF/fklmAa6GUuadK08dAOJW0PNiz0xe4ie2oBvX69Db8sf7dNma7au+dEd/LDnfRA6jCvm5s6Ndzau5XohXdTEYLHCWBMHZEATlEVqcHG4fQHprt5B1dVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483401; c=relaxed/simple;
	bh=/fRhfQDcAa8JTF6epwyuiyDsSdv8eh6R+2Cbd+/YmjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6KGnc+pEwtjsXpFkhVfuZOga5XEsDLDzu4iEoOrjd2kQ/cRKFARZWnMRWNRT/LgTJjJHIxJlAPB4EV+I0sBNe5/t7LeYREeAaNcHdLafUHw2mzLRop60OpDIGyMp6zvkPpgEQKtA2BrbTHz1ZScEor2BaqPWwW1VLWUjAoorug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX07YPAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6514CC4CEE4;
	Mon,  5 May 2025 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483401;
	bh=/fRhfQDcAa8JTF6epwyuiyDsSdv8eh6R+2Cbd+/YmjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bX07YPAttgcH88uHmxzc+9XkpSJzjkv47BTMo0/oUCSiQxttKAsioQkchXqj8QZ0Y
	 30SDmd+lLW6fY5L7HXipZGze5nVvycsYjBRQ7Aw+wl07adr6TKRpjPIHIJqjO82d/Y
	 HCfbyV1LuPGB8yOxaiUfNyzG+ZwanerOv/HPesT3lXRZIqvl19BiS7YJcCizhwnUaY
	 bB8sWLCBdP5Ur+QfWqz9GDigh8lGc+B35fH1boGXc4SeM3YA2ySZCBO2JawDDSjZQG
	 jDO8+eOBZkn04FX/mf2Kedgjsbm1oDPspl7MU928HnWrqYTLhCQ2ZYsHTQTLXgCT22
	 J6PSNz5XkFQkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	Liam.Howlett@Oracle.com,
	mjguzik@gmail.com,
	alexjlzheng@tencent.com,
	pasha.tatashin@soleen.com,
	tglx@linutronix.de,
	frederic@kernel.org,
	peterz@infradead.org,
	lorenzo.stoakes@oracle.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 067/642] pidfs: improve multi-threaded exec and premature thread-group leader exit polling
Date: Mon,  5 May 2025 18:04:43 -0400
Message-Id: <20250505221419.2672473-67-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0fb482728ba1ee2130eaa461bf551f014447997c ]

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
This tiny series tries to address this problem by discarding
PIDFD_THREAD notification on premature thread-group leader exit.

If that works correctly then no exit notifications are generated for a
PIDFD_THREAD pidfd for a thread-group leader until all subthreads have
been reaped. If a subthread should exec aftewards no exit notification
will be generated until that task exits or it creates subthreads and
repeates the cycle.

Co-Developed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250320-work-pidfs-thread_group-v4-1-da678ce805bf@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pidfs.c      | 9 +++++----
 kernel/exit.c   | 6 +++---
 kernel/signal.c | 3 +--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c0478b3c55d9f..9aa4c705776dd 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -188,20 +188,21 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 {
 	struct pid *pid = pidfd_pid(file);
-	bool thread = file->f_flags & PIDFD_THREAD;
 	struct task_struct *task;
 	__poll_t poll_flags = 0;
 
 	poll_wait(file, &pid->wait_pidfd, pts);
 	/*
-	 * Depending on PIDFD_THREAD, inform pollers when the thread
-	 * or the whole thread-group exits.
+	 * Don't wake waiters if the thread-group leader exited
+	 * prematurely. They either get notified when the last subthread
+	 * exits or not at all if one of the remaining subthreads execs
+	 * and assumes the struct pid of the old thread-group leader.
 	 */
 	guard(rcu)();
 	task = pid_task(pid, PIDTYPE_PID);
 	if (!task)
 		poll_flags = EPOLLIN | EPOLLRDNORM | EPOLLHUP;
-	else if (task->exit_state && (thread || thread_group_empty(task)))
+	else if (task->exit_state && !delay_group_leader(task))
 		poll_flags = EPOLLIN | EPOLLRDNORM;
 
 	return poll_flags;
diff --git a/kernel/exit.c b/kernel/exit.c
index 6bb59b16e33e1..a9960dd6d0aa0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -744,10 +744,10 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 
 	tsk->exit_state = EXIT_ZOMBIE;
 	/*
-	 * sub-thread or delay_group_leader(), wake up the
-	 * PIDFD_THREAD waiters.
+	 * Ignore thread-group leaders that exited before all
+	 * subthreads did.
 	 */
-	if (!thread_group_empty(tsk))
+	if (!delay_group_leader(tsk))
 		do_notify_pidfd(tsk);
 
 	if (unlikely(tsk->ptrace)) {
diff --git a/kernel/signal.c b/kernel/signal.c
index 875e97f6205a2..b2e5c90f29602 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2180,8 +2180,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	WARN_ON_ONCE(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 	/*
-	 * tsk is a group leader and has no threads, wake up the
-	 * non-PIDFD_THREAD waiters.
+	 * Notify for thread-group leaders without subthreads.
 	 */
 	if (thread_group_empty(tsk))
 		do_notify_pidfd(tsk);
-- 
2.39.5


