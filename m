Return-Path: <linux-fsdevel+bounces-5726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9C680F3E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 18:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDDE1C20C67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA787B3C1;
	Tue, 12 Dec 2023 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EtZK1xOy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC88FD0;
	Tue, 12 Dec 2023 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702400497; x=1702659697;
	bh=pW12o+ZtGJVXWSlbOsdjNFmo7Oz7+eWgJSUXDe0lDR4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EtZK1xOybz/DnTE1jmDyCKyrg45e7E5ujPmJ/I6Gq8/sgkfF+YPGE2vRrFs8ZtoJ2
	 vZIdmwNmDM6gGwaMLd6LRq6UkGPaq3Oqc0hX28EH19ciI8Udz7Hy4Gf+Y+TAjl8EbB
	 VNb4IFHRmeG4MEqUiV8tLE0dMK44YGQdFpCBomz4K/PpU7wDXsk2eyv2teS/PQvzzq
	 fMXViXI+vORmX+KlggGQWLgDa/jBQjGFulSMDx/cjiCPyzS10LSA3FJJGA6cJgTEZU
	 XK5ZHtzLGLGXarhIdlcEJ0A6QvaUFwKlZ3nxRc5gK8S5LWbYjPZ2WVDaxg7X5mIAiA
	 FIQNROXGUG1ew==
Date: Tue, 12 Dec 2023 17:01:28 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] rust: file: add abstraction for `poll_table`
Message-ID: <E-jdYd0FVvs15f_pEC0Fo6k2DByCDEQoh_Ux9P9ldmC-otCvUfQghkJOUkiAi8gDI8J47wAaDe56XYC5NiJhuohyhIklGAWMvv9v1qi6yYM=@proton.me>
In-Reply-To: <CAH5fLgiQ-7gbwP2RLoVDfDqoA+nXPboBW6eTKiv45Yam_Vjv_A@mail.gmail.com>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-7-af617c0d9d94@google.com> <k_vpgbqKAKoTFzJIBCjvgxGhX73kgkcv6w9kru78lBmTjHHvXPy05g8KxAKJ-ODARBxlZUp3a5e4F9TemGqQiskkwFCpTOhzxlvy378tjHM=@proton.me> <CAH5fLgiQ-7gbwP2RLoVDfDqoA+nXPboBW6eTKiv45Yam_Vjv_A@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/23 10:59, Alice Ryhl wrote:
> On Fri, Dec 8, 2023 at 6:53=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>> On 12/6/23 12:59, Alice Ryhl wrote:
>>> +    fn get_qproc(&self) -> bindings::poll_queue_proc {
>>> +        let ptr =3D self.0.get();
>>> +        // SAFETY: The `ptr` is valid because it originates from a ref=
erence, and the `_qproc`
>>> +        // field is not modified concurrently with this call since we =
have an immutable reference.
>>
>> This needs an invariant on `PollTable` (i.e. `self.0` is valid).
>=20
> How would you phrase it?

- `self.0` contains a valid `bindings::poll_table`.
- `self.0` is only modified via references to `Self`.

>>> +        unsafe { (*ptr)._qproc }
>>> +    }
>>> +
>>> +    /// Register this [`PollTable`] with the provided [`PollCondVar`],=
 so that it can be notified
>>> +    /// using the condition variable.
>>> +    pub fn register_wait(&mut self, file: &File, cv: &PollCondVar) {
>>> +        if let Some(qproc) =3D self.get_qproc() {
>>> +            // SAFETY: The pointers to `self` and `file` are valid bec=
ause they are references.
>>
>> What about cv.wait_list...
>=20
> I can add it to the list of things that are valid due to references.

Yes this is getting a bit tedious.

What if we create a newtype wrapping `Opaque<T>` with the invariant
that it contains a valid value? Then we could have a specially named
getter for which we would always assume that the returned pointer is
valid. And thus permit you to not mention it in the SAFETY comment?

[...]

>>> +#[pinned_drop]
>>> +impl PinnedDrop for PollCondVar {
>>> +    fn drop(self: Pin<&mut Self>) {
>>> +        // Clear anything registered using `register_wait`.
>>> +        //
>>> +        // SAFETY: The pointer points at a valid wait list.
>>
>> I was a bit confused by "wait list", since the C type is named
>> `wait_queue_head`, maybe just use the type name?
>=20
> I will update all instances of "wait list" to "wait_queue_head". It's
> because I incorrectly remembered the C type name to be "wait_list".

Maybe we should also change the name of the field on `CondVar`?

If you guys agree, I can open a good-first-issue, since it is a very
simple change.

--=20
Cheers,
Benno

