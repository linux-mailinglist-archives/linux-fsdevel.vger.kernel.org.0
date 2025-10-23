Return-Path: <linux-fsdevel+bounces-65288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D2C0070E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 12:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09C93AC3BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F5930504C;
	Thu, 23 Oct 2025 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VA2CNkyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF5303A1E
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214901; cv=none; b=YbS3A9wxOaQ6aldPbNoGSmTpy+Bbre/BpTlyW28CHlKcZhw8SsWKRfEfUeOLKGT34FEWGSylhMSEBwLZMxKuM53Kilk5m5SzQf9FF42URzt0gHWWLFIj/5P+YmfwcZKWaYgu+QMAeDDsfSYyUqO9biAQfsvzLYREg83ZxzkJ+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214901; c=relaxed/simple;
	bh=Qu5ezQS4KZt4gS/T53hUJlw3TLfcC1axpEoYACdUN/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRMvumxPOx7iUfug6at2Wj5UVy2GVWwzae21HvizTMiAiI9Aafvddq5rsJX6j1b2+yX1MyizoUJhTe3TyYVrdDcKI+/N/D8+vaBENYeulWZF12a1r9E+eSaS/yHoHHnYzWKBOyHBv24MnqLPV5FQ/L5IkYerjgD17ju3jjVG3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VA2CNkyy; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee12807d97so485296f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 03:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761214898; x=1761819698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwSw9XohcV8SjPUTl/sxIv1p5bvIiKGLRD0+vYZME4w=;
        b=VA2CNkyyusgokUy5/mTkZfzM6z3amyobxPbokETGHxsTvJqAYw6uu0Mh9U6KF4FTzW
         G6VmDolvlu6nB0qm4dXenpvmuTrAIJOewStnMPHz0WzmPUleBykENiEo5iPdNrbP/0wi
         rJFWOtPh0tEhcfzEo+f5AKZNSOVD6euMxTBa1f2m6+xtAvFgzuL3U7sAtqb7YGgMEp8G
         LfgD6GVtxtiPdk0/oB6w8L3t36T38SDDfKPUX69EDa+S49+CyuM7jOmokxjFIG6YwQDc
         WhweddVvYa9fEJzuJn7DizjLJissFIYoduPCbBhgeAda2JhG8swgAXpcOgxW3cshMnKg
         Tylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214898; x=1761819698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwSw9XohcV8SjPUTl/sxIv1p5bvIiKGLRD0+vYZME4w=;
        b=KJ8v50qmBgdf5qvy/Ky11/KFpqgBkCCImZx1RntE9oCnjIY69Z1alIK9O93mSz++au
         mGUDyB87ADnEDjY1GIpDXk+9AHmaznA6dcLtJ3UtRlxp9eRxwSAwXEnVjfSawLy+PTdR
         7hGCYXaDJKg664gnFnSbuPvxZyi3wTNQhDZcRQzCXFTdzLCjM1XUtPT+6fXD2Noaa+Xe
         HCBGjclyeF+QVcG8b0U80ecQl23rS/ZBrry8hRyX+MUL/uLMknVi/IJzUjesECZ+Nivw
         msBvmsJhqxM4t6YSSCVUYk/yk5OYbr81AWIum+caCcTapN7Ldf/2jC/rYqkoY2QSkfi5
         Bisw==
X-Forwarded-Encrypted: i=1; AJvYcCXFecYwZT1P+f2gX4NwVMUNTtA6Qf7f5tPfj7xTWIhqVwXNeXvSXLASMu4Oxn63SD03VFNvP4KOZbU3KR2r@vger.kernel.org
X-Gm-Message-State: AOJu0YzVF58vxgIskPTLaTHaM7n35H28DoDEuEp6AcW7WOKX2s4SLY3f
	vioxuVVWvguM1Po3rGBNgh1OqGivTIR8vVYPAjZCY2RJG0+HUFG02C35iKGUIWEAskrPFLNmGi3
	HBelYOYTyUzNhnad/c9iZek4RxdMnm3G9TEMm7aRY
X-Gm-Gg: ASbGnctTZ/J9eHzuLM5yQwlQbUhvFaMAu5DcqxIq3ayhjfnFMyEIU3icdYCMuCOPKDx
	iu/ZFFKA9em45DDEIP/4Lj0LNEn1kzgqAnmSUI9XRqv8ZRyxSqdN9fATyhnhLfNoGZDJnNiDhFI
	7FS5DpDH2UXudV/MCKzD/t21c/b3h9uXhZ+p86uPefJ3X9TSrjS9MHCV2H5o76z4daP3n8rN2br
	+vvHhvNUj+AHl1YqGBRsdLwAVczDLBCceOOdAwOubmM8KLnOVV8ysCOsGib8fSzZAoNBPVo
X-Google-Smtp-Source: AGHT+IFLDhOLNuSegdUPm81Yq0CjIZ1l+FCrC2+tNMd6VE8o2hy/t+zBizqWs3Y8kdD0gj4e3g9Q32zbdZJh/hgiTMw=
X-Received: by 2002:a05:6000:178e:b0:427:241:91c2 with SMTP id
 ffacd0b85a97d-42704d963cbmr14859523f8f.30.1761214897852; Thu, 23 Oct 2025
 03:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-7-dakr@kernel.org>
 <aPnmriUUdbsQAu3e@google.com> <DDPMBR9EUYJ6.23AYG1B27BUEN@kernel.org>
In-Reply-To: <DDPMBR9EUYJ6.23AYG1B27BUEN@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 23 Oct 2025 12:21:24 +0200
X-Gm-Features: AWmQ_blZjh9RfWntbP8mSS9aGUvEtZhlLJ652Y3NHwlru1u3c7sSo8Jq4WXN3O0
Message-ID: <CAH5fLghiEqqccH-0S9-GD7pJaNuVpuo_NecMMmGVF+zR7Xs_dA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] rust: debugfs: support for binary large objects
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:09=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Thu Oct 23, 2025 at 10:26 AM CEST, Alice Ryhl wrote:
> > On Wed, Oct 22, 2025 at 04:30:40PM +0200, Danilo Krummrich wrote:
> >> Introduce support for read-only, write-only, and read-write binary fil=
es
> >> in Rust debugfs. This adds:
> >>
> >> - BinaryWriter and BinaryReader traits for writing to and reading from
> >>   user slices in binary form.
> >> - New Dir methods: read_binary_file(), write_binary_file(),
> >>   `read_write_binary_file`.
> >> - Corresponding FileOps implementations: BinaryReadFile,
> >>   BinaryWriteFile, BinaryReadWriteFile.
> >>
> >> This allows kernel modules to expose arbitrary binary data through
> >> debugfs, with proper support for offsets and partial reads/writes.
> >>
> >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >
> >> +extern "C" fn blob_read<T: BinaryWriter>(
> >> +    file: *mut bindings::file,
> >> +    buf: *mut c_char,
> >> +    count: usize,
> >> +    ppos: *mut bindings::loff_t,
> >> +) -> isize {
> >> +    // SAFETY:
> >> +    // - `file` is a valid pointer to a `struct file`.
> >> +    // - The type invariant of `FileOps` guarantees that `private_dat=
a` points to a valid `T`.
> >> +    let this =3D unsafe { &*((*file).private_data.cast::<T>()) };
> >> +
> >> +    // SAFETY:
> >> +    // `ppos` is a valid `file::Offset` pointer.
> >> +    // We have exclusive access to `ppos`.
> >> +    let pos =3D unsafe { file::Offset::from_raw(ppos) };
> >> +
> >> +    let mut writer =3D UserSlice::new(UserPtr::from_ptr(buf.cast()), =
count).writer();
> >> +
> >> +    let ret =3D || -> Result<isize> {
> >> +        let written =3D this.write_to_slice(&mut writer, pos)?;
> >> +
> >> +        Ok(written.try_into()?)
> >
> > Hmm ... a conversion? Sounds like write_to_slice() has the wrong return
> > type.
>
> write_to_slice() returns the number of bytes written as usize, which seem=
s
> correct, no?

Yes, you're right, I think usize is the right value. The cast is
unfortunate, but it can't really be avoided. In practice it should
never fail because slice lengths always fit in an isize, but isize
isn't the right type.

Alice

