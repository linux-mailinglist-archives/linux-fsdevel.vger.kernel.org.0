Return-Path: <linux-fsdevel+bounces-21727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B619093C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 23:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1051B282E5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 21:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EAA185084;
	Fri, 14 Jun 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq+j2v4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE613A27E;
	Fri, 14 Jun 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718401567; cv=none; b=hKRYzIl1RTXtLhNYict5jBErIr23w1NuQKlEU6c+UIK4x9OSGANb461I7gU2q3zrvfBpwKmTlyiw911AXE3sb58HCwnIIHTysiyjYMIKW4l4CSb2AebFCrEhLn8zmwbzglRBj+yTuHu6wGnlI6tIvm8GN5QlXcIx6FQ+0byNBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718401567; c=relaxed/simple;
	bh=i4jX7659cAMQGML0/4MIrvWLaOXekkxxGp6cZqT4hA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfjdaZ4hu6l5UpzI88jr/vVGLPmgohx50XBbazwDpqCUWVW/BfVN5JNp7jLh3c2WLzAORLVWZFH81cccGeSSgil6Q8J74A/YYurdRLvEikxbD9AOEVoHZx8NlEQSbqgsMFpGm+RGHtssJDtmsey8/h5DgUxqK93l4L6zzB5mzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq+j2v4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A68C2BD10;
	Fri, 14 Jun 2024 21:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718401567;
	bh=i4jX7659cAMQGML0/4MIrvWLaOXekkxxGp6cZqT4hA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fq+j2v4XOTYaceMHapsgd0uzezQDlX6UA8+oL1/EDUeiMIXgTm7Tt+Oo9IH/QSPta
	 p0Ar+OeJLJs0LmIwKjSRlWS2sYDzbMOdMHO69up7WmXXkvMoPMUzXlGEZX20NCUMQR
	 edOQF47nYG97xht93AcjJF2SwRgjbQiQDyuQOJ9L0zpJfqNo++GS8CDQh9BmKH4z23
	 NiZWAa8vJRhrD3ylDti5DIOFAyXaWFVIfkUBxBSEbGPV4UHL6ck9nRo3C7NtbYAHsC
	 TMVrN25kVkePOpUr5rKQnwyqCgX4zGeM5EfGGT7tg1bTxwNCxI8aKBPfUineExYSbf
	 y9AXJDVgZWTkw==
Date: Fri, 14 Jun 2024 14:46:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [TEXT 1/3] design of iomap
Message-ID: <20240614214606.GL6125@frogsfrogsfrogs>
References: <20240614214347.GK6125@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614214347.GK6125@frogsfrogsfrogs>

Here's the design document, rendered as a textonly version of
https://djwong.org/docs/iomap/design.html

--D

                     (iomap) Library Design

   Table of Contents

     * Introduction
     * Who Should Read This?
     * How Is This Better?
     * File Range Iterator
          * Definitions
          * struct iomap
          * struct iomap_ops
               * ->iomap_begin
               * ->iomap_end
     * Preparing for File Operations
     * Locking Hierarchy
     * Bugs and Limitations

                              Introduction

   iomap is a filesystem library for handling common file operations.
   The library has two layers:

      1. A lower layer that provides an iterator over ranges of file
         offsets. This layer tries to obtain mappings of each file
         ranges to storage from the filesystem, but the storage
         information is not necessarily required.
      2. An upper layer that acts upon the space mappings provided by
         the lower layer iterator.

   The iteration can involve mappings of file's logical offset ranges
   to physical extents, but the storage layer information is not
   necessarily required, e.g. for walking cached file information.
   The library exports various APIs for implementing file operations
   such as:

       * Pagecache reads and writes
       * Folio write faults to the pagecache
       * Writeback of dirty folios
       * Direct I/O reads and writes
       * fsdax I/O reads, writes, loads, and stores
       * FIEMAP
       * lseek SEEK_DATA and SEEK_HOLE
       * swapfile activation

   This origins of this library is the file I/O path that XFS once
   used; it has now been extended to cover several other operations.

                         Who Should Read This?

   The target audience for this document are filesystem, storage, and
   pagecache programmers and code reviewers.

   If you are working on PCI, machine architectures, or device
   drivers, you are most likely in the wrong place.

                          How Is This Better?

   Unlike the classic Linux I/O model which breaks file I/O into
   small units (generally memory pages or blocks) and looks up space
   mappings on the basis of that unit, the iomap model asks the
   filesystem for the largest space mappings that it can create for a
   given file operation and initiates operations on that basis. This
   strategy improves the filesystem's visibility into the size of the
   operation being performed, which enables it to combat
   fragmentation with larger space allocations when possible. Larger
   space mappings improve runtime performance by amortizing the cost
   of mapping function calls into the filesystem across a larger
   amount of data.

   At a high level, an iomap operation looks like this:

    1. For each byte in the operation range...
         1. Obtain a space mapping via ->iomap_begin
         2. For each sub-unit of work...
              1. Revalidate the mapping and go back to (1) above, if
                 necessary. So far only the pagecache operations need
                 to do this.
              2. Do the work
         3. Increment operation cursor
         4. Release the mapping via ->iomap_end, if necessary

   Each iomap operation will be covered in more detail below. This
   library was covered previously by an LWN article and a
   KernelNewbies page.

   The goal of this document is to provide a brief discussion of the
   design and capabilities of iomap, followed by a more detailed
   catalog of the interfaces presented by iomap. If you change iomap,
   please update this design document.

                          File Range Iterator

Definitions

       * buffer head: Shattered remnants of the old buffer cache.
       * fsblock: The block size of a file, also known as
         i_blocksize.
       * i_rwsem: The VFS struct inode rwsemaphore. Processes hold
         this in shared mode to read file state and contents. Some
         filesystems may allow shared mode for writes. Processes
         often hold this in exclusive mode to change file state and
         contents.
       * invalidate_lock: The pagecache struct address_space
         rwsemaphore that protects against folio insertion and
         removal for filesystems that support punching out folios
         below EOF. Processes wishing to insert folios must hold this
         lock in shared mode to prevent removal, though concurrent
         insertion is allowed. Processes wishing to remove folios
         must hold this lock in exclusive mode to prevent insertions.
         Concurrent removals are not allowed.
       * dax_read_lock: The RCU read lock that dax takes to prevent a
         device pre-shutdown hook from returning before other threads
         have released resources.
       * filesystem mapping lock: This synchronization primitive is
         internal to the filesystem and must protect the file mapping
         data from updates while a mapping is being sampled. The
         filesystem author must determine how this coordination
         should happen; it does not need to be an actual lock.
       * iomap internal operation lock: This is a general term for
         synchronization primitives that iomap functions take while
         holding a mapping. A specific example would be taking the
         folio lock while reading or writing the pagecache.
       * pure overwrite: A write operation that does not require any
         metadata or zeroing operations to perform during either
         submission or completion. This implies that the fileystem
         must have already allocated space on disk as IOMAP_MAPPED
         and the filesystem must not place any constaints on IO
         alignment or size. The only constraints on I/O alignment are
         device level (minimum I/O size and alignment, typically
         sector size).

struct iomap

   The filesystem communicates to the iomap iterator the mapping of
   byte ranges of a file to byte ranges of a storage device with the
   structure below:

 struct iomap {
     u64                 addr;
     loff_t              offset;
     u64                 length;
     u16                 type;
     u16                 flags;
     struct block_device *bdev;
     struct dax_device   *dax_dev;
     voidw               *inline_data;
     void                *private;
     const struct iomap_folio_ops *folio_ops;
     u64                 validity_cookie;
 };

   The fields are as follows:

       * offset and length describe the range of file offsets, in
         bytes, covered by this mapping. These fields must always be
         set by the filesystem.

       * type describes the type of the space mapping:

            * IOMAP_HOLE: No storage has been allocated. This type
              must never be returned in response to an IOMAP_WRITE
              operation because writes must allocate and map space,
              and return the mapping. The addr field must be set to
              IOMAP_NULL_ADDR. iomap does not support writing
              (whether via pagecache or direct I/O) to a hole.
            * IOMAP_DELALLOC: A promise to allocate space at a later
              time ("delayed allocation"). If the filesystem returns
              IOMAP_F_NEW here and the write fails, the ->iomap_end
              function must delete the reservation. The addr field
              must be set to IOMAP_NULL_ADDR.
            * IOMAP_MAPPED: The file range maps to specific space on
              the storage device. The device is returned in bdev or
              dax_dev. The device address, in bytes, is returned via
              addr.
            * IOMAP_UNWRITTEN: The file range maps to specific space
              on the storage device, but the space has not yet been
              initialized. The device is returned in bdev or dax_dev.
              The device address, in bytes, is returned via addr.
              Reads from this type of mapping will return zeroes to
              the caller. For a write or writeback operation, the
              ioend should update the mapping to MAPPED. Refer to the
              sections about ioends for more details.
            * IOMAP_INLINE: The file range maps to the memory buffer
              specified by inline_data. For write operation, the
              ->iomap_end function presumably handles persisting the
              data. The addr field must be set to IOMAP_NULL_ADDR.
       * flags describe the status of the space mapping. These flags
         should be set by the filesystem in ->iomap_begin:

            * IOMAP_F_NEW: The space under the mapping is newly
              allocated. Areas that will not be written to must be
              zeroed. If a write fails and the mapping is a space
              reservation, the reservation must be deleted.
            * IOMAP_F_DIRTY: The inode will have uncommitted metadata
              needed to access any data written. fdatasync is
              required to commit these changes to persistent storage.
              This needs to take into account metadata changes that
              may be made at I/O completion, such as file size
              updates from direct I/O.
            * IOMAP_F_SHARED: The space under the mapping is shared.
              Copy on write is necessary to avoid corrupting other
              file data.
            * IOMAP_F_BUFFER_HEAD: This mapping requires the use of
              buffer heads for pagecache operations. Do not add more
              uses of this.
            * IOMAP_F_MERGED: Multiple contiguous block mappings were
              coalesced into this single mapping. This is only useful
              for FIEMAP.
            * IOMAP_F_XATTR: The mapping is for extended attribute
              data, not regular file data. This is only useful for
              FIEMAP.
            * IOMAP_F_PRIVATE: Starting with this value, the upper
              bits can be set by the filesystem for its own purposes.

         These flags can be set by iomap itself during file
         operations. The filesystem should supply an ->iomap_end
         function if it needs to observe these flags:

            * IOMAP_F_SIZE_CHANGED: The file size has changed as a
              result of using this mapping.
            * IOMAP_F_STALE: The mapping was found to be stale. iomap
              will call ->iomap_end on this mapping and then
              ->iomap_begin to obtain a new mapping.

         Currently, these flags are only set by pagecache operations.

       * addr describes the device address, in bytes.

       * bdev describes the block device for this mapping. This only
         needs to be set for mapped or unwritten operations.

       * dax_dev describes the DAX device for this mapping. This only
         needs to be set for mapped or unwritten operations, and only
         for a fsdax operation.

       * inline_data points to a memory buffer for I/O involving
         IOMAP_INLINE mappings. This value is ignored for all other
         mapping types.

       * private is a pointer to filesystem-private information. This
         value will be passed unchanged to ->iomap_end.

       * folio_ops will be covered in the section on pagecache
         operations.

       * validity_cookie is a magic freshness value set by the
         filesystem that should be used to detect stale mappings. For
         pagecache operations this is critical for correct operation
         because page faults can occur, which implies that filesystem
         locks should not be held between ->iomap_begin and
         ->iomap_end. Filesystems with completely static mappings
         need not set this value. Only pagecache operations
         revalidate mappings; see the section about iomap_valid for
         details.

struct iomap_ops

   Every iomap function requires the filesystem to pass an operations
   structure to obtain a mapping and (optionally) to release the
   mapping:

 struct iomap_ops {
     int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
                        unsigned flags, struct iomap *iomap,
                        struct iomap *srcmap);

     int (*iomap_end)(struct inode *inode, loff_t pos, loff_t length,
                      ssize_t written, unsigned flags,
                      struct iomap *iomap);
 };

  ->iomap_begin

   iomap operations call ->iomap_begin to obtain one file mapping for
   the range of bytes specified by pos and length for the file inode.
   This mapping should be returned through the iomap pointer. The
   mapping must cover at least the first byte of the supplied file
   range, but it does not need to cover the entire requested range.

   Each iomap operation describes the requested operation through the
   flags argument. The exact value of flags will be documented in the
   operation-specific sections below. These flags can, at least in
   principle, apply generally to iomap operations:

       * IOMAP_DIRECT is set when the caller wishes to issue file I/O
         to block storage.
       * IOMAP_DAX is set when the caller wishes to issue file I/O to
         memory-like storage.
       * IOMAP_NOWAIT is set when the caller wishes to perform a best
         effort attempt to avoid any operation that would result in
         blocking the submitting task. This is similar in intent to
         O_NONBLOCK for network APIs - it is intended for
         asynchronous applications to keep doing other work instead
         of waiting for the specific unavailable filesystem resource
         to become available. Filesystems implementing IOMAP_NOWAIT
         semantics need to use trylock algorithms. They need to be
         able to satisfy the entire I/O request range with a single
         iomap mapping. They need to avoid reading or writing
         metadata synchronously. They need to avoid blocking memory
         allocations. They need to avoid waiting on transaction
         reservations to allow modifications to take place. They
         probably should not be allocating new space. And so on. If
         there is any doubt in the filesystem developer's mind as to
         whether any specific IOMAP_NOWAIT operation may end up
         blocking, then they should return -EAGAIN as early as
         possible rather than start the operation and force the
         submitting task to block. IOMAP_NOWAIT is often set on
         behalf of IOCB_NOWAIT or RWF_NOWAIT.

   If it is necessary to read existing file contents from a different
   device or address range on a device, the filesystem should return
   that information via srcmap. Only pagecache and fsdax operations
   support reading from one mapping and writing to another.

  ->iomap_end

   After the operation completes, the ->iomap_end function, if
   present, is called to signal that iomap is finished with a
   mapping. Typically, implementations will use this function to tear
   down any context that were set up in ->iomap_begin. For example, a
   write might wish to commit the reservations for the bytes that
   were operated upon and unreserve any space that was not operated
   upon. written might be zero if no bytes were touched. flags will
   contain the same value passed to ->iomap_begin. iomap ops for
   reads are not likely to need to supply this function.

   Both functions should return a negative errno code on error, or
   zero on success.

                     Preparing for File Operations

   iomap only handles mapping and I/O. Filesystems must still call
   out to the VFS to check input parameters and file state before
   initiating an I/O operation. It does not handle obtaining
   filesystem freeze protection, updating of timestamps, stripping
   privileges, or access control.

                           Locking Hierarchy

   iomap requires that filesystems supply their own locking model.
   There are three categories of synchronization primitives, as far
   as iomap is concerned:

       * The upper level primitive is provided by the filesystem to
         coordinate access to different iomap operations. The exact
         primitive is specifc to the filesystem and operation, but is
         often a VFS inode, pagecache invalidation, or folio lock.
         For example, a filesystem might take i_rwsem before calling
         iomap_file_buffered_write and iomap_file_unshare to prevent
         these two file operations from clobbering each other.
         Pagecache writeback may lock a folio to prevent other
         threads from accessing the folio until writeback is
         underway.
            * The lower level primitive is taken by the filesystem in
              the ->iomap_begin and ->iomap_end functions to
              coordinate access to the file space mapping
              information. The fields of the iomap object should be
              filled out while holding this primitive. The upper
              level synchronization primitive, if any, remains held
              while acquiring the lower level synchronization
              primitive. For example, XFS takes ILOCK_EXCL and ext4
              takes i_data_sem while sampling mappings. Filesystems
              with immutable mapping information may not require
              synchronization here.
            * The operation primitive is taken by an iomap operation
              to coordinate access to its own internal data
              structures. The upper level synchronization primitive,
              if any, remains held while acquiring this primitive.
              The lower level primitive is not held while acquiring
              this primitive. For example, pagecache write operations
              will obtain a file mapping, then grab and lock a folio
              to copy new contents. It may also lock an internal
              folio state object to update metadata.

   The exact locking requirements are specific to the filesystem; for
   certain operations, some of these locks can be elided. All further
   mention of locking are recommendations, not mandates. Each
   filesystem author must figure out the locking for themself.

                          Bugs and Limitations

       * No support for fscrypt.
       * No support for compression.
       * No support for fsverity yet.
       * Strong assumptions that IO should work the way it does on
         XFS.
       * Does iomap actually work for non-regular file data?

   Patches welcome!

