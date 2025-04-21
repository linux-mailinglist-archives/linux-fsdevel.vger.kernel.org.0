Return-Path: <linux-fsdevel+bounces-46842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBAAA955DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 20:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64BC3A9F4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD42F1E9915;
	Mon, 21 Apr 2025 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNxyipRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07014883F;
	Mon, 21 Apr 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745260080; cv=none; b=XPJysfypgNOR+QAojhUMZ0l4vSzLYbrV4xODylvmpYrcOp4cw0yvPOhDYvUcgv0y/P4uk98zc96wJSJLeN7t265AXXZQ/1TGDJw322fWV+A16e1Z05dBqRhyBthMIjIqP+bZj0ckpkEvLlTLqoOM6XFOfz1JRRVeatETJ+1qBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745260080; c=relaxed/simple;
	bh=3hDGiq99gc+sy0LHT+ZmeczL9eu3JsaSljA5li2tOZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CE5CocwRJNO6GXsCYW2wyMK1jW5pBovMTD7UZnPre15V2LktxFjt1gfr2/WRZFWm2wDBPAjkK4ZLxyLncW6H85s/UbF+sEZZW2AjV/PQieu530qsiOHerIFPsnOCMStq/FjQ/MAJGBpes1dI8JCQmwWq0tPZmWM4LNbKVirSneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNxyipRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E183C4CEE4;
	Mon, 21 Apr 2025 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745260079;
	bh=3hDGiq99gc+sy0LHT+ZmeczL9eu3JsaSljA5li2tOZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNxyipRZa1YwZLby/k2kaFptenwet2POYsA/hlNjRvnfHdf7ICoJJvlqOxYd0FiGc
	 NRMD3EyFlgPwHC9dWDr7sZIj7DxHyh8LBgXo5h5xWou2LFA+49cQOTcFT0v2L4qyEF
	 y9cMIDtoWWVPqVcfMQWyPG8466ndgqj11hYeLFePTez9nuj06bR29P9AMIRWlSDcoT
	 PsvUQ9e6bPLpzGfhSXKP7F4PAAAsGeSUTR+TELtwpD3/3wMa44aCB+E8jOvcuk8RK+
	 mKwJ8isoGpjIQ4KfwF+YmNjQbFGaicp+JTY7M+VhCESadgLgzzpn898Zvmp4940Sn+
	 ozVM+nf1ucM8g==
Date: Mon, 21 Apr 2025 11:27:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
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
Message-ID: <20250421182758.GJ25659@frogsfrogsfrogs>
References: <20250421013346.32530-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421013346.32530-1-john@groves.net>

On Sun, Apr 20, 2025 at 08:33:27PM -0500, John Groves wrote:
> Subject: famfs: port into fuse
> 
> This is the initial RFC for the fabric-attached memory file system (famfs)
> integration into fuse. In order to function, this requires a related patch
> to libfuse [1] and the famfs user space [2]. 
> 
> This RFC is mainly intended to socialize the approach and get feedback from
> the fuse developers and maintainers. There is some dax work that needs to
> be done before this should be merged (see the "poisoned page|folio problem"
> below).

Note that I'm only looking at the fuse and iomap aspects of this
patchset.  I don't know the devdax code at all.

> This patch set fully works with Linux 6.14 -- passing all existing famfs
> smoke and unit tests -- and I encourage existing famfs users to test it.
> 
> This is really two patch sets mashed up:
> 
> * The patches with the dev_dax_iomap: prefix fill in missing functionality for
>   devdax to host an fs-dax file system.
> * The famfs_fuse: patches add famfs into fs/fuse/. These are effectively
>   unchanged since last year.
> 
> Because this is not ready to merge yet, I have felt free to leave some debug
> prints in place because we still find them useful; those will be cleaned up
> in a subsequent revision.
> 
> Famfs Overview
> 
> Famfs exposes shared memory as a file system. Famfs consumes shared memory
> from dax devices, and provides memory-mappable files that map directly to
> the memory - no page cache involvement. Famfs differs from conventional
> file systems in fs-dax mode, in that it handles in-memory metadata in a
> sharable way (which begins with never caching dirty shared metadata).
> 
> Famfs started as a standalone file system [3,4], but the consensus at LSFMM
> 2024 [5] was that it should be ported into fuse - and this RFC is the first
> public evidence that I've been working on that.

This is very timely, as I just started looking into how I might connect
iomap to fuse so that most of the hot IO path continues to run in the
kernel, and userspace block device filesystem drivers merely supply the
file mappings to the kernel.  In other words, we kick the metadata
parsing craziness out of the kernel.

> The key performance requirement is that famfs must resolve mapping faults
> without upcalls. This is achieved by fully caching the file-to-devdax
> metadata for all active files. This is done via two fuse client/server
> message/response pairs: GET_FMAP and GET_DAXDEV.

Heh, just last week I finally got around to laying out how I think I'd
want to expose iomap through fuse to allow ->iomap_begin/->iomap_end
upcalls to a fuse server.  Note that I've done zero prototyping but
"upload all the mappings at open time" seems like a reasonable place for
me to start looking, especially for a filesystem with static mappings.

I think what I want to try to build is an in-kernel mapping cache (sort
of like the one you built), only with upcalls to the fuse server when
there is no mapping information for a given IO.  I'd probably want to
have a means for the fuse server to put new mappings into the cache, or
invalidate existing mappings.

(famfs obviously is a simple corner-case of that grandiose vision, but I
still have a long way to get to my larger vision so don't take my words
as any kind of requirement.)

> Famfs remains the first fs-dax file system that is backed by devdax rather
> than pmem in fs-dax mode (hence the need for the dev_dax_iomap fixups).
> 
> Notes
> 
> * Once the dev_dax_iomap patches land, I suspect it may make sense for
>   virtiofs to update to use the improved interface.
> 
> * I'm currently maintaining compatibility between the famfs user space and
>   both the standalone famfs kernel file system and this new fuse
>   implementation. In the near future I'll be running performance comparisons
>   and sharing them - but there is no reason to expect significant degradation
>   with fuse, since famfs caches entire "fmaps" in the kernel to resolve

I'm curious to hear what you find, performance-wise. :)

>   faults with no upcalls. This patch has a bit too much debug turned on to
>   to that testing quite yet. A branch 

A branch ... what?

> * Two new fuse messages / responses are added: GET_FMAP and GET_DAXDEV.
> 
> * When a file is looked up in a famfs mount, the LOOKUP is followed by a
>   GET_FMAP message and response. The "fmap" is the full file-to-dax mapping,
>   allowing the fuse/famfs kernel code to handle read/write/fault without any
>   upcalls.

Huh, I'd have thought you'd wait until FUSE_OPEN to start preloading
mappings into the kernel.

> * After each GET_FMAP, the fmap is checked for extents that reference
>   previously-unknown daxdevs. Each such occurence is handled with a
>   GET_DAXDEV message and response.

I hadn't figured out how this part would work for my silly prototype.
Just out of curiosity, does the famfs fuse server hold an open fd to the
storage, in which case the fmap(ping) could just contain the open fd?

Where are the mappings that are sent from the fuse server?  Is that
struct fuse_famfs_simple_ext?

> * Daxdevs are stored in a table (which might become an xarray at some point).
>   When entries are added to the table, we acquire exclusive access to the
>   daxdev via the fs_dax_get() call (modeled after how fs-dax handles this
>   with pmem devices). famfs provides holder_operations to devdax, providing
>   a notification path in the event of memory errors.
> 
> * If devdax notifies famfs of memory errors on a dax device, famfs currently
>   bocks all subsequent accesses to data on that device. The recovery is to
>   re-initialize the memory and file system. Famfs is memory, not storage...

Ouch. :)

> * Because famfs uses backing (devdax) devices, only privileged mounts are
>   supported.
> 
> * The famfs kernel code never accesses the memory directly - it only
>   facilitates read, write and mmap on behalf of user processes. As such,
>   the RAS of the shared memory affects applications, but not the kernel.
> 
> * Famfs has backing device(s), but they are devdax (char) rather than
>   block. Right now there is no way to tell the vfs layer that famfs has a
>   char backing device (unless we say it's block, but it's not). Currently
>   we use the standard anonymous fuse fs_type - but I'm not sure that's
>   ultimately optimal (thoughts?)

Does it work if the fusefs server adds "-o fsname=<devdax cdev>" to the
fuse_args object?  fuse2fs does that, though I don't recall if that's a
reasonable thing to do.

> The "poisoned page|folio problem"
> 
> * Background: before doing a kernel mount, the famfs user space [2] validates
>   the superblock and log. This is done via raw mmap of the primary devdax
>   device. If valid, the file system is mounted, and the superblock and log
>   get exposed through a pair of files (.meta/.superblock and .meta/.log) -
>   because we can't be using raw device mmap when a file system is mounted
>   on the device. But this exposes a devdax bug and warning...
> 
> * Pages that have been memory mapped via devdax are left in a permanently
>   problematic state. Devdax sets page|folio->mapping when a page is accessed
>   via raw devdax mmap (as famfs does before mount), but never cleans it up.
>   When the pages of the famfs superblock and log are accessed via the "meta"
>   files after mount, we see a WARN_ONCE() in dax_insert_entry(), which
>   notices that page|folio->mapping is still set. I intend to address this
>   prior to asking for the famfs patches to be merged.
> 
> * Alistair Popple's recent dax patch series [6], which has been merged
>   for 6.15, addresses some dax issues, but sadly does not fix the poisoned
>   page|folio problem - its enhanced refcount checking turns the warning into
>   an error.
> 
> * This 6.14 patch set disables the warning; a proper fix will be required for
>   famfs to work at all in 6.15. Dan W. and I are actively discussing how to do
>   this properly...
> 
> * In terms of the correct functionality of famfs, the warning can be ignored.
> 
> References
> 
> [1] - https://github.com/libfuse/libfuse/pull/1200
> [2] - https://github.com/cxl-micron-reskit/famfs

Thanks for posting links, I'll have a look there too.

--D

> [3] - https://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/
> [4] - https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.net/
> [5] - https://lwn.net/Articles/983105/
> [6] - https://lore.kernel.org/linux-cxl/cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com/
> 
> 
> John Groves (19):
>   dev_dax_iomap: Move dax_pgoff_to_phys() from device.c to bus.c
>   dev_dax_iomap: Add fs_dax_get() func to prepare dax for fs-dax usage
>   dev_dax_iomap: Save the kva from memremap
>   dev_dax_iomap: Add dax_operations for use by fs-dax on devdax
>   dev_dax_iomap: export dax_dev_get()
>   dev_dax_iomap: (ignore!) Drop poisoned page warning in fs/dax.c
>   famfs_fuse: magic.h: Add famfs magic numbers
>   famfs_fuse: Kconfig
>   famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
>   famfs_fuse: Basic fuse kernel ABI enablement for famfs
>   famfs_fuse: Basic famfs mount opts
>   famfs_fuse: Plumb the GET_FMAP message/response
>   famfs_fuse: Create files with famfs fmaps
>   famfs_fuse: GET_DAXDEV message and daxdev_table
>   famfs_fuse: Plumb dax iomap and fuse read/write/mmap
>   famfs_fuse: Add holder_operations for dax notify_failure()
>   famfs_fuse: Add famfs metadata documentation
>   famfs_fuse: Add documentation
>   famfs_fuse: (ignore) debug cruft
> 
>  Documentation/filesystems/famfs.rst |  142 ++++
>  Documentation/filesystems/index.rst |    1 +
>  MAINTAINERS                         |   10 +
>  drivers/dax/Kconfig                 |    6 +
>  drivers/dax/bus.c                   |  144 +++-
>  drivers/dax/dax-private.h           |    1 +
>  drivers/dax/device.c                |   38 +-
>  drivers/dax/super.c                 |   33 +-
>  fs/dax.c                            |    1 -
>  fs/fuse/Kconfig                     |   13 +
>  fs/fuse/Makefile                    |    4 +-
>  fs/fuse/dev.c                       |   61 ++
>  fs/fuse/dir.c                       |   74 +-
>  fs/fuse/famfs.c                     | 1105 +++++++++++++++++++++++++++
>  fs/fuse/famfs_kfmap.h               |  166 ++++
>  fs/fuse/file.c                      |   27 +-
>  fs/fuse/fuse_i.h                    |   67 +-
>  fs/fuse/inode.c                     |   49 +-
>  fs/fuse/iomode.c                    |    2 +-
>  fs/namei.c                          |    1 +
>  include/linux/dax.h                 |    6 +
>  include/uapi/linux/fuse.h           |   63 ++
>  include/uapi/linux/magic.h          |    2 +
>  23 files changed, 1973 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/filesystems/famfs.rst
>  create mode 100644 fs/fuse/famfs.c
>  create mode 100644 fs/fuse/famfs_kfmap.h
> 
> 
> base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
> -- 
> 2.49.0
> 
> 

