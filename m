Return-Path: <linux-fsdevel+bounces-4678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BECE801C33
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 11:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228F11F2114B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97152156F0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Pdo79YX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052171A6;
	Sat,  2 Dec 2023 02:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701511417; x=1701770617;
	bh=ozFyIxYG1eV92CI6lLkyQ7Lh/CozJJPAZNA/ZOBz2dA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Pdo79YX+qRTRMR0IGvXzfSAgr71hSODe1JFF+1EI+szHo3hmkUFa3mkSLU1Az3+97
	 vA9aSUvN3TdpV0MfSvV300pt3EM+0B53g40Y45ERotqARuuKA2KGbhqK/r04UyVr8h
	 l4HufFJ3FkCQDaPBQM15sYfMNxs18S9dNVjqWHUDRHdUJ23uYb4oVxJdy/TaaIcdKr
	 0VHlnhu+9MyMFeicUtZVsUDKw7Wt542zMXgOls56eeYMzBigU191GWwcgsb6DOxB/i
	 C0eGxmOEQ3o9tjg6Z3XrqMSVIKJdi96PjfpsxrgU9evidyCcvfdWKNfF6XxMufiv2P
	 CHeLBsr5lhFxg==
Date: Sat, 02 Dec 2023 10:03:11 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 3/7] rust: security: add abstraction for secctx
Message-ID: <TdIzHaMBCR_0nM5Vvj7NWAG4feqbl2J7FcUgdCvXgHejuysujgtwXze0TEHNBpOWw26N4zgJzMvbfoFICQgPcmWfK4PyWl08MYIpxWuvPxE=@proton.me>
In-Reply-To: <20231201104831.2195715-1-aliceryhl@google.com>
References: <qwxqEq_l1jj3cAKSEh7gBZCUyBGCDmThdz6JJIQiFVl94ASI4yyNB6956XLrsQXnE4ulo48QRMaKPjgt7JZoolisVEiGOUP7IyRdecdhXqw=@proton.me> <20231201104831.2195715-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/1/23 11:48, Alice Ryhl wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>> On 11/29/23 14:11, Alice Ryhl wrote:
>>> +    /// Returns the bytes for this security context.
>>> +    pub fn as_bytes(&self) -> &[u8] {
>>> +        let mut ptr =3D self.secdata;
>>> +        if ptr.is_null() {
>>> +            // Many C APIs will use null pointers for strings of lengt=
h zero, but
>>
>> I would just write that the secctx API uses null pointers to denote a
>> string of length zero.
>=20
> I don't actually know whether it can ever be null, I just wanted to stay
> on the safe side.

I see, can someone from the C side confirm/refute this?

I found the comment a bit weird, since it is phrased in a general way.
If it turns out that the pointer can never be null, maybe use `NonNull`
instead (I would then also move the length check into the constructor)?
You can probably also do this if the pointer is allowed to be null,
assuming that you then do not need to call `security_release_secctx`.

>>> +            // `slice::from_raw_parts` doesn't allow the pointer to be=
 null even if the length is
>>> +            // zero. Replace the pointer with a dangling but non-null =
pointer in this case.
>>> +            debug_assert_eq!(self.seclen, 0);
>>
>> I am feeling a bit uncomfortable with this, why can't we just return
>> an empty slice in this case?
>=20
> I can do that, but to be clear, what I'm doing here is also definitely
> okay.

Yes it is okay, but I see this similar to avoiding `unsafe` code when it
can be done safely. In this example we are not strictly avoiding any
`unsafe` code, but we are avoiding a codepath with `unsafe` code. You
should of course still keep the `debug_assert_eq`.

--=20
Cheers,
Benno

