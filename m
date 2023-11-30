Return-Path: <linux-fsdevel+bounces-4361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE17FEF40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12A01C203A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9DF45BFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxgq+smu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F90250F8;
	Thu, 30 Nov 2023 10:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7729C433C7;
	Thu, 30 Nov 2023 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701341588;
	bh=8XkaVRCmO2JrQF4/dXotopuTsQp9i+OgT5+rIs7i4Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nxgq+smu5i9vrVSHRNyc4tSnnk1V+SQBcysfec0SgCiyBnnZiKxpVG/yENQAGdJHS
	 P0q9pkQAc1X8rRKYv/JLNR5EDc/mQXLUp+U6IaF1oI32BXTNRgo048TE8o7dY+8Oe7
	 OOYs9gagAX88y/maW+iiG9baEcJWSbGf5ouOq7Thf0Epn8Rr8lOMoPQv2dyMjrVDY6
	 rDBmjYCyUVtM9jnAB7t8BG63/q6HrfRVikfqjUVEZHmXbEEOazWx6yali03PuUE4Mo
	 cluCgiEauUfrj6iM/fyEGAth/qfmFIpsXFA0k5JPUw/HWtjPPMmGnIr4kp/odUrS3n
	 NNNzR8mFh3wHw==
Date: Thu, 30 Nov 2023 11:52:59 +0100
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
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231130-neuordnung-matetee-7aefa024f80b@brauner>
References: <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231130093603.113036-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130093603.113036-1-aliceryhl@google.com>

On Thu, Nov 30, 2023 at 09:36:03AM +0000, Alice Ryhl wrote:
> Christian Brauner <brauner@kernel.org> writes:
> > I'm a bit puzzled by all these rust_helper_*() calls. Can you explain
> > why they are needed? Because they are/can be static inlines and that
> > somehow doesn't work?
> 
> Yes, it's because the methods are inline. Rust can only call C methods
> that are actually exported by the C code.
> 
> >> +    /// Converts this kernel UID into a UID that userspace understands. Uses the namespace of the
> >> +    /// current task.
> >> +    pub fn into_uid_in_current_ns(self) -> bindings::uid_t {
> > 
> > Hm, I wouldn't special-case this. Just expose from_kuid() and let it
> > take a namespace argument, no? You don't need to provide bindings for
> > namespaces ofc.
> 
> To make `from_kuid` safe, I would need to wrap the namespace type too. I
> could do that, but it would be more code than this method because I need
> another wrapper struct and so on.
> 
> Personally I would prefer to special-case it until someone needs the
> non-special-case. Then, they can delete this method when they introduce
> the non-special-case.
> 
> But I'll do it if you think I should.

No, don't start wrapping namespaces as well. You already do parts of LSM
as well.

> 
> >> +impl PartialEq for Kuid {
> >> +    fn eq(&self, other: &Kuid) -> bool {
> >> +        // SAFETY: Just an FFI call.
> >> +        unsafe { bindings::uid_eq(self.kuid, other.kuid) }
> >> +    }
> >> +}
> >> +
> >> +impl Eq for Kuid {}
> > 
> > Do you need that?
> 
> Yes. This is the code that tells the compiler what `==` means for the
> `Kuid` type. Binder uses it here:

Ok, thanks.

