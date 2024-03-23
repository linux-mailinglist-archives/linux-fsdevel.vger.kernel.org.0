Return-Path: <linux-fsdevel+bounces-15166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E659887A83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 22:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824031C2126E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D25A7AE;
	Sat, 23 Mar 2024 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXMb9yxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1758104;
	Sat, 23 Mar 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711230038; cv=none; b=I6w12BvQ9ThWqE7Gzd2CMwUiPrzVS6e5OWAf+OLf20tlylLXssSOS25yhf/E/ay3jwg6UsfzsHIpCeuCry4SBeuTsV3ZXP0B8wy6RTjeDpjG9AdeFHcZc8Gwox53aVmMH627SZO5FTiWtyzUazVbrJD3PjHiypiKIquXRuEPbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711230038; c=relaxed/simple;
	bh=cxJyvYom9rYpI3v6jLA3KnXUFhHsx7mMzeaboHDdGAw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gl4MeZISYW3rpyluuP5pfbpIIYVTvopi+pQdiIHhZW7Dw5RUX19BC/VNhdLMnE9FVUKmy3cioEix+OXanPeWyZPFGebew9ZEQSzag5C+H7C79hA8Y0jFLH+djz0IsXIHXBi3othZ+np2p1yHczEmYrjjMeDl1W44o9XScZEOXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXMb9yxg; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78822e21a9dso157923385a.2;
        Sat, 23 Mar 2024 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711230036; x=1711834836; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOFRvpRAI+VWx5nUCuNi2VPShTLUPuTZZjdFa31yQSs=;
        b=NXMb9yxg9f1ThZQCvxH0Yz456i6L8sYWPjs6mdkgZ/4JogDXuGHkfmzFW7yIvRyv2r
         QiiNLan+NOuazcUOz1FNm74EWGC1tE5Yci7lYNx/qhkv4X05bc4UhSmml7IBRJWjN4W9
         GufUzB2bJYguFdZvDdk94K2etjwTFkAZThzUQBnaMRjSTx4LW9JkDrxxRGbRIq1wnZ4h
         JqZvjcldI9XTxAIH7W7UZ+L8Ci6uOlURgLiRzLSyMR5Mvb2qZzseAZJq+m2qwMTr0yz6
         afY2+fxqKhg7lVBc2rnNp2xpe2dzjP2tYq90NFFc627W8BTTCgyjXvxeUOSwkZSkAPKI
         8QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711230036; x=1711834836;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOFRvpRAI+VWx5nUCuNi2VPShTLUPuTZZjdFa31yQSs=;
        b=OgRRjadT4aqEJl2Zs3ZuHo+lN3/G6Cyfx/JEefG7zaDt6NUAJrzHNkbJXmbijz/PV0
         mKLwubGRQ5oupv2LDjSgz/oQhXjQJEjsuCa6wP2uWT3HkeJx4OsMwgTvBOKEeXE6W6Dz
         Vd8x9K+1SHDU85w6L+52ScixRrl1yOiZTGDqyRxYf47r/rDFKnLOwJUcKMAN/2qjHdzX
         EFf/dHz6rCxtnXGTZ+X6rgNpam182YNzxftDpviGoo2G1L5hF7Gm9ZEnk9gZVgfP1cEX
         lh3OYdU8nxg6fcsZqbpd01uYBK+N6PvKx2qG1eCER5Sr5k7KWUt0nIAauPP/V5ED1o6s
         /y7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5MTVgpLXUzR6nsuY+TfS2xXCIiyCr2fCWe7HwVz8crFY4rRC3cOu7xyZKEobHxFJdO0IjSoQpeIIHeQkR3eFDTQ6FvSRLRNZ4+z9k5ZqzFKfe2np+HwESjnVU64NW+A28PEkzF2TURnOQzHBXRD1AP1gE6VZJskqPQJndvmFcYvxQhT6rOnU3YbDcB0bYUpPzEKr+3ClOwe6AhUuNyNin0zy35kyBuw==
X-Gm-Message-State: AOJu0YwPR8ed/kpvqOY8Zl4Qj/J6Tr35t5BjvYHzQo5v3ozxz5FqQQk8
	ohyNLDcXvbjwvRCinPvVw7bk6HJRBTsWUu/7+cIJGMuAQhXOp8le
X-Google-Smtp-Source: AGHT+IGOLTqbKp1+ap2QBx/UabVyQfa+NSRyVtYLu6fT31jIeVrXitOYJm1ymdmJk8ukaXuOsxroBg==
X-Received: by 2002:a05:6214:1308:b0:691:e21:736c with SMTP id pn8-20020a056214130800b006910e21736cmr3799275qvb.30.1711230035924;
        Sat, 23 Mar 2024 14:40:35 -0700 (PDT)
Received: from smtpclient.apple (pool-162-84-172-44.nycmny.fios.verizon.net. [162.84.172.44])
        by smtp.gmail.com with ESMTPSA id kc1-20020a056214410100b00695e602d356sm2450268qvb.46.2024.03.23.14.40.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2024 14:40:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
From: comex <comexk@gmail.com>
In-Reply-To: <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
Date: Sat, 23 Mar 2024 17:40:23 -0400
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Boqun Feng <boqun.feng@gmail.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>,
 Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>,
 Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 kent.overstreet@gmail.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 elver@google.com,
 Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C85BE4F4-5847-45B4-A973-76B184B35EDE@gmail.com>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)


> On Mar 22, 2024, at 8:12=E2=80=AFPM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> And when the compiler itself is fundamentally buggy, you're kind of
> screwed. When you roll your own, you can work around the bugs in
> compilers.

That may be true, but the LLVM issue you cited isn=E2=80=99t a good =
example.  In that issue, the function being miscompiled doesn=E2=80=99t =
actually use any barriers or atomics itself; only the scaffolding around =
it does.  The same issue would happen even if the scaffolding used LKMM =
atomics.

For anyone curious: The problematic optimization involves an allocation =
(=E2=80=98p=E2=80=99) that is initially private to the function, but is =
returned at the end of the function.   LLVM moves a non-atomic store to =
that allocation across an external function call (to =E2=80=98foo=E2=80=99=
).  This reordering would be blatantly invalid if any other code could =
observe the contents of the allocation, but is valid if the allocation =
is private to the function.  LLVM assumes the latter: after all, the =
pointer to it hasn=E2=80=99t escaped.  Yet.  Except that in a weak =
memory model, the escape can =E2=80=98time travel=E2=80=99...=

