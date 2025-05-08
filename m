Return-Path: <linux-fsdevel+bounces-48459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 332C1AAF55D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 10:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B97BB503
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51661224249;
	Thu,  8 May 2025 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JcwEIG9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B107F21ABC8;
	Thu,  8 May 2025 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692278; cv=none; b=k+voEp/smmZgYch7NAVih+eARlC4B1LyQkzFgDHGPbveV4appGwCh2Zx9Qh8fG1IABCjy/qtlM5uqtnJox2px2hA11Ao8W2HfpgnfOpCMyN5Z7VBVLnNu1m0IOhIJwdriWgbObJsYWRni/mqOn2dA0ShFd9pkUBMsNyhybF/Ozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692278; c=relaxed/simple;
	bh=97pZaaaOitR15IX70aZeTjwWGkyDhPG3TUeJZ458ayI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsXtmBXteoqY3h4dUc5tUzuqrEzjhcDJq6lTVVyG1NPtslRXyWDiCFh4gLu4Hoh1duSSe1IZ3f2iNjJNXTZfGJWa7qaPOfnIIShPEWa0PZXKQD9OsFHLIUMdfbiVVTJQ/YRuMuTaLhI5MGY2coWfAcIBTjNzzZvpMDJCcs89qfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JcwEIG9f; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=er/gua2nYuCh2IM1eayDWyD5dOHJb+gewaGKUa5cYd4=; b=JcwEIG9fbF8SMGx3VlGe/u3emv
	Qukc17KRhhGWrk3XIc9BvHW0Ff6fiF1ULIKDsrpBZxw63iFYVx7G3Xd5fnr61FmvDp0KMRENKKU03
	l6qSZ9pIAkZeZzsB07BQzcm5HNniFhMzITTMfS2vWfB86pvU8j6LMzLfh2cA6dM9ZmBBy85v6/Zr+
	Y9O0Osieqwj9NYOnENzWQl50hJdHYNVC/ifNGLVzW4h+eu8UQHZYHgXeQRbzdgmlEgLzlB+hQGvbZ
	JRc4ngc+QX5Ij/JoRF1cPbwwkyzClFiGPIsgV1l776q3euPcIPmyn5RyZ5PwXdW6igeXXVdiN1kkE
	M+ZeX5Sw==;
Received: from [223.233.71.203] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uCwNs-0056Oz-Ou; Thu, 08 May 2025 10:17:48 +0200
Message-ID: <4af48ad5-1aa7-46d0-bfca-7779294e355c@igalia.com>
Date: Thu, 8 May 2025 13:47:39 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
Content-Language: en-US
To: Petr Mladek <pmladek@suse.com>, Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
References: <20250507110444.963779-1-bhupesh@igalia.com>
 <20250507110444.963779-3-bhupesh@igalia.com>
 <aBtSK5dFmtFXUaOE@pathway.suse.cz>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <aBtSK5dFmtFXUaOE@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Petr,

On 5/7/25 5:59 PM, Petr Mladek wrote:
> On Wed 2025-05-07 16:34:43, Bhupesh wrote:
>> As Linus mentioned in [1], currently we have several memcpy() use-cases
>> which use 'current->comm' to copy the task name over to local copies.
>> For an example:
>>
>>   ...
>>   char comm[TASK_COMM_LEN];
>>   memcpy(comm, current->comm, TASK_COMM_LEN);
>>   ...
>>
>> These should be modified so that we can later implement approaches
>> to handle the task->comm's 16-byte length limitation (TASK_COMM_LEN)
>> is a more modular way (follow-up patches do the same):
>>
>>   ...
>>   char comm[TASK_COMM_LEN];
>>   memcpy(comm, current->comm, TASK_COMM_LEN);
>>   comm[TASK_COMM_LEN - 1] = 0;
>>   ...
>>
>> The relevant 'memcpy()' users were identified using the following search
>> pattern:
>>   $ git grep 'memcpy.*->comm\>'
>>
>> [1]. https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/
>>
>> --- a/include/linux/coredump.h
>> +++ b/include/linux/coredump.h
>> @@ -53,7 +53,8 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
>>   	do {	\
>>   		char comm[TASK_COMM_LEN];	\
>>   		/* This will always be NUL terminated. */ \
>> -		memcpy(comm, current->comm, sizeof(comm)); \
>> +		memcpy(comm, current->comm, TASK_COMM_LEN); \
>> +		comm[TASK_COMM_LEN] = '\0'; \
> I would expect that we replace this with a helper function/macro
> which would do the right thing.
>
> Why is get_task_comm() not used here, please?
>
>>   		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
> Also the name seems to be used for printing a debug information.
> I would expect that we could use the bigger buffer here and print
> the "full" name. Is this planed, please?
>
>>   			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
>>   	} while (0)	\
>> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
>> index bd0ea07338eb..94a941ac2034 100644
>> --- a/include/trace/events/block.h
>> +++ b/include/trace/events/block.h
>> @@ -214,6 +214,7 @@ DECLARE_EVENT_CLASS(block_rq,
>>   		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
>>   		__get_str(cmd)[0] = '\0';
>>   		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
>> +		__entry->comm[TASK_COMM_LEN - 1] = '\0';
> Same for all other callers.
>
> That said, I am not sure if the larger buffer is save in all situations.
>
>>   	),
>

Thanks for the review, I agree on using the helper / wrapper function to 
replace this open-coded memcpy + set last entry as '\0'.

However I see that Steven has already shared a RFC approach (see [1]), 
to use __string() instead of fixed lengths for 'task->comm' for tracing 
events.
I plan to  rebase my v4 on top of his RFC, which might mean that this 
patch would no longer be needed in the v4.

[1]. 
https://lore.kernel.org/linux-trace-kernel/20250507133458.51bafd95@gandalf.local.home/

Regards,
Bhupesh

