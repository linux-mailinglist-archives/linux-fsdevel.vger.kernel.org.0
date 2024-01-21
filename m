Return-Path: <linux-fsdevel+bounces-8382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE5B8358D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 00:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4233C1C2189F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 23:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53A38FB3;
	Sun, 21 Jan 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PAhgnBTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2438DED
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705881384; cv=none; b=XOoASN05hjhEybQSj9X9rRL5wewV4WBtQ82KtEhnMADHEoVQ5ukwURT75mZ4BUVkcLI2h40XgDMWUIv8alDt58k77JQJ8a+A79BfGMpPsCLM4Y3cRzjXQXqzeGppHqz/eyoNlzleU1gP+VkR1BhJIn/AB3FRlkbgGcYF/tmJfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705881384; c=relaxed/simple;
	bh=E26WLEydURNLciZS8mL4oLPZ2o9M/Atd3GMrE8e3CaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F45OGrsE/hXGjOSlNqgmnGUBv9aOoqU+BBulDQvlJKJT85EpTpzO3qUTiuMuFqQpzWUkYnrsDEmvkzzEEeVtG23PiaWY5DvXTvMfNhasoDprmQ8736oHzaB6IK2jELY83xmxYhG/+PTU2Ks7Wm3K8NrKjIC5BdgK5hXUlsnrm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PAhgnBTV; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 21 Jan 2024 18:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705881379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaNb9i900YTz8bDoI0sHPIuzs00Kdb0nl8oXjKcg6Wc=;
	b=PAhgnBTVHE7omdepBNAow9sZycbf4Y0PKKMFY5m6cSZfbZnlhnYdz1Q0/MtarLKvdkeB0T
	1RQlc7sORwyjWQWXkztPDf8OcVvpCk//lqUqa+2bOxVfgNCwZ47sSxl4JuvANx7NcY3IY5
	MIJuP01MxVp9SFtUWFjBapzRx85Vtbs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] Memory profiling using code tagging
Message-ID: <orlflbtmdan535clwum4wlfarwg3ht54bjjl6zljvllk3derzf@qwi5ky4hovf5>
References: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
 <115288f8-bd28-f01f-dd91-63015dcc635d@suse.cz>
 <ZFvGP211N+CuGEUT@moria.home.lan>
 <CA+CK2bBmqL5coj7=hXfyj2sBZ+go9ozjZihzp4hmykxpKfQphA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBmqL5coj7=hXfyj2sBZ+go9ozjZihzp4hmykxpKfQphA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jan 21, 2024 at 06:39:26PM -0500, Pasha Tatashin wrote:
> On Wed, May 10, 2023 at 12:28 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Tue, Mar 28, 2023 at 06:28:21PM +0200, Vlastimil Babka wrote:
> > > On 2/22/23 20:31, Suren Baghdasaryan wrote:
> > > > We would like to continue the discussion about code tagging use for
> > > > memory allocation profiling. The code tagging framework [1] and its
> > > > applications were posted as an RFC [2] and discussed at LPC 2022. It
> > > > has many applications proposed in the RFC but we would like to focus
> > > > on its application for memory profiling. It can be used as a
> > > > low-overhead solution to track memory leaks, rank memory consumers by
> > > > the amount of memory they use, identify memory allocation hot paths
> > > > and possible other use cases.
> > > > Kent Overstreet and I worked on simplifying the solution, minimizing
> > > > the overhead and implementing features requested during RFC review.
> > >
> > > IIRC one large objection was the use of page_ext, I don't recall if you
> > > found another solution to that?
> >
> > Hasn't been addressed yet, but we were just talking about moving the
> > codetag pointer from page_ext to page last night for memory overhead
> > reasons.
> >
> > The disadvantage then is that the memory overhead doesn't go down if you
> > disable memory allocation profiling at boot time...
> >
> > But perhaps the performance overhead is low enough now that this is not
> > something we expect to be doing as much?
> >
> > Choices, choices...
> 
> I would like to participate in this discussion, specifically to
> discuss how to make this profiling applicable at the scale
> environment. Where we have many machines in the fleet, but the memory
> and performance overheads must be much smaller compared to what is
> currently proposed.
> 
> There are several ideas that we can discuss:
> 1. Filtering files that are going to be tagged at the build time.
> For example, If a specific driver does not need to be tagged it can be
> filtered out during build time.

Not a bad idea - but do we have a concrete reason we want this? Our goal
has been low enough overhead to be enabled in production, and I think
we're delivering on that; perhaps we could wait and see if anyone
complains.

We've already got the runtime switch (via a static branch), so if
overhead is the concern that should cover that.

> 2. Reducing the memory overhead by not using page_ext pointer, but
> instead use n-bits in the page->flags.
>
> The number of buckets is actually not that large, there is no need to
> keep 8-byte pointer in page_ext, it could be an idx in an array of a
> specific size. There could be buckets that contain several stacks.

Just a single tag index directly maps to the pointer it replaces, we
should be able to do this.

> 3. Using static branches for performance optimizations, especially for
> the cases when profiling is disabled.

Already are :)

> 4. Optionally enable only a specific allocator profiling:
> kmalloc/pgalloc/vmalloc/pcp etc.

See above - I'd prefer to be restrained with the knobs we add.

