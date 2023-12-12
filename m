Return-Path: <linux-fsdevel+bounces-5747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C580F91E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E24282145
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 21:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553E963C0F;
	Tue, 12 Dec 2023 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mnmoRQ6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFACFBC
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 13:23:10 -0800 (PST)
Date: Tue, 12 Dec 2023 16:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702416189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ze7N0LeK5GhFMp2EMwYyvls3BUByEPoaw58P0BU78GU=;
	b=mnmoRQ6c9TEYeBKy1kmxj0IKiJnIMeuxbHKBWQeOTpA9dHCPQBKrLB/4LuwAfid/trUMzx
	DLFNwd3nZpSwWdEdEGrraZqe7Ak6NMTGbMNY/2urOPc/r7DCd+TArS0UrwG4fx2rRgyt/4
	9tsw3jqpZBaN+lc9YYFJ3j49iwuT9VQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212212306.tpaw7nfubbuogglw@moria.home.lan>
References: <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <20231212152153.tasaxsrljq2zzbxe@moria.home.lan>
 <ZXjHEPn3DfgQNoms@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXjHEPn3DfgQNoms@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 13, 2023 at 07:48:16AM +1100, Dave Chinner wrote:
> On Tue, Dec 12, 2023 at 10:21:53AM -0500, Kent Overstreet wrote:
> > On Tue, Dec 12, 2023 at 04:53:28PM +1100, Dave Chinner wrote:
> > > Doesn't anyone else see or hear the elephant trumpeting loudly in
> > > the middle of the room?
> > > 
> > > I mean, we already have name_to_handle_at() for userspace to get a
> > > unique, opaque, filesystem defined file handle for any given file.
> > > It's the same filehandle that filesystems hand to the nfsd so nfs
> > > clients can uniquely identify the file they are asking the nfsd to
> > > operate on.
> > > 
> > > The contents of these filehandles is entirely defined by the file
> > > system and completely opaque to the user. The only thing that
> > > parses the internal contents of the handle is the filesystem itself.
> > > Therefore, as long as the fs encodes the information it needs into the
> > > handle to determine what subvol/snapshot the inode belongs to when
> > > the handle is passed back to it (e.g. from open_by_handle_at()) then
> > > nothing else needs to care how it is encoded.
> > > 
> > > So can someone please explain to me why we need to try to re-invent
> > > a generic filehandle concept in statx when we already have a
> > > have working and widely supported user API that provides exactly
> > > this functionality?
> > 
> > Definitely should be part of the discussion :)
> > 
> > But I think it _does_ need to be in statx; because:
> >  - we've determined that 64 bit ino_t just isn't a future proof
> >    interface, we're having real problems with it today
> >  - statx is _the_ standard, future proofed interface for getting inode
> >    attributes
> 
> No, it most definitely isn't, and statx was never intended as a
> dumping ground for anything and everything inode related. e.g. Any
> inode attribute that can be modified needs to use a different
> interface - one that has a corresponding "set" operation.

And here I thought the whole point of statx was to be an extensible way
to request any sort of inode attribute.

> >  - therefore, if we want userspace programmers to be using filehandles,
> >    instead of inode numbers, so there code isn't broken, we need to be
> >    providing interfaces that guide them in that direction.
> 
> We already have a filehandle interface they can use for this
> purpose. It is already used by some userspace applications for this
> purpose.
> 
> Anything new API function do with statx() will require application
> changes, and the vast majority of applications aren't using statx()
> directly - they are using stat() which glibc wraps to statx()
> internally. So they are going to need a change of API, anyway.
> 
> So, fundamentally, there is a change of API for most applications
> that need to do thorough inode uniqueness checks regardless of
> anything else. They can do this right now - just continue using
> stat() as they do right now, and then use name_to_filehandle_at()
> for uniqueness checks.
> 
> > Even assuming we can update all the documentation to say "filehandles
> > are the correct way to test inode uniqueness", you know at least half of
> > programmers will stick to stx_ino instead of the filehandle if the
> > filehandle is an extra syscall.
> 
> Your argument is "programmers suck so we must design for the
> lowest common denominator". That's an -awful- way to design APIs.

No, I'm saying if the old way doing things no longer works, we ought to
make the new future proofed way as ergonomic and easy to use as the old
way was - else it won't get used.

At the _very_ least we need to add a flag to statx for "inode number is
unreliable for uniqueness checks".

bcachefs could leave this off until the first snapshot has been taken.

But even with that option, I think we ought to be telling anyone doing
uniqueness checks to use the filehandle, because it includes i_generation.

> Further, this "programmers suck" design comes at a cost to every
> statx() call that does not need filehandles. That's the vast
> majority of statx() calls that are made on a system. Why should we
> slow down statx() for all users when so few applications actually
> need uniqueness and they can take the cost of robust uniqueness
> tests with an extra syscall entirely themselves?

For any local filesystem the filehandle is going to be the inode
generation number, the subvolume ID (if applicable), and the inode
number. That's 16 bytes on bcachefs, and if we make an attempt to
standardize how this works across filesystems we should be able to do it
without adding a new indirect function call to the statx() path. That
sounds pretty negligable to me.

The syscall overhead isn't going to be negligable when an application
has to do lots of scanning to find the files its interested - rsync.

