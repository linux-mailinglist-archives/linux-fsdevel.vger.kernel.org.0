Return-Path: <linux-fsdevel+bounces-30682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4061B98D3DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D36284018
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9A31D0437;
	Wed,  2 Oct 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BI28y/rj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890171D0426
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873907; cv=none; b=mnS42lRxkakzbNxECasNiZEn90oIIWXYRhi2yxLPg+79GGWFTlyAvJHz7BhLAgneJEumxd5oD+kAJO70ZphQQDlo2eyZ+UNzC3pl2B6SBAm5fPQ0dx2jXf9rljKvr8AjDdllEC9gcFzTxF3RUEQRjkpEJFE9avxwmKgI5Ea4pzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873907; c=relaxed/simple;
	bh=QUBuGnPlyg1Zpo5cSYdnCPifco/uAsbhZbLGKJuzkk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hi3HCOhzohTm6IbGBIr0oilkS5SCIrDLraJMYPSbFOlvls+hS4/SdgiF1qc+aQ1Kw4aawZJoNPzAbi75uO0/mbTrHBo9GrQAmI+PzA6u0mNB43SW1QZe5wIyVoXN9kAK69nszNMJoT8YGHU6p8tM4kNUKotwSdYOGK5bqTGBzPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BI28y/rj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cae102702so50325485e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727873904; x=1728478704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuvhL0iJAmSISnqppky+Pu1GhPMGz/EzvYkIVz0BxzI=;
        b=BI28y/rjGyvwNK/FW+6QYqLcvheOy40oWIxVlyuwOIFHP9jUuf/N0pcwFT0jz7cBDY
         mSnAXeMB6vJPKns/3+t+e1EPW4AQiHUUjkdS84L3Hf/B9RIGnaVAaEEhPofTY0PprZip
         zv+BwEolRsWvWtbmisELgaK6zgbMyHfb95j7nd2NmaPBovDCUFtTcI9j7ieNZpbEKdr8
         /RSJ3UXrREywoVQz8XOEwPxndgmZsIxJxzHVuSsv6E2s6fE5Mvqx55QYcpnp56GCVJH9
         F37PxCt2SKs3U7xc/hBlidc+dyAqnfw+BexTu/uelYnvdB6bDvn66wpl8P3h0CHtKhIR
         7C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727873904; x=1728478704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuvhL0iJAmSISnqppky+Pu1GhPMGz/EzvYkIVz0BxzI=;
        b=pyycuimUtNBOdqz4zfCoD3tcMZpwKA+KT0sO8F4FbhSTd0tLt5nQx/6u+WPVjkxMFp
         LZA15MtKEU//AfzK2W+XXpIk5b0F1mu3H3d1y+Gerb+BYIQNWND69JewxSko3s4Yd5nJ
         PUCA43sBAKGuHDEdneBVfLRcepgTi1jk6imS//1BFSC7iez+S0Ex3SW2eMAxRdeNKLW2
         Hzb8d61lnHDKRmX7kPTzc3mtXXCCArFXvZt0E25ykU4d9a0hdtiVlOXuaU4itMgTuUk+
         2rYLLnr6d1qz3wG2WPMSi5Tqeu2yW8F/ARLBWy+X9zwajXl30whxlNMcNPkG8PaMPnBK
         2GsA==
X-Forwarded-Encrypted: i=1; AJvYcCX4IhhQct7osg0H9PJkdzY2PEMQEsgaaIJ/R6xGk7ReQjxTx7XIOwsnZwKtLXtOtZ5lTXbHOhvUxzcgu/6l@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8EKzZdNAD6xSshgMDhBAc5i1O65GOOPgZTdqwd0pBt2+BWta
	fRArbYic6ktaNAF795hhIHxGfhBSBnxhj1isBdCJskWvqnH/EgqQOhHBknSIGTyY4kDDJMn1ge1
	cJkpTE7lEz9Z4B3wRLq/sn+vJM0EJg3CJw8TJ
X-Google-Smtp-Source: AGHT+IHHNpbvzD6JVLO0f6tehIAjS8/eh19SyhhFjt+iCRJaku04vJeilwH0IXR5Cw5Jlz9Nl44Ft6aab47N2vglH4g=
X-Received: by 2002:a05:600c:35cf:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-42f777c83b8mr19407115e9.20.1727873903611; Wed, 02 Oct 2024
 05:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com> <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
In-Reply-To: <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 2 Oct 2024 14:58:11 +0200
Message-ID: <CAH5fLghmkkYWF8zNFci-B-BvG8LbFCDEZkZWgr54HvLos5nrqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 1, 2024, at 08:22, Alice Ryhl wrote:
> > +#[cfg(CONFIG_COMPAT)]
> > +unsafe extern "C" fn fops_compat_ioctl<T: MiscDevice>(
> > +    file: *mut bindings::file,
> > +    cmd: c_uint,
> > +    arg: c_ulong,
> > +) -> c_long {
> > +    // SAFETY: The compat ioctl call of a file can access the private
> > data.
> > +    let private =3D unsafe { (*file).private_data };
> > +    // SAFETY: Ioctl calls can borrow the private data of the file.
> > +    let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(private=
)
> > };
> > +
> > +    match T::compat_ioctl(device, cmd as u32, arg as usize) {
> > +        Ok(ret) =3D> ret as c_long,
> > +        Err(err) =3D> err.to_errno() as c_long,
> > +    }
> > +}
>
> I think this works fine as a 1:1 mapping of the C API, so this
> is certainly something we can do. On the other hand, it would be
> nice to improve the interface in some way and make it better than
> the C version.
>
> The changes that I think would be straightforward and helpful are:
>
> - combine native and compat handlers and pass a flag argument
>   that the callback can check in case it has to do something
>   special for compat mode
>
> - pass the 'arg' value as both a __user pointer and a 'long'
>   value to avoid having to cast. This specifically simplifies
>   the compat version since that needs different types of
>   64-bit extension for incoming 32-bit values.
>
> On top of that, my ideal implementation would significantly
> simplify writing safe ioctl handlers by using the information
> encoded in the command word:
>
>  - copy the __user data into a kernel buffer for _IOW()
>    and back for _IOR() type commands, or both for _IOWR()
>  - check that the argument size matches the size of the
>    structure it gets assigned to
>
> We have a couple of subsystems in the kernel that already
> do something like this, but they all do it differently.
> For newly written drivers in rust, we could try to do
> this well from the start and only offer a single reliable
> way to do it. For drivers implementing existing ioctl
> commands, an additional complication is that there are
> many command codes that encode incorrect size/direction
> data, or none at all.
>
> I don't know if there is a good way to do that last bit
> in rust, and even if there is, we may well decide to not
> do it at first in order to get something working.

A quick sketch.

One option is to do something along these lines:

struct IoctlParams {
    pub cmd: u32,
    pub arg: usize,
}

impl IoctlParams {
    fn user_slice(&self) -> IoctlUser {
        let userslice =3D UserSlice::new(self.arg, _IOC_SIZE(self.cmd));
        match _IOC_DIR(self.cmd) {
            _IOC_READ =3D> IoctlParams::Read(userslice.reader()),
            _IOC_WRITE =3D> IoctlParams::Write(userslice.writer()),
            _IOC_READ|_IOC_WRITE =3D> IoctlParams::WriteRead(userslice),
            _ =3D> unreachable!(),
        }
    }
}

enum IoctlUser {
    Read(UserSliceReader),
    Write(UserSliceWriter),
    WriteRead(UserSlice),
}

Then ioctl implementations can use a match statement like this:

match ioc_params.user_slice() {
    IoctlUser::Read(slice) =3D> {},
    IoctlUser::Write(slice) =3D> {},
    IoctlUser::WriteRead(slice) =3D> {},
}

Where each branch of the match handles that case.

Alice

