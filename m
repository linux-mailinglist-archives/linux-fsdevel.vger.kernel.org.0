Return-Path: <linux-fsdevel+bounces-29411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F7A979836
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 20:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D3AB21A3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 18:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BAA1CC149;
	Sun, 15 Sep 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BfiZuwXU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD61CBEB5;
	Sun, 15 Sep 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425574; cv=none; b=mXxAmg471PSXHc0eis9i9AgeLZMLwNFHot2Dt2Pe8aepdDStl3WTu9VZKLGyR/SLlFqm8B8bMFZdpleF5N+RxJEZit7qaTI3A/gDmqJOZkl+/IAQztebSm0kNS18XjnmZebRzAHw+7X9xBCw1kmJ0h/RbwzR/sk7Lqi5XicW3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425574; c=relaxed/simple;
	bh=ujI3ob0yLW4HSxrKVQjvMzAe8JcPZ3eIAEBeL/dVX6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPSuCfCDnvF6asJ8iDP1u9qIXwixdpAlhDUjphc8yjRrDIV+RbruBpKy/YP7CxW1jcAUt7QeByAzo/Z0AwRVBAuXZvpWpzzyjXVl4CCSSxglSAyMZGQNN5EtpN5cOIZ3gAgTd3gtgFxnI5u62sJpeIqFQJoh18mPtVLj8wrsvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BfiZuwXU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l1/sYaWb1avWw0suXdNddcpJnS6z0B2rjO19tHcg/uI=; b=BfiZuwXU2BH++axM4Gw1YN95tR
	c1O4s11Y39h0Mz3c1+8MmNLDkr7F3WGYsb/1sp3uPpZOmCNYiYjBuZPwhW7FxF0oa/08uglBM1ggJ
	0NL+hulG2dqPrP4ONB0plbmWRCVbAr//BF+AteapPoy4tugIR5nsfpv0Fh7DbGLbS8YvkUP5hA+t0
	5ADTWU/Pz+hNJBSnuZsFmxD8sLk47JDCoWuc6d0igsUP0V9VburIFLorPQohHCFH7b2qUUfr/pR1w
	j97a+22+AQ99ZAZWYVe/FG6lI5a3H+UqGBY28diMxY1P6UoZo0BisMBS96IZcHOh006QcnEchT1Kf
	wzugQBoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spu9J-0000000CjB7-3t5m;
	Sun, 15 Sep 2024 18:39:05 +0000
Date: Sun, 15 Sep 2024 19:39:05 +0100
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
Message-ID: <20240915183905.GI2825852@ZenIV>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-6-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915-alice-file-v10-6-88484f7a3dcf@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 15, 2024 at 02:31:32PM +0000, Alice Ryhl wrote:

> +impl Drop for FileDescriptorReservation {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants of this type, `self.fd` was previously returned by
> +        // `get_unused_fd_flags`. We have not yet used the fd, so it is still valid, and `current`
> +        // still refers to the same task, as this type cannot be moved across task boundaries.
> +        unsafe { bindings::put_unused_fd(self.fd) };
> +    }
> +}

FWIW, it's a bit more delicate.  The real rules for API users are

	1) anything you get from get_unused_fd_flags() (well, alloc_fd(),
internally) must be passed either to put_unused_fd() or fd_install() before
you return from syscall.  That should be done by the same thread and
all calls of put_unused_fd() or fd_install() should be paired with
some get_unused_fd_flags() in that manner (i.e. by the same thread,
within the same syscall, etc.)

	2) calling thread MUST NOT unshare descriptor table while it has
any reserved descriptors.  I.e.
	fd = get_unused_fd();
	unshare_files();
	fd_install(fd, file);
is a bug.  Reservations are discarded by that.  Getting rid of that
constraint would require tracking the sets of reserved descriptors
separately for each thread that happens to share the descriptor table.
Conceptually they *are* per-thread - the same thread that has done
reservation must either discard it or use it.  However, it's easier to
keep the "it's reserved by some thread" represented in descriptor table
itself (bit set in ->open_fds bitmap, file reference in ->fd[] array is
NULL) than try and keep track of who's reserved what.  The constraint is
basically "all reservations can stay with the old copy", i.e. "caller has
no reservations of its own to transfer into the new private copy it gets".
	It's not particularly onerous[*] and it simplifies things
quite a bit.  However, if we are documenting thing, it needs to be
put explicitly.  With respect to Rust, if you do e.g. binfmt-in-rust
support it will immediately become an issue - begin_new_exec() is calling
unshare_files(), so the example above can become an issue.

	Internally (in fs/file.c, that is) we have additional safety
rule - anything that might be given an arbitrary descriptor (e.g.
do_dup2() destination can come directly from dup2(2) argument,
file_close_fd_locked() victim can come directly from close(2) one,
etc.) must leave reserved descriptors alone.  Not an issue API users
need to watch out for, though.

[*] unsharing the descriptor table is done by
	+ close_range(2), which has no reason to allocate any descriptors
and is only called by userland.
	+ unshare(2), which has no reason to allocate any descriptors
and is only called by userland.
	+ a place in early init that call ksys_unshare() while arranging
the environment for /linuxrc from initrd image to be run.  Again, no
reserved descriptors there.
	+ coredumping thread in the beginning of do_coredump().
The caller is at the point of signal delivery, which means that it had
already left whatever syscall it might have been in.  Which means
that all reservations must have been undone by that point.
	+ execve() at the point of no return (in begin_new_exec()).
That's the only place where violation of that constraint on some later
changes is plausible.  That one needs to be watched out for.

