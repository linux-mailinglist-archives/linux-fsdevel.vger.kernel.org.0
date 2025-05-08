Return-Path: <linux-fsdevel+bounces-48493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E8FAAFFB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 17:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500714A4AE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ADF27A475;
	Thu,  8 May 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB8DOljx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0280253345;
	Thu,  8 May 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719807; cv=none; b=s54+96zooJrrWfnExpibkJdY/aC62RI9zf1TtAmycIFARFrjGW0e6syMThJlaMjpfNYGDfKNkwUPmq4j4pxo64SkEMlXy9tWlsHtXeHsj1UL5keSefhgo2Q1TqJVA35ykqL5zuUdZkyFgWvBr3HckDM/4cizv7zZJ2/ZLudHF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719807; c=relaxed/simple;
	bh=M28pVjPHrEv/rACw6iZSY40oD1Z45F5bY/GhP8fIzGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nev9pOLLPAexidYRzI9LuBDVup4plpv/zgnY2PAOOm3BeNsGPiphE5tqu93inWlA9pFAc3lXh6iuXNY4jUEk3QY0e/o1Ufh1iNARfStOYXF/ByYUpFSFD9Z2TlEQuIHjZVKrwom7WMLnARonOizm/HCcNBSF9PBObkAfBGa2HY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB8DOljx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C06C4CEE7;
	Thu,  8 May 2025 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746719805;
	bh=M28pVjPHrEv/rACw6iZSY40oD1Z45F5bY/GhP8fIzGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SB8DOljx5L/gbsKgsDIJkdMGoXwtfwCdhXeS8geafJlSCe6ESXxMa+26O+Z4srap1
	 NBToJBpic/fvQ2NdOX44kEsjJ8aZS9kiDpG4FXlqEpG/5kJUoS/bqD95Y31K3G0zyw
	 O73HsnUCnug3uxjdygP95BZDeVw/9CI72sW/qlwfk2r/4cs2ntMcajnW0EmhHbUjO9
	 wac3FnjEexTGTm/TYtHQ/FJE6RA8xZuWVq7frHC5Xj5KprzH3aahbsNTbDCEL57ASv
	 zVbUlWCgJnyIEHfBpcL0Mh47/UdA78PDUWhErOvH0/aL3xAFSPgDhHlRCjVLGWVF6e
	 2APLxub7qfgyA==
Date: Thu, 8 May 2025 08:56:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20250508155644.GM1035866@frogsfrogsfrogs>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
 <20250424143848.GN25700@frogsfrogsfrogs>
 <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>
 <20250428190010.GB1035866@frogsfrogsfrogs>
 <CAJfpegtR28rH1VA-442kS_ZCjbHf-WDD+w_FgrAkWDBxvzmN_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtR28rH1VA-442kS_ZCjbHf-WDD+w_FgrAkWDBxvzmN_g@mail.gmail.com>

On Tue, May 06, 2025 at 06:56:29PM +0200, Miklos Szeredi wrote:
> On Mon, 28 Apr 2025 at 21:00, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > <nod> I don't know what Miklos' opinion is about having multiple
> > fusecmds that do similar things -- on the one hand keeping yours and my
> > efforts separate explodes the amount of userspace abi that everyone must
> > maintain, but on the other hand it then doesn't couple our projects
> > together, which might be a good thing if it turns out that our domain
> > models are /really/ actually quite different.
> 
> Sharing the interface at least would definitely be worthwhile, as
> there does not seem to be a great deal of difference between the
> generic one and the famfs specific one.  Only implementing part of the
> functionality that the generic one provides would be fine.

Well right now my barely functional prototype exposes this interface
for communicating mappings to the kernel.  I've only gotten as far as
exposing the ->iomap_{begin,end} and ->iomap_ioend calls to the fuse
server with no caching, because the only functions I've implemented so
far are FIEMAP, SEEK_{DATA,HOLE}, and directio.

So basically the kernel sends a FUSE_IOMAP_BEGIN command with the
desired (pos, count) file range to the fuse server, which responds with
a struct fuse_iomap_begin_out object that is translated into a struct
iomap.

The fuse server then responds with a read mapping and a write mapping,
which tell the kernel from where to read data, and where to write data.
As a shortcut, the write mapping can be of type
FUSE_IOMAP_TYPE_PURE_OVERWRITE to avoid having to fill out fields twice.

iomap_end is only called if there were errors while processing the
mapping, or if the fuse server sets FUSE_IOMAP_F_WANT_IOMAP_END.

iomap_ioend is called after read or write IOs complete, so that the
filesystem can update mapping metadata (e.g. unwritten extent
conversion, remapping after an out of place write, ondisk isize update).

Some of the flags here might not be needed or workable; I was merely
cutting and pasting the #defines from iomap.h.

#define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(0xFFFF) /* use read mapping data */
#define FUSE_IOMAP_TYPE_HOLE		0	/* no blocks allocated, need allocation */
#define FUSE_IOMAP_TYPE_DELALLOC	1	/* delayed allocation blocks */
#define FUSE_IOMAP_TYPE_MAPPED		2	/* blocks allocated at @addr */
#define FUSE_IOMAP_TYPE_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
#define FUSE_IOMAP_TYPE_INLINE		4	/* data inline in the inode */

#define FUSE_IOMAP_DEV_SBDEV		(0)	/* use superblock bdev */

#define FUSE_IOMAP_F_NEW		(1U << 0)
#define FUSE_IOMAP_F_DIRTY		(1U << 1)
#define FUSE_IOMAP_F_SHARED		(1U << 2)
#define FUSE_IOMAP_F_MERGED		(1U << 3)
#define FUSE_IOMAP_F_XATTR		(1U << 5)
#define FUSE_IOMAP_F_BOUNDARY		(1U << 6)
#define FUSE_IOMAP_F_ANON_WRITE		(1U << 7)

#define FUSE_IOMAP_F_WANT_IOMAP_END	(1U << 15) /* want ->iomap_end call */

#define FUSE_IOMAP_OP_WRITE		(1 << 0) /* writing, must allocate blocks */
#define FUSE_IOMAP_OP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
#define FUSE_IOMAP_OP_REPORT		(1 << 2) /* report extent status, e.g. FIEMAP */
#define FUSE_IOMAP_OP_FAULT		(1 << 3) /* mapping for page fault */
#define FUSE_IOMAP_OP_DIRECT		(1 << 4) /* direct I/O */
#define FUSE_IOMAP_OP_NOWAIT		(1 << 5) /* do not block */
#define FUSE_IOMAP_OP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
#define FUSE_IOMAP_OP_UNSHARE		(1 << 7) /* unshare_file_range */
#define FUSE_IOMAP_OP_ATOMIC		(1 << 9) /* torn-write protection */
#define FUSE_IOMAP_OP_DONTCACHE		(1 << 10) /* dont retain pagecache */

#define FUSE_IOMAP_NULL_ADDR		-1ULL	/* addr is not valid */

struct fuse_iomap_begin_in {
	uint32_t opflags;	/* FUSE_IOMAP_OP_* */
	uint32_t reserved;
	uint64_t ino;		/* matches st_ino provided by getattr/open */
	uint64_t pos;		/* file position, in bytes */
	uint64_t count;		/* operation length, in bytes */
};

struct fuse_iomap_begin_out {
	uint64_t offset;	/* file offset of mapping, bytes */
	uint64_t length;	/* length of both mappings, bytes */

	uint64_t read_addr;	/* disk offset of mapping, bytes */
	uint16_t read_type;	/* FUSE_IOMAP_TYPE_* */
	uint16_t read_flags;	/* FUSE_IOMAP_F_* */
	uint32_t read_dev;	/* FUSE_IOMAP_DEV_* */

	uint64_t write_addr;	/* disk offset of mapping, bytes */
	uint16_t write_type;	/* FUSE_IOMAP_TYPE_* */
	uint16_t write_flags;	/* FUSE_IOMAP_F_* */
	uint32_t write_dev;	/* FUSE_IOMAP_DEV_* */
};

struct fuse_iomap_end_in {
	uint32_t opflags;	/* FUSE_IOMAP_OP_* */
	uint32_t reserved;
	uint64_t ino;		/* matches st_ino provided iomap_begin */
	uint64_t pos;		/* file position, in bytes */
	uint64_t count;		/* operation length, in bytes */
	int64_t written;	/* bytes processed */

	uint64_t map_length;	/* length of mapping, bytes */
	uint64_t map_addr;	/* disk offset of mapping, bytes */
	uint16_t map_type;	/* FUSE_IOMAP_TYPE_* */
	uint16_t map_flags;	/* FUSE_IOMAP_F_* */
	uint32_t map_dev;	/* FUSE_IOMAP_DEV_* */
};

/* out of place write extent */
#define FUSE_IOMAP_IOEND_SHARED		(1U << 0)
/* unwritten extent */
#define FUSE_IOMAP_IOEND_UNWRITTEN	(1U << 1)
/* don't merge into previous ioend */
#define FUSE_IOMAP_IOEND_BOUNDARY	(1U << 2)
/* is direct I/O */
#define FUSE_IOMAP_IOEND_DIRECT		(1U << 3)

/* is append ioend */
#define FUSE_IOMAP_IOEND_APPEND		(1U << 15)

struct fuse_iomap_ioend_in {
	uint16_t ioendflags;	/* FUSE_IOMAP_IOEND_* */
	uint16_t reserved;
	int32_t error;		/* negative errno or 0 */
	uint64_t ino;		/* matches st_ino provided iomap_begin */
	uint64_t pos;		/* file position, in bytes */
	uint64_t addr;		/* disk offset of new mapping, in bytes */
	uint32_t written;	/* bytes processed */
	uint32_t reserved1;
};

> > (Especially because I suspect that interleaving is the norm for memory,
> > whereas we try to avoid that for disk filesystems.)
> 
> So interleaved extents are just like normal ones except they repeat,
> right?  What about adding a special "repeat last N extent
> descriptions" type of extent?

Yeah, I suppose a mapping cache could do that.  From talking to John
last week, it sounds like the mappings are supposed to be static for the
life of the file, as opposed to ext* where truncates and fallocate can
appear at any time.

One thing I forgot to ask John -- can there be multiple sets of
interleaved mappings per file?  e.g. the first 32g of a file are split
between 4 memory controllers, whereas the next 64g are split between 4
different domains?

> > > But the current implementation does not contemplate partially cached fmaps.
> > >
> > > Adding notification could address revoking them post-haste (is that why
> > > you're thinking about notifications? And if not can you elaborate on what
> > > you're after there?).
> >
> > Yeah, invalidating the mapping cache at random places.  If, say, you
> > implement a clustered filesystem with iomap, the metadata server could
> > inform the fuse server on the local node that a certain range of inode X
> > has been written to, at which point you need to revoke any local leases,
> > invalidate the pagecache, and invalidate the iomapping cache to force
> > the client to requery the server.
> >
> > Or if your fuse server wants to implement its own weird operations (e.g.
> > XFS EXCHANGE-RANGE) this would make that possible without needing to
> > add a bunch of code to fs/fuse/ for the benefit of a single fuse driver.
> 
> Wouldn't existing invalidation framework be sufficient?

I'm a little confused, are you talking about FUSE_NOTIFY_INVAL_INODE?
If so, then I think that's the wrong layer -- INVAL_INODE invalidates
the page cache, whereas I'm talking about caching the file space
mappings that iomap uses to construct bios for disk IO, and possibly
wanting to invalidate parts of that cache to force the kernel to upcall
the fuse server for a new mapping.

(Obviously this only applies to fuse servers for ondisk filesystems.)

--D

> Thanks,
> Miklos
> 

