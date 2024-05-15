Return-Path: <linux-fsdevel+bounces-19486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF88C5F11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 04:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572C31C217A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 02:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC24EAD7;
	Wed, 15 May 2024 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8QB8Yap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46FA210FF;
	Wed, 15 May 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715739387; cv=none; b=MZkTromFuSOHZGQyeVpa0TtF5xfkWDX5i7i7n+O6MpnuwS6AEdPAvoypBEsQwCY4YM6IqIbsEkeOTCIZPt5i1vCS4RF16U4auRE0VrmXtCMAzkGBkHtwThGtDckEFYBNa3+RWT4Maaa3l1fhvw2K27z++6Lvx3PwHTY+M/8c0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715739387; c=relaxed/simple;
	bh=h79cVWSC+yViTMKb80udAsko9NBzsml9klHZ/WAAFTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2ox7lgopgdBq9UlPQnmbc/zuPKJ9Pdh83vHIZIrA41z8DdqEPdNzNQALqvK5gqnD+BNo9OjLno6rwCfu/F8jvJUsd0boqxt4iZfBuVm1M30JZEW0U6S7nLE1/bd4II32h23MHAia1l4gsdTjRGFvY+bA3HKXx75efhYsE+kIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8QB8Yap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01311C2BD10;
	Wed, 15 May 2024 02:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715739387;
	bh=h79cVWSC+yViTMKb80udAsko9NBzsml9klHZ/WAAFTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8QB8YapccGj+71TORDpjgmHLYN3FIsayjqVyAgfjcxFrp8ZWwjx1UROcOQJVVYjC
	 ytTl5hf3hwAZKB97dEiefBGo9A+JOV2si0dVOXrlry9QJT/iqRKzuz9SDG/kW/uc+J
	 q8b7HwAB29tdtks4iAsL347FANgYkv3JFlLHzEiQclr4XybXD2w0lCPPqgw+w86TCl
	 EmbJ9EkHCRYs1utIYHJq7KzXH4Xi1MXGNnY3uosux6+Pt1JBblMP1xaSnkxenHa7bR
	 vruiW3cDk+VyC2RL8zy4oHaQq1g98hkhHXsXieb6vz/yJqhmO1c6nn+/OvEcDEoxiD
	 5gF4Km16BIaNg==
Date: Tue, 14 May 2024 19:16:25 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/18] fsverity: support block-based Merkle tree caching
Message-ID: <20240515021625.GA184012@sol.localdomain>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
 <171444679658.955480.4637262867075831070.stgit@frogsfrogsfrogs>
 <ZjHw6wt3K164hOBr@infradead.org>
 <20240501223519.GG360919@frogsfrogsfrogs>
 <ZjMZnxgFZ_X6c9aB@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjMZnxgFZ_X6c9aB@infradead.org>

On Wed, May 01, 2024 at 09:42:07PM -0700, Christoph Hellwig wrote:
> On Wed, May 01, 2024 at 03:35:19PM -0700, Darrick J. Wong wrote:
> > Got a link?  This is the first I've heard of this, but TBH I've been
> > ignoring a /lot/ of things trying to get online repair merged (thank
> > you!) over the past months...
> 
> This was long before I got involved with repair :)
> 
> Below is what I found in my local tree.  It doesn't have a proper commit
> log, so I probably only sent it out as a RFC in reply to a patch series
> posting, most likely untested:
> 
> commit c11dcbe101a240c7a9e9bae7efaff2779d88b292
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Oct 16 14:14:11 2023 +0200
> 
>     fsverity block interface

That RFC patch doesn't take into account the bitmap, but the overall idea does
seem to work.  I've had a go at the block-based Merkle tree caching support at
https://lore.kernel.org/fsverity/20240515015320.323443-1-ebiggers@kernel.org.
Let me know what you think.

(The one thing I'm not a huge fan of is the indirect call on the drop path.
Previously, it wasn't necessary for filesystems using page based caching.  This
hopefully is a minor point, but I'm not sure, since unfortunately indirect calls
are atrociously expensive these days -- especially on x86.  Having the single
read_block / drop_block interface does seem like the right solution, though.  We
could always optimize the pagecache-based drop to a direct call later, while
conceptually still having it be an implementation of the same interface.)

- Eric

