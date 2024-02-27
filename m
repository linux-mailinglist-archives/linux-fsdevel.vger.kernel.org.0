Return-Path: <linux-fsdevel+bounces-12917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A896C86888D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 06:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78504B21D88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 05:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11552F77;
	Tue, 27 Feb 2024 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcT0y2q4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1151C27
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709011062; cv=none; b=CPgItgxW3G17UW1dXfsrBZsiieAw8cQYXmVR4xbEbHj84LNyUoCyXpe7ZCzfwMXqJLy2ku5WIXGeFk6ZN+8WUxeqlSLGvqGEq8vGM1Ic1Y5FHSQExuCqUpbK17UVxC/31hrU+/4FSZi0JCvJ871eDD+xLbmjykb3vM9Rv8g13wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709011062; c=relaxed/simple;
	bh=MUTrLdwn8CzojDvpZGIbClrFw7b8sZKraVuvLtzG5RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIAUOZE15Ohq6BCBbUtzyRdmeodAYp2IPgSDTrCS88u9x8yBPiAhQQMyBfEZmR/zrmBjQBPUR80n1wRQWB5i7xK5PCtgN5Cb7jXhZl7ImK3TuLP7zjhgUBDHwEba0kb6IOavzDvF2w+TOpMWbBtnhAVY78JuXTm6BeMqNDaqEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcT0y2q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B45C433F1;
	Tue, 27 Feb 2024 05:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709011062;
	bh=MUTrLdwn8CzojDvpZGIbClrFw7b8sZKraVuvLtzG5RM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VcT0y2q4a7leZ6R2TvkQqa2KGLHi+mVjFVOv/BPjdbTLBn68R9a3k30P9eYRzRGCU
	 4p91BDccF1vuUk33rVYrRB0GaahYByQiZWsO3fXuUTVrCUt7sNvY0ft6oLtogA7D0x
	 So3FmCIr+oeDx5vwaxtC7ATcVxnEm757SRks899uAl9tNoxV1sn7r+qcwZ+GZV/+mc
	 db2WcvMz9lYZ3CbZw0sUDCGfgzQCmJsDtY2TyOyWKNrorVtfLvPziPiuyngPPgS3zU
	 vjUpg9+c01TJBSQxd0qXsHPtVEmjhokRAqdWQETu3aAsXp/kRIDm1+nst6AREq4hj4
	 We3e1M48aZcuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B9EEDCE1108; Mon, 26 Feb 2024 21:17:41 -0800 (PST)
Date: Mon, 26 Feb 2024 21:17:41 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <Zdz9p_Kn0puI1KEL@casper.infradead.org>
 <znixgiqxzoksfwwzggmzsu6hwpqfszigjh5k6hx273qil7dx5t@5dxcovjdaypk>
 <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>
 <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
 <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
 <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
 <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
 <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>

On Mon, Feb 26, 2024 at 08:08:17PM -0500, Kent Overstreet wrote:
> On Mon, Feb 26, 2024 at 04:55:29PM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 26, 2024 at 07:29:04PM -0500, Kent Overstreet wrote:
> > > On Mon, Feb 26, 2024 at 04:05:37PM -0800, Paul E. McKenney wrote:
> > > > On Mon, Feb 26, 2024 at 06:29:43PM -0500, Kent Overstreet wrote:
> > > > > Well, we won't want it getting hammered on continuously - we should be
> > > > > able to tune reclaim so that doesn't happen.
> > > > > 
> > > > > I think getting numbers on the amount of memory stranded waiting for RCU
> > > > > is probably first order of business - minor tweak to kfree_rcu() et all
> > > > > for that; there's APIs they can query to maintain that counter.
> > > > 
> > > > We can easily tell you the number of blocks of memory waiting to be freed.
> > > > But RCU does not know their size.  Yes, we could ferret this on each
> > > > call to kmem_free_rcu(), but that might not be great for performance.
> > > > We could traverse the lists at runtime, but such traversal must be done
> > > > with interrupts disabled, which is also not great.
> > > > 
> > > > > then, we can add a heuristic threshhold somewhere, something like 
> > > > > 
> > > > > if (rcu_stranded * multiplier > reclaimable_memory)
> > > > > 	kick_rcu()
> > > > 
> > > > If it is a heuristic anyway, it sounds best to base the heuristic on
> > > > the number of objects rather than their aggregate size.
> > > 
> > > I don't think that'll really work given that object size can very from <
> > > 100 bytes all the way up to 2MB hugepages. The shrinker API works that
> > > way and I positively hate it; it's really helpful for introspection and
> > > debugability later to give good human understandable units to this
> > > stuff.
> > 
> > You might well be right, but let's please try it before adding overhead to
> > kfree_rcu() and friends.  I bet it will prove to be good and sufficient.
> > 
> > > And __ksize() is pretty cheap, and I think there might be room in struct
> > > slab to stick the object size there instead of getting it from the slab
> > > cache - and folio_size() is cheaper still.
> > 
> > On __ksize():
> > 
> >  * This should only be used internally to query the true size of allocations.
> >  * It is not meant to be a way to discover the usable size of an allocation
> >  * after the fact. Instead, use kmalloc_size_roundup().
> > 
> > Except that kmalloc_size_roundup() doesn't look like it is meant for
> > this use case.  On __ksize() being used only internally, I would not be
> > at all averse to kfree_rcu() and friends moving to mm.
> 
> __ksize() is the right helper to use for this; ksize() is "how much
> usable memory", __ksize() is "how much does this occupy".
> 
> > The idea is for kfree_rcu() to invoke __ksize() when given slab memory
> > and folio_size() when given vmalloc() memory?
> 
> __ksize() for slab memory, but folio_size() would be for page
> allocations - actually, I think compound_order() is more appropriate
> here, but that's willy's area. IOW, for free_pages_rcu(), which AFAIK we
> don't have yet but it looks like we're going to need.
> 
> I'm scanning through vmalloc.c and I don't think we have a helper yet to
> query the allocation size - I can write one tomorrow, giving my brain a
> rest today :)

Again, let's give the straight count of blocks a try first.  I do see
that you feel that the added overhead is negligible, but zero added
overhead is even better.

							Thanx, Paul

