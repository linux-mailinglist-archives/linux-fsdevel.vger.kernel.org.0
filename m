Return-Path: <linux-fsdevel+bounces-23905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D023E9349E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 10:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1361F21BBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA47CF3E;
	Thu, 18 Jul 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzt86/F8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A1762DF;
	Thu, 18 Jul 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291303; cv=none; b=mCQVzvaKCl9NqYCunfW9AZzZDGL47ukssrrBci8QsF67o2Ds5orFPOMoEyHHM6U7vaOz388iTFyVB3MIj+KARNr5jCcGRDj9PJdHNUmLGtSUaYGj9s5vWJlQ5qcgAlNZCpDjahStnzMleIk9kJXXg+fWbZHlzawSwj1rtdXQNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291303; c=relaxed/simple;
	bh=XCr6YKml31o80SiYtVd5tepSG/OazBj9Kki1ka47Nuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TP3it70CPvKMZzrm2y2UsHQo4TQuvNvxSia2m45jufpKXGl9+UiAgORwATR3j2o6lEQS9GIagEYHqoxgU6ZaF0+TTos3ixW2XJxWZ2luU/WMDY8vh+ZY/eT514d/oD5yFIsw8WghUZSqcKbTS2cJPMV/vUrQ1LwMFNZqY7JTt5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzt86/F8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A03FC116B1;
	Thu, 18 Jul 2024 08:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721291303;
	bh=XCr6YKml31o80SiYtVd5tepSG/OazBj9Kki1ka47Nuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gzt86/F8fKULKJdmHFw2hK0g+kmipGTPLXpBJA43KiNbPufwXd0qao+ETGJQTNGJ0
	 W4TvA75UliI1IjRfMbPRL1nfzHO9fmubra4oFpo8PcYlUg+STcEFAfT7ntbE5QbKvo
	 THNpYhwLRM3rTfsVjve4BleNDPnq5n2kvUiQ1L0jyCn184ofOy1UwIE1dtb746ekZm
	 duEvJ5+kIm4pf8DZe/3APEdAvqd3GvFhYXnnP8dmyJkfI9UOq8XVDsHvHRXn6TMEQh
	 UGu1A32FlmjSM0GqkkC928RP9lxCQEeePXvU9pnxDwUr0xEn1B3DmeWzyLxyCQP4TJ
	 qFXegb3zRbzhA==
Message-ID: <ea6cfaf6-bdb8-48a4-bf59-9f54f36b112e@kernel.org>
Date: Thu, 18 Jul 2024 10:28:18 +0200
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
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <3cc3e652-e058-4995-8347-337ae605ebab@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/24 9:52 AM, Qu Wenruo wrote:
> 
> 
> 在 2024/7/18 16:47, Vlastimil Babka (SUSE) 写道:
>> On 7/18/24 12:38 AM, Qu Wenruo wrote:
> [...]
>>> Another question is, I only see this hang with larger folio (order 2 vs
>>> the old order 0) when adding to the same address space.
>>>
>>> Does the folio order has anything related to the problem or just a
>>> higher order makes it more possible?
>> 
>> I didn't spot anything in the memcg charge path that would depend on the
>> order directly, hm. Also what kernel version was showing these soft lockups?
> 
> The previous rc kernel. IIRC it's v6.10-rc6.
> 
> But that needs extra btrfs patches, or btrfs are still only doing the 
> order-0 allocation, then add the order-0 folio into the filemap.
> 
> The extra patch just direct btrfs to allocate an order 2 folio (matching 
> the default 16K nodesize), then attach the folio to the metadata filemap.
> 
> With extra coding handling corner cases like different folio sizes etc.

Hm right, but the same code is triggered for high-order folios (at least for
user mappable page cache) today by some filesystems AFAIK, so we should be
seeing such lockups already? btrfs case might be special that it's for the
internal node as you explain, but that makes no difference for
filemap_add_folio(), right? Or is it the only user with GFP_NOFS? Also is
that passed as gfp directly or are there some extra scoped gfp resctrictions
involved? (memalloc_..._save()).

>> 
>>> And finally, even without the hang problem, does it make any sense to
>>> skip all the possible memcg charge completely, either to reduce latency
>>> or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
>> 
>> Is it common to even use the filemap code for such metadata that can't be
>> really mapped to userspace?
> 
> At least XFS/EXT4 doesn't use filemap to handle their metadata. One of 
> the reason is, btrfs has pretty large metadata structure.
> Not only for the regular filesystem things, but also data checksum.
> 
> Even using the default CRC32C algo, it's 4 bytes per 4K data.
> Thus things can go crazy pretty easily, and that's the reason why btrfs 
> is still sticking to the filemap solution.
> 
>> How does it even interact with reclaim, do they
>> become part of the page cache and are scanned by reclaim together with data
>> that is mapped?
> 
> Yes, it's handled just like all other filemaps, it's also using page 
> cache, and all the lru/scanning things.
> 
> The major difference is, we only implement a small subset of the address 
> operations:
> 
> - write
> - release
> - invalidate
> - migrate
> - dirty (debug only, otherwise falls back to filemap_dirty_folio())
> 
> Note there is no read operations, as it's btrfs itself triggering the 
> metadata read, thus there is no read/readahead.
> Thus we're in the full control of the page cache, e.g. determine the 
> folio size to be added into the filemap.
> 
> The filemap infrastructure provides 2 good functionalities:
> 
> - (Page) Cache
>    So that we can easily determine if we really need to read from the
>    disk, and this can save us a lot of random IOs.
> 
> - Reclaiming
> 
> And of course the page cache of the metadata inode won't be 
> cloned/shared to any user accessible inode.
> 
>> How are the lru decisions handled if there are no references
>> for PTE access bits. Or can they be even reclaimed, or because there may
>> e.g. other open inodes pinning this metadata, the reclaim is impossible?
> 
> If I understand it correctly, we have implemented release_folio() 
> callback, which does the btrfs metadata checks to determine if we can 
> release the current folio, and avoid releasing folios that's still under 
> IO etc.

I see, thanks. Sounds like there might be potentially some suboptimal
handling in that the folio will appear inactive because there's no
references that folio_check_references() can detect, unless there's some
folio_mark_accessed() calls involved (I see some FGP_ACCESSED in btrfs so
maybe that's fine enough) so reclaim could consider it often, only to be
stopped by release_folio failing.

>> 
>> (sorry if the questions seem noob, I'm not that much familiar with the page
>> cache side of mm)
> 
> No worry at all, I'm also a newbie on the whole mm part.
> 
> Thanks,
> Qu
> 
>> 
>>> Thanks,
>>> Qu
>> 


