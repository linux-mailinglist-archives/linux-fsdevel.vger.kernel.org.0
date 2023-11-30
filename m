Return-Path: <linux-fsdevel+bounces-4341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50127FECF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB7F281C11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A341249EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7mpkg4F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4922D602;
	Thu, 30 Nov 2023 09:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7D7C433C8;
	Thu, 30 Nov 2023 09:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701335566;
	bh=JPV6b13s4BE9K43qIMvJGUS2I3VMsdnD+s5DD/fwO/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7mpkg4FxPcikJWcHTVEQqBK0fm1ykp+sGDB++oVKIGUlvQWrWf5oAi2/y7yU7yO9
	 BDYAivMUm1UfC5vLT8QxiQH91F6AbZarrb3NlPFA9c1NHjSpgEVYtuaa472HpWZsmy
	 NblRin+CJv3g/Sh/0ortuk2KdX98PlkkKL+b61bcpZqjV15vQ7Dgu2OavodKjvtEPO
	 hLP1t/a+lRl23inWPPsqMGkb3bpmLE+cZcJKNg08Tr5WPs8dQFKhPLY6QcP3BSeq0P
	 zCiAVujI7aDqaDvgRhDYD355QfiI1iDZ8XK3gsXSanMClLzhRJZraWy7AcC3T7Pwi0
	 QKOFo/0bdMRxA==
Date: Thu, 30 Nov 2023 10:12:38 +0100
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
Message-ID: <20231130-neuwagen-balkon-aa1b34055fec@brauner>
References: <20231129-zwiespalt-exakt-f1446d88a62a@brauner>
 <20231129165551.3476910-1-aliceryhl@google.com>
 <CAH5fLgi6n6WiueLkzvZ7ywt5hXWAJFAyseRr3O=KRAHUQ=hNrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgi6n6WiueLkzvZ7ywt5hXWAJFAyseRr3O=KRAHUQ=hNrQ@mail.gmail.com>

On Wed, Nov 29, 2023 at 06:14:24PM +0100, Alice Ryhl wrote:
> On Wed, Nov 29, 2023 at 5:55 PM Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > >> +    pub fn commit(self, file: ARef<File>) {
> > >> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
> > >> +        // guaranteed to have an owned ref count by its type invariants.
> > >> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };
> > >
> > > Why file.0.get()? Where did that come from?
> >
> > This gets a raw pointer to the C type.
> >
> > The `.0` part is a field access. `ARef` struct is a tuple struct, so its
> > fields are unnamed. However, the fields can still be accessed by index.
> 
> Oh, sorry, this is wrong. Let me try again:
> 
> This gets a raw pointer to the C type. The `.0` part accesses the
> field of type `Opaque<bindings::file>` in the Rust wrapper. Recall
> that File is defined like this:
> 
> pub struct File(Opaque<bindings::file>);
> 
> The above syntax defines a tuple struct, which means that the fields
> are unnamed. The `.0` syntax accesses the first field of a tuple
> struct [1].
> 
> The `.get()` method is from the `Opaque` struct, which returns a raw
> pointer to the C type being wrapped.

It'd be nice if this could be written in a more obvious/elegant way. And
if not a comment would help. I know there'll be more text then code but
until this is second nature to read I personally won't mind... Because
searching for this specific syntax isn't really possible.

