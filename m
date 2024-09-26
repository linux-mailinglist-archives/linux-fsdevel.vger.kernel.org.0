Return-Path: <linux-fsdevel+bounces-30185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE52898765F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBD6283225
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0031531C2;
	Thu, 26 Sep 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSs5tKqC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386BF12F59C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364033; cv=none; b=hV1P8f/gI6EXAQDc6m7V80ESZtS5pK5764ZgS8MxmEdbITVcfZg0dXR8oc798kSNQVb3jCA5+Lpnsc0sui9vL5yY97vopDByxoA2NbDcd+ub8V1/LDTlPTrMs5qAUoJROc83N0TGmJyqHWBmL76unWO9Lb92aZWMaT6Z4i04AFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364033; c=relaxed/simple;
	bh=Oxqmzt/Gb9lT0Uy3WkMLCYfBbN2dPeu3dHEwc624L9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9d35LZGDitkhFu0966Hl0RtzVCxUmGNjn6ETcTLusFQBkkzSLjAKy+96slH8qJ+tCb3ya4s+m0smK2LkVVB+nadR5MLXDeP6/7w26gEUyAN4kwWcSeOs22MnzhInEaJXwnWk10UpdRWIs+7P2VTFq6beD23PDXEGmbpT1PksKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSs5tKqC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso10477635e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727364029; x=1727968829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ifzNqOHsKcrVEllKTLGB0+zkVLWxhM9/nwMBHraXo0=;
        b=mSs5tKqC/Y0Fb3J7YJKOOs5ODf8OU5iM/3NVjUT36wOh9S4C2P77De+vh+IXZHtEvz
         2xxxo3i18fli74V/tj86q2+8ZJDo5DFeomE3DzmsGxNsEk3FXdYwotT1DSYySQ2ujXsQ
         jV8XbbZRn6lAe55o8zHTbVxjAIUhs5T5cj64z36yhhrKYFR0Sm+ZZ6OwibhETVG3dwQZ
         1eeprikm0VAi+zFPETt8oynPJXydLOvPcYkkP5D0xC9oBS68GX18PqqgmAbOXszcHHr+
         PVTdCu46N5OMRjyTpQnR9Nz/hudgUXvGQ6KhWLc+9sgALRrMp78VyXBJGlWwGuhNXgk+
         YEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364029; x=1727968829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ifzNqOHsKcrVEllKTLGB0+zkVLWxhM9/nwMBHraXo0=;
        b=UzFe//1qKoF3Sd+LCurVeC8tkpxqzKlT4ZigQpYJd4UfjJW9I+J6fABiHb3RLR/Obi
         n53d+Z6YZsSNkj1IZwOswTAvdf/cvAVd8pjrIb+wJnaG4rzxZw/icMlphj+u9Cf+lgPR
         Re+NDyUp/a3AFmEmbUQbtTDuMNP8RfcYCKv5xJy5MDzE/f6+uYRupa+nMoh71ZxzyZIn
         fdxCefHeexG9WrSVLrvh1yB++kuzG8WNhK7Oun2waRbdfgUKg816gC9curlo+q8DfA3/
         NHky8F1J67KA66tSg5HVyOiF1UkREVIz4aNp4GO1poLiZ2jyVuy6r78635hbpPLCnRIO
         11zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCskjwfaOJrZlDHk0RT17qBtAfGRxE8Mxdcxj/bcfbxSMtzgu1GwHkWy0945tpazsTtVTEEkMw2DiYhSNW@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXCztwY7xgzv+LnpSb/8d3CzaWffkRnWy/AIsKR/f3/RSXH1Y
	1Ypuuuw2wg3HLbIM3Ef5UZUiDrLqKXXhCBLVOiPEjfmtA/Hu6AS+nGQXKpNa0wTZCbyfOJwvY1d
	chiRg5TqhNol/RJAHDcMDJc0coPFbLs9n1qbn
X-Google-Smtp-Source: AGHT+IHrDwTw/6VY0EmcTYJyBlqnV2T6x/gjNgJUnRuUbF/y0O4Xv2KgCLxC5z41nbCf//Aa2D3PycMN7GdX0t8WX2E=
X-Received: by 2002:adf:c04c:0:b0:374:c8e0:d76b with SMTP id
 ffacd0b85a97d-37cc245b083mr4695581f8f.6.1727364029102; Thu, 26 Sep 2024
 08:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com> <2024092647-subgroup-aqueduct-ec24@gregkh>
In-Reply-To: <2024092647-subgroup-aqueduct-ec24@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 26 Sep 2024 17:20:15 +0200
Message-ID: <CAH5fLgh8DE8cPC+-HPz6vshCwToA2QyGqngj77N9x16cAUfpiQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Miscdevices in Rust
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 5:05=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 26, 2024 at 02:58:54PM +0000, Alice Ryhl wrote:
> > A misc device is generally the best place to start with your first Rust
> > driver, so having abstractions for miscdevice in Rust will be important
> > for our ability to teach Rust to kernel developers.
> >
> > I intend to add a sample driver using these abstractions, and I also
> > intend to use it in Rust Binder to handle the case where binderfs is
> > turned off.
> >
> > I know that the patchset is still a bit rough. It could use some work o=
n
> > the file position aspect. But I'm sending this out now to get feedback
> > on the overall approach.
>
> Very cool!
>
> > This patchset depends on files [1] and vma [2].
> >
> > Link: https://lore.kernel.org/all/20240915-alice-file-v10-0-88484f7a3dc=
f@google.com/ [1]
> > Link: https://lore.kernel.org/all/20240806-vma-v5-1-04018f05de2b@google=
.com/ [2]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Does it really need all of those dependencies?  I know your development
> stack is deep here, but maybe I can unwind a bit of the file stuff to
> get this in for the next merge window (6.13-rc1) if those two aren't
> going to be planned for there.

Ah, maybe not. The dependency on files is necessary to allow the file
to look at its own fields, e.g. whether O_NONBLOCK is set or what the
file position is. But we can take that out for now and add it once
both miscdevice and file have landed. I'm hoping that file will land
for 6.13, but untangling them allows both to land in 6.13.

As for vma, it's needed for mmap, but if I take out the ability to
define an mmap operation, I don't need it. We can always add back mmap
once both miscdevice and vma have landed.

Thank you for the suggestion on untangling the dependencies.

> I'll look into this some more next week, thanks!

Thanks!

Alice

