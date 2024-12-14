Return-Path: <linux-fsdevel+bounces-37420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582BE9F1E58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 12:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A811886E4B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2DA18E37B;
	Sat, 14 Dec 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QglRgckj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D826E154C00
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734176902; cv=none; b=fF9tE9ObsNqUIx7vKuBMI3cvqApokUlQv2EK4JB71642iiJNgx9sCkgdlD7adiBZvIeFoq/r/a6KW+B3Z17ukjrdzTicXjcyG1pgWnm81Fb45baZg0/xZcx31ngQwp8ZebFhTAOpmVbOZTm5ebv1v2mr/p28pKjBG4GXXl2HT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734176902; c=relaxed/simple;
	bh=dj5fyEJ4mI7g9ZyT6TYGigowRsIN16TjW5V0hqNTB58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+AIVvA1Dk8jEb2LFYKrLFaLaWV4G4+XxsC97VM8b9q4rsC3YeyAWHjXjFNDGti96Aaa8asOJXC7KjNJwMtdIXKSeAg4IWXbSYNFkKBLcoLmEo9qNWi+WMMJ48p9sVCnmC0NhryPTEFCv3Kq/Bz8erQWVsu7ScdXJ68Vbjmux6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QglRgckj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33436C4CED3;
	Sat, 14 Dec 2024 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734176902;
	bh=dj5fyEJ4mI7g9ZyT6TYGigowRsIN16TjW5V0hqNTB58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QglRgckjHpnyvgIVEzw91VGZLfW4jDys+8107Y6UJZirJ8d4D2YVf3tjC2MjcY/vf
	 cUOpVAX5cOVjjtfFe4y62qUr8T04461nLKD6JEWuRsub0AZVtM6bwVjEl6njCpAKNj
	 qoIpCblfM67QP8TtQRVKU1WIwKUE+ViNcKPRDuU59XtWsrlPBqbzlJSu6mFyF9gqH5
	 3O5miFXh4UoD4CXRgJFcgiZo1oU6wytjfcHV9TXSWGfV+aRcqAUY4j0FhrhrbLtAVD
	 zHQyDccvTOat/IioiGe+HDzdwuFj7XDjGgqUKDLMFhTyrCCvmGP+uUqMq9TyLJHXxp
	 0XWg3+ovFDE1A==
Date: Sat, 14 Dec 2024 12:48:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <20241214-galaxie-angetan-2d31098b66f7@brauner>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
 <Z1yCw665MIgFUI3M@casper.infradead.org>
 <20241213-lehnt-besoldung-fcca2235a0bc@brauner>
 <20241213-milan-feiern-e0e233c37f46@brauner>
 <20241213-filmt-abgrund-fbf7002137fe@brauner>
 <7tzjnz4fhpegb6y4fzjt2mgjlbrvuibkvkh3e4qd32l43zeh2q@43eedsimunw3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7tzjnz4fhpegb6y4fzjt2mgjlbrvuibkvkh3e4qd32l43zeh2q@43eedsimunw3>

On Fri, Dec 13, 2024 at 04:04:40PM -0500, Liam R. Howlett wrote:
> * Christian Brauner <brauner@kernel.org> [241213 15:11]:
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
> Instead of checking the flag inside mas_lock()/mas_unlock(), the flag is
> checked in mas_nomem(), and the correct mas_lock_irq() pair would be
> called there.  External callers would use the mas_lock_irq() pair
> directly instead of checking the flag.

I'm probably being dense but say I have two different locations with two
different locking requirements - as is the case with alloc_pid() and
free_pid(). alloc_pid() just uses spin_lock_irq() and spin_unlock_irq()
but free_pid() requires spin_lock_irqsave() and
spin_unlock_irqrestore(). If the whole mtree is marked with a flag that
tells the mtree_lock() to use spin_lock_irq() then it will use that also
in free_pid() where it should use spin_lock_irqsave().

So if I'm not completely off-track then we'd need a way to tell the
mtree to use different locks for different callsites. Or at least
override the locking requirements for specific calls by e.g., allowing a
flag to be specified in the MA_STATE() struct that's checke by e.g.,
mas_nomem().

> To keep the API as close as possible, we'd keep the mas_lock() the same
> and add the mas_lock_irq() as well as mas_lock_type(mas, lock_type).
> __xas_nomem() uses the (static) xas_lock_type() to lock/unlock for
> internal translations.
> 
> Thanks,
> Liam

