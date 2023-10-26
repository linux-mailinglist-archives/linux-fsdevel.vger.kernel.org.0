Return-Path: <linux-fsdevel+bounces-1226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D87D7DA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 09:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5DB281F54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1456716403;
	Thu, 26 Oct 2023 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Dlw9jrhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4807F15AC9
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 07:30:48 +0000 (UTC)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF7C184
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 00:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698305434; x=1698564634;
	bh=axyZQ/iRfA1t2iV98gW5YxAJMui6/7akQHsAayWVQLo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Dlw9jrhGm+TIaNhBsvAuXjQ6r8zYlFFwdDelakVE8u/m8HqkXbUY7MM1QNf/3UUgN
	 qszlyh0YGy3MpDpXu/xAYf34BrmpRg6PLi+BsSx54cSWi6YAJ/5hHwS7SLMnsA+0SI
	 zbENVxSQCKDKMUCDnA5+yzptWZC9cHy0Ey/munrkbKC3+TYi4Ff0cJ8J4MpPSrcVee
	 9z//tRYuRPtGLog0mMGKeJv+gV7V++KQ4KeNJysLpjkNPvgyegG4RIMsWgWHm1UqjJ
	 FjoQpiJ00aL4aqZUZ0t4vsTGArVDEL47nG+RdgIeiYJwBYngJSZYsmRbJo6Mzdhesn
	 I9Cl+hasdd/Yw==
Date: Thu, 26 Oct 2023 07:30:23 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Matthew Wilcox <willy@infradead.org>, Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] rust: types: Add read_once and write_once
Message-ID: <lScQ1U0g-cF24r7MwhNpqeVAtKcrIbGJHza4a3dsrc67qpEid8czeB3Dgs5Zd3GPIf7woFEc1EkOEdEl63qsW20lSLi8o4tefv9LI5FfLho=@proton.me>
In-Reply-To: <ZTmelWlSncdtExXp@boqun-archlinux>
References: <20231025195339.1431894-1-boqun.feng@gmail.com> <VEhpQqgTM0U-aNYRUQ89ICIHW9Eehr66yw92DrmBZcZOah2mLqlz24HxEwDwYPVDOnaigDiZDEVl5mWqZJxoAtRheqTMjzpxuTKe0sr1uZs=@proton.me> <ZTmelWlSncdtExXp@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.10.23 01:02, Boqun Feng wrote:
> On Wed, Oct 25, 2023 at 09:51:28PM +0000, Benno Lossin wrote:
>>> In theory, `read_volatile` and `write_volatile` in Rust can have UB in
>>> case of the data races [1]. However, kernel uses volatiles to implement
>>
>> I would not write "In theory", but rather state that data races involvin=
g
>> `read_volatile` is documented to still be UB.
>>
>=20
> Good point.
>=20
>>> READ_ONCE() and WRITE_ONCE(), and expects races on these marked accesse=
s
>>
>> Missing "`"?
>>
>=20
> Yeah, but these are C macros, and here is the commit log, so I wasn't so
> sure I want to add "`", but I guess it's good for consistency.

I was just wondering if it was intentional, since you did it below.

>>> don't cause UB. And they are proven to have a lot of usages in kernel.
>>>
>>> To close this gap, `read_once` and `write_once` are introduced, they
>>> have the same semantics as `READ_ONCE` and `WRITE_ONCE` especially
>>> regarding data races under the assumption that `read_volatile` and
>>
>> I would separate implementation from specification. We specify
>> `read_once` and `write_once` to have the same semantics as `READ_ONCE`
>> and `WRITE_ONCE`. But we implement them using
>> `read_volatile`/`write_volatile`, so we might still encounter UB, but it
>> is still a sort of best effort. As soon as we have the actual thing in
>> Rust, we will switch the implementation.
>>
>=20
> Sounds good, I will use this in the next version.
>=20
>>> `write_volatile` have the same behavior as a volatile pointer in C from
>>> a compiler point of view.
>>>
>>> Longer term solution is to work with Rust language side for a better wa=
y
>>> to implement `read_once` and `write_once`. But so far, it should be goo=
d
>>> enough.
>>>
>>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>>> Link: https://doc.rust-lang.org/std/ptr/fn.read_volatile.html#safety [1=
]
>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>> ---
>>>
>>> Notice I also make the primitives only work on T: Copy, since I don't
>>> think Rust side and C side will use a !Copy type to communicate, but we
>>> can always remove that constrait later.
>>>
>>>
>>>   rust/kernel/prelude.rs |  2 ++
>>>   rust/kernel/types.rs   | 43 +++++++++++++++++++++++++++++++++++++++++=
+
>>>   2 files changed, 45 insertions(+)
>>>
>>> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
>>> index ae21600970b3..351ad182bc63 100644
>>> --- a/rust/kernel/prelude.rs
>>> +++ b/rust/kernel/prelude.rs
>>> @@ -38,3 +38,5 @@
>>>   pub use super::init::{InPlaceInit, Init, PinInit};
>>>
>>>   pub use super::current;
>>> +
>>> +pub use super::types::{read_once, write_once};
>>
>> Do we really want people to use these so often that they should be in
>> the prelude?
>>
>=20
> The reason I prelude them is because that `READ_ONCE` and `WRITE_ONCE`
> have total ~7000 users in kernel, but now think about it, maybe it's
> better not.

I think we should start out with it not in the prelude. Drivers should
not need to call this often (I hope that only abstractions actually need
this).

>> Sure there will not really be any name conflicts, but I think an
>> explicit import might make sense.
>>
>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>> index d849e1979ac7..b0872f751f97 100644
>>> --- a/rust/kernel/types.rs
>>> +++ b/rust/kernel/types.rs
>>
>> I don't think this should go into `types.rs`. But I do not have a good
>> name for the new module.
>>
>=20
> kernel::sync?

I like that.

>>> @@ -432,3 +432,46 @@ pub enum Either<L, R> {
>>>       /// Constructs an instance of [`Either`] containing a value of ty=
pe `R`.
>>>       Right(R),
>>>   }
>>> +
>>> +/// (Concurrent) Primitives to interact with C side, which are conside=
red as marked access:
>>> +///
>>> +/// tools/memory-memory/Documentation/access-marking.txt
>>> +
>>
>> Accidental empty line? Or is this meant as a comment for both
>> functions?
>>
>=20
> Right, it's the documentation for both functions.

That will not work, it will just be rendered only on `read_once`.

Maybe just copy it to both and also cross link the two functions.
So `read_once` mentions the counterpart `write_once`.

>>> +/// The counter part of C `READ_ONCE()`.
>>> +///
>>> +/// The semantics is exactly the same as `READ_ONCE()`, especially whe=
n used for intentional data
>>> +/// races.
>>
>> It would be great if these semantics are either linked or spelled out
>> here. Ideally both.
>>
>=20
> Actually I haven't found any document about `READ_ONCE()` races with
> writes is not UB: we do have document saying `READ_ONCE()` will disable
> KCSAN checks, but no document says (explicitly) that it's not a UB.
>=20
>>> +///
>>> +/// # Safety
>>> +///
>>> +/// * `src` must be valid for reads.
>>> +/// * `src` must be properly aligned.
>>> +/// * `src` must point to a properly initialized value of value `T`.
>>> +#[inline(always)]
>>> +pub unsafe fn read_once<T: Copy>(src: *const T) -> T {
>>
>> Why only `T: Copy`?
>>
>=20
> I actually explained this above, after "---" of the commit log, but

Oh I missed that, sorry.

> maybe it's worth its own documentation? The reason that it only works

Yeah, lets document it. Otherwise I agree with your reasoning.

> with `T: Copy`, is that these primitives should be mostly used for
> C/Rust communication, and using a `T: !Copy` is probably wrong (or at
> least complicated) for communication, since users need to handle which
> one should be used after `read_once()`. This is in the same spirit as
> `read_volatile` documentation:
>=20
> ```
> Like read, read_volatile creates a bitwise copy of T, regardless of
> whether T is Copy. If T is not Copy, using both the returned value and
> the value at *src can violate memory safety. However, storing non-Copy
> types in volatile memory is almost certainly incorrect.
> ```
>=20
> I want to start with restrict usage.
>=20
>>> +    // SAFETY: the read is valid because of the function's safety requ=
irement, plus the assumption
>>> +    // here is that 1) a volatile pointer dereference in C and 2) a `r=
ead_volatile` in Rust have the
>>> +    // same semantics, so this function should have the same behavior =
as `READ_ONCE()` regarding
>>> +    // data races.
>>
>> I would explicitly state that we might have UB here due to data races.
>> But that we have not seen any invalid codegen and thus assume there to
>=20
> I'd rather not claim this (no invalid codegen), not because it's not
> true, but because it's not under our control. We have written doc in

But it is under our control, we pin the compiler version and can always
just check if the codegen is correct. If someone finds that it is not,
we also want to be informed, so I think we should write that we rely on
it here.

> Rust says:
>=20
> ```
> ... so the precise semantics of what =E2=80=9Cvolatile=E2=80=9D means her=
e is subject
> to change over time. That being said, the semantics will almost always
> end up pretty similar to C11=E2=80=99s definition of volatile.
> ```

But this is not a guarantee, that they behave exactly the same as C11
_now_.

--=20
Cheers,
Benno

> , so we have some confidence to say `read_volatile` equals to a volatile
> read, and `write_volatile` equals to a volatile write. Therefore, we can
> assume they have the same behaviors as `READ_ONCE()` and `WRITE_ONCE()`,
> but that's it. Going futher to talk about codegen means we have more
> guarantee from Rust compiler implementation.
>=20
> In other words, we are not saying racing `read_volatile`s don't have
> UBs, we are saying racing `read_volatile`s behave the same as a volatile
> read on UBs.

