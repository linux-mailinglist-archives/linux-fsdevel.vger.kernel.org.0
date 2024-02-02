Return-Path: <linux-fsdevel+bounces-10073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A154A8478AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C5D287758
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37803150474;
	Fri,  2 Feb 2024 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbRoRFWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4115044D;
	Fri,  2 Feb 2024 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899307; cv=none; b=d+WKtPyBjgGknQxV+czJULqh99u0ewFUDzj86iKtJvzdOfFNWba/lmcr2+lCo3ganiAciThtuyh11W5e26SCFZd3phf4+F63275Qo8kmib312XyFE026tTa9denNZeTYkudUx6tlyNpCU90Bz3j3BRyx3u3HhD/6QOeNw0lUihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899307; c=relaxed/simple;
	bh=axD4Mij+aQBMobeLf678/tZTD/zRKamci0mbWK48h3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1hP1mdtGbmcNIKn9+eoyFa9ZmyPHD8kdk+A7X48YYValZE5vzY7K/vw9s+iYhAK3/ySsh+gjhnknUQHY9hx/8k8DIc3NlmyWQt4kaWGQ1BxewN+wSMUUUvKwkW8gZWWTw4hSjKtgQww9Dpc2KVZ32BhQCNF/P/6iBIAtlQoEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbRoRFWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CF7C43394;
	Fri,  2 Feb 2024 18:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899307;
	bh=axD4Mij+aQBMobeLf678/tZTD/zRKamci0mbWK48h3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbRoRFWPo/BKEpW+Fn3ubkYtTEMqYcQFeUxz7ki1i7/3apA61C0GZ9mG5lrpruHN1
	 aginZPLgH4YbSFx0BSb6HxrQVgF+h8ZBY9+LX63+EfB35C8TaQzZ/PIYTLXz5Ifn8S
	 Utx3u8Kbe++XxH/wab6LfX0hEiEuyPFEPTwj3NDtLtkH43kREtmh7SG09+TU1wMgnZ
	 TT8ovHrgHztDg8WBddQuiuvbhr/kSbGYg6HKv4L9pWWsk+dc3cW3Hd9sgBSzjF4JPX
	 +UjXyGn83Dz452jCqakKVOVDdZDn8Ep2hfBjYtF4iEvfSTQhbeGkkLTYuI9rgBda/1
	 BC8/fh0PR/hQg==
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
Subject: [PATCH AUTOSEL 5.15 08/11] exec: Distinguish in_execve from in_exec
Date: Fri,  2 Feb 2024 13:41:22 -0500
Message-ID: <20240202184130.541736-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184130.541736-1-sashal@kernel.org>
References: <20240202184130.541736-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 881390b44cfd..5895f74b252b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1584,6 +1584,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	}
 	rcu_read_unlock();
 
+	/* "users" and "in_exec" locked for copy_fs() */
 	if (p->fs->users > n_fs)
 		bprm->unsafe |= LSM_UNSAFE_SHARE;
 	else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7bfc2b45cd99..4b88f57130aa 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -902,7 +902,7 @@ struct task_struct {
 	 */
 	unsigned			sched_remote_wakeup:1;
 
-	/* Bit to tell LSMs we're in execve(): */
+	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
 #ifndef TIF_RESTORE_SIGMASK
diff --git a/kernel/fork.c b/kernel/fork.c
index 753e641f617b..b9f61c26c1d0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1530,6 +1530,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		spin_lock(&fs->lock);
+		/* "users" and "in_exec" locked for check_unsafe_exec() */
 		if (fs->in_exec) {
 			spin_unlock(&fs->lock);
 			return -EAGAIN;
-- 
2.43.0


