Return-Path: <linux-fsdevel+bounces-11487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B47853F1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A91F24128
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3A62A1C;
	Tue, 13 Feb 2024 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9vSGo0h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FF627EE
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864531; cv=none; b=oj/krhSUjQ3mSQEZxTQqnBylqI39YDoWMOvnHSCBjqjegil0NJZ4i7+gwgxrqSYE0keYVGXgsOFrfgSIlzUU9doI2rtXSyHkokLHy665vTUuFVDYS0eEuq/Wmq4trwO2ISNFfJeEIlmfgEqP3Tv/vie9MX/6hIBsIkykvdV3F/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864531; c=relaxed/simple;
	bh=jNt/TRHM1T00/SVtqRibmVqDqXofu5Y38rxL3/XM5dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFE721pvnMrAxFQ+EnzSOlcdVPMxfAnxJnCQ+rG7Nrwf/eJ72vi8o9Z+l7xLl1Onv4UdO21rXPbqO4ypx8/YDSdIzICt2+RUle9uob1CBoKY7JTSCiLdQctoK816KiHzzkYG33errX5+JLdCqqYhj8BQ6swJOh3p3JvQKCx8nhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9vSGo0h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707864529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fUzYvptXwU+wpVXUT9gyu0he36rKpcH8guCwJL2uHOc=;
	b=P9vSGo0hnLHOJCvpFkX64nvvP1LzSwsq40KTalxxV5UvJFRaRSQaBsLet0U/h+fnKTIK2i
	ccLC0suN5k/+Hk3cD84V8iWcxo23vIFtA6fs8MUCFhcH+Un2f5aJ7CsP9zptJV2lnJ1vKU
	lqNUv5oqffinYPdgKKicjSMgdzcimVg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-C3BX9oZLNhq2tg47gk7o8A-1; Tue, 13 Feb 2024 17:48:47 -0500
X-MC-Unique: C3BX9oZLNhq2tg47gk7o8A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e53200380so29996655e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 14:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864526; x=1708469326;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUzYvptXwU+wpVXUT9gyu0he36rKpcH8guCwJL2uHOc=;
        b=MPqFK/jyEwucsteWS05ZMQ6RqKgqcrxXWS+7vsee966MEjt07CIewOt8/iOIY+SrNk
         1lVCZ/7frHMpv9FzDK0Yn2pPf8lLc0RLdwZHILKnyBqB3ptncUNL/H4dHgjISoILjmVd
         sdv1EiIy2/v2KPm2zV9R7sCMTxydG2g4xJkbDLCa6qBlxFrjTBHtwc13iUMwrgu7SK4u
         JUecsuHs+NUJlP8dFqTUIWDPHUrStAGsDLm+gWBLXvPzY4sMZwh5crYX+Rc4/RyOyndn
         Te/sZsaX1k+XdzkffpO+tMNkevPUj90gDHvp0DfgsFu0f+lIc0wGf55UTT57bKMkhU3t
         8KUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3H5ckZhAo2LsQR1+h3BQwEzRS7fvlD4Wr+echybAymLyz1587pikJi3bE3gB3ivEIwHsL2/+/l6AEjEwCqOUaPpIT980g9bZyIKuhjw==
X-Gm-Message-State: AOJu0YzgO01vXjNSC37aUrFuC002f5aoRf4tFRirxke2TpprMnys6ha3
	vEqLt4eWsKxXaKRD7qZoW1i3UW291iGAUMoMs6MW2S2Pnf0CsG4RQuXWqVRywjZTL3iWsmw0jmW
	mSmWpDLXe9ye40F1O65cWWEm3mK8ooCUHwHJZgvA7kTCI/CFPgTY/EHjQCDGxXFQ=
X-Received: by 2002:a05:6000:1289:b0:33b:4382:c50 with SMTP id f9-20020a056000128900b0033b43820c50mr399559wrx.26.1707864525836;
        Tue, 13 Feb 2024 14:48:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwdgUa9zYk4RWD1O/Fx60CTKkwN09LrmTmMG3vES6P2lwl9hNKQ6ZG2jpA1xBdh5djj4K2uQ==
X-Received: by 2002:a05:6000:1289:b0:33b:4382:c50 with SMTP id f9-20020a056000128900b0033b43820c50mr399523wrx.26.1707864525398;
        Tue, 13 Feb 2024 14:48:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; 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
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id bv14-20020a0560001f0e00b0033b784c2775sm8751825wrb.43.2024.02.13.14.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 14:48:44 -0800 (PST)
Message-ID: <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
Date: Tue, 13 Feb 2024 23:48:41 +0100
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
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.02.24 23:30, Suren Baghdasaryan wrote:
> On Tue, Feb 13, 2024 at 2:17 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 13.02.24 23:09, Kent Overstreet wrote:
>>> On Tue, Feb 13, 2024 at 11:04:58PM +0100, David Hildenbrand wrote:
>>>> On 13.02.24 22:58, Suren Baghdasaryan wrote:
>>>>> On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
>>>>>>
>>>>>> On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
>>>>>> [...]
>>>>>>> We're aiming to get this in the next merge window, for 6.9. The feedback
>>>>>>> we've gotten has been that even out of tree this patchset has already
>>>>>>> been useful, and there's a significant amount of other work gated on the
>>>>>>> code tagging functionality included in this patchset [2].
>>>>>>
>>>>>> I suspect it will not come as a surprise that I really dislike the
>>>>>> implementation proposed here. I will not repeat my arguments, I have
>>>>>> done so on several occasions already.
>>>>>>
>>>>>> Anyway, I didn't go as far as to nak it even though I _strongly_ believe
>>>>>> this debugging feature will add a maintenance overhead for a very long
>>>>>> time. I can live with all the downsides of the proposed implementation
>>>>>> _as long as_ there is a wider agreement from the MM community as this is
>>>>>> where the maintenance cost will be payed. So far I have not seen (m)any
>>>>>> acks by MM developers so aiming into the next merge window is more than
>>>>>> little rushed.
>>>>>
>>>>> We tried other previously proposed approaches and all have their
>>>>> downsides without making maintenance much easier. Your position is
>>>>> understandable and I think it's fair. Let's see if others see more
>>>>> benefit than cost here.
>>>>
>>>> Would it make sense to discuss that at LSF/MM once again, especially
>>>> covering why proposed alternatives did not work out? LSF/MM is not "too far"
>>>> away (May).
>>>>
>>>> I recall that the last LSF/MM session on this topic was a bit unfortunate
>>>> (IMHO not as productive as it could have been). Maybe we can finally reach a
>>>> consensus on this.
>>>
>>> I'd rather not delay for more bikeshedding. Before agreeing to LSF I'd
>>> need to see a serious proposl - what we had at the last LSF was people
>>> jumping in with half baked alternative proposals that very much hadn't
>>> been thought through, and I see no need to repeat that.
>>>
>>> Like I mentioned, there's other work gated on this patchset; if people
>>> want to hold this up for more discussion they better be putting forth
>>> something to discuss.
>>
>> I'm thinking of ways on how to achieve Michal's request: "as long as
>> there is a wider agreement from the MM community". If we can achieve
>> that without LSF, great! (a bi-weekly MM meeting might also be an option)
> 
> There will be a maintenance burden even with the cleanest proposed
> approach. 

Yes.

> We worked hard to make the patchset as clean as possible and
> if benefits still don't outweigh the maintenance cost then we should
> probably stop trying.

Indeed.

> At LSF/MM I would rather discuss functonal
> issues/requirements/improvements than alternative approaches to
> instrument allocators.
> I'm happy to arrange a separate meeting with MM folks if that would
> help to progress on the cost/benefit decision.
Note that I am only proposing ways forward.

If you think you can easily achieve what Michal requested without all 
that, good.

My past experience was that LSF/MM / bi-weekly MM meetings were 
extremely helpful to reach consensus.

-- 
Cheers,

David / dhildenb


