Return-Path: <linux-fsdevel+bounces-21893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B34A90D93F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 18:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4421C232E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 16:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32BC74070;
	Tue, 18 Jun 2024 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rHPsVjEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE98817547;
	Tue, 18 Jun 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728223; cv=none; b=Vuq/XKTzniDyHXc3wKHKtLcX6tF03VZU2SgS5Fmd/bmyFliFHah2nBb55BmbMzmrfbg46SofP8JLY+3YcoQOwc9FKt2TyLurp0bvAGGbpbWqUZVVdrRZUXXLccManra57BGByvdcx46sDMt71cE59OcVuQ8X5a+8Y5m3TOi8HaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728223; c=relaxed/simple;
	bh=SNpnXxuoqkntl4TwovY9awZfwyGvxXF2nfqcm7BBXhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6oXpaP6czVHbndxxxrz28v/8HS1TLzRMoDyUu0EfmX1jE+jC4fvSgwpQZ0rijmWN9vWr373muSgLmtiTvbic6719tmEXyB57KNAWQFtvSnEvUncGO3xGOkhhS8Nv2MyH1WzWXmiidWgKM/zXEo1o/mi1Qqf4pbAgDFfekUbX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rHPsVjEv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 544A820B7004;
	Tue, 18 Jun 2024 09:30:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 544A820B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718728221;
	bh=zsWyE7pQpHsy2X7xLQo7Ux0lg6ohXA0arRFNqZSXJ/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rHPsVjEv7/3yYeYORATmcWOOSVlzVn5PbFiDB5/Zem1Aicik7aG2W4Up3iJLogRh7
	 e+o/cFbqOCiSsyl8MRWxlRfzP4vF/I4Gc2kvpM0ym6D4Ttxv6u9WxEyRli2nL7MY3c
	 4mUH4MTlWfys13bAKCPsHl6COJJ7/NmiEZYGHmQE=
Message-ID: <c4644f2c-fad3-4d98-8301-acdc0ff2f3a6@linux.microsoft.com>
Date: Tue, 18 Jun 2024 09:30:22 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed
 core dumps
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: akpm@linux-foundation.org, apais@linux.microsoft.com, ardb@kernel.org,
 brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz,
 keescook@chromium.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nagvijay@microsoft.com,
 oleg@redhat.com, tandersen@netflix.com, vincent.whitchurch@axis.com,
 viro@zeniv.linux.org.uk, apais@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240617234133.1167523-1-romank@linux.microsoft.com>
 <20240617234133.1167523-2-romank@linux.microsoft.com>
 <20240618061849.Vh9N3ds2@linutronix.de>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240618061849.Vh9N3ds2@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/2024 11:18 PM, Sebastian Andrzej Siewior wrote:
> On 2024-06-17 16:41:30 [-0700], Roman Kisel wrote:
>> Missing, failed, or corrupted core dumps might impede crash
>> investigations. To improve reliability of that process and consequently
>> the programs themselves, one needs to trace the path from producing
>> a core dumpfile to analyzing it. That path starts from the core dump file
>> written to the disk by the kernel or to the standard input of a user
>> mode helper program to which the kernel streams the coredump contents.
>> There are cases where the kernel will interrupt writing the core out or
>> produce a truncated/not-well-formed core dump.
> 
> How much of this happened and how much of this is just "let me handle
> everything that could go wrong".
Some of that must be happening as there are truncated dump files. 
Haven't run the logging code at large scale yet with the systems being 
stressed a lot by the customer workloads to hit all edge cases. Sent the 
changes to the kernel mail list out of abundance of caution first, and 
being ecstatic about that: on the other thread Kees noticed I didn't use 
the ratelimited logging. That has absolutely made me day and whole week, 
just glowing :) Might've been a close call due to something in a crash loop.

I think it'd be fair to say that I am asking to please "let me handle 
(log) everything that could go wrong", ratelimited, as these error cases 
are present in the code, and logging can give a clue why the core dump 
collection didn't succeed and what one would need to explore to increase 
reliability of the system.

> The cases where it was interrupted without a hint probably deserve a
> note rather then leaving a half of coredump back.
Wholeheartedly agree!

> 
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> diff --git a/fs/coredump.c b/fs/coredump.c
>> index a57a06b80f57..a7200c9024c6 100644
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -777,9 +807,18 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>   		}
>>   		file_end_write(cprm.file);
>>   		free_vma_snapshot(&cprm);
>> +	} else {
>> +		pr_err("Core dump to |%s has been interrupted\n", cn.corename);
>> +		retval = -EAGAIN;
>> +		goto fail;
>>   	}
>> +	pr_info("Core dump to |%s: vma_count %d, vma_data_size %lu, written %lld bytes, pos %lld\n",
>> +		cn.corename, cprm.vma_count, cprm.vma_data_size, cprm.written, cprm.pos);
> 
> Probably too noisy in the default case. The offsets probably don't
> matter unless you debug.
Will make less noisy, thanks!

> 
>>   	if (ispipe && core_pipe_limit)
>>   		wait_for_dump_helpers(cprm.file);
>> +
>> +	retval = 0;
>> +
>>   close_fail:
>>   	if (cprm.file)
>>   		filp_close(cprm.file, NULL);
>> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
>> index 0904ba010341..8b29be758a87 100644
>> --- a/include/linux/coredump.h
>> +++ b/include/linux/coredump.h
>> @@ -42,9 +42,9 @@ extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
>>   extern int dump_align(struct coredump_params *cprm, int align);
>>   int dump_user_range(struct coredump_params *cprm, unsigned long start,
>>   		    unsigned long len);
>> -extern void do_coredump(const kernel_siginfo_t *siginfo);
>> +extern int do_coredump(const kernel_siginfo_t *siginfo);
>>   #else
>> -static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
>> +static inline int do_coredump(const kernel_siginfo_t *siginfo) {}
> 
> This probably does not compile.
D'oh! It does compile, and somehow the warning didn't show up for me. 
Fortunately, you and the kernel robot noticed that one silly piece I 
wrote here. Thank you very much!

For the inclined reader, both C99 and C11 require just these two things 
of the "return" statement (6.8.6.4 The return statement/Constraints):

"A return statement with an expression shall not appear in a function 
whose return type is void. A return statement without an expression 
shall only appear in a function whose return type is void".

One can omit the "return" statement in which case a warning is emitted 
(by gcc), and instead of "ret", gcc emits "ud2" or "brk #0x1000" or 
"trap", etc. to cause a fault.

> 
>>   #endif
>>   
>>   #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 1f9dd41c04be..f2ecf29a994d 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2675,6 +2675,7 @@ bool get_signal(struct ksignal *ksig)
>>   	struct sighand_struct *sighand = current->sighand;
>>   	struct signal_struct *signal = current->signal;
>>   	int signr;
>> +	int ret;
>>   
>>   	clear_notify_signal();
>>   	if (unlikely(task_work_pending(current)))
>> @@ -2891,7 +2892,9 @@ bool get_signal(struct ksignal *ksig)
>>   			 * first and our do_group_exit call below will use
>>   			 * that value and ignore the one we pass it.
>>   			 */
>> -			do_coredump(&ksig->info);
>> +			ret = do_coredump(&ksig->info);
>> +			if (ret)
>> +				pr_err("coredump has not been created, error %d\n", ret);
> 
> So you preserve the error code just for one additional note.
Couldn't see how not to do that and report the error code... Might move 
the declaration closer to the point of use, into the innermost 
enclosing/basic block. The C standard used by the kernel permits mixed 
declaration and code, yet not much of that seems to be actually used and 
I hesitated to do

		if (sig_kernel_coredump(signr)) {
			if (print_fatal_signals)
				print_fatal_signal(signr);
			proc_coredump_connector(current);
-			do_coredump(&ksig->info);
+			int ret = do_coredump(&ksig->info);
+			if (ret)
+				pr_err("coredump has not been created, error %d\n", ret);

Feel like moving the declaration inside that "if" statement if that 
looks better.

> 
>>   		}
>>   
>>   		/*
> 
> Sebastian

-- 
Thank you,
Roman

