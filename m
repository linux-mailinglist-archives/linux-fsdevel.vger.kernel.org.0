Return-Path: <linux-fsdevel+bounces-41868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B2A38A50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021A318965CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1E1228387;
	Mon, 17 Feb 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kec8O81i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD96227B85;
	Mon, 17 Feb 2025 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811836; cv=none; b=EyjxRmkv1aJa2kXXvyf+nqvo/BUShZDytUBNuMDcd9ci3CtUiWu8jKf6BKyHljwlb61kuL41axi3IEqhK0ERGCNLDn17l98kSV9pjq4NP+pIt0EEGW0dmI/ErhPnfzXNWgZzHWg3svwCFLQFQjXcTtlaNKbkaK4NBQ2GEc8z4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811836; c=relaxed/simple;
	bh=JbkE9qk5cNwyVZ7sS8JmFfKC2WpNCNBXJZZ2vt5CR0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGBBpFyMBJH0lV1Q2m8bAGL2rUy+D3egLjU0bfpTGjR4uzcRNPXtK4uFs0E64LkZ70/CJBucMlQ7AmCfo2I9e8euV4toKfMDnXWxqWk07KVED/X5BFbVIJJCJUbgk31O6vnoWYGt5rL0IwCcBdCuqPjnWfMmQ9rcqxxNidOUWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kec8O81i; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbfa7100b0so1118018a91.0;
        Mon, 17 Feb 2025 09:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811834; x=1740416634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbkE9qk5cNwyVZ7sS8JmFfKC2WpNCNBXJZZ2vt5CR0o=;
        b=Kec8O81itGv68SCWAH3HtsqcbZmHsTNVynqN6isDnrU82yOtE59XHwYBl1MX6E+btR
         i2rvFMMJUVnHI8Rwi6MqxGDJnPsWppofcefE2wu1kVpvoZHs2wgotJ4OfOqI47CM0MfG
         blNL9j7A4eXSOo7duzom8RE3KAxQlB42PzkQ3mEnbMtMWxql/9dpHq9tSmP0bXX/z6sQ
         wOVxWuzTR6XMPogoq6jwEUfKdPD3hB7lpLm3AXK0YkCjL+ilG7Df6CspNYndgxQHiIlQ
         AsyT9fhdYgtJQorXlV8v1lqh+/j8nzOrkfQxE0D7uSvtJzaGPQvHi+mSlMSoyJJahp8o
         oOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811834; x=1740416634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbkE9qk5cNwyVZ7sS8JmFfKC2WpNCNBXJZZ2vt5CR0o=;
        b=p5UJ9uIffV6DbGZA4ejljH19pXK7vv6JzctgNruwDmSRok9C6S4dILZF7H2nvqcUXy
         6XN8OGZe7aNJZEZ0/h6plgpJbC5eox8MOVyzM9gqEBXtk/U1vgM8ozA1tOaEUSx3TMJH
         8Nq+yvcpOs5xi7xCPOqTYsOIuGczmOPUGyQ5K3YyVse6mR+clY/CroXG/6JKhhxdbtQU
         SGjn3mKGNo3OEHDS4iBlekrEgHAhSg+PKZHTaySNf6RgkZRm8hSJs1S8PDL2nbGhfKOS
         Nmg8ls9d6ODHEHX47kgocT0Z7Ss3BKO16LM/JIOptHtHulMsjUN7XRLso/m0VLX/NcrV
         c4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUMop21bALQm2513rDpg9deS4HnEh7+UA9x1aqsBIhu9oV2cwf2ijTjsjpVHJr9E6pxVtCIZNaboatURZob@vger.kernel.org, AJvYcCUTlydY4acA4cCEhh/svCVyb6oY0fK1FyGWkEHa3DXcjNRsR/wN3b5IIOgktI5V6MVzMhLyi0FJPLmQ@vger.kernel.org, AJvYcCUXit6e11dHe1y+CEIuDE7vJW+7+ronfi81ef8rgAeqoFS341VaR/PXfuxCNgovDtIpvtdoHQdqefpce3SE@vger.kernel.org, AJvYcCX2Y50kVe2OICQHp2xxo9RVRpNCeI1R/a7Y5ojt+njmLSkpgoODYEG0ms/fWT8zeta67TrV/KnsrPDd50rxJOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Aopu2bPg8lVABwf/WWNVTX3zufcOaFKi4/IFKD3Qw4eqWQJq
	whaSUqiTcvxfBGaFWhG2Zo+FUZ9De7knHUWDFkPEuvcDY11wP4sfyynQ+O9a4TLQvK2xypwRZVo
	pQvHSI+d6c6fvHgbaGV1aOvvfWwg=
X-Gm-Gg: ASbGncuhz/Jh034wygPq9Mvpnp7b1zs8m8wRxy/PZEXOuU2mOOeD3jUJy+VMik22Bxz
	1vb4sf0ba7TmT+/DUMeIHBCKjRGJqCV9gwYHLJKnFb3+1apA6nyYWBgfxfM+CTzafqRMFfTpU
X-Google-Smtp-Source: AGHT+IEvI6Y+m6DWwxDBMJcfNZpGjwtbzFH4n56TVTDPNg16gYcoAbgXr+BfTTZHczHMpO2s+H2pf3FfpF6gE8MSH8E=
X-Received: by 2002:a17:90b:4b4e:b0:2ea:c2d3:a079 with SMTP id
 98e67ed59e1d1-2fc41044975mr5979577a91.3.1739811834364; Mon, 17 Feb 2025
 09:03:54 -0800 (PST)
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
In-Reply-To: <CAJ-ks9kZJt=eB0NU-PcXiygjORhhbEhGYEr9g3Mgjcf2-os06w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Feb 2025 18:03:41 +0100
X-Gm-Features: AWEUYZnobJfHgbE509vfptLe8Eruomt2DY6nrkmSG3oFWLIkPP8rLARcvsNuIX8
Message-ID: <CANiq72m+jM78zgPETh8VD+3WUPU-CDN2ymJ+ns_oL0P=uJqQ6w@mail.gmail.com>
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

On Mon, Feb 17, 2025 at 4:50=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> What do you think about enabling clippy::ptr_as_ptr?
> https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_ptr

`ptr_as_ptr` is one of the ones Trevor suggested back then.

It seems good to me, but there are quite a lot of instances already
around, so some cleaning would be needed.

Cheers,
Miguel

