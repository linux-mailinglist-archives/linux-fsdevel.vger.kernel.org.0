Return-Path: <linux-fsdevel+bounces-46251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC2A85ED5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5063AF656
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5161885A1;
	Fri, 11 Apr 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Isvuo1w7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A608165F1F;
	Fri, 11 Apr 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377775; cv=none; b=HlAuXMvX66MvXrJ7cDvWTrAyMfQVab5En6beqAQieTjDQsG6CchxWr6tSo0NGDX005aU2nWPe7l8xnzXcTF7nOcQLrkxcnx8W/T1cr355kMcfsQu/jOhCjCGZQbiOJ+oZL58ZtO6z43L1ipHjYRD2JjnPtWexq1Mg2SPRhWBlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377775; c=relaxed/simple;
	bh=TNr6/iH4wteP0Z259vZV/gG3UCIFnVzU36a5Lxqo/7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLgm+k9t2LSb6NPDVtblW69zV022Q23KK+EmE36h58+PJ40V77AuKbGKM0tkzpVPC9FRP1DoVEb3kT9ESzUG8ukY7BZb1wzK6zu88uWmhwYtLaEanjLq6GlrqvfcfChXJp4E5wt4ZbmkBfYbenYhhqnW9GPVLlu3OFI8UEdjRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Isvuo1w7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2305C4CEE5;
	Fri, 11 Apr 2025 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744377775;
	bh=TNr6/iH4wteP0Z259vZV/gG3UCIFnVzU36a5Lxqo/7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Isvuo1w7cSQJbBFglQ2Vrf4torVCMr4JL+RaIQDwStl1gBu8vTMW0uuxpRc1Ef78c
	 dOJIOwCQtKiyXbtBry7+uzZca8CsjvV8P+BFIkkYRbZmUdAhv/Mc+szN1n7FrPQ5DK
	 Ztio50jwbQ5dzam+fnxUCgcu5mZbvh4stVG+SLZ8QVlP4rN61Jqp/F5aHChphWoxoo
	 ++AINvi7Xcq+a1zRhr8z/XLWJFnAeWspqRLc/P9wa5llVIBFe7ZriG+MyPEQl3Z3yj
	 CUxxBQbIiyQrRu6TGpCQU8VQhGnVVqUleq4u60YN1lt4I7t+8GvYfvP5zof57HFDOj
	 +QHj7pA4zlsYA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 11 Apr 2025 15:22:44 +0200
Subject: [PATCH v2 1/2] exit: move wake_up_all() pidfd waiters into
 __unhash_process()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-work-pidfs-enoent-v2-1-60b2d3bb545f@kernel.org>
References: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
In-Reply-To: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 linux-kernel@vger.kernel.org, Peter Ziljstra <peterz@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TNr6/iH4wteP0Z259vZV/gG3UCIFnVzU36a5Lxqo/7w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/FF81teXThWl+xosavq6a4tSo+u+ltd0OTr8tc0o8r
 ULdQvuzOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSZMDwV7LBmXl97sln0t94
 fbm2mtac2sqyMfm2+b3ly+9O6IsUf8DI8HmmYLq64fSzS5m2TNRkcr5w+LlrksEk9aLolcJqrmu
 kWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move the pidfd notification out of __change_pid() and into
__unhash_process(). The only valid call to __change_pid() with a NULL
argument and PIDTYPE_PID is from __unhash_process(). This is a lot more
obvious than calling it from __change_pid().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/exit.c | 5 +++++
 kernel/pid.c  | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 1b51dc099f1e..abcd93ce4e18 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -133,8 +133,13 @@ struct release_task_post {
 static void __unhash_process(struct release_task_post *post, struct task_struct *p,
 			     bool group_dead)
 {
+	struct pid *pid = task_pid(p);
+
 	nr_threads--;
+
 	detach_pid(post->pids, p, PIDTYPE_PID);
+	wake_up_all(&pid->wait_pidfd);
+
 	if (group_dead) {
 		detach_pid(post->pids, p, PIDTYPE_TGID);
 		detach_pid(post->pids, p, PIDTYPE_PGID);
diff --git a/kernel/pid.c b/kernel/pid.c
index 4ac2ce46817f..26f1e136f017 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -359,11 +359,6 @@ static void __change_pid(struct pid **pids, struct task_struct *task,
 	hlist_del_rcu(&task->pid_links[type]);
 	*pid_ptr = new;
 
-	if (type == PIDTYPE_PID) {
-		WARN_ON_ONCE(pid_has_task(pid, PIDTYPE_PID));
-		wake_up_all(&pid->wait_pidfd);
-	}
-
 	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
 		if (pid_has_task(pid, tmp))
 			return;

-- 
2.47.2


