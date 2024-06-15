Return-Path: <linux-fsdevel+bounces-21753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FFC90967C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 09:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FC0B214D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 07:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A99517C8D;
	Sat, 15 Jun 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="al09To6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF47175AB;
	Sat, 15 Jun 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718435388; cv=none; b=uZMO8KeSb9AO1MA8GmARL5oZ7pj/EisJkuiX17qHihUkcJj12UUzInVgNOQBXq2UlEnjYm++KtRa1OcPDDDn7EJ3JdDJUJxCiqZbmJW05/DUE1fVsuMQ4EFEiDQx41sICFuMe1OTna7Hary2vc+Km+lA+yb+61k5Xc1BrMQ+7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718435388; c=relaxed/simple;
	bh=InMc+8IWJ3kDnz0Ha0kfcXNeCtlY2AtkImdW3XBWYi0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJ6vnTdR2GJ9cTygzdjDeK8Fm8ZQ4K99+TVf06tNxesAUR7ZAdez0Qap/o6MtfxneyV2sS3EvA/GVDAbvA++EzvUlnLDkTtBD7bn+OJIOfrR/a1P0KVcjupKVerhQw9k7BPvUk4oCHh0cpxwweZkQdXzjjweZNI76dYWiLTLRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=al09To6l; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1718435377; x=1718694577;
	bh=VZAtgC22c+KKhYQxrDN1MaUsBpanAgCvr8LCqwklF+A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=al09To6lFGef0pLt+lAgVXExOeTE7RV2cHxyTFfnDiKPM6HH0JIcwLretKPKvEDkB
	 Ix5L9JkKTfEIK/ZiCrif3IzTEpvAcFVkwOusL1PGEWCsRjs5OgZw5uwSSV8AHjS2gS
	 8BelcQduzkOZafPBwRjgQpWTmpW1VAeHoLwsail/AbQQ88Dig1tIsWm54EGO/Y2RBb
	 EIcJR5Ko7JSuwBCJdqXbfz+OV2AqT4C/OypMsZWUPvIy++By/GMQj0b2jKMiaBCwwz
	 wmwF3X0uK2onzKhp8BdJZZlkZGlY0gIM2nsS1K0i7NkxaIQWOpwPxeqrvrJWbpXgPA
	 IZu3dEYfErRTg==
Date: Sat, 15 Jun 2024 07:09:30 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
In-Reply-To: <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
References: <20240612223025.1158537-1-boqun.feng@gmail.com> <20240612223025.1158537-3-boqun.feng@gmail.com> <20240613144432.77711a3a@eugeo> <ZmseosxVQXdsQjNB@boqun-archlinux> <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com> <ZmtC7h7v1t6XJ6EI@boqun-archlinux> <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com> <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home> <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me> <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0fe548fbc11fa01208724021192655e59f7fc5d2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.06.24 03:33, Boqun Feng wrote:
> On Fri, Jun 14, 2024 at 09:22:24PM +0000, Benno Lossin wrote:
>> On 14.06.24 16:33, Boqun Feng wrote:
>>> On Fri, Jun 14, 2024 at 11:59:58AM +0200, Miguel Ojeda wrote:
>>>> On Thu, Jun 13, 2024 at 9:05=E2=80=AFPM Boqun Feng <boqun.feng@gmail.c=
om> wrote:
>>>>>
>>>>> Does this make sense?
>>>>
>>>> Implementation-wise, if you think it is simpler or more clear/elegant
>>>> to have the extra lower level layer, then that sounds fine.
>>>>
>>>> However, I was mainly talking about what we would eventually expose to
>>>> users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
>>>
>>> The truth is I don't know ;-) I don't have much data on which one is
>>> better. Personally, I think AtomicI32 and AtomicI64 make the users have
>>> to think about size, alignment, etc, and I think that's important for
>>> atomic users and people who review their code, because before one uses
>>> atomics, one should ask themselves: why don't I use a lock? Atomics
>>> provide the ablities to do low level stuffs and when doing low level
>>> stuffs, you want to be more explicit than ergonomic.
>>
>> How would this be different with `Atomic<i32>` and `Atomic<i64>`? Just
>=20
> The difference is that with Atomic{I32,I64} APIs, one has to choose (and
> think about) the size when using atomics, and cannot leave that option
> open. It's somewhere unconvenient, but as I said, atomics variables are
> different. For example, if someone is going to implement a reference
> counter struct, they can define as follow:
>=20
> =09struct Refcount<T> {
> =09    refcount: AtomicI32,
> =09    data: UnsafeCell<T>
> =09}
>=20
> but with atomic generic, people can leave that option open and do:
>=20
> =09struct Refcount<R, T> {
> =09    refcount: Atomic<R>,
> =09    data: UnsafeCell<T>
> =09}
>=20
> while it provides configurable options for experienced users, but it
> also provides opportunities for sub-optimal types, e.g. Refcount<u8, T>:
> on ll/sc architectures, because `data` and `refcount` can be in the same
> machine-word, the accesses of `refcount` are affected by the accesses of
> `data`.

I think this is a non-issue. We have two options of counteracting this:
1. We can just point this out in reviews and force people to use
   `Atomic<T>` with a concrete type. In cases where there really is the
   need to be generic, we can have it.
2. We can add a private trait in the bounds for the generic, nobody
   outside of the module can access it and thus they need to use a
   concrete type:

        // needs a better name
        trait Integer {}
        impl Integer for i32 {}
        impl Integer for i64 {}

        pub struct Atomic<T: Integer> {
            /* ... */
        }

And then in the other module, you can't do this (with compiler error):

        pub struct Refcount<R: Integer, T> {
                            // ^^^^^^^ not found in this scope
                            // note: trait `crate::atomic::Integer` exists =
but is inaccessible
            refcount: Atomic<R>,
            data: UnsafeCell<T>,
        }

I think that we can start with approach 2 and if we find a use-case
where generics are really unavoidable, we can either put it in the same
module as `Atomic<T>`, or change the access of `Integer`.

---
Cheers,
Benno

> The point I'm trying to make here is: when you are using atomics, you
> care about performance a lot (otherwise, why don't you use a lock?), and
> because of that, you should care about the size of the atomics, because
> it may affect the performance significantly.


