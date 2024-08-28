Return-Path: <linux-fsdevel+bounces-27536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01753962473
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE19C2849A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD161684BE;
	Wed, 28 Aug 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF8t9GlF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093F15B968;
	Wed, 28 Aug 2024 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840080; cv=none; b=qAksW3cZT/thV1SebNBd9Bf4RYNY11fhvnd4ZxV9coovN9yZO0JSVr275RKQqFceS13or8iH9Ytu3AQSESgTlabzcnb8Y0V8BY9pFCaIWkT9CskyiIrTAmAJefIdpkionDxyLhfIZi8yYenPJ04pjuAWzyokqAuSB1uLlcOVdgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840080; c=relaxed/simple;
	bh=68AnstsI4hubfgMgxvveFIXJHkuBsp/rm2FdiNu0eb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkVZBzfAPMFyk5PwCVXqYJ1aJZF3SPHV7oTTxOb3KHBsuYbcxlvemoIMy01D9Z3EBhGzxzp6TKtQrVP9Mk/Qg/0SLf9sCkUpxIyiMDI2SFysYVORsRMKvhBKIC7zX+OAlnhXz7D45uRW18uKNwYd7G8gy3+HwhlH8INRuqbIG14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF8t9GlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689BBC98EC2;
	Wed, 28 Aug 2024 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724840079;
	bh=68AnstsI4hubfgMgxvveFIXJHkuBsp/rm2FdiNu0eb0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qF8t9GlF+mOLun/Yk8Hzpcl9vb5CtW3ByomcSrh1Z7YmhCwJ7Vg1agUoNxrOW6SbE
	 2NFgpvExMt6Eg0GtZJZYYPeDGX5L7lHGQVY2ujC/xwZq8CGQld/scHJTPMHhAivbr0
	 9SWdWHtFImBh055uOxKGbeMK50MIUnb7AacsQ0QZfpd84QzXc2UhEVSG+YxjAhzUuZ
	 ENf8i8cs+mEduEbm2RObYKOXFBgw5YBZJfTpbCXx1ghGQBFQGlUVW1Rf/4BcnrOUmW
	 JK6W4fJ5mdA2/FJEYIT2VXMvLBjA+rv59+2SThI1wYJ4g8zT/IwX3pbV0th59SQzAg
	 88jfneK5CK+8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0896ACE0FF3; Wed, 28 Aug 2024 03:14:39 -0700 (PDT)
Date: Wed, 28 Aug 2024 03:14:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Z qiang <qiang.zhang1211@gmail.com>
Subject: Re: SRCU hung task on 5.10.y on synchronize_srcu(&fsnotify_mark_srcu)
Message-ID: <f0f89f4c-6796-4da6-b033-784bf9a9796f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1E829024-48BF-4647-A1DD-AC7E8BFA0FA2@nutanix.com>
 <95fbe7cc-8752-4e38-8c2e-5df5e544a3cc@paulmck-laptop>
 <C8864F22-A875-41B1-8293-9EF0D8495E12@nutanix.com>
 <2701726a-4552-4f63-9a75-3a7c93571072@paulmck-laptop>
 <9D17810D-2268-4649-A1B2-3708B93B50B6@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9D17810D-2268-4649-A1B2-3708B93B50B6@nutanix.com>

On Wed, Aug 28, 2024 at 02:41:09AM +0000, Jon Kohler wrote:
> > On Aug 27, 2024, at 9:21 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Tue, Aug 27, 2024 at 11:33:32PM +0000, Jon Kohler wrote:
> >>> On Aug 27, 2024, at 4:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> On Tue, Aug 27, 2024 at 08:01:27PM +0000, Jon Kohler wrote:
> >>>> Hey Paul, Lai, Josh, and the RCU list and Jan/FS list -
> >>>> Reaching out about a tricky hung task issue that I'm running into. I've
> >>>> got a virtualized Linux guest on top of a KVM based platform, running
> >>>> a 5.10.y based kernel. The issue we're running into is a hung task that
> >>>> *only* happens on shutdown/reboot of this particular VM once every 
> >>>> 20-50 times.
> >>>> 
> >>>> The signature of the hung task is always similar to the output below,
> >>>> where we appear to hang on the call to 
> >>>>   synchronize_srcu(&fsnotify_mark_srcu)
> >>> 
> >>> One thing to try would be to add trace_printk() or similar to the SRCU
> >>> readers, just in case someone was using srcu_read_lock_notrace() on
> >>> fsnotify_mark_srcu, which I see no trace of in current mainline.
> >>> 
> >>> Alternatively, if there is a version where this does not happen, try
> >>> bisecting.  Each bisection step would require something like 400-500
> >>> shutdown/reboots to prove the commit good.  (Obviously, the first failure
> >>> proves the commit bad, which for one-out-of-50 failures will take on
> >>> average about 35 shutdown/reboots.)
> >>> 
> >>> There could also be a bad SRCU backport from mainline, so please check
> >>> what SRCU backports you have in your 5.10.y stable release.  (Though
> >>> maybe Jack has already done this?)
> >>> 
> >>> Thanx, Paul
> >> 
> >> Thanks, Paul
> >> 
> >> For posterity, this kernel is just built off of the regular ole stable tree, and here’s
> >> All of the backports to kernel/rcu are below.
> >> 
> >> Stepping through this more, since we’re stalling at wait_for_completion,
> >> that must mean that wakeme_after_rcu() ... complete(&rcu->completion)
> >> is not happening, right?
> >> 
> >> That or somehow wakeme_after_rcu() fires *before* wait_for_completion()
> >> is setup, causing the wait to hang forever?
> > 
> > There is no problem with that misordering -- in that case, the call to
> > wait_for_completion() simply won't wait.
> > 
> > But that would be a good path to trace.  After all, you might have
> > noticed that what we believe software will do does not always match what
> > it actually does.
> 
> Agreed, I’ll noodle on it some more, and try to bisect as well. I see 
> Neeraj responded separately, I’ll check that out now.
> > 
> > 
> >> Is it possible for wakeme_after_rcu() to race, such that it fires somewhere
> >> else *before* wait_for_completion gets all the way to schedule()?
> > 
> > That should also work just fine, but it is still a good assumption to
> > check.
> > 
> > Good list below, but I must focus on mainline.  Apologies!
> > 
> > Plus this assumes that v5.10 worked for you -- has that been tested?
> > So again, what version has worked for you?
> 
> We’ve had this particular service on 5.10.y for a while; however, this
> behavior just recently started bubbling up with a somewhat new(er) set
> of internal QA tests that very specifically stress shutdown/reboots in a
> loop for a completely unrelated durability test, so its possible this issue
> has existed for a while.

I hope that the commit that Neeraj identified fixes this for you, and
thank you very much, Neeraj!

However, if it does not, I suggest: (1) running your new tests on older
versions of 5.10.y in case the bug was introduced by partial back ports,
(2) running your tests on newer versions of mainline in case there is
another fix that needs to be backported, and, if necessary, (3) work on
the tests so that the problem reproduces faster, reducing the costs of
further experiments.

							Thanx, Paul

> > Thanx, Paul
> > 
> >> [rcu]$ pwd
> >> /kernel/kernel/rcu
> >> [rcu]$ git remote -v
> >> origin https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_stable_linux.git&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=NGPRGGo37mQiSXgHKm5rCQ&m=1Tj05_-3u5bekAXIOn3TZBxlsLepxSWdhZVB6OKs02CYfxx4O9XkBJaihu2H2SaF&s=i-EJON2mPUDM-dvijeXkVr4nsR1g_obFaq9F9DCfQNs&e=  (fetch)
> >> origin https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_stable_linux.git&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=NGPRGGo37mQiSXgHKm5rCQ&m=1Tj05_-3u5bekAXIOn3TZBxlsLepxSWdhZVB6OKs02CYfxx4O9XkBJaihu2H2SaF&s=i-EJON2mPUDM-dvijeXkVr4nsR1g_obFaq9F9DCfQNs&e=  (push)
> >> [rcu]$ git log --oneline 2c85ebc57b3e..HEAD .
> >> ca4427ebc626 (HEAD, tag: v5.10.205) Linux 5.10.205 <<<< this is the base commit for 5.10.205 >>>>
> >> ...
> >> 175f4b062f69 rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects <<<< this is the most recent backport commit to kernel/rcu >>>>
> >> 55887adc76e1 rcuscale: Move rcu_scale_writer() schedule_timeout_uninterruptible() to _idle()
> >> 066fbd8bc981 refscale: Fix uninitalized use of wait_queue_head_t
> >> d93ba6e46e5f rcu-tasks: Add trc_inspect_reader() checks for exiting critical section
> >> 3e22624f8fd3 rcu-tasks: Wait for trc_read_check_handler() IPIs
> >> 9190c1f0aed1 rcu-tasks: Fix IPI failure handling in trc_wait_for_one_reader
> >> ad4f8c117b8b rcu: Prevent expedited GP from enabling tick on offline CPU
> >> 4f91de9a81bd rcu-tasks: Simplify trc_read_check_handler() atomic operations
> >> 3a64cd01cdd6 rcu-tasks: Mark ->trc_reader_special.b.need_qs data races
> >> 058f077d09ba rcu-tasks: Mark ->trc_reader_nesting data races
> >> 604d6a5ff718 rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale
> >> d414e24d1509 rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
> >> ecc5e6dbc269 rcuscale: Move shutdown from wait_event() to wait_event_idle()
> >> b62c816bdb5e rcuscale: Always log error message
> >> 8cd9917c13a7 rcuscale: Console output claims too few grace periods
> >> 7230a9e599d3 rcu/kvfree: Avoid freeing new kfree_rcu() memory after old grace period
> >> a7d21b858589 rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access
> >> e4842de4ec13 refscale: Move shutdown from wait_event() to wait_event_idle()
> >> eb18bc5a8678 rcu: Avoid stack overflow due to __rcu_irq_enter_check_tick() being kprobe-ed
> >> d99d194e2f8c rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
> >> 2bf501f1bc78 rcu: Suppress smp_processor_id() complaint in synchronize_rcu_expedited_wait()
> >> 1c37e86a78c2 rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()
> >> ad410f64f7ab rcu-tasks: Remove preemption disablement around srcu_read_[un]lock() calls
> >> b02b6bb83c68 rcu-tasks: Improve comments explaining tasks_rcu_exit_srcu purpose
> >> 7c15d7ecce00 rcu: Prevent lockdep-RCU splats on lock acquisition/release
> >> 5a52380b8193 rcu: Fix __this_cpu_read() lockdep warning in rcu_force_quiescent_state()
> >> 0dd025483f15 rcu-tasks: Convert RCU_LOCKDEP_WARN() to WARN_ONCE()
> >> 36d4ffbedff7 rcu: Back off upon fill_page_cache_func() allocation failure
> >> 10f30cba8f6c rcu: Make TASKS_RUDE_RCU select IRQ_WORK
> >> 1c6c3f233664 rcu-tasks: Fix race in schedule and flush work
> >> a22d66eb518f rcu: Apply callbacks processing time limit only on softirq
> >> 40fb3812d997 rcu: Fix callbacks processing time limit retaining cond_resched()
> >> fcc9797d0d13 rcu: Don't deboost before reporting expedited quiescent state
> >> 0c145262ac99 rcu/nocb: Fix missed nocb_timer requeue
> >> 657991fb06a4 rcu: Do not report strict GPs for outgoing CPUs
> >> 12d3389b7af6 rcu: Tighten rcu_advance_cbs_nowake() checks
> >> 0836f9404017 rcu/exp: Mark current CPU as exp-QS in IPI loop second pass
> >> 70692b06208c rcu: Mark accesses to rcu_state.n_force_qs
> >> af756be29c82 rcu: Always inline rcu_dynticks_task*_{enter,exit}()
> >> 226d68fb6c0a rcu: Fix existing exp request check in sync_sched_exp_online_cleanup()
> >> 02ddf26d849d rcu-tasks: Move RTGS_WAIT_CBS to beginning of rcu_tasks_kthread() loop
> >> 7f43cda650d5 rcutorture: Avoid problematic critical section nesting on PREEMPT_RT
> >> d3ca78775db4 rcu: Fix macro name CONFIG_TASKS_RCU_TRACE
> >> 497f3d9c3f58 rcu: Fix stall-warning deadlock due to non-release of rcu_node ->lock
> >> ea5e5bc881a4 rcu: Add lockdep_assert_irqs_disabled() to rcu_sched_clock_irq() and callees
> >> 527b56d7856f rcu: Fix to include first blocked task in stall warning
> >> 4b680b3fc6f3 rcu/tree: Handle VM stoppage in stall detection
> >> b6ae3854075e srcu: Provide polling interfaces for Tiny SRCU grace periods
> >> 450948b06ce8 srcu: Make Tiny SRCU use multi-bit grace-period counter
> >> 641e1d88404a srcu: Provide internal interface to start a Tiny SRCU grace period
> >> f789de3be808 srcu: Provide polling interfaces for Tree SRCU grace periods
> >> fdf66e5a7fc8 srcu: Provide internal interface to start a Tree SRCU grace period
> >> 86cb49e7314e rcu-tasks: Don't delete holdouts within trc_wait_for_one_reader()
> >> 55ddab2bfd70 rcu-tasks: Don't delete holdouts within trc_inspect_reader()
> >> 35a35909ec19 rcu: Reject RCU_LOCKDEP_WARN() false positives
> >> 23597afbe096 srcu: Fix broken node geometry after early ssp init
> >> 728f23e53c65 rcu: Invoke rcu_spawn_core_kthreads() from rcu_spawn_gp_kthread()
> >> 7d81aff28953 rcu: Remove spurious instrumentation_end() in rcu_nmi_enter()
> >> 09a27d662006 kvfree_rcu: Use same set of GFP flags as does single-argument
> >> e713bdd791ba rcu/nocb: Perform deferred wake up before last idle's need_resched() check
> >> 20b7669fa3f0 rcu: Pull deferred rcuog wake up to rcu_eqs_enter() callers
> >> 30b491e2b6cc rcu-tasks: Move RCU-tasks initialization to before early_initcall()
> >> 9b81af9c8455 rcu/tree: Defer kvfree_rcu() allocation to a clean context
> >> 5cacd18c5207 rcu,ftrace: Fix ftrace recursion
> >> 4540e84bd8a9 rcu: Allow rcu_irq_enter_check_tick() from NMI <<<< this is the first kernel/rcu backport for 5.10.y branch >>>>
> >> ...
> >> 2c85ebc57b3e (tag: v5.10) Linux 5.10 <<<< this is the divergence point from mainline to 5.10.y >>>> 
> >> 
> >>> 
> >>>> in fsnotify_connector_destroy_workfn / fsnotify_mark_destroy_workfn,
> >>>> where two kernel threads are both calling synchronize_srcu, then
> >>>> scheduling out in wait_for_completion, and completely going out to
> >>>> lunch for over 4 minutes. This then triggers the hung task timeout and
> >>>> things blow up.
> >>>> 
> >>>> We are running audit=1 for this system and are using an el8 based
> >>>> userspace.
> >>>> 
> >>>> I've flipped through the fs/notify code base for both 5.10 as well as
> >>>> upstream mainline to see if something jumped off the page, and I
> >>>> haven't yet spotted any particular suspect code from the caller side.
> >>>> 
> >>>> This hang appears to come up at the very end of the shutdown/reboot
> >>>> process, seemingly after the system starts to unwind through initrd.
> >>>> 
> >>>> What I'm working on now is adding some instrumentation to the dracut
> >>>> shutdown initrd scripts to see if I can how far we get down that path
> >>>> before the system fails to make forward progress, which may give some
> >>>> hints. TBD on that. I've also enabled lockdep with CONFIG_PROVE_RCU and
> >>>> a plethora of DEBUG options [2], and didn't get anything interesting.
> >>>> To be clear, we haven't seen lockdep spit out any complaints as of yet.
> >>>> 
> >>>> Reaching out to see if this sounds familar to anyone on the list, or if
> >>>> there are any particular areas of the RCU code base that might be
> >>>> suspect for this kind of issue. I'm happy to provide more information,
> >>>> as frankly, I'm quite stumped at the moment.
> >>>> 
> >>>> Thanks all,
> >>>> Jon
> >>>> 
> >>>> [1] panic trace
> >>>>   Normal shutdown process, then hangs on the following:
> >>>>   ...
> >>>>   dracut Warning: Killing all remaining processes
> >>>>   ...
> >>>>   INFO: task kworker/u20:7:1200701 blocked for more than 241 seconds.
> >>>>         Tainted: G           O      5.10.205-2.el8.x86_64 #1
> >>>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>>>   task:kworker/u20:7   state:D stack:    0 pid:1200701 ppid:     2 flags:0x00004080
> >>>>   Workqueue: events_unbound fsnotify_connector_destroy_workfn
> >>>>   Call Trace:
> >>>>    __schedule+0x267/0x790
> >>>>    schedule+0x3c/0xb0
> >>>>    schedule_timeout+0x219/0x2b0
> >>>>    wait_for_completion+0x9e/0x100
> >>>>    __synchronize_srcu.part.24+0x83/0xb0
> >>>>    ? __bpf_trace_rcu_utilization+0x10/0x10
> >>>>    ? synchronize_srcu+0x5d/0xf0
> >>>>    fsnotify_connector_destroy_workfn+0x46/0x80
> >>>>    process_one_work+0x1fc/0x390
> >>>>    worker_thread+0x2d/0x3e0
> >>>>    ? process_one_work+0x390/0x390
> >>>>    kthread+0x114/0x130
> >>>>    ? kthread_park+0x80/0x80
> >>>>    ret_from_fork+0x1f/0x30
> >>>>   INFO: task kworker/u20:8:1287360 blocked for more than 241 seconds.
> >>>>         Tainted: G           O      5.10.205-2.el8.x86_64 #1
> >>>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>>>   task:kworker/u20:8   state:D stack:    0 pid:1287360 ppid:     2 flags:0x00004080
> >>>>   Workqueue: events_unbound fsnotify_mark_destroy_workfn
> >>>>   Call Trace:
> >>>>    __schedule+0x267/0x790
> >>>>    schedule+0x3c/0xb0
> >>>>    schedule_timeout+0x219/0x2b0
> >>>>    ? add_timer+0x14a/0x200
> >>>>    wait_for_completion+0x9e/0x100
> >>>>    __synchronize_srcu.part.24+0x83/0xb0
> >>>>    ? __bpf_trace_rcu_utilization+0x10/0x10
> >>>>    fsnotify_mark_destroy_workfn+0x77/0xe0
> >>>>    process_one_work+0x1fc/0x390
> >>>>    ? process_one_work+0x390/0x390
> >>>>    worker_thread+0x2d/0x3e0
> >>>>    ? process_one_work+0x390/0x390
> >>>>    kthread+0x114/0x130
> >>>>    ? kthread_park+0x80/0x80
> >>>>    ret_from_fork+0x1f/0x30
> >>>>   Kernel panic - not syncing: hung_task: blocked tasks
> >>>>   CPU: 1 PID: 64 Comm: khungtaskd Kdump: loaded Tainted: G           O      5.10.205-2.el8.x86_64 #1
> >>>>   Hardware name: Red Hat KVM, BIOS 20230302.1.2662.el8 04/01/2014
> >>>>   Call Trace:
> >>>>    dump_stack+0x6d/0x8c
> >>>>    panic+0x114/0x2ea
> >>>>    watchdog.cold.8+0xb5/0xb5
> >>>>    ? hungtask_pm_notify+0x50/0x50
> >>>>    kthread+0x114/0x130
> >>>>    ? kthread_park+0x80/0x80
> >>>>    ret_from_fork+0x1f/0x30
> >>>> 
> >>>> [2] additional debugging config knobs turned up.
> >>>>   CONFIG_PROVE_LOCKING=y
> >>>>   CONFIG_LOCK_STAT=y
> >>>>   CONFIG_DEBUG_RT_MUTEXES=y
> >>>>   CONFIG_DEBUG_SPINLOCK=y
> >>>>   CONFIG_DEBUG_MUTEXES=y
> >>>>   CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> >>>>   CONFIG_DEBUG_RWSEMS=y
> >>>>   CONFIG_DEBUG_LOCK_ALLOC=y
> >>>>   CONFIG_LOCKDEP=y
> >>>>   CONFIG_LOCKDEP_BITS=15
> >>>>   CONFIG_LOCKDEP_CHAINS_BITS=16
> >>>>   CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> >>>>   CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> >>>>   CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> >>>>   CONFIG_DEBUG_SHIRQ=y
> >>>>   CONFIG_WQ_WATCHDOG=y
> >>>>   CONFIG_DEBUG_ATOMIC_SLEEP=y
> >>>>   CONFIG_DEBUG_LIST=y
> >>>>   CONFIG_DEBUG_PLIST=y
> >>>>   CONFIG_DEBUG_SG=y
> >>>>   CONFIG_DEBUG_NOTIFIERS=y
> >>>>   CONFIG_BUG_ON_DATA_CORRUPTION=y
> 
> 

