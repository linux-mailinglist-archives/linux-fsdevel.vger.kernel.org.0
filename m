Return-Path: <linux-fsdevel+bounces-9830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E784543D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5512B25102
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F314DA1B;
	Thu,  1 Feb 2024 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KYnEaCgL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9204D9E3;
	Thu,  1 Feb 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780310; cv=none; b=HsRglmzHhAyfjb+JvJAXW66HkTwtobq9pnt5BKzM2YeItA6U+VB1jci6uPng2VOhqtsoOMdQI9BDEH6DNI/EkvYPEFjeVphUq71hotvvEADI0Y07aNOOyN6RxyhXhd+tA9s5QP+4DYNrhuxhvxtz9Z6UMfPK1+WaLxC5d0tEGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780310; c=relaxed/simple;
	bh=6lwo5mHkqU86wnmQyHk4p9ijbfTpZMXDy9cRvEQb22E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jbjg5/v4K49BSHZfG5BLqIXCuZ8lEW4Vw0IBLK0mE2yOD2DTrZ6A8scrg9BuSIPG++ulDIywdOtGE8UdFu0ClPw3ebHz0WWJxZbdZkBt8IRTB6Tu7VT7qqYXI36Q2DEneJmCwKcoJoImmwY8UDaOAGbT82xYDzQN1MoPeKzWftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KYnEaCgL; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706780306; x=1707039506;
	bh=1FStN9/C374bnafIEvUZ7Cpc0dKu4duK0n7lhMP+VYU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KYnEaCgLAdUiq++OxJfmF37wIbraSL489oPCIVTPysr4oRamyzkGO6VLZr5XC1Ofv
	 +cC/z15kU9mDndCuP42WyDL9iDxHO2uoUETfoKHiA4MeJ1XjEBzWspA2vx7VRmdcOV
	 7oGlq++970t/81q627ScB7mstRvHuYtm+ZdNxRdMPeqr4x3nIprC7aaoNJR9kNMYA4
	 4OhruoY7a0LXQJbokCfgWztbQNWkS8zw2npfuQ1trk12o5VOiRJuu+Rkkt2AaDUn4D
	 Q0WM2Mq945vxmT43mLIFBmQfKXlw1Br7y23IYKmtqbmaDkox2OtLm56T7M0a+f1SO5
	 8g2ByeZOfOdJA==
Date: Thu, 01 Feb 2024 09:38:13 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] rust: file: add Rust abstraction for `struct file`
Message-ID: <38afc0bb-8874-4847-9b44-ea929880a9ba@proton.me>
In-Reply-To: <CAH5fLgioyr7NsX+-VSwbpQZtm2u9gFmSF8URHGzdSWEruRRrSQ@mail.gmail.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-1-9694b6f9580c@google.com> <5dbbaba2-fd7f-4734-9f44-15d2a09b4216@proton.me> <CAH5fLghgc_z23dOR2L5vnPhVmhiKqZxR6jin9KCA5e_ii4BL3w@mail.gmail.com> <84850d04-c1cb-460d-bc4e-d5032489da0d@proton.me> <CAH5fLgioyr7NsX+-VSwbpQZtm2u9gFmSF8URHGzdSWEruRRrSQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.02.24 10:33, Alice Ryhl wrote:
> On Thu, Feb 1, 2024 at 10:31=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 29.01.24 17:34, Alice Ryhl wrote:
>>> On Fri, Jan 26, 2024 at 4:04=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
>>>>> +///   closed.
>>>>> +/// * A light refcount must be dropped before returning to userspace=
.
>>>>> +#[repr(transparent)]
>>>>> +pub struct File(Opaque<bindings::file>);
>>>>> +
>>>>> +// SAFETY: By design, the only way to access a `File` is via an immu=
table reference or an `ARef`.
>>>>> +// This means that the only situation in which a `File` can be acces=
sed mutably is when the
>>>>> +// refcount drops to zero and the destructor runs. It is safe for th=
at to happen on any thread, so
>>>>> +// it is ok for this type to be `Send`.
>>>>
>>>> Technically, `drop` is never called for `File`, since it is only used
>>>> via `ARef<File>` which calls `dec_ref` instead. Also since it only con=
tains
>>>> an `Opaque`, dropping it is a noop.
>>>> But what does `Send` mean for this type? Since it is used together wit=
h
>>>> `ARef`, being `Send` means that `File::dec_ref` can be called from any
>>>> thread. I think we are missing this as a safety requirement on
>>>> `AlwaysRefCounted`, do you agree?
>>>> I think the safety justification here could be (with the requirement a=
dded
>>>> to `AlwaysRefCounted`):
>>>>
>>>>        SAFETY:
>>>>        - `File::drop` can be called from any thread.
>>>>        - `File::dec_ref` can be called from any thread.
>>>
>>> This wording was taken from rust/kernel/task.rs. I think it's out of
>>> scope to reword it.
>>
>> Rewording the safety docs on `AlwaysRefCounted`, yes that is out of scop=
e,
>> I was just checking if you agree that the current wording is incomplete.
>=20
> That's not what I meant. The wording of this safety comment is
> identical to the wording in other existing safety comments in the
> kernel, such as e.g. the one for `impl Send for Task`.

Ah I see. But I still think changing it is better, since it would only get
shorter. The comment on `Task` can be fixed later.
Or do you want to keep consistency here? Because I would prefer to make
this right and then change `Task` later.

--=20
Cheers,
Benno

>>> Besides, it says "destructor runs", not "drop runs". The destructor
>>> can be interpreted to mean the right thing for ARef.
>>
>> To me "destructor runs" and "drop runs" are synonyms.
>>
>>> The right safety comment would probably be that dec_ref can be called
>>> from any thread.
>>
>> Yes and no, I would prefer if you could remove the "By design, ..."
>> part and only focus on `dec_ref` being callable from any thread and
>> it being ok to send a `File` to a different thread.


