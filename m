Return-Path: <linux-fsdevel+bounces-24094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C73F93944D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 21:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874EE1F2232E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 19:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C26F171085;
	Mon, 22 Jul 2024 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N62yEBdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429B316FF4E;
	Mon, 22 Jul 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676885; cv=none; b=ja0uhkFpfUmfCpsZ7tiN7T97etZfLX6KHBIssyb3ond7RxIBi4fB2tjG/LHDo2TeNK7lKG9n6xBq/oOr0fftpZtuE1LFn/5kTigZ31bTIz/moa7UlxIAxjfNC72Yu+CbuB8SerhOMJMu6kXVdOcPOuPhq24Agxea/xGeX4Ta698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676885; c=relaxed/simple;
	bh=RPxFfg3uTiX9+mevAadqkOMWa0BWobrzKEKan0TjrNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaGgRYkt0AS4tVy+ybdiw+G1A2KtzRX4hCPKQMCXpvi8VtYsrJyeDJ0Te8qBSH+baCl1jGczkDgqiPrcoRd0J250y4oPkRvf33RP8lb43g0SRVlVe+sLf2JFeM9LZPng9MDothjMMsQdgvmrEfS0gC8/0mb1y5no/VpL/hj8fJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N62yEBdW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id C341620B7165;
	Mon, 22 Jul 2024 12:34:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C341620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721676884;
	bh=FQmh/EYQknSmmbveLSRuVujcbnn6z8lPRt8o/jsxY58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N62yEBdW7/cLTjulRYqDD6iK3BoFHzexx4tC0R8sXdK08GwIa76rFsXh+kGP6AlYt
	 9eqDXlJjXi2JQ9VNHTS/Sam7QwRwFhuKO/amhyelpJaqaIObRg7Ui93xtpaAQHmfGi
	 yKlfLfloCM/qwgptOZ1tKqpUFsUicZ1fmavl7RZw=
Message-ID: <f43d094c-ff06-4821-90c6-6602afb443bc@linux.microsoft.com>
Date: Mon, 22 Jul 2024 12:34:44 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] coredump: Standartize and fix logging
To: Allen Pais <apais@linux.microsoft.com>
Cc: akpm@linux-foundation.org, ardb@kernel.org, bigeasy@linutronix.de,
 brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz,
 Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, nagvijay@microsoft.com, oleg@redhat.com,
 tandersen@netflix.com, vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk,
 Allen Pais <apais@microsoft.com>, benhill@microsoft.com,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240718182743.1959160-1-romank@linux.microsoft.com>
 <20240718182743.1959160-2-romank@linux.microsoft.com>
 <1AEC6E18-313E-495F-AEE7-9C6C9DB3BAEA@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1AEC6E18-313E-495F-AEE7-9C6C9DB3BAEA@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/19/2024 10:33 AM, Allen Pais wrote:
> 
> 
>> On Jul 18, 2024, at 11:27 AM, Roman Kisel <romank@linux.microsoft.com> 
>> wrote:
>>
>> The coredump code does not log the process ID and the comm
>> consistently, logs unescaped comm when it does log it, and
>> does not always use the ratelimited logging. That makes it
>> harder to analyze logs and puts the system at the risk of
>> spamming the system log incase something crashes many times
>> over and over again.
>>
>> Fix that by logging TGID and comm (escaped) consistently and
>> using the ratelimited logging always.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> 
> LGTM.
> 
> Tested-by: Allen Pais <apais@linux.microsoft.com 
> <mailto:apais@linux.microsoft.com>>
Allen, thank you for your help!

> 
> Thanks.
> 
> 
>> ---
>> fs/coredump.c            | 43 +++++++++++++++-------------------------
>> include/linux/coredump.h | 22 ++++++++++++++++++++
>> 2 files changed, 38 insertions(+), 27 deletions(-)
>>
>> diff --git a/fs/coredump.c b/fs/coredump.c
>> index a57a06b80f57..19d3343b93c6 100644
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -586,8 +586,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>> struct subprocess_info *sub_info;
>>
>> if (ispipe < 0) {
>> -printk(KERN_WARNING "format_corename failed\n");
>> -printk(KERN_WARNING "Aborting core\n");
>> +coredump_report_failure("format_corename failed, aborting core");
>> goto fail_unlock;
>> }
>>
>> @@ -607,27 +606,21 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>> * right pid if a thread in a multi-threaded
>> * core_pattern process dies.
>> */
>> -printk(KERN_WARNING
>> -"Process %d(%s) has RLIMIT_CORE set to 1\n",
>> -task_tgid_vnr(current), current->comm);
>> -printk(KERN_WARNING "Aborting core\n");
>> +coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
>> goto fail_unlock;
>> }
>> cprm.limit = RLIM_INFINITY;
>>
>> dump_count = atomic_inc_return(&core_dump_count);
>> if (core_pipe_limit && (core_pipe_limit < dump_count)) {
>> -printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
>> -      task_tgid_vnr(current), current->comm);
>> -printk(KERN_WARNING "Skipping core dump\n");
>> +coredump_report_failure("over core_pipe_limit, skipping core dump");
>> goto fail_dropcount;
>> }
>>
>> helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
>>    GFP_KERNEL);
>> if (!helper_argv) {
>> -printk(KERN_WARNING "%s failed to allocate memory\n",
>> -      __func__);
>> +coredump_report_failure("%s failed to allocate memory", __func__);
>> goto fail_dropcount;
>> }
>> for (argi = 0; argi < argc; argi++)
>> @@ -644,8 +637,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>
>> kfree(helper_argv);
>> if (retval) {
>> -printk(KERN_INFO "Core dump to |%s pipe failed\n",
>> -      cn.corename);
>> +coredump_report_failure("|%s pipe failed", cn.corename);
>> goto close_fail;
>> }
>> } else {
>> @@ -658,10 +650,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>> goto fail_unlock;
>>
>> if (need_suid_safe && cn.corename[0] != '/') {
>> -printk(KERN_WARNING "Pid %d(%s) can only dump core "\
>> -"to fully qualified path!\n",
>> -task_tgid_vnr(current), current->comm);
>> -printk(KERN_WARNING "Skipping core dump\n");
>> +coredump_report_failure(
>> +"this process can only dump core to a fully qualified path, skipping 
>> core dump");
>> goto fail_unlock;
>> }
>>
>> @@ -730,13 +720,13 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>> idmap = file_mnt_idmap(cprm.file);
>> if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
>>    current_fsuid())) {
>> -pr_info_ratelimited("Core dump to %s aborted: cannot preserve file 
>> owner\n",
>> -   cn.corename);
>> +coredump_report_failure("Core dump to %s aborted: "
>> +"cannot preserve file owner", cn.corename);
>> goto close_fail;
>> }
>> if ((inode->i_mode & 0677) != 0600) {
>> -pr_info_ratelimited("Core dump to %s aborted: cannot preserve file 
>> permissions\n",
>> -   cn.corename);
>> +coredump_report_failure("Core dump to %s aborted: "
>> +"cannot preserve file permissions", cn.corename);
>> goto close_fail;
>> }
>> if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
>> @@ -757,7 +747,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>> * have this set to NULL.
>> */
>> if (!cprm.file) {
>> -pr_info("Core dump to |%s disabled\n", cn.corename);
>> +coredump_report_failure("Core dump to |%s disabled", cn.corename);
>> goto close_fail;
>> }
>> if (!dump_vma_snapshot(&cprm))
>> @@ -983,11 +973,10 @@ void validate_coredump_safety(void)
>> {
>> if (suid_dumpable == SUID_DUMP_ROOT &&
>>    core_pattern[0] != '/' && core_pattern[0] != '|') {
>> -pr_warn(
>> -"Unsafe core_pattern used with fs.suid_dumpable=2.\n"
>> -"Pipe handler or fully qualified core dump path required.\n"
>> -"Set kernel.core_pattern before fs.suid_dumpable.\n"
>> -);
>> +
>> +coredump_report_failure("Unsafe core_pattern used with 
>> fs.suid_dumpable=2: "
>> +"pipe handler or fully qualified core dump path required. "
>> +"Set kernel.core_pattern before fs.suid_dumpable.");
>> }
>> }
>>
>> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
>> index 0904ba010341..45e598fe3476 100644
>> --- a/include/linux/coredump.h
>> +++ b/include/linux/coredump.h
>> @@ -43,8 +43,30 @@ extern int dump_align(struct coredump_params *cprm, 
>> int align);
>> int dump_user_range(struct coredump_params *cprm, unsigned long start,
>>    unsigned long len);
>> extern void do_coredump(const kernel_siginfo_t *siginfo);
>> +
>> +/*
>> + * Logging for the coredump code, ratelimited.
>> + * The TGID and comm fields are added to the message.
>> + */
>> +
>> +#define __COREDUMP_PRINTK(Level, Format, ...) \
>> +do {\
>> +char comm[TASK_COMM_LEN];\
>> +\
>> +get_task_comm(comm, current);\
>> +printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",\
>> +task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);\
>> +} while (0)\
>> +
>> +#define coredump_report(fmt, ...) __COREDUMP_PRINTK(KERN_INFO, fmt, 
>> ##__VA_ARGS__)
>> +#define coredump_report_failure(fmt, ...) 
>> __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>> +
>> #else
>> static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
>> +
>> +#define coredump_report(...)
>> +#define coredump_report_failure(...)
>> +
>> #endif
>>
>> #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
>> -- 
>> 2.45.2
> 

-- 
Thank you,
Roman


