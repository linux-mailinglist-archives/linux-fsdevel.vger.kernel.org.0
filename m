Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC015708D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 03:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjESBsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 21:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESBsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 21:48:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C210CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 18:48:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53467c2486cso1531147a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 18:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684460911; x=1687052911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6v1FEG5F+0SKKlr1AToa1AZmXQjK+fbEvEurO7mkUU4=;
        b=KW+rnl3wBAoLKV19XX9YGB12jJcGjWMdUGSpC85okYycV2CdEiNpv1Lszde89noOL8
         3JqDHPIskjRKF39lZB2/oukNRxa47ZTzxu5K0bKY9Tm9cNfCvB9iJ/N6X+k9Rk3ttvH0
         C28N42jNR1YVerbeXjw0QoOra/KL4brDZjvECXHxZCJq4oFpfVhh4jD+hOOIVHjYr3n5
         Xq3+bu+wsSAZ+5SRqK5csRa0TMdX1cSgepUzysVb15SqW+3FvD3ou+LRfB5IhkNVwOuy
         9McvMVRrnDcQWAFO3W+cOcRcE0VKMBj/cUztX+c/o22L1kyqxDEHGo3KkqkMppNRCZUz
         Y22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684460911; x=1687052911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v1FEG5F+0SKKlr1AToa1AZmXQjK+fbEvEurO7mkUU4=;
        b=dg2YaKqoQ8sJ/pN1EvSBQ5ZncxpSFKtMO1/dnGo0QR+ExWEyRTCtBem0Zql/jDZ+bd
         esn09O1FgaLiiXJnX48c6H6YjwKopJ6mg6pgcOMe3VJjS4/A++3wQ7zviVVeHawUKocR
         doBzbEh326IqMTWI4MBzaeMD3NWtEHpfUtwR4bnznJoOEmsjw7au8gKL6Mh595Vc0CcJ
         GnaWE8gP9MDJWp4eYXIr4VWeGMJeUu3phl1/jfvV7sVIzKQfMvlthANCdZteph0SaOCZ
         oMe84e+whcazV++Ry7C/McyJAFfBF5e5rt3Z4zhZGSZNQpbWRyPuJCOE2JIikdPbT4qw
         //9g==
X-Gm-Message-State: AC+VfDwvM3HyUqjVv4ghD8AB/Qia58ron9NgZHeZRz40/i2LS3Ujadev
        81M9sq5i4wVI7Hw4nr8t+ksQ9w==
X-Google-Smtp-Source: ACHHUZ7VnzrVNoGbIoFNUWQItix4tbhpeM5uAHgQp1mIiVA3vAQ6lRRCOTFmFzihD3KSI/fmV3NJRg==
X-Received: by 2002:a17:903:234a:b0:1ab:289f:65cf with SMTP id c10-20020a170903234a00b001ab289f65cfmr1341913plh.54.1684460909961;
        Thu, 18 May 2023 18:48:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001aaea7bdaa7sm2142527plf.50.2023.05.18.18.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 18:48:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1pzpEH-001AXQ-2p;
        Fri, 19 May 2023 11:48:25 +1000
Date:   Fri, 19 May 2023 11:48:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     corbet@lwn.net, jake@lwn.net, hch@infradead.org, djwong@kernel.org,
        dchinner@redhat.com, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH v2] Documentation: add initial iomap kdoc
Message-ID: <ZGbVaewzcCysclPt@dread.disaster.area>
References: <20230518150105.3160445-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518150105.3160445-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 08:01:05AM -0700, Luis Chamberlain wrote:
> To help with iomap adoption / porting I set out the goal to try to
> help improve the iomap documentation and get general guidance for
> filesystem conversions over from buffer-head in time for this year's
> LSFMM. The end results thanks to the review of Darrick, Christoph and
> others is on the kernelnewbies wiki [0].
> 
> This brings this forward a relevant subset of that documentation to
> the kernel in kdoc format and also kdoc'ifies the existing documentation
> on iomap.h.
> 
> Tested with:
> 
> make htmldocs SPHINXDIRS="filesystems"
> 
> Then looking at the docs produced on:
> 
> Documentation/output/filesystems/iomap.html
> 
> [0] https://kernelnewbies.org/KernelProjects/iomap
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Changes on v2:
> 
>   * use 80 char length as if we're in the 1980's
> 
>  Documentation/filesystems/index.rst |   1 +
>  Documentation/filesystems/iomap.rst | 253 +++++++++++++++++++++
>  include/linux/iomap.h               | 336 ++++++++++++++++++----------
>  3 files changed, 468 insertions(+), 122 deletions(-)
>  create mode 100644 Documentation/filesystems/iomap.rst
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index fbb2b5ada95b..6186ab7c3ea8 100644
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
> index 000000000000..be487030fcff
> --- /dev/null
> +++ b/Documentation/filesystems/iomap.rst
> @@ -0,0 +1,253 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _iomap:
> +
> +..
> +        Mapping of heading styles within this document:
> +        Heading 1 uses "====" above and below
> +        Heading 2 uses "===="
> +        Heading 3 uses "----"
> +        Heading 4 uses "````"
> +        Heading 5 uses "^^^^"
> +        Heading 6 uses "~~~~"
> +        Heading 7 uses "...."
> +
> +        Sections are manually numbered because apparently that's what everyone
> +        does in the kernel.
> +.. contents:: Table of Contents
> +   :local:
> +
> +=====
> +iomap
> +=====
> +
> +.. kernel-doc:: include/linux/iomap.h
> +
> +A modern block abstraction
> +==========================

iomap is not a "block" abstraction layer. It's a mapping layer that
maps -file offset- ranges to -extents- that describe a LBA range in
a block device address space.

> +**iomap** allows filesystems to query storage media for data using *byte
> +ranges*. Since block mapping are provided for a *byte ranges* for cache data in
> +memory, in the page cache, naturally this implies operations on block ranges
> +will also deal with *multipage* operations in the page cache.

I don't know what this means.

> **Folios** are
> +used to help provide *multipage* operations in memory for the *byte ranges*
> +being worked on.

No. iomap naturally does multi-page operations that span the mapped
extent that is returned. We do not need folios for this (never have)
but folios can optimise it.

Any discussion that tries to describe iomap in page cache terms has
started off in completely the wrong direction. The whole point of
iomap is that it is filesystem centric rather than page cache or mm
centric. i.e. the fundamental structure of the iomap infrastructure
is this:

user IO
  loop for file IO range
    loop for each mapped extent
      if (buffered) {
        loop for each page/folio {
	  instantiate page cache
	  copy data to/from page cache
	  update page cache state
	}
      } else { /* direct IO */
        loop for each bio {
	  pack user pages into bio
	  submit bio
	}
      }
    }
  }

IOWs, if you are trying to describe iomap in terms of page cache
behaviour, then you've got it completely back to front.  The whole
point of iomap is that it is "completely back to front" w.r.t. to
the old "get_blocks()" per page callback mechanism the page cache
used to use to interact with filesystems.

The introduction should actually give some grounding in how the
infrastructure works - how it iterates, when mapping callbacks run,
why we have iomap_begin and iomap_end operations and when it is
necessary to supply both, etc. Spreading all that information
across this file and structure and function definitions in the code
does not make for coherent, readable or understandable
documentation...

Also, describing the required locking heirachy also helps to explain
how things work. iomap assumes two layers of locking. It requires
locking above the iomap layer for IO serialisation (i_rwsem,
invalidation lock) which is generally taken before calling into
iomap functions.  There is also locking below iomap for
mapping/allocation serialisation on an inode (e.g. XFS_ILOCK,
i_data_sem in ext4, etc) that is usually taken inside the mapping
methods filesystems supply to the iomap infrastructure. This layer
of locking needs to be independent of the IO path serialisation
locking as it nests inside in the IO path but is also used without
the filesystem IO path locking protecting it (e.g. in the iomap
writeback path).

> +iomap IO interfaces
> +===================
> +
> +You call **iomap** depending on the type of filesystem operation you are working
> +on. We detail some of these interactions below.
> +
> +iomap for bufferred IO writes
> +-----------------------------
> +
> +You call **iomap** for buffered IO with:
> +
> + * ``iomap_file_buffered_write()`` - for buffered writes

This is not sufficient to implement a filesystem based on iomap.
There's no discussion of:

- locking requirements
- IOCB_NOWAIT requirements
- that write validity checking must have already been performed
- it doesn't do things like update timestamps or strip privileges
- the ops structure that needs to be supplied to this function needs
  to be documented as well as when those callbacks are run and what
  they are supposed to do.

> + * ``iomap_page_mkwrite()`` - when dealing callbacks for
> +    ``struct vm_operations_struct``

Similar issues here.

> +
> +  * ``struct vm_operations_struct.page_mkwrite()``
> +  * ``struct vm_operations_struct.fault()``
> +  * ``struct vm_operations_struct.huge_fault()``
> +  * ``struct vm_operations_struct`.pfn_mkwrite()``

No idea what this is doing in an iomap document. :/

> +You *may* use buffered writes to also deal with ``fallocate()``:
> +
> + * ``iomap_zero_range()`` on fallocate for zeroing
> + * ``iomap_truncate_page()`` on fallocate for truncation

These are *not* fallocate() operations. fallocate() implementations
may use iomap_zero_range(), but that's because fallocate() ops might
need to -zero file offset ranges within EOF-

IOWs, iomap_zero_range() is a standalone helper that converts a
range of the file to contain zeros. That's all it does. It also
needs documenting about what locks need to be held when it's called,
along with a discussion of how it handles partial block zeroing and
what happens when the range spans unwritten extents..

iomap_truncate_page() is only used when removing file data from the
file. It is a destructive operation, and it is typically used to
remove cached data from beyond EOF when a truncate down operation is
making the file smaller. It has nothing to do with fallocate() at
all....

> +Typically you'd also happen to use these on paths when updating an inode's size.
> +
> +iomap for direct IO
> +-------------------
> +
> +You call **iomap** for direct IO with:
> +
> + * ``iomap_dio_rw()``

All the same comments as for buffered IO.

There are also addition data integrity concerns with serialising
concurrent sub-block DIO constraints that the filesystem has to
handle itself.

> +You **may** use direct IO writes to also deal with ``fallocate()``:
> +
> + * ``iomap_zero_range()`` on fallocate for zeroing
> + * ``iomap_truncate_page()`` on fallocate for truncation

This makes no sense at all.

iomap_dio_rw() does it's own sub-block zeroing if the mapping
returned to it by the filesystem requires it. That's where all the
additional data integrity concerns with concurrent sub-block DIO
come from.

> +Typically you'd also happen to use these on paths when updating an inode's size.

What has that got to do with discussing how iomap_dio_rw() works?

> +iomap for reads
> +---------------
> +
> +You can call into **iomap** for reading, ie, dealing with the filesystems's
> +``struct file_operations``:
> +
> + * ``struct file_operations.read_iter()``: note that depending on the type of
> +   read your filesystem might use ``iomap_dio_rw()`` for direct IO,
> +   generic_file_read_iter() for buffered IO and
> +   ``dax_iomap_rw()`` for DAX.
> + * ``struct file_operations.remap_file_range()`` - currently the special
> +   ``dax_remap_file_range_prep()`` helper is provided for DAX mode reads.

This is confusing. Why mention struct file_operations here and
not in the write path? Why mention DAX here, and not in the write
path? Why mention remap_file_range here, when that is an operation
that simply layers over the read and write IO paths?

Indeed, you don't discuss anything about the IO path, locking
requirements, how reads and writes can be serialised against each
other with iomap (e.g. via coarse grained per-IO exclusion via
i_rwsem or fine-grained via folio locks), etc. Those are things that
people implementing filesystem actually need to know....

> +iomap for userspace file extent mapping
> +---------------------------------------
> +
> +The ``fiemap`` ioctl can be used to allow userspace to get a file extent
> +mapping. The older ``bmap()`` (aka ``FIBMAP``)  allows the VM to map logical
> +block offset to physical block number.  ``bmap()`` is a legacy block mapping
> +operation supported only for the ioctl and two areas in the kernel which likely
> +are broken (the default swapfile implementation and odd md bitmap code).
> +``bmap()`` was only useful in the days of ext2 when there were no support for
> +delalloc or unwritten extents. Consequently, the interface reports nothing for
> +those types of mappings. Because of this we don't want filesystems to start
> +exporting this interface if they don't already do so.

Discussion of FIBMAP problems has no place in a description of how
to use iomap to support FIEMAP.

> +The ``fiemap`` ioctl is supported through an inode ``struct
> +inode_operations.fiemap()`` callback.

Well, yes, but that's largely irrelevant to how to use iomap to
implement it?

> +You would use ``iomap_fiemap()`` to provide the mapping. You could use two
> +seperate ``struct iomap_ops`` one for when requested to also map extended
> +attributes (``FIEMAP_FLAG_XATTR``) and your another ``struct iomap_ops`` for
> +regular read ``struct iomap_ops`` when there is no need for extended attributes.

Yay, finally the 'struct iomap_ops' is mentioned, but without any
description of what it is or how it gets used, this is just
confusing.

"iomap_fiemap() will return the fiemap data ready to be returned to
userspace based on the mapping function provided by the caller. Note
that FIEMAP may ask for different mappings from the same inode (e.g.
attribute vs data) so care must be taken to ensure the mapping
function provided returns the information the caller asked for."


> +In the future **iomap** may provide its own dedicated ops structure for
> +``fiemap``.

unnecessary.

> +``iomap_bmap()`` exists and should *only be used* by filesystems that
> +**already** supported ``FIBMAP``.  ``FIBMAP`` **should not be used** with the
> +address_space -- we have iomap readpages and writepages for that.

I really don't understand what you are trying to say "do not do"
here.  Nothing in a filesystem implementation needs to call
iomap_bmap(); it's a function to implement the fs ->bmap method and
nothing else.

> +iomap for assisting the VFS
> +---------------------------
> +
> +A filesystem also needs to call **iomap** when assisting the VFS manipulating a
> +file into the page cache.

I have no idea what this means.

> +iomap for VFS reading
> +---------------------
> +
> +A filesystem can call **iomap** to deal with the VFS reading a file into folios
> +with:
> +
> + * ``iomap_bmap()`` - called to assist the VFS when manipulating page cache with
> +   ``struct address_space_operations.bmap()``, to help the VFS map a logical
> +   block offset to physical block number.

What? Nobody should be using ->bmap() except for FIBMAP and the
legacy swapfile mapping path. Any filesystem that is implementing
iomap that supports swapfiles should be using
iomap_swapfile_activate(). Swapfiles are most definitely not
a "VFS reading a file into folios" situation.

> + * ``iomap_read_folio()`` - called to assist the page cache with
> +   ``struct address_space_operations.read_folio()``
> + * ``iomap_readahead()`` - called to assist the page cache with
> +   ``struct address_space_operations.readahead()``

Oh, these aren't "VFS reading" operations. These are page cache IO
interfaces.

> +
> +iomap for VFS writepages
> +------------------------
> +
> +A filesystem can call **iomap** to deal with the VFS write out of pages back to
> +backing store, that is to help deal with a filesystems's ``struct
> +address_space_operations.writepages()``. The special ``iomap_writepages()`` is
> +used for this case with its own respective filestems's ``struct iomap_ops`` for
> +this.

That is .... very brief.

There's no discussion of:
- the iomap_writepage_ctx and how to use that,
- calling context constraints (e.g. no direct reclaim calls),
- what happens when the page spans or is beyond EOF,
- what the ->map_blocks() callback is supposed to do,
- how errors during write submission are handled,
- when ->discard_folio() should be implemented,
- data integrity requirements,
- how ioends work
- when a filesystem might need to implement ->prepare_ioend() (e.g.
  for COW state updates)
- how ioend completion merging can be implemented
- how to attach custom IO completion handlers (e.g. for unwritten
  extent conversion, COW state updates, file size updates, etc)


> +iomap for VFS llseek
> +--------------------
> +
> +A filesystem ``struct address_space_operations.llseek()`` is used by the VFS
> +when it needs to move the current file offset, the file offset is in ``struct
> +file.f_pos``. **iomap** has special support for the ``llseek`` ``SEEK_HOLE`` or
> +``SEEK_DATA`` interfaces:

All this needs to say is:

"iomap provides generic support for SEEK_HOLE and SEEK_DATA via
iomap_seek_hole() and iomap_seek_data(). This requires the
filesystem to supply a mapping callback to allow targeted
iteration of the current inode's extent map."

> +
> + * ``iomap_seek_hole()``: for when the
> +   ``struct address_space_operations.llseek()`` *whence* argument is
> +   ``SEEK_HOLE``, when looking for the file's next hole.
> + * ``iomap_seek_data()``: for when the
> +   ``struct address_space_operations.llseek()`` *whence* argument isj
> +   ``SEEK_DATA`` when looking for the file's next data area.
> +
> +Your own ``struct iomap_ops`` for this is encouraged.

What does that mean? The structure with a valid ->iomap_begin method
is required for correct operation....

> +iomap for DAX
> +-------------
> +You can use ``dax_iomap_rw()`` when calling iomap from a DAX context, this is
> +typically from the filesystems's ``struct file_operations.write_iter()``
> +callback.

Ugh. That is *not useful*. It's worse than not documenting it at
all.

DAX has a separate iomap API and iterator. it implements many of the
same functions unsing the same API. e.g. dax_zero_range(),
dax_truncate_page(), dax_iomap_fault(), dax_file_unshare(),
dax_remap_file_range_prep(), etc.

Any filesystem that uses the iomap API should be able to branch
operations to the DAX iomap operations if IS_DAX() is set on the
inode. Other than that, implementation of DAX support is way outside
the scope of implementing iomap support in a filesystem.

> +Converting filesystems from buffer-head to iomap guide
> +======================================================
> +
> +These are generic guidelines on converting a filesystem over to **iomap** from
> +'''buffer-heads'''.
> +
> +One op at at time
> +-----------------
> +
> +You may try to convert a filesystem with different clustered set of operations
> +at time, below are a generic order you may strive to target:
> +
> + * direct io
> + * miscellaneous helpers (seek/fiemap/bmap)
> + * buffered io

That doesn't tell anyone how to actually go about this.

The right approach is to first implement ->iomap_begin and (if
necessary) ->iomap_end to allow iomap to obtain a read-only mapping
of a file range.  In most cases, this is a relatively trivial
conversion of the existing get_block() callback for read-only
mappings.

FIEMAP is a really good first target because it is trivial to
implement support for it and then to determine that the extent map
iteration is correct from userspace.  i.e. if FIEMAP is returning
the correct information, it's a good sign that other read-only
mapping operations will also do the right thing.

Next, rewrite the filesystem's get_block(create = false)
implementatio to use the new ->iomap_begin() implementation. i.e.
get_block wraps around the outside and converts the information in
the iomap to the bufferhead-based map that getblock returns. This
will convert all the existing read-only mapping users to use the new
iomap mapping function internally. This way the iomap mapping
function can be further tested without needing to implement any
other iomap APIs.

Once everything is working like this, then convert all the other
read-only mapping operations to use iomap. Done one at a time,
regressions should be self evident. The only likely complexity
at this point will be the buffered read IO path because
bufferheads. The buffered read IO paths don't need to be converted
yet, though the direct IO read path should be converted.

The next thing to do is implement get_blocks(create = true)
functionality in the ->iomap_begin/end() methods. Then convert the
direct IO write path to iomap, and start running fsx w/ DIO enabled
in earnest on filesystem. This will flush out lots of data integrity
corner case bug that the new write mapping implementation
introduces.

At this point, converting the entire get_blocks() path to call the
iomap functions and convert the iomaps to bufferhead maps is
possible. THis will get the entire filesystem using the new mapping
functions, and they should largely be debugged and working correctly
after this step.

This now largely leaves the buffered read and write paths to be
converted. The mapping functions should all work correctly,
so all that needs to be done is rewriting all the code that
interfaces with bufferheads to interface with iomap and folios. This
is left as an exercise for the reader, as it will be different for
every filesystem.


> +Defining a simple filesystem
> +----------------------------
> +
> +A simple filesystem is perhaps the easiest to convert over to **iomap**, a
> +simple filesystem is one which:
> +
> + * does not use fsverify, fscrypt, compression
> + * has no Copy on Write support (reflinks)
> +
> +Converting a simple filesystem to iomap
> +---------------------------------------
> +
> +Simple filesystems should covert to IOMAP piecemeal wise first converting over
> +**direct IO**, then the miscellaneous helpers  (seek/fiemap/bmap) and last
> +should be buffered IO.
> +
> +Converting shared filesystem features
> +-------------------------------------
> +
> +Shared filesystems features such as fscrypt, compression, erasure coding, and
> +any other data transformations need to be ported to **iomap** first, as none of
> +the current **iomap** users require any of this functionality.
> +
> +Converting complex filesystems
> +------------------------------
> +
> +If your filesystem relies on any shared filesystem features mentioned above
> +those would need to be converted piecemeal wise.

"piecemeal wise"? Anyway, didn't you just address this in the
previous section? Why mention it again?

> If reflinks are supported you
> +need to first ensure proper locking sanity in order to be able to address byte
> +ranges can be handled properly through **iomap** operations.  An example
> +filesystem where this work is taking place is btrfs.

Ah, what? To use iomap at all, you first need to ensure properly
locking sanity across the filesystem operations. Reflink or any
other filesystem functionality doesn't magically create locking
issues with iomap - the iomap infrastructure *always* assumes the
caller is holding the correct locks when iomap functions are called,
and that the methods will take the right locks to ensure filesystem
mapping operations are serialised against each other correctly. i.e.
there is no locking in the iomap infrastructure except for internal
state protection....


> +IOMAP_F_BUFFER_HEAD considerations
> +----------------------------------
> +
> +``IOMAP_F_BUFFER_HEAD`` won't be removed until we have all filesystem fully
> +converted away from **buffer-heads**, and this could be never.
> +
> +``IOMAP_F_BUFFER_HEAD`` should be avoided as a stepping stone / to port
> +filesystems over to **iomap** as it's support for **buffer-heads** only apply to
> +the buffered write path and nothing else including the read_folio/readahead and
> +writepages aops.
> +
> +Testing Direct IO
> +=================
> +
> +Other than fstests you can use LTP's dio, however this tests is limited as it
> +does not test stale data.
> +
> +{{{
> +./runltp -f dio -d /mnt1/scratch/tmp/
> +}}}

This should point to all the data integrity tests and IO path stress
tests in fstests (i.e. '-g rw -g aio -g fiemap -g seek'). I think
those cover far more cases (including stale data and buffered/mmap
IO) than what you are suggesting here.

> +
> +Known issues and future improvements
> +====================================
> +
> +We try to document known issues that folks should be aware of with **iomap** here.
> +
> + * write amplification on IOMAP when bs < ps: **iomap** needs improvements for
> +   large folios for dirty bitmap tracking
> + * filesystems which use buffer head helpers such as ``sb_bread()`` and friends
> +   will have to continue to use buffer heads as there is no generic iomap
> +   metadata read/write library yet.

This will get out of data rapidly. I would not bother to document
stuff like this - if it needs to be documented it should be in the
code where the problems are being fixed, not in the documentation.

> +References
> +==========
> +
> +  *  `Presentation on iomap evolution`<https://docs.google.com/presentation/d/e/2PACX-1vSN4TmhiTu1c6HNv6_gJZFqbFZpbF7GkABllSwJw5iLnSYKkkO-etQJ3AySYEbgJA/pub?start=true&loop=false&delayms=3000&slide=id.g189cfd05063_0_185>`

Someone did "git grep iomap fs/xfs" and turned it into a slide set?

Yeah, they did. The total contents of Slide 11:

| XFS IOMAP usage today
|
| git grep "struct buffer_head" fs/xfs |wc -l
| 0

That's really not a useful reference at all. Maybe what was said
during the talk was more insightful, but as reference material it
is not useful at all.

> +  * `LWN review on deprecating buffer-heads <https://lwn.net/Articles/930173/>`
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e2b836c2e119..ee4b026995ac 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -10,6 +10,30 @@
>  #include <linux/mm_types.h>
>  #include <linux/blkdev.h>
>  
> +/**
> + * DOC: Introduction
> + *
> + * iomap allows filesystems to sequentially iterate over byte addressable block
> + * ranges on an inode and apply operations to it.
> + *
> + * iomap grew out of the need to provide a modern block mapping abstraction for
> + * filesystems with the different IO access methods they support and assisting
> + * the VFS with manipulating files into the page cache. iomap helpers are
> + * provided for each of these mechanisms. However, block mapping is just one of
> + * the features of iomap, given iomap supports DAX IO for filesystems and also
> + * supports such the ``lseek``/``llseek`` ``SEEK_DATA``/``SEEK_HOLE``
> + * interfaces.
> + *
> + * Block mapping provides a mapping between data cached in memory and the
> + * location on persistent storage where that data lives. `LWN has an great
> + * review of the old buffer-heads block-mapping and why they are inefficient
> + * <https://lwn.net/Articles/930173/>`, since the inception of Linux.  Since
> + * **buffer-heads** work on a 512-byte block based paradigm, it creates an
> + * overhead for modern storage media which no longer necessarily works only on
> + * 512-blocks. iomap is flexible providing block ranges in *bytes*. iomap, with
> + * the support of folios, provides a modern replacement for **buffer-heads**.
> + */

This commentary belongs in the documentation, not the code. If you
are going to document anything in the code, it should be the
requirements the code is implementing, the design behind the
implementation in the code, implementation constraints and
assumptions, etc. 

> +
>  struct address_space;
>  struct fiemap_extent_info;
>  struct inode;
> @@ -22,37 +46,43 @@ struct page;
>  struct vm_area_struct;
>  struct vm_fault;
>  
> -/*
> - * Types of block ranges for iomap mappings:
> +/**
> + * DOC: iomap block ranges types

I seriously dislike this "DOC:" keyword appearing everywhere.
We've already got a "this is a comment for documentation" annotation
in the "/**" comment prefix, having to add "DOC:" is entirely
redudant and unnecessary noise.

> + *
> + * * IOMAP_HOLE		- no blocks allocated, need allocation
> + * * IOMAP_DELALLOC	- delayed allocation blocks
> + * * IOMAP_MAPPED	- blocks allocated at @addr
> + * * IOMAP_UNWRITTEN	- blocks allocated at @addr in unwritten state
> + * * IOMAP_INLINE	- data inline in the inode

Why we need "double *" here? This just makes the comment look weird.

>   */
> -#define IOMAP_HOLE	0	/* no blocks allocated, need allocation */
> -#define IOMAP_DELALLOC	1	/* delayed allocation blocks */
> -#define IOMAP_MAPPED	2	/* blocks allocated at @addr */
> -#define IOMAP_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
> -#define IOMAP_INLINE	4	/* data inline in the inode */
> +#define IOMAP_HOLE	0
> +#define IOMAP_DELALLOC	1
> +#define IOMAP_MAPPED	2
> +#define IOMAP_UNWRITTEN	3
> +#define IOMAP_INLINE	4
>  
> -/*
> - * Flags reported by the file system from iomap_begin:
> +/**
> + * DOC:  Flags reported by the file system from iomap_begin
>   *
> - * IOMAP_F_NEW indicates that the blocks have been newly allocated and need
> - * zeroing for areas that no data is copied to.
> + * * IOMAP_F_NEW: indicates that the blocks have been newly allocated and need
> + *	zeroing for areas that no data is copied to.
>   *
> - * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to access
> - * written data and requires fdatasync to commit them to persistent storage.
> - * This needs to take into account metadata changes that *may* be made at IO
> - * completion, such as file size updates from direct IO.
+ * * IOMAP_F_DIRTY: indicates the inode has uncommitted metadata needed to access
> + *	written data and requires fdatasync to commit them to persistent storage.
> + *	This needs to take into account metadata changes that *may* be made at IO
> + *	completion, such as file size updates from direct IO.

This breaks all the 80 column wrapping in this file. If you are
going to indent comments, they need to be reflowed to stay within
80 columns.

Which brings me back to why do we want all this extra comment
formatting constraints?"

Next question: Why is the comment formatting here different to the
first set of "DOC" comments you added?


> @@ -61,22 +91,20 @@ struct vm_fault;
>  #define IOMAP_F_BUFFER_HEAD	(1U << 4)
>  #define IOMAP_F_XATTR		(1U << 5)
>  
> -/*
> - * Flags set by the core iomap code during operations:
> +/**
> + * DOC: Flags set by the core iomap code during operations
> + *
> + * * IOMAP_F_SIZE_CHANGED: indicates to the iomap_end method that the file size
> + *	has changed as the result of this write operation.
>   *
> - * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
> - * has changed as the result of this write operation.
> + * * IOMAP_F_STALE: indicates that the iomap is not valid any longer and the file
> + *	range it covers needs to be remapped by the high level before the
> + *	operation can proceed.

Again beyond 80 columns.

>   *
> - * IOMAP_F_STALE indicates that the iomap is not valid any longer and the file
> - * range it covers needs to be remapped by the high level before the operation
> - * can proceed.
> + * * IOMAP_F_PRIVATE: Flags from 0x1000 up are for file system specific usage
>   */
>  #define IOMAP_F_SIZE_CHANGED	(1U << 8)
>  #define IOMAP_F_STALE		(1U << 9)
> -
> -/*
> - * Flags from 0x1000 up are for file system specific usage:
> - */
>  #define IOMAP_F_PRIVATE		(1U << 12)
>  
>  
> @@ -124,73 +152,119 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>  	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
>  }
>  
> -/*
> - * When a filesystem sets folio_ops in an iomap mapping it returns, get_folio
> - * and put_folio will be called for each folio written to.  This only applies
> - * to buffered writes as unbuffered writes will not typically have folios
> - * associated with them.
> - *
> - * When get_folio succeeds, put_folio will always be called to do any
> - * cleanup work necessary.  put_folio is responsible for unlocking and putting
> - * @folio.
> +/**
> + * struct iomap_folio_ops - buffered writes folio folio reference count helpers

folio folio folio folio....

> + *
> + * A filesystem can optionally set folio_ops in a &struct iomap mapping it
> + * returns to override the default get_folio and put_folio for each folio
> + * written to.

That's much worse than the comment it replaces. "get_folio and
put_folio will be called for each folio written to" is *much
clearer* compared to "override the default".
>
> This only applies to buffered writes as unbuffered writes will
> + * not typically have folios associated with them.
> + *
> + * @get_folio: iomap defaults to iomap_get_folio() (which calls
> + *	__filemap_get_folio()) if the filesystem did not provide a get folio op.

Nope. Document what the method is provided with and is expected to
perform, not what iomap_get_folio() does.


> + * @put_folio: when get_folio succeeds, put_folio will always be called to do
> + *	any cleanup work necessary. put_folio is responsible for unlocking and
> + *	putting @folio.

See, you didn't mention that get_folio is responsible for returning a
locked, referenced folio....

> + * @iomap_valid: check that the cached iomap still maps correctly to the
> + *	filesystem's internal extent map. FS internal extent maps can change
> + *	while iomap is iterating a cached iomap, so this hook allows iomap to
> + *	detect that the iomap needs to be refreshed during a long running write operation.

Line length.

> + *
> + *	The filesystem can store internal state (e.g. a sequence number) in
> + *	iomap->validity_cookie when the iomap is first mapped to be able to
> + *	detect changes between mapping time and whenever .iomap_valid() is
> + *	called.
> + *
> + *	This is called with the folio over the specified file position held
> + *	locked by the iomap code.  This is useful for filesystems that have
> + *	dynamic mappings (e.g. anything other than zonefs).  An example reason
> + *	as to why this is necessary is writeback doesn't take the vfs locks.

I don't think these last two sentences add any value here. the first
paragraph makes it pretty clear that it is related to dynamic
mappings, and not taking VFS locks in writeback does not mean a
filesystem needs to implement ->iomap_valid(). Indeed, the problem
this fixes with XFS is related to stale unwritten extent mappings
and memory reclaim racing with write() - it has nothing to do
with the locking in ->writepages so at minimum the comment doesn't
reflect the actual reason for this method existing....

> -/*
> - * Flags for iomap_begin / iomap_end.  No flag implies a read.
> +/**
> + * DOC:  Flags for iomap_begin / iomap_end.  No flag implies a read.
> + *
> + * * IOMAP_WRITE: writing, must allocate blocks
> + * * IOMAP_ZERO: zeroing operation, may skip holes
> + * * IOMAP_REPORT: report extent status, e.g. FIEMAP
> + * * IOMAP_FAULT: mapping for page fault
> + * * IOMAP_DIRECT: direct I/O
> + * * IOMAP_NOWAIT: do not block
> + * * IOMAP_OVERWRITE_ONLY: only pure overwrites allowed
> + * * IOMAP_UNSHARE: unshare_file_range
> + * * IOMAP_DAX: DAX mapping

Yet another different doc comment style.

> +/**
> + * struct iomap_ops - IO interface specific operations
> + *
> + * A filesystem is must provide a &struct iomap_ops for to deal with the
> + * beginning an IO operation, iomap_begin(), and ending an IO operation on a
> + * block range, ``iomap_end()``. You would call iomap with a specialized iomap
> + * operation depending on its filesystem or the VFS needs.
> + *
> + * For example iomap_dio_rw() would be used for for a filesystem when doing a
> + * block range read or write operation with direct IO. In this case your
> + * filesystem's respective &struct file_operations.write_iter() would eventually
> + * call iomap_dio_rw() on the filesystem's &struct file_operations.write_iter().
> + *
> + * For buffered IO a filesystem would use iomap_file_buffered_write() on the
> + * same &struct file_operations.write_iter(). But that is not the only situation
> + * in which a filesystem would deal with buffered writes, you could also use
> + * buffered writes when a filesystem has to deal with &struct
> + * file_operations.fallocate(). However fallocate() can be used for *zeroing* or
> + * for *truncation* purposes. A special respective iomap_zero_range() would be
> + * used for *zeroing* and a iomap_truncate_page() would be used for
> + * *truncation*.

This isn't useful information. It's commentary - it doesn't document
what the methods are supposed to do or provide the iomap
infrastructure. This sort of stuff belongs in the documentation, not
the code.

> + *
> + * Experience with adopting iomap on filesystems have shown that the filesystem
> + * implementation of these operations can be simplified considerably if one
> + * &struct iomap_ops is provided per major filesystem IO operation:
> + *
> + * * buffered io
> + * * direct io
> + * * DAX io
> + * * fiemap for with extended attributes (``FIEMAP_FLAG_XATTR``)
> + * * lseek

And this most definitely doesn't belong in the code. Put the "how to
implement a filesystem" commentary in the documentation, leave the
comments for the API to *describe the API*.

/**
 * struct iomap_ops - IO interface specific operations
 *
 * This structure provides the filesystem methods for mapping a file
 * offset range to a mapped extent than an IO operation could be
 * performed on.
 *
 * An iomap reflects a single contiguous range of filesystem address
 * space that either exists in memory or on a block device. The type
 * of the iomap determines what the range maps to, and there are
 * several different state flags that can be returned that indicate
 * how the iomap infrastructure should modify it's behaviour to do
 * the right thing.
 *
 * The methods are designed to be used as pairs. The begin method
 * creates the iomap and attaches all the necessary state and
 * information subsequent iomap methods and callbacks might need.
 * and once the iomap infrastructure has finished working on the
 * iomap it will call the end method to allow the filesystem to tear
 * down any unused space and/or structures it created for the
 * specific iomap context.
 *
 .....

> + *
> + * @iomap_begin: return the existing mapping at pos, or reserve space starting
> + *	at pos for up to length, as long as we can do it as a single mapping. The
> + *	actual length is returned in iomap->length. The &struct iomap iomap must
> + *	always be set. The &struct iomap srcmap should be set if the range is
> + *	CoW.

Discuss what @flags contains and what the flags mean.

Describe what the @srcmap is used for when CoW is being set up.

Explain constraints on @srcmap because it is not passed to the
->iomap_end() method.

> + *
> + * @iomap_end: commit and/or unreserve space previous allocated using
> + *	iomap_begin. Written indicates the length of the successful write

Shouldn't this be @written

> + *	operation which needs to be committed, while the rest needs to be
> + *	unreserved. Written might be zero if no data was written.

@flags is undocumented.

> + */
>  struct iomap_ops {
> -	/*
> -	 * Return the existing mapping at pos, or reserve space starting at
> -	 * pos for up to length, as long as we can do it as a single mapping.
> -	 * The actual length is returned in iomap->length.
> -	 */
>  	int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
>  			unsigned flags, struct iomap *iomap,
>  			struct iomap *srcmap);
>  
> -	/*
> -	 * Commit and/or unreserve space previous allocated using iomap_begin.
> -	 * Written indicates the length of the successful write operation which
> -	 * needs to be commited, while the rest needs to be unreserved.
> -	 * Written might be zero if no data was written.
> -	 */
>  	int (*iomap_end)(struct inode *inode, loff_t pos, loff_t length,
>  			ssize_t written, unsigned flags, struct iomap *iomap);
>  };
> @@ -207,6 +281,7 @@ struct iomap_ops {
>   * @flags: Zero or more of the iomap_begin flags above.
>   * @iomap: Map describing the I/O iteration
>   * @srcmap: Source map for COW operations
> + * @private: internal use

Completely useless description. Wrong as well.

iomap_dio_rw() allows the caller to pass a filesystem private
pointer which gets stored in the iomap_iter. The iomap_iter is then
passed to iomap_dio_ops->submit_io, and the filesystem can then grab
whatever it private structure it passes to the DIO from the iter
and make use of it.

i.e. if you are going to document this, it is a pointer to a
filesystem owned private structure that was passed to the high level
iomap IO function so it is available to individual filesystem
methods that are passed the iomap_iter structure as it is iterated.

>   */
>  struct iomap_iter {
>  	struct inode *inode;
> @@ -241,7 +316,7 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
>   * @i: iteration structure
>   *
>   * Write operations on file systems with reflink support might require a
> - * source and a destination map.  This function retourns the source map
> + * source and a destination map.  This function returns the source map
>   * for a given operation, which may or may no be identical to the destination
>   * map in &i->iomap.
>   */
> @@ -281,42 +356,52 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
>  sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>  		const struct iomap_ops *ops);
>  
> -/*
> - * Structure for writeback I/O completions.
> +/**
> + * struct iomap_ioend - for writeback I/O completions
> + *
> + * @io_list: next ioend in chain
> + * @io_type:

Care to update this?

> + * @io_flags: IOMAP_F_*
> + * @io_folios: folios added to ioend
> + * @io_inode: file being written to
> + * @io_size: size of the extent
> + * @io_offset: offset in the file
> + * @io_sector: start sector of ioend
> + * @io_bio: bio being built
> + * @io_inline_bio: MUST BE LAST!

Yet another different doc comment format....

That said, these comments lose a lot of their relevance when the
varible type is stripped out. e.g "io_folios" - is that a pointer to
a list of folios, an array of folios, or something else? it's
something else - it's a counter, and that's obvious from the "u32"
type. It's not obvious from the comment in isolation.

Hence I think just lifting the comments as "documentation" is less
useful than not documenting them at all. I'd still have to go look
at the code to know what these variables mean, and at that point
there's no reason to look at the documentation....

>   */
>  struct iomap_ioend {
> -	struct list_head	io_list;	/* next ioend in chain */
> +	struct list_head	io_list;
>  	u16			io_type;
> -	u16			io_flags;	/* IOMAP_F_* */
> -	u32			io_folios;	/* folios added to ioend */
> -	struct inode		*io_inode;	/* file being written to */
> -	size_t			io_size;	/* size of the extent */
> -	loff_t			io_offset;	/* offset in the file */
> -	sector_t		io_sector;	/* start sector of ioend */
> -	struct bio		*io_bio;	/* bio being built */
> -	struct bio		io_inline_bio;	/* MUST BE LAST! */
> +	u16			io_flags;
> +	u32			io_folios;
> +	struct inode		*io_inode;
> +	size_t			io_size;
> +	loff_t			io_offset
> +	sector_t		io_sector;
> +	struct bio		*io_bio;
> +	struct bio		io_inline_bio;
>  };
>  
> +/**
> + * struct iomap_writeback_ops - used for writeback
> + *
> + * This structure is used to support dealing with a filesystem
> + * ``struct address_space_operations.writepages()``, for writeback.
> + *
> + * @map_blocks: required, maps the blocks so that writeback can be performed on
> + *	the range starting at offset.
> + * @prepare_ioend: optional, allows the file systems to perform actions just
> + *	before submitting the bio and/or override the bio end_io handler for
> + *	complex operations like copy on write extent manipulation or unwritten
> + *	extent conversions.
> + * @discard_folio: optional, allows the file system to discard state on a page where
> + *	we failed to submit any I/O.
> + */

And yet another different document comment format. Lines are still
too long.

This is also much harder to read than the original comments. The
layout of the original comments make it very clear what is required
or optional, now it's hidden in a big chunk of dense text.

>  struct iomap_writeback_ops {
> -	/*
> -	 * Required, maps the blocks so that writeback can be performed on
> -	 * the range starting at offset.
> -	 */
>  	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
>  				loff_t offset);
> -
> -	/*
> -	 * Optional, allows the file systems to perform actions just before
> -	 * submitting the bio and/or override the bio end_io handler for complex
> -	 * operations like copy on write extent manipulation or unwritten extent
> -	 * conversions.
> -	 */
>  	int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
> -
> -	/*
> -	 * Optional, allows the file system to discard state on a page where
> -	 * we failed to submit any I/O.
> -	 */
>  	void (*discard_folio)(struct folio *folio, loff_t pos);
>  };
>  
> @@ -334,26 +419,33 @@ int iomap_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
>  		const struct iomap_writeback_ops *ops);
>  
> -/*
> - * Flags for direct I/O ->end_io:
> +/**
> + * DOC: Flags for direct I/O ->end_io
> + *
> + * * IOMAP_DIO_UNWRITTEN: covers unwritten extent(s)
> + * * IOMAP_DIO_COW: covers COW extent(s)
>   */
> -#define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
> -#define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
> +#define IOMAP_DIO_UNWRITTEN	(1 << 0)
> +#define IOMAP_DIO_COW		(1 << 1)
>  
> +/**
> + * struct iomap_dio_ops - used for direct IO
> + *
> + * This is used to support direct IO.
> + *
> + * @end_io:
> + * @submit_io:
> + * @bio_set: Filesystems wishing to attach private information to a direct io
> + *	bio must provide a ->submit_io method that attaches the additional
> + *	information to the bio and changes the ->bi_end_io callback to a custom
> + *	function.  This function should, at a minimum, perform any relevant
> + *	post-processing of the bio and end with a call to iomap_dio_bio_end_io.
> + */

Why does the documentation of bio_set document what end_io and
submit_io do, and provide no information about what @bio_set
actually does?

Blindly lifting comments and making them documentation doesn't make
for good documentation....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
