Return-Path: <linux-fsdevel+bounces-59856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93904B3E675
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494283B62A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9203133A012;
	Mon,  1 Sep 2025 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="im375hOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m.syntacore.com (m.syntacore.com [178.249.69.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC6338F29;
	Mon,  1 Sep 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.249.69.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735142; cv=none; b=lg2U+wr+iRrNlzBjDoIrZy3P5zBdCRlebu1xYQGa1ZOjH2USxDvi254JuUImndsIh8iarIebfWjOGLd2lfkleFLWhtPjm6cMIbK4uxGES3tQLOdgpNTIOtQ3ZbJZL7jWub6WnbqfNTHCiYArPCPWpmqUyqqqgOsWwUcq1mHOMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735142; c=relaxed/simple;
	bh=m1jDbs5wY5pi1Wi54fIs/L4wHgSFxBhj4yCcww2BEe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JLt9ab81V0L/zfyBh/xx/PmbgtjetX1SavuCk4RhllVvwj+jDNgQY3/njhV1JrCTwS9VKlxv0poZYyiL+v+3qUXANIvg6hEx8mvDQnAw2yhWUGzBlkK9mc6nM/RnclrdSPFlBBSxCANebsecVURq1ERuFdg3Try9hPKcSq8MFsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=pass smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=im375hOA; arc=none smtp.client-ip=178.249.69.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syntacore.com
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
	by m.syntacore.com (Postfix) with ESMTP id 535941A0005;
	Mon,  1 Sep 2025 13:58:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 535941A0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
	t=1756735139; bh=KFK1KsPaY9lVZCNqSiIscNbL7eAxdmZz/XyL68Jx/+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=im375hOAfoHr1jOpo6ZcppAjUC/QV2Bv0nkdC6qpYUk7R/j9aowFYySe4q9penFP8
	 inmTDm/ogLsyZ30UjzX/vNMzumDgERDBR1FTuqeyv5/g1HXiMY29LLx6sbhPKIcttv
	 YY7gPMpVEXHVR+15BR9i8PnlIrIQxsr/TWGFRHibIlhKtxFovTTomzHvmRWWf1Q0j/
	 3pORsKs/vnx9iU2jeZP5mbgMLbjBUjNpwH/Pqf95c7kJOha9/RLovtGZUqBh4Z/k7U
	 9G0+VsX0pd2W4K0+PpBj9PGIt9vIkmIQDuqw5s70wwhtGK/ieIdICXY3k0h7fXWLsB
	 vw2XM7GdPrqgg==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com [10.76.202.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by m.syntacore.com (Postfix) with ESMTPS;
	Mon,  1 Sep 2025 13:58:58 +0000 (UTC)
Received: from [10.30.18.228] (10.30.18.228) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 16:58:51 +0300
Message-ID: <308785c9-5579-4950-aea5-f19d02a2de37@syntacore.com>
Date: Mon, 1 Sep 2025 20:58:56 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v2] binfmt_elf: preserve original ELF e_flags for
 core dumps
To: Kees Cook <kees@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>,
	<vbabka@suse.cz>, <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>
References: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>
 <20250811095328.256869-1-svetlana.parfenova@syntacore.com>
 <202508251009.CB5EB2E304@keescook>
Content-Language: en-US
From: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
In-Reply-To: <202508251009.CB5EB2E304@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/09/01 12:41:00 #27718494
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

On 26/08/2025 00.17, Kees Cook wrote:
> On Mon, Aug 11, 2025 at 03:53:28PM +0600, Svetlana Parfenova wrote:
>> Some architectures, such as RISC-V, use the ELF e_flags field to encode
>> ABI-specific information (e.g., ISA extensions, fpu support). Debuggers
>> like GDB rely on these flags in core dumps to correctly interpret
>> optional register sets. If the flags are missing or incorrect, GDB may
>> warn and ignore valid data, for example:
>>
>>      warning: Unexpected size of section '.reg2/213' in core file.
>>
>> This can prevent access to fpu or other architecture-specific registers
>> even when they were dumped.
>>
>> Save the e_flags field during ELF binary loading (in load_elf_binary())
>> into the mm_struct, and later retrieve it during core dump generation
>> (in fill_note_info()). A new macro ELF_CORE_USE_PROCESS_EFLAGS allows
>> architectures to enable this behavior - currently just RISC-V.
>>
>> Signed-off-by: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
>> ---
>> Changes in v2:
>>   - Remove usage of Kconfig option.
>>   - Add an architecture-optional macro to set process e_flags. Enabled
>>     by defining ELF_CORE_USE_PROCESS_EFLAGS. Defaults to no-op if not
>>     used.
>>
>>   arch/riscv/include/asm/elf.h |  1 +
>>   fs/binfmt_elf.c              | 34 ++++++++++++++++++++++++++++------
>>   include/linux/mm_types.h     |  3 +++
>>   3 files changed, 32 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
>> index c7aea7886d22..5d9f0ac851ee 100644
>> --- a/arch/riscv/include/asm/elf.h
>> +++ b/arch/riscv/include/asm/elf.h
>> @@ -20,6 +20,7 @@
>>    * These are used to set parameters in the core dumps.
>>    */
>>   #define ELF_ARCH	EM_RISCV
>> +#define ELF_CORE_USE_PROCESS_EFLAGS
> 
> Let's move this to the per-arch Kconfig instead, that way we can use it
> in other places. Maybe call in CONFIG_ARCH_HAS_ELF_CORE_EFLAGS?
> 
>>   
>>   #ifndef ELF_CLASS
>>   #ifdef CONFIG_64BIT
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index caeddccaa1fe..e52b1e077218 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -66,6 +66,14 @@
>>   #define elf_check_fdpic(ex) false
>>   #endif
>>   
>> +#ifdef ELF_CORE_USE_PROCESS_EFLAGS
>> +#define elf_coredump_get_process_eflags(dump_task, e_flags) \
>> +	(*(e_flags) = (dump_task)->mm->saved_e_flags)
>> +#else
>> +#define elf_coredump_get_process_eflags(dump_task, e_flags) \
>> +	do { (void)(dump_task); (void)(e_flags); } while (0)
>> +#endif
> 
> Let's make specific set/get helpers here, instead.
> 
> static inline
> u32 coredump_get_mm_eflags(struct mm_struct *mm, u32 flags)
> {
> #ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
> 	flags = mm->saved_e_flags;
> #else
> 	return flags;
> }
> 
> static inline
> void coredump_set_mm_eflags(struct mm_struct *mm, u32 flags)
> {
> #ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
> 	mm->saved_e_flags = flags;
> #endif
> }
> 
> 
>> +
>>   static int load_elf_binary(struct linux_binprm *bprm);
>>   
>>   /*
>> @@ -1290,6 +1298,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
>>   	mm->end_data = end_data;
>>   	mm->start_stack = bprm->p;
>>   
>> +	/* stash e_flags for use in core dumps */
>> +	mm->saved_e_flags = elf_ex->e_flags;
> 
> Then this is:
> 
> 	coredump_set_mm_eflags(mm, elf_ex->e_flags);
> 
>> +
>>   	/**
>>   	 * DOC: "brk" handling
>>   	 *
>> @@ -1804,6 +1815,8 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
>>   	struct elf_thread_core_info *t;
>>   	struct elf_prpsinfo *psinfo;
>>   	struct core_thread *ct;
>> +	u16 machine;
>> +	u32 flags;
>>   
>>   	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
>>   	if (!psinfo)
>> @@ -1831,17 +1844,26 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
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
>> +	/*
>> +	 * Override ELF e_flags with value taken from process,
>> +	 * if arch wants to.
>> +	 */
>> +	elf_coredump_get_process_eflags(dump_task, &flags);
> 
> And this is:
> 
> 	flags = coredump_get_mm_eflags(dump_task->mm, flags);
> 
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
>> index d6b91e8a66d6..e46f554f8d91 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -1098,6 +1098,9 @@ struct mm_struct {
>>   
>>   		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
>>   
> 
> And then add:
> 
> #ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
> 
>> +		/* the ABI-related flags from the ELF header. Used for core dump */
>> +		unsigned long saved_e_flags;
> 
> #endif
> 
> around this part
> 
>> +
>>   		struct percpu_counter rss_stat[NR_MM_COUNTERS];
>>   
>>   		struct linux_binfmt *binfmt;
>> -- 
>> 2.50.1
>>
> 

Thank you for review! I have addressed your comments in v3 of the patch.

-- 
Best regards,
Svetlana Parfenova

