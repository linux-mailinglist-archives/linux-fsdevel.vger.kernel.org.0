Return-Path: <linux-fsdevel+bounces-21723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1EF909385
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 22:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF1C288B97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 20:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D11AB508;
	Fri, 14 Jun 2024 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL6OzTd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA521F946;
	Fri, 14 Jun 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718397696; cv=none; b=QEXFOz5YS5iTZ9JiTlYiQJbrCmot7q7Eejvx5b13R6gAQi0B6F/I2f489V7t1R2s/6TjfdxQiH5sufdKAT3nVurcdzpUla7b2LJ+L+SzyPkjTWihimNsY2yHYPt+f3aCGWhb3Hzeicp5q+78Bo7sTfwxyKeKGBjMMe+IPf2Be6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718397696; c=relaxed/simple;
	bh=b2U7IF/mpa1TMhbAFL89JzdngizUiapMi7+c9TOessE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN5jS7tp6k7ZM4/C7W7MWeIlq6lebPun0mDc7nYQwSkIgLsMe6lr6KzYyTVPQv9IQa2H4706bNYThyl591JqddMl1TsDk4kmfremCONzry5kaxR6EtxHzlDlvq6XMVl7WrKuQNJ7tGmPvg1LrqtAY9OGAX1zGNJ7HzchAdagfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL6OzTd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1DCC2BD10;
	Fri, 14 Jun 2024 20:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718397695;
	bh=b2U7IF/mpa1TMhbAFL89JzdngizUiapMi7+c9TOessE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HL6OzTd+/HKON1KhrIhgkzH9sosLfsuw5A1XH3L5kHX2tI5VNivcs5UNuJcugMVJV
	 VIw8dueFaYO36ddCJaP8XL/wkSZNk4WZLFF7ZPHWwYJAFSkGtM2Y3glv2XO4RUoVbs
	 EUf8wU4OVAh+GXdgUl04SMqcy2MD/KT9tjDJJ4Wz/8HJcG0K7u+oFSSKfLWGZZT6in
	 kKKoLGHVv1SVqxTcn7s5+rW594CjfqXFKPhy+fe6QlqTvw/CWPwsOlmfgocayEYZhS
	 2VedDEeW3+cMfQ5YPrt4BeHTpZOZ+ghx/k+QFg4fbthTs6CyaCD7vOycW4i0L3h/A7
	 2wt0OxKKrVpMA==
Date: Fri, 14 Jun 2024 13:41:35 -0700
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
Message-ID: <20240614204135.GI6125@frogsfrogsfrogs>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <87msnny3do.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msnny3do.fsf@gmail.com>

On Fri, Jun 14, 2024 at 08:31:55PM +0530, Ritesh Harjani wrote:
> 
> > +SEEK_DATA
> > +---------
> > +
> > +The ``iomap_seek_data`` function implements the SEEK_DATA "whence" value
> > +for llseek.
> > +``IOMAP_REPORT`` will be passed as the ``flags`` argument to
> > +``->iomap_begin``.
> > +
> > +For unwritten mappings, the pagecache will be searched.
> > +Regions of the pagecache with a folio mapped and uptodate fsblocks
> > +within those folios will be reported as data areas.
> > +
> > +Callers commonly hold ``i_rwsem`` in shared mode.
> > +
> > +SEEK_HOLE
> > +---------
> > +
> > +The ``iomap_seek_hole`` function implements the SEEK_HOLE "whence" value
> > +for llseek.
> > +``IOMAP_REPORT`` will be passed as the ``flags`` argument to
> > +``->iomap_begin``.
> > +
> > +For unwritten mappings, the pagecache will be searched.
> > +Regions of the pagecache with no folio mapped, or a !uptodate fsblock
> > +within a folio will be reported as sparse hole areas.
> > +
> > +Callers commonly hold ``i_rwsem`` in shared mode.
> > +
> > +Swap File Activation
> > +--------------------
> > +
> > +The ``iomap_swapfile_activate`` function finds all the base-page aligned
> > +regions in a file and sets them up as swap space.
> > +The file will be ``fsync()``'d before activation.
> > +``IOMAP_REPORT`` will be passed as the ``flags`` argument to
> > +``->iomap_begin``.
> > +All mappings must be mapped or unwritten; cannot be dirty or shared, and
> > +cannot span multiple block devices.
> > +Callers must hold ``i_rwsem`` in exclusive mode; this is already
> > +provided by ``swapon``.
> > +
> > +Extent Map Reporting (FS_IOC_FIEMAP)
> > +------------------------------------
> > +
> > +The ``iomap_fiemap`` function exports file extent mappings to userspace
> > +in the format specified by the ``FS_IOC_FIEMAP`` ioctl.
> > +``IOMAP_REPORT`` will be passed as the ``flags`` argument to
> > +``->iomap_begin``.
> > +Callers commonly hold ``i_rwsem`` in shared mode.
> > +
> > +Block Map Reporting (FIBMAP)
> > +----------------------------
> > +
> > +``iomap_bmap`` implements FIBMAP.
> > +The calling conventions are the same as for FIEMAP.
> > +This function is only provided to maintain compatibility for filesystems
> > +that implemented FIBMAP prior to conversion.
> > +This ioctl is deprecated; do not add a FIBMAP implementation to
> > +filesystems that do not have it.
> > +Callers should probably hold ``i_rwsem`` in shared mode, but this is
> > +unclear.
> 
> looking at fiemap callers is also confusing w.r.t i_rwsem ;)

Yes indeed -- if the FIEMAP code does not access any state that's
protected only by i_rwsem then I guess you don't need it?  AFAICT that's
the case for xfs.

> > +
> > +Porting Guide
> > +=============
> > +
> > +Why Convert to iomap?
> > +---------------------
> > +
> > +There are several reasons to convert a filesystem to iomap:
> > +
> > + 1. The classic Linux I/O path is not terribly efficient.
> > +    Pagecache operations lock a single base page at a time and then call
> > +    into the filesystem to return a mapping for only that page.
> > +    Direct I/O operations build I/O requests a single file block at a
> > +    time.
> > +    This worked well enough for direct/indirect-mapped filesystems such
> > +    as ext2, but is very inefficient for extent-based filesystems such
> > +    as XFS.
> > +
> > + 2. Large folios are only supported via iomap; there are no plans to
> > +    convert the old buffer_head path to use them.
> > +
> > + 3. Direct access to storage on memory-like devices (fsdax) is only
> > +    supported via iomap.
> > +
> > + 4. Lower maintenance overhead for individual filesystem maintainers.
> > +    iomap handles common pagecache related operations itself, such as
> > +    allocating, instantiating, locking, and unlocking of folios.
> > +    No ->write_begin(), ->write_end() or direct_IO
> > +    address_space_operations are required to be implemented by
> > +    filesystem using iomap.
> > +
> > +How to Convert to iomap?
> > +------------------------
> > +
> > +First, add ``#include <linux/iomap.h>`` from your source code and add
> > +``select FS_IOMAP`` to your filesystem's Kconfig option.
> > +Build the kernel, run fstests with the ``-g all`` option across a wide
> > +variety of your filesystem's supported configurations to build a
> > +baseline of which tests pass and which ones fail.
> > +
> > +The recommended approach is first to implement ``->iomap_begin`` (and
> > +``->iomap->end`` if necessary) to allow iomap to obtain a read-only
> 
> small correction: ``->iomap_end``

Fixed, thanks.

> > +mapping of a file range.
> > +In most cases, this is a relatively trivial conversion of the existing
> > +``get_block()`` function for read-only mappings.
> > +``FS_IOC_FIEMAP`` is a good first target because it is trivial to
> > +implement support for it and then to determine that the extent map
> > +iteration is correct from userspace.
> > +If FIEMAP is returning the correct information, it's a good sign that
> > +other read-only mapping operations will do the right thing.
> > +
> > +Next, modify the filesystem's ``get_block(create = false)``
> > +implementation to use the new ``->iomap_begin`` implementation to map
> > +file space for selected read operations.
> > +Hide behind a debugging knob the ability to switch on the iomap mapping
> > +functions for selected call paths.
> > +It is necessary to write some code to fill out the bufferhead-based
> > +mapping information from the ``iomap`` structure, but the new functions
> > +can be tested without needing to implement any iomap APIs.
> > +
> > +Once the read-only functions are working like this, convert each high
> > +level file operation one by one to use iomap native APIs instead of
> > +going through ``get_block()``.
> > +Done one at a time, regressions should be self evident.
> > +You *do* have a regression test baseline for fstests, right?
> > +It is suggested to convert swap file activation, ``SEEK_DATA``, and
> > +``SEEK_HOLE`` before tackling the I/O paths.
> > +A likely complexity at this point will be converting the buffered read
> > +I/O path because of bufferheads.
> > +The buffered read I/O paths doesn't need to be converted yet, though the
> > +direct I/O read path should be converted in this phase.
> > +
> > +At this point, you should look over your ``->iomap_begin`` function.
> > +If it switches between large blocks of code based on dispatching of the
> > +``flags`` argument, you should consider breaking it up into
> > +per-operation iomap ops with smaller, more cohesive functions.
> > +XFS is a good example of this.
> > +
> > +The next thing to do is implement ``get_blocks(create == true)``
> > +functionality in the ``->iomap_begin``/``->iomap_end`` methods.
> > +It is strongly recommended to create separate mapping functions and
> > +iomap ops for write operations.
> > +Then convert the direct I/O write path to iomap, and start running fsx
> > +w/ DIO enabled in earnest on filesystem.
> > +This will flush out lots of data integrity corner case bugs that the new
> > +write mapping implementation introduces.
> > +
> > +Now, convert any remaining file operations to call the iomap functions.
> > +This will get the entire filesystem using the new mapping functions, and
> > +they should largely be debugged and working correctly after this step.
> > +
> > +Most likely at this point, the buffered read and write paths will still
> > +to be converted.
> > +The mapping functions should all work correctly, so all that needs to be
> > +done is rewriting all the code that interfaces with bufferheads to
> > +interface with iomap and folios.
> > +It is much easier first to get regular file I/O (without any fancy
> > +features like fscrypt, fsverity, compression, or data=journaling)
> > +converted to use iomap.
> > +Some of those fancy features (fscrypt and compression) aren't
> > +implemented yet in iomap.
> > +For unjournalled filesystems that use the pagecache for symbolic links
> > +and directories, you might also try converting their handling to iomap.
> > +
> > +The rest is left as an exercise for the reader, as it will be different
> > +for every filesystem.
> > +If you encounter problems, email the people and lists in
> > +``get_maintainers.pl`` for help.
> > +
> > +Bugs and Limitations
> > +====================
> > +
> > + * No support for fscrypt.
> > + * No support for compression.
> > + * No support for fsverity yet.
> > + * Strong assumptions that IO should work the way it does on XFS.
> > + * Does iomap *actually* work for non-regular file data?
> > +
> > +Patches welcome!
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8754ac2c259d..2ddd94d43ecf 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8483,6 +8483,7 @@ R:	Darrick J. Wong <djwong@kernel.org>
> >  L:	linux-xfs@vger.kernel.org
> >  L:	linux-fsdevel@vger.kernel.org
> >  S:	Supported
> > +F:	Documentation/filesystems/iomap.txt
> >  F:	fs/iomap/
> >  F:	include/linux/iomap.h
> >  
> 
> Rest looks good to me.

Yay, thanks for giving feedback on the whole thing!

--D

> -ritesh
> 

