Return-Path: <linux-fsdevel+bounces-15361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C7788CA36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF19B241BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B16A13D531;
	Tue, 26 Mar 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLyu0CxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445E8627B;
	Tue, 26 Mar 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472669; cv=none; b=SYmFfHG6KCnGFiN8PnGg9ovxsGybcsPCYSA+Bkb0wN9KRXLp51juY4xZo/5HGQ925/CZb23egpO3eSpr5FKVx9N7Pu/vRT6iQnktowqqsDvFEAH9dMJ2F9uh0cEIl9giXy8BYejWFjGpJcC5C4oErkv7Xgng89z26k9OXD0O3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472669; c=relaxed/simple;
	bh=yXY2WhzisLx9owVvt4Jz3mM6SUUgl3eE1txAJxejugQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay6Muwb2QVcr9MtkPmQ2rIL6zIYVqo6tVDfiNoPtjezIQ7j/y3+V9jZH71riFtg7cv11Xso/O6iQWgajYWSEFPRTWHDDeD8PpNmdfrj/mOkkQ/46uPHax/z1W/ot4OP2hZ/oxMqbXT8E2iH93X6UtH8+eu75MLuBOF3ofac467M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLyu0CxP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dc949f998fso3412640a12.3;
        Tue, 26 Mar 2024 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711472668; x=1712077468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXY2WhzisLx9owVvt4Jz3mM6SUUgl3eE1txAJxejugQ=;
        b=BLyu0CxPhM4W4P/5tbx5yjVmTGY0dNr/Uk/1EsK/aEwe5fAk3k13byVfB4V9a1kJbN
         0j6EUAK/6hTOaXHuevknImEmzndHZXqYKBRZNzc/93AXpdXsQjrAUK879l12VzJtDuQ0
         wZa96usivOMXa1IPTiEIf9Vouug8Ms8fnAz6CAZ3QwAKvrC9V/kx1s5azDXOZDhvm2HZ
         OFWA0/OsYDyFysJalptXvIk4tWeencEtwRwbG/ixBIQyekYvdhOxkLZ+4763zK5cDdko
         c0bR2jKqfQ6+6XCluLone5DyPvn4EXQXixgFGNICSbz/BqRdND8ot7BG9642/AFabz7X
         RZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472668; x=1712077468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXY2WhzisLx9owVvt4Jz3mM6SUUgl3eE1txAJxejugQ=;
        b=lNDFIv8k/IuQ6lqBEPwKHmDNVPy5yuUG2AXhY1r3r4geSgmOwEPd6w7pf9u4+sOlhv
         A3dUBRFjW0m1cTdRKedOEGaUzdrYzKG7ArNdZqIQmOQtkeHvFVASQhKmp+4BVn0faovA
         lV6ix786lqAZNAQVlypP7rgrCIKsNFI9fvHlyK2quitDzc8B+2kQcjRhW5X152i+ApcH
         hu2qBhhfhzfh7QM5tIjn3zjkZ7oxA3Y5I272NJ05YIHtc+P8BQ8U/uzitpJrR4BukPa1
         TpGgoMPIB1OkOfYKqB5jKkUUAQZbghvbumH4uY4PUMU8TGMdv6iJszvEampQMu0AmnKL
         sw6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmipMz9Ua9LjAoT03ReOiUfbKTpdyQBDqgCOViWO4Gq3xCZLp+LepC5ZsZtlQzIie1gXGydJnB3VlszVPFOzhJeMyJiq8LmdYSfAvIBj1G+Std+8flDg2FMs8eOUvTc2z+xnkax84gM1f8N1zP
X-Gm-Message-State: AOJu0Yyn41E6HWDX1eXFf1kK3uD3/9cBSCFz4ydAiGZPFXH5/NMVw656
	LTSqQgPRe26GyPxeERN23+NuNPYDSgsQtN+XjcNc7q6wAqCgaFqizAkPFld2g0FoLomV0NmOjtm
	vQnvzeWhJ88sqXZ0JlNJhndGRXGE=
X-Google-Smtp-Source: AGHT+IHX1wlYMCI+6kMyUtB5VsDPIH1w+HKZqoE0aRWzlpD59eh3+QAnEjUmz9+Nmjmh6RurJCmPm43yEI1ldIzJM7w=
X-Received: by 2002:a17:90b:f08:b0:29c:6c79:7e92 with SMTP id
 br8-20020a17090b0f0800b0029c6c797e92mr7698538pjb.19.1711472667548; Tue, 26
 Mar 2024 10:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309235927.168915-2-mcanal@igalia.com> <20240309235927.168915-4-mcanal@igalia.com>
 <CAH5fLgi9uaOOT=fHKWmXT7ETv+Nf6_TVttuWoyMtuYNguCGYtw@mail.gmail.com>
 <c8279ceb44cf430e039a66d67ac2aa1d75e7e285.camel@redhat.com>
 <f0b1ca50-dd0c-447e-bf21-6e6cac2d3afb@nvidia.com> <Zfzc09QY5IWKeeUB@Boquns-Mac-mini.home>
 <31263f2235b7f399b2cc350b7ccb283a84534a4b.camel@redhat.com>
 <CANiq72=1hY2NcyWmkR9Z4jop01kRqTMby6Kd6hW_AOzaMQRm-w@mail.gmail.com> <5e19d7959d43afe0d95d5b8e9a9b58472fe56656.camel@redhat.com>
In-Reply-To: <5e19d7959d43afe0d95d5b8e9a9b58472fe56656.camel@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Mar 2024 18:03:59 +0100
Message-ID: <CANiq72=5ajtjKK5+XihiCuK32TALDi4qaMSJ-0UHDXq5mxtdCw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rust: xarray: Add an abstraction for XArray
To: Philipp Stanner <pstanner@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, John Hubbard <jhubbard@nvidia.com>, 
	Alice Ryhl <aliceryhl@google.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Wilcox <willy@infradead.org>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 2:53=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> You mean if `ret` was a pointer that, consequently, would have to be
> checked for equality rather then for less-than 0?

No, I meant a C function that happens to return an `int` with
different semantics (e.g. encoding for the error) than the usual ones
(Rust does not allow to compare a raw pointer with an integer).

> The difference is that checkpatch is an additional tool that is not
> tied to the compiler or build chain.

Perhaps a better comparison would be Sparse or Coccinelle then? (i.e.
in that we ideally would test the source code, not the patches, all
the time).

In any case, if you mean to have kernel-only lints, Gary created klint
[1] for that and Julia and Tathagata announced Coccinelle for Rust [2]
some months ago.

We hope we can start putting these tools into good use soon (not to
say they are not useful already, e.g. klint already found actual
issues in the past), ideally running them all the time for all code.

Unless you mean replicating all the compiler diagnostics -- that is
not really feasible (bandwidth-wise) and I am not sure what we would
gain in practice. We don't do that either for kernel C.

[1] https://rust-for-linux.com/klint
[2] https://rust-for-linux.com/coccinelle-for-rust

> Yes, and I think that shouldn't be done. The C coding guideline is more
> of a recommendation.

Kernel C is quite consistent (relative to what you could randomly do
in C), even including the big differences from some subsystems. So, in
practice, some of the guidelines are rules.

For Rust, we had the chance to be even more consistent (thanks to
having the tooling available from the start), and we went for that,
because we see that as a good thing that will pay off long term.

Cheers,
Miguel

