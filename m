Return-Path: <linux-fsdevel+bounces-17947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D66E8B4142
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 23:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20BC8B20C7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 21:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7FE37163;
	Fri, 26 Apr 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUGKUOVT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB6374D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167196; cv=none; b=hPAllq1SG2iskLYGdKGUQ7OLwUd6NB7uctpIuu1wBjBxBxpBAUPMxLh+R0lMiz/C6wF7RIzFfivJuUnN6Ej75ATKCGwFEgJpREuMGTDN+2BYT4Zk0/2u/MKUlYX4UaDDnalRk3j9LxMMFcxllDV4YpiLmgm8k7V2Ik86eT1k3p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167196; c=relaxed/simple;
	bh=kxnGaLzCx36ImG3jzFPNGZvnlVs5FtG14IIFMoRjSAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njRTSiTi9Sdp164MKalqU5LmHYm2TM7pzGa8U2W/TScPpvPw9QHzPPAInh4x5yHoMo5mcVESKFIUEt7cVUdL8OaYVUV5IwkhiGHifdVeKGUgp76LQnrSWk0OEzGiToVYHipPdHYivOQgdJQQEwlKdwFIBjjH1fNxeCP69BhDCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUGKUOVT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714167194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HTxgqruqHfJleI+BsiKGjG0w4odgnXdiSmb5CNOjsgc=;
	b=QUGKUOVT4BnqsqyZEcmrK9HvDUeUpy8/4BZ0r24rf+fZPiBU9SqccfCCAdsx3hVUDIq7c3
	zo29VQDEYiOizBj1j5CYQbBczMqWRkh8UFEQoV1P0OJiiOaYBBL04PrDiAXYy2qdXoV/qq
	QD8X71SGRRJKQx2Sbw3sMykKTHYUy1w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-Hk9cHOx3P5-LG0KYWt4THw-1; Fri, 26 Apr 2024 17:33:12 -0400
X-MC-Unique: Hk9cHOx3P5-LG0KYWt4THw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3477835b2f7so1250113f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 14:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714167191; x=1714771991;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HTxgqruqHfJleI+BsiKGjG0w4odgnXdiSmb5CNOjsgc=;
        b=nVE1I81E0DR4cHH/ISyY3hUvYWLzUT6jSqljZR0XtyCxQdtThGCRQEcmDCzlI9yDJd
         S6aCFOWJq25OCH2zMvFre259h/BAaWnHxuTpBatPvaVPvLO60bfm+qsFjLIRrQrCBgc9
         PIhtaZobdCKbIct55SqUg2D5a37PW8Nl9wUrSBo0ivg2NwoOits+5483l4dIncne4bkj
         YhHuFuVc4+oKiMuqMO9iSvE/KytGa1ni4NJu5bM4b54fW5YwuLnMHErLbicHHaft7E/I
         ExLF8MmelKmLHuQb0G5IiFcUQmUr7PctcMvjk3FHkyTnOlnEacmNF5vP3J4b2lHb5tNJ
         M90A==
X-Forwarded-Encrypted: i=1; AJvYcCWdBUWFIa+lWI9BdlvyfulRhnRft4R2NZ6orMFehnXfeu7MtEPlgDqqhAujKL+uX8KyZgWE2S0bGT33SSJSg3nV8RO7hOP4iObV/fuZzQ==
X-Gm-Message-State: AOJu0YwCHYT6rBZxnxRscmEEJjmTZk0uLliszj03sHaMwS8+2edZCG1d
	rgSUn5BfvTYeJh1mO3Nw1LBXjgQ0nLaPwaOBSBFswv+5AaNe1KwCr3s/ZPvqgQv8pKp6yXEZw2k
	SDbTOvQlUCuFOdUow/qB/N/W1Vb9DwPdnE8P02EgcX6m4dYNmsHvvUuiwaLrvH5Y=
X-Received: by 2002:adf:e70b:0:b0:34c:5f6e:1720 with SMTP id c11-20020adfe70b000000b0034c5f6e1720mr554763wrm.60.1714167191483;
        Fri, 26 Apr 2024 14:33:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM1bRgkh0yb/MsAsyuNGZmpW4/Rz7FCY0YwSzgR+rZNpVvpkuS+p8nE7OJ5gTd+vbJaBdFtw==
X-Received: by 2002:adf:e70b:0:b0:34c:5f6e:1720 with SMTP id c11-20020adfe70b000000b0034c5f6e1720mr554751wrm.60.1714167190989;
        Fri, 26 Apr 2024 14:33:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6100:20f2:6848:5b74:ca82? (p200300cbc726610020f268485b74ca82.dip0.t-ipconnect.de. [2003:cb:c726:6100:20f2:6848:5b74:ca82])
        by smtp.gmail.com with ESMTPSA id e15-20020a05600c218f00b004146e58cc35sm35152816wme.46.2024.04.26.14.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 14:33:10 -0700 (PDT)
Message-ID: <fb3bd167-748a-4548-a94f-9194443c0bc3@redhat.com>
Date: Fri, 26 Apr 2024 23:33:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mm/gup: consistently name GUP-fast functions
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-riscv@lists.infradead.org, x86@kernel.org
References: <20240402125516.223131-1-david@redhat.com>
 <20240402125516.223131-2-david@redhat.com>
 <e685c532-8330-4a57-bc08-c67845e0c352@redhat.com> <Ziuv2jLY1wgBITiP@x1n>
 <ZivScN8-Uoi9eye8@x1n> <8b42a24d-caf0-46ef-9e15-0f88d47d2f21@redhat.com>
 <Ziwal-SucIye3hPM@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Ziwal-SucIye3hPM@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>>> Hmm, so when I enable 2M hugetlb I found ./cow is even failing on x86.
>>>
>>>     # ./cow  | grep -B1 "not ok"
>>>     # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
>>>     not ok 161 No leak from parent into child
>>>     --
>>>     # [RUN] vmsplice() + unmap in child with mprotect() optimization ... with hugetlb (2048 kB)
>>>     not ok 215 No leak from parent into child
>>>     --
>>>     # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb (2048 kB)
>>>     not ok 269 No leak from child into parent
>>>     --
>>>     # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 kB)
>>>     not ok 323 No leak from child into parent
>>>
>>> And it looks like it was always failing.. perhaps since the start?  We
>>
>> Yes!
>>
>> commit 7dad331be7816103eba8c12caeb88fbd3599c0b9
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Tue Sep 27 13:01:17 2022 +0200
>>
>>      selftests/vm: anon_cow: hugetlb tests
>>      Let's run all existing test cases with all hugetlb sizes we're able to
>>      detect.
>>      Note that some tests cases still fail. This will, for example, be fixed
>>      once vmsplice properly uses FOLL_PIN instead of FOLL_GET for pinning.
>>      With 2 MiB and 1 GiB hugetlb on x86_64, the expected failures are:
>>       # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
>>       not ok 23 No leak from parent into child
>>       # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
>>       not ok 24 No leak from parent into child
>>       # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb (2048 kB)
>>       not ok 35 No leak from child into parent
>>       # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb (1048576 kB)
>>       not ok 36 No leak from child into parent
>>       # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 kB)
>>       not ok 47 No leak from child into parent
>>       # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (1048576 kB)
>>       not ok 48 No leak from child into parent
>>
>> As it keeps confusing people (until somebody cares enough to fix vmsplice), I already
>> thought about just disabling the test and adding a comment why it happens and
>> why nobody cares.
> 
> I think we should, and when doing so maybe add a rich comment in
> hugetlb_wp() too explaining everything?

Likely yes. Let me think of something.

> 
>>
>>> didn't do the same on hugetlb v.s. normal anon from that regard on the
>>> vmsplice() fix.
>>>
>>> I drafted a patch to allow refcount>1 detection as the same, then all tests
>>> pass for me, as below.
>>>
>>> David, I'd like to double check with you before I post anything: is that
>>> your intention to do so when working on the R/O pinning or not?
>>
>> Here certainly the "if it's easy it would already have done" principle applies. :)
>>
>> The issue is the following: hugetlb pages are scarce resources that cannot usually
>> be overcommitted. For ordinary memory, we don't care if we COW in some corner case
>> because there is an unexpected reference. You temporarily consume an additional page
>> that gets freed as soon as the unexpected reference is dropped.
>>
>> For hugetlb, it is problematic. Assume you have reserved a single 1 GiB hugetlb page
>> and your process uses that in a MAP_PRIVATE mapping. Then it calls fork() and the
>> child quits immediately.
>>
>> If you decide to COW, you would need a second hugetlb page, which we don't have, so
>> you have to crash the program.
>>
>> And in hugetlb it's extremely easy to not get folio_ref_count() == 1:
>>
>> hugetlb_fault() will do a folio_get(folio) before calling hugetlb_wp()!
>>
>> ... so you essentially always copy.
> 
> Hmm yes there's one extra refcount. I think this is all fine, we can simply
> take all of them into account when making a CoW decision.  However crashing
> an userspace can be a problem for sure.

Right, and a simple reference from page migration or some other PFN 
walker would be sufficient for that.

I did not dare being responsible for that, even though races are rare :)

The vmsplice leak is not worth that: hugetlb with MAP_PRIVATE to 
COW-share data between processes with different privilege levels is not 
really common.

> 
>>
>>
>> At that point I walked away from that, letting vmsplice() be fixed at some point. Dave
>> Howells was close at some point IIRC ...
>>
>> I had some ideas about retrying until the other reference is gone (which cannot be a
>> longterm GUP pin), but as vmsplice essentially does without FOLL_PIN|FOLL_LONGTERM,
>> it's quit hopeless to resolve that as long as vmsplice holds longterm references the wrong
>> way.
>>
>> ---
>>
>> One could argue that fork() with hugetlb and MAP_PRIVATE is stupid and fragile: assume
>> your child MM is torn down deferred, and will unmap the hugetlb page deferred. Or assume
>> you access the page concurrently with fork(). You'd have to COW and crash the program.
>> BUT, there is a horribly ugly hack in hugetlb COW code where you *steal* the page form
>> the child program and crash your child. I'm not making that up, it's horrible.
> 
> I didn't notice that code before; doesn't sound like a very responsible
> parent..
> 
> Looks like either there come a hugetlb guru who can make a decision to
> break hugetlb ABI at some point, knowing that nobody will really get
> affected by it, or that's the uncharted area whoever needs to introduce
> hugetlb v2.

I raised this topic in the past, and IMHO we either (a) never should 
have added COW support; or (b) added COW support by using ordinary 
anonymous memory (hey, partial mappings of hugetlb pages! ;) ).

After all, COW is an optimization to speed up fork and defer copying. It 
relies on memory overcommit, but that doesn't really apply to hugetlb, 
so we fake it ...

One easy ABI break I had in mind was to simply *not* allow COW-sharing 
of anon hugetlb folios; for example, simply don't copy the page into the 
child. Chances are there are not really a lot of child processes that 
would fail ... but likely we would break *something*. So there is no 
easy way out :(


-- 
Cheers,

David / dhildenb


