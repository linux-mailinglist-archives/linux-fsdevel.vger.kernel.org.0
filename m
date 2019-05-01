Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95DA3103D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 04:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfEACOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 22:14:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40332 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbfEACOH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 22:14:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 212941F453;
        Wed,  1 May 2019 02:14:06 +0000 (UTC)
Date:   Wed, 1 May 2019 02:14:05 +0000
From:   Eric Wong <e@80x24.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Kilani <omar.kilani@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Strange issues with epoll since 5.0
Message-ID: <20190501021405.hfvd7ps623liu25i@dcvr>
References: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
 <20190424193903.swlfmfuo6cqnpkwa@dcvr>
 <20190427093319.sgicqik2oqkez3wk@dcvr>
 <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
 <20190428004858.el3yk6hljloeoxza@dcvr>
 <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
 <20190429210427.dmfemfft2t2gdwko@dcvr>
 <CABeXuvqpAjk8ocRUabVU4Yviv7kgRkMneLE1Xy-jAtHdXAHBVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABeXuvqpAjk8ocRUabVU4Yviv7kgRkMneLE1Xy-jAtHdXAHBVw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> I was also not able to reproduce this.
> Arnd and I were talking about this today morning. Here is something
> Arnd noticed:
> 
> If there was a signal after do_epoll_wait(), we never were not
> entering the if (err = -EINTR) at all before.

I'm not sure which `if' statement you're talking about, but ok...

> But, now we do.
> We could try with the below patch:

Wasn't close to applying or being buildable, but I put a
working version together (below).

epoll_pwait wakes up as expected, now :>

> If this works that means we know what is busted.

OK, good to know...

> I'm not sure what the hang in the userspace is about. Is it because
> the syscall did not return an error or the particular signal was
> blocked etc.

Uh, ok; that's less comforting.

> There are also a few timing differences also. But, can we try this first?

Anyways, the following patch works and builds cleanly for me
(didn't test AIO, but everything else seems good)

Thanks!

---------8<-------
Subject: [PATCH] test fix from Deepa

TBD
---
 fs/aio.c               |  8 ++++----
 fs/eventpoll.c         |  4 ++--
 fs/select.c            | 12 ++++++------
 include/linux/signal.h |  2 +-
 kernel/signal.c        |  6 ++++--
 5 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3d9669d011b9..d54513ca11b6 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2146,7 +2146,7 @@ SYSCALL_DEFINE6(io_pgetevents,
 		return ret;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
-	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	restore_user_sigmask(ksig.sigmask, &sigsaved, -1);
 	if (signal_pending(current) && !ret)
 		ret = -ERESTARTNOHAND;
 
@@ -2180,7 +2180,7 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
 		return ret;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
-	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	restore_user_sigmask(ksig.sigmask, &sigsaved, -1);
 	if (signal_pending(current) && !ret)
 		ret = -ERESTARTNOHAND;
 
@@ -2244,7 +2244,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 		return ret;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
-	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	restore_user_sigmask(ksig.sigmask, &sigsaved, -1);
 	if (signal_pending(current) && !ret)
 		ret = -ERESTARTNOHAND;
 
@@ -2277,7 +2277,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
 		return ret;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
-	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	restore_user_sigmask(ksig.sigmask, &sigsaved, -1);
 	if (signal_pending(current) && !ret)
 		ret = -ERESTARTNOHAND;
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a5d219d920e7..bd84ec54a8fb 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2247,7 +2247,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 
 	error = do_epoll_wait(epfd, events, maxevents, timeout);
 
-	restore_user_sigmask(sigmask, &sigsaved);
+	restore_user_sigmask(sigmask, &sigsaved, error == -EINTR);
 
 	return error;
 }
@@ -2272,7 +2272,7 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 
 	err = do_epoll_wait(epfd, events, maxevents, timeout);
 
-	restore_user_sigmask(sigmask, &sigsaved);
+	restore_user_sigmask(sigmask, &sigsaved, err == -EINTR);
 
 	return err;
 }
diff --git a/fs/select.c b/fs/select.c
index d0f35dbc0e8f..04720e5856ed 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -760,7 +760,7 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
 	ret = core_sys_select(n, inp, outp, exp, to);
 	ret = poll_select_copy_remaining(&end_time, tsp, type, ret);
 
-	restore_user_sigmask(sigmask, &sigsaved);
+	restore_user_sigmask(sigmask, &sigsaved, -1);
 
 	return ret;
 }
@@ -1106,7 +1106,7 @@ SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
 
 	ret = do_sys_poll(ufds, nfds, to);
 
-	restore_user_sigmask(sigmask, &sigsaved);
+	restore_user_sigmask(sigmask, &sigsaved, -1);
 
 	/* We can restart this syscall, usually */
 	if (ret == -EINTR)
@@ -1142,7 +1142,7 @@ SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds, unsigned int, nfds,
 
 	ret = do_sys_poll(ufds, nfds, to);
 
-	restore_user_sigmask(sigmask, &sigsaved);
+	restore_user_sigmask(sigmask, &sigsaved, -1);
 
 	/* We can restart this syscall, usually */
 	if (ret == -EINTR)
@@ -1352,7 +1352,7 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 	ret = compat_core_sys_select(n, inp, outp, exp, to);
 	ret = poll_select_copy_remaining(&end_time, tsp, type, ret);
 
-	restore_user_sigmask(sigmask, &sigsaved);
+	restore_user_sigmask(sigmask, &sigsaved, -1);
 
 	return ret;
 }
@@ -1425,7 +1425,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
 
 	ret = do_sys_poll(ufds, nfds, to);
 
-	restore_user_sigmask(sigmask, &sigsaved);
+	restore_user_sigmask(sigmask, &sigsaved, -1);
 
 	/* We can restart this syscall, usually */
 	if (ret == -EINTR)
@@ -1461,7 +1461,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time64, struct pollfd __user *, ufds,
 
 	ret = do_sys_poll(ufds, nfds, to);
 
-	restore_user_sigmask(sigmask, &sigsaved);
+	restore_user_sigmask(sigmask, &sigsaved, -1);
 
 	/* We can restart this syscall, usually */
 	if (ret == -EINTR)
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 9702016734b1..b55804ae2021 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -276,7 +276,7 @@ extern int sigprocmask(int, sigset_t *, sigset_t *);
 extern int set_user_sigmask(const sigset_t __user *usigmask, sigset_t *set,
 	sigset_t *oldset, size_t sigsetsize);
 extern void restore_user_sigmask(const void __user *usigmask,
-				 sigset_t *sigsaved);
+				 sigset_t *sigsaved, int sig_pending);
 extern void set_current_blocked(sigset_t *);
 extern void __set_current_blocked(const sigset_t *);
 extern int show_unhandled_signals;
diff --git a/kernel/signal.c b/kernel/signal.c
index 57b7771e20d7..cc827e6c4bea 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2843,11 +2843,13 @@ EXPORT_SYMBOL(set_compat_user_sigmask);
  * usigmask: sigmask passed in from userland.
  * sigsaved: saved sigmask when the syscall started and changed the sigmask to
  *           usigmask.
+ * sig_pending: "> 0" if a signal is pending, "< 0" to check signal_pending
  *
  * This is useful for syscalls such as ppoll, pselect, io_pgetevents and
  * epoll_pwait where a new sigmask is passed in from userland for the syscalls.
  */
-void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
+void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved,
+			  int sig_pending)
 {
 
 	if (!usigmask)
@@ -2857,7 +2859,7 @@ void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
 	 * Restoring sigmask here can lead to delivering signals that the above
 	 * syscalls are intended to block because of the sigmask passed in.
 	 */
-	if (signal_pending(current)) {
+	if (sig_pending > 0 || (sig_pending < 0 && signal_pending(current))) {
 		current->saved_sigmask = *sigsaved;
 		set_restore_sigmask();
 		return;
-- 
