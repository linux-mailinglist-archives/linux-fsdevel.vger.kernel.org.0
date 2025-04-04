Return-Path: <linux-fsdevel+bounces-45718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E84A7B766
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 07:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D912A178D4B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1616A395;
	Fri,  4 Apr 2025 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iXesTLYp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184ED2E62C0;
	Fri,  4 Apr 2025 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743745027; cv=none; b=NAjuS203K0C+Aifjmagixeqka9k7PM3Hgg8kKgK6baaKqPQvfq68V7YbhXq27uCMw8drszBWR2mVUYsgyIcsQQ8aTR3tfuDbXPUANAC2md8wC8TId/CmsdSUAN/2dHRi84ORq84DtDOjf3MzmH/MxrhX7HEFSXx/9EjwS+HOqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743745027; c=relaxed/simple;
	bh=eMsiF/PXoai0KvDHU7yXTnPdYeGeIe/AIWfCyoMZMcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BX0oKfMmp8jo7/RupoialKmZjj9lxkmGI9dUxm6n/tZwjnz0fPZB3AxOJpA7LdXfn5AXA5uEV/OUbaJDXrVTL1yQvmYI9/fBhsuDeEZZb6yxCi/gsB4vDr0PR/P/or7FCtB34fFST+u08cEJ5gfoylkrjsYPpkTVOftPh/sqNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iXesTLYp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RJ6sJSRTRl9f2sZO8e6I1tdZqgXHwuW7syCheEXJI80=; b=iXesTLYpmAC7VnKZcqwzWpaBMr
	+BjlrXU93j2nnBgWxooZfjJgUfl5Evpo0stzq6D2PRnPg17LRd1iUGHQLn52CF5XjyGL5UNSFzHbf
	JPKPCo/VWr+iyn89AlTv0SBwY4vv/I1EN+lFPdhbg47mAxFgPtMYzLs6PTjGwr5S6eVfboNa31UMy
	eliDl/+0VjIcxwD8y7zhtGv1a/nu24osG1SG3saWbE8klvXekMID1DobWqI0xvINcpn9xVpQlL9vf
	ANjhs9vuySDsxA8cPjPQEkotsnRrFDO8Nt8xrPZgJox5OxJ18R6NFrkDms8qrPTemGH5d5iUIaUka
	xIAQ1tjg==;
Received: from [223.233.74.223] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u0Zjb-00BC68-IJ; Fri, 04 Apr 2025 07:36:55 +0200
Message-ID: <04038132-2edf-f13e-86f9-449cb7426104@igalia.com>
Date: Fri, 4 Apr 2025 11:06:50 +0530
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
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
References: <20250331121820.455916-1-bhupesh@igalia.com>
 <20250331121820.455916-2-bhupesh@igalia.com>
 <CAEf4Bza1xjSD9KPkB0gE6AN0vc=xejW-jkn0M_Z_pSQ4_7e7Jw@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <CAEf4Bza1xjSD9KPkB0gE6AN0vc=xejW-jkn0M_Z_pSQ4_7e7Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/3/25 9:47 PM, Andrii Nakryiko wrote:
> On Mon, Mar 31, 2025 at 5:18 AM Bhupesh <bhupesh@igalia.com> wrote:
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
> this `args` argument, it's not initialized anywhere, right? It's not
> clear where it's coming from, but you are passing it directly into
> kvasprintf(), I can't convince myself that this is correct. Can you
> please explain what is happening here?
>
> Also, instead of allocating a buffer unconditionally, maybe check that
> comm is longer than 16, and if not, just use the old-schoold 16-byte
> comm array?

Ok. As Kees also mentioned in his comment, I will try to do away with
the allocation in the exec() hot-path in v3.

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
>>          struct nameidata                *nameidata;
>>
>>   #ifdef CONFIG_SYSVIPC
>> @@ -2007,6 +2010,12 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
>>          buf;                                            \
>>   })
>>
>> +#define get_task_full_name(buf, buf_size, tsk) ({      \
>> +       BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);      \
>> +       strscpy_pad(buf, (tsk)->full_name, buf_size);   \
>> +       buf;                                            \
>> +})
>> +
>>   #ifdef CONFIG_SMP
>>   static __always_inline void scheduler_ipi(void)
>>   {
>> --
>> 2.38.1
>>

Thanks.

