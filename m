Return-Path: <linux-fsdevel+bounces-45591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB9A79A71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 05:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780A91721B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 03:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B423178372;
	Thu,  3 Apr 2025 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tvekliCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFE54F81
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743651129; cv=none; b=QA6ZNQEdx1VZA2lkRpS1olxmCKWaykN0vamBXhy6xMkQ3puTzdMUoZBU4DVCJQHHGtX9EmrrBbNoC784MNsuEWSi/t5Y6UmK+HrSRFEwJSxScV55X+M/MGf4U2AfO7LxsggF/F93yEQZR+CREJRP5fh/B+3KNkFkyU0b9btuK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743651129; c=relaxed/simple;
	bh=JwsE8VrZU0kcvl3BlQUge0q6kvrDHCU000Av6sTY14Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BUNugoa77QamgzeCRM4rRYEb7/F1dtWq5XFXfMbD4ikBd9+gtD5f2diOBqDYNBly+QxUsqqm+nhPy6zDJSoYtJrvMI8U5y6MM1+3H9F2hh8jncHq2n4aU6LyoSWCfUzYBdN2JvBpZQNSfMzA197KriZhISJR7rfVPatxtho3LEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tvekliCN; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743651122; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=4HRLqzOVDnJA3M8Jj1I2PRudQxaI3/HlAG7E5faBSZE=;
	b=tvekliCNxw2VMYb63/PkAT6Wtz9b7hG1MiaH67QSft2F8X2T1TgbQsezQFLvWBiYsXmo1Te16yw41ruazRS6XsHyGNtY330oFuh5qgPKexlJk2gLzL2LZ32ruaf5Up27t7A97Be0YBuAABzAQ2mY1LwVLnt/JOGNwzH2/9+clg0=
Received: from 30.221.145.143(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WUYlogQ_1743651120 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Apr 2025 11:32:01 +0800
Message-ID: <1036199a-3145-464b-8bbb-13726be86f46@linux.alibaba.com>
Date: Thu, 3 Apr 2025 11:31:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>,
 David Hildenbrand <david@redhat.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <CAJnrk1aXOJ-dAUdSmP07ZP6NPBJrdjPPJeaGbBULZfY=tBdn=Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJnrk1aXOJ-dAUdSmP07ZP6NPBJrdjPPJeaGbBULZfY=tBdn=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/3/25 5:34 AM, Joanne Koong wrote:
> On Thu, Dec 19, 2024 at 5:05 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 23.11.24 00:23, Joanne Koong wrote:
>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>> writeback may take an indeterminate amount of time to complete, and
>>> waits may get stuck.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>> ---
>>>   mm/migrate.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index df91248755e4..fe73284e5246 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>                */
>>>               switch (mode) {
>>>               case MIGRATE_SYNC:
>>> -                     break;
>>> +                     if (!src->mapping ||
>>> +                         !mapping_writeback_indeterminate(src->mapping))
>>> +                             break;
>>> +                     fallthrough;
>>>               default:
>>>                       rc = -EBUSY;
>>>                       goto out;
>>
>> Ehm, doesn't this mean that any fuse user can essentially completely
>> block CMA allocations, memory compaction, memory hotunplug, memory
>> poisoning... ?!
>>
>> That sounds very bad.
> 
> I took a closer look at the migration code and the FUSE code. In the
> migration code in migrate_folio_unmap(), I see that any MIGATE_SYNC
> mode folio lock holds will block migration until that folio is
> unlocked. This is the snippet in migrate_folio_unmap() I'm looking at:
> 
>         if (!folio_trylock(src)) {
>                 if (mode == MIGRATE_ASYNC)
>                         goto out;
> 
>                 if (current->flags & PF_MEMALLOC)
>                         goto out;
> 
>                 if (mode == MIGRATE_SYNC_LIGHT && !folio_test_uptodate(src))
>                         goto out;
> 
>                 folio_lock(src);
>         }
> 
> If this is all that is needed for a malicious FUSE server to block
> migration, then it makes no difference if AS_WRITEBACK_INDETERMINATE
> mappings are skipped in migration. A malicious server has easier and
> more powerful ways of blocking migration in FUSE than trying to do it
> through writeback. For a malicious fuse server, we in fact wouldn't
> even get far enough to hit writeback - a write triggers
> aops->write_begin() and a malicious server would deliberately hang
> forever while the folio is locked in write_begin().

Indeed it seems possible.  A malicious FUSE server may already be
capable of blocking the synchronous migration in this way.


> 
> I looked into whether we could eradicate all the places in FUSE where
> we may hold the folio lock for an indeterminate amount of time,
> because if that is possible, then we should not add this writeback way
> for a malicious fuse server to affect migration. But I don't think we
> can, for example taking one case, the folio lock needs to be held as
> we read in the folio from the server when servicing page faults, else
> the page cache would contain stale data if there was a concurrent
> write that happened just before, which would lead to data corruption
> in the filesystem. Imo, we need a more encompassing solution for all
> these cases if we're serious about preventing FUSE from blocking
> migration, which probably looks like a globally enforced default
> timeout of some sort or an mm solution for mitigating the blast radius
> of how much memory can be blocked from migration, but that is outside
> the scope of this patchset and is its own standalone topic.
> 
> I don't see how this patch has any additional negative impact on
> memory migration for the case of malicious servers that the server
> can't already (and more easily) do. In fact, this patchset if anything
> helps memory given that malicious servers now can't also trigger page
> allocations for temp pages that would never get freed.
> 

If that's true, maybe we could drop this patch out of this patchset? So
that both before and after this patchset, synchronous migration could be
blocked by a malicious FUSE server, while the usability of continuous
memory (CMA) won't be affected.

-- 
Thanks,
Jingbo

