Return-Path: <linux-fsdevel+bounces-5709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ECE80F10E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5186F1F20FF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA0D77F1E;
	Tue, 12 Dec 2023 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tMklP8KB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912ADAA;
	Tue, 12 Dec 2023 07:28:58 -0800 (PST)
Date: Tue, 12 Dec 2023 10:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702394936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSmYahAI1/3A8P8vC3gfszRXaL+fhFAUnbHnvxlXGHQ=;
	b=tMklP8KBZbAmG9PihUM4JU0INuK2SvNuu070eAEpmLWnT7IUHxk9P6Kc/mrz9yuiJAVpUK
	8GXkZLEw+Rq2QzLV77V1aIpjWvURFhLOlOyjbwIWQtDXDX67hJc3NWYz21EoT04jbogY0L
	GsPgDu6NASJnEsy6h4lf0PPYaAWgfvg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212152853.fvlkgstsvmryoyix@moria.home.lan>
References: <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <2810685.1702372247@warthog.procyon.org.uk>
 <20231212-ablauf-achtbar-ae6e5b15b057@brauner>
 <CAJfpegvL9kV+06v2W+5LbUk0eZr1ydfT1v0P-Pp_KexLNz=Lfg@mail.gmail.com>
 <20231212-sechzehn-hausgemacht-6eb61150554e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-sechzehn-hausgemacht-6eb61150554e@brauner>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 12, 2023 at 10:35:40AM +0100, Christian Brauner wrote:
> On Tue, Dec 12, 2023 at 10:28:12AM +0100, Miklos Szeredi wrote:
> > On Tue, 12 Dec 2023 at 10:23, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, Dec 12, 2023 at 09:10:47AM +0000, David Howells wrote:
> > > > Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > > > > > I suggest:
> > > > > > > >
> > > > > > > >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> > > > > > > >                               same inode number
> > > > >
> > > > > This is just ugly with questionable value. A constant reminder of how
> > > > > broken this is. Exposing the subvolume id also makes this somewhat redundant.
> > > >
> > > > There is a upcoming potential problem where even the 64-bit field I placed in
> > > > statx() may be insufficient.  The Auristor AFS server, for example, has a
> > > > 96-bit vnode ID, but I can't properly represent this in stx_ino.  Currently, I
> > >
> > > Is that vnode ID akin to a volume? Because if so you could just
> > > piggy-back on a subvolume id field in statx() and expose it there.
> > 
> > And how would exporting a subvolume ID and expecting userspace to take
> > that into account when checking for hard links be meaningfully
> > different than expecting userspace to retrieve the file handle and
> > compare that?
> > 
> > The latter would at least be a generic solution, including stacking fs
> > inodes, instead of tackling just a specific corner of the problem
> > space.
> 
> So taking a step back here, please. The original motivation for this
> discussion was restricted to handle btrfs - and now bcachefs as well.
> Both have a concept of a subvolume so it made sense to go that route.
> IOW, it wasn't originally a generic problem or pitched as such.
> 
> Would overlayfs be able to utilize an extended inode field as well?

No, the original motivation was not just btrfs and bcachefs; overlayfs
fundamentally needs to export a bigger identifier than the host
filesystems - pigeonhole principle, if anyone remembers their
combinatorics.

This applies to any filesystem which is under the hood reexporting from
other filesystems; there's a lot of stuff going on in container
filesystems right now, and I expect it'll come up there (you can create
new identifiers if you're exporting file by file, but not if it's
directory trees).

And Neal brought up NFS re-exports; I think there's a compelling
argument to be made that we ought to be able to round trip NFS
filehandles.

