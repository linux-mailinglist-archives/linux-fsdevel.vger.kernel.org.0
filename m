Return-Path: <linux-fsdevel+bounces-64627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2503FBEED4F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 23:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E063BCC8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 21:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860A023B605;
	Sun, 19 Oct 2025 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQpBR7TD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B34A22A1D4
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909134; cv=none; b=rhP6vnT2PY4o/ns5U+4oqrMCM7OwEVeHT+fJKQjGzCJShNeShx6kuFJZVOxY60XKv5A0JYG5kWOi9r9oUcwqmQZyRaOlyhGyB7OVzNPblzg+ZXFgmsqK585h88Cm4TsMXnTtTbcC2Vs1haodXI/c2hECKTUKOrq7wKHbGzk7Pt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909134; c=relaxed/simple;
	bh=ycAfcyNNCDvL8r+cj6EK2T80BYm3/AHXV1y+txWFqzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGT/ZW2klO1WyILao2TLFCyAKYN4+dKsfkRNwqPJ5HCqILdFIIKDxpadiz/5Q1uIoYTsy2cvyE8rTMvZFyTmBsr25ybF4PP/ehFujPosBPQxMR0RPvl2Tw1ZBExbUDRwvXn8qzlJgJo//D1auBAN+hi8mxJbQMaNwzNxs7bO6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQpBR7TD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29245cb814cso4430155ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909132; x=1761513932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycAfcyNNCDvL8r+cj6EK2T80BYm3/AHXV1y+txWFqzI=;
        b=DQpBR7TDwXQXpp+mLTN7vd+6pDnwCn94aRLrW2xwzkgw2/+WaWr58QDfXIvSUuAqDH
         QI5muLpHKfPn+kWy8wAqnTy2Hz31tHhGBgTx+c5edPcT4CdtCPp6IAaL9QhohOyWsJqV
         F0gc8tvOd5VhlugYbumG8RlBw6JFDuLefCoaGv4PkXl6L1O5K7kQC6tfeJqUTJwSBWKS
         TXT4b8Y6ZacsUC4ZRQ9TuhBoQZlu7GnpToYI9ONvaFVFevnO97oqkMcfK6zLeIOeSy9m
         dYb3QfBD3pHg4Ub8DkC9J9ULr4Dw8dOOSDOrVKhzGpL/7+sjm7ZWulyEvcPboG9mvKaz
         rMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909132; x=1761513932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycAfcyNNCDvL8r+cj6EK2T80BYm3/AHXV1y+txWFqzI=;
        b=oed2TO6JWqdFva0+cvwEx6B7VMXuo0iB/DFEmhbpk4REhT7BJwNGjI8HhkKqXeY5JA
         f3L+nZf3KpFRzoAYcG3Yq/dpEM/2KQTndUA/scQx2WKOiS1jIiCb1EKeLeUVwmqbUd4a
         Wqx7BdBglPqFcpQwEGinj1O+DuHxSM0pMkX/WE746WSjKXd3QjNRuYKgS/wSPvjnA45o
         nRp9FtLmG/ch0Y39DkL8zxL3JpxAaNcBg2jO0yidyHg+9KM/KuFQAsSK9Y6JgKrtz73C
         4Flo7OL/Uxwcq4JzU2i1rx8aX+1WQLvg1f0e3ghRjBo0fLvCFc7Ud74PeVRhrPp9/4Vf
         8k4A==
X-Forwarded-Encrypted: i=1; AJvYcCVYD03D2x+RhUFTIgjWAAz9+9rUe4sC6SUYEjVjm5VliH/DHuA4QLIn9ljgm0RGt7xzpW24+j/wgE/TiGWK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kziXVrz/dRdAtZNr5NuYQl2YbM2EtIOha7mNwSaXFL3j5GCb
	QoBCS4OUMfrhoRyMIH4hUZ+MDVeEuUJ0rNX3aRcZyIKzEr9hU7n6C6Hc2essHQQQvxgBz4Yic85
	qoH3QuFcxSly4I+INTFh1MU9spa48fFE=
X-Gm-Gg: ASbGncsq/JLUV8sFh3S+ubaUKLBv5Sx125EN64OPyVQU5wHrd31kj9e/OA29YDLg//I
	rKJ9YT7V43KjnKEcAtz8picBuSlw6CJgQIbPWtxkcLuxIPnpON/BmiPWH8E2YdRwTLUS+nog904
	j6ucb/6vuzW3hVaiEYtHum1FtmtnHOxriy5EnkjLBF1HbVCcpzvdmY0I2G39ldc7QcZaVD+E0hB
	1hpY1dnsqBYmF5yvIR9pr+CqTD2Cbcn19JHGWjHckXGfJoI+Bgw7eXNO5dXIHCIaBCxKUb0zZt0
	bTIuXNyXnUDufaN4JUjNqsKshIvyjT2nI3vJRmbYAIdUVFDfOhzNAP493IzaQP5Mq7A/MQOfnma
	OTh3r/awHBAaG9w==
X-Google-Smtp-Source: AGHT+IEqij5v9mJs5/CWA1m9c2NrE8PMDKfGOLkkgvIBrH2S+dVqx6DMlKfweKNo3iNjtFuT7Y5fW/l69CjJHY+CKa4=
X-Received: by 2002:a17:903:b8f:b0:290:c5c5:57e6 with SMTP id
 d9443c01a7336-290c9cff139mr74090165ad.3.1760909132458; Sun, 19 Oct 2025
 14:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-14-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-14-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:18 +0200
X-Gm-Features: AS18NWAMycluR5p3NBfaTwCbAsRiC2-Lwc15QqFISNzvPKOcYBFx7NoYnd__ov0
Message-ID: <CANiq72md2Gt-UUpPdnoOimUW8d+M8Wp=9jDTZ47NzvruhfP6+A@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 14/16] rust: clk: use `CStr::as_char_ptr`
To: Tamir Duberstein <tamird@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Breno Leitao <leitao@debian.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev, 
	Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 9:17=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=3D&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=3D&[u8]>`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Michael, Stephen: I will apply this since it would be nice to try to
get the flag day patch in this series finally done -- please shout if
you have a problem with this.

An Acked-by would be very appreciated, thanks!

Cheers,
Miguel

