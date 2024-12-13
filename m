Return-Path: <linux-fsdevel+bounces-37373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B322D9F17D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254DF18834F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4B11917CD;
	Fri, 13 Dec 2024 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4sUhUWe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA218E02A
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124052; cv=none; b=b0Jm5K4DItbUuL8cbtNyE3S21LX7d9bplHOtLHt9zOEOcHItkZ1Ptksqj1khtAcFcrAymyRxPnu1tTqbC6r3GdWiJ4V99TfVOfe6pUpzU9ZCMWL51jgwB8oWAsri3j7KIUzQRSaWRBzgc0x5zLiHs/wSYZ+Dm6Q+CHw5Bhglz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124052; c=relaxed/simple;
	bh=lODNr6pLN9mJD3TlYu83OBSZE8+SPUcZ+JxZyYb02d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbZmaWOg0heX0ZnBxaDpRaf2D7GO2KonrOELuQnwOCubT9wuvDesWOv0vVNhq+LAOKgubclbyIurJeyqWeh7EjxRfaCT8KDvhdFAWeXSXdLldIkpLM/lM4JeowxwcHDxkkxKAoUIc+BusQpyWmQYUOmfFPEBMcUA0Paq4uoH8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4sUhUWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FBFC4CED0;
	Fri, 13 Dec 2024 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734124051;
	bh=lODNr6pLN9mJD3TlYu83OBSZE8+SPUcZ+JxZyYb02d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4sUhUWeHSRTd1uLSYfMjV3VPceyUUPJByCiM6tPp3wbbEItb0cOP7YO6TEJJ0TwH
	 M1CNFs006ZWv92svSjFWpbL3pLQfx3ZbugcsSY0NoKZdRRbQnuRWHGI6xfPrhaD0jd
	 W6Ji41r+3ehPui9KYPRAh1bNQaJf3roRcqmFqORATPi5/kffG7slqY4kYHXMyN840w
	 ovN2cEXsdd5M7eLi8NajK9fyLWNTSMEPUrFtAFHq4S8+u9uewHARiHSmxjUR+iewsk
	 D9T34bCKwCkE2DmKVl2A1xixgI/rwpeaK5c1Wgumsv6AFF8h0CWFky8RJ3bvptwyWS
	 mvfhkYEnCPLgQ==
Date: Fri, 13 Dec 2024 22:07:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <20241213-datieren-spionieren-bbed37f02838@brauner>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
 <Z1yCw665MIgFUI3M@casper.infradead.org>
 <20241213-lehnt-besoldung-fcca2235a0bc@brauner>
 <20241213-milan-feiern-e0e233c37f46@brauner>
 <20241213-filmt-abgrund-fbf7002137fe@brauner>
 <20241213-sequenz-entzwei-d70f9f56490c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213-sequenz-entzwei-d70f9f56490c@brauner>

On Fri, Dec 13, 2024 at 09:50:56PM +0100, Christian Brauner wrote:
> On Fri, Dec 13, 2024 at 09:11:04PM +0100, Christian Brauner wrote:
> > On Fri, Dec 13, 2024 at 08:25:21PM +0100, Christian Brauner wrote:
> > > On Fri, Dec 13, 2024 at 08:01:30PM +0100, Christian Brauner wrote:
> > > > On Fri, Dec 13, 2024 at 06:53:55PM +0000, Matthew Wilcox wrote:
> > > > > On Fri, Dec 13, 2024 at 07:51:50PM +0100, Christian Brauner wrote:
> > > > > > Yeah, it does. Did you see the patch that is included in the series?
> > > > > > I've replaced the macro with always inline functions that select the
> > > > > > lock based on the flag:
> > > > > > 
> > > > > > static __always_inline void mtree_lock(struct maple_tree *mt)
> > > > > > {
> > > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > > >                 spin_lock_irq(&mt->ma_lock);
> > > > > >         else
> > > > > >                 spin_lock(&mt->ma_lock);
> > > > > > }
> > > > > > static __always_inline void mtree_unlock(struct maple_tree *mt)
> > > > > > {
> > > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > > >                 spin_unlock_irq(&mt->ma_lock);
> > > > > >         else
> > > > > >                 spin_unlock(&mt->ma_lock);
> > > > > > }
> > > > > > 
> > > > > > Does that work for you?
> > > > > 
> > > > > See the way the XArray works; we're trying to keep the two APIs as
> > > > > close as possible.
> > > > > 
> > > > > The caller should use mtree_lock_irq() or mtree_lock_irqsave()
> > > > > as appropriate.
> > > > 
> > > > Say I need:
> > > > 
> > > > spin_lock_irqsave(&mt->ma_lock, flags);
> > > > mas_erase(...);
> > > > -> mas_nomem()
> > > >    -> mtree_unlock() // uses spin_unlock();
> > > >       // allocate
> > > >    -> mtree_lock() // uses spin_lock();
> > > > spin_lock_irqrestore(&mt->ma_lock, flags);
> > > > 
> > > > So that doesn't work, right? IOW, the maple tree does internal drop and
> > > > retake locks and they need to match the locks of the outer context.
> > > > 
> > > > So, I think I need a way to communicate to mas_*() what type of lock to
> > > > take, no? Any idea how you would like me to do this in case I'm not
> > > > wrong?
> > > 
> > > My first inclination has been to do it via MA_STATE() and the mas_flag
> > > value but I'm open to any other ideas.
> > 
> > Braino on my part as free_pid() can be called with write_lock_irq() held.
> 
> I don't think I can use the maple tree because even an mas_erase()
> operation may allocate memory and that just makes it rather unpleasant
> to use in e.g., free_pid(). So I think I'm going to explore using the
> xarray to get the benefits of ULONG_MAX indices and I see that btrfs is
> using it already for similar purposes.

Hm, __xa_alloc_cyclic() doesn't support ULONG_MAX indices. So any ideas
how I can proceed? Can I use the maple tree to wipe an entry at a given
index and have the guarantee it won't have to allocate memory?

