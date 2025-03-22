Return-Path: <linux-fsdevel+bounces-44759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF599A6C7C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 07:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8961B60550
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 06:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E618C006;
	Sat, 22 Mar 2025 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtYFib+Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AE13C816;
	Sat, 22 Mar 2025 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742624766; cv=none; b=tFp+PJpLZfkEcnW7EsxAtya4Lz2xHgE4Xr7+t7LqQ4FRaxduaJo1AXH3XmZt2UoAxLPc1A+elXB0OB7deP5mvtZEHUHuLDO6hXI8lppzNQvWQH72XwFKrGERHHZsRJKLEu5Skt4aJnXAajT2mFr5LRt9qwmTZQ79v8gQhBVMbNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742624766; c=relaxed/simple;
	bh=f2Dru0mOp1GeU7ZUiZtTDdgdJ+Abue+hSj07w9O/LT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbyiG0v/C4V33QPudlotnEPk/upw7USchMfdEz11oWXkwQYAmYugbiA9aF/Mynl6rxQA+Zh86hg85jOns2LOKgsdnLYod1JkJeuv6DLsEIIFk4KcVx2uDPgSW1MwEbF3bQrQwfrRzz8PVYcsVzIDAGMwz7bdm+4He/KrIjcx50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtYFib+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD14C4CEDD;
	Sat, 22 Mar 2025 06:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742624766;
	bh=f2Dru0mOp1GeU7ZUiZtTDdgdJ+Abue+hSj07w9O/LT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtYFib+Q3DoREtr2IJNNacGcq8XdyyIPv3ygvWEamXjhiMnaR6w04f8o2ZHJC9v/r
	 uIBmKS7CZQAZCuPJg73/vaNO1Wx005GyVa7KHJZ/Zkv+/lMdvSDiL+QvOEIcg+Ib9p
	 kEmICSBUowT0M4TxBdIPswgMJLgJ0I9X5XchezrAtxkEFM1jTfWSkR4aK7Mf2HLyEm
	 gPTQuCY9no07QXktpCazE+TrMGW7ZSSTOHD3Ir6UB3mAgbtWEgBui2+UhGE1RnuklS
	 VEGEWdR3OgSUkzRUgyiJfwK7bNZGCgBxCmWawrazP2dUWpXqWZY7YxKR8V76SnTSP+
	 acdtDH6GJTTmA==
Date: Fri, 21 Mar 2025 23:26:03 -0700
From: Kees Cook <kees@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <202503212313.1E55652@keescook>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321-abdecken-infomaterial-2f373f8e3b3c@brauner>
 <20250322010008.GG2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322010008.GG2023217@ZenIV>

On Sat, Mar 22, 2025 at 01:00:08AM +0000, Al Viro wrote:
> On Fri, Mar 21, 2025 at 09:45:39AM +0100, Christian Brauner wrote:
> 
> > Afaict, the only way this data race can happen is if we jump to the
> > cleanup label and then reset current->fs->in_exec. If the execve was
> > successful there's no one to race us with CLONE_FS obviously because we
> > took down all other threads.
> 
> Not really.

Yeah, you found it. Thank you!

> 1) A enters check_unsafe_execve(), sets ->in_exec to 1
> 2) B enters check_unsafe_execve(), sets ->in_exec to 1

With 3 threads A, B, and C already running, fs->users == 3, so steps (1)
and (2) happily pass.

> 3) A calls exec_binprm(), fails (bad binary)
> 4) A clears ->in_exec
> 5) C calls clone(2) with CLONE_FS and spawns D - ->in_exec is 0

D's creation bumps fs->users == 4.

> 6) B gets through exec_binprm(), kills A and C, but not D.
> 7) B clears ->in_exec, returns
> 
> Result: B and D share ->fs, B runs suid binary.
> 
> Had (5) happened prior to (2), (2) wouldn't have set ->in_exec;
> had (5) happened prior to (4), clone() would've failed; had
> (5) been delayed past (6), there wouldn't have been a thread
> to call clone().
> 
> But in the window between (4) and (6), clone() doesn't see
> execve() in progress and check_unsafe_execve() has already
> been done, so it hadn't seen the extra thread.
> 
> IOW, it really is racy.  It's a counter, not a flag.

Yeah, I would agree. Totally untested patch:

diff --git a/fs/exec.c b/fs/exec.c
index 506cd411f4ac..988b8621c079 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1632,7 +1632,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	if (p->fs->users > n_fs)
 		bprm->unsafe |= LSM_UNSAFE_SHARE;
 	else
-		p->fs->in_exec = 1;
+		refcount_inc(&p->fs->in_exec);
 	spin_unlock(&p->fs->lock);
 }
 
@@ -1862,7 +1862,7 @@ static int bprm_execve(struct linux_binprm *bprm)
 
 	sched_mm_cid_after_execve(current);
 	/* execve succeeded */
-	current->fs->in_exec = 0;
+	refcount_dec(&current->fs->in_exec);
 	current->in_execve = 0;
 	rseq_execve(current);
 	user_events_execve(current);
@@ -1881,7 +1881,7 @@ static int bprm_execve(struct linux_binprm *bprm)
 		force_fatal_sig(SIGSEGV);
 
 	sched_mm_cid_after_execve(current);
-	current->fs->in_exec = 0;
+	refcount_dec(&current->fs->in_exec);
 	current->in_execve = 0;
 
 	return retval;
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 64c2d0814ed6..df46b873c425 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -115,7 +115,7 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 	/* We don't need to lock fs - think why ;-) */
 	if (fs) {
 		fs->users = 1;
-		fs->in_exec = 0;
+		fs->in_exec = REFCOUNT_INIT(0);
 		spin_lock_init(&fs->lock);
 		seqcount_spinlock_init(&fs->seq, &fs->lock);
 		fs->umask = old->umask;
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 783b48dedb72..aebc0b7aedb9 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -11,7 +11,7 @@ struct fs_struct {
 	spinlock_t lock;
 	seqcount_spinlock_t seq;
 	int umask;
-	int in_exec;
+	refcount_t in_exec;
 	struct path root, pwd;
 } __randomize_layout;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a9c5f3..8b427045fd86 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1767,7 +1767,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 		/* tsk->fs is already what we want */
 		spin_lock(&fs->lock);
 		/* "users" and "in_exec" locked for check_unsafe_exec() */
-		if (fs->in_exec) {
+		if (refcount_read(&fs->in_exec)) {
 			spin_unlock(&fs->lock);
 			return -EAGAIN;
 		}

-- 
Kees Cook

