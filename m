Return-Path: <linux-fsdevel+bounces-56804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F7CB1BE77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 03:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7443B15B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 01:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D701A23A0;
	Wed,  6 Aug 2025 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L744vBhq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C712502BE;
	Wed,  6 Aug 2025 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445295; cv=none; b=cJnkn0FVcTNLbUZT7yRUfnK7wgvDHBfysWbim7Y8Ee95RlTWUlwDm7tsoEIqlanPtdM7S/3uj7jlj/RNyNnWQgLd9ZR1N08F+AMXQWFJBzpT8JzGJ9+dAuV3jXb7DIrVGMlwIDNRkDiUkOxlK73OrdvYY1OM2ToG00qojrXq+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445295; c=relaxed/simple;
	bh=EPVzJPUmvWwbmQcqVM3T4ytLQLa5WfF2jfCt0acpElE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScF3ieRZY51BFVox2gqoaErtbbJ+hbtcVk1LUzvGDfeKIJJkHySzkXk0N+f7yjC6XD9XGSqIwLr99ozBTM7K/zkxmJA8gbMRsfweZdqSPTrYWzjxcRwDdpMwhOjLBq4urGzLD2mtYWABbiSIKBplDCoIKMQXBtJQSbUiuc7LcaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=L744vBhq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y7hjcTlBLlHEkIsVkJW9LcLYrfSDMpCRStdSI9oCyBM=; b=L744vBhqaFVKh14WsOoVpPCpHk
	Um4YnOsK0YP+Eb69qKtI76/vtSGMMUY9nBQN+YPT2U/WQKvvIi9T5refIu2ThAdMCbGYCVKXAh4Px
	Ff3n6Ie5XtTSolnLiIOZxqsv9/tCStxb7vgQhIS6e7u0kLJuMXhvNAphammMluL9+CUpN363VNH2r
	FWz8IoX1+jU3hNtXCvsyTh4NoQK4O9HErhAJflMa8WjFM1vatAJK7N34S105oExp6vsbipc8OvjZe
	LjvTUXfo9FQV0lrue+LCVbeaokOsgrhFKDPdrJ+7PY+Rc80OQuvbSnpCRJWdJe4icmLQZzJwkMbSB
	jF12ROjg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujTMf-00000007Aqw-3DD8;
	Wed, 06 Aug 2025 01:54:49 +0000
Date: Wed, 6 Aug 2025 02:54:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Jan Kara <jack@suse.cz>, Sargun Dhillon <sargun@sargun.me>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: always return zero on success from replace_fd()
Message-ID: <20250806015449.GA1638962@ZenIV>
References: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>
 <20250804-rundum-anwalt-10c3b9c11f8e@brauner>
 <20250804155229.GY222315@ZenIV>
 <20250805-beleidigen-klugheit-c19b1657674a@brauner>
 <20250805153457.GB222315@ZenIV>
 <20250805195003.GC222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805195003.GC222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 05, 2025 at 08:50:03PM +0100, Al Viro wrote:
> On Tue, Aug 05, 2025 at 04:34:57PM +0100, Al Viro wrote:
> 
> > They do no allow to express things like "foo() consumes lock X".
> > >From time to time, we *do* need that, and when that happens guards
> > become a menace.
> > 
> > Another case is
> > 	lock
> > 	if (lock-dependent condition)
> > 		some work
> > 		unlock
> > 		work that can't be under that lock
> > 	else
> > 		some other work
> > 		unlock
> > 		more work that can't be under that lock
> > 
> > Fairly common, especially when that's a spinlock and "can't be under that
> > lock" includes blocking operations.  Can't be expressed with guards, not
> > without a massage that often ends up with bloody awful results.
> 
> FWIW, I'm looking through the raw data I've got during ->d_lock audit.
> Except for a few functions (all static in fs/dcache.c), all scopes
> terminate in the same function where they begin.

... and for ->file_lock we have the following:
	expand_fdtable(): drops and regains
	expand_files(): either nothing or drops and regains
	do_dup2(): drops
everything else is neutral.

20 functions touching that stuff total.  Convertible to guard() or
scoped_guard(): put_unused_fd(), fd_install(), close_fd() (scoped_guard
only), __range_cloexec(), file_close_fd(), set_close_on_exec(),
iterate_fd(), fcntl_setlk() and fcntl_setlk64() (scoped_guard only), 
seq_show() - 10 out of 20.

Anything that uses expand_fdtable() is in the best case an abuse of
guard/scoped_guard; in the worst, it's actively confusing, since
there's *not* one continuous scope there.  expand_files() is in
the same boat.  That covers alloc_fd(), replace_fd() and ksys_dup3().
That's 5 out of remaining 10.  BTW, trying to eliminate gotos from
alloc_fd() is not fun either.

dup_fd():
	spin_lock(&oldf->file_lock);
	...
	while (unlikely(open_files > new_fdt->max_fds)) {
		spin_unlock(&oldf->file_lock);
		... (blocking, possibly return on failure here)
		spin_lock(&oldf->file_lock);
		...
	}
	...
	spin_unlock(&oldf->file_lock);
	...
No way to do that with guard() - not unless you mix it with explicit
unlock/lock in the middle of scope, and even that will be bitch to
deal with due to failure exit after allocation failure.  We'd need
to do this:
	spin_unlock(&oldf->file_lock);
	if (new_fdt != &newf->fdtab)
		__free_fdtable(new_fdt);
	new_fdt = alloc_fdtable(open_files);
	spin_lock(&oldf->file_lock);
	if (IS_ERR(new_fdt)) {
		kmem_cache_free(files_cachep, newf);
		return ERR_CAST(new_fdt);
	}
all of that under guard(spinlock)(&oldf->file_lock).  IMO that would
be too confusing and brittle.

__range_close():
	spin_lock(&files->file_lock);
	...
	for (; fd <= max_fd; fd++) { 
		file = file_close_fd_locked(files, fd);
		if (file) {
			spin_unlock(&files->file_lock);
			filp_close(file, files);
			cond_resched();
			spin_lock(&files->file_lock);
		} else if (need_resched()) {
			spin_unlock(&files->file_lock);
			cond_resched();
			spin_lock(&files->file_lock);
		}
	}
	spin_unlock(&files->file_lock);
Not a good fit for guard(), for the same reasons.

do_close_on_exec():
	...
	spin_lock(&files->file_lock);
	for (i = 0; ; i++) {
		....
		for ( ; set ; fd++, set >>= 1) {
			....
			spin_unlock(&files->file_lock);
			filp_close(file, files);
			cond_resched();
			spin_lock(&files->file_lock);
		}
	}
	spin_unlock(&files->file_lock);
Same story.

io_close():
	might be convertible to scoped_guard; won't be pretty,
AFAICS - that -EAGAIN case in the middle makes it very clumsy.

do_dup2(): well... we could lift filp_close() into the callers,
but that ends up with fairly unpleasant boilerplate in the
callers, and one of those callers is a fairly hot syscall.

And that's the remaining 5.  For some locks scoped_guard() is
a decent fit; for some it really isn't ;-/

