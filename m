Return-Path: <linux-fsdevel+bounces-5763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7BE80FB80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04C5B20EEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F3C65A9B;
	Tue, 12 Dec 2023 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xjp9WFxy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A974A6
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 15:42:07 -0800 (PST)
Date: Tue, 12 Dec 2023 18:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702424525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhEwlpoq/H4rMCIwjVPTECovw8Txs/Kao190wZWoFGg=;
	b=xjp9WFxyXZmGW8mj63ufbqCiN/VmSsIceNIO2iFyO43KHikYuEYZlsJuwsrKxPq6tv0tD2
	ct9q7OCpd3fQhBiN1hNEOrkq2qhiH9Jbw+/goYcuxuU+3DBgKMGadTUnSQPz5a09qwoBJt
	g4IVN0OpH8/HGtB9JjVOnvcUzI3XXQo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212234200.6fbcjjfrozuxnoj4@moria.home.lan>
References: <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <20231212152153.tasaxsrljq2zzbxe@moria.home.lan>
 <ZXjHEPn3DfgQNoms@dread.disaster.area>
 <20231212212306.tpaw7nfubbuogglw@moria.home.lan>
 <ZXjaWIFKvBRH7Q4c@dread.disaster.area>
 <170242027365.12910.2226609822336684620@noble.neil.brown.name>
 <ZXjnffHOo+JY/M4b@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXjnffHOo+JY/M4b@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 13, 2023 at 10:06:37AM +1100, Dave Chinner wrote:
> On Wed, Dec 13, 2023 at 09:31:13AM +1100, NeilBrown wrote:
> > On Wed, 13 Dec 2023, Dave Chinner wrote:
> > > 
> > > What you are suggesting is that we now duplicate filehandle encoding
> > > into every filesystem's statx() implementation.  That's a bad
> > > trade-off from a maintenance, testing and consistency POV because
> > > now we end up with lots of individual, filehandle encoding
> > > implementations in addition to the generic filehandle
> > > infrastructure that we all have to test and validate.
> > 
> > Not correct.  We are suggesting an interface, not an implementation.
> > Here you are proposing a suboptimal implementation, pointing out its
> > weakness, and suggesting the has consequences for the interface
> > proposal.  Is that the strawman fallacy?
> 
> No, you simply haven't followed deep enough into the rabbit hole to
> understand Kent was suggesting potential implementation details to
> address hot path performance concerns with filehandle encoding.
> 
> > vfs_getattr_nosec could, after calling i_op->getattr, check if
> > STATX_HANDLE is set in request_mask but not in ->result_mask.
> > If so it could call exportfs_encode_fh() and handle the result.
> >
> > No filesystem need to be changed.
> 
> Well, yes, it's pretty damn obvious that is exactly what I've been
> advocating for here - if we are going to put filehandles in statx(),
> then it must use the same infrastructure as name_to_handle_at().
> i.e. calling exportfs_encode_fh(EXPORT_FH_FID) to generate the
> filehandle.
> 
> The important discussion detail you've missed about
> exportfs_encode_fh() is that it *requires* adding a new indirect
> call (via export_ops->encode_fh) in the statx path to encode the
> filehandle, and that's exactly what Kent was suggesting we can code
> the implementation to avoid.
> 
> Avoiding an indirect function call is an implementation detail, not
> an interface design requirement.
> 
> And the only way to avoid adding new indirect calls to encoding
> filesystem specific filehandles is to implement the encoding in the
> existing individual filesystem i_op->getattr methods. i.e. duplicate
> the filehandle encoding in the statx path rather than use
> exportfs_encode_fh().....

I was thinking along the lines of coming up with a common fh type for
local filesystems (why exactly do we need 15?) and adding a volume ID to
the VFS inode so this could live entirely in VS code for most
filesystems, but that's an option too.

Might be the best one, since btrfs and bcachefs actually do want a
different fh type (btrfs: 64 bit subvol, 64 bit ino, bcachefs: 64 bit
ino, 32 bit subvol, 32 bit generation), and we don't want to generate a
bigger fh than necessary for when it's being consumed by a stacking
filesystem that has to generate a new fh by concatanating something.

