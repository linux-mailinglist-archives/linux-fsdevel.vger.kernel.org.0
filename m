Return-Path: <linux-fsdevel+bounces-36767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E099E928E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1E916232D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E5D21E0AA;
	Mon,  9 Dec 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvA2xkqE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5221E08E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744178; cv=none; b=FSr0T87Z753MojM4xGMzpmF1LcDEiUHE6WFQEXI8OuF0pr7DNh4Jjy7oVD5rXfA1IPWMY7AW+VgfmFQRmhYWoEbe4LoWbTiBQHtaRIIchcWBXt08QC6aDeQd+o1iZxio/Jt0S99xKSPVMXftO+ulEZMs+4Zjw8x0jjbydZfX25A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744178; c=relaxed/simple;
	bh=SksebqPHbFrnpTRu15e2F8a43erNfWstAn/0eo/cgNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdqcwN86Pa0lgVTGQilT11cRMQYqZq0tM24nH63rmc+p+lEiOTWwXXoOwgOhegBdtMZIaXD4/sESH833mt2cevqJzZzXRfQ+/Y2G/pxrOCCOzlUD+TjH6u3GnTWfQaew7EttPLQK3p/nKmkmGaimPWcYOIeKr6fizzycQHuOCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvA2xkqE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434f3d934fcso6934715e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 03:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733744175; x=1734348975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyaNKCdC5ol0B97FxkqNYLrH8cbNI4oEIWwfBDcavIE=;
        b=rvA2xkqE7ijVT2Vm9EAQiYVVokEpuW5RW5a2VFrgZ6t0kC0/8g1eZlq+pFiLy1Dfh2
         LAJEynEjRio+8BJcAsKqxVAFouO6lITolg5euva4l3XirwtxlALU2yqAOLew6rhncprG
         clq1rW3Fngb/S9h78M/Du36GDXYQyeJHIy7IYrNqY4PvFoGz0nH9eEk/R27oy3Tq+0+3
         x3U7iSbWvOMzCrcCjaoUd9nivE7p4HRp6/VfJBQV8tpOIdky77X8w/t4+32YxLhUKqFw
         FHZ0IGU9NtH5hh/vRJ36BRz7k+kiiBAr/nfZ1lYdsbpBmUpC/V9KnXFsWwfWyQy+CCX0
         LBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733744175; x=1734348975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyaNKCdC5ol0B97FxkqNYLrH8cbNI4oEIWwfBDcavIE=;
        b=ZlhMa+duL7m0hFxfld3Bj5LmWoFxYo7P/zs+W2Tl8vfAhyvtINoo1uEsU43erOiPNF
         8vP5qTX1okESda18aTUiDNha6AOmm0k3jYNLD+pIR9TPnSAWJ/5J63Ya1SFhlpwuvgYy
         7B9Q2uM1tB+xMrBoGMrPa9hhHIWQ+RZm3GVpKR7DLzEf1vgAkrko9UO8LhkjpGMbtdbM
         7NsN/+957ilBYl3Ps1hxwGDSIpUwmfpevaWYCBYEsXA7Mwwm3xMvuYNeFMmWGxQ5Ecbn
         ZlT/CwXLCVLlHuS3GbiUgqzhHKgCL7KObrc1cgByGoAhLEzYKJ+sAyejVfBu153AGiCf
         GRaA==
X-Forwarded-Encrypted: i=1; AJvYcCUvVjRFtuRkxJaHTS73xHTkOwKn0fFBiG90c067NA3nSgwWeGODjIlngK1TNzCIR8plqG2l5cIxy2uvj7DG@vger.kernel.org
X-Gm-Message-State: AOJu0YztbntzEs4nle0tUwzNkzZZ8nCme4Lu+4WgY5n+eCkWHf8ydVfn
	2uddUcoGTInqLL+Xy18eHH1HhVgN5YvrOQpKfZW5mHPzVz97VsSXeNJsGQ9H4ACvy4w2L7gG2xU
	Dd5TcqNin9SiPHriSxIxdno21QPpPw5kS8q60
X-Gm-Gg: ASbGncvCqRKABKL5cxUmQwofgXOXwFyjkxrOCD/uDPaXb6XqvH/lkzMJ7uLZ2t/cRv+
	kME6cZRoo+XrGNdTY4i2MFk96ebeNYAo+RcSCzoNmD/dWiwJ6GYX9ncXXzCme
X-Google-Smtp-Source: AGHT+IFt14hQvbQibGO8JqBL9INOqCOe4nHDDcUGogdrqehlLvZ5tZgZseDFFJiRhCnpS3xMoTF0HsvEgAbu/Jk7u+Y=
X-Received: by 2002:a5d:6da8:0:b0:385:e5d8:3ef1 with SMTP id
 ffacd0b85a97d-3862b3d5c1emr9642939f8f.44.1733744174841; Mon, 09 Dec 2024
 03:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com> <Z1bPYb0nDcUN7SKK@pollux.localdomain>
In-Reply-To: <Z1bPYb0nDcUN7SKK@pollux.localdomain>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 12:36:03 +0100
Message-ID: <CAH5fLgjAp8Bz=ke93qaha1pFacgAyppOinVn8pdMkT5R05CAAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: access the `struct miscdevice`
 from fops->open()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:07=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
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
> >
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
>
> How is the user of this abstraction supposed to access the underlying str=
uct
> miscdevice e.g. from other fops? AFAICS, there is no way for the user to =
store a
> device pointer / reference in their driver private data.

I had assumed that the miscdevice does not necessarily live long
enough for that to be okay ... but if it does we can change it. See
other thread with Greg.

> I also think it's a bit weird to pass the registration structure in open(=
) to
> access the device.
>
> I think we need an actual representation of a struct miscdevice, i.e.
> `misc::Device`.

It sounds like we can just rename `MiscDeviceRegistration` to `Device`.

> We can discuss whether we want to implement it like I implemented `pci::D=
evice`
> and `platform::Device`, i.e. as an `ARef<device::Device>` or if we do it =
like
> you proposed, but I think things should be aligned.

Let's figure out the lifetime of `struct miscdevice` first ...

Alice

