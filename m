Return-Path: <linux-fsdevel+bounces-41869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7CFA38A49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF8C7A44E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01212227BB8;
	Mon, 17 Feb 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiyE71+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A6227581;
	Mon, 17 Feb 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811849; cv=none; b=Kc48p1pR9Yf4kc/IR5n8ZXLf3xBfc4f259b4Ma4MBbhemraz7eYWTxJkHLdQdY+zwZPjmugMH5PxUsQhzeYrFeUs8iJ58f19i/Rgc/RhB2oNTG8bZigzQbhtcEO5uIBARu3sZUMqOdMmmz9FUv9lYT0keBd4WLIjuoHmZWPiLjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811849; c=relaxed/simple;
	bh=1bMglenQoBAxuUrNFMrnRamqieLlLc1NCnUhO3lY+L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vt8NHApaSP+0HFpOlYkY0W4HWQHktFSZTHGMiO4ioiiKeAkt//YMT4xcw0eLjrzLOrJEblR1wpgVEid6IBF+GD1KNs6Zp/qRNCbozi4REyTcYHjK/FUeS46bjLvb5B5HVU2vwyNPtH1xxcx7QpJ+c0z2733Ap0S+BIrkPfy5DwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiyE71+e; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2162b5d2e1fso11066395ad.3;
        Mon, 17 Feb 2025 09:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811847; x=1740416647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bMglenQoBAxuUrNFMrnRamqieLlLc1NCnUhO3lY+L8=;
        b=SiyE71+eIu9fohJWYh7wiFcBytK+xNQYx00u2bzGWQMMvBDIIwIRI8XsRScOmLx/kr
         h2josEdBxsVNYm99a6Ssz6n56tvUp06vc/V5KG8PwaTGbKNSYyLE99S1iyfgLRqXOlR8
         xoKX5Mq/WGmAASMdZMbcBBJHBh9YCJ2Ig1wuKO5u0xXnyQKfMsJkqafLsRUeQ2ENE07T
         N/rUcSWOzibtwjmfLgbf3Sm8L0Iya3BYJOuZILfzSqIIRxf/2KfYI79hoGEb/aofwSMh
         1xywbVh6GL94kBO5WFSA9xQHJe3ygZRD/+PnkisuVkWJduCVEMK4/iYW7vEy9PWvLVFF
         s1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811847; x=1740416647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bMglenQoBAxuUrNFMrnRamqieLlLc1NCnUhO3lY+L8=;
        b=MwuBaZTxkzgxi6byuCk8TR65x2FHxFyaVC1JlcpCfi/xEOfHNJSuErhhxI7RdKWYNi
         NFp5hWWm8CgyCH+uEWGVXyTEJrvPJI4cDKmOyqExiuPrBAHLT8mIJHqkeUN9tcNyucK4
         CQs1GjjnlErkjx6XpMky8ObYCkEhPVb347wlePcRyqARQ4CDbNenBTVuBQfGhXTrx5JK
         qcZZI7ym/Ief10FsZwG0xl6MbeNEF1KQLgrd1Asv2jOlxP9OFbYFabmbRmVQ0Jlh2YbD
         0R7NKbsPZWw7hV9xWOOPtvORD/pQBYTGVOgmb+Ozr/NLK9umGOpUAM0cAoUdz1xIiKdK
         2raA==
X-Forwarded-Encrypted: i=1; AJvYcCUis8I81JGRc4uRpIBbSplPQoPnlYgEayXl1wIfZvKKq6Or33zU6ZjywJkOEOCEiOOCRvQiDiKVUS2r@vger.kernel.org, AJvYcCUmId0sR1t/mMtPnrRXtQhFBkIqWvVEnfypZOfMKxoTaWzj+79mrBb+CdW0S+mkSxDUvrYyi4FJXBlctsNskMI=@vger.kernel.org, AJvYcCWrN09bSgGTdayIbBIxTezhKAPBCWbA3QxUiI0n0v/9Vcd4Xiu7agZOMY98c69hdFR+c3/VK/Fse1h19ktS@vger.kernel.org, AJvYcCXPXxF3YjZNuS56PHgDPHZT46Wo1T7QxM/p5raAAiTSh6Ce4hKnMZ+fuxigUhB1Sn3ChDaSLCxdzdiChmNE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ag3gjHGsvBHbw512aX3j01gFWuVt9xB3CX9uacVn0xvCqA+V
	HiGRxSw6Vma6IxsttW8jqN0lq8HCYUiIUBUFABfq++CbDhXAcQ0rdbnOMQD7+IZWXX+55suq55M
	HzA1/6EMhw6mirPFFj6FOHpRfejI=
X-Gm-Gg: ASbGncu4C31vPxF70aZf81BemOcSvinTdb0e4ma5qN37OEEOPyBMkdwz26FAfnP4QCI
	1t1lZu1Xldx1i6LCiaJXTK++rdIpX8xxdBkO8vP++J9ysNTP+RxSLgfeNleqMVhR4cxnPaA5J
X-Google-Smtp-Source: AGHT+IE6fXFJD/TAHAmq4FllPdL+PqA6R+1cPSqSk8NAYGVi+EZlSnYgQaG1/T+qfhxobNH7+/FWKcsi7SwGvQAiBkk=
X-Received: by 2002:a17:902:d507:b0:21f:795:8fc0 with SMTP id
 d9443c01a7336-22103ef20c8mr57871445ad.2.1739811847302; Mon, 17 Feb 2025
 09:04:07 -0800 (PST)
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
 <Z7NJugCD3FThZpbI@cassiopeiae> <CAJ-ks9mcRffgyMWxYf=anoP7XWCA1yzc74-NazLZCXdjNqZSfg@mail.gmail.com>
 <Z7NNDucW1-kEdFem@cassiopeiae> <CAJ-ks9kZJt=eB0NU-PcXiygjORhhbEhGYEr9g3Mgjcf2-os06w@mail.gmail.com>
 <Z7NlUN7pSrDnSaMD@cassiopeiae>
In-Reply-To: <Z7NlUN7pSrDnSaMD@cassiopeiae>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Feb 2025 18:03:54 +0100
X-Gm-Features: AWEUYZmEkhwbjl3aNEThRUHQfnDsNNyRjc3eqFwDDWcwCyoHQJ0RVoQQuhWdm8E
Message-ID: <CANiq72miVrnnies3V5-T+BT=J3wnWgtnu1j+0OUT8_gRbEWyqA@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
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

On Mon, Feb 17, 2025 at 5:35=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> I know some lints are not stable and hence need to be treated with care, =
though
> this doesn't seem to be one of them.

Yeah, the "nursery" ones may be not ready for prime time.

> Additionally, I think the lint would need to be supported by all compiler
> versions the kernel supports currently, which also seems to be the case (=
added
> in: 1.51.0).

Yeah, though we could ignore unknown ones.

Cheers,
Miguel

