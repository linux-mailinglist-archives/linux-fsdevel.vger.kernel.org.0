Return-Path: <linux-fsdevel+bounces-49762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72119AC22AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852C03B9FC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC9D17583;
	Fri, 23 May 2025 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dtTyykSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FADAE552;
	Fri, 23 May 2025 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003523; cv=none; b=GRJfuANkoH5tdyrqlNxq59cEwFlqwBf3Gns7SloyEHrpxwCjc/d6K3HPF3LTpscQS+H3feU0M5zij0C/7CAPJQwmLFLil+ASgbCep6PPaWSH0Hcreb2+kXjnnHfarXzCJITrw+9d3teUASRqFExO4nQB8JzIe9RVBeHnCoRBMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003523; c=relaxed/simple;
	bh=j0CL94Rb8NLPTthjduF/9Bmuzez0jW0NPtqEk9wPUBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pswo0odFB2QdP2BogO4d0RRAitpMVEeEQ9mGGSG24iYGvndxNJbXgzo3smTP2v8TphyPF0Lj9QOwI7Ysz/OqA4CFwCERcGXUm3Li/9RurBQgW48Vp4DuqhZ4Vmtkk5/QIM1G+Kt5+Xd3Hk3axvHmdhz8MmBs5yqVzwL6YRHD6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dtTyykSV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yO0EwDZrf4fd992J3B8iCK71Ip2ga1Ayg9UxqoNl3Zw=; b=dtTyykSVssYRpd4G7j3B1bGx7I
	XaQ18MuK8E645S1dcEUB3aD0MCqSWaQrM8s5x4zd7EMH21QPKvZLczSBuupJvoATKwLzkNDz0oKzu
	zRbXx08nyKMkS4pymGSq4SQkGRV4apCr3ONB78Zr+sphNCIq0b5ob9xUJVBTi4ubC2cBJjSY073Yg
	TlVq/YRLU9Q8wN57CZXZ59s6qDswZVnBXNVx9kQo/74OSSCd0nasd+9qRZOek6hwqtuzv+2YP6iek
	fyTrBrCqR79iZ46ueTEXEhkuBrtjifNRI9A58IN0M1VTKXjMtLMZi/CidjNG0DgWI0g/DPPgrACDo
	Fy4F4v/A==;
Received: from [223.233.76.245] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uIRZ1-00CB4g-9x; Fri, 23 May 2025 14:31:51 +0200
Message-ID: <a7c323fe-6d11-4a21-a203-bd60acbfd831@igalia.com>
Date: Fri, 23 May 2025 18:01:41 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/3] exec: Add support for 64 byte 'tsk->comm_ext'
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, Bhupesh <bhupesh@igalia.com>
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
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org
References: <20250521062337.53262-1-bhupesh@igalia.com>
 <20250521062337.53262-4-bhupesh@igalia.com>
 <202505222041.B639D482FB@keescook>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <202505222041.B639D482FB@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kees,

Thanks for the review.

On 5/23/25 9:18 AM, Kees Cook wrote:
> On Wed, May 21, 2025 at 11:53:37AM +0530, Bhupesh wrote:
>> Historically due to the 16-byte length of TASK_COMM_LEN, the
>> users of 'tsk->comm' are restricted to use a fixed-size target
>> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
>>
>> To fix the same, Linus suggested in [1] that we can add the
>> following union inside 'task_struct':
>>         union {
>>                 char    comm[TASK_COMM_LEN];
>>                 char    comm_ext[TASK_COMM_EXT_LEN];
>>         };
> I remain unconvinced that this is at all safe. With the existing
> memcpy() and so many places using %s and task->comm, this feels very
> very risky to me.
>
> Can we just make it separate, instead of a union? Then we don't have to
> touch comm at all.

I understand your apprehensions, but I think we have covered _almost_ 
all the existing use-cases as of now:

1. memcpy() users: Handled by [PATCH 2/3] of this series, where we 
identify existing users using the following search
     pattern:
        $ git grep 'memcpy.*->comm\>'

2. %s usage: I checked this at multiple places and can confirm that %s 
usage to print out 'tsk->comm' (as a string), get the longer
     new "extended comm".

3. users who do 'sizeof(->comm)' will continue to get the old value 
because of the union.

The problem with having two separate comms: tsk->comm and tsk->ext_comm, 
instead of a union is two fold:
(a). If we keep two separate statically allocated comms: tsk->comm and 
tsk->ext_comm in struct task_struct, we need to basically keep 
supporting backward compatibility / ABI via tsk->comm and ask new 
user-land users to move to tsk->ext_comm.

(b). If we keep one statically allocated comm: tsk->comm and one dynamically allocated tsk->ext_comm in struct task_struct, then we have the problem of allocating the tsk->ext_comm which _may_ be in the exec()  hot path.

I think the discussion between Linus and Yafang (see [1]), was more towards avoiding the approach in 3(a).

Also we discussed the 3(b) approach, during the review of v2 of this series, where there was a apprehensions around: adding another field to store the task name and allocating tsk->ext_comm dynamically in the exec() hot path (see [2]).

[1]. https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/
[2]. https://lore.kernel.org/lkml/CALOAHbB51b-reG6+ypr43sBJ-QpQhF39r5WPjuEp5rgabgRmoA@mail.gmail.com/

Please let me know your views.

Thanks,
Bhupesh

>> and then modify '__set_task_comm()' to pass 'tsk->comm_ext'
>> to the existing users.
> We can use set_task_comm() to set both still...
>


