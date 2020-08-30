Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD3D256DA8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 14:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgH3Mbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 08:31:48 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45398 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgH3Mbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 08:31:47 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kCMUp-00836e-83; Sun, 30 Aug 2020 06:31:43 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kCMUn-0005Ur-Sg; Sun, 30 Aug 2020 06:31:43 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     peterz@infradead.org
Cc:     syzbot <syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, gladkov.alexey@gmail.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        walken@google.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, jannh@google.com
References: <00000000000063640c05ade8e3de@google.com>
        <87mu2fj7xu.fsf@x220.int.ebiederm.org>
        <20200828123720.GZ1362448@hirez.programming.kicks-ass.net>
Date:   Sun, 30 Aug 2020 07:31:39 -0500
In-Reply-To: <20200828123720.GZ1362448@hirez.programming.kicks-ass.net>
        (peterz's message of "Fri, 28 Aug 2020 14:37:20 +0200")
Message-ID: <87v9h0gvro.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kCMUn-0005Ur-Sg;;;mid=<87v9h0gvro.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/wNTrKWXxSNhTbAMkX//UsQBeeMp6vWYU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4791]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;peterz@infradead.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 919 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (1.4%), b_tie_ro: 12 (1.3%), parse: 1.75
        (0.2%), extract_message_metadata: 16 (1.7%), get_uri_detail_list: 4.3
        (0.5%), tests_pri_-1000: 15 (1.6%), tests_pri_-950: 1.25 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 70 (7.6%), check_bayes: 69
        (7.5%), b_tokenize: 13 (1.5%), b_tok_get_all: 13 (1.4%), b_comp_prob:
        3.8 (0.4%), b_tok_touch_all: 34 (3.7%), b_finish: 0.80 (0.1%),
        tests_pri_0: 778 (84.6%), check_dkim_signature: 0.84 (0.1%),
        check_dkim_adsp: 2.6 (0.3%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        3.0 (0.3%), tests_pri_500: 17 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: possible deadlock in proc_pid_syscall (2)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

peterz@infradead.org writes:

> On Fri, Aug 28, 2020 at 07:01:17AM -0500, Eric W. Biederman wrote:
>> This feels like an issue where perf can just do too much under
>> exec_update_mutex.  In particular calling kern_path from
>> create_local_trace_uprobe.  Calling into the vfs at the very least
>> makes it impossible to know exactly which locks will be taken.
>> 
>> Thoughts?
>
>> > -> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
>> >        down_read+0x96/0x420 kernel/locking/rwsem.c:1492
>> >        inode_lock_shared include/linux/fs.h:789 [inline]
>> >        lookup_slow fs/namei.c:1560 [inline]
>> >        walk_component+0x409/0x6a0 fs/namei.c:1860
>> >        lookup_last fs/namei.c:2309 [inline]
>> >        path_lookupat+0x1ba/0x830 fs/namei.c:2333
>> >        filename_lookup+0x19f/0x560 fs/namei.c:2366
>> >        create_local_trace_uprobe+0x87/0x4e0 kernel/trace/trace_uprobe.c:1574
>> >        perf_uprobe_init+0x132/0x210 kernel/trace/trace_event_perf.c:323
>> >        perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9580
>> >        perf_try_init_event+0x12a/0x560 kernel/events/core.c:10899
>> >        perf_init_event kernel/events/core.c:10951 [inline]
>> >        perf_event_alloc.part.0+0xdee/0x3770 kernel/events/core.c:11229
>> >        perf_event_alloc kernel/events/core.c:11608 [inline]
>> >        __do_sys_perf_event_open+0x72c/0x2cb0 kernel/events/core.c:11724
>> >        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>> >        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Right, so we hold the mutex fairly long there, supposedly to ensure
> privs don't change out from under us.
>
> We do the permission checks early -- no point in doing anything else if
> we're not allowed, but we then have to hold this mutex until the event
> is actually installed according to that comment.
>
> /me goes look at git history:
>
>   6914303824bb5 - changed cred_guard_mutex into exec_update_mutex
>   79c9ce57eb2d5 - introduces cred_guard_mutex
>
> So that latter commit explains the race we're guarding against. Without
> this we can install the event after execve() which might have changed
> privs on us.
>
> I'm open to suggestions on how to do this differently.
>
> Could we check privs twice instead?
>
> Something like the completely untested below..

That might work.

I am thinking that for cases where we want to do significant work it
might be better to ask the process to pause at someplace safe (probably
get_signal) and then do all of the work when we know nothing is changing
in the process.

I don't really like the idea of checking and then checking again.  We
might have to do it but it feels like the model is wrong somewhere.

Given that this is tricky to hit in practice, and given that I am
already working the general problem of how to sort out the locking I am
going to work this with the rest of the thorny issues of in exec.  This
feels like a case where the proper solution is that we simply need
something better than a mutex.


I had not realized before this how much setting up tracing in
perf_even_open looks like attaching a debugger in ptrace_attach.


I need to look at this some more but I suspect exec should be
treating a tracer like exec currently treats a ptracer for
purposes of permission checks.  So I think we may have more issues
than simply the possibility of deadlock on exec_update_mutex.

Eric


> ---
> diff --git a/include/linux/freelist.h b/include/linux/freelist.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5bfe8e3c6e44..14e6c9bbfcda 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11701,21 +11701,9 @@ SYSCALL_DEFINE5(perf_event_open,
>  	}
>  
>  	if (task) {
> -		err = mutex_lock_interruptible(&task->signal->exec_update_mutex);
> -		if (err)
> -			goto err_task;
> -
> -		/*
> -		 * Preserve ptrace permission check for backwards compatibility.
> -		 *
> -		 * We must hold exec_update_mutex across this and any potential
> -		 * perf_install_in_context() call for this new event to
> -		 * serialize against exec() altering our credentials (and the
> -		 * perf_event_exit_task() that could imply).
> -		 */
>  		err = -EACCES;
>  		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
> -			goto err_cred;
> +			goto err_task;
>  	}
>  
>  	if (flags & PERF_FLAG_PID_CGROUP)
> @@ -11844,6 +11832,24 @@ SYSCALL_DEFINE5(perf_event_open,
>  		goto err_context;
>  	}
>  
> +	if (task) {
> +		err = mutex_lock_interruptible(&task->signal->exec_update_mutex);
> +		if (err)
> +			goto err_file;
> +
> +		/*
> +		 * Preserve ptrace permission check for backwards compatibility.
> +		 *
> +		 * We must hold exec_update_mutex across this and any potential
> +		 * perf_install_in_context() call for this new event to
> +		 * serialize against exec() altering our credentials (and the
> +		 * perf_event_exit_task() that could imply).
> +		 */
> +		err = -EACCES;
> +		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
> +			goto err_cred;
> +	}
> +
>  	if (move_group) {
>  		gctx = __perf_event_ctx_lock_double(group_leader, ctx);
>  
> @@ -12019,7 +12025,10 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (move_group)
>  		perf_event_ctx_unlock(group_leader, gctx);
>  	mutex_unlock(&ctx->mutex);
> -/* err_file: */
> +err_cred:
> +	if (task)
> +		mutex_unlock(&task->signal->exec_update_mutex);
> +err_file:
>  	fput(event_file);
>  err_context:
>  	perf_unpin_context(ctx);
> @@ -12031,9 +12040,6 @@ SYSCALL_DEFINE5(perf_event_open,
>  	 */
>  	if (!event_file)
>  		free_event(event);
> -err_cred:
> -	if (task)
> -		mutex_unlock(&task->signal->exec_update_mutex);
>  err_task:
>  	if (task)
>  		put_task_struct(task);
