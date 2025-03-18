Return-Path: <linux-fsdevel+bounces-44348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F291BA67BA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 19:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2998188DAA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846FA21322B;
	Tue, 18 Mar 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DBzlswaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB52212B07;
	Tue, 18 Mar 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321227; cv=none; b=iYTitGZ+ICqTcbh38BM2r1cyXLK08wU/y0cNXMby34rYAEajgKXjiF4FPaIZ2nNZ2bJw1qVgBfhwv5Ap0vElmibgPm3GQpntsuGJJvUeGtumDP/m93KtX+zLcpfxQgMVz6cAUIUOsF2Qbb/JO6oa6YKQ25azc1lDmYJjnBo6ezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321227; c=relaxed/simple;
	bh=ObvK4V5+WTs9GjlkzhLf22kOTTKhjSK/UvNK71fc+iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avuzkEjro65qZSENMPFIXhXmm1KWMlREGug9aBqD2gtfuOvF3Sp53YeBwgMvMCMzQW6md4TJzqsKmI8KEaweCCH92ELIyD0jy7O7JLuNTjJjXo0XNNyGUth5Z/6jmYxwYZ3Chd2EqSHvN2CenYdiaAuXiV0Wd0/RclVy6YQBS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DBzlswaw; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xi5z/098n3s55drfJnQC0KGieJT8vR+QHgsSyHMCSwc=; b=DBzlswawCpcdwZoCIaLOvmz4bR
	f0qEhXAdTinfikQUSQKatFmc4DOOS06n8K1sJFrOSNcUeLsXDHdJtNOOqIoE8tMVCawIxhjr7V0il
	wj7gIb8Wa/bOAL4CwOk29espYzdobGhMYvbkCHF6VHxQtcfoa7ax0Pyk3HAHtUSu/fg/xTpJm1xTt
	IiNOB4hK2IvroqdJaIkKfy3UKumgrzzhUswjeq0+prccirjOKyNlc3/hOJZX8zgnN5eKsjqjMl02e
	ARHGKMUHhTSXc/fvmwe4vsdSRTzB13/2bXVwzUV6PAVlRDiOf2K221sWXTZQAwmOS33ro4q6Qysbs
	/dIdWobg==;
Received: from [223.233.76.123] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tubKz-002s83-Kp; Tue, 18 Mar 2025 19:06:49 +0100
Message-ID: <24766119-3aa2-fe88-878a-90a2794cca8f@igalia.com>
Date: Tue, 18 Mar 2025 23:36:40 +0530
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
To: Kees Cook <kees@kernel.org>
Cc: Andres Rodriguez <andresx7@gmail.com>, Bhupesh <bhupesh@igalia.com>,
 akpm@linux-foundation.org, kernel-dev@igalia.com,
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
 <8b11d5f6-bb16-7af6-8377-bb0951fcfb60@igalia.com>
 <202503180846.EAB79290D@keescook>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <202503180846.EAB79290D@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kees,

On 3/18/25 9:21 PM, Kees Cook wrote:
> On Tue, Mar 18, 2025 at 04:49:28PM +0530, Bhupesh Sharma wrote:
>> On 3/15/25 1:13 PM, Andres Rodriguez wrote:
>>> On 3/14/25 14:25, Kees Cook wrote:
>>>> On Fri, Mar 14, 2025 at 10:57:13AM +0530, Bhupesh wrote:
>>>>> While working with user-space debugging tools which work especially
>>>>> on linux gaming platforms, I found that the task name is truncated due
>>>>> to the limitation of TASK_COMM_LEN.
>>>>>
>>>>> For example, currently running 'ps', the task->comm value of a long
>>>>> task name is truncated due to the limitation of TASK_COMM_LEN.
>>>>>       create_very_lon
>>>>>
>>>>> This leads to the names passed from userland via pthread_setname_np()
>>>>> being truncated.
>>>> So there have been long discussions about "comm", and it mainly boils
>>>> down to "leave it alone". For the /proc-scraping tools like "ps" and
>>>> "top", they check both "comm" and "cmdline", depending on mode. The more
>>>> useful (and already untruncated) stuff is in "cmdline", so I suspect it
>>>> may make more sense to have pthread_setname_np() interact with that
>>>> instead. Also TASK_COMM_LEN is basically considered userspace ABI at
>>>> this point and we can't sanely change its length without breaking the
>>>> world.
>>>>
>>> Completely agree that comm is best left untouched. TASK_COMM_LEN is
>>> embedded into the kernel and the pthread ABI changes here should be
>>> avoided.
>>>
>> So, basically my approach _does not_ touch TASK_COMM_LEN at all. The normal
>> 'TASK_COMM_LEN' 16byte design remains untouched.
>> Which means that all the legacy / existing ABi which uses 'task->comm' and
>> hence are designed / written to handle 'TASK_COMM_LEN' 16-byte name,
>> continue to work as before using '/proc/$pid/task/$tid/comm'.
>>
>> This change-set only adds a _parallel_ dynamically allocated
>> 'task->full_name' which can be used by interested users via
>> '/proc/$pid/task/$tid/full_name'.
> I don't want to add this to all processes at exec time as the existing
> solution works for those processes: read /proc/$pid/cmdline.
>
> That said, adding another pointer to task_struct isn't to bad I guess,
> and it could be updated by later calls. Maybe by default it just points
> to "comm".
Sure.

>
>> I am fine with adding either '/proc/$pid/task/$tid/full_name' or
>> '/proc/$pid/task/$tid/debug_name' (actually both of these achieve the same).
>> The new / modified users (especially the debug applications you listed
>> above) can switch easily to using '/proc/$pid/task/$tid/full_name' instead
>> of ''/proc/$pid/task/$tid/comm'
>>
>> AFAIK we already achieved for the kthreads using d6986ce24fc00 ("kthread:
>> dynamically allocate memory to store kthread's full name"), which adds
>> 'full_name' in parallel to 'comm' for kthread names.
> If we do this for task_struct, we should remove "full_name" from kthread
> and generalize it for all processes.
>
Got it. Ok, let me rework the series so that we have a unified 
'full_name' inside 'task_struct' and have kthread use it as well.

I will send a v2 accordingly.

Thanks,
Bhupesh

