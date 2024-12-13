Return-Path: <linux-fsdevel+bounces-37360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FBF9F1564
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 20:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944CC16AEA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 19:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27423183CC1;
	Fri, 13 Dec 2024 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOHO4Ya6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7F1E2309
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116495; cv=none; b=coZOsi8PRq7jdVPs0CWFunKMZLZKPVBToNmQuvbfZsWFaSX0iHKyLXrl7MombzIZxnate1zZErkbgsYrPBZWYtkNnWG5rTpH7hX7KCnCxPTwcr497Fv15LoBUWGZO5pSdkhC5l0TZ8DW8V7blLi/Jf6PZQxl9IqLmOSXgZvaL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116495; c=relaxed/simple;
	bh=CpEUD5UT6UCmzVEoi1D11GDybgVLpADVMtjmQ0Rpd1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoHpoEp3DO8A2w50cV7xnPqMH743/ez/PhYGedTvEaBslaWUY9mkIuVb9V64rJCrjIbmbBG7fUcod5VKNjK9Z2bTh9OLt5imEKszTzKZB9lO1EykPHHKF/edfHrwaqhOtAdzDXz+ZGW3oOOU3S61IEZiWP4GG7cD2Jcad5Gnh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOHO4Ya6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B216EC4CED0;
	Fri, 13 Dec 2024 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734116494;
	bh=CpEUD5UT6UCmzVEoi1D11GDybgVLpADVMtjmQ0Rpd1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOHO4Ya6z6QkYHM7bRYHV6GKpSG8/r9MwZpzEXdGLpN2rJ7yYbF/m34FRq/sMf/I7
	 WwtisFMyHCLBwxuBu17KR+OMnNapPqBSyKtOU8teBaO2Mjm4fgz4qlARnYW88or2Dj
	 GJPyodErYs+wp4Ls1C0OcYS8ROmWKYuVWWpBjK/jNlYBfBGNcqi0QagZcza1cwOflv
	 hcnarTjPr0HkSSb76P50Jr/g1x+7V+kG9oA8TQNOV1G13mRN3QWi213Bp1FfBm/orV
	 NTdvlPVdlXrX/y+nDEQuMStvYWBAx0zUXH+wp5piTJQTw51wkDXRLS8/rSQ8Gr1ZUX
	 zOp43y8XPcKLQ==
Date: Fri, 13 Dec 2024 20:01:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <20241213-lehnt-besoldung-fcca2235a0bc@brauner>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
 <Z1yCw665MIgFUI3M@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1yCw665MIgFUI3M@casper.infradead.org>

On Fri, Dec 13, 2024 at 06:53:55PM +0000, Matthew Wilcox wrote:
> On Fri, Dec 13, 2024 at 07:51:50PM +0100, Christian Brauner wrote:
> > Yeah, it does. Did you see the patch that is included in the series?
> > I've replaced the macro with always inline functions that select the
> > lock based on the flag:
> > 
> > static __always_inline void mtree_lock(struct maple_tree *mt)
> > {
> >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> >                 spin_lock_irq(&mt->ma_lock);
> >         else
> >                 spin_lock(&mt->ma_lock);
> > }
> > static __always_inline void mtree_unlock(struct maple_tree *mt)
> > {
> >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> >                 spin_unlock_irq(&mt->ma_lock);
> >         else
> >                 spin_unlock(&mt->ma_lock);
> > }
> > 
> > Does that work for you?
> 
> See the way the XArray works; we're trying to keep the two APIs as
> close as possible.
> 
> The caller should use mtree_lock_irq() or mtree_lock_irqsave()
> as appropriate.

Say I need:

spin_lock_irqsave(&mt->ma_lock, flags);
mas_erase(...);
-> mas_nomem()
   -> mtree_unlock() // uses spin_unlock();
      // allocate
   -> mtree_lock() // uses spin_lock();
spin_lock_irqrestore(&mt->ma_lock, flags);

So that doesn't work, right? IOW, the maple tree does internal drop and
retake locks and they need to match the locks of the outer context.

So, I think I need a way to communicate to mas_*() what type of lock to
take, no? Any idea how you would like me to do this in case I'm not
wrong?

