Return-Path: <linux-fsdevel+bounces-9836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAC7845485
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F711F23AFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C374DA19;
	Thu,  1 Feb 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hZBUumxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B34DA0F;
	Thu,  1 Feb 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780903; cv=none; b=rJkc5rBy+/HlLd9IX7oXL9N815ngo+aMlFHYBook9PaKpm50i2zJdzXSN/lDiP5yWovXe2BurYpjRZVgu+AG8z2HHTFVrnkomRuvWb7TSA0tI3xUJrp5LMo7tDhmVfdoIm36mmYeo4x09RvB1yNoJhTd4ah4qctG5eWIKDU0LNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780903; c=relaxed/simple;
	bh=DFghu3f7HzjWGNU0gxtFRoAFiQOsk60yFRXN1PiuSDc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1mfaf+P7csrtdDSH0+q2Iwwq+drFoxFcksSpcDYHSNmB62w+rfw3pGNGjk4khv3qQyU7IK/VpcWiA7hyVX4/GsOFFzkrC+wIJchbmwhuGyk5dYNYPYAWo7yow/lyyVHYphQ/JozOp8Rm74QMvAbB1pKEg4Gz3NusMvXr1vdmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hZBUumxT; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706780899; x=1707040099;
	bh=u9SphSZbc1p3zFepTcmXSK/skYC+oxXB4G+fAJ9cZrc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hZBUumxT1k1hPWHmwKu0MEgn4637WMREmAeVkuIACG2wyUGcYQ9lIz6YKVAZnbrAy
	 zyy+V4ptGI5LVJLEBmyxgXmL717veco5j9gps8uyl1XA5zBj0Hui5ia9GgTSAr0ihV
	 CZlO501Jq4m4HCDKAtWFGooBi74TcEamWTMWxCMhLRThPjBR3LgXfzM2cOlWRCJ7gU
	 0WPnhosSSifYK6bgOcKZaI8GGDLJP1zWSy7dDbZq3niqquJLVB+rPHlMkGQr7mZGi9
	 bftKAjif2hvoXE1k4/jYksQ5xfh46qdmUI6etEnBRgv6pQogza2FyylV2w3KbCwcPX
	 zV/3t+cNbiK6g==
Date: Thu, 01 Feb 2024 09:48:04 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] rust: file: add Rust abstraction for `struct file`
Message-ID: <038748e0-22ce-4455-ba08-e8ae30e357df@proton.me>
In-Reply-To: <CAH5fLghQAn5JYeeG0MDO-acwQHdX7CTkr_-5SzGOzrdFs2SfNw@mail.gmail.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-1-9694b6f9580c@google.com> <5dbbaba2-fd7f-4734-9f44-15d2a09b4216@proton.me> <CAH5fLghgc_z23dOR2L5vnPhVmhiKqZxR6jin9KCA5e_ii4BL3w@mail.gmail.com> <84850d04-c1cb-460d-bc4e-d5032489da0d@proton.me> <CAH5fLgioyr7NsX+-VSwbpQZtm2u9gFmSF8URHGzdSWEruRRrSQ@mail.gmail.com> <38afc0bb-8874-4847-9b44-ea929880a9ba@proton.me> <CAH5fLghQAn5JYeeG0MDO-acwQHdX7CTkr_-5SzGOzrdFs2SfNw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.02.24 10:41, Alice Ryhl wrote:
> On Thu, Feb 1, 2024 at 10:38=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 01.02.24 10:33, Alice Ryhl wrote:
>>> On Thu, Feb 1, 2024 at 10:31=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
>>>>
>>>> On 29.01.24 17:34, Alice Ryhl wrote:
>>>>> On Fri, Jan 26, 2024 at 4:04=E2=80=AFPM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
>>>>>>> +///   closed.
>>>>>>> +/// * A light refcount must be dropped before returning to userspa=
ce.
>>>>>>> +#[repr(transparent)]
>>>>>>> +pub struct File(Opaque<bindings::file>);
>>>>>>> +
>>>>>>> +// SAFETY: By design, the only way to access a `File` is via an im=
mutable reference or an `ARef`.
>>>>>>> +// This means that the only situation in which a `File` can be acc=
essed mutably is when the
>>>>>>> +// refcount drops to zero and the destructor runs. It is safe for =
that to happen on any thread, so
>>>>>>> +// it is ok for this type to be `Send`.
>>>>>>
>>>>>> Technically, `drop` is never called for `File`, since it is only use=
d
>>>>>> via `ARef<File>` which calls `dec_ref` instead. Also since it only c=
ontains
>>>>>> an `Opaque`, dropping it is a noop.
>>>>>> But what does `Send` mean for this type? Since it is used together w=
ith
>>>>>> `ARef`, being `Send` means that `File::dec_ref` can be called from a=
ny
>>>>>> thread. I think we are missing this as a safety requirement on
>>>>>> `AlwaysRefCounted`, do you agree?
>>>>>> I think the safety justification here could be (with the requirement=
 added
>>>>>> to `AlwaysRefCounted`):
>>>>>>
>>>>>>         SAFETY:
>>>>>>         - `File::drop` can be called from any thread.
>>>>>>         - `File::dec_ref` can be called from any thread.
>>>>>
>>>>> This wording was taken from rust/kernel/task.rs. I think it's out of
>>>>> scope to reword it.
>>>>
>>>> Rewording the safety docs on `AlwaysRefCounted`, yes that is out of sc=
ope,
>>>> I was just checking if you agree that the current wording is incomplet=
e.
>>>
>>> That's not what I meant. The wording of this safety comment is
>>> identical to the wording in other existing safety comments in the
>>> kernel, such as e.g. the one for `impl Send for Task`.
>>
>> Ah I see. But I still think changing it is better, since it would only g=
et
>> shorter. The comment on `Task` can be fixed later.
>> Or do you want to keep consistency here? Because I would prefer to make
>> this right and then change `Task` later.
>=20
> What would you like me to change it to?
>=20
> For example:
> // SAFETY: It is okay to send references to a File across thread boundari=
es.

That would fit better as the safety comment for `Sync`, since
it refers to "references".

For `Send` I think this would be better:
// SAFETY:
// - `File::dec_ref` can be called from any thread.
// - It is okay to send ownership of `File` across thread boundaries.

--=20
Cheers,
Benno



