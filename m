Return-Path: <linux-fsdevel+bounces-29154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346339767F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 13:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E721C2159D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E1419F11E;
	Thu, 12 Sep 2024 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp1O3mRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AD145B14;
	Thu, 12 Sep 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140764; cv=none; b=dBmBGOwgh6uysXMxj9CPPXJ/S2uAJAY8pWOfD41xqp0AIuNSlKlPT1K+a/Ohpq5BgLsT9NNdsi8zOKMeyX3cW25O56+ejZ0xJc4YJeZ6oQRhRwrFwLT4VK1nKRmlM86KpbfxmxXadDJss2SSnsmlnW3EWtcSl1zAR4o1ng+cvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140764; c=relaxed/simple;
	bh=BC7Rtm/KlFhi0b4+rYUch3KQ+o2GR0Cgc3H/ROsGGKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZfID04PKnwI+R0NsXYk+VRBYEJ/jkWVu/J0P4e5Vfz/HTcNuqgDP4KHs9qRx0TCA05FL4wR9RU6dKL4AtvFNLlKiRAosNuokRm9VE2Rp5mLx4hN5DSgpEeCQJ+V05FWVkfaWzUnCO8MaW+y0zg8/tOEiJ5jOBsJ6GRvA5jxA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp1O3mRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB4AC4CEC4;
	Thu, 12 Sep 2024 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726140763;
	bh=BC7Rtm/KlFhi0b4+rYUch3KQ+o2GR0Cgc3H/ROsGGKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kp1O3mRpa7tXevp3M7cInSrve7QGPU3Ch4AdhUHXIwZdSahtNFjoZP5HeVlMfsCha
	 DHWllQA5Dj8oq5WFjva8H+3b00faKrNmZOsu0VmaT6xlqklIZkU6HWLfmSBHk3Ajmj
	 aDixf6whAP3PYkfJ1kOoFVgteKAatbjyk2lbjYA/OcD448juAqin3eQv0SO9mH2hlN
	 +LVBeQrIGMFpVrDbPNcnJmK+lXLaa62p8upNjPppuy/2VKMPivMQsk50LpIk8d7FRV
	 FgAt311WOXWBq5woOpNaDM9qo1e9QTE05RVPe9dFA5AZTj4OtTPu5auyqnMHrizrYl
	 i/3p5G0/fZu0Q==
Date: Thu, 12 Sep 2024 13:32:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, 
	Benjamin Coddington <bcodding@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Neil Brown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexander Ahring Oder Aring <aahringo@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Message-ID: <20240912-akkreditieren-montag-8e935460169d@brauner>
References: <cover.1726083391.git.bcodding@redhat.com>
 <f798d5225cc52ec227b4458f3313f1908c471984.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f798d5225cc52ec227b4458f3313f1908c471984.camel@kernel.org>

On Thu, Sep 12, 2024 at 07:08:07AM GMT, Jeff Layton wrote:
> On Wed, 2024-09-11 at 15:42 -0400, Benjamin Coddington wrote:
> > Last year both GFS2 and OCFS2 had some work done to make their locking more
> > robust when exported over NFS.  Unfortunately, part of that work caused both
> > NLM (for NFS v3 exports) and kNFSD (for NFSv4.1+ exports) to no longer send
> > lock notifications to clients.
> > 
> > This in itself is not a huge problem because most NFS clients will still
> > poll the server in order to acquire a conflicted lock, but now that I've
> > noticed it I can't help but try to fix it because there are big advantages
> > for setups that might depend on timely lock notifications, and we've
> > supported that as a feature for a long time.
> > 
> > Its important for NLM and kNFSD that they do not block their kernel threads
> > inside filesystem's file_lock implementations because that can produce
> > deadlocks.  We used to make sure of this by only trusting that
> > posix_lock_file() can correctly handle blocking lock calls asynchronously,
> > so the lock managers would only setup their file_lock requests for async
> > callbacks if the filesystem did not define its own lock() file operation.
> > 
> > However, when GFS2 and OCFS2 grew the capability to correctly
> > handle blocking lock requests asynchronously, they started signalling this
> > behavior with EXPORT_OP_ASYNC_LOCK, and the check for also trusting
> > posix_lock_file() was inadvertently dropped, so now most filesystems no
> > longer produce lock notifications when exported over NFS.
> > 
> > I tried to fix this by simply including the old check for lock(), but the
> > resulting include mess and layering violations was more than I could accept.
> > There's a much cleaner way presented here using an fop_flag, which while
> > potentially flag-greedy, greatly simplifies the problem and grooms the
> > way for future uses by both filesystems and lock managers alike.
> > 
> > Criticism welcomed,
> > Ben
> > 
> > Benjamin Coddington (4):
> >   fs: Introduce FOP_ASYNC_LOCK
> >   gfs2/ocfs2: set FOP_ASYNC_LOCK
> >   NLM/NFSD: Fix lock notifications for async-capable filesystems
> >   exportfs: Remove EXPORT_OP_ASYNC_LOCK
> > 
> >  Documentation/filesystems/nfs/exporting.rst |  7 -------
> >  fs/gfs2/export.c                            |  1 -
> >  fs/gfs2/file.c                              |  2 ++
> >  fs/lockd/svclock.c                          |  5 ++---
> >  fs/nfsd/nfs4state.c                         | 19 ++++---------------
> >  fs/ocfs2/export.c                           |  1 -
> >  fs/ocfs2/file.c                             |  2 ++
> >  include/linux/exportfs.h                    | 13 -------------
> >  include/linux/filelock.h                    |  5 +++++
> >  include/linux/fs.h                          |  2 ++
> >  10 files changed, 17 insertions(+), 40 deletions(-)
> > 
> 
> Thanks for fixing this up, Ben!
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

It might be a bit late for v6.12 so I would stuff this into a branch for
v6.13. Sound ok?

