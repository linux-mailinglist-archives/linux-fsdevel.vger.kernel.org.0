Return-Path: <linux-fsdevel+bounces-38918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF3BA09CD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 22:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650D6188C30E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 21:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AF20896C;
	Fri, 10 Jan 2025 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeCFhKEx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1852080DA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736543608; cv=none; b=Ewtb8TfyGrCPTUcPwkMl+VNhoemcQbaEC4cFKlxo/gNDfZP1O6uavWjIkTf7lKJsTevuPwgMjSUqcHKaHK0i24kX5DPzB9UtoH0dJ4Tz2rdm0M0b61Ehyfw7lCjSCr/suQeMQJ6H/GW7PhogQCi+mvt8GxUQi1FDj4LgPqtwrC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736543608; c=relaxed/simple;
	bh=FVI0/6qpry5sKriVjmJQijuiGqC1NEAjPMq4ldsarDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPsbcAHvSertTaicg8Ft7YoEy0VMPB7H5gqstSw70NnytX77/ZRd+Y5I/02aHv4aO8dW4hRsCXYlbIsJcdwAJ+9aiyZd9ogmvM/hndijxDNN01lIfHtNwy3TvCZujkDkCEuOUuhbdBX8fc/BkKXs5g02kYE3NrcEsyqSTneVHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeCFhKEx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736543605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EeIUoIjZUFNtiNRnVwaW4fp2T66i1qr7WJzeNybd0b4=;
	b=VeCFhKExHD5bB4TYdjWE9+VXm/v1jaQuabSgy7vJr3ZXlPeHh28I5a0DhisDAUgiNWJFDV
	XjYw6oHY6Ai1xE6v0f+vDPDxhDXKwF8hIviXL4tu56l4vFsJ1Abolm6nqUM/6/T7DXj5x+
	bifz/cbWUsLdpaJqXY/ZOQ725uq7lbE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-JaKQLOOjMHqvVjKsdFQ7Pg-1; Fri, 10 Jan 2025 16:13:22 -0500
X-MC-Unique: JaKQLOOjMHqvVjKsdFQ7Pg-1
X-Mimecast-MFC-AGG-ID: JaKQLOOjMHqvVjKsdFQ7Pg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385ed79291eso1705863f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 13:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736543601; x=1737148401;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EeIUoIjZUFNtiNRnVwaW4fp2T66i1qr7WJzeNybd0b4=;
        b=KlVZ5yXBDq5mmqDuAmzGDWH9sSrq9MWNxL/HotNP2rIokMnJtfF1XVubeHaSs8+f+u
         RjwDnonzKFeHk4E1aRqmpBeYzVid/2+m+xh6lja5B2R/yn8jEScoQjUdR8dbiQdIKEcU
         S76hj9VSkI1o511G04a1EOeUADm32vT9O4rg0GmuC7d/TcgWxNP/YUPGKPJGwvKjED1x
         h7gWvCs43Jf09UYLTOXf+NVzJP8M1eswDtCQmNsckGxxrflrAtJpSy0UqjPHnKje4orS
         7VOGL70aZdBjv+2lzVEt5KT+BzPZ84gjUypLfnBkjm1cIOKJGIlP1B4utr3R2TejDBBy
         sWpA==
X-Forwarded-Encrypted: i=1; AJvYcCXunY/UFOCR/4efevON3/iIRbAHniPfZ9SxNzAv+frmNcLD8FRliqvVucjStdKo3uO5W1EsaaJcXSs/aAfT@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCrxANqL/asEvjXzi3+X3OZA2xDZoWjPrcPae8S9SZMSCQ6q0
	TCg0Yj9MQyNpVML6OEthliOTjUkyBSCdf5IcB3zSI/bMR/hVebU/ulaBJ0Rn2ViQTcvTVORz9Ec
	kPBjCdZgwjaRJLwNZN0TBX0fkXx677q1ccFTKxXKbRVwVn5fI8qGmYWS4Fv2USus=
X-Gm-Gg: ASbGnct2HUCxdVOFVhUJUHjked3/iSgREbwoV3R2L+tLHFq0YmIVDMaz4lTa8GdjQwu
	1TvtvH9xgUID/F2I1Wap2qQo9u/Par9Kt5F+KTt6vqRvJODVYjJSEtbKG6naCZu/qq/YDDyf31w
	YhmMFCIbYurpNZjPoNdx7t4dZVCHMPmMhnpCZjDjTOJdhuNXMnF6IPorVSMGtdaTcwlYIu+1APv
	8sl2bpd50moGdPp9WRKn13lGNu+HM37zxGaTdQxcYLWepPB6TkFICISogk5dcnBf6um0zl5mNi4
	sTkTk7FZYBWzZn/XL+8G+ODl735CkoctpEoMoYouDXSPjE8komwtgP5okVKwu+dA/qvh+avNE1q
	hWcD5XQ22
X-Received: by 2002:a5d:6d04:0:b0:385:f07a:f4cb with SMTP id ffacd0b85a97d-38a8b0d3166mr6945470f8f.8.1736543600965;
        Fri, 10 Jan 2025 13:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5R47FaOgB1kt8eBsOyKxn/mdF0lH6hJkFFQSVsNWL9a3o0cjUcVhjjK+cWeMmdXpZSiAiEQ==
X-Received: by 2002:a5d:6d04:0:b0:385:f07a:f4cb with SMTP id ffacd0b85a97d-38a8b0d3166mr6945458f8f.8.1736543600591;
        Fri, 10 Jan 2025 13:13:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a? (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de. [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d01dsm5427873f8f.9.2025.01.10.13.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 13:13:19 -0800 (PST)
Message-ID: <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com>
Date: Fri, 10 Jan 2025 22:13:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jeff Layton <jlayton@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong
 <joannelkoong@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>,
 Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
 <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
 <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
 <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 21:28, Jeff Layton wrote:
> On Thu, 2025-01-09 at 12:22 +0100, David Hildenbrand wrote:
>> On 07.01.25 19:07, Shakeel Butt wrote:
>>> On Tue, Jan 07, 2025 at 09:34:49AM +0100, David Hildenbrand wrote:
>>>> On 06.01.25 19:17, Shakeel Butt wrote:
>>>>> On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
>>>>>> On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
>>>>>>> In any case, having movable pages be turned unmovable due to persistent
>>>>>>> writaback is something that must be fixed, not worked around. Likely a
>>>>>>> good topic for LSF/MM.
>>>>>>
>>>>>> Yes, this seems a good cross fs-mm topic.
>>>>>>
>>>>>> So the issue discussed here is that movable pages used for fuse
>>>>>> page-cache cause a problems when memory needs to be compacted. The
>>>>>> problem is either that
>>>>>>
>>>>>>     - the page is skipped, leaving the physical memory block unmovable
>>>>>>
>>>>>>     - the compaction is blocked for an unbounded time
>>>>>>
>>>>>> While the new AS_WRITEBACK_INDETERMINATE could potentially make things
>>>>>> worse, the same thing happens on readahead, since the new page can be
>>>>>> locked for an indeterminate amount of time, which can also block
>>>>>> compaction, right?
>>>>
>>>> Yes, as memory hotplug + virtio-mem maintainer my bigger concern is these
>>>> pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where there *must not be
>>>> unmovable pages ever*. Not triggered by an untrusted source, not triggered
>>>> by an trusted source.
>>>>
>>>> It's a violation of core-mm principles.
>>>
>>> The "must not be unmovable pages ever" is a very strong statement and we
>>> are violating it today and will keep violating it in future. Any
>>> page/folio under lock or writeback or have reference taken or have been
>>> isolated from their LRU is unmovable (most of the time for small period
>>> of time).
>>
>> ^ this: "small period of time" is what I meant.
>>
>> Most of these things are known to not be problematic: retrying a couple
>> of times makes it work, that's why migration keeps retrying.
>>
>> Again, as an example, we allow short-term O_DIRECT but disallow
>> long-term page pinning. I think there were concerns at some point if
>> O_DIRECT might also be problematic (I/O might take a while), but so far
>> it was not a problem in practice that would make CMA allocations easily
>> fail.
>>
>> vmsplice() is a known problem, because it behaves like O_DIRECT but
>> actually triggers long-term pinning; IIRC David Howells has this on his
>> todo list to fix. [I recall that seccomp disallows vmsplice by default
>> right now]
>>
>> These operations are being done all over the place in kernel.
>>> Miklos gave an example of readahead.
>>
>> I assume you mean "unmovable for a short time", correct, or can you
>> point me at that specific example; I think I missed that.
>>
>>> The per-CPU LRU caches are another
>>> case where folios can get stuck for long period of time.
>>
>> Which is why memory offlining disables the lru cache. See
>> lru_cache_disable(). Other users that care about that drain the LRU on
>> all cpus.
>>
>>> Reclaim and
>>> compaction can isolate a lot of folios that they need to have
>>> too_many_isolated() checks. So, "must not be unmovable pages ever" is
>>> impractical.
>>
>> "must only be short-term unmovable", better?
>>
> 
> Still a little ambiguous.
> 
> How short is "short-term"? Are we talking milliseconds or minutes?

Usually a couple of seconds, max. For memory offlining, slightly longer 
times are acceptable; other things (in particular compaction or CMA 
allocations) will give up much faster.

> 
> Imposing a hard timeout on writeback requests to unprivileged FUSE
> servers might give us a better guarantee of forward-progress, but it
> would probably have to be on the order of at least a minute or so to be
> workable.

Yes, and that might already be a bit too much, especially if stuck on 
waiting for folio writeback ... so ideally we could find a way to 
migrate these folios that are under writeback and it's not your ordinary 
disk driver that responds rather quickly.

Right now we do it via these temp pages, and I can see how that's 
undesirable.

For NFS etc. we probably never ran into this, because it's all used in 
fairly well managed environments and, well, I assume NFS easily outdates 
CMA and ZONE_MOVABLE :)

 > >>>
>>> The point is that, yes we should aim to improve things but in iterations
>>> and "must not be unmovable pages ever" is not something we can achieve
>>> in one step.
>>
>> I agree with the "improve things in iterations", but as
>> AS_WRITEBACK_INDETERMINATE has the FOLL_LONGTERM smell to it, I think we
>> are making things worse.
>>
>> And as this discussion has been going on for too long, to summarize my
>> point: there exist conditions where pages are short-term unmovable, and
>> possibly some to be fixed that turn pages long-term unmovable (e.g.,
>> vmsplice); that does not mean that we can freely add new conditions that
>> turn movable pages unmovable long-term or even forever.
>>
>> Again, this might be a good LSF/MM topic. If I would have the capacity I
>> would suggest a topic around which things are know to cause pages to be
>> short-term or long-term unmovable/unsplittable, and which can be
>> handled, which not. Maybe I'll find the time to propose that as a topic.
>>
> 
> 
> This does sound like great LSF/MM fodder! I predict that this session
> will run long! ;)

Heh, fully agreed! :)

-- 
Cheers,

David / dhildenb


