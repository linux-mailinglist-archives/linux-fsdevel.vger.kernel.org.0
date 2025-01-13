Return-Path: <linux-fsdevel+bounces-39053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89D8A0BBDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFAF161937
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB57240253;
	Mon, 13 Jan 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9oAj5g/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD807240254
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782064; cv=none; b=gqyb2KJStpS5zn5dhjOjSi70SGw3PBheKdLw7oqCihtvpLEL80hgRVeeiAfsrD1hxxt6+jP07G3uGSDF1a00Ayi+SEoh0DXgVOdDjlM+MMP4RaGV1rOR8z5BhQPDQT5/9Pk6+OHxG18FQbfGXxANcMyypckLy+6JF3gH6G56vcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782064; c=relaxed/simple;
	bh=UUe2HPtOxo8lt7dU2l5wPUpcdJwAngiydVROK+mvJrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxmlIim4HwUE+DMo1I9M0tQQmF0UtjIyk4dHxOnk4Vt4TmzlrucfsqWbeBosJoBiQK4PEQOvEob9cS06vGt6l8Cnlk7fA+/3zZya1qqSxzQm1CvIxzRzYP1VQMDgXFdVusOYDTnYQuI1m8cwHtHj1aSlcnZdC1kDTaep9NP+nuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9oAj5g/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736782061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B1tdRw+GFmnVDVJUdRXQGRA8NBvUzqvFlAtcjpsRORs=;
	b=i9oAj5g/hX+d6K4bHDyLMcErHqlzwvATaqkMKrF6WtTHkASpEUk7xiO1GZFtFIWj76ETDi
	4N8p/dOlZAamIMeQf5omwZZIxW1R6IUN2SiHU3Oqon+67KQn7lZqd3NmZCWSc59TorlPdS
	WkeYiTlQwZWaJKdqbTDNJWcEvy6tdwY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-XOPt2bM8M2S3ollPU2rQtQ-1; Mon, 13 Jan 2025 10:27:39 -0500
X-MC-Unique: XOPt2bM8M2S3ollPU2rQtQ-1
X-Mimecast-MFC-AGG-ID: XOPt2bM8M2S3ollPU2rQtQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436248d1240so21429525e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 07:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782058; x=1737386858;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B1tdRw+GFmnVDVJUdRXQGRA8NBvUzqvFlAtcjpsRORs=;
        b=ZQsfnu58QYn7EFNabW9R1ZvrCVilLh9ztEaJT/V8JgeBc0jnVixAnMgRw82m61d481
         eM78mVCPuNnZam71kAsxhBUsTs5Dsf8oLvIjmYVqm91Gx5VEbFVkr4sPKfJXPcbC0hZp
         E8ZUU02fxf+IgCZDazX7GZlZ8nnfQ0+DdzahF9+YinYMg5g9gwiuWroHliAyodwm7hmZ
         SFUwD0vMkFgoz2rZnhijFRVMWo9KHVfchPIbl7o4DuwtlkwR7UbALXfcgHBwtq14dHr6
         K4V0xiQAuI7ciXaxAwlnOw5nkKmkvsGyawT2t85XYWaoZpmIDajdNWYs2bd+Y+qQlHaG
         yCqw==
X-Forwarded-Encrypted: i=1; AJvYcCVWzxJoMJFluol1zzRlBNTKIJCTtrmy8KG3sn1czsbl5CiG7tOfhg3AgniDZXCBDT7RRKk2oA9fL8C+YHxo@vger.kernel.org
X-Gm-Message-State: AOJu0YxansrHid5fdVQPNpzMbEQLpZYcRujauHFdjMkqVgLzQHHowZ+T
	nyOp67rKG6cD07bXsNG4IXfzv0fWXU2OCAehMtzBiM1mdiSrnieW2J5ra8MGPUDA72YZ1W/TC2V
	ITpYzej5wuzVKsgg0vT8nw5P4MGmEnuP/334wNnRjcYYUEO1vAr1n/LY59YIz1B4=
X-Gm-Gg: ASbGncu8UHFAUgwALz63keauzaCoch7NEJo6mtDvDXAhx3hNsPsp9BFIeA/APm4Wc+N
	dYKlr1TBJj8P8nuKJxNxIVYFDk7J7lhGi16FMqyNXdkIpiGXcMsQSXF/RhQzhRBw17mlqJxUw+v
	TJ0B+jH/cJOFPs9sXeq6OxuoIUbErL2O6feQoeP1TYGdxvyDSrQOUNw4ruxo992D9AE1godK2E1
	9AlJEhPXBHZcCu9Iv31AKlK6qjij4HHEhc5dJq8/ulUu0Os3hpMxAZ+g5/EWIis0JIrk8XUals3
	fG0k8M9S1iN7J8Y=
X-Received: by 2002:a05:600c:1d14:b0:436:5fc9:309d with SMTP id 5b1f17b1804b1-436e26f6d81mr144857525e9.30.1736782058135;
        Mon, 13 Jan 2025 07:27:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF10MMhhJLojZYGh83FtfYFql07yg7ZjEHf/55/4MjF9hbTzyhzmb+dfeltdh2S+k12HjoOiw==
X-Received: by 2002:a05:600c:1d14:b0:436:5fc9:309d with SMTP id 5b1f17b1804b1-436e26f6d81mr144857165e9.30.1736782057664;
        Mon, 13 Jan 2025 07:27:37 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e03e5fsm145668705e9.18.2025.01.13.07.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 07:27:36 -0800 (PST)
Message-ID: <2848b566-3cae-4e89-916c-241508054402@redhat.com>
Date: Mon, 13 Jan 2025 16:27:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
 <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
 <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com>
 <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 23:00, Shakeel Butt wrote:
> On Fri, Jan 10, 2025 at 10:13:17PM +0100, David Hildenbrand wrote:
>> On 10.01.25 21:28, Jeff Layton wrote:
>>> On Thu, 2025-01-09 at 12:22 +0100, David Hildenbrand wrote:
>>>> On 07.01.25 19:07, Shakeel Butt wrote:
>>>>> On Tue, Jan 07, 2025 at 09:34:49AM +0100, David Hildenbrand wrote:
>>>>>> On 06.01.25 19:17, Shakeel Butt wrote:
>>>>>>> On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
>>>>>>>> On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>> In any case, having movable pages be turned unmovable due to persistent
>>>>>>>>> writaback is something that must be fixed, not worked around. Likely a
>>>>>>>>> good topic for LSF/MM.
>>>>>>>>
>>>>>>>> Yes, this seems a good cross fs-mm topic.
>>>>>>>>
>>>>>>>> So the issue discussed here is that movable pages used for fuse
>>>>>>>> page-cache cause a problems when memory needs to be compacted. The
>>>>>>>> problem is either that
>>>>>>>>
>>>>>>>>      - the page is skipped, leaving the physical memory block unmovable
>>>>>>>>
>>>>>>>>      - the compaction is blocked for an unbounded time
>>>>>>>>
>>>>>>>> While the new AS_WRITEBACK_INDETERMINATE could potentially make things
>>>>>>>> worse, the same thing happens on readahead, since the new page can be
>>>>>>>> locked for an indeterminate amount of time, which can also block
>>>>>>>> compaction, right?
>>>>>>
>>>>>> Yes, as memory hotplug + virtio-mem maintainer my bigger concern is these
>>>>>> pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where there *must not be
>>>>>> unmovable pages ever*. Not triggered by an untrusted source, not triggered
>>>>>> by an trusted source.
>>>>>>
>>>>>> It's a violation of core-mm principles.
>>>>>
>>>>> The "must not be unmovable pages ever" is a very strong statement and we
>>>>> are violating it today and will keep violating it in future. Any
>>>>> page/folio under lock or writeback or have reference taken or have been
>>>>> isolated from their LRU is unmovable (most of the time for small period
>>>>> of time).
>>>>
>>>> ^ this: "small period of time" is what I meant.
>>>>
>>>> Most of these things are known to not be problematic: retrying a couple
>>>> of times makes it work, that's why migration keeps retrying.
>>>>
>>>> Again, as an example, we allow short-term O_DIRECT but disallow
>>>> long-term page pinning. I think there were concerns at some point if
>>>> O_DIRECT might also be problematic (I/O might take a while), but so far
>>>> it was not a problem in practice that would make CMA allocations easily
>>>> fail.
>>>>
>>>> vmsplice() is a known problem, because it behaves like O_DIRECT but
>>>> actually triggers long-term pinning; IIRC David Howells has this on his
>>>> todo list to fix. [I recall that seccomp disallows vmsplice by default
>>>> right now]
>>>>
>>>> These operations are being done all over the place in kernel.
>>>>> Miklos gave an example of readahead.
>>>>
>>>> I assume you mean "unmovable for a short time", correct, or can you
>>>> point me at that specific example; I think I missed that.
> 
> Please see https://lore.kernel.org/all/CAJfpegthP2enc9o1hV-izyAG9nHcD_tT8dKFxxzhdQws6pcyhQ@mail.gmail.com/
> 
>>>>
>>>>> The per-CPU LRU caches are another
>>>>> case where folios can get stuck for long period of time.
>>>>
>>>> Which is why memory offlining disables the lru cache. See
>>>> lru_cache_disable(). Other users that care about that drain the LRU on
>>>> all cpus.
>>>>
>>>>> Reclaim and
>>>>> compaction can isolate a lot of folios that they need to have
>>>>> too_many_isolated() checks. So, "must not be unmovable pages ever" is
>>>>> impractical.
>>>>
>>>> "must only be short-term unmovable", better?
> 
> Yes and you have clarified further below of the actual amount.
> 
>>>>
>>>
>>> Still a little ambiguous.
>>>
>>> How short is "short-term"? Are we talking milliseconds or minutes?
>>
>> Usually a couple of seconds, max. For memory offlining, slightly longer
>> times are acceptable; other things (in particular compaction or CMA
>> allocations) will give up much faster.
>>
>>>
>>> Imposing a hard timeout on writeback requests to unprivileged FUSE
>>> servers might give us a better guarantee of forward-progress, but it
>>> would probably have to be on the order of at least a minute or so to be
>>> workable.
>>
>> Yes, and that might already be a bit too much, especially if stuck on
>> waiting for folio writeback ... so ideally we could find a way to migrate
>> these folios that are under writeback and it's not your ordinary disk driver
>> that responds rather quickly.
>>
>> Right now we do it via these temp pages, and I can see how that's
>> undesirable.
>>
>> For NFS etc. we probably never ran into this, because it's all used in
>> fairly well managed environments and, well, I assume NFS easily outdates CMA
>> and ZONE_MOVABLE :)
>>
>>>>>>
>>>>> The point is that, yes we should aim to improve things but in iterations
>>>>> and "must not be unmovable pages ever" is not something we can achieve
>>>>> in one step.
>>>>
>>>> I agree with the "improve things in iterations", but as
>>>> AS_WRITEBACK_INDETERMINATE has the FOLL_LONGTERM smell to it, I think we
>>>> are making things worse.
> 
> AS_WRITEBACK_INDETERMINATE is really a bad name we picked as it is still
> causing confusion. It is a simple flag to avoid deadlock in the reclaim
> code path and does not say anything about movability.
> 
>>>>
>>>> And as this discussion has been going on for too long, to summarize my
>>>> point: there exist conditions where pages are short-term unmovable, and
>>>> possibly some to be fixed that turn pages long-term unmovable (e.g.,
>>>> vmsplice); that does not mean that we can freely add new conditions that
>>>> turn movable pages unmovable long-term or even forever.
>>>>
>>>> Again, this might be a good LSF/MM topic. If I would have the capacity I
>>>> would suggest a topic around which things are know to cause pages to be
>>>> short-term or long-term unmovable/unsplittable, and which can be
>>>> handled, which not. Maybe I'll find the time to propose that as a topic.
>>>>
>>>
>>>
>>> This does sound like great LSF/MM fodder! I predict that this session
>>> will run long! ;)
>>
>> Heh, fully agreed! :)
> 
> I would like more targeted topic and for that I want us to at least
> agree where we are disagring. Let me write down two statements and
> please tell me where you disagree:

I think we're mostly in agreement!

> 
> 1. For a normal running FUSE server (without tmp pages), the lifetime of
> writeback state of fuse folios falls under "short-term unmovable" bucket
> as it does not differ in anyway from anyother filesystems handling
> writeback folios.

That's the expectation, yes. As long as the FUSE server is able to make 
progress, the expectation is that it's just like NFS etc. If it isn't 
able to make progress (i.e., crash), the expectation is that everything 
will get cleaned up either way.

I wonder if there could be valid scenario where the FUSE server is no 
longer able to make progress (ignoring network outages), or the progress 
might start being extremely slow such that it becomes a problem. In 
contrast to in-kernel FSs, one can do some fancy stuff with fuse where 
writing a page could possibly consume a lot of memory in user-space. 
Likely, in this case we might just blame it on the admin that agreed to 
running this (trusted) fuse server.

> 
> 2. For a buggy or untrusted FUSE server (without tmp pages), the
> lifetime of writeback state of fuse folios can be arbitrarily long and
> we need some mechanism to limit it.

Yes.


Especially in 1), we really want to wait for writeback to finish, just 
like for any other filesystem. For 2), we want a way so writeback will 
not get stuck for a long time, but are able to make progress and migrate 
these pages.

-- 
Cheers,

David / dhildenb


