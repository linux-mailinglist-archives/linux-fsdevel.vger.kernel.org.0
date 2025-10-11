Return-Path: <linux-fsdevel+bounces-63845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86814BCF76A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C7694E3CC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEC127E7F0;
	Sat, 11 Oct 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UjrCKKxZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9B263F2D
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760193176; cv=none; b=E+u9i8l4yrYoMmbQ+13P+dQhilPw4GSI3h1q+bCejCFoxZIRfMzEJo9RMMohJrbMbTrQDVDomnOrO5+jUod6GgJssqbDB2VcHIOlnVtcs9Tv/dBZoELex7Aj8Q1gh1I1HwPPDJwxGRYDI2Y7/fYfBoq4ZCKZdGwOe5aMRaFg6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760193176; c=relaxed/simple;
	bh=Rg//Celz7bZVYwFutchuLMutpRd3KAuXCKgvp9l+Sp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uu7KhF7fwvhAZJltRif9BGFK95Mz2SLkT8ozXXphoFME8ZMfzDNZ7A1VTVR5mJCsLDvU+Je/CgURhssyb+CQJXXtWmyXIiYfqdyC191hCrOSU0uKDWXgaOLd9PQ5K9iKpAkfwWpQbZVawd0+xnhLtDASt+MA5a+uPElJQ5QqclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UjrCKKxZ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d25340e3-2017-4614-a472-c5c7244c7ce4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760193160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6DAktFf8ux13w20eariAQM5EE06H68osCBE8i4364c=;
	b=UjrCKKxZ7HfUt7+I13g5vfVRPU1qXFULaDafrS7I83LwXVt6aH0moEoYrW9v3fMHyte3Lc
	JIVb1vAXalk/iAX9JV1paqTF7GbCKdZcWmZHtsHe0AsdOKnwoKmIv3g4EwebnsComkRoff
	oN69fjYfPJQ1nqoEOUx/q55njQikJ+A=
Date: Sat, 11 Oct 2025 16:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 06/12] KVM: guest_memfd: add module param for disabling
 TLB flushing
To: David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, "Roy, Patrick"
 <roypat@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "song@kernel.org" <song@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jannh@google.com"
 <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
 "shuah@kernel.org" <shuah@kernel.org>, "seanjc@google.com"
 <seanjc@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "Thomson, Jack" <jackabt@amazon.co.uk>,
 "derekmn@amazon.co.uk" <derekmn@amazon.co.uk>,
 "tabba@google.com" <tabba@google.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
 <20250924152214.7292-3-roypat@amazon.co.uk>
 <e25867b6-ffc0-4c7c-9635-9b3f47b186ca@intel.com>
 <c1875a54-0c87-450f-9370-29e7ec4fea3d@redhat.com>
 <82bff1c4-987f-46cb-833c-bd99eaa46e7a@intel.com>
 <c79173d8-6f18-40fa-9621-e691990501e4@redhat.com>
 <c88514c3-e15f-4853-8acf-15e7b4b979f4@linux.dev>
 <aNZwmPFAxm_HRYpC@willie-the-truck>
 <5d11b5f7-3208-4ea8-bbff-f535cf62d576@redhat.com>
 <be89abc6-97ca-47d8-b8e7-95f58ab9cc67@linux.dev>
 <f13e06f3-3c7b-4993-b33a-a6921c14231b@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Patrick Roy <patrick.roy@linux.dev>
Content-Language: en-US
In-Reply-To: <f13e06f3-3c7b-4993-b33a-a6921c14231b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hey all,

sorry it took me a while to get back to this, turns out moving
internationally is move time consuming than I expected.

On Mon, 2025-09-29 at 12:20 +0200, David Hildenbrand wrote:
> On 27.09.25 09:38, Patrick Roy wrote:
>> On Fri, 2025-09-26 at 21:09 +0100, David Hildenbrand wrote:
>>> On 26.09.25 12:53, Will Deacon wrote:
>>>> On Fri, Sep 26, 2025 at 10:46:15AM +0100, Patrick Roy wrote:
>>>>> On Thu, 2025-09-25 at 21:13 +0100, David Hildenbrand wrote:
>>>>>> On 25.09.25 21:59, Dave Hansen wrote:
>>>>>>> On 9/25/25 12:20, David Hildenbrand wrote:
>>>>>>>> On 25.09.25 20:27, Dave Hansen wrote:
>>>>>>>>> On 9/24/25 08:22, Roy, Patrick wrote:
>>>>>>>>>> Add an option to not perform TLB flushes after direct map manipulations.
>>>>>>>>>
>>>>>>>>> I'd really prefer this be left out for now. It's a massive can of worms.
>>>>>>>>> Let's agree on something that works and has well-defined behavior before
>>>>>>>>> we go breaking it on purpose.
>>>>>>>>
>>>>>>>> May I ask what the big concern here is?
>>>>>>>
>>>>>>> It's not a _big_ concern.
>>>>>>
>>>>>> Oh, I read "can of worms" and thought there is something seriously problematic :)
>>>>>>
>>>>>>> I just think we want to start on something
>>>>>>> like this as simple, secure, and deterministic as possible.
>>>>>>
>>>>>> Yes, I agree. And it should be the default. Less secure would have to be opt-in and documented thoroughly.
>>>>>
>>>>> Yes, I am definitely happy to have the 100% secure behavior be the
>>>>> default, and the skipping of TLB flushes be an opt-in, with thorough
>>>>> documentation!
>>>>>
>>>>> But I would like to include the "skip tlb flushes" option as part of
>>>>> this patch series straight away, because as I was alluding to in the
>>>>> commit message, with TLB flushes this is not usable for Firecracker for
>>>>> performance reasons :(
>>>>
>>>> I really don't want that option for arm64. If we're going to bother
>>>> unmapping from the linear map, we should invalidate the TLB.
>>>
>>> Reading "TLB flushes result in a up to 40x elongation of page faults in
>>> guest_memfd (scaling with the number of CPU cores), or a 5x elongation
>>> of memory population,", I can understand why one would want that optimization :)
>>>
>>> @Patrick, couldn't we use fallocate() to preallocate memory and batch the TLB flush within such an operation?
>>>
>>> That is, we wouldn't flush after each individual direct-map modification but after multiple ones part of a single operation like fallocate of a larger range.
>>>
>>> Likely wouldn't make all use cases happy.
>>>
>>
>> For Firecracker, we rely a lot on not preallocating _all_ VM memory, and
>> trying to ensure only the actual "working set" of a VM is faulted in (we
>> pack a lot more VMs onto a physical host than there is actual physical
>> memory available). For VMs that are restored from a snapshot, we know
>> pretty well what memory needs to be faulted in (that's where @Nikita's
>> write syscall comes in), so there we could try such an optimization. But
>> for everything else we very much rely on the on-demand nature of guest
>> memory allocation (and hence direct map removal). And even right now,
>> the long pole performance-wise are these on-demand faults, so really, we
>> don't want them to become even slower :(
> 
> Makes sense. I guess even without support for large folios one could implement a kind of "fault" around: for example, on access to one addr, allocate+prepare all pages in the same 2 M chunk, flushing the tlb only once after adjusting all the direct map entries.
> 
>>
>> Also, can we really batch multiple TLB flushes as you suggest? Even if
>> pages are at consecutive indices in guest_memfd, they're not guaranteed
>> to be continguous physically, e.g. we couldn't just coalesce multiple
>> TLB flushes into a single TLB flush of a larger range.
> 
> Well, you there is the option on just flushing the complete tlb of course :) When trying to flush a range you would indeed run into the problem of flushing an ever growing range.

In the last guest_memfd upstream call (over a week ago now), we've
discussed the option of batching and deferring TLB flushes, while
providing a sort of "deadline" at which a TLB flush will
deterministically be done.  E.g. guest_memfd would keep a counter of how
many pages got direct map zapped, and do a flush of a range that
contains all zapped pages every 512 allocated pages (and to ensure the
flushes even happen in a timely manner if no allocations happen for a
long time, also every, say, 5 seconds or something like that). Would
that work for everyone? I briefly tested the performance of
batch-flushes with secretmem in QEMU, and its within of 30% of the "no
TLB flushes at all" solution in a simple benchmark that just memsets
2GiB of memory.

I think something like this, together with the batch-flushing at the end
of fallocate() / write() as David suggested above should work for
Firecracker.

>> There's probably other things we can try. Backing guest_memfd with
>> hugepages would reduce the number TLB flushes by 512x (although not all
>> users of Firecracker at Amazon [can] use hugepages).
> 
> Right.
> 
>>
>> And I do still wonder if it's possible to have "async TLB flushes" where
>> we simply don't wait for the IPI (x86 terminology, not sure what the
>> mechanism on arm64 is). Looking at
>> smp_call_function_many_cond()/invlpgb_kernel_range_flush() on x86, it
>> seems so? Although seems like on ARM it's actually just handled by a
>> single instruction (TLBI) and not some interprocess communication
>> thingy. Maybe there's a variant that's faster / better for this usecase?
> 
> Right, some architectures (and IIRC also x86 with some extension) are able to flush remote TLBs without IPIs.
> 
> Doing a quick search, there seems to be some research on async TLB flushing, e.g., [1].
> 
> In the context here, I wonder whether an async TLB flush would be
> significantly better than not doing an explicit TLB flush: in both
> cases, it's not really deterministic when the relevant TLB entries
> will vanish: with the async variant it might happen faster on average
> I guess.

I actually did end up playing around with this a while ago, and it made
things slightly better performance wise, but it was still too bad to be
useful :(

> 
> [1] https://cs.yale.edu/homes/abhishek/kumar-taco20.pdf
>

Best, 
Patrick

