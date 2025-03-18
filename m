Return-Path: <linux-fsdevel+bounces-44312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A324EA67275
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 12:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41613A3C0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941620ADE6;
	Tue, 18 Mar 2025 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QVgvFXCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F61209F32;
	Tue, 18 Mar 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296801; cv=none; b=NFJAod7yHFlkdPEtAcGD0a8VpW/ttnT2RMq5jtUGUJ9wdChPJJoJOKc6Hqq+tpVDgcK6ALBYsXZzlnL7lNSAMFd6V0DgrkyErbqOzpG6YXxq+MOTDbSviTX7Adi0ioS77Nw2w4dimnB9nYxNHGv+v4uQ9ZVowcCZ360E7yLQNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296801; c=relaxed/simple;
	bh=YV1JHVxz8NuwH6aGsDylRmmy3YqPpEpoYghJFRZw8zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3ZhWz16UYfqhkL+f9vLFMIcx5jA0uuywQCaOXI3P61903d6KxQ9u7T7XQb5c1/brfHBgJrEyUlcDRj/pkh/NOMuc86jsJ4upRUMskEkXkx3CIz7jwFvsKjjiMGPlRcMyR3yanxfE67YKXcAIwxplf8AO2lVMwYBtXuKrxbJDY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QVgvFXCY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hgkuz267b67SX+QM0W1jzr7EXhcboJpgPAQwlzu1erE=; b=QVgvFXCYTJl4+9Vf0VRaVN892p
	Ugnl2V4H0E7oMDa5wTSJFhD3Ic4LgwEpDzYh+XQoA30GvMLWVEbkDxDxAiR0EGku0/ObwJixGuR4U
	EMkNFaPzZRjpv28BXwkdsrzz6pcUvomjPAXX3i5E//wOkW3o2zgeu9pcBb55rQB38pfYSC34QMPQN
	rI21IZBslc9xdp5oTeMEwlcfnz8E4hp7WmTZEL6pVorsizA6kTgi53Lbx8zRgyiaN3DyDvfiMzNaQ
	hr64ob7YwQFoqo/uWj8pqc94Zag3D8XQ3TLAanesyUyBimCocC/sUzmb4r+VsiEMQqyeo4xxUG1z7
	FBt2bi+A==;
Received: from [223.233.71.8] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tuUz1-002g2U-L9; Tue, 18 Mar 2025 12:19:43 +0100
Message-ID: <8b11d5f6-bb16-7af6-8377-bb0951fcfb60@igalia.com>
Date: Tue, 18 Mar 2025 16:49:28 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH RFC 0/2] Dynamically allocate memory to store task's full
 name
Content-Language: en-US
To: Andres Rodriguez <andresx7@gmail.com>, Kees Cook <kees@kernel.org>,
 Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
References: <20250314052715.610377-1-bhupesh@igalia.com>
 <202503141420.37D605B2@keescook>
 <a73ea646-0a24-474a-9e14-d59ea5eaa662@gmail.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <a73ea646-0a24-474a-9e14-d59ea5eaa662@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the review and inputs on the additional possible use-cases.
Please see my replies inline.

On 3/15/25 1:13 PM, Andres Rodriguez wrote:
>
>
> On 3/14/25 14:25, Kees Cook wrote:
>> On Fri, Mar 14, 2025 at 10:57:13AM +0530, Bhupesh wrote:
>>> While working with user-space debugging tools which work especially
>>> on linux gaming platforms, I found that the task name is truncated due
>>> to the limitation of TASK_COMM_LEN.
>>>
>>> For example, currently running 'ps', the task->comm value of a long
>>> task name is truncated due to the limitation of TASK_COMM_LEN.
>>>      create_very_lon
>>>
>>> This leads to the names passed from userland via pthread_setname_np()
>>> being truncated.
>>
>> So there have been long discussions about "comm", and it mainly boils
>> down to "leave it alone". For the /proc-scraping tools like "ps" and
>> "top", they check both "comm" and "cmdline", depending on mode. The more
>> useful (and already untruncated) stuff is in "cmdline", so I suspect it
>> may make more sense to have pthread_setname_np() interact with that
>> instead. Also TASK_COMM_LEN is basically considered userspace ABI at
>> this point and we can't sanely change its length without breaking the
>> world.
>>
>
> Completely agree that comm is best left untouched. TASK_COMM_LEN is 
> embedded into the kernel and the pthread ABI changes here should be 
> avoided.
>

So, basically my approach _does not_ touch TASK_COMM_LEN at all. The 
normal 'TASK_COMM_LEN' 16byte design remains untouched.
Which means that all the legacy / existing ABi which uses 'task->comm' 
and hence are designed / written to handle 'TASK_COMM_LEN' 16-byte name, 
continue to work as before using '/proc/$pid/task/$tid/comm'.

This change-set only adds a _parallel_ dynamically allocated 
'task->full_name' which can be used by interested users via 
'/proc/$pid/task/$tid/full_name'.

[PATCH 2/2] shows only a possible use-case of the same and can be 
dropped with only [PATCH 1/2] being considered to add the 
'/proc/$pid/task/$tid/full_name' interface.
>> Best to use /proc/$pid/task/$tid/cmdline IMO...
>
> Your recommendation works great for programs like ps and top, which are
> the examples proposed in the cover letter. However, I think the 
> opening email didn't point out use cases where the name is modified at 
> runtime. In those cases cmdline would be an unsuitable solution as it 
> should remain immutable across the process lifetime. An example of 
> this use case would be to set a thread's name for debugging purposes 
> and then trying to query it via gdb or perf.
>
> I wrote a quick and dirty example to illustrate what I mean:
> https://github.com/lostgoat/tasknames
>
> I think an alternative approach could be to have a separate entry in 
> procfs to store a tasks debug name (and leave comm completely 
> untouched), e.g. /proc/$pid/task/$tid/debug_name. This would allow 
> userspace apps to be updated with the following logic:
>
> get_task_debug_name() {
>     if ( !is_empty( debug_name ) )
>         return debug_name;
>     return comm;
> }
>
> "Legacy" userspace apps would remain ABI compatible as they would just 
> fall back to comm. And apps that want to opt in to the new behaviour 
> can be updated one at a time. Which would be work intensive, but even 
> just updating gdb and perf would be super helpful.

I am fine with adding either '/proc/$pid/task/$tid/full_name' or 
'/proc/$pid/task/$tid/debug_name' (actually both of these achieve the same).
The new / modified users (especially the debug applications you listed 
above) can switch easily to using '/proc/$pid/task/$tid/full_name' 
instead of ''/proc/$pid/task/$tid/comm'

AFAIK we already achieved for the kthreads using d6986ce24fc00 
("kthread: dynamically allocate memory to store kthread's full name"), 
which adds 'full_name' in parallel to 'comm' for kthread names.

Thanks,
Bhupesh

