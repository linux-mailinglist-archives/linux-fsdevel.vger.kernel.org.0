Return-Path: <linux-fsdevel+bounces-21729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8113C9093C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 23:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954D71C21245
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 21:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BA185097;
	Fri, 14 Jun 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYkTGNFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D22032A;
	Fri, 14 Jun 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718401671; cv=none; b=lRB3q71fuWRv3/eUCfm/eWbZxSLt1nSQrvJVqGgYy+kgKvoCGJNDAfxQ98xw1c2QbD/rg5yE5KjaIxO2Mjx6sQrlNaN2vTwphp+vIkw3fkQNQtwdiPlr7BLHlkndnqNcJwDwTsj038homuH0xH7AS+Z0/uBIOdz6Fh1DagNfhfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718401671; c=relaxed/simple;
	bh=QzLUVCGd/IwfRy9XRwM8Zt5WYb9nFWEzZiraamlAO9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVJrrQehpsfJggkF8AJV47oDY/l+xSBUjBelMI9PwA1SfgiJ0DwN/6ohHR1cP9F4ytQcofGSLIJcP8kO/GNvajLldF7OeA4xATjfcnO4WF0CPYxS2ejYG7SHJtFXPCNZ8t2x5YDKhkOW1I+1BsXKl+rygpMOu0LaW18S7cO/Zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYkTGNFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A183DC2BD10;
	Fri, 14 Jun 2024 21:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718401670;
	bh=QzLUVCGd/IwfRy9XRwM8Zt5WYb9nFWEzZiraamlAO9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYkTGNFkD36aJM7RCXZB1yQmhEZeUAH58YooPQKwPT3DfWasaEbVzniv/3VQdUOHw
	 yi0bd04n+gHUWTvdrlcPv3BJZ9JeNM7InpuMAzWpJTgf3bTGLD+gmv0MRzgy+nU/XC
	 A1iu0ebyXR8NR79bVQrTQHXHl5XFT/5OlKG61UdM8LjTVpDdQ4bJPSHnC7/c+mFdN7
	 od5ZZdZEhuB7+ydTK9NzQM2O6smJPIdjA8QtcPPffcUlXfLhz/1Gj5et9HVb4WEf9t
	 LTrmZlMnSU3exqAfFkgR7devvkb9NUH4vbQSLvDBGqwhDtDprJmy0xrYygd9Dxt+4z
	 9gVyz3X0KPwkw==
Date: Fri, 14 Jun 2024 14:47:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [TEXT 3/3] porting iomap
Message-ID: <20240614214750.GN6125@frogsfrogsfrogs>
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

And the final part is the porting guide.
https://djwong.org/docs/iomap/porting.html

--D

                        Porting Your Filesystem

   Table of Contents

     * Why Convert?
     * How Do I Convert a Filesystem?

                              Why Convert?

   There are several reasons to convert a filesystem to iomap:

      1. The classic Linux I/O path is not terribly efficient.
         Pagecache operations lock a single base page at a time and
         then call into the filesystem to return a mapping for only
         that page. Direct I/O operations build I/O requests a single
         file block at a time. This worked well enough for
         direct/indirect-mapped filesystems such as ext2, but is very
         inefficient for extent-based filesystems such as XFS.
      2. Large folios are only supported via iomap; there are no
         plans to convert the old buffer_head path to use them.
      3. Direct access to storage on memory-like devices (fsdax) is
         only supported via iomap.
      4. Lower maintenance overhead for individual filesystem
         maintainers. iomap handles common pagecache related
         operations itself, such as allocating, instantiating,
         locking, and unlocking of folios. No ->write_begin(),
         ->write_end() or direct_IO address_space_operations are
         required to be implemented by filesystem using iomap.

                     How Do I Convert a Filesystem?

   First, add #include <linux/iomap.h> from your source code and add
   select FS_IOMAP to your filesystem's Kconfig option. Build the
   kernel, run fstests with the -g all option across a wide variety
   of your filesystem's supported configurations to build a baseline
   of which tests pass and which ones fail.

   The recommended approach is first to implement ->iomap_begin (and
   ->iomap_end if necessary) to allow iomap to obtain a read-only
   mapping of a file range. In most cases, this is a relatively
   trivial conversion of the existing get_block() function for
   read-only mappings. FS_IOC_FIEMAP is a good first target because
   it is trivial to implement support for it and then to determine
   that the extent map iteration is correct from userspace. If FIEMAP
   is returning the correct information, it's a good sign that other
   read-only mapping operations will do the right thing.

   Next, modify the filesystem's get_block(create = false)
   implementation to use the new ->iomap_begin implementation to map
   file space for selected read operations. Hide behind a debugging
   knob the ability to switch on the iomap mapping functions for
   selected call paths. It is necessary to write some code to fill
   out the bufferhead-based mapping information from the iomap
   structure, but the new functions can be tested without needing to
   implement any iomap APIs.

   Once the read-only functions are working like this, convert each
   high level file operation one by one to use iomap native APIs
   instead of going through get_block(). Done one at a time,
   regressions should be self evident. You do have a regression test
   baseline for fstests, right? It is suggested to convert swap file
   activation, SEEK_DATA, and SEEK_HOLE before tackling the I/O
   paths. A likely complexity at this point will be converting the
   buffered read I/O path because of bufferheads. The buffered read
   I/O paths doesn't need to be converted yet, though the direct I/O
   read path should be converted in this phase.

   At this point, you should look over your ->iomap_begin function.
   If it switches between large blocks of code based on dispatching
   of the flags argument, you should consider breaking it up into
   per-operation iomap ops with smaller, more cohesive functions. XFS
   is a good example of this.

   The next thing to do is implement get_blocks(create == true)
   functionality in the ->iomap_begin/->iomap_end methods. It is
   strongly recommended to create separate mapping functions and
   iomap ops for write operations. Then convert the direct I/O write
   path to iomap, and start running fsx w/ DIO enabled in earnest on
   filesystem. This will flush out lots of data integrity corner case
   bugs that the new write mapping implementation introduces.

   Now, convert any remaining file operations to call the iomap
   functions. This will get the entire filesystem using the new
   mapping functions, and they should largely be debugged and working
   correctly after this step.

   Most likely at this point, the buffered read and write paths will
   still need to be converted. The mapping functions should all work
   correctly, so all that needs to be done is rewriting all the code
   that interfaces with bufferheads to interface with iomap and
   folios. It is much easier first to get regular file I/O (without
   any fancy features like fscrypt, fsverity, compression, or
   data=journaling) converted to use iomap. Some of those fancy
   features (fscrypt and compression) aren't implemented yet in
   iomap. For unjournalled filesystems that use the pagecache for
   symbolic links and directories, you might also try converting
   their handling to iomap.

   The rest is left as an exercise for the reader, as it will be
   different for every filesystem. If you encounter problems, email
   the people and lists in get_maintainers.pl for help.

