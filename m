Return-Path: <linux-fsdevel+bounces-21663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA5A907A68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 19:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D361F2439F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9DB14A619;
	Thu, 13 Jun 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwH41Q0v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2B614A089;
	Thu, 13 Jun 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301503; cv=none; b=SVSP2rifZscBxLC0cjvamU/zdv4kBUYDqirGOOTazY5zMH3fhAAmLJKuaT8jOYRz7BKFkbO34w3AxDg+ZaDywdyoeSgRCxaaHqXgf0jp1Uqxu6Jj5pLgPWY4GluV9zQdJXo7+FltE6H0/8LyZbUSNzQWkfQIFyd46ItM/FlZ+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301503; c=relaxed/simple;
	bh=bgFDf0RcHIHWl5mkjwGNAsJfd7ndu2ENses6VhQLacY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1yK7ZvboIUpgqCwkE9WdJYKNPjYe9Qtp5jvslEO5dOH2g7M3rOqhiD378Zhk5MVn7bO5FLrRWijpETrCal0rLaBsbmokRhNM1nS4Ghlph6bw6yx4W2N1t58R8coBfiSnYT+KBH1j4H59b0YzYXIgZXd7J8iMcW3u4kS5/RkPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwH41Q0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A72C3277B;
	Thu, 13 Jun 2024 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718301503;
	bh=bgFDf0RcHIHWl5mkjwGNAsJfd7ndu2ENses6VhQLacY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwH41Q0v4tpBKYeX/83G20ZrVDtrVkmuBqVv6I2MC1lWlz6Q2cHlz0OscAIE9ggBv
	 cCDqtTl4DAAseU6ttU96TXXlcE/djo2r49+Gh1Mrhn+h+76iB+JD7LV3hHgaCfCKIB
	 dJJXxM1po6VDKWUEX6f1r7XaE7EgFEso0DowrVh+NztjdEgHi25JmRt9oy5JkVMfHC
	 /ahOxSBlYhgKxbpJ0Y3zzic3qnnk1GNV24I1MAtIv/IHCAMPykmW2lk68zNEMX+UIr
	 Oy+u3dlasIs0qEHRlqB1KGkOlaLaBWfeemcWTD00ya9bG69FEWv+SxQwz/h2L62pEF
	 e9dyTwDDb+RdA==
Date: Thu, 13 Jun 2024 10:58:22 -0700
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
Message-ID: <20240613175822.GA3855056@frogsfrogsfrogs>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <878qza2t1p.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qza2t1p.fsf@gmail.com>

On Wed, Jun 12, 2024 at 06:54:02PM +0530, Ritesh Harjani wrote:
> 
> <snip>
> > +Direct I/O
> > +----------
> > +
> > +In Linux, direct I/O is defined as file I/O that is issued directly to
> > +storage, bypassing the pagecache.
> > +
> > +The ``iomap_dio_rw`` function implements O_DIRECT (direct I/O) reads and
> > +writes for files.
> > +An optional ``ops`` parameter can be passed to change the behavior of
> > +direct I/O.
> 
> Did you mean "dops" iomap_dio_ops (instead of ops)?

Oops, yes.

> ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> 		unsigned int dio_flags, void *private, size_t done_before);
> 
> 1. Also can you please explain what you meant by "change the behavior of
> direct-io"?

"The filesystem can provide the ``dops`` parameter if it needs to
perform extra work before or after the I/O is issued to storage."

> 
> 2. Do you think we should add the function declaration of
> iomap_dio_rw() here, given it has so many arguments?

Will do.

> > +The ``done_before`` parameter should be set if writes have been
> > +initiated prior to the call.
> 
> I don't think this is specific to "writes" alone. 
> 
> Maybe this?
> 
> The ``done_before`` parameter tells the how much of the request has
> already been transferred. It gets used for finishing a request
> asynchronously when part of the request has already been complete
> synchronously.
> 
> Maybe please also add a the link to this (for easy reference).
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c03098d4b9ad76bca2966a8769dcfe59f7f85103

Yep, thanks for that.

> > +The direction of the I/O is determined from the ``iocb`` passed in.
> > +
> > +The ``flags`` argument can be any of the following values:
> 
> Callers of iomap_dio_rw() can set the flags argument which can be any of
> the following values:
> 
> Just a bit more descriptive ^^^
> 
> > +
> > + * ``IOMAP_DIO_FORCE_WAIT``: Wait for the I/O to complete even if the
> > +   kiocb is not synchronous.
> 
> Adding an example would be nice.
> 
> e.g. callers might want to consider setting this flag for extending writes.
> 
> > +
> > + * ``IOMAP_DIO_OVERWRITE_ONLY``: Allocating blocks, zeroing partial
> > +   blocks, and extensions of the file size are not allowed.
> > +   The entire file range must to map to a single written or unwritten
>                                 ^^^ an extra to
> 
> > +   extent.
> > +   This flag exists to enable issuing concurrent direct IOs with only
> > +   the shared ``i_rwsem`` held when the file I/O range is not aligned to
> > +   the filesystem block size.
> > +   ``-EAGAIN`` will be returned if the operation cannot proceed.
> 
> Can we please add these below details too. I would rather avoid wasting
> my time in searching the history about, why EXT4 does not use this flag :)
> 
> Currently XFS uses this flag. EXT4 does not use it since it checks for
> overwrites or unaligned overwrites and uses appropriate locking
> up front rather than on a retry response to -EAGAIN [1] [2].
> 
> [1]: https://lore.kernel.org/linux-ext4/20230810165559.946222-1-bfoster@redhat.com/
> [2]: https://lore.kernel.org/linux-ext4/20230314130759.642710-1-bfoster@redhat.com/

Ok.  I'll just mention that it's a performance optimization to reduce
lock contention, but that a lot of detailed checking is required to do
it correctly.

> > +
> > + * ``IOMAP_DIO_PARTIAL``: If a page fault occurs, return whatever
> > +   progress has already been made.
> > +   The caller may deal with the page fault and retry the operation.
> 
> Callers use ``dio_before`` argument along with ``IOMAP_DIO_PARTIAL`` to
> tell the iomap subsystem about how much of the requested I/O was already
> done.

Let's be more specific than that -- if the caller decides to perform
multiple retries, then the done_before parameter to the next call should
be the accumulated return values of all the previous attempts.

> > +
> > +These ``struct kiocb`` flags are significant for direct I/O with iomap:
> > +
> > + * ``IOCB_NOWAIT``: Only proceed with the I/O if mapping data are
> > +   already in memory, we do not have to initiate other I/O, and we
> > +   acquire all filesystem locks without blocking.
> > +
> 
> Maybe explicitly mentioning about "no block allocation"?
> 
> * ``IOCB_NOWAIT``: Only proceed with the I/O if mapping data are
>   already in memory, we do not have to initiate other I/O or do any
>   block allocations, and we acquire all filesystem locks without
>   blocking.

Oh, I changed all these NOWAIT bits to define what nowait means (i.e.
dave's long paragraph about it) in its own section, and all these bullet
points merely point back to that definition.

> > + * ``IOCB_SYNC``: Ensure that the device has persisted data to disk
> > +   BEFORE completing the call.
> > +   In the case of pure overwrites, the I/O may be issued with FUA
> > +   enabled.
> > +
> > + * ``IOCB_HIPRI``: Poll for I/O completion instead of waiting for an
> > +   interrupt.
> > +   Only meaningful for asynchronous I/O, and only if the entire I/O can
> > +   be issued as a single ``struct bio``.
> > +
> > + * ``IOCB_DIO_CALLER_COMP``: Try to run I/O completion from the caller's
> > +   process context.
> > +   See ``linux/fs.h`` for more details.
> > +
> > +Filesystems should call ``iomap_dio_rw`` from ``->read_iter`` and
> > +``->write_iter``, and set ``FMODE_CAN_ODIRECT`` in the ``->open``
> > +function for the file.
> > +They should not set ``->direct_IO``, which is deprecated.
> > +
> 
> Return value: 
> ~~~~~~~~~~~~~
> On success it will return the number of bytes transferred. On failure it
> will return a negative error value. 
> 
> Note:
> -ENOTBLK is a magic return value which callers may use for falling back
> to buffered-io. ->iomap_end()/->iomap_begin() can decide to return this
> magic return value if it decides to fallback to buffered-io. iomap
> subsystem return this value in case if it fails to invalidate the
> pagecache pages belonging to the direct-io range before initiating the
> direct-io.
> 
> -EIOCBQUEUED is returned when an async direct-io request is queued for I/O. 

Done.

> > +If a filesystem wishes to perform its own work before direct I/O
> > +completion, it should call ``__iomap_dio_rw``.
> > +If its return value is not an error pointer or a NULL pointer, the
> > +filesystem should pass the return value to ``iomap_dio_complete`` after
> > +finishing its internal work.
> > +
> > +Direct Reads
> > +~~~~~~~~~~~~
> > +
> > +A direct I/O read initiates a read I/O from the storage device to the
> > +caller's buffer.
> > +Dirty parts of the pagecache are flushed to storage before initiating
> > +the read io.
> > +The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DIRECT`` with
> > +any combination of the following enhancements:
> > +
> > + * ``IOMAP_NOWAIT``: Read if mapping data are already in memory.
> > +   Does not initiate other I/O or block on filesystem locks.
> > +
> > +Callers commonly hold ``i_rwsem`` in shared mode.
> > +
> > +Direct Writes
> > +~~~~~~~~~~~~~
> > +
> > +A direct I/O write initiates a write I/O to the storage device to the
> > +caller's buffer.
> 
> to the storage device "from" the caller's buffer.

Heh, oooops.  Thanks for catching that.

> > +Dirty parts of the pagecache are flushed to storage before initiating
> > +the write io.
> > +The pagecache is invalidated both before and after the write io.
> > +The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DIRECT |
> > +IOMAP_WRITE`` with any combination of the following enhancements:
> > +
> > + * ``IOMAP_NOWAIT``: Write if mapping data are already in memory.
> > +   Does not initiate other I/O or block on filesystem locks.
> > + * ``IOMAP_OVERWRITE_ONLY``: Allocating blocks and zeroing partial
> > +   blocks is not allowed.
> > +   The entire file range must to map to a single written or unwritten
> > +   extent.
> > +   The file I/O range must be aligned to the filesystem block size.
> > +
> > +Callers commonly hold ``i_rwsem`` in shared or exclusive mode.
> > +
> > +struct iomap_dio_ops:
> > +~~~~~~~~~~~~~~~~~~~~~
> > +.. code-block:: c
> > +
> > + struct iomap_dio_ops {
> > +     void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
> > +                       loff_t file_offset);
> > +     int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
> > +                   unsigned flags);
> > +     struct bio_set *bio_set;
> > + };
> > +
> > +The fields of this structure are as follows:
> > +
> > +  - ``submit_io``: iomap calls this function when it has constructed a
> > +    ``struct bio`` object for the I/O requested, and wishes to submit it
> > +    to the block device.
> > +    If no function is provided, ``submit_bio`` will be called directly.
> > +    Filesystems that would like to perform additional work before (e.g.
> > +    data replication for btrfs) should implement this function.
> > +
> > +  - ``end_io``: This is called after the ``struct bio`` completes.
> > +    This function should perform post-write conversions of unwritten
> > +    extent mappings, handle write failures, etc.
> > +    The ``flags`` argument may be set to a combination of the following:
> > +
> > +    * ``IOMAP_DIO_UNWRITTEN``: The mapping was unwritten, so the ioend
> > +      should mark the extent as written.
> > +
> > +    * ``IOMAP_DIO_COW``: Writing to the space in the mapping required a
> > +      copy on write operation, so the ioend should switch mappings.
> > +
> > +  - ``bio_set``: This allows the filesystem to provide a custom bio_set
> > +    for allocating direct I/O bios.
> > +    This enables filesystems to `stash additional per-bio information
> > +    <https://lore.kernel.org/all/20220505201115.937837-3-hch@lst.de/>`_
> > +    for private use.
> > +    If this field is NULL, generic ``struct bio`` objects will be used.
> > +
> > +Filesystems that want to perform extra work after an I/O completion
> > +should set a custom ``->bi_end_io`` function via ``->submit_io``.
> > +Afterwards, the custom endio function must call
> > +``iomap_dio_bio_end_io`` to finish the direct I/O.
> > +
> > +DAX I/O
> > +-------
> > +
> > +Storage devices that can be directly mapped as memory support a new
> > +access mode known as "fsdax".
> 
> Added a comma before "support" for better readability.
> 
> Storage devices that can be directly mapped as memory, support a new
> access mode known as "fsdax".

Eh, I don't like the comma.  Maybe this should say a teensy bit more
about what fsdax even is?

"Some storage devices can be directly mapped as memory.
These devices support a new access mode known as fsdax that allows
loads and stores through the CPU and memory controller."

> 
> > +
> > +fsdax Reads
> > +~~~~~~~~~~~
> > +
> > +A fsdax read performs a memcpy from storage device to the caller's
> > +buffer.
> > +The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DAX`` with any
> > +combination of the following enhancements:
> > +
> > + * ``IOMAP_NOWAIT``: Read if mapping data are already in memory.
> > +   Does not initiate other I/O or block on filesystem locks.
> > +
> > +Callers commonly hold ``i_rwsem`` in shared mode.
> >   +
> > +fsdax Writes
> > +~~~~~~~~~~~~
> > +
> > +A fsdax write initiates a memcpy to the storage device to the caller's
> 
> "from" the storage device

Fixed, thank you.

> > +buffer.
> > +The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DAX |
> > +IOMAP_WRITE`` with any combination of the following enhancements:
> > +
> > + * ``IOMAP_NOWAIT``: Write if mapping data are already in memory.
> > +   Does not initiate other I/O or block on filesystem locks.
> > +
> > + * ``IOMAP_OVERWRITE_ONLY``: Allocating blocks and zeroing partial
> > +   blocks is not allowed.
> > +   The entire file range must to map to a single written or unwritten
> > +   extent.
> > +   The file I/O range must be aligned to the filesystem block size.
> > +
> > +Callers commonly hold ``i_rwsem`` in exclusive mode.
> > +
> > +mmap Faults
> > +~~~~~~~~~~~
> > +
> > +The ``dax_iomap_fault`` function handles read and write faults to fsdax
> > +storage.
> > +For a read fault, ``IOMAP_DAX | IOMAP_FAULT`` will be passed as the
> > +``flags`` argument to ``->iomap_begin``.
> > +For a write fault, ``IOMAP_DAX | IOMAP_FAULT | IOMAP_WRITE`` will be
> > +passed as the ``flags`` argument to ``->iomap_begin``.
> > +
> > +Callers commonly hold the same locks as they do to call their iomap
> > +pagecache counterparts.
> > +
> > +Truncation, fallocate, and Unsharing
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +For fsdax files, the following functions are provided to replace their
> > +iomap pagecache I/O counterparts.
> > +The ``flags`` argument to ``->iomap_begin`` are the same as the
> > +pagecache counterparts, with ``IOMAP_DIO`` added.
> 
> with "IOMAP_DAX"

Fixed, thanks.

> > +
> > + * ``dax_file_unshare``
> > + * ``dax_zero_range``
> > + * ``dax_truncate_page``
> 
> Shall we mention
> "dax_remap_file_range_prep()/dax_dedupe_file_range_compare()" ?

I think dax_remap_file_range_prep is a rather silly wrapper.  But I
suppose filesystems that support dax and reflink need to know about it,
so I'll add a section:

"Filesystems implementing the ``FIDEDUPERANGE`` ioctl must call the
``dax_remap_file_range_prep`` function with their own iomap read ops."

The only caller of dax_dedupe_file_range_compare is the vfs itself, so I
don't think this is worth mentioning.

> > +
> > +Callers commonly hold the same locks as they do to call their iomap
> > +pagecache counterparts.
> > +
> 
> Stopping here for now. Will resume the rest of the document review
> later.

Ok.  I didn't see this email before my previous reply.  You're pretty
close to the end, so I'll respin the series on the list after I see your
next reply.  An interim version is here:

https://djwong.org/docs/iomap/

--D

> -ritesh
> 

