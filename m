Return-Path: <linux-fsdevel+bounces-58392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639DAB2E0A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 17:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4C2B643E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628F327791;
	Wed, 20 Aug 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7cWBJ7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A68322C95
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702559; cv=none; b=UqjMfHG1QN3Tl/qhEM/ZvGTlbB9iVY6ZNiab32p8HR0rBRwlyYq6dQ0uHjaDrNHEMlw72bupfbjMrrHKcd9gV2EMAgfMsQoVEmJM3UX8DEziBcKGB4ydB35l37ntC4KESHJlIHYovVcThSt5SjnX/ylirPW6VSX+E6wHAuRrEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702559; c=relaxed/simple;
	bh=PN4EFUTHRBP54dg39SWgOY3/hwCnfw4bc/Jj4n+45Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3Ce2ShzyEVk0xB4jsZ6dSaCkCZb9hD19pqjJlGogP0En7bIqAn84tNkPNpoJvgCkAkPQYvxHcNuEFvh1lEzX/5NCHUJrQ9hqZBs0PYiZDCMa5M3q/WKbTx/7C0kCSibq4kbe8TcUxJQyeVbM+79D014TVWwwaR5NOZ5Yuoitoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7cWBJ7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893D7C4CEEB;
	Wed, 20 Aug 2025 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755702558;
	bh=PN4EFUTHRBP54dg39SWgOY3/hwCnfw4bc/Jj4n+45Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7cWBJ7W9pHf2L0zL8E75xvcjhNWJ0wUAUEPyQjaQ15CXAFMIyJhGd4pINe8bpIZP
	 u/A2g0hFXmyKpu7HFFaYF9D09XhDvSscnFElsGJzmVEx8cdZqWaLE5W8Rr2eMIsaFz
	 s5Mwd6uCKnn8SCyCs6YrchSE1e2ocg4gDP3WThtiWZEgvbdXdi9ZrQaZpLaCPt0Ngo
	 gfX+C98Wz2WlKJjOWI5GMLoxgxRenqmZ/VWgOtYeqfQhAN4ijYNid5fVOQvKiU+vG4
	 tY2pfsATWzigFD3uXEQyj6q7udPUG56BZC/Mhnyzy4x8pETcVNuft1ZHIBNFINcpbM
	 aBtLTAkDDkJfA==
Date: Wed, 20 Aug 2025 08:09:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250820150918.GK7981@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
 <20250818200155.GA7942@frogsfrogsfrogs>
 <CAJfpegtC4Ry0FeZb_13DJuTWWezFuqR=B8s=Y7GogLLj-=k4Sg@mail.gmail.com>
 <20250819225127.GI7981@frogsfrogsfrogs>
 <CAJfpegt38osEYbDYUP64+qY5j_y9EZBeYFixHgc=TDn=2n7D4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt38osEYbDYUP64+qY5j_y9EZBeYFixHgc=TDn=2n7D4w@mail.gmail.com>

On Wed, Aug 20, 2025 at 11:16:42AM +0200, Miklos Szeredi wrote:
> On Wed, 20 Aug 2025 at 00:51, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Something like this, maybe?
> >
> > #define FUSE_UNCACHED_STATX_MASK        (STATX_DIOALIGN | \
> >                                          STATX_SUBVOL | \
> >                                          STATX_WRITE_ATOMIC)
> >
> > and then in fuse_update_get_attr,
> >
> >         if (!request_mask)
> >                 sync = false;
> >         else if (request_mask & FUSE_UNCACHED_STATX_MASK) {
> >                 if (flags & AT_STATX_DONT_SYNC) {
> >                         request_mask &= ~FUSE_UNCACHED_STATX_MASK;
> >                         sync = false;
> >                 } else {
> >                         sync = true;
> >                 }
> >         } else if (flags & AT_STATX_FORCE_SYNC)
> >                 sync = true;
> >         else if (flags & AT_STATX_DONT_SYNC)
> >                 sync = false;
> >         else if (request_mask & inval_mask & ~cache_mask)
> >                 sync = true;
> >         else
> >                 sync = time_before64(fi->i_time, get_jiffies_64());
> 
> Yes.
> 
> > Way back in 2017, dhowells implied that it synchronises the attributes
> > with the backing store in the same way that network filesystems do[1].
> > But the question is, does fuse count as a network fs?
> >
> > I guess it does.  But the discussion from 2016 also provided "this is
> > very filesystem specific" so I guess we can do whatever we want??  XFS
> > and ext4 ignore that value.  The statx(2) manpage repeats that "whatever
> > stat does" language, but the stat(2) and stat(3) manpages don't say a
> > darned thing.

Ohhh, only now I noticed that it's one of those trickster flags symbols
like O_RDONLY that are #define'd to 0.  That's why there's no
(flags & SYNC_AS_STAT) anywhere in the codebase.

> Actually we can't ignore it, since it's the default (i.e. if neither
> FORCE_SYNC nor DONT_SYNC is in effect, then that implies
> SYNC_AS_STAT).
> 
> I guess the semantics you codified above make sense.  In words:
> 
> "If neither forcing nor forbidding sync, then statx shall always
> attempt to return attributes that are defined on that filesystem, but
> may return stale values."

Where is that written?  I'd like to read the rest of it to clear my
head. :)

> As an optimization of the above, the filesystem clearing the
> request_mask for these uncached attributes means that that attribute
> is not supported by the filesystem and that *can* be cheaply cached
> (e.g. clearing fi->inval_mask).

Hrmm.  I wouldn't want to set fi->inval_mask bits just because a
FUSE_STATX message ignored a mask bit one time -- imagine a filesystem
with tiered storage.  A file might be on slow hdd storage which means no
fancy things like atomic writes, but later it might get promoted to
faster nvme which does support that.

Anyway I'll send out rfcv4 today, which has the above update_get_attr
logic in it.

--D

> Thanks,
> Miklos

