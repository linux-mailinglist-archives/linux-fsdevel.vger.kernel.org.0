Return-Path: <linux-fsdevel+bounces-50080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B8DAC8120
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CB13AB76A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A722F755;
	Thu, 29 May 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeeO2kyE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29422A7EC;
	Thu, 29 May 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537105; cv=none; b=kKokjgNwmdnI+s/kSkibaP6edrfsPP4Ne36162X1dakJHa4HKUQann++TsYa26XMPVpYzWv+bgettjUbT596peqgfPocsYeodKAbDVkg5cnq1AhYTXNgJ8Yi28yhu+qPTDYJbPog6fnY6UkdwwzvTDw+yWkSLurTwwLv0hVtkkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537105; c=relaxed/simple;
	bh=yc6LBxN+Q8vbkSFlcCBoqnAdoFeHw0M/YuyhY3cQPjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyWqbIs0nONLf25Gjkt9KHC3pVriXUe2yomzPYX/vAGKY6NOQBPOK0/XKfrp5TXabqCB7A0hJlw31DnwY0kihqu+86pfCmpqDY7K+kI0TFM94VU7h8dHLPjBtW7hEQxPRQgf7b8LMSSbs4B4tq09EGfgJf4WA2LWEBQrlvg1oFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeeO2kyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A19EC4CEE7;
	Thu, 29 May 2025 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748537104;
	bh=yc6LBxN+Q8vbkSFlcCBoqnAdoFeHw0M/YuyhY3cQPjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EeeO2kyEiQH1hR2Z+kweTObJLZydUchUBc+xi1yHBKegyvW4CRIsGalCETNNy6Oix
	 Iq6xjHtCE842/LdjxUtDEODh+ULo+KMrVnMvUNrf5dfLziSAW5BuV9SIb8LZEguQFH
	 xlWVnUfvakegPG+6L/UwZ4wnHL27G6dIwHCqWRxzeRpK5dZTN8xpxQ5vq4rIRHg/6L
	 hElcavrCMVqONyPvkieQLao36c66kWwLhR61RwGk1IAuQu7ITLKMPlceqOiGhXSAMK
	 nEiv7a9w8bs/xCdS6DliNL1rG1ThuRFipGgLgbXLKpzp1IUAGuGzSHu4WQ0ombR3ft
	 eZ3jqlCmTZemw==
Date: Thu, 29 May 2025 09:45:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net,
	bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250529164503.GB8282@frogsfrogsfrogs>
References: <20250521235837.GB9688@frogsfrogsfrogs>
 <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>

On Thu, May 22, 2025 at 06:24:50PM +0200, Amir Goldstein wrote:
> On Thu, May 22, 2025 at 1:58 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Hi everyone,
> >
> > DO NOT MERGE THIS.
> >
> > This is the very first request for comments of a prototype to connect
> > the Linux fuse driver to fs-iomap for regular file IO operations to and
> > from files whose contents persist to locally attached storage devices.
> >
> > Why would you want to do that?  Most filesystem drivers are seriously
> > vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
> > over almost a decade of its existence.  Faulty code can lead to total
> > kernel compromise, and I think there's a very strong incentive to move
> > all that parsing out to userspace where we can containerize the fuse
> > server process.
> >
> > willy's folios conversion project (and to a certain degree RH's new
> > mount API) have also demonstrated that treewide changes to the core
> > mm/pagecache/fs code are very very difficult to pull off and take years
> > because you have to understand every filesystem's bespoke use of that
> > core code.  Eeeugh.
> >
> > The fuse command plumbing is very simple -- the ->iomap_begin,
> > ->iomap_end, and iomap ioend calls within iomap are turned into upcalls
> > to the fuse server via a trio of new fuse commands.  This is suitable
> > for very simple filesystems that don't do tricky things with mappings
> > (e.g. FAT/HFS) during writeback.  This isn't quite adequate for ext4,
> > but solving that is for the next sprint.
> >
> > With this overly simplistic RFC, I am to show that it's possible to
> > build a fuse server for a real filesystem (ext4) that runs entirely in
> > userspace yet maintains most of its performance.  At this early stage I
> > get about 95% of the kernel ext4 driver's streaming directio performance
> > on streaming IO, and 110% of its streaming buffered IO performance.
> > Random buffered IO suffers a 90% hit on writes due to unwritten extent
> > conversions.  Random direct IO is about 60% as fast as the kernel; see
> > the cover letter for the fuse2fs iomap changes for more details.
> >
> 
> Very cool!
> 
> > There are some major warts remaining:
> >
> > 1. The iomap cookie validation is not present, which can lead to subtle
> > races between pagecache zeroing and writeback on filesystems that
> > support unwritten and delalloc mappings.
> >
> > 2. Mappings ought to be cached in the kernel for more speed.
> >
> > 3. iomap doesn't support things like fscrypt or fsverity, and I haven't
> > yet figured out how inline data is supposed to work.
> >
> > 4. I would like to be able to turn on fuse+iomap on a per-inode basis,
> > which currently isn't possible because the kernel fuse driver will iget
> > inodes prior to calling FUSE_GETATTR to discover the properties of the
> > inode it just read.
> 
> Can you make the decision about enabling iomap on lookup?
> The plan for passthrough for inode operations was to allow
> setting up passthough config of inode on lookup.

The main requirement (especially for buffered IO) is that we've set the
address space operations structure either to the regular fuse one or to
the fuse+iomap ops before clearing INEW because the iomap/buffered-io.c
code assumes that cannot change on a live inode.

So I /think/ we could ask the fuse server at inode instantiation time
(which, if I'm reading the code correctly, is when iget5_locked gives
fuse an INEW inode and calls fuse_init_inode) provided it's ok to upcall
to userspace at that time.  Alternately I guess we could extend struct
fuse_attr with another FUSE_ATTR_ flag, I think?

> > 5. ext4 doesn't support out of place writes so I don't know if that
> > actually works correctly.
> >
> > 6. iomap is an inode-based service, not a file-based service.  This
> > means that we /must/ push ext2's inode numbers into the kernel via
> > FUSE_GETATTR so that it can report those same numbers back out through
> > the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate nodeid
> > to index its incore inode, so we have to pass those too so that
> > notifications work properly.
> >
> 
> Again, I might be missing something, but as long as the fuse filesystem
> is exposing a single backing filesystem, it should be possible to make
> sure (via opt-in) that fuse nodeid's are equivalent to the backing fs
> inode number.
> See sketch in this WIP branch:
> https://github.com/amir73il/linux/commit/210f7a29a51b085ead9f555978c85c9a4a503575

I think this would work in many places, except for filesystems with
64-bit inumbers on 32-bit machines.  That might be a good argument for
continuing to pass along the nodeid and fuse_inode::orig_ino like it
does now.  Plus there are some filesystems that synthesize inode numbers
so tying the two together might not be feasible/desirable anyway.

Though one nice feature of letting fuse have its own nodeids might be
that if the in-memory index switches to a tree structure, then it could
be more compact if the filesystem's inumbers are fairly sparse like xfs.
OTOH the current inode hashtable has been around for a very long time so
that might not be a big concern.  For fuse2fs it doesn't matter since
ext4 inumbers are u32.

--D

> 
> Thanks,
> Amir.
> 

