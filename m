Return-Path: <linux-fsdevel+bounces-43345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43BEA549E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F2D3B4A77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E378320AF71;
	Thu,  6 Mar 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZehCEko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8720F066
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261291; cv=none; b=P30ZIjH3faORTUmWBO+5ADzrKd/0oaqP8ev++YfXaNskc4zD/4xrWRA2WO/yY0Z4aLpQ9EukYo3QVigP3wfD0s6BNTW9CFeG2KKSuJoYkpCzCuA/Ubml0Yr3bOBGL35QISHck3x9U6e6oNOSdZiBeSSMxDWHngVsgxeR1blV4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261291; c=relaxed/simple;
	bh=3yKKVrsqzuaFgFZH8A7Xj9mBAHLg2AHkJR+xzYZ5iJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BAhMCQBk20q0vvnlr93KqmkrGP4nE4xlLwMsCNAIswCJXBnUdE7+xd1FJ69q9jwvTRv4ZwG7NjW1gj1qHxxJjJ/maTGPoGd7IpQWCdv+LtA9UFm/tdEdwoaZOAfHLIwE/tq5AXsdqymq1iELkVdZA8WgWssS1h/Y+zEH5t5Z2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZehCEko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD4EC4CEE0;
	Thu,  6 Mar 2025 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741261290;
	bh=3yKKVrsqzuaFgFZH8A7Xj9mBAHLg2AHkJR+xzYZ5iJA=;
	h=Date:From:To:Cc:Subject:From;
	b=ZZehCEko5KSOgA8mU1foySGSNEpwocj6uJ0ira6T5Qj1dFz705qNFLWeMha33w65G
	 gsPORD94J7qwhQOAqjlwjk0/jKM92MYzc5ajE+Dv8S6XDgO6v/ePX0LfwmcYiu4SVU
	 pZQS+8keENRc+HFUIHnKUXXkzevh8HqNga2fzK9CiXuKp3Exip3fJqjDXGje7Jg+nO
	 IXsd36NZ5uYi2Xl7yal/DKTlMqAhEwfGhx8ZOf+QGgQVcsbDLQiDZIgL4QBni1kHXc
	 Caa6cxYHp0cFgzdutkjHN+WCM8ZkyiOI5gAnxL7gJmauc6qhMKBS4HoRizEPh6j2+5
	 10ZoeSBzgLc+A==
Date: Thu, 6 Mar 2025 12:41:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: PIDFD_THREAD behavior for thread-group leaders
Message-ID: <nhoaiykqnoid3df3ckmqqgycbjqtd2rutrpeat25j4bbm7tbjl@tpncnt7cp26n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Oleg,

I've been thinking about the multi-threaded exec case where a
non-thread-group leader task execs and assumes the thread-group leaders
struct pid.

Back when we implemented support for PIDFD_THREAD we ended up with the
decision that if userspace holds:

pidfd_leader_thread = pidfd_open(<thread-group-leader-pid>, PIDFD_THREAD)

that exit notification is not strictly defined if a non-thread-group
leader thread execs: If poll is called before the exec happened, then an
exit notification may be observed and if aftewards no exit notification
is generated for the old thread-group leader. Of if exit for the old
thread-group leader was observed but poll is called again then it would
block again.

I was wondering why the following snippet wouldn't work to ensure that
PIDFD_THREAD pidfds for thread-group leaders wouldn't be woken with
spurious exits:

diff --git a/kernel/exit.c b/kernel/exit.c
index 9916305e34d3..b79ded1b3bf5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -745,8 +745,11 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
        /*
         * sub-thread or delay_group_leader(), wake up the
         * PIDFD_THREAD waiters.
+        *
+        * The thread-group leader will be taken over by the execing
+        * task so don't cause spurious wakeups.
         */
-       if (!thread_group_empty(tsk))
+       if (!thread_group_empty(tsk) && (tsk->signal->notify_count >= 0))
                do_notify_pidfd(tsk);

        if (unlikely(tsk->ptrace)) {

Because that would seem more consistent to me. The downside would be
that if userspace performed a series of multi-threaded exec for
non-thread-group leader threads then waiters wouldn't get woken. But I
think that's probably ok.

To handle this case we could later think about whether we can instead
start generating a separate poll (POLLPRI?) event when exec happens.

I'm probably missing something very obvious why that won't work.

Christian

