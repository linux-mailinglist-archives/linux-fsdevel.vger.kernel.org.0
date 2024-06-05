Return-Path: <linux-fsdevel+bounces-21029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3838FC8C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DA21C21E15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 10:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A819006E;
	Wed,  5 Jun 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjVCdFEV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880B1946D5;
	Wed,  5 Jun 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582607; cv=none; b=I24OVSMOEOiIr1x7OQAkJ6c7aAFL46aZnHOcoE2eDhqf0fT6z1VLjBxSdjiebdc3/AAvvPzBMLN5VZvFsW/SokArtKZcpLubeWxdbJ+vubHgIiKrd4sSpAbHODg0pCm9qnZNs3jNtbqqgFQvKWjhPeS7In+xxyAu8ywZXR+nkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582607; c=relaxed/simple;
	bh=PaI7VUNSl76ewO4JzRll82e4HwSvUh5OurHByDn8EHY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=V5ofhUgvd2PCv6HT7HekdwWtMOEGO13ZDbf6foKCKLJNAIuwfV+o23oHZfwCzuvU/0PjoRl6uZ81UvLrwO4JZkqPO+Wjq2ueyYgTEW8LTNSKm73CB/2CH7KOPnQQ88th7NS8x9V41F+phbYeMFOlUmPjokBHkjyQNbJ+r8j07IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjVCdFEV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7025e7a42dcso1823072b3a.1;
        Wed, 05 Jun 2024 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717582605; x=1718187405; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qIkHx610FbxA9QtRt/pObQK7Sf7jeSHIX/qKqv8UJZw=;
        b=XjVCdFEVwAkvRvUqy70sXzqqf8wMCZcj842Ps1IzMwY4W+S7UHepitjHrV3o/cJfGE
         mNSTnT2QRof8VTPWB1Z8IFNx8Kk65CkWEXM6+hiTNc5sscDz0t7kasqSyin9c37r9By5
         BIhGVfaLAQlCh9UGNHcegVsYyiO8VP+piChMYRA67UDzyghvC2l4MfxEMR98LvQW/oK2
         JYIEVQwekSerF8sYiEI3Giv+QozStl58RyPdxjWkLplwIeMYUBWHEg4GbluALPAb6Aj7
         pZ9hRRSqkQh6pE7qWsLhJugwivtmm3ETSpDDPQ2mlHHmFh18tpx75Bry6itJ42tTyK1V
         w6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582605; x=1718187405;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIkHx610FbxA9QtRt/pObQK7Sf7jeSHIX/qKqv8UJZw=;
        b=PX3amNILhsRX/AVEoN6FfJC7DOGCHU035A68+xYIDNd+UwV69UulSOt8UslRUVNaNK
         9ffq6yGQ7tGXOC1YaDcMx+IGr87DJKN8kr0yoD3uQjakprfpTblAmt5qZQ87JZrJg/qv
         WZFEpBGS3A2NerOs32hJvYzBzHD/3dAE3EGm1XM89SKkIDf6S8e6D+fhA1+APTg027AU
         kxWscTvA1u7lknzzhAU9ymvvtDzGqsEb6oSBP7tmRtq0HhXrbKklFkbZ6CVJGX18dvWS
         K9m8tqvC/aF+j8Smc52PY23nEfIT03Lokx0EnNGbrL+UkumR8rhFUex842H9VJh1Xmg9
         gxqA==
X-Forwarded-Encrypted: i=1; AJvYcCWRYGx2JiwYlllo10JaYsUZ0EM1KFsNA44p/Ycc+7UI87rSNG6QVmOVThP61jxOsSOjRyRotsML89wNX1QQJwCjMtGywqumj2XgnS32JGL/M/yAEuRekCvA43CfMQHlIgA+L74IijSsvw==
X-Gm-Message-State: AOJu0Ywi4XWBiR9B+SVyVD6Ff0joLmMKCDos090EN4AjmfjifDjfEeZX
	1igsp/OphPiEWVC85vEJ/1gPTo758WgsVjynsDknTbjWj/Wq7BgBliux3A==
X-Google-Smtp-Source: AGHT+IEm3upQkrDWlqOIrBHpiE7pDpoXNwe59JaAySRS6tE308Y40JFxDDzb3Altbxyr96nn6Kq8Cg==
X-Received: by 2002:aa7:8887:0:b0:702:3183:2ae1 with SMTP id d2e1a72fcca58-703e59f77cfmr2412569b3a.27.1717582605090;
        Wed, 05 Jun 2024 03:16:45 -0700 (PDT)
Received: from dw-tp ([171.76.82.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423c7c62sm8642995b3a.11.2024.06.05.03.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:16:44 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Documentation: Add initial iomap document
In-Reply-To: <20240603233422.GI53013@frogsfrogsfrogs>
Date: Wed, 05 Jun 2024 09:37:51 +0530
Message-ID: <8734psjalk.fsf@gmail.com>
References: <17e84cbae600898269e9ad35046ce6dc929036ae.1714744795.git.ritesh.list@gmail.com> <20240603233422.GI53013@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, May 03, 2024 at 07:40:19PM +0530, Ritesh Harjani (IBM) wrote:
>> This adds an initial first draft of iomap documentation. Hopefully this
>> will come useful to those who are looking for converting their
>> filesystems to iomap. Currently this is in text format since this is the
>> first draft. I would prefer to work on it's conversion to .rst once we
>> receive the feedback/review comments on the overall content of the document.
>> But feel free to let me know if we prefer it otherwise.
>> 
>> A lot of this has been collected from various email conversations, code
>> comments, commit messages and/or my own understanding of iomap. Please
>> note a large part of this has been taken from Dave's reply to last iomap
>> doc patchset. Thanks to Dave, Darrick, Matthew, Christoph and other iomap
>> developers who have taken time to explain the iomap design in various emails,
>> commits, comments etc.
>> 
>> Please note that this is not the complete iomap design doc. but a brief
>> overview of iomap.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  Documentation/filesystems/index.rst |   1 +
>>  Documentation/filesystems/iomap.txt | 289 ++++++++++++++++++++++++++++
>>  MAINTAINERS                         |   1 +
>>  3 files changed, 291 insertions(+)
>>  create mode 100644 Documentation/filesystems/iomap.txt
>> 
>> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
>> index 1f9b4c905a6a..c17b5a2ec29b 100644
>> --- a/Documentation/filesystems/index.rst
>> +++ b/Documentation/filesystems/index.rst
>> @@ -34,6 +34,7 @@ algorithms work.
>>     seq_file
>>     sharedsubtree
>>     idmappings
>> +   iomap
>> 
>>     automount-support
>> 
>> diff --git a/Documentation/filesystems/iomap.txt b/Documentation/filesystems/iomap.txt
>> new file mode 100644
>> index 000000000000..4f766b129975
>> --- /dev/null
>> +++ b/Documentation/filesystems/iomap.txt
>> @@ -0,0 +1,289 @@
>> +Introduction
>> +============
>> +iomap is a filesystem centric mapping layer that maps file's logical offset
>
> It's really more of a library for filesystem implementations that need
> to handle file operations that involve physical storage devices.
>

Maybe something like this...

iomap is a filesystem library for handling various filesystem operations
that involves mapping of file's logical offset ranges to physical extents.


>> +ranges to physical extents. It provides several iterator APIs which filesystems
>
> Minor style nit: Start each sentence on a new line, so that future
> revisions to a sentence don't produce diff for adjoining sentences.
>

I will try to keep that in mind wherever possible.

>> +can use for doing various file_operations, address_space_operations,
>
> "...for doing various file and pagecache operations, such as:
>
>  * Pagecache reads and writes
>  * Page faults
>  * Dirty pagecache writeback
>  * FIEMAP
>  * directio
>  * lseek
>  * swapfile activation
> <etc>
>

Thanks this is more clear.


>> +vm_operations, inode_operations etc. It supports APIs for doing direct-io,
>> +buffered-io, lseek, dax-io, page-mkwrite, swap_activate and extent reporting
>> +via fiemap.
>> +
>> +iomap is termed above as filesystem centric because it first calls
>> +->iomap_begin() phase supplied by the filesystem to get a mapped extent and
>> +then loops over each folio within that mapped extent.
>> +This is useful for filesystems because now they can allocate/reserve a much
>> +larger extent at begin phase v/s the older approach of doing block allocation
>> +of one block at a time by calling filesystem's provided ->get_blocks() routine.
>
> I think this should be more general because all the iomap operations
> work this way, not just the ones that involve folios:
>
> "Unlike the classic Linux IO model which breaks file io into small units
> (generally memory pages or blocks) and looks up space mappings on the
> basis of that unit, the iomap model asks the filesystem for the largest
> space mappings that it can create for a given file operation and
> initiates operations on that basis.
> This strategy improves the filesystem's visibility into the size of the
> operation being performed, which enables it to combat fragmentation with
> larger space allocations when possible.
> Larger mappings improve runtime performance by amortizing the cost of a
> mapping function call into the filesystem across a larger amount of
> data."
>
> "At a high level, an iomap operation looks like this:
>
>   for each byte in the operation range,
>       obtain space mapping via ->iomap_begin
>       for each sub-unit of work,
>           revalidate the mapping
>           do the work
>       increment file range cursor
>       if needed, release the mapping via ->iomap_end
>

Thanks for making it more general. I will use your above version.

> "Each iomap operation will be covered in more detail below."
>
>> +
>> +i.e. at a high level how iomap does write iter is [1]::
>> +	user IO
>> +	  loop for file IO range
>> +	    loop for each mapped extent
>> +	      if (buffered) {
>> +		loop for each page/folio {
>> +		  instantiate page cache
>> +		  copy data to/from page cache
>> +		  update page cache state
>> +		}
>> +	      } else { /* direct IO */
>> +		loop for each bio {
>> +		  pack user pages into bio
>> +		  submit bio
>> +		}
>> +	      }
>> +	    }
>> +	  }
>
> I agree with the others that each io operation (pagecache, directio,
> etc) should be a separate section.
>

Actually the idea for adding this loop was mainly to show that
->iomap_begin operation first maps the extent and then we loop over each
folio. This is some sense is already covered in your paragraph above.
So I am not sure how much of a value it will add to add these loops for
individual operations. But I will re-asses that while doing v2.


>> +
>> +
>> +Motivation for filesystems to convert to iomap
>> +===============================================
>
> Maybe this is the section titled buffered IO?
>

No the idea here was to list the modern filesystem features iomap
library supports. e.g. large folios, upcoming atomic writes for
buffered-io, abstracts page cache operation completely...

But, I got your point. Let me find a better line for this section :)

>> +1. iomap is a modern filesystem mapping layer VFS abstraction.
>
> I don't think this is much of a justification -- buffer heads were
> modern once.
>

Sure depending upon what ends up being the section name. I will see what
needs to come here, or will drop it.

>> +2. It also supports large folios for buffered-writes. Large folios can help
>> +improve filesystem buffered-write performance and can also improve overall
>> +system performance.
>
> How does it improve pagecache performance?  Is this a result of needing
> to take fewer locks?  Is it because page table walks can stop early?  Is
> it because we can reduce the number of memcpy calls?
>

You mean to ask how does large folios in iomap improves buffered-write
performance & system performance?
- less no. of struct folio entries to iterate over while doing
buffered-I/O. 
- large folios in pagecache helps in reducing MM fragmentation.
- Smaller LRU lists size means, lesser work overhead for MM subsystems; means
better system performance.

I will go ahead and add these subpoints for point 2 then. 


>> +3. Less maintenance overhead for individual filesystem maintainers.
>> +iomap is able to abstract away common folio-cache related operations from the
>> +filesystem to within the iomap layer itself. e.g. allocating, instantiating,
>> +locking and unlocking of the folios for buffered-write operations are now taken
>> +care within iomap. No ->write_begin(), ->write_end() or direct_IO
>> +address_space_operations are required to be implemented by filesystem using
>> +iomap.
>
> I think it's stronger to say that iomap abstracts away /all/ the
> pagecache operations, which gets each fs implementation out of the
> business of doing that itself.
>

Sure. Make sense. Will do that.

>> +
>> +
>> +blocksize < pagesize path/large folios
>> +======================================
>
> Is this a subsection?  Should the annotation be "----" instead of "====" ?
>

Ok.

>> +Large folio support or systems with large pagesize e.g 64K on Power/ARM64 and
>> +4k blocksize, needs filesystems to support bs < ps paths. iomap embeds
>> +struct iomap_folio_state (ifs) within folio->private. ifs maintains uptodate
>> +and dirty bits for each subblock within the folio. Using ifs iomap can track
>> +update and dirty status of each block within the folio. This helps in supporting
>> +bs < ps path for such systems with large pagesize or with large folios [2].
>
> TBH I think it's sufficient to mention that the iomap pagecache
> implementation tracks uptodate and dirty status for each the fsblocks
> cached by a folio to reduce read and write amplification.  No need to go
> into the details of exactly how that happens.
>
> Perhaps also mention that variable sized folios are required to handle
> fsblock > pagesize filesystems.
>

Ok.

>> +
>> +
>> +struct iomap
>> +=============
>> +This structure defines a file mapping information of logical file offset range
>> +to a physical mapped extent on which an IO operation could be performed.
>> +An iomap reflects a single contiguous range of filesystem address space that
>> +either exists in memory or on a block device.
>
> "This structure contains information to map a range of file data to
> physical space on a storage device.
> The information is useful for translating file operations into action.
> The actions taken are specific to the target of the operation, such as
> disk cache, physical storage devices, or another part of the kernel."
>
> "Each iomap operation will pass operation flags as needed to the
> ->iomap_begin function.
> These flags will be documented in the operation-specific sections below.
> For a write operation, IOMAP_WRITE will be set.
> For any other operation, IOMAP_WRITE will not be set."
>
> ...and then down in the section on pagecache operations, you can do
> something like:
>
> "For pagecache operations, the @flags argument to ->iomap_begin can be
> any of the following:"
>
>  * IOMAP_WRITE: write to a file
>
>  * IOMAP_WRITE | IOMAP_UNSHARE: if any of the space backing a file is
>    shared, mark that part of the pagecache dirty so that it will be
>    unshared during writeback
>
>  * IOMAP_WRITE | IOMAP_FAULT: this is a write fault for mmapped
>    pagecache
>
>  * IOMAP_ZERO: zero parts of a file
>
>  * 0: read from the pagecache
>

Ok. Thanks for this.

> Ugh, this namespace collides with IOMAP_{HOLE..INLINE}.  Sigh.
>
>> +1. The type field within iomap determines what type the range maps to e.g.
>> +IOMAP_HOLE, IOMAP_DELALLOC, IOMAP_UNWRITTEN etc.
>
> Maybe have a list here stating what a "DELALLOC" is?  Not all readers
> are going to know what these types are.
>
>  * IOMAP_HOLE: No storage has been allocated.  This must never be
>    returned in response to an IOMAP_WRITE operation because writes must
>    allocate and map space, and return the mapping.
>
>  * IOMAP_DELALLOC: A promise to allocate space at a later time ("delayed
>    allocation").  If the filesystem returns IOMAP_F_NEW here and the
>    write fails, the ->iomap_end function must delete the reservation.
>
>  * IOMAP_MAPPED: The file range maps to this space on the storage
>    device.  The device is returned in @bdev or @dax_dev, and the device
>    address of the space is returned in @addr.
>
>  * IOMAP_UNWRITTEN: The file range maps to this space on the storage
>    device, but the space has not yet been initialized.  The device is
>    returned in @bdev or @dax_dev, and the device address of the space is
>    returned in @addr.  Reads will return zeroes, and the write ioend
>    must update the mapping to MAPPED.
>
>  * IOMAP_INLINE: The file range maps to the in-memory buffer
>    @inline_data.  For IOMAP_WRITE operations, the ->iomap_end function
>    presumable handles persisting the data.
>

I was thinking maybe it's corresponding file will already have that
that's why, so we need not cover it here.
And I also wanted to kept initial RFC document as a brief overview.
But sure thanks for doing this. I will add this info in v2.


>> +2. The flags field represent the state flags (e.g. IOMAP_F_*), most of which are
>> +set the by the filesystem during mapping time that indicates how iomap
>> +infrastructure should modify it's behaviour to do the right thing.
>
> I think you should summarize the IOMAP_F_ flags here.
>

Sure. Thanks!

>> +3. private void pointer within iomap allows the filesystems to pass filesystem's
>> +private data from ->iomap_begin() to ->iomap_end() [3].
>> +(see include/linux/iomap.h for more details)
>
> 4. Maybe we should mention what bdev/dax_dev/inline_data do here?
>

Let me read about this.

> 5. What does the validity cookie do?
>

Sure, I will add that.

>> +
>> +
>> +iomap operations
>> +================
>> +iomap provides different iterator APIs for direct-io, buffered-io, lseek,
>> +dax-io, page-mkwrite, swap_activate and extent reporting via fiemap. It requires
>> +various struct operations to be prepared by filesystem and to be supplied to
>> +iomap iterator APIs either at the beginning of iomap api call or attaching it
>> +during the mapping callback time e.g iomap_folio_ops is attached to
>> +iomap->folio_ops during ->iomap_begin() call.
>> +
>> +Following provides various ops to be supplied by filesystems to iomap layer for
>> +doing different I/O types as discussed above.
>> +
>> +iomap_ops: IO interface specific operations
>> +==========
>> +The methods are designed to be used as pairs. The begin method creates the iomap
>> +and attaches all the necessary state and information which subsequent iomap
>> +methods & their callbacks might need. Once the iomap infrastructure has finished
>> +working on the iomap it will call the end method to allow the filesystem to tear
>> +down any unused space and/or structures it created for the specific iomap
>> +context.
>> +
>> +Almost all iomap iterator APIs require filesystems to define iomap_ops so that
>> +filesystems can be called into for providing logical to physical extent mapping,
>> +wherever required. This is required by the iomap iter apis used for the
>> +operations which are listed in the beginning of "iomap operations" section.
>> +  - iomap_begin: This either returns an existing mapping or reserve/allocates a
>> +    new mapping when called by iomap. pos and length are passed as function
>> +    arguments. Filesystem returns the new mapping information within struct
>> +    iomap which also gets passed as a function argument. Filesystems should
>> +    provide the type of this extent in iomap->type for e.g. IOMAP_HOLE,
>> +    IOMAP_UNWRITTEN and it should set the iomap->flags e.g. IOMAP_F_*
>> +    (see details in include/linux/iomap.h)
>> +
>> +    Note that iomap_begin() call has srcmap passed as another argument. This is
>> +    mainly used only during the begin phase for COW mappings to identify where
>> +    the reads are to be performed from. Filesystems needs to fill that mapping
>> +    information if iomap should read data for partially written blocks from a
>> +    different location than the write target [4].
>> +
>> +  - iomap_end: Commit and/or unreserve space which was previously allocated
>> +    using iomap_begin. During buffered-io, when a short writes occurs,
>> +    filesystem may need to remove the reserved space that was allocated
>> +    during ->iomap_begin. For filesystems that use delalloc allocation, we need
>> +    to punch out delalloc extents from the range that are not dirty in the page
>> +    cache. See comments in iomap_file_buffered_write_punch_delalloc() for more
>> +    info [5][6].
>
> I think these three sections "struct iomap", "iomap operations", and
> "iomap_ops" should come first before you talk about specific things like
> buffered io operations.
>

Ok. 

> I'm going to stop here for the day.
>
> --D
>

Thanks Darrick for taking time to do the extensive review. 

I will take yours and others review into account and will work on v2.

-ritesh

