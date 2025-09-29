Return-Path: <linux-fsdevel+bounces-63017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF44BA8DFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 12:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A503189D5FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 10:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591D42FBDE8;
	Mon, 29 Sep 2025 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIiSjgq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD22FB974
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141278; cv=none; b=TL+RpjWbxJWQm91eEQ9L8gjOWEU2y5QWL2MIb3hhwrAeOqcBqlJL9G1igXT+ffKIUb5SulDbhJifYfRJjpYPlyKcrtyAmf7atFBWl2t6pO8rLRMFVUH3yCVLoGgE7KFyaTiWlts3olLBzALGPb0k9sDxz8pzAYAeA+6D58UfA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141278; c=relaxed/simple;
	bh=WcvQCY0+UwCaIb6eCl0gssuyRiHF3sXxtaZi0SsyUzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uh1z+mVojatcEBHmjnLIVDjUKwnBZWJeS/xR7lW3wujfHLN0jximWd8GJjsz3lH66bShWbScUNlXVI2DpLVEolcsq4fFhuw1MHVU+gs/0jjlQR4eSZUtxY7hMPsWpJsT27YRbOcg+Tai3VTN4h7swt2xus+9z69R3JmrcmdJ4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIiSjgq1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759141275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z3YKN3zIRZfonnEHUxLu7FAkkWR5YdTCLJYZ6VEYM8Y=;
	b=fIiSjgq1ZZvEn7q1nKH1Ac+rmlfEHDp6FfOjtqYfZmTZlXFE11ugcoahidcKpJpfDiykMQ
	ybuT5Za8yfjHkedTdQQCQrv18izvZnHulIX5YkV2fvtuUZnyz7jLvoRxAGK1G0d2FqJW8Q
	kPF7LIZrlgfSr3HofI4u6V+BCTbxdpc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-O-PYEviwOai-aMk2D8fMZA-1; Mon, 29 Sep 2025 06:21:14 -0400
X-MC-Unique: O-PYEviwOai-aMk2D8fMZA-1
X-Mimecast-MFC-AGG-ID: O-PYEviwOai-aMk2D8fMZA_1759141273
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f3c118cbb3so2848877f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 03:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759141273; x=1759746073;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3YKN3zIRZfonnEHUxLu7FAkkWR5YdTCLJYZ6VEYM8Y=;
        b=I+QdOmR0SeiLC61OPt+URrE1xY2aF30h2GUdbtWelg7kY08qd+ngy5sufleHYz4ezM
         8hsnY54acBwmUp30c/I0snfAn7svXFc9rDQu5eg3zXl6FqUYBXCcfHZXSew5MaWSl27A
         EOkQyVweqa1v0C+M6LISZp6b46lzocYrQqt6hv2un9i4j1wUlKTJ639YC8sNY9cBH38G
         UrDafx6UZN/tYG/4QnudES+jilwdPGLLLycJlZiC17+QKyLOISL7M+ElqZIWJkNkl4WP
         EKdsJzSTwwKk3+NI5xFhJ2mJB+yt6yPqW3cM5PCTqVslMH93j2gHZtwu0JnMt9E9Lq28
         BvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzpYDe9kRZSbw4bQpriB9sRJ3vm/FB/PgdzLxSgGAipXo1GJwzt8WuT+vmvxXVEAiEm8JmLw2A7iSbs2pP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywohsx/JLEszDcsJHh2cTh7sfUXUiV1+/RmhrPtbBAClrQTTNDA
	YevsBt0UUEZZlVTSE0EJXrL/TiHLtvsvwvcDTRGwfYSOmKVwTSYFcL5+BiRkVVGu3tStehF3glQ
	CPKiw5GlNFZJ9f7/ucqhw85mL4qwdB9uYkfcTpPaUlJAW0J7tkFfJJ4XsSjfPparWM0g=
X-Gm-Gg: ASbGncuAlCcCvhCuJC0550jmGzOZrhQzbKRw4A2gnsH9i6lN5GcDsYe1WgcKwG+XOnM
	MXmp6FLDC6oJUhJJKtNo6kzJFBLc8qtx2bEflnH2Pk86gEXIwkc4Hz4oMICVZ6z+VOAKcgEN6DV
	Qezcnw0wJDNoayAaGCS/hsuTLjqomnysDP8cYpd3vwZjN1IEjPNq2eS1J5/r/nu17BrX49IrJiH
	sKPkop4mCa50X8uTEvSaDbE/zCPHmjC4Dk8UnlpPgLPtopNT7iDMria3U1ZuE3XHKWQJUlTOGSu
	Pnl9HzE9RxXw1O3QkCQ7hWY7kVlIFKZ0WJY6p0+LZIeABSDzDN8YZfUR3mSHwHYYdF4dYioG
X-Received: by 2002:a05:6000:2410:b0:3ec:d80d:e59b with SMTP id ffacd0b85a97d-40e4354d936mr17145979f8f.10.1759141273212;
        Mon, 29 Sep 2025 03:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHseD/VRuRD8/5XkmKc+WsswLQN2PeBfIKRcSn+dzEpfuntBaoyeW14SJHlBROwxevLjLT9Aw==
X-Received: by 2002:a05:6000:2410:b0:3ec:d80d:e59b with SMTP id ffacd0b85a97d-40e4354d936mr17145899f8f.10.1759141272561;
        Mon, 29 Sep 2025 03:21:12 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1fa94.dip0.t-ipconnect.de. [79.241.250.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603161sm17745080f8f.35.2025.09.29.03.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:21:11 -0700 (PDT)
Message-ID: <f13e06f3-3c7b-4993-b33a-a6921c14231b@redhat.com>
Date: Mon, 29 Sep 2025 12:20:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/12] KVM: guest_memfd: add module param for disabling
 TLB flushing
To: Patrick Roy <patrick.roy@linux.dev>, Will Deacon <will@kernel.org>
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <be89abc6-97ca-47d8-b8e7-95f58ab9cc67@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.09.25 09:38, Patrick Roy wrote:
> 
> 
> On Fri, 2025-09-26 at 21:09 +0100, David Hildenbrand wrote:
>> On 26.09.25 12:53, Will Deacon wrote:
>>> On Fri, Sep 26, 2025 at 10:46:15AM +0100, Patrick Roy wrote:
>>>>
>>>>
>>>> On Thu, 2025-09-25 at 21:13 +0100, David Hildenbrand wrote:
>>>>> On 25.09.25 21:59, Dave Hansen wrote:
>>>>>> On 9/25/25 12:20, David Hildenbrand wrote:
>>>>>>> On 25.09.25 20:27, Dave Hansen wrote:
>>>>>>>> On 9/24/25 08:22, Roy, Patrick wrote:
>>>>>>>>> Add an option to not perform TLB flushes after direct map manipulations.
>>>>>>>>
>>>>>>>> I'd really prefer this be left out for now. It's a massive can of worms.
>>>>>>>> Let's agree on something that works and has well-defined behavior before
>>>>>>>> we go breaking it on purpose.
>>>>>>>
>>>>>>> May I ask what the big concern here is?
>>>>>>
>>>>>> It's not a _big_ concern.
>>>>>
>>>>> Oh, I read "can of worms" and thought there is something seriously problematic :)
>>>>>
>>>>>> I just think we want to start on something
>>>>>> like this as simple, secure, and deterministic as possible.
>>>>>
>>>>> Yes, I agree. And it should be the default. Less secure would have to be opt-in and documented thoroughly.
>>>>
>>>> Yes, I am definitely happy to have the 100% secure behavior be the
>>>> default, and the skipping of TLB flushes be an opt-in, with thorough
>>>> documentation!
>>>>
>>>> But I would like to include the "skip tlb flushes" option as part of
>>>> this patch series straight away, because as I was alluding to in the
>>>> commit message, with TLB flushes this is not usable for Firecracker for
>>>> performance reasons :(
>>>
>>> I really don't want that option for arm64. If we're going to bother
>>> unmapping from the linear map, we should invalidate the TLB.
>>
>> Reading "TLB flushes result in a up to 40x elongation of page faults in
>> guest_memfd (scaling with the number of CPU cores), or a 5x elongation
>> of memory population,", I can understand why one would want that optimization :)
>>
>> @Patrick, couldn't we use fallocate() to preallocate memory and batch the TLB flush within such an operation?
>>
>> That is, we wouldn't flush after each individual direct-map modification but after multiple ones part of a single operation like fallocate of a larger range.
>>
>> Likely wouldn't make all use cases happy.
>>
> 
> For Firecracker, we rely a lot on not preallocating _all_ VM memory, and
> trying to ensure only the actual "working set" of a VM is faulted in (we
> pack a lot more VMs onto a physical host than there is actual physical
> memory available). For VMs that are restored from a snapshot, we know
> pretty well what memory needs to be faulted in (that's where @Nikita's
> write syscall comes in), so there we could try such an optimization. But
> for everything else we very much rely on the on-demand nature of guest
> memory allocation (and hence direct map removal). And even right now,
> the long pole performance-wise are these on-demand faults, so really, we
> don't want them to become even slower :(

Makes sense. I guess even without support for large folios one could 
implement a kind of "fault" around: for example, on access to one addr, 
allocate+prepare all pages in the same 2 M chunk, flushing the tlb only 
once after adjusting all the direct map entries.

> 
> Also, can we really batch multiple TLB flushes as you suggest? Even if
> pages are at consecutive indices in guest_memfd, they're not guaranteed
> to be continguous physically, e.g. we couldn't just coalesce multiple
> TLB flushes into a single TLB flush of a larger range.

Well, you there is the option on just flushing the complete tlb of 
course :) When trying to flush a range you would indeed run into the 
problem of flushing an ever growing range.

> 
> There's probably other things we can try. Backing guest_memfd with
> hugepages would reduce the number TLB flushes by 512x (although not all
> users of Firecracker at Amazon [can] use hugepages).

Right.

> 
> And I do still wonder if it's possible to have "async TLB flushes" where
> we simply don't wait for the IPI (x86 terminology, not sure what the
> mechanism on arm64 is). Looking at
> smp_call_function_many_cond()/invlpgb_kernel_range_flush() on x86, it
> seems so? Although seems like on ARM it's actually just handled by a
> single instruction (TLBI) and not some interprocess communication
> thingy. Maybe there's a variant that's faster / better for this usecase?

Right, some architectures (and IIRC also x86 with some extension) are 
able to flush remote TLBs without IPIs.

Doing a quick search, there seems to be some research on async TLB 
flushing, e.g., [1].

In the context here, I wonder whether an async TLB flush would be 
significantly better than not doing an explicit TLB flush: in both 
cases, it's not really deterministic when the relevant TLB entries will 
vanish: with the async variant it might happen faster on average I guess.


[1] https://cs.yale.edu/homes/abhishek/kumar-taco20.pdf

-- 
Cheers

David / dhildenb


