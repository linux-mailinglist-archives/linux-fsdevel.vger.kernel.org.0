Return-Path: <linux-fsdevel+bounces-41871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61356A38A84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4981890FF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A208229B1E;
	Mon, 17 Feb 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca44laX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A944EB51;
	Mon, 17 Feb 2025 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813106; cv=none; b=H3fQwni3byJ3q7+vkkEjqLmklW6ZoBqmJs5Hd71gNl2918W0lFEgpnky/a+UvkfLUMqitygLPaRcRqToUsm3SGyVTHAQkl5fDWmE+2FsSNTDX312GqQ8j0Rh3gmZllV/9tqFNIdAEbohW925gFkiJI847LFQXltiRU4XSIB1p2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813106; c=relaxed/simple;
	bh=FcpGYvmdtwwhIJ4dHydo5UqPEJfKoMifDwgHkRA98O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lm0msnTa5iMS1IRcqRX4hSobuRzvo4uW4KxCcJuAuzWtZeK4fw++a1OrQieN7XOx52nKj15+GGyYoMPp+4nskOQVw6tHW75IEAvGS+nTVxyRLAffdRD1v6Pfy1rg9mzm4ioTSnswgmsezZbTdGiMRfdbdY4JxPxy8q6WQ0uR3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca44laX1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc0ab102e2so1050166a91.1;
        Mon, 17 Feb 2025 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739813104; x=1740417904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcpGYvmdtwwhIJ4dHydo5UqPEJfKoMifDwgHkRA98O8=;
        b=Ca44laX1FuqU+mEewq/Z9xb6PIgwS6D1ZhpbXtg2psk7BCRMl9168ywwS5mPaI0Vaz
         QdVe1BEkbilNp6+Ad+XO+JmzOuzqSuqXwwRHZZ7P8pYq0DX1HxkRxgl/KYpEiuohebsk
         W4fiFLWS6+qSdK4TU2SayBeXUlSWP7/udyhJsoU5CXtr+RNGbXodLNd9bmkbVILi2p+u
         oYzsFj9jEVl75q3AGJyTqEOKGXRZMa1Y6zGAC61C+o97ghKEQ4zGJx+AwnSL6RSlBSy0
         9Vj6yAKZ1uFBnVSbVtkLkRpK/vpTdxgt5jidiX9K16DWoAfFRsIWsT0740ZDPKsrlYxS
         Ek7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813104; x=1740417904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcpGYvmdtwwhIJ4dHydo5UqPEJfKoMifDwgHkRA98O8=;
        b=fw9rZVVU1mwQMexsYWnWvWKiQQsWZbPPGW1aPEFZKgvldVDvn05atYvn/qTuMJJ2bW
         Etz/OOxu4rXuWobd0pRA0izmAyhQt+i3HVrP+p/THmDnDj3A07LOdGonM3IiEFDfGrcx
         XeWSIsYI81OuNFumnbmPAg9p1TXaHTg/PKk8BaDyu/Nm0JIf3fMtxgGLNjrur0DbcJFW
         T/hYsZILwxhEcwOIv/4PTKiVezkiRsiEpKLHBmvU7IyDyY26BlFIwAP6RAIzjY2Y2DWn
         jnJJm0FFfvLNZUSKuKgQTZMtMYOqt5ragh/LAIQqZcXKwCzL+2NhgQdm3ule/FohK+F0
         V3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCV7QnFVJKmD3lYVd/zWXnsdiqlO++eKtLZEq9OdZOwD99LoeXhThqhqFBp8jXo+25lmfYNpfcpRthnX+8K2@vger.kernel.org, AJvYcCWpLJAT1zOc61L57w0G5DpVNxgDZe58hrp/W0ppUUaUU8voS3v/NWJkMfUDvR8p4qLQFDDmKtZo3ZnimXxR@vger.kernel.org, AJvYcCWscz9l48NdnQ+lgfNEOSOfFDTHZzl3AaP47QHvj2J9rNuqGv2sIkFwmptorvaoSnhgvsO0N2nwjmbI@vger.kernel.org, AJvYcCXRLe4gBXeSkikiPfJf5o/9wcEg596Qf/6QPRYiv4leZQDcsWO3lI0skWrU7/xdwdjXDYUlCty/SOuTuHn5yx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywv2MBquZ7wzlCbzKN6XbixMaET1GM5kGJw0IyMAhHLMrPlRcb
	yl/i6X9iIGUMEvZ7Qao3jkoxca9cpMPpNZygJbJtLg3L7a1+Bfw3QQSBPqCd9xMREmBQpw1U1pS
	K4/RtluiI9awxb56fYL4y6/WYvGk=
X-Gm-Gg: ASbGncvowQgtqv7ffouJsYuDGMaMw1Rga/BjAVdHKaJD/h3jh6aoYSiRkBj0BRZFiPR
	J1E5xu9LGMHJLw3akiPLgGssOnCEMp36ttP3eJDjg1jg1Ra1JWF4Gt83EUpd3mFitPQh/t+KH
X-Google-Smtp-Source: AGHT+IGfwCTeqstsgIsiK/MKQ/iUTmSLXB7VCe5xjH1OnjLFDvxLl/DUXxKb+UsY5FqLU1Cu/EIytJpEOjkXgoF3fu8=
X-Received: by 2002:a17:90b:2fc3:b0:2fa:6055:17e7 with SMTP id
 98e67ed59e1d1-2fc41173947mr6075604a91.8.1739813104405; Mon, 17 Feb 2025
 09:25:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
 <Z7MnxKSSNY7IyExt@cassiopeiae> <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
 <Z7NEZfuXSr3Ofh1G@cassiopeiae> <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>
 <CANiq72kAhw6XwPzGu+FrF64PZ9P_eSzX3gqG9CLvy7YJnbXgoQ@mail.gmail.com> <CAJ-ks9mFT1Gaao+OrdYF+hg6Sp=XghyHWu1VTALdeMJPwkX=Uw@mail.gmail.com>
In-Reply-To: <CAJ-ks9mFT1Gaao+OrdYF+hg6Sp=XghyHWu1VTALdeMJPwkX=Uw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Feb 2025 18:24:52 +0100
X-Gm-Features: AWEUYZkbsI3FPn2Xmxj8TJ-MBdTZiQo90g9XW-TdOOtJ4TRiM_QuFvTbEcwSBR0
Message-ID: <CANiq72kFpDt230zBugN12q978LRSJiZB5dJZszWkL2p7XqQ52w@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 6:11=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Only my personal experience with git blame. The `.cast()` call itself
> is boilerplate that arises from the difference in types between the
> abstractions and the bindings; my opinion is that a user of git blame
> is more likely to be interested in the rationale accompanying the
> implementation rather than that of the type shuffle.

I understand the rationale -- what I meant to ask is if you saw that
rule in kernel documentation or similar, because I could be missing
something, but I don't think we do that in the kernel.

So if you have a change like that, please just change the line, rather
than adding new ones just for `git blame`.

Cheers,
Miguel

