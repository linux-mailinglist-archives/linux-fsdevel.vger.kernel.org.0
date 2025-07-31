Return-Path: <linux-fsdevel+bounces-56419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40484B17366
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4A01C24606
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B041A2632;
	Thu, 31 Jul 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYhtX+gw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2B155A30;
	Thu, 31 Jul 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973388; cv=none; b=tM1b/4prJRcg/CKFexNhkCzJqlejDHjY6k6xeKSawIpXOY6UFkrs/qAxF1emKIpQDNWnQWE4lKo2dgMX1UMihNKneeIqFTay/BGXme/e++EzUpoVmpehoSoSsp75B6K++P+kONrkOvmUcj2DosP5Juc0dsmJTp7oe7dX2vbH8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973388; c=relaxed/simple;
	bh=HflpHYTyNymyTP8oAS6k2QZVmsZLMupS9zH6VAtDJYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9aDsf5/3LVAM3ePhzsMYJvAvrnLGzZxXPg0e6CjqNQjKfeb6NznCGPKMqxaT6IasqwFU0DVvJV8/JugpIwuUPt8X7u2dmMXE1Wlm0VjG7FlGDu68oBcqtFF8ed3gb2mFCIlwqeabiYJMS7N3lsBGedfB3k/3uH6VyradnJUxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYhtX+gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EE8C4CEEF;
	Thu, 31 Jul 2025 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753973387;
	bh=HflpHYTyNymyTP8oAS6k2QZVmsZLMupS9zH6VAtDJYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYhtX+gwfXLl1M2l87YdyT3oju3HhDKo9C54fFPPozvkvye1DIM3SSBB6cl3p3ssT
	 juk9yNt0aS9j9PRNuQIunxMoIFG0r0DpaAssE9dJeVPolUc+bEmZ/plkgTdtFUeTgz
	 oObB4fNt3LW0G6gLOprJiym5/1puO/5UIZOqbcGBWBZlMN/lPbVMBgYman/TutSCjN
	 q/4pspslVF3Y1zAWkTobMoCLLlACOIAgsRVg/l0gep8s1yU3gm5zbf1vXoMH8MowtS
	 j3DMhuEH0iDab0PtJiicAK3PDQhmLDcwoOToy7ZWFS9qhIGlf6L4GBnQKCy1mqeFE4
	 zWvAzkmi0Xdlw==
Date: Thu, 31 Jul 2025 07:49:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 20/29] xfs: disable preallocations for fsverity
 Merkle tree writes
Message-ID: <20250731144947.GZ2672029@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-20-9e5443af0e34@kernel.org>
 <20250729222736.GK2672049@frogsfrogsfrogs>
 <hnpu2acy45q3v3k4sj3p3yazfqfpihh3rnvrdyh6ljgmkod6cz@poli3ifoi6my>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hnpu2acy45q3v3k4sj3p3yazfqfpihh3rnvrdyh6ljgmkod6cz@poli3ifoi6my>

On Thu, Jul 31, 2025 at 01:42:54PM +0200, Andrey Albershteyn wrote:
> On 2025-07-29 15:27:36, Darrick J. Wong wrote:
> > On Mon, Jul 28, 2025 at 10:30:24PM +0200, Andrey Albershteyn wrote:
> > > While writing Merkle tree, file is read-only and there's no further
> > > writes except Merkle tree building. The file is truncated beforehand to
> > > remove any preallocated extents.
> > > 
> > > The Merkle tree is the only data XFS will write. As we don't want XFS to
> > > truncate file after we done writing, let's also skip truncation on
> > > fsverity files. Therefore, we also need to disable preallocations while
> > > writing merkle tree as we don't want any unused extents past the tree.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  fs/xfs/xfs_iomap.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index ff05e6b1b0bb..00ec1a738b39 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -32,6 +32,8 @@
> > >  #include "xfs_rtbitmap.h"
> > >  #include "xfs_icache.h"
> > >  #include "xfs_zone_alloc.h"
> > > +#include "xfs_fsverity.h"
> > > +#include <linux/fsverity.h>
> > 
> > What do these includes pull in for the iflags tests below?
> 
> Probably need to be removed, thanks for noting
> 
> > 
> > >  #define XFS_ALLOC_ALIGN(mp, off) \
> > >  	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
> > > @@ -1849,7 +1851,9 @@ xfs_buffered_write_iomap_begin(
> > >  		 * Determine the initial size of the preallocation.
> > >  		 * We clean up any extra preallocation when the file is closed.
> > >  		 */
> > > -		if (xfs_has_allocsize(mp))
> > > +		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> > > +			prealloc_blocks = 0;
> > > +		else if (xfs_has_allocsize(mp))
> > >  			prealloc_blocks = mp->m_allocsize_blocks;
> > >  		else if (allocfork == XFS_DATA_FORK)
> > >  			prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork,
> > > @@ -1976,6 +1980,13 @@ xfs_buffered_write_iomap_end(
> > >  	if (flags & IOMAP_FAULT)
> > >  		return 0;
> > >  
> > > +	/*
> > > +	 * While writing Merkle tree to disk we would not have any other
> > > +	 * delayed allocations
> > > +	 */
> > > +	if (xfs_iflags_test(XFS_I(inode), XFS_VERITY_CONSTRUCTION))
> > > +		return 0;
> > 
> > I assume XFS_VERITY_CONSTRUCTION doesn't get set until after we've
> > locked the inode, flushed the dirty pagecache, and truncated the file to
> > EOF?  In which case I guess this is ok -- we're never going to have new
> > delalloc reservations,
> 
> yes, this is my thinking here
> 
> > and verity data can't be straddling the EOF
> > folio, no matter how large it is.  Right?
> 
> Not sure, what you mean here. In page cache merkle tree is stored
> at (1 << 53) offset, and there's check for file overlapping this in
> patch 22 xfs_fsverity_begin_enable().

Yeah, I hadn't gotten to that patch yet.  That part looks fine to me,
though I sorta wondered why not put it at offset 1<<62 to allow for even
bigger files.  But the impression I've gotten from Eric is that they
don't really want to handle files that huge with merkle trees that big
so the loss of file range address space probably doesn't matter.

--D

> -- 
> - Andrey
> 
> 

