Return-Path: <linux-fsdevel+bounces-8810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A469783B2A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AD3B26A47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF29133422;
	Wed, 24 Jan 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q52Uawls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD58131756
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126248; cv=none; b=JVgnjgkLfT4jHPryNRCGSwu29x8GEe85gX3kgcJLqO6ECkRIp6Bvc8uLJbjv3kUnj/WM62NnfbzwSBWpxuvYQ18wOoR6xDNSJBBYMPFJZ8E7kuedz1gAZumrFSqBP8nNMgmmZkOcsfsLEWwNVD+QwKEK/v5CgAV/VdAy/hzFQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126248; c=relaxed/simple;
	bh=UcZRabghaZ0pffmG7ZuTjqIi0FbWnK1BC0w+NXBkj6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbtFwcIqHdLA5rPFAwdrfHXcYC0ChmGONrgFkLpt2bKzlp7sdBJ1Kpv++nRV3ESSq59QzMOQdoyAsMAm3SVrmFV98JdLNa8wlZ+7rSfuhhgmfMKPaFqk6SHawjokelYrNiv7mPr6s9FV9ZMODIts5awZmyhKPJKcWag1t2cG6F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q52Uawls; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jan 2024 14:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706126244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0/oqAi1DiBLdRVJXBjflU/z9ZSquFg+SWWTXG75dyA=;
	b=Q52UawlspQj5g/tuyQVztm1TvHSU+NS8Yv6sDC1dSxpYfMK/Hzk35WCPIlUwSfZYApsSd4
	luekHavggSrW+wr3Q9e2wvIAmpbo1hJTyklcY2F50Bk/c/4blFzBe39f8PpC5AREZeExWN
	oMa2X64seRHmDTKEYq6uVyzNP4cTqyQ=
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
Message-ID: <4yzecrleclh4prjqw633r6m2jvs7cbtfznjm7azdaxpp2vvmn6@cjxk3ueacoe5>
References: <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
 <ZbAO8REoMbxWjozR@casper.infradead.org>
 <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>
 <ZbEwKjWxdD4HhcA_@casper.infradead.org>
 <2e62289ad0fffd2fb8bc7fa179b9a43ab7fe2222.camel@HansenPartnership.com>
 <bmgzm3wjtcyzsuawscxrdyhq56ckc7vqnfbcjbm42gj6eb4qph@wgkhxkk43wxm>
 <37f44c1409334f5dc15d7421e8b7cd3a4ff9ae33.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37f44c1409334f5dc15d7421e8b7cd3a4ff9ae33.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 24, 2024 at 02:43:21PM -0500, James Bottomley wrote:
> On Wed, 2024-01-24 at 13:50 -0500, Kent Overstreet wrote:
> > > To illustrate the problem with cryptography in rust: just because
> > > it's rust safe doesn't mean its correct or bug free.  Crypto
> > > functions are the most difficult to get right (algorithmically,
> > > regardless of memory safety).  Look at this Medium report on the
> > > top ten bugs in blockchain:
> > > 
> > > https://medium.com/rektoff/top-10-vulnerabilities-in-substrate-based-blockchains-using-rust-d454279521ff
> > > 
> > > Number 1 is a rust crypto vulnerability due to insecure randomness
> > > in a random number generating function (note it was rust safe code
> > > just not properly checked for algorithmic issues by a
> > > cryptographer).
> > > 
> > > The reason for using the kernel functions is that they are vetted
> > > by cryptographers and crafted for our environment.
> > 
> > Are you arguing that typical kernel code is more secure than typical
> > Rust code?
> 
> For crypto code?  Absolutely, that's what the example above showed. 
> It's pretty much impossible to use an insecure rng in the kernel if you
> plug into one of our existing APIs.  That's obviously not necessarily
> true if you pull a random one from crates.io.
> 
> James

I can just as easily use prandom.h instead of random.h in the kernel;
this just comes down to Rust not being able to save you from arbitrary
logic errors. But all the data we have so far from CVEs and bug reports
shows that Rust code is _dramatically_ more secure than any C code, even
kernel code.

