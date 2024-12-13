Return-Path: <linux-fsdevel+bounces-37367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFCB9F1745
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432F2188B12D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 20:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B91E883A;
	Fri, 13 Dec 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUVj5ft/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54E51C4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120669; cv=none; b=f6K26iCtK5YUfR3ZIIimhJn8ki5R8s9IhiOv81n2nXLp8A1ZgHyuvHLHFJi6OLf7pf3YgWkvO1V7fvsYeGC/pfbsYhCnHTYPcvlBMWXgPkYrOEg4DsbcvFLEnL33MXozt2+XLqA7X/UZOgLcnaoPzso/yUT/MYqtAeHMobTL8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120669; c=relaxed/simple;
	bh=02VZYjHQ0aPNHPJNOlZPgdFJ05cd30mIFeIptO8MoJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwUYt+k2rzeS/1PdRjnqwCdPyefX4sHxDl8/a7hct1N7YEQ/XFs/ehWhAgzg/vvNU1rfCwPZ1fbLk29dyVyGI5aGRhhrvNAOdK1NsfMskMj/dKc5Ao/AfBYljYlYP3xe3lTA4OjdmfeNlVCGEgEtcv7KZofAXIvIZsadgnbqmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUVj5ft/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65CFC4CED0;
	Fri, 13 Dec 2024 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734120669;
	bh=02VZYjHQ0aPNHPJNOlZPgdFJ05cd30mIFeIptO8MoJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUVj5ft/ey6h+3PrhyHF7v2wNOciRlHVMHF8hdzKKPglrdWdvw570A7dgAqFTf5X6
	 d6gA6bcsJAOxx9wUVw/G4MGBQaiMOWsNOrlNYgdrJrhkiw+AENgiGpoDTKKJfguQnL
	 pTs1GaMcEwnu1/HD2xkwR+B8pYGteAFNammc4uNpOEGk7P2lRoFlQ0Kv3Osn89eksP
	 tCeJC4c+UiZm25PWympMxB84yQSZZ+3rczZzxh3gCKaimDz65r7I/bYQmAqN9sOoAe
	 xLlf2jTFp2x85nFk0nU5RdzVb7FQZ1V7EA6OmZj/GR7JEvsOfqCX0C9h0P8fA3PUTI
	 Dpqj9xMWSlLkQ==
Date: Fri, 13 Dec 2024 21:11:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <20241213-filmt-abgrund-fbf7002137fe@brauner>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
 <Z1yCw665MIgFUI3M@casper.infradead.org>
 <20241213-lehnt-besoldung-fcca2235a0bc@brauner>
 <20241213-milan-feiern-e0e233c37f46@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213-milan-feiern-e0e233c37f46@brauner>

On Fri, Dec 13, 2024 at 08:25:21PM +0100, Christian Brauner wrote:
> On Fri, Dec 13, 2024 at 08:01:30PM +0100, Christian Brauner wrote:
> > On Fri, Dec 13, 2024 at 06:53:55PM +0000, Matthew Wilcox wrote:
> > > On Fri, Dec 13, 2024 at 07:51:50PM +0100, Christian Brauner wrote:
> > > > Yeah, it does. Did you see the patch that is included in the series?
> > > > I've replaced the macro with always inline functions that select the
> > > > lock based on the flag:
> > > > 
> > > > static __always_inline void mtree_lock(struct maple_tree *mt)
> > > > {
> > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > >                 spin_lock_irq(&mt->ma_lock);
> > > >         else
> > > >                 spin_lock(&mt->ma_lock);
> > > > }
> > > > static __always_inline void mtree_unlock(struct maple_tree *mt)
> > > > {
> > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > >                 spin_unlock_irq(&mt->ma_lock);
> > > >         else
> > > >                 spin_unlock(&mt->ma_lock);
> > > > }
> > > > 
> > > > Does that work for you?
> > > 
> > > See the way the XArray works; we're trying to keep the two APIs as
> > > close as possible.
> > > 
> > > The caller should use mtree_lock_irq() or mtree_lock_irqsave()
> > > as appropriate.
> > 
> > Say I need:
> > 
> > spin_lock_irqsave(&mt->ma_lock, flags);
> > mas_erase(...);
> > -> mas_nomem()
> >    -> mtree_unlock() // uses spin_unlock();
> >       // allocate
> >    -> mtree_lock() // uses spin_lock();
> > spin_lock_irqrestore(&mt->ma_lock, flags);
> > 
> > So that doesn't work, right? IOW, the maple tree does internal drop and
> > retake locks and they need to match the locks of the outer context.
> > 
> > So, I think I need a way to communicate to mas_*() what type of lock to
> > take, no? Any idea how you would like me to do this in case I'm not
> > wrong?
> 
> My first inclination has been to do it via MA_STATE() and the mas_flag
> value but I'm open to any other ideas.

Braino on my part as free_pid() can be called with write_lock_irq() held.

