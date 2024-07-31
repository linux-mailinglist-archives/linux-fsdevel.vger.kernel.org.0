Return-Path: <linux-fsdevel+bounces-24671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D439942B6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 12:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0B8280998
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 10:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A41AAE16;
	Wed, 31 Jul 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e89ZDnvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395B4D8AD;
	Wed, 31 Jul 2024 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420109; cv=none; b=iZGEGembbiTlogBvwxNToczmv5ecg7NymJlyWxg9/7qoe+jqZ7pYboBCq0rhWI0vL5VoVZvBnGtkjYSXMnJ75mIpZW0pt/w0mGx2IIMYs+m34wOspkitot5HCz28kfqghmkbyrTfeGc/1/vx+gsTzK+uQpD5m3Tv7qnnhiXiBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420109; c=relaxed/simple;
	bh=vCDDYkxaDrqr+HkDaZXcGreYiRRijdDkP/Gr8VjNeeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qu6OaBsl005Xqhcj2WNGW06bTHkVirwR8uv2WZKTBeIP/RAfOxeCCYfjJKquVc3T+Bn0B48VUPd6yPAQ4Nc1zmer/KGwFR1XdZNIk0r2gqKx6oZe8TJ4xgQA3Apmg8tKoKCm6selnNEufT1JnBIcmwD1QMJQS4pZI5My0bUlDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e89ZDnvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4DCC116B1;
	Wed, 31 Jul 2024 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722420108;
	bh=vCDDYkxaDrqr+HkDaZXcGreYiRRijdDkP/Gr8VjNeeg=;
	h=From:To:Cc:Subject:Date:From;
	b=e89ZDnvX8mX2eWxUEsrad9Zibb8KAXSdsJ1CSBeigWhthC1cCmGZCQyFLQ//PFc0O
	 dNEeRDAl5gP3Aaob8q0e8qLs5vTk77qyWc7j5GfIqGC0EfC95X3Vghk2blnzrvPTeN
	 NAk/0ANi+MQfMLxbipZGugEugCo3okvIzsjGIwiKZy39bv0jsAVcCnv5Fl6y6FGqd2
	 SpwXcM9tjAB+DFdO811r2ix8RsG5u3qx3BrmJ2JXxEEhETI/q5JnOHTswTWO//tglT
	 rKK/TOItJD1I1aSyff5Tft1nehbd78XK2HU17B8s0fT+tqYAkfF1Ix3dRVKdDNEl70
	 RhNlZ6+QQZDLw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] pidfd: prevent creation of pidfds for kthreads
Date: Wed, 31 Jul 2024 12:01:12 +0200
Message-ID: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=brauner@kernel.org; h=from:subject:message-id; bh=vCDDYkxaDrqr+HkDaZXcGreYiRRijdDkP/Gr8VjNeeg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSt4s487b8qcdHeyilJl8pFWSs9n0zQL9n5+Oyy+HgZe 8FOvedGHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRZGFkOP/0do+V0dvyxbEP TzUomFQc3P3741nhSzr1/QVLu5ZkxDEyrO12SL3uwC45Y19X3x6dnzvfcHZmf/hezJCtpL6rxPM VAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

It's currently possible to create pidfds for kthreads but it is unclear
what that is supposed to mean. Until we have use-cases for it and we
figured out what behavior we want block the creation of pidfds for
kthreads.

Fixes: 32fcb426ec00 ("pid: add pidfd_open()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/fork.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..18bdc87209d0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2053,11 +2053,24 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	bool thread = flags & PIDFD_THREAD;
-
-	if (!pid || !pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID))
+	if (!pid)
 		return -EINVAL;
 
+	scoped_guard(rcu) {
+		struct task_struct *tsk;
+
+		if (flags & PIDFD_THREAD)
+			tsk = pid_task(pid, PIDTYPE_PID);
+		else
+			tsk = pid_task(pid, PIDTYPE_TGID);
+		if (!tsk)
+			return -EINVAL;
+
+		/* Don't create pidfds for kernel threads for now. */
+		if (tsk->flags & PF_KTHREAD)
+			return -EINVAL;
+	}
+
 	return __pidfd_prepare(pid, flags, ret);
 }
 
@@ -2403,6 +2416,12 @@ __latent_entropy struct task_struct *copy_process(
 	if (clone_flags & CLONE_PIDFD) {
 		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
 
+		/* Don't create pidfds for kernel threads for now. */
+		if (args->kthread) {
+			retval = -EINVAL;
+			goto bad_fork_free_pid;
+		}
+
 		/* Note that no task has been attached to @pid yet. */
 		retval = __pidfd_prepare(pid, flags, &pidfile);
 		if (retval < 0)
-- 
2.43.0


