Return-Path: <linux-fsdevel+bounces-45619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64107A79FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214B83B16FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187F242923;
	Thu,  3 Apr 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="LQA3I0f/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uMDLej1U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C11F12F1
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672326; cv=none; b=Z7U2NY6IHCCVFlRU5tRFkgO7WNtYXInjpXM7d3V9dqFJWvaxQRyy24IKJMZm2Udn3kWvCJ7i0b43AFZcKVthFWfa7Hflzphxftq+iNySJr3HbNYQlI0tgdFHDRGN3xomMQafRhdrxUClB1HorJ7Ho8B5Is0FFWd9zGXHwOdjyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672326; c=relaxed/simple;
	bh=N29983bZMqppYv2sqeAF/D0SQpg7MT2z/+Nl9tDw590=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMjXvX1LN/ZjdWg8GFSUgIHWAPYQsXpcI9/giJlHiPP2P653VgUrQrrY3LcJ3eomHq93FltHLzKVPIzRO8dcnsub+krmVNB77p0GpeBRmrgcpAlq/TM8fqcqevFGizyBs4qTPkHmdmP3bl5BA71FNBdmQvMEflktDcQB28l+VX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=LQA3I0f/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uMDLej1U; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F0F61140233;
	Thu,  3 Apr 2025 05:25:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 03 Apr 2025 05:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743672321;
	 x=1743758721; bh=0grwJN9pQJNLiQHb/gAsQcKM+5IlBV3uvLNe2gjHODQ=; b=
	LQA3I0f//SDOx/8VpBYt1BYRgS6zxjyIjPleI56iYj5mOh0qDYWBo+Xh5GW3Wlf8
	eYl0obd7nXgJbeXaqVMrZumMcEN3g8m+42wSmw8xbV3Pp1FNltw3o3gCfNsGulhp
	hMv1zXqwjbn3TMUrczw5LmkzjRPqBiT/NDvXVF16XrjmS1wnkYkLYsZJ2ad0wgz2
	iXI6VkZkSxKpVEXGmwSKxMLgR0pIvi7EAuzHq9MVyLpUorWe1hWoskiumnwXgkNn
	d0dYHGPanEE6U1plzJwmXAwm8/+7EhbR+sMimIlI+OGAdIhc9/TNfDnV5gptbqub
	1YxfDgCEl8ogJftWHUuG/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743672321; x=
	1743758721; bh=0grwJN9pQJNLiQHb/gAsQcKM+5IlBV3uvLNe2gjHODQ=; b=u
	MDLej1UzLaWUvPI8FWSRqmxZyql00yoLtp6y95Mp4/SAzyUDEgB7qnZI1Wv2MvTS
	dxbp0ubWuw5XvccRr4fzx86qE/iIPagSGzDYJUoZuz1aoYOONhY+C0COL68BWxEg
	XmLC6iWmE+SxdZ0kCTG0MVGzAdBSSPkRwKoyFyBK3QJQmVEoz2PV/Hucfckz0sNV
	cgFZRjmn7f9IE8QyRmvS9arC5rwrJlVfBOFVnSdHA6iAsMs/OJN0gW7zhYJSuIit
	DH2jlBKsO0vM0egRTWTAaa+at5RhPB0j8Dw9cNxnVREr/KGn4gkywF6ZOMOXysb6
	ypVFmNa0nOJHvmsN60M+g==
X-ME-Sender: <xms:AFTuZ-VsIM3scY3hHTtJ_zzUtPS4ybExNQcJ-6hdK0HnIlzs52Eh1Q>
    <xme:AFTuZ6k3trlCtA5CwUxdgCuiwcxakci8IbFHfjqqvdmIZUPvZqAxVOP9GYlzofmfD
    ZwN5kU8l_JZSfZt>
X-ME-Received: <xmr:AFTuZybhw51qpUFWOp-0SSP2Az_900xTmpR0m9S1k8MglHiIAZqSNWlbXyqTaxKjz9SLhmxLffbUy30WuGk0b3LEuB9F9Js3VXOGWXBnSIDxNP-__GpR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudev
    udevleegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoh
    epjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhl
    ohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhrghkvggvlhdrsghuthht
    sehlihhnuhigrdguvghvpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthht
    ohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:AFTuZ1VtmvDrMsEr4PA1wvFzN59JQndUVJLfbHpiHh96cMvpIQkV1A>
    <xmx:AFTuZ4mvmuwuj44S5wPUH-9AhZihc53EPMQMzyTEQ0O-JAMMhFJ2gg>
    <xmx:AFTuZ6dvxNhlRgZqZ3dU3s1tf4b6pODAaZmOR5LTXbLyVk5q9OutmQ>
    <xmx:AFTuZ6ElhfqvX5ljVBj4KrgPYqeY4YO7zE7W9uu8bPN8D3gLa0m5hw>
    <xmx:AVTuZ2heBpM6pf54VIFzisqMwMzopVeDs-rirWs98Nz8NWKFxOiYNOAs>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 05:25:18 -0400 (EDT)
Message-ID: <cb6a5eb4-582b-42ba-a4b8-7ecaccbf5ba2@fastmail.fm>
Date: Thu, 3 Apr 2025 11:25:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>,
 Keith Busch <kbusch@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <CAJnrk1aXOJ-dAUdSmP07ZP6NPBJrdjPPJeaGbBULZfY=tBdn=Q@mail.gmail.com>
 <1036199a-3145-464b-8bbb-13726be86f46@linux.alibaba.com>
 <1577c4be-c6ee-4bc6-bb9c-d0a6d553b156@redhat.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <1577c4be-c6ee-4bc6-bb9c-d0a6d553b156@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/3/25 11:18, David Hildenbrand wrote:
> On 03.04.25 05:31, Jingbo Xu wrote:
>>
>>
>> On 4/3/25 5:34 AM, Joanne Koong wrote:
>>> On Thu, Dec 19, 2024 at 5:05 AM David Hildenbrand <david@redhat.com>
>>> wrote:
>>>>
>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the
>>>>> folio if
>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag
>>>>> set on its
>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the
>>>>> mapping, the
>>>>> writeback may take an indeterminate amount of time to complete, and
>>>>> waits may get stuck.
>>>>>
>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>> ---
>>>>>    mm/migrate.c | 5 ++++-
>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>> index df91248755e4..fe73284e5246 100644
>>>>> --- a/mm/migrate.c
>>>>> +++ b/mm/migrate.c
>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t
>>>>> get_new_folio,
>>>>>                 */
>>>>>                switch (mode) {
>>>>>                case MIGRATE_SYNC:
>>>>> -                     break;
>>>>> +                     if (!src->mapping ||
>>>>> +                         !mapping_writeback_indeterminate(src-
>>>>> >mapping))
>>>>> +                             break;
>>>>> +                     fallthrough;
>>>>>                default:
>>>>>                        rc = -EBUSY;
>>>>>                        goto out;
>>>>
>>>> Ehm, doesn't this mean that any fuse user can essentially completely
>>>> block CMA allocations, memory compaction, memory hotunplug, memory
>>>> poisoning... ?!
>>>>
>>>> That sounds very bad.
>>>
>>> I took a closer look at the migration code and the FUSE code. In the
>>> migration code in migrate_folio_unmap(), I see that any MIGATE_SYNC
>>> mode folio lock holds will block migration until that folio is
>>> unlocked. This is the snippet in migrate_folio_unmap() I'm looking at:
>>>
>>>          if (!folio_trylock(src)) {
>>>                  if (mode == MIGRATE_ASYNC)
>>>                          goto out;
>>>
>>>                  if (current->flags & PF_MEMALLOC)
>>>                          goto out;
>>>
>>>                  if (mode == MIGRATE_SYNC_LIGHT && !
>>> folio_test_uptodate(src))
>>>                          goto out;
>>>
>>>                  folio_lock(src);
>>>          }
>>>
> 
> Right, I raised that also in my LSF/MM talk: waiting for readahead
> currently implies waiting for the folio lock (there is no separate
> readahead flag like there would be for writeback).
> 
> The more I look into this and fuse, the more I realize that what fuse
> does is just completely broken right now.
> 
>>> If this is all that is needed for a malicious FUSE server to block
>>> migration, then it makes no difference if AS_WRITEBACK_INDETERMINATE
>>> mappings are skipped in migration. A malicious server has easier and
>>> more powerful ways of blocking migration in FUSE than trying to do it
>>> through writeback. For a malicious fuse server, we in fact wouldn't
>>> even get far enough to hit writeback - a write triggers
>>> aops->write_begin() and a malicious server would deliberately hang
>>> forever while the folio is locked in write_begin().
>>
>> Indeed it seems possible.  A malicious FUSE server may already be
>> capable of blocking the synchronous migration in this way.
> 
> Yes, I think the conclusion is that we should advise people from not
> using unprivileged FUSE if they care about any features that rely on
> page migration or page reclaim.
> 
>>
>>
>>>
>>> I looked into whether we could eradicate all the places in FUSE where
>>> we may hold the folio lock for an indeterminate amount of time,
>>> because if that is possible, then we should not add this writeback way
>>> for a malicious fuse server to affect migration. But I don't think we
>>> can, for example taking one case, the folio lock needs to be held as
>>> we read in the folio from the server when servicing page faults, else
>>> the page cache would contain stale data if there was a concurrent
>>> write that happened just before, which would lead to data corruption
>>> in the filesystem. Imo, we need a more encompassing solution for all
>>> these cases if we're serious about preventing FUSE from blocking
>>> migration, which probably looks like a globally enforced default
>>> timeout of some sort or an mm solution for mitigating the blast radius
>>> of how much memory can be blocked from migration, but that is outside
>>> the scope of this patchset and is its own standalone topic.
> 
> I'm still skeptical about timeouts: we can only get it wrong.
> 
> I think a proper solution is making these pages movable, which does seem
> feasible if (a) splice is not involved and (b) we can find a way to not
> hold the folio lock forever e.g., in the readahead case.
> 
> Maybe readahead would have to be handled more similar to writeback
> (e.g., having a separate flag, or using a combination of e.g.,
> writeback+uptodate flag, not sure)
> 
> In both cases (readahead+writeback), we'd want to call into the FS to
> migrate a folio that is under readahread/writeback. In case of fuse
> without splice, a migration might be doable, and as discussed, splice
> might just be avoided.

My personal take is here that we should move away from splice.
Keith (or colleague) is working on ZC with io-uring anyway, so
maybe a good timing. We should just ensure that the new approach
doesn't have the same issue.

Thanks,
Bernd

