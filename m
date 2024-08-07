Return-Path: <linux-fsdevel+bounces-25236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3861F94A205
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6519282D2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E03C1C8227;
	Wed,  7 Aug 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d9Ap6mpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E17C6D4;
	Wed,  7 Aug 2024 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017143; cv=none; b=G+Qq6Tw8KggqcdydaM70PNIGe4QvkanrUr1PHGteXYeMAdgK0+cSOHZmnMu9K/wxRldgCAxFocnn50CFS9Yw5hMSOQfAWT3NsTDOuMJ5rUqbbimJSCdDUO6E4VYZYVFTiASUyQnSLjYOxIWIL/n3cf4qM1yq2CbkoVFqybdT5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017143; c=relaxed/simple;
	bh=1wAhjX2DPr9/lVfPAalcSwLvoZc4JgfP3/j9qMFUUrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAFqGlcexVMGTJ4i1yYWAREUaXWjZoe0J3K4msrIDy5EQMxONKwfa8nBWd0AivZOEoZrOkj3Xtkp7VFxARhciv/yF/WOR4/DuTvqlHymPJU23EMLg1977kk+yXC2l4Ng6LBKbm1LO1bCzpW5kp8zCLprZYlEl1OyGIQbBROyY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d9Ap6mpt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BObMkshv/1ZlUvzNmrwwqT325S36O8qv+ooCnwJwmHg=; b=d9Ap6mptPEo0WzYc27vE63neRu
	u73kQ6QLcVnInCj1A8IesRMAoEYA2nHwR1O6AdXwcK1T+AGHefo3qcERKVWkjTQOEVOwz8vshRTKq
	DWcQXwx+cN/uTyH2w7NAZ7GrhVXTK5zi557/FkEB5b6MVmgaK7qbJu2jrIpcxKARhWeWfiAmkjxAK
	1kRAbBvYe6tO4vtqkFV7Q0eBrW00T1rJQMm5eD7FprnDLPLOl/EiqcVm7YIpmseepYYfVe9h3HUMg
	1eaEez6gabRLV2kcqA9Gq0WG3ftsB4d8x8eJDdGH53+EfXpa/8XFH9xKpkKz6NRkAtyqDxM3jFOBz
	b8lTf1Cw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbbT0-00000002GZV-49f8;
	Wed, 07 Aug 2024 07:52:19 +0000
Date: Wed, 7 Aug 2024 08:52:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <20240807075218.GX5334@ZenIV>
References: <20240806144628.874350-1-mjguzik@gmail.com>
 <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
 <20240807033820.GS5334@ZenIV>
 <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
 <20240807062300.GU5334@ZenIV>
 <20240807063350.GV5334@ZenIV>
 <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 07, 2024 at 09:22:59AM +0200, Mateusz Guzik wrote:

> Well it's your call, you wrote the thing and I need the problem out of
> the way, so I'm not going to argue about the patchset.
> 
> I verified it boots and provides the expected perf win [I have to
> repeat it is highly variable between re-runs because of ever-changing
> offsets between different inode allocations resulting in different
> false-sharing problems; i'm going to separately mail about that]
> 
> I think it will be fine to copy the result from my commit message and
> denote it's from a different variant achieving the same goal.
> 
> That said feel free to use my commit message in whatever capacity,
> there is no need to mention me.

Original analysis had been yours, same for "let's change the calling
conventions for do_dentry_open() wrt path refcounting", same for
the version I'd transformed into that...  FWIW, my approach to
that had been along the lines of "how do we get it consistently,
whether we go through vfs_open() or finish_open()", which pretty
much required keeping hold on the path until just before
terminate_walk().  This "transfer from nd->path to whatever borrowed
it" was copied from path_openat() (BTW, might be worth an inlined helper
next to terminate_walk(), just to document that it's not an accidental
property of terminate_walk()) and that was pretty much it.

Co-developed-by: seems to be the usual notation these days for
such situations - that really had been incremental changes.

Anyway, I really need to get some sleep before writing something
usable as commit messages...

