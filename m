Return-Path: <linux-fsdevel+bounces-64606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECABEDA5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 21:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D4342741B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93E2882B2;
	Sat, 18 Oct 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWwYi6s3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DE28640C
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815508; cv=none; b=UXCo/TA/AgAlEUoyyeOiLPaaokYQDuqq8ao1zU7ebNcVVJh2fSW2Jcb0Ctl3t/7y7ERAau6xg/gfDbPiZ6t6a9+BEFBBurNUew+uflQVmCO4E/bqhu1IAcDNwDPW4LG90FxVqA8x3FviDVKiCstJyn3Cc78CpLRvkI67RG1w5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815508; c=relaxed/simple;
	bh=rnUc1sSIJcJcXtlU0rQc91rWE99Qu6t+C8m+svSvM9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4wkCxFU7BJ7kOWlgTy4DqVMEQTZ8/Wui28RgfwIUSVV0SgKz5Npqn6puDQJ4p05Ii3i7FTcBiXpwDRf1hlyX3x40MECT5L+rHSLIkC5WdKK61wQtQxDfCvI5jHkL5h6CgP0Vp6W5M1BahZgi/vunCp23+3AQV66KnaiU0A2qzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWwYi6s3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29245cb814cso2284525ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760815505; x=1761420305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXwxLtFHklVqMldstrW5nXmaQWoQkEu+q+HBHCmmMZA=;
        b=IWwYi6s3kuZG/HtWI4MzpdPGLv4d8Bfcn+qXg3YsCAJEr1QKzKvTGjiRQOdS/DQ6DP
         Y8fr4SVEQM6tnr35g77FE8TRgg5K2PYEEdg9HIONLygZlMDawxU3NigbPW3k+OP+wdAX
         p+RL+AdNcPN++TuGYbszNv8guqVo3p+IJHzSFOheikGp+wvxHC9YGodWGWMCuNiFQyF0
         lrFKjCEXeBB56WnBrAiqRo+TEE4IlNb0HSwwcDRdBld7LAccjJwp6Gt9TETzQOBw8cBJ
         mXKIEF0M0odkj1R/YCfAK98yUptWeiaPIRZWw7LLzFnaqdaEvwU0L50N+CZJqNyHJ4EX
         3h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760815505; x=1761420305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXwxLtFHklVqMldstrW5nXmaQWoQkEu+q+HBHCmmMZA=;
        b=JQPpVv3cdfIu38uO9+jy+/8hlqlGCzAxSpu0q9y1UupkdwU5Yn+lH+corlbroyJmK4
         1wlERYw9XKu1OySVLVdb64S4OhbDfdC/XhdoO/udP17VO7nfdZSw8fud5h/JhZzOFpS0
         s50jB+v3hT6ixQUscPUr2tK1ARbb237aVBe1NbvfGcSrM/dfLyNkJ9E8hL+ScYs05QQH
         7dieA5VIgkiQn+IHR0naXSuV8ZJ1uIIOLRMpm94EEoxiICdkidDQHhwZvn8BIjv3JwLA
         WFqv6YuhbeiSfJKqhP7QeWEy1Lvd2T2v+nhPJycp6FmZxMuLJ4By4+m+fAYu+ZksEj7V
         Hfew==
X-Forwarded-Encrypted: i=1; AJvYcCXjZPp7P0n6RA57SayTo9ev7xHgRGCCWklxvNYDcO//SNKhvOG59hKC9Uavd0kNdmxhM7zSI1RRo6xQRvDj@vger.kernel.org
X-Gm-Message-State: AOJu0YyiranLpTecTicvQgB21wQavrx1RXMf01n8npJ80+dz/GAX1U1W
	tml6pLXbWMPshoVL1sRZw6zHlTjIJ7ti8C67egkzGMJpaLpO/T9Cjav7dWLOcPbcM6u7o88Vbxq
	Fcgr0MhOnrrLZUoYtoSPCSMm4oCAU4Ws=
X-Gm-Gg: ASbGncuCstvSf35F+ZxcP3npYzgy93IU9Aj2LFC/cwujDXOhr8Jd/SO5cH2x5MjxOtA
	c7o7v+PqnPQN7eVFFzvlv+GAEOR6GxKhm04q12pxVQrJetG32CtH/AhTLcJ0uD+4hMfEf5Pi4Z5
	StlBMis8lwNAWsxzVGSLU2MC+5UiTg7JyORulp9ck/JcQoKluXN6e5Vipv0VcggAT3mZ9pZTT5K
	JF4bXsw7VXhGXEHcdOeI4P75XoprAn4sLT0EB1XN+L267PVpWofQ7rzS0eF0JzP0i2AfBUHE5uM
	N+z5RmXOBBNcLuHbZ7QDie3z1G6X5RIkbiOhB93bkBNgo/6c8asMhLDATgTJTi8TEqagqgIaCQc
	um/I=
X-Google-Smtp-Source: AGHT+IFynbxdq4PbDoeu2y7E7pruyAv8MSoOFKgcS5qR5uKUe2l/9/1aikoejnUdjk1VE9ieyNLSjxDynifGmomPS5w=
X-Received: by 2002:a17:902:f550:b0:274:506d:7fe5 with SMTP id
 d9443c01a7336-290c9cfec04mr58829965ad.4.1760815505098; Sat, 18 Oct 2025
 12:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 18 Oct 2025 21:24:52 +0200
X-Gm-Features: AS18NWDWZ6CTzqAcsRkSpKjdzes4UGFhB9PPk5gEXsERGZ6zM8JBbanNnhdHiYY
Message-ID: <CANiq72n8m0JKjJMZ8Nk8B=GG5kcsSuc2YKp4=r2XJJgREoZZkw@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 00/16] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Tamir Duberstein <tamird@kernel.org>
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
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev, 
	Tamir Duberstein <tamird@gmail.com>, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 9:16=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> have omitted Co-authored tags, as the end result is quite different.
>
> This series is intended to be taken through rust-next. The final patch
> in the series requires some other subsystems' `Acked-by`s:
> - drivers/android/binder/stats.rs: rust_binder. Alice, could you take a
>   look?
> - rust/kernel/device.rs: driver-core. Already acked by gregkh.
> - rust/kernel/firmware.rs: driver-core. Danilo, could you take a look?
> - rust/kernel/seq_file.rs: vfs. Christian, could you take a look?
> - rust/kernel/sync/*: locking-core. Boqun, could you take a look?
>
> Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vador=
ovsky@protonmail.com/t/#u [0]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Thanks for trying the kernel.org account -- it seems it worked!

No more throttling to deal with anymore :)

Cheers,
Miguel

