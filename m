Return-Path: <linux-fsdevel+bounces-37363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADC99F15C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 20:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFB4188D739
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F571E3DE6;
	Fri, 13 Dec 2024 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6nEQR/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED11684AC
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734117926; cv=none; b=MbgfkDsX0KSqUHe5AxM5VRGm1XJebjl3bw+pK6OwpRcC6bPWPr2u8bxb4rYGZPPlPG4X8NNDdjxnxrl5J+NysANfASyIVQa+ai8dIPDdsF6Mvk1kGF+sVnji512eTGncRirXt6dZ14N4SQ6ln1j1CEQ2SAi1bhZoJpXJP7NQFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734117926; c=relaxed/simple;
	bh=1Oh4d/QHF0TqRseUY+A881Nzg+Y7+42fGc2DQMZEEAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCqPMRD7FVyDPnjQvedVIpJlCDUdw6odIGXB5G+f4vPCzgN6BWkO1ldhbDVkoK1Sv4QxoiGVdDhWdUKqB0fsuCKtyPLUUGGrnNOGN8IDUQzzJlNUCoU4LQq+K3fbhDRCPzhv5Bc0D8XUs0FPc1xy5ILzS/cmQVg0uA/NxBaIz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6nEQR/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0542C4CED4;
	Fri, 13 Dec 2024 19:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734117926;
	bh=1Oh4d/QHF0TqRseUY+A881Nzg+Y7+42fGc2DQMZEEAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6nEQR/yxfVRuXMRgMK2S4urZ59rf+BX2mPYjjGZpr6x2qKhs121F16pRht/VHFvI
	 B1+deMae/bBihw9YhjIAJcXiftnkjNRv+YapRGzjA2tYFJLek4SyNt0L5sLNMc9Rx6
	 Em4gPBtLTDpiyv5hfF16A/cUJ51tZyJXGhsK1NCVF18/MFHsdkHF9OFsAHT7OjpVKf
	 +ds2PTFPQqENZiHFFBM71xlbSybd8YZryZcIlwgIhv8yAZEIxsqO8ZGzHedkOtGtrW
	 45eCCESs2taRlXhgBCvnyNznU+jjKUhdVYinSH8UC5MWkXM+h/w6f9OWkrh87eZE6F
	 2FYEhfU6e5V2Q==
Date: Fri, 13 Dec 2024 20:25:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <20241213-milan-feiern-e0e233c37f46@brauner>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
 <Z1yCw665MIgFUI3M@casper.infradead.org>
 <20241213-lehnt-besoldung-fcca2235a0bc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213-lehnt-besoldung-fcca2235a0bc@brauner>

On Fri, Dec 13, 2024 at 08:01:30PM +0100, Christian Brauner wrote:
> On Fri, Dec 13, 2024 at 06:53:55PM +0000, Matthew Wilcox wrote:
> > On Fri, Dec 13, 2024 at 07:51:50PM +0100, Christian Brauner wrote:
> > > Yeah, it does. Did you see the patch that is included in the series?
> > > I've replaced the macro with always inline functions that select the
> > > lock based on the flag:
> > > 
> > > static __always_inline void mtree_lock(struct maple_tree *mt)
> > > {
> > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > >                 spin_lock_irq(&mt->ma_lock);
> > >         else
> > >                 spin_lock(&mt->ma_lock);
> > > }
> > > static __always_inline void mtree_unlock(struct maple_tree *mt)
> > > {
> > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > >                 spin_unlock_irq(&mt->ma_lock);
> > >         else
> > >                 spin_unlock(&mt->ma_lock);
> > > }
> > > 
> > > Does that work for you?
> > 
> > See the way the XArray works; we're trying to keep the two APIs as
> > close as possible.
> > 
> > The caller should use mtree_lock_irq() or mtree_lock_irqsave()
> > as appropriate.
> 
> Say I need:
> 
> spin_lock_irqsave(&mt->ma_lock, flags);
> mas_erase(...);
> -> mas_nomem()
>    -> mtree_unlock() // uses spin_unlock();
>       // allocate
>    -> mtree_lock() // uses spin_lock();
> spin_lock_irqrestore(&mt->ma_lock, flags);
> 
> So that doesn't work, right? IOW, the maple tree does internal drop and
> retake locks and they need to match the locks of the outer context.
> 
> So, I think I need a way to communicate to mas_*() what type of lock to
> take, no? Any idea how you would like me to do this in case I'm not
> wrong?

My first inclination has been to do it via MA_STATE() and the mas_flag
value but I'm open to any other ideas.

