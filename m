Return-Path: <linux-fsdevel+bounces-20140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E138CEBD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 23:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7121F222C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDDD84DF7;
	Fri, 24 May 2024 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gn5GQ9pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC87494;
	Fri, 24 May 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716586401; cv=none; b=CFxzwTRSQWQ3BVqrtxFMR/8YZE2pcImDO0YlGsDs836gwZssztLgojePLO70/LcyqjK0Kq8no2anmDz+OAUPcDFYhtKA4uaCp2zt8yVeYMVplzbptRSnzi1l4J1jPFurJUJkNbk2+lh5/RgAk5XX1b0tK4xyaBlAzSbLb5sbGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716586401; c=relaxed/simple;
	bh=kS/RQ4cV15lrdM14LL44ca5FC0YdNuULpCqorPSUcD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRtIfidAS6RVFb/ugUw3OJXcazwU4JmupoIkKEys4oaarFFRkr+H9mSNqa007GYSO5l6/oXdSgTvPcxeiGq3wf29h1UAYuky4uIkzSnrZ/Pnutfx1TQ/OX+ys69WKDdJe9BecMPJBqCGmIkh1+IPyErWsaWo4XR4wU3Y0U2PDAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gn5GQ9pc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iFnpsnIr3E7unjMeiYQVNgGcmGx9RfPTJUxPktbjnSc=; b=gn5GQ9pc+/AVFWvnYNQ4KYIm6j
	hhfICy9CJx9/Jmzo+K2PY2GbQOGUs752SW+Z4W9w8uBtsjkZMF7S5p90pPNhxa1nIY7BH4/fAU9u4
	R0l5dISBXYogfEebMkp+H9hIwqyH0Vt3Vn0+fSEn+bSDnfKUk1h0jIKmKx8r5257PCmSzh6MjmhNg
	Yv1uAmlOKngfSs2vqacswt7H/pALxbDzbCyp7/1R0f0WpuwFwbD1Ze4O8rbv1nUHhPVvDCnK2FpGl
	jstYHPWxC73R82W8iU2m5NKgvRhIBg3SFxN3auyp8uL4HRWCBksw5sviXDyyGNLRZMis+IhKLt3vq
	QhnQmbJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sAcWr-005rmb-1V;
	Fri, 24 May 2024 21:32:45 +0000
Date: Fri, 24 May 2024 22:32:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: brauner@kernel.org, a.hindborg@samsung.com, alex.gaynor@gmail.com,
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com,
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	maco@android.com, ojeda@kernel.org, peterz@infradead.org,
	rust-for-linux@vger.kernel.org, surenb@google.com,
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu,
	wedsonaf@gmail.com, willy@infradead.org, yakoyoku@gmail.com
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
Message-ID: <20240524213245.GT2118490@ZenIV>
References: <20240524-anhieb-bundesweit-e1b0227fd3ed@brauner>
 <20240524191714.2950286-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524191714.2950286-1-aliceryhl@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 24, 2024 at 07:17:13PM +0000, Alice Ryhl wrote:

> > You obviously are aware of this but I'm just spelling it out. Iirc,
> > there will practically only ever be one light refcount per file.
> >
> > For a light refcount to be used we know that the file descriptor table
> > isn't shared with any other task. So there are no threads that could
> > concurrently access the file descriptor table. We also know that the
> > file descriptor table cannot become shared while we're in system call
> > context because the caller can't create new threads and they can't
> > unshare the file descriptor table.
> >
> > So there's only one fdget() caller (Yes, they could call fdget()
> > multiple times and then have to do fdput() multiple times but that's a
> > level of weirdness that we don't need to worry about.).
> 
> Hmm. Is it not the case that different processes with different file
> descriptor tables could reference the same underlying `struct file` and
> both use light refcounts to do so, as long as each fd table is not
> shared? So there could be multiple light refcounts to the same `struct
> file` at the same time on different threads.

Relevant rules:

	* Each file pointer in any descriptor table contributes to refcount
of file.

	* All assignments to task->files are done by the task itself or,
during task creation, by its parent The latter happens before the task
runs for the first time.  The former is done with task_lock(current)
held.

	* current->files is always stable.  The object it points to
is guaranteed to stay alive at least until you explicitly change
current->files.
	* task->files is stable while you are holding task_lock(task).
The object it points to is guaranteed to stay alive until you release
task_lock(task).
	* task->files MAY be fetched (racily) without either of the
above, but it should not be dereferenced - the memory may be freed
and reused right after you've fetched the pointer.

	* descriptor tables are refcounted by table->count.
	* descriptor table is created with ->count equal to 1 and
destroyed when its ->count reaches 0.
	* each task with task->files == table contributes to table->count.
	* before the task dies, its ->files becomes NULL (see exit_files()).
	* when task is born (see copy_process() and copy_files())) the parent
is responsible for setting the value of task->files and making sure that
refcounts are correct; that's the only case where one is allowed to acquire
an extra reference to existing table (handling of clone(2) with COPY_FILES).

	* the only descriptor table one may modify is that pointed to
by current->files.  Any access to other threads' descriptor tables is
read-only.

	* struct fd is fundamentally thread-local.  It should never be
passed around, put into shared data structures, etc.

	* if you have done fdget(N), the matching fdput() MUST be done
before the caller modifies the Nth slot of its descriptor table,
spawns children that would share the descriptor table.

	* fdget() MAY borrow a reference from caller's descriptor table.
That can be done if current->files->count is equal to 1.
In that case we can be certain that the file reference we fetched from
our descriptor table will remain unchanged (and thus contributing to refcount
of file) until fdput().  Indeed,
	+ at the time of fdget() no other thread has task->files pointing
to our table (otherwise ->count would be greater than 1).
	+ our thread will remain the sole owner of descriptor table at
least until fdput().  Indeed, the first additional thread with task->files
pointing to our table would have to have been spawned by us and we are
forbidden to do that (rules for fdget() use)
	+ no other thread could modify our descriptor table (they would
have to share it first).
	+ we are allowed to modify our table, but we are forbidden to touch
the slot we'd copied from (rules for fdget() use).

In other words, if current->files->count is equal to 1 at fdget() time
we can skip incrementing refcount.  Matching fdput() would need to
skip decrement, of course.  Note that we must record that (borrowed
vs. cloned) in struct fd - the condition cannot be rechecked at fdput()
time, since the table that had been shared at fdget() time might no longer
be shared by the time of fdput().

> And this does *not* apply to `fdget_pos`, which checks the refcount of
> the `struct file` instead of the refcount of the fd table.

False.  fdget_pos() is identical to fdget() as far as file refcount
handling goes.  The part that is different is that grabbing ->f_pos_lock
is sensitive to file refcount in some cases.  This is orthogonal to
"does this struct fd contribute to file refcount".


Again, "light" references are tied to thread; they can only be created
if we are guaranteed that descriptor table's slot they came from will
remain unchanged for as long as the reference is used.

And yes, there may be several light references to the same file - both
in different processes that do not share descriptor table *and* in the
same thread, if e.g. sendfile(in_fd, out_fd, ...) is called with
in_fd == out_fd.

