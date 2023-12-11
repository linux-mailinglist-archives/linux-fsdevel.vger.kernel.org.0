Return-Path: <linux-fsdevel+bounces-5568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E9F80DAE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 20:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EC0280DE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00AF52F9A;
	Mon, 11 Dec 2023 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RL8B0uOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37976A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 11:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=oez5vhlldzbmfa37ze5u6zgypa.protonmail; t=1702323034; x=1702582234;
	bh=ZvbWUAFMmN9CwyCE8z5cp5KvI4mt6HMigT944NpeNaI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RL8B0uOJcCwNVHWVJYyDCGgsBtdjDZAwBFEFprLad5/31BcaTZ/obv974Pnztj36e
	 WxbdXBKBnCSHR6MPXNsa1bLaHOPiPINWfbD87Uw7rcgSGJ3ehQm3G2ZaObFF9YmFGc
	 mkJialwWbEU8Gwv29hbx1KxMjRonP1sERdbEahR2vLt5J0L8DGY6apYl1K+A0Uq8vW
	 GnWt/UF9FA4ix3HUjkOSPqIx1b6L6RymbisMJ9PLKwKbjtouuj9ABmOe+wX0sZaeGZ
	 Jxe1A70SOutTmcoKdJWzIfoEUC1pIfLBd6pTzKdtJA2GJqRQMj3UUiYnUfucH2CXet
	 c8+UkybW9uocQ==
Date: Mon, 11 Dec 2023 19:30:26 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, bjorn3_gh@protonmail.com, brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH v2 2/7] rust: cred: add Rust abstraction for `struct cred`
Message-ID: <n0l18tFK7udBpF4RawU_7WctuHqpROIBs0IlBmXZTtOkwE6mCLucm27SAOlwnpUXlJpqUu0jVyVHR0_cxlYsSu7UbxjSN7kf2NXzC4UDI4U=@proton.me>
In-Reply-To: <ZXdIbEqSCTO62BHE@boqun-archlinux>
References: <ZXZjoOrO5q7no4or@boqun-archlinux> <20231211153429.4161511-1-aliceryhl@google.com> <ZXdIbEqSCTO62BHE@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/11/23 18:35, Boqun Feng wrote:
> On Mon, Dec 11, 2023 at 03:34:29PM +0000, Alice Ryhl wrote:
>> Boqun Feng <boqun.feng@gmail.com> writes:
>>> On Wed, Dec 06, 2023 at 11:59:47AM +0000, Alice Ryhl wrote:
>>> [...]
>>>> @@ -151,6 +152,21 @@ pub fn as_ptr(&self) -> *mut bindings::file {
>>>>          self.0.get()
>>>>      }
>>>>
>>>> +    /// Returns the credentials of the task that originally opened th=
e file.
>>>> +    pub fn cred(&self) -> &Credential {
>>>
>>> I wonder whether it would be helpful if we use explicit lifetime here:
>>>
>>>     pub fn cred<'file>(&'file self) -> &'file Credential
>>>
>>> It might be easier for people to get. For example, the lifetime of the
>>> returned Credential reference is constrainted by 'file, the lifetime of
>>> the file reference.
>>>
>>> But yes, maybe need to hear others' feedback first.
>>>
>>> Regards,
>>> Boqun
>>
>> That would trigger a compiler warning because the lifetime is
>> unnecessary.
>>
>=20
> We can disable that warning if people need the information. Code is
> mostly for reading, less often for compilation and changes.
>=20
>> The safety comment explains what the signature means. I think that
>> should be enough.
>>
>=20
> For someone who has a good understanding of Rust lifetime (and the
> elision), yes. But I'm wondering whether all the people feel the same
> way.

So in this example, I think it should be straight forward what happens
to the lifetimes, since there is only one to begin with.
If we want to do this, I think we should have some rules around it.

A general piece of advice I can offer is this:
- when there are no lifetimes in the return type of a function, then you
  probably do not care about the lifetimes (they will all be distinct
  and there are no relationships between them).
- when there is a single input and a single output lifetime, then
  they are the same.
- the other cases are not so simple, but most of the time they will
  require explicit annotations.

I left out some details, you can read more at [1]. Most cases where it
is not obvious which lifetime relations exist are already rejected by
the compiler. The only exception is if there is a `&self` or `&mut self`
parameter, then that one has precedence. So we could also explicitly
annotate those. Since they are also rare, I think this would be fine.


[1]: https://doc.rust-lang.org/nomicon/lifetime-elision.html

--=20
Cheers,
Benno

