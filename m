Return-Path: <linux-fsdevel+bounces-4373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668FA7FEF4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFDC281D08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDB347A48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep0gjFbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D847A58;
	Thu, 30 Nov 2023 12:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899E6C433C7;
	Thu, 30 Nov 2023 12:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701347628;
	bh=51fXWxq6Hw7XhjVhkMIm4RN54bM85K0YyitPMl6vCWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ep0gjFbrZeKdMPFrdioQYJ/GelBiEo1WtAb9TifyEqp37liL/MxNn/C6l9VWg8GWp
	 vbvQnua6tP41WQ8lwJyb6h6+t2DFtdGOZ0juP9fM869yHsfI5GsKEzl3ZFbJhTUXo3
	 oqPpV8/GenMcDeEDwzF9zvMlc3pFOCPxY+fQBeeDvEIs0n8f51xl1Lq5UeFwGYkS0A
	 XFGIj26d/KjPCNUQaUdZm1r6WZxXve1VeZSKGZkNPZNR4FImwaAprz4uTobqhHk6IN
	 7yMJEwhwcu0w/pszoWeDbvAmIQ0nP4mpSP5EM9SfRkpqPXKfAkeP9lQwBjoqXyxOt6
	 7q92Ne2ygVWZQ==
Date: Thu, 30 Nov 2023 13:33:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, a.hindborg@samsung.com,
	alex.gaynor@gmail.com, arve@android.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com,
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	maco@android.com, ojeda@kernel.org, peterz@infradead.org,
	rust-for-linux@vger.kernel.org, surenb@google.com,
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
Message-ID: <20231130-bestrafen-absieht-27dc986abc53@brauner>
References: <20231130-windungen-flogen-7b92c4013b82@brauner>
 <20231130115451.138496-1-aliceryhl@google.com>
 <nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me>

On Thu, Nov 30, 2023 at 12:17:14PM +0000, Benno Lossin wrote:
> On 30.11.23 12:54, Alice Ryhl wrote:
> > Christian Brauner <brauner@kernel.org> writes:
> >> On Thu, Nov 30, 2023 at 09:17:56AM +0000, Alice Ryhl wrote:
> >>> Christian Brauner <brauner@kernel.org> writes:
> >>>>>>> +    /// Prevent values of this type from being moved to a different task.
> >>>>>>> +    ///
> >>>>>>> +    /// This is necessary because the C FFI calls assume that `current` is set to the task that
> >>>>>>> +    /// owns the fd in question.
> >>>>>>> +    _not_send_sync: PhantomData<*mut ()>,
> >>>>>>
> >>>>>> I don't fully understand this. Can you explain in a little more detail
> >>>>>> what you mean by this and how this works?
> >>>>>
> >>>>> Yeah, so, this has to do with the Rust trait `Send` that controls
> >>>>> whether it's okay for a value to get moved from one thread to another.
> >>>>> In this case, we don't want it to be `Send` so that it can't be moved to
> >>>>> another thread, since current might be different there.
> >>>>>
> >>>>> The `Send` trait is automatically applied to structs whenever *all*
> >>>>> fields of the struct are `Send`. So to ensure that a struct is not
> >>>>> `Send`, you add a field that is not `Send`.
> >>>>>
> >>>>> The `PhantomData` type used here is a special zero-sized type.
> >>>>> Basically, it says "pretend this struct has a field of type `*mut ()`,
> >>>>> but don't actually add the field". So for the purposes of `Send`, it has
> >>>>> a non-Send field, but since its wrapped in `PhantomData`, the field is
> >>>>> not there at runtime.
> >>>>
> >>>> This probably a stupid suggestion, question. But while PhantomData gives
> >>>> the right hint of what is happening I wouldn't mind if that was very
> >>>> explicitly called NoSendTrait or just add the explanatory comment. Yes,
> >>>> that's a lot of verbiage but you'd help us a lot.
> >>>
> >>> I suppose we could add a typedef:
> >>>
> >>> type NoSendTrait = PhantomData<*mut ()>;
> >>>
> >>> and use that as the field type. The way I did it here is the "standard"
> >>> way of doing it, and if you look at code outside the kernel, you will
> >>> also find them using `PhantomData` like this. However, I don't mind
> >>> adding the typedef if you think it is helpful.
> >>
> >> I'm fine with just a comment as well. I just need to be able to read
> >> this a bit faster. I'm basically losing half a day just dealing with
> >> this patchset and that's not realistic if I want to keep up with other
> >> patches that get sent.
> >>
> >> And if you resend and someone else review you might have to answer the
> >> same question again.
> > 
> > What do you think about this wording?
> > 
> > /// Prevent values of this type from being moved to a different task.
> > ///
> > /// This field has the type `PhantomData<*mut ()>`, which does not
> > /// implement the Send trait. By adding a field with this property, we
> > /// ensure that the `FileDescriptorReservation` struct will not
> > /// implement the Send trait either. This has the consequence that the
> > /// compiler will prevent you from moving values of type
> > /// `FileDescriptorReservation` into a different task, which we want
> > /// because other tasks might have a different value of `current`. We
> > /// want to avoid that because `fd_install` assumes that the value of
> > /// `current` is unchanged since the call to `get_unused_fd_flags`.
> > ///
> > /// The `PhantomData` type has size zero, so the field does not exist at
> > /// runtime.
> > 
> > Alice
> 
> I don't think it is a good idea to add this big comment to every
> `PhantomData` field. I would much rather have a type alias:
> 
>     /// Zero-sized type to mark types not [`Send`].
>     ///
>     /// Add this type as a field to your struct if your type should not be sent to a different task.
>     /// Since [`Send`] is an auto trait, adding a single field that is [`!Send`] will ensure that the
>     /// whole type is [`!Send`].
>     ///
>     /// If a type is [`!Send`] it is impossible to give control over an instance of the type to another
>     /// task. This is useful when a type stores task-local information for example file descriptors.
>     pub type NotSend = PhantomData<*mut ()>;
> 
> If you have suggestions for improving the doc comment or the name,
> please go ahead.
> 
> This doesn't mean that there should be no comment on the `NotSend`
> field of `FileDescriptorReservation`, but I don't want to repeat
> the `Send` stuff all over the place (since it comes up a lot):
> 
>     /// Ensure that `FileDescriptorReservation` cannot be sent to a different task, since there the
>     /// value of `current` is different. We want to avoid that because `fd_install` assumes that the
>     /// value of `current` is unchanged since the call to `get_unused_fd_flags`.
>     _not_send: NotSend,

Seems sane to me. But I would suggest to move away from the "send"
terminology?

* CurrentOnly
* AccessCurrentTask vs AccessForeignTask
* NoForeignTaskAccess
* TaskLocalContext
* TaskCurrentAccess

Or some other variant thereof.

