Return-Path: <linux-fsdevel+bounces-29352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A529787A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 20:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C026CB26FF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35812CD88;
	Fri, 13 Sep 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R5ag1CbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9083A17;
	Fri, 13 Sep 2024 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251340; cv=none; b=fcvTqrAJdG0g3DyDgTluO2+XSdOOZJgNvBnLyeOcjSvYODM1lS9W6vYS30llYjQ0TJZwEFfyO0qtidE9VnVve+db7b45JJLPKRomesUxiQeQClL9p4FHUYITR+hZr4AmK2SvvUA9E1j/7WxJIQx5BWozRtvKdCm167itVWy/PHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251340; c=relaxed/simple;
	bh=NlK4dbEW2AvqUqV7RdrHsjrhW7yTPUe9VucDl4PrIzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTjLL/wnShIGKkcGI66n+kacaBulmK25x9tHhO+r/bsXxTBTKpYrpM+iJJ/16k9Yv5jGc0xmfyPgwm836KhuMUbKCgxshp/7zRD887iAF8h7sDi9384kCY8IsY3b+HIckPxPfpmVrb2rb1MmVut/tKnJod9hIgT+utnDA3ocbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R5ag1CbF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Bq1Gea88A+B6NeDYaKCfbevhpShpf8ZKdFAOPfCVxM=; b=R5ag1CbFUgKYRrgPv9hvd9N0st
	gv2RQcEDGnDMhGm6FfWCwcueEoDgTilPTHewhvzTanyDdOCZznNjtw/jsemjq+dD8HqBCkyVwksVd
	EjGmaTHUIXSggDU0i0iNOzSsDvLkpUXLcSm2awbf/UCZCtUdki2H78F+9KMHmtXcK1xnXKHutcIkO
	WqCpHlXilpccexdKKRW6vWl5SO2H/it8zE0uaDWiSLPbNchT2O6Sb6C6cOiFjfMJNLC9p2hEuGmWN
	30EVL8uwd2J9lqJYlLARlV17iMI4KbfRLKrCiKc0j0HtO2BmSp5jQJj93n6Pa/bAOqfqQsOQWLcHI
	zLWTbeCg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spApL-0000000GrP9-0pZr;
	Fri, 13 Sep 2024 18:15:27 +0000
Date: Fri, 13 Sep 2024 19:15:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Christian Theune <ct@flyingcircus.io>,
	linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>,
	Dave Chinner <david@fromorbit.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZuSBPrN2CbWMlr3f@casper.infradead.org>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <d4a1cca4-96b8-4692-81f0-81c512f55ccf@meta.com>
 <ZuRfjGhAtXizA7Hu@casper.infradead.org>
 <b40b2b1c-3ed5-4943-b8d0-316e04cb1dab@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b40b2b1c-3ed5-4943-b8d0-316e04cb1dab@meta.com>

On Fri, Sep 13, 2024 at 12:33:49PM -0400, Chris Mason wrote:
> > If you could get the precise index numbers, that would be an important
> > clue.  It would be interesting to know the index number in the xarray
> > where the folio was found rather than folio->index (as I suspect that
> > folio->index is completely bogus because folio->mapping is wrong).
> > But gathering that info is going to be hard.
> 
> This particular debug session was late at night while we were urgently
> trying to roll out some NFS features.  I didn't really save many of the
> details because my plan was to reproduce it and make a full bug report.
> 
> Also, I was explaining the details to people in workplace chat, which is
> wildly bad at rendering long lines of structured text, especially when
> half the people in the chat are on a mobile device.
> 
> You're probably wondering why all of that is important...what I'm really
> trying to say is that I've attached a screenshot of the debugging output.
> 
> It came from a older drgn script, where I'm still clinging to "radix",
> and you probably can't trust the string representation of the page flags
> because I wasn't yet using Omar's helpers and may have hard coded them
> from an older kernel.

That's all _fine_.  This is enormously helpful.

First, we see the same folio appear three times.  I think that's
particularly significant.  Modulo 64 (number of entries/node), the indices
the bad folio are found at is 16, 32 and 48.  So I think the _current_
order of folio is 4, but at the time the folio was put in the xarray,
it was order 6.  Except ... at order-6 we elide a level of the xarray.
So we shouldn't be able to see this.  Hm.

Oh!  I think split is the key.  Let's say we have an order-6 (or
larger) folio.  And we call split_huge_page() (whatever it's called
in your kernel version).  That calls xas_split_alloc() followed
by xas_split().  xas_split_alloc() puts entry in node->slots[0] and
initialises node->slots[1..XA_CHUNK_SIZE] to a sibling entry.

Now, if we do allocate those node in xas_split_alloc(), we're supposed to
free them with radix_tree_node_rcu_free() which zeroes all the slots.
But what if we don't, somehow?  (this is my best current theory).
Then we allocate the node to a different tree, but any time we try to
look something up, unless it's the index for which we allocated the node,
we find a sibling entry and it points to a stale pointer.

I'm going to think on this a bit more, but so far this is all good
evidence for my leading theory.

