Return-Path: <linux-fsdevel+bounces-5703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4C480EFFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4EE0B20CFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6503D75426;
	Tue, 12 Dec 2023 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WBT+Q9uQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214A683
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:21:58 -0800 (PST)
Date: Tue, 12 Dec 2023 10:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702394516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7QgFteOYbCeX2vVpxWnLWW2DbsXumaa/4I4AHoHgfU=;
	b=WBT+Q9uQoobl3Uw8HYBHbEDp2uvEChQP2I+FPAYdcb9otcqJtTyIutnsyVq8uLIxOOnnte
	VO4FJcWqN1F1tl/WkB5txnsLzZrtF88qsJ2qGNGfVKpJESvDWiyq2M05s3fNjANbeZmj8z
	eLslwUlnVDnsJKkkxAmSqv4tp6mj+sc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212152153.tasaxsrljq2zzbxe@moria.home.lan>
References: <170200162890.12910.9667703050904306180@noble.neil.brown.name>
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXf1WCrw4TPc5y7d@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 12, 2023 at 04:53:28PM +1100, Dave Chinner wrote:
> Doesn't anyone else see or hear the elephant trumpeting loudly in
> the middle of the room?
> 
> I mean, we already have name_to_handle_at() for userspace to get a
> unique, opaque, filesystem defined file handle for any given file.
> It's the same filehandle that filesystems hand to the nfsd so nfs
> clients can uniquely identify the file they are asking the nfsd to
> operate on.
> 
> The contents of these filehandles is entirely defined by the file
> system and completely opaque to the user. The only thing that
> parses the internal contents of the handle is the filesystem itself.
> Therefore, as long as the fs encodes the information it needs into the
> handle to determine what subvol/snapshot the inode belongs to when
> the handle is passed back to it (e.g. from open_by_handle_at()) then
> nothing else needs to care how it is encoded.
> 
> So can someone please explain to me why we need to try to re-invent
> a generic filehandle concept in statx when we already have a
> have working and widely supported user API that provides exactly
> this functionality?

Definitely should be part of the discussion :)

But I think it _does_ need to be in statx; because:
 - we've determined that 64 bit ino_t just isn't a future proof
   interface, we're having real problems with it today
 - statx is _the_ standard, future proofed interface for getting inode
   attributes
 - therefore, if we want userspace programmers to be using filehandles,
   instead of inode numbers, so there code isn't broken, we need to be
   providing interfaces that guide them in that direction.

Even assuming we can update all the documentation to say "filehandles
are the correct way to test inode uniqueness", you know at least half of
programmers will stick to stx_ino instead of the filehandle if the
filehandle is an extra syscall.

