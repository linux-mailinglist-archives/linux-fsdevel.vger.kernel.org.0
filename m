Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F383217C13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 02:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgGHAFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 20:05:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:45386 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgGHAFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:05:10 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jsxaC-0000bi-IL; Wed, 08 Jul 2020 02:05:04 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jsxaC-0009N2-5Q; Wed, 08 Jul 2020 02:05:04 +0200
Subject: Re: [PATCH v3 13/16] exit: Factor thread_group_exited out of
 pidfd_poll
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
 <20200702164140.4468-13-ebiederm@xmission.com>
 <20200703203021.paebx25miovmaxqt@ast-mbp.dhcp.thefacebook.com>
 <873668s2j8.fsf@x220.int.ebiederm.org>
 <20200704155052.kmrest5useyxcfnu@wittgenstein>
 <87mu4bjlqm.fsf@x220.int.ebiederm.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a84ec1df-dc9b-dd5b-cc34-385fd3ca1da4@iogearbox.net>
Date:   Wed, 8 Jul 2020 02:05:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87mu4bjlqm.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25866/Tue Jul  7 15:47:52 2020)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/7/20 7:09 PM, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
>> On Fri, Jul 03, 2020 at 04:37:47PM -0500, Eric W. Biederman wrote:
>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>>
>>>> On Thu, Jul 02, 2020 at 11:41:37AM -0500, Eric W. Biederman wrote:
>>>>> Create an independent helper thread_group_exited report return true
>>>>> when all threads have passed exit_notify in do_exit.  AKA all of the
>>>>> threads are at least zombies and might be dead or completely gone.
>>>>>
>>>>> Create this helper by taking the logic out of pidfd_poll where
>>>>> it is already tested, and adding a missing READ_ONCE on
>>>>> the read of task->exit_state.
>>>>>
>>>>> I will be changing the user mode driver code to use this same logic
>>>>> to know when a user mode driver needs to be restarted.
>>>>>
>>>>> Place the new helper thread_group_exited in kernel/exit.c and
>>>>> EXPORT it so it can be used by modules.
>>>>>
>>>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>>> ---
>>>>>   include/linux/sched/signal.h |  2 ++
>>>>>   kernel/exit.c                | 24 ++++++++++++++++++++++++
>>>>>   kernel/fork.c                |  6 +-----
>>>>>   3 files changed, 27 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>>>>> index 0ee5e696c5d8..1bad18a1d8ba 100644
>>>>> --- a/include/linux/sched/signal.h
>>>>> +++ b/include/linux/sched/signal.h
>>>>> @@ -674,6 +674,8 @@ static inline int thread_group_empty(struct task_struct *p)
>>>>>   #define delay_group_leader(p) \
>>>>>   		(thread_group_leader(p) && !thread_group_empty(p))
>>>>>   
>>>>> +extern bool thread_group_exited(struct pid *pid);
>>>>> +
>>>>>   extern struct sighand_struct *__lock_task_sighand(struct task_struct *task,
>>>>>   							unsigned long *flags);
>>>>>   
>>>>> diff --git a/kernel/exit.c b/kernel/exit.c
>>>>> index d3294b611df1..a7f112feb0f6 100644
>>>>> --- a/kernel/exit.c
>>>>> +++ b/kernel/exit.c
>>>>> @@ -1713,6 +1713,30 @@ COMPAT_SYSCALL_DEFINE5(waitid,
>>>>>   }
>>>>>   #endif
>>>>>   
>>>>> +/**
>>>>> + * thread_group_exited - check that a thread group has exited
>>>>> + * @pid: tgid of thread group to be checked.
>>>>> + *
>>>>> + * Test if thread group is has exited (all threads are zombies, dead
>>>>> + * or completely gone).
>>>>> + *
>>>>> + * Return: true if the thread group has exited. false otherwise.
>>>>> + */
>>>>> +bool thread_group_exited(struct pid *pid)
>>>>> +{
>>>>> +	struct task_struct *task;
>>>>> +	bool exited;
>>>>> +
>>>>> +	rcu_read_lock();
>>>>> +	task = pid_task(pid, PIDTYPE_PID);
>>>>> +	exited = !task ||
>>>>> +		(READ_ONCE(task->exit_state) && thread_group_empty(task));
>>>>> +	rcu_read_unlock();
>>>>> +
>>>>> +	return exited;
>>>>> +}
>>>>
>>>> I'm not sure why you think READ_ONCE was missing.
>>>> It's different in wait_consider_task() where READ_ONCE is needed because
>>>> of multiple checks. Here it's done once.
>>>
>>> In practice it probably has no effect on the generated code.  But
>>> READ_ONCE is about telling the compiler not to be clever.  Don't use
>>> tearing loads or stores etc.  When all of the other readers are using
>>> READ_ONCE I just get nervous if we have a case that doesn't.
>>
>> That's not true. The only place where READ_ONCE(->exit_state) is used is
>> in wait_consider_task() and nowhere else. We had that discussion a while
>> ago where I or someone proposed to simply place a READ_ONCE() around all
>> accesses to exit_state for the sake of kcsan and we agreed that it's
>> unnecessary and not to do this.
>> But it obviously doesn't hurt to have it.
> 
> There is a larger discussion to be had around the proper handling of
> exit_state.
> 
> In this particular case because we are accessing exit_state with
> only rcu_read_lock protection, because the outcome of the read
> is about correctness, and because the compiler has nothing else
> telling it not to re-read exit_state, I believe we actually need
> the READ_ONCE.
> 
> At the same time it would take a pretty special compiler to want to
> reaccess that field in thread_group_exited.
> 
> I have looked through and I don't find any of the other access of
> exit_state where the result is about correctness (so that we care)
> and we don't hold tasklist_lock.
> 
> But I have removed the necessary wording from the commit comment.

Hey Eric, are you planning to push the final version into a topic branch
so it can be pulled into bpf-next as discussed earlier?

Thanks,
Daniel
