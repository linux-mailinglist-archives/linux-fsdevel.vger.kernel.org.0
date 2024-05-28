Return-Path: <linux-fsdevel+bounces-20370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54348D24B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 21:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20939B224D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B917798C;
	Tue, 28 May 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CVYoa0I+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8613C3E7;
	Tue, 28 May 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925015; cv=none; b=EcrhiR9o7zNJ/dRdOkaCpo2Rlol860orFFJA/5B4aK9mnB7mGdVGg6GYic+ovHSAO4XctFE9YlG5FyF7qxHWq4K7AcPC8e5jGLnx8B5mIJOFfzWYunj+tmZu3DK6i4P+iknk9LNgQIs1FyYN3yjeVn+jF4kAkAYN49VFJP1AKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925015; c=relaxed/simple;
	bh=3qCTckRbSoDeQuWSwNNTDxw8BHRVGSB1bN1w9lT0kis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBYLfwi5eZr+DAKEARlgq4Yhyg0Fl0YOZFup/z+oZ3gkU+Y2kMuP9qeFJKzvvKBGei65FQCpVCP9uMdhaNohleWopFxwgyIfyhFJS1AVZWJFDKPrrzsMUM4xOPUTYeFj59PyOX2SgDTn4gGYM1ol1I+IAMdVN2ukBfSdm/OVaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CVYoa0I+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/CfLh9oYnTyEvViq39bmHv8vkZ7XhSHj9YEgQPZXpMI=; b=CVYoa0I+KTYmpfA6iYnEo3pVpL
	N6NAhUwJpKLo0qhTNRkzDtDrlX/jRDg7UxpgwuCloSxcfT62QhBl2b/r2V79XKU8kgnPn0rqBKovK
	7OcP7ArDd03iejqlMIrGzjZyqhyjxMF3mdFHp0VgK86aM5hHLFhSqE0ehr80BE1HN7EcomvJGSONE
	XQ6ofdRBKroCMagf8+yxPuZIdGJjqY0k5mc3Fh0IOCmezlvXy5Ky29YligepWHuHA2jOgPjI5juVj
	TB9B81+uIX8NFPmMwfjyOJ9d+IQMhFgfoKmijDT25fvvwgcUB/jz/4OKsosvqQzf1wtv/F5ivLX5r
	eInQWChw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sC2cS-0013LZ-1N;
	Tue, 28 May 2024 19:36:24 +0000
Date: Tue, 28 May 2024 20:36:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com,
	dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
	gregkh@linuxfoundation.org, joel@joelfernandes.org,
	keescook@chromium.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
	peterz@infradead.org, rust-for-linux@vger.kernel.org,
	surenb@google.com, tglx@linutronix.de, tkjos@android.com,
	tmgross@umich.edu, wedsonaf@gmail.com, willy@infradead.org,
	yakoyoku@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
Message-ID: <20240528193624.GH2118490@ZenIV>
References: <20240524213245.GT2118490@ZenIV>
 <20240527160356.3909000-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527160356.3909000-1-aliceryhl@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 27, 2024 at 04:03:56PM +0000, Alice Ryhl wrote:

> > In other words, if current->files->count is equal to 1 at fdget() time
> > we can skip incrementing refcount.  Matching fdput() would need to
> > skip decrement, of course.  Note that we must record that (borrowed
> > vs. cloned) in struct fd - the condition cannot be rechecked at fdput()
> > time, since the table that had been shared at fdget() time might no longer
> > be shared by the time of fdput().
> 
> This is great! It matches my understanding. I didn't know the details
> about current->files and task->files.
> 
> You should copy this to the kernel documentation somewhere. :)

Probably, after it's turned into something more coherent - and after
the description of struct fd scope rules is corrected ;-/

Correction in question: you _are_ allowed to move reference from
descriptor table while in scope of struct fd; what you are not allowed
is dropping that reference until the end of scope.

That's what binder_do_fd_close() is about - binder_deferred_fd_close()
is called in a struct fd scope (anything called from ->unlocked_ioctl()
instances is).  It *does* remove a struct file reference from
descriptor table:
        twcb->file = file_close_fd(fd);
moves that reference to twcb->file, and subsequent
                get_file(twcb->file);
		filp_close(twcb->file, current->files);
completes detaching it from the table[*] and the reference itself
is dropped via task_work, which is going to be executed on the
way out to userland, definitely after we leave the scope of
struct fd.

Incidentally, I'm very tempted to unexport close_fd(); in addition to
being a source of bugs when called from ioctl on user-supplied descriptor
it encourages racy crap - just look at e.g. 1819200166ce
"drm/amdkfd: Export DMABufs from KFD using GEM handles", where we
call drm_gem_prime_handle_to_fd(), immediately followed by
		dmabuf = dma_buf_get(fd);
		close_fd(fd);
dup2() from another thread with guessed descriptor number as target and
you've got a problem...  It's not a violation of fdget() use rules
(it is called from ioctl, but descriptor is guaranteed to be different
from the one passed to ioctl(2)), but it's still wrong.  Would take
some work, though...

"Detaching from the table" bit also needs documenting, BTW.  If you look
at that thing, you'll see that current->files is converted to fl_owner_t,
which is an opaque pointer.  What happens is that dnotify and POSIX lock
use current->files as opaque tags (->dn_owner and ->flc_owner resp.) and
filp_close() (well, filp_flush() these days) needs to be called to
purge all of those associated with given struct file and given tag value.

That needs to be done between removal of file reference from table and
destruction of the table itself and it guarantees that those opaque references
won't outlive the table (more importantly, don't survive until a different
files_struct instance is allocated at the same address).

[*] NB: might make sense to export filp_flush(), since that's what this
sequence boils down to.  We really need a better identifier, though -
"filp" part is a leftover from OSDI, AFAICT; that's a hungarism for
"file pointer" and it makes no sense.  file_flush() would be better,
IMO - or flush_file(), for that matter.

