Return-Path: <linux-fsdevel+bounces-21914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE9490E718
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 11:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE741F22149
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AF81219;
	Wed, 19 Jun 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cSbHonGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C380C09
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789425; cv=none; b=Mm/bp4n55RW1suLgvthYRPDYIeyCnXZ4bgoxduFiKdCm486kWderlWOdTF4g7ncWOLwTDVpIx3cGasNoJNtVqpIl04jtipFhB5yXeJiQsRCVE60j4+8LhXZq3pfPOTpszjdN1LjbKnAitrvlmloCNycCJdg/8hyyx0BiahMQTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789425; c=relaxed/simple;
	bh=7ne4ekeJPSiu9Wa/xWvMdy+2iJetKy2FB72LpR8ncLY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBK3A/xHARiogUJ1Cv+fiFSpnX6YGa2WtEVTGTMVb7ZNJHgH7+ZiR6dI2PebGoS7IgDRQXPIwrFWphW4bTY3fqvEXelj09LCotFB2dBz/+HI2Y3LJr3jRp2NoNksYKnzbA4QofP873GxHlpDHOWw5fWtC/gkxe0w9Qc2RohrUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cSbHonGn; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1718789420; x=1719048620;
	bh=zV1Qzzj1i+vpiKHlTH9zT9EGlrl+KcXNNmM1imA2OVs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cSbHonGnWaJH37f1v+pSaKUQwYqlPPs+VtxX+8Sx2EZa4gfkG6EbZpEFL1ac6AJSJ
	 +zm/edwto6ej3rtZoDCxktTyvEy3KwzMLuGps4gixWJId4+eIiKjM/YMAhuD6RbdTa
	 j2RiXtPvBlCrR2Ag+uGa4Vgwq0/I7AWttYOmTjke/x5q7y7xM99zlCRi47Or+OqD4B
	 BNKE8/RAyZk2+tGreTkAu5UwsC5NQJ1h9HMGsX3AIPaP33fOeRgCQa+6byjK08Ys5d
	 EoE5c2uLBWYZcaqYKWiyoYziz+AMut+hOdm0vJt8NWQ+16u6mtF0WYN3hqgQ6OQor7
	 e5Z3mWOu+o96A==
Date: Wed, 19 Jun 2024 09:30:15 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: John Hubbard <jhubbard@nvidia.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <8f23cb56-91a9-4515-a14f-4b7de70f6852@proton.me>
In-Reply-To: <Zm_LTXm3wJhcQIwI@Boquns-Mac-mini.home>
References: <ZmseosxVQXdsQjNB@boqun-archlinux> <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com> <79239550-dd6e-4738-acea-e7df50176487@nvidia.com> <ZmztZd9OJdLnBZs5@Boquns-Mac-mini.home> <c243bef3-e152-462f-be68-91dbf876092b@nvidia.com> <Zmz-338Ad6r4vzM-@Boquns-Mac-mini.home> <20240616155145.54371240.gary@garyguo.net> <Zm7_XWe6ciy1yN-h@Boquns-Mac-mini.home> <Zm_LTXm3wJhcQIwI@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 11698e3de8f944b2217c782e5cf4abe605702990
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.06.24 07:36, Boqun Feng wrote:
> On Sun, Jun 16, 2024 at 08:06:05AM -0700, Boqun Feng wrote:
> [...]
>>>
>>> Note that crossbeam's AtomicCell is also generic, and crossbeam is used
>>> by tons of crates. As Miguel mentioned, I think it's very likely that i=
n
>>> the future we want be able to do atomics on new types (e.g. for
>>> seqlocks perhaps). We probably don't need the non-lock-free fallback of
>>
>> Good, another design bit, thank you!
>>
>> What's our overall idea on sub-word types, like Atomic<u8> and
>> Atomic<u16>, do we plan to say no to them, or they could have a limited
>> APIs? IIUC, some operations on them are relatively sub-optimal on some
>> architectures, supporting the same set of API as i32 and i64 is probably
>> a bad idea.
>>
>> Another thing in my mind is making `Atomic<T>`
>>
>> =09pub struct Atomic<T: Send + ...> { ... }
>>
>> so that `Atomic<T>` will always be `Sync`, because quite frankly, an
>> atomic type that cannot `Sync` is pointless.

That is true, but adding semantically "unnecessary" bounds can be bad.
This is because they infect everything that wants to use `Atomic<T>`,
since they also need to add that bound.

> Also, how do we avoid this issue [1] in kernel?

I think that we can first go the way of my second approach (ie adding a
private trait as a bound on `Atomic<T>` to prevent generic usage). And
only allow primitives.
If we then see that people would like to put their own (u8, u16) tuple
structs into `Atomic<T>`, we have multiple options:

1. Field projection:
   Only primitives can be `load`ed and `store`ed, to access the values
   of the tuple, one would need to project to each field and read them.

2. Disallow padding:
   We add an `unsafe` trait that asserts there are no padding bytes in
   there (like `NoUinit` from below) and also add a macro that
   implements the trait safely.

3. Use `MaybeUninit` under the hood:
   I don't know if this would fix the issue entirely, since that is what
   crossbeam currently uses (but the issue remains open).

But I don't think that we should encourage large structs to be put into
`Atomic<T>`, since that would be bad for perf, right? So I think that
going the way of 1 would be great (if we had FP, otherwise 2 seems fine).

> `atomic_load()` in C is implemented as READ_ONCE() and it's, at most
> time, a volatile read, so the eventual code is:
>=20
>     let a: (u8, u16) =3D (1, 2);
>     let b =3D unsafe { core::ptr::read_volatile::<i32>(&a as *const _ as =
*const i32) };
>=20
> I know we probably ignore data race here and treat `read_volatile` as a
> dependency read per LKMM [2]. But this is an using of uninitialized
> data, so it's a bit different.

But would we implement it this way? Or would it go through a C function?
If we entirely do it in Rust, then yes this is bad.

---
Cheers,
Benno

> We can do what https://crates.io/crates/atomic does:
>=20
> =09pub struct Atomic<T: NoUninit + ..> { ... }
>=20
> , where `NoUinit` means no internal padding bytes, but it loses the
> ability to put a
>=20
> =09#[repr(u32)]
> =09pub enum Foo { .. }
>=20
> into `Atomic<T>`, right? Which is probably a case you want to support?
>=20
> Regards,
> Boqun
>=20
> [1]: https://github.com/crossbeam-rs/crossbeam/issues/748#issuecomment-11=
33926617
> [2]: tools/memory-model/Documentation/access-marking.txt



