Return-Path: <linux-fsdevel+bounces-30841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA19898EB70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 10:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF6F1C21C85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0013BAE4;
	Thu,  3 Oct 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsCFc0te"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634913B2A4;
	Thu,  3 Oct 2024 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943551; cv=none; b=NvAoCC+yQ7TOXz+0OzlJcVxJkko7eDtWr1s8v0n7i58h6Nqp38q/jkTPMNkcQ65cgnx/O4LPEtIId0wW6s4APBbUrZKiInw+r/p2JxDUjXJopJGmWSHipmGFGxCi73/tG2ukSTYQ2MX0LlMw7wtfBSPF0rvJehch7p15S1ujKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943551; c=relaxed/simple;
	bh=Sf2jAhCrBHj1PNT38EqZYJc/PjNKrs+9dSnGLkOkVu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMsGaby3Z/WVq3DqE9/sW6Z5vX7436030KAJ7U5cUxqRS0eoYM2UQJN8vYu1biVP53ON+6LevCfMvHRFHsa/kaLyjIhG+UqHtV0A9/q7W17A9czdUTdPI/pGAO0Y2/wzN0cUYfQB5+ZtlYJqFJSruglkvJhXAD1k3S4sqCnnrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsCFc0te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B11CC4CEC7;
	Thu,  3 Oct 2024 08:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727943549;
	bh=Sf2jAhCrBHj1PNT38EqZYJc/PjNKrs+9dSnGLkOkVu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsCFc0teaEQlieD/Op2ltdZsN8k/YaufkzILkrycIkaoGM3B/NvdwInUwRXttrq1x
	 7ZdewxBepJmB0b33keOst7U00WhsOcg5QRPQA0MhO5nLRwxEXnZuxWiAuxFf1rrvKi
	 wCOeSZmIwiRglbPYFCpF6Jg9wdWYNQQGvw4IuEP7kRo/6DFyKWF5/ALlnuRyEcWmrz
	 68YqkxhDq1iHAMxR+pHSMTrdc0SILaSckwD8mB9+FVWu5ydRd3zSCfKfnVNQI9q23j
	 An5R86v8vvOaC4oO1E/uTtrNw9UYuBkcpTbOae3OfL85nBHdtWZTDqbokCOLNR+s5A
	 ga3vOoQEFBXiw==
Date: Thu, 3 Oct 2024 10:19:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Message-ID: <20241003-putzig-umhang-587b3e6acff8@brauner>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
 <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <20241002-rabiat-ehren-8c3d1f5a133d@brauner>
 <CAH5fLgjdpF7F03ORSKkb+r3+nGfrnA+q1GKw=KHCHASrkz1NPw@mail.gmail.com>
 <20241002-inbegriff-getadelt-9275ce925594@brauner>
 <10dca723-73e2-4757-8e94-22407f069a75@app.fastmail.com>
 <2024100223-unwitting-girdle-92a5@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024100223-unwitting-girdle-92a5@gregkh>

On Wed, Oct 02, 2024 at 06:04:38PM GMT, Greg Kroah-Hartman wrote:
> On Wed, Oct 02, 2024 at 03:45:08PM +0000, Arnd Bergmann wrote:
> > On Wed, Oct 2, 2024, at 14:23, Christian Brauner wrote:
> > 
> > > and then copy the stuff via copy_struct_from_user() or copy back out to
> > > user via other means.
> > >
> > > This way you can safely extend ioctl()s in a backward and forward
> > > compatible manner and if we can enforce this for new drivers then I
> > > think that's what we should do.
> > 
> > I don't see much value in building generic code for ioctl around
> > this specific variant of extensibility. Extending ioctl commands
> > by having a larger structure that results in a new cmd code
> > constant is fine, but there is little difference between doing
> > this with the same or a different 'nr' value. Most drivers just
> > always use a new nr here, and I see no reason to discourage that.
> > 
> > There is actually a small risk in your example where it can
> > break if you have the same size between native and compat
> > variants of the same command, like
> > 
> > struct old {
> >     long a;
> > };
> > 
> > struct new {
> >     long a;
> >     int b;
> > };
> > 
> > Here, the 64-bit 'old' has the same size as the 32-bit 'new',
> > so if we try to handle them in a shared native/compat ioctl
> > function, this needs an extra in_conmpat_syscall() check that
> > adds complexity and is easy to forget.
> 
> Agreed, "extending" ioctls is considered a bad thing and it's just
> easier to create a new one.  Or use some flags and reserved fields, if
> you remember to add them in the beginning...

This statement misses the reality of what has been happening outside of
arbitrary drivers for years. Let alone that it simply asserts that it's
a bad thing.

