Return-Path: <linux-fsdevel+bounces-15454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C588EAE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 17:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DA41F2376A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD96130E35;
	Wed, 27 Mar 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO2SVDZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F030E42A91;
	Wed, 27 Mar 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556189; cv=none; b=Enf+hE9SyppGxdoU5Sn7sgcIPyDrBnDoiEE4dO4RUVrVw5ZTLybAtVQDmOhW3mVwBa1hj6rZfwzcw87RzoQgeklrmTurnStQSJ242PYPcxsahz21ma23vbtKWjC1VzdRbbXgQurbQGt1NuPN4S94K9n72oK0Eq2GCPjHFVKULCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556189; c=relaxed/simple;
	bh=kfVdwdCf7B9X7O5+oO8Vigvx4JOZ1iSnjiYAU8Orp7A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pwqYQHSTqQ6DO2bcHJWmOJqr5jJ9+wNTAqAs5pdIO6ubGs/23T2pbtY2laZzbs9ML5YOvxjgtSoGDwgebgZRBWKjuLQbAssAaUzqMGY6k8n17wc9ND9Tso9HOJmA5tm1tHdCL1R+vqUMo9TjagU9NFEzybgKLJy5pbzY6g39+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO2SVDZj; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29e0229d6b5so21801a91.3;
        Wed, 27 Mar 2024 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711556186; x=1712160986; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSCcPL9ReYBC3ieN7sRSJkCjHUDGGaoDNVjenjFddiw=;
        b=IO2SVDZjHjZPW2836N0zwP40dW7kQoErJc3ls12qCB3GBLL/+cruxnGBWIqWI55W+/
         rTAeZE/xIG/NdLRCfK923/dVb4ywqgrX36Nf41UNDY4mYqaWpJXe9kQkbcOGN2XMYmqo
         33n80Vko3quEny4XazHjxUtQwDeFUJI9S3MyQNR1EAB28D/cFgAW9MeqU8kXxKHa5uYF
         vefr5H27YGxpRGTYk4Ps13181tXpfpahUTy7rnWVlwqZqcgw7U9nEm2BYllgo3SIvzN0
         gBg3/Z8Ux/0GYKeEaX/9v9nBs0+OIqbt6JPoOyTJUXlXMBkouO7sSnpj6QAS4J2PiquO
         Xi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556186; x=1712160986;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSCcPL9ReYBC3ieN7sRSJkCjHUDGGaoDNVjenjFddiw=;
        b=t6TWzwP3nMhkl9lWbplncD69DNy6Z9TIfmtUWuM/Knj0TsaXMYJeu37kXUc5UAZZD+
         Q0CfvL9ASMuVsg5yxkCJeXEbBYEBAesjQHvVWV1XMpBtrljOX4pnHo1lrhUKhOCwOrI4
         F+ZP6PS3ZVlRE3bGHEAzsrOn8+jh8t7yogmNyTZluE/SGE+uvbhLek8CDG+Guikrf7yn
         /YGkLCrtfEela3Qw9u8wcDaQ2pGmX2VXLgv9eXpMxBOSk9fbhewKPmAf0blVbWQYh+nJ
         HeYzW6PJEDEs/xg7nXICdfa82I4+mT/KzNAfn0R+8TWQ4yVIUR7ZAo8QAjUXHLn2lpVS
         YMRg==
X-Forwarded-Encrypted: i=1; AJvYcCWtrL4rJRo2yOOVLMBANZSBx+7aw8MQceJGU4uUHHGlaogTXXasEn9nQNEjgrQ1aXH8T4t9a99X/yad+USad44ml+2LTMnphYL/8SaRdY+/MyXhA+ie1xmPBHros/x3YdUR0DebC+OpNYuHpUn0m9gkdMDNMYNg8zFbi5GZ4SpvBkVWNCPRuTqr1sOcmUZmmLsXPkhNxQlln0XDJyww7762UuWyVFIZSA==
X-Gm-Message-State: AOJu0YyifwLiRD4W03sQ3W17YXXXjUlkxxDQQpGK6mC+TMFLvYOKOVqp
	1UuHQER9BFEkBZ7HK22Q9ZJ/D5K4w9hsBLOt0//dv74xniapJuHV
X-Google-Smtp-Source: AGHT+IFb5IqfgxBvySBVcYNKgghJ48Dnwn4nEVJk9rDb4Sdzmwo0ZtCk8BBaNaurYYvMG+RdbrIyPw==
X-Received: by 2002:a17:90b:4a44:b0:29c:7845:cba with SMTP id lb4-20020a17090b4a4400b0029c78450cbamr100758pjb.36.1711556186202;
        Wed, 27 Mar 2024 09:16:26 -0700 (PDT)
Received: from smtpclient.apple ([2601:647:4d7e:dba0:5840:a196:2bf3:3600])
        by smtp.gmail.com with ESMTPSA id sl13-20020a17090b2e0d00b0029951d04dc4sm1903536pjb.54.2024.03.27.09.16.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:16:25 -0700 (PDT)
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
In-Reply-To: <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
Date: Wed, 27 Mar 2024 09:16:09 -0700
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Philipp Stanner <pstanner@redhat.com>,
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
 Marco Elver <elver@google.com>,
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
Message-Id: <160DB953-1588-418E-A490-381009CD8DE0@gmail.com>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
 <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On Mar 25, 2024, at 8:49=E2=80=AFPM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> But you should _start_ the design of your language memory model around
> the unsafe "raw atomic access operations" model.
>=20
> Then you can use those strictly more powerful operations, and you
> create an object model *around* it.

To some extent Rust does this already, unlike C++.

C++ allows atomics to be implemented using locks.  Partly for this =
reason,
`std::atomic<T>` is documented as not necessarily having the same
representation as `T` [1].  C++ also has strict aliasing, so even if =
those types
do have the same representation, you still can't cast `T *` to
`std::atomic<T> *`.

But Rust atomics are lower-level.  First, they are guaranteed lock-free =
[2].
Second, they are documented as having "the same in-memory representation =
as the
underlying" type [3].  (They also usually have the same alignment, =
except on
x86 where u64 is only 4-byte aligned but AtomicU64 of course needs to be =
8-byte
aligned.)  Meanwhile, Rust intentionally lacks strict aliasing.

Combined, this means it's perfectly legal in Rust to cast e.g. `&mut =
u32` to
`&AtomicU32` and perform atomic accesses on it.  Or the same with =
u64/AtomicU64
if you know the pointer is validly aligned.  This is by design; the =
Atomic
types' methods are considered the official way to perform atomic =
operations on
arbitrary memory, making it unnecessary to also stabilize 'lower-level'
intrinsics.

That said, there *are* currently some holes in Rust's atomics model, =
based on
the fact that it's mostly inherited from C++.  =46rom the documentation:

> Since C++ does not support mixing atomic and non-atomic accesses, or
> non-synchronized different-sized accesses to the same data, Rust does =
not
> support those operations either. Note that both of those restrictions =
only
> apply if the accesses are non-synchronized.
https://doc.rust-lang.org/std/sync/atomic/index.html

There are some open issues around this:

- "How can we allow read-read races between atomic and non-atomic =
accesses?"
  https://github.com/rust-lang/unsafe-code-guidelines/issues/483

  > [..] I do think we should allow such code. However, then we have to =
change
  > the way we document our atomics [..]

- "What about: mixed-size atomic accesses"
  https://github.com/rust-lang/unsafe-code-guidelines/issues/345"

  > Apparently the x86 manual says you "should" not do this [..] It is =
unclear
  > what "should" means (or what anything else here really means, =
operationally
  > speaking...)

[1] https://eel.is/c++draft/atomics#types.generic.general-3
[2] https://doc.rust-lang.org/std/sync/atomic/index.html#portability
[3] =
https://doc.rust-lang.org/nightly/std/sync/atomic/struct.AtomicU64.html


