Return-Path: <linux-fsdevel+bounces-64628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168F6BEED5A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 23:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12A23E59D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 21:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD11923CEF9;
	Sun, 19 Oct 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFVKCsLj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46987222565
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909146; cv=none; b=lYdXcekIORNj/MgM9JG605A2XpSr9nLy0aRqiMjCPnxfVq18zInpeSdeRcmWvtGeMhh2j+zSXjsD0/Tn2xEiXG9Wa04b7oV4CJThqqZba0ditSP9IyM9AOVYH32GARhiGwIBz0/RzvK2TS00zgdQKB/QZxXPZU8JZdUfFH5jVtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909146; c=relaxed/simple;
	bh=uA5vTOIALbcdwmrJpSZvDL4908AXryA4bzuPW04xPwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+alj/gypfH46D4JaQ5JSHcZ0BYWFFo6H/zuN5XkExLR8GopJyAK1ab49XziZYpJs3Gis26fQ4e2ihT6KaL8bj412xSkShAOHwFzLZ2OH0x2HpcduNL1wbXwoyFW+oY8X/WpwvKMmC6SYQm/dKvSWk++l1lw4rS4tkqmNhdTicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFVKCsLj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-280fc0e9f50so7005405ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909143; x=1761513943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA5vTOIALbcdwmrJpSZvDL4908AXryA4bzuPW04xPwI=;
        b=iFVKCsLjZ9ItLLugnc3NOyWgR6LdhMQj/lhUoAGx54ScPjkNeKQ2UAHsHjOHAamQ2/
         xDrS4i3MmZ7dAf4jogvQ02XjPPAkf7FBRZUEFrnlDrNc1OceGpdauhfN3WWMOffyFOsn
         cW1K4sWbbT3wXOvP2fMOi73RSK4EW28qGP3jA4JYKg2Iaa3pJSk4L/CktLp3YJW7Gf5G
         fiorgLY3lsDB+31e2mVDFbj582klczwsIdfO0ZH7AD/vCsTqeOB2KpwBHq+RgR1GDo6z
         ya5WTV98cFuVNieBV2HztSxbHvIKViXB7T0g3CN1L9Hn9vf3NGmZUNBGqagWjha9IEZc
         UrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909143; x=1761513943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA5vTOIALbcdwmrJpSZvDL4908AXryA4bzuPW04xPwI=;
        b=bLLd4OS+wr/YqJGV7LG2eQ6tIQt0inUl8NUytKeqE+c0IX3aG6ojsQNMHmUD7sdum0
         LyABkm8nE9HrGD3memQWO3BjqlfzBo13B8egrUw46kPiXuPP/saGzBcnZTwBgkXYpjyS
         /rFYsnK+1rbv7ib8EOrtsnsqamab260Pv0jP/3+KKdWZQZmveuSgYxrBbK/FDxpVE21C
         OPDOdOR4WlVHgtBmN7VLi2RP6ETwe2zh+P8lWtZ3VWlhUISXsloYFWeMc9YpOV3iW5YC
         zDeZl8qNMQxb0L1m7pljXYYKhRT84xcWO/byF9QrwqIaEMg7BbMxaQAP9Kd8QPbyNWHJ
         KiVA==
X-Forwarded-Encrypted: i=1; AJvYcCWRiDZlRZ66t9dbw3x2zflCxe1cxxp+zRxhieII+1eTvgLMOLiuTuC/gum2kqz+gBVDf+9Xe9l/uaGAKR8Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxwiUy23S43iI8UD6paxC8o0qtsX9yvu6WSgw6Lft0fp1rvsfgR
	WpeU7VXv52IybycxAxWCCgdFFB9xk72EzykSMmKWGeg3H4/Ovz62oFplctJGEB/gjLtYEU3jCWe
	mn2l8VRQnXjJMy7B7c9BJlx1AaXn2Ffs=
X-Gm-Gg: ASbGncsG0Kz9PbeeKnOLlGG6FQPXnThCXzi1yj29WWebiJlevx/Tm+HhE82k3Qk4ACt
	eIMG/yo1hlgvyLeCVEhHcEn0mGsBzVAmT7e1z8w/Qmm0v5IDgXeuX6IMSgo1vYoAnmhIeZJkUy4
	E4RpZGLAQ3C+1M9AnQ6GaFkVG57HVrTOFE8vjnqMDJGeHp70kcxSxoqHSa357ARqQnyz+n9as4O
	wVK4sBFYsKxraPWQOnlHcjrX0pJGFquxrAziU6r7hypTHsiPaTGeuvR5p5pBZS7hW75bClvX0LO
	Fajr6B6PwpERLtX3rOCR4euZT6klAUxPLu0jlE/sYZ5fZu5DVXquGzgdcbOeCJWG/yeOkSTCSMG
	ODigq0sRzSkC5LQ==
X-Google-Smtp-Source: AGHT+IG+Xq8GXKfGoMwbFFQSVjc1IKmL7pMM4P5v7DRrKR2eAYMxLjwbrDpo8D26g74EqZuNpH1jVIwhs5ozgrDthtg=
X-Received: by 2002:a17:903:3d0f:b0:274:944f:9d84 with SMTP id
 d9443c01a7336-290ccaccc47mr70983905ad.11.1760909143546; Sun, 19 Oct 2025
 14:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-12-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-12-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:28 +0200
X-Gm-Features: AS18NWD0bEVrj3eqcMBbtrKdDrdonGG9WGD9YJjG46fNVzfrXtIBr4GqiIVIqEs
Message-ID: <CANiq72=c3Zs+mecvDVJ=cyeinzezhGz7yqC9r6FG=Q4HAdb98Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 12/16] rust: configfs: use `CStr::as_char_ptr`
To: Tamir Duberstein <tamird@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
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

Andreas et al.: I will apply this since it would be nice to try to get
the flag day patch in this series finally done -- please shout if you
have a problem with this.

An Acked-by would be very appreciated, thanks!

Cheers,
Miguel

