Return-Path: <linux-fsdevel+bounces-5725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBA180F38D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 17:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25871F210A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E9C7A23E;
	Tue, 12 Dec 2023 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Jp8ET7bH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E0A6;
	Tue, 12 Dec 2023 08:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702399860; x=1702659060;
	bh=w38LyRHLZtbV6MXFwYHgJYUkLwMl4DKzg/6P9akEIm8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Jp8ET7bH3aUWWYk2XtraWwxkt6VOsNoTE6yTzBkO/5qlf8Uz7N1EHWsm6NaW0dL34
	 6oSR5bu1enkU96x+sMJJNGD1qmYW/04YQIGibnzU67r8PcDR8IHWGvfejHQ0o9w4ub
	 jKwJFBS7GtZscegHd4KGpVr2YDCPFUpV0R6e2Xj2UKh+qX2iRlsaP/nxolfneYK5hR
	 KrRnoGDXDS/3jpnhYWaqpKCS82I1UNUG5plAcmWZW3n2q/5aRUHYcoUd+9UYINGzM2
	 3miwsR87An1DUJgbf8yedooNSmwy2Lcn+KxifYodaS21XxJbGCWOboZmPwDfD/iuGg
	 l/Eg9bptUz9Zg==
Date: Tue, 12 Dec 2023 16:50:53 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH v2 6/7] rust: file: add `DeferredFdCloser`
Message-ID: <8idgiXA3NzJ1zv5FQ4UVhObREsn81yb7T_M6Z44-Mc0-Rta_Q_jmOAkmDCwLKgE221TtMmFiebz0Q8WJPhy4WpngTiTc5dxwg6qIffueYmY=@proton.me>
In-Reply-To: <CAH5fLggB_33jR1eyXSFhN=DN34wD7E6-ckSU8ABmQ50H-L3P-w@mail.gmail.com>
References: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me> <20231211153440.4162899-1-aliceryhl@google.com> <DNn_nN0MKmn9OoY7Gjn4fCUcwKD6ijDZyDXVHvouEa2w0o2yiXeRox3EUfAcbfoWqx0I24-8HqqzONjuTQIVxu2cfAoNQpUFJygPtQNXPM4=@proton.me> <CAH5fLggB_33jR1eyXSFhN=DN34wD7E6-ckSU8ABmQ50H-L3P-w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/23 10:35, Alice Ryhl wrote:
> On Mon, Dec 11, 2023 at 6:23=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>>>>> +        // We update the file pointer that the task work is supposed=
 to fput.
>>>>> +        //
>>>>> +        // SAFETY: Task works are executed on the current thread onc=
e we return to userspace, so
>>>>> +        // this write is guaranteed to happen before `do_close_fd` i=
s called, which means that a
>>>>> +        // race is not possible here.
>>>>> +        //
>>>>> +        // It's okay to pass this pointer to the task work, since we=
 just acquired a refcount with
>>>>> +        // the previous call to `get_file`. Furthermore, the refcoun=
t will not drop to zero during
>>>>> +        // an `fdget` call, since we defer the `fput` until after re=
turning to userspace.
>>>>> +        unsafe { *file_field =3D file };
>>>>
>>>> A synchronization question: who guarantees that this write is actually
>>>> available to the cpu that executes `do_close_fd`? Is there some
>>>> synchronization run when returning to userspace?
>>>
>>> It's on the same thread, so it's just a sequenced-before relation.
>>>
>>> It's not like an interrupt. It runs after the syscall invocation has
>>> exited, but before it does the actual return-to-userspace stuff.
>>
>> Reasonable, can you also put this in a comment?
>=20
> What do you want me to add? I already say that it will be executed on
> the same thread.

Seems I missed that, then no need to add anything.

>>>>> +/// Represents a failure to close an fd in a deferred manner.
>>>>> +#[derive(Copy, Clone, Eq, PartialEq)]
>>>>> +pub enum DeferredFdCloseError {
>>>>> +    /// Closing the fd failed because we were unable to schedule a t=
ask work.
>>>>> +    TaskWorkUnavailable,
>>>>> +    /// Closing the fd failed because the fd does not exist.
>>>>> +    BadFd,
>>>>> +}
>>>>> +
>>>>> +impl From<DeferredFdCloseError> for Error {
>>>>> +    fn from(err: DeferredFdCloseError) -> Error {
>>>>> +        match err {
>>>>> +            DeferredFdCloseError::TaskWorkUnavailable =3D> ESRCH,
>>>>
>>>> This error reads "No such process", I am not sure if that is the best
>>>> way to express the problem in that situation. I took a quick look at t=
he
>>>> other error codes, but could not find a better fit. Do you have any
>>>> better ideas? Or is this the error that C binder uses?
>>>
>>> This is the error code that task_work_add returns. (It can't happen in
>>> Binder.)
>>>
>>> And I do think that it is a reasonable choice, because the error only
>>> happens if you're calling the method from a context that has no
>>> userspace process associated with it.
>>
>> I see.
>>
>> What do you think of making the Rust error more descriptive? So instead
>> of implementing `Debug` like you currently do, you print
>>
>>     $error ($variant)
>>
>> where $error =3D Error::from(*self) and $variant is the name of the
>> variant?
>>
>> This is more of a general suggestion, I don't think that this error type
>> in particular warrants this. But in general with Rust we do have the
>> option to have good error messages for every error while maintaining
>> efficient error values.
>=20
> I can #[derive(Debug)] instead, I guess?

Hmm I thought that might not be ideal, since then you would not have the
error code, only `TaskWorkUnavailable` or `BadFd`.
But if that is also acceptable, then I would go with the derived debug.

--=20
Cheers,
Benno


