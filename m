Return-Path: <linux-fsdevel+bounces-4590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B1D80102E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 17:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2190281867
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C464D100
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ESSodeRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE46310DF;
	Fri,  1 Dec 2023 07:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701443676; x=1701702876;
	bh=CQrld9s0aEvaSp170xsyS5XrYFnhPFO9afBIK1y6HCo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ESSodeRcWhQ69FRDO31zQsuhJ18eu49av4FlLHOs6Wa4p2y2FvTJ0fL+SrhTH5QwW
	 SHY6UJVaydogC1YiZC3ANwAhEyGOqxkxfzJ3XAtJsJh+IOEd+jyBSxLlvuONp0hDbn
	 wc0zCNMN/B8pqE2czBXysJfnN7r50wpMsCRDdc2KeEOJV/GQAWkmlQRSJ4nOF9fPm6
	 JhlVlPhvJTBlwRT/Wnm8boUfKDWb7aWRPy5MySD9VIIWj/XkBNEbvg7i0eBvmGw8U1
	 vRxATOK5aS5mylcY6bfXhHaT+ff25u7IS7IH15VDN5DlEvCsTczrREsEAoakySopEE
	 heOFaUqUgKhhQ==
Date: Fri, 01 Dec 2023 15:14:23 +0000
To: Theodore Ts'o <tytso@mit.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, david.laight@aculab.com, a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <zWaYgly6VpMZcvVUAILQWBSs9VnO7nFiAiCo4eTzT4SJEfqXY8G8w7f6az7kz9wEB4pA8EbajkQZRX4CuifI00Ce3EA_4muXjz_kfdAuzOU=@proton.me>
In-Reply-To: <20231201150442.GC509422@mit.edu>
References: <386bbdee165d47338bc451a04e788dd6@AcuMS.aculab.com> <20231201122740.2214259-1-aliceryhl@google.com> <20231201150442.GC509422@mit.edu>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/1/23 16:04, Theodore Ts'o wrote:
> On Fri, Dec 01, 2023 at 12:27:40PM +0000, Alice Ryhl wrote:
>>
>> You can import it with a use statement. For example:
>>
>> use kernel::file::flags::O_RDONLY;
>> // use as O_RDONLY
>=20
> That's good to hear, but it still means that we have to use the XYZ_*
> prefix, because otherwise, after something like
>=20
> use kernel::file::flags::RDONLY;
> use kernel::uapi::rwf::RDONLY;
>=20
> that will blow up.  So that has to be
>=20
> use kernel::file::flags::O_RDONLY;
> use kernel::uapi::rwf::RWF_RDONLY;

You can just import the `flags` and `rwf` modules (the fourth option
posted by Alice):

    use kernel::file::flags;
    use kernel::uapi::rwf;
   =20
    // usage:
   =20
    flags::O_RDONLY
   =20
    rwf::RDONLY

Alternatively if we end up with multiple flags modules you can do this
(the sixth option from Alice):

    use kernel::file::flags as file_flags;
    use kernel::foo::flags as foo_flags;

    // usage:

    file_flags::O_RDONLY

    foo_flags::O_RDONLY

--=20
Cheers,
Benno

