Return-Path: <linux-fsdevel+bounces-59290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D81B36F30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 18:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D80A000EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868FA3164CB;
	Tue, 26 Aug 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5Dlq2GW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E63164A6
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223626; cv=none; b=XXL3rgADJDlZThORZfR8IL8HYNZ9XWypTErOP83Mi4WdZNYtPgGNa3zU7sIOBORxQ/br41moyFfex5EUrT80VFUNcmma76F6Btwr4sx6Eq7kNvdbwV9wwVZeHYH2aRygHsRPVYZpd+kPUckrtVMP4R74NbWjM0sHLmkkWgFJ4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223626; c=relaxed/simple;
	bh=P69Cksxfe/Q80STdfcKyieBFfFGdz3o3/vzI06BYov8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgVUOI6+xnZ1qiTSGCYh1yiwUModqWE3tnvcc2CK7dKqmFc6eB+rKVH3ZJj8MqjdnRr55QHW9ysFLLSFdWhsbnfLeFZnzGF1iFrJVZS7We7DJ5CpBRJQCD2TGSLEmaoV7wrp/2PNd6STvcqoDkw5x19of3Wq4iWCSnLDJktebu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5Dlq2GW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756223623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+U14wXv0VhbfGH2miM5ngrvAv4bmmIvsTMUNtMccNUc=;
	b=A5Dlq2GW+ORpVuFEmP1VF3Zeib4UDYuxfS/4IjSp4NZEVVcyvUa4sEWkUNv62dHaFXO5pQ
	1S+LkxXkV2Xtgq+Wy1t2wxNx/tl0BFLalH480JCWQSqmXudC8iPK4UDn5KT2LoZDyR7Qig
	z3xEHK0Sh56NxBgnlkm7sd13qcegodU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Ku4oTATqOHKWkdGkAV0hRg-1; Tue, 26 Aug 2025 11:53:41 -0400
X-MC-Unique: Ku4oTATqOHKWkdGkAV0hRg-1
X-Mimecast-MFC-AGG-ID: Ku4oTATqOHKWkdGkAV0hRg_1756223621
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b645707f1so8481525e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756223620; x=1756828420;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+U14wXv0VhbfGH2miM5ngrvAv4bmmIvsTMUNtMccNUc=;
        b=SM9r3mUDyeSQTjHSCOjh8dq4ktgbcOfT6Zh0F5QFY5YTWBDrLzNcNQc8l9naOHzyhP
         klFpX3ygd+NHDjLMBfbSESXba4JNrO8CDqYOxhuxu4F9/NqLsSd8Vj/BdfOiTQGKJ0h9
         dA8pwDeI2+i9u8cNNlySP6qCx/5KZxbhmaysjTGkPmGNgX5UaobTDQsC2abZjMi4x/Bu
         eTKWpNsgP48rU/Ufd8ButYwG9zBmAlxNSJab6ExBUmqjptlpwitnJXohQMiuxbBgo5nQ
         O8shGYkRYS94GWzbFJU5h/ndhPV77UYxgMA4b9lU755xwSrtFtGNkIVIsuiBRCvroGkK
         hUPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdfQ0KAgGnodBZlfViTEhFcclmsCOGBsqqx6fZRsAX9SFpCqjZTHPPeCYVajfQLC/dVnFuLoHW63Mvx2sZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyzaHS4jl28SB6CXPNAFtK6R5UnXGcOCHvFC28FWhorjnZ6wXC6
	PjuEmlyf0Z208Zb3FbvAPfNh+45QUFu2Sxd7R++I33t7Enqq+O1xQ+BwL/u+sF6gm0mi5p2PIIX
	BgItOFlGqmcxICld0PqIOaSgkSXEQE5/OfL8VGG2qEaUfgJvORXFLLQ5rTn+h+YE3KAk=
X-Gm-Gg: ASbGncsbU+oPwgyugjAJfjbWRa5Z5iXVpS9CvGFc9L9co53NsVG6NM1DzkOuMIcCpcf
	REaz83IZCeBz8dda4mMkiF1JZko4tb3ZGDWlmt7NNL2bbQhWEEzc2Tcl57nBVfBvRTV+5UUGSOq
	WDY7XAsFIC3b0jkdRcogLc+7dlB2XWy2K2bf98bPYCcvneBe3MZR/efECBWlAtLyVbW3Zlov54n
	jemCDZGEbYoeKOhZIDVVQSgCXb1IzYhJ3Td6C0Zf8pVXcuPVhauX05yxrqC17ivcKNdU/qj3UFv
	hMu+A2aFOKE4UbTTWy6BpK6H5V//k3HqEIBNGqfjqPn1xKUBlH7O0Dq5wgItZMkHEeBy88QW
X-Received: by 2002:a05:600c:4ed0:b0:459:dfde:3323 with SMTP id 5b1f17b1804b1-45b517cfb81mr136206555e9.27.1756223620439;
        Tue, 26 Aug 2025 08:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSFZHuF3ZmBgbb1DmR6AWyXPp01fHC/E5LsiIPukWcFbvko5eip1UQdcjgn0D15hklxp1KaQ==
X-Received: by 2002:a05:600c:4ed0:b0:459:dfde:3323 with SMTP id 5b1f17b1804b1-45b517cfb81mr136205695e9.27.1756223619755;
        Tue, 26 Aug 2025 08:53:39 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211cc8sm16703127f8f.36.2025.08.26.08.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:53:39 -0700 (PDT)
Message-ID: <49df1a2a-7c5b-4ada-98b8-8d7871fd7228@redhat.com>
Date: Tue, 26 Aug 2025 17:53:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] mm: update fork mm->flags initialisation to use
 bitmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
 <73a39f45-e10c-42f8-819b-7289733eae03@redhat.com>
 <d4f8346d-42eb-48db-962d-6bc0fc348510@lucifer.local>
 <d39e029a-8c12-42fb-8046-8e4a568134dc@redhat.com>
 <1743164d-c2d2-44a1-a2a9-aeeed8c13bc8@lucifer.local>
 <e91f7a38-3b17-4a0c-aedb-8b404d40cf59@redhat.com>
 <9e7f5149-afb7-4e94-b231-78876c41a438@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9e7f5149-afb7-4e94-b231-78876c41a438@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 17:39, Lorenzo Stoakes wrote:
> On Tue, Aug 26, 2025 at 05:24:22PM +0200, David Hildenbrand wrote:
>> On 26.08.25 16:32, Lorenzo Stoakes wrote:
>>> On Tue, Aug 26, 2025 at 04:28:20PM +0200, David Hildenbrand wrote:
>>>> On 26.08.25 16:21, Lorenzo Stoakes wrote:
>>>>> On Tue, Aug 26, 2025 at 03:12:08PM +0200, David Hildenbrand wrote:
>>>>>> On 12.08.25 17:44, Lorenzo Stoakes wrote:
>>>>>>> We now need to account for flag initialisation on fork. We retain the
>>>>>>> existing logic as much as we can, but dub the existing flag mask legacy.
>>>>>>>
>>>>>>> These flags are therefore required to fit in the first 32-bits of the flags
>>>>>>> field.
>>>>>>>
>>>>>>> However, further flag propagation upon fork can be implemented in mm_init()
>>>>>>> on a per-flag basis.
>>>>>>>
>>>>>>> We ensure we clear the entire bitmap prior to setting it, and use
>>>>>>> __mm_flags_get_word() and __mm_flags_set_word() to manipulate these legacy
>>>>>>> fields efficiently.
>>>>>>>
>>>>>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>>>> ---
>>>>>>>      include/linux/mm_types.h | 13 ++++++++++---
>>>>>>>      kernel/fork.c            |  7 +++++--
>>>>>>>      2 files changed, 15 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>>>>>> index 38b3fa927997..25577ab39094 100644
>>>>>>> --- a/include/linux/mm_types.h
>>>>>>> +++ b/include/linux/mm_types.h
>>>>>>> @@ -1820,16 +1820,23 @@ enum {
>>>>>>>      #define MMF_TOPDOWN		31	/* mm searches top down by default */
>>>>>>>      #define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
>>>>>>> -#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>>>>>>> +#define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>>>>>>>      				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>>>>>>>      				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
>>>>>>> -static inline unsigned long mmf_init_flags(unsigned long flags)
>>>>>>> +/* Legacy flags must fit within 32 bits. */
>>>>>>> +static_assert((u64)MMF_INIT_LEGACY_MASK <= (u64)UINT_MAX);
>>>>>>
>>>>>> Why not use the magic number 32 you are mentioning in the comment? :)
>>>>>
>>>>> Meh I mean UINT_MAX works as a good 'any bit' mask and this will work on
>>>>> both 32-bit and 64-bit systems.
>>>>>
>>>>>>
>>>>>> static_assert((u32)MMF_INIT_LEGACY_MASK != MMF_INIT_LEGACY_MASK);
>>>>>
>>>>> On 32-bit that'd not work would it?
>>>>
>>>> On 32bit, BIT(32) would exceed the shift width of unsigned long -> undefined
>>>> behavior.
>>>>
>>>> The compiler should naturally complain.
>>>
>>> Yeah, I don't love that sorry. Firstly it's a warning, so you may well miss it
>>> (I just tried),
>>
>> Upstream bots usually complain at you for warnings :P
> 
> Fine, but it's not a static assert and they can be delayed.
> 
>>
>>> and secondly you're making the static assert not have any
>>> meaning except that you expect to trigger a compiler warning, it's a bit
>>> bizarre.
>>
>> On 64 bit where BIT(32) *makes any sense* it triggers as expected, no?
> 
> It's not a static assert.
> 
>>
>>>
>>> My solution works (unless you can see a reason it shouldn't) and I don't find
>>> this approach any simpler.
>>
>> Please explain to me like I am a 5 yo how your approach works with BIT(32)
>> on 32bit when the behavior on 32bit is undefined. :P
> 
> OK right I see, in both cases BIT(32) is going to cause a warning on 32-bit.
> 
> I was wrong in thinking (u64)(1UL << 32) would get fixed up because of the
> outer cast I guess.
> 
> This was the mistake here, so fine, we could do it this way.
> 
> I guess I'll have to respin the series at this point.

Let me think again: assuming someone would mess up the BIT() thing and 
convert back to 1 << NR, your variant would catch it on 32bit I guess.

So given I was primarily confused by the "u64" when talking about 32it, 
no need for a full resend of this series just to clean this up.

-- 
Cheers

David / dhildenb


