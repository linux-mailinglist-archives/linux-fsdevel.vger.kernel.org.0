Return-Path: <linux-fsdevel+bounces-29412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C93979878
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 21:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0131C218FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 19:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2861CB325;
	Sun, 15 Sep 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TKOtGGCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C391B85D9;
	Sun, 15 Sep 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726428910; cv=none; b=szp/RtLi1ndoLWOkrk9FuhM6VXJaMOwdv4n551carqTkjx5fTZJO7hNWoRIWaUTupeh1kaaoTl5m63dqCve3tIhab6/l6ELDWahnNGVbn9PZc0LD9uY362yd8LX+QoPcCzMSQwN6Be78tfAk4+125kEE1HkBePwtQ8HBx7sTyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726428910; c=relaxed/simple;
	bh=Ztvwstq5klPJincLUXWeb4jXXiG0ODtnWTMdxIzaYcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGf+SHj2tU9BnS355+VCqZHp8wYTIEIBeQx+ND1K7DsiQyy3lwHp8hgoSxRlgRUdxVVgWLFZLKZrklBOoJovR8gnEtgbS1FFKKC4pRM5yliLRqA14CyA/0CeQmTZud9TIwvXrhvqxM9Rpz1rU5XxbINV05AcxEJ3sr4tEJZz/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TKOtGGCN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0BxDruh7S7ijZk6E+YQkSo4Un7V4HISAaHQSfC2SZJs=; b=TKOtGGCNiaBftnO0gTOnYNx0/D
	khqaG/bq7ndnBd1/Y8Z6yU1Eaaw7DBQUCyALQM7nxGAB+WedwUumRaufg2e/VKS+627YTt/B02uXO
	+fjHQxJU8arfVMXzmsO+7bqx6KOOOs8KtvWvC9ZGzKgAjJPoDYoQMqmed0g5INPb2J5MFSpvH0/6C
	HVI4BtMq9BCV1lHg2iOyiAR7GiSObHZG2F68+EfchvbzK62A8Ingo3CqUrCC75x7mvHSoGBnVWqpN
	5G+uo0KL8YRIQbWkjIEOZdzq1nXU8qXnaqAp2ShK7cf7Xh01HJQoEW1Qe1EZ2gH1dHLXX6+vkhir8
	04kwJ/Iw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spv19-0000000CkLq-2ql2;
	Sun, 15 Sep 2024 19:34:43 +0000
Date: Sun, 15 Sep 2024 20:34:43 +0100
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
Message-ID: <20240915193443.GK2825852@ZenIV>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-6-88484f7a3dcf@google.com>
 <20240915183905.GI2825852@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915183905.GI2825852@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 15, 2024 at 07:39:05PM +0100, Al Viro wrote:
> 	2) calling thread MUST NOT unshare descriptor table while it has
> any reserved descriptors.  I.e.
> 	fd = get_unused_fd();
> 	unshare_files();
> 	fd_install(fd, file);
> is a bug.  Reservations are discarded by that.  Getting rid of that
> constraint would require tracking the sets of reserved descriptors
> separately for each thread that happens to share the descriptor table.
> Conceptually they *are* per-thread - the same thread that has done
> reservation must either discard it or use it.  However, it's easier to
> keep the "it's reserved by some thread" represented in descriptor table
> itself (bit set in ->open_fds bitmap, file reference in ->fd[] array is
> NULL) than try and keep track of who's reserved what.  The constraint is
> basically "all reservations can stay with the old copy", i.e. "caller has
> no reservations of its own to transfer into the new private copy it gets".

FWIW, I toyed with the idea of having reservations kept per-thread;
it is possible and it simplifies some things, but I hadn't been able to
find a way to do that without buggering syscall latency for open() et.al.

It would keep track of the set of reservations in task_struct (count,
two-element array for the first two + page pointer for spillovers,
for the rare threads that need more than two reserved simultaneously).

Representation in fdtable:
state		open_fds bit	value in ->fd[] array
free		clear		0UL
reserved	set		0UL
uncommitted	set		1UL|(unsigned long)file
open		set		(unsigned long)file

with file lookup treating any odd value as 0 (i.e. as reserved)
fd_install() switching reserved to uncommitted *AND* separate
"commit" operation that does this:
	if current->reservation_count == 0
		return
	if failure
		for each descriptor in our reserved set
			v = fdtable->fd[descriptor]
			if (v) {
				fdtable->fd[descriptor] = 0;
				fput((struct file *)(v & ~1);
			}
			clear bit in fdtable->open_fds[]
	else
		for each descriptor in our reserved set
			v = fdtable->fd[descriptor]
			if (v)
				fdtable->fd[descriptor] = v & ~1;
			else
				BUG
	current->reservation_count = 0

That "commit" thing would be called on return from syscall
for userland threads and would be called explicitly in
kernel threads that have a descriptor table and work with
it.

The benefit would be that fd_install() would *NOT* have to be done
after the last possible failure exit - something that installs
a lot of files wouldn't have to play convoluted games on cleanup.
Simply returning an error would do the right thing.

Two stores into ->fd[] instead of one is not a big deal;
however, anything like task_work_add() to arrange the call
of "commit" ends up being bloody awful.

We could have it called from syscall glue directly, but
that means touching assembler for quite a few architectures,
and I hadn't gotten around to that.  Can be done, but it's
not a pleasant work...

