Return-Path: <linux-fsdevel+bounces-8865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C9983BD30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F12B28A48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE11BC5E;
	Thu, 25 Jan 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6X1S99c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D0A1BC42
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174700; cv=none; b=s0Duka/Qrk/GmyjBL/aEpmRHO9efbQopZoybjt3yrGOue7vsYi/vMxzjtZxvixPtNvArkgvho1lKmLyK5VoxxIEz8gbZAcNIqVgVva/QZMwP+O70X3070jz7lIU8K3oZ7xMFYC/At2sFI/1rHIcpYC9D00qKGZrONYuJz97Zmes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174700; c=relaxed/simple;
	bh=6UE0SRZjvyyFYa0SX3uCauVIXNPtguWCaX+ojo6xL+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp7oGQIN9NKVqPW0qt2+TsecRcqlXSvO5fsO+zRsDweL87q6B2UjrAxD0HTbX0frTLc5FyUvyKVep4a3aoziQito/RjvVN1bZ5kCEf6bIqa+wzWLg+rY4jiPFxREBNzH4ADG5trIIbBnpdsdh6VayG/cMbYVb+HUa1gCcaHq7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j6X1S99c; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Jan 2024 04:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706174695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FEZJDPSztwlSq+bBHVyJk6lavPwpvO/fWxjbdKAveY=;
	b=j6X1S99c9OqDmQhk+o5Od38phw8NAKGavG3oZo8uC4PTJoO3P6QEPqRtA01s2ujlCH9oXY
	gkfSNnMIxE4uzurxHKHo11ZFaSnX/dyEffUWQgzVDU5JoksOsSFK1/EH/ABiSvESxg7mbi
	71x6JxAny+kOXOHYj/PdbxfFqz8RuNk=
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
Message-ID: <dd7w7t42m2mckgal7sl5azop6tlue4wog7yxz52g2val77fye7@hm5gvdkwzw23>
References: <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
 <ZbAO8REoMbxWjozR@casper.infradead.org>
 <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>
 <ZbEwKjWxdD4HhcA_@casper.infradead.org>
 <2e62289ad0fffd2fb8bc7fa179b9a43ab7fe2222.camel@HansenPartnership.com>
 <bmgzm3wjtcyzsuawscxrdyhq56ckc7vqnfbcjbm42gj6eb4qph@wgkhxkk43wxm>
 <37f44c1409334f5dc15d7421e8b7cd3a4ff9ae33.camel@HansenPartnership.com>
 <4yzecrleclh4prjqw633r6m2jvs7cbtfznjm7azdaxpp2vvmn6@cjxk3ueacoe5>
 <c368f1a22e271f96a49a4eab438b040959782387.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c368f1a22e271f96a49a4eab438b040959782387.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 24, 2024 at 10:47:22PM -0500, James Bottomley wrote:
> On Wed, 2024-01-24 at 14:57 -0500, Kent Overstreet wrote:
> > On Wed, Jan 24, 2024 at 02:43:21PM -0500, James Bottomley wrote:
> > > On Wed, 2024-01-24 at 13:50 -0500, Kent Overstreet wrote:
> > > > > To illustrate the problem with cryptography in rust: just
> > > > > because it's rust safe doesn't mean its correct or bug free. 
> > > > > Crypto functions are the most difficult to get right
> > > > > (algorithmically, regardless of memory safety).  Look at this
> > > > > Medium report on the top ten bugs in blockchain:
> > > > > 
> > > > > https://medium.com/rektoff/top-10-vulnerabilities-in-substrate-based-blockchains-using-rust-d454279521ff
> > > > > 
> > > > > Number 1 is a rust crypto vulnerability due to insecure
> > > > > randomness in a random number generating function (note it was
> > > > > rust safe code just not properly checked for algorithmic issues
> > > > > by a cryptographer).
> > > > > 
> > > > > The reason for using the kernel functions is that they are
> > > > > vetted by cryptographers and crafted for our environment.
> > > > 
> > > > Are you arguing that typical kernel code is more secure than
> > > > typical Rust code?
> > > 
> > > For crypto code?  Absolutely, that's what the example above showed.
> > > It's pretty much impossible to use an insecure rng in the kernel if
> > > you plug into one of our existing APIs.  That's obviously not
> > > necessarily true if you pull a random one from crates.io.
> > > 
> > > James
> > 
> > I can just as easily use prandom.h instead of random.h in the kernel;
> 
> Neither of which would be insecure ...

Are you claiming that
        
/* Pseudo random number generator from numerical recipes. */
static inline u32 next_pseudo_random32(u32 seed)
{
        return seed * 1664525 + 1013904223;
}

is a secure RNG?

> 
> > this just comes down to Rust not being able to save you from
> > arbitrary logic errors. But all the data we have so far from CVEs and
> > bug reports shows that Rust code is _dramatically_ more secure than
> > any C code, even kernel code.
> 
> I've said it thrice the bellman cried and what I tell you three times
> is true.
> 
> Back in the real world, the literature seems to show that rust code has
> about the same bug density as any other code (including C). 

You might want to re-read that literature...

