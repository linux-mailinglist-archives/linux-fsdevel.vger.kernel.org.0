Return-Path: <linux-fsdevel+bounces-45723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E41DA7B7D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928113B6C09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469842AB4;
	Fri,  4 Apr 2025 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VLtktzyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F9847B;
	Fri,  4 Apr 2025 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743748549; cv=none; b=IzSJel+XuOqdbmmkaKkVzQN0wuur9nlZlGUAYEaX44wQjTMzhWSoR0wMPnYynniIrvOGrrr2c/LeoscFU1n8hSuae+3uNXWxexIUSH5e2n7ARKzvhSf9dDJpS8CjWAyw7IcvRFKTrX215Rpi8LQd5OBvl1uE8IErmtH8FJ9kPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743748549; c=relaxed/simple;
	bh=hD8174uOH2T+lsYS2evpeGfkcl1Wpip1zHGbv8j2Ef8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqBtrXnrax2vdCgMJb8G/Y62IDbhlsXSgMjbKpdPsWcAcScbVaja0Gnec65rD8+NszaMbInTo60q9mPOKk12wx69ID4rvMkdFU+U7CFKKHnjy8NFTIDpAaaLfWUHjkgKKWlQy00tE3I0ZU+qG1munhVxk0uEP394kgjIJVmqIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VLtktzyg; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0rog/nxboMHnwuFuI69UvOFfP3CGYosW55e+1Io3x50=; b=VLtktzygHenGP22YTGx9UMPXIs
	obpPCT9aIas2r7evBpL2D0bb1js6q0i/B4uC2opnWfDUipcfONy+0g0IbelLJS8aWQuyS2PsuDIdm
	7w0cjzbWLsM7LHRK3mT51Cc3k9Ln/ZQIsH1KX/wq6HZzUcbB72ZYToUAJurnXWcFJEdpGZUbdw3BA
	eh4hfAftwtmwzZFx1nZQs65zJEKslflvY7h601Fs48wxfKauy8fCWwVUIJ5I1FVouXn1lFW/1ES93
	UOhDoOM9fSM2eyYscL3Uhqe7g8Qpi9xnwtjK0geFQUNqmvLdom5iBDTzulTdeQFl3ou1zbJmbqssb
	K7OyNpGw==;
Received: from [223.233.74.223] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u0aeJ-00BDab-Pv; Fri, 04 Apr 2025 08:35:32 +0200
Message-ID: <6beead5a-8c21-af57-0304-1bf825588481@igalia.com>
Date: Fri, 4 Apr 2025 12:05:26 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] exec: Dynamically allocate memory to store task's
 full name
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, Bhupesh <bhupesh@igalia.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, pmladek@suse.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
 ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
 juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com
References: <20250331121820.455916-1-bhupesh@igalia.com>
 <20250331121820.455916-2-bhupesh@igalia.com>
 <CALOAHbB51b-reG6+ypr43sBJ-QpQhF39r5WPjuEp5rgabgRmoA@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <CALOAHbB51b-reG6+ypr43sBJ-QpQhF39r5WPjuEp5rgabgRmoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/1/25 7:37 AM, Yafang Shao wrote:
> On Mon, Mar 31, 2025 at 8:18 PM Bhupesh <bhupesh@igalia.com> wrote:
>> Provide a parallel implementation for get_task_comm() called
>> get_task_full_name() which allows the dynamically allocated
>> and filled-in task's full name to be passed to interested
>> users such as 'gdb'.
>>
>> Currently while running 'gdb', the 'task->comm' value of a long
>> task name is truncated due to the limitation of TASK_COMM_LEN.
>>
>> For example using gdb to debug a simple app currently which generate
>> threads with long task names:
>>    # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>>    # cat log
>>
>>    NameThatIsTooLo
>>
>> This patch does not touch 'TASK_COMM_LEN' at all, i.e.
>> 'TASK_COMM_LEN' and the 16-byte design remains untouched. Which means
>> that all the legacy / existing ABI, continue to work as before using
>> '/proc/$pid/task/$tid/comm'.
>>
>> This patch only adds a parallel, dynamically-allocated
>> 'task->full_name' which can be used by interested users
>> via '/proc/$pid/task/$tid/full_name'.
>>
>> After this change, gdb is able to show full name of the task:
>>    # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>>    # cat log
>>
>>    NameThatIsTooLongForComm[4662]
>>
>> Signed-off-by: Bhupesh <bhupesh@igalia.com>
>> ---
>>   fs/exec.c             | 21 ++++++++++++++++++---
>>   include/linux/sched.h |  9 +++++++++
>>   2 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index f45859ad13ac..4219d77a519c 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1208,6 +1208,9 @@ int begin_new_exec(struct linux_binprm * bprm)
>>   {
>>          struct task_struct *me = current;
>>          int retval;
>> +       va_list args;
>> +       char *name;
>> +       const char *fmt;
>>
>>          /* Once we are committed compute the creds */
>>          retval = bprm_creds_from_file(bprm);
>> @@ -1348,11 +1351,22 @@ int begin_new_exec(struct linux_binprm * bprm)
>>                   * detecting a concurrent rename and just want a terminated name.
>>                   */
>>                  rcu_read_lock();
>> -               __set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
>> -                               true);
>> +               fmt = smp_load_acquire(&bprm->file->f_path.dentry->d_name.name);
>> +               name = kvasprintf(GFP_KERNEL, fmt, args);
>> +               if (!name)
>> +                       return -ENOMEM;
>> +
>> +               me->full_name = name;
>> +               __set_task_comm(me, fmt, true);
>>                  rcu_read_unlock();
>>          } else {
>> -               __set_task_comm(me, kbasename(bprm->filename), true);
>> +               fmt = kbasename(bprm->filename);
>> +               name = kvasprintf(GFP_KERNEL, fmt, args);
>> +               if (!name)
>> +                       return -ENOMEM;
>> +
>> +               me->full_name = name;
>> +               __set_task_comm(me, fmt, true);
>>          }
>>
>>          /* An exec changes our domain. We are no longer part of the thread
>> @@ -1399,6 +1413,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>>          return 0;
>>
>>   out_unlock:
>> +       kfree(me->full_name);
>>          up_write(&me->signal->exec_update_lock);
>>          if (!bprm->cred)
>>                  mutex_unlock(&me->signal->cred_guard_mutex);
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 56ddeb37b5cd..053b52606652 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1166,6 +1166,9 @@ struct task_struct {
>>           */
>>          char                            comm[TASK_COMM_LEN];
>>
>> +       /* To store the full name if task comm is truncated. */
>> +       char                            *full_name;
>> +
> Adding another field to store the task name isn’t ideal. What about
> combining them into a single field, as Linus suggested [0]?
>
> [0]. https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/
>

Thanks for sharing Linus's suggestion. I went through the suggested 
changes in the related threads and came up with the following set of points:

1. struct task_struct would contain both 'comm' and 'full_name',
2. Remove the task_lock() inside __get_task_comm(),
3. Users of task->comm will be affected in the following ways:
     (a). Printing with '%s' and tsk->comm would just continue to 
work,but will get a longer max string.
     (b). For users of memcpy.*->comm\>', we should change 'memcpy()' to 
'copy_comm()' which would look like:

         memcpy(dst, src, TASK_COMM_LEN);
         dst[TASK_COMM_LEN-1] = 0;

    (c). Users which use "sizeof(->comm)" will continue to get the old value because of the hacky union.

Am I missing something here. Please let me know your views.

Thanks,
Bhupesh


