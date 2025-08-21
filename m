Return-Path: <linux-fsdevel+bounces-58699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5247B30931
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98213B8C09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C72E0916;
	Thu, 21 Aug 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5jlZnGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EC21765B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815239; cv=none; b=PtVri601LFSH7oVtOO/YzcjduzNqFb2r+70xhAWEuicY+jAC/5NECtXoyzl5PSJdASAY2oz8bH0GLyj/liVuHd6RsDjBMN+0QWX51qPTPBQ87si9q4KgDSJThK+eIraEDGKeIamFIjKm+zdJgpvOq0aqUIdgD46PzwZenFL1Bno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815239; c=relaxed/simple;
	bh=6aYsXwTKAQzNJ7EQ4OMKgZKrrG+zLq35VVE/uSBmlKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ7DIwoEomN7jrncNPfAbgFdm2h1Akm8NjJnl+DaVrIjvRKXl0tkkxC1/AS6LNegfQ3/RHgH0oD6p5NA0LSjHZfTmXHvAHG8kQuFWom7iZUt8kWkEPI1Ja49EkC+7cEy4XPaDlkvRQgK/2wAoJcTNrbvktLWBJsBY8UTgmLhGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5jlZnGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD44C4CEEB;
	Thu, 21 Aug 2025 22:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755815239;
	bh=6aYsXwTKAQzNJ7EQ4OMKgZKrrG+zLq35VVE/uSBmlKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5jlZnGjJMaR5p6qx/fTvZAbcUZlJkUhx8JH5NQtb0qibopniMgDydIalvBNABo2W
	 f5MkpaMNlxvaxQilE18P5W8wGorP+u7DFES79XacEOIXeqqE524x06ZnAS7v0+aiRS
	 Y9srcgIHASF2GYpj1BCP+9+cixeKdsKnNaTkrRGldMOJ0VBEZEbP9xJU8sXzJaBmXx
	 citnF+n7Up2mjOPCM4hdeDmhhdFbh21Y+QChumcxP8Vonbmp0yif3U9oXHGMQwj7P4
	 v4NvJ2MWdx+/roP2k7I0PEVNCDxJgRIc3a1+O+OegKGWE1E2ZVCUc4Rg6FOMt9Q8bt
	 C3i3EEHyFvrlw==
Date: Thu, 21 Aug 2025 15:27:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, John@groves.net, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
Message-ID: <20250821222718.GP7981@frogsfrogsfrogs>
References: <175573710975.19062.7329425679466983566.stgit@frogsfrogsfrogs>
 <175573710994.19062.1523403126247996321.stgit@frogsfrogsfrogs>
 <9730e948-75ca-4259-9344-cee4742e27cc@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9730e948-75ca-4259-9344-cee4742e27cc@bsbernd.com>

On Thu, Aug 21, 2025 at 11:39:25PM +0200, Bernd Schubert wrote:
> 
> 
> On 8/21/25 03:01, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > fuse.h and fuse_lowlevel.h are public headers, don't expose internal
> > build system config variables to downstream clients.  This can also lead
> > to function pointer ordering issues if (say) libfuse gets built with
> > HAVE_STATX but the client program doesn't define a HAVE_STATX.
> > 
> > Get rid of the conditionals in the public header files to fix this.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  include/fuse.h           |    2 --
> >  include/fuse_lowlevel.h  |    2 --
> >  example/memfs_ll.cc      |    2 +-
> >  example/passthrough.c    |    2 +-
> >  example/passthrough_fh.c |    2 +-
> >  example/passthrough_ll.c |    2 +-
> >  6 files changed, 4 insertions(+), 8 deletions(-)
> > 
> > 
> > diff --git a/include/fuse.h b/include/fuse.h
> > index 06feacb070fbfb..209102651e9454 100644
> > --- a/include/fuse.h
> > +++ b/include/fuse.h
> > @@ -854,7 +854,6 @@ struct fuse_operations {
> >  	 */
> >  	off_t (*lseek) (const char *, off_t off, int whence, struct fuse_file_info *);
> >  
> > -#ifdef HAVE_STATX
> >  	/**
> >  	 * Get extended file attributes.
> >  	 *
> > @@ -865,7 +864,6 @@ struct fuse_operations {
> >  	 */
> >  	int (*statx)(const char *path, int flags, int mask, struct statx *stxbuf,
> >  		     struct fuse_file_info *fi);
> > -#endif
> >  };
> >  
> >  /** Extra context that may be needed by some filesystems
> > diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> > index 844ee710295973..8d87be413bfe37 100644
> > --- a/include/fuse_lowlevel.h
> > +++ b/include/fuse_lowlevel.h
> > @@ -1327,7 +1327,6 @@ struct fuse_lowlevel_ops {
> >  	void (*tmpfile) (fuse_req_t req, fuse_ino_t parent,
> >  			mode_t mode, struct fuse_file_info *fi);
> >  
> > -#ifdef HAVE_STATX
> >  	/**
> >  	 * Get extended file attributes.
> >  	 *
> > @@ -1343,7 +1342,6 @@ struct fuse_lowlevel_ops {
> >  	 */
> >  	void (*statx)(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
> >  		      struct fuse_file_info *fi);
> > -#endif
> >  };
> >  
> >  /**
> > diff --git a/example/memfs_ll.cc b/example/memfs_ll.cc
> > index edda34b4e43d39..7055a434a439cd 100644
> > --- a/example/memfs_ll.cc
> > +++ b/example/memfs_ll.cc
> > @@ -6,7 +6,7 @@
> >    See the file GPL2.txt.
> >  */
> >  
> > -#define FUSE_USE_VERSION 317
> > +#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
> >  
> >  #include <algorithm>
> >  #include <stdio.h>
> > diff --git a/example/passthrough.c b/example/passthrough.c
> > index fdaa19e331a17d..1f09c2dc05df1e 100644
> > --- a/example/passthrough.c
> > +++ b/example/passthrough.c
> > @@ -23,7 +23,7 @@
> >   */
> >  
> >  
> > -#define FUSE_USE_VERSION 31
> > +#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
> >  
> >  #define _GNU_SOURCE
> >  
> > diff --git a/example/passthrough_fh.c b/example/passthrough_fh.c
> > index 0d4fb5bd4df0d6..6403fbb74c7759 100644
> > --- a/example/passthrough_fh.c
> > +++ b/example/passthrough_fh.c
> > @@ -23,7 +23,7 @@
> >   * \include passthrough_fh.c
> >   */
> >  
> > -#define FUSE_USE_VERSION 31
> > +#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
> >  
> >  #define _GNU_SOURCE
> >  
> > diff --git a/example/passthrough_ll.c b/example/passthrough_ll.c
> > index 5ca6efa2300abe..8a5ac2e9226b59 100644
> > --- a/example/passthrough_ll.c
> > +++ b/example/passthrough_ll.c
> > @@ -35,7 +35,7 @@
> >   */
> >  
> >  #define _GNU_SOURCE
> > -#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 12)
> > +#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
> >  
> >  #include <fuse_lowlevel.h>
> >  #include <unistd.h>
> > 
> 
> 
> Thanks, I'm going to apply it to libfuse tomorrow. I think the version
> update in the examples is not strictly needed, but doesn't hurt either.

Thank you!

Yeah, I don't think the examples updates are strictly necessary either,
but the examples might as well give full access to someone who wants to
copy-paste them into a new server.

--D

> 
> Thanks,
> Bernd

