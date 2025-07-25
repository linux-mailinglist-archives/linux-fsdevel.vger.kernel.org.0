Return-Path: <linux-fsdevel+bounces-56033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC9BB11F2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 15:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73037B206D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EB12ED17A;
	Fri, 25 Jul 2025 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyW73iBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268842D46DA
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448912; cv=none; b=hF7mgIJ/d1AdUTwrxBBa9rHyCNBuJ5ez9VvUAmLMrUnf6ZvElgKAL7QbTjgchWXbU5IA/QtIgTWzmLxisFdZDi/X8kHw6UngomXH9FR1SZo848mR8TcBQbGlFd12V5D4YhpCOOLTlxvQNaDCDLE7t7LaW6kPU4xtc91kRhssgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448912; c=relaxed/simple;
	bh=HwzKmT7HoDJ6wlSR5IkxxMdfp+sPMHETQqVzV+OPnI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlQIhNB9Pm6oUuC9sm13qDo047o+1pr8nzBPjcPTc1/UM/3KzXPj504S7katcOHItJ9tpA/ACQ8UnmtSsXvXEY7ms4hiskfolx7Jl+u0PLhgWELZ4uFzkqKfRA4r4hIv6CHlk+sOA2UL/EUTk4Jit7ljqQtRU0uhiO2qXd6Q2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyW73iBy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753448910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vXVoKfgt+eDdtfLoo5jK4LHubyq9Q2bBiLasDQpfjKc=;
	b=QyW73iByaRY8BTHDv0LFGj1hZePs1sczSw+1wp5YAxmKlfi5fA3KADv43dCMBsyzGjEUHM
	4mDASvo4VTroQXF5HogNWRdsc48JqCR2Oj1s/NoU9WieYWFrUtZU7NJN2uPkCiKtRrqQH0
	kF+BA3IhczzbjozQ3cUeIWbOLTzCSRA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-58rcq0vOPSeHTgSxpw2hzA-1; Fri, 25 Jul 2025 09:08:28 -0400
X-MC-Unique: 58rcq0vOPSeHTgSxpw2hzA-1
X-Mimecast-MFC-AGG-ID: 58rcq0vOPSeHTgSxpw2hzA_1753448907
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so10138885e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 06:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753448907; x=1754053707;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vXVoKfgt+eDdtfLoo5jK4LHubyq9Q2bBiLasDQpfjKc=;
        b=GiWhhTpqFH+P72eZtsmFJaAs/pFk7mYgD7Xr5A8TmnxmcsE6HOnaWVYzjDsBesGNjr
         v8kym0WfKtn34RXwd1c5NhZtL9N6JBaskooOCkZeshOz/DKsFmtF+bxHpPHtnssvueR2
         UuSQEsheP3LSRIbxmqUFoBfN3QkpCfxLLKYtwegdcBoVfeJ9NJrrWlJOMCj3JS6q2Cuy
         /of4NNIC7q7mCtrcGg4NizUFwh3O0zx1QKscoEjmbs33uKPUOafMfVkNUG4V5/ZbmcWG
         pdf6uhryhqctCJwcdA38x5unKPgQYiTlA77mSVhGTL/5bwfaPGZarXSm+D0D/ka3antW
         rg0w==
X-Forwarded-Encrypted: i=1; AJvYcCX3Y5NnZXowg86BtLo63JsF0eaRp219YJ3C9+mfZJ1eFMGku44yiMSxLnTx1vKjjuZz/oaeseB1jXIFxmYK@vger.kernel.org
X-Gm-Message-State: AOJu0YwbozyFuuVh1GipiTF4FeB2V53v8iLjPJojpoKdD8uCv7VWr6u5
	vNcNKlNeByVBWtgjDzpAte2mD2USn1Nm1TPC5gR2rLsgcu5jmBYhBOzg88WQ56sMJwqvscA0V/u
	WoVB0vgcgdWExffUc97bRw4/O8GZP2OZFrLvmz7Ly8hgZIQGUNbTjSWGFrsFXWfZReWo=
X-Gm-Gg: ASbGncs0Z0tF5I5KnmYE8AgPswtS69an5JyJjjzrkSEh1rtI/W3yE/Ui0BhSm2kNPJj
	LWwFrfeNf4xDyB5SeJ1kl91yXdziiZcujRVz8co1rYf+KOzbN5NYJDpUPu4L4vZyTODl1v15Vz4
	DssMJzIzJIfFuq8dqnVp0FZ1tbcHQE2QeK322sLJ/NNawwHIb8BB4XUtxHcQ6n2LbpU7Vuq2yTF
	bhU6Q0ztYRrfVq+YndavIuD1oNntB/UJoJGUzFs7a4bL/k+AxPYPwdXLemc8Mi++qDpIISxuLD0
	d6hKvTLWdF6YoSa8lvJYuxGj0Z5k5MmhhZxvMtBcZlupVtMnJjtg8WL4W9abIxWmvRAn33fgxly
	Q0E9qW4/KRJpuz/E1eaOFpf8c2L08Dy1ULU/TJWox1JDggcNH5xN5cV11tFybhJFQ
X-Received: by 2002:a05:600c:a08e:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-458787dc1fcmr10178315e9.19.1753448907052;
        Fri, 25 Jul 2025 06:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2RXrdRvbIxRYGYQLphu0lW6ksSFFRRKo/9yzkhDSnD9/0KgQ1xqI1uMWWpky4n4Gl2pL7ag==
X-Received: by 2002:a05:600c:a08e:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-458787dc1fcmr10177755e9.19.1753448906522;
        Fri, 25 Jul 2025 06:08:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:ae00:cf93:b0dc:6bed:abc? (p200300d82f34ae00cf93b0dc6bed0abc.dip0.t-ipconnect.de. [2003:d8:2f34:ae00:cf93:b0dc:6bed:abc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870532a4csm53826245e9.7.2025.07.25.06.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 06:08:25 -0700 (PDT)
Message-ID: <0905a63e-420e-484f-a98b-19e85fc851fa@redhat.com>
Date: Fri, 25 Jul 2025 15:08:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>,
 Jann Horn <jannh@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250721090942.274650-1-david@redhat.com>
 <3ec01250-0ff3-4d04-9009-7b85b6058e41@gmail.com>
 <601e015b-1f61-45e8-9db8-4e0d2bc1505e@redhat.com>
 <99e25828-641b-490b-baab-35df860760b4@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <99e25828-641b-490b-baab-35df860760b4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 00:27, Usama Arif wrote:
> 
>> Hi!
>>
>>>
>>> Over here, with MMF_DISABLE_THP_EXCEPT_ADVISED, MADV_HUGEPAGE will succeed as vm_flags has
>>> VM_HUGEPAGE set, but MADV_COLLAPSE will fail to give a hugepage (as VM_HUGEPAGE is not set
>>> and MMF_DISABLE_THP_EXCEPT_ADVISED is set) which I feel might not be the right behaviour
>>> as MADV_COLLAPSE is "advise" and the prctl flag is PR_THP_DISABLE_EXCEPT_ADVISED?
>>
>> THPs are disabled for these regions, so it's at least consistent with the "disable all", but ...
>>
>>>
>>> This will be checked in multiple places in madvise_collapse: thp_vma_allowable_order,
>>> hugepage_vma_revalidate which calls thp_vma_allowable_order and hpage_collapse_scan_pmd
>>> which also ends up calling hugepage_vma_revalidate.
>>>> A hacky way would be to save and overwrite vma->vm_flags with VM_HUGEPAGE at the start of madvise_collapse
>>> if VM_NOHUGEPAGE is not set, and reset vma->vm_flags to its original value at the end of madvise_collapse
>>> (Not something I am recommending, just throwing it out there).
>>
>> Gah.
>>
>>>
>>> Another possibility is to pass the fact that you are in madvise_collapse to these functions
>>> as an argument, this might look ugly, although maybe not as ugly as hugepage_vma_revalidate
>>> already has collapse control arg, so just need to take care of thp_vma_allowable_orders.
>>
>> Likely this.
>>
>>>
>>> Any preference or better suggestions?
>>
>> What you are asking for is not MMF_DISABLE_THP_EXCEPT_ADVISED as I planned it, but MMF_DISABLE_THP_EXCEPT_ADVISED_OR_MADV_COLLAPSE.
>>
>> Now, one could consider MADV_COLLAPSE an "advise". (I am not opposed to that change)
>>
> 
> lol yeah I always think of MADV_COLLAPSE as an extreme version of MADV_HUGE (more of a demand
> than an advice :)), eventhough its not persistant.
> Which is why I think might be unexpected if MADV_HUGE gives hugepages but MADV_COLLAPSE doesn't
> (But could just be my opinion).
> 
>> Indeed, the right way might be telling vma_thp_disabled() whether we are in collapse.
>>
>> Can you try implementing that on top of my patch to see how it looks?
>>
> 
> My reasoning is that a process that is running with system policy always but with
> PR_THP_DISABLE_EXCEPT_ADVISED gets THPs in exactly the same behaviour as a process that is running
> with system policy madvise. This will help us achieve (3) that you mentioned in the
> commit message:
> (3) Switch from THP=madvise to THP=always, but keep the old behavior
>       (THP only when advised) for selected workloads.
> 
> 
> I have written quite a few selftests now for prctl SET_THP_DISABLE, both with and without
> PR_THP_DISABLE_EXCEPT_ADVISED set incorporating your feedback on it. I have all of them passing
> with the below diff. The diff is slightly ugly, but very simple and hopefully acceptable. If it
> looks good, I can send a series with everything. Probably make the below diff as a separate patch
> on top of this patch as its mostly adding an extra arg to functions and would keep the review easier?

Yes, we should do it as a separate patch, makes our life easier, because 
that requires more work.

We require a cleanup first, the boolean parameter for 
__thp_vma_allowable_orders() is no good.

I just pushed something untested to my branch (slightly adjusted patch#1 
+ 2 more patches), can you have a look at that? (untested ... :) )

-- 
Cheers,

David / dhildenb


