Return-Path: <linux-fsdevel+bounces-10782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1361284E4A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45CD287001
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366437E116;
	Thu,  8 Feb 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obJpFnU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA687BAE7;
	Thu,  8 Feb 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408132; cv=none; b=tm73EUf2c7KKNmiiEjDpnJdgIbSkl3+4Ous3G0wxKuXobv7EWxUIZMuMufVf3BAYp6SbALHP9z0kzjkoyhyVAbYFI5fNV+818e6IXtQXyft18gKIo7IDh2ajSnDaeb4XeL8UM7s0dFO3CU7HAPDnnRRPOTaqcRV4UhaP5WPthWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408132; c=relaxed/simple;
	bh=uTFe5CG7oWonbpeVbz5UaAiaJEjR9X1sZYLpZSCrroE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpalCi3Iba9l+gDTQVQ3cBC1tUMXBk160Y1LAnXyH40zfhFpUWCpc8ji+oNx+4O1gknE2g4gk8wKste4qnzOATOhpTU/EgHMB1vf+nr0TU668cjzTKpKdUL9DdLen97lP2o8Dt4lFcKVJ/akmTIPH14w0C5G/V6D6u9exhV9VTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obJpFnU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC76CC433C7;
	Thu,  8 Feb 2024 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707408132;
	bh=uTFe5CG7oWonbpeVbz5UaAiaJEjR9X1sZYLpZSCrroE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=obJpFnU3wW/7vWnQ2T7KbJTN1o0DhsaGAsrrj2BVE8zioOEqxNl2MiXnaak9whqbt
	 OIDJi1LDw4Ob4TOyMXecgyYlB0ULe8cbKEYD18dH7iv2VOYpw90ipR40HRow6soWvg
	 DkCTi37Z6twlWFr7xB9SDcp4WUYNmxbMlDbECEGxFl+2eUYoaRKZIyH7IwHvpQ9BQu
	 nNUhloOm8p60q6R9WsjvEZT4tnO900WaEIv/prTxnu+YOB1xTOPKTTYP8o7TuhLlr2
	 Ljl07+/LdqTtHEHadWQ3k0UZK64B9xF+oq5GtFxTc70ZUxMclN84FsAWvnJLmt4GnN
	 Cj4n/P6UyVT+g==
Message-ID: <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
Date: Thu, 8 Feb 2024 17:02:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 Kent Overstreet <kent.overstreet@gmail.com>, Michal Hocko <mhocko@kernel.org>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ZZzP6731XwZQnz0o@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/24 05:47, Dave Chinner wrote:
> On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
>> This is primarily a _FILESYSTEM_ track topic.  All the work has already
>> been done on the MM side; the FS people need to do their part.  It could
>> be a joint session, but I'm not sure there's much for the MM people
>> to say.
>> 
>> There are situations where we need to allocate memory, but cannot call
>> into the filesystem to free memory.  Generally this is because we're
>> holding a lock or we've started a transaction, and attempting to write
>> out dirty folios to reclaim memory would result in a deadlock.
>> 
>> The old way to solve this problem is to specify GFP_NOFS when allocating
>> memory.  This conveys little information about what is being protected
>> against, and so it is hard to know when it might be safe to remove.
>> It's also a reflex -- many filesystem authors use GFP_NOFS by default
>> even when they could use GFP_KERNEL because there's no risk of deadlock.
>> 
>> The new way is to use the scoped APIs -- memalloc_nofs_save() and
>> memalloc_nofs_restore().  These should be called when we start a
>> transaction or take a lock that would cause a GFP_KERNEL allocation to
>> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
>> can see the nofs situation is in effect and will not call back into
>> the filesystem.
> 
> So in rebasing the XFS kmem.[ch] removal patchset I've been working
> on, there is a clear memory allocator function that we need to be
> scoped: __GFP_NOFAIL.
> 
> All of the allocations done through the existing XFS kmem.[ch]
> interfaces (i.e just about everything) have __GFP_NOFAIL semantics
> added except in the explicit cases where we add KM_MAYFAIL to
> indicate that the allocation can fail.
> 
> The result of this conversion to remove GFP_NOFS is that I'm also
> adding *dozens* of __GFP_NOFAIL annotations because we effectively
> scope that behaviour.
> 
> Hence I think this discussion needs to consider that __GFP_NOFAIL is
> also widely used within critical filesystem code that cannot
> gracefully recover from memory allocation failures, and that this
> would also be useful to scope....
> 
> Yeah, I know, mm developers hate __GFP_NOFAIL. We've been using
> these semantics NOFAIL in XFS for over 2 decades and the sky hasn't
> fallen. So can we get memalloc_nofail_{save,restore}() so that we
> can change the default allocation behaviour in certain contexts
> (e.g. the same contexts we need NOFS allocations) to be NOFAIL
> unless __GFP_RETRY_MAYFAIL or __GFP_NORETRY are set?

Your points and Kent's proposal of scoped GFP_NOWAIT [1] suggests to me this
is no longer FS-only topic as this isn't just about converting to the scoped
apis, but also how they should be improved.

[1] http://lkml.kernel.org/r/Zbu_yyChbCO6b2Lj@tiehlicka

> We already have memalloc_noreclaim_{save/restore}() for turning off
> direct memory reclaim for a given context (i.e. equivalent of
> clearing __GFP_DIRECT_RECLAIM), so if we are going to embrace scoped
> allocation contexts, then we should be going all in and providing
> all the contexts that filesystems actually need....
> 
> -Dave.


