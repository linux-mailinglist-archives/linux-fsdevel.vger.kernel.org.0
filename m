Return-Path: <linux-fsdevel+bounces-23910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F07934AC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 11:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C725F1F21D95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDE38175F;
	Thu, 18 Jul 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzdAj7PB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4863399B;
	Thu, 18 Jul 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294391; cv=none; b=VOASWuwIVwVj/oCrmOy9xEaZEjJz2HocaWmetitjXcH6w2CQKiz0AoD8ewst/Mkf82AQK/NAj/y1avNP7+ab1M6wNw1xW6S/mp4WRg2uKYmoifGvynGWmYNqArIiLmHu3hAFroQsTjJHuVDF323hszEjiXoQjSI+jKpKQwfI0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294391; c=relaxed/simple;
	bh=JHPP4Mp0x8FuvmMJ+shD192GYO/rYQu/8eEDu1L9I1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJb0GzNPIpSWuM6UdlU2ObCK9dZZCKvoZfbgn3i7tjprVRtmJJikEmaQjTcWZ135aubx3/tptMzAnbWkq2JepE/vIAOvMgZuyuXPV0QaUtegQdxVUcETBHWugZmTcRyNhH6mNEyprtRKOCQjSEwfdCW5GdE6pqwWdH6Thjp3ylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzdAj7PB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71E6C116B1;
	Thu, 18 Jul 2024 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721294391;
	bh=JHPP4Mp0x8FuvmMJ+shD192GYO/rYQu/8eEDu1L9I1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LzdAj7PBpfaUWnjrKQvjbs5b6Ko64yKMlkZfPMpy3Kyk+27Tn8OtyokBYQmg3zA57
	 qEeaZi7kgRVZkFerLWxaQI1FI6TRaM+0WNx/v1wIKybd913OIhZmMSnM342TcCkRaT
	 bRwB/L3i4ymQKUsrjqks+1mkZbVW6dGkh4bAhcDae3PiKb/BnU/EBNI1tGMi6Jhqeb
	 waaGnaAgXsV4SJRURc7sRsPiYeJYHst8f3kjmCLT5w/rkpAFWrytjuwkFz/lgFqcU1
	 cUWSehAFjaAyzag9/ZiP6gkSNyWzi/U/pYe17ipi/YX8OusKZEA+Q+RBrLh8R9yNkU
	 1l8IytZxncCdA==
Message-ID: <6b193cd1-ee30-4fd8-a748-ed266fe4bc37@kernel.org>
Date: Thu, 18 Jul 2024 11:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Michal Hocko <mhocko@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Cgroups <cgroups@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka> <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <3cc3e652-e058-4995-8347-337ae605ebab@suse.com>
 <ea6cfaf6-bdb8-48a4-bf59-9f54f36b112e@kernel.org>
 <2b48a095-97e6-43bc-9f7c-13dd31ce00b8@suse.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <2b48a095-97e6-43bc-9f7c-13dd31ce00b8@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/24 10:50 AM, Qu Wenruo wrote:
> 
> 
> 在 2024/7/18 17:58, Vlastimil Babka (SUSE) 写道:
>> On 7/18/24 9:52 AM, Qu Wenruo wrote:
>>>
>>> The previous rc kernel. IIRC it's v6.10-rc6.
>>>
>>> But that needs extra btrfs patches, or btrfs are still only doing the
>>> order-0 allocation, then add the order-0 folio into the filemap.
>>>
>>> The extra patch just direct btrfs to allocate an order 2 folio (matching
>>> the default 16K nodesize), then attach the folio to the metadata filemap.
>>>
>>> With extra coding handling corner cases like different folio sizes etc.
>> 
>> Hm right, but the same code is triggered for high-order folios (at least for
>> user mappable page cache) today by some filesystems AFAIK, so we should be
>> seeing such lockups already? btrfs case might be special that it's for the
>> internal node as you explain, but that makes no difference for
>> filemap_add_folio(), right? Or is it the only user with GFP_NOFS? Also is
>> that passed as gfp directly or are there some extra scoped gfp resctrictions
>> involved? (memalloc_..._save()).
> 
> I'm not sure about other fses, but for that hang case, it's very 
> metadata heavy, and ALL folios for that btree inode filemap is in order 
> 2, since we're always allocating the order folios using GFP_NOFAIL, and 
> attaching that folio into the filemap using GFP_NOFAIL too.
> 
> Not sure if other fses can have such situation.

Doh right of course, the __GFP_NOFAIL is the special part compared to the
usual page cache usage.

> [...]
>>> If I understand it correctly, we have implemented release_folio()
>>> callback, which does the btrfs metadata checks to determine if we can
>>> release the current folio, and avoid releasing folios that's still under
>>> IO etc.
>> 
>> I see, thanks. Sounds like there might be potentially some suboptimal
>> handling in that the folio will appear inactive because there's no
>> references that folio_check_references() can detect, unless there's some
>> folio_mark_accessed() calls involved (I see some FGP_ACCESSED in btrfs so
>> maybe that's fine enough) so reclaim could consider it often, only to be
>> stopped by release_folio failing.
> 
> For the page accessed part, btrfs handles it by 
> mark_extent_buffer_accessed() call, and it's called every time we try to 
> grab an extent buffer structure (the structure used to represent a 
> metadata block inside btrfs).
> 
> So the accessed flag part should be fine I guess?

Sounds good then, thanks!

> Thanks,
> Qu
>> 
>>>>
>>>> (sorry if the questions seem noob, I'm not that much familiar with the page
>>>> cache side of mm)
>>>
>>> No worry at all, I'm also a newbie on the whole mm part.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>>> Thanks,
>>>>> Qu
>>>>
>> 


