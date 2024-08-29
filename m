Return-Path: <linux-fsdevel+bounces-27820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF28596453C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A70B27E6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353BC1B5EBC;
	Thu, 29 Aug 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d9wkAv5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4851B583E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935373; cv=none; b=toAnrxzoDoMV0YG1fjFPgay58LlLcDZ4MVZHTRzXzihvmJVGvZbxyVfwkIqKFeXEui9u8zIWlR+DtTO3zBuDzBgsgkmGbWmbO9+DJtcmaWWzXoUOyOuYw7XnoIS5lEJ77NwAq2h16v0zowbgSb7XYGuOfzK8NKdk/uudJMzhOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935373; c=relaxed/simple;
	bh=ADwLGNGiaK3lns2GUXiZI6S4bjiJhuc+TKq6YqqSCk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOOlNZUB3AzfyzRrsw7MNHKyAV1lhGGg7xZQEGcNct8iKf2hpDZC5IC+o3uAsDwhSsz9cPGvibcHow/EeQ6K7w++rXXWEYo1/YGwp0uXWo0WCGClgV3bbGMqQqM2NhthqD+UkrJgihLigTRq2HcoD5L88Kg/CffucuhogTV4wEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d9wkAv5S; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 08:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724935369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tNwHoeoh/+wF32dV32WxYpQ/YVsPYMrSItFbwY6BfW0=;
	b=d9wkAv5SG8C9ESy/IzIJVu675IQ2gFGCDH5HGa/p1MhQWtHdRWCyssPcIJXad0jP1TV/Gh
	nPXEbSSrSAjb9e8Dm9WDgpg9yv7oFgCIG5WDqZW+aswtTdzVe4B9/J4+BmQIMtgI0CUYH3
	e18O0ZfrWXr7tU024NNjA2YNEHXFWuA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <eatlt3lugcodzlef54xsxdm7w5o3gwtreyf3qvuhq3ebpi3bas@zt6isukikuvw>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtBqwOiBThqxzckc@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBqwOiBThqxzckc@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 02:34:08PM GMT, Michal Hocko wrote:
> On Thu 29-08-24 07:55:08, Kent Overstreet wrote:
> > On Thu, Aug 29, 2024 at 01:08:53PM GMT, Michal Hocko wrote:
> > > On Wed 28-08-24 18:58:43, Kent Overstreet wrote:
> > > > On Wed, Aug 28, 2024 at 09:26:44PM GMT, Michal Hocko wrote:
> > > > > On Wed 28-08-24 15:11:19, Kent Overstreet wrote:
> > > [...]
> > > > > > It was decided _years_ ago that PF_MEMALLOC flags were how this was
> > > > > > going to be addressed.
> > > > > 
> > > > > Nope! It has been decided that _some_ gfp flags are acceptable to be used
> > > > > by scoped APIs. Most notably NOFS and NOIO are compatible with reclaim
> > > > > modifiers and other flags so these are indeed safe to be used that way.
> > > > 
> > > > Decided by who?
> > > 
> > > Decides semantic of respective GFP flags and their compatibility with
> > > others that could be nested in the scope.
> > 
> > Well, that's a bit of commentary, at least.
> > 
> > The question is which of those could properly apply to a section, not a
> > callsite, and a PF_MEMALLOC_NOWAIT (similar to but not exactly the same
> > as PF_MEMALLOC_NORECLAIM) would be at the top of that list since we
> > already have a clear concept of sections where we're not allowed to
> > sleep.
> 
> Unfortunately a lack of __GFP_DIRECT_RECLAIM means both no reclaim and
> no sleeping allowed for historical reasons. GFP_NOWAIT is both used from
> atomic contexts and as an optimistic allocation attempt with a heavier
> fallback allocation strategy. If you want NORECLAIM semantic then this
> would need to be represented by different means than __GFP_DIRECT_RECLAIM
> alone.

I don't see it as particularly needed - the vmalloc locks you mentioned
previously just mean it's something worth considering. In my usage I
probably wouldn't care about those locks, but for keeping the API simple
we probably want just PF_MEMALLOC_NOWAIT (where those locks become
trylock).

> > And that tells us how to resolve GFP_NOFAIL with other conflicting
> > PF_MEMALLOC flags: GFP_NOFAIL loses.
> > 
> > It is a _bug_ if GFP_NOFAIL is accidentally used in a non sleepable
> > context, and properly labelling those sections to the allocator would
> > allow us to turn undefined behaviour into an error - _that_ would be
> > turning kmalloc() into a safe interface.
> 
> If your definition of safe includes an oops or worse silent failure
> then yes. Not really safe interface in my book though. E.g. (just
> randomly looking at GFP_NOFAIL users) btree_paths_realloc doesn't check
> the return value and if it happened to be called from such a scope it
> would have blown up. That code is safe without the scope though. There
> are many other callsites which do not have failure paths.

Yes, but that's unsafe anyways due to the max allocation size of
GFP_NOFAIL - I'll have to fix that.

Note that even if we got rid of the smaller max allocation size of
GFP_NOFAIL allocations we'd _still_ generally need error paths due to
the hard limit of INT_MAX, and integer overflow checking for array
allocations.

