Return-Path: <linux-fsdevel+bounces-41873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7867A38AA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95ABF16D1A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5489E229B30;
	Mon, 17 Feb 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGRWO/0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8CB155C83;
	Mon, 17 Feb 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813798; cv=none; b=nRxh7SEKaSUIxn/IbJO3BOgr6y564DK2Jb9RB1jO9Ux6u8kCHKH+cAM8caKVSioUowv/Br3Tae0PeQfA4bYCYAHQtweniwHhJkv6SSYb+CSU2uqSGPWyQweORwDDLDSt+CfEwa8cFGA1jBFqsm3WTyddSijFEaPhOBAyPYWBh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813798; c=relaxed/simple;
	bh=SwO7vDsfD9Xzz/NGxBz8ksCtoWFceyTR4jwgR61JskQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naiLadESxdkrC+90+sKOa5DduPlSMPQ6msCpK3ZtbQ0OUJlS72zZ4/5ajbBQAJn24nOEsHRd8sND7jIZDcZ72rr/7IUUgsXRdUgaELqJALfzpi95luHW2UA184qfMVotmoOwodI5HRwzJkZhj6CDwCNlzPM1+4Qkve/toQc3YII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGRWO/0E; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166db59927so9957725ad.0;
        Mon, 17 Feb 2025 09:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739813797; x=1740418597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwO7vDsfD9Xzz/NGxBz8ksCtoWFceyTR4jwgR61JskQ=;
        b=gGRWO/0E7YpMAthvkN5RjZkzmA6OCmCs4e0zpWd42CdCPT4T1ljwsIjkwf7kDdXobK
         5DquvPuLO7EEcQVaiKh1yywltIitli5bGUwas1+cThYYMLwIuMtRzyToF5uKR6MCcoUO
         CJ0MkXSBHZWihzVyVKt79UUuS4gbNs3RZtvyoXx3chKSe5vP9yJOVeHxT+OaclXJmr0B
         LE68zzCim7xlwj0NEwy1E+aCafm6rQMtSKAxamiRK4KH3yv7y0LSrbfSedFWRIuq2PDZ
         PPApD11j+sP8tZ4BR0aBOWncwLI4r8KU4KEfSGW175eKALKYTGneE/wfc2ygRTT+0UH7
         PEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813797; x=1740418597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwO7vDsfD9Xzz/NGxBz8ksCtoWFceyTR4jwgR61JskQ=;
        b=hjCv2ntj33lO923Y1RKe7dlKw8XnYNr5eZm6SolHhsEWlw7OSXn37ulfNhlZZOWrVs
         RPNmB1lV74C/WosQESccVsaKi7aUrP+E23DK6vbOZjgQ5kaDORr6IQjtDn/0Q9ra49t0
         d3Szk8oxVfU3tr4Q8K+RUGprtXc+NcaTaZxOJn5DSWhKNB9mrAhBkZUl1ldnz17+zu9O
         iFRvdtYUc/XFlMavVKougD1Sx4OKoQD6svxfAkqow5eASZVOLnFlHdii00gWJTR4VXBv
         6gRzMveOBwlq/Q1QJu989UJ5Y93BooYcFRgWh4QCRo/2OlTay7cCwkaVhZrGUc0GBdrz
         zoug==
X-Forwarded-Encrypted: i=1; AJvYcCWZTfggrVYKGA11fgEone7VyJ6xBzJOWt72/7EsVYFpCWj8xDIsABmsnSYiDuZ7hU9PqMT+pSPXbQt/9U4y@vger.kernel.org, AJvYcCWbUA6UUDVcAfeTXMABwSx6z5dQwr9HxrXGQrcBfrbOTHbYibkUfaJTNAgBtWGOxA5xLk66CB+Stjrpxv8e@vger.kernel.org, AJvYcCX57Lb1jt59VRqZD0bY9zQdQ+2a7cKYxi4b9MHoKzS/SLnw3NnHqZ4BeadsFmq4qTYn0xA05/3/7fwi@vger.kernel.org, AJvYcCXbikPIGdaTLshzK33v/x2+52yxfULne5Abwti0OqIWxmLZ5DokDetSczDf+7yeg2pJI0lA/rPyHnh8TwjXDD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9M3iN74xZUUW2LJiyYXPsR64mUvywGJPrdS1qWD8UrNncMj2h
	trbmlXF3H0i2doSKzGRmdrkUrI0Cmzri5yZn+zAa53GFtEFl2AVtWL1eEgZi6hAwOIJmg1QNkw1
	GmVU88mIsk2+ZJkw1J05Ch0XOccg=
X-Gm-Gg: ASbGncvl64YG5kq0AlP9RYErZGTNbsq5Jhv/RsVdbBVKkrLa5cYyb6Yv9EbqN6MKfRi
	Xojxa97r9rSO+GwJKuStq4pR5uxN85BNQ61vks7ENv0Io9yqDmA3EepIbgYxvhOVk+JTvwnZX
X-Google-Smtp-Source: AGHT+IHoUzKFz6KdsRlLbiPBD4oc1ayhlO4iOKanwFszVBIiP5IHTNgEjME2IqdlTDlUFzJMK4fxDeg1fRPOi9UfJDY=
X-Received: by 2002:a17:902:fc8d:b0:215:8721:30b7 with SMTP id
 d9443c01a7336-221040a7a59mr62404795ad.11.1739813796701; Mon, 17 Feb 2025
 09:36:36 -0800 (PST)
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
 <CANiq72kAhw6XwPzGu+FrF64PZ9P_eSzX3gqG9CLvy7YJnbXgoQ@mail.gmail.com>
 <CAJ-ks9mFT1Gaao+OrdYF+hg6Sp=XghyHWu1VTALdeMJPwkX=Uw@mail.gmail.com> <CANiq72kFpDt230zBugN12q978LRSJiZB5dJZszWkL2p7XqQ52w@mail.gmail.com>
In-Reply-To: <CANiq72kFpDt230zBugN12q978LRSJiZB5dJZszWkL2p7XqQ52w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Feb 2025 18:36:24 +0100
X-Gm-Features: AWEUYZkXXe9ucp731IUnfF8Mkzrw90VtoilSTq_--wgHn6jSTiKyQT8lGbY5FVI
Message-ID: <CANiq72kjAx4a20cnE3XrJ-z4K=8pCRuc+TOa+WtcuUsdZ22tSA@mail.gmail.com>
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

On Mon, Feb 17, 2025 at 6:24=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I understand the rationale -- what I meant to ask is if you saw that

By the way, I don't agree with the rationale, because it sounds to me
like optimizing for `git blame` readers, while pessimizing for normal
readers.

We do a lot of `git blame` in the kernel, especially since our Git log
is quite good, but we still read the files themselves more... I can
imagine ending up with a lot of extra lines over time everywhere, it
could dissuade small fixes and so on.

Cheers,
Miguel

