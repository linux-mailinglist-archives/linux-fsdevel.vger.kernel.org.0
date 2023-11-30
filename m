Return-Path: <linux-fsdevel+bounces-4374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB377FEF4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7D7B20C32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C1847A50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2QmaEhh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4804779B;
	Thu, 30 Nov 2023 12:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1C4C433C8;
	Thu, 30 Nov 2023 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701347774;
	bh=EtiRcH4voLF+iaE6Nt64ffXFd88eaIh4a9FFJs3FC8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2QmaEhhoDDSdbFFx2qGmUEuyScr1iGmxSPJtl7f55G3T1z9lN0PdcTPrWuemXoUO
	 IfwzJciOhNTLWL+S71VQnZ7ftEFRkip8GPgjsH0CfyfOjVGmpyg/odMwndGQbGwLZf
	 YYuW1Qu5o2zrpedLP4lYrQQgKlPdFgUv1EeUjfk3Xb3/DFNmMAcmz97JWUNBRlz3qO
	 RZNiwGA8YzLFqk4qRALooT6zm3UdGub8EqrCd73VmL7/HdEAlU2q3r9zTAuUU8vk4O
	 //g4EdtXEG7l8auwNdWNfABGig40Q2jISdg/tYToSdaTbuyjxiY9eZRYWPpJfQUmBt
	 GCmS/ytNEh53A==
Date: Thu, 30 Nov 2023 13:36:06 +0100
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
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <20231130-zweig-mitleid-2ba3ef78145e@brauner>
References: <20231130-sackgasse-abdichtung-62c23edd9a9f@brauner>
 <20231130121013.140671-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130121013.140671-1-aliceryhl@google.com>

On Thu, Nov 30, 2023 at 12:10:12PM +0000, Alice Ryhl wrote:
> Christian Brauner <brauner@kernel.org> writes:
> >> This is the backdoor. You use it when *you* know that the file is okay
> > 
> > And a huge one.
> > 
> >> to access, but Rust doesn't. It's unsafe because it's not checked by
> >> Rust.
> >> 
> >> For example you could do this:
> >> 
> >> 	let ptr = unsafe { bindings::fdget(fd) };
> >> 
> >> 	// SAFETY: We just called `fdget`.
> >> 	let file = unsafe { File::from_ptr(ptr) };
> >> 	use_file(file);
> >> 
> >> 	// SAFETY: We're not using `file` after this call.
> >> 	unsafe { bindings::fdput(ptr) };
> >> 
> >> It's used in Binder here:
> >> https://github.com/Darksonn/linux/blob/dca45e6c7848e024709b165a306cdbe88e5b086a/drivers/android/rust_binder.rs#L331-L332
> >> 
> >> Basically, I use it to say "C code has called fdget for us so it's okay
> >> to access the file", whenever userspace uses a syscall to call into the
> >> driver.
> > 
> > Yeah, ok, because the fd you're operating on may be coming from fdget(). Iirc,
> > binder is almost by default used multi-threaded with a shared file descriptor
> > table? But while that means fdget() will usually bump the reference count you
> > can't be sure. Hmkay.
> 
> Even if the syscall used `fget` instead of `fdget`, I would still be
> using `from_ptr` here. The `ARef` type only really makes sense when *we*
> have ownership of the ref-count, but in this case we don't own it. We're
> just given a promise that the caller is keeping it alive for us using
> some mechanism or another.
> 
> >>>> +// SAFETY: It's OK to access `File` through shared references from other threads because we're
> >>>> +// either accessing properties that don't change or that are properly synchronised by C code.
> >>> 
> >>> Uhm, what guarantees are you talking about specifically, please?
> >>> Examples would help.
> >>> 
> >>>> +unsafe impl Sync for File {}
> >> 
> >> The Sync trait defines whether a value may be accessed from several
> >> threads in parallel (using shared/immutable references). In our case,
> > 
> > So let me put this into my own words and you correct me, please:
> > 
> > So, this really just means that if I have two processes both with their own
> > fdtable and they happen to hold fds that refer to the same @file:
> > 
> > P1				P2
> > struct fd fd1 = fdget(1234);
> >                                  struct fd fd2 = fdget(5678);
> > if (!fd1.file)                   if (!fd2.file)
> > 	return -EBADF;                 return -EBADF;
> > 
> > // fd1.file == fd2.file
> > 
> > the only if the Sync trait is implemented both P1 and P2 can in parallel call
> > file->f_op->poll(@file)?
> > 
> > So if the Sync trait isn't implemented then the compiler will prohibit that P1
> > and P2 at the same time call file->f_op->poll(@file)? And that's all that's
> > meant by a shared reference? It's really about sharing the pointer.
> 
> Yeah, what you're saying sounds correct. For a type that is not Sync,
> you would need a lock around the call to `poll` before the compiler
> would accept the call.
> 
> (Or some other mechanism to convince the compiler that no other thread
> is looking at the file at the same time. Of course, a lock is just one
> way to do that.)
> 
> > The thing is that "shared reference" gets a bit in our way here:
> > 
> > (1) If you have SCM_RIGHTs in the mix then P1 can open fd1 to @file and then
> >     send that @file to P2 which now has fd2 refering to @file as well. The
> >     @file->f_count is bumped in that process. So @file->f_count is now 2.
> > 
> >     Now both P1 and P2 call fdget(). Since they don't have a shared fdtable
> >     none of them take an additional reference to @file. IOW, @file->f_count
> >     may remain 2 all throughout the @file->f_op->*() operation.
> > 
> >     So they share a reference to that file and elide both the
> >     atomic_inc_not_zero() and the atomic_dec_not_zero().
> > 
> > (2) io_uring has fixed files whose reference count always stays at 1.
> >     So all io_uring operations on such fixed files share a single reference.
> > 
> > So that's why this is a bit confusing at first to read "shared reference".
> > 
> > Please add a comment on top of unsafe impl Sync for File {}
> > explaining/clarifying this a little that it's about calling methods on the same
> > file.
> 
> Yeah, I agree, the terminology gets a bit mixed up here because we both
> use the word "reference" for different things.

> 
> How about this comment?

Sounds good.

