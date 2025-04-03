Return-Path: <linux-fsdevel+bounces-45704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC70A7B054
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62717A6F77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 21:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD357202982;
	Thu,  3 Apr 2025 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCihhfzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DF20127C
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743713082; cv=none; b=pCCKGfYya+gIWo79lNJbw+Q6eYUhFDnlt4eqS4vU+yFN44eBOVrUY+H7+Y2Q+vHjrVWa9YiNKnL4ibDuzXqGPzRNt9kVDQ7bfJKOM+b+xQ62kdbJmbGjI9xCxfnJ5fl5IncwnhTQgAG8NLefcNrxcHogtT3GeFub03FcmiL+K4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743713082; c=relaxed/simple;
	bh=xBNnzSDIcFpG5l1V0hOahzRnQd199gHN6VnIMp38X44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFrkgmLLlmwmrzSEKYYcFSq+c6CHZ+UMcxBUd5nRqAK7uAY4T/fTMYpqLYGunoQDhDwJjPrPKZLoJI2o2GkExp/Vc4ayQs/RLXNuOkpvXnEgZTQIA/sX9INOKpJsCJ82IopXJN9DAREVuuUCEEJ+eZaQzciEQcOHmkfHVVulI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCihhfzr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743713078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Y9MBgTDLbQ/2p3ToDYrW2wJ+A96DDpYuEBaZvNIJ+Q=;
	b=RCihhfzrburm099hUwYSQBrB24Fv5iFFWzjEOrYPFZem1KUpgi7rwV9Ll0utHAw6SQi/hD
	IuffgQzZjdxBNBw9fK6ow/pCpXg9uyOeklWCrUi58GxUf9wXFIiaOMmYK9Rj4qysrDqNK0
	UE2K/zJ/6HgJI7cg+teByG9A3lgaPmI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-lzQHq-N3M1eiFYdO9PK86g-1; Thu, 03 Apr 2025 16:44:37 -0400
X-MC-Unique: lzQHq-N3M1eiFYdO9PK86g-1
X-Mimecast-MFC-AGG-ID: lzQHq-N3M1eiFYdO9PK86g_1743713076
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39c2da64df9so1010370f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 13:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743713076; x=1744317876;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Y9MBgTDLbQ/2p3ToDYrW2wJ+A96DDpYuEBaZvNIJ+Q=;
        b=gdf3uWmZnWc653+AsTeyEi6lvuPDlJ4LVbQ7IfnZnLVPoLVaeutf6QqpwK6S5NoSre
         9L7JhPJgaDcKWzqEkyNBhpFj/IjnYdfoqqeU9G/bI31YST08vuh3zEfJueVT6WoBxGpN
         IO9AFcbHJOZ9SIi1KZQ/eGHShMuktErLIbT/1AFZT2oTnneJPHWBjzev3mjWyT6Wb294
         Fon03d6cn2oslJAoAgtau3sgSbqIvBqSTcWB4rSs5mCDi1yShCCRlJxpEEgiQFSwb7aO
         hkzRRjTRvJ7LaJfJmRbis100FYkJ0pVVieWG6URrvpTRfQI7yQTM/6x4iWfbk3EtkKdp
         vRgA==
X-Forwarded-Encrypted: i=1; AJvYcCXxw/Lqd+YpgcK0PJHjnylB6ZgNWBGSgrjc5ktjkHdgv9ZSWTD/0rZjXXqw2N83Hk0Y4BJv0y3eUgoRYYPr@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzuvKGqDKo6mbLPixfAGzDUB7kykF0UeoWyq0ajjgIiAcPa7M
	j6KdsVJvHOSJX5BjCosanwp3twuSzGd0UF7lRtH3vuFXPY3jFdBCLZPS/cLOBQkTMfjxjuYRBhC
	kDLvllcCdj1rmLITI2UFeOfVqV0AwnassB9b6J8q0Vac5mhGt9FVRyJgwojQ7SWk=
X-Gm-Gg: ASbGncv3AGLZfFWDV+ITwGe8izbpEodERP+jBl03QFcJ0aBFtJQ8gVKZR8pmFoIKTl1
	sc4ebQZ88Vb4G6gYnDy5wRaGfK6osK22eP8ddQjYxMy5b+AZyLndGeySekOvWhIOiNxgkAr7R2M
	M4kDCzxmKPFTLxhi8T+ORbe3wj9C0gAzfv75s91PlRYSVvzVYPxjpPyP2mOCeKHFfg2xfHrYj1Q
	zy5NREOnZ89cOYfCbEJQ12XUj7XAT4xRhnJubXt0cLj4mQLuBQ0wvh7PYR6mvyLVCdJUkx83hRd
	QUwwq0OykxtZmx/jEgliXSen+s1prVxqMUhK4cEcDkFaoSW2Rsx1vkE8p5G2X9ZtcJPoaF8bI3U
	t8H945XzEX4wHxvous5YKCoFGTmFiPRWjPP3uh9NkzOE=
X-Received: by 2002:a05:6000:4312:b0:390:e9e0:5cb3 with SMTP id ffacd0b85a97d-39cb36b2a91mr554697f8f.12.1743713075988;
        Thu, 03 Apr 2025 13:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcpbwz8aWSj3cfnOxw0o3ybTgPdOxG2pUb5Nd+u+WSXD0JmQrC8lp6Zs5p7/wGoJOQtmZ0vg==
X-Received: by 2002:a05:6000:4312:b0:390:e9e0:5cb3 with SMTP id ffacd0b85a97d-39cb36b2a91mr554677f8f.12.1743713075535;
        Thu, 03 Apr 2025 13:44:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:7b00:54a7:eb96:63bc:ccf4? (p200300cbc70a7b0054a7eb9663bcccf4.dip0.t-ipconnect.de. [2003:cb:c70a:7b00:54a7:eb96:63bc:ccf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096896sm2727202f8f.19.2025.04.03.13.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 13:44:34 -0700 (PDT)
Message-ID: <075209ac-c659-485e-a220-83d4afed8a94@redhat.com>
Date: Thu, 3 Apr 2025 22:44:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <CAJnrk1aXOJ-dAUdSmP07ZP6NPBJrdjPPJeaGbBULZfY=tBdn=Q@mail.gmail.com>
 <1036199a-3145-464b-8bbb-13726be86f46@linux.alibaba.com>
 <1577c4be-c6ee-4bc6-bb9c-d0a6d553b156@redhat.com>
 <CAJnrk1a7DAijj09VQxJ1rjppgh=FMCm30cN_=wQijrz4B4nUtQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJnrk1a7DAijj09VQxJ1rjppgh=FMCm30cN_=wQijrz4B4nUtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.04.25 21:09, Joanne Koong wrote:
> On Thu, Apr 3, 2025 at 2:18 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 03.04.25 05:31, Jingbo Xu wrote:
>>>
>>>
>>> On 4/3/25 5:34 AM, Joanne Koong wrote:
>>>> On Thu, Dec 19, 2024 at 5:05 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>>>>> writeback may take an indeterminate amount of time to complete, and
>>>>>> waits may get stuck.
>>>>>>
>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>> ---
>>>>>>     mm/migrate.c | 5 ++++-
>>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>> index df91248755e4..fe73284e5246 100644
>>>>>> --- a/mm/migrate.c
>>>>>> +++ b/mm/migrate.c
>>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>>                  */
>>>>>>                 switch (mode) {
>>>>>>                 case MIGRATE_SYNC:
>>>>>> -                     break;
>>>>>> +                     if (!src->mapping ||
>>>>>> +                         !mapping_writeback_indeterminate(src->mapping))
>>>>>> +                             break;
>>>>>> +                     fallthrough;
>>>>>>                 default:
>>>>>>                         rc = -EBUSY;
>>>>>>                         goto out;
>>>>>
>>>>> Ehm, doesn't this mean that any fuse user can essentially completely
>>>>> block CMA allocations, memory compaction, memory hotunplug, memory
>>>>> poisoning... ?!
>>>>>
>>>>> That sounds very bad.
>>>>
>>>> I took a closer look at the migration code and the FUSE code. In the
>>>> migration code in migrate_folio_unmap(), I see that any MIGATE_SYNC
>>>> mode folio lock holds will block migration until that folio is
>>>> unlocked. This is the snippet in migrate_folio_unmap() I'm looking at:
>>>>
>>>>           if (!folio_trylock(src)) {
>>>>                   if (mode == MIGRATE_ASYNC)
>>>>                           goto out;
>>>>
>>>>                   if (current->flags & PF_MEMALLOC)
>>>>                           goto out;
>>>>
>>>>                   if (mode == MIGRATE_SYNC_LIGHT && !folio_test_uptodate(src))
>>>>                           goto out;
>>>>
>>>>                   folio_lock(src);
>>>>           }
>>>>
>>
>> Right, I raised that also in my LSF/MM talk: waiting for readahead
>> currently implies waiting for the folio lock (there is no separate
>> readahead flag like there would be for writeback).
>>
>> The more I look into this and fuse, the more I realize that what fuse
>> does is just completely broken right now.
>>
>>>> If this is all that is needed for a malicious FUSE server to block
>>>> migration, then it makes no difference if AS_WRITEBACK_INDETERMINATE
>>>> mappings are skipped in migration. A malicious server has easier and
>>>> more powerful ways of blocking migration in FUSE than trying to do it
>>>> through writeback. For a malicious fuse server, we in fact wouldn't
>>>> even get far enough to hit writeback - a write triggers
>>>> aops->write_begin() and a malicious server would deliberately hang
>>>> forever while the folio is locked in write_begin().
>>>
>>> Indeed it seems possible.  A malicious FUSE server may already be
>>> capable of blocking the synchronous migration in this way.
>>
>> Yes, I think the conclusion is that we should advise people from not
>> using unprivileged FUSE if they care about any features that rely on
>> page migration or page reclaim.
>>
>>>
>>>
>>>>
>>>> I looked into whether we could eradicate all the places in FUSE where
>>>> we may hold the folio lock for an indeterminate amount of time,
>>>> because if that is possible, then we should not add this writeback way
>>>> for a malicious fuse server to affect migration. But I don't think we
>>>> can, for example taking one case, the folio lock needs to be held as
>>>> we read in the folio from the server when servicing page faults, else
>>>> the page cache would contain stale data if there was a concurrent
>>>> write that happened just before, which would lead to data corruption
>>>> in the filesystem. Imo, we need a more encompassing solution for all
>>>> these cases if we're serious about preventing FUSE from blocking
>>>> migration, which probably looks like a globally enforced default
>>>> timeout of some sort or an mm solution for mitigating the blast radius
>>>> of how much memory can be blocked from migration, but that is outside
>>>> the scope of this patchset and is its own standalone topic.
>>
>> I'm still skeptical about timeouts: we can only get it wrong.
>>
>> I think a proper solution is making these pages movable, which does seem
>> feasible if (a) splice is not involved and (b) we can find a way to not
>> hold the folio lock forever e.g., in the readahead case.
>>
>> Maybe readahead would have to be handled more similar to writeback
>> (e.g., having a separate flag, or using a combination of e.g.,
>> writeback+uptodate flag, not sure)
>>
>> In both cases (readahead+writeback), we'd want to call into the FS to
>> migrate a folio that is under readahread/writeback. In case of fuse
>> without splice, a migration might be doable, and as discussed, splice
>> might just be avoided.
>>
>>>>
>>>> I don't see how this patch has any additional negative impact on
>>>> memory migration for the case of malicious servers that the server
>>>> can't already (and more easily) do. In fact, this patchset if anything
>>>> helps memory given that malicious servers now can't also trigger page
>>>> allocations for temp pages that would never get freed.
>>>>
>>>
>>> If that's true, maybe we could drop this patch out of this patchset? So
>>> that both before and after this patchset, synchronous migration could be
>>> blocked by a malicious FUSE server, while the usability of continuous
>>> memory (CMA) won't be affected.
>>
>> I had exactly the same thought: if we can block forever on the folio
>> lock, there is no need for AS_WRITEBACK_INDETERMINATE. It's already all
>> completely broken.
> 
> I will resubmit this patchset and drop this patch.
> 
> I think we still need AS_WRITEBACK_INDETERMINATE for sync and legacy
> cgroupv1 reclaim scenarios:
> a) sync: sync waits on writeback so if we don't skip waiting on
> writeback for AS_WRITEBACK_INDETERMINATE mappings, then malicious fuse
> servers could make syncs hang. (There's no actual effect on sync
> behavior though with temp pages because even without temp pages, we
> return even though the data hasn't actually been synced to disk by the
> server yet)

Just curious: Are we sure there are no other cases where a malicious 
userspace could make some other folio_lock() hang forever either way?

IOW, just like for migration, isn't this just solving one part of the 
whole problem we are facing?

> 
> b) cgroupv1 reclaim: a correctly written fuse server can fall into
> this deadlock in one very specific scenario (eg  if it's using legacy
> cgroupv1 and reclaim encounters a folio that already has the reclaim
> flag set and the caller didn't have __GFP_FS (or __GFP_IO if swap)
> set), where the deadlock is triggered by:
> * single-threaded FUSE server is in the middle of handling a request
> that needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback
> * the FUSE server can't write back the folio since it's stuck in direct reclaim

Yes, that sounds reasonable.

-- 
Cheers,

David / dhildenb


