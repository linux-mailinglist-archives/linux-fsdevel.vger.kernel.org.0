Return-Path: <linux-fsdevel+bounces-36762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9E9E90F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4C018812DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F5321770F;
	Mon,  9 Dec 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OF71MjUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671821765A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741473; cv=none; b=gc0sf4HSHvf3kuO1DBBgVA0pG7YeYiMn6595D1vfcHOoDU+/G5aNuZlOgi3i8AIKikdKjyKtYXfWHa8PMlXTIaAT4lqcaWCid4WMO29783WVW93qAxjmZxuXVFi3mXCn81payXWT1q6MEbg12BH4KI1uQb8bfZJ2J3Hcu+KaE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741473; c=relaxed/simple;
	bh=L4ui1h/vrdTNSwIpVte950FBLDJ/cVXgkHics9qC5xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbu0c1zgjIlfgexChvSYpQpGe+4TB/R9C2KWQPBSDZc1PwEP2QkqQN9jYD6Fcds+Kb2QpnmXy4n9IkGKOkCl/DUZc8H88ffUwB4vAYfTG+pjetRTkXMLnn1yJSgggUUbJv9BM84wVZn8LOO1XNmbrKnfKU4M0PNHSiTMCAA6tJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OF71MjUP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso46807365e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 02:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733741470; x=1734346270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FryIWHG4glDtAbY0ViJJ5GhXfPjObehPPRF/NzIgnoU=;
        b=OF71MjUPR4/jGDWDf6cf2UWoU9YY1Qc16GE6uICv3zBjfUK0F60MxOEA6oOYJTHs5K
         MYhbdhKX38b4IMnK3oAtncB09vrXk8X7q6e8PCBC3BemuLPSol1DnN57MzMzLpvzheO5
         Psxd9Jyz+MCDrzXxUrX5FB55WS2Enrr3wbLkrJyBDyVZnbBiTMe1sCEdgT0xA32hw0Bm
         4Zg9imRuO7Rp/nDYKjcwPTzydMdwCrQTPbaUSYZmNcjz9XEoUrJWbCm7xVL+sl8EAbG3
         BGmS3kQi+UgtFW0dO3bDBr2T5k40lTzmIICUQEuCZT9ivGfUMBNYwxLGeYVFStlg5mHQ
         VBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741470; x=1734346270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FryIWHG4glDtAbY0ViJJ5GhXfPjObehPPRF/NzIgnoU=;
        b=h2hiaJXq0XzneWd845bgt3pAryU42MO/t54bySKzBal60RbgA5v+YIWCUQXl4tORtC
         FJI9wq3Y5uMJRNrM9GgDqrsl/Nv/4v9rn89UXMnE9drjNoILopoxbICX0ES3OeVClhlQ
         niNU/iwEM7f8ZpSL99fUqSyH/UCJp5YowSrB9coGonoFPz6w2+9Ka+Ij7LzxKNQPwRYd
         iQ4X34qHmsP/8QEps/OH0VdA6aQve+ai6dyCOGPZAHNRfZap3NwKULw5uJkm4DAz0J0P
         ukUBH0w/BnT1efbhheCYevrxWcuqk7eOBHxMqg3JVdTCE/uR0zx1u4EpNJOrv0GxaJb5
         px/A==
X-Forwarded-Encrypted: i=1; AJvYcCXAU4mbWN7OyepT7UTX9avPpeXnJ0SsLRsHNDSAS9Q3Sy64efkLFCS50XMHuiIossfy2XxzZJ8nVTmOdtLs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gTdH0RQYryXKh5uiDCMFg8RxM6I1GR8Zy7cMwTMqr2cO0RF4
	oHKCyRyRtzCItP/2CXOh2eE8skX9xpQICI0/RWhMhalOonsXPdfpv+Z1N1Q6zqM5c8m9994L8zK
	6HeMTe8l/AaWW19cAFFv7chX9hOYdR7h+a7A7
X-Gm-Gg: ASbGncu1w+2h+F1HD6CkvU3EN0gvVD9Tf/ryVyvFRdhX13IGNOA9AT5VxP0BAFQe+FU
	+qUCzwGijtAyFOsJUeUTH14XhtgSnsvVpWiMwCzaWZxRXplWfIuDiTO/rp/1z
X-Google-Smtp-Source: AGHT+IFCMPz2gJwTLGpVlTtIU/+TRhfTp9o6Sr1cbaBHwP5xMQrVhcDylO0Qa0ADEgHobqtV7VaBYYQ104jfMWkjpKE=
X-Received: by 2002:a05:6000:1446:b0:386:4034:f9a6 with SMTP id
 ffacd0b85a97d-3864034fe3dmr2031582f8f.57.1733741469667; Mon, 09 Dec 2024
 02:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com> <2024120925-express-unmasked-76b4@gregkh>
In-Reply-To: <2024120925-express-unmasked-76b4@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 11:50:57 +0100
Message-ID: <CAH5fLgigt1SL0qyRwvFe77YqpzEXzKOOrCpNfpb1qLT1gW7S+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: access the `struct miscdevice`
 from fops->open()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:48=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> > Providing access to the underlying `struct miscdevice` is useful for
> > various reasons. For example, this allows you access the miscdevice's
> > internal `struct device` for use with the `dev_*` printing macros.
> >
> > Note that since the underlying `struct miscdevice` could get freed at
> > any point after the fops->open() call, only the open call is given
> > access to it. To print from other calls, they should take a refcount on
> > the device to keep it alive.
>
> The lifespan of the miscdevice is at least from open until close, so
> it's safe for at least then (i.e. read/write/ioctl/etc.)

How is that enforced? What happens if I call misc_deregister while
there are open fds?

> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/miscdevice.rs | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > index 0cb79676c139..c5af1d5ec4be 100644
> > --- a/rust/kernel/miscdevice.rs
> > +++ b/rust/kernel/miscdevice.rs
> > @@ -104,7 +104,7 @@ pub trait MiscDevice {
> >      /// Called when the misc device is opened.
> >      ///
> >      /// The returned pointer will be stored as the private data for th=
e file.
> > -    fn open(_file: &File) -> Result<Self::Ptr>;
> > +    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Res=
ult<Self::Ptr>;
> >
> >      /// Called when the misc device is released.
> >      fn release(device: Self::Ptr, _file: &File) {
> > @@ -190,14 +190,27 @@ impl<T: MiscDevice> VtableHelper<T> {
> >          return ret;
> >      }
> >
> > +    // SAFETY: The opwn call of a file can access the private data.
>
> s/opwn/open/ :)
>
> > +    let misc_ptr =3D unsafe { (*file).private_data };
>
> Blank line here?
>
> > +    // SAFETY: This is a miscdevice, so `misc_open()` set the private =
data to a pointer to the
> > +    // associated `struct miscdevice` before calling into this method.=
 Furthermore, `misc_open()`
> > +    // ensures that the miscdevice can't be unregistered and freed dur=
ing this call to `fops_open`.
>
> Aren't we wrapping comment lines at 80 columns still?  I can't remember
> anymore...

Not sure what the rules are, but I don't think Rust comments are being
wrapped at 80.

> > +    let misc =3D unsafe { &*misc_ptr.cast::<MiscDeviceRegistration<T>>=
() };
> > +
> >      // SAFETY:
> > -    // * The file is valid for the duration of this call.
> > +    // * The file is valid for the duration of the `T::open` call.
>
> It's valid for the lifespan between open/release.
>
> >      // * There is no active fdget_pos region on the file on this threa=
d.
> > -    let ptr =3D match T::open(unsafe { File::from_raw_file(file) }) {
> > +    let file =3D unsafe { File::from_raw_file(file) };
> > +
> > +    let ptr =3D match T::open(file, misc) {
> >          Ok(ptr) =3D> ptr,
> >          Err(err) =3D> return err.to_errno(),
> >      };
> >
> > +    // This overwrites the private data from above. It makes sense to =
not hold on to the misc
> > +    // pointer since the `struct miscdevice` can get unregistered as s=
oon as we return from this
> > +    // call, so the misc pointer might be dangling on future file oper=
ations.
> > +    //
>
> Wait, what are we overwriting this here with?  Now private data points
> to the misc device when before it was the file structure.  No other code
> needed to be changed because of that?  Can't we enforce this pointer
> type somewhere so that any casts in any read/write/ioctl also "knows" it
> has the right type?  This feels "dangerous" to me.

Ultimately, when interfacing with C code using void pointers, Rust is
going to need a pointer cast somewhere to assert what the type is.
With the current design, that place is the fops_* functions. We need
to get the pointer casts right there, but anywhere else the types are
enforced.

> >      // SAFETY: The open call of a file owns the private data.
> >      unsafe { (*file).private_data =3D ptr.into_foreign().cast_mut() };
>
> Is this SAFETY comment still correct?

Well, it could probably be worded better at least. The point is that
nobody else is going to touch this field and we can do what we want
with it.

Alice

