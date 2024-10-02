Return-Path: <linux-fsdevel+bounces-30693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFD98D626
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C7E286198
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB3E1D0794;
	Wed,  2 Oct 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KU4RhYHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4291D04A2
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876209; cv=none; b=LK5kxzI7GltSgFcHxCXWJcAamREvWPaBvAXmC7fak0C/ELQzXBbp/ZP+HMYKI1L3fXwrQen+70xMw+LqCtktBm22fK+listY7fnw4XGvSitSbBnlKKP28JOFACnDvEODRwkVvxlfyj1JrYLGtOqfx/Yk2Klge5xSWJIYXpd9Qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876209; c=relaxed/simple;
	bh=l+47bXLYl4yy2e8lJa8E5g2vj1iZfXMGhncCb/6mWN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgKuSRkRD8sFjKc0Dy9Bbn8U05hekosu2a5f82YrfGKLfF+gPeXLVsZ4XNyfiUDEeQMCLVhdgw1FJCNJmNp/t1NDIqwsnuIiJ84NDgXSutQq6lCTBCrUNmNxwIsrH4IYzoekcPcwaDkVO8Ywa0TVM9bInuz7uh1GYsMaUjbEwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KU4RhYHW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ccc600466so3036932f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727876206; x=1728481006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeS6fGpb9kLNgYn5kD0zRdoYybzkuxoklL8QigoCJf4=;
        b=KU4RhYHWHCC4g0fmTg1/Dkzg1VktvC5b5RTSzRKtiG7dZiru5SqfGV7nOAJt1lWJT+
         hMteBAOof+GuPa8I61MpnKDNmUNQOFeaxmAgWKQNKbh7QYwoXy7ISjZ8yPzzV/4mNhtH
         UkTldSLsxCNc2D5Hq3S2OG7Vz4efP/9z9YApBnh5OKQXRM3AokAfUgRBRjv1/sx6qqPT
         OfnSBiKQKisve/LpUNHah4CVaYqRgoJQcUrTVv7G0Si0xagTN9rrjH0cBn6xGfJ85gCE
         qM1hEe1A7ij8j3zuF949q7jvANczuZmPoYBs154wdvT5u6Gn6CeFMsP47XtgjSfv6EGT
         rILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876206; x=1728481006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeS6fGpb9kLNgYn5kD0zRdoYybzkuxoklL8QigoCJf4=;
        b=QSQDJ0Ed/ku4TRYJbopWwLwlDfdPHomB9HHqYlkvsm6XXTlOAlc+AJguoNjuR5k/DT
         s2dXtCMUonkF+MJ+4pRjAd+yPqky5j6C8ZcYsw1qswAiYHQv5o20+0v2U/lC/r55Q/qe
         zCp3rtfIyO/nfglCvS+eR2y3OIS9UUHUck7Z2NjwLiTG3SOGdf6xFKjgSAFTFW8qNA2O
         w6GuKISMa11U0iJopEu7A2VpgH2j+nodkwlQvE83ix9AMNpwOkc5Oc20XO32Orh5IjcS
         dWHa1Uwaj4r6f57DUdWVTQTzszfiUd4OuTzstnh8nAfACGqy9PWf9izgkw1lfjdf8sP3
         TzEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCGsdtx4wwvA/aeHx357FS6D51CjCaZZTWpDrldMjZ0RPPsC11gPQWYAo8dOxwkhxpIjVnZ8nh14DlMj4b@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJVOOcxGEcQ5LQxTgYS0xzNGUjrk6ykY8ebj7NosNQh6CbuG3
	zWf9Fx/XNcyb8tA6RY+d/WBi10ZBaf37jf83VKRzDQf89Z8xoAYq+GMaQXrYWCXDbo6A/mIoDQk
	55nNucoEI8qCZFAzNmPSi7/yh59dKWr0sA6sO
X-Google-Smtp-Source: AGHT+IET4bgd2O7fUBJAw3Zthwv1E6m/zgp1w3SGtluJLDimHbPGXWAml2WMM4ZBGLhDNaa9XYD2lzzWg16o6cLs8qM=
X-Received: by 2002:adf:b186:0:b0:374:c581:9f4f with SMTP id
 ffacd0b85a97d-37cfba16a00mr2083256f8f.55.1727876205409; Wed, 02 Oct 2024
 06:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com> <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <20241002-rabiat-ehren-8c3d1f5a133d@brauner>
In-Reply-To: <20241002-rabiat-ehren-8c3d1f5a133d@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 2 Oct 2024 15:36:33 +0200
Message-ID: <CAH5fLgjdpF7F03ORSKkb+r3+nGfrnA+q1GKw=KHCHASrkz1NPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
To: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:24=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, Oct 02, 2024 at 12:48:12PM GMT, Arnd Bergmann wrote:
> > On Tue, Oct 1, 2024, at 08:22, Alice Ryhl wrote:
> > > +#[cfg(CONFIG_COMPAT)]
> > > +unsafe extern "C" fn fops_compat_ioctl<T: MiscDevice>(
> > > +    file: *mut bindings::file,
> > > +    cmd: c_uint,
> > > +    arg: c_ulong,
> > > +) -> c_long {
> > > +    // SAFETY: The compat ioctl call of a file can access the privat=
e
> > > data.
> > > +    let private =3D unsafe { (*file).private_data };
> > > +    // SAFETY: Ioctl calls can borrow the private data of the file.
> > > +    let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(priva=
te)
> > > };
> > > +
> > > +    match T::compat_ioctl(device, cmd as u32, arg as usize) {
> > > +        Ok(ret) =3D> ret as c_long,
> > > +        Err(err) =3D> err.to_errno() as c_long,
> > > +    }
> > > +}
> >
> > I think this works fine as a 1:1 mapping of the C API, so this
> > is certainly something we can do. On the other hand, it would be
> > nice to improve the interface in some way and make it better than
> > the C version.
> >
> > The changes that I think would be straightforward and helpful are:
> >
> > - combine native and compat handlers and pass a flag argument
> >   that the callback can check in case it has to do something
> >   special for compat mode
> >
> > - pass the 'arg' value as both a __user pointer and a 'long'
> >   value to avoid having to cast. This specifically simplifies
> >   the compat version since that needs different types of
> >   64-bit extension for incoming 32-bit values.
> >
> > On top of that, my ideal implementation would significantly
> > simplify writing safe ioctl handlers by using the information
> > encoded in the command word:
> >
> >  - copy the __user data into a kernel buffer for _IOW()
> >    and back for _IOR() type commands, or both for _IOWR()
> >  - check that the argument size matches the size of the
> >    structure it gets assigned to
>
> - Handle versioning by size for ioctl()s correctly so stuff like:
>
>         /* extensible ioctls */
>         switch (_IOC_NR(ioctl)) {
>         case _IOC_NR(NS_MNT_GET_INFO): {
>                 struct mnt_ns_info kinfo =3D {};
>                 struct mnt_ns_info __user *uinfo =3D (struct mnt_ns_info =
__user *)arg;
>                 size_t usize =3D _IOC_SIZE(ioctl);
>
>                 if (ns->ops->type !=3D CLONE_NEWNS)
>                         return -EINVAL;
>
>                 if (!uinfo)
>                         return -EINVAL;
>
>                 if (usize < MNT_NS_INFO_SIZE_VER0)
>                         return -EINVAL;
>
>                 return copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, =
&kinfo);
>         }
>
> This is not well-known and noone versions ioctl()s correctly and if they
> do it's their own hand-rolled thing. Ideally, this would be a first
> class concept with Rust bindings and versioning like this would be
> universally enforced.

Could you point me at some more complete documentation or example of
how to correctly do versioning?

Alice

