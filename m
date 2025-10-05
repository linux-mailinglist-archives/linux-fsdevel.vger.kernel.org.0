Return-Path: <linux-fsdevel+bounces-63444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A59ABBCC92
	for <lists+linux-fsdevel@lfdr.de>; Sun, 05 Oct 2025 23:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77EB14E7129
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Oct 2025 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD123A98E;
	Sun,  5 Oct 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iCGL4MsG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0332156F20;
	Sun,  5 Oct 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699813; cv=none; b=O2IuWBRhixmn2+xP5IPKRmcvoFfjaYSzPbJevyUuhpbzyQYqxLGTFSlUzLnE31GBM2p4xeLLrIwrCOjSnUd5Q5KFOOfpBsCmW6LJ/hSWQUkMXmsmcn6FwEt9QNdkBHWUxdKgVIaeG1eufM+ahxjiU9NFzN3woENQi+41S5Mv/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699813; c=relaxed/simple;
	bh=X2Sj+X4ry8CeKTZ3BjYqZlfUBwPFnjOa3L+N/yV5Yqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0gcd7XVPGtWm03L/4m5zgmyt93g/yM2o52Q6ytqxG4zLmU+XGQfntifd65RF/WVtKukgkg6kUyFt2rN9flvFgphu79HQbtQfUIZVzZIkrv7QCI73umzsRr1Yy7X21T0cAjJNW6P3ae1JFGLWr5G8ZabtSrU9TvMlVBvYj1q/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iCGL4MsG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=av6tgXA9OEKZB5j5EgDH2KVUpfC7vQCZYrM0ThTzPwk=; b=iCGL4MsGwWmPlwMXPOthkmEvq+
	kuQs491WFrxUWEWnQiyWnRO9OAeVyZ4zEK5L2xzpiwxgCx+mID+AvEEfx2MQZPjc1xPqVqNa2TOO8
	qq8m/NVf01VlzvwvV79HQ4ehuQ8B6/IKbKmxKXNhzsQma898hESFrEEACrXi1Kl4NVvWEtYpXDIbS
	TPku5wazwD+FyTRWBUcQgyNXteVxS+qeLfLGInm4M0MhBKqD8tTfqXbK3M5f6ca5dm+YrVt6CLVnW
	kUnlz7Ge9DnwetHj6Y+0tXm6rD8mte5/5BVZ4ClgAC/Pby/6jZTSQPcgdHs9E72GfTTylmtn7Cn6S
	cbzuCfDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5WIx-00000001mYO-2GSj;
	Sun, 05 Oct 2025 21:30:07 +0000
Date: Sun, 5 Oct 2025 22:30:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] fs: Use a cleanup attribute in copy_fdtable()
Message-ID: <20251005213007.GG2441659@ZenIV>
References: <20251004210340.193748-1-mssola@mssola.com>
 <20251004211908.GD2441659@ZenIV>
 <20251005090152.GE2441659@ZenIV>
 <87y0pp455w.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0pp455w.fsf@>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Oct 05, 2025 at 07:41:47PM +0200, Miquel Sabaté Solà wrote:
> Al Viro @ 2025-10-05 10:01 +01:
> 
> > On Sun, Oct 05, 2025 at 07:37:50AM +0200, Miquel Sabaté Solà wrote:
> >> Al Viro @ 2025-10-04 22:19 +01:
> >>
> >> > On Sat, Oct 04, 2025 at 11:03:40PM +0200, Miquel Sabaté Solà wrote:
> >> >> This is a small cleanup in which by using the __free(kfree) cleanup
> >> >> attribute we can avoid three labels to go to, and the code turns to be
> >> >> more concise and easier to follow.
> >> >
> >> > Have you tried to build and boot that?
> >>
> >> Yes, and it worked on my machine...
> >
> > Unfortunately, it ends up calling that kfree() on success as well as on failure.
> > Idiomatic way to avoid that would be
> > 	return no_free_ptr(fdt);
> > but you've left bare
> > 	return fdt;
> > in there, ending up with returning dangling pointers to the caller.  So as
> > soon as you get more than BITS_PER_LONG descriptors used by a process,
> > you'll get trouble.  In particular, bash(1) running as an interactive shell
> > would hit that - it has descriptor 255 opened...
> 
> Ugh, this is just silly from my end...
> 
> You are absolutely right. I don't know what the hell I was doing while
> testing that prevented me from realizing this before, but as you say
> it's quite obvious and I was just blind or something.
> 
> Sorry for the noise and thanks for your patience...

FWIW, the real low-level destructor (__free_fdtable()) *does* cope with ->fd
or ->open_fds left NULL, so theoretically we could replace kmalloc with
kzalloc in alloc_fdtable(), add use that thing via DEFINE_FREE()/__free(...);
I'm not sure if it's a good idea, though - at the very least, that property
of destructor would have to be spelled out with explanations, both in
__free_fdtable() and in alloc_fdtable().

Matter of taste, but IMO it's not worth bothering with - figuring out why
the damn thing is correct would take at least as much time and attention
from readers as the current variant does.

BTW, there's a chance to kill struct fdtable off - a project that got stalled
about a year ago (see https://lore.kernel.org/all/20240806010217.GL5334@ZenIV/
and subthread from there on for details) that just might end up eliminating
that double indirect.  I'm not saying that it's a reason not to do cleanups in
what exists right now, just a tangentially related thing that might be interesting
to resurrect...

