Return-Path: <linux-fsdevel+bounces-41862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81AA386E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 15:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9872D188DFD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D8223705;
	Mon, 17 Feb 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3KXwgO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BD21CA0E;
	Mon, 17 Feb 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803674; cv=none; b=MNtHTYNttW6viCCa4KZjWsZ8UYLdU6plZdmJEbdKdAdTFY3iSAP3QmakZAbLyiv15xdIFbP65uXlBCAbg6amVAbmoODDwYpcEJuJHc3mVZbzpBjCPpJ6heAh37JE1A9V6F/b+dAFq03U9Ds/Xy55rv9Lb7YEQqCrIvo1fB0qLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803674; c=relaxed/simple;
	bh=oGq1HKEXRFild7cOOV4DLkmQbmFmQNwy9jzM7RkUz1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxjml+QtFqbZd3wmi/L339wHC9hxoe4SYqxrzFch2Wr9mAER0b30YLgqvIFnHZrTiGT8mjf3tGHvpWBou/SanfTNTsmM6LW4Bvv+8+Ss864MeBlTmRa74v+cUVAkiG8C6GuOiaUIjQB60rx+tED1XOeEbbWKM9OIOvhtRPyfEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3KXwgO4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307c13298eeso45645971fa.0;
        Mon, 17 Feb 2025 06:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739803671; x=1740408471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yelQ8r3ymkQjfm9j6D5BGBZ62JnuLjJsnUbfmnDTfxs=;
        b=k3KXwgO4xbI6b81EZxlhqLxh4Z9b3auGIYjpLx+xsNImFH1LgVAbOLNzufM+3PNxNO
         oi/tsgDjOel+srO7MJzYVsexnwPHia5zxCrcXJSclH4r5mBW7jg0pFLJXsjyS2DJ50+C
         30/CilJM5FRvdoNmTqNCPY6ERVHLr+XvZOtmBVYe0PNPCDANnnFZxj+b4+BjBZwPbwVa
         DjLCs0rDmkbKAVtDewNyIiskgYlbt4/4+BNlPK8dAlLQlZ/G2nJY4zFUE7h/SxOUdBxl
         OIuUpvkGOH4Rkk35yXVtj+5F9ckyD8gtv4IOYxs57CBBpGeKtVtd7d/OV/YRDsSgevhC
         /LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739803671; x=1740408471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yelQ8r3ymkQjfm9j6D5BGBZ62JnuLjJsnUbfmnDTfxs=;
        b=Yh+Frr6aDiPqWeMreKnai34p+IgNrnDgMg9Z0LLXpgp4puxbV6lAqQDuaIxk4b2uKR
         DhE4a8jeFx1AhvKWbX8Ed/kkhStQPWmQDGEIA9k65EsS0npLrXj5v/crwPhnDraRH12s
         xCy7x6aCkAt5vEVBSHcs+zItb3j+BvjcGbTXNFcqFmEOKyX/CrBE/uXpFboHIS9ZfB9T
         QHgtfoOa54poKR75FpRbb56ZNq8Ni2SmFjWwpcdI8ooy+nBishbDAts0osRbAceoLXP0
         S8+pBepNVvc4BMysvhxplZ8HAgxP0KnxvazdAXKOVGqpucFqzVsPrM/hOr8SglGqaOoI
         kLqA==
X-Forwarded-Encrypted: i=1; AJvYcCUF1WWDnNt11sPyk7cl0Bd3gciE6WXcD9ELQgtQnkNXuJCTCrProco/1PWl3SPG3LfyIODT6UCOTHLQ2KPYLlU=@vger.kernel.org, AJvYcCUFSKwfFdGnU92D9FCD8ZQsMS8O7vcWw4QYVZR4UKWwZgDW5myLYEDOHCw8I5JkZmqnVrPgacW+X3DW@vger.kernel.org, AJvYcCUqGBtHdVOnAdPQMZA3i4lHcAmJ4CbOTKT7atxhjRCLpN2aC7oQiF9zUSKh0sp3RYbpiu3ilk8GUXJEFrnU@vger.kernel.org, AJvYcCW21XsBBritXjPMxxWLkYyo4b7XtPIBBKlQHuuHEg8VBK7/d+CqAZbZv48gttrjyhqhhp2kW4nsDTA/vMxT@vger.kernel.org
X-Gm-Message-State: AOJu0YxhvZC+t229EB7RqOjN22kgkJ7czAQZmL5TnEaF3YcbA4p/tS0p
	qTlhFOuif/G6CL/fweWpHNF231Me6sl6gSif/BWFnnZrRhZNfKZNPOYhRJFjfMdoPBDpSCq4Mkc
	Cf3bfpFaXfvuMRXemcWW4y2oruipREws7
X-Gm-Gg: ASbGncuXcABGXAf5zhF4D5x9FaeDo6njD1F+2IwiJDrLqzWuO+0s/ckqjHpxC0NrSlA
	qzo4L1jEJ7WfJ9bTftw0wAB19FFCJvNdO8mSCn5LvjvjYxrfe3pdzBcPPnVp6BNJdomjk0pFOXC
	PRlqKWG9JgUUrOVbeOojFy49K436XZDNQ=
X-Google-Smtp-Source: AGHT+IGl++F9JEix/3p1S41cUUJSot7kHwy5rdU0vrT8bdI4ZQwvTDealantGSf3uQMwjqLGEtdxinx7X645sIp0jn0=
X-Received: by 2002:a2e:9e1a:0:b0:302:49b6:dfaf with SMTP id
 38308e7fff4ca-30928b7454emr23551951fa.20.1739803670897; Mon, 17 Feb 2025
 06:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
 <Z7MnxKSSNY7IyExt@cassiopeiae> <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
 <Z7NEZfuXSr3Ofh1G@cassiopeiae> <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>
 <Z7NJugCD3FThZpbI@cassiopeiae>
In-Reply-To: <Z7NJugCD3FThZpbI@cassiopeiae>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Feb 2025 09:47:14 -0500
X-Gm-Features: AWEUYZkhjWnndzObhnnMYKIbIRqYFHcYPrkL6t02LpCr5aboeg3gLJ8FDP7cjDg
Message-ID: <CAJ-ks9mcRffgyMWxYf=anoP7XWCA1yzc74-NazLZCXdjNqZSfg@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 9:37=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon, Feb 17, 2025 at 09:21:00AM -0500, Tamir Duberstein wrote:
> > On Mon, Feb 17, 2025 at 9:15=E2=80=AFAM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > On Mon, Feb 17, 2025 at 09:02:12AM -0500, Tamir Duberstein wrote:
> > > > > > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > > > > > index 6c3bc14b42ad..eb25fabbff9c 100644
> > > > > > --- a/rust/kernel/pci.rs
> > > > > > +++ b/rust/kernel/pci.rs
> > > > > > @@ -73,6 +73,7 @@ extern "C" fn probe_callback(
> > > > > >          match T::probe(&mut pdev, info) {
> > > > > >              Ok(data) =3D> {
> > > > > >                  let data =3D data.into_foreign();
> > > > > > +                let data =3D data.cast();
> > > > >
> > > > > Same here and below, see also [2].
> > > >
> > > > You're the maintainer,
> > >
> > > This isn't true. I'm the original author, but I'm not an official mai=
ntainer of
> > > this code. :)
> > >
> > > > so I'll do what you ask here as well. I did it
> > > > this way because it avoids shadowing the git history with this chan=
ge,
> > > > which I thought was the dominant preference.
> > >
> > > As mentioned in [2], if you do it the other way around first the "rus=
t: types:
> > > add `ForeignOwnable::PointedTo`" patch and then the conversion to cas=
t() it's
> > > even cleaner and less code to change.
> >
> > This is true for the two instances of `as _`,
>
> Yes, those are the ones I talk about.
>
> > but not for all the
> > other instances where currently there's no cast, but one is now
> > needed.
> >
> > > >
> > > > > I understand you like this style and I'm not saying it's wrong or=
 forbidden and
> > > > > for code that you maintain such nits are entirely up to you as fa=
r as I'm
> > > > > concerned.
> > > > >
> > > > > But I also don't think there is a necessity to convert things to =
your preference
> > > > > wherever you touch existing code.
> > > >
> > > > This isn't a conversion, it's a choice made specifically to avoid
> > > > touching code that doesn't need to be touched (in this instance).
> > >
> > > See above.
> >
> > This doesn't address my point. I claim that
> >
> > @@ -246,6 +248,7 @@ impl<T: MiscDevice> VtableHelper<T> {
> >  ) -> c_int {
> >      // SAFETY: The release call of a file owns the private data.
> >      let private =3D unsafe { (*file).private_data };
> > +    let private =3D private.cast();
> >      // SAFETY: The release call of a file owns the private data.
> >      let ptr =3D unsafe { <T::Ptr as ForeignOwnable>::from_foreign(priv=
ate) };
> >
> > is a better diff than
> >
> > @@ -245,7 +245,7 @@ impl<T: MiscDevice> VtableHelper<T> {
> >      file: *mut bindings::file,
> >  ) -> c_int {
> >      // SAFETY: The release call of a file owns the private data.
> > -    let private =3D unsafe { (*file).private_data };
> > +    let private =3D unsafe { (*file).private_data }.cast();
> >      // SAFETY: The release call of a file owns the private data.
> >      let ptr =3D unsafe { <T::Ptr as ForeignOwnable>::from_foreign(priv=
ate) };
> >
> > because it doesn't acquire the git blame on the existing line.
>
> I disagree with the *rationale*, because it would also mean that if I hav=
e
>
>   let result =3D a + b;
>
> and it turns out that we're off by one later on, it'd be reasonable to ch=
ange it
> to
>
>   let result =3D a - b;
>   let result =3D result + 1;
>
> in order to not acquire the git blame of the existing line.

Like anything, it depends. If something changes from being 0-indexed
to 1-indexed then I'd say what you have there is perfectly reasonable:
the 1-bias is logically separate from `a - b`. That's a fine analogy
for what's happening in this patch.

> >
> > > >
> > > > > I already explicitly asked you not to do so in [3] and yet you di=
d so while
> > > > > keeping my ACK. :(
> > > > >
> > > > > (Only saying the latter for reference, no need to send a new vers=
ion of [3],
> > > > > otherwise I would have replied.)
> > > > >
> > > > > [2] https://lore.kernel.org/rust-for-linux/Z7MYNQgo28sr_4RS@cassi=
opeiae/
> > > > > [3] https://lore.kernel.org/rust-for-linux/20250213-aligned-alloc=
-v7-1-d2a2d0be164b@gmail.com/
> > > >
> > > > I will drop [2] and leave the `as _` casts in place to minimize
> > > > controversy here.
> > >
> > > As mentioned I think the conversion to cast() is great, just do it af=
ter this
> > > one and keep it a single line -- no controversy. :)
> >
> > The code compiles either way, so I'll leave it untouched rather than
> > risk being scolded for sneaking unrelated changes.
>
> Again, I never did that, but as already mentioned if it came across this =
way,
> please consider that I tell you now, that it wasn't meant to be.

Wasn't my intention to imply that this was something you did. It was
meant as a general observation.

> You're free to do the change (I encourage that), but that's of course up =
to you.

I'll create a "good first issue" for it in the RfL repository.

> Subsequently, I kindly ask you though to abstain from saying that I accus=
ed you
> of something or do scold you. Thanks!

Certainly. I'll point out, as you did, that I never said that.

