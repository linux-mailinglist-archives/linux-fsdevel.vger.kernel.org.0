Return-Path: <linux-fsdevel+bounces-21394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E19037A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FA82813D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D6D176ACE;
	Tue, 11 Jun 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd9NpBMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153D3BB23;
	Tue, 11 Jun 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097328; cv=none; b=GfaNa0Omq9zbEIeC87+xkikfAethTrS/zUdjt5own2eDeoAL3fBNrPyr/VOdwOFViJrFiKLrBbqdHeUaPtj9puV+UFOK7rCfOc+Mp/yiFaH9tCOtOVvgG6RErb/0UYQ5/kFHNcsTI0PtOnG4k1b/asNaIjwyCbSsYUJTgR/Dxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097328; c=relaxed/simple;
	bh=3wqPsEBMxwwZ8P9yoyEFGld7zEyXBcm+IEI8vdbV+4o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=uDBOrqK24skX6iQNggdUrlndHj/QPy4+4dj9RBiXzM4F3FsrGtYevOEXjPG8pHyLcy+tFSAGPtvVUnDjANuyQ54MZvSA+jriEEYzRH6gP64weUJ+M1gVePAY0YXo50h17Ptl1U7xqPUDDbqt/NkPokFseknzL/p1td3L5n8CWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd9NpBMo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70599522368so714404b3a.2;
        Tue, 11 Jun 2024 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718097325; x=1718702125; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMlFccGgF1JbERB0qSqUDrCHVWIoPR3tjSAu3jCKCXU=;
        b=Vd9NpBMo/0KBRAnBMt2VRWUC9uUqRGZzVE8DVtN/Y0PC0jotCGQsj/T8luG+6VEyem
         aHT92/oQBfIxuPns4mn8yHbnKojubqLm93VoyWDSIhqxu432lmn5c8CxlQuGjiiFJHrf
         uO33ydIWpHXgLEUypuBXIO+iu8bkk7gvN7mfh1ji08zDfU8uB1DZk3xur9pGCGEjA3Ou
         XNSO5MZO4bQXqnBhXQlYQW/S5J/FnBySkZHmFfiDxdCDyU+4PK6pQVo0MFEldMq9Jxl1
         r+CU8oAshQxY6FBNTXRItFBvlAw396DMzOaBICs+Ngmbd1FkXyB2EFC/SlzDC2l41K4+
         3bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718097325; x=1718702125;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMlFccGgF1JbERB0qSqUDrCHVWIoPR3tjSAu3jCKCXU=;
        b=azNvam8ihQJqD4i3HDYZ5hn4MIbmevoVqlJwuXQUTJZnVXcxzJTFQHlt8Yc+9GzgGY
         aYGNQmP2GlMrcxYmZQW7fEbevBJUdqtVwNOL7TvnDfstrVF7Ib7g3YxtA5XeiP0R+K35
         HMGDyuyTsZCly+6MB0dGeNI4uVDzUEqxtDI+/pImC/ykqt4WsS8ZRrgjKLYD3YzaJWJX
         NZrQYOprOHtHWi69C5w76TqbBk8u2IEMpzVbfTXD9OllkeKk/wLI0zpCPWjjCvpJHTKZ
         9WV5fyHnWC2W9pptoe39f4R3Z8rFsfnpABb84JbnklJBY5txfd/PQz4tZ1c5jA3T7LjT
         RC8w==
X-Forwarded-Encrypted: i=1; AJvYcCUtnH5yqGxJmq9Bzu6iqVyElL2JpCJSegKGtlIirdisDhpyZYkCiGfh/gttpnzyQTJ5cJh3DIsItoj1crBnrw2Ea62rLl7v1gNlnf4tjGKr+SOj6UUYF1mRV14is316/zJ2Q9qYAL0dOg==
X-Gm-Message-State: AOJu0YyHi2dpxylr5J/GV3nGgTvTnnxribbe9nGJIH+nXsCZ2z7REdQh
	Pj7UhwSlWocQXyv6G2mnfDorRIXQBFnl3uAzFgaBD36WfB7bMjLt
X-Google-Smtp-Source: AGHT+IHrb4bkv59aGO1RC9Ltb0gF29qtfMpB6rErDhaqA2yJL2iW5ubnegbG2BNiml8eShRQVO//AA==
X-Received: by 2002:a05:6a20:9184:b0:1b6:a7c5:4fb4 with SMTP id adf61e73a8af0-1b6a7c55844mr5424077637.16.1718097324959;
        Tue, 11 Jun 2024 02:15:24 -0700 (PDT)
Received: from dw-tp ([171.76.84.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd80d789sm95807825ad.289.2024.06.11.02.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:15:24 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to port
In-Reply-To: <20240610231111.GW52987@frogsfrogsfrogs>
Date: Tue, 11 Jun 2024 12:13:22 +0530
Message-ID: <875xug9dyt.fsf@gmail.com>
References: <20240608001707.GD52973@frogsfrogsfrogs> <874ja118g7.fsf@gmail.com> <20240610231111.GW52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Mon, Jun 10, 2024 at 02:27:28PM +0530, Ritesh Harjani wrote:
>> 
>> Hello Darrick,
>> 
>> "Darrick J. Wong" <djwong@kernel.org> writes:
>> 
>> > From: Darrick J. Wong <djwong@kernel.org>
>> >
>> > This is the fourth attempt at documenting the design of iomap and how to
>> 
>> I agree that this isn't needed in the commit msg ("fourth attempt").
>
> Ok.  "Coapture the design of iomap and how to port..."
>
>> > port filesystems to use it.  Apologies for all the rst formatting, but
>> > it's necessary to distinguish code from regular text.
>> >
>> > A lot of this has been collected from various email conversations, code
>> > comments, commit messages, my own understanding of iomap, and
>> > Ritesh/Luis' previous efforts to create a document.  Please note a large
>> > part of this has been taken from Dave's reply to last iomap doc
>> > patchset. Thanks to Ritesh, Luis, Dave, Darrick, Matthew, Christoph and
>> > other iomap developers who have taken time to explain the iomap design
>> > in various emails, commits, comments etc.
>> >
>> > Cc: Dave Chinner <david@fromorbit.com>
>> > Cc: Matthew Wilcox <willy@infradead.org>
>> > Cc: Christoph Hellwig <hch@infradead.org>
>> > Cc: Christian Brauner <brauner@kernel.org>
>> > Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> > Cc: Jan Kara <jack@suse.cz>
>> > Cc: Luis Chamberlain <mcgrof@kernel.org>
>> > Inspired-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> 
>> I am not sure if this is even a valid or accepted tag.
>> But sure thanks! :)
>
> They're freeform tags, so they can be everything everyone wants them to
> be!  Drum circle kumbaya etc. :P
>
>> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>> > ---
>> >  Documentation/filesystems/index.rst |    1 
>> >  Documentation/filesystems/iomap.rst | 1060 +++++++++++++++++++++++++++++++++++
>> >  MAINTAINERS                         |    1 
>> >  3 files changed, 1062 insertions(+)
>> >  create mode 100644 Documentation/filesystems/iomap.rst
>> >
>> > diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
>> > index 8f5c1ee02e2f..b010cc8df32d 100644
>> > --- a/Documentation/filesystems/index.rst
>> > +++ b/Documentation/filesystems/index.rst
>> > @@ -34,6 +34,7 @@ algorithms work.
>> >     seq_file
>> >     sharedsubtree
>> >     idmappings
>> > +   iomap
>> >  
>> >     automount-support
>> >  
>> > diff --git a/Documentation/filesystems/iomap.rst b/Documentation/filesystems/iomap.rst
>> > new file mode 100644
>> > index 000000000000..a478b55e4135
>> > --- /dev/null
>> > +++ b/Documentation/filesystems/iomap.rst
>> > @@ -0,0 +1,1060 @@
>> > +.. SPDX-License-Identifier: GPL-2.0
>> > +.. _iomap:
>> > +
>> > +..
>> > +        Dumb style notes to maintain the author's sanity:
>> > +        Please try to start sentences on separate lines so that
>> > +        sentence changes don't bleed colors in diff.
>> > +        Heading decorations are documented in sphinx.rst.
>> > +
>> > +============================
>> > +VFS iomap Design and Porting
>> > +============================
>> > +
>> > +.. toctree::
>> > +
>> > +Introduction
>> > +============
>> > +
>> > +iomap is a filesystem library for handling various filesystem operations
>> > +that involves mapping of file's logical offset ranges to physical
>> > +extents.
>> > +This origins of this library is the file I/O path that XFS once used; it
>> > +has now been extended to cover several other operations.
>> > +The library provides various APIs for implementing various file and
>>                         ^^^^ redundant "various"
>> 
>> > +pagecache operations, such as:
>> > +
>> > + * Pagecache reads and writes
>> > + * Folio write faults to the pagecache
>> > + * Writeback of dirty folios
>> > + * Direct I/O reads and writes
>> 
>> Dax I/O reads and writes.
>> ... as well please?
>
> It's really fsdax I/O reads, writes, loads, and stores, isn't it?
>

It felt like dax_iomap_rw() belongs to fs/iomap. 
But nevertheless, we could skip it if we are targetting fs/iomap/
lib.

>> 
>> > + * FIEMAP
>> > + * lseek ``SEEK_DATA`` and ``SEEK_HOLE``
>> > + * swapfile activation
>> > +
>> 
>> > +Who Should Read This?
>> > +=====================
>> > +
>> > +The target audience for this document are filesystem, storage, and
>> 
>> /s/and/,/
>> 
>> 
>> > +pagecache programmers and code reviewers.
>> 
>> Not sure if we even need this secion "Who Should Read This".
>
> That was a review comment from Luis' attempt to write this document:
> https://lore.kernel.org/linux-xfs/87zg61p78x.fsf@meer.lwn.net/
>
> Also I guess I should state explicitly:
>
> "If you are working on PCI, machine architectures, or device drivers,
> you are most likely in the wrong place."
>
>> > +The goal of this document is to provide a brief discussion of the
>> > +design and capabilities of iomap, followed by a more detailed catalog
>> > +of the interfaces presented by iomap.
>> > +If you change iomap, please update this design document.
>> 
>> The details of "goal of this document..." -> can be a part of
>> separate paragraph in "Introduction" section itself.
>> 
>> > +
>> > +But Why?
>> > +========
>> 
>> "Why Iomap?" is more clean IMO. 
>
> "Why VFS iomap?", then.
>
>> > +
>> > +Unlike the classic Linux I/O model which breaks file I/O into small
>> > +units (generally memory pages or blocks) and looks up space mappings on
>> > +the basis of that unit, the iomap model asks the filesystem for the
>> > +largest space mappings that it can create for a given file operation and
>> > +initiates operations on that basis.
>> > +This strategy improves the filesystem's visibility into the size of the
>> > +operation being performed, which enables it to combat fragmentation with
>> > +larger space allocations when possible.
>> > +Larger space mappings improve runtime performance by amortizing the cost
>> > +of a mapping function call into the filesystem across a larger amount of
>> 
>> s/call/calls
>
> Done.
>
>> > +data.
>> > +
>> > +At a high level, an iomap operation `looks like this
>> > +<https://lore.kernel.org/all/ZGbVaewzcCysclPt@dread.disaster.area/>`_:
>> > +
>> > +1. For each byte in the operation range...
>> > +
>> > +   1. Obtain space mapping via ->iomap_begin
>> > +   2. For each sub-unit of work...
>> > +
>> > +      1. Revalidate the mapping and go back to (1) above, if necessary
>> > +      2. Do the work
>> > +
>> > +   3. Increment operation cursor
>> > +   4. Release the mapping via ->iomap_end, if necessary
>> > +
>> > +Each iomap operation will be covered in more detail below.
>> > +This library was covered previously by an `LWN article
>> > +<https://lwn.net/Articles/935934/>`_ and a `KernelNewbies page
>> > +<https://kernelnewbies.org/KernelProjects/iomap>`_.
>> > +
>> > +Data Structures and Algorithms
>> > +==============================
>> > +
>> > +Definitions
>> > +-----------
>> > +
>> > + * ``bufferhead``: Shattered remnants of the old buffer cache.
>> > + * ``fsblock``: The block size of a file, also known as ``i_blocksize``.
>> > + * ``i_rwsem``: The VFS ``struct inode`` rwsemaphore.
>> > + * ``invalidate_lock``: The pagecache ``struct address_space``
>> > +   rwsemaphore that protects against folio removal.
>> 
>> This definition is a bit confusing & maybe even incomplete.
>> I think we should use this from header file.
>> 
>> @invalidate_lock: The pagecache ``struct address_sapce`` rwsemaphore
>>   that guards coherency between page cache contents and file offset->disk
>>   block mappings in the filesystem during invalidates. It is also used to
>>   block modification of page cache contents through memory mappings.
>> 
>> Also if we are describing definitions above - then I think we should
>> also clarify these locks/terms used in this document (I just looked
>> "lock" related terms for now)
>> 
>> - folio lock:
>> - dax lock:
>
> Er, what /is/ the dax lock?  Is that the dax_read_lock thing that (I
> think) wraps the dax rcu lock?  Which in turn exists so that we don't
> return from the dax offlining function before everyone's dropped all
> their references to internal structures?
>
>> - pagecache lock: 
>> - FS internal mapping lock: 
>> - Iomap internal operation lock:
>> 
>> > +
>> > +struct iomap_ops
>> > +----------------
>> 
>> IMO, we should define "struct iomap" in the begining. The reason is
>> because iomap_ops functions take "struct iomap" in it's function
>> arguments. So it's easier if we describe "struct iomap" before.
>
> Yeah, I agree.
>
>> > +
>> > +Every iomap function requires the filesystem to pass an operations
>> > +structure to obtain a mapping and (optionally) to release the mapping.
>> > +
>> > +.. code-block:: c
>> > +
>> > + struct iomap_ops {
>> > +     int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
>> > +                        unsigned flags, struct iomap *iomap,
>> > +                        struct iomap *srcmap);
>> > +
>> > +     int (*iomap_end)(struct inode *inode, loff_t pos, loff_t length,
>> > +                      ssize_t written, unsigned flags,
>> > +                      struct iomap *iomap);
>> > + };
>> > +
>> > +The ``->iomap_begin`` function is called to obtain one mapping for the
>> > +range of bytes specified by ``pos`` and ``length`` for the file
>> > +``inode``.
>> 
>> I think it is better if we describe ->iomap_begin and ->iomap_end
>> in proper sub-sections. Otherwise this looks like we have clobbered
>> all the information together :)
>> 
>> ->iomap_begin 
>> ^^^^^^^^^^^^^^^^^
>
> Yes, I like the explicit section headings better.
>

yup.

>> This either returns an existing mapping or reserve/allocates a new
>> mapping.
>
> That's a filesystem specific detail -- all that iomap cares about is
> that the fs communicates a mapping.  Maybe the fs actually had to do a
> bunch of work to get that mapping, or maybe it's already laid out
> statically, ala zonefs.  Either way, it's not a concern of the iomap
> library.
>
>> logical file pos and length are in bytes which gets passed
>> as function arguments. Filesystem returns the new mapping information
>> within ``struct iomap`` which also gets passed as a function argument.
>> Filesystems should provide the details of this mapping by filling
>> various fields within ``struct iomap``.
>
> "iomap operations call ->iomap_begin to obtain one file mapping for the
> range of bytes specified by pos and length for the file inode.  This
> mapping should be returned through the iomap pointer.  The mapping must
> cover at least the first byte of the supplied file range, but it does
> not need to cover the entire requested range."
>

I like it. Thanks for adding that detail in the last line.

>>   @srcmap agument:
>>     Note that ->iomap_begin call has srcmap passed as another argument. This is
>>     mainly used only during the begin phase for COW mappings to identify where
>>     the reads are to be performed from. Filesystems needs to fill that mapping
>>     information if iomap should read data for partially written blocks from a
>>     different location than the write target [4].
>>   @flags argument:
>>     These are the operation types which iomap supports. 
>>     IOMAP_WRITE: For doing write I/O.
>>     <...>
>>     IOMAP_ZERO:
>>     IOMAP_REPORT:		
>>     IOMAP_FAULT:		
>>     IOMAP_DIRECT:		
>>     IOMAP_NOWAIT:		
>>     IOMAP_OVERWRITE_ONLY:
>>     IOMAP_UNSHARE:
>>     IOMAP_DAX:	
>
> I think it's /much/ more valuable to document the exact combinations
> that will be passed to ->iomap_begin further down where we talk about
> specific operations that iomap performs.
>
> Otherwise, someone is going to look at this list and wonder if they
> really need to figure out what IOMAP_ZERO|IOMAP_FAULT|IOMAP_DAX means,
> and if it's actually possible (it's not).
>

Sure.

>> 
>> ->iomap_end
>> ^^^^^^^^^^^^^^^^^
>> 
>> Commit and/or unreserve space which was previously allocated/reserved
>> in ``->iomap_begin``. For e.g. during buffered-io, when a short writes
>> occurs, filesystem may need to remove the reserved space that was
>> allocated during ->iomap_begin.
>> For filesystems that use delalloc allocation, we may need to punch out
>> delalloc extents from the range that are not dirty in
>> the page cache. See comments in
>> iomap_file_buffered_write_punch_delalloc() for more info [5][6].
>> 
>> (IMHO) I find above definitions more descriptive.
>
> I don't want to merge the general description with pagecache specific
> areas.  They already cover punch_delalloc.
>

sure.

>> > +
>> > +Each iomap operation describes the requested operation through the
>> > +``flags`` argument.
>> > +The exact value of ``flags`` will be documented in the
>> > +operation-specific sections below, but these principles apply generally:
>> > +
>> > + * For a write operation, ``IOMAP_WRITE`` will be set.
>> > +   Filesystems must not return ``IOMAP_HOLE`` mappings.
>> > +
>> > + * For any other operation, ``IOMAP_WRITE`` will not be set.
>> > +
>> 
>> Direct-io related operation which bypasses pagecache use IOMAP_DIRECT.
>
> That's covered in the pagecache/directio/dax subsection because I wanted
> to document specific combinations that filesystem authors should expect.
>

The points mentioned above were targetting buffered-io, dax, so I
thought we could add direct-io related flag as well here.

>> > + * For any operation targetting direct access to storage (fsdax),
>> > +   ``IOMAP_DAX`` will be set.
>> > +
>> > +If it is necessary to read existing file contents from a `different
>> > +<https://lore.kernel.org/all/20191008071527.29304-9-hch@lst.de/>`_ device or
>> > +address range on a device, the filesystem should return that information via
>> > +``srcmap``.
>> > +Only pagecache and fsdax operations support reading from one mapping and
>> > +writing to another.
>> > +
>> > +After the operation completes, the ``->iomap_end`` function, if present,
>> > +is called to signal that iomap is finished with a mapping.
>> > +Typically, implementations will use this function to tear down any
>> > +context that were set up in ``->iomap_begin``.
>> > +For example, a write might wish to commit the reservations for the bytes
>> > +that were operated upon and unreserve any space that was not operated
>> > +upon.
>> > +``written`` might be zero if no bytes were touched.
>> > +``flags`` will contain the same value passed to ``->iomap_begin``.
>> > +iomap ops for reads are not likely to need to supply this function.
>> > +
>> > +Both functions should return a negative errno code on error, or zero.
>> 
>> minor nit: ... or zero on success.
>
> done.
>
>> > +
>> > +struct iomap
>> > +------------
>> > +
>> > +The filesystem returns the mappings via the following structure.
>> 
>> Filesystem returns the contiguous file mapping information of logical
>> file offset range to a physically mapped extent via the following
>> structure which iomap uses to perform various file and pagecache
>> related operations listed above.
>
> How about:
>
> "The filesystem communicates to iomap operations the mappings of byte
> ranges of a file to byte ranges of a storage device with the structure
> below."
>

Sounds good.

>> > +For documentation purposes, the structure has been reordered to group
>> > +fields that go together logically.
>> > +
>> > +.. code-block:: c
>> > +
>> > + struct iomap {
>> > +     loff_t                       offset;
>> > +     u64                          length;
>> > +
>> > +     u16                          type;
>> > +     u16                          flags;
>> > +
>> > +     u64                          addr;
>> > +     struct block_device          *bdev;
>> > +     struct dax_device            *dax_dev;
>> > +     void                         *inline_data;
>> > +
>> > +     void                         *private;
>> > +
>> > +     const struct iomap_folio_ops *folio_ops;
>> > +
>> > +     u64                          validity_cookie;
>> > + };
>> > +
>> > +The information is useful for translating file operations into action.
>> > +The actions taken are specific to the target of the operation, such as
>> > +disk cache, physical storage devices, or another part of the kernel.
>> 
>> I think the wording "action" & trying to make it so generic w/o mapping
>> what "action" refers here for "disk cache", "physical storage device" or
>> "other parts of the kernel", gets a bit confusing.
>> 
>> Do you think we should map those to some examples maybe?
>> BTW, with added definition of "struct iomap" which I mentioned above,
>> I am even fine if we want to drop this paragraph. 
>
> Yeah, I'll delete the paragraph.
>
>> > +
>> > + * ``offset`` and ``length`` describe the range of file offsets, in
>> > +   bytes, covered by this mapping.
>> > +   These fields must always be set by the filesystem.
>> > +
>> > + * ``type`` describes the type of the space mapping:
>> 
>> This field is set by the filesystem in ->iomap_begin call.
>> 
>> > +
>> > +   * **IOMAP_HOLE**: No storage has been allocated.
>> > +     This type must never be returned in response to an IOMAP_WRITE
>> > +     operation because writes must allocate and map space, and return
>> > +     the mapping.
>> > +     The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
>> > +     iomap does not support writing (whether via pagecache or direct
>> > +     I/O) to a hole.
>> > +
>> > +   * **IOMAP_DELALLOC**: A promise to allocate space at a later time
>> > +     ("delayed allocation").
>> > +     If the filesystem returns IOMAP_F_NEW here and the write fails, the
>> > +     ``->iomap_end`` function must delete the reservation.
>> > +     The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
>> > +
>> > +   * **IOMAP_MAPPED**: The file range maps to specific space on the
>> > +     storage device.
>> > +     The device is returned in ``bdev`` or ``dax_dev``.
>> > +     The device address, in bytes, is returned via ``addr``.
>> > +
>> > +   * **IOMAP_UNWRITTEN**: The file range maps to specific space on the
>> > +     storage device, but the space has not yet been initialized.
>> > +     The device is returned in ``bdev`` or ``dax_dev``.
>> > +     The device address, in bytes, is returned via ``addr``.
>> > +     Reads will return zeroes to userspace.
>> 
>> Reads to this type of mapping will return zeroes to the caller.
>
> Reads from this type of mapping, but yes.
>
>> > +     For a write or writeback operation, the ioend should update the
>> > +     mapping to MAPPED.
>> 
>> Refer to section "Writeback ioend Completion" for more details.
>
> There are two here -- one for the pagecache, and one for directio.
>
>> > +
>> > +   * **IOMAP_INLINE**: The file range maps to the memory buffer
>> > +     specified by ``inline_data``.
>> > +     For write operation, the ``->iomap_end`` function presumably
>> > +     handles persisting the data.
>> 
>> Is it? Or do we just mark the inode as dirty?
>
> gfs2 actually starts a transaction in ->iomap_begin and commits or
> cancels it in ->iomap_end.
>

ok.

>> > +     The ``addr`` field must be set to ``IOMAP_NULL_ADDR``.
>> > +
>> > + * ``flags`` describe the status of the space mapping.
>> > +   These flags should be set by the filesystem in ``->iomap_begin``:
>> > +
>> > +   * **IOMAP_F_NEW**: The space under the mapping is newly allocated.
>> > +     Areas that will not be written to must be zeroed.
>> 
>> In case of DAX, we have to invalidate those existing mappings which
>> might have a "hole" page mapped.
>
> Isn't that an internal detail of the fs/dax.c code?  The filesystem
> doesn't have to do the invalidation or even know about hole pages.
>

Right. Sorry about that. I assumed dax_iomap_rw() implementation
is a part of iomap :)

>> > +     If a write fails and the mapping is a space reservation, the
>> > +     reservation must be deleted.
>> > +
>> > +   * **IOMAP_F_DIRTY**: The inode will have uncommitted metadata needed
>> > +     to access any data written.
>> > +     fdatasync is required to commit these changes to persistent
>> > +     storage.
>> > +     This needs to take into account metadata changes that *may* be made
>> > +     at I/O completion, such as file size updates from direct I/O.
>> > +
>> > +   * **IOMAP_F_SHARED**: The space under the mapping is shared.
>> > +     Copy on write is necessary to avoid corrupting other file data.
>> > +
>> > +   * **IOMAP_F_BUFFER_HEAD**: This mapping requires the use of buffer
>> > +     heads for pagecache operations.
>> > +     Do not add more uses of this.
>> > +
>> > +   * **IOMAP_F_MERGED**: Multiple contiguous block mappings were
>> > +     coalesced into this single mapping.
>> > +     This is only useful for FIEMAP.
>> > +
>> > +   * **IOMAP_F_XATTR**: The mapping is for extended attribute data, not
>> > +     regular file data.
>> > +     This is only useful for FIEMAP.
>> > +
>> > +   * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
>> > +     be set by the filesystem for its own purposes.
>> > +
>> > +   These flags can be set by iomap itself during file operations.
>> > +   The filesystem should supply an ``->iomap_end`` function to observe
>> > +   these flags:
>> > +
>> > +   * **IOMAP_F_SIZE_CHANGED**: The file size has changed as a result of
>> > +     using this mapping.
>> > +
>> > +   * **IOMAP_F_STALE**: The mapping was found to be stale.
>> > +     iomap will call ``->iomap_end`` on this mapping and then
>> > +     ``->iomap_begin`` to obtain a new mapping.
>> > +
>> > +   Currently, these flags are only set by pagecache operations.
>> > +
>> > + * ``addr`` describes the device address, in bytes.
>> > +
>> > + * ``bdev`` describes the block device for this mapping.
>> > +   This only needs to be set for mapped or unwritten operations.
>> > +
>> > + * ``dax_dev`` describes the DAX device for this mapping.
>> > +   This only needs to be set for mapped or unwritten operations, and
>> > +   only for a fsdax operation.
>> 
>> Looks like we can make this union (bdev and dax_dev). Since depending
>> upon IOMAP_DAX or not we only set either dax_dev or bdev.
>
> Separate patch. ;)
>

Yes, in a way I was trying to get an opinion from you and others on
whether it make sense to make bdev and dax_dev as union :)

Looks like this series [1] could be the reason for that. 

[1]: https://lore.kernel.org/all/20211129102203.2243509-1-hch@lst.de/#t

I also don't see any reference to dax code from fs/iomap/buffered-io.c
So maybe we don't need this dax.h header in this file.

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c5802a459334..e1a6cca3cec2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -10,7 +10,6 @@
 #include <linux/pagemap.h>
 #include <linux/uio.h>
 #include <linux/buffer_head.h>
-#include <linux/dax.h>
 #include <linux/writeback.h>
 #include <linux/list_sort.h>
 #include <linux/swap.h>
 

>> Sorry Darrick. I will stop here for now.
>> I will continue it from here later.
>
> Ok.  The rest of the doc will hopefully make it more obvious why there's
> the generic discussion up here.
>

Sure. I am going through it.

-ritesh

