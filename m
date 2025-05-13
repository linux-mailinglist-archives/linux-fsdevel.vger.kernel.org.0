Return-Path: <linux-fsdevel+bounces-48798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1300AB4A53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 06:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494588651A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 04:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7821DFDB9;
	Tue, 13 May 2025 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T72mnacQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A117578;
	Tue, 13 May 2025 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747109003; cv=none; b=rPmhIcPFs9fBeY1Ve3CnxivdeFXofKBIgGrSU9a3iwNy1mCt1SLSmzGndAmKFAxIhDidZp+k94M55YgQI74E18mbczKnhhjFvlahOIs2UXR3w9XZHQVe6xHR0NH7AYrP9HaPcT5BdJYUpWzGW94ChIxyAKsLXWPjyyJFU589tEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747109003; c=relaxed/simple;
	bh=D63mIX1uEjiZbr7YvIdYOs9REFfIzl+pwZg3OQ9KMxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioG2A7Oygal2ZG6pNWPZ6+xAls5SiuT5i+yysCF1NZBoTp035UcQIOIUMmUzIx3lguKxxn+wjdxFPMnzbyP4SezZy+vPYH2sJ5W1bjhRTjgsaRawYh8TUE+woKtiLu1lEXvISD0E84scNDCgCoCcKWFu7AJnei6p2GjOr3QnCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T72mnacQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0F1C4CEE4;
	Tue, 13 May 2025 04:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747109002;
	bh=D63mIX1uEjiZbr7YvIdYOs9REFfIzl+pwZg3OQ9KMxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T72mnacQywhUKudxJVYfCFotqqgLmTr6zkKKG21MPYk4l9tFIEYadNqdM/JiWcBvy
	 sTNNYHNjwRSjKEeMeibeJ6jFeaY0rUiKq0g4vjmIEpxmo2QXp4Ii3GqIpRqSejjdZd
	 y11IHvkSOdD1kcjt8EjhyFRHakmshuHPcAO24djvCEWWkBo8gdP/LmmRxb44Z+sOcQ
	 gFP1kEF7MzrE81wCWpfirHrFbbitq4zLrf0WfnuQo/CLvKYjmgv7uT6Mv1fFn/Mky+
	 dxj4HsMYoorakKZ0BPBMT+h47bb3mjLEacVPBey7ORgLOnLJ7caxd9FDVfpV8GI/ZF
	 drwbXvwsZS5iQ==
Date: Mon, 12 May 2025 21:03:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
Message-ID: <20250513040321.GO1035866@frogsfrogsfrogs>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
 <20250424143848.GN25700@frogsfrogsfrogs>
 <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>
 <20250428190010.GB1035866@frogsfrogsfrogs>
 <CAJfpegtR28rH1VA-442kS_ZCjbHf-WDD+w_FgrAkWDBxvzmN_g@mail.gmail.com>
 <aytnzv4tmp7fdvpgxdfoe2ncu7qaxlp2svsxiskfnrvdnknhmp@uu4ifgc6aj34>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aytnzv4tmp7fdvpgxdfoe2ncu7qaxlp2svsxiskfnrvdnknhmp@uu4ifgc6aj34>

On Mon, May 12, 2025 at 02:51:45PM -0500, John Groves wrote:
> On 25/05/06 06:56PM, Miklos Szeredi wrote:
> > On Mon, 28 Apr 2025 at 21:00, Darrick J. Wong <djwong@kernel.org> wrote:
> > 
> > > <nod> I don't know what Miklos' opinion is about having multiple
> > > fusecmds that do similar things -- on the one hand keeping yours and my
> > > efforts separate explodes the amount of userspace abi that everyone must
> > > maintain, but on the other hand it then doesn't couple our projects
> > > together, which might be a good thing if it turns out that our domain
> > > models are /really/ actually quite different.
> > 
> > Sharing the interface at least would definitely be worthwhile, as
> > there does not seem to be a great deal of difference between the
> > generic one and the famfs specific one.  Only implementing part of the
> > functionality that the generic one provides would be fine.
> 
> Agreed. I'm coming around to thinking the most practical approach would be
> to share the GET_FMAP message/response, but to add a separate response
> format for Darrick's use case - when the time comes. In this patch set, 
> that starts with 'struct fuse_famfs_fmap_header' and is followed by the 
> approriate extent structures, serialized in the message. Collectively 
> that's an fmap in message format.

Well in that case I might as well just plumb in the pieces I need as
separate fuse commands.  fuse_args::opcode is u32, there's plenty of
space left.

> Side note: the current patch set sends back the logically-variable-sized 
> fmap in a fixed-size message, but V2 of the series will address that; 
> I got some help from Bernd there, but haven't finished it yet.
> 
> So the next version of the patch set would, say, add a more generic first
> 'struct fmap_header' that would indicate whether the next item would be
> 'struct fuse_famfs_fmap_header' (i.e. my/famfs metadata) or some other
> to be codified metadata format. I'm going here because I'm dubious that
> we even *can* do grand-unified-fmap-metadata (or that we should try).
> 
> This will require versioning the affected structures, unless we think
> the fmap-in-message structure can be opaque to the rest of fuse. @miklos,
> is there an example to follow regarding struct versioning in 
> already-existing fuse structures?

/me is a n00b, but isn't that a simple matter of making sure that new
revisions change the structure size, and then you can key off of that?

> > > (Especially because I suspect that interleaving is the norm for memory,
> > > whereas we try to avoid that for disk filesystems.)
> > 
> > So interleaved extents are just like normal ones except they repeat,
> > right?  What about adding a special "repeat last N extent
> > descriptions" type of extent?
> 
> It's a bit more than that. The comment at [1] makes it possible to understand
> the scheme, but I'd be happy to talk through it with you on a call if that
> seems helpful.
> 
> An interleaved extent stripes data spread across N memory devices in raid 0
> format; the space from each device is described by a single simple extent 
> (so it's contigous), but it's not consumed contiguously - it's consumed in 
> fixed-sized chunks that precess across the devices. Notwithstanding that I 
> couldn't explain it very well when we talked about it at LPC, I think I 
> could make it pretty clear in a pretty brief call now.
> 
> In any case, you have my word that it's actually quite elegant :D
> (seriously, but also with a smile...)

Admittedly the more I think about the interleaving in famfs vs straight
block mappings for disk filesystems, the more I think they ought to be
separate interfaces for code that solves different problems.  Then both
our codebases will remain relatively cohesive.

> > > > But the current implementation does not contemplate partially cached fmaps.
> > > >
> > > > Adding notification could address revoking them post-haste (is that why
> > > > you're thinking about notifications? And if not can you elaborate on what
> > > > you're after there?).
> > >
> > > Yeah, invalidating the mapping cache at random places.  If, say, you
> > > implement a clustered filesystem with iomap, the metadata server could
> > > inform the fuse server on the local node that a certain range of inode X
> > > has been written to, at which point you need to revoke any local leases,
> > > invalidate the pagecache, and invalidate the iomapping cache to force
> > > the client to requery the server.
> > >
> > > Or if your fuse server wants to implement its own weird operations (e.g.
> > > XFS EXCHANGE-RANGE) this would make that possible without needing to
> > > add a bunch of code to fs/fuse/ for the benefit of a single fuse driver.
> > 
> > Wouldn't existing invalidation framework be sufficient?
> > 
> > Thanks,
> > Miklos
> 
> My current thinking is that Darrick's use case doesn't need GET_DAXDEV, but
> famfs does. I think Darrick's use case has one backing device, and that should
> be passed in at mount time. Correct me if you think that might be wrong.

Technically speaking iomap can operate on /any/ block or dax device as
long as you have a reference to them.  Once I get more of the plumbing
sorted out I'll start thinking about how to handle multi-device
filesystems like XFS which can put file data on more than 1 block
device.

I was thinking that the fuse server could just send a REGISTER_DEVICE
notification to the fuse driver (I know, again with the notifications
:)), the kernel replies with a magic cookie, and that's what gets passed
in the {read,write,map}_dev field.

Right now I reconfigured fuse2fs to present itself as a "fuseblk" driver
so that at least we know that inode->i_sb->s_bdev is a valid pointer.
It turns out to be useful because the kernel sends FUSE_DESTROY commands
synchronously during unmount, which avoids the situation where umount
exits but the block device still can't be opened O_EXCL because the fuse
server program is still exiting.  It may be useful for some day wiring
up some of the block device ops to fuse servers.  Though I think it
might conflict with CONFIG_BLK_DEV_WRITE_MOUNTED=y

I just barely got directio writes and pagecache read/write working
through iomap today, though I'm still getting used to the fuse inode
locking model and sorting through the bugs. :)

(I wonder how nasty would it be to pass fds to the fuse kernel driver
from fuseblk servers?)

> Famfs doesn't necessarily have just one backing dev, which means that famfs
> could pass in the *primary* backing dev at mount time, but it would still
> need GET_DAXDEV to get the rest. But if I just use GET_FMAP every time, I
> only need one way to do this.
> 
> I'll add a few more responses to Darrick's reply...

Hehhe onto that message go I.

--D

> 
> Thanks,
> John
> 
> [1] https://github.com/cxl-micron-reskit/famfs-linux/blob/c57553c4ca91f0634f137285840ab25be8a87c30/fs/fuse/famfs_kfmap.h#L13
> 
> 

