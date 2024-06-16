Return-Path: <linux-fsdevel+bounces-21782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B50909E15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 17:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828651F21654
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE01805A;
	Sun, 16 Jun 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mSraej69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640814F90;
	Sun, 16 Jun 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718550416; cv=none; b=k9aj7qcrVds1gYU7dasRHQGdMJaPnE8QlIYQ5w7BYpEPLjBEuP7dC74qmaJBXvzRJNBDLqzrEWRR5XhnSdZ18PCXZ9QpzJos4cQW/LrG3waSoGhiLjnr7nw2aZW9gjSE9xxQ1jla3j96mIr/4zNRIUQWRKnRY6MqCYXePTf53WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718550416; c=relaxed/simple;
	bh=p5zJ4+9q8IuUz87Wd9F+o/28kdYtulCro0d2mJm/XEY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCWvFGDOv2P2oKvoR2QF3uazwyOE2Z6HMhaw/1kiLY/bVj+lUxTpBAEHoHC8TrnzVVjEiHYPaGjN0/yrhq68Uw2ud57mTwfKGfGoOueKrSqF2Z1nLmyLWY6ZfCkT1Y1sepOLBa6mZ64NSx/ExJmANRrSgv8Rmwk7UBlsHiUC+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mSraej69; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6oh7yesvyjgnxl3sh6rcesrhj4.protonmail; t=1718550405; x=1718809605;
	bh=3NPcfb3TcZHCQq/fKC5xCaBEd1Gh0/q4eoxgjTOHKCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mSraej692hLKvs7mzHtyoFIACPfk+BbHW1PJdNOssrPuAExdBfaeVAoaHLN9yQ42p
	 VUV3G2T82Oyc0asvyD7ZX2d1ndVyFPTclvW68QT0U0xyNqjFjozCpGeX/k/9rGH09P
	 6QfS3FzHuyhv7c3jG1Ee6ymycimn38p1OBCMJJOE7/3n3dgpyjbcUAoOejwyz1o2gA
	 L/NDRr2Web4yroKi7RlJPc4TpAYFF0QHjnEKI7P1ne+mchcmCu0ZAUw9DANaImMnhz
	 VtVaj+9AhWL4nyet3pgmlEGK2o9za39WNUTyboboJ4xJCOhXoH9c3PfosFvWIkjHNT
	 8JEGxsTkIImYQ==
Date: Sun, 16 Jun 2024 15:06:36 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <f29cb2fd-651b-4bc5-8055-e3a412192e29@proton.me>
In-Reply-To: <Zm7xySzPJcddF-I_@Boquns-Mac-mini.home>
References: <20240612223025.1158537-3-boqun.feng@gmail.com> <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com> <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home> <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me> <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home> <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me> <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home> <d67aeb8c-3499-4498-aaf9-4ac459c2f747@proton.me> <Zm7xySzPJcddF-I_@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 491e33e1981ad9297cbb1951124c18038c7ab95a
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.06.24 16:08, Boqun Feng wrote:
> On Sun, Jun 16, 2024 at 09:46:45AM +0000, Benno Lossin wrote:
>> On 16.06.24 00:12, Boqun Feng wrote:
>>> On Sat, Jun 15, 2024 at 07:09:30AM +0000, Benno Lossin wrote:
>>>> On 15.06.24 03:33, Boqun Feng wrote:
>>>>> On Fri, Jun 14, 2024 at 09:22:24PM +0000, Benno Lossin wrote:
>>>>>> On 14.06.24 16:33, Boqun Feng wrote:
>>>>>>> On Fri, Jun 14, 2024 at 11:59:58AM +0200, Miguel Ojeda wrote:
>>>>>>>> On Thu, Jun 13, 2024 at 9:05=E2=80=AFPM Boqun Feng <boqun.feng@gma=
il.com> wrote:
>>>>>>>>>
>>>>>>>>> Does this make sense?
>>>>>>>>
>>>>>>>> Implementation-wise, if you think it is simpler or more clear/eleg=
ant
>>>>>>>> to have the extra lower level layer, then that sounds fine.
>>>>>>>>
>>>>>>>> However, I was mainly talking about what we would eventually expos=
e to
>>>>>>>> users, i.e. do we want to provide `Atomic<T>` to begin with? If ye=
s,
>>>>>>>
>>>>>>> The truth is I don't know ;-) I don't have much data on which one i=
s
>>>>>>> better. Personally, I think AtomicI32 and AtomicI64 make the users =
have
>>>>>>> to think about size, alignment, etc, and I think that's important f=
or
>>>>>>> atomic users and people who review their code, because before one u=
ses
>>>>>>> atomics, one should ask themselves: why don't I use a lock? Atomics
>>>>>>> provide the ablities to do low level stuffs and when doing low leve=
l
>>>>>>> stuffs, you want to be more explicit than ergonomic.
>>>>>>
>>>>>> How would this be different with `Atomic<i32>` and `Atomic<i64>`? Ju=
st
>>>>>
>>>>> The difference is that with Atomic{I32,I64} APIs, one has to choose (=
and
>>>>> think about) the size when using atomics, and cannot leave that optio=
n
>>>>> open. It's somewhere unconvenient, but as I said, atomics variables a=
re
>>>>> different. For example, if someone is going to implement a reference
>>>>> counter struct, they can define as follow:
>>>>>
>>>>> =09struct Refcount<T> {
>>>>> =09    refcount: AtomicI32,
>>>>> =09    data: UnsafeCell<T>
>>>>> =09}
>>>>>
>>>>> but with atomic generic, people can leave that option open and do:
>>>>>
>>>>> =09struct Refcount<R, T> {
>>>>> =09    refcount: Atomic<R>,
>>>>> =09    data: UnsafeCell<T>
>>>>> =09}
>>>>>
>>>>> while it provides configurable options for experienced users, but it
>>>>> also provides opportunities for sub-optimal types, e.g. Refcount<u8, =
T>:
>>>>> on ll/sc architectures, because `data` and `refcount` can be in the s=
ame
>>>>> machine-word, the accesses of `refcount` are affected by the accesses=
 of
>>>>> `data`.
>>>>
>>>> I think this is a non-issue. We have two options of counteracting this=
:
>>>> 1. We can just point this out in reviews and force people to use
>>>>    `Atomic<T>` with a concrete type. In cases where there really is th=
e
>>>>    need to be generic, we can have it.
>>>> 2. We can add a private trait in the bounds for the generic, nobody
>>>>    outside of the module can access it and thus they need to use a
>>>>    concrete type:
>>>>
>>>>         // needs a better name
>>>>         trait Integer {}
>>>>         impl Integer for i32 {}
>>>>         impl Integer for i64 {}
>>>>
>>>>         pub struct Atomic<T: Integer> {
>>>>             /* ... */
>>>>         }
>>>>
>>>> And then in the other module, you can't do this (with compiler error):
>>>>
>>>>         pub struct Refcount<R: Integer, T> {
>>>>                             // ^^^^^^^ not found in this scope
>>>>                             // note: trait `crate::atomic::Integer` ex=
ists but is inaccessible
>>>>             refcount: Atomic<R>,
>>>>             data: UnsafeCell<T>,
>>>>         }
>>>>
>>>> I think that we can start with approach 2 and if we find a use-case
>>>> where generics are really unavoidable, we can either put it in the sam=
e
>>>> module as `Atomic<T>`, or change the access of `Integer`.
>>>>
>>>
>>> What's the issue of having AtomicI32 and AtomicI64 first then? We don't
>>> need to do 1 or 2 until the real users show up.
>>
>> Generics allow you to avoid code duplication (I don't think that you
>> want to create the `Atomic{I32,I64}` types via macros...). We would have
>> to do a lot of refactoring, when we want to introduce it. I don't see
>=20
> You can simply do
>=20
> =09type AtomicI32=3DAtomic<i32>;

Eh, I would think that we could just do a text replacement in this case.
Or if that doesn't work, Coccinelle should be able to do this...

> Plus, we always do refactoring in kernel, because it's impossible to get
> everything right at the first time. TBH, it's too confident to think one
> can.

I don't think that we're at the "let's just put it in" stage. This is an
RFC version, so it should be fine to completely change the approach.
I agree, that we can't get it 100% right the first time, but we should
at least strive to get a good version.

>> the harm of introducing generics from the get-go.
>>
>>> And I'd like also to point out that there are a few more trait bound
>>> designs needed for Atomic<T>, for example, Atomic<u32> and Atomic<i32>
>>> have different sets of API (no inc_unless_negative() for u32).
>>
>> Sure, just like Gary said, you can just do:
>>
>>     impl Atomic<i32> {
>>         pub fn inc_unless_negative(&self, ordering: Ordering) -> bool;
>>     }
>>
>> Or add a `HasNegative` trait.
>>
>>> Don't make me wrong, I have no doubt we can handle this in the type
>>> system, but given the design work need, won't it make sense that we tak=
e
>>> baby steps on this? We can first introduce AtomicI32 and AtomicI64 whic=
h
>>> already have real users, and then if there are some values of generic
>>> atomics, we introduce them and have proper discussion on design.
>>
>> I don't understand this point, why can't we put in the effort for a good
>> design? AFAIK we normally spend considerable time to get the API right
>> and I think in this case it would include making it generic.
>>
>=20
> What's the design you propose here? Well, the conversation between us is
> only the design bit I saw, elsewhere it's all handwaving that "generics
> are overall really good". I'm happy to get the API right, and it's easy
> and simple to do on concrete types. But IIUC, Gary's suggestion is to
> only have Atomic<i32> and Atomic<i64> first, and do the design later,
> which I really don't like. It may not be a complete design, but I need
> to see the design now to understand whether we need to go to that
> direction. I cannot just introduce a TBD generic.

I don't think that the idea was to "do the design later". I don't even
know how you would do that, since you need the design to submit a patch.

I can't offer you a complete API description, since that would require
me writing it up myself. But I would recommend trying to get it to work
with generics. I got a few other comments:
- I don't think that we should resort to a script to generate the Rust
  code since it prevents adding good documentation & examples to the
  various methods. AFAIU you want to generate the functions from
  `scripts/atomic/atomics.tbl` to keep it in sync with the C side. I
  looked at the git log of that file and it hasn't been changed
  significantly since its inception. I don't think that there is any
  benefit to generating the functions from that file.
- most of the documented functions say "See `c_function`", I don't like
  this, can we either copy the C documentation (I imagine it not
  changing that often, or is that assumption wrong?) or write our own?
- we should try to use either const generic or normal parameters for the
  access ordering instead of putting it in the function name.
- why do we need both non-return and return variants?

I think it is probably a good idea to discuss this in our meeting.

---
Cheers,
Benno


