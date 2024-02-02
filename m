Return-Path: <linux-fsdevel+bounces-10072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE28B847884
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A052930C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145F154C18;
	Fri,  2 Feb 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMDYbyVZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEC813CE96;
	Fri,  2 Feb 2024 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899280; cv=none; b=T61eJTS8WqwvZ3vLyHKYmwQg+mGDBI8MjCmIRma4oIai2a8ZX9ZGMN3BIz04Dlz5SGaoydp56PmbnysTD1Hi3S8Lkk6uiPyM/p70jsP6WzmsK90ZMSEpWoRL+JaGOwyjD5Itd6NUP+xsfnKEj1/VdxQFtPFLQyV+1t5+RYip0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899280; c=relaxed/simple;
	bh=+83wejdaZn0XRoPCrFUad4bSGSW8W3jB8XnpkDDvpqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dga/FOmc1uF1tLsAYwZ+g9LyJfb9KkL1OC+hd9Klf0f11THqS+32GY5KogVbXLj0FiW9Ih4uTpJErc8M0jkM8u8SBFpDji+avXkpMDpa7qWgC94UNJpFqh9ZbduUgOtX6oqZ0WGetrNAaPdzy+6zcpPQvECOoi+2SDjlQ3htneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMDYbyVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FC5C43394;
	Fri,  2 Feb 2024 18:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899280;
	bh=+83wejdaZn0XRoPCrFUad4bSGSW8W3jB8XnpkDDvpqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMDYbyVZ78vS+3O92S77GJfV/uPE8mFTXSDQJMPr8Z843pXFbuppcqvax31pC0/Ux
	 LVvPVKQ6ZEGhCHp/D3reSPHs15ugbOFDA02Avl3gFr41cuJqDxfQqfFIaGoD3HQ5ki
	 bSn0VutIXHprtopFqhLxUQzim7parctdbTQakDD70ruSjZJ35zxkbsp/HPDKFE4bZm
	 sEUoDxcmkjdgJkGqG1n3BL/91d8j6+yMLjPmaNwFfwxHg3gaFKK9ol59iIFDbJvnmk
	 xB574uVTgy1rquIPW1ahpi6iLvSvUawgWZ3sVfDhBeNhlzp8qHWP902bSwIlIigxSn
	 6P0NQPQYgL3Ng==
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
	michael.christie@oracle.com,
	mst@redhat.com,
	mjguzik@gmail.com,
	npiggin@gmail.com,
	zhangpeng.00@bytedance.com,
	hca@linux.ibm.com
Subject: [PATCH AUTOSEL 6.1 12/15] exec: Distinguish in_execve from in_exec
Date: Fri,  2 Feb 2024 13:40:49 -0500
Message-ID: <20240202184057.541411-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
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
index 283012eb1aeb..541ae913e683 100644
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
index 0cac69902ec5..4f955709a4ae 100644
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
index 85617928041c..354c644b6deb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1602,6 +1602,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		spin_lock(&fs->lock);
+		/* "users" and "in_exec" locked for check_unsafe_exec() */
 		if (fs->in_exec) {
 			spin_unlock(&fs->lock);
 			return -EAGAIN;
-- 
2.43.0


