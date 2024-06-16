Return-Path: <linux-fsdevel+bounces-21775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD58909CD2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF971F214AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1841B185080;
	Sun, 16 Jun 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gdcka24V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249216D9AA;
	Sun, 16 Jun 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718531223; cv=none; b=M0Hi38iZ18WmZR61b0CDsv/F1B2MRvJ8HS5OY2FjEbMpo4ZmO7fR5oOSPSZUSbbSMax6e9/yG2DbVIEFbx4CGvqTbL3aeBH7lWbEOlzzIMhq++XZ3Jl6mL6anzCQGDmWt02Wm+D0L0QRn381Aju1saBXhiUkFNMPDLg/v5qPUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718531223; c=relaxed/simple;
	bh=q26N2GgeVglH9gCbjku86QbUgLOk6W++2mgK2GguLKA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Psp8iExEV0tyzndRMKlcj/5Vl1ad3MlWDXpI4woI/qU7Bn7qtJRZGgdGeb5dgHoFes7qdR1mX2Hub2AFHGcp4EptAC2QZfkVhGg2jI08zYBN+MAwKDdwu3ad7j0BALg7S3awqdthhGC5uWrtxTobr7UzA3xv67dZHa9sE3pTSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gdcka24V; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1718531210; x=1718790410;
	bh=znzItjjdQt5Gx2XVgBVIK96GA/gE2ZHpRn5IIrL3wOI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gdcka24V73hbb95kA47a+wMdMUp4FbYBulK5vF0HVp5VuuKVIHcdEWJBB3Pr9bu6R
	 NhlXLdn5BBT81CawX9HbibONV/+vAxt3WSCairMGdKuSRg2n6YWI8G/wJ2DbrPKpf9
	 HS2i9kWdmrq8qeVqsz85MnkkYJGU468NSjOAVPo/T9VGGCYLfS4Uf4L55f1dZy2R26
	 9IX33orpEJWw52nEKBg45ayRvmmriRTDobFE4Yw8fZNKBX/SOqToQAtOsvc54DuE62
	 FvHp1UnFcS7dQGK8DhM/BJHitJbhGgI0o9RkWHNf+XL3ZY7PwFhxxHMnhkctS5siBg
	 uWVcH/2yjrgLQ==
Date: Sun, 16 Jun 2024 09:46:45 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <d67aeb8c-3499-4498-aaf9-4ac459c2f747@proton.me>
In-Reply-To: <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
References: <20240612223025.1158537-3-boqun.feng@gmail.com> <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com> <ZmtC7h7v1t6XJ6EI@boqun-archlinux> <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com> <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home> <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me> <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home> <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me> <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: aa019b834b17958b26c96544baf90fc8c32aaadd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.06.24 00:12, Boqun Feng wrote:
> On Sat, Jun 15, 2024 at 07:09:30AM +0000, Benno Lossin wrote:
>> On 15.06.24 03:33, Boqun Feng wrote:
>>> On Fri, Jun 14, 2024 at 09:22:24PM +0000, Benno Lossin wrote:
>>>> On 14.06.24 16:33, Boqun Feng wrote:
>>>>> On Fri, Jun 14, 2024 at 11:59:58AM +0200, Miguel Ojeda wrote:
>>>>>> On Thu, Jun 13, 2024 at 9:05=E2=80=AFPM Boqun Feng <boqun.feng@gmail=
.com> wrote:
>>>>>>>
>>>>>>> Does this make sense?
>>>>>>
>>>>>> Implementation-wise, if you think it is simpler or more clear/elegan=
t
>>>>>> to have the extra lower level layer, then that sounds fine.
>>>>>>
>>>>>> However, I was mainly talking about what we would eventually expose =
to
>>>>>> users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
>>>>>
>>>>> The truth is I don't know ;-) I don't have much data on which one is
>>>>> better. Personally, I think AtomicI32 and AtomicI64 make the users ha=
ve
>>>>> to think about size, alignment, etc, and I think that's important for
>>>>> atomic users and people who review their code, because before one use=
s
>>>>> atomics, one should ask themselves: why don't I use a lock? Atomics
>>>>> provide the ablities to do low level stuffs and when doing low level
>>>>> stuffs, you want to be more explicit than ergonomic.
>>>>
>>>> How would this be different with `Atomic<i32>` and `Atomic<i64>`? Just
>>>
>>> The difference is that with Atomic{I32,I64} APIs, one has to choose (an=
d
>>> think about) the size when using atomics, and cannot leave that option
>>> open. It's somewhere unconvenient, but as I said, atomics variables are
>>> different. For example, if someone is going to implement a reference
>>> counter struct, they can define as follow:
>>>
>>> =09struct Refcount<T> {
>>> =09    refcount: AtomicI32,
>>> =09    data: UnsafeCell<T>
>>> =09}
>>>
>>> but with atomic generic, people can leave that option open and do:
>>>
>>> =09struct Refcount<R, T> {
>>> =09    refcount: Atomic<R>,
>>> =09    data: UnsafeCell<T>
>>> =09}
>>>
>>> while it provides configurable options for experienced users, but it
>>> also provides opportunities for sub-optimal types, e.g. Refcount<u8, T>=
:
>>> on ll/sc architectures, because `data` and `refcount` can be in the sam=
e
>>> machine-word, the accesses of `refcount` are affected by the accesses o=
f
>>> `data`.
>>
>> I think this is a non-issue. We have two options of counteracting this:
>> 1. We can just point this out in reviews and force people to use
>>    `Atomic<T>` with a concrete type. In cases where there really is the
>>    need to be generic, we can have it.
>> 2. We can add a private trait in the bounds for the generic, nobody
>>    outside of the module can access it and thus they need to use a
>>    concrete type:
>>
>>         // needs a better name
>>         trait Integer {}
>>         impl Integer for i32 {}
>>         impl Integer for i64 {}
>>
>>         pub struct Atomic<T: Integer> {
>>             /* ... */
>>         }
>>
>> And then in the other module, you can't do this (with compiler error):
>>
>>         pub struct Refcount<R: Integer, T> {
>>                             // ^^^^^^^ not found in this scope
>>                             // note: trait `crate::atomic::Integer` exis=
ts but is inaccessible
>>             refcount: Atomic<R>,
>>             data: UnsafeCell<T>,
>>         }
>>
>> I think that we can start with approach 2 and if we find a use-case
>> where generics are really unavoidable, we can either put it in the same
>> module as `Atomic<T>`, or change the access of `Integer`.
>>
>=20
> What's the issue of having AtomicI32 and AtomicI64 first then? We don't
> need to do 1 or 2 until the real users show up.

Generics allow you to avoid code duplication (I don't think that you
want to create the `Atomic{I32,I64}` types via macros...). We would have
to do a lot of refactoring, when we want to introduce it. I don't see
the harm of introducing generics from the get-go.

> And I'd like also to point out that there are a few more trait bound
> designs needed for Atomic<T>, for example, Atomic<u32> and Atomic<i32>
> have different sets of API (no inc_unless_negative() for u32).

Sure, just like Gary said, you can just do:

    impl Atomic<i32> {
        pub fn inc_unless_negative(&self, ordering: Ordering) -> bool;
    }

Or add a `HasNegative` trait.

> Don't make me wrong, I have no doubt we can handle this in the type
> system, but given the design work need, won't it make sense that we take
> baby steps on this? We can first introduce AtomicI32 and AtomicI64 which
> already have real users, and then if there are some values of generic
> atomics, we introduce them and have proper discussion on design.

I don't understand this point, why can't we put in the effort for a good
design? AFAIK we normally spend considerable time to get the API right
and I think in this case it would include making it generic.

> To me, it's perfectly fine that Atomic{I32,I64} co-exist with Atomic<T>.
> What's the downside? A bit specific example would help me understand
> the real concern here.

I don't like that, why have two ways of doing the same thing? People
will be confused whether they should use `AtomicI32` vs `Atomic<i32>`...

---
Cheers,
Benno


