Return-Path: <linux-fsdevel+bounces-21473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE3A904658
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69267285AE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 21:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56C615442C;
	Tue, 11 Jun 2024 21:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlrXhgN+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647D15445F;
	Tue, 11 Jun 2024 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142236; cv=none; b=RFlrri9Lmi05ZhkeVZLzfSeGjgJFGQHYYo5RUFT16mWDWRc5tBjdqMqLj3qOXyTHsp6/j5R2cGiH1XqyUaVJqdW/ktZiBrIpBdFF64QEfIFw5Toa/2pApJDGOAgtpYHgQ5dgH8Ppm2dBykEsFtrZa7zF0O/VgJfOIM1h9peYewA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142236; c=relaxed/simple;
	bh=KlHIgNvDyZC9MtN2GZoUqn6aV2oBNClS6zkq5k/Kvi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lbv9GYAmRtQcyZ3AJRugWVyBQOLhMcyvtNJYmxgEPJ2ittX4tCXKq0SQQgJH/gZKT/DjV4XLzGh9xr8Q3qoDe0xELOR6oNFLLEDNSFSpB9GHRFm4ll5gnieYEHDiGwqky4FsJeyedlfBKa7FRXPVeRxmwIYOJcxbUDtyU9acn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlrXhgN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD2FC2BD10;
	Tue, 11 Jun 2024 21:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718142235;
	bh=KlHIgNvDyZC9MtN2GZoUqn6aV2oBNClS6zkq5k/Kvi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlrXhgN+tImDEj8BhwYCLJVBaeCpEN2s3VdkI0kSsXxSjOlyoHcOcCCYYQtbgsE7b
	 3JNpEZnDofkDMMxqXMUdbUO/lxEs210S+CP9mx4c+aMv5XIoyPj/ix4DUC3+Y8W70a
	 pVlGSZBjg0UfNwBi632p0OisVrOIEkP1ePbYCBFpRbzDgSIoSM+HpCQb8da8hhz39O
	 NhiWHjzYYK9FVTNsVqQRbbzpCchV3gO+9dK9eep+miFiK2dGTbS0Qm+zC857AiKKT0
	 ZgMKBEWoLKUU8hdXFxZz7BWvUfTx0pronIdiol1/rsE/BxF7V2kz1jfX4pkkQuB6Ih
	 BPnEOQzdLZbNA==
Date: Tue, 11 Jun 2024 14:43:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to
 port
Message-ID: <20240611214355.GB52987@frogsfrogsfrogs>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <ZmVNblggFRgR8bnJ@infradead.org>
 <20240609155506.GT52987@frogsfrogsfrogs>
 <Zmh3XTDLM1TToQ2g@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmh3XTDLM1TToQ2g@infradead.org>

On Tue, Jun 11, 2024 at 09:12:13AM -0700, Christoph Hellwig wrote:
> On Sun, Jun 09, 2024 at 08:55:06AM -0700, Darrick J. Wong wrote:
> > HTML version here, text version below.
> 
> That is so much nicer than all the RST stuff..
> 
> >    iomap is a filesystem library for handling various filesystem
> >    operations that involves mapping of file's logical offset ranges
> >    to physical extents. This origins of this library is the file I/O
> >    path that XFS once used; it has now been extended to cover several
> >    other operations. The library provides various APIs for
> >    implementing various file and pagecache operations, such as:
> 
> Does anyone care about the origin?

I do; occasionally people who are totally new to iomap wonder why
suchandsuch works in the odd way it does, and I can point them at its
XFS origins.

> > 
> >        * Pagecache reads and writes
> > 
> >        * Folio write faults to the pagecache
> > 
> >        * Writeback of dirty folios
> > 
> >        * Direct I/O reads and writes
> > 
> >        * FIEMAP
> > 
> >        * lseek SEEK_DATA and SEEK_HOLE
> > 
> >        * swapfile activation
> 
> One useful bit might be that there are two layer in iomap.
> 
>  1) the very simply underlying layer in iter.c that just provides
>     a nicer iteration over logical file offsets
>  2) anything built on top.  That's the things mentioned above plus
>     DAX.
> 
> What is also kinda interesting as it keeps confusing people is that
> nothing in the iterator is block device specific.  In fact the DAX
> code now has no block device dependencies, as does the lseek and
> FIEMAP code.

<nod>

> Because of that it might make sense to split this document up a bit
> for the different layers and libraries.  Or maybe not if too many
> documents are too confusing.

Hmm.  The internal design is about ~400 lines of text.  The actual
operations iomap implements are another ~600 LoT, and the porting
guidelines at the end are about 140 LoT.  Maybe that's a reasonable
length for splitting?

> >          2. For each sub-unit of work...
> > 
> >               1. Revalidate the mapping and go back to (1) above, if
> >                  necessary
> 
> That's something only really done in the buffered write path.

Yeah.

> >    Each iomap operation will be covered in more detail below. This
> >    library was covered previously by an LWN article and a
> >    KernelNewbies page.
> 
> Maybe these are links in other formats, but if not this information
> isn't very useful.  Depending on how old that information is it
> probably isn't even with links.

There are links, which are visible in the HTML version.  Maybe I
should've run links in whichever mode spits out all the links as
footnotes.  (rst2html -> links is how I made the text version in the
first place).

> >    The filesystem returns the mappings via the following structure.
> >    For documentation purposes, the structure has been reordered to
> >    group fields that go together logically.
> 
> I don't think putting a different layout in here is a good idea.
> In fact duplicating the definition means it will be out of sync
> rather sooner than later.  Given that we have to deal with RST anyway
> we might as well want to pull this in as kerneldoc comments.
> And maybe reorder the actual definition while we're at it,
> as the version below still packs nicely.

Ok, I'll copy struct iomap as is.

> >      struct block_device          *bdev;
> >      struct dax_device            *dax_dev;
> >      void                         *inline_data;
> 
> Note: The could become a union these days.  I tried years ago
> before fully decoupling the DAX code and that didn't work,
> but we should be fine now.

You and Ritesh have both suggested that today.

> >        * type describes the type of the space mapping:
> > 
> >             * IOMAP_HOLE: No storage has been allocated. This type
> >               must never be returned in response to an IOMAP_WRITE
> >               operation because writes must allocate and map space,
> >               and return the mapping. The addr field must be set to
> >               IOMAP_NULL_ADDR. iomap does not support writing
> >               (whether via pagecache or direct I/O) to a hole.
> 
> ...
> 
> These should probably also be kerneldoc comments instead of being
> away from the definitions?

I don't like how kerneldoc makes it hard to associate iomap::type with
the IOMAP_* constants that go in it.  This would probably be ok for
::type if we turned it into an actual enum, but as C doesn't actually
have a bitset type, the only way to tell the reader which flags go where
is either strong namespacing (we blew it on that) or writing linking
text into the kerneldoc.

With this format I can lay out the document with relevant topics
adjacent and indented, so the association is obvious.  The oneline
comments in the header file can jog readers' memories, without us
needing to stuff a whole ton of documentation into a C header.

Besides, kerneldoc only tells the reader what the interfaces are, not
how all those pieces fit together.

> >             * IOMAP_F_XATTR: The mapping is for extended attribute
> >               data, not regular file data. This is only useful for
> >               FIEMAP.
> 
> .. and only used inside XFS.  Maybe we should look into killing it.

Yeah.

> >    These struct kiocb flags are significant for buffered I/O with
> >    iomap:
> > 
> >        * IOCB_NOWAIT: Only proceed with the I/O if mapping data are
> >          already in memory, we do not have to initiate other I/O, and
> >          we acquire all filesystem locks without blocking. Neither
> >          this flag nor its definition RWF_NOWAIT actually define what
> >          this flag means, so this is the best the author could come
> >          up with.
> 
> I don't think that's true.  But if it feels true to you submitting
> a patch to describe it better is probably more helpful than this.

I think Dave just told me off for this, so I'll probably replace the
whole section with what he and Jan wrote.

> >    iomap internally tracks two state bits per fsblock:
> > 
> >        * uptodate: iomap will try to keep folios fully up to date. If
> >          there are read(ahead) errors, those fsblocks will not be
> >          marked uptodate. The folio itself will be marked uptodate
> >          when all fsblocks within the folio are uptodate.
> > 
> >        * dirty: iomap will set the per-block dirty state when
> >          programs write to the file. The folio itself will be marked
> >          dirty when any fsblock within the folio is dirty.
> > 
> >    iomap also tracks the amount of read and write disk IOs that are
> >    in flight. This structure is much lighter weight than struct
> >    buffer_head.
> 
> Is this really something that should go into an API documentation?

Strictly speaking, no.  It should be in a separate internals document.

> Note that the structure not only is lighter weight than a buffer_head,
> but more importantly there are a lot less of them as there is only
> one per folio and not one per FSB.
> 
> >   Why Convert to iomap?
> 
> Make this a separate document?

I was pondering splitting these into two pieces:

Documentation/iomap/{design,porting}.rst

Though the porting guide is 10% of the document.  Maybe that's worth it.

--D

