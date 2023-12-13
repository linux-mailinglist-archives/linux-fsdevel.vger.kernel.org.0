Return-Path: <linux-fsdevel+bounces-5820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EEA810D16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42DE2814AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2221EB5C;
	Wed, 13 Dec 2023 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TNE8211i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0104BAD;
	Wed, 13 Dec 2023 01:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702458773; x=1702717973;
	bh=MEAwN2FYlBpSwYoH9a2PEuQpzLdTwET0cZNUdnLD5cQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TNE8211i36nwjpY1JK6pg5ubksVz22Xteuzh7eG3Dx6D16cLt/98MFjBnFFh0TYDI
	 u88OAAePGhRGa1h2qs7ZKQT72O/Psf9cAk/QNwVGPO1Kx/6qw4FYvta40OW/JXdijc
	 IPFVOXjaJO1vn9+28PLVCW4oMrgQAh4kiNIjKNgIBkL9kQUPb0b7IMukn1nRU3zxE9
	 NjMx1ToEuUf5AoW56NP9I8bh8QZ1CM2Ti7r4cKaFC1dYWPzF+/OTaQtGMAhDh8FPWZ
	 0pkNK965rJf6+yPB2kv7avltEGgYoMJQzna+9Fc/i8GGszfqGnjoe969P9ZBNyPKJ9
	 XatbtEdnyTAig==
Date: Wed, 13 Dec 2023 09:12:45 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] rust: file: add abstraction for `poll_table`
Message-ID: <pxtBsqlawLf52Escu7kGkCv1iEorWkE4-g8Ke_IshhejEYz5zZGGX5q98hYtU_YGubwk770ufUezNXFB_GJFMnZno5G7OGuF2oPAOoVAGgc=@proton.me>
In-Reply-To: <ZXkKTSTCuQMt2ge6@boqun-archlinux>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-7-af617c0d9d94@google.com> <k_vpgbqKAKoTFzJIBCjvgxGhX73kgkcv6w9kru78lBmTjHHvXPy05g8KxAKJ-ODARBxlZUp3a5e4F9TemGqQiskkwFCpTOhzxlvy378tjHM=@proton.me> <CAH5fLgiQ-7gbwP2RLoVDfDqoA+nXPboBW6eTKiv45Yam_Vjv_A@mail.gmail.com> <E-jdYd0FVvs15f_pEC0Fo6k2DByCDEQoh_Ux9P9ldmC-otCvUfQghkJOUkiAi8gDI8J47wAaDe56XYC5NiJhuohyhIklGAWMvv9v1qi6yYM=@proton.me> <ZXkKTSTCuQMt2ge6@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/13/23 02:35, Boqun Feng wrote:
> On Tue, Dec 12, 2023 at 05:01:28PM +0000, Benno Lossin wrote:
>> On 12/12/23 10:59, Alice Ryhl wrote:
>>> On Fri, Dec 8, 2023 at 6:53=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>>> On 12/6/23 12:59, Alice Ryhl wrote:
>>>>> +    fn get_qproc(&self) -> bindings::poll_queue_proc {
>>>>> +        let ptr =3D self.0.get();
>>>>> +        // SAFETY: The `ptr` is valid because it originates from a r=
eference, and the `_qproc`
>>>>> +        // field is not modified concurrently with this call since w=
e have an immutable reference.
>>>>
>>>> This needs an invariant on `PollTable` (i.e. `self.0` is valid).
>>>
>>> How would you phrase it?
>>
>> - `self.0` contains a valid `bindings::poll_table`.
>> - `self.0` is only modified via references to `Self`.
>>
>>>>> +        unsafe { (*ptr)._qproc }
>>>>> +    }
>>>>> +
>>>>> +    /// Register this [`PollTable`] with the provided [`PollCondVar`=
], so that it can be notified
>>>>> +    /// using the condition variable.
>>>>> +    pub fn register_wait(&mut self, file: &File, cv: &PollCondVar) {
>>>>> +        if let Some(qproc) =3D self.get_qproc() {
>>>>> +            // SAFETY: The pointers to `self` and `file` are valid b=
ecause they are references.
>>>>
>>>> What about cv.wait_list...
>>>
>>> I can add it to the list of things that are valid due to references.
>>
>=20
> Actually, there is an implied safety requirement here, it's about how
> qproc is implemented. As we can see, PollCondVar::drop() will wait for a
> RCU grace period, that means the waiter (a file or something) has to use
> RCU to access the cv.wait_list, otherwise, the synchronize_rcu() in
> PollCondVar::drop() won't help.

Good catch, this is rather important. I did not find the implementation
of `qproc`, since it is a function pointer. Since this pattern is
common, what is the way to find the implementation of those in general?

I imagine that the pattern is used to enable dynamic selection of the
concrete implementation, but there must be some general specification of
what the function does, is this documented somewhere?

> To phrase it, it's more like:
>=20
> (in the safety requirement of `PollTable::from_ptr` and the type
> invariant of `PollTable`):
>=20
> ", further, if the qproc function in poll_table publishs the pointer of
> the wait_queue_head, it must publish it in a way that reads on the
> published pointer have to be in an RCU read-side critical section."

What do you mean by `publish`?

> and here we can said,
>=20
> "per type invariant, `qproc` cannot publish `cv.wait_list` without
> proper RCU protection, so it's safe to use `cv.wait_list` here, and with
> the synchronize_rcu() in PollCondVar::drop(), free of the wait_list will
> be delayed until all usages are done."

I think I am missing how the call to `__wake_up_pollfree` ensures that
nobody uses the `PollCondVar` any longer. How is it removed from the
table?

--=20
Cheers,
Benno

> I know, this is quite verbose, but just imagine some one removes the
> rcu_read_lock() and rcu_read_unlock() in ep_remove_wait_queue(), the
> poll table from epoll (using ep_ptable_queue_proc()) is still valid one
> according to the current safety requirement, but now there is a
> use-after-free in the following case:
>=20
> =09CPU 0                        CPU1
> =09                             ep_remove_wait_queue():
> =09=09=09=09       struct wait_queue_head *whead;
> =09                               whead =3D smp_load_acquire(...);
> =09                               if (whead) { // not null
> =09PollCondVar::drop():
> =09  __wake_pollfree();
> =09  synchronize_rcu(); // no current RCU readers, yay.
> =09  <free the wait_queue_head>
> =09                                 remove_wait_queue(whead, ...); // BOO=
M, use-after-free

