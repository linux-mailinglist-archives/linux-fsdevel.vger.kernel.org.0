Return-Path: <linux-fsdevel+bounces-21449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A09040ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 18:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC51EB23C54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E5A3A28D;
	Tue, 11 Jun 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uWm/x20H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82311720;
	Tue, 11 Jun 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122337; cv=none; b=Zk4Obtfnoz8jwFqAIDPMYev5G/JLTOASPxM1OtaHQMLl6JmoHJJlMQ+yBC2vo1pAbQguZP4Y8cT+BsZO0jVNesC/QCVXVQz6WbS6lBsjlPR3cA41ofTAWkk7BkJ7WbSp8AblRsSqMZChG5H/UcXWuw7XbSszghDZVG9QMC82aCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122337; c=relaxed/simple;
	bh=VZ0o54UMcw140gZRar2GtS++P8hw9v8NeCtiUWYIIiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgQrkuGcIUzjCx8drlQz51ogIpWveny4qMFvoROkSzyalHVb4+fOI2Xigpz/xh21jgCZHyrqRFzj+hkjhw+uE+eIuxR9SEaV0+EhT391zmPbGmV0FSdhFsoFbHOqn6OljzUOmRYraRjqNMgsQeyEDbxg4Rk9X7L8eDfSnhYAxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uWm/x20H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jthpn0A2/AheIVgcEBsmw1C6QM5gdAWip+PnRxD96Do=; b=uWm/x20HC7l7eoUlhohfqUhpm6
	jWAxPdTCXI0pSbEVlK2Lt64TbCI0B4rlztIx0VF1rLe6oU/r2beMUfwCjmN1WH63db13FufQAI4Ff
	t+nMYrYzIN1ewn7LnFh9bi7yQtFFc0D7CuZWdj5A7fVH+gaXdOyLPg1TgxjoiFb/03Kq08Sx1JFxM
	c3kH09dJZOaNNl3KRTNT2Ri9MVrmYlLRLCVqLurR8iLMARTU+EI+UJkob6lgGCpg+P1roQc+kEa98
	AVA9XeK5k1wnCtRy9RsjW20ZP0J6oVU9KxKwUT/AOWM3/vW3c36YuCFObPjWl7FB6OVLHmyHJfw7+
	w1qjpS0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH46X-00000009SX8-2xUq;
	Tue, 11 Jun 2024 16:12:13 +0000
Date: Tue, 11 Jun 2024 09:12:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to
 port
Message-ID: <Zmh3XTDLM1TToQ2g@infradead.org>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <ZmVNblggFRgR8bnJ@infradead.org>
 <20240609155506.GT52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609155506.GT52987@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Jun 09, 2024 at 08:55:06AM -0700, Darrick J. Wong wrote:
> HTML version here, text version below.

That is so much nicer than all the RST stuff..

>    iomap is a filesystem library for handling various filesystem
>    operations that involves mapping of file's logical offset ranges
>    to physical extents. This origins of this library is the file I/O
>    path that XFS once used; it has now been extended to cover several
>    other operations. The library provides various APIs for
>    implementing various file and pagecache operations, such as:

Does anyone care about the origin?

> 
>        * Pagecache reads and writes
> 
>        * Folio write faults to the pagecache
> 
>        * Writeback of dirty folios
> 
>        * Direct I/O reads and writes
> 
>        * FIEMAP
> 
>        * lseek SEEK_DATA and SEEK_HOLE
> 
>        * swapfile activation

One useful bit might be that there are two layer in iomap.

 1) the very simply underlying layer in iter.c that just provides
    a nicer iteration over logical file offsets
 2) anything built on top.  That's the things mentioned above plus
    DAX.

What is also kinda interesting as it keeps confusing people is that
nothing in the iterator is block device specific.  In fact the DAX
code now has no block device dependencies, as does the lseek and
FIEMAP code.

Because of that it might make sense to split this document up a bit
for the different layers and libraries.  Or maybe not if too many
documents are too confusing.

>          2. For each sub-unit of work...
> 
>               1. Revalidate the mapping and go back to (1) above, if
>                  necessary

That's something only really done in the buffered write path.

>    Each iomap operation will be covered in more detail below. This
>    library was covered previously by an LWN article and a
>    KernelNewbies page.

Maybe these are links in other formats, but if not this information
isn't very useful.  Depending on how old that information is it
probably isn't even with links.

>    The filesystem returns the mappings via the following structure.
>    For documentation purposes, the structure has been reordered to
>    group fields that go together logically.

I don't think putting a different layout in here is a good idea.
In fact duplicating the definition means it will be out of sync
rather sooner than later.  Given that we have to deal with RST anyway
we might as well want to pull this in as kerneldoc comments.
And maybe reorder the actual definition while we're at it,
as the version below still packs nicely.

>      struct block_device          *bdev;
>      struct dax_device            *dax_dev;
>      void                         *inline_data;

Note: The could become a union these days.  I tried years ago
before fully decoupling the DAX code and that didn't work,
but we should be fine now.

>        * type describes the type of the space mapping:
> 
>             * IOMAP_HOLE: No storage has been allocated. This type
>               must never be returned in response to an IOMAP_WRITE
>               operation because writes must allocate and map space,
>               and return the mapping. The addr field must be set to
>               IOMAP_NULL_ADDR. iomap does not support writing
>               (whether via pagecache or direct I/O) to a hole.

...

These should probably also be kerneldoc comments instead of being
away from the definitions?

> 
>             * IOMAP_F_XATTR: The mapping is for extended attribute
>               data, not regular file data. This is only useful for
>               FIEMAP.

.. and only used inside XFS.  Maybe we should look into killing it.

>    These struct kiocb flags are significant for buffered I/O with
>    iomap:
> 
>        * IOCB_NOWAIT: Only proceed with the I/O if mapping data are
>          already in memory, we do not have to initiate other I/O, and
>          we acquire all filesystem locks without blocking. Neither
>          this flag nor its definition RWF_NOWAIT actually define what
>          this flag means, so this is the best the author could come
>          up with.

I don't think that's true.  But if it feels true to you submitting
a patch to describe it better is probably more helpful than this.

>    iomap internally tracks two state bits per fsblock:
> 
>        * uptodate: iomap will try to keep folios fully up to date. If
>          there are read(ahead) errors, those fsblocks will not be
>          marked uptodate. The folio itself will be marked uptodate
>          when all fsblocks within the folio are uptodate.
> 
>        * dirty: iomap will set the per-block dirty state when
>          programs write to the file. The folio itself will be marked
>          dirty when any fsblock within the folio is dirty.
> 
>    iomap also tracks the amount of read and write disk IOs that are
>    in flight. This structure is much lighter weight than struct
>    buffer_head.

Is this really something that should go into an API documentation?

Note that the structure not only is lighter weight than a buffer_head,
but more importantly there are a lot less of them as there is only
one per folio and not one per FSB.

>   Why Convert to iomap?

Make this a separate document?


