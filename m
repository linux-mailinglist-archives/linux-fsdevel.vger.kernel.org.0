Return-Path: <linux-fsdevel+bounces-37371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8589F17A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63B21883228
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95412192B90;
	Fri, 13 Dec 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvZgH394"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F71925A6
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123062; cv=none; b=JbnC9sLz2OPDndbnLnADvFWOvVZqrBoylRQql9qGQQpBwPuVPe7mechieEcWKwv8oMk77A44B+uMX5H+5n/fb9bGEcCE+UmzDLr9eIvB6xnhJY4XCXeY/bQotqcLiMjaxKquV2pNLTgPXTSCJXCb7MMJFPhegoDkALUpiIhG3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123062; c=relaxed/simple;
	bh=VtBNpqcwmAoMDkppq+ZfD9mZtacQv39tz4HV3v7SnLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVv4i9c3VTn8o9Wk2o8ihM8gsTIDhsazgddIVI8+T8FpypmZytvyqW7JMxLJmgCj6Jkd0X4RtUXkj3TM3fa31q1U944oShegjKyKQC4BGJJOpO9u1zFpLwEEMbp384QFrAs94w0zEAzfHN9kxJ2S0u0abxhLyfrhL87c8Oam8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvZgH394; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473ABC4CED0;
	Fri, 13 Dec 2024 20:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734123060;
	bh=VtBNpqcwmAoMDkppq+ZfD9mZtacQv39tz4HV3v7SnLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvZgH394lg8LtdbBuBn/E2+39HeZTfoUnC6nTDXCfOYMcHRPZmNB+E8P60jtE2vkI
	 nJL0UE5JSEDCOmcvdhJ7mO1MW7TiBoMYhEcXJpKslxhvL+vpGxVZwHjY0q/YfVooL/
	 xZx3EKJbrSii1rzcLK4vSB3GiahJAJiKwmpHwcY8wxJamxTF4TbLzSO4s3ZOz/rltS
	 WVAtighL3hLCgRMO+byWe6fzl7AzIkgPNMm6i6LKMCmUOt6nUyEbdIYb6t4g+jTErO
	 hmW+QCCmC3QvlcQemTNTwQQ2oxaG0Uzdgd4JuD5EITfS8V+dwwwW06Te0OWsw78Cls
	 Hn4/bbOzgHjbQ==
Date: Fri, 13 Dec 2024 21:50:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <20241213-sequenz-entzwei-d70f9f56490c@brauner>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
 <Z1yCw665MIgFUI3M@casper.infradead.org>
 <20241213-lehnt-besoldung-fcca2235a0bc@brauner>
 <20241213-milan-feiern-e0e233c37f46@brauner>
 <20241213-filmt-abgrund-fbf7002137fe@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213-filmt-abgrund-fbf7002137fe@brauner>

On Fri, Dec 13, 2024 at 09:11:04PM +0100, Christian Brauner wrote:
> On Fri, Dec 13, 2024 at 08:25:21PM +0100, Christian Brauner wrote:
> > On Fri, Dec 13, 2024 at 08:01:30PM +0100, Christian Brauner wrote:
> > > On Fri, Dec 13, 2024 at 06:53:55PM +0000, Matthew Wilcox wrote:
> > > > On Fri, Dec 13, 2024 at 07:51:50PM +0100, Christian Brauner wrote:
> > > > > Yeah, it does. Did you see the patch that is included in the series?
> > > > > I've replaced the macro with always inline functions that select the
> > > > > lock based on the flag:
> > > > > 
> > > > > static __always_inline void mtree_lock(struct maple_tree *mt)
> > > > > {
> > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > >                 spin_lock_irq(&mt->ma_lock);
> > > > >         else
> > > > >                 spin_lock(&mt->ma_lock);
> > > > > }
> > > > > static __always_inline void mtree_unlock(struct maple_tree *mt)
> > > > > {
> > > > >         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
> > > > >                 spin_unlock_irq(&mt->ma_lock);
> > > > >         else
> > > > >                 spin_unlock(&mt->ma_lock);
> > > > > }
> > > > > 
> > > > > Does that work for you?
> > > > 
> > > > See the way the XArray works; we're trying to keep the two APIs as
> > > > close as possible.
> > > > 
> > > > The caller should use mtree_lock_irq() or mtree_lock_irqsave()
> > > > as appropriate.
> > > 
> > > Say I need:
> > > 
> > > spin_lock_irqsave(&mt->ma_lock, flags);
> > > mas_erase(...);
> > > -> mas_nomem()
> > >    -> mtree_unlock() // uses spin_unlock();
> > >       // allocate
> > >    -> mtree_lock() // uses spin_lock();
> > > spin_lock_irqrestore(&mt->ma_lock, flags);
> > > 
> > > So that doesn't work, right? IOW, the maple tree does internal drop and
> > > retake locks and they need to match the locks of the outer context.
> > > 
> > > So, I think I need a way to communicate to mas_*() what type of lock to
> > > take, no? Any idea how you would like me to do this in case I'm not
> > > wrong?
> > 
> > My first inclination has been to do it via MA_STATE() and the mas_flag
> > value but I'm open to any other ideas.
> 
> Braino on my part as free_pid() can be called with write_lock_irq() held.

I don't think I can use the maple tree because even an mas_erase()
operation may allocate memory and that just makes it rather unpleasant
to use in e.g., free_pid(). So I think I'm going to explore using the
xarray to get the benefits of ULONG_MAX indices and I see that btrfs is
using it already for similar purposes.

