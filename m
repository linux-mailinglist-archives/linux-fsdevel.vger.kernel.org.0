Return-Path: <linux-fsdevel+bounces-8797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F583B17C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751C62875FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFE2131E4E;
	Wed, 24 Jan 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xRrF8vo5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E07E778;
	Wed, 24 Jan 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122266; cv=none; b=by3vATXam1vMmnwEqc/i1ZawGbNL/BGvTo0qI5eqvV3czizpKmLLujjwqM2uH4y0WHpScyj+kMo+HIZgv/Xf9DCu3ASBLHmc/DDwKC8coX2NyjB5iJr9r6GmiG0Wb2UXN8DcZBox45eQE5irSHdKtUcPIaYYZkQAcxlDPQm08vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122266; c=relaxed/simple;
	bh=XYCCL3twcWmLJdhjo4kYUTNmhDLnSFBOPOKk1NAsjK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf8Yp4yqSodyzXZIaDF2TYYJ+Xt8Hacjruz1z7AHDsREqzn+XwN0u8AuRj3VJ+fW00Iag/hVEJJHNuZV4ch9dYfEGuMh9IxK02kIbq5Axe4CZIwD33N4VyanIVJxz1It51t6uFfcBeQYMegtdU+ECsJFb6OX/iiSzbKM/JKcA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xRrF8vo5; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jan 2024 13:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706122260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pfnezVEREhW6dZgC9s3OfcWoKEKkqVNG1mZHT/2oQ4=;
	b=xRrF8vo527eQ2Ez/yECby+L1we/jX9raOR52CVQ2Q3WiP5YJC8zgb6z5S+bMrqTAQ+jMl8
	qhi5KcqnoPGaGACAPrPso1Kue74dJaXSF+fSHWZHF7INqzasf6Cta7mKGoR23lA33JPkaS
	qzkOb6vWfLIvTlLOc+WFtxxW9ryAqAI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>, 
	Dave Chinner <dchinner@redhat.com>, David Howells <dhowells@redhat.com>, 
	Ariel Miculas <amiculas@cisco.com>, Paul McKenney <paulmck@kernel.org>
Subject: Re: [LSF/MM TOPIC] Rust
Message-ID: <bmgzm3wjtcyzsuawscxrdyhq56ckc7vqnfbcjbm42gj6eb4qph@wgkhxkk43wxm>
References: <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
 <ZbAO8REoMbxWjozR@casper.infradead.org>
 <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>
 <ZbEwKjWxdD4HhcA_@casper.infradead.org>
 <2e62289ad0fffd2fb8bc7fa179b9a43ab7fe2222.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e62289ad0fffd2fb8bc7fa179b9a43ab7fe2222.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 24, 2024 at 11:04:14AM -0500, James Bottomley wrote:
> On Wed, 2024-01-24 at 15:43 +0000, Matthew Wilcox wrote:
> > On Wed, Jan 24, 2024 at 09:26:34AM -0500, James Bottomley wrote:
> > > On Tue, 2024-01-23 at 19:09 +0000, Matthew Wilcox wrote:
> > > > >   - The use of outside library code: Historically, C code was
> > > > > either written for userspace or the kernel, and not both. But
> > > > > that's not particularly true in Rust land (and getting to be
> > > > > less true even in C land); should we consider some sort of
> > > > > structure or (cough) package management? Is it time to move
> > > > > beyond ye olde cut- and-paste?
> > > > 
> > > > Rust has a package manager.  I don't think we need kCargo.  I'm
> > > > not deep enough in the weeds on this to make sensible
> > > > suggestions, but if a package (eg a crypto suite or compression
> > > > library) doesn't depend on anything ridiculous then what's the
> > > > harm in just pulling it in?
> > > 
> > > The problem with this is that it leads to combinatoric explosions
> > > and multiple copies of everything[1].
> > 
> > OK, but why do we care?  We still have buffer_heads in the kernel
> > (v1.0 of the block layer abstraction) while also have bios, iomap and
> > numerous NIH in various filesystems.  I don't even know if it's going
> > to be quantitatively worse.
> 
> Multiple copies lead to kernel bloat and problems for embedded systems
> as well as security problems.

Yes, but it's a problem we already have, and sure introducing a package
manager might lead to lead to more duplication and bloat if we don't
bother to care about this issue.

But introducing a package manager also means we'll have standard tooling
for checking for duplicated dependencies, so if we make sure to use the
tooling and make it part of the review process we should be fine.

It wouldn't be hard to make checkpatch check for this on changes to
Cargo.lock.

> > > For crypto in particular the last thing you want to do is pull some
> > > random encryption routine off the internet, particularly if the
> > > kernel already supplies it because it's usually not properly
> > > optimized for your CPU and it makes it a nightmare to deduce the
> > > security properties of the system.
> > 
> > That seems like a strawman.  Why is it _so_ much worse to have your
> > kernel compromised than your web browser, your email client, or your
> > corporate authentication provider?
> 
> If I follow that argument to the logical conclusion you're saying
> security of our crypto functions doesn't matter that much because
> others also get it wrong?  I'd say that might be slightly controversial

I think the argument is more just "why exactly is the kernel special
here?". 

> To illustrate the problem with cryptography in rust: just because it's
> rust safe doesn't mean its correct or bug free.  Crypto functions are
> the most difficult to get right (algorithmically, regardless of memory
> safety).  Look at this Medium report on the top ten bugs in blockchain:
> 
> https://medium.com/rektoff/top-10-vulnerabilities-in-substrate-based-blockchains-using-rust-d454279521ff
> 
> Number 1 is a rust crypto vulnerability due to insecure randomness in a
> random number generating function (note it was rust safe code just not
> properly checked for algorithmic issues by a cryptographer).
> 
> The reason for using the kernel functions is that they are vetted by
> cryptographers and crafted for our environment.

Are you arguing that typical kernel code is more secure than typical
Rust code?

> >   Why would we allow code in that pulls in random shit from the
> > internet instead of the vetted stuff on crates.io?
> 
> The pallet problem in the blockchain bug came from crates.io.
> 
> > > However, there's nothing wrong with a vetted approach to this: keep
> > > a list of stuff rust needs, make sure it's properly plumbed in to
> > > the kernel routines (which likely necessitates package changes) and
> > > keep it somewhere everyone can use.
> > 
> > ... like crates.io.  Why are we better at this than they are?
> 
> The volume is way smaller so scrutiny can be way greater and they have
> to be crafted for our environment anyway.

No, and being special snowflakes isn't helpful.

They don't in general have to be crafted for our environment, and we're
slowly working to reduce the differences between the kernel environment
and userspace (gfp flags).

We can and should have our own review process when pulling in new
dependencies, but we shouldn't otherwise be making it difficult to use
crates.io dependencies just for the sake of it.

> Really?  crates.io currently has 135,010 packages which can all be
> uploaded and changed instantly by their respective owners.  Security
> vetting is mostly supposed to be done by the uploaders (it can't be
> done by the repo since there are so many packages) ... is this starting
> to sound familiar?  because it's the same security policy all the web
> package repositories have.  Sure they've got safeties in place for
> left-pad essential package removals problems, but they could still get
> a log4j issue.

Comitting the cargo lockfile pins your dependencies to an exact git
revision, and then updating to new versions of dependencies requires a
new commit in our repository. We have the means to do our own review
here.

