Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29A213428
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 21:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfECTwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 15:52:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfECTwD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 15:52:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 501A2AD36;
        Fri,  3 May 2019 19:52:01 +0000 (UTC)
Date:   Fri, 3 May 2019 12:51:48 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, e@80x24.org,
        omar.kilani@gmail.com, jbaron@akamai.com, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] signal: Adjust error codes according to
 restore_user_sigmask()
Message-ID: <20190503195148.t6hj4ly3axqosse3@linux-r8p5>
References: <20190503033440.cow6xm4p4hezgkxv@linux-r8p5>
 <20190503034205.12121-1-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190503034205.12121-1-deepa.kernel@gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch could also be routed via akpm, adding him.

On Thu, 02 May 2019, Deepa Dinamani wrote:

>For all the syscalls that receive a sigmask from the userland,
>the user sigmask is to be in effect through the syscall execution.
>At the end of syscall, sigmask of the current process is restored
>to what it was before the switch over to user sigmask.
>But, for this to be true in practice, the sigmask should be restored
>only at the the point we change the saved_sigmask. Anything before
>that loses signals. And, anything after is just pointless as the
>signal is already lost by restoring the sigmask.
>
>The issue was detected because of a regression caused by 854a6ed56839a.
>The patch moved the signal_pending() check closer to restoring of the
>user sigmask. But, it failed to update the error code accordingly.
>
>Detailed issue discussion permalink:
>https://lore.kernel.org/linux-fsdevel/20190427093319.sgicqik2oqkez3wk@dcvr/
>
>Note that the patch returns interrupted errors (EINTR, ERESTARTNOHAND,
>etc) only when there is no other error. If there is a signal and an error
>like EINVAL, the syscalls return -EINVAL rather than the interrupted
>error codes.

Thanks for doing this; I've reviewed the epoll bits (along with the overall
idea) and it seems like a sane alternative to reverting the offending patch.

Feel free to add:

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

A small nit, I think we should be a bit more verbose about the return semantics
of restore_user_sigmask()... see at the end.

>
>Reported-by: Eric Wong <e@80x24.org>
>Fixes: 854a6ed56839a40f6b5d02a2962f48841482eec4 ("signal: Add restore_user_sigmask()")
>Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

>---
>Sorry, I was trying a new setup at work. I should have tested it.
>My bad, I've checked this one.
>I've removed the questionable reported-by, since we're not sure if
>it is actually the same issue.
>
> fs/aio.c               | 24 ++++++++++++------------
> fs/eventpoll.c         | 14 ++++++++++----
> fs/io_uring.c          |  9 ++++++---
> fs/select.c            | 37 +++++++++++++++++++++----------------
> include/linux/signal.h |  2 +-
> kernel/signal.c        |  8 +++++---
> 6 files changed, 55 insertions(+), 39 deletions(-)
>
>diff --git a/fs/aio.c b/fs/aio.c
>index 38b741aef0bf..7de2f7573d55 100644
>--- a/fs/aio.c
>+++ b/fs/aio.c
>@@ -2133,7 +2133,7 @@ SYSCALL_DEFINE6(io_pgetevents,
> 	struct __aio_sigset	ksig = { NULL, };
> 	sigset_t		ksigmask, sigsaved;
> 	struct timespec64	ts;
>-	int ret;
>+	int ret, signal_detected;
>
> 	if (timeout && unlikely(get_timespec64(&ts, timeout)))
> 		return -EFAULT;
>@@ -2146,8 +2146,8 @@ SYSCALL_DEFINE6(io_pgetevents,
> 		return ret;
>
> 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
>-	restore_user_sigmask(ksig.sigmask, &sigsaved);
>-	if (signal_pending(current) && !ret)
>+	signal_detected = restore_user_sigmask(ksig.sigmask, &sigsaved);
>+	if (signal_detected && !ret)
> 		ret = -ERESTARTNOHAND;
>
> 	return ret;
>@@ -2166,7 +2166,7 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
> 	struct __aio_sigset	ksig = { NULL, };
> 	sigset_t		ksigmask, sigsaved;
> 	struct timespec64	ts;
>-	int ret;
>+	int ret, signal_detected;
>
> 	if (timeout && unlikely(get_old_timespec32(&ts, timeout)))
> 		return -EFAULT;
>@@ -2180,8 +2180,8 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
> 		return ret;
>
> 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
>-	restore_user_sigmask(ksig.sigmask, &sigsaved);
>-	if (signal_pending(current) && !ret)
>+	signal_detected = restore_user_sigmask(ksig.sigmask, &sigsaved);
>+	if (signal_detected && !ret)
> 		ret = -ERESTARTNOHAND;
>
> 	return ret;
>@@ -2231,7 +2231,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
> 	struct __compat_aio_sigset ksig = { NULL, };
> 	sigset_t ksigmask, sigsaved;
> 	struct timespec64 t;
>-	int ret;
>+	int ret, signal_detected;
>
> 	if (timeout && get_old_timespec32(&t, timeout))
> 		return -EFAULT;
>@@ -2244,8 +2244,8 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
> 		return ret;
>
> 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
>-	restore_user_sigmask(ksig.sigmask, &sigsaved);
>-	if (signal_pending(current) && !ret)
>+	signal_detected = restore_user_sigmask(ksig.sigmask, &sigsaved);
>+	if (signal_detected && !ret)
> 		ret = -ERESTARTNOHAND;
>
> 	return ret;
>@@ -2264,7 +2264,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
> 	struct __compat_aio_sigset ksig = { NULL, };
> 	sigset_t ksigmask, sigsaved;
> 	struct timespec64 t;
>-	int ret;
>+	int ret, signal_detected;
>
> 	if (timeout && get_timespec64(&t, timeout))
> 		return -EFAULT;
>@@ -2277,8 +2277,8 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
> 		return ret;
>
> 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
>-	restore_user_sigmask(ksig.sigmask, &sigsaved);
>-	if (signal_pending(current) && !ret)
>+	signal_detected = restore_user_sigmask(ksig.sigmask, &sigsaved);
>+	if (signal_detected && !ret)
> 		ret = -ERESTARTNOHAND;
>
> 	return ret;
>diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>index 4a0e98d87fcc..fe5a0724b417 100644
>--- a/fs/eventpoll.c
>+++ b/fs/eventpoll.c
>@@ -2317,7 +2317,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
> 		int, maxevents, int, timeout, const sigset_t __user *, sigmask,
> 		size_t, sigsetsize)
> {
>-	int error;
>+	int error, signal_detected;
> 	sigset_t ksigmask, sigsaved;
>
> 	/*
>@@ -2330,7 +2330,10 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
>
> 	error = do_epoll_wait(epfd, events, maxevents, timeout);
>
>-	restore_user_sigmask(sigmask, &sigsaved);
>+	signal_detected = restore_user_sigmask(sigmask, &sigsaved);
>+
>+	if (signal_detected && !error)
>+		error = -EINTR;
>
> 	return error;
> }
>@@ -2342,7 +2345,7 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
> 			const compat_sigset_t __user *, sigmask,
> 			compat_size_t, sigsetsize)
> {
>-	long err;
>+	long err, signal_detected;
> 	sigset_t ksigmask, sigsaved;
>
> 	/*
>@@ -2355,7 +2358,10 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
>
> 	err = do_epoll_wait(epfd, events, maxevents, timeout);
>
>-	restore_user_sigmask(sigmask, &sigsaved);
>+	signal_detected = restore_user_sigmask(sigmask, &sigsaved);
>+
>+	if (signal_detected && !err)
>+		err = -EINTR;
>
> 	return err;
> }
>diff --git a/fs/io_uring.c b/fs/io_uring.c
>index e2bd77da5e21..e107e299c3f3 100644
>--- a/fs/io_uring.c
>+++ b/fs/io_uring.c
>@@ -1965,7 +1965,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
> 	struct io_cq_ring *ring = ctx->cq_ring;
> 	sigset_t ksigmask, sigsaved;
> 	DEFINE_WAIT(wait);
>-	int ret;
>+	int ret, signal_detected;
>
> 	/* See comment at the top of this file */
> 	smp_rmb();
>@@ -1996,8 +1996,11 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>
> 	finish_wait(&ctx->wait, &wait);
>
>-	if (sig)
>-		restore_user_sigmask(sig, &sigsaved);
>+	if (sig) {
>+		signal_detected = restore_user_sigmask(sig, &sigsaved);
>+		if (signal_detected && !ret)
>+			ret  = -EINTR;
>+	}
>
> 	return READ_ONCE(ring->r.head) == READ_ONCE(ring->r.tail) ? ret : 0;
> }
>diff --git a/fs/select.c b/fs/select.c
>index 6cbc9ff56ba0..348dbe5e6dd0 100644
>--- a/fs/select.c
>+++ b/fs/select.c
>@@ -732,7 +732,7 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
> {
> 	sigset_t ksigmask, sigsaved;
> 	struct timespec64 ts, end_time, *to = NULL;
>-	int ret;
>+	int ret, signal_detected;
>
> 	if (tsp) {
> 		switch (type) {
>@@ -760,7 +760,9 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
> 	ret = core_sys_select(n, inp, outp, exp, to);
> 	ret = poll_select_copy_remaining(&end_time, tsp, type, ret);
>
>-	restore_user_sigmask(sigmask, &sigsaved);
>+	signal_detected = restore_user_sigmask(sigmask, &sigsaved);
>+	if (signal_detected && !ret)
>+		ret = -EINTR;
>
> 	return ret;
> }
>@@ -1089,7 +1091,7 @@ SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
> {
> 	sigset_t ksigmask, sigsaved;
> 	struct timespec64 ts, end_time, *to = NULL;
>-	int ret;
>+	int ret, signal_detected;
>
> 	if (tsp) {
> 		if (get_timespec64(&ts, tsp))
>@@ -1106,10 +1108,10 @@ SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
>
> 	ret = do_sys_poll(ufds, nfds, to);
>
>-	restore_user_sigmask(sigmask, &sigsaved);
>+	signal_detected = restore_user_sigmask(sigmask, &sigsaved);
>
> 	/* We can restart this syscall, usually */
>-	if (ret == -EINTR)
>+	if (ret == -EINTR || (signal_detected && !ret))
> 		ret = -ERESTARTNOHAND;
>
> 	ret = poll_select_copy_remaining(&end_time, tsp, PT_TIMESPEC, ret);
>@@ -1125,7 +1127,7 @@ SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds, unsigned int, nfds,
> {
> 	sigset_t ksigmask, sigsaved;
> 	struct timespec64 ts, end_time, *to = NULL;
>-	int ret;
>+	int ret, signal_detected;
>
> 	if (tsp) {
> 		if (get_old_timespec32(&ts, tsp))
>@@ -1142,10 +1144,10 @@ SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds, unsigned int, nfds,
>
> 	ret = do_sys_poll(ufds, nfds, to);
>
>-	restore_user_sigmask(sigmask, &sigsaved);
>+	signal_detected = restore_user_sigmask(sigmask, &sigsaved);
>
> 	/* We can restart this syscall, usually */
>-	if (ret == -EINTR)
>+	if (ret == -EINTR || (signal_detected && !ret))
> 		ret = -ERESTARTNOHAND;
>
> 	ret = poll_select_copy_remaining(&end_time, tsp, PT_OLD_TIMESPEC, ret);
>@@ -1324,7 +1326,7 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
> {
> 	sigset_t ksigmask, sigsaved;
> 	struct timespec64 ts, end_time, *to = NULL;
>-	int ret;
>+	int ret, signal_detected;
>
> 	if (tsp) {
> 		switch (type) {
>@@ -1352,7 +1354,10 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
> 	ret = compat_core_sys_select(n, inp, outp, exp, to);
> 	ret = poll_select_copy_remaining(&end_time, tsp, type, ret);
>
>-	restore_user_sigmask(sigmask, &sigsaved);
>+	signal_detected = restore_user_sigmask(sigmask, &sigsaved);
>+
>+	if (signal_detected && !ret)
>+		ret = -EINTR;
>
> 	return ret;
> }
>@@ -1408,7 +1413,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds,
> {
> 	sigset_t ksigmask, sigsaved;
> 	struct timespec64 ts, end_time, *to = NULL;
>-	int ret;
>+	int ret, signal_detected;
>
> 	if (tsp) {
> 		if (get_old_timespec32(&ts, tsp))
>@@ -1425,10 +1430,10 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds,
>
> 	ret = do_sys_poll(ufds, nfds, to);
>
>-	restore_user_sigmask(sigmask, &sigsaved);
>+	signal_detected = restore_user_sigmask(sigmask, &sigsaved);
>
> 	/* We can restart this syscall, usually */
>-	if (ret == -EINTR)
>+	if (ret == -EINTR || (signal_detected && !ret))
> 		ret = -ERESTARTNOHAND;
>
> 	ret = poll_select_copy_remaining(&end_time, tsp, PT_OLD_TIMESPEC, ret);
>@@ -1444,7 +1449,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time64, struct pollfd __user *, ufds,
> {
> 	sigset_t ksigmask, sigsaved;
> 	struct timespec64 ts, end_time, *to = NULL;
>-	int ret;
>+	int ret, signal_detected;
>
> 	if (tsp) {
> 		if (get_timespec64(&ts, tsp))
>@@ -1461,10 +1466,10 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time64, struct pollfd __user *, ufds,
>
> 	ret = do_sys_poll(ufds, nfds, to);
>
>-	restore_user_sigmask(sigmask, &sigsaved);
>+	signal_detected = restore_user_sigmask(sigmask, &sigsaved);
>
> 	/* We can restart this syscall, usually */
>-	if (ret == -EINTR)
>+	if (ret == -EINTR || (signal_detected && !ret))
> 		ret = -ERESTARTNOHAND;
>
> 	ret = poll_select_copy_remaining(&end_time, tsp, PT_TIMESPEC, ret);
>diff --git a/include/linux/signal.h b/include/linux/signal.h
>index 9702016734b1..1d36e8629edf 100644
>--- a/include/linux/signal.h
>+++ b/include/linux/signal.h
>@@ -275,7 +275,7 @@ extern int __group_send_sig_info(int, struct kernel_siginfo *, struct task_struc
> extern int sigprocmask(int, sigset_t *, sigset_t *);
> extern int set_user_sigmask(const sigset_t __user *usigmask, sigset_t *set,
> 	sigset_t *oldset, size_t sigsetsize);
>-extern void restore_user_sigmask(const void __user *usigmask,
>+extern int restore_user_sigmask(const void __user *usigmask,
> 				 sigset_t *sigsaved);
> extern void set_current_blocked(sigset_t *);
> extern void __set_current_blocked(const sigset_t *);
>diff --git a/kernel/signal.c b/kernel/signal.c
>index 3a9e41197d46..4f8b49a7b058 100644
>--- a/kernel/signal.c
>+++ b/kernel/signal.c
>@@ -2845,15 +2845,16 @@ EXPORT_SYMBOL(set_compat_user_sigmask);
>  * usigmask: sigmask passed in from userland.
>  * sigsaved: saved sigmask when the syscall started and changed the sigmask to
>  *           usigmask.
>+ * returns 1 in case a pending signal is detected.

How about:

"
Callers must carefully coordinate between signal_pending() checks between the
actual system call and restore_user_sigmask() - for which a new pending signal
may come in between calls and therefore must consider this for returning a proper
error code.

Returns 1 in case a signal pending is detected, otherwise 0.
"

>  *
>  * This is useful for syscalls such as ppoll, pselect, io_pgetevents and
>  * epoll_pwait where a new sigmask is passed in from userland for the syscalls.
>  */
>-void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
>+int restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
> {
>
> 	if (!usigmask)
>-		return;
>+		return 0;
> 	/*
> 	 * When signals are pending, do not restore them here.
> 	 * Restoring sigmask here can lead to delivering signals that the above
>@@ -2862,7 +2863,7 @@ void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
> 	if (signal_pending(current)) {
> 		current->saved_sigmask = *sigsaved;
> 		set_restore_sigmask();
>-		return;
>+		return 1;
> 	}
>
> 	/*
>@@ -2870,6 +2871,7 @@ void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
> 	 * saved_sigmask when signals are not pending.
> 	 */
> 	set_current_blocked(sigsaved);
>+	return 0;
> }
> EXPORT_SYMBOL(restore_user_sigmask);
>
>-- 
>2.21.0.593.g511ec345e18-goog
>
