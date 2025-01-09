Return-Path: <linux-fsdevel+bounces-38728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC5A0748D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 12:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB5E166465
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC172165EC;
	Thu,  9 Jan 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYZ50u8Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6196DDDC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421751; cv=none; b=c3e4L6+TySMi34F637/2e5JzEDv7Tnwb9PSeB+jlhsxLcMqf8RtHCGOJnTZqAuwtvjyILf4Oei9OvgH0sH50cKVlN8wtt+7O+QhG0++OmfU/33EO5PnoRKWcgF8/kC9eMEMEZEJ03+scqpbrLi6RkVpsIcXZmeHMiZlLExoGhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421751; c=relaxed/simple;
	bh=gpdGzXSNEMBz3FjW5TgBdo2yIPuauMb/HsjHMWW0SU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+UqpUp54wV3ABHKR8z5LRu35I0f4wfRoQ319pBFyIxq3f48EAlbC84qmwsCC/A5w+AqjnWG9Rz8S5Mlmz/TnudQ2JWTiVtN3cK7YDwA85ypvHkGT39jEthR+2486IlaatDJCR9xJgCPyEDZwW7KOxFHoLRmoUSJ2x7uUZxlplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYZ50u8Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736421748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F7w0Lj+T4CWrVwi5FMFjGb9ZW0o7/x2RrSBvY2OdilM=;
	b=YYZ50u8Z3LbIPJede0MEJbzj48HoM3NLKrCLrYVYBre4kjRhl6VMTH+nHKR+hNoUhRHT2S
	UgNEksIca00I2p759RF86xJqDir0HfOi50F0pEdPZ5YMl2GqsuzH3MVMOFciU8hzUkoChP
	IPLgnSTa9wQgGFsJwat/YP5xOCqZOdQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-kjOCIjXENeOfXOswTy4XSQ-1; Thu, 09 Jan 2025 06:22:27 -0500
X-MC-Unique: kjOCIjXENeOfXOswTy4XSQ-1
X-Mimecast-MFC-AGG-ID: kjOCIjXENeOfXOswTy4XSQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so4126045e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 03:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736421746; x=1737026546;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F7w0Lj+T4CWrVwi5FMFjGb9ZW0o7/x2RrSBvY2OdilM=;
        b=DG8173a5EbCv0V1tt0yhV7eyUcSNuMvqe717Pm19IWOirCGYnpk8h8Rhv5qikvDww1
         JcmDWtLr0A0sVLP+hZvpYmzEMP1ZzsVEF/X/O5BDGrZvzGJQK71cWilmU0acOp5yT+/6
         t2VeAqOCGb1VIuTl67h8JLrF9s3p52n/cU4oOeKfDK1MA5k1DOCsOuD87lxnT6pw8sGv
         CHpo+ydNaPIUa+UqKtPUXsX6lwKex+ysoafCOwiCj6Zk+npjmVh0k8K+a/kr7/Qd8e0+
         0K6maJdRbbnn20dio8SBKKZaXcNeglrXD6WVTKUWStmGGoChS+tP4SYA9fwRawUr/sgE
         T/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5cRTYU0AQ0heYu3hnv7sJ+Pn+ZXrZ0dVW79Cv/iq61m4guYQMtB3T9jFM/yVkBVVsGk94wK2tnXJbWA1V@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7v+RUwrh0+g4tPLNl72BfU/WNHl4ICQXTtRSs/4P97TfWxS/p
	Kegz26C1pf4ZlF6c6G11pXoforO5EUhehlZZ3rD0eU+e9dgOkBAOayKQ48rQCxChU/hof7ioK0G
	aOxKBOOeP3mVwD4b/brZ2h45c4wLVbDM3SoGNctoJnpuRJ2BHANaluD9PuUDu0/5Vh5ZvsTA=
X-Gm-Gg: ASbGncuxUfuhvzM+jj87etc7mOfFjvUrhccZub158UGBfB+Il4mtmz9dTXr681igqRK
	Jx3T3ibNJO5/gKn7fLD061y6v6UmKbulDi9YeIs3v84eumnLiVaDRaJmn/FGEliuqNLHeE8SEq5
	sCXOxSnpiwMjrVx+ElIkv697mmUZXEFRSmQ2uuIJZdvNfXNslLFy359uATbYf/wBx4ruVBsefdv
	mb+QNYw55znmznOtSvP/ItfSL2GD3h/DEwO7f8F8+MmvFdw4oeYacTXnVSp8zvhBikrDBBf0Qsg
	Uj99T9JF8ANtEkpxWXWtNGvUvbglTMBq+hQ0bqgqYmccUYc/C4hWWqOt6Zj5aZ+O+///n0wrP1O
	jAsVa7A==
X-Received: by 2002:a5d:64ad:0:b0:385:e67d:9e0 with SMTP id ffacd0b85a97d-38a8730d521mr5145607f8f.29.1736421746310;
        Thu, 09 Jan 2025 03:22:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkPjFLyjd0K3wvAdCPpWhl0J54qBsWSnwpSWDeCcp0szfh4piYX+SHBbgnXJufh3vWMLbm4A==
X-Received: by 2002:a5d:64ad:0:b0:385:e67d:9e0 with SMTP id ffacd0b85a97d-38a8730d521mr5145576f8f.29.1736421745831;
        Thu, 09 Jan 2025 03:22:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c72e:800:d383:9661:5934:2cfa? (p200300cbc72e0800d383966159342cfa.dip0.t-ipconnect.de. [2003:cb:c72e:800:d383:9661:5934:2cfa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1b05sm1528207f8f.88.2025.01.09.03.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 03:22:25 -0800 (PST)
Message-ID: <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
Date: Thu, 9 Jan 2025 12:22:23 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.01.25 19:07, Shakeel Butt wrote:
> On Tue, Jan 07, 2025 at 09:34:49AM +0100, David Hildenbrand wrote:
>> On 06.01.25 19:17, Shakeel Butt wrote:
>>> On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
>>>> On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
>>>>> In any case, having movable pages be turned unmovable due to persistent
>>>>> writaback is something that must be fixed, not worked around. Likely a
>>>>> good topic for LSF/MM.
>>>>
>>>> Yes, this seems a good cross fs-mm topic.
>>>>
>>>> So the issue discussed here is that movable pages used for fuse
>>>> page-cache cause a problems when memory needs to be compacted. The
>>>> problem is either that
>>>>
>>>>    - the page is skipped, leaving the physical memory block unmovable
>>>>
>>>>    - the compaction is blocked for an unbounded time
>>>>
>>>> While the new AS_WRITEBACK_INDETERMINATE could potentially make things
>>>> worse, the same thing happens on readahead, since the new page can be
>>>> locked for an indeterminate amount of time, which can also block
>>>> compaction, right?
>>
>> Yes, as memory hotplug + virtio-mem maintainer my bigger concern is these
>> pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where there *must not be
>> unmovable pages ever*. Not triggered by an untrusted source, not triggered
>> by an trusted source.
>>
>> It's a violation of core-mm principles.
> 
> The "must not be unmovable pages ever" is a very strong statement and we
> are violating it today and will keep violating it in future. Any
> page/folio under lock or writeback or have reference taken or have been
> isolated from their LRU is unmovable (most of the time for small period
> of time).

^ this: "small period of time" is what I meant.

Most of these things are known to not be problematic: retrying a couple 
of times makes it work, that's why migration keeps retrying.

Again, as an example, we allow short-term O_DIRECT but disallow 
long-term page pinning. I think there were concerns at some point if 
O_DIRECT might also be problematic (I/O might take a while), but so far 
it was not a problem in practice that would make CMA allocations easily 
fail.

vmsplice() is a known problem, because it behaves like O_DIRECT but 
actually triggers long-term pinning; IIRC David Howells has this on his 
todo list to fix. [I recall that seccomp disallows vmsplice by default 
right now]

These operations are being done all over the place in kernel.
> Miklos gave an example of readahead. 

I assume you mean "unmovable for a short time", correct, or can you 
point me at that specific example; I think I missed that.

> The per-CPU LRU caches are another
> case where folios can get stuck for long period of time.

Which is why memory offlining disables the lru cache. See 
lru_cache_disable(). Other users that care about that drain the LRU on 
all cpus.

> Reclaim and
> compaction can isolate a lot of folios that they need to have
> too_many_isolated() checks. So, "must not be unmovable pages ever" is
> impractical.

"must only be short-term unmovable", better?

> 
> The point is that, yes we should aim to improve things but in iterations
> and "must not be unmovable pages ever" is not something we can achieve
> in one step.

I agree with the "improve things in iterations", but as
AS_WRITEBACK_INDETERMINATE has the FOLL_LONGTERM smell to it, I think we 
are making things worse.

And as this discussion has been going on for too long, to summarize my 
point: there exist conditions where pages are short-term unmovable, and 
possibly some to be fixed that turn pages long-term unmovable (e.g., 
vmsplice); that does not mean that we can freely add new conditions that 
turn movable pages unmovable long-term or even forever.

Again, this might be a good LSF/MM topic. If I would have the capacity I 
would suggest a topic around which things are know to cause pages to be 
short-term or long-term unmovable/unsplittable, and which can be 
handled, which not. Maybe I'll find the time to propose that as a topic.

-- 
Cheers,

David / dhildenb


