Return-Path: <linux-fsdevel+bounces-11530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B517D8546C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EEE1C224B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 10:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06415171BC;
	Wed, 14 Feb 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh6Gp1MM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7416436
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904873; cv=none; b=mLokRTDGxYFuLW/EiqfblOtNweMsfiBcGS+5fXg9C24PvC2MW9+NAw8ZQzNMhaHRx0f9dvHRGO8djR9dh5a0O1X+uGIFDoTSi5AoCQDLQpWu4KgUiw98hK91wPLUttTUDhKZChfRZ7gUA3955QrlcoxY9A0onJwjOxsoiSfIbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904873; c=relaxed/simple;
	bh=ISNhoVAHE5ea59GMSp6fB/xzP9AMMIXNtq+7KToWy/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LydPTEcUYbaXi8veYneVxKa7Awsm8lw8q0gZQ/dgqRe/UKWumFRGts4NP+p0mttSMoFXwDNJynH8CixQWA2P5ASSj4i1YE3kx1+QCcHQXS4OG+EwFU8hlLYWKSApoKHHpqWxeRbkZuLgO3sL2TYEPFIKpoqsTjnQ3VWSAGqIGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gh6Gp1MM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707904870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SYtqzgv+BxOcacLu4368aIKcl3CwnG8tHFk8B9VUFvU=;
	b=Gh6Gp1MMBKbx/xnXOKaKdkpT4d1GtLHT6BmnyzCs3O//x0QW9xs4uq0REnEzLpqYP4AUuh
	Gl+GjhMCJhVw8X6Rj417QAGMX5D7LSn3CIrz5YNjWExJ59WIbDm68oX5cO1BuIq/lPyAB9
	Zzt5Jiytu0suITVXX4kg5gW3U83CF44=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-giDbsRbENOeELBv6bbqDjg-1; Wed, 14 Feb 2024 05:01:08 -0500
X-MC-Unique: giDbsRbENOeELBv6bbqDjg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d0cb64437dso43981201fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 02:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707904867; x=1708509667;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYtqzgv+BxOcacLu4368aIKcl3CwnG8tHFk8B9VUFvU=;
        b=Iv4+9dtCGPacwJrNH2/0qLZPKh3XUXuDekdZpsAtf3rj9B8maspCq7Ztw4NcR+00rL
         tjZWNpO5T38gDP2sH0CLpo9clcB4wV6VezMKBb6VEAoD/lRnFnOlFLTs73hijKLF9w89
         XzEi16DmPckD0g6MRW783QnQBGmtePLIdTBtO7bK/7/HzdHbuz+qIdLJz2EDO4/U1RoV
         5VmeT3cFHi0YCTgk88dicSCRB+keM8H3rpI/tVBsDnmsaSz4fEi15OUA7Vk7o34BB2Jl
         kVm8NOwpeXJm7ghFR0K/IN44nlvX+hXZM/0n/IGj1M37HFHUdjMlA3wuCqMn0l/EYpoS
         G91Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv264Rv3ITHWHg8uvVBVmfN5ujrQsdgF28eTMdWWrZTY9WnpOUnCyU40elodb8z171vqv+qNtfYYTG6cjy5I597PFAizNHLoWbhnbnsw==
X-Gm-Message-State: AOJu0YwieMKeUaBxh5TZ1Iz35uxGmO5U/lRLmoXs9ljEwRKpRiKHiyb7
	174NoeF/FD98pj3mEME+mMfcaTyJTbhYDocYXBf04ItESqLavToUULWhorxqImmkIm7XEcyA4OK
	FT7l238YgjMdcM1euDlyyvlz790IT6wKlNxHnXztFse5dw5gqPia7QLakpZ89jY8=
X-Received: by 2002:a2e:bb85:0:b0:2d0:de72:9d47 with SMTP id y5-20020a2ebb85000000b002d0de729d47mr1387376lje.8.1707904866655;
        Wed, 14 Feb 2024 02:01:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeBVBeETe/HNpRyfxbiQ4zG7pHiUv6kqZUWoyq8jvv2EQfYHAzza7a6OSmZLJjmPb8OFOyjg==
X-Received: by 2002:a2e:bb85:0:b0:2d0:de72:9d47 with SMTP id y5-20020a2ebb85000000b002d0de729d47mr1387286lje.8.1707904866113;
        Wed, 14 Feb 2024 02:01:06 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id z21-20020a05600c221500b004101f27737asm1416372wml.29.2024.02.14.02.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 02:01:05 -0800 (PST)
Message-ID: <d7d132ca-8d0d-497e-bf8d-3c275960aaf9@redhat.com>
Date: Wed, 14 Feb 2024 11:01:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 corbet@lwn.net, void@manifault.com, peterz@infradead.org,
 juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
 arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
 paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com,
 yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
 andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com,
 vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
 ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <a9b0440b-844e-4e45-a546-315d53322aad@redhat.com>
 <xbehqbtjp5wi4z2ppzrbmlj6vfazd2w5flz3tgjbo37tlisexa@caq633gciggt>
 <c842347d-5794-4925-9b95-e9966795b7e1@redhat.com>
 <CAJuCfpFB-WimQoC1s-ZoiAx+t31KRu1Hd9HgH3JTMssnskdvNw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpFB-WimQoC1s-ZoiAx+t31KRu1Hd9HgH3JTMssnskdvNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.02.24 00:28, Suren Baghdasaryan wrote:
> On Tue, Feb 13, 2024 at 3:22 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 14.02.24 00:12, Kent Overstreet wrote:
>>> On Wed, Feb 14, 2024 at 12:02:30AM +0100, David Hildenbrand wrote:
>>>> On 13.02.24 23:59, Suren Baghdasaryan wrote:
>>>>> On Tue, Feb 13, 2024 at 2:50 PM Kent Overstreet
>>>>> <kent.overstreet@linux.dev> wrote:
>>>>>>
>>>>>> On Tue, Feb 13, 2024 at 11:48:41PM +0100, David Hildenbrand wrote:
>>>>>>> On 13.02.24 23:30, Suren Baghdasaryan wrote:
>>>>>>>> On Tue, Feb 13, 2024 at 2:17 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On 13.02.24 23:09, Kent Overstreet wrote:
>>>>>>>>>> On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
>>>>>>>>>>> On 13.02.24 22:58, Suren Baghdasaryan wrote:
>>>>>>>>>>>> On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
>>>>>>>>>>>>> [...]
>>>>>>>>>>>>>> We're aiming to get this in the next merge window, for 6.9. The feedback
>>>>>>>>>>>>>> we've gotten has been that even out of tree this patchset has already
>>>>>>>>>>>>>> been useful, and there's a significant amount of other work gated on the
>>>>>>>>>>>>>> code tagging functionality included in this patchset [2].
>>>>>>>>>>>>>
>>>>>>>>>>>>> I suspect it will not come as a surprise that I really dislike the
>>>>>>>>>>>>> implementation proposed here. I will not repeat my arguments, I have
>>>>>>>>>>>>> done so on several occasions already.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Anyway, I didn't go as far as to nak it even though I _strongly_ believe
>>>>>>>>>>>>> this debugging feature will add a maintenance overhead for a very long
>>>>>>>>>>>>> time. I can live with all the downsides of the proposed implementation
>>>>>>>>>>>>> _as long as_ there is a wider agreement from the MM community as this is
>>>>>>>>>>>>> where the maintenance cost will be payed. So far I have not seen (m)any
>>>>>>>>>>>>> acks by MM developers so aiming into the next merge window is more than
>>>>>>>>>>>>> little rushed.
>>>>>>>>>>>>
>>>>>>>>>>>> We tried other previously proposed approaches and all have their
>>>>>>>>>>>> downsides without making maintenance much easier. Your position is
>>>>>>>>>>>> understandable and I think it's fair. Let's see if others see more
>>>>>>>>>>>> benefit than cost here.
>>>>>>>>>>>
>>>>>>>>>>> Would it make sense to discuss that at LSF/MM once again, especially
>>>>>>>>>>> covering why proposed alternatives did not work out? LSF/MM is not "too far"
>>>>>>>>>>> away (May).
>>>>>>>>>>>
>>>>>>>>>>> I recall that the last LSF/MM session on this topic was a bit unfortunate
>>>>>>>>>>> (IMHO not as productive as it could have been). Maybe we can finally reach a
>>>>>>>>>>> consensus on this.
>>>>>>>>>>
>>>>>>>>>> I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
>>>>>>>>>> need to see a serious proposl - what we had at the last LSF was people
>>>>>>>>>> jumping in with half baked alternative proposals that very much hadn't
>>>>>>>>>> been thought through, and I see no need to repeat that.
>>>>>>>>>>
>>>>>>>>>> Like I mentioned, there's other work gated on this patchset; if people
>>>>>>>>>> want to hold this up for more discussion they better be putting forth
>>>>>>>>>> something to discuss.
>>>>>>>>>
>>>>>>>>> I'm thinking of ways on how to achieve Michal's request: "as long as
>>>>>>>>> there is a wider agreement from the MM community". If we can achieve
>>>>>>>>> that without LSF, great! (a bi-weekly MM meeting might also be an option)
>>>>>>>>
>>>>>>>> There will be a maintenance burden even with the cleanest proposed
>>>>>>>> approach.
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>>> We worked hard to make the patchset as clean as possible and
>>>>>>>> if benefits still don't outweigh the maintenance cost then we should
>>>>>>>> probably stop trying.
>>>>>>>
>>>>>>> Indeed.
>>>>>>>
>>>>>>>> At LSF/MM I would rather discuss functonal
>>>>>>>> issues/requirements/improvements than alternative approaches to
>>>>>>>> instrument allocators.
>>>>>>>> I'm happy to arrange a separate meeting with MM folks if that would
>>>>>>>> help to progress on the cost/benefit decision.
>>>>>>> Note that I am only proposing ways forward.
>>>>>>>
>>>>>>> If you think you can easily achieve what Michal requested without all that,
>>>>>>> good.
>>>>>>
>>>>>> He requested something?
>>>>>
>>>>> Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
>>>>> possible until the compiler feature is developed and deployed. And it
>>>>> still would require changes to the headers, so don't think it's worth
>>>>> delaying the feature for years.
>>>>>
>>>>
>>>> I was talking about this: "I can live with all the downsides of the proposed
>>>> implementationas long as there is a wider agreement from the MM community as
>>>> this is where the maintenance cost will be payed. So far I have not seen
>>>> (m)any acks by MM developers".
>>>>
>>>> I certainly cannot be motivated at this point to review and ack this,
>>>> unfortunately too much negative energy around here.
>>>
>>> David, this kind of reaction is exactly why I was telling Andrew I was
>>> going to submit this as a direct pull request to Linus.
>>>
>>> This is an important feature; if we can't stay focused ot the technical
>>> and get it done that's what I'll do.
>>
>> Kent, I started this with "Would it make sense" in an attempt to help
>> Suren and you to finally make progress with this, one way or the other.
>> I know that there were ways in the past to get the MM community to agree
>> on such things.
>>
>> I tried to be helpful, finding ways *not having to* bypass the MM
>> community to get MM stuff merged.
>>
>> The reply I got is mostly negative energy.
>>
>> So you don't need my help here, understood.
>>
>> But I will fight against any attempts to bypass the MM community.
> 
> Well, I'm definitely not trying to bypass the MM community, that's why
> this patchset is posted. Not sure why people can't voice their opinion
> on the benefit/cost balance of the patchset over the email... But if a
> meeting would be more productive I'm happy to set it up.

If you can get the acks without any additional meetings, great. The 
replies from Pasha and Johannes are encouraging, let's hope core 
memory-allocator people will voice their opinion here.

If you come to the conclusion that another meeting would help getting 
maintainers's attention and sorting out some of the remaining concerns, 
feel free to schedule a meeting with Dave R. I suspect only the slot 
next week is already taken. In the past, we also had "special" meetings 
just for things to make progress faster.

If you're looking for ideas on what the agenda of such a meeting could 
look like, I'll happily discuss that with you off-list.

v2 was more than 3 months ago. If it's really about minor details here, 
waiting another 3 months for LSF/MM is indeed not reasonable.

Myself, I'll be happy not having to sit through another LSF/MM session 
of that kind. The level of drama is exceptional and I'm hoping it won't 
be the new norm in the MM space.

Good luck!

-- 
Cheers,

David / dhildenb


