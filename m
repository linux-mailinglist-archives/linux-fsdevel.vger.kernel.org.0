Return-Path: <linux-fsdevel+bounces-15157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9AA8877DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 10:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55519282784
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 09:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2CD10962;
	Sat, 23 Mar 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3z+EhBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF31DF59
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Mar 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711187910; cv=none; b=VCKUPzPBfSEXbeO1U3xuBOexywQrZa4AyVcA7k5z+XL0LuwEZR0PS+GdymI51Vzh39Ojoa44w9Ansq1y2eTogWs6ksK/gEY+NWswo4poN1Bz9cQlBMiV4uBxvnukcKlwjyk9eQPmTSQXeO9I5EpCL3C6GnlyD97QO8YR+/5bXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711187910; c=relaxed/simple;
	bh=88XYaAUkw5+FIlN0k+w5zlI1HA5aU9i8sSo1I2tq1TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuBkk9s0Sv8IrUYxDYe1oRneitvT26jIv35xjg4kSWiaq548uZS7Sht6/WKm90iKPCQ6meLl1fKkYfpLjpcgFbNpDkFjUaIvjpQuhfXue8In5FREEEIVnkJcakJp36vEnLfiaRARK/CgG5U6QBrq95YKH6gyBuGDzircKa+FGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3z+EhBi; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7e070b9736bso2183210241.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Mar 2024 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711187908; x=1711792708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByMFrWADWxfCqmgsuCZcbqeVUMaKvKom3ZFjR5jUOA4=;
        b=x3z+EhBiDuGM8qoo0YaBRIr2g2JtN6oF852DpOPxpgSDC3Io15Fx53EWLDscZ/hdy1
         1S+YtWY3X6wyTGDQOTSWmsPFCJ5qjCG9Wtbe9nhFbc644Fh/HFPBgzeqg1WPKMlbpV22
         kdTlJa+teMtVEwIj3Jk35NxgAE5fwkmaWL3LwnUlnTE80DF7sYXADPZup5w+1EnLpKR5
         jm2Lc/4FjArKCTkRjBlvzYoWFYrK14ZqE52qALjh0ByHu/20pnYW29krb3Liy31+Bu0R
         2yKSLnmQHrpT0xCixz6+59VXDGZK0L+uN8UpkWjLMmfCivsFDjCiHXdwLonYnDa1A6eC
         MkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711187908; x=1711792708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByMFrWADWxfCqmgsuCZcbqeVUMaKvKom3ZFjR5jUOA4=;
        b=RxDl/ysTfTaJ1r8P+NpsbjBYdHD+7wmBCBDcNaYyV4vDPyVzL8oVXOjPhjO8vr5VX1
         w11wIq3igV2ldYZeNZ2rN+lZMP2lwQkmRetTPnwnKiek0eUBhRWS4SVnXD8QNQwkPs8i
         pwZvjNQUzkcFLd1JLVNcWycuB9HTAdaKIYXyZtkje9mx53QaILE0W3M7Q4LVynjueMJj
         wO6yuFRSzFDZg4LSnON4Uwor6+2xpK4LXX+1Gpd3t/cN7E0TXVFsaalj7vj6hBfDAxC/
         Cbe8moF5VdQDOFC7AmJ09IpOzmqBuPDmBW9JzG3gRLxm8xwed4KuMUnjAqz/ijoK7cXp
         vvHg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZZwkXloXPKtUMz3/24kA7GS/K/kyW+wS6KuAoyMi9eGhCjlB0rjN7C5EP+MFF2kQ6hCnKhNYASYl2xqmbOJi9x0i4M6CjBXfUz6epw==
X-Gm-Message-State: AOJu0YxOVBdz+0/3zeOKJ8HaEnV+lirM5H83wd197x98OBNMi7oN2j7X
	KT9QEcQWBiLNqEl45XAyIl8QtWe8XBB1BCKGliqPaXyiBtr44yBXg+uZxP61L8hwSlB5rSXlAeY
	EavMDRUXuTlPGKbahE2VrujLSmqtKGhC7LxWd
X-Google-Smtp-Source: AGHT+IHAgBE9Mt9tCncQbdq3kL3/YyCXJsjych9A8TVxZPi3s8EhiSf04grenMGGPKfBQGLsBYx9mC23O4pppsMnfhE=
X-Received: by 2002:a05:6122:2524:b0:4d8:7296:f52b with SMTP id
 cl36-20020a056122252400b004d87296f52bmr612108vkb.5.1711187907683; Sat, 23 Mar
 2024 02:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <20240322233838.868874-2-boqun.feng@gmail.com>
 <068a5983-8216-48a5-9eb5-784a42026836@lunn.ch>
In-Reply-To: <068a5983-8216-48a5-9eb5-784a42026836@lunn.ch>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 23 Mar 2024 10:58:16 +0100
Message-ID: <CAH5fLggdVDccDwBa3z+3YfjKFLegh7ZvcSzfhnEbAGSk=THKrw@mail.gmail.com>
Subject: Re: [WIP 1/3] rust: Introduce atomic module
To: Andrew Lunn <andrew@lunn.ch>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 12:52=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > +//! These primitives should have the same semantics as their C counter=
parts, for precise definitions
> > +//! of the semantics, please refer to tools/memory-model. Note that Li=
nux Kernel Memory
> > +//! (Consistency) Model is the only model for Rust development in kern=
el right now, please avoid to
> > +//! use Rust's own atomics.
>
> Is it possible to somehow poison rusts own atomics?  I would not be
> too surprised if somebody with good Rust knowledge but new to the
> kernel tries using Rusts atomics. Either getting the compiler to fail
> the build, or it throws an Opps on first invocation would be good.

We could try to get a flag added to the Rust standard library that
removes the core::sync::atomic module entirely, then pass that flag.

Alice

