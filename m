Return-Path: <linux-fsdevel+bounces-55476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FE6B0AB11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2347E1C24EDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A74221ABDB;
	Fri, 18 Jul 2025 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfzvuDL4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3621A436
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870048; cv=none; b=R5YZZnxouuINVsVo+5MsKKfmXiyJK6542qZbHWQstrYvpfdYQDcWKCiv8jmbAOmyOGUY07pM4RUiN+F2+qmWP4b7tkSHX+aShLnMzvi1p3uXbLmUgq2PLR/hZVU0MFVZo7hvoUwNDEKglMXsPJJM9xT75tkYXchAqCxDVpGyG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870048; c=relaxed/simple;
	bh=u9OLdloI4SpYJdWlLI7xxNVmOQ9XLMz72Vv2wVwnln8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXKt8lyEKpcYbGNfHdLJ+YEWGaYmSrW/GgT/WgL3/Gft7x+kYA7uhrFgYyk6KcDIOGZfAxnHu1DmNb3KJUTTDJOTwX3VUgkWJPn44agirSplKwvjh7gwpFQlCgmm17l379YzKdPz9mezQFB3bCCSKFvbg1fJxJXuwByACslKrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfzvuDL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D69C4CEEB;
	Fri, 18 Jul 2025 20:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752870048;
	bh=u9OLdloI4SpYJdWlLI7xxNVmOQ9XLMz72Vv2wVwnln8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfzvuDL4YMi211yRKFuuK3lzihtt8JhBZajxJgKLfl0xREGCesR0uJxndRG5Ep06j
	 LuJGXtJCzcVvf/h/j12pyREnfmgpAwpOVWenJCRNJZeCE3QIQNtMMPEYnU2zhVl3ty
	 OeuQbE9C+2MdMAhKPK+SnyKDSOZPKV+2AXGrwvGZf2cUKn0RCGuEMunnkFGf3j69t5
	 pCgiP9yZqecHQrWcWv6tl0Rm7bIYxiS+iMSLmyUjFj/Zch5em5qoqejrpHFcyH277l
	 arGlXsuRxHN/Ch56w8VFrh8Lqg0xHnNwjvD7TprH9ywBw8F/VCOI+9UpgHQz79CKNt
	 F+Gp1c3s/h8bA==
Date: Fri, 18 Jul 2025 13:20:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 06/13] fuse: implement buffered IO with iomap
Message-ID: <20250718202046.GE2672029@frogsfrogsfrogs>
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
 <175279450066.711291.11325657475144563199.stgit@frogsfrogsfrogs>
 <CAOQ4uxjfTp0My7xv39BA1_nD95XLQd-TqERAMG-C4V3UFYpX8w@mail.gmail.com>
 <20250718180121.GV2672029@frogsfrogsfrogs>
 <CAOQ4uxjBhFeksGKpvpSb0qzaOP=zzwQSRGPjb4JRAytnTDQrXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjBhFeksGKpvpSb0qzaOP=zzwQSRGPjb4JRAytnTDQrXg@mail.gmail.com>

On Fri, Jul 18, 2025 at 09:45:17PM +0200, Amir Goldstein wrote:
> On Fri, Jul 18, 2025 at 8:01 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Jul 18, 2025 at 05:10:14PM +0200, Amir Goldstein wrote:
> > > On Fri, Jul 18, 2025 at 1:32 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > Implement pagecache IO with iomap, complete with hooks into truncate and
> > > > fallocate so that the fuse server needn't implement disk block zeroing
> > > > of post-EOF and unaligned punch/zero regions.
> > > >
> > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > ---
> > > >  fs/fuse/fuse_i.h          |   46 +++
> > > >  fs/fuse/fuse_trace.h      |  391 ++++++++++++++++++++++++
> > > >  include/uapi/linux/fuse.h |    5
> > > >  fs/fuse/dir.c             |   23 +
> > > >  fs/fuse/file.c            |   90 +++++-
> > > >  fs/fuse/file_iomap.c      |  723 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  fs/fuse/inode.c           |   14 +
> > > >  7 files changed, 1268 insertions(+), 24 deletions(-)
> > > >
> > > >
> > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > index 67e428da4391aa..f33b348d296d5e 100644
> > > > --- a/fs/fuse/fuse_i.h
> > > > +++ b/fs/fuse/fuse_i.h
> > > > @@ -161,6 +161,13 @@ struct fuse_inode {
> > > >
> > > >                         /* waitq for direct-io completion */
> > > >                         wait_queue_head_t direct_io_waitq;
> > > > +
> > > > +#ifdef CONFIG_FUSE_IOMAP
> > > > +                       /* pending io completions */
> > > > +                       spinlock_t ioend_lock;
> > > > +                       struct work_struct ioend_work;
> > > > +                       struct list_head ioend_list;
> > > > +#endif
> > > >                 };
> > >
> > > This union member you are changing is declared for
> > > /* read/write io cache (regular file only) */
> > > but actually it is also for parallel dio and passthrough mode
> > >
> > > IIUC, there should be zero intersection between these io modes and
> > >  /* iomap cached fileio (regular file only) */
> > >
> > > Right?
> >
> > Right.  iomap will get very very confused if you switch file IO paths on
> > a live file.  I think it's /possible/ to switch if you flush and
> > truncate the whole page cache while holding inode_lock() but I don't
> > think anyone has ever tried.
> >
> > > So it can use its own union member without increasing fuse_inode size.
> > >
> > > Just need to be carefull in fuse_init_file_inode(), fuse_evict_inode() and
> > > fuse_file_io_release() which do not assume a specific inode io mode.
> >
> > Yes, I think it's possible to put the iomap stuff in a separate struct
> > within that union so that we're not increasing the fuse_inode size
> > unnecessarily.  That's desirable for something to do before merging,
> > but for now prototyping is /much/ easier if I don't have to do that.
> >
> 
> understood. you can deal with that later. I just wanted to leave a TODO note.

<nod> I'll leave an XXX comment then.

> > Making that change will require a lot of careful auditing, first I want
> > to make sure you all agree with the iomap approach because it's much
> > different from what I see in the other fuse IO paths. :)
> >
> 
> Indeed a good audit will be required, but
> *if* you can guarantee to configure iomap alway at inode initiation
> then in fuse_init_file_inode() it is clear, which member of the union
> is being initialized and this mode has to stick with the inode until
> evict anyway.
> 
> So basically, all you need to do is never allow configuring iomap on an
> already initialized inode.

Right.  iomap has to be initialized at INEW time and cannot be changed.

> > Eeeyiks, struct fuse_inode shrinks from 1272 bytes to 1152 if I push the
> > iomap stuff into its own union struct.
> >
> > > Was it your intention to allow filesystems to configure some inodes to be
> > > in file_iomap mode and other inodes to be in regular cached/direct/passthrough
> > > io modes?
> >
> > That was a deliberate design decision on my part -- maybe a fuse server
> > would be capable of serving up some files from a local disk, and others
> > from (say) a network filesystem.  Or maybe it would like to expose an
> > administrative fd for the filesystem (like the xfs_healer event stream)
> > that isn't backed by storage.
> >
> 
> Understood.
> 
> But the filesystem should be able to make the decision on inode
> initiation time (lookup)
> and once made, this decision sticks throughout the inode lifetime. Right?

Correct.

> > > I can't say that I see a big benefit in allowing such setups.
> > > It certainly adds a lot of complication to the test matrix if we allow that.
> > > My instinct is for initial version, either allow only opening files in
> > > FILE_IOMAP or
> > > DIRECT_IOMAP to inodes for a filesystem that supports those modes.
> >
> > I was thinking about combining FUSE_ATTR_IOMAP_(DIRECTIO|FILEIO) for the
> > next RFC because I can't imagine any scenario where you don't want
> > directio support if you already use iomap for the pagecache.  fuse iomap
> > requires directio write support for writeback, so the server *must*
> > support IOMAP_WRITE|IOMAP_DIRECT.
> >
> > > Perhaps later we can allow (and maybe fallback to) FOPEN_DIRECT_IO
> > > (without parallel dio) if a server does not configure IOMAP to some inode
> > > to allow a server to provide the data for a specific inode directly.
> >
> > Hrmm.  Is FOPEN_DIRECT_IO the magic flag that fuse passes to the fuse
> > server to tell it that a file is open in directio mode?  There's a few
> > fstests that initiate aio+dio writes to a dm-error device that currently
> > fail in non-iomap mode because fuse2fs writes everything to the bdev
> > pagecache.
> >
> 
> Not exactly, but nevermind, you can use a much simpler logic for what
> you described:
> iomap has to be configured on inode instantiation and never changed afterwards.
> Other inodes are not going to be affected by iomap at all from that point on.

<nod>

> > > fuse_file_io_open/release() can help you manage those restrictions and
> > > set ff->iomode = IOM_FILE_IOMAP when a file is opened for file iomap.
> > > I did not look closely enough to see if file_iomap code ends up setting
> > > ff->iomode = IOM_CACHED/UNCACHED or always remains IOM_NONE.
> >
> > I don't touch ff->iomode because iomap is a per-inode property, not a
> > per-file property... but I suppose that would be a good place to look.
> >
> 
> Right, with cached/direct/passthrough the inode may change the iomode
> after all files are closed, but we *do* keep the mode in the inode,
> so we know that files cannot be opened in conflicting modes on the same inode.
> 
> The purpose of ff->iomode is to know if the file contributes to cached mode
> positive iocachectr or to a negative passthrough mode refcount.
> 
> So setting ff->iomode = IOM_IOMAP just helps for annotating how the
> file was opened, in case we are tracing it. There is no functional need to
> define and set this mode on the file when the mode of the inode is const.

Ah ok.  I'll go add that for the next rfc, thanks!

--D

> Thanks,
> Amir.
> 

