Return-Path: <linux-fsdevel+bounces-20413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41FD8D30FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 10:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7F81C20B83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CEC174EE3;
	Wed, 29 May 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+XxuPtV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844AC168C3D;
	Wed, 29 May 2024 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970667; cv=none; b=P9RrUU+UWJ7TZw/ZT3pywBA3SvEmOF7iAKkYLwxA7RNnINmuNaIeQpXIWyCcvXzPVrpxuPBco+C8/07WtgoqlIBA3clt1t8vRk6meBUKjuq2PWbXJFB7KZn1kzqjkJsz3Frr5JR5BFTst9sixfONoIfU4MI35i+6H/8Yip+auas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970667; c=relaxed/simple;
	bh=aex72zuj9Ceu5xpqhciQKKCLeAJCuCEnMMtr7+earFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6pVAH4vVFNoRYhiMHPrILPsEoTAdJNVo2lXtSrUB8SueQAxfxtkhk7UxnUV88DiSbN+EY/9hMNLIuZLfQc0/VPVEWsdX72WS37XmWD1WNpYdqKQOrcCZZPskH7+gt1OYumJS+MEEJ9kOEuTvrYkD0cvwDwtWQjJUhZqieWV6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+XxuPtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B7EC32786;
	Wed, 29 May 2024 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716970665;
	bh=aex72zuj9Ceu5xpqhciQKKCLeAJCuCEnMMtr7+earFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+XxuPtV4QUkDBG2igGuGESMzKco6PB+FxfuvH7AEA2uGr6gCnclN0M3Fi6ITvU1P
	 MJQUKfeHle/7jVVwHopdRdBrgWTDCyRNiOt3WtY5LazUrmuJYD6zySctiK1kpcQRJq
	 8Pq4YPBYzzSlzn0npedFaS4msMQN3v/xaDAmgJeCQcMge7vcqXxrbK+fsxGBDlaoQr
	 kUVg0pFfzsyIjqMV5o8fACgWyNBsmoaZB/IbgfPDqDm/aSxt4mC1vlD4leDztsuWKW
	 Q6S1TyuGcIZNO9vnhTIyNyP05sQZ+4e217JU8KzmmpFEp5CHM4Q9cyVPlOVxsqh9p3
	 do7l1e7KsAbAA==
Date: Wed, 29 May 2024 10:17:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org, yakoyoku@gmail.com
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
Message-ID: <20240529-muskatnuss-jubel-489aaf93fc0b@brauner>
References: <20240525-dompteur-darfst-79a1b275e7f3@brauner>
 <20240527160514.3909734-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527160514.3909734-1-aliceryhl@google.com>

> > So what you're getting at seems to be that some process has a private
> > file descriptor table and an just opened @fd to a @file that isn't
> > shared.
> > 
> > 	fd = open("/my/file");
> > 
> > and then let's say has a random ioctl(fd, SOMETHING_SOMETHING) that
> > somehow does:
> > 
> > 	struct fd fd = fdget_pos();
> > 	if (!fd.file)
> > 		return -EBADF;
> > 
> > We know that process has used a light reference count and that it didn't
> > acquire f_pos_lock.
> > 
> > Your whole approach seems to assume that after something like this has
> > happened the same process now offloads that struct file to another
> > process that somehow ends up doing some other operation on the file that
> > would also require f_pos_lock to be taken but it doesn't like a read or
> > something.
> 
> Can we not have a data race even if the other process *does* take the
> f_pos_lock mutex? The current thread did not take the mutex, so if the
> current thread touches the file position after sending the file
> reference, then that could race with the other process even if the
> other process takes f_pos_lock.

Yes, for that the original sender would have to have taken a light
reference, and the file mustn't have been in any other file descriptor
table and then the original opener must've sent it while in fdget_pos
scope and remain in that scope while the receiver installs the fd into
their fd table and then leaves and reenters the kernel to e.g., read.

> > To share a file between multiple processes would normally always require
> > that the process sends that file to another process. That process then
> > install that fd into its file descriptor table and then later accesses
> > that file via fdget() again. That's the standard way of doing it -
> > binder does it that way too. And that's all perfectly fine.
> 
> And similarly, if the remote process installs the file, returns to
> userspace, and then userspace calls back into the kernel, which enters
> an fdget_pos scope and modifies the file position. Then this can also
> race on the file position if the original process changes the file
> position it after sending the file reference.

If that process were to send it from within an fdget_pos scope then yes. 

> *That's* the data race that this is trying to prevent.
> 
> > What you would need for this to be a problem is for a process be sent a
> > struct file from a process that is in the middle of an f_pos_lock scope
> > and for the receiving process to immediately start doing stuff that
> > would normally require f_pos_lock.
> > 
> > Like, idk vfs_read(file, ...).
> > 
> > If that's what this is about then yes, there's a close-to-zero but
> > non-zero possibility that some really stupid code could end up doing
> > something like this.
> > 
> > Basically, that scenario doesn't exist (as I've mentioned before)
> > currently. It only exists in a single instance and that's when
> > pidfd_getfd() is used to steal a file from another task while that task
> > is in the middle of an f_pos_lock section (I said it before we don't
> > care about that because non-POSIX interface anyway and we have ptrace
> > rights anyway. And iiuc that wouldn't even be preventable in your
> > current scheme because you would need to have the information available
> > that the struct file you're about to steal from the file descriptor
> > table is currently within an f_pos_lock section.).
> > 
> > Is it honestly worth encoding all that complexity into rust's file
> > implementation itself right now? It's barely understandable to
> > non-rust experts as it is right now. :)
> > 
> > Imho, it would seem a lot more prudent to just have something simpler
> > for now.
> 
> The purpose of the changes I've made are to prevent data races on the
> file position. If we go back to what we had before, then the API does
> not make it impossible for users of the API to cause such data races.
> 
> That is the tradeoff.

Right. Sorry, there's some back and forth here. But we're all navigating
this new territory here and it's not always trivial to see what the
correct approach is.

I wonder what's better for now. It seems that the binder code isn't
really subject to the races we discussed. So maybe we should start with
the simpler approach for now to not get bogged down in encoding all
subtle details into rust's file wrapper just yet?

