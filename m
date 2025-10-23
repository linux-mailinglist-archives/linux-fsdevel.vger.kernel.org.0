Return-Path: <linux-fsdevel+bounces-65293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5531EC008A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0E19500ED8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D042EF667;
	Thu, 23 Oct 2025 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JiaADP40"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B932C11D9
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215863; cv=none; b=VkLl5b7sAfqhZsajHQcO5C1YE9SbGnrLQ4tb98dfflrn9P7B6dBfl83E8mRTNFexMZNRYPtzx11OQUhag2GQbtVP41Q0CqY4gq8bmem69tAyzs+gegm8fG1ZelhVsGSQApOiRrLk2EUV/TBp2HcjrvjL0/PSsv0cZH73lFirG7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215863; c=relaxed/simple;
	bh=YYxfUPdfLOOxl7Euu9zdXiMarVpXjjOUqwtysvwPqAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGOKs46OJdRV7vqqR+vCxCDGTLUsngHtnpCHH7x5rRwUbSFNlMYw5Re7wwOgkfMW9Glb8gbHDIyrx9KK0mDTSRx7K6XyxQ1OP7iw7Zp6i2aebpozixkjKzAxoJfNpn0aMYkdYTq/yN+ll0T+Vnp5Dd5iMyfuldNL4p7PFPFenNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JiaADP40; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421851bca51so621298f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761215859; x=1761820659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlbOJJaTUJl2R9AS5ER+G1wmL9urQDFVZkUedb+ly68=;
        b=JiaADP40+cdDUse3X8lkAmhG/cK7DQllg6z2yNIapco8KiopK+kDSldASAADjDL0t8
         3WD90uo635LI0L7l4X7Ody6moFNC9bEligxs5KZ+4CZ/bA8hORhbLCIIhxeh6KXwp+yi
         iQKi3cqNgdCly5TLF1MypNGocpERPCg3b/hj/XPKjTC10sUOobS9UyCKXT2FOxDkDpkq
         Gy3bQRcVWfBvGtKWLHbiyPabsFCgT3FVa7RWKiKds8I3aBC2dfhq6Rf1y/COWJmR+rTN
         It5PvSEZZ3SJCfO84lmYe0ijJTHXOZTn21Wkfq+0gFGrFDAM6fyglraBoArWwsBkI+TY
         SOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215859; x=1761820659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlbOJJaTUJl2R9AS5ER+G1wmL9urQDFVZkUedb+ly68=;
        b=XmHoWI6W7tGjUBjUqEPWDTweJ0ioBxPrEnOcvbTmrJQaAgPq39C6gh8E4oI8vurYJq
         dEkqdp4b0apC/jJmAUJwGTK5P/Mjk2UBqeM0puaHCyKjU995QKjCV5DU9GeA70b1N/c/
         lkVNSuI5LPbBMAfgqv9LCkYnYzLlYoTXZZADJzAg9VbqYaCUOMamR08WV9C5g1P/o7hh
         PXqJv9Evr0Q10d9CKp/pDRuB40a517hcFP6mIrwCpIk9JG8wvQw0pUM1ybGF+ZfQpj0x
         PzowY6I2OoWC0GRGucePs4zSNcLBDDblFxzDFzne1/YvO8wkQnuZgPZMmXvx6aQY3EtZ
         Qaew==
X-Forwarded-Encrypted: i=1; AJvYcCXAi4RkRLkQDkieJ1VJ/kqAhJ3BxfAxLHevOamgc+PPhe+Y5pppUCCwkdVGgm9y1ZjYR5HXV6b/QxLoDtjC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5eiWA1X2S2+Ouiuiw+6S3+O8WRbVboR5gdKOJcZSE0osyhLh
	MrPbRJqojV3bMFQIbdL5o02e5F7inyKFG/YWp3uvYXaef1M4gMaF243wdxGGkla3sTO5ZqgUeCN
	DQ30Snr8joRpZSSi2JAM/OZOFisex9xJdRxRnK1OW
X-Gm-Gg: ASbGncvtunB/SFsfzpb/5kFCU+XzBe4jG2jCejD9ZZ8auqiycQaZFzbQf4aUyK8IFfZ
	VIxcqL0Wu9hMJKmWrtQA/4yB0gzieRK/5Pw/Z+hzlYgsnbs3sRVXOeZpFpR4u/5jhiXyKsTS3Lq
	mgV2YUQ/tj2MmUKWaF/uRK2+pttsfPMnUm2BAGrB/1CCkHaOpO9HB5+9U5T4MBf8PrF+dNS4VTV
	+ewL51aGiyxRP9qgpd3a9kPK+wUVIc9yseM0z2XVg3s9W2muZXmWw9Oyc0vUw==
X-Google-Smtp-Source: AGHT+IF7maTSQiS4kZPLIabukQBdn/rZWFtqT50NtIAJr4GO0YjV9vbHGhXIn7kavPdqJnen7ikTwzQkeGILfRe8wuI=
X-Received: by 2002:a05:6000:25fd:b0:427:587:d9ae with SMTP id
 ffacd0b85a97d-4270587d9c1mr13312291f8f.9.1761215858529; Thu, 23 Oct 2025
 03:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-6-dakr@kernel.org>
 <aPnnkU3IWwgERuT3@google.com> <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
In-Reply-To: <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 23 Oct 2025 12:37:25 +0200
X-Gm-Features: AWmQ_bnHmpaGJ5SXvKhXy7BPOYeRX2L2uNppxAQX8TK3YbD6TWoOM-Pb_fLGRa8
Message-ID: <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:35=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Thu Oct 23, 2025 at 10:30 AM CEST, Alice Ryhl wrote:
> > On Wed, Oct 22, 2025 at 04:30:39PM +0200, Danilo Krummrich wrote:
> >> Add UserSliceWriter::write_slice_file(), which is the same as
> >> UserSliceWriter::write_slice_partial() but updates the given
> >> file::Offset by the number of bytes written.
> >>
> >> This is equivalent to C's `simple_read_from_buffer()` and useful when
> >> dealing with file offsets from file operations.
> >>
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> ---
> >>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> >> index 539e77a09cbc..20ea31781efb 100644
> >> --- a/rust/kernel/uaccess.rs
> >> +++ b/rust/kernel/uaccess.rs
> >> @@ -495,6 +495,30 @@ pub fn write_slice_partial(&mut self, data: &[u8]=
, offset: usize) -> Result<usiz
> >>              .map_or(Ok(0), |src| self.write_slice(src).map(|()| src.l=
en()))
> >>      }
> >>
> >> +    /// Writes raw data to this user pointer from a kernel buffer par=
tially.
> >> +    ///
> >> +    /// This is the same as [`Self::write_slice_partial`] but updates=
 the given [`file::Offset`] by
> >> +    /// the number of bytes written.
> >> +    ///
> >> +    /// This is equivalent to C's `simple_read_from_buffer()`.
> >> +    ///
> >> +    /// On success, returns the number of bytes written.
> >> +    pub fn write_slice_file(&mut self, data: &[u8], offset: &mut file=
::Offset) -> Result<usize> {
> >> +        if offset.is_negative() {
> >> +            return Err(EINVAL);
> >> +        }
> >> +
> >> +        let Ok(offset_index) =3D (*offset).try_into() else {
> >> +            return Ok(0);
> >> +        };
> >> +
> >> +        let written =3D self.write_slice_partial(data, offset_index)?=
;
> >> +
> >> +        *offset =3D offset.saturating_add_usize(written);
> >
> > This addition should never overflow:
>
> It probably never will (which is why this was a + operation in v1).
>
> >       offset + written <=3D data.len() <=3D isize::MAX <=3D Offset::MAX
>
> However, this would rely on implementation details you listed, i.e. the
> invariant that a slice length should be at most isize::MAX and what's the
> maximum size of file::Offset::MAX.

It's not an implementation detail. All Rust allocations are guaranteed
to fit in isize::MAX bytes:
https://doc.rust-lang.org/stable/std/ptr/index.html#allocation

Alice

