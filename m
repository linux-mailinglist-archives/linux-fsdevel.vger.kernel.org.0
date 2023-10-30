Return-Path: <linux-fsdevel+bounces-1527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8BC7DB506
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 09:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8C61C20A71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBACD26C;
	Mon, 30 Oct 2023 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I7gJn1G+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B2D27A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 08:21:29 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C166B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=jrmnpnmyqvcb3ipaajjxsfef54.protonmail; t=1698654082; x=1698913282;
	bh=ecIJyYrbZM2RfM1hkjnhx0W3o9KwdDqY6+ZLK4zmkp4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=I7gJn1G+Q0FRJDQi0VGsEDUQBlhsepzTsCU8hAr3EycHCWpwQviy08GYQjJb+mFL5
	 1x6CT/Xcdkpnms9snhO9J6iioUtDFLzK5tDPH25pMPC5mDr3y4CvH7gMNQpyXIIXJl
	 9AtwD7ERKQW6594wPcI8TXo7zwiXiVARsnb+sKJ9/wUeopSk4J0CHWu1nlIuyZZBDT
	 xzqVMnBEdJmF8me0AV8AgI52Ofq4RnTW7+9AHWR/makNEeyAdyDEl48M7Ago/5y+wR
	 F52+RDU4wdIjByWgxXP9R5M7Y7r/3D1Yhcjp3ErkdnOXg2fntaYdw8Uotz6f/FsZmL
	 K1tF1c1bQ3Vxw==
Date: Mon, 30 Oct 2023 08:21:04 +0000
To: Alice Ryhl <alice@ryhl.io>, Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 04/19] rust: fs: introduce `FileSystem::super_params`
Message-ID: <5479e7c1-6616-4930-b33c-0075772c266e@proton.me>
In-Reply-To: <4b19dd7d-b946-4a5c-8746-f7e9c2f55d25@ryhl.io>
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-5-wedsonaf@gmail.com> <E5dn4WQzlLvA0snHR_r_i2h1IPRjiiTIwssBSR403Rda6JA2Fgd-7lOonQQ6Oz1DMqp45cvtDfyW0JwRFgSZurzvtXIk3KGNhtSBqvvBnF0=@proton.me> <4b19dd7d-b946-4a5c-8746-f7e9c2f55d25@ryhl.io>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.10.23 18:39, Alice Ryhl wrote:
> On 10/18/23 18:34, Benno Lossin wrote:>> +        from_result(|| {
>>> +            // SAFETY: The C callback API guarantees that `fc_ptr` is =
valid.
>>> +            let fc =3D unsafe { &mut *fc_ptr };
>>
>> This safety comment is not enough, the pointer needs to be unique and
>> pointing to a valid value for this to be ok. I would recommend to do
>> this instead:
>>
>>       unsafe { addr_of_mut!((*fc_ptr).ops).write(&Tables::<T>::CONTEXT) =
};
>=20
> It doesn't really need to be unique. Or at least, that wording gives the
> wrong intuition even if it's technically correct when you use the right
> definition of "unique".
>=20
> To clarify what I mean: Using `ptr::write` on a raw pointer is valid if
> and only if creating a mutable reference and using that to write is
> valid. (Assuming the type has no destructor.)

I tried looking in the nomicon and UCG, but was not able to find this
statement, where is it from?

> Of course, in this case you *also* have the difference of whether you
> create a mutable to the entire struct or just the field.
>>> +                // SAFETY: This is a newly-created inode. No other ref=
erences to it exist, so it is
>>> +                // safe to mutably dereference it.
>>> +                let inode =3D unsafe { &mut *inode };
>>
>> The inode also needs to be initialized and have valid values as its fiel=
ds.
>> Not sure if this is kept and it would probably be better to keep using r=
aw
>> pointers here.
>=20
> My understanding is that this is just a safety invariant, and not a
> validity invariant, so as long as the uninitialized memory is not read,
> it's fine.
>=20
> See e.g.:
> https://github.com/rust-lang/unsafe-code-guidelines/issues/346

I'm not so sure that that discussion is finished and agreed upon. The
nomicon still writes "It is illegal to construct a reference to
uninitialized data" [1].

Using this pattern (&mut uninit to initialize data) is also dangerous
if the underlying type has drop impls, since then by doing
`foo.bar =3D baz;` you drop the old uninitialized value. Sure in
our bindings there are no types that implement drop (AFAIK) so
it is less of an issue.

If we decide to do this, we should have a comment that explains that
this reference might point to uninitialized memory. Since otherwise
it might be easy to give the reference to another safe function that
then e.g. reads a bool.

[1]: https://doc.rust-lang.org/nomicon/unchecked-uninit.html

--=20
Cheers,
Benno



