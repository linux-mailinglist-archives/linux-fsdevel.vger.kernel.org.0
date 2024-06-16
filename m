Return-Path: <linux-fsdevel+bounces-21789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF7909E42
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C376CB20996
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1913F1C68E;
	Sun, 16 Jun 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QrBygh8S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FA1BC23;
	Sun, 16 Jun 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718553323; cv=none; b=SLlKav+9VKLoTf4+9VplHGUkw8ukd99cO7gb88kkH/MpG42LHtsPga3zx0XowbVgFoozXMQdmYr6giWtGgq0vz37GX+nLCg5mkytC1C0QZzY5jsBcblaVl1aPeF31fDJP38pRv3Z4TAS7LefFsgm+CnXOPSiLiUmpM3qJ6YUFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718553323; c=relaxed/simple;
	bh=kcC3w13VrfxRb6tpYyyBosyv7OrSc0j48TvAnV+fu1Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTRv9/01AIRHxgK7aHu5Wh2MQnczQKL4KqBqc/9lq7vA+m3Y382TmwTAJ9Z3amcrxHpmBnG5nntl5a/HwqHocbgAr8KLDsWGU4lxxRpLhjMf1CyofEapT1BSXK/xom4QL8be1SOinGGjlhG4NSdwzAjw8F2GJ/vLHej7vdKI8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QrBygh8S; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1718553317; x=1718812517;
	bh=ctRLXoxi0KvO/8qAZoHDVJO9KmER+NNguFvW5A9aV1I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QrBygh8Sz75Jz2utzjLkAxH52l0F77c8uoUxHJaer2Bo8eGAVoRB6C5kcCCr1xRb9
	 LT4c1ahGDY7KRC4YJmkrHWHfDzB4tI/MQ3fLPZi+Xz/ggwztr0jfg56y2mX92u4A7o
	 3b+PuRkXpK7Y0vkKDghcdgTQySecIgrM+9kaUYkL3+1lE7t/SLp1v+f4x0T1Mw7HdV
	 vmsBfXqmZ43ykbcymc4xqAOW4o5OfdNG5/8otaUx7Lm4RiNnC0713W/HFaZ3WRdtEM
	 bv0DeotKqGzoidUhdxtzxNW/0RCHLJyTcDJ/AEex6Pxh3y+eeHk8rNvLnFQXpHTmF5
	 r/6xKFCLDbOmA==
Date: Sun, 16 Jun 2024 15:55:12 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <0653b5d5-7a62-4baa-a500-4c110d816ba0@proton.me>
In-Reply-To: <Zm8F7ZFnUFJkFGQ3@Boquns-Mac-mini.home>
References: <20240612223025.1158537-3-boqun.feng@gmail.com> <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me> <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home> <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me> <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home> <d67aeb8c-3499-4498-aaf9-4ac459c2f747@proton.me> <Zm7xySzPJcddF-I_@Boquns-Mac-mini.home> <f29cb2fd-651b-4bc5-8055-e3a412192e29@proton.me> <Zm8F7ZFnUFJkFGQ3@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1889aa0f4a38e9a79148a675090aeb93a7a33e50
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.06.24 17:34, Boqun Feng wrote:
> On Sun, Jun 16, 2024 at 03:06:36PM +0000, Benno Lossin wrote:
>> On 16.06.24 16:08, Boqun Feng wrote:
>>> On Sun, Jun 16, 2024 at 09:46:45AM +0000, Benno Lossin wrote:
>>>> On 16.06.24 00:12, Boqun Feng wrote:
>>>>> On Sat, Jun 15, 2024 at 07:09:30AM +0000, Benno Lossin wrote:
>>>>>> On 15.06.24 03:33, Boqun Feng wrote:
>>>>>>> On Fri, Jun 14, 2024 at 09:22:24PM +0000, Benno Lossin wrote:
>>>>>>>> On 14.06.24 16:33, Boqun Feng wrote:
>>>>>>>>> On Fri, Jun 14, 2024 at 11:59:58AM +0200, Miguel Ojeda wrote:
>>>>>>>>>> On Thu, Jun 13, 2024 at 9:05=E2=80=AFPM Boqun Feng <boqun.feng@g=
mail.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Does this make sense?
>>>>>>>>>>
>>>>>>>>>> Implementation-wise, if you think it is simpler or more clear/el=
egant
>>>>>>>>>> to have the extra lower level layer, then that sounds fine.
>>>>>>>>>>
>>>>>>>>>> However, I was mainly talking about what we would eventually exp=
ose to
>>>>>>>>>> users, i.e. do we want to provide `Atomic<T>` to begin with? If =
yes,
>>>>>>>>>
>>>>>>>>> The truth is I don't know ;-) I don't have much data on which one=
 is
>>>>>>>>> better. Personally, I think AtomicI32 and AtomicI64 make the user=
s have
>>>>>>>>> to think about size, alignment, etc, and I think that's important=
 for
>>>>>>>>> atomic users and people who review their code, because before one=
 uses
>>>>>>>>> atomics, one should ask themselves: why don't I use a lock? Atomi=
cs
>>>>>>>>> provide the ablities to do low level stuffs and when doing low le=
vel
>>>>>>>>> stuffs, you want to be more explicit than ergonomic.
>>>>>>>>
>>>>>>>> How would this be different with `Atomic<i32>` and `Atomic<i64>`? =
Just
>>>>>>>
>>>>>>> The difference is that with Atomic{I32,I64} APIs, one has to choose=
 (and
>>>>>>> think about) the size when using atomics, and cannot leave that opt=
ion
>>>>>>> open. It's somewhere unconvenient, but as I said, atomics variables=
 are
>>>>>>> different. For example, if someone is going to implement a referenc=
e
>>>>>>> counter struct, they can define as follow:
>>>>>>>
>>>>>>> =09struct Refcount<T> {
>>>>>>> =09    refcount: AtomicI32,
>>>>>>> =09    data: UnsafeCell<T>
>>>>>>> =09}
>>>>>>>
>>>>>>> but with atomic generic, people can leave that option open and do:
>>>>>>>
>>>>>>> =09struct Refcount<R, T> {
>>>>>>> =09    refcount: Atomic<R>,
>>>>>>> =09    data: UnsafeCell<T>
>>>>>>> =09}
>>>>>>>
>>>>>>> while it provides configurable options for experienced users, but i=
t
>>>>>>> also provides opportunities for sub-optimal types, e.g. Refcount<u8=
, T>:
>>>>>>> on ll/sc architectures, because `data` and `refcount` can be in the=
 same
>>>>>>> machine-word, the accesses of `refcount` are affected by the access=
es of
>>>>>>> `data`.
>>>>>>
>>>>>> I think this is a non-issue. We have two options of counteracting th=
is:
>>>>>> 1. We can just point this out in reviews and force people to use
>>>>>>    `Atomic<T>` with a concrete type. In cases where there really is =
the
>>>>>>    need to be generic, we can have it.
>>>>>> 2. We can add a private trait in the bounds for the generic, nobody
>>>>>>    outside of the module can access it and thus they need to use a
>>>>>>    concrete type:
>>>>>>
>>>>>>         // needs a better name
>>>>>>         trait Integer {}
>>>>>>         impl Integer for i32 {}
>>>>>>         impl Integer for i64 {}
>>>>>>
>>>>>>         pub struct Atomic<T: Integer> {
>>>>>>             /* ... */
>>>>>>         }
>>>>>>
>>>>>> And then in the other module, you can't do this (with compiler error=
):
>>>>>>
>>>>>>         pub struct Refcount<R: Integer, T> {
>>>>>>                             // ^^^^^^^ not found in this scope
>>>>>>                             // note: trait `crate::atomic::Integer` =
exists but is inaccessible
>>>>>>             refcount: Atomic<R>,
>>>>>>             data: UnsafeCell<T>,
>>>>>>         }
>>>>>>
>>>>>> I think that we can start with approach 2 and if we find a use-case
>>>>>> where generics are really unavoidable, we can either put it in the s=
ame
>>>>>> module as `Atomic<T>`, or change the access of `Integer`.
>>>>>>
>>>>>
>>>>> What's the issue of having AtomicI32 and AtomicI64 first then? We don=
't
>>>>> need to do 1 or 2 until the real users show up.
>>>>
>>>> Generics allow you to avoid code duplication (I don't think that you
>>>> want to create the `Atomic{I32,I64}` types via macros...). We would ha=
ve
>>>> to do a lot of refactoring, when we want to introduce it. I don't see
>>>
>>> You can simply do
>>>
>>> =09type AtomicI32=3DAtomic<i32>;
>>
>> Eh, I would think that we could just do a text replacement in this case.
>> Or if that doesn't work, Coccinelle should be able to do this...
>>
>>> Plus, we always do refactoring in kernel, because it's impossible to ge=
t
>>> everything right at the first time. TBH, it's too confident to think on=
e
>>> can.
>>
>> I don't think that we're at the "let's just put it in" stage. This is an
>> RFC version, so it should be fine to completely change the approach.
>=20
> I'm fine as well. I wasn't trying to rush anything, but as I mentioned
> below, I need some more design from people who want it to understand
> whether that's a good idea.
>=20
>> I agree, that we can't get it 100% right the first time, but we should
>> at least strive to get a good version.
>>
>>>> the harm of introducing generics from the get-go.
>>>>
>>>>> And I'd like also to point out that there are a few more trait bound
>>>>> designs needed for Atomic<T>, for example, Atomic<u32> and Atomic<i32=
>
>>>>> have different sets of API (no inc_unless_negative() for u32).
>>>>
>>>> Sure, just like Gary said, you can just do:
>>>>
>>>>     impl Atomic<i32> {
>>>>         pub fn inc_unless_negative(&self, ordering: Ordering) -> bool;
>>>>     }
>>>>
>>>> Or add a `HasNegative` trait.
>>>>
>>>>> Don't make me wrong, I have no doubt we can handle this in the type
>>>>> system, but given the design work need, won't it make sense that we t=
ake
>>>>> baby steps on this? We can first introduce AtomicI32 and AtomicI64 wh=
ich
>>>>> already have real users, and then if there are some values of generic
>>>>> atomics, we introduce them and have proper discussion on design.
>>>>
>>>> I don't understand this point, why can't we put in the effort for a go=
od
>>>> design? AFAIK we normally spend considerable time to get the API right
>>>> and I think in this case it would include making it generic.
>>>>
>>>
>>> What's the design you propose here? Well, the conversation between us i=
s
>>> only the design bit I saw, elsewhere it's all handwaving that "generics
>>> are overall really good". I'm happy to get the API right, and it's easy
>>> and simple to do on concrete types. But IIUC, Gary's suggestion is to
>>> only have Atomic<i32> and Atomic<i64> first, and do the design later,
>>> which I really don't like. It may not be a complete design, but I need
>>> to see the design now to understand whether we need to go to that
>>> direction. I cannot just introduce a TBD generic.
>>
>> I don't think that the idea was to "do the design later". I don't even
>> know how you would do that, since you need the design to submit a patch.
>>
>=20
> Then I might mis-understand Gary? He said:
>=20
> "Can we avoid two types and use a generic `Atomic<T>` and then implement
> on `Atomic<i32>` and `Atomic<i64>` instead?"
>=20
> , which means just replace `impl AtomicI32` with `impl Atomic<i32>` to
> me.

This is a fair interpretation, but what prevents you from merging the
impls of functions that can be? I assumed that you would do that
automatically.

>> I can't offer you a complete API description, since that would require
>> me writing it up myself. But I would recommend trying to get it to work
>> with generics. I got a few other comments:
>=20
> We should work on things that are concrete, right? It's fine that the
> design is not complete, and it's fine if you just recommend. But without
> a somewhat concrete design (doesn't have to be complete), I cannot be
> sure about whether we have the same vision of the future of generic
> atomics (see my question to Gary), that's a bit hard for me to try to

Sorry, which question?
Also to be aligned on the vision, I think we should rather talk about
the vision and not the design, since the design that we want to have now
can be different from the vision. On that note, what do you envision the
future of the atomic API?

> work something out (plus I personally don't think it's a good idea, it's
> OK to me, but not good). Anyway, I wasn't trying to refuse to do this
> just based on personal reasons, but I do need to understand what you are
> all proposing, because I don't have one myself.

I went back through the thread and here is what I think your argument
against generics is: people should think about size and alignment when
using atomics, which is problematic when allowing users to leave the
atomic generic.
But as I argued before, this is not an issue. Have I overlooked another
argument? Because I don't see anything else.

>> - I don't think that we should resort to a script to generate the Rust
>>   code since it prevents adding good documentation & examples to the
>>   various methods. AFAIU you want to generate the functions from
>>   `scripts/atomic/atomics.tbl` to keep it in sync with the C side. I
>>   looked at the git log of that file and it hasn't been changed
>>   significantly since its inception. I don't think that there is any
>>   benefit to generating the functions from that file.
>=20
> I'll leave this to other atomic maintainers.
>=20
>> - most of the documented functions say "See `c_function`", I don't like
>>   this, can we either copy the C documentation (I imagine it not
>>   changing that often, or is that assumption wrong?) or write our own?
>=20
> You're not wrong. AN in C side, we do have some documentation template
> to generate the comments (see scripts/atomic/kerneldoc). But first the
> format is for doxygen(I guess?), and second as you just bring up, the
> templates are tied with the bash script.

I see a bash script similarly to how Wedson sees proc macros ;)
We should try *hard* to avoid them and only use them when there is no
other way.

>> - we should try to use either const generic or normal parameters for the
>>   access ordering instead of putting it in the function name.
>=20
> Why is it important? Keeping it in the current way brings the value that
> it's not too much different than their C counterparts. Could you explain
> a bit the pros and cons on suffix vs const generic approach?

Reduce code duplication, instead of 3 different variants, we can have
one. It allows people to build ergonomic APIs that allows the user to
decide which synchronization they use under the hood.

>> - why do we need both non-return and return variants?
>>
>=20
> Historical reason I guess. Plus maybe some architectures have a better
> implementation on non-return atomics IIRC.

Could we get some more concrete arguments for why we would need these in
rust? If the reason is purely historical, then we shouldn't expose the
non-return variant IMO. If it is because of performance, then we can
only expose them in the respective arches.

---
Cheers,
Benno


