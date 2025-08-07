Return-Path: <linux-fsdevel+bounces-56988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37202B1D8AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 15:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77583A876E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B400125A321;
	Thu,  7 Aug 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="lwlxXC8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m.syntacore.com (m.syntacore.com [178.249.69.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA72E36EC;
	Thu,  7 Aug 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.249.69.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572438; cv=none; b=IY/alPr9I//IHLGRoJm/lMQcW2tHvqY0hAbt6pqf3ZzzOvh3EMjR1ezhQCfUsuvKlsncyLSx633mdUxzPGDPHDnEF+1pxAaLFYSTTp+rZeyKXEdvFpLdCgW+SNpKa0UhiSFpN8YYKJX9tVnkAFPjSZObOIht6ezQ1w7PYc8jvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572438; c=relaxed/simple;
	bh=2WKbjQVRF2KVnkFG08+yi39gLJTA1kh0qsWsfwI2jSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i2SYYC2pdyRA+y3dVduTOYF9khHQZT1XfakchPBBhl5EsKDRbfSOuGvPSQgX+7gVxXlUT6n/rmFn1E8T1l2ximpgfgJpe/SMrP1O6rLyimhyEVpLvFWIyCf+SB2bLJ/PQ8erD+Mq9+itvV7nAVj9SypPxbwnRKR1wZmN8RATUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=pass smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=lwlxXC8O; arc=none smtp.client-ip=178.249.69.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syntacore.com
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
	by m.syntacore.com (Postfix) with ESMTP id 428081A0004;
	Thu,  7 Aug 2025 13:13:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 428081A0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
	t=1754572434; bh=PRldComWRoiWOPNshpB2MJ/sQDU9cbT00ez0s1BzS8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=lwlxXC8O4PxNXasjBDd5En6yslrBNKR2DOdsWuXC5VnWBHN451A0zyGjW/fCetcRS
	 Xisbxr/ILirZiNrhm/rf5gYXrjwuvkahiy9xdStOPmj/7HasYhx+k9cCz1O19IJhbh
	 G2F+OlT4Mp7aeotBQb1MhLhaFLBiDEBgCOSfHkWpSfm07paHg0V5EEF0z8DpNN0DuW
	 IIKVn4HZmwry5/iH9X4hXaytkvZChritrSB9WS4+AhwdwdF9gvyAZfOa42FX1dvDL0
	 1LmPyKNrVMvaL5FaSqTw1vR9xUafDPflnrzYeTA9jdtaKzekfP67saSzk/AY/7aKAM
	 SSBmCcIkPU5fQ==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com [10.76.202.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by m.syntacore.com (Postfix) with ESMTPS;
	Thu,  7 Aug 2025 13:13:52 +0000 (UTC)
Received: from [10.199.23.86] (10.199.23.86) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Aug 2025 16:13:20 +0300
Message-ID: <e9990237-bc83-4cbb-bab8-013b939a61fb@syntacore.com>
Date: Thu, 7 Aug 2025 19:13:50 +0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND] binfmt_elf: preserve original ELF e_flags in core
 dumps
To: Kees Cook <kees@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>,
	<vbabka@suse.cz>, <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>
References: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>
 <202508061152.6B26BDC6FB@keescook>
Content-Language: en-US
From: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
In-Reply-To: <202508061152.6B26BDC6FB@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/08/07 12:24:00 #27641897
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

On 07/08/2025 00.57, Kees Cook wrote:
> On Wed, Aug 06, 2025 at 10:18:14PM +0600, Svetlana Parfenova wrote:
>> Preserve the original ELF e_flags from the executable in the core dump
>> header instead of relying on compile-time defaults (ELF_CORE_EFLAGS or
>> value from the regset view). This ensures that ABI-specific flags in
>> the dump file match the actual binary being executed.
>>
>> Save the e_flags field during ELF binary loading (in load_elf_binary())
>> into the mm_struct, and later retrieve it during core dump generation
>> (in fill_note_info()). Use this saved value to populate the e_flags in
>> the core dump ELF header.
>>
>> Add a new Kconfig option, CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS, to guard
>> this behavior. Although motivated by a RISC-V use case, the mechanism is
>> generic and can be applied to all architectures.
> 
> In the general case, is e_flags mismatched? i.e. why hide this behind a
> Kconfig? Put another way, if I enabled this Kconfig and dumped core from
> some regular x86_64 process, will e_flags be different?
> 

The Kconfig option is currently restricted to the RISC-V architecture 
because it's not clear to me whether other architectures need actual 
e_flags value from ELF header. If this option is disabled, the core dump 
will always use a compile time value for e_flags, regardless of which 
method is selected: ELF_CORE_EFLAGS or CORE_DUMP_USE_REGSET. And this 
constant does not necessarily reflect the actual e_flags of the running 
process (at least on RISC-V), which can vary depending on how the binary 
was compiled. Thus, I made a third method to obtain e_flags that 
reflects the real value. And it is gated behind a Kconfig option, as not 
all users may need it.

>> This change is needed to resolve a debugging issue encountered when
>> analyzing core dumps with GDB for RISC-V systems. GDB inspects the
>> e_flags field to determine whether optional register sets such as the
>> floating-point unit are supported. Without correct flags, GDB may warn
>> and ignore valid register data:
>>
>>      warning: Unexpected size of section '.reg2/213' in core file.
>>
>> As a result, floating-point registers are not accessible in the debugger,
>> even though they were dumped. Preserving the original e_flags enables
>> GDB and other tools to properly interpret the dump contents.
>>
>> Signed-off-by: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
>> ---
>>   fs/Kconfig.binfmt        |  9 +++++++++
>>   fs/binfmt_elf.c          | 26 ++++++++++++++++++++------
>>   include/linux/mm_types.h |  5 +++++
>>   3 files changed, 34 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
>> index bd2f530e5740..45bed2041542 100644
>> --- a/fs/Kconfig.binfmt
>> +++ b/fs/Kconfig.binfmt
>> @@ -184,4 +184,13 @@ config EXEC_KUNIT_TEST
>>   	  This builds the exec KUnit tests, which tests boundary conditions
>>   	  of various aspects of the exec internals.
>>   
>> +config CORE_DUMP_USE_PROCESS_EFLAGS
>> +	bool "Preserve ELF e_flags from executable in core dumps"
>> +	depends on BINFMT_ELF && ELF_CORE && RISCV
>> +	default n
>> +	help
>> +	  Save the ELF e_flags from the process executable at load time
>> +	  and use it in the core dump header. This ensures the dump reflects
>> +	  the original binary ABI.
>> +
>>   endmenu
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index caeddccaa1fe..e5e06e11f9fc 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -1290,6 +1290,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
>>   	mm->end_data = end_data;
>>   	mm->start_stack = bprm->p;
>>   
>> +#ifdef CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS
>> +	/* stash e_flags for use in core dumps */
>> +	mm->saved_e_flags = elf_ex->e_flags;
>> +#endif
> 
> Is this structure actually lost during ELF load? I thought we preserved
> some more of the ELF headers during load...
> 

As far as I can tell, the ELF header itself is not preserved beyond 
loading. If there's a mechanism I'm missing that saves it, please let me 
know.

>> +
>>   	/**
>>   	 * DOC: "brk" handling
>>   	 *
>> @@ -1804,6 +1809,8 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
>>   	struct elf_thread_core_info *t;
>>   	struct elf_prpsinfo *psinfo;
>>   	struct core_thread *ct;
>> +	u16 machine;
>> +	u32 flags;
>>   
>>   	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
>>   	if (!psinfo)
>> @@ -1831,17 +1838,24 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
>>   		return 0;
>>   	}
>>   
>> -	/*
>> -	 * Initialize the ELF file header.
>> -	 */
>> -	fill_elf_header(elf, phdrs,
>> -			view->e_machine, view->e_flags);
>> +	machine = view->e_machine;
>> +	flags = view->e_flags;
>>   #else
>>   	view = NULL;
>>   	info->thread_notes = 2;
>> -	fill_elf_header(elf, phdrs, ELF_ARCH, ELF_CORE_EFLAGS);
>> +	machine = ELF_ARCH;
>> +	flags = ELF_CORE_EFLAGS;
>>   #endif
>>   
>> +#ifdef CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS
>> +	flags = dump_task->mm->saved_e_flags;
>> +#endif
> 
> This appears to clobber the value from view->e_flags. Is that right? It
> feels like this change should only be needed in the default
> ELF_CORE_EFLAGS case. How is view->e_flags normally set?
> 

view->e_flags is set at compile time, and view is pointing to const 
struct. The override of e_flags is intentional in both cases 
(ELF_CORE_EFLAGS and CORE_DUMP_USE_REGSET) to allow access to the 
process actual e_flags, regardless of the selected method.

>> +
>> +	/*
>> +	 * Initialize the ELF file header.
>> +	 */
>> +	fill_elf_header(elf, phdrs, machine, flags);
>> +
>>   	/*
>>   	 * Allocate a structure for each thread.
>>   	 */
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index d6b91e8a66d6..39921b32e4f5 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -1098,6 +1098,11 @@ struct mm_struct {
>>   
>>   		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
>>   
>> +#ifdef CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS
>> +		/* the ABI-related flags from the ELF header. Used for core dump */
>> +		unsigned long saved_e_flags;
>> +#endif
>> +
>>   		struct percpu_counter rss_stat[NR_MM_COUNTERS];
>>   
>>   		struct linux_binfmt *binfmt;
>> -- 
>> 2.50.1
>>
> 
> -Kees
> 


-- 
Best regards,
Svetlana Parfenova

