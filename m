Return-Path: <linux-fsdevel+bounces-68922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686CC684FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 826A7342D3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535503009C7;
	Tue, 18 Nov 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwveRkhR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B103101BC;
	Tue, 18 Nov 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455905; cv=none; b=aFqyG99ZQHNhBUkvMUhzrnBpiIPvFN8edK4nnADvNpLsGd1Ap96s/i3wfrTJM2/7S+GNDa1UNwtbaVJiJrBbJfA0VjhdJhuIXB5Jps9z4AURFp5PXxTe09Gm7SMCXPYa2611fIyHdvPBPh1QB55JCJVvPsZL70owPJYNnkYw1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455905; c=relaxed/simple;
	bh=qvUA4igN+3L19DyfGE1idHMAssgfS6Bs6bYW7pr0XHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYEFtf1VlD/DRp56VeKowi4hJ780J4RYbzdYtfO71jtSavPqCzMjSbc78/TOj+oMiS0rVThRNqnLGgnag7Rjj6qBgqu+Nwe2iJ5uBunEttYbQICcJkd7cSzr3j40LBe7HBIGLakHVA8BptV3+XW94+2hb+J6b8MvoOA8j0MaD2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwveRkhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B775C2BCB3;
	Tue, 18 Nov 2025 08:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763455905;
	bh=qvUA4igN+3L19DyfGE1idHMAssgfS6Bs6bYW7pr0XHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IwveRkhRugwYpdfit9oT2x8PUOOCVrEXb0545F/qsp/2w4Z8PpQNCqP49Jo5KbUFD
	 plXuA7r0nSCTJxZdCV8FxqKQYl2sYBBBNUHXLNp8ixPMjXK67ca8ZXMO1u4rairRc3
	 cUTgW85RYCXI0MwMUJxOAsAOMHgCnXJh1JXQUERyVbFiUOOhLNpEwchHlavt0AdRQc
	 8fDaSxkhI5AdC9sA1u8+58UuIT0Ce+uFIr/YOTI0q982Tj7vVAim/ZVsOvr9tYrGcG
	 GcuKpx/gCEDUdIewKXNvNPbVawUqRjyltsq1vinrRty3tgnG8AdcES2vXyfVSmUaLx
	 LLxYTWBXADAMg==
Message-ID: <7f89c0cf-0601-4f61-a665-72364629681a@kernel.org>
Date: Tue, 18 Nov 2025 09:51:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Extend xas_split* to support splitting
 arbitrarily large entries
To: Ackerley Tng <ackerleytng@google.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, michael.roth@amd.com,
 vannapurve@google.com
References: <20251117224701.1279139-1-ackerleytng@google.com>
 <aRuuRGxw2vuXcVv6@casper.infradead.org> <diqztsysb4zc.fsf@google.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <diqztsysb4zc.fsf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.11.25 00:43, Ackerley Tng wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
>> On Mon, Nov 17, 2025 at 02:46:57PM -0800, Ackerley Tng wrote:
>>> guest_memfd is planning to store huge pages in the filemap, and
>>> guest_memfd's use of huge pages involves splitting of huge pages into
>>> individual pages. Splitting of huge pages also involves splitting of
>>> the filemap entries for the pages being split.
> 
>>
>> Hm, I'm not most concerned about the number of nodes you're allocating.
> 
> Thanks for reminding me, I left this out of the original message.
> 
> Splitting the xarray entry for a 1G folio (in a shift-18 node for
> order=18 on x86), assuming XA_CHUNK_SHIFT is 6, would involve
> 
> + shift-18 node (the original node will be reused - no new allocations)
> + shift-12 node: 1 node allocated
> + shift-6 node : 64 nodes allocated
> + shift-0 node : 64 * 64 = 4096 nodes allocated
> 
> This brings the total number of allocated nodes to 4161 nodes. struct
> xa_node is 576 bytes, so that's 2396736 bytes or 2.28 MB, so splitting a
> 1G folio to 4K pages costs ~2.5 MB just in filemap (XArray) entry
> splitting. The other large memory cost would be from undoing HVO for the
> HugeTLB folio.
> 
>> I'm most concerned that, once we have memdescs, splitting a 1GB page
>> into 512 * 512 4kB pages is going to involve allocating about 20MB
>> of memory (80 bytes * 512 * 512).
> 
> I definitely need to catch up on memdescs. What's the best place for me
> to learn/get an overview of how memdescs will describe memory/replace
> struct folios?
> 
> I think there might be a better way to solve the original problem of
> usage tracking with memdesc support, but this was intended to make
> progress before memdescs.
> 
>> Is this necessary to do all at once?
> 
> The plan for guest_memfd was to first split from 1G to 4K, then optimize
> on that by splitting in stages, from 1G to 2M as much as possible, then
> to 4K only for the page ranges that the guest shared with the host.

Right, we also discussed the non-uniform split as an optimization in the 
future.

-- 
Cheers

David

