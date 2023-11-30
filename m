Return-Path: <linux-fsdevel+bounces-4370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8A27FEF4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F8DB20A26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE047795
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="k6ULomu+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A4E10CE;
	Thu, 30 Nov 2023 04:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701346639; x=1701605839;
	bh=dlgoIC/cWlhFA8U/2kxuaUxiujj/QS0YBwzrP3FBLaI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=k6ULomu+kgyTAuukqBhyciOebVjjGZaMvKMo1C8smeeSSoLuPMkTudT4SPqHdzZhb
	 uXYxQ+0d2qNku34cK8jD1/whBNndv+QgyP3RKVg7Dg6c/ZOSVx9PphH73jLDer3KdY
	 508UOnAwQGMxSm48M8FJj1RHHwtxx8UEEYXoLvcmrPgzhJA4b+q2P5Dei+0neQtoZm
	 gPOnF+0u1SsuRyAG3vy8+PMwXxQls5Wq+Q7zvS9FdMLs7mgUd97eYRFuxS2xUzBVJ3
	 3JaQWy9wFsaV1SefC6RRDtmViVTWhuHT81LKHAZlszCYV53SscxDC3QhxcWRYePsZJ
	 CYOjyn1Dn/ABQ==
Date: Thu, 30 Nov 2023 12:17:14 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: brauner@kernel.org, a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
Message-ID: <nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me>
In-Reply-To: <20231130115451.138496-1-aliceryhl@google.com>
References: <20231130-windungen-flogen-7b92c4013b82@brauner> <20231130115451.138496-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.11.23 12:54, Alice Ryhl wrote:
> Christian Brauner <brauner@kernel.org> writes:
>> On Thu, Nov 30, 2023 at 09:17:56AM +0000, Alice Ryhl wrote:
>>> Christian Brauner <brauner@kernel.org> writes:
>>>>>>> +    /// Prevent values of this type from being moved to a differen=
t task.
>>>>>>> +    ///
>>>>>>> +    /// This is necessary because the C FFI calls assume that `cur=
rent` is set to the task that
>>>>>>> +    /// owns the fd in question.
>>>>>>> +    _not_send_sync: PhantomData<*mut ()>,
>>>>>>
>>>>>> I don't fully understand this. Can you explain in a little more deta=
il
>>>>>> what you mean by this and how this works?
>>>>>
>>>>> Yeah, so, this has to do with the Rust trait `Send` that controls
>>>>> whether it's okay for a value to get moved from one thread to another=
.
>>>>> In this case, we don't want it to be `Send` so that it can't be moved=
 to
>>>>> another thread, since current might be different there.
>>>>>
>>>>> The `Send` trait is automatically applied to structs whenever *all*
>>>>> fields of the struct are `Send`. So to ensure that a struct is not
>>>>> `Send`, you add a field that is not `Send`.
>>>>>
>>>>> The `PhantomData` type used here is a special zero-sized type.
>>>>> Basically, it says "pretend this struct has a field of type `*mut ()`=
,
>>>>> but don't actually add the field". So for the purposes of `Send`, it =
has
>>>>> a non-Send field, but since its wrapped in `PhantomData`, the field i=
s
>>>>> not there at runtime.
>>>>
>>>> This probably a stupid suggestion, question. But while PhantomData giv=
es
>>>> the right hint of what is happening I wouldn't mind if that was very
>>>> explicitly called NoSendTrait or just add the explanatory comment. Yes=
,
>>>> that's a lot of verbiage but you'd help us a lot.
>>>
>>> I suppose we could add a typedef:
>>>
>>> type NoSendTrait =3D PhantomData<*mut ()>;
>>>
>>> and use that as the field type. The way I did it here is the "standard"
>>> way of doing it, and if you look at code outside the kernel, you will
>>> also find them using `PhantomData` like this. However, I don't mind
>>> adding the typedef if you think it is helpful.
>>
>> I'm fine with just a comment as well. I just need to be able to read
>> this a bit faster. I'm basically losing half a day just dealing with
>> this patchset and that's not realistic if I want to keep up with other
>> patches that get sent.
>>
>> And if you resend and someone else review you might have to answer the
>> same question again.
>=20
> What do you think about this wording?
>=20
> /// Prevent values of this type from being moved to a different task.
> ///
> /// This field has the type `PhantomData<*mut ()>`, which does not
> /// implement the Send trait. By adding a field with this property, we
> /// ensure that the `FileDescriptorReservation` struct will not
> /// implement the Send trait either. This has the consequence that the
> /// compiler will prevent you from moving values of type
> /// `FileDescriptorReservation` into a different task, which we want
> /// because other tasks might have a different value of `current`. We
> /// want to avoid that because `fd_install` assumes that the value of
> /// `current` is unchanged since the call to `get_unused_fd_flags`.
> ///
> /// The `PhantomData` type has size zero, so the field does not exist at
> /// runtime.
>=20
> Alice

I don't think it is a good idea to add this big comment to every
`PhantomData` field. I would much rather have a type alias:

    /// Zero-sized type to mark types not [`Send`].
    ///
    /// Add this type as a field to your struct if your type should not be =
sent to a different task.
    /// Since [`Send`] is an auto trait, adding a single field that is [`!S=
end`] will ensure that the
    /// whole type is [`!Send`].
    ///
    /// If a type is [`!Send`] it is impossible to give control over an ins=
tance of the type to another
    /// task. This is useful when a type stores task-local information for =
example file descriptors.
    pub type NotSend =3D PhantomData<*mut ()>;

If you have suggestions for improving the doc comment or the name,
please go ahead.

This doesn't mean that there should be no comment on the `NotSend`
field of `FileDescriptorReservation`, but I don't want to repeat
the `Send` stuff all over the place (since it comes up a lot):

    /// Ensure that `FileDescriptorReservation` cannot be sent to a differe=
nt task, since there the
    /// value of `current` is different. We want to avoid that because `fd_=
install` assumes that the
    /// value of `current` is unchanged since the call to `get_unused_fd_fl=
ags`.
    _not_send: NotSend,

--=20
Cheers,
Benno

