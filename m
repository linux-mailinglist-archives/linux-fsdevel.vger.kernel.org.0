Return-Path: <linux-fsdevel+bounces-10070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA7E847809
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364A8289345
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BE0151CD2;
	Fri,  2 Feb 2024 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jl+YNTKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172581738;
	Fri,  2 Feb 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899198; cv=none; b=fFRZQvhPye7yUGI+Ydm4IRWyd52i22N/vESJ3E/YvuzA5pk3ij0lu5+rG1JdDJl31GveaJYPSk7Osf7GUqvq9r/pnPwjT0n7K8/25c4MAKB30yQD17nrUC0PceX3QpX/dBJ3DXhQE68ZAQZ8Yrd/Y+EHMYwc9Vg9y7pU6M6e12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899198; c=relaxed/simple;
	bh=/GgaPwcxXLMGw96QHxTmcd+p19bQxwEOIwtu1eiz/68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAiAZe99ohnASUnPehI/5KAzlCgh30ToSvPRdIGQgKLZieFg62ZEiJekQj95jelXRh9/px//sp56mE0LQOtXP+UDT1MKQ8UBB5XCXoceiHK4BtXzSvvg28eewLqD2o8VSbKkMs6TjVKYGCpqJPNrao6HcKbeOvoDifhIuhbCeB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jl+YNTKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F2FC433F1;
	Fri,  2 Feb 2024 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899196;
	bh=/GgaPwcxXLMGw96QHxTmcd+p19bQxwEOIwtu1eiz/68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jl+YNTKRZO5Z+q5sSVrCvBMLinJwzJiFHevf5cc0E850wSV7g+8YJQDZQyUeUF+mE
	 66v1RL822OouIsrLjzuoqzw8bNc1yXUogCD+igc/h3yBOt8YMeJfcrRG9GHa63sYD3
	 XRGw5dMxqGwVmSesZthdsLiKHZcZnluV+fl4+VmvkVayQR0LdJjPGMJxrw9o+0NaJ0
	 2z4Sy9mhBDn/qWCVktFC3bWRAljG6V9F26iTRI2yE9E4wbQcW3acwzKyK6Qk2IRHPB
	 Hwa4u+UJBC677Us4mNUGr0Ok4VJMcyFeueoAcbelWSSpNNGBcg31n0n5m3znMryapY
	 96Og3VM/HUQfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	surenb@google.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	npiggin@gmail.com,
	zhangpeng.00@bytedance.com,
	hca@linux.ibm.com
Subject: [PATCH AUTOSEL 6.7 18/23] exec: Distinguish in_execve from in_exec
Date: Fri,  2 Feb 2024 13:39:14 -0500
Message-ID: <20240202183926.540467-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 90383cc07895183c75a0db2460301c2ffd912359 ]

Just to help distinguish the fs->in_exec flag from the current->in_execve
flag, add comments in check_unsafe_exec() and copy_fs() for more
context. Also note that in_execve is only used by TOMOYO now.

Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c             | 1 +
 include/linux/sched.h | 2 +-
 kernel/fork.c         | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4aa19b24f281..3842066d5b0b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1588,6 +1588,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	}
 	rcu_read_unlock();
 
+	/* "users" and "in_exec" locked for copy_fs() */
 	if (p->fs->users > n_fs)
 		bprm->unsafe |= LSM_UNSAFE_SHARE;
 	else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..de0e2752c5b2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -917,7 +917,7 @@ struct task_struct {
 	unsigned			sched_rt_mutex:1;
 #endif
 
-	/* Bit to tell LSMs we're in execve(): */
+	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
 #ifndef TIF_RESTORE_SIGMASK
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..0a08837e1443 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1754,6 +1754,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		spin_lock(&fs->lock);
+		/* "users" and "in_exec" locked for check_unsafe_exec() */
 		if (fs->in_exec) {
 			spin_unlock(&fs->lock);
 			return -EAGAIN;
-- 
2.43.0


