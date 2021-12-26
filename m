Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F2547F75E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Dec 2021 16:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhLZPDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 10:03:23 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50044 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232090AbhLZPDW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 10:03:22 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 1BQF3Arx021457;
        Sun, 26 Dec 2021 16:03:10 +0100
Date:   Sun, 26 Dec 2021 16:03:10 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries
 irrespective of invoking users
Message-ID: <20211226150310.GA992@1wt.eu>
References: <20211221021744.864115-1-longman@redhat.com>
 <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
 <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com>
 <87czlp7tdu.fsf@email.froward.int.ebiederm.org>
 <e78085e4-74cd-52e1-bc0e-4709fac4458a@redhat.com>
 <CAHk-=wg+qpNvqcROndhRidOE1i7bQm93xM=jmre98-X4qkVkMw@mail.gmail.com>
 <7f0f8e71-cf62-4c0b-5f13-a41919c6cd9b@redhat.com>
 <20211221205635.GB30289@1wt.eu>
 <20211221221336.GC30289@1wt.eu>
 <87o8594jlq.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <87o8594jlq.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Eric,

I've experimented a bit with this and am not completely convinced we're
on the right track.

First, resetting the not-dumpable status on setuid()/setsid() and friends
means that sudo itself resets it, and as such that the executable that it
launches may very well crash on CPU limits for example, thus allowing a
sudoer to produce a root core in a random directory. That's the current
state of affairs after the first attached patch.

This made me think that since we want to protect the called program and
not sudo itself, we ought to verify that the called program performs the
action itself. I.e. only programs that are marked as dumpable may reset
their not-dumpable status on various actions. That's what the second patch
does.

Doing this worked a lot better and initially made me think it solved the
issue: a user becoming root via sudo could regularly dump cores, but
crashes during startup would not work. That was until I tested with
"sudo ping" and saw root cores again, because ping, like many setuid
enabled programs, takes care of its permissions via setuid(0).

So this makes me think that trying to infer a program's intents via
snooping a few syscalls isn't going very far. Earlier in this
conversation there were a few other proposals around just playing with
RLIMIT_CORE and PR_SET_DUMPABLE.

I tend to think that if we combine the principle above (only monitor
dumpable programs) with the only two actions that *really* act on the
ability to produce a core (rlimit and prctl) then it might actually
reasonably work, because then a program could explicitly want to enable
core dumps and be allowed to do that. That's what the last patch does
and I couldn't find a case where it doesn't work. I.e. switching from
a user to root via sudo allows me to dump a core from a shell as the
shell sets RLIMIT_CORE, but will not let a program such as "ping" dump
a core by default for example. I've put that in the last patch which
replaces the first two ones.

I'm still wondering if adding a 4th value to suid_dumpable wouldn't
solve all of this: the value would automatically change when setting
RLIMIT_CORE. It could just be a bit more confusing to configure.

Other (orthogonal) approaches could consist in forcefully resetting a
few limits on suidexec. At least memory limits and CPU limits could be
reset to default (unlimited) values since there doesn't seem to be any
valid reason for an unprivileged process to change them for a privileged
one. And the core dump limits could be set to zero for the same reason.
It could be decided that we'd never dump a core on user-addressable
signals (SIGQUIT, maybe others?) and that could be even cleaner than
the currently discussed solutions.

Please let me know what you think.

Thanks,
Willy

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-WIP-only-remove-non-dumpable-in-the-non-suid-program.patch"

From 8ca54b3a0bba56dbfce8ccf96ba36a1d6c189e85 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sun, 26 Dec 2021 15:17:08 +0100
Subject: WIP: only remove non-dumpable in the non-suid program

this way sudo doesn't drop its own not-dumpable flag before executing.
---
 fs/coredump.c                  |  2 ++
 include/linux/sched/coredump.h |  4 ++--
 kernel/sys.c                   | 15 ++++++++++-----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 3224dee44d30..5f0bfe2c00a6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -609,6 +609,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		goto fail;
 	if (!__get_dumpable(cprm.mm_flags))
 		goto fail;
+	if (cprm.mm_flags & MMF_NOT_DUMPABLE_MASK)
+		goto fail;
 
 	cred = prepare_creds();
 	if (!cred)
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 302f31247c90..662508d139e1 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -80,8 +80,8 @@ extern void set_dumpable(struct mm_struct *mm, int value);
  */
 static inline int __get_dumpable(unsigned long mm_flags)
 {
-	if (mm_flags & MMF_NOT_DUMPABLE_MASK)
-		return SUID_DUMP_DISABLE;
+	//if (mm_flags & MMF_NOT_DUMPABLE_MASK)
+	//	return SUID_DUMP_DISABLE;
 	return mm_flags & MMF_DUMPABLE_MASK;
 }
 
diff --git a/kernel/sys.c b/kernel/sys.c
index f4405e004145..0ecdb4cc64e7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -564,7 +564,8 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 		goto error;
 
 	/* attempt to change ID drops the not-dumpable protection */
-	clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
+	if (get_dumpable(current->mm))
+		clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
 
 	return commit_creds(new);
 
@@ -629,7 +630,8 @@ long __sys_setuid(uid_t uid)
 		goto error;
 
 	/* attempt to change ID drops the not-dumpable protection */
-	clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
+	if (get_dumpable(current->mm))
+		clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
 
 	return commit_creds(new);
 
@@ -711,7 +713,8 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 		goto error;
 
 	/* attempt to change ID drops the not-dumpable protection */
-	clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
+	if (get_dumpable(current->mm))
+		clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
 
 	return commit_creds(new);
 
@@ -1225,7 +1228,8 @@ int ksys_setsid(void)
 	write_unlock_irq(&tasklist_lock);
 	if (err > 0) {
 		/* session leaders reset the not-dumpable protection */
-		clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
+		if (get_dumpable(current->mm))
+			clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
 
 		proc_sid_connector(group_leader);
 		sched_autogroup_create_attach(group_leader);
@@ -1627,7 +1631,8 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 	 * If an application wants to change its own core dump settings, it
 	 * wants to decide on its dumpability so we reset MMF_NOT_DUMPABLE.
 	 */
-	if (!retval && new_rlim && resource == RLIMIT_CORE && tsk == current)
+	if (!retval && new_rlim && resource == RLIMIT_CORE && tsk == current &&
+	    get_dumpable(tsk->mm))
 		clear_bit(MMF_NOT_DUMPABLE, &tsk->mm->flags);
 out:
 	read_unlock(&tasklist_lock);
-- 
2.17.5


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-WIP-only-change-not_dumpable-via-prctl-and-setrlimit.patch"

From da2953f7d61c59674f7e8d37fc7df0889ac18ad7 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sun, 26 Dec 2021 15:36:50 +0100
Subject: WIP: only change not_dumpable via prctl() and setrlimit()

This way a simple setuid() will not cause it. It seems to do the
trick.
---
 kernel/sys.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 0ecdb4cc64e7..eb0bf9d6dd97 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -563,9 +563,9 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 	if (retval < 0)
 		goto error;
 
-	/* attempt to change ID drops the not-dumpable protection */
-	if (get_dumpable(current->mm))
-		clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
+	///* attempt to change ID drops the not-dumpable protection */
+	//if (get_dumpable(current->mm))
+	//	clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
 
 	return commit_creds(new);
 
@@ -629,9 +629,9 @@ long __sys_setuid(uid_t uid)
 	if (retval < 0)
 		goto error;
 
-	/* attempt to change ID drops the not-dumpable protection */
-	if (get_dumpable(current->mm))
-		clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
+	///* attempt to change ID drops the not-dumpable protection */
+	//if (get_dumpable(current->mm))
+	//	clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
 
 	return commit_creds(new);
 
@@ -712,9 +712,9 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 	if (retval < 0)
 		goto error;
 
-	/* attempt to change ID drops the not-dumpable protection */
-	if (get_dumpable(current->mm))
-		clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
+	///* attempt to change ID drops the not-dumpable protection */
+	//if (get_dumpable(current->mm))
+	//	clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
 
 	return commit_creds(new);
 
@@ -1227,9 +1227,9 @@ int ksys_setsid(void)
 out:
 	write_unlock_irq(&tasklist_lock);
 	if (err > 0) {
-		/* session leaders reset the not-dumpable protection */
-		if (get_dumpable(current->mm))
-			clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
+		///* session leaders reset the not-dumpable protection */
+		//if (get_dumpable(current->mm))
+		//	clear_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
 
 		proc_sid_connector(group_leader);
 		sched_autogroup_create_attach(group_leader);
-- 
2.17.5


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0003-coredump-disable-core-dumps-when-transitionning-via-.patch"

From e11ef55c696d65f1dc3c5f151f9f62fe3b3b62cf Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sun, 26 Dec 2021 12:41:15 +0100
Subject: coredump: disable core dumps when transitionning via a suidexec

This adds an MMF_NOT_DUMPABLE flag to mm->flags that is set when
transitionning via a suidexec program, and is only reset when the target
program changes the RLIMIT_CORE values or changes its dumpable state
using prctl(PR_SET_DUMPABLE).

This allows programs like su/sudo to start a program without this
program risking to dump a core, but it also lets such programs
explicitly disable this protection by simply changing their core
limits.
---
 fs/coredump.c                  |  2 ++
 fs/exec.c                      |  4 +++-
 include/linux/sched/coredump.h |  4 +++-
 kernel/sys.c                   | 12 ++++++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 3224dee44d30..5f0bfe2c00a6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -609,6 +609,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		goto fail;
 	if (!__get_dumpable(cprm.mm_flags))
 		goto fail;
+	if (cprm.mm_flags & MMF_NOT_DUMPABLE_MASK)
+		goto fail;
 
 	cred = prepare_creds();
 	if (!cred)
diff --git a/fs/exec.c b/fs/exec.c
index ac7b51b51f38..42f74b6f0ca0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1348,8 +1348,10 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
 	    !(uid_eq(current_euid(), current_uid()) &&
-	      gid_eq(current_egid(), current_gid())))
+	      gid_eq(current_egid(), current_gid()))) {
+		set_bit(MMF_NOT_DUMPABLE, &current->mm->flags);
 		set_dumpable(current->mm, suid_dumpable);
+	}
 	else
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 4d9e3a656875..e307f70c5b95 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -81,9 +81,11 @@ static inline int get_dumpable(struct mm_struct *mm)
  * lifecycle of this mm, just for simplicity.
  */
 #define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
+#define MMF_NOT_DUMPABLE	29	/* dump disabled by suidexec */
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
+#define MMF_NOT_DUMPABLE_MASK	(1 << MMF_NOT_DUMPABLE)
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK)
+				 MMF_DISABLE_THP_MASK | MMF_NOT_DUMPABLE_MASK)
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 8fdac0d90504..c5bb0247bde4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1610,6 +1610,17 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 	     new_rlim->rlim_cur != RLIM_INFINITY &&
 	     IS_ENABLED(CONFIG_POSIX_TIMERS))
 		update_rlimit_cpu(tsk, new_rlim->rlim_cur);
+
+	/*
+	 * If an application wants to change its own core dump settings, it
+	 * wants to decide on its dumpability so we reset MMF_NOT_DUMPABLE.
+	 * We only do that for applications that were previously dumpable,
+	 * so that suid programs such as su/sudo setting the target process'
+	 * limits do no disable the protection by accident.
+	 */
+	if (!retval && new_rlim && resource == RLIMIT_CORE && tsk == current &&
+	    get_dumpable(tsk->mm))
+		clear_bit(MMF_NOT_DUMPABLE, &tsk->mm->flags);
 out:
 	read_unlock(&tasklist_lock);
 	return retval;
@@ -2293,6 +2304,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			break;
 		}
 		set_dumpable(me->mm, arg2);
+		clear_bit(MMF_NOT_DUMPABLE, &me->mm->flags);
 		break;
 
 	case PR_SET_UNALIGN:
-- 
2.17.5


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dumpable.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/prctl.h>
#include <sys/resource.h>

// ./dumpable  => returns current dumpable
// ./dumpable [0|1|2] <cmd> [args...]  => executes cmd under dumpable state
//                                        and with RLIMIT_CPU=0
int main(int argc, char **argv, char **envp)
{
	struct rlimit lim;

	if (argc < 2) {
		printf("dumpable=%d\n", prctl(PR_GET_DUMPABLE, 0, 0, 0, 0));
		return 0;
	}

	prctl(PR_SET_DUMPABLE, atoi(argv[1]), 0, 0, 0);

	lim.rlim_cur = RLIM_INFINITY;
	lim.rlim_max = RLIM_INFINITY;
	setrlimit(RLIMIT_CORE, &lim);

	lim.rlim_cur = 0;
	lim.rlim_max = RLIM_INFINITY;
	setrlimit(RLIMIT_CPU, &lim);

	return execve(argv[2], argv + 2, envp);
}

--qMm9M+Fa2AknHoGS--
