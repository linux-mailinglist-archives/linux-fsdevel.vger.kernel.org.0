Return-Path: <linux-fsdevel+bounces-44641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BCBA6AEF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A618A247B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 20:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67669228CB8;
	Thu, 20 Mar 2025 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCQR0lzD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353F21CA00;
	Thu, 20 Mar 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501383; cv=none; b=M1pFyqXUpiVgOzxDM++WNuGwrMx4h1Hk4Me/5LesVpPg5zkAUNV2wrhE+kt8A5gw4LuDfTnOOEY9yf6VkJfXaIJ8j8nNRD6A2cdm34Zmu5rU3tMkVXCc6vuFZEwIBWcpqRBpFBtzT2tv0geFpF96RNWfiBy1Tb6/p2Q7H5kp684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501383; c=relaxed/simple;
	bh=IXvse+cPAOPI+1A/p8odtSxPd7pf1eSfCqgYQkxrS5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk5+ZZABOPCUd4vPx1gZc1S9kzwsYMkhls4MdPxFJY8LCpfpv333M2ucyaNxJR75ZA7xOAqWPd2bHVHDkWH4f4AhiAgrWLi6k80ijwm1qkw16OJRs1dXlFoJIYPVBFRGqrNaeW7sTMBXJV+ARGDkIGb+tAioSAXj6/c3jWV66/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCQR0lzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279A7C4CEDD;
	Thu, 20 Mar 2025 20:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742501382;
	bh=IXvse+cPAOPI+1A/p8odtSxPd7pf1eSfCqgYQkxrS5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCQR0lzDuAIiEy/tA38KqCCM+VStvYEx9jAE3vPLr3wopNeo4XTajhm4MYNcbPNmG
	 vvLLZFuo5tnuoMpQVOeosbZoPFFFy4Ic3wND4JXKvh0eQRbIgEs/xbStBon3JSQsqu
	 0MYcR+XA+Eu+8cQnaAimhpLHdQiWCGXJvEviJ7VwWwnt/FtvSpNOSIno+/rnoF/0AL
	 ThUX2y+6wE5sSETTDE1dZxvO43sF0Rn7U/0LHf9P8XM6kF1BC2k6M0pZtTJHGOBMVD
	 iwq0kR3sA3YpeGiKLkbEHKTmFQJaPSLR4A/pEctjO64+aZNtb52XUwT/UNMcBZqtJe
	 iWXpSFaiBgYCA==
Date: Thu, 20 Mar 2025 13:09:38 -0700
From: Kees Cook <kees@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, brauner@kernel.org
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <202503201225.92C5F5FB1@keescook>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>

Hey look another threaded exec bug. :|

On Thu, Mar 20, 2025 at 12:09:36PM -0700, syzbot wrote:
> ==================================================================
> BUG: KCSAN: data-race in bprm_execve / copy_fs
> 
> write to 0xffff8881044f8250 of 4 bytes by task 13692 on cpu 0:
>  bprm_execve+0x748/0x9c0 fs/exec.c:1884

This is:

        current->fs->in_exec = 0;

And is part of the execve failure path:

out:
	...
        if (bprm->point_of_no_return && !fatal_signal_pending(current))
                force_fatal_sig(SIGSEGV);

        sched_mm_cid_after_execve(current);
        current->fs->in_exec = 0;
        current->in_execve = 0;

        return retval;
}

>  do_execveat_common+0x769/0x7e0 fs/exec.c:1966
>  do_execveat fs/exec.c:2051 [inline]
>  __do_sys_execveat fs/exec.c:2125 [inline]
>  __se_sys_execveat fs/exec.c:2119 [inline]
>  __x64_sys_execveat+0x75/0x90 fs/exec.c:2119
>  x64_sys_call+0x291e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:323
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff8881044f8250 of 4 bytes by task 13686 on cpu 1:
>  copy_fs+0x95/0xf0 kernel/fork.c:1770

This is:

                if (fs->in_exec) {

Which is under lock:

        struct fs_struct *fs = current->fs;
        if (clone_flags & CLONE_FS) {
                /* tsk->fs is already what we want */
                spin_lock(&fs->lock);
                /* "users" and "in_exec" locked for check_unsafe_exec() * */
                if (fs->in_exec) {
                        spin_unlock(&fs->lock);
                        return -EAGAIN;
                }
                fs->users++;
                spin_unlock(&fs->lock);


Does execve need to be taking this lock? The other thing touching it is
check_unsafe_exec(), which takes the lock. It looks like the bprm_execve()
lock was removed in commit 8c652f96d385 ("do_execve() must not clear
fs->in_exec if it was set by another thread") which used the return
value from check_unsafe_exec():

    When do_execve() succeeds, it is safe to clear ->in_exec unconditionally.
    It can be set only if we don't share ->fs with another process, and since
    we already killed all sub-threads either ->in_exec == 0 or we are the
    only user of this ->fs.

    Also, we do not need fs->lock to clear fs->in_exec.

This logic was updated in commit 9e00cdb091b0 ("exec:check_unsafe_exec:
kill the dead -EAGAIN and clear_in_exec logic"), which includes this
rationale:

            2. "out_unmark:" in do_execve_common() is either called
               under ->cred_guard_mutex, or after de_thread() which
               kills other threads, so we can't race with sub-thread
               which could set ->in_exec. And if ->fs is shared with
               another process ->in_exec should be false anyway.

The de_thread() is part of the "point of no return" in exec_binprm(),
called via exec_binprm(). But the bprm_execve() error path is reachable
from many paths prior to the point of no return.

What I can imagine here is two failing execs racing a fork:

	A start execve
	B fork with CLONE_FS
	C start execve, reach check_unsafe_exec(), set fs->in_exec
	A bprm_execve() failure, clear fs->in_exec
	B copy_fs() increment fs->users.
	C bprm_execve() failure, clear fs->in_exec

But I don't think this is a "real" flaw, though, since the locking is to
protect a _successful_ execve from a fork (i.e. getting the user count
right). A successful execve will de_thread, and I don't see any wrong
counting of fs->users with regard to thread lifetime.

Did I miss something in the analysis? Should we perform locking anyway,
or add data race annotations, or something else?

-- 
Kees Cook

