Return-Path: <linux-fsdevel+bounces-12761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F8866F35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414A0B2755B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7C87F7C0;
	Mon, 26 Feb 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azttXLZK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B57F463;
	Mon, 26 Feb 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938710; cv=none; b=PUixXIVIV5+nKCRwK+hZMCogUO3Ajqu5nIV7vipmNnayPefTpXQIFoq4Tvup8uwlWfjM0WphZXi6UwyGPiIkfi2IuaAzXyyZt6KqBbuT33QWzL56bU70aUsq1F4zPymh8iFD6uYdr9wAC579+sOMCGmfCgw0GA0XYhtaN82ooXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938710; c=relaxed/simple;
	bh=HmQtwuVTdmVLT7OgJWjjNCGSFahCKuzF399EFnjzcZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJLjHVj6qvo0qpoPR2WO2EteQl4JQhsW5qYedhuHZlFtv9fN+BHP4tH0+O6t7kYx5jPnTwhFOkEEiQBd95onsxO4x3PWNsKzQ7bFy6CcCLdkReMRvU9fnvmv7uhIS5u5yGHAWvz0X9gG+DHl24iQ+vOj1+V6oWIiuSeuyvmJPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azttXLZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2857BC433C7;
	Mon, 26 Feb 2024 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708938709;
	bh=HmQtwuVTdmVLT7OgJWjjNCGSFahCKuzF399EFnjzcZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azttXLZK2HR58ht4UAz6hDNX2DSwFY9VjTwzFm1/lVrxMUjehHSq32+rHOdRbgxLj
	 ftTU7zjUGmdSpdsbuxrTyHU98xvnC1B33Ep1kAWvkW1v/GKSxNX82Pkpw6vrTID9Ed
	 YWZCvHNPkyi2U90jgrUxJ+zjI5OfbCp6M50ZqEIIxvqWYuXmO2U9lXzS00L0BgHUwv
	 E4Sh7z1x+GlENyyd3Vm3MgfmJRvdfXj4BJvbBUH4ScQgER4hwe6Z5lUNAAr92Ppdlz
	 nUCoRWxlRJe7ITKvYOUw32tby++UOAk6gsEwlX0bBtZ5X7xBvrDIoWm4yVqbc5HTUn
	 6Kzk+k549KZ3w==
Date: Mon, 26 Feb 2024 04:13:03 -0500
From: Al Viro <viro@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] documentation on filesystem exposure to RCU pathwalk from
 fs maintainers' POV
Message-ID: <ZdxWH4uNfwcftWYI@duke.home>
References: <Zdu58Jevui1ySBqa@duke.home>
 <5879f44e-1c28-4be1-a684-9bf4fbf6966b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5879f44e-1c28-4be1-a684-9bf4fbf6966b@oracle.com>

On Mon, Feb 26, 2024 at 07:35:17AM +0100, Vegard Nossum wrote:

> There is a slight apparent contradiction here between "at the very
> least, they can expect [...] to remain live throughout the operation" in
> the first paragraph (which sounds like they _do_ have these guarantees)
> and most of the second paragraph (which says they _don't_ have these
> guarantees).
> 
> I *think* what you are saying is that dentries/inodes/sbs involved will
> indeed stay live (i.e. allocated), but that there are OTHER warranties
> you might usually expect that are not there, such as objects not being
> locked and potentially changing underneath your filesystem's VFS
> callback or being in a partial state or other indirectly pointed-to
> objects not being safe to access.

Live != memory object hasn't been freed yet.  It's a lot stronger than
that.  And most of the filesystem methods get those stronger warranties;
life would be very hard if we did not have those.

E.g. when you are in the middle of ->read(), you know that struct file
passed to you won't reach ->release() until after your ->read() returns,
that the filesystem it's on hasn't even started to be shut down, that
its in-core inode won't get to ->evict_inode(), that its dentry is
still associated with the same inode and will stay that way until you are
done, etc.

Normally we do get that kind of warranties - caller holds references
to the objects we are asked to operate upon.  However, the fast
path of pathname resolution (everything's in the VFS caches, no IO
or blocking operations needed, etc.) is an exception.  Several filesystem
methods (the ones involved in the fast path) may be called with
the warranties that are weaker than what they (and the rest of the
methods) normally get.  Note that e.g.  ->lookup() does not need to worry -
it's off the fast path pretty much by definition and VFS switches to
pinning objects before calling anything of that sort.

"Unsafe call" refers to the method calls made by RCU pathwalk with
weaker warranties.  Part of the objects passed to those might have
already started on the way through their destructors.

> Filesystem methods can usually count upon a number of VFS-provided
> warranties regarding the stability of the dentries/inodes/superblocks
> they are called to act upon. For example, they always can expect these
> objects to remain live throughout the operation; life would be much more
> painful without that.
> 
> However, such warranties do not come for free and other warranties may
> not always be provided. [...]
> """

Maybe...

> (As a side note, you may also want to actually link the docs we have for
> RCU lookup where you say "details are described elsewhere".)
> 
> > What methods are affected?
> > ==========================
> > 
> > 	The list of the methods that could run into that fun:
> > 
> > ========================	==================================	=================
> > 	method			indication that the call is unsafe	unstable objects
> > ========================	==================================	=================
> 
> I'd wish for explicit definitions of "unsafe" (which is a terminology
> you do use more or less consistently in this doc) and "unstable". The
> definitions don't need mathematical precision, but there should be a
> quick one-line explanation of each.
 
See above.

> I think "the call is unsafe" means that it doesn't have all the usual
> safety warranties (as detailed above).
> 
> I think "unstable" means "not locked, can change underneath the
> function" (but not that it can be freed), but it would be good to have
> it spelled out.

Nope.  "Locked" is not an issue.  "Might be hit by a destructor called by
another thread right under your nose" is.  It's _that_ unpleasant.  Fortunately,
most of the nastiness is on the VFS side, but there's a good reason why
quite a few filesystems simply bail out and tell VFS to piss off and not
come back without having grabbed the references, so that nothing of that
sort would have to be dealt with.

