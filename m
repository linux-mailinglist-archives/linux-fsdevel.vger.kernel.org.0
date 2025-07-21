Return-Path: <linux-fsdevel+bounces-55592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9049FB0C394
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 13:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B578F16391D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797A12BEC3A;
	Mon, 21 Jul 2025 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/8JEF/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284C2C1589
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098328; cv=none; b=KFUN4aiDaYQD7AUo2C6eTAVWS9FM/PXaF86J+TTxDr/vP+Lm6yz2ltWOty9ISbK/sj7tFn/j/2sPzSE4rcTUIiDhsCs8V6lkGdqMmxYT9ZPCg84QAAT/OVEIgV/sGIoWwnThsD4Z5akqgwHUwsj+ydjnspkUNeeEmn+C5drDHl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098328; c=relaxed/simple;
	bh=8iiQehblZ5rquvWL/VzSvnqAa2ba9yxjtbrJQkr2at4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5OLZPE2Y4m9iYyR18FrZniKO9Pq7Y25vRYD+uMv47SiGza4k/Zip/qAQsYvd0jdP118f7g32I98mE0kOBJhXOlMwbZPtpjCjbTvFG77vzmks7psE5p3YOKZJTvoHfzdCSJwES0+7BShAUgu2R8Ds7hJDyMY70jqUQLAcfq6cZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/8JEF/8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753098324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GCnwDj1L7bKo73iyzhJL71q39FbBt4cl5tPwgm7Q5oE=;
	b=M/8JEF/8Rz4uxTfsMwTkwgyjGm1/DC7StXkaY1CWWiOFhXzuuPQ5vV4xdKT5NYu2LjVSH6
	D1+Td8asNYWCIw4bsWJhDqMA8HorFMAJP3iugSjv3wd3TjbNlRGKcDY5L9WDNCHIeWV5Nl
	G7yOWNPk/BNn71IdjckBEd0HaytC0lQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-xhBwET7UMjWwjLlMA1RMfA-1; Mon, 21 Jul 2025 07:45:22 -0400
X-MC-Unique: xhBwET7UMjWwjLlMA1RMfA-1
X-Mimecast-MFC-AGG-ID: xhBwET7UMjWwjLlMA1RMfA_1753098321
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so1825289f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 04:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098321; x=1753703121;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GCnwDj1L7bKo73iyzhJL71q39FbBt4cl5tPwgm7Q5oE=;
        b=Mw03kInLLpgRRqt/aVuxlnHbFAFE69/mXeFwvtVpQhtnNoA6IZVD6PM70GgyxK8dI5
         2mkEd4ZyK4TACv65PG/MCXser03vdFy4B1y98s19NgrRoyr0pMgb0C9TBfZaQi4v3pTY
         T7++zVWmbJC5BDcahu60b7PsX2EwEFKZJAPTnu8Tza295vMzGOHyeS6plVOIesTQH8bV
         tnysp+dvfic56gA0QmkAjUQzO/PCrot5BwIND1S4zACfYdzL1ql4AMaJISDX6mOy4nQd
         ixvqCZVniXjcImlU6Ln/dOuR14knWutkYU98nYO4O3/HhsgVaFvwUvqfwnlLzdk/J2Vn
         DFkg==
X-Forwarded-Encrypted: i=1; AJvYcCVCUBpQqR8YvLLJ7ExpvMjDYh87BMWyClfHtbqW7fGF5ODsfwhUBXEWJMQ9Zfkg0VP4gzxVXMKc6pQ1aRSa@vger.kernel.org
X-Gm-Message-State: AOJu0Yxei/TrAKlJtLwmPc7LGFaz9NmyBpP6tyiR8GG+4x7dzcfGGRQ5
	MUgJet6QrY2CXEjeeY91fi22Vvk9xsquuvUcRMuevib9loEi+49vd0iAmRw98JoYKJX6L2GmjdI
	fEKRhepVwF4JciZDQB99DgybuKfxT9IZe1Jw21RldxQfv4OKzSq9urIhn9G5W6ScWIaA=
X-Gm-Gg: ASbGncsEDOw8QbmpbSKiv4rwUvJrGDjgVePDVoFY/HbAFvDIO778A+Z7/EIxqRSjX/r
	CXNLJ2UMh5gAUKUeONTHozUPZLOdQ8YrQYieQ63G69o8dJh1UdhApax+QqvBXVjR0PRBBABLCxL
	fkJrvSBkiFEcV4PNi8bPkFKwVfNe+rF5K8lEeofp9I+UaRnI/grhZHLwwyKAedmOAqri+X9gXLp
	/+2C/8tTYVgnT3HsEYjQUdqy4ZtVTClpaHDyh4Vh5shqZ3cUfjU4KZvOyn4y7WHluyAT6KuPWzB
	sX433QDs6+Red4iVFEFlX8WXepHHgeUG0P8ICBl5a2cQ6/N64mvyC91sHDLPOCtjhOeBGkg+viw
	5znymeTtgrIRboPv5zv6Lz+rTq7/wA8s91PKUhuYucLc0fBBoPPmKo8j0RMelZeOm
X-Received: by 2002:a05:6000:64a:b0:3b6:1a2c:2543 with SMTP id ffacd0b85a97d-3b61a2c2743mr8555899f8f.6.1753098320984;
        Mon, 21 Jul 2025 04:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVLRVT9BOVXKuSr+ITnX/oZWo1nET6OmXFxbgiR6lPnpga9oIpUNc+iVZLgSNke4NLdi5Clg==
X-Received: by 2002:a05:6000:64a:b0:3b6:1a2c:2543 with SMTP id ffacd0b85a97d-3b61a2c2743mr8555849f8f.6.1753098320245;
        Mon, 21 Jul 2025 04:45:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4c:df00:a9f5:b75b:33c:a17f? (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de. [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d581sm10094306f8f.64.2025.07.21.04.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 04:45:19 -0700 (PDT)
Message-ID: <ff53959b-a402-4030-b11a-dc19fe36ee4e@redhat.com>
Date: Mon, 21 Jul 2025 13:45:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Usama Arif <usamaarif642@gmail.com>,
 SeongJae Park <sj@kernel.org>, Jann Horn <jannh@google.com>,
 Yafang Shao <laoar.shao@gmail.com>, Matthew Wilcox <willy@infradead.org>
References: <20250721090942.274650-1-david@redhat.com>
 <686d2658-a06e-46cb-af22-440b75ac34ed@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <686d2658-a06e-46cb-af22-440b75ac34ed@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.07.25 13:28, Lorenzo Stoakes wrote:
> Overall, while I HATE this interface (as y'know, everyone knows :P), since
> it _already_ exists and fulfils a real need (and we _have_ to keep
> supporting that need) I'm open to us solving the issue this way.
> 
> So this might be a way for us to achieve what Usama + others need without
> having to splice in horridness.
> 
> This as a proof-of-concept is obviously not for 6.17 (and late in the day
> anyway :P), so we have at least 6.18 cycle to discuss.
> 
> On Mon, Jul 21, 2025 at 11:09:42AM +0200, David Hildenbrand wrote:
>> People want to make use of more THPs, for example, moving from
>> THP=never to THP=madvise, or from THP=madvise to THP=never.
> 
> Nitty, but sort of vague as to what THP= means here, I'd just say 'from
> never to madvise, or from madvise to never' - it's pretty clear what you
> mean and keeps enough 'flexibility' of interpretation to cover off the
> various ways you can do this in the sysfs interfaces.
 > > Same comment for simlar below.
> 
>>
>> While this is great news for every THP desperately waiting to get
>> allocated out there, apparently there are some workloads that require a
>> bit of care during that transition: once problems are detected, these
>> workloads should be started with the old behavior, without making all
>> other workloads on the system go back to the old behavior as well.
> 
> I'm confused about what 'old behavior' is here. Also it's not always
> necessarily due to problems, there can be a desire to treat THPs as a
> resource to be distributed as desired.
> 
> So I'd say something like '... transition: individual processes may need to
> opt-out from this behaviour for various reasons, and this should be
> permitted without needing to make all other workloads on the system
> similarly opt-out'.

No strong opinion.

> 
>>
>> In essence, the following scenarios are imaginable:
>>
>> (1) Switch from THP=none to THP=madvise or THP=always, but keep the old
>>      behavior (no THP) for selected workloads.
> 
> I'd remove 'old behavior' here as it's confusing, and simply refer to THP
> being disabled for selected  workloads.

Yes.

> 
>>
>> (2) Stay at THP=none, but have "madvise" or "always" behavior for
>>      selected workloads.
>>
>> (3) Switch from THP=madvise to THP=always, but keep the old behavior
>>      (THP only when advised) for selected workloads.
>>
>> (4) Stay at THP=madvise, but have "always" behavior for selected
>>      workloads.
>>
>> In essence, (2) can be emulated through (1), by setting THP!=none while
>> disabling THPs for all processes that don't want THPs. It requires
>> configuring all workloads, but that is a user-space problem to sort out.
> 
> NIT: Delete 'In essence' here.

I wanted "something" there to not make it look like the list keeps going 
on in a weird way ;)

> 
>>
>> (4) can be emulated through (3) in a similar way.
>>
>> Back when (1) was relevant in the past, as people started enabling THPs,
>> we added PR_SET_THP_DISABLE, so relevant workloads that were not ready
>> yet (i.e., used by Redis) were able to just disable THPs completely. Redis
>> still implements the option to use this interface to disable THPs
>> completely.
>>
>> With PR_SET_THP_DISABLE, we added a way to force-disable THPs for a
>> workload -- a process, including fork+exec'ed process hierarchy.
>> That essentially made us support (1): simply disable THPs for all workloads
>> that are not ready for THPs yet, while still enabling THPs system-wide.
>>
>> The quest for handling (3) and (4) started, but current approaches
>> (completely new prctl, options to set other policies per processm,
>>   alternatives to prctl -- mctrl, cgroup handling) don't look particularly
>> promising. Likely, the future will use bpf or something similar to
>> implement better policies, in particular to also make better decisions
>> about THP sizes to use, but this will certainly take a while as that work
>> just started.
> 
> Ack.
> 
>>
>> Long story short: a simple enable/disable is not really suitable for the
>> future, so we're not willing to add completely new toggles.
> 
> Yes this is the crux of the problem.
> 
>>
>> While we could emulate (3)+(4) through (1)+(2) by simply disabling THPs
>> completely for these processes, this scares many THPs in our system
>> because they could no longer get allocated where they used to be allocated
>> for: regions flagged as VM_HUGEPAGE. Apparently, that imposes a
>> problem for relevant workloads, because "not THPs" is certainly worse
>> than "THPs only when advised".
> 
> I don't know what you mean by 'scares' many THPs? :P

They are very afraid of not getting allocated :)

> 
>>
>> Could we simply relax PR_SET_THP_DISABLE, to "disable THPs unless not
>> explicitly advised by the app through MAD_HUGEPAGE"? *maybe*, but this
> 
> MAD_HUGEPAGE -> MADV_HUGEPAGE
> 
> I'm confused by 'unless not explicitly advised' do you mean 'disable THPs
> unless explicitly advised by the app through MADV_HUGEPAGE'?

Yes.

> 
>> would change the documented semantics quite a bit, and the versatility
>> to use it for debugging purposes, so I am not 100% sure that is what we
>> want -- although it would certainly be much easier.
>>
>> So instead, as an easy way forward for (3) and (4), an option to
>> make PR_SET_THP_DISABLE disable *less* THPs for a process.
>>
>> In essence, this patch:
>>
>> (A) Adds PR_THP_DISABLE_EXCEPT_ADVISED, to be used as a flag in arg3
>>      of prctl(PR_SET_THP_DISABLE) when disabling THPs (arg2 != 0).
> 
> prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED)?
> 
>>
>>      For now, arg3 was not allowed to be set (-EINVAL). Now it holds
>>      flags.
> 
> This sentence is redundant.
> 
>>
>> (B) Makes prctl(PR_GET_THP_DISABLE) return 3 if
>>      PR_THP_DISABLE_EXCEPT_ADVISED was set while disabling.
>>
>>      For now, it would return 1 if THPs were disabled completely. Now
>>      it essentially returns the set flags as well.
> 
> For now as in 'previously'. I guess right now it's just used as a boolean,
> so this seems fine.
> 
>>
>> (C) Renames MMF_DISABLE_THP to MMF_DISABLE_THP_COMPLETELY, to express
>>      the semantics clearly.
>>
>>      Fortunately, there are only two instances outside of prctl() code.
>>
>> (D) Adds MMF_DISABLE_THP_EXCEPT_ADVISED to express "no THP except for VMAs
>>      with VM_HUGEPAGE" -- essentially "thp=madvise" behavior
>>
>>      Fortunately, we only have to extend vma_thp_disabled().
>>
>> (E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are not
>>      disabled completely
> 
> You mean 'are disabled completely' but this has been covered already :P

Yeah, see my self-reply.

> 
>>
>>      Only indicating that THPs are disabled when they are really disabled
>>      completely, not only partially.
> 
> 
> So the really interesting part in the above is the small delta this change
> represents... which makes it a lot more compelling as a solution.
> 
>>
>> The documented semantics in the man page for PR_SET_THP_DISABLE
>> "is inherited by a child created via fork(2) and is preserved across
>> execve(2)" is maintained. This behavior, for example, allows for
>> disabling THPs for a workload through the launching process (e.g.,
>> systemd where we fork() a helper process to then exec()).
> 
> Yeah, this is something I REALLY don't want us to perpetuate, as it's
> adding a now policy method by the 'back door'.
> 
> I had actually come to the conclusion that we absolutely should NOT
> implement anything like this, as discussed in the THP cabal meeting.
> 
> HOWEVER, since this mechanism ALREADY EXISTS for this case, I am much more
> ok with this.
> 
> We already perpetuate state for this across fork/exec.
> 
>>
>> There is currently not way to prevent that a process will not issue
>> PR_SET_THP_DISABLE itself to re-enable THP. We could add a "seal" option
>> to PR_SET_THP_DISABLE through another flag if ever required. The known
>> users (such as redis) really use PR_SET_THP_DISABLE to disable THPs, so
>> that is not added for now.
> 
> Yeah not a fan of the seal idea, that will add a bunch of complexity and
> state that I would rather not have.
> 
> I'd far prefer just disallowing re-enabling THP. We could allow
> re-disabling with different flags though.
> 
> Be good to get some examples of the old + new prctl() invocations in the
> commit message too.
> 
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Usama Arif <usamaarif642@gmail.com>
>> Cc: SeongJae Park <sj@kernel.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Cc: Yafang Shao <laoar.shao@gmail.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> ---
>>
>> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
>> think there might be real use cases where we want to disable any THPs --
>> in particular also around debugging THP-related problems, and
>> "THP=never" not meaning ... "never" anymore. PR_SET_THP_DISABLE will
> 
> Well, not quite anymore :) it's been this way for a while right? Even since
> MADV_COLLAPSE was introduced.

It goes back to 3.15, yes ...

> 
>> also block MADV_COLLAPSE, which can be very helpful. Of course, I thought
> 
> Yes.
> 
> I mean I hate, hate, HATE this interface. But it exists and we have to
> support it anyway.
> 
>> of having a system-wide config to change PR_SET_THP_DISABLE behavior, but
>> I just don't like the semantics.
> 
> What do you mean?

Kconfig option to change the behavior etc. In summary, I don't want to 
go down that path, it all gets weird.

> 
>>
>> "prctl: allow overriding system THP policy to always"[1] proposed
>> "overriding policies to always", which is just the wrong way around: we
>> should not add mechanisms to "enable more" when we already have an
>> interface/mechanism to "disable" them (PR_SET_THP_DISABLE). It all gets
>> weird otherwise.
> 
> Yes. A 'disable but' is more logical.
> 
>>
>> "[PATCH 0/6] prctl: introduce PR_SET/GET_THP_POLICY"[2] proposed
>> setting the default of the VM_HUGEPAGE, which is similarly the wrong way
>> around I think now.
> 
> Yes.
> 
>>
>> The proposals by Lorenzo to extend process_madvise()[3] and mctrl()[4]
>> similarly were around the "default for VM_HUGEPAGE" idea, but after the
>> discussion, I think we should better leave VM_HUGEPAGE untouched.
> 
> Well, to be clear, these were more 'if we HAVE to do this, what is the
> least awful way of doing this?' rather than proposals per se :P and mctrl()
> was really taking existing discussed ideas and -simply seeing how it looked
> in code- though in the end we decided better to spell out in words how it
> would look.
> 
> At least now I'm not in favour of us implementing policy this way (but
> again, am open to us extending an _existing_ abomination :)
> 
>>
>> Happy to hear naming suggestions for "PR_THP_DISABLE_EXCEPT_ADVISED" where
>> we essentially want to say "leave advised regions alone" -- "keep THP
>> enabled for advised regions",
> 
> Seems OK to me. I guess the one point of confusion could be people being
> confused between the THP toggle 'madvise' vs. actually having MADV_HUGEPAGE
> set, but that's moot, because 'madvise' mode only enables THP if the region
> has had MADV_HUGEPAGE set.

Right, whatever ends up setting VM_HUGEPAGE.

> 
>>
>> The only thing I really dislike about this is using another MMF_* flag,
>> but well, no way around it -- and seems like we could easily support
>> more than 32 if we want to, or storing this thp information elsewhere.
> 
> Yes my exact thoughts. But I will be adding a series to change this for VMA
> flags soon enough, and can potentially do mm flags at the same time...
> 
> So this shouldn't in the end be as much of a problem.
> 
> Maybe it's worth holding off on this until I've done that? But at any rate
> I intend to do those changes next cycle, and this will be a next cycle
> thing at the earliest anyway.

I don't think this series must be blocked by that. Using a bitmap 
instead of a single "unsigned long" should be fairly easy later -- I did 
not identify any big blockers.

> 
>>
>> I think this here (modifying an existing toggle) is the only prctl()
>> extension that we might be willing to accept. In general, I agree like
>> most others, that prctl() is a very bad interface for that -- but
>> PR_SET_THP_DISABLE is already there and is getting used.
> 
> Yes.
> 
>>
>> Long-term, I think the answer will be something based on bpf[5]. Maybe
>> in that context, I there could still be value in easily disabling THPs for
>> selected workloads (esp. debugging purposes).
>>
>> Jann raised valid concerns[6] about new flags that are persistent across
>> exec[6]. As this here is a relaxation to existing PR_SET_THP_DISABLE I
>> consider it having a similar security risk as our existing
>> PR_SET_THP_DISABLE, but devil is in the detail.
> 
> Yes...
> 
>>
>> This is *completely* untested and might be utterly broken. It merely
>> serves as a PoC of what I think could be done. If this ever goes upstream,
>> we need some kselftests for it, and extensive tests.
> 
> Well :) I mean we should definitely try this out in anger and it _MUST_
> have self tests and put under some pressure.
> 
> Usama, can you attack this and see?

Yes, that's what I am hoping for.

> 
>>
>> [1] https://lore.kernel.org/r/20250507141132.2773275-1-usamaarif642@gmail.com
>> [2] https://lkml.kernel.org/r/20250515133519.2779639-2-usamaarif642@gmail.com
>> [3] https://lore.kernel.org/r/cover.1747686021.git.lorenzo.stoakes@oracle.com
>> [4] https://lkml.kernel.org/r/85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local
>> [5] https://lkml.kernel.org/r/20250608073516.22415-1-laoar.shao@gmail.com
>> [6] https://lore.kernel.org/r/CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com
>>
>> ---
>>   Documentation/filesystems/proc.rst |  5 +--
>>   fs/proc/array.c                    |  2 +-
>>   include/linux/huge_mm.h            | 20 ++++++++---
>>   include/linux/mm_types.h           | 13 +++----
>>   include/uapi/linux/prctl.h         |  7 ++++
>>   kernel/sys.c                       | 58 +++++++++++++++++++++++-------
>>   mm/khugepaged.c                    |  2 +-
>>   7 files changed, 78 insertions(+), 29 deletions(-)
>>
>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>> index 2971551b72353..915a3e44bc120 100644
>> --- a/Documentation/filesystems/proc.rst
>> +++ b/Documentation/filesystems/proc.rst
>> @@ -291,8 +291,9 @@ It's slow but very precise.
>>    HugetlbPages                size of hugetlb memory portions
>>    CoreDumping                 process's memory is currently being dumped
>>                                (killing the process may lead to a corrupted core)
>> - THP_enabled		     process is allowed to use THP (returns 0 when
>> -			     PR_SET_THP_DISABLE is set on the process
>> + THP_enabled                 process is allowed to use THP (returns 0 when
>> +                             PR_SET_THP_DISABLE is set on the process to disable
>> +                             THP completely, not just partially)
> 
> Hmm but this means we have no way of knowing if it's set for partial

Yes. I briefly thought about indicating another member, but then I 
thought (a) it's ugly and (b) "who cares".

I also thought about just printing "partial" instead of "1", but not 
sure if that would break any parser.

> 
>>    Threads                     number of threads
>>    SigQ                        number of signals queued/max. number for queue
>>    SigPnd                      bitmap of pending signals for the thread
>> diff --git a/fs/proc/array.c b/fs/proc/array.c
>> index d6a0369caa931..c4f91a784104f 100644
>> --- a/fs/proc/array.c
>> +++ b/fs/proc/array.c
>> @@ -422,7 +422,7 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>>   	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
>>
>>   	if (thp_enabled)
>> -		thp_enabled = !test_bit(MMF_DISABLE_THP, &mm->flags);
>> +		thp_enabled = !test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
>>   	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>>   }
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index e0a27f80f390d..c4127104d9bc3 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -323,16 +323,26 @@ struct thpsize {
>>   	(transparent_hugepage_flags &					\
>>   	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
>>
>> +/*
>> + * Check whether THPs are explicitly disabled through madvise or prctl, or some
>> + * architectures may disable THP for some mappings, for example, s390 kvm.
>> + */
>>   static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>>   		vm_flags_t vm_flags)
> 
> This _should_ work as we set/clear VM_HUGEPAGE, VM_NOHUGEPAGE in madvise()
> unconditionally without bothering to check available THP orders first so no
> chicken-and-egg here.
> 
>>   {
>> +	/* Are THPs disabled for this VMA? */
>> +	if (vm_flags & VM_NOHUGEPAGE)
>> +		return true;
>> +	/* Are THPs disabled for all VMAs in the whole process? */
>> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, &vma->vm_mm->flags))
>> +		return true;
>>   	/*
>> -	 * Explicitly disabled through madvise or prctl, or some
>> -	 * architectures may disable THP for some mappings, for
>> -	 * example, s390 kvm.
>> +	 * Are THPs disabled only for VMAs where we didn't get an explicit
>> +	 * advise to use them?
> 
> Probably fine to drop the rather pernickety reference to s390 kvm here, I
> mean we don't need to spell out massively specific details in a general
> handler.

No strong opinion.

> 
>>   	 */
>> -	return (vm_flags & VM_NOHUGEPAGE) ||
>> -	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
>> +	if (vm_flags & VM_HUGEPAGE)
>> +		return false;
>> +	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
>>   }
>>
>>   static inline bool thp_disabled_by_hw(void)
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 1ec273b066915..a999f2d352648 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -1743,19 +1743,16 @@ enum {
>>   #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
>>   #define MMF_VM_HUGEPAGE		17	/* set when mm is available for khugepaged */
>>
>> -/*
>> - * This one-shot flag is dropped due to necessity of changing exe once again
>> - * on NFS restore
>> - */
>> -//#define MMF_EXE_FILE_CHANGED	18	/* see prctl_set_mm_exe_file() */
>> +#define MMF_HUGE_ZERO_PAGE	18      /* mm has ever used the global huge zero page */
>>
>>   #define MMF_HAS_UPROBES		19	/* has uprobes */
>>   #define MMF_RECALC_UPROBES	20	/* MMF_HAS_UPROBES can be wrong */
>>   #define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
>>   #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
>> -#define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
>> -#define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
>> -#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>> +#define MMF_DISABLE_THP_EXCEPT_ADVISED	23	/* no THP except for VMAs with VM_HUGEPAGE */
>> +#define MMF_DISABLE_THP_COMPLETELY	24	/* no THP for all VMAs */
>> +#define MMF_DISABLE_THP_MASK	((1 << MMF_DISABLE_THP_COMPLETELY) |\
>> +				 (1 << MMF_DISABLE_THP_EXCEPT_ADVISED))
> 
> It feels a bit sigh to have to use up low-supply mm flags for this. But
> again, I should be attacking this shortage soon enough.
> 
> Are we not going ahead with Barry's series that was going to use one of
> these in the end?

Whoever gets acked first ;)

> 
>>   #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
>>   #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
>>   /*
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 43dec6eed559a..1949bb9270d48 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -177,7 +177,14 @@ struct prctl_mm_map {
>>
>>   #define PR_GET_TID_ADDRESS	40
>>
>> +/*
>> + * Flags for PR_SET_THP_DISABLE are only applicable when disabling. Bit 0
>> + * is reserved, so PR_GET_THP_DISABLE can return 1 when no other flags were
>> + * specified for PR_SET_THP_DISABLE.
>> + */
> 
> Probably worth specifying that you're just returning the flags here.

Yes.

Thanks!

-- 
Cheers,

David / dhildenb


