Return-Path: <linux-fsdevel+bounces-32285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6029A3180
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 01:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283611C22FBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C26C1D6195;
	Thu, 17 Oct 2024 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z2TPVGIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28320E304
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729209304; cv=none; b=IPpwdobmZR8sNuPaKxyXQ+goXDIcnV2efupFpVytBUwEU/Pt8E5J+49ZvxREHCKluxDpM5kq42fsq6Yx0B7bekd6SbCWpsK7WeFfoSB8SO5WrI9FK/BbKeLYR2vaqLaj4jYcaqj257rh8+7i1Sx40H9MpiQqGHZeR8e2H9y0NHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729209304; c=relaxed/simple;
	bh=0pIe92Bdik9E4UhTLrQpqy+efduFeTMPrUDA7ONiAAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubfzuWkrX/kmi8R4M3IKbHJBQvEsTEKbrnl8OdZy3CW5mPkDq7deZgyT43ctohQNFH4DI+AxR5B38lb9RW9UV3vHKI5LXSt2qPDvvAlo0vwHnP2VU5ct333LTNwrmGKZhJbwvnTzGGPqWo9YeNnfJJ5wfNISYEV0HR31T0tQkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z2TPVGIl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F5+jglHRr+Kr5VD5y2tuNdVDFq0oRO9SCj3Fptqc4z4=; b=Z2TPVGIlPW7Q0m/kdIPJkMjunu
	ZSykFmxcwoXW/uc37XFZ6dN0usvT9Y3We1tizJGD66vm02pvi9UhWBQd0JnN5JjWLnKlcK/tg1TOI
	giJ1ypmP3p8gQg8LfBKii5byOThfdtfnQG7Qr3F/J7ANnUpWiC1xL/GNulZhKtbH+eafrowoKSh+5
	MYPrEdMfDC5MoMYxNa4XdjbLBR1+sD49Fjs2GOiEQd4hTRLtI+FJzYSoBnhGmXXsgpXUeM7B31bbV
	qylUXyv91SXqLZH557LvYseXC5lrONef5LghIkyIx1bn4191Tyt9l5CrbDrvSNpmbFhNnkDJPnlZB
	uXJKVeaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1aKZ-00000004rkV-3s2K;
	Thu, 17 Oct 2024 23:54:59 +0000
Date: Fri, 18 Oct 2024 00:54:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241017235459.GN4017910@ZenIV>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-rennen-zeugnis-4ffec497aae7@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 16, 2024 at 04:49:48PM +0200, Christian Brauner wrote:
> On Wed, Oct 16, 2024 at 03:00:50PM +0100, Al Viro wrote:
> > On Wed, Oct 16, 2024 at 10:32:16AM +0200, Christian Brauner wrote:
> > 
> > > > ended up calling user_path_at() with empty pathname and nothing like LOOKUP_EMPTY
> > > > in lookup_flags.  Which bails out with -ENOENT, since getname() in there does
> > > > so.  My variant bails out with -EBADF and I'd argue that neither is correct.
> > > > 
> > > > Not sure what's the sane solution here, need to think for a while...
> > > 
> > > Fwiw, in the other thread we concluded to just not care about AT_FDCWD with "".
> > > And so far I agree with that.
> > 
> > Subject:?
> 
> https://lore.kernel.org/r/CAGudoHHdccL5Lh8zAO-0swqqRCW4GXMSXhq4jQGoVj=UdBK-Lg@mail.gmail.com
> 
> Hm, this only speaks about the NULL case.
> 
> 
> I just looked through codesearch on github and on debian and the only
> example I found was
> https://sources.debian.org/src/snapd/2.65.3-1/tests/main/seccomp-statx/test-snapd-statx/bin/statx.py/?hl=71#L71
> 
> So really, just special-case it for statx() imho instead of spreading
> that ugliness everywhere?

Not sure, TBH.  I wonder if it would be simpler to have filename_lookup()
accept NULL for pathname and have it treat that as "".

Look: all it takes is the following trick
	* add const char *pathname to struct nameidata
	* in __set_nameidata() add
        p->pathname = likely(name) ? name->name : "";
	* in path_init() replace
	const char *s = nd->name->name;
with
	const char *s = nd->pathname;
and we are done.  Oh, and teach putname() to treat NULL as no-op.

With such changes in fs/namei.c we could do
        struct filename *name = getname_maybe_null(filename, flags);

	if (!name && dfd != AT_FDCWD)
		return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);
	ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
	putname(name);
	return ret;
in statx(2) and similar in vfs_fstatat().

With that I'm not even sure we want to bother with separate
vfs_statx_fd() - the overhead might very well turn out to
be tolerable.  It is non-zero, but that's a fairly straight
trip through filename_lookup() machinery.  Would require some
profiling, though...

