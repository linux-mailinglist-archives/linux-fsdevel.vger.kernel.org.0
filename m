Return-Path: <linux-fsdevel+bounces-8776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D503983ADEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826AE28B4EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115B7E564;
	Wed, 24 Jan 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="T0cDMbuz";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="T0cDMbuz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CA7CF2E;
	Wed, 24 Jan 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112261; cv=none; b=lXjEVRIImU6fl1v2Vz8ef6n25h+Om4uvywTNVIq0wtvNmwAqqSvtZgkzCBSXFAZIZLguVwpTED4v9yBmexg1olW4EHpHOtDOdVzZmmPn8rzD1EnwBD8j1Ovpb9f4oCJ8Z3IWFTX1d0RYv4wkN7f5LjHAofH+C9m1VTxQVWBPrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112261; c=relaxed/simple;
	bh=fasIJ0PrWDB5sYY7xQh7IyoIzqM674SGHD/nrmUzWcg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVEYTwqk2axvm4ZlD3kB9dXkfh13O16ouSBr5QoQuvBWoCnnXT9hHzIQslgQtX/JU5RXQa6vpSrbSAC4o9xK9iDRNACIKH9IBSlohPMjc2rjalVqClfo3Y9Ap82ikeNWYrU7XzV1D/NVBaQ2NvoeVS6EbUol7J6tvAcGOGcGAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=T0cDMbuz; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=T0cDMbuz; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706112257;
	bh=fasIJ0PrWDB5sYY7xQh7IyoIzqM674SGHD/nrmUzWcg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=T0cDMbuzIOvgh0Z+rYA0mBL6+6K3THMlZyogD7Rv9ASLvFOPjp3lYZ96Cu724tJIF
	 kLgHrHoZT0cfbjih14dqGXPTGIJG2whkqMXIXc6NQeKuSgwszJXCeiDiUzieF+VLd1
	 wfm0CFGcknUCF1DovnAKcwHuLXyX60hDUGflMoY4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E8D0D128626F;
	Wed, 24 Jan 2024 11:04:17 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id elb6CRu6YowF; Wed, 24 Jan 2024 11:04:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706112257;
	bh=fasIJ0PrWDB5sYY7xQh7IyoIzqM674SGHD/nrmUzWcg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=T0cDMbuzIOvgh0Z+rYA0mBL6+6K3THMlZyogD7Rv9ASLvFOPjp3lYZ96Cu724tJIF
	 kLgHrHoZT0cfbjih14dqGXPTGIJG2whkqMXIXc6NQeKuSgwszJXCeiDiUzieF+VLd1
	 wfm0CFGcknUCF1DovnAKcwHuLXyX60hDUGflMoY4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 52D091285D7A;
	Wed, 24 Jan 2024 11:04:16 -0500 (EST)
Message-ID: <2e62289ad0fffd2fb8bc7fa179b9a43ab7fe2222.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Rust
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>,  Alice Ryhl <aliceryhl@google.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Kees
 Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>, Dave Chinner
 <dchinner@redhat.com>, David Howells <dhowells@redhat.com>, Ariel Miculas
 <amiculas@cisco.com>, Paul McKenney <paulmck@kernel.org>
Date: Wed, 24 Jan 2024 11:04:14 -0500
In-Reply-To: <ZbEwKjWxdD4HhcA_@casper.infradead.org>
References: 
	<wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
	 <ZbAO8REoMbxWjozR@casper.infradead.org>
	 <cf6a065636b5006235dbfcaf83ff9dbcc51b2d11.camel@HansenPartnership.com>
	 <ZbEwKjWxdD4HhcA_@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-01-24 at 15:43 +0000, Matthew Wilcox wrote:
> On Wed, Jan 24, 2024 at 09:26:34AM -0500, James Bottomley wrote:
> > On Tue, 2024-01-23 at 19:09 +0000, Matthew Wilcox wrote:
> > > >   - The use of outside library code: Historically, C code was
> > > > either written for userspace or the kernel, and not both. But
> > > > that's not particularly true in Rust land (and getting to be
> > > > less true even in C land); should we consider some sort of
> > > > structure or (cough) package management? Is it time to move
> > > > beyond ye olde cut- and-paste?
> > > 
> > > Rust has a package manager.  I don't think we need kCargo.  I'm
> > > not deep enough in the weeds on this to make sensible
> > > suggestions, but if a package (eg a crypto suite or compression
> > > library) doesn't depend on anything ridiculous then what's the
> > > harm in just pulling it in?
> > 
> > The problem with this is that it leads to combinatoric explosions
> > and multiple copies of everything[1].
> 
> OK, but why do we care?  We still have buffer_heads in the kernel
> (v1.0 of the block layer abstraction) while also have bios, iomap and
> numerous NIH in various filesystems.  I don't even know if it's going
> to be quantitatively worse.

Multiple copies lead to kernel bloat and problems for embedded systems
as well as security problems.

> > For crypto in particular the last thing you want to do is pull some
> > random encryption routine off the internet, particularly if the
> > kernel already supplies it because it's usually not properly
> > optimized for your CPU and it makes it a nightmare to deduce the
> > security properties of the system.
> 
> That seems like a strawman.  Why is it _so_ much worse to have your
> kernel compromised than your web browser, your email client, or your
> corporate authentication provider?

If I follow that argument to the logical conclusion you're saying
security of our crypto functions doesn't matter that much because
others also get it wrong?  I'd say that might be slightly controversial
...

To illustrate the problem with cryptography in rust: just because it's
rust safe doesn't mean its correct or bug free.  Crypto functions are
the most difficult to get right (algorithmically, regardless of memory
safety).  Look at this Medium report on the top ten bugs in blockchain:

https://medium.com/rektoff/top-10-vulnerabilities-in-substrate-based-blockchains-using-rust-d454279521ff

Number 1 is a rust crypto vulnerability due to insecure randomness in a
random number generating function (note it was rust safe code just not
properly checked for algorithmic issues by a cryptographer).

The reason for using the kernel functions is that they are vetted by
cryptographers and crafted for our environment.

>   Why would we allow code in that pulls in random shit from the
> internet instead of the vetted stuff on crates.io?

The pallet problem in the blockchain bug came from crates.io.

> > However, there's nothing wrong with a vetted approach to this: keep
> > a list of stuff rust needs, make sure it's properly plumbed in to
> > the kernel routines (which likely necessitates package changes) and
> > keep it somewhere everyone can use.
> 
> ... like crates.io.  Why are we better at this than they are?

The volume is way smaller so scrutiny can be way greater and they have
to be crafted for our environment anyway.

> > [1] just to support this point, I maintain a build of element-
> > desktop that relies on node (which uses the same versioned package
> > management style rust does).  It pulls in 2115 packages of which
> > 417 are version duplicates (same package but different version
> > numbers).
> 
> I'd suggest that node.js has a very different approach from
> crates.io.
> I don't see there being a rust left-pad.

Really?  crates.io currently has 135,010 packages which can all be
uploaded and changed instantly by their respective owners.  Security
vetting is mostly supposed to be done by the uploaders (it can't be
done by the repo since there are so many packages) ... is this starting
to sound familiar?  because it's the same security policy all the web
package repositories have.  Sure they've got safeties in place for
left-pad essential package removals problems, but they could still get
a log4j issue.

James


