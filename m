Return-Path: <linux-fsdevel+bounces-21487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F343F9047C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D862840AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91CB156248;
	Tue, 11 Jun 2024 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEZN1sgb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8E4502B;
	Tue, 11 Jun 2024 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718149667; cv=none; b=NLp+uiEdv5SSeXtbn2VeEvfwJ1zu1xUdRS/IwTQfVjeDgepm64+CGmyMmCGR91REjrsTwHCYmf5GhV8K24oPWH/orsWwGXDQwuSKEbER5dIRZI6Bp0a0U7rHOhms5pdMaqNABDASf/WyiesIkpWlgqkFRVanEz5D6adDg1bA7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718149667; c=relaxed/simple;
	bh=HcAEIFxcpJbTJ0ynL0GxTiBE924enRs0YQwAyTLa2dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWaEdgqHjyiSl8MQk1mmAXHa2JByGdwkqTk5GiBlCd2EbUuePMrf+1lWIVk6FPcq/s0w3Vh7Qtmmt26PFdxHP0KhSNuM32JZbI5q6ell2aE2P1d8H9rJQtigLKM+5RuMazWqlB9t6z8z3jC47RCjKW6L4/quioobCVH0FFFbDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEZN1sgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDD5C3277B;
	Tue, 11 Jun 2024 23:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718149666;
	bh=HcAEIFxcpJbTJ0ynL0GxTiBE924enRs0YQwAyTLa2dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEZN1sgbbXNV9JAsptwyBfGmSKUpV4QDPOpMZWOzPoXBP6KgrviPfh546lwzGBY3N
	 SKhMJJbxkT7psfLUbwov5WTzvNorVKNGADSDpq9meG6dqIL4sz4GtmpoWhgGR80IA/
	 dPA/c9l6oSGTYfu7QtQuUOWQoID1jzd5nM+qCgkBM+dD4eoG1jBvrU33bYxcCK87kw
	 q+pqIKMXVi93LhMMEhjrXg957bHLrILy6d3Qu+XKOcGsSwNxyhc3L5G5kraQQe+KYa
	 WNw9O/qbmWo1nU8ZDMO2vhqJz/iAD+FgRboz56JjQfPmtP7G4hqGfzmXTNyXqCAoQJ
	 WydHMNucMpmlw==
Date: Tue, 11 Jun 2024 16:47:45 -0700
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
Message-ID: <20240611234745.GD52987@frogsfrogsfrogs>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <874j9zahch.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j9zahch.fsf@gmail.com>

On Tue, Jun 11, 2024 at 04:15:02PM +0530, Ritesh Harjani wrote:
> 
> Hi Darrick,
> 
> Resuming my review from where I left off yesterday.

<snip>

> > +Validation
> > +==========
> > +
> > +**NOTE**: iomap only handles mapping and I/O.
> > +Filesystems must still call out to the VFS to check input parameters
> > +and file state before initiating an I/O operation.
> > +It does not handle updating of timestamps, stripping privileges, or
> > +access control.
> > +
> > +Locking Hierarchy
> > +=================
> > +
> > +iomap requires that filesystems provide their own locking.
> > +There are no locks within iomap itself, though in the course of an
> 
> That might not be totally true. There is a state_lock within iomap_folio_state ;)
> 
> > +operation iomap may take other locks (e.g. folio/dax locks) as part of
> > +an I/O operation.
> 
> I think we need not mention "dax locks" here right? Since most of that
> code is in fs/dax.c anyways?

Well they're examples, so I think we can leave them.

> > +Locking with iomap can be split into two categories: above and below
> > +iomap.
> > +
> > +The upper level of lock must coordinate the iomap operation with other
> > +iomap operations.
> 
> Can we add some more details in this line or maybe an example? 
> Otherwise confusing use of "iomap operation" term.

How about:

"iomap requires that filesystems supply their own locking model.  There
are three categories of synchronization primitives, as far as iomap is
concerned:

 * The **upper** level primitive is provided by the filesystem to
   coordinate access to different iomap operations.
   The exact primitive is specifc to the filesystem and operation,
   but is often a VFS inode, pagecache invalidation, or folio lock.
   For example, a filesystem might take ``i_rwsem`` before calling
   ``iomap_file_buffered_write`` and ``iomap_file_unshare`` to prevent
   these two file operations from clobbering each other.
   Pagecache writeback may lock a folio to prevent other threads from
   accessing the folio until writeback is underway.

   * The **lower** level primitive is taken by the filesystem in the
     ``->iomap_begin`` and ``->iomap_end`` functions to coordinate
     access to the file space mapping information.
     The fields of the iomap object should be filled out while holding
     this primitive.
     The upper level synchronization primitive, if any, remains held
     while acquiring the lower level synchronization primitive.
     For example, XFS takes ``ILOCK_EXCL`` and ext4 takes ``i_data_sem``
     while sampling mappings.
     Filesystems with immutable mapping information may not require
     synchronization here.

   * The **operation** primitive is taken by an iomap operation to
     coordinate access to its own internal data structures.
     The upper level synchronization primitive, if any, remains held
     while acquiring this primitive.
     The lower level primitive is not held while acquiring this
     primitive.
     For example, pagecache write operations will obtain a file mapping,
     then grab and lock a folio to copy new contents.
     It may also lock an internal folio state object to update metadata.

The exact locking requirements are specific to the filesystem; for
certain operations, some of these locks can be elided.
All further mention of locking are *recommendations*, not mandates.
Each filesystem author must figure out the locking for themself."

> > +Generally, the filesystem must take VFS/pagecache locks such as
> > +``i_rwsem`` or ``invalidate_lock`` before calling into iomap.
> > +The exact locking requirements are specific to the type of operation.
> > +
> > +The lower level of lock must coordinate access to the mapping
> > +information.
> > +This lock is filesystem specific and should be held during
> > +``->iomap_begin`` while sampling the mapping and validity cookie.
> > +
> > +The general locking hierarchy in iomap is:
> > +
> > + * VFS or pagecache lock
> > +
> 
> There is also a folio lock within iomap which now comes below VFS or
> pagecache lock.
> 
> > +   * Internal filesystem specific mapping lock
> 
> I think it will also be helpful if we give an example of this lock for
> e.g. XFS(XFS_ILOCK) or ext4(i_data_sem)
> 
> > +
> > +   * iomap operation-specific lock
> 
> some e.g. of what you mean here please?
> 
> > +
> > +The exact locking requirements are specific to the filesystem; for
> > +certain operations, some of these locks can be elided.
> > +All further mention of locking are *recommendations*, not mandates.
> > +Each filesystem author must figure out the locking for themself.
> 
> Is it also possible to explicitly list down the fact that folio_lock
> order w.r.t VFS lock (i_rwsem) (is it even with pagecache lock??) is now
> reversed with iomap v/s the legacy I/O model. 
> 
> There was an internal ext4 issue which got exposed due to this [1].
> So it might be useful to document the lock order change now.
> 
> [1]: https://lore.kernel.org/linux-ext4/87cyqcyt6t.fsf@gmail.com/
> 
> > +
> > +iomap Operations
> > +================
> > +
> > +Below are a discussion of the file operations that iomap implements.
> > +
> > +Buffered I/O
> > +------------
> > +
> > +Buffered I/O is the default file I/O path in Linux.
> > +File contents are cached in memory ("pagecache") to satisfy reads and
> > +writes.
> > +Dirty cache will be written back to disk at some point that can be
> > +forced via ``fsync`` and variants.
> > +
> > +iomap implements nearly all the folio and pagecache management that
> > +filesystems once had to implement themselves.
> 
> nit: that "earlier in the legacy I/O model filesystems had to implement
> themselves"

"iomap implements nearly all the folio and pagecache management that
filesystems have to implement themselves for the legacy I/O model."

?

> > +This means that the filesystem need not know the details of allocating,
> > +mapping, managing uptodate and dirty state, or writeback of pagecache
> > +folios.
> > +Unless the filesystem explicitly opts in to buffer heads, they will not
> > +be used, which makes buffered I/O much more efficient, and ``willy``
> 
> Could also please list down why buffered I/O is more efficient with
> iomap (other than the fact that iomap has large folios)?
> 
> If I am not wrong, it comes from the fact that iomap only maintains
> (other than sizeof iomap_folio_state once) 2 extra bytes per fsblock v/s
> the 104 extra bytes of struct buffer_head per fsblock in the legacy I/O model. 
> And while iterating over the pagecache pages, it is much faster to
> set/clear the uptodate/dirty bits of a folio in iomap v/s iterating over
> each bufferhead within a folio in legacy I/O model.
> 
> Right?

Yeah.  How about:

"iomap implements nearly all the folio and pagecache management that
filesystems have to implement themselves under the legacy I/O model.
This means that the filesystem need not know the details of allocating,
mapping, managing uptodate and dirty state, or writeback of pagecache
folios.  Under the legacy I/O model, this was managed very inefficiently
with linked lists of buffer heads instead of the per-folio bitmaps that
iomap uses.  Unless the filesystem explicitly opts in to buffer heads,
they will not be used, which makes buffered I/O much more efficient, and
the pagecache maintainer much happier."

<snip>

> > +Writes
> > +~~~~~~
> > +
> > +The ``iomap_file_buffered_write`` function writes an ``iocb`` to the
> > +pagecache.
> > +``IOMAP_WRITE`` or ``IOMAP_WRITE`` | ``IOMAP_NOWAIT`` will be passed as
> > +the ``flags`` argument to ``->iomap_begin``.
> > +Callers commonly take ``i_rwsem`` in either shared or exclusive mode.
> 
> shared(e.g. aligned overwrites) 

That's a matter of debate -- xfs locks out concurrent reads by taking
i_rwsem in exclusive mode, whereas (I think?) ext4 and most other
filesystems take it in shared mode and synchronizes readers and writers
with folio locks.

There was some discussion before/during LSF about relaxing XFS' locking
model since most linux programs don't seem to care that readers can see
partially written contents if a write crosses a folio boundary.

> > +
> > +mmap Write Faults
> > +^^^^^^^^^^^^^^^^^
> > +
> > +The ``iomap_page_mkwrite`` function handles a write fault to a folio the
> > +pagecache.
> 
> "handles a write fault to the pagecache" ?

I'd earlier corrected that to read "...to a folio in the pagecache."
> 
> 
> > +``IOMAP_WRITE | IOMAP_FAULT`` will be passed as the ``flags`` argument
> > +to ``->iomap_begin``.
> > +Callers commonly take the mmap ``invalidate_lock`` in shared or
> > +exclusive mode.
> > +
> > +Write Failures
> > +^^^^^^^^^^^^^^
> > +
> > +After a short write to the pagecache, the areas not written will not
> > +become marked dirty.
> > +The filesystem must arrange to `cancel
> > +<https://lore.kernel.org/all/20221123055812.747923-6-david@fromorbit.com/>`_
> > +such `reservations
> > +<https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/>`_
> > +because writeback will not consume the reservation.
> > +The ``iomap_file_buffered_write_punch_delalloc`` can be called from a
> > +``->iomap_end`` function to find all the clean areas of the folios
> > +caching a fresh (``IOMAP_F_NEW``) delalloc mapping.
> > +It takes the ``invalidate_lock``.
> > +
> > +The filesystem should supply a callback ``punch`` will be called for
> 
> The filesystem supplied ``punch`` callback will be called for...

"The filesystem must supply a function ``punch`` to be called for..."

> > +each file range in this state.
> > +This function must *only* remove delayed allocation reservations, in
> > +case another thread racing with the current thread writes successfully
> > +to the same region and triggers writeback to flush the dirty data out to
> > +disk.
> > +
> > +Truncation
> > +^^^^^^^^^^
> > +
> > +Filesystems can call ``iomap_truncate_page`` to zero the bytes in the
> > +pagecache from EOF to the end of the fsblock during a file truncation
> > +operation.
> > +``truncate_setsize`` or ``truncate_pagecache`` will take care of
> > +everything after the EOF block.
> > +``IOMAP_ZERO`` will be passed as the ``flags`` argument to
> > +``->iomap_begin``.
> > +Callers typically take ``i_rwsem`` and ``invalidate_lock`` in exclusive
> > +mode.
> > +
> > +Zeroing for File Operations
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Filesystems can call ``iomap_zero_range`` to perform zeroing of the
> > +pagecache for non-truncation file operations that are not aligned to
> > +the fsblock size.
> > +``IOMAP_ZERO`` will be passed as the ``flags`` argument to
> > +``->iomap_begin``.
> > +Callers typically take ``i_rwsem`` and ``invalidate_lock`` in exclusive
> > +mode.
> > +
> > +Unsharing Reflinked File Data
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Filesystems can call ``iomap_file_unshare`` to force a file sharing
> > +storage with another file to preemptively copy the shared data to newly
> > +allocate storage.
> > +``IOMAP_WRITE | IOMAP_UNSHARE`` will be passed as the ``flags`` argument
> > +to ``->iomap_begin``.
> > +Callers typically take ``i_rwsem`` and ``invalidate_lock`` in exclusive
> > +mode.
> > +
> > +Writeback
> > +~~~~~~~~~
> > +
> > +Filesystems can call ``iomap_writepages`` to respond to a request to
> > +write dirty pagecache folios to disk.
> > +The ``mapping`` and ``wbc`` parameters should be passed unchanged.
> > +The ``wpc`` pointer should be allocated by the filesystem and must
> > +be initialized to zero.
> > +
> > +The pagecache will lock each folio before trying to schedule it for
> > +writeback.
> > +It does not lock ``i_rwsem`` or ``invalidate_lock``.
> > +
> > +The dirty bit will be cleared for all folios run through the
> > +``->map_blocks`` machinery described below even if the writeback fails.
> > +This is to prevent dirty folio clots when storage devices fail; an
> > +``-EIO`` is recorded for userspace to collect via ``fsync``.
> > +
> > +The ``ops`` structure must be specified and is as follows:
> > +
> > +struct iomap_writeback_ops
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +.. code-block:: c
> > +
> > + struct iomap_writeback_ops {
> > +     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
> > +                       loff_t offset, unsigned len);
> > +     int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
> > +     void (*discard_folio)(struct folio *folio, loff_t pos);
> > + };
> > +
> > +The fields are as follows:
> > +
> > +  - ``map_blocks``: Sets ``wpc->iomap`` to the space mapping of the file
> > +    range (in bytes) given by ``offset`` and ``len``.
> > +    iomap calls this function for each fs block in each dirty folio,
> > +    even if the mapping returned is longer than one fs block.
> 
> It's no longer true after this patch right [1]. iomap calls this
> function for each contiguous range of dirty fsblocks within a dirty folio.
> 
> [1]: https://lore.kernel.org/all/20231207072710.176093-15-hch@lst.de/

Oh!  It does!  I forgot about this series a second time. :(

"iomap calls this function for each dirty fs block in each dirty folio,
though it will reuse mappings for runs of contiguous dirty fsblocks
within a folio."

> > +    Do not return ``IOMAP_INLINE`` mappings here; the ``->iomap_end``
> > +    function must deal with persisting written data.
> > +    Filesystems can skip a potentially expensive mapping lookup if the
> > +    mappings have not changed.
> > +    This revalidation must be open-coded by the filesystem; it is
> > +    unclear if ``iomap::validity_cookie`` can be reused for this
> > +    purpose.
> 
> struct iomap_writepage_ctx defines it's own ``struct iomap`` as a member. 
> 
> struct iomap_writepage_ctx {
> 	struct iomap		iomap;
> 	struct iomap_ioend	*ioend;
> 	const struct iomap_writeback_ops *ops;
> 	u32			nr_folios;	/* folios added to the ioend */
> };
> 
> That means it does not conflict with the context which is doing buffered
> writes (i.e. write_iter) and writeback is anyway single threaded.
> So we should be able to use wpc->iomap.validity_cookie for validating
> whether the cookie is valid or not during the course of writeback
> operation - (IMO)

We could, since the validity cookie is merely a u64 value that the
filesystem gets to define completely.  But someone will have to check
the xfs mechanisms very carefully to make sure we encode it correctly.

I think it's a simple matter of combining the value that gets written to
data_seq/cow_seq into a single u64, passing that to xfs_bmbt_to_iomap,
and revalidating it later in xfs_imap_valid.  However, the behavior of
the validity cookie and cow/data_seq are different when IOMAP_F_SHARED
is set, so this is tricky.

> 
> > +    This function is required.
> 
> This line is left incomplete.

I disagree, but perhaps it would be clearer if it said:

"This function must be supplied by the filesystem." ?

> I think we should also mention this right? - 
> 
> If the filesystem reserved delalloc extents during buffered-writes, than
> they should allocate extents for those delalloc mappings in this
> ->map_blocks call.

Technically speaking iomap doesn't screen for that, but writeback will
probably do a very wrong thing if the fs supplies a delalloc mapping.
I'll update the doc to say that:

"Do not return IOMAP_DELALLOC mappings here; iomap currently requires
mapping to allocated space."

Though I guess if hch or someone gets back to the "write and tell me
where you wrote it" patchset then I guess it /would/ be appropriate to
use IOMAP_DELALLOC here, and let the block device tell us what to map.

> > +
> > +  - ``prepare_ioend``: Enables filesystems to transform the writeback
> > +    ioend or perform any other prepatory work before the writeback I/O
> 
> IMO, some e.g. will be very helpful to add wherever possible. I
> understand we should keep the document generic enough, but it is much
> easier if we state some common examples of what XFS / other filesystems
> do with such callback methods.
> 
> e.g. 
> 
> - What do we mean by "transform the writeback ioend"? I guess it is -
>  XFS uses this for conversion of COW extents to regular extents?

Yes, the xfs ioend processing will move the mappings for freshly written
extents from the cow fork to the data fork.

> - What do we mean by "perform any other preparatory work before the
>   writeback I/O"? - I guess it is - 
>   XFS hooks in custom a completion handler in ->prepare_ioend callback for
>   conversion of unwritten extents.

Yes.

"prepare_ioend: Enables filesystems to transform the writeback ioend or
perform any other preparatory work before the writeback I/O is
submitted.  This might include pre-write space accounting updates, or
installing a custom ->bi_end_io function for internal purposes such as
deferring the ioend completion to a workqueue to run metadata update
transactions from process context.  This function is optional."

> > +    is submitted.
> > +    A filesystem can override the ``->bi_end_io`` function for its own
> > +    purposes, such as kicking the ioend completion to a workqueue if the
> > +    bio is completed in interrupt context.
> 
> Thanks this is also helpful. 

<nod>

> > +    This function is optional.
> > +
> > +  - ``discard_folio``: iomap calls this function after ``->map_blocks``
> > +    fails schedule I/O for any part of a dirty folio.
> 
> fails "to" schedule

Thanks, fixed.

> > +    The function should throw away any reservations that may have been
> > +    made for the write.
> > +    The folio will be marked clean and an ``-EIO`` recorded in the
> > +    pagecache.
> > +    Filesystems can use this callback to `remove
> > +    <https://lore.kernel.org/all/20201029163313.1766967-1-bfoster@redhat.com/>`_
> > +    delalloc reservations to avoid having delalloc reservations for
> > +    clean pagecache.
> > +    This function is optional.
> > +
> > +Writeback ioend Completion
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +iomap creates chains of ``struct iomap_ioend`` objects that wrap the
> > +``bio`` that is used to write pagecache data to disk.
> > +By default, iomap finishes writeback ioends by clearing the writeback
> > +bit on the folios attached to the ``ioend``.
> > +If the write failed, it will also set the error bits on the folios and
> > +the address space.
> > +This can happen in interrupt or process context, depending on the
> > +storage device.
> > +
> > +Filesystems that need to update internal bookkeeping (e.g. unwritten
> > +extent conversions) should provide a ``->prepare_ioend`` function to
> 
> Ok, you did actually mention the unwritten conversion example here.
> However no harm in also mentioning this in the section which gives info
> about ->prepare_ioend callback :)

Ok, I'll reference that again:

"This function should call iomap_finish_ioends after finishing its own
work (e.g. unwritten extent conversion)."

> > +override the ``struct iomap_end::bio::bi_end_io`` with its own function.
> > +This function should call ``iomap_finish_ioends`` after finishing its
> > +own work.
> > +
> > +Some filesystems may wish to `amortize the cost of running metadata
> > +transactions
> > +<https://lore.kernel.org/all/20220120034733.221737-1-david@fromorbit.com/>`_
> > +for post-writeback updates by batching them.
> 
> > +They may also require transactions to run from process context, which
> > +implies punting batches to a workqueue.
> > +iomap ioends contain a ``list_head`` to enable batching.
> > +
> > +Given a batch of ioends, iomap has a few helpers to assist with
> > +amortization:
> > +
> > + * ``iomap_sort_ioends``: Sort all the ioends in the list by file
> > +   offset.
> > +
> > + * ``iomap_ioend_try_merge``: Given an ioend that is not in any list and
> > +   a separate list of sorted ioends, merge as many of the ioends from
> > +   the head of the list into the given ioend.
> > +   ioends can only be merged if the file range and storage addresses are
> > +   contiguous; the unwritten and shared status are the same; and the
> > +   write I/O outcome is the same.
> > +   The merged ioends become their own list.
> > +
> > + * ``iomap_finish_ioends``: Finish an ioend that possibly has other
> > +   ioends linked to it.
> > +
> 
> Again sorry for stopping here. I will continue the review from Direct-io later.

Ok, see you tomorrow.

--D

> Thanks!
> -ritesh
> 

