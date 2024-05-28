Return-Path: <linux-fsdevel+bounces-20373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065908D269F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 22:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2731C1C2627B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 20:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE817A931;
	Tue, 28 May 2024 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t8/UWoUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A236A33F;
	Tue, 28 May 2024 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929986; cv=none; b=lV4oE5WRmxK8gh03ZrzjVzwFcHTMCxBde9KtSexAzwYNq6J0lIF0HIF9/8zLBhxA5HYmaeK9IN3fZf+AAUhoIL+WeFMzshwqB74z8RMHXDuC4Si+8dxuN/ylCSKqLGue0KOTRqjeHxnPvhl9aJ7AdzFRVXvitgo1jag9a6dWXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929986; c=relaxed/simple;
	bh=PLXFcu8sKJkyE4JeTWpuz+MKwoHU4DkF9JJyJXCaCCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0kdda4n+bhEvsFiyNYLh+Ji2ESRGa3QulTWxlD5YEQ9lLaVrxQe6jzlKhaG1o6DIvSByUk9JPlpnKrMfXKOZtVGVUNddBQDX6zoZldzTB4I5BRMz4XoAkXJoHxIo+4QmZk0dYSniF2K70k6eVnxp5MokBdAO4nITFzBzMhTywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=t8/UWoUu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1hlkMQxRIEdCpGnrp8gqv9h5AashnbOh2AOuFzZyuXo=; b=t8/UWoUuvp2VSP8PT5TOhsIbJy
	nEy4xgsPykl6zjSmMYIkH1Vm+pLRxsUY4jN0a5/kKQri9MCsvFpjMJiKuKW7gB7a6o+kSiSE80A5Q
	YNj/ss8hy5VyDX5cad+CzO1i9i5MUZhcOjxUerRv3Eao263YlHROFVSxGB9bvaiwGq2TaYVR2YN45
	sqWosP2jyQni3ve+r5EKzVvInAbz0xKxoHqe2QK/eBlsL56rzrQ2JjDtQcC0xqlSxgMWqH6MFCGhS
	6KyjlJH45gsik2YJxTiNOyM+XnB3eUreuzVQMBecKTIBgvAwTE+6ToCXrz2Ai1t2gywvqYtTp3buD
	YgcaiS6g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sC3uf-001C35-2M;
	Tue, 28 May 2024 20:59:17 +0000
Date: Tue, 28 May 2024 21:59:17 +0100
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
Message-ID: <20240528205917.GI2118490@ZenIV>
References: <20240524213245.GT2118490@ZenIV>
 <20240527160356.3909000-1-aliceryhl@google.com>
 <20240528193624.GH2118490@ZenIV>
 <CAH5fLgiD_x3OVSc_JVK43BoNY4SeFt01siT32w2gQy_Ae_awrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgiD_x3OVSc_JVK43BoNY4SeFt01siT32w2gQy_Ae_awrA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 28, 2024 at 10:29:03PM +0200, Alice Ryhl wrote:

> > Incidentally, I'm very tempted to unexport close_fd(); in addition to
> > being a source of bugs when called from ioctl on user-supplied descriptor
> > it encourages racy crap - just look at e.g. 1819200166ce
> > "drm/amdkfd: Export DMABufs from KFD using GEM handles", where we
> > call drm_gem_prime_handle_to_fd(), immediately followed by
> >                 dmabuf = dma_buf_get(fd);
> >                 close_fd(fd);
> > dup2() from another thread with guessed descriptor number as target and
> > you've got a problem...  It's not a violation of fdget() use rules
> > (it is called from ioctl, but descriptor is guaranteed to be different
> > from the one passed to ioctl(2)), but it's still wrong.  Would take
> > some work, though...
> 
> Wait, what's going on there? It adds the fd and then immediately
> removes it again, or?

It creates an object and associated struct file, using a primitive that
shoves the reference to that new struct file into descriptor table and
returns the slot number.  Then it looks the file up by the returned
descriptor, tries to pick the object out of it and closes the descriptor.
If that descriptor table is shared, well... pray the descriptor still
refers to the same file by the time you try to look the file up.

It's bogus; the song and dance with putting it into descriptor table
makes sense for the primary user (ioctl that returns the descriptor
number to userland), but here it's just plain wrong.  What they need
is to cut that sucker in two functions - one that returns dmabuf,
with wrapper doing dma_buf_fd() on the result (or allocating a descriptor
first, then calling the primitives that gets their dmabuf, then doing
fd_install()).

This caller should use the new primitive without messing with descriptor
table.  In general, new descriptors are fit only for one thing - returning
them to userland.  As soon as file reference is in descriptor table
it might get closed right under you - file argument of fd_install()
is moved, not borrowed.  You might find something on lookup by that
descritor, but it's not guaranteed to have anything to do with what
you'd just put there.

That's why we have anon_inode_getfile(), with anon_inode_getfd() being
only a convenience helper, for example...

