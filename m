Return-Path: <linux-fsdevel+bounces-21439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218E1903CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D201C221F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136017C9ED;
	Tue, 11 Jun 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POsg5Lw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885717B420;
	Tue, 11 Jun 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111798; cv=none; b=Sh9K+VziJbEJL8SbGp0bIP1Sb803ePtT/lfPJVTGZH7A2thRwu7P4VJV9ZN03Imh90X5j2N/MGRXJsxL+VNfEaOsUYaJA0B/44IOJ4XwP+NgrTgOVWh5v0RgrucShj/x+na2EdDsUA4HJd0UMHeHdexYyuWZfIqLQJIIlIz0AQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111798; c=relaxed/simple;
	bh=znbZG285bJEjFdMAxkxe613W9htB9I/LjK6RQ3WegLI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=O1QvY+D6rVkqSpw3Xih5MziusM/0QTPa0JQaaxREbovvXksvA8mfTlusK+LZsuI7FCqhPZivQ6wbnmxApsM7M8aP2tbyVWH8fTXAd9oLunT/nvd+P3XuVOCCz5iu5C7UCNREFVHyhBHkh5xwEJ6NjWtAlz1hFi0jsZmJ1uHYCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POsg5Lw7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c2ecbc109fso2301418a91.1;
        Tue, 11 Jun 2024 06:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718111795; x=1718716595; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qnOSvAtj3z/S8CLhlmmIr6V7ehOViXmY+CuzB/8eVfE=;
        b=POsg5Lw7JOH3IT8L/2Lmg/F3EqJzeAlQRj6/MzvkudnTLIi7HrI+Fh77SLlYo6j1s+
         s74h/CrXmzDG+3ip89CeJ1M16IGVUln4JuTRuUCyLOdOEVJBUmM8z5S8lY9m1NWXhi6o
         0G2jb2Ai2x0OPHnPcnO1oo45nmRX0RzRmmpWXZZuochnVHaGwT+8ssDO8HZoh0O2O1E0
         vYqTPncUub3bzrk2h93DWjazdKP0IOkeylgtJJ0NQIW9GBFgcJyeRyh02yW7r/t9ClLa
         PsFs3AxaogjyXKR0uVCkkmyWGvzSLe1fMYyMSqN1tk3M8fTorWMP0y00Fo6Xf6VyXsr4
         DmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111795; x=1718716595;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnOSvAtj3z/S8CLhlmmIr6V7ehOViXmY+CuzB/8eVfE=;
        b=CRSZ8+zTLvZoW8p9jNPpmMII38Q3XLaUsiodEQFDQ7roWwr18SZ8deRzLY6h+phpL/
         Uwh4gsnthnnqYrl1A15vRVjCtsV611s7cV5aOeNbYW9v84b5WEWWOOxRxShlH23op+HT
         HPnYg60U3AEy9qxI6ayR/R13b7eEc0S6BMbXz9a7hm/t0z6keMCaFuM6p/VcrTXUs3lj
         htmEuau54/eqegtQ7CRsau7YhOihzLvL/yKNn3yrvDhbq4bIYoDLZ4edfYiOsnwyfjSF
         YsNS+sMNQsf7JypG9a1Mfdz/SYnUK+Hk9/F5ktSpEpDNz8gqDTyVRhqJIKaHNwyEBi1g
         7p9w==
X-Forwarded-Encrypted: i=1; AJvYcCVnC5c25lxIYhSrYTQGKjx/TB6FPBaX5IkyKNysue5n7iazUDTM9qgIIrxm96HMQmiV74Mf8rcgDOMz4vilCuIucX1BbkPSgDMuFrkSfVr1vRLApMZcrGJL3USdQz4R6ZsUFY5sLD2NoA==
X-Gm-Message-State: AOJu0YyBiPVmo/ozeaMpTIh+FDOrg3SdJ4Uu1XHM3tLOoPeg0gwnzC3S
	Jap6ufiAMTnSlQPF91QHSqu+e/+Nk6cwN5Fa1H6gWJSjrsDNDxr4
X-Google-Smtp-Source: AGHT+IHm+lmS4x7eS7nkgzUqvdPCZmlzfcuSQ0GAmJe5SKwO5Yy+2YcIO5Qg5FHnR9a/35nTPoo30A==
X-Received: by 2002:a17:90a:ce14:b0:2c2:f6c1:4d87 with SMTP id 98e67ed59e1d1-2c2f6c14e21mr6730234a91.20.1718111794970;
        Tue, 11 Jun 2024 06:16:34 -0700 (PDT)
Received: from dw-tp ([171.76.84.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2f8e2fbfesm5285192a91.34.2024.06.11.06.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 06:16:34 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to port
In-Reply-To: <20240608001707.GD52973@frogsfrogsfrogs>
Date: Tue, 11 Jun 2024 16:15:02 +0530
Message-ID: <874j9zahch.fsf@gmail.com>
References: <20240608001707.GD52973@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Hi Darrick,

Resuming my review from where I left off yesterday.

"Darrick J. Wong" <djwong@kernel.org> writes:

> From: Darrick J. Wong <djwong@kernel.org>
>
> This is the fourth attempt at documenting the design of iomap and how to
> port filesystems to use it.  Apologies for all the rst formatting, but
> it's necessary to distinguish code from regular text.
>
> A lot of this has been collected from various email conversations, code
> comments, commit messages, my own understanding of iomap, and
> Ritesh/Luis' previous efforts to create a document.  Please note a large
> part of this has been taken from Dave's reply to last iomap doc
> patchset. Thanks to Ritesh, Luis, Dave, Darrick, Matthew, Christoph and
> other iomap developers who have taken time to explain the iomap design
> in various emails, commits, comments etc.
>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Inspired-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  Documentation/filesystems/index.rst |    1 
>  Documentation/filesystems/iomap.rst | 1060 +++++++++++++++++++++++++++++++++++
>  MAINTAINERS                         |    1 
>  3 files changed, 1062 insertions(+)
>  create mode 100644 Documentation/filesystems/iomap.rst
>
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 8f5c1ee02e2f..b010cc8df32d 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -34,6 +34,7 @@ algorithms work.
>     seq_file
>     sharedsubtree
>     idmappings
> +   iomap
>  
>     automount-support
>  
> diff --git a/Documentation/filesystems/iomap.rst b/Documentation/filesystems/iomap.rst
> new file mode 100644
> index 000000000000..a478b55e4135
> --- /dev/null
> +++ b/Documentation/filesystems/iomap.rst
> @@ -0,0 +1,1060 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _iomap:
> +
> +..
> +        Dumb style notes to maintain the author's sanity:
> +        Please try to start sentences on separate lines so that
> +        sentence changes don't bleed colors in diff.
> +        Heading decorations are documented in sphinx.rst.
> +
> +============================
> +VFS iomap Design and Porting
> +============================
> +
> +.. toctree::
> +
> +Introduction
> +============
> +
> +iomap is a filesystem library for handling various filesystem operations
> +that involves mapping of file's logical offset ranges to physical
> +extents.
> +This origins of this library is the file I/O path that XFS once used; it
> +has now been extended to cover several other operations.
> +The library provides various APIs for implementing various file and
> +pagecache operations, such as:
> +
> + * Pagecache reads and writes
> + * Folio write faults to the pagecache
> + * Writeback of dirty folios
> + * Direct I/O reads and writes
> + * FIEMAP
> + * lseek ``SEEK_DATA`` and ``SEEK_HOLE``
> + * swapfile activation
> +
> +Who Should Read This?
> +=====================
> +
> +The target audience for this document are filesystem, storage, and
> +pagecache programmers and code reviewers.
> +The goal of this document is to provide a brief discussion of the
> +design and capabilities of iomap, followed by a more detailed catalog
> +of the interfaces presented by iomap.
> +If you change iomap, please update this design document.
> +
> +But Why?
> +========
> +
> +Unlike the classic Linux I/O model which breaks file I/O into small
> +units (generally memory pages or blocks) and looks up space mappings on
> +the basis of that unit, the iomap model asks the filesystem for the
> +largest space mappings that it can create for a given file operation and
> +initiates operations on that basis.
> +This strategy improves the filesystem's visibility into the size of the
> +operation being performed, which enables it to combat fragmentation with
> +larger space allocations when possible.
> +Larger space mappings improve runtime performance by amortizing the cost
> +of a mapping function call into the filesystem across a larger amount of
> +data.
> +
> +At a high level, an iomap operation `looks like this
> +<https://lore.kernel.org/all/ZGbVaewzcCysclPt@dread.disaster.area/>`_:
> +
> +1. For each byte in the operation range...
> +
> +   1. Obtain space mapping via ->iomap_begin
> +   2. For each sub-unit of work...
> +
> +      1. Revalidate the mapping and go back to (1) above, if necessary
> +      2. Do the work
> +
> +   3. Increment operation cursor
> +   4. Release the mapping via ->iomap_end, if necessary
> +
> +Each iomap operation will be covered in more detail below.
> +This library was covered previously by an `LWN article
> +<https://lwn.net/Articles/935934/>`_ and a `KernelNewbies page
> +<https://kernelnewbies.org/KernelProjects/iomap>`_.
> +
> +Data Structures and Algorithms
> +==============================
> +
> +Definitions
> +-----------
> +
> + * ``bufferhead``: Shattered remnants of the old buffer cache.
> + * ``fsblock``: The block size of a file, also known as ``i_blocksize``.
> + * ``i_rwsem``: The VFS ``struct inode`` rwsemaphore.
> + * ``invalidate_lock``: The pagecache ``struct address_space``
> +   rwsemaphore that protects against folio removal.
> +
> +struct iomap_ops
> +----------------
> +
> +Every iomap function requires the filesystem to pass an operations
> +structure to obtain a mapping and (optionally) to release the mapping.
> +
> +.. code-block:: c
> +
> + struct iomap_ops {
> +     int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
> +                        unsigned flags, struct iomap *iomap,
> +                        struct iomap *srcmap);
> +
> +     int (*iomap_end)(struct inode *inode, loff_t pos, loff_t length,
> +                      ssize_t written, unsigned flags,
> +                      struct iomap *iomap);
> + };
> +
> +The ``->iomap_begin`` function is called to obtain one mapping for the
> +range of bytes specified by ``pos`` and ``length`` for the file
> +``inode``.
> +
> +Each iomap operation describes the requested operation through the
> +``flags`` argument.
> +The exact value of ``flags`` will be documented in the
> +operation-specific sections below, but these principles apply generally:
> +
> + * For a write operation, ``IOMAP_WRITE`` will be set.
> +   Filesystems must not return ``IOMAP_HOLE`` mappings.
> +
> + * For any other operation, ``IOMAP_WRITE`` will not be set.
> +
> + * For any operation targetting direct access to storage (fsdax),
> +   ``IOMAP_DAX`` will be set.
> +
> +If it is necessary to read existing file contents from a `different
> +<https://lore.kernel.org/all/20191008071527.29304-9-hch@lst.de/>`_ device or
> +address range on a device, the filesystem should return that information via
> +``srcmap``.
> +Only pagecache and fsdax operations support reading from one mapping and
> +writing to another.
> +
> +After the operation completes, the ``->iomap_end`` function, if present,
> +is called to signal that iomap is finished with a mapping.
> +Typically, implementations will use this function to tear down any
> +context that were set up in ``->iomap_begin``.
> +For example, a write might wish to commit the reservations for the bytes
> +that were operated upon and unreserve any space that was not operated
> +upon.
> +``written`` might be zero if no bytes were touched.
> +``flags`` will contain the same value passed to ``->iomap_begin``.
> +iomap ops for reads are not likely to need to supply this function.
> +
> +Both functions should return a negative errno code on error, or zero.
> +
> +struct iomap
> +------------
> +
> +The filesystem returns the mappings via the following structure.
> +For documentation purposes, the structure has been reordered to group
> +fields that go together logically.
> +
> +.. code-block:: c
> +
> + struct iomap {
> +     loff_t                       offset;
> +     u64                          length;
> +
> +     u16                          type;
> +     u16                          flags;
> +
> +     u64                          addr;
> +     struct block_device          *bdev;
> +     struct dax_device            *dax_dev;
> +     void                         *inline_data;
> +
> +     void                         *private;
> +
> +     const struct iomap_folio_ops *folio_ops;
> +
> +     u64                          validity_cookie;
> + };
> +
> +The information is useful for translating file operations into action.
> +The actions taken are specific to the target of the operation, such as
> +disk cache, physical storage devices, or another part of the kernel.
> +
> + * ``offset`` and ``length`` describe the range of file offsets, in
> +   bytes, covered by this mapping.
> +   These fields must always be set by the filesystem.
> +
> + * ``type`` describes the type of the space mapping:
> +
> +   * **IOMAP_HOLE**: No storage has been allocated.
> +     This type must never be returned in response to an IOMAP_WRITE
> +     operation because writes must allocate and map space, and return
> +     the mapping.
> +     The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
> +     iomap does not support writing (whether via pagecache or direct
> +     I/O) to a hole.
> +
> +   * **IOMAP_DELALLOC**: A promise to allocate space at a later time
> +     ("delayed allocation").
> +     If the filesystem returns IOMAP_F_NEW here and the write fails, the
> +     ``->iomap_end`` function must delete the reservation.
> +     The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
> +
> +   * **IOMAP_MAPPED**: The file range maps to specific space on the
> +     storage device.
> +     The device is returned in ``bdev`` or ``dax_dev``.
> +     The device address, in bytes, is returned via ``addr``.
> +
> +   * **IOMAP_UNWRITTEN**: The file range maps to specific space on the
> +     storage device, but the space has not yet been initialized.
> +     The device is returned in ``bdev`` or ``dax_dev``.
> +     The device address, in bytes, is returned via ``addr``.
> +     Reads will return zeroes to userspace.
> +     For a write or writeback operation, the ioend should update the
> +     mapping to MAPPED.
> +
> +   * **IOMAP_INLINE**: The file range maps to the memory buffer
> +     specified by ``inline_data``.
> +     For write operation, the ``->iomap_end`` function presumably
> +     handles persisting the data.
> +     The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
> +
> + * ``flags`` describe the status of the space mapping.
> +   These flags should be set by the filesystem in ``->iomap_begin``:
> +
> +   * **IOMAP_F_NEW**: The space under the mapping is newly allocated.
> +     Areas that will not be written to must be zeroed.
> +     If a write fails and the mapping is a space reservation, the
> +     reservation must be deleted.
> +
> +   * **IOMAP_F_DIRTY**: The inode will have uncommitted metadata needed
> +     to access any data written.
> +     fdatasync is required to commit these changes to persistent
> +     storage.
> +     This needs to take into account metadata changes that *may* be made
> +     at I/O completion, such as file size updates from direct I/O.
> +
> +   * **IOMAP_F_SHARED**: The space under the mapping is shared.
> +     Copy on write is necessary to avoid corrupting other file data.
> +
> +   * **IOMAP_F_BUFFER_HEAD**: This mapping requires the use of buffer
> +     heads for pagecache operations.
> +     Do not add more uses of this.
> +
> +   * **IOMAP_F_MERGED**: Multiple contiguous block mappings were
> +     coalesced into this single mapping.
> +     This is only useful for FIEMAP.
> +
> +   * **IOMAP_F_XATTR**: The mapping is for extended attribute data, not
> +     regular file data.
> +     This is only useful for FIEMAP.
> +
> +   * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
> +     be set by the filesystem for its own purposes.
> +
> +   These flags can be set by iomap itself during file operations.
> +   The filesystem should supply an ``->iomap_end`` function to observe
> +   these flags:
> +
> +   * **IOMAP_F_SIZE_CHANGED**: The file size has changed as a result of
> +     using this mapping.
> +
> +   * **IOMAP_F_STALE**: The mapping was found to be stale.
> +     iomap will call ``->iomap_end`` on this mapping and then
> +     ``->iomap_begin`` to obtain a new mapping.
> +
> +   Currently, these flags are only set by pagecache operations.
> +
> + * ``addr`` describes the device address, in bytes.
> +
> + * ``bdev`` describes the block device for this mapping.
> +   This only needs to be set for mapped or unwritten operations.
> +
> + * ``dax_dev`` describes the DAX device for this mapping.
> +   This only needs to be set for mapped or unwritten operations, and
> +   only for a fsdax operation.
> +
> + * ``inline_data`` points to a memory buffer for I/O involving
> +   ``IOMAP_INLINE`` mappings.
> +   This value is ignored for all other mapping types.
> +
> + * ``private`` is a pointer to `filesystem-private information
> +   <https://lore.kernel.org/all/20180619164137.13720-7-hch@lst.de/>`_.
> +   This value will be passed unchanged to ``->iomap_end``.
> +
> + * ``folio_ops`` will be covered in the section on pagecache operations.
> +
> + * ``validity_cookie`` is a magic freshness value set by the filesystem
> +   that should be used to detect stale mappings.
> +   For pagecache operations this is critical for correct operation
> +   because page faults can occur, which implies that filesystem locks
> +   should not be held between ``->iomap_begin`` and ``->iomap_end``.
> +   Filesystems with completely static mappings need not set this value.
> +   Only pagecache operations revalidate mappings.
> +
> +   XXX: Should fsdax revalidate as well?
> +
> +Validation
> +==========
> +
> +**NOTE**: iomap only handles mapping and I/O.
> +Filesystems must still call out to the VFS to check input parameters
> +and file state before initiating an I/O operation.
> +It does not handle updating of timestamps, stripping privileges, or
> +access control.
> +
> +Locking Hierarchy
> +=================
> +
> +iomap requires that filesystems provide their own locking.
> +There are no locks within iomap itself, though in the course of an

That might not be totally true. There is a state_lock within iomap_folio_state ;)

> +operation iomap may take other locks (e.g. folio/dax locks) as part of
> +an I/O operation.

I think we need not mention "dax locks" here right? Since most of that
code is in fs/dax.c anyways?

> +Locking with iomap can be split into two categories: above and below
> +iomap.
> +
> +The upper level of lock must coordinate the iomap operation with other
> +iomap operations.

Can we add some more details in this line or maybe an example? 
Otherwise confusing use of "iomap operation" term.

> +Generally, the filesystem must take VFS/pagecache locks such as
> +``i_rwsem`` or ``invalidate_lock`` before calling into iomap.
> +The exact locking requirements are specific to the type of operation.
> +
> +The lower level of lock must coordinate access to the mapping
> +information.
> +This lock is filesystem specific and should be held during
> +``->iomap_begin`` while sampling the mapping and validity cookie.
> +
> +The general locking hierarchy in iomap is:
> +
> + * VFS or pagecache lock
> +

There is also a folio lock within iomap which now comes below VFS or
pagecache lock.

> +   * Internal filesystem specific mapping lock

I think it will also be helpful if we give an example of this lock for
e.g. XFS(XFS_ILOCK) or ext4(i_data_sem)

> +
> +   * iomap operation-specific lock

some e.g. of what you mean here please?

> +
> +The exact locking requirements are specific to the filesystem; for
> +certain operations, some of these locks can be elided.
> +All further mention of locking are *recommendations*, not mandates.
> +Each filesystem author must figure out the locking for themself.

Is it also possible to explicitly list down the fact that folio_lock
order w.r.t VFS lock (i_rwsem) (is it even with pagecache lock??) is now
reversed with iomap v/s the legacy I/O model. 

There was an internal ext4 issue which got exposed due to this [1].
So it might be useful to document the lock order change now.

[1]: https://lore.kernel.org/linux-ext4/87cyqcyt6t.fsf@gmail.com/

> +
> +iomap Operations
> +================
> +
> +Below are a discussion of the file operations that iomap implements.
> +
> +Buffered I/O
> +------------
> +
> +Buffered I/O is the default file I/O path in Linux.
> +File contents are cached in memory ("pagecache") to satisfy reads and
> +writes.
> +Dirty cache will be written back to disk at some point that can be
> +forced via ``fsync`` and variants.
> +
> +iomap implements nearly all the folio and pagecache management that
> +filesystems once had to implement themselves.

nit: that "earlier in the legacy I/O model filesystems had to implement
themselves"

> +This means that the filesystem need not know the details of allocating,
> +mapping, managing uptodate and dirty state, or writeback of pagecache
> +folios.
> +Unless the filesystem explicitly opts in to buffer heads, they will not
> +be used, which makes buffered I/O much more efficient, and ``willy``

Could also please list down why buffered I/O is more efficient with
iomap (other than the fact that iomap has large folios)?

If I am not wrong, it comes from the fact that iomap only maintains
(other than sizeof iomap_folio_state once) 2 extra bytes per fsblock v/s
the 104 extra bytes of struct buffer_head per fsblock in the legacy I/O model. 
And while iterating over the pagecache pages, it is much faster to
set/clear the uptodate/dirty bits of a folio in iomap v/s iterating over
each bufferhead within a folio in legacy I/O model.

Right?

> +much happier.
> +
> +struct address_space_operations
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The following iomap functions can be referenced directly from the
> +address space operations structure:
> +
> + * ``iomap_dirty_folio``
> + * ``iomap_release_folio``
> + * ``iomap_invalidate_folio``
> + * ``iomap_is_partially_uptodate``
> +
> +The following address space operations can be wrapped easily:
> +
> + * ``read_folio``
> + * ``readahead``
> + * ``writepages``
> + * ``bmap``
> + * ``swap_activate``
> +
> +struct iomap_folio_ops
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``->iomap_begin`` function for pagecache operations may set the
> +``struct iomap::folio_ops`` field to an ops structure to override
> +default behaviors of iomap:
> +
> +.. code-block:: c
> +
> + struct iomap_folio_ops {
> +     struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
> +                                unsigned len);
> +     void (*put_folio)(struct inode *inode, lofs, unsigned copied,
> +                       struct folio *folio);
> +     bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> + };
> +
> +iomap calls these functions:
> +
> +  - ``get_folio``: Called to allocate and return an active reference to
> +    a locked folio prior to starting a write.
> +    If this function is not provided, iomap will call
> +    ``iomap_get_folio``.
> +    This could be used to `set up per-folio filesystem state
> +    <https://lore.kernel.org/all/20190429220934.10415-5-agruenba@redhat.com/>`_
> +    for a write.
> +
> +  - ``put_folio``: Called to unlock and put a folio after a pagecache
> +    operation completes.
> +    If this function is not provided, iomap will ``folio_unlock`` and
> +    ``folio_put`` on its own.
> +    This could be used to `commit per-folio filesystem state
> +    <https://lore.kernel.org/all/20180619164137.13720-6-hch@lst.de/>`_
> +    that was set up by ``->get_folio``.
> +
> +  - ``iomap_valid``: The filesystem may not hold locks between
> +    ``->iomap_begin`` and ``->iomap_end`` because pagecache operations
> +    can take folio locks, fault on userspace pages, initiate writeback
> +    for memory reclamation, or engage in other time-consuming actions.
> +    If a file's space mapping data are mutable, it is possible that the
> +    mapping for a particular pagecache folio can `change in the time it
> +    takes
> +    <https://lore.kernel.org/all/20221123055812.747923-8-david@fromorbit.com/>`_
> +    to allocate, install, and lock that folio.
> +    For such files, the mapping *must* be revalidated after the folio
> +    lock has been taken so that iomap can manage the folio correctly.
> +    The filesystem's ``->iomap_begin`` function must sample a sequence
> +    counter into ``struct iomap::validity_cookie`` at the same time that
> +    it populates the mapping fields.
> +    It must then provide a ``->iomap_valid`` function to compare the
> +    validity cookie against the source counter and return whether or not
> +    the mapping is still valid.
> +    If the mapping is not valid, the mapping will be sampled again.
> +
> +These ``struct kiocb`` flags are significant for buffered I/O with
> +iomap:
> +
> + * ``IOCB_NOWAIT``: Only proceed with the I/O if mapping data are
> +   already in memory, we do not have to initiate other I/O, and we
> +   acquire all filesystem locks without blocking.
> +   Neither this flag nor its definition ``RWF_NOWAIT`` actually define
> +   what this flag means, so this is the best the author could come up
> +   with.
> +
> +Internal per-Folio State
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +If the fsblock size matches the size of a pagecache folio, it is assumed
> +that all disk I/O operations will operate on the entire folio.
> +The uptodate (memory contents are at least as new as what's on disk) and
> +dirty (memory contents are newer than what's on disk) status of the
> +folio are all that's needed for this case.
> +
> +If the fsblock size is less than the size of a pagecache folio, iomap
> +tracks the per-fsblock uptodate and dirty state itself.
> +This enables iomap to handle both "bs < ps" `filesystems
> +<https://lore.kernel.org/all/20230725122932.144426-1-ritesh.list@gmail.com/>`_
> +and large folios in the pagecache.
> +
> +iomap internally tracks two state bits per fsblock:
> +
> + * ``uptodate``: iomap will try to keep folios fully up to date.
> +   If there are read(ahead) errors, those fsblocks will not be marked
> +   uptodate.
> +   The folio itself will be marked uptodate when all fsblocks within the
> +   folio are uptodate.
> +
> + * ``dirty``: iomap will set the per-block dirty state when programs
> +   write to the file.
> +   The folio itself will be marked dirty when any fsblock within the
> +   folio is dirty.
> +
> +iomap also tracks the amount of read and write disk IOs that are in
> +flight.
> +This structure is much lighter weight than ``struct buffer_head``.
> +
> +Filesystems wishing to turn on large folios in the pagecache should call
> +``mapping_set_large_folios`` when initializing the incore inode.
> +
> +Readahead and Reads
> +~~~~~~~~~~~~~~~~~~~
> +
> +The ``iomap_readahead`` function initiates readahead to the pagecache.
> +The ``iomap_read_folio`` function reads one folio's worth of data into
> +the pagecache.
> +The ``flags`` argument to ``->iomap_begin`` will be set to zero.
> +The pagecache takes whatever locks it needs before calling the
> +filesystem.
> +
> +Writes
> +~~~~~~
> +
> +The ``iomap_file_buffered_write`` function writes an ``iocb`` to the
> +pagecache.
> +``IOMAP_WRITE`` or ``IOMAP_WRITE`` | ``IOMAP_NOWAIT`` will be passed as
> +the ``flags`` argument to ``->iomap_begin``.
> +Callers commonly take ``i_rwsem`` in either shared or exclusive mode.

shared(e.g. aligned overwrites) 

> +
> +mmap Write Faults
> +^^^^^^^^^^^^^^^^^
> +
> +The ``iomap_page_mkwrite`` function handles a write fault to a folio the
> +pagecache.

"handles a write fault to the pagecache" ?


> +``IOMAP_WRITE | IOMAP_FAULT`` will be passed as the ``flags`` argument
> +to ``->iomap_begin``.
> +Callers commonly take the mmap ``invalidate_lock`` in shared or
> +exclusive mode.
> +
> +Write Failures
> +^^^^^^^^^^^^^^
> +
> +After a short write to the pagecache, the areas not written will not
> +become marked dirty.
> +The filesystem must arrange to `cancel
> +<https://lore.kernel.org/all/20221123055812.747923-6-david@fromorbit.com/>`_
> +such `reservations
> +<https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/>`_
> +because writeback will not consume the reservation.
> +The ``iomap_file_buffered_write_punch_delalloc`` can be called from a
> +``->iomap_end`` function to find all the clean areas of the folios
> +caching a fresh (``IOMAP_F_NEW``) delalloc mapping.
> +It takes the ``invalidate_lock``.
> +
> +The filesystem should supply a callback ``punch`` will be called for

The filesystem supplied ``punch`` callback will be called for...

> +each file range in this state.
> +This function must *only* remove delayed allocation reservations, in
> +case another thread racing with the current thread writes successfully
> +to the same region and triggers writeback to flush the dirty data out to
> +disk.
> +
> +Truncation
> +^^^^^^^^^^
> +
> +Filesystems can call ``iomap_truncate_page`` to zero the bytes in the
> +pagecache from EOF to the end of the fsblock during a file truncation
> +operation.
> +``truncate_setsize`` or ``truncate_pagecache`` will take care of
> +everything after the EOF block.
> +``IOMAP_ZERO`` will be passed as the ``flags`` argument to
> +``->iomap_begin``.
> +Callers typically take ``i_rwsem`` and ``invalidate_lock`` in exclusive
> +mode.
> +
> +Zeroing for File Operations
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Filesystems can call ``iomap_zero_range`` to perform zeroing of the
> +pagecache for non-truncation file operations that are not aligned to
> +the fsblock size.
> +``IOMAP_ZERO`` will be passed as the ``flags`` argument to
> +``->iomap_begin``.
> +Callers typically take ``i_rwsem`` and ``invalidate_lock`` in exclusive
> +mode.
> +
> +Unsharing Reflinked File Data
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Filesystems can call ``iomap_file_unshare`` to force a file sharing
> +storage with another file to preemptively copy the shared data to newly
> +allocate storage.
> +``IOMAP_WRITE | IOMAP_UNSHARE`` will be passed as the ``flags`` argument
> +to ``->iomap_begin``.
> +Callers typically take ``i_rwsem`` and ``invalidate_lock`` in exclusive
> +mode.
> +
> +Writeback
> +~~~~~~~~~
> +
> +Filesystems can call ``iomap_writepages`` to respond to a request to
> +write dirty pagecache folios to disk.
> +The ``mapping`` and ``wbc`` parameters should be passed unchanged.
> +The ``wpc`` pointer should be allocated by the filesystem and must
> +be initialized to zero.
> +
> +The pagecache will lock each folio before trying to schedule it for
> +writeback.
> +It does not lock ``i_rwsem`` or ``invalidate_lock``.
> +
> +The dirty bit will be cleared for all folios run through the
> +``->map_blocks`` machinery described below even if the writeback fails.
> +This is to prevent dirty folio clots when storage devices fail; an
> +``-EIO`` is recorded for userspace to collect via ``fsync``.
> +
> +The ``ops`` structure must be specified and is as follows:
> +
> +struct iomap_writeback_ops
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. code-block:: c
> +
> + struct iomap_writeback_ops {
> +     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
> +                       loff_t offset, unsigned len);
> +     int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
> +     void (*discard_folio)(struct folio *folio, loff_t pos);
> + };
> +
> +The fields are as follows:
> +
> +  - ``map_blocks``: Sets ``wpc->iomap`` to the space mapping of the file
> +    range (in bytes) given by ``offset`` and ``len``.
> +    iomap calls this function for each fs block in each dirty folio,
> +    even if the mapping returned is longer than one fs block.

It's no longer true after this patch right [1]. iomap calls this
function for each contiguous range of dirty fsblocks within a dirty folio.

[1]: https://lore.kernel.org/all/20231207072710.176093-15-hch@lst.de/

> +    Do not return ``IOMAP_INLINE`` mappings here; the ``->iomap_end``
> +    function must deal with persisting written data.
> +    Filesystems can skip a potentially expensive mapping lookup if the
> +    mappings have not changed.
> +    This revalidation must be open-coded by the filesystem; it is
> +    unclear if ``iomap::validity_cookie`` can be reused for this
> +    purpose.

struct iomap_writepage_ctx defines it's own ``struct iomap`` as a member. 

struct iomap_writepage_ctx {
	struct iomap		iomap;
	struct iomap_ioend	*ioend;
	const struct iomap_writeback_ops *ops;
	u32			nr_folios;	/* folios added to the ioend */
};

That means it does not conflict with the context which is doing buffered
writes (i.e. write_iter) and writeback is anyway single threaded.
So we should be able to use wpc->iomap.validity_cookie for validating
whether the cookie is valid or not during the course of writeback
operation - (IMO)


> +    This function is required.

This line is left incomplete.

I think we should also mention this right? - 

If the filesystem reserved delalloc extents during buffered-writes, than
they should allocate extents for those delalloc mappings in this
->map_blocks call.

> +
> +  - ``prepare_ioend``: Enables filesystems to transform the writeback
> +    ioend or perform any other prepatory work before the writeback I/O

IMO, some e.g. will be very helpful to add wherever possible. I
understand we should keep the document generic enough, but it is much
easier if we state some common examples of what XFS / other filesystems
do with such callback methods.

e.g. 

- What do we mean by "transform the writeback ioend"? I guess it is -
 XFS uses this for conversion of COW extents to regular extents?

- What do we mean by "perform any other preparatory work before the
  writeback I/O"? - I guess it is - 
  XFS hooks in custom a completion handler in ->prepare_ioend callback for
  conversion of unwritten extents.

> +    is submitted.
> +    A filesystem can override the ``->bi_end_io`` function for its own
> +    purposes, such as kicking the ioend completion to a workqueue if the
> +    bio is completed in interrupt context.

Thanks this is also helpful. 

> +    This function is optional.
> +
> +  - ``discard_folio``: iomap calls this function after ``->map_blocks``
> +    fails schedule I/O for any part of a dirty folio.

fails "to" schedule

> +    The function should throw away any reservations that may have been
> +    made for the write.
> +    The folio will be marked clean and an ``-EIO`` recorded in the
> +    pagecache.
> +    Filesystems can use this callback to `remove
> +    <https://lore.kernel.org/all/20201029163313.1766967-1-bfoster@redhat.com/>`_
> +    delalloc reservations to avoid having delalloc reservations for
> +    clean pagecache.
> +    This function is optional.
> +
> +Writeback ioend Completion
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +iomap creates chains of ``struct iomap_ioend`` objects that wrap the
> +``bio`` that is used to write pagecache data to disk.
> +By default, iomap finishes writeback ioends by clearing the writeback
> +bit on the folios attached to the ``ioend``.
> +If the write failed, it will also set the error bits on the folios and
> +the address space.
> +This can happen in interrupt or process context, depending on the
> +storage device.
> +
> +Filesystems that need to update internal bookkeeping (e.g. unwritten
> +extent conversions) should provide a ``->prepare_ioend`` function to

Ok, you did actually mention the unwritten conversion example here.
However no harm in also mentioning this in the section which gives info
about ->prepare_ioend callback :)

> +override the ``struct iomap_end::bio::bi_end_io`` with its own function.
> +This function should call ``iomap_finish_ioends`` after finishing its
> +own work.
> +
> +Some filesystems may wish to `amortize the cost of running metadata
> +transactions
> +<https://lore.kernel.org/all/20220120034733.221737-1-david@fromorbit.com/>`_
> +for post-writeback updates by batching them.

> +They may also require transactions to run from process context, which
> +implies punting batches to a workqueue.
> +iomap ioends contain a ``list_head`` to enable batching.
> +
> +Given a batch of ioends, iomap has a few helpers to assist with
> +amortization:
> +
> + * ``iomap_sort_ioends``: Sort all the ioends in the list by file
> +   offset.
> +
> + * ``iomap_ioend_try_merge``: Given an ioend that is not in any list and
> +   a separate list of sorted ioends, merge as many of the ioends from
> +   the head of the list into the given ioend.
> +   ioends can only be merged if the file range and storage addresses are
> +   contiguous; the unwritten and shared status are the same; and the
> +   write I/O outcome is the same.
> +   The merged ioends become their own list.
> +
> + * ``iomap_finish_ioends``: Finish an ioend that possibly has other
> +   ioends linked to it.
> +

Again sorry for stopping here. I will continue the review from Direct-io later.

Thanks!
-ritesh

