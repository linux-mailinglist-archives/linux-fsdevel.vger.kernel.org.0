Return-Path: <linux-fsdevel+bounces-6471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEF38180E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 06:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE91B23C20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 05:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F243C2C7;
	Tue, 19 Dec 2023 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohRP4t7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD5C123;
	Tue, 19 Dec 2023 05:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE39C433C8;
	Tue, 19 Dec 2023 05:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702962896;
	bh=pKrAPeWa7h9TShAmcrc1uzA+67RsLTGQHDug+VgYEk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohRP4t7WnPr7QVLmt6ZHm0kwT8Ifo27kX7v93NOpKUA5iieJYqKKpSdNuvtfd19h4
	 s/DklAeZt3ugeXrPpqjNN/axocYeLZlhA7857D2nBr1FTnsIDtp8FtLZyDE/fAwQNL
	 ElxCwSNiU3GC7nLQjghVBiz77BV2G0od8Uwt6ak2FpKTp3o5C9sjtkhACcaY7+GWRt
	 oBVgJEmJJAhS1A9xeTyE4QgWokYDw8i2NP6vsR8GdlCFsXve6vU1DgRIsvD9GxLVKP
	 7fOvzuvVgCUh/NSlD3PlEHhuDKjRlkEzT2cuMq8FlLzTdXnAdgvKnU67EGwquv3+IF
	 3lNNCCon6+i6A==
Date: Mon, 18 Dec 2023 21:14:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231219051456.GB3964019@frogsfrogsfrogs>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212163246.GA24594@lst.de>
 <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
 <20231213154409.GA7724@lst.de>
 <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>

On Wed, Dec 13, 2023 at 04:27:35PM +0000, John Garry wrote:
> On 13/12/2023 15:44, Christoph Hellwig wrote:
> > On Wed, Dec 13, 2023 at 09:32:06AM +0000, John Garry wrote:
> > > > > - How to make API extensible for when we have no HW support? In that case,
> > > > >     we would prob not have to follow rule of power-of-2 length et al.
> > > > >     As a possible solution, maybe we can say that atomic writes are
> > > > >     supported for the file via statx, but not set unit_min and max values,
> > > > >     and this means that writes need to be just FS block aligned there.
> > > > I don't think the power of two length is much of a problem to be
> > > > honest, and if we every want to lift it we can still do that easily
> > > > by adding a new flag or limit.
> > > ok, but it would be nice to have some idea on what that flag or limit
> > > change would be.
> > That would require a concrete use case.  The simples thing for a file
> > system that can or does log I/O it would simply be a flag waving all
> > the alignment and size requirements.
> 
> ok...
> 
> > 
> > > > I suspect we need an on-disk flag that forces allocations to be
> > > > aligned to the atomic write limit, in some ways similar how the
> > > > XFS rt flag works.  You'd need to set it on an empty file, and all
> > > > allocations after that are guaranteed to be properly aligned.
> > > Hmmm... so how is this different to the XFS forcealign feature?
> > Maybe not much.  But that's not what it is about - we need a common
> > API for this and not some XFS internal flag.  So if this is something
> > we could support in ext4 as well that would be a good step.  And for
> > btrfs you'd probably want to support something like it in nocow mode
> > if people care enough, or always support atomics and write out of
> > place.
> 
> The forcealign feature was a bit of case of knowing specifically what to do
> for XFS to enable atomic writes.
> 
> But some common method to configure any FS file for atomic writes (if
> supported) would be preferable, right?

/me stumbles back in with plenty of covidbrain to go around.

So ... Christoph, you're asking for a common API for
sysadmins/applications to signal to the filesystem that they want all
data allocations aligned to a given value, right?

e.g. if a nvme device advertises a capability for untorn writes between
$lbasize and 64k, then we need a way to set up each untorn-file with
some alignment between $lbasize and 64k?

or if cxl storage becomes not ung-dly expensive, then we'd want a way to
set up files with an alignment of 2M (x86) or 512M (arm64lol) to take
advantage of PMD mmap mappings?

I guess we could define a fsxattr xflag for FORCEALIGN and declare that
the fsx_extsize field becomes mandates mapping startoff/startblock
alignment if FORCEALIGN is set.

It just happens that since fsxattr comes from XFS then it'll be easy
enough for us to wire that up.  Maybe.

Concretely, xfs would have to have a way to force the
ag/rtgroup/rtextent size to align with the maximum anticipated required
alignment (e.g. 64k) of the device so that groups (and hence per-group
allocations) don't split the alignment.  xfs would also have need to
constrain the per-inode alignment to some factor of the ag size / rt
extent size.

Writing files could use hw acceleration directly if all the factors are
set up correctly; or fall back to COW.  Assuming there's a way to
require that writeback pick up all the folios in a $forcealign chunk for
simultaneous writeout.  (I think this is a lingering bug in the xfs
rtreflink patchset.)  Also, IIRC John mentioned that there might be some
programs that would rather get an EIO than fall back to COW.

ext4 could maybe sort of do this by allowing forcealign alignments up to
the bigalloc size, if bigalloc is enabled.  Assuming bigalloc isn't DOA.
IIRC bigalloc only supports power of 2 factors.  It wouldn't have the
COW problem because it only supports overwrites.

As usual, I dunno about btrfs.

So does that sound like more or less what you're getting at, Christoph?
Or have I misread the entire thing?  (PS: there's been like 1200 fsdevel
messages since I got sick and I've only had sufficient brainpower to
limp the xfs 6.8 patches across the finish line...)

--D

> > 
> > > For XFS, I thought that your idea was to always CoW new extents for
> > > misaligned extents or writes which spanned multiple extents.
> > Well, that is useful for two things:
> > 
> >   - atomic writes on hardware that does not support it
> >   - atomic writes for bufferd I/O
> >   - supporting other sizes / alignments than the strict power of
> >     two above.
> 
> Sure
> 
> > 
> > > Right, so we should limit atomic write queue limits to max_hw_sectors. But
> > > people can still tweak max_sectors, and I am inclined to say that
> > > atomic_write_unit_max et al should be (dynamically) limited to max_sectors
> > > also.
> > Allowing people to tweak it seems to be asking for trouble.
> 
> I tend to agree....
> 
> Let's just limit at max_hw_sectors.
> 
> > 
> > > > have that silly limit.  For NVMe that would require SGL support
> > > > (and some driver changes I've been wanting to make for long where
> > > > we always use SGLs for transfers larger than a single PRP if supported)
> > > If we could avoid dealing with a virt boundary, then that would be nice.
> > > 
> > > Are there any patches yet for the change to always use SGLs for transfers
> > > larger than a single PRP?
> > No.
> 
> As below, if we are going to enforce alignment/size of iovecs elsewhere,
> then I don't need to worry about virt boundary.
> 
> > 
> > > On a related topic, I am not sure about how - or if we even should -
> > > enforce iovec PAGE-alignment or length; rather, the user could just be
> > > advised that iovecs must be PAGE-aligned and min PAGE length to achieve
> > > atomic_write_unit_max.
> > Anything that just advices the user an it not clear cut and results in
> > an error is data loss waiting to happen.  Even more so if it differs
> > from device to device.
> 
> ok, fine. I suppose that we better enforce it then.
> 
> Thanks,
> John
> 

