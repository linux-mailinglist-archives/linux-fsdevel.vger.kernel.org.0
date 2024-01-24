Return-Path: <linux-fsdevel+bounces-8775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372C183AD9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 16:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35021F28DF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35CF7C0B3;
	Wed, 24 Jan 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ad6Cqdxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB75B7C08B;
	Wed, 24 Jan 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111026; cv=none; b=NHBcidUXfBx+En24G/owSC0inLq3utstNR7ZPdKpWkwJE/iUI8LUNjRQ3lwZ8YG++TUUQ+YiMVbQzC235v98ReKltIYLWqWgPF6wt6ihdaVhE9LkFmOi5xos25xKpCcMtSjd2KX80985Jv7eLhHCkBt0CLIrECxAn5X2w105fWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111026; c=relaxed/simple;
	bh=YF0VeK0JGetToSGO2ElfmGFh4NZvSbnTo84Fho2S6yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCPIoKK/DANW3Uk22toEiwGh9X2v8HvLVKwOHyLf0vv9iO3hva+q12ViEbb451J9033ym3haKPH4hocf42/79wcfewKdQO0bKZKXp6B9t2bhDxJ6btr3rvH+KxjuVk+1zlFj6eZEjtVHV8kXa67TqvlvqcAEpsoX6AlT7prKN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ad6Cqdxx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GvdY4MaSQClVJBs7CtStbKT7OOMHk0OQL6w1/cF4GJk=; b=Ad6CqdxxcazX9WVt0rOgREG3Dg
	eOQFzlJYdB9KLaoxeNDCM4S2dVge9DM0OWLJtton4oMc5J9C9qxlv8cVeI3R6GS9t9JERCdgxpnyM
	IbOT87XmOzIei0Cy/iVRoGDco5M33Egc/RpQJ7ci6gexCymS+WQhEr7SkjnhfP2yhM5prjtOA69RX
	ROGTl9ZcgJd0VCQroWLiRO2guVbA2wg0UotE6mSSXtEZEfsDNWgQ/z1E0f2XzdO46tjYsGZx96QB0
	efU6K8F9T7zobFF02wgGI7zesERdV8o1qlyYjN/mGk0FawXP/eRv2Si+APZQCyODl2bIR3GCrr0La
	lG+H1l4g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSfPe-0000000737q-44n9;
	Wed, 24 Jan 2024 15:43:39 +0000
Date: Wed, 24 Jan 2024 15:43:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>,
	Dave Chinner <dchinner@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Ariel Miculas <amiculas@cisco.com>,
	Paul McKenney <paulmck@kernel.org>
Subject: Re: [LSF/MM TOPIC] Rust
Message-ID: <ZbEwKjWxdD4HhcA_@casper.infradead.org>
References: <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
 <ZbAO8REoMbxWjozR@casper.infradead.org>
 <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>

On Wed, Jan 24, 2024 at 09:26:34AM -0500, James Bottomley wrote:
> On Tue, 2024-01-23 at 19:09 +0000, Matthew Wilcox wrote:
> > >   - The use of outside library code: Historically, C code was
> > > either written for userspace or the kernel, and not both. But
> > > that's not particularly true in Rust land (and getting to be less
> > > true even in C land); should we consider some sort of structure or
> > > (cough) package management? Is it time to move beyond ye olde cut-
> > > and-paste?
> > 
> > Rust has a package manager.  I don't think we need kCargo.  I'm not
> > deep enough in the weeds on this to make sensible suggestions, but if
> > a package (eg a crypto suite or compression library) doesn't depend
> > on anything ridiculous then what's the harm in just pulling it in?
> 
> The problem with this is that it leads to combinatoric explosions and
> multiple copies of everything[1].

OK, but why do we care?  We still have buffer_heads in the kernel (v1.0
of the block layer abstraction) while also have bios, iomap and numerous
NIH in various filesystems.  I don't even know if it's going to be
quantitatively worse.

> For crypto in particular the last
> thing you want to do is pull some random encryption routine off the
> internet, particularly if the kernel already supplies it because it's
> usually not properly optimized for your CPU and it makes it a nightmare
> to deduce the security properties of the system.

That seems like a strawman.  Why is it _so_ much worse to have your kernel
compromised than your web browser, your email client, or your corporate
authentication provider?  Why would we allow code in that pulls in random
shit from the internet instead of the vetted stuff on crates.io?

> However, there's nothing wrong with a vetted approach to this: keep a
> list of stuff rust needs, make sure it's properly plumbed in to the
> kernel routines (which likely necessitates package changes) and keep it
> somewhere everyone can use.

... like crates.io.  Why are we better at this than they are?

> [1] just to support this point, I maintain a build of element-desktop
> that relies on node (which uses the same versioned package management
> style rust does).  It pulls in 2115 packages of which 417 are version
> duplicates (same package but different version numbers).

I'd suggest that node.js has a very different approach from crates.io.
I don't see there being a rust left-pad.

