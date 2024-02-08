Return-Path: <linux-fsdevel+bounces-10830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A284E92F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC861C235A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8299338393;
	Thu,  8 Feb 2024 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHFRsg6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC6D37711;
	Thu,  8 Feb 2024 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422110; cv=none; b=Gy8Cy24bRqg8NleDnrFkX4UXYDLxNRcUqTzzl1gS6hvzXcxgaqY0uxD0OrZUhV5Yvj7C6eNg/HHo1WNvGRSzLX70QnIEIbwkX5fQlUTq4qvICYKQKm2vW8yoUsXprm8Ay9ZyUOS+y6JLgWyxjnFWTzFmO9hnN0j7xpfGA1TbEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422110; c=relaxed/simple;
	bh=lOfJwpXUdnEs4NdD2l4UxOLwSgcIGRsZp7hL7KAWBwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEKbI34yHN4R2eSAXGVCN+35wrxOf5XMT8u3xJZEOe9d15i4MlMX2wqP/CGmpqF9wvLUZu7BgtwNCJBJWbcfrhAPpvQqA7bCkPLDJpTb8c7nloE6/hxXetrOQcJI3xWBudJ50m6ahNjjXSh9/mUfmb3mZ30maymzTIQyViu2kYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHFRsg6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C640C433F1;
	Thu,  8 Feb 2024 19:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707422110;
	bh=lOfJwpXUdnEs4NdD2l4UxOLwSgcIGRsZp7hL7KAWBwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHFRsg6WccEchUFyrMTDbpsND8UtEeB7G2dQt7WSwW8EOSdvsfxtiFUpL1Bdc8Bek
	 mh+UH3E7pdkOXekpzAzB2Pte0DAjqeQI7oJCq5r591oq0M4sd/i3vPYbBzncVnNDqg
	 VdQaxpWDwOL96HRfsQNAt52NDO1G0JOuNMlGofKNd9hhSd8oBzVG7s6bJ8A8fR5LBJ
	 yysBINVtEdH6Xnc0eqoSx/ALVkQLvXDJRAk7TG96ukqW5tcoESko0YM4DQ9pryNltg
	 B7qluL+vCL/+79c0MwGCki1auhtFUIYmiLQZ3ztfxrpEONfxrA79RQpZ5zr/curMdQ
	 h/meCLWH4APjQ==
Message-ID: <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
Date: Thu, 8 Feb 2024 20:55:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 Kent Overstreet <kent.overstreet@gmail.com>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
 <ZcUQfzfQ9R8X0s47@tiehlicka>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ZcUQfzfQ9R8X0s47@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 18:33, Michal Hocko wrote:
> On Thu 08-02-24 17:02:07, Vlastimil Babka (SUSE) wrote:
>> On 1/9/24 05:47, Dave Chinner wrote:
>> > On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
>> 
>> Your points and Kent's proposal of scoped GFP_NOWAIT [1] suggests to me this
>> is no longer FS-only topic as this isn't just about converting to the scoped
>> apis, but also how they should be improved.
> 
> Scoped GFP_NOFAIL context is slightly easier from the semantic POV than
> scoped GFP_NOWAIT as it doesn't add a potentially unexpected failure
> mode. It is still tricky to deal with GFP_NOWAIT requests inside the
> NOFAIL scope because that makes it a non failing busy wait for an
> allocation if we need to insist on scope NOFAIL semantic. 
> 
> On the other hand we can define the behavior similar to what you
> propose with RETRY_MAYFAIL resp. NORETRY. Existing NOWAIT users should
> better handle allocation failures regardless of the external allocation
> scope.
> 
> Overriding that scoped NOFAIL semantic with RETRY_MAYFAIL or NORETRY
> resembles the existing PF_MEMALLOC and GFP_NOMEMALLOC semantic and I do
> not see an immediate problem with that.
> 
> Having more NOFAIL allocations is not great but if you need to
> emulate those by implementing the nofail semantic outside of the
> allocator then it is better to have those retries inside the allocator
> IMO.

I see potential issues in scoping both the NOWAIT and NOFAIL

- NOFAIL - I'm assuming Dave is adding __GFP_NOFAIL to xfs allocations or
adjacent layers where he knows they must not fail for his transaction. But
could the scope affect also something else underneath that could fail
without the failure propagating in a way that it affects xfs? Maybe it's a
high-order allocation with a low-order fallback that really should not be
__GFP_NOFAIL? We would need to hope it has something like RETRY_MAYFAIL or
NORETRY already. But maybe it just relies on >costly order being more likely
to fail implicitly, and those costly orders should be kept excluded from the
scoped NOFAIL? Maybe __GFP_NOWARN should also override the scoped nofail?

- NOWAIT - as said already, we need to make sure we're not turning an
allocation that relied on too-small-to-fail into a null pointer exception or
BUG_ON(!page). It's probably not feasible to audit everything that can be
called underneath when adding a new scoped NOWAIT. Static analysis probably
won't be powerful enough as well. Kent suggested fault injection [1]. We
have the framework for a system-wide one but I don't know if anyone is
running it and how successful it is. But maybe we could have a special fault
injection mode (CONFIG_ option or something) for the NOWAIT scoped
allocations only. If everything works as expected, there are no crashes and
the pattern Kent described in [1] has a fallback that's slower but still
functional. If not, we get a report and known which place to fix, and the
testing only focuses on the relevant parts. When a new scoped NOWAIT is
added and bots/CIs running this fault injection config report no issues, we
can be reasonably sure it's fine?

[1]
https://lore.kernel.org/all/zup5yilebkgkrypis4g6zkbft7pywqi57k5aztoio2ufi5ujsd@mfnqu4rarort/

>> [1] http://lkml.kernel.org/r/Zbu_yyChbCO6b2Lj@tiehlicka
>> 
>> > We already have memalloc_noreclaim_{save/restore}() for turning off
>> > direct memory reclaim for a given context (i.e. equivalent of
>> > clearing __GFP_DIRECT_RECLAIM), so if we are going to embrace scoped
>> > allocation contexts, then we should be going all in and providing
>> > all the contexts that filesystems actually need....
>> > 
>> > -Dave.
> 


