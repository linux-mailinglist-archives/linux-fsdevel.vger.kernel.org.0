Return-Path: <linux-fsdevel+bounces-27223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257C895FA0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C473D1F2401E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152ED1993BD;
	Mon, 26 Aug 2024 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pdkoi/S/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CE198E90;
	Mon, 26 Aug 2024 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702107; cv=none; b=gJ8x56nCPcK5ykRlu0QsQ9KE9qW39LjMSJr/FMPMb/22J+jv/A2ohlnwrrD80mKTh1JRKJMvTH0BB2u6fCInjyHkztcfVmGWTTkRFwE+AKKwIb9WD6+9c2A8JkVl+CoNifGNz2u1vyyyt4RiVZiNy0rz2MhiLrai3o+1BJtvc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702107; c=relaxed/simple;
	bh=fl1HE77D3fhTLgBU4l1vqYLWZb4UBEzK0A+Mzspb6bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuaH+37i6fYQ0pq8d7witkZylkimRo0HOs0/SkCrsoCZ1GayLf6C5zMBSVPez4U/jbPx8VHt+4tzfjxadAcq6XLXTwaSxilRnX4YrlBfpGeDkNvdeXLXoAfaAe4ACHlFtsyvHVrzcytmW7zxJs8VAGSdR3OEAHOb0k6EYyvvIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pdkoi/S/; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 15:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724702101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ruExyvd6gxPtiLXw8MJ5M67mJMswkxY6U+zhoDHwHI=;
	b=pdkoi/S/Dr0rAlm9V4YVflbW7gKVDBKd4If8UuxbhWUQR/EWStR1Rp582L6Vs7jgi1Z+7b
	RNayvFgXNk/M/EtErDYgpws+rHSVzvnKBmrxYYlXH+P7/agdeTqPGznkpzN5Z2upBuolTe
	z0X0oRQwESYT95iJ/a6tZQgWTSi2SZo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <5m5qksxkvj4cvfzczqzleyortpe5selbrzkwlgbdc4ia5btg5d@mcaycdzfn6x3>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <Zszado75SnObVKG5@casper.infradead.org>
 <rwqusvtkwzbr2pc2hwmt2lkpffzivrlaw3xfrnrqxze6wmpsex@s3eavvieveld>
 <Zszbt8M5mUPZjbFq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zszbt8M5mUPZjbFq@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 08:47:03PM GMT, Matthew Wilcox wrote:
> On Mon, Aug 26, 2024 at 03:42:59PM -0400, Kent Overstreet wrote:
> > On Mon, Aug 26, 2024 at 08:41:42PM GMT, Matthew Wilcox wrote:
> > > On Mon, Aug 26, 2024 at 03:39:47PM -0400, Kent Overstreet wrote:
> > > > Given the amount of plumbing required here, it's clear that passing gfp
> > > > flags is the less safe way of doing it, and this really does belong in
> > > > the allocation context.
> > > > 
> > > > Failure to pass gfp flags correctly (which we know is something that
> > > > happens today, e.g. vmalloc -> pte allocation) means you're introducing
> > > > a deadlock.
> > > 
> > > The problem with vmalloc is that the page table allocation _doesn't_
> > > take a GFP parameter.
> > 
> > yeah, I know. I posted patches to plumb it through, which were nacked by
> > Linus.
> > 
> > And we're trying to get away from passing gfp flags directly, are we
> > not? I just don't buy the GFP_NOFAIL unsafety argument.
> 
> The problem with the giant invasive change of "getting away from passing
> GFP flags directly" is that you need to build consensus for what it
> looks like and convince everyone that you have a solution that solves
> all the problems, or at least doesn't make any of those problems worse.
> You haven't done that, you've just committed code that the MM people hate
> (indeed already rejected), and set back the idea.

Err, what? I'm not the one who originated the idae of getting away from
passing gfp flags directly. That's been the consensus for _awhile_;
you've been talking about it, Linus talked about it re: vmalloc pte
allocation.

So this looks to me like the mm people just trying to avoid having to
deal with that. GFP_NOFAIL conflicting with other memalloc/gfp flags is
not a new issue (you really shouldn't be combining GFP_NOFAIL with
GFP_NOFS or GFP_NOIO!), and it's something we have warnings for.

But the issue of gfp flags not being passed correctly is not something
we can check for at runtime with any reliability - which means this
patchset look like a net negative to me.

