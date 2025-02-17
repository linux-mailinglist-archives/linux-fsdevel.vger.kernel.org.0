Return-Path: <linux-fsdevel+bounces-41861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3C3A386BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF2A7A3E53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD8C223707;
	Mon, 17 Feb 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhBkePjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAF3215F40;
	Mon, 17 Feb 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803074; cv=none; b=sw//wOCdpLbdxRybw9O125H58wav9wLCivehuSvoy2PDzgsFyUknwbFFUFdybnmcitVGPMZ7zNXOGzblgfYKp+QLTbURcN4UyGPTW20rKyVb94QacR4Lz+aaWuQM6CuMn5JeQggHaX/4jdRKqn070oC589J7kScbniKWZvdnovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803074; c=relaxed/simple;
	bh=/OwhTvXO606OA4pqdHgVMbVF9fCjRmz8tESTQDrpLhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlSm8BUu2cA/kzc2dy0f0myMkhvoJny+aCGWQ1i8Wt+pVXdSez1aF4LMCQrU4wG1yp3/FuXd1lGK5Gd9ZCRCZMFl9iq8hTtNkP1+qx65B8+9C6COcFX92IHLVejWoxEI2HaUpNEN1q1ZwiqzTtRwjpELioKkkENPFaqTREiz2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhBkePjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CADC4CEE9;
	Mon, 17 Feb 2025 14:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739803074;
	bh=/OwhTvXO606OA4pqdHgVMbVF9fCjRmz8tESTQDrpLhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhBkePjHukuGEqv8NyIXqXDPDDV6g0I8eFkKkKc+Rd2Sho2XK+uLSe8YWAuEwa+PU
	 vhZuc5HNzWffTsZPbDezTUdLkASDk4JvMV0QKQvvUg8wEibV4RaergFyLy9ppRUxX7
	 CkmWMVNb5C9zJUHQicigF7XDY7y4ZKuvXtP7jeNJ2RhUgEbOu7AyCzkIwGWJv49WOl
	 iZ+gKDcE6p/ZS5pqeiEnICVF+Xca3teZWK3F9e+Z04MIyYmt+HREEH/Go+BcaS+8fU
	 2MxpVpXUfT/lhmQvYVf7pDVw7ncyxPmIleji2bxyT++NWRMQ2CvAwfIFXin2rC6dIU
	 gvouA5QrVUSNg==
Date: Mon, 17 Feb 2025 15:37:46 +0100
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
Message-ID: <Z7NJugCD3FThZpbI@cassiopeiae>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
 <Z7MnxKSSNY7IyExt@cassiopeiae>
 <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
 <Z7NEZfuXSr3Ofh1G@cassiopeiae>
 <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>

On Mon, Feb 17, 2025 at 09:21:00AM -0500, Tamir Duberstein wrote:
> On Mon, Feb 17, 2025 at 9:15 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Mon, Feb 17, 2025 at 09:02:12AM -0500, Tamir Duberstein wrote:
> > > > > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > > > > index 6c3bc14b42ad..eb25fabbff9c 100644
> > > > > --- a/rust/kernel/pci.rs
> > > > > +++ b/rust/kernel/pci.rs
> > > > > @@ -73,6 +73,7 @@ extern "C" fn probe_callback(
> > > > >          match T::probe(&mut pdev, info) {
> > > > >              Ok(data) => {
> > > > >                  let data = data.into_foreign();
> > > > > +                let data = data.cast();
> > > >
> > > > Same here and below, see also [2].
> > >
> > > You're the maintainer,
> >
> > This isn't true. I'm the original author, but I'm not an official maintainer of
> > this code. :)
> >
> > > so I'll do what you ask here as well. I did it
> > > this way because it avoids shadowing the git history with this change,
> > > which I thought was the dominant preference.
> >
> > As mentioned in [2], if you do it the other way around first the "rust: types:
> > add `ForeignOwnable::PointedTo`" patch and then the conversion to cast() it's
> > even cleaner and less code to change.
> 
> This is true for the two instances of `as _`,

Yes, those are the ones I talk about.

> but not for all the
> other instances where currently there's no cast, but one is now
> needed.
> 
> > >
> > > > I understand you like this style and I'm not saying it's wrong or forbidden and
> > > > for code that you maintain such nits are entirely up to you as far as I'm
> > > > concerned.
> > > >
> > > > But I also don't think there is a necessity to convert things to your preference
> > > > wherever you touch existing code.
> > >
> > > This isn't a conversion, it's a choice made specifically to avoid
> > > touching code that doesn't need to be touched (in this instance).
> >
> > See above.
> 
> This doesn't address my point. I claim that
> 
> @@ -246,6 +248,7 @@ impl<T: MiscDevice> VtableHelper<T> {
>  ) -> c_int {
>      // SAFETY: The release call of a file owns the private data.
>      let private = unsafe { (*file).private_data };
> +    let private = private.cast();
>      // SAFETY: The release call of a file owns the private data.
>      let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
> 
> is a better diff than
> 
> @@ -245,7 +245,7 @@ impl<T: MiscDevice> VtableHelper<T> {
>      file: *mut bindings::file,
>  ) -> c_int {
>      // SAFETY: The release call of a file owns the private data.
> -    let private = unsafe { (*file).private_data };
> +    let private = unsafe { (*file).private_data }.cast();
>      // SAFETY: The release call of a file owns the private data.
>      let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
> 
> because it doesn't acquire the git blame on the existing line.

I disagree with the *rationale*, because it would also mean that if I have

  let result = a + b;

and it turns out that we're off by one later on, it'd be reasonable to change it
to

  let result = a - b;
  let result = result + 1;

in order to not acquire the git blame of the existing line.

> 
> > >
> > > > I already explicitly asked you not to do so in [3] and yet you did so while
> > > > keeping my ACK. :(
> > > >
> > > > (Only saying the latter for reference, no need to send a new version of [3],
> > > > otherwise I would have replied.)
> > > >
> > > > [2] https://lore.kernel.org/rust-for-linux/Z7MYNQgo28sr_4RS@cassiopeiae/
> > > > [3] https://lore.kernel.org/rust-for-linux/20250213-aligned-alloc-v7-1-d2a2d0be164b@gmail.com/
> > >
> > > I will drop [2] and leave the `as _` casts in place to minimize
> > > controversy here.
> >
> > As mentioned I think the conversion to cast() is great, just do it after this
> > one and keep it a single line -- no controversy. :)
> 
> The code compiles either way, so I'll leave it untouched rather than
> risk being scolded for sneaking unrelated changes.

Again, I never did that, but as already mentioned if it came across this way,
please consider that I tell you now, that it wasn't meant to be.

You're free to do the change (I encourage that), but that's of course up to you.

Subsequently, I kindly ask you though to abstain from saying that I accused you
of something or do scold you. Thanks!

