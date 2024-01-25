Return-Path: <linux-fsdevel+bounces-8839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD383B879
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 04:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12EC2853F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 03:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830BA79F5;
	Thu, 25 Jan 2024 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YL9qBxB8";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="fsgLgirK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EBD7489;
	Thu, 25 Jan 2024 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154449; cv=none; b=Xt4YPDBLpDccwnmr6SXkluy747g2qSqRUxddPbJMLcueJ4d4xN1S31SIhcoXKfnDGUO5kD6ygEJDrCUDaFuIwWqiY4jhppaM5Q9MpRWtK/AsV8NZtwjKyq1zbrtruO17kngDa1A8TjrxRrFgj4Et1aQZpO2REp0pHRiKBNXGZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154449; c=relaxed/simple;
	bh=ZjLMYFdfKY7zfT35BRJ219TV857F6P+ZP1+xHv635go=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AE+HpvrtXWf4i3HsXD2GVpJQJxZRk3mOARSFBc0SRTw6wF/h/S4JXO0BaP4KfosVdtSu4Tfkrj8O5YzAAz0le1WpJ6MpApRnRDPZgdEmFGpxJcaswsCRncrB+sFW24+c4pSrXT6i4xkDypBINgiFeeEYyTpPTbYtBU5S6Out/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=YL9qBxB8; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=fsgLgirK; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706154446;
	bh=ZjLMYFdfKY7zfT35BRJ219TV857F6P+ZP1+xHv635go=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=YL9qBxB8rmXrVUP2wvIzsy95J5wxMuXIdx+URN22csaVJESKYsX6UgVrf/yH6GwHH
	 4wZ/Jvksr2wp9uIBHGBgfwNCDuqARVeYx0Ely4k9eFp92WsErfoPYpgZbQeVh9Iba2
	 pfXteLrEoXWG+4qA32j0iRq6OXg/tZy8W4g4o7CI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0CAF21280A41;
	Wed, 24 Jan 2024 22:47:26 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hwqxZ0ieK8S6; Wed, 24 Jan 2024 22:47:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706154445;
	bh=ZjLMYFdfKY7zfT35BRJ219TV857F6P+ZP1+xHv635go=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=fsgLgirK6U6/ihHvoQz8t+Sju0qDPzwC9zaPg0N0+4hIMxdc4v1WsZ9xydkDklhdG
	 20qanvPgrKu7g8quDCNukjgBWjnTWzwE9ROZ7eeQA4K4T1PBPIil8LWiq7SWkwB+Uv
	 9d+QxmnUTxWeN0TOk3mqhu73ix1L/BgsyQv0dD9Q=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7D6951280658;
	Wed, 24 Jan 2024 22:47:24 -0500 (EST)
Message-ID: <c368f1a22e271f96a49a4eab438b040959782387.camel@HansenPartnership.com>
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
Date: Wed, 24 Jan 2024 22:47:22 -0500
In-Reply-To: <4yzecrleclh4prjqw633r6m2jvs7cbtfznjm7azdaxpp2vvmn6@cjxk3ueacoe5>
References: 
	<wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
	 <ZbAO8REoMbxWjozR@casper.infradead.org>
	 <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>
	 <ZbEwKjWxdD4HhcA_@casper.infradead.org>
	 <2e62289ad0fffd2fb8bc7fa179b9a43ab7fe2222.camel@HansenPartnership.com>
	 <bmgzm3wjtcyzsuawscxrdyhq56ckc7vqnfbcjbm42gj6eb4qph@wgkhxkk43wxm>
	 <37f44c1409334f5dc15d7421e8b7cd3a4ff9ae33.camel@HansenPartnership.com>
	 <4yzecrleclh4prjqw633r6m2jvs7cbtfznjm7azdaxpp2vvmn6@cjxk3ueacoe5>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-01-24 at 14:57 -0500, Kent Overstreet wrote:
> On Wed, Jan 24, 2024 at 02:43:21PM -0500, James Bottomley wrote:
> > On Wed, 2024-01-24 at 13:50 -0500, Kent Overstreet wrote:
> > > > To illustrate the problem with cryptography in rust: just
> > > > because it's rust safe doesn't mean its correct or bug free. 
> > > > Crypto functions are the most difficult to get right
> > > > (algorithmically, regardless of memory safety).  Look at this
> > > > Medium report on the top ten bugs in blockchain:
> > > > 
> > > > https://medium.com/rektoff/top-10-vulnerabilities-in-substrate-based-blockchains-using-rust-d454279521ff
> > > > 
> > > > Number 1 is a rust crypto vulnerability due to insecure
> > > > randomness in a random number generating function (note it was
> > > > rust safe code just not properly checked for algorithmic issues
> > > > by a cryptographer).
> > > > 
> > > > The reason for using the kernel functions is that they are
> > > > vetted by cryptographers and crafted for our environment.
> > > 
> > > Are you arguing that typical kernel code is more secure than
> > > typical Rust code?
> > 
> > For crypto code?  Absolutely, that's what the example above showed.
> > It's pretty much impossible to use an insecure rng in the kernel if
> > you plug into one of our existing APIs.  That's obviously not
> > necessarily true if you pull a random one from crates.io.
> > 
> > James
> 
> I can just as easily use prandom.h instead of random.h in the kernel;

Neither of which would be insecure ...

> this just comes down to Rust not being able to save you from
> arbitrary logic errors. But all the data we have so far from CVEs and
> bug reports shows that Rust code is _dramatically_ more secure than
> any C code, even kernel code.

I've said it thrice the bellman cried and what I tell you three times
is true.

Back in the real world, the literature seems to show that rust code has
about the same bug density as any other code (including C). 
Ironically, memory safety is still an issue because of the inability to
reduce unsafe areas in rust code.  I suspect the density is high simply
because the rust code is newer (bug density in new code tends to be
higher simply due to the human input rate of algorithmic defects), so
this may evolve better over time, but it doesn't change the calculus
that older more vetted code is better than rewriting that code in rust
because the rewrite tends to introduce new bugs.

James


