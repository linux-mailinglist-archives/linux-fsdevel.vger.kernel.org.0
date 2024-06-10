Return-Path: <linux-fsdevel+bounces-21362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B927902B1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 23:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CB51F22D8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 21:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA27E14F9EF;
	Mon, 10 Jun 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7WDgkGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2B14659A;
	Mon, 10 Jun 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056769; cv=none; b=haYPowGkA1Cfhb+4/Il0tbI/rc6ndWwgg5fFz3c++NP/+JfRq6M0zcuk960XfDIGyWECcZB4dU9ml5nsMEG1DoiH7E/l9P3g41jVyuDHqUljKx7gDf6cqfOpOD8Q+bOh2GdKGrF+5BeVMqqIwl7v1y+R7Xvv8h552OhT0TROKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056769; c=relaxed/simple;
	bh=P2MkW8CPJ104yFREHq1aVGWPd2gRI4Icz1w4ZJrsGJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGd/xroJZu3DnmpviwAVqm8KWOBKLRc9TjrBVtW3d7JXnqT6J2VLzvplll1GvGuHo6YJ5RmXy3C3i+hVFKKCjGMg2MEjNBtsue4jAcysxJnDYtAEjZg69q9sed28JJwYSpVzH5p2a0vdV6FegRC1ALGYxFWzxypHBvl/PZ0rrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7WDgkGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C92C2BBFC;
	Mon, 10 Jun 2024 21:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718056768;
	bh=P2MkW8CPJ104yFREHq1aVGWPd2gRI4Icz1w4ZJrsGJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c7WDgkGP2RUyr9ToF21oU4hG1PUv+nznoMqZNSTgObbDBj361h9Z6JO//nhhnJxwM
	 NSS8s6IkDpF4+rqoaEfjPKOf/oC8FZwDgaZoEQ/TpdAhc79hxWhb6qnZq7X1FO/TMY
	 wVVkE9Sb0oEVtGKY5JI4H5T5SsubBGyaPsFmXoRzHVUBOPzktpF2mSn6QemlwIoKQi
	 W6GFAZgVathccZoF82MN9PTjNrgNzY3CUObwMLKW1c8kxJxPbK485Ag4jgjpPoIBcX
	 4mVOfvXnTmqg1UyIzMQl4dxnZKDsvgJfHSEAPcvQvyW+RWbTVIz+VoOb7V9BB19kcL
	 iEfrug+Rj4B+w==
Date: Mon, 10 Jun 2024 14:59:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to
 port
Message-ID: <20240610215928.GV52987@frogsfrogsfrogs>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <ZmVNblggFRgR8bnJ@infradead.org>
 <20240609155506.GT52987@frogsfrogsfrogs>
 <20240610141808.vdsflgcbjmgc37dt@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610141808.vdsflgcbjmgc37dt@quack3>

On Mon, Jun 10, 2024 at 04:18:08PM +0200, Jan Kara wrote:
> On Sun 09-06-24 08:55:06, Darrick J. Wong wrote:
> >        * invalidate_lock: The pagecache struct address_space
> >          rwsemaphore that protects against folio removal.
> 
> invalidate_lock lock is held for read during insertions and for write
> during removals. So holding it pro read indeed protects against folio
> removal but holding it for write protects against folio insertion (which
> some places also use).

Ok, I've changed the two lock bulletpoints to read:

"i_rwsem: The VFS struct inode rwsemaphore.  Processes hold this in
shared mode to read file state and contents.  Some filesystems may allow
shared mode for writes.  Processes often hold this in exclusive mode to
change file state and contents.

"invalidate_lock: The pagecache struct address_space rwsemaphore that
protects against folio insertion and removal for filesystems that
support punching out folios below EOF.  Processes wishing to insert
folios must hold this lock in shared mode to prevent removal, though
concurrent insertion is allowed.  Processes wishing to remove folios
must hold this lock in exclusive mode to prevent insertions.  Concurrent
removals are not allowed."

> >        * validity_cookie is a magic freshness value set by the
> >          filesystem that should be used to detect stale mappings. For
> >          pagecache operations this is critical for correct operation
> >          because page faults can occur, which implies that filesystem
> >          locks should not be held between ->iomap_begin and
> >          ->iomap_end. Filesystems with completely static mappings
> >          need not set this value. Only pagecache operations
> >          revalidate mappings.
> > 
> >          XXX: Should fsdax revalidate as well?
> 
> AFAICT no. DAX is more like using direct IO for everything. So no writeback
> changing mapping state behind your back (and that's the only thing that is
> not serialized with i_rwsem or invalidate_lock). Maybe this fact can be
> mentioned somewhere around the discussion of iomap_valid() as a way how
> locking usually works out?

<nod> I'll put that in the section about iomap_valid, which documents
the whole mechanism more thoroughly:

"iomap_valid: The filesystem may not hold locks between ->iomap_begin
and ->iomap_end because pagecache operations can take folio locks, fault
on userspace pages, initiate writeback for memory reclamation, or engage
in other time-consuming actions.  If a file's space mapping data are
mutable, it is possible that the mapping for a particular pagecache
folio can change in the time it takes to allocate, install, and lock
that folio.

"For the pagecache, races can happen if writeback doesn't take i_rwsem
or invalidate_lock and updates mapping information.  Races can also
happen if the filesytem allows concurrent writes.  For such files, the
mapping *must* be revalidated after the folio lock has been taken so
that iomap can manage the folio correctly.

"fsdax does not need this revalidation because there's no writeback and
no support for unwritten extents.

"The filesystem's ->iomap_begin function must sample a sequence counter
into struct iomap::validity_cookie at the same time that it populates
the mapping fields.  It must then provide a ->iomap_valid function to
compare the validity cookie against the source counter and return
whether or not the mapping is still valid.  If the mapping is not valid,
the mapping will be sampled again."

> >    iomap implements nearly all the folio and pagecache management
> >    that filesystems once had to implement themselves. This means that
> >    the filesystem need not know the details of allocating, mapping,
> >    managing uptodate and dirty state, or writeback of pagecache
> >    folios. Unless the filesystem explicitly opts in to buffer heads,
> >    they will not be used, which makes buffered I/O much more
> >    efficient, and willy much happier.
> 		    ^^^ unless we make it a general noun for someone doing
> thankless neverending conversion job, we should give him a capital W ;).

I'll change it to 'the pagecache maintainer'

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
> RWF_NOWAIT is a performance feature, not a correctness one, hence the
> meaning is somewhat vague. It is meant to mean "do the IO only if it
> doesn't involve waiting for other IO or other time expensive operations".
> Generally we translate it to "don't wait for i_rwsem, page locks, don't do
> block allocation, etc." OTOH we don't bother to specialcase internal
> filesystem locks (such as EXT4_I(inode)->i_data_sem) and we get away with
> it because blocking on it under constraints we generally perform RWF_NOWAIT
> IO is exceedingly rare.

I hate this flag's undocumented nature.  It now makes *documenting*
things around it hard.  How about:

"IOCB_NOWAIT: Neither this flag nor its associated definition RWF_NOWAIT
actually specify what this flag means.  Community members seem to think
that it means only proceed with the I/O if it doesn't involve waiting
for expensive operations.  XFS and ext4 appear to reject the IO unless
the mapping data are already in memory, the filesystem does not have to
initiate other I/O, and the kernel can acquire all filesystem locks
without blocking."

> >       mmap Write Faults
> > 
> >    The iomap_page_mkwrite function handles a write fault to a folio
> >    the pagecache.
>      ^^^ to a folio *in* the pagecache? I cannot quite parse the sentence.

Correct.  Fixed.

> >       Truncation
> > 
> >    Filesystems can call iomap_truncate_page to zero the bytes in the
> >    pagecache from EOF to the end of the fsblock during a file
> >    truncation operation. truncate_setsize or truncate_pagecache will
> >    take care of everything after the EOF block. IOMAP_ZERO will be
> >    passed as the flags argument to ->iomap_begin. Callers typically
> >    take i_rwsem and invalidate_lock in exclusive mode.
> 
> Hum, but i_rwsem and invalidate_lock are usually acquired *before*
> iomap_truncate_page() is even called, aren't they?

Yes, I think so.

>                                                    This locking note looks
> a bit confusing to me. I'd rather write: "The callers typically hold i_rwsem
> and invalidate_lock when calling iomap_truncate_page()." if you want to
> mention any locking.

Ok.

> >       Zeroing for File Operations
> > 
> >    Filesystems can call iomap_zero_range to perform zeroing of the
> >    pagecache for non-truncation file operations that are not aligned
> >    to the fsblock size. IOMAP_ZERO will be passed as the flags
> >    argument to ->iomap_begin. Callers typically take i_rwsem and
> >    invalidate_lock in exclusive mode.
> 
> Ditto here...
> 
> >       Unsharing Reflinked File Data
> > 
> >    Filesystems can call iomap_file_unshare to force a file sharing
> >    storage with another file to preemptively copy the shared data to
> >    newly allocate storage. IOMAP_WRITE | IOMAP_UNSHARE will be passed
> >    as the flags argument to ->iomap_begin. Callers typically take
> >    i_rwsem and invalidate_lock in exclusive mode.
> 
> And here.

Yeah, I'm not sure -- this is the XFS model (and I guess ext4 now too),
but other systems don't have to follow that.  I'll just weaselword it:

"Callers typically hold i_rwsem and invalidate_lock in exclusive
mode before calling this function."

> >   Direct I/O
> > 
> >    In Linux, direct I/O is defined as file I/O that is issued
> >    directly to storage, bypassing the pagecache.
> > 
> >    The iomap_dio_rw function implements O_DIRECT (direct I/O) reads
> >    and writes for files. An optional ops parameter can be passed to
> >    change the behavior of direct I/O. The done_before parameter
> >    should be set if writes have been initiated prior to the call. The
> >    direction of the I/O is determined from the iocb passed in.
> > 
> >    The flags argument can be any of the following values:
> > 
> >        * IOMAP_DIO_FORCE_WAIT: Wait for the I/O to complete even if
> >          the kiocb is not synchronous.
> > 
> >        * IOMAP_DIO_OVERWRITE_ONLY: Allocating blocks, zeroing partial
> >          blocks, and extensions of the file size are not allowed. The
> >          entire file range must to map to a single written or
> 				  ^^ extra "to"

Fixed, thanks.

> >          unwritten extent. This flag exists to enable issuing
> >          concurrent direct IOs with only the shared i_rwsem held when
> >          the file I/O range is not aligned to the filesystem block
> >          size. -EAGAIN will be returned if the operation cannot
> >          proceed.
> 
> <snip>
> 
> >     Direct Writes
> > 
> >    A direct I/O write initiates a write I/O to the storage device to
> >    the caller's buffer. Dirty parts of the pagecache are flushed to
> >    storage before initiating the write io. The pagecache is
> >    invalidated both before and after the write io. The flags value
> >    for ->iomap_begin will be IOMAP_DIRECT | IOMAP_WRITE with any
> >    combination of the following enhancements:
> > 
> >        * IOMAP_NOWAIT: Write if mapping data are already in memory.
> >          Does not initiate other I/O or block on filesystem locks.
> > 
> >        * IOMAP_OVERWRITE_ONLY: Allocating blocks and zeroing partial
> >          blocks is not allowed. The entire file range must to map to
> 							     ^^ extra "to"
> 
> >          a single written or unwritten extent. The file I/O range
> >          must be aligned to the filesystem block size.
> 
> This seems to be XFS specific thing? At least I don't see anything in
> generic iomap code depending on this?

Hmm.  XFS bails out if the mapping is unwritten and the directio write
range isn't aligned to the fsblock size.  I think the reason for that is
because we'd have to zero the unaligned regions outside of the write
range, and xfs can't do that without synchronizing.  (Or we didn't think
that was common enough to bother with the code complexity.)

"The file I/O range must be aligned to the filesystem block size
if the filesystem supports unwritten mappings but cannot zero unaligned
regions without exposing stale contents."?

> 
> >     fsdax Writes
> > 
> >    A fsdax write initiates a memcpy to the storage device to the
> 							    ^^ from
> 
> >    caller's buffer. The flags value for ->iomap_begin will be
> >    IOMAP_DAX | IOMAP_WRITE with any combination of the following
> >    enhancements:
> > 
> >        * IOMAP_NOWAIT: Write if mapping data are already in memory.
> >          Does not initiate other I/O or block on filesystem locks.
> > 
> >        * IOMAP_OVERWRITE_ONLY: Allocating blocks and zeroing partial
> >          blocks is not allowed. The entire file range must to map to
> 							     ^^ extra "to"
> 
> >          a single written or unwritten extent. The file I/O range
> >          must be aligned to the filesystem block size.
> > 
> >    Callers commonly hold i_rwsem in exclusive mode.
> > 
> >     mmap Faults
> > 
> >    The dax_iomap_fault function handles read and write faults to
> >    fsdax storage. For a read fault, IOMAP_DAX | IOMAP_FAULT will be
> >    passed as the flags argument to ->iomap_begin. For a write fault,
> >    IOMAP_DAX | IOMAP_FAULT | IOMAP_WRITE will be passed as the flags
> >    argument to ->iomap_begin.
> > 
> >    Callers commonly hold the same locks as they do to call their
> >    iomap pagecache counterparts.
> > 
> >     Truncation, fallocate, and Unsharing
> > 
> >    For fsdax files, the following functions are provided to replace
> >    their iomap pagecache I/O counterparts. The flags argument to
> >    ->iomap_begin are the same as the pagecache counterparts, with
> >    IOMAP_DIO added.
> 	  ^^^ IOMAP_DAX?

Oops yes.

> >        * dax_file_unshare
> > 
> >        * dax_zero_range
> > 
> >        * dax_truncate_page
> > 
> >    Callers commonly hold the same locks as they do to call their
> >    iomap pagecache counterparts.
> 
> >   How to Convert to iomap?
> > 
> >    First, add #include <linux/iomap.h> from your source code and add
> >    select FS_IOMAP to your filesystem's Kconfig option. Build the
> >    kernel, run fstests with the -g all option across a wide variety
> >    of your filesystem's supported configurations to build a baseline
> >    of which tests pass and which ones fail.
> > 
> >    The recommended approach is first to implement ->iomap_begin (and
> >    ->iomap->end if necessary) to allow iomap to obtain a read-only
>        ^^^^ ->iomap_end

Fixed, thanks.

> <snip>
> 
> >    Most likely at this point, the buffered read and write paths will
> >    still to be converted. The mapping functions should all work
>           ^^ need to be

Fixed, thanks.

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

