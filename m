Return-Path: <linux-fsdevel+bounces-5766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75B80FBA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A511C20CEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C65259D;
	Wed, 13 Dec 2023 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JkOqALOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6B992
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 16:00:20 -0800 (PST)
Date: Tue, 12 Dec 2023 19:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702425618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O5brmE21wHS+UfHfsQ8FV9wEFHx8LOliVn+TvUeTNp0=;
	b=JkOqALOpemxHqjnTGNyGUEFI09eZ81S2glMQO23f1y/fepBGPeJjCZfAXfp6WPcvTilNnH
	ghUrg85YHSazbzv+u5Xs1uIQ9ow7V/GVa9LIMPjFSp8y2asy8Pm0OMtBLSunkzp9u1zNZ8
	yl4RYxzA08q+Zmo/sEQE0+vQiyN654o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, Frank Filz <ffilzlnx@mindspring.com>,
	'Theodore Ts'o' <tytso@mit.edu>,
	'Donald Buczek' <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	'Stefan Krueger' <stefan.krueger@aei.mpg.de>,
	'David Howells' <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx
Message-ID: <20231213000015.7x3xlufk2af55bho@moria.home.lan>
References: <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>
 <20231212152016.GB142380@mit.edu>
 <0b4c01da2d1e$cf65b930$6e312b90$@mindspring.com>
 <ZXjJyoJQFgma+lXF@dread.disaster.area>
 <170241826315.12910.12856411443761882385@noble.neil.brown.name>
 <ZXjdVvE9W45KOrqe@dread.disaster.area>
 <20231212223927.comwbwcmpvrd7xk4@moria.home.lan>
 <ZXjwR/6jfxFbLq9Y@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXjwR/6jfxFbLq9Y@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 13, 2023 at 10:44:07AM +1100, Dave Chinner wrote:
> On Tue, Dec 12, 2023 at 05:39:27PM -0500, Kent Overstreet wrote:
> > Like Neal mentioned we won't even be fetching the fh if it wasn't
> > explicitly requested - and like I mentioned, we can avoid the
> > .encode_fh() call for local filesystems with a bit of work at the VFS
> > layer.
> > 
> > OTOH, when you're running rsync in incremental mode, and detecting
> > hardlinks, your point that "statx can be called millions of times per
> > second" would apply just as much to the additional name_to_handle_at()
> > call - we'd be nearly doubling their overhead for scanning files that
> > don't need to be sent.
> 
> Hardlinked files are indicated by st_nlink > 1, not by requiring
> userspace to store every st_ino/dev it sees and having to compare
> the st-ino/dev of every newly stat()d inode against that ino/dev
> cache.
> 
> We only need ino/dev/filehandles for hardlink path disambiguation.
> 
> IOWs, this use case does not need name_to_handle_at() for millions
> of inodes - it is just needed on the regular file inodes that have
> st_nlink > 1.

Ok yeah, that's a really good point. Perhaps nanme_to_handle_at() is
sufficient, then.

If so, maybe we can just add STATX_ATTR_INUM_NOT_UNIQUE and STATX_VOL
now, and leave STATX_HANDLE until someone discovers an application where
it actually does matter.

> > > And then comes the cost of encoding dynamically sized information in
> > > struct statx - filehandles are not fixed size - and statx is most
> > > definitely not set up or intended for dynamically sized attribute
> > > data. This adds more complexity to statx because it wasn't designed
> > > or intended to handle dynamically sized attributes. Optional
> > > attributes, yes, but not attributes that might vary in size from fs
> > > to fs or even inode type to inode type within a fileystem (e.g. dir
> > > filehandles can, optionally, encode the parent inode in them).
> > 
> > Since it looks like expanding statx is not going to be quite as easy as
> > hoped, I proposed elsewhere in the thread that we reserve a smaller
> > fixed size in statx (32 bytes) and set a flag if it won't fit,
> > indicating that userspace needs to fall back to name_to_handle_at().
> 
> struct btrfs_fid is 40 bytes in size. Sure, that's not all used for
> name_to_handle_at(), but we already have in-kernel filehandles that
> can optionally configured to be bigger than 32 bytes...

The hell is all that for!? They never reuse inode numbers, why are there
generation numbers in there? And do they not have inode -> dirent
backrefs?

> > Stuffing a _dynamically_ sized attribute into statx would indeed be
> > painful - I believe were always talking about a fixed size buffer in
> > statx, the discussion's been over how big it needs to be...
> 
> The contents of the buffer is still dynamically sized, so there's
> still a length attribute that needs to be emitted to userspace with
> the buffer.

Correct

> And then what happens with the next attribute that someone wants
> statx() to expose that can be dynamically sized? Are we really
> planning to allow the struct statx to be expanded indefinitely
> with largely unused static data arrays?

Well, struct stat/statx is not a long lived object that anyone would
ever keep a lot of around; it's a short lived object that just needs to
be efficient to access and ABI stable, so yes, if this comes up again
that's what we should do.

The alternative would be adding fields with an [ offset, length ] scheme
and treating the statx buffer as a bump allocator, but simple and fast
to access beats space efficiency here...

