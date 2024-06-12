Return-Path: <linux-fsdevel+bounces-21635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8D2906ABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 13:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D881F23995
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652AD14374A;
	Thu, 13 Jun 2024 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJ5aMBmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130513F44A;
	Thu, 13 Jun 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276933; cv=none; b=Q3+m6DBbOyjOoxtIAtQqj4sWqpv1ievqrO/m919jWborc3n1TK//MRSGuKpNgyZP4SRrq0H668HiNfXIQatVnbbiwZnbR8cBG7UUZJv5DP15SfnMMlHIdWy+KAS+VQ7VHVyXAC6mnsnpd1Mqc900m29ILqnIkycFlsrfGFI1tlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276933; c=relaxed/simple;
	bh=nFKjSa+qoAdp6+2qGmT1+JMqYxAJPvmA+E5gTIr0yhA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=DyTyBcPy1WwlRqYRGYZFl4uKUasltLq0t4s2MahKNEuZMAAyz62VspUHu756hnSIih5rOPSToLrYOn8gdr4W9BPiX3IMXLHtzSwjSBR0lU53OBsjRO2YmoXDQUsM3kXC1qcYFALzr57lRvi4F8ff5rNTeoOLAmr2iHgOAetxkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJ5aMBmU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-705c1220a52so862275b3a.1;
        Thu, 13 Jun 2024 04:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718276931; x=1718881731; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJasjnMgrYZ7K8WEVnoCc4Z6TujXkc1RvD922MbCs8E=;
        b=eJ5aMBmUgMWR3rwwQQ2S6moKRZYSyVrgnRZWu+3J/Pef0JpEtpVgFbZGxH39oYinha
         W/boil00d2U+mwfX4/Wu9uwAu8AWLYTYzHpjup9ldJeLKy28EoSPN2CCjI0SC+mVgTn8
         VnoXO/nkSO85K0booG0+uICOjguEjtjRfNfI7S0U7NhlDTdZKwovEYW35xdFCKFsbRkn
         m53IaR0+QIu7WdpX2cmMFElUprAvrBTILMvGpHo4Vx7XcEI/+qnaFzMtDnq5ljSuXpcu
         SpfjRZl/yy9fIGpPjwSQ2vyntJq/2yQfKtjoQ5j2pWFTSR1bxJRfT8rWeCyDoUuTvwZ0
         +h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718276931; x=1718881731;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJasjnMgrYZ7K8WEVnoCc4Z6TujXkc1RvD922MbCs8E=;
        b=ouMlaeDHJxwVb9QHyWLy11PSVqbpiuUba1MHIEJOnVTgZMbLSn0/JwUrLsqZPEf7qv
         qjuXNcstsMvFbhqm5lfkNlSutX3FWKnSw1V81zkVvHAcBhjykeM0x1jPUTB135npP/9d
         U2ihJeVKp/qbA0trimbqcIb4zJmRBusHpWpzZ8E7GYa0ZOlPrHtH/O55XYbSLSSlJE3x
         ZJVyj/23j6oCONwYsC3a/dBHnCSA4SHJdzQensrjXfacBe1tCAmb+kranmy7+PL0XZji
         DtbCgR4RTZguoeIRkWnIViK1cnVY3ziNyA4m4BFwlK4N+FzihSJqpK3q+06sjRiXaoOV
         Bkow==
X-Forwarded-Encrypted: i=1; AJvYcCUmZphc88IOHsFHfZ9FxCOZFFAS5fU15j9z2oy1/QgMFsRHLxwySeOtvP2OnVw3ygxbyOrmHkBkBKUTrvSHVXn9LDvTvTF2irc9K25TvQC/UlznjPBY1NwZHaQwfiuNQsiXDU3brVPK2w==
X-Gm-Message-State: AOJu0YxK/A513VYmzNz9UmGnRO6BZkTj6HUVvIymyqcXnzJCEPSm6JVf
	l8aB+lIwTxKPSKDpVE8yVsdkTfFDqExLyBQoLg71yMYm/B2RNI95
X-Google-Smtp-Source: AGHT+IGGbR6SG1aOBIrjbi07FeTGKyiVAASfm0L070OqrFw7PnycPJYdYZ1rvjnKrRTr6RT9Vgt/ag==
X-Received: by 2002:a05:6a21:9988:b0:1b4:82db:26ef with SMTP id adf61e73a8af0-1b8a9ba6deemr5279989637.24.1718276930833;
        Thu, 13 Jun 2024 04:08:50 -0700 (PDT)
Received: from dw-tp ([171.76.81.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e72203sm11242305ad.98.2024.06.13.04.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:08:50 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to port
In-Reply-To: <20240608001707.GD52973@frogsfrogsfrogs>
Date: Wed, 12 Jun 2024 18:54:02 +0530
Message-ID: <878qza2t1p.fsf@gmail.com>
References: <20240608001707.GD52973@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


<snip>
> +Direct I/O
> +----------
> +
> +In Linux, direct I/O is defined as file I/O that is issued directly to
> +storage, bypassing the pagecache.
> +
> +The ``iomap_dio_rw`` function implements O_DIRECT (direct I/O) reads and
> +writes for files.
> +An optional ``ops`` parameter can be passed to change the behavior of
> +direct I/O.

Did you mean "dops" iomap_dio_ops (instead of ops)?

ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
		unsigned int dio_flags, void *private, size_t done_before);

1. Also can you please explain what you meant by "change the behavior of
direct-io"?

2. Do you think we should add the function declaration of
iomap_dio_rw() here, given it has so many arguments?


> +The ``done_before`` parameter should be set if writes have been
> +initiated prior to the call.

I don't think this is specific to "writes" alone. 

Maybe this?

The ``done_before`` parameter tells the how much of the request has
already been transferred. It gets used for finishing a request
asynchronously when part of the request has already been complete
synchronously.

Maybe please also add a the link to this (for easy reference).
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c03098d4b9ad76bca2966a8769dcfe59f7f85103

> +The direction of the I/O is determined from the ``iocb`` passed in.
> +
> +The ``flags`` argument can be any of the following values:

Callers of iomap_dio_rw() can set the flags argument which can be any of
the following values:

Just a bit more descriptive ^^^

> +
> + * ``IOMAP_DIO_FORCE_WAIT``: Wait for the I/O to complete even if the
> +   kiocb is not synchronous.

Adding an example would be nice.

e.g. callers might want to consider setting this flag for extending writes.

> +
> + * ``IOMAP_DIO_OVERWRITE_ONLY``: Allocating blocks, zeroing partial
> +   blocks, and extensions of the file size are not allowed.
> +   The entire file range must to map to a single written or unwritten
                                ^^^ an extra to

> +   extent.
> +   This flag exists to enable issuing concurrent direct IOs with only
> +   the shared ``i_rwsem`` held when the file I/O range is not aligned to
> +   the filesystem block size.
> +   ``-EAGAIN`` will be returned if the operation cannot proceed.

Can we please add these below details too. I would rather avoid wasting
my time in searching the history about, why EXT4 does not use this flag :)

Currently XFS uses this flag. EXT4 does not use it since it checks for
overwrites or unaligned overwrites and uses appropriate locking
up front rather than on a retry response to -EAGAIN [1] [2].

[1]: https://lore.kernel.org/linux-ext4/20230810165559.946222-1-bfoster@redhat.com/
[2]: https://lore.kernel.org/linux-ext4/20230314130759.642710-1-bfoster@redhat.com/

> +
> + * ``IOMAP_DIO_PARTIAL``: If a page fault occurs, return whatever
> +   progress has already been made.
> +   The caller may deal with the page fault and retry the operation.

Callers use ``dio_before`` argument along with ``IOMAP_DIO_PARTIAL`` to
tell the iomap subsystem about how much of the requested I/O was already
done.

> +
> +These ``struct kiocb`` flags are significant for direct I/O with iomap:
> +
> + * ``IOCB_NOWAIT``: Only proceed with the I/O if mapping data are
> +   already in memory, we do not have to initiate other I/O, and we
> +   acquire all filesystem locks without blocking.
> +

Maybe explicitly mentioning about "no block allocation"?

* ``IOCB_NOWAIT``: Only proceed with the I/O if mapping data are
  already in memory, we do not have to initiate other I/O or do any
  block allocations, and we acquire all filesystem locks without
  blocking.
  
> + * ``IOCB_SYNC``: Ensure that the device has persisted data to disk
> +   BEFORE completing the call.
> +   In the case of pure overwrites, the I/O may be issued with FUA
> +   enabled.
> +
> + * ``IOCB_HIPRI``: Poll for I/O completion instead of waiting for an
> +   interrupt.
> +   Only meaningful for asynchronous I/O, and only if the entire I/O can
> +   be issued as a single ``struct bio``.
> +
> + * ``IOCB_DIO_CALLER_COMP``: Try to run I/O completion from the caller's
> +   process context.
> +   See ``linux/fs.h`` for more details.
> +
> +Filesystems should call ``iomap_dio_rw`` from ``->read_iter`` and
> +``->write_iter``, and set ``FMODE_CAN_ODIRECT`` in the ``->open``
> +function for the file.
> +They should not set ``->direct_IO``, which is deprecated.
> +

Return value: 
~~~~~~~~~~~~~
On success it will return the number of bytes transferred. On failure it
will return a negative error value. 

Note:
-ENOTBLK is a magic return value which callers may use for falling back
to buffered-io. ->iomap_end()/->iomap_begin() can decide to return this
magic return value if it decides to fallback to buffered-io. iomap
subsystem return this value in case if it fails to invalidate the
pagecache pages belonging to the direct-io range before initiating the
direct-io.

-EIOCBQUEUED is returned when an async direct-io request is queued for I/O. 

> +If a filesystem wishes to perform its own work before direct I/O
> +completion, it should call ``__iomap_dio_rw``.
> +If its return value is not an error pointer or a NULL pointer, the
> +filesystem should pass the return value to ``iomap_dio_complete`` after
> +finishing its internal work.
> +
> +Direct Reads
> +~~~~~~~~~~~~
> +
> +A direct I/O read initiates a read I/O from the storage device to the
> +caller's buffer.
> +Dirty parts of the pagecache are flushed to storage before initiating
> +the read io.
> +The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DIRECT`` with
> +any combination of the following enhancements:
> +
> + * ``IOMAP_NOWAIT``: Read if mapping data are already in memory.
> +   Does not initiate other I/O or block on filesystem locks.
> +
> +Callers commonly hold ``i_rwsem`` in shared mode.
> +
> +Direct Writes
> +~~~~~~~~~~~~~
> +
> +A direct I/O write initiates a write I/O to the storage device to the
> +caller's buffer.

to the storage device "from" the caller's buffer.

> +Dirty parts of the pagecache are flushed to storage before initiating
> +the write io.
> +The pagecache is invalidated both before and after the write io.
> +The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DIRECT |
> +IOMAP_WRITE`` with any combination of the following enhancements:
> +
> + * ``IOMAP_NOWAIT``: Write if mapping data are already in memory.
> +   Does not initiate other I/O or block on filesystem locks.
> + * ``IOMAP_OVERWRITE_ONLY``: Allocating blocks and zeroing partial
> +   blocks is not allowed.
> +   The entire file range must to map to a single written or unwritten
> +   extent.
> +   The file I/O range must be aligned to the filesystem block size.
> +
> +Callers commonly hold ``i_rwsem`` in shared or exclusive mode.
> +
> +struct iomap_dio_ops:
> +~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: c
> +
> + struct iomap_dio_ops {
> +     void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
> +                       loff_t file_offset);
> +     int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
> +                   unsigned flags);
> +     struct bio_set *bio_set;
> + };
> +
> +The fields of this structure are as follows:
> +
> +  - ``submit_io``: iomap calls this function when it has constructed a
> +    ``struct bio`` object for the I/O requested, and wishes to submit it
> +    to the block device.
> +    If no function is provided, ``submit_bio`` will be called directly.
> +    Filesystems that would like to perform additional work before (e.g.
> +    data replication for btrfs) should implement this function.
> +
> +  - ``end_io``: This is called after the ``struct bio`` completes.
> +    This function should perform post-write conversions of unwritten
> +    extent mappings, handle write failures, etc.
> +    The ``flags`` argument may be set to a combination of the following:
> +
> +    * ``IOMAP_DIO_UNWRITTEN``: The mapping was unwritten, so the ioend
> +      should mark the extent as written.
> +
> +    * ``IOMAP_DIO_COW``: Writing to the space in the mapping required a
> +      copy on write operation, so the ioend should switch mappings.
> +
> +  - ``bio_set``: This allows the filesystem to provide a custom bio_set
> +    for allocating direct I/O bios.
> +    This enables filesystems to `stash additional per-bio information
> +    <https://lore.kernel.org/all/20220505201115.937837-3-hch@lst.de/>`_
> +    for private use.
> +    If this field is NULL, generic ``struct bio`` objects will be used.
> +
> +Filesystems that want to perform extra work after an I/O completion
> +should set a custom ``->bi_end_io`` function via ``->submit_io``.
> +Afterwards, the custom endio function must call
> +``iomap_dio_bio_end_io`` to finish the direct I/O.
> +
> +DAX I/O
> +-------
> +
> +Storage devices that can be directly mapped as memory support a new
> +access mode known as "fsdax".

Added a comma before "support" for better readability.

Storage devices that can be directly mapped as memory, support a new
access mode known as "fsdax".


> +
> +fsdax Reads
> +~~~~~~~~~~~
> +
> +A fsdax read performs a memcpy from storage device to the caller's
> +buffer.
> +The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DAX`` with any
> +combination of the following enhancements:
> +
> + * ``IOMAP_NOWAIT``: Read if mapping data are already in memory.
> +   Does not initiate other I/O or block on filesystem locks.
> +
> +Callers commonly hold ``i_rwsem`` in shared mode.
>   +
> +fsdax Writes
> +~~~~~~~~~~~~
> +
> +A fsdax write initiates a memcpy to the storage device to the caller's

"from" the storage device

> +buffer.
> +The ``flags`` value for ``->iomap_begin`` will be ``IOMAP_DAX |
> +IOMAP_WRITE`` with any combination of the following enhancements:
> +
> + * ``IOMAP_NOWAIT``: Write if mapping data are already in memory.
> +   Does not initiate other I/O or block on filesystem locks.
> +
> + * ``IOMAP_OVERWRITE_ONLY``: Allocating blocks and zeroing partial
> +   blocks is not allowed.
> +   The entire file range must to map to a single written or unwritten
> +   extent.
> +   The file I/O range must be aligned to the filesystem block size.
> +
> +Callers commonly hold ``i_rwsem`` in exclusive mode.
> +
> +mmap Faults
> +~~~~~~~~~~~
> +
> +The ``dax_iomap_fault`` function handles read and write faults to fsdax
> +storage.
> +For a read fault, ``IOMAP_DAX | IOMAP_FAULT`` will be passed as the
> +``flags`` argument to ``->iomap_begin``.
> +For a write fault, ``IOMAP_DAX | IOMAP_FAULT | IOMAP_WRITE`` will be
> +passed as the ``flags`` argument to ``->iomap_begin``.
> +
> +Callers commonly hold the same locks as they do to call their iomap
> +pagecache counterparts.
> +
> +Truncation, fallocate, and Unsharing
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +For fsdax files, the following functions are provided to replace their
> +iomap pagecache I/O counterparts.
> +The ``flags`` argument to ``->iomap_begin`` are the same as the
> +pagecache counterparts, with ``IOMAP_DIO`` added.

with "IOMAP_DAX"


> +
> + * ``dax_file_unshare``
> + * ``dax_zero_range``
> + * ``dax_truncate_page``

Shall we mention
"dax_remap_file_range_prep()/dax_dedupe_file_range_compare()" ?

> +
> +Callers commonly hold the same locks as they do to call their iomap
> +pagecache counterparts.
> +

Stopping here for now. Will resume the rest of the document review
later.

-ritesh

