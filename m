Return-Path: <linux-fsdevel+bounces-65437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 677CBC059BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0881B818AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB03101AA;
	Fri, 24 Oct 2025 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSz7tjwg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FB30F537
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302219; cv=none; b=cxgv28g6gIXB/be8CsIzFArFpPIc6803wZqAkPT44CMpbHOdq2qtGHsJRplV+ow+i144y8fiVRcn4StCelclLGpNsa24/PcwzS5+GaXNAxSwxny98s/24sggq69TgKVYgFiuZ+rlhoEeezP+j31aLVbZsIKzhaV9qkEMt2I6SG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302219; c=relaxed/simple;
	bh=s2FO8pnEV/7szb+dOJiq08LSuK/rb7I+nZ2d4KW8ctI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hLsfpzx3yIHaD7egOlA9FurBK7+oGAEnxGGeRv+bb+m0tENasmIubHNRet0HBFqi7wh/RovIJrYAITSPfpjrUTdSt+105pNvxDyilmrUzcHOG79FJsKT/wmqcJC062eR2yl8loNfTdH5/yRNHNmeU+6FQijoMImynu1mgbfPQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSz7tjwg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e39567579so9159055e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761302216; x=1761907016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5WckZjr4qpmTV+gX2VgoGwpr/mWfENYA9Da0Yb01PI=;
        b=MSz7tjwgyvFZkXvDVUUXgaxwns48UJXrL6dnuTQzZ43x3DlchEM61p71kMIuz64ph9
         suiSlWxDC2AcqvZESe7730GIUlX1KntWwl+gUZ+7e4CY+rcdMDN2iDQQ5yNUngCDTQjf
         FhlGmFNnfYQke2YQC/LcnvN9KAXP03bV7aiWOxaiLeVuTSYWvza+5Ec2Of1RFoJAYNWf
         cvZbUaszI4w394upLVxOhNSATrn9+PqqGfEIaPcg1f4CLxX+tRaUiFCLVSXHAw8qpGkm
         Nmg/DjVkc0N+3j9E17j1Z5bCoviefd4Cd/uNGcQWB61yVFMHTrrN7tNy1lHwaQPE5ppL
         A6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302216; x=1761907016;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c5WckZjr4qpmTV+gX2VgoGwpr/mWfENYA9Da0Yb01PI=;
        b=v5MJ9XIR3j+o1wh2w/6BKBIJ9cgYD3s3AbizKKM1dhR7gph/Twy7lZasf3jAoUhF7s
         RK846+4PndLBp6yQL0UY0mkSqO4DrFNbJvioNdxrG7dbjkJ1uhSn0ayunYAhd8B1mGgy
         RQclY5ninlEYP3ecmZpoQbFeaphh7zaL3Ibt4VJ46S//iv4fVEdlgtgZJWOGyZFyPjhf
         86Q0ma6+F8uHm6rvbfwu3QwjErjbQoq/oU+GpJxX0z6M3mVhmkyOdj4d7jf6XitHxi5f
         90p/iGQth5y9R5rz3Cd/TCZM/jaqgxb+6WW931Jsa5pZdwvxya5y3baCJaGn2n3BrXlE
         a02w==
X-Forwarded-Encrypted: i=1; AJvYcCWXQifaAwugx8vl+OqPgTLnmtzR1JINOztcMjzuxVCywu71lciGeIoJtGEd5rkx/lsSWAepkyWiHvqVpKcq@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZIwTm+tCDwLZFnH/CDwW/JxQt44kpmKasaxOsXq67U4hSAvX
	1kcIT0kuN78CVRb7fyHY0CbYUVC383vgn3Bkh3s060a3F3EwSusrZxF0FvnXYu8OF7SSJVciSGm
	+2KDhax2C0BrFu70Ddw==
X-Google-Smtp-Source: AGHT+IF6Mgy1YsJz+7QCsPHpP9ik7YMhi0K8WjvdltQv05VpchJvsZPKXTgJ4bEGg+tkcUMZROs5PhBuuxH4BSw=
X-Received: from wmsm9.prod.google.com ([2002:a05:600c:3b09:b0:46e:684e:1977])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524f:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-471178a6e99mr195067895e9.17.1761302216346;
 Fri, 24 Oct 2025 03:36:56 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:36:55 +0000
In-Reply-To: <CAH5fLghiEqqccH-0S9-GD7pJaNuVpuo_NecMMmGVF+zR7Xs_dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-7-dakr@kernel.org>
 <aPnmriUUdbsQAu3e@google.com> <DDPMBR9EUYJ6.23AYG1B27BUEN@kernel.org> <CAH5fLghiEqqccH-0S9-GD7pJaNuVpuo_NecMMmGVF+zR7Xs_dA@mail.gmail.com>
Message-ID: <aPtWx4i3WuIlcWEM@google.com>
Subject: Re: [PATCH v3 06/10] rust: debugfs: support for binary large objects
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:21:24PM +0200, Alice Ryhl wrote:
> On Thu, Oct 23, 2025 at 12:09=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> >
> > On Thu Oct 23, 2025 at 10:26 AM CEST, Alice Ryhl wrote:
> > > On Wed, Oct 22, 2025 at 04:30:40PM +0200, Danilo Krummrich wrote:
> > >> Introduce support for read-only, write-only, and read-write binary f=
iles
> > >> in Rust debugfs. This adds:
> > >>
> > >> - BinaryWriter and BinaryReader traits for writing to and reading fr=
om
> > >>   user slices in binary form.
> > >> - New Dir methods: read_binary_file(), write_binary_file(),
> > >>   `read_write_binary_file`.
> > >> - Corresponding FileOps implementations: BinaryReadFile,
> > >>   BinaryWriteFile, BinaryReadWriteFile.
> > >>
> > >> This allows kernel modules to expose arbitrary binary data through
> > >> debugfs, with proper support for offsets and partial reads/writes.
> > >>
> > >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> > >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > >
> > >> +extern "C" fn blob_read<T: BinaryWriter>(
> > >> +    file: *mut bindings::file,
> > >> +    buf: *mut c_char,
> > >> +    count: usize,
> > >> +    ppos: *mut bindings::loff_t,
> > >> +) -> isize {
> > >> +    // SAFETY:
> > >> +    // - `file` is a valid pointer to a `struct file`.
> > >> +    // - The type invariant of `FileOps` guarantees that `private_d=
ata` points to a valid `T`.
> > >> +    let this =3D unsafe { &*((*file).private_data.cast::<T>()) };
> > >> +
> > >> +    // SAFETY:
> > >> +    // `ppos` is a valid `file::Offset` pointer.
> > >> +    // We have exclusive access to `ppos`.
> > >> +    let pos =3D unsafe { file::Offset::from_raw(ppos) };
> > >> +
> > >> +    let mut writer =3D UserSlice::new(UserPtr::from_ptr(buf.cast())=
, count).writer();
> > >> +
> > >> +    let ret =3D || -> Result<isize> {
> > >> +        let written =3D this.write_to_slice(&mut writer, pos)?;
> > >> +
> > >> +        Ok(written.try_into()?)
> > >
> > > Hmm ... a conversion? Sounds like write_to_slice() has the wrong retu=
rn
> > > type.
> >
> > write_to_slice() returns the number of bytes written as usize, which se=
ems
> > correct, no?
>=20
> Yes, you're right, I think usize is the right value. The cast is
> unfortunate, but it can't really be avoided. In practice it should
> never fail because slice lengths always fit in an isize, but isize
> isn't the right type.
>=20
> Alice

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

