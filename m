Return-Path: <linux-fsdevel+bounces-41859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE68EA385F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A903B6B91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535E021D5B3;
	Mon, 17 Feb 2025 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmWbtd79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16C21D590;
	Mon, 17 Feb 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801709; cv=none; b=rdUekos7XYaSK80MUUH6+AveWKCj6InUHKtROsBTAmOeK/ovyTD9WDhwN/oZcnKbepkPqXlMpWvJ9XjaD68j1pzyMs0LSZWWxc2Axi8OYIvE9CqPRyv4NEgYKcvfufW7MkZwvTbo8ZUpqh0RdsVp80ft9GmpwN/Jc5Hngnapeys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801709; c=relaxed/simple;
	bh=hbSbl71FBK8RCszFFgY/mpfrt95evDjXZ+gnLfbAbl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjL95XKmVhXAg48GAhPlxkBNOKqCeJsjLsfvG04paZDRnQj4FrxNzAfeNuRvVj8m8vs4gjSD0UdcbM8D12HVr7YTVmUfqQx4RMJL0wkeLTJ2gdxeda2GZjCm4VLAqIs4W/0LwsEU0dJT/c/s7hs+GXgWHxW70pxzZaKCjw15gyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmWbtd79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C79EC4CEE4;
	Mon, 17 Feb 2025 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801709;
	bh=hbSbl71FBK8RCszFFgY/mpfrt95evDjXZ+gnLfbAbl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmWbtd79YGOsQE7g644cm2r7vTW1j9N41wPry5NKpsCw2VROU/jplgBhKcYE7QfFK
	 yaUtujHasazFR3kUdmKDlYcP/pSfMtpwvRbF/glBrYcevaX0KM8QgRzrWuWsecHk8L
	 bx9ZPPljdgbeORfH9zFLDqSGR7cw+sFdVe2GXtcWaXeZSs3GdaeDQ4TEs7snOFJ1g9
	 B1uUfubDlBVm9SPTQrLZ9ObWl7tRazXHpYRWNbAqXIT47+XgvhtNq2xy/oLHGLcYKj
	 YZB338Wn2HRE999mHCU3JmpKPWPWBHmdZuF5uI+D9Iq+nC/MktRjGdRRNi4h/DnrW7
	 GzMTXoV3dQ6Gg==
Date: Mon, 17 Feb 2025 15:15:01 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Matthew Wilcox <willy@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
Message-ID: <Z7NEZfuXSr3Ofh1G@cassiopeiae>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
 <Z7MnxKSSNY7IyExt@cassiopeiae>
 <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>

On Mon, Feb 17, 2025 at 09:02:12AM -0500, Tamir Duberstein wrote:
> > > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > > index 6c3bc14b42ad..eb25fabbff9c 100644
> > > --- a/rust/kernel/pci.rs
> > > +++ b/rust/kernel/pci.rs
> > > @@ -73,6 +73,7 @@ extern "C" fn probe_callback(
> > >          match T::probe(&mut pdev, info) {
> > >              Ok(data) => {
> > >                  let data = data.into_foreign();
> > > +                let data = data.cast();
> >
> > Same here and below, see also [2].
> 
> You're the maintainer,

This isn't true. I'm the original author, but I'm not an official maintainer of
this code. :)

> so I'll do what you ask here as well. I did it
> this way because it avoids shadowing the git history with this change,
> which I thought was the dominant preference.

As mentioned in [2], if you do it the other way around first the "rust: types:
add `ForeignOwnable::PointedTo`" patch and then the conversion to cast() it's
even cleaner and less code to change.

> 
> > I understand you like this style and I'm not saying it's wrong or forbidden and
> > for code that you maintain such nits are entirely up to you as far as I'm
> > concerned.
> >
> > But I also don't think there is a necessity to convert things to your preference
> > wherever you touch existing code.
> 
> This isn't a conversion, it's a choice made specifically to avoid
> touching code that doesn't need to be touched (in this instance).

See above.

> 
> > I already explicitly asked you not to do so in [3] and yet you did so while
> > keeping my ACK. :(
> >
> > (Only saying the latter for reference, no need to send a new version of [3],
> > otherwise I would have replied.)
> >
> > [2] https://lore.kernel.org/rust-for-linux/Z7MYNQgo28sr_4RS@cassiopeiae/
> > [3] https://lore.kernel.org/rust-for-linux/20250213-aligned-alloc-v7-1-d2a2d0be164b@gmail.com/
> 
> I will drop [2] and leave the `as _` casts in place to minimize
> controversy here.

As mentioned I think the conversion to cast() is great, just do it after this
one and keep it a single line -- no controversy. :)

