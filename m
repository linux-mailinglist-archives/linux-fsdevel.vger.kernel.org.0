Return-Path: <linux-fsdevel+bounces-872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1FD7D1D4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 15:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59CAB2130B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAE0101C8;
	Sat, 21 Oct 2023 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nDsloROd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEE1D311
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 13:48:51 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0AA1A8
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697896125; x=1698155325;
	bh=RVGGArVlVQOjvH8ZJNaeBXrD66txIivcjqTNXntViuw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nDsloROd8LcBEzvRSMth93Cdn5AlqMjNkCxSPTxHuc+JNXdL81lhnGcf4tdG2scbS
	 /NA3gzBP8/ntKRbal9iNPwz9RZ/R7ZHrBD4wrTa1/GKHJCwQWFDPa3hjRhf5mKWIqD
	 pegxtB3E8BHlwNfg90f+Lf7xl9JzhNERUQNZ2mIkLBIioXyqulOWZ9EDHWNjpfk1mt
	 BAEWSsYGGx4FrYSz50wBkRx4k6NtIqn2G/OEdMmHIKqYzShWWs+qZk/Z1IwsXw57Aa
	 8qN77VRBDnOTEUGhwB3dSsvgZGeTzyocZ5sn3ytyrt5198XCiu7nl2QUYUcsd4rZrZ
	 NY3AD4KEPSa3A==
Date: Sat, 21 Oct 2023 13:48:28 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Message-ID: <vT8j_VVzNv0Cx7iTO9OobT9H8zEc_I-dxmh2sF6GZWqRQ0nhjnaNZqtWPtYm37wOhwGek2vLUYwAM-jJ83AZEe8TXMDx9N6pZ3mZW1WdNNw=@proton.me>
In-Reply-To: <ZTHPOfy4dhj0x5ch@boqun-archlinux>
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-7-wedsonaf@gmail.com> <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me> <ZTHPOfy4dhj0x5ch@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.10.23 02:52, Boqun Feng wrote:
> On Thu, Oct 19, 2023 at 02:30:56PM +0000, Benno Lossin wrote:
> [...]
>>> +        let inode =3D
>>> +            ptr::NonNull::new(unsafe { bindings::iget_locked(self.0.ge=
t(), ino) }).ok_or(ENOMEM)?;
>>> +
>>> +        // SAFETY: `inode` is valid for read, but there could be concu=
rrent writers (e.g., if it's
>>> +        // an already-initialised inode), so we use `read_volatile` to=
 read its current state.
>>> +        let state =3D unsafe { ptr::read_volatile(ptr::addr_of!((*inod=
e.as_ptr()).i_state)) };
>>
>> Are you sure that `read_volatile` is sufficient for this use case? The
>> documentation [1] clearly states that concurrent write operations are st=
ill
>> UB:
>>
>>      Just like in C, whether an operation is volatile has no bearing
>>      whatsoever on questions involving concurrent access from multiple
>>      threads. Volatile accesses behave exactly like non-atomic accesses =
in
>>      that regard. In particular, a race between a read_volatile and any
>>      write operation to the same location is undefined behavior.
>>
>=20
> Right, `read_volatile` can have data race. I think what we can do here
> is:
>=20
> =09// SAFETY: `i_state` in `inode` is `unsigned long`, therefore
> =09// it's safe to treat it as `AtomicUsize` and do a relaxed read.
> =09let state =3D unsafe { *(ptr::addr_of!((*inode.as_ptr()).i_state).cast=
::<AtomicUsize>()).load(Relaxed) };

I am not sure if that is enough. What kind of writes happen
concurrently on the C side? If they are atomic, then this should
be fine, if they are not synchronized at all, then it could be
problematic, as miri says that it is still UB:
https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D2021&gi=
st=3Daa75fb6805c8d67ade8837531a2096d0

--=20
Cheers,
Benno

