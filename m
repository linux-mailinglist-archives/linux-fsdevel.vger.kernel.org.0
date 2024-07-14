Return-Path: <linux-fsdevel+bounces-23645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA1930A63
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2024 16:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F144F281B16
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2024 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EB41386DA;
	Sun, 14 Jul 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UOxJtaa3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BE426296;
	Sun, 14 Jul 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720967640; cv=none; b=uI09LmuitEJgqjaWlMNc8spXgjs/kGXslOUWenEneNxlfRvlpQhmr76LYByhCauh3Cg3xQSSMEK0kUDO/EceVJmg5/qcuGOaawCl8uIfDtq4VmNDi0f2Lx/rque7SF4u0e8tJRAuGinERelHeWcPrdEPIvI+KVB9Mzbml/ywguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720967640; c=relaxed/simple;
	bh=Q0ggrqd6JrWRP4LMNYR10Qj0ncy8JE9oFaflcnlr4K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qt1JeLTty8ycfvIosZxFnPZYqPrPBxj14cekYh46FqoyUTxDCX9+A/7kjgAu1j3te84sNAjey9LYGsiasuFz7u18dtxmreWGm8G5uyMG3p87bXQiavUG7ePFAqCqJJt45h0Lwkx74WpiBjcyf/Iy6lrwOruVNWRuiUWpGI3FpmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UOxJtaa3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7D4E520B7165;
	Sun, 14 Jul 2024 07:33:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D4E520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720967632;
	bh=583exBE87er5wi2OkjlShNrw0hTE/HfFZ3UGUoxDu4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UOxJtaa3GSi5Wqs/8u7Ilei583xycFz8UEAppGArByVT9+2HpOtDEfh15LJpx1nUs
	 sPjk1HaYUY8zOlHrIIa/YQJskxjgJ3tK1s7qZW7NW3wTaZAztDehV0rp4AKClN2F72
	 bpgVv8QpuCdmUag7UlxGHNwS+fS6Hrg/vezm2WXw=
Message-ID: <d85b210a-6388-41a3-9c97-35eee0603c99@linux.microsoft.com>
Date: Sun, 14 Jul 2024 07:33:53 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] binfmt_elf, coredump: Log the reason of the failed
 core dumps
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, apais@linux.microsoft.com, ardb@kernel.org,
 bigeasy@linutronix.de, brauner@kernel.org, ebiederm@xmission.com,
 jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, nagvijay@microsoft.com, oleg@redhat.com,
 tandersen@netflix.com, vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240712215223.605363-1-romank@linux.microsoft.com>
 <20240712215223.605363-2-romank@linux.microsoft.com>
 <202407130840.67879B31@keescook>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <202407130840.67879B31@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/13/2024 9:31 AM, Kees Cook wrote:
> On Fri, Jul 12, 2024 at 02:50:56PM -0700, Roman Kisel wrote:
>> Missing, failed, or corrupted core dumps might impede crash
>> investigations. To improve reliability of that process and consequently
>> the programs themselves, one needs to trace the path from producing
>> a core dumpfile to analyzing it. That path starts from the core dump file
>> written to the disk by the kernel or to the standard input of a user
>> mode helper program to which the kernel streams the coredump contents.
>> There are cases where the kernel will interrupt writing the core out or
>> produce a truncated/not-well-formed core dump without leaving a note.
>>
>> Add logging for the core dump collection failure paths to be able to reason
>> what has gone wrong when the core dump is malformed or missing.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   fs/binfmt_elf.c          |  60 ++++++++++++++++-----
>>   fs/coredump.c            | 109 ++++++++++++++++++++++++++++++++-------
>>   include/linux/coredump.h |   8 ++-
>>   kernel/signal.c          |  22 +++++++-
>>   4 files changed, 165 insertions(+), 34 deletions(-)
>>
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index a43897b03ce9..cfe84b9436af 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -1994,8 +1994,11 @@ static int elf_core_dump(struct coredump_params *cprm)
>>   	 * Collect all the non-memory information about the process for the
>>   	 * notes.  This also sets up the file header.
>>   	 */
>> -	if (!fill_note_info(&elf, e_phnum, &info, cprm))
>> +	if (!fill_note_info(&elf, e_phnum, &info, cprm)) {
>> +		pr_err_ratelimited("Error collecting note info, core dump of %s(PID %d) failed\n",
>> +			current->comm, current->pid);
> 
> A couple things come to mind for me as I scanned through this:
> 
> - Do we want to report pid or tgid?
> - Do we want to report the global value or the current pid namespace
>    mapping?
> 
> Because I notice that the existing code:
> 
>>   			printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
>>   			       task_tgid_vnr(current), current->comm);
> 
> Is reporting tgid for current's pid namespace. We should be consistent.
> 
Thanks, will update the code to be consistent with the existing logging.

> I think all of this might need cleaning up first before adding new
> reports. We should consolidate the reporting into a single function so
> this is easier to extend in the future. Right now the proposed patch is
> hand-building the report, and putting pid/comm in different places (at
> the end, at the beginning, with/without "of", etc), which is really just
> boilerplate repetition.
100% agreed.

> 
> How about creating:
> 
> static void coredump_report_failure(const char *msg)
> {
> 	char comm[TASK_COMM_LEN];
> 
> 	task_get_comm(current, comm);
> 
> 	pr_warn_ratelimited("coredump: %d(%*pE): %s\n",
> 			    task_tgid_vnr(current), strlen(comm), comm, msg);
> }
> 
> Then in a new first patch, convert all the existing stuff:
> 
> 	printk(KERN_WARNING ...)
> 	pr_info(...)
> 	etc
> 
> Since even the existing warnings are inconsistent and don't escape
> newlines, etc. :)
> 
> Then in patch 2 use this to add the new warnings?
Absolutely love that! Couldn't possibly appreciate your help more :)

> 

-- 
Thank you,
Roman

