Return-Path: <linux-fsdevel+bounces-55465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B98CEB0AA4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A41AA7FC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3439F2E6D00;
	Fri, 18 Jul 2025 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF7RM7ow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9A16DEB3
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864412; cv=none; b=LWd43ivUFBKZzh7sf8EdkpcT3uo6f95KpTUeKjE9wWmRUJ4lXvDHsSGzDNdYKxxUEA7rl2Fju1yag2wiUKUKZooLn1PJzwdFgnXqo8tkD6IqXRbNvVldL3p4cGMtOQfzCBLFQxiiH/xIOvflj/P5FjD4oiS6jp6581AwljAiO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864412; c=relaxed/simple;
	bh=P4DshfTPS/ssDd75WeiXE/ubaonuESZWz5Sax2N6pQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9+pxydGgFh5T84geJvS07/Jqb4aZMfzikJpfqTJu5dno+DCi9acP94BQJUHFvamHZZw+zS4sBcuEKRwMwHXo7FhrSqvX9YKaHlQlaTCBj8c2411b2wtsNdSMZnw/Ks5t6lNsUU8Y5WlMXSFjwGMjHFua9WNXey+AfJg+78T6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF7RM7ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3916CC4CEEB;
	Fri, 18 Jul 2025 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864412;
	bh=P4DshfTPS/ssDd75WeiXE/ubaonuESZWz5Sax2N6pQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RF7RM7owBQ3wh4wQJyJV+NRP3DnJQqOBocUO9mxhVKVy+eYg4oA89Jc11KbwmBvlw
	 Y8kd4HfU28+37W6YX/Mbtdy2FJB6A0uCvjviHK4LFdT7UC/tamDA2wXe2rhR0M/sou
	 l2ShNNcj3aIJAnKCFQyCzXHBFMmg2S5DoAKXvqPEeLk0YGLKt4oFxieA+lsFbu4X+/
	 BtOKZjIMt7ggj5ZF26ZgCsVUdCl4a0IJ79TzctBeayufrPq0iEvgLTYfVhs54KdJAf
	 Zn4b7V3rrDPmpZX7Zq7QFcfsKZxFaijih2KtfBMG/+1wcBmToBNE77IKJNmdmfjB8u
	 G1IaWe7Mj0+5g==
Date: Fri, 18 Jul 2025 11:46:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	neal@gompa.dev, John@groves.net, miklos@szeredi.hu,
	joannelkoong@gmail.com
Subject: Re: [PATCH 06/13] fuse: implement buffered IO with iomap
Message-ID: <20250718184651.GB2672029@frogsfrogsfrogs>
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
 <175279450066.711291.11325657475144563199.stgit@frogsfrogsfrogs>
 <CAOQ4uxjfTp0My7xv39BA1_nD95XLQd-TqERAMG-C4V3UFYpX8w@mail.gmail.com>
 <20250718180121.GV2672029@frogsfrogsfrogs>
 <9ffc3eb8-c0ef-42ae-9d66-2a2b5d0e9197@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ffc3eb8-c0ef-42ae-9d66-2a2b5d0e9197@bsbernd.com>

On Fri, Jul 18, 2025 at 08:39:18PM +0200, Bernd Schubert wrote:
> 
> 
> On 7/18/25 20:01, Darrick J. Wong wrote:
> > On Fri, Jul 18, 2025 at 05:10:14PM +0200, Amir Goldstein wrote:
> >> On Fri, Jul 18, 2025 at 1:32 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >>>
> >>> From: Darrick J. Wong <djwong@kernel.org>
> >>>
> >>> Implement pagecache IO with iomap, complete with hooks into truncate and
> >>> fallocate so that the fuse server needn't implement disk block zeroing
> >>> of post-EOF and unaligned punch/zero regions.
> >>>
> >>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >>> ---
> >>>  fs/fuse/fuse_i.h          |   46 +++
> >>>  fs/fuse/fuse_trace.h      |  391 ++++++++++++++++++++++++
> >>>  include/uapi/linux/fuse.h |    5
> >>>  fs/fuse/dir.c             |   23 +
> >>>  fs/fuse/file.c            |   90 +++++-
> >>>  fs/fuse/file_iomap.c      |  723 +++++++++++++++++++++++++++++++++++++++++++++
> >>>  fs/fuse/inode.c           |   14 +
> >>>  7 files changed, 1268 insertions(+), 24 deletions(-)
> >>>
> >>>
> >>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> >>> index 67e428da4391aa..f33b348d296d5e 100644
> >>> --- a/fs/fuse/fuse_i.h
> >>> +++ b/fs/fuse/fuse_i.h
> >>> @@ -161,6 +161,13 @@ struct fuse_inode {
> >>>
> >>>                         /* waitq for direct-io completion */
> >>>                         wait_queue_head_t direct_io_waitq;
> >>> +
> >>> +#ifdef CONFIG_FUSE_IOMAP
> >>> +                       /* pending io completions */
> >>> +                       spinlock_t ioend_lock;
> >>> +                       struct work_struct ioend_work;
> >>> +                       struct list_head ioend_list;
> >>> +#endif
> >>>                 };
> >>
> >> This union member you are changing is declared for
> >> /* read/write io cache (regular file only) */
> >> but actually it is also for parallel dio and passthrough mode
> >>
> >> IIUC, there should be zero intersection between these io modes and
> >>  /* iomap cached fileio (regular file only) */
> >>
> >> Right?
> > 
> > Right.  iomap will get very very confused if you switch file IO paths on
> > a live file.  I think it's /possible/ to switch if you flush and
> > truncate the whole page cache while holding inode_lock() but I don't
> > think anyone has ever tried.
> > 
> >> So it can use its own union member without increasing fuse_inode size.
> >>
> >> Just need to be carefull in fuse_init_file_inode(), fuse_evict_inode() and
> >> fuse_file_io_release() which do not assume a specific inode io mode.
> > 
> > Yes, I think it's possible to put the iomap stuff in a separate struct
> > within that union so that we're not increasing the fuse_inode size
> > unnecessarily.  That's desirable for something to do before merging,
> > but for now prototyping is /much/ easier if I don't have to do that.
> > 
> > Making that change will require a lot of careful auditing, first I want
> > to make sure you all agree with the iomap approach because it's much
> > different from what I see in the other fuse IO paths. :)
> > 
> > Eeeyiks, struct fuse_inode shrinks from 1272 bytes to 1152 if I push the
> > iomap stuff into its own union struct.
> > 
> >> Was it your intention to allow filesystems to configure some inodes to be
> >> in file_iomap mode and other inodes to be in regular cached/direct/passthrough
> >> io modes?
> > 
> > That was a deliberate design decision on my part -- maybe a fuse server
> > would be capable of serving up some files from a local disk, and others
> > from (say) a network filesystem.  Or maybe it would like to expose an
> > administrative fd for the filesystem (like the xfs_healer event stream)
> > that isn't backed by storage.
> > 
> >> I can't say that I see a big benefit in allowing such setups.
> >> It certainly adds a lot of complication to the test matrix if we allow that.
> >> My instinct is for initial version, either allow only opening files in
> >> FILE_IOMAP or
> >> DIRECT_IOMAP to inodes for a filesystem that supports those modes.
> > 
> > I was thinking about combining FUSE_ATTR_IOMAP_(DIRECTIO|FILEIO) for the
> > next RFC because I can't imagine any scenario where you don't want
> > directio support if you already use iomap for the pagecache.  fuse iomap
> > requires directio write support for writeback, so the server *must*
> > support IOMAP_WRITE|IOMAP_DIRECT.
> > 
> >> Perhaps later we can allow (and maybe fallback to) FOPEN_DIRECT_IO
> >> (without parallel dio) if a server does not configure IOMAP to some inode
> >> to allow a server to provide the data for a specific inode directly.
> > 
> > Hrmm.  Is FOPEN_DIRECT_IO the magic flag that fuse passes to the fuse
> > server to tell it that a file is open in directio mode?  There's a few
> > fstests that initiate aio+dio writes to a dm-error device that currently
> > fail in non-iomap mode because fuse2fs writes everything to the bdev
> > pagecache.
> 
> 
> The other way around, FOPEN_DIRECT_IO is a flag that fuse-server tells
> the kernel that it wants to bypass the page cache. And also allows
> parallel DIO IO (shared vs exclusive lock).

Oh ok.  iomap supports parallel directio writes, but one has to be
careful to drop to synchronous mode for file extending and unaligned
writes so I've left it out of the prototype for now.  (Parallel reads
are supported by default.)

Hrmm I'll have to study these more...

--D

> 
> Thanks,
> Bernd
> 

