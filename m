Return-Path: <linux-fsdevel+bounces-44528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E138A6A29A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA91188748B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E080B2222CA;
	Thu, 20 Mar 2025 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN128tVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502DB1C1F2F
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462960; cv=none; b=RDndxMmaRR7if6auCSGKgPfueFNyxYB03J3NpUsD3nxd7auSoAXMSTFUTTwaYkxDWqumb1irZkb13Q12fjXOX/OelwuUrA6Aad3n5eCeABjd8xAtIHDbph5QUxlITfTLQCmN91w16Kv3fXjvOK4IFHPiRyYIv+Ok6J5QkeFbMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462960; c=relaxed/simple;
	bh=r50E0l5C8uDz15M+6YCpeInJcjFSrcv03N1iDigSQRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogNUyt+Z4dgNScZF9LxyUBio8SkFhmKvr/pGj+NgGJfDOZisvmQLa6yIzL9pTV3mNsfeeT1Q/ZE9LPwdhYKoygDtCPRYLxP6HtxkZLsR+2TyS9mssYYij50j8vRrJjhBqSkGDratYdXS6o+n560ijs1NWUk7Xp26ZkXmcDeThmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN128tVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC558C4CEDD;
	Thu, 20 Mar 2025 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742462959;
	bh=r50E0l5C8uDz15M+6YCpeInJcjFSrcv03N1iDigSQRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LN128tVLtp9Rqd8iQfoig6PMPq44VmmnENApEgmP008G3Q3/48opLnPaDwg8EZ+/D
	 49PCY4Zs4zwxx9s2NB2/Aup2NZQK0d3aNr2cB5DeP795fq4uY54mRYnvcGTszYVC8M
	 hWmKHzBKWJglSSYnlI1VRzyLPrFzsiIaqchbtXpHGIF/MpvyEHQ8b4K4VsrGPK/J3r
	 MlGSlLF1sgEJ77KNyK36+IJjx8kQZ8RtW3qrBPJi037YGNZBENTh/79MReM3HudCS8
	 K8h8pq3h/P2h7t2vr+z9Vr7gjkhjaqTiul8ZNrXROAYbOzVyhK4lwmqi2c2wCjH4F3
	 yvuRcP60UY1XA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Mar 2025 10:29:06 +0100
Subject: [PATCH v3 1/4] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-work-pidfs-thread_group-v3-1-b7e5f7e2c3b1@kernel.org>
References: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
In-Reply-To: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=5992; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r50E0l5C8uDz15M+6YCpeInJcjFSrcv03N1iDigSQRc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfvv/ywQcex+W/dr9Nbfb+fueW+NWX1WW/vpitO8a6l
 2/ir/9lbh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT8TrI8D/Ny2iD70Nrvq/t
 +7/U161aV/d+ad/W1W/e7tebUs5nqFvA8M9e8bj1+sh9fNLaU289to26yPU7fklVsJP9bO9U56P
 37nIAAA==
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
This tiny series tries to address this problem by discarding
PIDFD_THREAD notification on premature thread-group leader exit.

If that works correctly then no exit notifications are generated for a
PIDFD_THREAD pidfd for a thread-group leader until all subthreads have
been reaped. If a subthread should exec aftewards no exit notification
will be generated until that task exits or it creates subthreads and
repeates the cycle.

Co-Developed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c      | 22 +++++++++++++++++++++-
 kernel/exit.c   | 12 +++++++++---
 kernel/signal.c |  6 ++++--
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index a48cc44ced6f..f1c49a7540f3 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -218,12 +218,32 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	/*
 	 * Depending on PIDFD_THREAD, inform pollers when the thread
 	 * or the whole thread-group exits.
+	 *
+	 * There are two corner cases to consider:
+	 *
+	 * (1) If a thread-group leader of a thread-group with
+	 *     subthreads exits prematurely, i.e., before all of the
+	 *     subthreads of the thread-group have exited then no
+	 *     notification will be generated for PIDFD_THREAD pidfds
+	 *     referring to the thread-group leader.
+	 *
+	 *     The exit notification for the thread-group leader will be
+	 *     delayed until the last subthread of the thread-group
+	 *     exits.
+	 *
+	 * (2) If a subthread of a thread-group execs then the
+	 *     current thread-group leader will be SIGKILLed and the
+	 *     subthread will assume the struct pid of the now defunct
+	 *     old thread-group leader. No exit notification will be
+	 *     generated for PIDFD_THREAD pidfds referring to the old
+	 *     thread-group leader as they continue referring to the new
+	 *     thread-group leader.
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
index 9916305e34d3..ce5cdad5ba9c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -271,6 +271,9 @@ void release_task(struct task_struct *p)
 		 * If we were the last child thread and the leader has
 		 * exited already, and the leader's parent ignores SIGCHLD,
 		 * then we are the one who should release the leader.
+		 *
+		 * This will also wake PIDFD_THREAD pidfds for the
+		 * thread-group leader that already exited.
 		 */
 		zap_leader = do_notify_parent(leader, leader->exit_signal);
 		if (zap_leader)
@@ -743,10 +746,13 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 
 	tsk->exit_state = EXIT_ZOMBIE;
 	/*
-	 * sub-thread or delay_group_leader(), wake up the
-	 * PIDFD_THREAD waiters.
+	 * Wake up PIDFD_THREAD waiters if this is a proper subthread
+	 * exit. If this is a premature thread-group leader exit delay
+	 * the notification until the last subthread exits. If a
+	 * subthread should exec before then no notification will be
+	 * generated.
 	 */
-	if (!thread_group_empty(tsk))
+	if (!delay_group_leader(tsk))
 		do_notify_pidfd(tsk);
 
 	if (unlikely(tsk->ptrace)) {
diff --git a/kernel/signal.c b/kernel/signal.c
index 081f19a24506..0ccef8783dff 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2180,8 +2180,10 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	WARN_ON_ONCE(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 	/*
-	 * tsk is a group leader and has no threads, wake up the
-	 * non-PIDFD_THREAD waiters.
+	 * This is a thread-group leader without subthreads so wake up
+	 * the non-PIDFD_THREAD waiters. This also wakes the
+	 * PIDFD_THREAD waiters for the thread-group leader in case it
+	 * exited prematurely from release_task().
 	 */
 	if (thread_group_empty(tsk))
 		do_notify_pidfd(tsk);

-- 
2.47.2


