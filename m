Return-Path: <linux-fsdevel+bounces-27954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95DF965215
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 23:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745A91F23B73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 21:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350481BA286;
	Thu, 29 Aug 2024 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBOxK4qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B511898E0;
	Thu, 29 Aug 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967290; cv=none; b=LDEcJjpnJmOaEAdSYOhoCV1TJ1PwObFiFMAWH6+N1SK22VEChCHkxo0XovNSzaFdEQEmjEgewa3+AUQlDHU6gnAdB9lhCQ9EC9di9SoXrKVJpRmzDYCX/UOp9D3yxHSzd+m2+Le2k4IPHT/vStdHn6dHA15gvC1apddgRMI8KDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967290; c=relaxed/simple;
	bh=ub7Z5aN8IySBUMo8/+nhlsLcMo/h7ul28OnQpJA+4hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIwQb/sEwoIrcf91WvWqC1am4mZ0BIusSGloHsVsUTrQLDag8cDTPzvGyEhUFRsoUvcCZhQ2r0cFCpA6bGk0lRoa5Pm/fUx6mPErYYDHzfMfzsUdlENfxNEZ7xwy7LVCBj/yzQyrp4qQyjQqNBoi1Jyp2xwbtR1+OFcI6pabO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBOxK4qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CA5C4CEC1;
	Thu, 29 Aug 2024 21:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724967290;
	bh=ub7Z5aN8IySBUMo8/+nhlsLcMo/h7ul28OnQpJA+4hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBOxK4qjIdVHEAxAH6BGat92NShZR2602T+Ww2i+UWJaZeocQrYRfGtumvBDAv0+1
	 9yN7/tzuG8MeUyZFoKQ/ovik7XUj87Yk8CH4dFz5qwVJ8CzZOMeVqsd2hOnIFbsWmD
	 d+jpteh8ZYcBztouqNySUhmdvirlXTUT/JZkIEV2WTI9sXeBwvRymenv05FnsqRtrZ
	 /nRwGMwdiSOjZV7Q1Z6aIc9CVIKGgATjVV5gLROPI+oTnNuq/yAE943RWNCfLNBX+l
	 T2CUgQYBlOM+U5UNGtR5AlpkOXPbzuMTwhZsR99fpTd3tCI698A7ECrF/4o0kzEFUS
	 WggpAV+dGEBrw==
Date: Thu, 29 Aug 2024 14:34:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 02/14] xfs: always tail align maxlen allocations
Message-ID: <20240829213448.GO6224@frogsfrogsfrogs>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <20240813163638.3751939-3-john.g.garry@oracle.com>
 <20240823163149.GC865349@frogsfrogsfrogs>
 <6d735dff-04a4-4386-b9e5-c01643dab92a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d735dff-04a4-4386-b9e5-c01643dab92a@oracle.com>

On Thu, Aug 29, 2024 at 06:58:02PM +0100, John Garry wrote:
> On 23/08/2024 17:31, Darrick J. Wong wrote:
> 
> sorry for the slow reply...
> 
> > On Tue, Aug 13, 2024 at 04:36:26PM +0000, John Garry wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > > > When we do a large allocation, the core free space allocation code
> > > assumes that args->maxlen is aligned to args->prod/args->mod. hence
> > > if we get a maximum sized extent allocated, it does not do tail
> > > alignment of the extent.
> > > 
> > > However, this assumes that nothing modifies args->maxlen between the
> > > original allocation context setup and trimming the selected free
> > > space extent to size. This assumption has recently been found to be
> > > invalid - xfs_alloc_space_available() modifies args->maxlen in low
> > > space situations - and there may be more situations we haven't yet
> > > found like this.
> > > 
> > > Force aligned allocation introduces the requirement that extents are
> > > correctly tail aligned, resulting in this occasional latent
> > > alignment failure to be reclassified from an unimportant curiousity
> > > to a must-fix bug.
> > > 
> > > Removing the assumption about args->maxlen allocations always being
> > > tail aligned is trivial, and should not impact anything because
> > > args->maxlen for inodes with extent size hints configured are
> > > already aligned. Hence all this change does it avoid weird corner
> > > cases that would have resulted in unaligned extent sizes by always
> > > trimming the extent down to an aligned size.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> [provisional on v1 series comment]
> > 
> > Still provisional -- neither the original patch author nor the submitter
> > have answered my question from June:
> > 
> > IOWs, we always trim rlen, unless there is no alignment (prod==1) or
> > rlen is less than mod.  For a forcealign file, it should never be the
> > case that minlen < mod because we'll have returned ENOSPC, right?
> 
> For forcealign, mod == 0, so naturally that (minlen < mod) would not happen.
> We want to alloc a multiple of align only, which is in prod.
> 
> If we consider minlen < prod, then that should not happen either as we would
> have returned ENOSPC. In xfs_bmap_select_minlen() we rounddown blen by
> args->alignment, and if that is less than the ap->minlen (1), i.e. if after
> rounddown we have 0, then we return ENOSPC for forcealign. So then minlen
> would not be less than prod after selecting minlen in
> xfs_bmap_select_minlen().
> 
> I hope that I am answering the question asked...

Yep, that satisfies my curiosity!  Thanks for getting back to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> Thanks,
> John
> 
> > 
> > --D
> > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
> > >   1 file changed, 5 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> > > index d559d992c6ef..bf08b9e9d9ac 100644
> > > --- a/fs/xfs/libxfs/xfs_alloc.c
> > > +++ b/fs/xfs/libxfs/xfs_alloc.c
> > > @@ -433,20 +433,18 @@ xfs_alloc_compute_diff(
> > >    * Fix up the length, based on mod and prod.
> > >    * len should be k * prod + mod for some k.
> > >    * If len is too small it is returned unchanged.
> > > - * If len hits maxlen it is left alone.
> > >    */
> > > -STATIC void
> > > +static void
> > >   xfs_alloc_fix_len(
> > > -	xfs_alloc_arg_t	*args)		/* allocation argument structure */
> > > +	struct xfs_alloc_arg	*args)
> > >   {
> > > -	xfs_extlen_t	k;
> > > -	xfs_extlen_t	rlen;
> > > +	xfs_extlen_t		k;
> > > +	xfs_extlen_t		rlen = args->len;
> > >   	ASSERT(args->mod < args->prod);
> > > -	rlen = args->len;
> > >   	ASSERT(rlen >= args->minlen);
> > >   	ASSERT(rlen <= args->maxlen);
> > > -	if (args->prod <= 1 || rlen < args->mod || rlen == args->maxlen ||
> > > +	if (args->prod <= 1 || rlen < args->mod ||
> > >   	    (args->mod == 0 && rlen < args->prod))
> > >   		return;
> > >   	k = rlen % args->prod;
> > > -- 
> > > 2.31.1
> > > 
> > > 
> 
> 

