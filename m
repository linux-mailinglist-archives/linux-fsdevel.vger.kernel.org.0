Return-Path: <linux-fsdevel+bounces-46921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FCEA9682C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D98D17BE84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0420727CB0D;
	Tue, 22 Apr 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9lpDUvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF627C167;
	Tue, 22 Apr 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322633; cv=none; b=uMKZQrqzV0y9JjJashVw1KGFGdFKyFNEz8BskqzqASlxsQhL+SgWqV08zIiyQAPU40fdWKbJ4RVVTnLaVL/JXF9CvHb5YDCUr/sAdzIV6NC4zP1pYV4NOmEkGd+X2DkLIGtIUzJHOJwFa9H/Jr9cLhPgYtM8NKCIvMpmJjgAlkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322633; c=relaxed/simple;
	bh=L9KcjqYpqFrKqGLfHIsOLmEwyyROjgNyJNvc1KDgWoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMtmlZL22uoijVskL8loEVAMVBwO6d5gKOZK9Hfn1c01Do5gPGNzD76oQtEj8ySV4lyARwHlJ/PMcZu/hxKImqx2wjabxUFSyissIfDt6hM4OdGM1MXzb36ef5BPj9mxO4LArOuYj5DL41QJKyqu/aXL8zps0kLdxmRqfARS8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9lpDUvO; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72b7a53ceb6so2926854a34.0;
        Tue, 22 Apr 2025 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745322630; x=1745927430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfjQMOd5B2EGMHryhC7I69Mb6uAlBkfxyYbc6+DsyU8=;
        b=m9lpDUvOpvQnq35VH/ZiWxAgJ+PhtZ/BZWuvdFe22m1pjlBVT3ALLbMWx+tAQ96bst
         m0yJ3rZluv4OrFoYHQsvrUXrynABzqm7r7+PHHwGgPAIUiZcCfbtcpjyB3c+xr+x1Tn+
         IsXUNl5roSUdumpbP7naodZD7rLpyL085pes6tn9OCulwj5Q82MgkF28R1aqRC+2J4Am
         D0GuJKEirh5dXJtYs7skJcLu5Trvv2AS/w5o4LOhwZhJIC9HNb5s/ms9oTI6xBBLpHCv
         k/Bt7E8buEI8PisiaBHlVQg4We9LvqB0oj9NjCuSTE44y6kPAriH0cw5I/kGmIuf0hHe
         I7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745322630; x=1745927430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfjQMOd5B2EGMHryhC7I69Mb6uAlBkfxyYbc6+DsyU8=;
        b=kn8fOjgrjKg8WDKsqW5s5NaHM74DzeoIIH8mPGlKy6+yNc4sgo3QFdbiYGKFxXgXS8
         LQ0R4JYriS8r664a/t3T9J0ypfqqlINwHpQtEGySDdp58bJi6BuUxd5UsTZ69n/U9Tqb
         dEmqBnq5ZiGlaHXKfztfM78tvvlIGtZ5WvXuaDt1VQu1p0Qqu3ea3LEP+wji/9DJxPPp
         VUjBd2CIxIHNiS3X4eMfnunMEB/+KyFTzZgNcjXnF4n0vfHRUXzuxPI4HAkUZKvFkY7M
         kQC02aSbfoRdhz6apL5DGhC2p7ALDHnLhfIZB6dgY6zNN2OMzGSLbYHBOGHkhYrtnewc
         Cl9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCpp+28qAAA5btxyPOizn9Pm8xCS+ss5nzw0RrN6kpP0zzXCqdG5Oo8WbEjeOTR6Z2BIqKfgHdweXO4XIg@vger.kernel.org, AJvYcCVQw3suP4x5rdIrE6u9XxU4HDreLGF+7yqIiAnwkOn9olRkBYI9gQb22y/dLfuIiiYukXFrP8+VhNs=@vger.kernel.org, AJvYcCWaiCRo+/IuIuBWlO7sTYXWEZm8BXmJxcfqlES5xx7iRfJQe1FI4dxlllMblGDZRjaxUo0g/1bzLE2u@vger.kernel.org, AJvYcCX+Cwh4hBHx0Msut9DVQfNhuqfDhSaLEcCod9dTX5sG5f2lPHJx1FvptBbdXNtDHJyogqia+mRZ27AWrGYyTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0FtNC0/r3A0C6DFhx5DvqLNEN+iK+niwVSGLi3VlAWyUa48x
	MXQ88wL97xmG6Fte0emBEiAVf0p58mole9khwEbHEj4U2DPG1q6k
X-Gm-Gg: ASbGncsJKHGi0Z64KFz79L6mSrjoxNWi9D0hEppVN+lu2qeH9CX3Uk0SkCnOHw8YhsQ
	6b8DyJNDbLK+x0Ag2LV8zEXqoqacQDwgeqg/1cG8nQczrr8L5z85M0V17ItV4FViaoomM/W4xkY
	hzCt8Ksmfx8jJwc40xahcVi8u1f8oU5T8hSHQGzqsusfHS3Q8rVH8v9VfMZNjiZk1rP0jeHThKY
	20DSY0vzpWofyfWoTEDvvW4wzIawhGph9umICGac3TJDyXhQks+9s42FWQo7dWG67DKI3HVUPMA
	qmsgW67Br7uXYt6ab44XVXmi5gb9AJkzqNRaehgFMtZBzx9xMlzGHl9bs5HTHEueDLdyDRQ=
X-Google-Smtp-Source: AGHT+IGaRC6YinLI3INlucgK1D0PGH1/ym+KQ0qnBo+zKkV3J0xgvvFRuT5IfjwCxO5kE0Wba05nHA==
X-Received: by 2002:a05:6830:6686:b0:727:20db:dd5b with SMTP id 46e09a7af769-730034df443mr11234456a34.2.1745322629959;
        Tue, 22 Apr 2025 04:50:29 -0700 (PDT)
Received: from Borg-550.local ([2603:8080:1500:3d89:4c95:a1e3:9428:5d89])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73004884780sm1905980a34.53.2025.04.22.04.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:50:29 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Tue, 22 Apr 2025 06:50:25 -0500
From: John Groves <John@groves.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Luis Henriques <luis@igalia.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 00/19] famfs: port into fuse
Message-ID: <r4njpmpw4mnkzt6msn6k523dcagoi7gulhbvanpht26b3lpvtm@7oroy3y2dr2c>
References: <20250421013346.32530-1-john@groves.net>
 <20250421182758.GJ25659@frogsfrogsfrogs>
 <37ss7esexgblholq5wc5caeizhcjpjhjxsghqjtkxjqri4uxjp@gixtdlggap5i>
 <20250422012537.GL25659@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422012537.GL25659@frogsfrogsfrogs>

On 25/04/21 06:25PM, Darrick J. Wong wrote:
> On Mon, Apr 21, 2025 at 05:00:35PM -0500, John Groves wrote:
> > On 25/04/21 11:27AM, Darrick J. Wong wrote:
> > > On Sun, Apr 20, 2025 at 08:33:27PM -0500, John Groves wrote:
> > > > Subject: famfs: port into fuse
> > > > 
> > > > This is the initial RFC for the fabric-attached memory file system (famfs)
> > > > integration into fuse. In order to function, this requires a related patch
> > > > to libfuse [1] and the famfs user space [2]. 
> > > > 
> > > > This RFC is mainly intended to socialize the approach and get feedback from
> > > > the fuse developers and maintainers. There is some dax work that needs to
> > > > be done before this should be merged (see the "poisoned page|folio problem"
> > > > below).
> > > 
> > > Note that I'm only looking at the fuse and iomap aspects of this
> > > patchset.  I don't know the devdax code at all.
> > > 
> > > > This patch set fully works with Linux 6.14 -- passing all existing famfs
> > > > smoke and unit tests -- and I encourage existing famfs users to test it.
> > > > 
> > > > This is really two patch sets mashed up:
> > > > 
> > > > * The patches with the dev_dax_iomap: prefix fill in missing functionality for
> > > >   devdax to host an fs-dax file system.
> > > > * The famfs_fuse: patches add famfs into fs/fuse/. These are effectively
> > > >   unchanged since last year.
> > > > 
> > > > Because this is not ready to merge yet, I have felt free to leave some debug
> > > > prints in place because we still find them useful; those will be cleaned up
> > > > in a subsequent revision.
> > > > 
> > > > Famfs Overview
> > > > 
> > > > Famfs exposes shared memory as a file system. Famfs consumes shared memory
> > > > from dax devices, and provides memory-mappable files that map directly to
> > > > the memory - no page cache involvement. Famfs differs from conventional
> > > > file systems in fs-dax mode, in that it handles in-memory metadata in a
> > > > sharable way (which begins with never caching dirty shared metadata).
> > > > 
> > > > Famfs started as a standalone file system [3,4], but the consensus at LSFMM
> > > > 2024 [5] was that it should be ported into fuse - and this RFC is the first
> > > > public evidence that I've been working on that.
> > > 
> > > This is very timely, as I just started looking into how I might connect
> > > iomap to fuse so that most of the hot IO path continues to run in the
> > > kernel, and userspace block device filesystem drivers merely supply the
> > > file mappings to the kernel.  In other words, we kick the metadata
> > > parsing craziness out of the kernel.
> > 
> > Coool!
> > 
> > > 
> > > > The key performance requirement is that famfs must resolve mapping faults
> > > > without upcalls. This is achieved by fully caching the file-to-devdax
> > > > metadata for all active files. This is done via two fuse client/server
> > > > message/response pairs: GET_FMAP and GET_DAXDEV.
> > > 
> > > Heh, just last week I finally got around to laying out how I think I'd
> > > want to expose iomap through fuse to allow ->iomap_begin/->iomap_end
> > > upcalls to a fuse server.  Note that I've done zero prototyping but
> > > "upload all the mappings at open time" seems like a reasonable place for
> > > me to start looking, especially for a filesystem with static mappings.
> > > 
> > > I think what I want to try to build is an in-kernel mapping cache (sort
> > > of like the one you built), only with upcalls to the fuse server when
> > > there is no mapping information for a given IO.  I'd probably want to
> > > have a means for the fuse server to put new mappings into the cache, or
> > > invalidate existing mappings.
> > > 
> > > (famfs obviously is a simple corner-case of that grandiose vision, but I
> > > still have a long way to get to my larger vision so don't take my words
> > > as any kind of requirement.)
> > > 
> > > > Famfs remains the first fs-dax file system that is backed by devdax rather
> > > > than pmem in fs-dax mode (hence the need for the dev_dax_iomap fixups).
> > > > 
> > > > Notes
> > > > 
> > > > * Once the dev_dax_iomap patches land, I suspect it may make sense for
> > > >   virtiofs to update to use the improved interface.
> > > > 
> > > > * I'm currently maintaining compatibility between the famfs user space and
> > > >   both the standalone famfs kernel file system and this new fuse
> > > >   implementation. In the near future I'll be running performance comparisons
> > > >   and sharing them - but there is no reason to expect significant degradation
> > > >   with fuse, since famfs caches entire "fmaps" in the kernel to resolve
> > > 
> > > I'm curious to hear what you find, performance-wise. :)
> > > 
> > > >   faults with no upcalls. This patch has a bit too much debug turned on to
> > > >   to that testing quite yet. A branch 
> > > 
> > > A branch ... what?
> > 
> > I trail off sometimes... ;)
> > 
> > > 
> > > > * Two new fuse messages / responses are added: GET_FMAP and GET_DAXDEV.
> > > > 
> > > > * When a file is looked up in a famfs mount, the LOOKUP is followed by a
> > > >   GET_FMAP message and response. The "fmap" is the full file-to-dax mapping,
> > > >   allowing the fuse/famfs kernel code to handle read/write/fault without any
> > > >   upcalls.
> > > 
> > > Huh, I'd have thought you'd wait until FUSE_OPEN to start preloading
> > > mappings into the kernel.
> > 
> > That may be a better approach. Miklos and I discussed it during LPC last year, 
> > and thought both were options. Having implemented it at LOOKUP time, I think
> > moving it to open might avoid my READDIRPLUS problem (which is that RDP is a
> > mashup of READDIR and LOOKUP), therefore might need to add the GET_FMAP
> > payload. Moving GET_FMAP to open time, would break that connection in a good
> > way, I think.
> 
> I wonder if we could just add a couple new "notification" types so that
> the fuse server can initiate uploads of mappings whenever it feels like
> it.  For your usage model I don't think it'll make much difference since
> they seem pretty static, but the ability to do that would open up some
> flexibility for famfs.  The more general filesystems will need it
> anyway, and someone's going to want to truncate a famfs file.  They
> always do. ;)
> 
> > > 
> > > > * After each GET_FMAP, the fmap is checked for extents that reference
> > > >   previously-unknown daxdevs. Each such occurence is handled with a
> > > >   GET_DAXDEV message and response.
> > > 
> > > I hadn't figured out how this part would work for my silly prototype.
> > > Just out of curiosity, does the famfs fuse server hold an open fd to the
> > > storage, in which case the fmap(ping) could just contain the open fd?
> > > 
> > > Where are the mappings that are sent from the fuse server?  Is that
> > > struct fuse_famfs_simple_ext?
> > 
> > See patch 17 or fs/fuse/famfs_kfmap.h for the fmap metadata explanation. 
> > Famfs currently supports either simple extents (daxdev, offset, length) or 
> > interleaved ones (which describe each "strip" as a simple extent). I think 
> > the explanation in famfs_kfmap.h is pretty clear.
> > 
> > A key question is whether any additional basic metadata abstractions would
> > be needed - because the kernel needs to understand the full scheme.
> > 
> > With disaggregated memory, the interleave approach is nice because it gets
> > aggregated performance and resolving a file offset to daxdev offset is order
> > 1.
> > 
> > Oh, and there are two fmap formats (ok, more, but the others are legacy ;).
> > The fmaps-in-messages structs are currently in the famfs section of
> > include/uapi/linux/fuse.h. And the in-memory version is in 
> > fs/fuse/famfs_kfmap.h. The former will need to be a versioned interface.
> > (ugh...)
> 
> Ok, will take a look tomorrow morning.
> 
> > > 
> > > > * Daxdevs are stored in a table (which might become an xarray at some point).
> > > >   When entries are added to the table, we acquire exclusive access to the
> > > >   daxdev via the fs_dax_get() call (modeled after how fs-dax handles this
> > > >   with pmem devices). famfs provides holder_operations to devdax, providing
> > > >   a notification path in the event of memory errors.
> > > > 
> > > > * If devdax notifies famfs of memory errors on a dax device, famfs currently
> > > >   bocks all subsequent accesses to data on that device. The recovery is to
> > > >   re-initialize the memory and file system. Famfs is memory, not storage...
> > > 
> > > Ouch. :)
> > 
> > Cautious initial approach (i.e. I'm trying not to scare people too much ;) 
> > 
> > > 
> > > > * Because famfs uses backing (devdax) devices, only privileged mounts are
> > > >   supported.
> > > > 
> > > > * The famfs kernel code never accesses the memory directly - it only
> > > >   facilitates read, write and mmap on behalf of user processes. As such,
> > > >   the RAS of the shared memory affects applications, but not the kernel.
> > > > 
> > > > * Famfs has backing device(s), but they are devdax (char) rather than
> > > >   block. Right now there is no way to tell the vfs layer that famfs has a
> > > >   char backing device (unless we say it's block, but it's not). Currently
> > > >   we use the standard anonymous fuse fs_type - but I'm not sure that's
> > > >   ultimately optimal (thoughts?)
> > > 
> > > Does it work if the fusefs server adds "-o fsname=<devdax cdev>" to the
> > > fuse_args object?  fuse2fs does that, though I don't recall if that's a
> > > reasonable thing to do.
> > 
> > The kernel needs to "own" the dax devices. fs-dax on pmem/block calls
> > fs_dax_get_by_bdev() and passes in holder_operations - which are used for
> > error upcalls, but also effect exclusive ownership. 
> > 
> > I added fs_dax_get() since the bdev version wasn't really right or char
> > devdax. But same holder_operations.
> > 
> > I had originally intended to pass in "-o daxdev=<cdev>", but famfs needs to
> > span multiple daxdevs, in order to interleave for performance. The approach
> > of retrieving them with GET_DAXDEV handles the generalized case, so "-o"
> > just amounts to a second way to do the same thing.
> 
> Oh, hah, it's a multi-device filesystem.  Hee hee hee...

Hee hee indeed. The thing about memory, and dax devices, is that there
isn't anything like device mapper that can make compound or interleaved
devices. There's not a "stop while dma happens" point for swizzling 
addresses. I'm down for a discussion about whether there is a viable way 
to have a mapper layer, but I also think constructing interleaved objects 
as files is quite good - and might be the best solution.

Interleaving is essential to memory performance in general. System-ram is
pretty much never not interleaved. And there are some reasons why programming
the hardware to do the interleaving is gonna be problem for non-static 
setups. I'll save going down that rathole for a different time...

John

