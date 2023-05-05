Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8A6F8C53
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 00:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjEEWXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 18:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEEWXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 18:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1844EED;
        Fri,  5 May 2023 15:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87916414B;
        Fri,  5 May 2023 22:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA69EC433D2;
        Fri,  5 May 2023 22:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683325414;
        bh=itOhcWtT9F2Ty9bRfFR/TEHVNbHJczWFq8/D70MbB2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JiZqzOAPObZA0lTQiV84hLIrX1srcL0RAZuBGZ9t8dMD0bSrL8C1fgaVF54Wp2qNw
         ZUbFazJmC310S5FsRs8FBRpFI+87VG1x2RIliHp0zgMjg92U2+JPbrOGuUKuxLYwLB
         n64o9x/7U/DzVxtapQM6lXmU9gWMIuJC3cMDnh20fmQLOd3lS2fMAZBh2ozs5nNlMc
         6JhHkUVdhI878PYHwuAvL1ArhZ5PfJoG6rR8eAC5qEP9i5iqbWjQhrSdzqq5l2q1tx
         FNZtYRXP78zoaYdi+uXuh6Ggb030d3OF/lP+B8K62xsVJppQDjcZ1K2mbO09/ovplH
         YHij5S86gJORA==
Date:   Fri, 5 May 2023 15:23:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Allison Henderson <allison.henderson@oracle.com>,
        Catherine Hoang <catherine.hoang@oracle.com>
Subject: Re: [PATCH RFC 12/16] xfs: Add support for fallocate2
Message-ID: <20230505222333.GM15394@frogsfrogsfrogs>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-13-john.g.garry@oracle.com>
 <20230503232616.GG3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503232616.GG3223426@dread.disaster.area>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 09:26:16AM +1000, Dave Chinner wrote:
> On Wed, May 03, 2023 at 06:38:17PM +0000, John Garry wrote:
> > From: Allison Henderson <allison.henderson@oracle.com>
> > 
> > Add support for fallocate2 ioctl, which is xfs' own version of fallocate.
> > Struct xfs_fallocate2 is passed in the ioctl, and xfs_fallocate2.alignment
> > allows the user to specify required extent alignment. This is key for
> > atomic write support, as we expect extents to be aligned on
> > atomic_write_unit_max boundaries.
> 
> This approach of adding filesystem specific ioctls for minor behavioural
> modifiers to existing syscalls is not a sustainable development
> model.

To be fair to John and Allison, I told them to shove all the new UAPI
bits into a xfs_fs_staging.h because of that conversation you and
Catherine and I had a month or two ago (the fsuuid ioctls) about putting
new interfaces in an obviously marked staging file, using that to
prototype and discover the interface that we really wanted, and only
then talk about hoisting it to the VFS.

Hence this fallocate2 because we weren't sure if syscalls for aligned
allocations should explicitly define the alignment or get it from the
extent size hint, if there should be an explicit flag mandating aligned
allocation, etc.

> If we want fallocate() operations to apply filesystem atomic write
> constraints to operations, then add a new modifier flag to
> fallocate(), say FALLOC_FL_ATOMIC. The filesystem can then
> look up it's atomic write alignment constraints and apply them to
> the operation being performed appropriately.
> 
> > The alignment flag is not sticky, so further extent mutation will not
> > obey this original alignment request.
> 
> IOWs, you want the specific allocation to behave exactly as if an
> extent size hint of the given alignment had been set on that inode.
> Which could be done with:
> 
> 	ioctl(FS_IOC_FSGETXATTR, &fsx)
> 	old_extsize = fsx.fsx_extsize;
> 	fsx.fsx_extsize = atomic_align_size;
> 	ioctl(FS_IOC_FSSETXATTR, &fsx)

Eww, multiple threads doing fallocates can clobber each other here.

> 	fallocate(....)
> 	fsx.fsx_extsize = old_extsize;
> 	ioctl(FS_IOC_FSSETXATTR, &fsx)

Also, you can't set extsize if the data fork has any mappings in it,
so you can't set the old value.  But perhaps it's not so bad to expect
that programs will set this up once and not change the underlying
storage?

I'm not actually sure why you can't change the extent size hint.  Why is
that?

> Yeah, messy, but if an application is going to use atomic writes,
> then setting an extent size hint of the atomic write granularity the
> application will use at file create time makes a whole lot of sense.
> This will largely guarantee that any allocation will be aligned to
> atomic IO constraints even when non atomic IO operations are
> performed on that inode. Hence when the application needs to do an
> atomic IO, it's not going to fail because previous allocation was
> not correctly aligned.
> 
> All that we'd then need to do for atomic IO is ensure that we fail
> the allocation early if we can't allocate fully sized and aligned
> extents rather than falling back to unaligned extents when there are
> no large enough contiguous free spaces for aligned extents to be
> allocated. i.e. when RWF_ATOMIC or FALLOC_FL_ATOMIC are set by the
> application...

Right.

> 
> > In addition, extent lengths should
> > always be a multiple of atomic_write_unit_max,
> 
> Yup, that's what extent size hint based allocation does - it rounds
> both down and up to hint alignment...
> 
> ....
> 
> > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > index 34de6e6898c4..52a6e2b61228 100644
> > --- a/fs/xfs/libxfs/xfs_bmap.c
> > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > @@ -3275,7 +3275,9 @@ xfs_bmap_compute_alignments(
> >  	struct xfs_alloc_arg	*args)
> >  {
> >  	struct xfs_mount	*mp = args->mp;
> > -	xfs_extlen_t		align = 0; /* minimum allocation alignment */
> > +
> > +	/* minimum allocation alignment */
> > +	xfs_extlen_t		align = args->alignment;
> >  	int			stripe_align = 0;
> 
> 
> This doesn't do what you think it should. For one, it will get
> overwritten by extent size hints that are set, hence the user will
> not get the alignment they expected in that case.
> 
> Secondly, args->alignment is an internal alignment control for
> stripe alignment used later in the allocator when doing file
> extenstion allocations.  Overloading it to pass a user alignment
> here means that initial data allocations will have alignments set
> without actually having set up the allocator parameters for aligned
> allocation correctly.
> 
> This will lead to unexpected allocation failure as the filesystem
> fills as the reservations needed for allocation to succeed won't
> match what is actually required for allocation to succeed. It will
> also cause problematic behaviour for fallback allocation algorithms
> that expect only to be called with args->alignment = 1...
> 
> >  	/* stripe alignment for allocation is determined by mount parameters */
> > @@ -3652,6 +3654,7 @@ xfs_bmap_btalloc(
> >  		.datatype	= ap->datatype,
> >  		.alignment	= 1,
> >  		.minalignslop	= 0,
> > +		.alignment	= ap->align,
> >  	};
> >  	xfs_fileoff_t		orig_offset;
> >  	xfs_extlen_t		orig_length;
> 
> > @@ -4279,12 +4282,14 @@ xfs_bmapi_write(
> >  	uint32_t		flags,		/* XFS_BMAPI_... */
> >  	xfs_extlen_t		total,		/* total blocks needed */
> >  	struct xfs_bmbt_irec	*mval,		/* output: map values */
> > -	int			*nmap)		/* i/o: mval size/count */
> > +	int			*nmap,
> > +	xfs_extlen_t		align)		/* i/o: mval size/count */
> 
> 
> As per above - IMO this is not the right way to specify aligment for
> atomic IO. A XFS_BMAPI_ATOMIC flag is probably the right thing to
> add from the caller - this also communicates the specific allocation
> failure behaviour required, too.
> 
> Then xfs_bmap_compute_alignments() can pull the alignment
> from the relevant buftarg similar to how it already pulls preset
> alignments for extent size hints and/or realtime devices. And then
> the allocator can attempt exact aligned allocation for maxlen, then
> if that fails an exact aligned allocation for minlen, and if both of
> those fail then we return ENOSPC without attempting any unaligned
> allocations...
> 
> This also gets rid of the need to pass another parameter to
> xfs_bmapi_write(), and it's trivial to plumb into the XFS iomap and
> fallocate code paths....

I too prefer a XFS_BMAPI_ALLOC_ALIGNED flag to all this extra plumbing,
having now seen the extra plumbing.

--D

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
