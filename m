Return-Path: <linux-fsdevel+bounces-24907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2CE9466FE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 05:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA7C282863
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 03:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35BD2FA;
	Sat,  3 Aug 2024 03:09:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0663D0;
	Sat,  3 Aug 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722654577; cv=none; b=khkcRPiuw9bmocaFoBJfO5/e36Diia/pOa4FeDRk+JqMKiiD0gRltRsc/WMRJlB2SnHAQbkfcjuCH02Gi2zYWXiUyY34bQ0KLIvIS57D8RLfIcMhAlh0MnyIQ1OKZmYPIDv+rGN/afXtx/8ZVrvncYtJrpE4pqtx7JOC1XzasMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722654577; c=relaxed/simple;
	bh=EsLLGFErEDhmQKIfUVOMvGP9RLgQXmOdKXBkfzGJu5M=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=RfK01FM4lm1n8B+GdLLRPEvrPqwuOHwGXsIJEvyekItMry8kr+9ajAy+qkahWpPjFREPlmm7R+3rjaQb7YKQXjrMF+Ojhkwu8sqbR4e6AyM0507vQniw1AZN8DNU4kUOKWSpZIW5kfNcb/zHCWvYmOXkriURHS21pzmRoSrIrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:47736)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sa594-006CNC-LX; Fri, 02 Aug 2024 21:09:26 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:45680 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sa593-00Eun8-4P; Fri, 02 Aug 2024 21:09:26 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Brian Mak <makb@juniper.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Kees Cook
 <kees@kernel.org>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-mm@kvack.org"
 <linux-mm@kvack.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Oleg Nesterov <oleg@redhat.com>
References: <CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net>
	<877cd1ymy0.fsf@email.froward.int.ebiederm.org>
	<4B7D9FBE-2657-45DB-9702-F3E056CE6CFD@juniper.net>
	<87h6c2x5ma.fsf@email.froward.int.ebiederm.org>
	<565A7C1E-A521-44C1-8192-C1735100AD56@juniper.net>
Date: Fri, 02 Aug 2024 22:08:55 -0500
In-Reply-To: <565A7C1E-A521-44C1-8192-C1735100AD56@juniper.net> (Brian Mak's
	message of "Fri, 2 Aug 2024 17:46:37 +0000")
Message-ID: <87r0b6uwu0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sa593-00Eun8-4P;;;mid=<87r0b6uwu0.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+4tEOqjAbUIMPoTrtSG2BHIgtvzQDGcI8=
X-SA-Exim-Connect-IP: 68.227.165.127
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Brian Mak <makb@juniper.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 869 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 15 (1.7%), b_tie_ro: 13 (1.5%), parse: 1.89
	(0.2%), extract_message_metadata: 21 (2.4%), get_uri_detail_list: 8
	(0.9%), tests_pri_-2000: 14 (1.6%), tests_pri_-1000: 2.8 (0.3%),
	tests_pri_-950: 1.41 (0.2%), tests_pri_-900: 1.29 (0.1%),
	tests_pri_-90: 147 (16.9%), check_bayes: 124 (14.3%), b_tokenize: 22
	(2.5%), b_tok_get_all: 24 (2.8%), b_comp_prob: 9 (1.0%),
	b_tok_touch_all: 62 (7.1%), b_finish: 1.58 (0.2%), tests_pri_0: 650
	(74.9%), check_dkim_signature: 0.87 (0.1%), check_dkim_adsp: 3.8
	(0.4%), poll_dns_idle: 0.83 (0.1%), tests_pri_10: 2.2 (0.3%),
	tests_pri_500: 8 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Brian Mak <makb@juniper.net> writes:

> On Aug 2, 2024, at 9:16 AM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> Brian Mak <makb@juniper.net> writes:
>> 
>>> On Jul 31, 2024, at 7:52 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>> 
>>>> Brian Mak <makb@juniper.net> writes:
>>>> 
>>>>> Large cores may be truncated in some scenarios, such as daemons with stop
>>>>> timeouts that are not large enough or lack of disk space. This impacts
>>>>> debuggability with large core dumps since critical information necessary to
>>>>> form a usable backtrace, such as stacks and shared library information, are
>>>>> omitted. We can mitigate the impact of core dump truncation by dumping
>>>>> smaller VMAs first, which may be more likely to contain memory for stacks
>>>>> and shared library information, thus allowing a usable backtrace to be
>>>>> formed.
>>>> 
>>>> This sounds theoretical.  Do you happen to have a description of a
>>>> motivating case?  A situtation that bit someone and resulted in a core
>>>> file that wasn't usable?
>>>> 
>>>> A concrete situation would help us imagine what possible caveats there
>>>> are with sorting vmas this way.
>>>> 
>>>> The most common case I am aware of is distributions setting the core
>>>> file size to 0 (ulimit -c 0).
>>> 
>>> Hi Eric,
>>> 
>>> Thanks for taking the time to reply. We have hit these scenarios before in
>>> practice where large cores are truncated, resulting in an unusable core.
>>> 
>>> At Juniper, we have some daemons that can consume a lot of memory, where
>>> upon crash, can result in core dumps of several GBs. While dumping, we've
>>> encountered these two scenarios resulting in a unusable core:
>>> 
>>> 1. Disk space is low at the time of core dump, resulting in a truncated
>>> core once the disk is full.
>>> 
>>> 2. A daemon has a TimeoutStopSec option configured in its systemd unit
>>> file, where upon core dumping, could timeout (triggering a SIGKILL) if the
>>> core dump is too large and is taking too long to dump.
>>> 
>>> In both scenarios, we see that the core file is already several GB, and
>>> still does not contain the information necessary to form a backtrace, thus
>>> creating the need for this change. In the second scenario, we are unable to
>>> increase the timeout option due to our recovery time objective
>>> requirements.
>>> 
>>>> One practical concern with this approach is that I think the ELF
>>>> specification says that program headers should be written in memory
>>>> order.  So a comment on your testing to see if gdb or rr or any of
>>>> the other debuggers that read core dumps cares would be appreciated.
>>> 
>>> I've already tested readelf and gdb on core dumps (truncated and whole)
>>> with this patch and it is able to read/use these core dumps in these
>>> scenarios with a proper backtrace.
>>> 
>>>>> We implement this by sorting the VMAs by dump size and dumping in that
>>>>> order.
>>>> 
>>>> Since your concern is about stacks, and the kernel has information about
>>>> stacks it might be worth using that information explicitly when sorting
>>>> vmas, instead of just assuming stacks will be small.
>>> 
>>> This was originally the approach that we explored, but ultimately moved
>>> away from. We need more than just stacks to form a proper backtrace. I
>>> didn't narrow down exactly what it was that we needed because the sorting
>>> solution seemed to be cleaner than trying to narrow down each of these
>>> pieces that we'd need. At the very least, we need information about shared
>>> libraries (.dynamic, etc.) and stacks, but my testing showed that we need a
>>> third piece sitting in an anonymous R/W VMA, which is the point that I
>>> stopped exploring this path. I was having a difficult time narrowing down
>>> what this last piece was.
>>> 
>>>> I expect the priorities would look something like jit generated
>>>> executable code segments, stacks, and then heap data.
>>>> 
>>>> I don't have enough information what is causing your truncated core
>>>> dumps, so I can't guess what the actual problem is your are fighting,
>>>> so I could be wrong on priorities.
>>>> 
>>>> Though I do wonder if this might be a buggy interaction between
>>>> core dumps and something like signals, or io_uring.  If it is something
>>>> other than a shortage of storage space causing your truncated core
>>>> dumps I expect we should first debug why the coredumps are being
>>>> truncated rather than proceed directly to working around truncation.
>>> 
>>> I don't really see any feasible workarounds that can be done for preventing
>>> truncation of these core dumps. Our truncated cores are also not the result
>>> of any bugs, but rather a limitation.
>> 
>> Thanks that clarifies things.
>> 
>> From a quality of implementation standpoint I regret that at least some
>> pause during coredumping is inevitable.  Ideally I would like to
>> minimize that pause, preserve the memory and have a separate kernel
>> thread perform the coredumping work.  That in principle would remove the
>> need for coredumps to be stop when a SIGKILL is delievered and avoid the
>> issue with the systemd timeout.  Plus it would allow systemd to respawn
>> the process before the coredump was complete.  Getting there is in no
>> sense easy, and it would still leave the problem of not getting
>> the whole coredump when you are running out of disk space.
>
> This is actually another approach that we thought about, but decided
> against. The fact that it doesn't address running out of disk space is one
> thing, but also, if systemd were to respawn the process before the coredump
> completes, there would effectively be a doubling of that process' memory
> usage. For applications that take up a significant chunk of available
> memory on a system, effectively "duplicating" that memory consumption could
> result in a system running out of memory.
>
> With this approach, there's two options: to have systemd restart the
> process or wait until core dumping is complete to restart. In the first
> option, we would be risking system stability for debuggability in
> applications with a large memory footprint. In the second option, we would
> be back to where we started (either terminate the core dumping or miss
> recovery time objectives).
>
>> The explanation of the vma sort is good.  Sorting by size seems to make
>> a simple and very effective heuristic.  It would nice if that
>> explanation appeared in the change description.
>> 
>> From a maintenance perspective it would be very nice to perform the vma
>> size sort unconditionally.   Can you remove the knob making the size
>> sort conditional?  If someone reports a regression we can add a knob
>> making the sort conditional.
>> 
>> We are in the middle of the merge window right now but I expect Kees
>> could take a simplified patch (aka no knob) after the merge window
>> closes and get it into linux-next.  Which should give plenty of time
>> to spot any regressions caused by sorting the vmas.
>
> Understood, will get a PATCH v2 sent out with the removal of the knob. I
> should note though that the conditional sorting actually gives a second
> benefit, which is that in the event there is low available memory,
> allocating the sorted_vmas array may fail, allowing for a fallback to
> original functionality without any additional memory allocations. However,
> in the interest of maintainability, it may be better to just forgo that
> benefit.

The entire array of vmas is initially allocated in
fs/coredump.c:dump_vma_snapshot(), to avoid the need to hold the
mmap_lock while writing the coredump.

Unless there is some technical reason I haven't thought of you might as
well sort the vma array in place and avoid the copy to a new array.

The logic seems to apply all coredumps so I would recommend placing the
sorting in dump_vma_snapshot.  Then we don't have to worry about the
other implementations of elf coredumps (ELF FDPIC) getting out of sync
in with the primary coredump implementation.

Eric

> Thanks for looking this over!
>
> Best,
> Brian Mak
>
>> Eric
>> 
>> 
>>> 
>>> Please let me know your thoughts!
>>> 
>>> Best,
>>> Brian Mak
>>> 
>>>> Eric
>>>> 
>>>>> Signed-off-by: Brian Mak <makb@juniper.net>
>>>>> ---
>>>>> 
>>>>> Hi all,
>>>>> 
>>>>> My initial testing with a program that spawns several threads and allocates heap
>>>>> memory shows that this patch does indeed prioritize information such as stacks,
>>>>> which is crucial to forming a backtrace and debugging core dumps.
>>>>> 
>>>>> Requesting for comments on the following:
>>>>> 
>>>>> Are there cases where this might not necessarily prioritize dumping VMAs
>>>>> needed to obtain a usable backtrace?
>>>>> 
>>>>> Thanks,
>>>>> Brian Mak
>>>>> 
>>>>> fs/binfmt_elf.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
>>>>> 1 file changed, 62 insertions(+), 2 deletions(-)
>>>>> 
>>>>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>>>>> index 19fa49cd9907..d45240b0748d 100644
>>>>> --- a/fs/binfmt_elf.c
>>>>> +++ b/fs/binfmt_elf.c
>>>>> @@ -13,6 +13,7 @@
>>>>> #include <linux/module.h>
>>>>> #include <linux/kernel.h>
>>>>> #include <linux/fs.h>
>>>>> +#include <linux/debugfs.h>
>>>>> #include <linux/log2.h>
>>>>> #include <linux/mm.h>
>>>>> #include <linux/mman.h>
>>>>> @@ -37,6 +38,7 @@
>>>>> #include <linux/elf-randomize.h>
>>>>> #include <linux/utsname.h>
>>>>> #include <linux/coredump.h>
>>>>> +#include <linux/sort.h>
>>>>> #include <linux/sched.h>
>>>>> #include <linux/sched/coredump.h>
>>>>> #include <linux/sched/task_stack.h>
>>>>> @@ -1990,6 +1992,22 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
>>>>>     shdr4extnum->sh_info = segs;
>>>>> }
>>>>> 
>>>>> +static int cmp_vma_size(const void *vma_meta_lhs_ptr, const void *vma_meta_rhs_ptr)
>>>>> +{
>>>>> +     const struct core_vma_metadata *vma_meta_lhs = *(const struct core_vma_metadata **)
>>>>> +             vma_meta_lhs_ptr;
>>>>> +     const struct core_vma_metadata *vma_meta_rhs = *(const struct core_vma_metadata **)
>>>>> +             vma_meta_rhs_ptr;
>>>>> +
>>>>> +     if (vma_meta_lhs->dump_size < vma_meta_rhs->dump_size)
>>>>> +             return -1;
>>>>> +     if (vma_meta_lhs->dump_size > vma_meta_rhs->dump_size)
>>>>> +             return 1;
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static bool sort_elf_core_vmas = true;
>>>>> +
>>>>> /*
>>>>> * Actual dumper
>>>>> *
>>>>> @@ -2008,6 +2026,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>>>>>     struct elf_shdr *shdr4extnum = NULL;
>>>>>     Elf_Half e_phnum;
>>>>>     elf_addr_t e_shoff;
>>>>> +     struct core_vma_metadata **sorted_vmas = NULL;
>>>>> 
>>>>>     /*
>>>>>      * The number of segs are recored into ELF header as 16bit value.
>>>>> @@ -2071,11 +2090,27 @@ static int elf_core_dump(struct coredump_params *cprm)
>>>>>     if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
>>>>>             goto end_coredump;
>>>>> 
>>>>> +     /* Allocate memory to sort VMAs and sort if needed. */
>>>>> +     if (sort_elf_core_vmas)
>>>>> +             sorted_vmas = kvmalloc_array(cprm->vma_count, sizeof(*sorted_vmas), GFP_KERNEL);
>>>>> +
>>>>> +     if (!ZERO_OR_NULL_PTR(sorted_vmas)) {
>>>>> +             for (i = 0; i < cprm->vma_count; i++)
>>>>> +                     sorted_vmas[i] = cprm->vma_meta + i;
>>>>> +
>>>>> +             sort(sorted_vmas, cprm->vma_count, sizeof(*sorted_vmas), cmp_vma_size, NULL);
>>>>> +     }
>>>>> +
>>>>>     /* Write program headers for segments dump */
>>>>>     for (i = 0; i < cprm->vma_count; i++) {
>>>>> -             struct core_vma_metadata *meta = cprm->vma_meta + i;
>>>>> +             struct core_vma_metadata *meta;
>>>>>             struct elf_phdr phdr;
>>>>> 
>>>>> +             if (ZERO_OR_NULL_PTR(sorted_vmas))
>>>>> +                     meta = cprm->vma_meta + i;
>>>>> +             else
>>>>> +                     meta = sorted_vmas[i];
>>>>> +
>>>>>             phdr.p_type = PT_LOAD;
>>>>>             phdr.p_offset = offset;
>>>>>             phdr.p_vaddr = meta->start;
>>>>> @@ -2111,7 +2146,12 @@ static int elf_core_dump(struct coredump_params *cprm)
>>>>>     dump_skip_to(cprm, dataoff);
>>>>> 
>>>>>     for (i = 0; i < cprm->vma_count; i++) {
>>>>> -             struct core_vma_metadata *meta = cprm->vma_meta + i;
>>>>> +             struct core_vma_metadata *meta;
>>>>> +
>>>>> +             if (ZERO_OR_NULL_PTR(sorted_vmas))
>>>>> +                     meta = cprm->vma_meta + i;
>>>>> +             else
>>>>> +                     meta = sorted_vmas[i];
>>>>> 
>>>>>             if (!dump_user_range(cprm, meta->start, meta->dump_size))
>>>>>                     goto end_coredump;
>>>>> @@ -2128,10 +2168,26 @@ static int elf_core_dump(struct coredump_params *cprm)
>>>>> end_coredump:
>>>>>     free_note_info(&info);
>>>>>     kfree(shdr4extnum);
>>>>> +     kvfree(sorted_vmas);
>>>>>     kfree(phdr4note);
>>>>>     return has_dumped;
>>>>> }
>>>>> 
>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>> +
>>>>> +static struct dentry *elf_core_debugfs;
>>>>> +
>>>>> +static int __init init_elf_core_debugfs(void)
>>>>> +{
>>>>> +     elf_core_debugfs = debugfs_create_dir("elf_core", NULL);
>>>>> +     debugfs_create_bool("sort_elf_core_vmas", 0644, elf_core_debugfs, &sort_elf_core_vmas);
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +fs_initcall(init_elf_core_debugfs);
>>>>> +
>>>>> +#endif               /* CONFIG_DEBUG_FS */
>>>>> +
>>>>> #endif               /* CONFIG_ELF_CORE */
>>>>> 
>>>>> static int __init init_elf_binfmt(void)
>>>>> @@ -2144,6 +2200,10 @@ static void __exit exit_elf_binfmt(void)
>>>>> {
>>>>>     /* Remove the COFF and ELF loaders. */
>>>>>     unregister_binfmt(&elf_format);
>>>>> +
>>>>> +#if defined(CONFIG_ELF_CORE) && defined(CONFIG_DEBUG_FS)
>>>>> +     debugfs_remove(elf_core_debugfs);
>>>>> +#endif
>>>>> }
>>>>> 
>>>>> core_initcall(init_elf_binfmt);
>>>>> 
>>>>> base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d

