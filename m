Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83447C91C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 23:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhLUWNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 17:13:48 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49890 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230085AbhLUWNq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:13:46 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 1BLMDaAP031294;
        Tue, 21 Dec 2021 23:13:36 +0100
Date:   Tue, 21 Dec 2021 23:13:36 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries
 irrespective of invoking users
Message-ID: <20211221221336.GC30289@1wt.eu>
References: <20211221021744.864115-1-longman@redhat.com>
 <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
 <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com>
 <87czlp7tdu.fsf@email.froward.int.ebiederm.org>
 <e78085e4-74cd-52e1-bc0e-4709fac4458a@redhat.com>
 <CAHk-=wg+qpNvqcROndhRidOE1i7bQm93xM=jmre98-X4qkVkMw@mail.gmail.com>
 <7f0f8e71-cf62-4c0b-5f13-a41919c6cd9b@redhat.com>
 <20211221205635.GB30289@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221205635.GB30289@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:56:35PM +0100, Willy Tarreau wrote:
> > As it is all done within the kernel, there is no need to
> > change any userspace code. We may need to add a flag bit in the task
> > structure to indicate using the suid_dumpable setting so that it can be
> > inherited across fork/exec.
> 
> Depending on what we change there can be some subtly visible changes.
> In one of my servers I explicitly re-enable dumpable before setsid()
> when a core dump is desired for debugging. But other deamons could do
> the exact opposite. If setsid() systematically restores suid_dumpable,
> a process that explicitly disables it before calling setsid() would
> see it come back. But if we have a special "suid_in_progress" flag
> to mask suid_dumpable and that's reset by setsid() and possibly
> prctl(PR_SET_DUMPABLE) then I think it could even cover that unlikely
> case.

Would there be any interest in pursuing attempts like the untested patch
below ? The intent is to set a new MMF_NOT_DUMPABLE on exec on setuid or
setgid bit, but clear it on setrlimit(RLIMIT_CORE), prctl(SET_DUMPABLE),
and setsid(). This flag makes get_dumpable() return SUID_DUMP_DISABLED
when set. I think that in the spirit it could maintain the info that a
suidexec happened and was not reset, without losing any tuning made by
the application. I never feel at ease touching all this and I certainly
did some mistakes but for now it's mostly to have a base to discuss
around, so do not hesitate to suggest or criticize.

Willy


diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..a80bfd835235 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1348,8 +1348,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
 	    !(uid_eq(current_euid(), current_uid()) &&
-	      gid_eq(current_egid(), current_gid())))
+	      gid_eq(current_egid(), current_gid()))) {
+		set_bit(MMF_NOT_DUMPABLE, &mm->flags);
+
 		set_dumpable(current->mm, suid_dumpable);
+	}
 	else
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 4d9e3a656875..fd2109d036bc 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -14,23 +14,6 @@
 #define MMF_DUMPABLE_BITS 2
 #define MMF_DUMPABLE_MASK ((1 << MMF_DUMPABLE_BITS) - 1)
 
-extern void set_dumpable(struct mm_struct *mm, int value);
-/*
- * This returns the actual value of the suid_dumpable flag. For things
- * that are using this for checking for privilege transitions, it must
- * test against SUID_DUMP_USER rather than treating it as a boolean
- * value.
- */
-static inline int __get_dumpable(unsigned long mm_flags)
-{
-	return mm_flags & MMF_DUMPABLE_MASK;
-}
-
-static inline int get_dumpable(struct mm_struct *mm)
-{
-	return __get_dumpable(mm->flags);
-}
-
 /* coredump filter bits */
 #define MMF_DUMP_ANON_PRIVATE	2
 #define MMF_DUMP_ANON_SHARED	3
@@ -81,9 +64,29 @@ static inline int get_dumpable(struct mm_struct *mm)
  * lifecycle of this mm, just for simplicity.
  */
 #define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
+#define MMF_NOT_DUMPABLE	29	/* dump disable by suidexec */
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK)
 
+extern void set_dumpable(struct mm_struct *mm, int value);
+/*
+ * This returns the actual value of the suid_dumpable flag. For things
+ * that are using this for checking for privilege transitions, it must
+ * test against SUID_DUMP_USER rather than treating it as a boolean
+ * value.
+ */
+static inline int __get_dumpable(unsigned long mm_flags)
+{
+	if (mm_flag & MMF_NOT_DUMPABLE)
+		return SUID_DUMP_DISABLE;
+	return mm_flags & MMF_DUMPABLE_MASK;
+}
+
+static inline int get_dumpable(struct mm_struct *mm)
+{
+	return __get_dumpable(mm->flags);
+}
+
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 8fdac0d90504..a20002075496 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1215,6 +1215,13 @@ int ksys_setsid(void)
 out:
 	write_unlock_irq(&tasklist_lock);
 	if (err > 0) {
+		struct mm_struct *mm = get_task_mm(current);
+		if (mm) {
+			/* session leaders reset the not-dumpable protection */
+			clear_bit(MMF_NOT_DUMPABLE, &mm->flags);
+			mmput(mm);
+		}
+
 		proc_sid_connector(group_leader);
 		sched_autogroup_create_attach(group_leader);
 	}
@@ -1610,6 +1617,18 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 	     new_rlim->rlim_cur != RLIM_INFINITY &&
 	     IS_ENABLED(CONFIG_POSIX_TIMERS))
 		update_rlimit_cpu(tsk, new_rlim->rlim_cur);
+
+	/*
+	 * If an application wants to change core dump settings, it means
+	 * it wants to decide on its dumpability so we reset MMF_NOT_DUMPABLE.
+	 */
+	if (resource == RLIMIT_CORE) {
+		struct mm_struct *mm = get_task_mm(tsk);
+		if (mm) {
+			clear_bit(MMF_NOT_DUMPABLE, &mm->flags);
+			mmput(mm);
+		}
+	}
 out:
 	read_unlock(&tasklist_lock);
 	return retval;
@@ -2292,6 +2311,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = -EINVAL;
 			break;
 		}
+		clear_bit(MMF_NOT_DUMPABLE, &me->mm->flags);
 		set_dumpable(me->mm, arg2);
 		break;
 
