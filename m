Return-Path: <linux-fsdevel+bounces-44574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD26A6A713
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452E017C715
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92880221574;
	Thu, 20 Mar 2025 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIXwluCc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B81DFE00
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477059; cv=none; b=adbqF1jVP+9VgCiYM9IxZ/MRc8jq6J+jnFgxLDhp1dLgtf9DuiujrfQ9iHAMRX+NrzBr73FpD5PNO15bslG3kWw4fUSUKYm/fnXqA8vzCd1ulvKDKKPFxKvNRFnjgbqvdy5q1VEFm5Sev/VAf0yesx3JYOonnui/QiTLtj3hWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477059; c=relaxed/simple;
	bh=BtOaVjDpk1fZqkfhmjGWg+YUBdmOSa3NNOtmB7NQCiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9WRu7osQEKjkkMyp65iTKZ8u754E+bY5CQMN3HGLsA9DJKSlZOYda2CeQER7IsB95qBlFXvnmceY40nUv/s3Whz+h8CRT+IcwV88tpnMuT7MW+rAT6eTRUckawVvgriHLRJqACl46ajs85OxcAjhVhJvHmvassFhDlEpr7iK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIXwluCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD32C4CEE3;
	Thu, 20 Mar 2025 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742477058;
	bh=BtOaVjDpk1fZqkfhmjGWg+YUBdmOSa3NNOtmB7NQCiY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SIXwluCcD57pydf5ZoqGOjdCxgCHs65MBijEaPoSfwwl8GvkSsJy/Y7m7EJKbkRAb
	 rA+Bwdt5sdkqY/RAw3HRJNwoMZC6asWIIxEIl2l10xrov3OXddAzCQXuBZV/nuaQPZ
	 OKAz141f/C5hqN3c9uOTl8YWSV/iz49/4bYjtR+zsxDUkCIg50ptE51KzOv8O5vDsf
	 anqvSq7FDcF4OY2FXuDZJ5ne1H7gAKDiXR/KIzcXaxm1xxNCPFDt5QXgKAtJct02Eh
	 Z/4qrNzvGXgxox8KC3pYAa6/n6ZRJprhuVT5kym0GW++LV3NGuFjkuFIPsgZWMt7UB
	 /AxKdGfIQeh7g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Mar 2025 14:24:08 +0100
Subject: [PATCH v4 1/4] pidfs: improve multi-threaded exec and premature
 thread-group leader exit polling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-work-pidfs-thread_group-v4-1-da678ce805bf@kernel.org>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
In-Reply-To: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4740; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BtOaVjDpk1fZqkfhmjGWg+YUBdmOSa3NNOtmB7NQCiY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfEfu3Q+KNZMKDK8I/4k26lOv9b6/5vk6701l520aeF
 dK8xZP7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaieYGRYYrf48bva+cvspyo
 VjFF8+DdaWLh3GJs4je+nj6Ve1lPW43hn+HbJTNjMi8t/mLXY88zT1HYw7+y4v5NBQX96bki+29
 9YgcA
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
 fs/pidfs.c      | 9 +++++----
 kernel/exit.c   | 6 +++---
 kernel/signal.c | 3 +--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index a48cc44ced6f..1b3d23e0ffdd 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -210,20 +210,21 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
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
index 9916305e34d3..683766316a3d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -743,10 +743,10 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 
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
index 081f19a24506..027ad9e97417 100644
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
2.47.2


