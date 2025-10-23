Return-Path: <linux-fsdevel+bounces-65301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09D8C00AEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ECC18C8342
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E1D30DD0B;
	Thu, 23 Oct 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jf4KXGQU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03CF30C35A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218417; cv=none; b=ZxgssgKvOoFNuzXnvM3wYwx7a60vdu5iQ3XsFPB/VfwpS7E0cdD/nusgY3m03ww06ppuK8WwPgJLJjoc+USEwKj0JWiYOS9VWa9ahybAYqMIDlSf3vcnu5NEFkL1zP1dYP4rS/g7SY+6WMEfLvvv1kDjBiwXXzrIaG78y5Bz06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218417; c=relaxed/simple;
	bh=h40p5k5+pElZQOdviKgfoGMd48LzDGMWUjhCF++upVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JgQBXb3pTQLINDN8Ai0NnZsrvOHzleAPhc/ahuyQs59EepBzcwelVcCNOfpVPuL6g25oYU9AgW9NAwaIJZ6TBaRwxnaQDoGy0QnWTErkvR56TPQlMbGSE+nRrQfaWo5R8cZVLj5qmpTej8G8avWkl5LZJ7baECcbmhJQjmpjwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jf4KXGQU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47114d373d5so5490775e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761218413; x=1761823213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VbiRN7dyfbR5k4LKjwiKuRphvzhFq3uU84mIhjYZi0=;
        b=jf4KXGQUfocjvesuOS/cBro9PAQ7U1DkNwf3cTcGEBS/iUnlBeyK/99uVEkKeB8JWI
         Su4Q6ROMrOovmhQjLr6gjUCCQeaL2XSfFdtEXqJIuqARe+jxZzalRP0hjJxvfaW/E5Wq
         JAaN+hg9myDsiTIC6gLi3hAJzMpKUoYWmSxVbQXLqUXNV1XC09YRHj+C5zTfStZEeZc2
         KoMd80i2rf4aR4FBY0YEodlTFuE656s9mIpk4GniBtQqbFg0Fe3ebkaNG+7lM+vGzNyl
         ae50DlMsjt+aQ0D4tdM/5levyMt0qEQaaGmTR5b6Du7kBf/uwXZUoWv9IWjcSTTV41vY
         CRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218413; x=1761823213;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/VbiRN7dyfbR5k4LKjwiKuRphvzhFq3uU84mIhjYZi0=;
        b=QDDL5/AwJMRhuJEo75v1pgg4rTYpZ22a1Oearje1K3bvhfa8raClQPD30QSuOEIx1v
         FqE3rQBPisKge81tsfsb9leUDvJ1xucPE7IPLkvQrb3io55C65kkByLVyg/gXfQcUh9Y
         ZViFDo14F7SRg75E3JLEPCZIurwgToKxL2CnfgXEG/4i6+ssc2VH1yxrSIxokG6C2wGZ
         2g8yPrI+oa3bkM20K+gv52Fu8LHIFSyaQAYg8vku7bjf0hno3t6KGx6/eFwz7ewjSO6r
         WzLjYMSHSM8EdkU6QXWf6Hg72i7/hDCVENvKNAwudNvHsCR9P0ZlurTlkIwC3eK4UuOd
         Ir2w==
X-Forwarded-Encrypted: i=1; AJvYcCWyGLeIuflLy2XifhHPkQDrm7YUGsP7COiSy8dHwduR0N/RbihN5hK93ajzu9rjkAIotp35/KCL6uIaPJ/3@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQb3bTU7Y9Nq/MZdIQilHu3nppbwBcM4kPEx//2AwTehZfcA3
	4d8OShotLZXD1vmalL1jJaNU7Vn/mEOTgcxlN27+ZsVr0REFdYCdWGbofBPXrfv4vzQEk57tYtk
	J2ZeWKiGm7bnMlaIgoQ==
X-Google-Smtp-Source: AGHT+IGgFDXdkbchdyD6FyA3f9D48Q6TJhqelFimolj3xmlXkCLl5F1WZy4r/uAtjiwVz/IxjL5J8cPMbOJgKxU=
X-Received: from wmwn22.prod.google.com ([2002:a05:600d:4356:b0:458:bdde:5c9b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5029:b0:46f:b32e:4af3 with SMTP id 5b1f17b1804b1-471178784efmr150564155e9.1.1761218413141;
 Thu, 23 Oct 2025 04:20:13 -0700 (PDT)
Date: Thu, 23 Oct 2025 11:20:12 +0000
In-Reply-To: <DDPNGUVNJR6K.SX999PDIF1N2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-6-dakr@kernel.org>
 <aPnnkU3IWwgERuT3@google.com> <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
 <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com> <DDPNGUVNJR6K.SX999PDIF1N2@kernel.org>
Message-ID: <aPoPbFXGXk_ohOpW@google.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 01:03:35PM +0200, Danilo Krummrich wrote:
> On Thu Oct 23, 2025 at 12:37 PM CEST, Alice Ryhl wrote:
> > On Thu, Oct 23, 2025 at 12:35=E2=80=AFPM Danilo Krummrich <dakr@kernel.=
org> wrote:
> >>
> >> On Thu Oct 23, 2025 at 10:30 AM CEST, Alice Ryhl wrote:
> >> > On Wed, Oct 22, 2025 at 04:30:39PM +0200, Danilo Krummrich wrote:
> >> >> Add UserSliceWriter::write_slice_file(), which is the same as
> >> >> UserSliceWriter::write_slice_partial() but updates the given
> >> >> file::Offset by the number of bytes written.
> >> >>
> >> >> This is equivalent to C's `simple_read_from_buffer()` and useful wh=
en
> >> >> dealing with file offsets from file operations.
> >> >>
> >> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> >> ---
> >> >>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
> >> >>  1 file changed, 24 insertions(+)
> >> >>
> >> >> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> >> >> index 539e77a09cbc..20ea31781efb 100644
> >> >> --- a/rust/kernel/uaccess.rs
> >> >> +++ b/rust/kernel/uaccess.rs
> >> >> @@ -495,6 +495,30 @@ pub fn write_slice_partial(&mut self, data: &[=
u8], offset: usize) -> Result<usiz
> >> >>              .map_or(Ok(0), |src| self.write_slice(src).map(|()| sr=
c.len()))
> >> >>      }
> >> >>
> >> >> +    /// Writes raw data to this user pointer from a kernel buffer =
partially.
> >> >> +    ///
> >> >> +    /// This is the same as [`Self::write_slice_partial`] but upda=
tes the given [`file::Offset`] by
> >> >> +    /// the number of bytes written.
> >> >> +    ///
> >> >> +    /// This is equivalent to C's `simple_read_from_buffer()`.
> >> >> +    ///
> >> >> +    /// On success, returns the number of bytes written.
> >> >> +    pub fn write_slice_file(&mut self, data: &[u8], offset: &mut f=
ile::Offset) -> Result<usize> {
> >> >> +        if offset.is_negative() {
> >> >> +            return Err(EINVAL);
> >> >> +        }
> >> >> +
> >> >> +        let Ok(offset_index) =3D (*offset).try_into() else {
> >> >> +            return Ok(0);
> >> >> +        };
> >> >> +
> >> >> +        let written =3D self.write_slice_partial(data, offset_inde=
x)?;
> >> >> +
> >> >> +        *offset =3D offset.saturating_add_usize(written);
> >> >
> >> > This addition should never overflow:
> >>
> >> It probably never will (which is why this was a + operation in v1).
> >>
> >> >       offset + written <=3D data.len() <=3D isize::MAX <=3D Offset::=
MAX
> >>
> >> However, this would rely on implementation details you listed, i.e. th=
e
> >> invariant that a slice length should be at most isize::MAX and what's =
the
> >> maximum size of file::Offset::MAX.
> >
> > It's not an implementation detail. All Rust allocations are guaranteed
> > to fit in isize::MAX bytes:
> > https://doc.rust-lang.org/stable/std/ptr/index.html#allocation
>=20
> Yeah, I'm aware -- I expressed this badly.
>=20
> What I meant is that for the kernel we obviously know that there's no
> architecture where isize::MAX > file::Offset::MAX.
>=20
> However, in the core API the conversion from usize to u128 is considered
> fallible. So, applying the assumption that isize::MAX <=3D file::Offset::=
MAX is at
> least inconsistent.

I would love to have infallible conversions from usize to u64 (and u32
to usize), but we can't really modify the stdlib to add them.

But even if we had them, it wouldn't help here since the target type is
i64, not u64. And there are usize values that don't fit in i64 - it's
just that in this case the usize fits in isize.

Alice

