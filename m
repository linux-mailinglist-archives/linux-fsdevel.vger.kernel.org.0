Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622512D15DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 17:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgLGQWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 11:22:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:45175 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgLGQWA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:22:00 -0500
IronPort-SDR: 9GgYIDLzIFh6ho9HOjYuP6ok3wvWqVDuJjTd8o8hKQtfoOTGKWBZrZpmcFGFIuxvTzal9Zryrx
 3iEqygdyZUjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="173876012"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="173876012"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 08:20:13 -0800
IronPort-SDR: GLrS16k9ZSgyMUmmIqRt/OuboMmhUDssZftBuPHS4JbytnwElwPGvpb4gz9NtxU26qwSYwJRBt
 KrKhds2u7Eig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="407200993"
Received: from cvg-ubt08.iil.intel.com (HELO [10.185.176.12]) ([10.185.176.12])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2020 08:19:57 -0800
Subject: Re: [RFC PATCH v2] do_exit(): panic() recursion detected
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        Rafael Aquini <aquini@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>, chenqiwu <chenqiwu@xiaomi.com>,
        Minchan Kim <minchan@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20201207124433.4017265-1-vladimir.kondratiev@linux.intel.com>
 <da3fece2-664c-0ac3-2d22-3ce29bf1bfa8@linux.intel.com>
 <87pn3ly5u3.fsf@x220.int.ebiederm.org>
From:   Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Message-ID: <f6f1208a-12c4-77b8-2e1d-fb4a03a2211a@linux.intel.com>
Date:   Mon, 7 Dec 2020 18:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87pn3ly5u3.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I see 2 paths how "bad things" can cause recursive do_exit - various 
traps that go through die() and therefore covered by panic_on_oops; and 
do_group_exit() as result of fatal signal.

Provided one add "panic on coredump" functionality, path through 
do_group_exit() covered as well.

Let's drop this patch.

Thanks, Vladimir

On 12/7/20 5:49 PM, Eric W. Biederman wrote:
> Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com> writes:
> 
>> Please ignore version 1 of the patch - it was sent from wrong mail address.
>>
>> To clarify the reason:
>>
>> Situation where do_exit() re-entered, discovered by static code analysis.
>> For safety critical system, it is better to panic() when minimal chance of
>> corruption detected. For this reason, we also panic on fatal signal delivery -
>> patch for this not submitted yet.
> 
> What did the static code analysis say?  What triggers the recursion.
> 
> What makes it safe to even call panic on this code path?  Is there
> enough kernel stack?
> 
> My sense is that if this actually can happen and is a real concern,
> and that it is safe to do something on this code path it is probably
> better just to ooops.  That way if someone is trying to debug such
> a recursion they will have a backtrace to work with.  Plus panic
> on oops will work.
> 
> Eric
> 
>>
>> On 12/7/20 2:44 PM, Vladimir Kondratiev wrote:
>>> Recursive do_exit() is symptom of compromised kernel integrity.
>>> For safety critical systems, it may be better to
>>> panic() in this case to minimize risk.
>>>
>>> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
>>> Change-Id: I42f45900a08c4282c511b05e9e6061360d07db60
>>> ---
>>>    Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>>>    include/linux/kernel.h                          | 1 +
>>>    kernel/exit.c                                   | 7 +++++++
>>>    kernel/sysctl.c                                 | 9 +++++++++
>>>    4 files changed, 23 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 44fde25bb221..6e12a6804557 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3508,6 +3508,12 @@
>>>    			bit 4: print ftrace buffer
>>>    			bit 5: print all printk messages in buffer
>>>    +	panic_on_exit_recursion
>>> +			panic() when do_exit() recursion detected, rather then
>>> +			try to stay running whenever possible.
>>> +			Useful on safety critical systems; re-entry in do_exit
>>> +			is a symptom of compromised kernel integrity.
>>> +
>>>    	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
>>>    			Format: <hex>[,nousertaint]
>>>    			Hexadecimal bitmask representing the set of TAINT flags
>>> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>>> index 2f05e9128201..5afb20534cb2 100644
>>> --- a/include/linux/kernel.h
>>> +++ b/include/linux/kernel.h
>>> @@ -539,6 +539,7 @@ extern int sysctl_panic_on_rcu_stall;
>>>    extern int sysctl_panic_on_stackoverflow;
>>>      extern bool crash_kexec_post_notifiers;
>>> +extern int panic_on_exit_recursion;
>>>      /*
>>>     * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
>>> diff --git a/kernel/exit.c b/kernel/exit.c
>>> index 1f236ed375f8..162799a8b539 100644
>>> --- a/kernel/exit.c
>>> +++ b/kernel/exit.c
>>> @@ -68,6 +68,9 @@
>>>    #include <asm/unistd.h>
>>>    #include <asm/mmu_context.h>
>>>    +int panic_on_exit_recursion __read_mostly;
>>> +core_param(panic_on_exit_recursion, panic_on_exit_recursion, int, 0644);
>>> +
>>>    static void __unhash_process(struct task_struct *p, bool group_dead)
>>>    {
>>>    	nr_threads--;
>>> @@ -757,6 +760,10 @@ void __noreturn do_exit(long code)
>>>    	 */
>>>    	if (unlikely(tsk->flags & PF_EXITING)) {
>>>    		pr_alert("Fixing recursive fault but reboot is needed!\n");
>>> +		if (panic_on_exit_recursion)
>>> +			panic("Recursive do_exit() detected in %s[%d]\n",
>>> +			      current->comm, task_pid_nr(current));
>>> +
>>>    		futex_exit_recursive(tsk);
>>>    		set_current_state(TASK_UNINTERRUPTIBLE);
>>>    		schedule();
>>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>>> index afad085960b8..bb397fba2c42 100644
>>> --- a/kernel/sysctl.c
>>> +++ b/kernel/sysctl.c
>>> @@ -2600,6 +2600,15 @@ static struct ctl_table kern_table[] = {
>>>    		.extra2		= &one_thousand,
>>>    	},
>>>    #endif
>>> +	{
>>> +		.procname	= "panic_on_exit_recursion",
>>> +		.data		= &panic_on_exit_recursion,
>>> +		.maxlen		= sizeof(int),
>>> +		.mode		= 0644,
>>> +		.proc_handler	= proc_dointvec_minmax,
>>> +		.extra1		= SYSCTL_ZERO,
>>> +		.extra2		= SYSCTL_ONE,
>>> +	},
>>>    	{
>>>    		.procname	= "panic_on_warn",
>>>    		.data		= &panic_on_warn,
>>>
