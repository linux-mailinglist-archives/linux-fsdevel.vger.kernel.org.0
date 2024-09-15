Return-Path: <linux-fsdevel+bounces-29419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C06979959
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 00:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4431B1F22AB7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF737316E;
	Sun, 15 Sep 2024 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oAed+Cvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1000101EE;
	Sun, 15 Sep 2024 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726437714; cv=none; b=L8X6yCUcudtuFVdLQMs9iKAzFXpxXYou2jqQ98yhGBhknaL8HVC7iIQsfRd1RF08ixXpLNOM+aFwXWpPn4pqfmSpzMMUG9NtWL1QIGOmAgT8aF+RgMTFKVwN6pzd1NjJuhhZz4sV83W5zu+T6t/xZQYxCN8pfVQ+IO72+NsSiXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726437714; c=relaxed/simple;
	bh=sEOHdfoj9EzUrCtH+g3Xe2IUrUDQKucIUOQlkDPfyt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp0B5HqsV5hznZI7lxEZfp257/Ydcjpm8oF0OV23nSCmImv++fad0t4aXYaNC25HR3bicJgQnVGXC4pIErwmWHtvJpfkBjDvJJ1oOucNPUW4MfLdDVMInLhJqV34LzfbwYbeoSowg1lqP9ZEu93JTGS5QsjMfoI7LLxFHF14nzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oAed+Cvx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ELs+jLVT+v2Ekt7PF+z3M9b+rtkzpChlU0w4tXVYYzc=; b=oAed+Cvx6uY04gl700Ms0Us4qc
	ReOVbFXl/Lsf/E2VNEkQnNEdyOQo5FJMBYynH0OxkSv6XAe/oMFcILi5oF1QBSXIvruFQ54egD1RW
	QbC9WvW+WgUh4/XIXePqMvTq5eDdHuycB/J/ckVxrPEHHS57zWkXCQjHCLaYxLC9TAQR1jP7ZEQFz
	qZ+GVj6IlmAfgvPIJu+DS9pDPe/cB3N28tF1WQgVHnfW7eL5YTcUSRetB90bOAWE4ItOsZsqvclZ5
	cVd2aQ8fIPCFY3j+7/EBE32JsUYd/+M87HZLqWV8/nS/ACdbN4xm0I4oDi3ryhQoErxEeIaGY8Q56
	wMpyokTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spxJ8-0000000ClOE-1F8L;
	Sun, 15 Sep 2024 22:01:26 +0000
Date: Sun, 15 Sep 2024 23:01:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v10 6/8] rust: file: add `FileDescriptorReservation`
Message-ID: <20240915220126.GL2825852@ZenIV>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-6-88484f7a3dcf@google.com>
 <20240915183905.GI2825852@ZenIV>
 <CAH5fLghu1NAoj1hSUOD2ULz2XEed329OtHY+w2eAnFd5GrXOKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLghu1NAoj1hSUOD2ULz2XEed329OtHY+w2eAnFd5GrXOKQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>


> What happens if I call `get_unused_fd_flags`, and then never call
> `put_unused_fd`? Assume that I don't try to use the fd in the future,
> and that I just forgot to clean up after myself.

Moderate amount of bogosities while the thread exists.  For one thing,
descriptor is leaked - for open() et.al. it will look like it's in use.
For close() it will look like it's _not_ open (i.e. trying to close it
from userland will quietly do nothing).  Trying to overwrite it with
dup2() will keep failing with -EBUSY.

Kernel-side it definitely violates assertions, but currently nothing
will break.  Might or might not remain true in the future.  Doing that
again and again would lead to inflated descriptor table, but then
so would dup2(0, something_large).

IOW, it would be a bug, but it's probably not going to be high impact
security hole.

> >         + execve() at the point of no return (in begin_new_exec()).
	      execve(2), sorry.
> > That's the only place where violation of that constraint on some later
> > changes is plausible.  That one needs to be watched out for.
 
> Thanks for going through that.

I'm in the middle of writing documentation on the descriptor table and
struct file handling right now anyway...

> From a Rust perspective, it sounds
> easiest to just declare that execve() is an unsafe operation, and that
> one of the conditions for using it is that you don't hold any fd
> reservations. Trying to encode this in the fd reservation logic seems
> too onerous, and I'm guessing execve is not used particularly often
> anyway.

Sorry, bad editing on my part - I should've clearly marked execve() as a
syscall.  It's not that it's an unsafe operation - it's only called from
userland anyway, so it's not going to happen in scope of any reserved
descriptor.

The problem is different:

* userland calls execve("/usr/bin/whatever", argv, envp)

* that proceeds through several wrappers to do_execveat_common().
  There are several syscalls in that family and they all converge
  to do_execveat_common() - wrappers just deal with difference
  in calling conventions.

* do_execveat_common() set up exec context (struct linux_binprm).
  That opens the binary to be executed, creates memory context
  to be used, calculates argc, sets up argv and envp on what will
  become the userland stack for the new program, etc. - basically,
  all the work for marshalling the data from caller's memory.
  Then it calls bprm_execve(), which is where the rest of the work
  will be done.

* bprm_execve() eventually calls exec_binprm().  That calls
  search_binary_handler(), which is where we finally get a look
  at the binary we are trying to load.  search_binary_handler()
  goes through the known binary formats (ELF, script, etc.)
  and tries to offer the exec context to ->load_binary() of
  each.

* ->load_binary() instance looks at the binary (starting with the
  first 256 bytes read for us by prepare_binprm() called in the
  beginning of search_binary_handler()).  If it doesn't have the
  right magic values, ->load_binary() just returns -ENOEXEC,
  so that the next format would be tried.  If it *does* look like
  something this format is going to deal with, more sanity checks
  are done, things are set up, etc. - details depend upon the
  binary format in question.  See load_elf_binary() for some taste
  of that.  Eventually it decides to actually discard the old
  memory and switch to new binary.  Up to that point it can
  return an error - -ENOEXEC for soft ones ("not mine, after all,
  try other formats"), something like -EINVAL/-ENOMEM/-EPERM/-EIO/etc.
  for hard ones ("fail execve(2) with that error").  _After_ that
  point we have nothing to return to; old binary is not mapped
  anymore, userland stack frame is gone, etc.  Any errors past
  that point are treated as "kill me".

  At the point of no return we call begin_new_exec().  That
  kills all other threads, unshares descriptor table in case it
  had been shared wider than the thread group, switches memory
  context, etc.

  Once begin_new_exec() is done, we can safely map whatever we
  want to map, handle relocations, etc.  Among other things,
  we modify the userland register values saved on syscall entry,
  so that once we return from syscall we'll end up with the
  right register state at the right userland entry point, etc.
  If everything goes fine, ->load_binary() returns 0 into
  search_binary_handler() and we are pretty much done - some
  cleanups on the way out and off to the loaded binary.

  Alternatively, we may decide to mangle the exec context -
  that's what #! handling does (see load_script() - basically
  it opens the interpreter and massages the arguments, so
  that something like debian/rules build-arch turns into
  /usr/bin/make -f debian/rules build-arch and tells the
  caller to deal with that; this is what the loop in
  search_binary_handler() is about).

There's not a lot of binary formats (5 of those currently -
all in fs/binmt_*.c), but there's nothing to prohibit more
of them.  If somebody decides to add the infrastructure for
writing those in Rust, begin_new_exec() wrapper will need
to be documented as "never call that in scope of reserved
descriptor".  Maybe by marking that wrapper unsafe and
telling the users about the restriction wrt descriptor
reservations, maybe by somehow telling the compiler to
watch out for that - or maybe the constraint will be gone
by that time.

In any case, the underlying constraint ("a thread with
reserved descriptors should not try to get a private
descriptor table until all those descriptors are disposed
of one way or another") needs to be documented.

