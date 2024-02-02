Return-Path: <linux-fsdevel+bounces-10074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2008478CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCEE1C25BD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0315B156610;
	Fri,  2 Feb 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku6zuzzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41F1565E2;
	Fri,  2 Feb 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899331; cv=none; b=ZpxDiZAVy2kYGtZYSXDhTGqCFFHSAIc31TGAtatrqYJ2+CO50X3Kuekd//R9x3CyLk+G/rHvwG8jzu7JNjAZR1JXHGOlrgvh06INfsgqTm2l/JEnLnbBe1o/SWIOY3ZJEtJKo9GFhR5mIKZANJpowGpQ9xz4fyQ+B2iVA6NDDiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899331; c=relaxed/simple;
	bh=uezgj+oNmphdSlN+YJCe2E3qwAs5jx2TqUTdE4zM3s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ0frfX3h0Z+N2KvBaEZTDwA10zBIqpMilxeTu/hEdmjG7VxRRdPSE4ZMaaCpltCVVO67sttutkcaevtd6nionkEHY4HiCygi4osO4kaJ0SKTOJMh+Bs+Gvu45gBiJkiRgUHN9VarVPHGd8RmSFiYZSFI6Y14ASi9t/oDkF8UaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku6zuzzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3D4C433C7;
	Fri,  2 Feb 2024 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899331;
	bh=uezgj+oNmphdSlN+YJCe2E3qwAs5jx2TqUTdE4zM3s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ku6zuzzNIbi9A/s02NLgUU8okONmdLEpNsH16M6BIfmh9bu1BXW1c9fhjfXM1MYlY
	 zLtwzefzC3fZimjrQSFuHwboIBrOoXBlI4ERudQqOMJI4TUuqLytJc+SaCrVLfIbAQ
	 z44kWVoDTl6HUrT+KJbCz8KodCpjO7KqPEQOPZ2njanUtNokkx/grgMAtATYh+2SVc
	 OpeGyYU+8QmkuRuTMtUfJmJPMqOmAzw/okghweZEM6nECVtwIyUZr46pwV6rxVj74m
	 uPSnMgOvbnRCkB1i1e+HRlkUOcM6vJwKzRYm0KZ2bB/nvuoOU4a0+PIuLknCW9+2A4
	 WslHLdHkIEJHg==
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
Subject: [PATCH AUTOSEL 5.10 7/8] exec: Distinguish in_execve from in_exec
Date: Fri,  2 Feb 2024 13:41:51 -0500
Message-ID: <20240202184156.541981-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184156.541981-1-sashal@kernel.org>
References: <20240202184156.541981-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 983295c0b8ac..b809f4a39296 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1565,6 +1565,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	}
 	rcu_read_unlock();
 
+	/* "users" and "in_exec" locked for copy_fs() */
 	if (p->fs->users > n_fs)
 		bprm->unsafe |= LSM_UNSAFE_SHARE;
 	else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index aa015416c569..65cfe85de8d5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -806,7 +806,7 @@ struct task_struct {
 	 */
 	unsigned			sched_remote_wakeup:1;
 
-	/* Bit to tell LSMs we're in execve(): */
+	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
 #ifndef TIF_RESTORE_SIGMASK
diff --git a/kernel/fork.c b/kernel/fork.c
index 633b0af1d1a7..906dbaf25058 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1452,6 +1452,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		spin_lock(&fs->lock);
+		/* "users" and "in_exec" locked for check_unsafe_exec() */
 		if (fs->in_exec) {
 			spin_unlock(&fs->lock);
 			return -EAGAIN;
-- 
2.43.0


