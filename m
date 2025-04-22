Return-Path: <linux-fsdevel+bounces-46868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA58A95A79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 03:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFD71894B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 01:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD9B174EF0;
	Tue, 22 Apr 2025 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOA26Sow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E0125DF;
	Tue, 22 Apr 2025 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745285138; cv=none; b=EbDiIgtEHooD/T3NZyf8jneA5PvjIVGWYxDFmIL4E9ZagVMLx6EfIUclw89AQOMtUwp8WXoVUjd2YjCxjK2c7vAf0jlYWHflr5iQWazoGN28HTWmCPJE0OQzHHl0aqkaam2t3f6xyLWszIZtSPnhTepyQFod31pFNc42YHB2TZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745285138; c=relaxed/simple;
	bh=beyaRmF+nkMa2OmUzGxepPUNv5XrwYiI3FFAOsjubnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+5/decB+f2WWWIUEKHwMQ3LCxcPrmtvjvDZ30BUnvovnB3ovHA4iCwjcls6YmiNceP8i/u4bbcxLE2nDNliAYMUhnEaHzMGx0Jfxa+SzssXes9FdvJNFy8cHjRj7AWz9Hdhq5ptCiqx8NWi0jVYXb3Avuc5qSeUMh94wYRlEME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOA26Sow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E590C4CEE4;
	Tue, 22 Apr 2025 01:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745285137;
	bh=beyaRmF+nkMa2OmUzGxepPUNv5XrwYiI3FFAOsjubnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOA26SowJhq1l7aJcoGhjG3vwzVWr5XlwywCFShRYH5THKqyA3qaZenEMB5uBFyrU
	 t+fBsBG6LubT1UH7CEdopx3FCe4xeOI7xt7oXBZLllQ4sOcp+uVR9zHE1g7ejOSf++
	 Ngcv6d6o1m4UKrAHQLTHGDLE5Vbszp+892CHXiykxwNH7KR132kRtNzDsAbWW/pa2W
	 JR7Ti6kqEUAZ4IK5q1fGR1OaG9dtwE7O1+iSD1KUDtyMBcJRucAYIUEK8+Z93sma/3
	 IwVHa1gJ9Z1NAzZXkG9syG65X8lF5xwdipYdCOGNY9ay9+rkZkGLWvKg9BGkBFsTqs
	 FHnPKitUpDOYQ==
Date: Mon, 21 Apr 2025 18:25:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 00/19] famfs: port into fuse
Message-ID: <20250422012537.GL25659@frogsfrogsfrogs>
References: <20250421013346.32530-1-john@groves.net>
 <20250421182758.GJ25659@frogsfrogsfrogs>
 <37ss7esexgblholq5wc5caeizhcjpjhjxsghqjtkxjqri4uxjp@gixtdlggap5i>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ss7esexgblholq5wc5caeizhcjpjhjxsghqjtkxjqri4uxjp@gixtdlggap5i>

On Mon, Apr 21, 2025 at 05:00:35PM -0500, John Groves wrote:
> On 25/04/21 11:27AM, Darrick J. Wong wrote:
> > On Sun, Apr 20, 2025 at 08:33:27PM -0500, John Groves wrote:
> > > Subject: famfs: port into fuse
> > > 
> > > This is the initial RFC for the fabric-attached memory file system (famfs)
> > > integration into fuse. In order to function, this requires a related patch
> > > to libfuse [1] and the famfs user space [2]. 
> > > 
> > > This RFC is mainly intended to socialize the approach and get feedback from
> > > the fuse developers and maintainers. There is some dax work that needs to
> > > be done before this should be merged (see the "poisoned page|folio problem"
> > > below).
> > 
> > Note that I'm only looking at the fuse and iomap aspects of this
> > patchset.  I don't know the devdax code at all.
> > 
> > > This patch set fully works with Linux 6.14 -- passing all existing famfs
> > > smoke and unit tests -- and I encourage existing famfs users to test it.
> > > 
> > > This is really two patch sets mashed up:
> > > 
> > > * The patches with the dev_dax_iomap: prefix fill in missing functionality for
> > >   devdax to host an fs-dax file system.
> > > * The famfs_fuse: patches add famfs into fs/fuse/. These are effectively
> > >   unchanged since last year.
> > > 
> > > Because this is not ready to merge yet, I have felt free to leave some debug
> > > prints in place because we still find them useful; those will be cleaned up
> > > in a subsequent revision.
> > > 
> > > Famfs Overview
> > > 
> > > Famfs exposes shared memory as a file system. Famfs consumes shared memory
> > > from dax devices, and provides memory-mappable files that map directly to
> > > the memory - no page cache involvement. Famfs differs from conventional
> > > file systems in fs-dax mode, in that it handles in-memory metadata in a
> > > sharable way (which begins with never caching dirty shared metadata).
> > > 
> > > Famfs started as a standalone file system [3,4], but the consensus at LSFMM
> > > 2024 [5] was that it should be ported into fuse - and this RFC is the first
> > > public evidence that I've been working on that.
> > 
> > This is very timely, as I just started looking into how I might connect
> > iomap to fuse so that most of the hot IO path continues to run in the
> > kernel, and userspace block device filesystem drivers merely supply the
> > file mappings to the kernel.  In other words, we kick the metadata
> > parsing craziness out of the kernel.
> 
> Coool!
> 
> > 
> > > The key performance requirement is that famfs must resolve mapping faults
> > > without upcalls. This is achieved by fully caching the file-to-devdax
> > > metadata for all active files. This is done via two fuse client/server
> > > message/response pairs: GET_FMAP and GET_DAXDEV.
> > 
> > Heh, just last week I finally got around to laying out how I think I'd
> > want to expose iomap through fuse to allow ->iomap_begin/->iomap_end
> > upcalls to a fuse server.  Note that I've done zero prototyping but
> > "upload all the mappings at open time" seems like a reasonable place for
> > me to start looking, especially for a filesystem with static mappings.
> > 
> > I think what I want to try to build is an in-kernel mapping cache (sort
> > of like the one you built), only with upcalls to the fuse server when
> > there is no mapping information for a given IO.  I'd probably want to
> > have a means for the fuse server to put new mappings into the cache, or
> > invalidate existing mappings.
> > 
> > (famfs obviously is a simple corner-case of that grandiose vision, but I
> > still have a long way to get to my larger vision so don't take my words
> > as any kind of requirement.)
> > 
> > > Famfs remains the first fs-dax file system that is backed by devdax rather
> > > than pmem in fs-dax mode (hence the need for the dev_dax_iomap fixups).
> > > 
> > > Notes
> > > 
> > > * Once the dev_dax_iomap patches land, I suspect it may make sense for
> > >   virtiofs to update to use the improved interface.
> > > 
> > > * I'm currently maintaining compatibility between the famfs user space and
> > >   both the standalone famfs kernel file system and this new fuse
> > >   implementation. In the near future I'll be running performance comparisons
> > >   and sharing them - but there is no reason to expect significant degradation
> > >   with fuse, since famfs caches entire "fmaps" in the kernel to resolve
> > 
> > I'm curious to hear what you find, performance-wise. :)
> > 
> > >   faults with no upcalls. This patch has a bit too much debug turned on to
> > >   to that testing quite yet. A branch 
> > 
> > A branch ... what?
> 
> I trail off sometimes... ;)
> 
> > 
> > > * Two new fuse messages / responses are added: GET_FMAP and GET_DAXDEV.
> > > 
> > > * When a file is looked up in a famfs mount, the LOOKUP is followed by a
> > >   GET_FMAP message and response. The "fmap" is the full file-to-dax mapping,
> > >   allowing the fuse/famfs kernel code to handle read/write/fault without any
> > >   upcalls.
> > 
> > Huh, I'd have thought you'd wait until FUSE_OPEN to start preloading
> > mappings into the kernel.
> 
> That may be a better approach. Miklos and I discussed it during LPC last year, 
> and thought both were options. Having implemented it at LOOKUP time, I think
> moving it to open might avoid my READDIRPLUS problem (which is that RDP is a
> mashup of READDIR and LOOKUP), therefore might need to add the GET_FMAP
> payload. Moving GET_FMAP to open time, would break that connection in a good
> way, I think.

I wonder if we could just add a couple new "notification" types so that
the fuse server can initiate uploads of mappings whenever it feels like
it.  For your usage model I don't think it'll make much difference since
they seem pretty static, but the ability to do that would open up some
flexibility for famfs.  The more general filesystems will need it
anyway, and someone's going to want to truncate a famfs file.  They
always do. ;)

> > 
> > > * After each GET_FMAP, the fmap is checked for extents that reference
> > >   previously-unknown daxdevs. Each such occurence is handled with a
> > >   GET_DAXDEV message and response.
> > 
> > I hadn't figured out how this part would work for my silly prototype.
> > Just out of curiosity, does the famfs fuse server hold an open fd to the
> > storage, in which case the fmap(ping) could just contain the open fd?
> > 
> > Where are the mappings that are sent from the fuse server?  Is that
> > struct fuse_famfs_simple_ext?
> 
> See patch 17 or fs/fuse/famfs_kfmap.h for the fmap metadata explanation. 
> Famfs currently supports either simple extents (daxdev, offset, length) or 
> interleaved ones (which describe each "strip" as a simple extent). I think 
> the explanation in famfs_kfmap.h is pretty clear.
> 
> A key question is whether any additional basic metadata abstractions would
> be needed - because the kernel needs to understand the full scheme.
> 
> With disaggregated memory, the interleave approach is nice because it gets
> aggregated performance and resolving a file offset to daxdev offset is order
> 1.
> 
> Oh, and there are two fmap formats (ok, more, but the others are legacy ;).
> The fmaps-in-messages structs are currently in the famfs section of
> include/uapi/linux/fuse.h. And the in-memory version is in 
> fs/fuse/famfs_kfmap.h. The former will need to be a versioned interface.
> (ugh...)

Ok, will take a look tomorrow morning.

> > 
> > > * Daxdevs are stored in a table (which might become an xarray at some point).
> > >   When entries are added to the table, we acquire exclusive access to the
> > >   daxdev via the fs_dax_get() call (modeled after how fs-dax handles this
> > >   with pmem devices). famfs provides holder_operations to devdax, providing
> > >   a notification path in the event of memory errors.
> > > 
> > > * If devdax notifies famfs of memory errors on a dax device, famfs currently
> > >   bocks all subsequent accesses to data on that device. The recovery is to
> > >   re-initialize the memory and file system. Famfs is memory, not storage...
> > 
> > Ouch. :)
> 
> Cautious initial approach (i.e. I'm trying not to scare people too much ;) 
> 
> > 
> > > * Because famfs uses backing (devdax) devices, only privileged mounts are
> > >   supported.
> > > 
> > > * The famfs kernel code never accesses the memory directly - it only
> > >   facilitates read, write and mmap on behalf of user processes. As such,
> > >   the RAS of the shared memory affects applications, but not the kernel.
> > > 
> > > * Famfs has backing device(s), but they are devdax (char) rather than
> > >   block. Right now there is no way to tell the vfs layer that famfs has a
> > >   char backing device (unless we say it's block, but it's not). Currently
> > >   we use the standard anonymous fuse fs_type - but I'm not sure that's
> > >   ultimately optimal (thoughts?)
> > 
> > Does it work if the fusefs server adds "-o fsname=<devdax cdev>" to the
> > fuse_args object?  fuse2fs does that, though I don't recall if that's a
> > reasonable thing to do.
> 
> The kernel needs to "own" the dax devices. fs-dax on pmem/block calls
> fs_dax_get_by_bdev() and passes in holder_operations - which are used for
> error upcalls, but also effect exclusive ownership. 
> 
> I added fs_dax_get() since the bdev version wasn't really right or char
> devdax. But same holder_operations.
> 
> I had originally intended to pass in "-o daxdev=<cdev>", but famfs needs to
> span multiple daxdevs, in order to interleave for performance. The approach
> of retrieving them with GET_DAXDEV handles the generalized case, so "-o"
> just amounts to a second way to do the same thing.

Oh, hah, it's a multi-device filesystem.  Hee hee hee...

> "But wait"... I thought. Doesn't the "-o" approach get the primary daxdev
> locked up sooner, which might be good? Well, no, because famfs creates a
> couple of meta files during mount .meta/.superblock and .meta/.log - and 
> those are guaranteed to reference the primary daxdev. So I concluded the -o
> approach wasn't worth the trouble (though it's not *much* trouble).

<nod> For block devices, someone needs to own the bdev O_EXCL, but it
doesn't have to be the kernel.  Though ... I wonder what *does* happen
when the something tries to invoke the bdev holder_ops?  Maybe it would
be nice to freeze the fs, but I don't know if fuse already does that.

> > 
> > > The "poisoned page|folio problem"
> > > 
> > > * Background: before doing a kernel mount, the famfs user space [2] validates
> > >   the superblock and log. This is done via raw mmap of the primary devdax
> > >   device. If valid, the file system is mounted, and the superblock and log
> > >   get exposed through a pair of files (.meta/.superblock and .meta/.log) -
> > >   because we can't be using raw device mmap when a file system is mounted
> > >   on the device. But this exposes a devdax bug and warning...
> > > 
> > > * Pages that have been memory mapped via devdax are left in a permanently
> > >   problematic state. Devdax sets page|folio->mapping when a page is accessed
> > >   via raw devdax mmap (as famfs does before mount), but never cleans it up.
> > >   When the pages of the famfs superblock and log are accessed via the "meta"
> > >   files after mount, we see a WARN_ONCE() in dax_insert_entry(), which
> > >   notices that page|folio->mapping is still set. I intend to address this
> > >   prior to asking for the famfs patches to be merged.
> > > 
> > > * Alistair Popple's recent dax patch series [6], which has been merged
> > >   for 6.15, addresses some dax issues, but sadly does not fix the poisoned
> > >   page|folio problem - its enhanced refcount checking turns the warning into
> > >   an error.
> > > 
> > > * This 6.14 patch set disables the warning; a proper fix will be required for
> > >   famfs to work at all in 6.15. Dan W. and I are actively discussing how to do
> > >   this properly...
> > > 
> > > * In terms of the correct functionality of famfs, the warning can be ignored.
> > > 
> > > References
> > > 
> > > [1] - https://github.com/libfuse/libfuse/pull/1200
> > > [2] - https://github.com/cxl-micron-reskit/famfs
> > 
> > Thanks for posting links, I'll have a look there too.
> > 
> > --D
> > 
> 
> I'm happy to talk if you wanna kick ideas around.

Heheh I will, but give me a day or two to wander through the rest of the
patches, or maybe just decide to pull the branch and look at one huge
diff.

--D

> Cheers,
> John
> 
> 

