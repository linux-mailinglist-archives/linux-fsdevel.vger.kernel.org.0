Return-Path: <linux-fsdevel+bounces-4360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF27FEF3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AE0B20CCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7475F38F96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJKo8nB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660213984C;
	Thu, 30 Nov 2023 10:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0024AC433C7;
	Thu, 30 Nov 2023 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701341485;
	bh=Y4MoSY6O39Ift8abTx8Z8lmCpQSAiFIgx4bR6Skiwa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJKo8nB1AQXk6QtYFLkTPwieZ5ML5iWy502wIN/ce8cuJs2/iICs32sz7mj1bU1n3
	 0NaYA0A6WJ19Z09FYGIzz4aQRtygI7H3LyP8gUCBurnyd8+f36CvekQc6Gbg0fd8+n
	 5myFa4poG2p3b5gPWomtgtPaFUGPbI0UdY5+uRU/aBh+5pG5N+bAoIHTP+Q4o2i6py
	 5KdPYLSK2sJbekBJtjNJpQ6pbo8P7w8whUKseINrRKSxs82IfkERnot9Uj7s3AQZTO
	 IDssT1oQayf5MKifeI2Xrlr3fpp9U/inWCkl1kJM5JjVB+pmaHe8MAiq4e9I7EZoiF
	 sjAe6JsiUOVmA==
Date: Thu, 30 Nov 2023 11:51:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com,
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	maco@android.com, ojeda@kernel.org, peterz@infradead.org,
	rust-for-linux@vger.kernel.org, surenb@google.com,
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
Message-ID: <20231130-windungen-flogen-7b92c4013b82@brauner>
References: <20231130-lernziel-rennen-0a5450188276@brauner>
 <20231130091756.109655-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130091756.109655-1-aliceryhl@google.com>

On Thu, Nov 30, 2023 at 09:17:56AM +0000, Alice Ryhl wrote:
> Christian Brauner <brauner@kernel.org> writes:
> >>>> +    /// Prevent values of this type from being moved to a different task.
> >>>> +    ///
> >>>> +    /// This is necessary because the C FFI calls assume that `current` is set to the task that
> >>>> +    /// owns the fd in question.
> >>>> +    _not_send_sync: PhantomData<*mut ()>,
> >>> 
> >>> I don't fully understand this. Can you explain in a little more detail
> >>> what you mean by this and how this works?
> >> 
> >> Yeah, so, this has to do with the Rust trait `Send` that controls
> >> whether it's okay for a value to get moved from one thread to another.
> >> In this case, we don't want it to be `Send` so that it can't be moved to
> >> another thread, since current might be different there.
> >> 
> >> The `Send` trait is automatically applied to structs whenever *all*
> >> fields of the struct are `Send`. So to ensure that a struct is not
> >> `Send`, you add a field that is not `Send`.
> >> 
> >> The `PhantomData` type used here is a special zero-sized type.
> >> Basically, it says "pretend this struct has a field of type `*mut ()`,
> >> but don't actually add the field". So for the purposes of `Send`, it has
> >> a non-Send field, but since its wrapped in `PhantomData`, the field is
> >> not there at runtime.
> > 
> > This probably a stupid suggestion, question. But while PhantomData gives
> > the right hint of what is happening I wouldn't mind if that was very
> > explicitly called NoSendTrait or just add the explanatory comment. Yes,
> > that's a lot of verbiage but you'd help us a lot.
> 
> I suppose we could add a typedef:
> 
> type NoSendTrait = PhantomData<*mut ()>;
> 
> and use that as the field type. The way I did it here is the "standard"
> way of doing it, and if you look at code outside the kernel, you will
> also find them using `PhantomData` like this. However, I don't mind
> adding the typedef if you think it is helpful.

I'm fine with just a comment as well. I just need to be able to read
this a bit faster. I'm basically losing half a day just dealing with
this patchset and that's not realistic if I want to keep up with other
patches that get sent.

And if you resend and someone else review you might have to answer the
same question again.

