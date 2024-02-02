Return-Path: <linux-fsdevel+bounces-10071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFFB84784E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD971F2F850
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129B135DDB;
	Fri,  2 Feb 2024 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKgOLoAH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4765135DCF;
	Fri,  2 Feb 2024 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899244; cv=none; b=XHnKoU+yZgsHXHEzscVhVNkrkFp0gQpMwUxGRRse5GTeqQeina73OlVhKsH8/H7mMlOrHjFuWoYHhkkUFTARvj21nA5RNweDL0M4y4kwBZIkadGVmTtdACljxqOrJzlfvQwXCuR7qRgvJONjXa3DwwMt1GjXLFzzALIiK/0OCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899244; c=relaxed/simple;
	bh=iNFafJR22TQxMVXHVTQvbaJRTbsIbHqq8o288GxB84Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFM54kv54lNr8zdr67xZGGtZO4UmpWUbVp4yTeEO9KhB2r/Hy//aO0unaqf2xY0xLfeORYZxNVGfmTz5sLxqp58rIjvzASSYFK9zefsziWUDdXHjasmbEruJXzXkf6W9KdkMglT41TfvYbWBNWCYdPHoU8q5y2gGQoFkV/02YF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKgOLoAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFDBC433C7;
	Fri,  2 Feb 2024 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899244;
	bh=iNFafJR22TQxMVXHVTQvbaJRTbsIbHqq8o288GxB84Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKgOLoAHbUswOO+oBlvPqWUDOTPBZIWXrsfC64mNykMsXma+4CU/a5cZO44/3Er+d
	 spWRmbBUyHzuULNcmczBZ2SGziF6C/3DbEMvHh5fLfn0znJ3W77iixhaXhPI6aSQeA
	 VY6tUwBgo+68KxywmjdtV443bOHdf4b6uPxfQLXbWrbpDBaoGybpcB00L5SDDEPwIK
	 02QkSzRmfrSHJiU9TYOhpPSnoypTqQKAu1+aE2sy8/NGEiO+xntME1kFHaMwEqR4Ed
	 +MkaUhx/agLiuVSzhCxsFUZmVH4oZszDIMxlbABiYcZOS1kL/vw2LdvxBu3GMMH9dK
	 UVf+r2Y52ZxnQ==
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
Subject: [PATCH AUTOSEL 6.6 17/21] exec: Distinguish in_execve from in_exec
Date: Fri,  2 Feb 2024 13:40:04 -0500
Message-ID: <20240202184015.540966-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
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
index 6518e33ea813..3bd1784b92c5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1590,6 +1590,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	}
 	rcu_read_unlock();
 
+	/* "users" and "in_exec" locked for copy_fs() */
 	if (p->fs->users > n_fs)
 		bprm->unsafe |= LSM_UNSAFE_SHARE;
 	else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..9fb7851384f9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -912,7 +912,7 @@ struct task_struct {
 	 */
 	unsigned			sched_remote_wakeup:1;
 
-	/* Bit to tell LSMs we're in execve(): */
+	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
 #ifndef TIF_RESTORE_SIGMASK
diff --git a/kernel/fork.c b/kernel/fork.c
index 177ce7438db6..97dd79386c62 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1749,6 +1749,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		spin_lock(&fs->lock);
+		/* "users" and "in_exec" locked for check_unsafe_exec() */
 		if (fs->in_exec) {
 			spin_unlock(&fs->lock);
 			return -EAGAIN;
-- 
2.43.0


