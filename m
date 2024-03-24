Return-Path: <linux-fsdevel+bounces-15180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A58887E27
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 18:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559E0281570
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2371A5AC;
	Sun, 24 Mar 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9tjCJ1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C24B1841;
	Sun, 24 Mar 2024 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711301839; cv=none; b=dENBIx9hcwORn9tiutJQqCsPmpeV57/PxU4H9fle0Kg3huzXlNsCPMuzXX8CTc70+UUJbkAzU+3A5rGr8fntWjvU2g7g6eKj6T/2er1UoUZnsfs+50quskZUovjivylUMqhu0qL1iBjzNcHGA9hrPzGkoxNVLmRIid0tCY6HT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711301839; c=relaxed/simple;
	bh=e8Wzt++tI0Y6lTciHZrwviD9JAPYs1UHfQ1N/92js8k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t/DcCGNQjP4Jbxzh0x99CMd+zMX35FCDQbog2yfHxov9zoOnkHBW0KrsPFtA4xMbDrcSdgYfvnSxCPiGu270meX9FnerEN8RSCgLKFnyqFmMXML88EFYOEF2ZLk2GU8bCWvSrRGasrIYo9dZXqZztpprmjP7OGPYVfA7PiDZDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9tjCJ1Z; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-789fb1f80f5so259885485a.3;
        Sun, 24 Mar 2024 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711301837; x=1711906637; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A5SUwxxd4XjDHjkrEb2n2ZXL0/7LMjpgw75QRXKPIo=;
        b=U9tjCJ1ZmAn4W1sQlddU2YtDArW9vMQs4On2X1DVYRqlxSzVHWtNuml0ac2AzbBJZJ
         qGbPef81QRvLsk7ZxmPupjpvCrDKhWTxDr3V7kcwR53CxMZxO7ajLHjGoX+APMSPwe5m
         snL9AhnJAK6toz7Csn2K7uak6UXps9Mp+xYWC0QnyMI2MMrHWxDIuXZh9a0xH9/r/nSW
         XfRHiali/kF2ooatjFzX1gbNWhuIOg1vLqmnJo3COMSDKtsAlLLW3Krsp8zsg+y0+0ew
         8BThdRBcTYgzKJlo5SRnxLklTzDZhwHAUlZ16BWdw8q9iT9K+6zkjYwXJTmOwM0yn7z1
         Lw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711301837; x=1711906637;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A5SUwxxd4XjDHjkrEb2n2ZXL0/7LMjpgw75QRXKPIo=;
        b=fIMAoKF/NNWQj4HeYdooFen9gkvvOAYHK+dPqJ0LNDOrdAXH1/pBO13yJYSgicGGxZ
         AX0iwDFK5zmEJ/Lmh3vCYnBe6fNR79TCja+QSAHbCHcILwDgRa0wv9UFO7OFRUEyfA+L
         w+8hAaCH0PCUgenpVUjLo38awSJYz4yCPMPoYiLiYhA8iMCQOEYAVsaqz9YV503Zh16u
         DEhrmHBk3pQYApIlB/DmW291Dlu6QFLnN4JtUofE7hCMQmvpxlK8kuTDrR0NTpkyFG+Q
         KX7DTes+VoxngKPvfUxOwRqznHZ+s0DtUHVhY5STc+SRwh//P+Pcjy2m987ZoUHVt43E
         lI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBF7U0hxnl3+h0XkG0AhD3RutxhxBurW+97yc4ix9BGwRqxVm4ODHyN1s3wAJlx0fR+RUd2+doeKkveKrg3GeGnCdk0zoRiwb8tudkLFrtm2yrSaMKaVpUNUqaahkmKdrUzME7VFlh3mb5aHSx+eCns7lZWXkC4+8u12gYKwnZQ7Y+YnT8FaeyYQ/Lilb1xWIlMs+goZm4bua9iXWjmJkgAVk7mOlvBA==
X-Gm-Message-State: AOJu0Yzrz6YcKKPNHOIoH8ZJvcXkb3KBCE9FRMtUmsUfTgDL12IooJzp
	9FIwLUAYFgraXkqLFmf/lf7sl3PyjpHp6ck3C8cK9l6omTTrMYy2
X-Google-Smtp-Source: AGHT+IFjpSfbEmAjCyadZ4oh3c1hlZvr8OuU2bvWGAJwDmJef8K4HA0yJIlXQ6FGAqvDYB9qnUMuMw==
X-Received: by 2002:a05:620a:5d8a:b0:78a:1e39:2674 with SMTP id xx10-20020a05620a5d8a00b0078a1e392674mr5391270qkn.39.1711301837071;
        Sun, 24 Mar 2024 10:37:17 -0700 (PDT)
Received: from smtpclient.apple ([63.115.34.165])
        by smtp.gmail.com with ESMTPSA id vq12-20020a05620a558c00b00789ea123bd5sm1491096qkn.59.2024.03.24.10.37.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2024 10:37:16 -0700 (PDT)
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
In-Reply-To: <174272a1-e21f-4d85-94ab-f0457bd1c93b@rowland.harvard.edu>
Date: Sun, 24 Mar 2024 13:37:03 -0400
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
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
Message-Id: <3088DF9A-6507-423B-8F0A-100B78DE1A26@gmail.com>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <C85BE4F4-5847-45B4-A973-76B184B35EDE@gmail.com>
 <174272a1-e21f-4d85-94ab-f0457bd1c93b@rowland.harvard.edu>
To: Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Mar 24, 2024, at 11:22=E2=80=AFAM, Alan Stern =
<stern@rowland.harvard.edu> wrote:
>=20
> I don't know if this is what you meant by "in a weak memory model, the=20=

> escape can =E2=80=98time travel'".  Regardless, it seems very clear =
that any=20
> compiler which swaps L1 and L2 in f() has a genuine bug.

Yes, that=E2=80=99s what I meant.  Clang thinks it=E2=80=99s valid to =
swap L1 and L2.  Though, for it to actually happen, they would have to =
be in a loop, since the problematic optimization is =E2=80=9Cloop-invarian=
t code motion".  Here=E2=80=99s a modified version of your f() that =
shows the optimization in action:

https://godbolt.org/z/bdaTjjvMs

Anyway, my point is just that using LKMM doesn=E2=80=99t save you from =
the bug.=

