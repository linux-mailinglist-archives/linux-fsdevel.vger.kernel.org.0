Return-Path: <linux-fsdevel+bounces-25079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A260948B7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 10:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACA32815B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA571BD01C;
	Tue,  6 Aug 2024 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMPBZN4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D216BE0A
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933723; cv=none; b=J1daTGap10Zng+v9CDD06dWJhQfhToqYjg6raSb/4NAKi0b8XnvMKYG3ZpbObWydIffq69wibLRIF8gwKoMZC1ETFhRIA3xy7sxbGdte/mZ7KEA8bNyEFJUwv/qqZyAjsQGON0BItYKJZkRxyIu/WMBMd42tpUIf/kCpysQ7zYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933723; c=relaxed/simple;
	bh=AmmTxrW5E5qRSOipSFVBhB/YrkAurRbSvjsxZ6s06gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHtD6Zx9W2PK26czQKRzcICCGHRDtrqNFE5daBTZ3Xi9xaldcey8aiCYOB4dc1Jnfl2HhW6LkyZWeUX4uX3JQPmmQMZmuR0NqOubaf/b46ha39ydeSVMsYuuNHQtutZSphbtLhE3WfdH0NvjxztWoOKboSxpLzhmPW1dltVrLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMPBZN4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE72C32786;
	Tue,  6 Aug 2024 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722933723;
	bh=AmmTxrW5E5qRSOipSFVBhB/YrkAurRbSvjsxZ6s06gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMPBZN4yQAYndqDwttr+pLo5gJMejIw/U7GQNBVM03MxUuohbFOBNBnGHX6PWvLSE
	 90S0UZEE6suMwDUzbz7IdvR4AtPS2Z1Q+41/sbz7jM7EWWs/Kk+EvRBYXC5xJYoU1e
	 8eBhiL//mU1RHOGvFQ4DFazybKvE7EvkVpsby5L2eJ7VjtZhVk/2lSm0naATXRRY45
	 YR/Nm38TVzorHrKDNEfYb2I+x4PvKnmNIgSZ1aJg+L+YbIoF5CYRNTIEZsD99Wx+fU
	 I/eE6YNy2ZmXQKaD5C2U90npSFKhq9iiwQ6hXD4HCl17/0UMZ5+cPViJaItbW+8Psp
	 Ei0afiH8jgFFA==
Date: Tue, 6 Aug 2024 10:41:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240806-beugen-unsinn-9433e4a8e276@brauner>
References: <20240803225054.GY5334@ZenIV>
 <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV>
 <20240804034739.GB5334@ZenIV>
 <CAHk-=wgH=M9G02hhgPL36cN3g21MmGbg7zAeS6HtN9LarY_PYg@mail.gmail.com>
 <20240804211322.GD5334@ZenIV>
 <20240805234456.GK5334@ZenIV>
 <CAHk-=wjb1pGkNuaJOyJf9Uois648to5NJNLXHk5ELFTB_HL0PA@mail.gmail.com>
 <20240806010217.GL5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240806010217.GL5334@ZenIV>

On Tue, Aug 06, 2024 at 02:02:17AM GMT, Al Viro wrote:
> On Mon, Aug 05, 2024 at 05:04:05PM -0700, Linus Torvalds wrote:
> > On Mon, 5 Aug 2024 at 16:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > So... do we really need that indirect?  The problem would be
> > > seeing ->max_fds update before that of the array pointers.
> > 
> > The reason is simply so that we can have one single allocation.
> > 
> > In fact, quite often, it's zero allocations when you can use the
> > 'struct fdtable fdtab' that is embedded in 'struct files_struct'.
> 
> More to the point, we use arrays embedded into files_struct.
> 
> >But
> > the 'struct fdtable' was a convenient way to allocate all those
> > bitmaps _and_ the 'struct file *' array all together.
> 
> I don't think so - IIRC, it was introduced when we added RCU'd
> file lookup.  Let me check...  Yep; badf16621c1f "[PATCH] files:
> break up files struct", with RCU support as rationale.  Followed
> by ab2af1f50050 "[PATCH] files: files struct with RCU".
> 
> Before those commits ->max_fds and ->fd used to live in
> files_struct and fget() (OK, fcheck_files()) had been taking
> ->files_lock, so that concurrent expand_files() would not
> screw us over.
> 
> The problem was not just the need to delay freeing old ->fd
> array; that could be dealt with easily enough.  Think what
> would've happened if fcheck_files() ended up fetching
> new value of ->max_fds and old value of ->fd, which pointed
> to pre-expansion array.  Indirection allowed to update
> both in one store.
> 
> The thing is, ->max_fds for successive ->fdt is monotonously
> increasing.  So a lockless reader seeing the old size is
> fine with the new table - we just need to prevent the opposite.
> 
> Would rcu_assign_pointer of pointers + smp_store_release of max_fds on expand
> (all under ->files_lock, etc.) paired with
> smp_load_acquire of max_fds + rcu_dereference of ->fd on file lookup side
> be enough, or do we need an explicit smp_wmb/smp_rmb in there?

Afair, smp_load_acquire() would be a barrier for both later loads and
stores and smp_store_release() would be a barrier for both earlier loads
and stores.

Iiuc, here we only care about ordering stores to ->fd and max_fds on the
write side and about ordering loads of max_fds and ->fd on the reader
side. The reader doesn't actually write anything.

In other words, we want to make ->fd visible before max_fds on the write
side and we want to load max_fds after ->fd.

So I think smp_wmb() and smp_rmb() would be sufficient. I also find it
clearer in this case.

