Return-Path: <linux-fsdevel+bounces-21474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0925904669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E481F21DEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 21:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF8F15383D;
	Tue, 11 Jun 2024 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6GuwJ7Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6352F2C;
	Tue, 11 Jun 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142651; cv=none; b=k+uViqBvo4cWd+T1NShFo5LNklXkhNNCSclxtIyoZcJR5Aq8DvMzqrQuleKNe5/1n8D7O2AFp3vbIMHIOXnnT9vlFi6ErIlc36pdf/7GeJRhRACmB09Y4KP6blLlF27Be3Yo6zabn2GVTLHD8WYb6G6LArr6RaZoPoMQPDEGnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142651; c=relaxed/simple;
	bh=owlX9Tbvul4n7xWeIc013pbQmrbY5AwkytRMZhij7xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2GYWZBhIpWy8eR2RkMS6Wir7in9jmmnIS5S0Ky2Q3wCL7bAh/GhIsgyGj4gGT4suvmoISZ9JHxudN4KIrI5r36VcFhmId4Zs+XcrTIfZlLCA6zwMYn2JqQQMJwHA1U4csv+8vH86FcqnlTD4H5Nu1hutLVqO5ZtbVEpLgrTamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6GuwJ7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EC6C2BD10;
	Tue, 11 Jun 2024 21:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718142650;
	bh=owlX9Tbvul4n7xWeIc013pbQmrbY5AwkytRMZhij7xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6GuwJ7ZG1ySYV4b5nnzaBfmxGKUJMsRfcqiNAU9dqNJP2lX6buW5ZPJtzklKqDoT
	 RG48TRPbdkJn5TTlsm5zU8NPB71YM+uHy5SUY6kutEhGHPhxiSs9wmgHzhSXIAuZ4h
	 zm3TXKuF3kSZlHBTm2Eoy1Gw6jBT/Af+IZeWEK+cL/Nu6YWLyxC4k8vAKroI6zGSyW
	 Ia745jXeCgGXcSTpP/BrQDHPKXNjvketyvgFsaWQ1Pj3lqQ3DoLhtAe5mX3LcRDGhh
	 ov+Rh1Yq4iPThkoCRGNffHHXVBwpRNgrLNGTLPuhURqdGSNwGKlI4PqU4x+MJwtL4m
	 Fvlkkdf+qMqSg==
Date: Tue, 11 Jun 2024 14:50:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to
 port
Message-ID: <20240611215049.GC52987@frogsfrogsfrogs>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <874ja118g7.fsf@gmail.com>
 <20240610231111.GW52987@frogsfrogsfrogs>
 <875xug9dyt.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xug9dyt.fsf@gmail.com>

On Tue, Jun 11, 2024 at 12:13:22PM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Mon, Jun 10, 2024 at 02:27:28PM +0530, Ritesh Harjani wrote:
> >> 
> >> Hello Darrick,
> >> 
> >> "Darrick J. Wong" <djwong@kernel.org> writes:
> >> 
> >> > From: Darrick J. Wong <djwong@kernel.org>
> >> >
> >> > This is the fourth attempt at documenting the design of iomap and how to
> >> 
> >> I agree that this isn't needed in the commit msg ("fourth attempt").
> >
> > Ok.  "Coapture the design of iomap and how to port..."
> >
> >> > port filesystems to use it.  Apologies for all the rst formatting, but
> >> > it's necessary to distinguish code from regular text.
> >> >
> >> > A lot of this has been collected from various email conversations, code
> >> > comments, commit messages, my own understanding of iomap, and
> >> > Ritesh/Luis' previous efforts to create a document.  Please note a large
> >> > part of this has been taken from Dave's reply to last iomap doc
> >> > patchset. Thanks to Ritesh, Luis, Dave, Darrick, Matthew, Christoph and
> >> > other iomap developers who have taken time to explain the iomap design
> >> > in various emails, commits, comments etc.
> >> >
> >> > Cc: Dave Chinner <david@fromorbit.com>
> >> > Cc: Matthew Wilcox <willy@infradead.org>
> >> > Cc: Christoph Hellwig <hch@infradead.org>
> >> > Cc: Christian Brauner <brauner@kernel.org>
> >> > Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >> > Cc: Jan Kara <jack@suse.cz>
> >> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> >> > Inspired-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> 
> >> I am not sure if this is even a valid or accepted tag.
> >> But sure thanks! :)
> >
> > They're freeform tags, so they can be everything everyone wants them to
> > be!  Drum circle kumbaya etc. :P
> >
> >> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> >> > ---
> >> >  Documentation/filesystems/index.rst |    1 
> >> >  Documentation/filesystems/iomap.rst | 1060 +++++++++++++++++++++++++++++++++++
> >> >  MAINTAINERS                         |    1 
> >> >  3 files changed, 1062 insertions(+)
> >> >  create mode 100644 Documentation/filesystems/iomap.rst
> >> >
> >> > diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> >> > index 8f5c1ee02e2f..b010cc8df32d 100644
> >> > --- a/Documentation/filesystems/index.rst
> >> > +++ b/Documentation/filesystems/index.rst
> >> > @@ -34,6 +34,7 @@ algorithms work.
> >> >     seq_file
> >> >     sharedsubtree
> >> >     idmappings
> >> > +   iomap
> >> >  
> >> >     automount-support
> >> >  
> >> > diff --git a/Documentation/filesystems/iomap.rst b/Documentation/filesystems/iomap.rst
> >> > new file mode 100644
> >> > index 000000000000..a478b55e4135
> >> > --- /dev/null
> >> > +++ b/Documentation/filesystems/iomap.rst
> >> > @@ -0,0 +1,1060 @@
> >> > +.. SPDX-License-Identifier: GPL-2.0
> >> > +.. _iomap:
> >> > +
> >> > +..
> >> > +        Dumb style notes to maintain the author's sanity:
> >> > +        Please try to start sentences on separate lines so that
> >> > +        sentence changes don't bleed colors in diff.
> >> > +        Heading decorations are documented in sphinx.rst.
> >> > +
> >> > +============================
> >> > +VFS iomap Design and Porting
> >> > +============================
> >> > +
> >> > +.. toctree::
> >> > +
> >> > +Introduction
> >> > +============
> >> > +
> >> > +iomap is a filesystem library for handling various filesystem operations
> >> > +that involves mapping of file's logical offset ranges to physical
> >> > +extents.
> >> > +This origins of this library is the file I/O path that XFS once used; it
> >> > +has now been extended to cover several other operations.
> >> > +The library provides various APIs for implementing various file and
> >>                         ^^^^ redundant "various"
> >> 
> >> > +pagecache operations, such as:
> >> > +
> >> > + * Pagecache reads and writes
> >> > + * Folio write faults to the pagecache
> >> > + * Writeback of dirty folios
> >> > + * Direct I/O reads and writes
> >> 
> >> Dax I/O reads and writes.
> >> ... as well please?
> >
> > It's really fsdax I/O reads, writes, loads, and stores, isn't it?
> >
> 
> It felt like dax_iomap_rw() belongs to fs/iomap. 
> But nevertheless, we could skip it if we are targetting fs/iomap/
> lib.

Logically, it does.  However, there's a fair bit of code in fs/dax.c
that is used by the iomap iterators; all of those would have to become
non-static symbols to make that separation happen.

Maybe it still should; the pagecache is already like that.

<snip>

> >> I think it is better if we describe ->iomap_begin and ->iomap_end
> >> in proper sub-sections. Otherwise this looks like we have clobbered
> >> all the information together :)
> >> 
> >> ->iomap_begin 
> >> ^^^^^^^^^^^^^^^^^
> >
> > Yes, I like the explicit section headings better.
> >
> 
> yup.
> 
> >> This either returns an existing mapping or reserve/allocates a new
> >> mapping.
> >
> > That's a filesystem specific detail -- all that iomap cares about is
> > that the fs communicates a mapping.  Maybe the fs actually had to do a
> > bunch of work to get that mapping, or maybe it's already laid out
> > statically, ala zonefs.  Either way, it's not a concern of the iomap
> > library.
> >
> >> logical file pos and length are in bytes which gets passed
> >> as function arguments. Filesystem returns the new mapping information
> >> within ``struct iomap`` which also gets passed as a function argument.
> >> Filesystems should provide the details of this mapping by filling
> >> various fields within ``struct iomap``.
> >
> > "iomap operations call ->iomap_begin to obtain one file mapping for the
> > range of bytes specified by pos and length for the file inode.  This
> > mapping should be returned through the iomap pointer.  The mapping must
> > cover at least the first byte of the supplied file range, but it does
> > not need to cover the entire requested range."
> >
> 
> I like it. Thanks for adding that detail in the last line.
> 
> >>   @srcmap agument:
> >>     Note that ->iomap_begin call has srcmap passed as another argument. This is
> >>     mainly used only during the begin phase for COW mappings to identify where
> >>     the reads are to be performed from. Filesystems needs to fill that mapping
> >>     information if iomap should read data for partially written blocks from a
> >>     different location than the write target [4].
> >>   @flags argument:
> >>     These are the operation types which iomap supports. 
> >>     IOMAP_WRITE: For doing write I/O.
> >>     <...>
> >>     IOMAP_ZERO:
> >>     IOMAP_REPORT:		
> >>     IOMAP_FAULT:		
> >>     IOMAP_DIRECT:		
> >>     IOMAP_NOWAIT:		
> >>     IOMAP_OVERWRITE_ONLY:
> >>     IOMAP_UNSHARE:
> >>     IOMAP_DAX:	
> >
> > I think it's /much/ more valuable to document the exact combinations
> > that will be passed to ->iomap_begin further down where we talk about
> > specific operations that iomap performs.
> >
> > Otherwise, someone is going to look at this list and wonder if they
> > really need to figure out what IOMAP_ZERO|IOMAP_FAULT|IOMAP_DAX means,
> > and if it's actually possible (it's not).
> >
> 
> Sure.
> 
> >> 
> >> ->iomap_end
> >> ^^^^^^^^^^^^^^^^^
> >> 
> >> Commit and/or unreserve space which was previously allocated/reserved
> >> in ``->iomap_begin``. For e.g. during buffered-io, when a short writes
> >> occurs, filesystem may need to remove the reserved space that was
> >> allocated during ->iomap_begin.
> >> For filesystems that use delalloc allocation, we may need to punch out
> >> delalloc extents from the range that are not dirty in
> >> the page cache. See comments in
> >> iomap_file_buffered_write_punch_delalloc() for more info [5][6].
> >> 
> >> (IMHO) I find above definitions more descriptive.
> >
> > I don't want to merge the general description with pagecache specific
> > areas.  They already cover punch_delalloc.
> >
> 
> sure.
> 
> >> > +
> >> > +Each iomap operation describes the requested operation through the
> >> > +``flags`` argument.
> >> > +The exact value of ``flags`` will be documented in the
> >> > +operation-specific sections below, but these principles apply generally:
> >> > +
> >> > + * For a write operation, ``IOMAP_WRITE`` will be set.
> >> > +   Filesystems must not return ``IOMAP_HOLE`` mappings.
> >> > +
> >> > + * For any other operation, ``IOMAP_WRITE`` will not be set.
> >> > +
> >> 
> >> Direct-io related operation which bypasses pagecache use IOMAP_DIRECT.
> >
> > That's covered in the pagecache/directio/dax subsection because I wanted
> > to document specific combinations that filesystem authors should expect.
> >
> 
> The points mentioned above were targetting buffered-io, dax, so I
> thought we could add direct-io related flag as well here.

Given all the confusion with the later sections I'll just remove it.

<snip>

> >> > +
> >> > +   * **IOMAP_INLINE**: The file range maps to the memory buffer
> >> > +     specified by ``inline_data``.
> >> > +     For write operation, the ``->iomap_end`` function presumably
> >> > +     handles persisting the data.
> >> 
> >> Is it? Or do we just mark the inode as dirty?
> >
> > gfs2 actually starts a transaction in ->iomap_begin and commits or
> > cancels it in ->iomap_end.
> >
> 
> ok.
> 
> >> > +     The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
> >> > +
> >> > + * ``flags`` describe the status of the space mapping.
> >> > +   These flags should be set by the filesystem in ``->iomap_begin``:
> >> > +
> >> > +   * **IOMAP_F_NEW**: The space under the mapping is newly allocated.
> >> > +     Areas that will not be written to must be zeroed.
> >> 
> >> In case of DAX, we have to invalidate those existing mappings which
> >> might have a "hole" page mapped.
> >
> > Isn't that an internal detail of the fs/dax.c code?  The filesystem
> > doesn't have to do the invalidation or even know about hole pages.
> >
> 
> Right. Sorry about that. I assumed dax_iomap_rw() implementation
> is a part of iomap :)
> 
> >> > +     If a write fails and the mapping is a space reservation, the
> >> > +     reservation must be deleted.
> >> > +
> >> > +   * **IOMAP_F_DIRTY**: The inode will have uncommitted metadata needed
> >> > +     to access any data written.
> >> > +     fdatasync is required to commit these changes to persistent
> >> > +     storage.
> >> > +     This needs to take into account metadata changes that *may* be made
> >> > +     at I/O completion, such as file size updates from direct I/O.
> >> > +
> >> > +   * **IOMAP_F_SHARED**: The space under the mapping is shared.
> >> > +     Copy on write is necessary to avoid corrupting other file data.
> >> > +
> >> > +   * **IOMAP_F_BUFFER_HEAD**: This mapping requires the use of buffer
> >> > +     heads for pagecache operations.
> >> > +     Do not add more uses of this.
> >> > +
> >> > +   * **IOMAP_F_MERGED**: Multiple contiguous block mappings were
> >> > +     coalesced into this single mapping.
> >> > +     This is only useful for FIEMAP.
> >> > +
> >> > +   * **IOMAP_F_XATTR**: The mapping is for extended attribute data, not
> >> > +     regular file data.
> >> > +     This is only useful for FIEMAP.
> >> > +
> >> > +   * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
> >> > +     be set by the filesystem for its own purposes.
> >> > +
> >> > +   These flags can be set by iomap itself during file operations.
> >> > +   The filesystem should supply an ``->iomap_end`` function to observe
> >> > +   these flags:
> >> > +
> >> > +   * **IOMAP_F_SIZE_CHANGED**: The file size has changed as a result of
> >> > +     using this mapping.
> >> > +
> >> > +   * **IOMAP_F_STALE**: The mapping was found to be stale.
> >> > +     iomap will call ``->iomap_end`` on this mapping and then
> >> > +     ``->iomap_begin`` to obtain a new mapping.
> >> > +
> >> > +   Currently, these flags are only set by pagecache operations.
> >> > +
> >> > + * ``addr`` describes the device address, in bytes.
> >> > +
> >> > + * ``bdev`` describes the block device for this mapping.
> >> > +   This only needs to be set for mapped or unwritten operations.
> >> > +
> >> > + * ``dax_dev`` describes the DAX device for this mapping.
> >> > +   This only needs to be set for mapped or unwritten operations, and
> >> > +   only for a fsdax operation.
> >> 
> >> Looks like we can make this union (bdev and dax_dev). Since depending
> >> upon IOMAP_DAX or not we only set either dax_dev or bdev.
> >
> > Separate patch. ;)
> >
> 
> Yes, in a way I was trying to get an opinion from you and others on
> whether it make sense to make bdev and dax_dev as union :)
> 
> Looks like this series [1] could be the reason for that. 
> 
> [1]: https://lore.kernel.org/all/20211129102203.2243509-1-hch@lst.de/#t
> 
> I also don't see any reference to dax code from fs/iomap/buffered-io.c
> So maybe we don't need this dax.h header in this file.
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c5802a459334..e1a6cca3cec2 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -10,7 +10,6 @@
>  #include <linux/pagemap.h>
>  #include <linux/uio.h>
>  #include <linux/buffer_head.h>
> -#include <linux/dax.h>
>  #include <linux/writeback.h>
>  #include <linux/list_sort.h>
>  #include <linux/swap.h>

Yes, given that both you and hch have mentioned it, could one of you
send a cleanup series for that?

> 
> >> Sorry Darrick. I will stop here for now.
> >> I will continue it from here later.
> >
> > Ok.  The rest of the doc will hopefully make it more obvious why there's
> > the generic discussion up here.
> >
> 
> Sure. I am going through it.

<nod>

--D

> -ritesh
> 

