Return-Path: <linux-fsdevel+bounces-5760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7FC80FA79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09955281BA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD661173C;
	Tue, 12 Dec 2023 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n/b+tnCG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C6BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 14:39:33 -0800 (PST)
Date: Tue, 12 Dec 2023 17:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702420771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgYoidaoXbbUrHkaN5T3OD6QdBRhdSPteK25e76NSzs=;
	b=n/b+tnCGLD9WlBiksfAQeamypTQzbnQDpDp2hCzm6h6YLNXkft6W1nFnWEPicCYP3BC7Kk
	5cGEBap6yxZPeGLpitzJzO+iD8eB5rbEBrgKBGRr/IxsqZ3XVKqbzGABC6AiW7fbCgkmiI
	NdFEnfOkN063m/HTtTYbQzoK9Vm9moM=
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
Message-ID: <20231212223927.comwbwcmpvrd7xk4@moria.home.lan>
References: <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>
 <20231212152016.GB142380@mit.edu>
 <0b4c01da2d1e$cf65b930$6e312b90$@mindspring.com>
 <ZXjJyoJQFgma+lXF@dread.disaster.area>
 <170241826315.12910.12856411443761882385@noble.neil.brown.name>
 <ZXjdVvE9W45KOrqe@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXjdVvE9W45KOrqe@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 13, 2023 at 09:23:18AM +1100, Dave Chinner wrote:
> On Wed, Dec 13, 2023 at 08:57:43AM +1100, NeilBrown wrote:
> > On Wed, 13 Dec 2023, Dave Chinner wrote:
> > > On Tue, Dec 12, 2023 at 09:15:29AM -0800, Frank Filz wrote:
> > > > > On Tue, Dec 12, 2023 at 10:10:23AM +0100, Donald Buczek wrote:
> > > > > > On 12/12/23 06:53, Dave Chinner wrote:
> > > > > >
> > > > > > > So can someone please explain to me why we need to try to re-invent
> > > > > > > a generic filehandle concept in statx when we already have a have
> > > > > > > working and widely supported user API that provides exactly this
> > > > > > > functionality?
> > > > > >
> > > > > > name_to_handle_at() is fine, but userspace could profit from being
> > > > > > able to retrieve the filehandle together with the other metadata in a
> > > > > > single system call.
> > > > > 
> > > > > Can you say more?  What, specifically is the application that would want
> > > > to do
> > > > > that, and is it really in such a hot path that it would be a user-visible
> > > > > improveable, let aloine something that can be actually be measured?
> > > > 
> > > > A user space NFS server like Ganesha could benefit from getting attributes
> > > > and file handle in a single system call.
> > > 
> > > At the cost of every other application that doesn't need those
> > > attributes.
> > 
> > Why do you think there would be a cost?
> 
> It's as much maintenance and testing cost as it is a runtime cost.
> We have to test and check this functionality works as advertised,
> and we have to maintain that in working order forever more. That's
> not free, especially if it is decided that the implementation needs
> to be hyper-optimised in each individual filesystem because of
> performance cost reasons.
> 
> Indeed, even the runtime "do we need to fetch this information"
> checks have a measurable cost, especially as statx() is a very hot
> kernel path. We've been optimising branches out of things like
> setting up kiocbs because when that path is taken millions of times
> every second each logic branch that decides if something needs to be
> done or not has a direct measurable cost. statx() is a hot path that
> can be called millions of times a second.....

Like Neal mentioned we won't even be fetching the fh if it wasn't
explicitly requested - and like I mentioned, we can avoid the
.encode_fh() call for local filesystems with a bit of work at the VFS
layer.

OTOH, when you're running rsync in incremental mode, and detecting
hardlinks, your point that "statx can be called millions of times per
second" would apply just as much to the additional name_to_handle_at()
call - we'd be nearly doubling their overhead for scanning files that
don't need to be sent.

> And then comes the cost of encoding dynamically sized information in
> struct statx - filehandles are not fixed size - and statx is most
> definitely not set up or intended for dynamically sized attribute
> data. This adds more complexity to statx because it wasn't designed
> or intended to handle dynamically sized attributes. Optional
> attributes, yes, but not attributes that might vary in size from fs
> to fs or even inode type to inode type within a fileystem (e.g. dir
> filehandles can, optionally, encode the parent inode in them).

Since it looks like expanding statx is not going to be quite as easy as
hoped, I proposed elsewhere in the thread that we reserve a smaller
fixed size in statx (32 bytes) and set a flag if it won't fit,
indicating that userspace needs to fall back to name_to_handle_at().

Stuffing a _dynamically_ sized attribute into statx would indeed be
painful - I believe were always talking about a fixed size buffer in
statx, the discussion's been over how big it needs to be...

