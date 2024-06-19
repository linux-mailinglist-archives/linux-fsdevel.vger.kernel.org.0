Return-Path: <linux-fsdevel+bounces-21913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE1B90E68F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 11:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A77B1F2273B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7F7F7C3;
	Wed, 19 Jun 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CUTdy6Dr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F25770F5;
	Wed, 19 Jun 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788195; cv=none; b=jtVbbJwc/gXeUo92eY/hATfoffBUrrIPRBxvemjgZF3The0KYP+dFrXJDdzDay3mLtyTJk924NC5+/qt+jeGt3NKw/xre6Ch33aauafjW1DjjVIkAsWSJnQwahMYmuXNeL0AY7zv3MOFN/DcJv5V75KTKf/PbTxGN4oQ++l/dr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788195; c=relaxed/simple;
	bh=cewcQd0hHO5cIb91kEm4bQgDjhY9hlmZwAZu0cZ8QwQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWJJCGVigBvE5qSLJ6ePoAbPv6nnsSzd7NqiZjl/V4w4nrS3lnGBqOn4KvoZlqqq0Ymlf3ZWIeNqUhIz9/XM2ekHZ7sBIGcpu/vi+kOTDKy3I2qW27RMfe2+mzlaANejBMkaXLzr1yrvZodpj1LgBQ8d6E3ZWDbw7TIhNB+4Fsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CUTdy6Dr; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1718788191; x=1719047391;
	bh=eJrma/fVCMsJbBISEt95GcF83525t5S0wAsH5rZ36k4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CUTdy6DrK1LCCUqauU804s+HdcepMsEmEkFzDc7VhrbW1VA7ebQ9q62OmO6zTbcsr
	 Mv5HSJMlYqd7kYnDy6+t5m7O6IDCn0EcnxsL4sqtBuf0/hSfMUzYcCLai8J0bggoWV
	 LkR5iBetgQ1HmKWlH1LrrlQKcM9FTiiKyucXqsGishBzmxQTc8X/mEy+SnAOCjUb9i
	 mT55WX9dCsF/+FJ8IpgcLGgcCu5Q1+W4u7IuVYN9CSnXrrHg8+4RZyLfLdg1UnkNDr
	 DDvyR1NgQGMvvsq2pnbZkh4uQyhL94KCecVhxs9a9KuZzN0wKgt0wR3uhMtrlz+NL5
	 b8tMvN3mCGxEw==
Date: Wed, 19 Jun 2024 09:09:46 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <d87c75d3-9557-4a9f-8fc2-a297a945ef2e@proton.me>
In-Reply-To: <Zm8TPRK-h2mDUX0b@Boquns-Mac-mini.home>
References: <20240612223025.1158537-3-boqun.feng@gmail.com> <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me> <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home> <d67aeb8c-3499-4498-aaf9-4ac459c2f747@proton.me> <Zm7xySzPJcddF-I_@Boquns-Mac-mini.home> <f29cb2fd-651b-4bc5-8055-e3a412192e29@proton.me> <Zm8F7ZFnUFJkFGQ3@Boquns-Mac-mini.home> <0653b5d5-7a62-4baa-a500-4c110d816ba0@proton.me> <Zm8TPRK-h2mDUX0b@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b622b422e7574181dc2ed20ba243007baa44d09b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.06.24 18:30, Boqun Feng wrote:
> On Sun, Jun 16, 2024 at 03:55:12PM +0000, Benno Lossin wrote:
> [...]
>>>>
>>>> I don't think that the idea was to "do the design later". I don't even
>>>> know how you would do that, since you need the design to submit a patc=
h.
>>>>
>>>
>>> Then I might mis-understand Gary? He said:
>>>
>>> "Can we avoid two types and use a generic `Atomic<T>` and then implemen=
t
>>> on `Atomic<i32>` and `Atomic<i64>` instead?"
>>>
>>> , which means just replace `impl AtomicI32` with `impl Atomic<i32>` to
>>> me.
>>
>> This is a fair interpretation, but what prevents you from merging the
>> impls of functions that can be? I assumed that you would do that
>> automatically.
>>
>=20
> I think you missed the point, Gary's suggestion at that time sounds
> like: let's impl Atomic<i32> and Atomic<i64> first, and leave rest of
> the work for later, that is a "do the design later" to me.

Hmm, but wouldn't that just be less work for you?

>>>> I can't offer you a complete API description, since that would require
>>>> me writing it up myself. But I would recommend trying to get it to wor=
k
>>>> with generics. I got a few other comments:
>>>
>>> We should work on things that are concrete, right? It's fine that the
>>> design is not complete, and it's fine if you just recommend. But withou=
t
>>> a somewhat concrete design (doesn't have to be complete), I cannot be
>>> sure about whether we have the same vision of the future of generic
>>> atomics (see my question to Gary), that's a bit hard for me to try to
>>
>> Sorry, which question?
>=20
> =09https://lore.kernel.org/rust-for-linux/Zm7_XWe6ciy1yN-h@Boquns-Mac-min=
i.home/
>=20
>> Also to be aligned on the vision, I think we should rather talk about
>> the vision and not the design, since the design that we want to have now
>> can be different from the vision. On that note, what do you envision the
>> future of the atomic API?
>>
>=20
> Mine is simple, just providing AtomicI32 and AtomicI64 first, since
> there are immediate users right now, and should we learn more needs from
> the users, we get more idea about what a good API is, and we evolve from
> there.

That is fine, but since we want to get generics in the future anyways, I
think it would be good to already implement them now to also gather
feedback on them.

>>> work something out (plus I personally don't think it's a good idea, it'=
s
>>> OK to me, but not good). Anyway, I wasn't trying to refuse to do this
>>> just based on personal reasons, but I do need to understand what you ar=
e
>>> all proposing, because I don't have one myself.
>>
>> I went back through the thread and here is what I think your argument
>> against generics is: people should think about size and alignment when
>> using atomics, which is problematic when allowing users to leave the
>> atomic generic.
>> But as I argued before, this is not an issue. Have I overlooked another
>=20
> You mean you said it's a non-issue but gave me two counteract? If it's
> really a non-issue, you won't need a couneraction, right? In other words
> non-generic atomics do provide some value.

The second counteractions would provide exactly the same API surface as
your non-generic version, so I don't see how going non-generic provides
any value over going generic.
The first approach was intended for a future in which we are not scared
of people using generic atomics in their structs. I don't know if we are
going to be in that future, so I think we should go with the second
approach for the time being.

>> argument? Because I don't see anything else.
>>
>>>> - I don't think that we should resort to a script to generate the Rust
>>>>   code since it prevents adding good documentation & examples to the
>>>>   various methods. AFAIU you want to generate the functions from
>>>>   `scripts/atomic/atomics.tbl` to keep it in sync with the C side. I
>>>>   looked at the git log of that file and it hasn't been changed
>>>>   significantly since its inception. I don't think that there is any
>>>>   benefit to generating the functions from that file.
>>>
>>> I'll leave this to other atomic maintainers.
>>>
>>>> - most of the documented functions say "See `c_function`", I don't lik=
e
>>>>   this, can we either copy the C documentation (I imagine it not
>>>>   changing that often, or is that assumption wrong?) or write our own?
>>>
>>> You're not wrong. AN in C side, we do have some documentation template
>>> to generate the comments (see scripts/atomic/kerneldoc). But first the
>>> format is for doxygen(I guess?), and second as you just bring up, the
>>> templates are tied with the bash script.
>>
>> I see a bash script similarly to how Wedson sees proc macros ;)
>> We should try *hard* to avoid them and only use them when there is no
>> other way.
>>
>=20
> I will just start with the existing mechanism and try to evolve, whether
> it's a script or proc macro, I don't mind, I want to get the work done
> and most relevant people can understand in the way the they prefer and
> step-by-step, move it to the place I think is the best for the project.

I don't think that we need a script or a proc macro. A few declarative
macros probably suffice if we go the way of generics.

>>>> - we should try to use either const generic or normal parameters for t=
he
>>>>   access ordering instead of putting it in the function name.
>>>
>>> Why is it important? Keeping it in the current way brings the value tha=
t
>>> it's not too much different than their C counterparts. Could you explai=
n
>>> a bit the pros and cons on suffix vs const generic approach?
>>
>> Reduce code duplication, instead of 3 different variants, we can have
>> one. It allows people to build ergonomic APIs that allows the user to
>> decide which synchronization they use under the hood.
>>
>=20
> I already mentioned why I think it's good in the current way, I will
> defer it to others on their inputs.
>=20
>>>> - why do we need both non-return and return variants?
>>>>
>>>
>>> Historical reason I guess. Plus maybe some architectures have a better
>>> implementation on non-return atomics IIRC.
>>
>> Could we get some more concrete arguments for why we would need these in
>> rust? If the reason is purely historical, then we shouldn't expose the
>=20
> Sure. Look like my memory is correct, at least on ARM64 they are
> different instructions (see arch/arm64/include/asm/atomic_lse.h)
>=20
> non-return atomics on ARM64:
>=20
> =09#define ATOMIC_OP(op, asm_op)=09=09=09=09=09=09\
> =09static __always_inline void=09=09=09=09=09=09\
> =09__lse_atomic_##op(int i, atomic_t *v)=09=09=09=09=09\
> =09{=09=09=09=09=09=09=09=09=09\
> =09=09asm volatile(=09=09=09=09=09=09=09\
> =09=09__LSE_PREAMBLE=09=09=09=09=09=09=09\
> =09=09"=09" #asm_op "=09%w[i], %[v]\n"=09=09=09=09\
> =09=09: [v] "+Q" (v->counter)=09=09=09=09=09=09\
> =09=09: [i] "r" (i));=09=09=09=09=09=09=09\
> =09}
>=20
> value-return atomics on ARM64:
>=20
> =09#define ATOMIC_FETCH_OP(name, mb, op, asm_op, cl...)=09=09=09\
> =09static __always_inline int=09=09=09=09=09=09\
> =09__lse_atomic_fetch_##op##name(int i, atomic_t *v)=09=09=09\
> =09{=09=09=09=09=09=09=09=09=09\
> =09=09int old;=09=09=09=09=09=09=09\
> =09=09=09=09=09=09=09=09=09=09\
> =09=09asm volatile(=09=09=09=09=09=09=09\
> =09=09__LSE_PREAMBLE=09=09=09=09=09=09=09\
> =09=09"=09" #asm_op #mb "=09%w[i], %w[old], %[v]"=09=09=09\
> =09=09: [v] "+Q" (v->counter),=09=09=09=09=09\
> =09=09  [old] "=3Dr" (old)=09=09=09=09=09=09\
> =09=09: [i] "r" (i)=09=09=09=09=09=09=09\
> =09=09: cl);=09=09=09=09=09=09=09=09\
> =09=09=09=09=09=09=09=09=09=09\
> =09=09return old;=09=09=09=09=09=09=09\
> =09}
>=20
> It may not be easy to see the different instructions from the pasted
> code, but you can find them in the header file, also you could notice
> that the number of operands is different?

This is not my expertise, so I believe you :)

>> non-return variant IMO. If it is because of performance, then we can
>> only expose them in the respective arches.
>>
>=20
> Hmm.. so we ask user to write arch-specific code like:
>=20
> =09pub fn increase_counter(&self) {
> =09    #[cfg(CONFIG_ARM64)]
> =09    self.counter.inc();
>=20
> =09    #[cfg(CONFIG_X86_64)]
> =09    let _ =3D self.counter.inc_return();
> =09}
>=20
> are you sure it's a good idea?

No that looks horrible.

Maybe there is something that we can do with generics, but I don't know
if it is worth it. I guess we can leave that open for the time being.

---
Cheers,
Benno


