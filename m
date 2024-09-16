Return-Path: <linux-fsdevel+bounces-29431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD7E979A4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 06:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF18282980
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 04:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B293A1BA;
	Mon, 16 Sep 2024 04:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ae/65gvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6052F5B;
	Mon, 16 Sep 2024 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726460315; cv=none; b=Oe0YDZl7suUxP+h6suDIYx6dZr3O/Uh1e4CgFsDnIN/56YoESGFwnCDEqFSw58D+6fJLLgCCMXgNzTYtQcPhzPbdED0rqA8yuAhcpahuGZLVhHuZMuRzky4Jo+cdbP5sDPd0lqFdyCr0UxEA+AX3e0EBPX0kws6pqqDQvN1SqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726460315; c=relaxed/simple;
	bh=DR5eTYXqizS++Oxp4/zCK03oWTy2bGFeXCwR6HkHWFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XneMoVnSzw75NgMyULFQDU2cJA4GVO4o1K5ooB4QN5U+K+b5yn5SScuByqsuIG5PQjOauJthi/RR2SLcDVnbOfpi+DjL4MCqN8K45awbC4tmMdnInFYQ+wMGQKxcCoOIlOIafu+3Ok7eMvqQ52XhK7ZYpsZBdu5m2teUX7zEtQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ae/65gvP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5DbAG9dxofjmc039hnMVqStrVmflynfUIJTlbchod58=; b=Ae/65gvPFWC1d+1iGXrzaTAwXR
	VLlQV6jCW2IbzqgXcIFV/aELZEZCVw1SMsCm6TD34Oszu3O29hVKobe4cOhBFgZTIANNBzOSnZuM1
	7ViT56FwjuRuBPvpZgRqQ1zhh0pzOLH2BpSFxRtULTn3m9Y+rryPIy6hdwMn8YAy5T+LX9wDuzsTs
	COwQc2kaME+xOCZ35YiXMcFmG8ma49eZrmb5j8J9iXaITD1aaPAFDUYKBE1L+/fgbAMGJlqvp2zRd
	/9kO3jjIFjrWsgaXDnGaee9xhFlvMuS6p7/H08wAHRWUKr/vURGJk8PnY0lITIuVm40W8apxhQn8V
	4Z3sGCPg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sq3Bt-0000000Cq4Z-455W;
	Mon, 16 Sep 2024 04:18:22 +0000
Date: Mon, 16 Sep 2024 05:18:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
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
	rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v10 6/8] rust: file: add `FileDescriptorReservation`
Message-ID: <20240916041821.GN2825852@ZenIV>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-6-88484f7a3dcf@google.com>
 <20240915183905.GI2825852@ZenIV>
 <20240915193443.GK2825852@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915193443.GK2825852@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 15, 2024 at 08:34:43PM +0100, Al Viro wrote:

> FWIW, I toyed with the idea of having reservations kept per-thread;
> it is possible and it simplifies some things, but I hadn't been able to
> find a way to do that without buggering syscall latency for open() et.al.

Hmm...  How about the following:

* add an equivalent of array of pairs (fd, file) to task_struct;
representation could be e.g. (a _VERY_ preliminary variant)
	unsigned fd_count;
	int fds[2];
	struct file *fp[2];
	void *spillover;
with 'spillover' being a separately allocated array of pairs to deal with
the moments when we have more than 2 simultaneously reserved descriptors.
Initially NULL, allocated the first time we need more than 2.  Always empty
outside of syscall.

* inline primitives:
	count_reserved_fds()
	reserved_descriptor(index)
	reserved_file(index)

* int reserve_fd(flags)
	returns -E... or index.

	slot = current->fd_count
	if (unlikely(slot == 2) && !current->spillover) {
		allocate spillover
		if failed
			return -ENOMEM
		set current->spillover
	}
	if slot is maximal allowed (2 + how much fits into allocated part?)
		return -E<something>
	fd = get_unused_fd_flags(flags);
	if (unlikely(fd < 0))
		return fd;
	if (likely(slot < 2)) {
		current->fds[slot] = fd;
		current->fp[slot] = NULL;
	} else {
		store (fd, NULL) into element #(slot - 2) of current->spillover
	}
	current->fd_count = slot + 1;

* void install_file(index, file)
	
	if (likely(slot < 2))
		current->fp[slot] = file;
	else
		store file to element #(slot - 2) of current->spillover

* void __commit_reservations(unsigned count, bool failed)
	// count == current->fd_count

	while (count--) {
		fd = reserved_descriptor(count);
		file = reserved_file(count);
		if (!file)
			put_unused_fd(fd);
		else if (!failed)
			fd_install(fd, file);
		else {
			put_unused_fd(fd);
			fput(file);
		}
	}
	current->fd_count = 0;

* static inline void commit_fd_reservations(bool failed)
	called in syscall glue, right after the syscall returns
	
	unsigned slots = current->fd_count;
	if (unlikely(slots))
		__commit_reservations(slots, failed);


Then we can (in addition to the current use of get_unused_fd_flags() et.al. -
that still works) do e.g. things like

	for (i = 0; i < 69; i++) {
		index = reserve_fd(FD_CLOEXEC);

		if (unlikely(index < 0))
			return index;

		file = some_driver_shite(some_shite, i);
		if (IS_ERR(file))
			return PTR_ERR(file);

		install_file(index, file); // consumed file

		ioctl_result.some_array[i] = reserved_descriptor(index);
		....
	}
	...
	if (copy_to_user(arg, &ioctl_result, sizeof(ioctl_result))
		return -EFAULT;
	...
	return 0;

and have it DTRT on all failures, no matter how many files we have added,
etc. - on syscall return we will either commit all reservations
(on success) or release all reserved descriptors and drop all files we
had planned to put into descriptor table.  Getting that right manually
is doable (drm has some examples), but it's _not_ pleasant.

The win here is in simpler cleanup code.  And it can coexist with the
current API just fine.  The PITA is in the need to add the call
of commit_fd_reservations() in syscall exit glue and have that done
on all architectures ;-/

FWIW, I suspect that it won't be slower than the current API, even
if used on hot paths.  pipe(2) would be an interesting testcase
for that - converting it is easy, and there's a plenty of loads
where latency of pipe(2) would be visible.

Comments?

