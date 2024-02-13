Return-Path: <linux-fsdevel+bounces-11493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37F853FA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3069F1C262A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D7629FC;
	Tue, 13 Feb 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cs8yXryA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225361686
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865359; cv=none; b=lwWqEyzufO79UGokN2hsHG7gpBTdaUYE0R2/dUF/sRN4WhexzRJPOQbBXOc07w8xDmjNQ0pzerqvMR4DSf80xbvl3W4SigZ5M5Hkek35/+WSCfE6cr9cioqLAuw0+eFewmHacyiyBwPnIeUll6rMKYOmj5PNBvGaPnLdU6W+5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865359; c=relaxed/simple;
	bh=mvBx5c1Mz1PzeUdF/phvjBEqnMk0fyJZOg0mqmgOhf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGUyFGL4telJWSSDb6QQEjG/2qQzgmlR27ACbR+vpbodWUVX1BGB4i8goAVlfVXC02bmomXZ0nEZLDRccl8RcDWWYLKhqao6fZWwnxY1pDydusi1e+xkbi5bXP1I/WAvgYPnCQ69e3pzYkym90zmEqOKMheJ9aLPT12yfWnxACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cs8yXryA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707865356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xJhJ4xEMtOy5c1y6MqLIa8bGWYDGFy49+SYmZWzszOg=;
	b=cs8yXryA2CuoxSZgAHmSD2h0ulvo+h4G09mdovsd6d5dM8tnmbrYpqxSEOD7k+fCDMeXBs
	jfSvYxLpLScTSy6H4qo1ZlR55+sEofzmzGQoajXz9k4aalOjvwqeI/L/zS23xNSgK5PvUF
	34vPTtx9G9JcBlZfxy9N9MfxYSg5N2w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-O5ft9q3WPxCrDiEJlMybFA-1; Tue, 13 Feb 2024 18:02:35 -0500
X-MC-Unique: O5ft9q3WPxCrDiEJlMybFA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b2badbb4eso1877810f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 15:02:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865354; x=1708470154;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJhJ4xEMtOy5c1y6MqLIa8bGWYDGFy49+SYmZWzszOg=;
        b=WWiZK1a2kvT8JrQM45WPDyCPnh2HrUtbR/9GFGeXJeDsc1ZCaI9uWv29uxSA+Ey518
         bVxkcoZK+pMVC6DXrCGKH675n5Fgu8kPxbJVgiPqDBmhLwpQ6gS1rlImYmIUb/4Hwfr2
         U14Ib5ZP6tQlMwdCCyBOh5vtjR6QXPQzOBaFWQhi38Np89SButpl1LsEdHvUYSChc9Na
         rFkj4RGU7NPkUNZ2K3IIcIYA2J7bWOtSS0IItqt6Gy2mC/5AEStXVpwpp+X9bRl8TB7b
         ckU8RwWYSUsFPvz1OB5rhDKlLC+NTklu5qnuOS2xGd66q0BqUE6lYAhkoMFjQEFLjTmu
         NKWg==
X-Forwarded-Encrypted: i=1; AJvYcCWzVQOUbO/MEff6x8ybW+kROufhlBrIyYx56qyZ6sd5KIN0/YsUBZh/zan4sXeXd1+Z57duDVBUiI2I/0kdzzRVOgKFFYozM9k8m4xFzA==
X-Gm-Message-State: AOJu0YxVxiu1AiS0+kPYBkt9NAasbckVaICRoUgvv0v+7UivR4Ss6jyZ
	WLys7K/11373Rbcqfm4wTvMP76xrIqXEDsdyfr8md/G5hoqchyR3PgwypEIVZl1yaDW717CEl3F
	LpEyljSEkS+i/0+ScWO2vlNLTWBXMFEMyGoluXiwOX870gRhwLsDxcSmTXdMJthI=
X-Received: by 2002:a5d:4b44:0:b0:33c:df3e:a5a4 with SMTP id w4-20020a5d4b44000000b0033cdf3ea5a4mr459834wrs.18.1707865354007;
        Tue, 13 Feb 2024 15:02:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4A8VhQYTSoOYs4CoXMrelxYHYlTrlDNgZogjuyEeTUIXrZp//fCLZAWwioyKng9ZFc5pN5g==
X-Received: by 2002:a5d:4b44:0:b0:33c:df3e:a5a4 with SMTP id w4-20020a5d4b44000000b0033cdf3ea5a4mr459818wrs.18.1707865353562;
        Tue, 13 Feb 2024 15:02:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; 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
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id r3-20020adfca83000000b0033cdbe335bcsm2512992wrh.71.2024.02.13.15.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:02:33 -0800 (PST)
Message-ID: <a9b0440b-844e-4e45-a546-315d53322aad@redhat.com>
Date: Wed, 14 Feb 2024 00:02:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
 vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
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
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.02.24 23:59, Suren Baghdasaryan wrote:
> On Tue, Feb 13, 2024 at 2:50 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
>>
>> On Tue, Feb 13, 2024 at 11:48:41PM +0100, David Hildenbrand wrote:
>>> On 13.02.24 23:30, Suren Baghdasaryan wrote:
>>>> On Tue, Feb 13, 2024 at 2:17 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 13.02.24 23:09, Kent Overstreet wrote:
>>>>>> On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
>>>>>>> On 13.02.24 22:58, Suren Baghdasaryan wrote:
>>>>>>>> On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
>>>>>>>>>
>>>>>>>>> On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
>>>>>>>>> [...]
>>>>>>>>>> We're aiming to get this in the next merge window, for 6.9. The feedback
>>>>>>>>>> we've gotten has been that even out of tree this patchset has already
>>>>>>>>>> been useful, and there's a significant amount of other work gated on the
>>>>>>>>>> code tagging functionality included in this patchset [2].
>>>>>>>>>
>>>>>>>>> I suspect it will not come as a surprise that I really dislike the
>>>>>>>>> implementation proposed here. I will not repeat my arguments, I have
>>>>>>>>> done so on several occasions already.
>>>>>>>>>
>>>>>>>>> Anyway, I didn't go as far as to nak it even though I _strongly_ believe
>>>>>>>>> this debugging feature will add a maintenance overhead for a very long
>>>>>>>>> time. I can live with all the downsides of the proposed implementation
>>>>>>>>> _as long as_ there is a wider agreement from the MM community as this is
>>>>>>>>> where the maintenance cost will be payed. So far I have not seen (m)any
>>>>>>>>> acks by MM developers so aiming into the next merge window is more than
>>>>>>>>> little rushed.
>>>>>>>>
>>>>>>>> We tried other previously proposed approaches and all have their
>>>>>>>> downsides without making maintenance much easier. Your position is
>>>>>>>> understandable and I think it's fair. Let's see if others see more
>>>>>>>> benefit than cost here.
>>>>>>>
>>>>>>> Would it make sense to discuss that at LSF/MM once again, especially
>>>>>>> covering why proposed alternatives did not work out? LSF/MM is not "too far"
>>>>>>> away (May).
>>>>>>>
>>>>>>> I recall that the last LSF/MM session on this topic was a bit unfortunate
>>>>>>> (IMHO not as productive as it could have been). Maybe we can finally reach a
>>>>>>> consensus on this.
>>>>>>
>>>>>> I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
>>>>>> need to see a serious proposl - what we had at the last LSF was people
>>>>>> jumping in with half baked alternative proposals that very much hadn't
>>>>>> been thought through, and I see no need to repeat that.
>>>>>>
>>>>>> Like I mentioned, there's other work gated on this patchset; if people
>>>>>> want to hold this up for more discussion they better be putting forth
>>>>>> something to discuss.
>>>>>
>>>>> I'm thinking of ways on how to achieve Michal's request: "as long as
>>>>> there is a wider agreement from the MM community". If we can achieve
>>>>> that without LSF, great! (a bi-weekly MM meeting might also be an option)
>>>>
>>>> There will be a maintenance burden even with the cleanest proposed
>>>> approach.
>>>
>>> Yes.
>>>
>>>> We worked hard to make the patchset as clean as possible and
>>>> if benefits still don't outweigh the maintenance cost then we should
>>>> probably stop trying.
>>>
>>> Indeed.
>>>
>>>> At LSF/MM I would rather discuss functonal
>>>> issues/requirements/improvements than alternative approaches to
>>>> instrument allocators.
>>>> I'm happy to arrange a separate meeting with MM folks if that would
>>>> help to progress on the cost/benefit decision.
>>> Note that I am only proposing ways forward.
>>>
>>> If you think you can easily achieve what Michal requested without all that,
>>> good.
>>
>> He requested something?
> 
> Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
> possible until the compiler feature is developed and deployed. And it
> still would require changes to the headers, so don't think it's worth
> delaying the feature for years.
> 

I was talking about this: "I can live with all the downsides of the 
proposed implementationas long as there is a wider agreement from the MM 
community as this is where the maintenance cost will be payed. So far I 
have not seen (m)any acks by MM developers".

I certainly cannot be motivated at this point to review and ack this, 
unfortunately too much negative energy around here.

-- 
Cheers,

David / dhildenb


