Return-Path: <linux-fsdevel+bounces-9009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAB683CEA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 22:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DC9299E10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 21:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B2913A26D;
	Thu, 25 Jan 2024 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="L/uij/Lo";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="L/uij/Lo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041D137C4A;
	Thu, 25 Jan 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218208; cv=none; b=S4KSNuqsRPWDreIyfkdNHZFUeFohkpA1QG4Zp1xIwmOIIZ+7MXKKRdJnynQhGRC17QLw82NfkSwUDPcMZGEPNqUH9T1SL4r7yVi9S2jx8pIhqCxgrH9zZVH2uT5lq/JEXGb77IDQRPBXGK+Vnb7/be2VHyhWckYHcVVQTL9nOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218208; c=relaxed/simple;
	bh=ASPx7+zMtCatuRRLO5tMl/H/PNMnqVQ9t//4ppXH93o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/onr6Wvj5i7dV6xnAd/EQH8cuC5+sONkoLKKG8kbwrDv53vPLuKbNWnBGyUECi+VtRTIeZXIlIZksOx6ZeqI+DzLLfqrtK4t4dYpq2KfyCapp71GTYbX1jA2hp9zqFtIxWxW4+8j7cd3VeLdKEZGJDoE+bdhnYIxSfA4e3+/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=L/uij/Lo; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=L/uij/Lo; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706218204;
	bh=ASPx7+zMtCatuRRLO5tMl/H/PNMnqVQ9t//4ppXH93o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=L/uij/LoHTJ8a0eF9WxaTaV7vCowOQOLKgWd/RKordZdZe5NAWgZIIftyBolNWeXx
	 Ihf2p1EmcJQoyHZLFT3BQCSZZSvrshJOiBmuYKT21IiFmeXA9YCzV7eS2F8ndStB/a
	 e5axczPm5u/dKpJGodAIkStqx0fXVTttE3uDWP4I=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A5F1F128189E;
	Thu, 25 Jan 2024 16:30:04 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id XhTnIQp3kvfA; Thu, 25 Jan 2024 16:30:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706218204;
	bh=ASPx7+zMtCatuRRLO5tMl/H/PNMnqVQ9t//4ppXH93o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=L/uij/LoHTJ8a0eF9WxaTaV7vCowOQOLKgWd/RKordZdZe5NAWgZIIftyBolNWeXx
	 Ihf2p1EmcJQoyHZLFT3BQCSZZSvrshJOiBmuYKT21IiFmeXA9YCzV7eS2F8ndStB/a
	 e5axczPm5u/dKpJGodAIkStqx0fXVTttE3uDWP4I=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 002021281291;
	Thu, 25 Jan 2024 16:30:02 -0500 (EST)
Message-ID: <fafee46bae1a1fc378eb48f808376fd10564088c.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Rust
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org,
  linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Miguel
 Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Kees
 Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>, Dave Chinner
 <dchinner@redhat.com>, David Howells <dhowells@redhat.com>, Ariel Miculas
 <amiculas@cisco.com>, Paul McKenney <paulmck@kernel.org>
Date: Thu, 25 Jan 2024 16:30:01 -0500
In-Reply-To: <dd7w7t42m2mckgal7sl5azop6tlue4wog7yxz52g2val77fye7@hm5gvdkwzw23>
References: 
	<wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
	 <ZbAO8REoMbxWjozR@casper.infradead.org>
	 <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>
	 <ZbEwKjWxdD4HhcA_@casper.infradead.org>
	 <2e62289ad0fffd2fb8bc7fa179b9a43ab7fe2222.camel@HansenPartnership.com>
	 <bmgzm3wjtcyzsuawscxrdyhq56ckc7vqnfbcjbm42gj6eb4qph@wgkhxkk43wxm>
	 <37f44c1409334f5dc15d7421e8b7cd3a4ff9ae33.camel@HansenPartnership.com>
	 <4yzecrleclh4prjqw633r6m2jvs7cbtfznjm7azdaxpp2vvmn6@cjxk3ueacoe5>
	 <c368f1a22e271f96a49a4eab438b040959782387.camel@HansenPartnership.com>
	 <dd7w7t42m2mckgal7sl5azop6tlue4wog7yxz52g2val77fye7@hm5gvdkwzw23>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-01-25 at 04:24 -0500, Kent Overstreet wrote:
> On Wed, Jan 24, 2024 at 10:47:22PM -0500, James Bottomley wrote:
> > On Wed, 2024-01-24 at 14:57 -0500, Kent Overstreet wrote:
> > > On Wed, Jan 24, 2024 at 02:43:21PM -0500, James Bottomley wrote:
> > > > On Wed, 2024-01-24 at 13:50 -0500, Kent Overstreet wrote:
> > > > > > To illustrate the problem with cryptography in rust: just
> > > > > > because it's rust safe doesn't mean its correct or bug
> > > > > > free.  Crypto functions are the most difficult to get right
> > > > > > (algorithmically, regardless of memory safety).  Look at
> > > > > > this Medium report on the top ten bugs in blockchain:
> > > > > > 
> > > > > > https://medium.com/rektoff/top-10-vulnerabilities-in-substrate-based-blockchains-using-rust-d454279521ff
> > > > > > 
> > > > > > Number 1 is a rust crypto vulnerability due to insecure
> > > > > > randomness in a random number generating function (note it
> > > > > > was rust safe code just not properly checked for
> > > > > > algorithmic issues by a cryptographer).
> > > > > > 
> > > > > > The reason for using the kernel functions is that they are
> > > > > > vetted by cryptographers and crafted for our environment.
> > > > > 
> > > > > Are you arguing that typical kernel code is more secure than
> > > > > typical Rust code?
> > > > 
> > > > For crypto code?  Absolutely, that's what the example above
> > > > showed. It's pretty much impossible to use an insecure rng in
> > > > the kernel if you plug into one of our existing APIs.  That's
> > > > obviously not necessarily true if you pull a random one from
> > > > crates.io.
> > > > 
> > > > James
> > > 
> > > I can just as easily use prandom.h instead of random.h in the
> > > kernel;
> > 
> > Neither of which would be insecure ...
> 
> Are you claiming that
>         
> /* Pseudo random number generator from numerical recipes. */
> static inline u32 next_pseudo_random32(u32 seed)
> {
>         return seed * 1664525 + 1013904223;
> }
> 
> is a secure RNG?

It's the best linear congruence generator for 32 bits, yes; it's
straight out of Knuth.   However, I assume you picked that one becuase
you know it's only used in testing to generate a repeatable series of
numbers.  The actual prandom_ API is based on an internally seeded
linear feedback shift register algorithm.

The trick to using PRNGs correctly is 1) knowing you can use them and
don't need cryptographic randomness and 2) seeding them correctly,
which is where the rust problem came from and which you can't get wrong
in Linux because it's done directly from the entropy pool.

James



