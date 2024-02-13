Return-Path: <linux-fsdevel+bounces-11490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03E853F45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658041F2A265
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CCF627EF;
	Tue, 13 Feb 2024 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOKGqARn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B37627FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865065; cv=none; b=XpbSCT/txfQ+L/eSZiT5orTa3GbOh5pDbGlu2ZMi9iHNbvTsWOAJg/rwdFreE3p2eMN1CGJzTzCYatSNoXhwOwYgsT2IyFJsYC0bV3RSZViEBLRSkfqx6bcddDNAAxncb4kxXkBNz0mi3ZaHL/CSGdrAsnoVy/WQgcVmYV3DpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865065; c=relaxed/simple;
	bh=fvKCkcTy77W8ri6hSmJP1vOfZP3eYJv01gTg93oPRtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxfHFpbeiXgGxNLLxH5WkyWZQLdElkCAM2IxY+u5IEuNROBNqIE/3YUA1nbcfHr2AUfXq+UNzFfT9HnEN/wsNfQaViwYyv8HAr1byZrjmsq35kwOyT98e/NTqQTDZUSzXJTWQHkFUKtdABa6QlwVdviGPFQ6JNDw+tqQsKi3l7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOKGqARn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707865063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=46CJF8ki9aog8H1XgwfThvnTA8WcsAcCcWmi4TUP1b0=;
	b=FOKGqARn7SHX8X6S0vB0L2prO3+9Z6UKL7jlii4XF5EJG0YO8pHGpfU5IKvIoPCWCTShCQ
	mHh89uSTQb6eeqlR4bYq2KN2nCDSk2v6oZkZGBZo8dLW0zk62UijSaAzsjhB5tgLZcPh87
	/XWyj6FqsKUQx1ScmqI0bQSVwga0oAc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-4hC-2t-iNF-n9Jp4mLLqvQ-1; Tue, 13 Feb 2024 17:57:41 -0500
X-MC-Unique: 4hC-2t-iNF-n9Jp4mLLqvQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78346521232so660702685a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 14:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865061; x=1708469861;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46CJF8ki9aog8H1XgwfThvnTA8WcsAcCcWmi4TUP1b0=;
        b=gUrLamkl7HmQXsvPM2aXdN6wWxKshVpVs1yWDCivp5wmRjNIvUbvZKVJdAq24o9k/c
         a0rV2A0jibpFpBrU6AN0Nx0RBMDi4P3iuWgl37HjhfUZ2e6Ey1eafR5a8B6euD3f2UKe
         XDa9z3JNo+s0c6YBslDIrYXhrRFIoAnggCqTEh8+Oso/+7Ug77Wer8QxuWFR6RD15Z82
         ZgSjHI2q+0Mj9wzO3sIeaB4CabTx0nVvxGZ9TRx8quF8n3N9XppBgBcMrzAR6TvqUqq0
         3on3Yq3VgsxUju6oor2vStL1JQV1zQEx0bfMG1Ip5WpGV87//Wk/wk/8d45CTDUZHaJO
         d0bg==
X-Forwarded-Encrypted: i=1; AJvYcCVei8A5gO3vhXmfKLd+uxFwLteNEnlC44oOZfBbnowhpT/wNAsMZuc4q/xYaIrumw3g18NvpuX7ZP7ruagjam97VF/qNrC3Mm2P9vX9VA==
X-Gm-Message-State: AOJu0YyXJB+OY34lsFtRWOGuDAdb+QRqT1dnfsndFYLfjU/x+0v83aNf
	iEoVI07F0kvqAyk7oHJYKBla0rsOsHdp/Ioic7QRvQyPkX6+Lbst49X+KSRgUqp4jAi5kaRMnMj
	iWisL5YUigqzL9a1tBRPn1/d8fwNjW9ku1/JBYaaLoCMqAkmUZtpj5GrBzThWCXA=
X-Received: by 2002:a05:620a:15aa:b0:785:c4ee:7903 with SMTP id f10-20020a05620a15aa00b00785c4ee7903mr1041419qkk.57.1707865061160;
        Tue, 13 Feb 2024 14:57:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAm9ESvyQ81pDEVMjic8YF5MayysXtXlH7r2+8SJ6Vh3lo+Ztgw5hs9lyvTOA9CQvc+LVjFg==
X-Received: by 2002:a05:620a:15aa:b0:785:c4ee:7903 with SMTP id f10-20020a05620a15aa00b00785c4ee7903mr1041388qkk.57.1707865060779;
        Tue, 13 Feb 2024 14:57:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; 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
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id h14-20020a05620a10ae00b007872ade6cf1sm5569qkk.71.2024.02.13.14.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 14:57:40 -0800 (PST)
Message-ID: <22faab25-9509-483f-b9e9-d810de1f639f@redhat.com>
Date: Tue, 13 Feb 2024 23:57:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 peterx@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.02.24 23:50, Kent Overstreet wrote:
> On Tue, Feb 13, 2024 at 11:48:41PM +0100, David Hildenbrand wrote:
>> On 13.02.24 23:30, Suren Baghdasaryan wrote:
>>> On Tue, Feb 13, 2024 at 2:17 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 13.02.24 23:09, Kent Overstreet wrote:
>>>>> On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
>>>>>> On 13.02.24 22:58, Suren Baghdasaryan wrote:
>>>>>>> On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
>>>>>>>>
>>>>>>>> On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
>>>>>>>> [...]
>>>>>>>>> We're aiming to get this in the next merge window, for 6.9. The feedback
>>>>>>>>> we've gotten has been that even out of tree this patchset has already
>>>>>>>>> been useful, and there's a significant amount of other work gated on the
>>>>>>>>> code tagging functionality included in this patchset [2].
>>>>>>>>
>>>>>>>> I suspect it will not come as a surprise that I really dislike the
>>>>>>>> implementation proposed here. I will not repeat my arguments, I have
>>>>>>>> done so on several occasions already.
>>>>>>>>
>>>>>>>> Anyway, I didn't go as far as to nak it even though I _strongly_ believe
>>>>>>>> this debugging feature will add a maintenance overhead for a very long
>>>>>>>> time. I can live with all the downsides of the proposed implementation
>>>>>>>> _as long as_ there is a wider agreement from the MM community as this is
>>>>>>>> where the maintenance cost will be payed. So far I have not seen (m)any
>>>>>>>> acks by MM developers so aiming into the next merge window is more than
>>>>>>>> little rushed.
>>>>>>>
>>>>>>> We tried other previously proposed approaches and all have their
>>>>>>> downsides without making maintenance much easier. Your position is
>>>>>>> understandable and I think it's fair. Let's see if others see more
>>>>>>> benefit than cost here.
>>>>>>
>>>>>> Would it make sense to discuss that at LSF/MM once again, especially
>>>>>> covering why proposed alternatives did not work out? LSF/MM is not "too far"
>>>>>> away (May).
>>>>>>
>>>>>> I recall that the last LSF/MM session on this topic was a bit unfortunate
>>>>>> (IMHO not as productive as it could have been). Maybe we can finally reach a
>>>>>> consensus on this.
>>>>>
>>>>> I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
>>>>> need to see a serious proposl - what we had at the last LSF was people
>>>>> jumping in with half baked alternative proposals that very much hadn't
>>>>> been thought through, and I see no need to repeat that.
>>>>>
>>>>> Like I mentioned, there's other work gated on this patchset; if people
>>>>> want to hold this up for more discussion they better be putting forth
>>>>> something to discuss.
>>>>
>>>> I'm thinking of ways on how to achieve Michal's request: "as long as
>>>> there is a wider agreement from the MM community". If we can achieve
>>>> that without LSF, great! (a bi-weekly MM meeting might also be an option)
>>>
>>> There will be a maintenance burden even with the cleanest proposed
>>> approach.
>>
>> Yes.
>>
>>> We worked hard to make the patchset as clean as possible and
>>> if benefits still don't outweigh the maintenance cost then we should
>>> probably stop trying.
>>
>> Indeed.
>>
>>> At LSF/MM I would rather discuss functonal
>>> issues/requirements/improvements than alternative approaches to
>>> instrument allocators.
>>> I'm happy to arrange a separate meeting with MM folks if that would
>>> help to progress on the cost/benefit decision.
>> Note that I am only proposing ways forward.
>>
>> If you think you can easily achieve what Michal requested without all that,
>> good.
> 
> He requested something?
> 

This won't get merged without acks from MM people.

-- 
Cheers,

David / dhildenb


