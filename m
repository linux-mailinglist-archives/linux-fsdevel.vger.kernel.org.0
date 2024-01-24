Return-Path: <linux-fsdevel+bounces-8792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3E83B0D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479B41F24F1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA7812A170;
	Wed, 24 Jan 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJEWLT58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A81272C5;
	Wed, 24 Jan 2024 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120289; cv=none; b=WFMoQsYBW+3nXQdSBLnLuOgpLEmpVpS38Nc3GRAIIc2iENO3/L/nURwvBPgpj7aja74SZJqepuuTp48qeAF/dz2ijHPaSHWrq7++IWo2/djM/tieML5fIekv9LRRKrRcGl2fhr6PHju5jLDymwilxZoCmFv5VSb/kMu6OXzAmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120289; c=relaxed/simple;
	bh=IZVOlariVRfIcGsIrV1/Rj9DEC+cUqQAkpjxQgYzNog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0WIuEBaYd/Rx+p3gp5eoseiKEOM/CInlBAmZx3hqTHCYJLbkh9sNUaPpxilV8D2pCqtp0aJyIuIz8fAiNGiNjJmy1Nk0U7eNG18XK2afXTLjPq0Jus9qldD7LYmxDxqHLQSQNythD31HytXhBly9S9+s2b9JZdb9ecc58disxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJEWLT58; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-600094c5703so32528297b3.3;
        Wed, 24 Jan 2024 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706120286; x=1706725086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QsC5J7SFRh8VB2y7cw0DmGPNJsrnu5DQuprLfeci/dk=;
        b=DJEWLT58U27eAto/wYwgoUHnH4EALDKuJvOIwk6QKwM5AqQuNYP9MKBtp/k5a6C4PN
         l1MJL+18QmTj7s0vRGOlCAU8e1WMejW+zphefCHzas4JfpQOdgrGStw8AWS5j+xQ3V+n
         zaxI9sHgb79DCfQ+gX46KRQ9Vp2mdbkR9VQdnfdXzNTEP0N4GNkrdmYl64qZMx/Fawlv
         EQ76l7AqsvNKOVGnOcr9vQdNjHySv4crsAy9EuW44PSFlnnoP6OoI2pr23rp6Mq9cLSk
         9DD086H8hsWaT7d5wxk5PL69U6UKaNKIKE4WtO6HLZWHmTRAf84b/DB194uUsPZNhXvU
         8hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120286; x=1706725086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsC5J7SFRh8VB2y7cw0DmGPNJsrnu5DQuprLfeci/dk=;
        b=wUTEC0qMlnruwZLSoHNhcx8zzENtHfPR2kZK91+5D/4jHT8hz6byVZwMOBek/sDBg3
         UAoVuuiBsH9flxhSvWhEvFBn59xuoE7JbMJ+xNHetm2Zs9Z50A/QGjdVepge/c0BASzO
         Sah8HixptRhEehQm99LA7rO4t9DuNP7qw/hUJgSRUxyUR1ldfGe/P1ilEUZRF0Gam/ml
         aDeJgbXCcIw0KOl7SyrWr9MCekTGqwKWaDxlw8fOY0EM7pNYHyhYSf9AeX0HfBxJCtrK
         q/YqKBgH7JSS2VhS5c62LynOOPkjYnTGryiQpxlbcv/k0TsD+GKdULRLOhbOCpu/I2Vv
         gsJA==
X-Gm-Message-State: AOJu0Yx+Be0GGW8m+rjpOQzV+K6wDQJcIA3DSxCAvxV2sFGDcxOgl263
	9QeLaSpuFnQHWvrt5FHGL572gFGt0T/4kEAHJ7h2Lvv9oLS6gHmU/qdaS/h2kqcrTJIbWsYLgXZ
	J4eRO8NuNRO/tCGTn+AlysEUkp60=
X-Google-Smtp-Source: AGHT+IHjIotTzRXLyqQXirevqWOvpN0RADtAYz7W01uBjHC4bmMaKvNw8tNKwj68QaXnyYWvZcic6lqR4nV2ERKTT5M=
X-Received: by 2002:a05:6902:50b:b0:dbf:1edf:37ef with SMTP id
 x11-20020a056902050b00b00dbf1edf37efmr893940ybs.54.1706120286281; Wed, 24 Jan
 2024 10:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-6-wedsonaf@gmail.com>
 <20240104051454.GC3964019@frogsfrogsfrogs>
In-Reply-To: <20240104051454.GC3964019@frogsfrogsfrogs>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 24 Jan 2024 15:17:55 -0300
Message-ID: <CANeycqrCzxJ0dWHX22gZw2ZBawz63btw5E1ONaz_TisNCoo5Zg@mail.gmail.com>
Subject: Re: [RFC PATCH 05/19] rust: fs: introduce `INode<T>`
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 02:14, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Wed, Oct 18, 2023 at 09:25:04AM -0300, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > Allow Rust file systems to handle typed and ref-counted inodes.
> >
> > This is in preparation for creating new inodes (for example, to create
> > the root inode of a new superblock), which comes in the next patch in
> > the series.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> >  rust/helpers.c    |  7 +++++++
> >  rust/kernel/fs.rs | 53 +++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 58 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 4c86fe4a7e05..fe45f8ddb31f 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/build_bug.h>
> >  #include <linux/err.h>
> >  #include <linux/errname.h>
> > +#include <linux/fs.h>
> >  #include <linux/mutex.h>
> >  #include <linux/refcount.h>
> >  #include <linux/sched/signal.h>
> > @@ -144,6 +145,12 @@ struct kunit *rust_helper_kunit_get_current_test(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
> >
> > +off_t rust_helper_i_size_read(const struct inode *inode)
>
> i_size_read returns a loff_t (aka __kernel_loff_t (aka long long)),
> but this returns    an off_t (aka __kernel_off_t (aka long)).
>
> Won't that cause truncation issues for files larger than 4GB on some
> architectures?

This is indeed a bug, thanks for catching it! Fixed in v2.

> > +{
> > +     return i_size_read(inode);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_i_size_read);
> > +
> >  /*
> >   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
> >   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> > diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> > index 31cf643aaded..30fa1f312f33 100644
> > --- a/rust/kernel/fs.rs
> > +++ b/rust/kernel/fs.rs
> > @@ -7,9 +7,9 @@
> >  //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
> >
> >  use crate::error::{code::*, from_result, to_result, Error, Result};
> > -use crate::types::Opaque;
> > +use crate::types::{AlwaysRefCounted, Opaque};
> >  use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
> > -use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin};
> > +use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin, ptr};
> >  use macros::{pin_data, pinned_drop};
> >
> >  /// Maximum size of an inode.
> > @@ -94,6 +94,55 @@ fn drop(self: Pin<&mut Self>) {
> >      }
> >  }
> >
> > +/// The number of an inode.
> > +pub type Ino = u64;
> > +
> > +/// A node in the file system index (inode).
> > +///
> > +/// Wraps the kernel's `struct inode`.
> > +///
> > +/// # Invariants
> > +///
> > +/// Instances of this type are always ref-counted, that is, a call to `ihold` ensures that the
> > +/// allocation remains valid at least until the matching call to `iput`.
> > +#[repr(transparent)]
> > +pub struct INode<T: FileSystem + ?Sized>(Opaque<bindings::inode>, PhantomData<T>);
> > +
> > +impl<T: FileSystem + ?Sized> INode<T> {
> > +    /// Returns the number of the inode.
> > +    pub fn ino(&self) -> Ino {
> > +        // SAFETY: `i_ino` is immutable, and `self` is guaranteed to be valid by the existence of a
> > +        // shared reference (&self) to it.
> > +        unsafe { (*self.0.get()).i_ino }
>
> Is "*self.0.get()" the means by which the Rust bindings get at the
> actual C object?

It gets a pointer to the C object.

self's type is INode, which is a pair. `self.0` get the first element
of the pair, which has type `Opaque<bindings::inode>`. It has a method
called `get` that returns a pointer to the object it wraps.

> (Forgive me, I've barely finished drying the primer coat on my rust-fu.)
>
> > +    }
> > +
> > +    /// Returns the super-block that owns the inode.
> > +    pub fn super_block(&self) -> &SuperBlock<T> {
> > +        // SAFETY: `i_sb` is immutable, and `self` is guaranteed to be valid by the existence of a
> > +        // shared reference (&self) to it.
> > +        unsafe { &*(*self.0.get()).i_sb.cast() }
> > +    }
> > +
> > +    /// Returns the size of the inode contents.
> > +    pub fn size(&self) -> i64 {
>
> I'm a little surprised I didn't see a
>
> pub type loff_t = i64
>
> followed by this function returning a loff_t.  Or maybe it would be
> better to define it as:

This was suggested by Matthew Wilcox as well, which I did for v2,
though I call it `Offset`.

> struct loff_t(i64);
>
> So that dopey fs developers like me cannot so easily assign a file
> position (bytes) to a pgoff_t (page index) without either supplying an
> actual conversion operator or seeing complaints from the compiler.

We may want to eventually do this, but for now I'm only doing the type alias.

The disadvantage of doing a new type is that we lose all arithmetic
operators as well, though we can redefine them by implementing the
appropriate traits.

Thanks,
-Wedson

