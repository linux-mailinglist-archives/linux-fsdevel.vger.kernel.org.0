Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973BD168FE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 16:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBVPsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 10:48:36 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:53310 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgBVPsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 10:48:35 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j5X15-0002Kb-RQ; Sat, 22 Feb 2020 08:48:31 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j5X14-0004kb-Io; Sat, 22 Feb 2020 08:48:31 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Solar Designer <solar@openwall.com>
References: <20200212200335.GO23230@ZenIV.linux.org.uk>
        <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
        <20200212203833.GQ23230@ZenIV.linux.org.uk>
        <20200212204124.GR23230@ZenIV.linux.org.uk>
        <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
        <87lfp7h422.fsf@x220.int.ebiederm.org>
        <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
        <87pnejf6fz.fsf@x220.int.ebiederm.org>
        <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
        <87r1yp7zhc.fsf_-_@x220.int.ebiederm.org>
        <20200221165036.GB16646@redhat.com>
Date:   Sat, 22 Feb 2020 09:46:29 -0600
In-Reply-To: <20200221165036.GB16646@redhat.com> (Oleg Nesterov's message of
        "Fri, 21 Feb 2020 17:50:37 +0100")
Message-ID: <87mu9a4obu.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j5X14-0004kb-Io;;;mid=<87mu9a4obu.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+wG8oCF9P5p4qTliSUMtLy9dXaaffHDtc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 717 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.8 (0.4%), b_tie_ro: 1.94 (0.3%), parse: 0.93
        (0.1%), extract_message_metadata: 12 (1.7%), get_uri_detail_list: 2.2
        (0.3%), tests_pri_-1000: 6 (0.8%), tests_pri_-950: 1.23 (0.2%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 32 (4.4%), check_bayes: 30
        (4.2%), b_tokenize: 11 (1.5%), b_tok_get_all: 10 (1.4%), b_comp_prob:
        3.0 (0.4%), b_tok_touch_all: 3.9 (0.5%), b_finish: 0.68 (0.1%),
        tests_pri_0: 648 (90.3%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 12 (1.7%), poll_dns_idle: 0.37 (0.1%), tests_pri_10:
        2.9 (0.4%), tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 7/7] proc: Ensure we see the exit of each process tid exactly once
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 02/20, Eric W. Biederman wrote:
>>
>> +void exchange_tids(struct task_struct *ntask, struct task_struct *otask)
>> +{
>> +	/* pid_links[PIDTYPE_PID].next is always NULL */
>> +	struct pid *npid = READ_ONCE(ntask->thread_pid);
>> +	struct pid *opid = READ_ONCE(otask->thread_pid);
>> +
>> +	rcu_assign_pointer(opid->tasks[PIDTYPE_PID].first, &ntask->pid_links[PIDTYPE_PID]);
>> +	rcu_assign_pointer(npid->tasks[PIDTYPE_PID].first, &otask->pid_links[PIDTYPE_PID]);
>> +	rcu_assign_pointer(ntask->thread_pid, opid);
>> +	rcu_assign_pointer(otask->thread_pid, npid);
>
> this breaks has_group_leader_pid()...
>
> proc_pid_readdir() can miss a process doing mt-exec but this looks fixable,
> just we need to update ntask->thread_pid before updating ->first.
>
> The more problematic case is __exit_signal() which does
> 		
> 		if (unlikely(has_group_leader_pid(tsk)))
> 			posix_cpu_timers_exit_group(tsk);

Along with the comment:
		/*
		 * This can only happen if the caller is de_thread().
		 * FIXME: this is the temporary hack, we should teach
		 * posix-cpu-timers to handle this case correctly.
		 */
So I suspect this is fixable and the above fix might be part of that.

Hmm looking at your commit:

commit e0a70217107e6f9844628120412cb27bb4cea194
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Fri Nov 5 16:53:42 2010 +0100

    posix-cpu-timers: workaround to suppress the problems with mt exec
    
    posix-cpu-timers.c correctly assumes that the dying process does
    posix_cpu_timers_exit_group() and removes all !CPUCLOCK_PERTHREAD
    timers from signal->cpu_timers list.
    
    But, it also assumes that timer->it.cpu.task is always the group
    leader, and thus the dead ->task means the dead thread group.
    
    This is obviously not true after de_thread() changes the leader.
    After that almost every posix_cpu_timer_ method has problems.
    
    It is not simple to fix this bug correctly. First of all, I think
    that timer->it.cpu should use struct pid instead of task_struct.
    Also, the locking should be reworked completely. In particular,
    tasklist_lock should not be used at all. This all needs a lot of
    nontrivial and hard-to-test changes.
    
    Change __exit_signal() to do posix_cpu_timers_exit_group() when
    the old leader dies during exec. This is not the fix, just the
    temporary hack to hide the problem for 2.6.37 and stable. IOW,
    this is obviously wrong but this is what we currently have anyway:
    cpu timers do not work after mt exec.
    
    In theory this change adds another race. The exiting leader can
    detach the timers which were attached to the new leader. However,
    the window between de_thread() and release_task() is small, we
    can pretend that sys_timer_create() was called before de_thread().
    
    Signed-off-by: Oleg Nesterov <oleg@redhat.com>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

It looks like the data structures need fixing.  Possibly to use struct
pid.  Possibly to move the group data to signal struct.

I think I played with some of that awhile ago.

I am going to move this change to another patchset.  So I don't wind up
playing shift the bug around.  I thought I would need this to get the
other code working but it turns out we remain bug compatible without
this.

Hopefully I can get something out in the next week or so that addresses
the issues you have pointed out.

Eric

