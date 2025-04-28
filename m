Return-Path: <linux-fsdevel+bounces-47533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD0FA9F90E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 21:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B503BBA95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75579296D32;
	Mon, 28 Apr 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa/AnQo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB6E28C5BF;
	Mon, 28 Apr 2025 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866811; cv=none; b=Rror9QVoyaE3akyWvZCOKMAhh3hrei2rJXqiAEK3FCKIqS6NMmuxxrrnGo/2ymzNioiYRnlJQD0rNio+e5iTjexQnTxwxbX8hLxo9OCiJ/e085iar5JgaY/SxluxGujnXk8RC+Z2F2tr5CUl9wManXH2TUjm/8f0op75wmxzE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866811; c=relaxed/simple;
	bh=VOBhTYGv7U6EwTbbvDJfFalfxqXT7QXGEu4dGWzP4rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPH9hvwZRUCQXc9a6ppPLONlZLj+QUA+hsoUVZPjN/0KfSuko2b37PznxWKaJ+hoYqStehUKTEgpSbOSDFdbq2AepQlzpz4wvPeFfr8aZO082vaf1/SdIFZjOJb78fCyCBlBxtIZgu0gfhYt/aM2NYUKIDbj/91KzxbNzr3qMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa/AnQo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C882C4CEEC;
	Mon, 28 Apr 2025 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745866811;
	bh=VOBhTYGv7U6EwTbbvDJfFalfxqXT7QXGEu4dGWzP4rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oa/AnQo7UxlB/YwqdvTFZfFeOSpZnl85qblx/x2r/W4sJNe27HhO1NR2aDFfSR2J1
	 TNnETMr7LmhVYK2fvqL+PTcN1R/hGaS+s2TaGmxVQrboHIgsaz0BncvekH12e66xhc
	 Tmid+y6i9dWfMSRetHgxzt9ndOHExEJB9Zp81sgdHK+/KUvTUWsF+ckhdMLZ9WgD8A
	 wPE8qZkXge0jPt0wqErjA3JQdlrcGuHSpOfJBmXDN0dbOMqzOxe/BHeMpVr9p2rp1G
	 WyHNANrvGcgJpy1/0TqnOr5WFmpQAAYYvlxFYUlDYY6jzu4jGTdcuvItqcGiUKWKnu
	 iPQ7QYAUblv1Q==
Date: Mon, 28 Apr 2025 12:00:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
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
	Ajay Joshi <ajayjoshi@micron.com>, 0@groves.net
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
Message-ID: <20250428190010.GB1035866@frogsfrogsfrogs>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
 <20250424143848.GN25700@frogsfrogsfrogs>
 <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>

On Sun, Apr 27, 2025 at 08:48:30PM -0500, John Groves wrote:
> On 25/04/24 07:38AM, Darrick J. Wong wrote:
> > On Thu, Apr 24, 2025 at 08:43:33AM -0500, John Groves wrote:
> > > On 25/04/20 08:33PM, John Groves wrote:
> > > > On completion of GET_FMAP message/response, setup the full famfs
> > > > metadata such that it's possible to handle read/write/mmap directly to
> > > > dax. Note that the devdax_iomap plumbing is not in yet...
> > > > 
> > > > Update MAINTAINERS for the new files.
> > > > 
> > > > Signed-off-by: John Groves <john@groves.net>
> > > > ---
> > > >  MAINTAINERS               |   9 +
> > > >  fs/fuse/Makefile          |   2 +-
> > > >  fs/fuse/dir.c             |   3 +
> > > >  fs/fuse/famfs.c           | 344 ++++++++++++++++++++++++++++++++++++++
> > > >  fs/fuse/famfs_kfmap.h     |  63 +++++++
> > > >  fs/fuse/fuse_i.h          |  16 +-
> > > >  fs/fuse/inode.c           |   2 +-
> > > >  include/uapi/linux/fuse.h |  42 +++++
> > > >  8 files changed, 477 insertions(+), 4 deletions(-)
> > > >  create mode 100644 fs/fuse/famfs.c
> > > >  create mode 100644 fs/fuse/famfs_kfmap.h
> > > > 
> > 
> > <snip>
> > 
> > > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > > index d85fb692cf3b..0f6ff1ffb23d 100644
> > > > --- a/include/uapi/linux/fuse.h
> > > > +++ b/include/uapi/linux/fuse.h
> > > > @@ -1286,4 +1286,46 @@ struct fuse_uring_cmd_req {
> > > >  	uint8_t padding[6];
> > > >  };
> > > >  
> > > > +/* Famfs fmap message components */
> > > > +
> > > > +#define FAMFS_FMAP_VERSION 1
> > > > +
> > > > +#define FUSE_FAMFS_MAX_EXTENTS 2
> > > > +#define FUSE_FAMFS_MAX_STRIPS 16
> > > 
> > > FYI, after thinking through the conversation with Darrick,  I'm planning 
> > > to drop FUSE_FAMFS_MAX_(EXTENTS|STRIPS) in the next version.  In the 
> > > response to GET_FMAP, it's the structures below serialized into a message 
> > > buffer. If it fits, it's good - and if not it's invalid. When the
> > > in-memory metadata (defined in famfs_kfmap.h) gets assembled, if there is
> > > a reason to apply limits it can be done - but I don't currently see a reason
> > > do to that (so if I'm currently enforcing limits there, I'll probably drop
> > > that.
> > 
> > You could also define GET_FMAP to have an offset in the request buffer,
> > and have the famfs daemon send back the next offset at the end of its
> > reply (or -1ULL to stop).  Then the kernel can call GET_FMAP again with
> > that new offset to get more mappings.
> > 
> > Though at this point maybe it should go the /other/ way, where the fuse
> > server can sends a "notification" to the kernel to populate its mapping
> > data?  fuse already defines a handful of notifications for invalidating
> > pagecache and directory links.
> > 
> > (Ugly wart: notifications aren't yet implemented for the iouring channel)
> 
> I don't have fully-formed thoughts about notifications yet; thinking...

Me neither.  The existing ones seem like they /could/ be useful for 

> If the fmap stuff may be shared by more than one use case (as has always
> seemed possible), it's a good idea to think through a couple of things: 
> 1) is there anything important missing from this general approach, and 

Well for general iomap caching, I think we'd need to pull in a lot more
of the iomap fields:

struct fuse_iomap {
	u64		addr;	/* disk offset of mapping, bytes */
	loff_t		offset;	/* file offset of mapping, bytes */
	u64		length;	/* length of mapping, bytes */
	u16		type;	/* type of mapping */
	u16		flags;	/* flags for mapping */
	u32		devindex;
	u64		validity_cookie; /* used with .iomap_valid() */
};

fuse would use devindex to find the block_device/dax_device, but
otherwise the fields are exactly the same as struct iomap.  Given that
this is exposed to userspace we'd probably want to add some padding.

The validity cookie I'm not 100% sure about -- buffered IO uses it to
detect stale iomappings after we've locked a folio for write, having
dropped whatever locks protect the iomappings.  The ->iomap_valid
function compares the iomap::validity_cookie against some internal magic
value (this would have to be the iomap cache) to decide if revalidation
is needed.

One way to make this work is to implement the cookie entirely within the
fuse-iomap cache itself -- every time a new mapping comes in (or a range
gets invalidated) the cache bumps its cookie.  The fuse server doesn't
have to implement the cookie itself, but it will have to push a new
mapping or invalidate something every time the mappings change.

Another way would be to have the fuse server implement the cookie
itself, but now we have to find a way to have the kernel and userspace
share a piece of memory where the cookie lives.  I don't like this
option, but it does give the fuse server direct control over when the
cookie value changes.

> 2) do you need to *partially* cache fmaps? (or is the "offset" idea above 
> just to deal with an fmap that might otherwise overflow a response size?)

It's mostly to cap the amount of mapping data being copied into the
kernel in a specific GET_FMAP call.  For famfs I don't think you have
that many mappings, but for (say) an XFS filesystem there could be
billions of them.

Though at that point it might make more sense to populate the cache
piecemeal as file IO actually happens.

I wouldn't split an existing mapping, FWIW.  Think "I have 1,000,000
mappings and I'm only going to upload them 1,000 at a time", not "I'm
going to upload mappings for 100MB worth of file range at a time".

> The current approach lets the kernel retrieve and cache simple and 
> interleaved fmaps (and BTW interleaved can be multi-dev or single-dev - 
> there are current weird cases where that's useful). Also too, FWIW everything
> that can be done with simple ext list fmaps can be done with a collection
> of interleaved extents, each with strip count = 1. But I think there is a
> worthwhile clarity to having both.

<nod> I don't know what Miklos' opinion is about having multiple
fusecmds that do similar things -- on the one hand keeping yours and my
efforts separate explodes the amount of userspace abi that everyone must
maintain, but on the other hand it then doesn't couple our projects
together, which might be a good thing if it turns out that our domain
models are /really/ actually quite different.

(Especially because I suspect that interleaving is the norm for memory,
whereas we try to avoid that for disk filesystems.)

> But the current implementation does not contemplate partially cached fmaps.
> 
> Adding notification could address revoking them post-haste (is that why
> you're thinking about notifications? And if not can you elaborate on what
> you're after there?).

Yeah, invalidating the mapping cache at random places.  If, say, you
implement a clustered filesystem with iomap, the metadata server could
inform the fuse server on the local node that a certain range of inode X
has been written to, at which point you need to revoke any local leases,
invalidate the pagecache, and invalidate the iomapping cache to force
the client to requery the server.

Or if your fuse server wants to implement its own weird operations (e.g.
XFS EXCHANGE-RANGE) this would make that possible without needing to
add a bunch of code to fs/fuse/ for the benefit of a single fuse driver.

--D

> 
> > 
> > --D
> 
> Cheers,
> John
> 
> 

