Return-Path: <linux-fsdevel+bounces-41857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0035DA38533
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5AE170F1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD821CC6C;
	Mon, 17 Feb 2025 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7Ags1Nc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB513AA5D;
	Mon, 17 Feb 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800636; cv=none; b=rqmCIXviagUymihM1ScdDLQAMeks9PZ7Esu5YxWM9/KSBiXrkuHldu+kR1NI4CntQhbldc6izwRptxf32fSSmlR42picuKbD7gVpKaZ9NdK+Uzg+ACEwuvrhHKp86SHHztnfKTVJ9mkFplCCiQmm/wwn1BR5IpdlItZT2flnP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800636; c=relaxed/simple;
	bh=em5e3cMNcfkV84z7vQ4RzlRh9r9e9zI+5uKdTIaxX9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7N/aHjXj1RhznrEENWD3Rd3oG+vp9sL2FQjSfoSZmpmh128bQjGsZuiVy3ENLvp9chS8LFCFZlJXvMJa/jn0/nZLpa1quevSnNiHGfPHUH1ri4A42bCYjCoS3md8/oXNneoibjpALbKo1r0T8ftEICZLAOVNf3Yw/h5XlnbSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7Ags1Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109CAC4CEE4;
	Mon, 17 Feb 2025 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800635;
	bh=em5e3cMNcfkV84z7vQ4RzlRh9r9e9zI+5uKdTIaxX9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7Ags1NcYppE459rNwSQtwG5b4RyKielVYW0wWheTMImQNxWyVoHUa2R+IZaBg4/V
	 PXY4nZTbzBDlcjrYxJZdakfJvRK2vrq2sJsZtW2ls1HeXnkHL6ZRca6HmkiYNXLenX
	 fATV+SVtbcDBwslyFAkZXarusQJES8ZYE1bApY6jGf8uovujQc0kIFihVEtkuVv2bo
	 emUK6EYAKnhUoTj9qLLdB7yNNNb6wIlsEKPPYzSOO3fClFzTgZQcpqb7B+ThaE5UK1
	 dcz/zXptPr8x6wF9kYrUYvKin591ZH6RP1YMHGzt+RlZrPsbooxkx39ywSJ5aU1Vl2
	 R4dAAcP8GPYTg==
Date: Mon, 17 Feb 2025 14:57:08 +0100
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
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v16 3/4] rust: xarray: Add an abstraction for XArray
Message-ID: <Z7NANGwGPQaGNwIh@cassiopeiae>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-3-256b0cf936bd@gmail.com>
 <Z7MfETop-rGSNLFo@cassiopeiae>
 <CAJ-ks9m4QhnztQ7McJLdxEQjNcfYUiHPXwpnbbG12GFfPXBGqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9m4QhnztQ7McJLdxEQjNcfYUiHPXwpnbbG12GFfPXBGqw@mail.gmail.com>

On Mon, Feb 17, 2025 at 08:43:12AM -0500, Tamir Duberstein wrote:
> On Mon, Feb 17, 2025 at 6:35 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Fri, Feb 07, 2025 at 08:58:26AM -0500, Tamir Duberstein wrote:
> > > `XArray` is an efficient sparse array of pointers. Add a Rust
> > > abstraction for this type.
> > >
> > > This implementation bounds the element type on `ForeignOwnable` and
> > > requires explicit locking for all operations. Future work may leverage
> > > RCU to enable lockless operation.
> > >
> > > Inspired-by: Maíra Canal <mcanal@igalia.com>
> > > Inspired-by: Asahi Lina <lina@asahilina.net>
> > > Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > >  rust/bindings/bindings_helper.h |   6 +
> > >  rust/helpers/helpers.c          |   1 +
> > >  rust/helpers/xarray.c           |  28 ++++
> > >  rust/kernel/alloc.rs            |   5 +
> > >  rust/kernel/lib.rs              |   1 +
> > >  rust/kernel/xarray.rs           | 276 ++++++++++++++++++++++++++++++++++++++++
> > >  6 files changed, 317 insertions(+)
> > >
> > > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > > index fc9c9c41cd79..77840413598d 100644
> > > --- a/rust/kernel/alloc.rs
> > > +++ b/rust/kernel/alloc.rs
> > > @@ -39,6 +39,11 @@
> > >  pub struct Flags(u32);
> > >
> > >  impl Flags {
> > > +    /// Get a flags value with all bits unset.
> > > +    pub fn empty() -> Self {
> > > +        Self(0)
> > > +    }
> >
> > No! Zero is not a reasonable default for GFP flags.
> 
> This is not a default.
> 
> > In fact, I don't know any
> > place in the kernel where we would want no reclaim + no IO + no FS without any
> > other flags (such as high-priority or kswapd can wake). Especially, because for
> > NOIO and NOFS, memalloc_noio_{save, restore} and memalloc_nofs_{save, restore}
> > guards should be used instead.
> >
> > You also don't seem to use this anywhere anyways.
> 
> This was used in an earlier iteration that included support for
> reservations. I used this value when fulfilling a reservation because
> it was an invariant of the API that no allocation would take place.
> 
> > Please also make sure to not bury such changes in unrelated other patches.
> 
> Thank you for spotting this errant change. Please consider whether it
> serves anyone's purpose to accuse someone of underhanded behavior.

As far as I can see I did not accuse anyone of underhanded behavior. But if it
came across this way to you, that wasn't the intention.

> 
> > > +/// The error returned by [`store`](Guard::store).
> > > +///
> > > +/// Contains the underlying error and the value that was not stored.
> > > +pub struct StoreError<T> {
> > > +    /// The error that occurred.
> > > +    pub error: Error,
> > > +    /// The value that was not stored.
> > > +    pub value: T,
> > > +}
> > > +
> > > +impl<T> From<StoreError<T>> for Error {
> > > +    fn from(value: StoreError<T>) -> Self {
> > > +        let StoreError { error, value: _ } = value;
> > > +        error
> >
> > Why not just `value.error`?
> 
> I prefer the clarity that this results in the value being dropped.

I don't think that any further clarity than the fact that value was passed by
value is needed.

Otherwise one could probably argue the same way for this:

fn from(value: StoreError<T>) -> Self {
   let error = value.error;
   drop(value);
   error
}

But that's up to you.

> Is there written guidance on this matter?

I don't think so.

