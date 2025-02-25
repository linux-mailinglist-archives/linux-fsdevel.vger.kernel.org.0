Return-Path: <linux-fsdevel+bounces-42598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F208FA448F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE34175673
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90BD199FD0;
	Tue, 25 Feb 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA2HYpU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BA19882F;
	Tue, 25 Feb 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505818; cv=none; b=pYmsLmnhR4bDCek45v0tcTGflQ5sGuQfZAJJkSjmv5Qn9HTJ1eVhNvTybNChKBdCsXyFadBduBMezmsnl/ug97eOU2VwzKHOv/AxBMF80m0SLNhOBwOJ3hNg4Ml7aHQAJ+yukD2tXeEEGKo7Hla2zhJWRu+yKSmyLzMPsfOq9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505818; c=relaxed/simple;
	bh=pseHv10suOnTrBMeDPRE21TEpcumthLSZ89PrafeTmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBShzLXD2a7Xb0sZF2l7p0QF4qcfSeKNde7n2R7BBw+JXMU7gG7G1aWdJ6ATXl1ug9gmTx27PbQ0fiBHnEYzDc7EXc1cXpxYT+aPlPk8JR+mJ59RivknWyK2LahW6Hd3Io7WCfWbRbD6qdOlt6DggFTpS11NwNFfS2/51gRbs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA2HYpU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6609EC4CEDD;
	Tue, 25 Feb 2025 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505815;
	bh=pseHv10suOnTrBMeDPRE21TEpcumthLSZ89PrafeTmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FA2HYpU7sxl9DbGvZS2VrTSZkTRi0NbggriHvkAoRNsLSClEhqvmlLRf0WKvLtKn6
	 nsmfJnfzqFpDz+JsDT4zYL3AHGMKjWy89TgRyjPtRsKGvsIGfEyvXoMsp0bP1GGGc2
	 J3MPOWvmuwX7nhoBVYD6e+1R9ZikLZXD4cp2sMSaV8/wVLKUZepFhWNAm+0Ny0v+M/
	 6qc5PJ5Ik0O2W3+IeRnL0869QbeBToUMz85xSn20NcC9W65V5+JiYRz0gkaa4o4JsR
	 lWluW5luUuayby5720qFTotpcZMAmv+zn2/JA8BO1zAuJObKL4WVibt24mv1DljorM
	 5jpObOLzOR9mA==
Date: Tue, 25 Feb 2025 09:50:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 09/11] xfs: Commit CoW-based atomic writes atomically
Message-ID: <20250225175014.GG6242@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-10-john.g.garry@oracle.com>
 <20250224202034.GE21808@frogsfrogsfrogs>
 <b2ba8b64-be86-474d-874c-273bbeb4df00@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ba8b64-be86-474d-874c-273bbeb4df00@oracle.com>

On Tue, Feb 25, 2025 at 11:11:45AM +0000, John Garry wrote:
> On 24/02/2025 20:20, Darrick J. Wong wrote:
> > On Thu, Feb 13, 2025 at 01:56:17PM +0000, John Garry wrote:
> > > When completing a CoW-based write, each extent range mapping update is
> > > covered by a separate transaction.
> > > 
> > > For a CoW-based atomic write, all mappings must be changed at once, so
> > > change to use a single transaction.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_file.c    |  5 ++++-
> > >   fs/xfs/xfs_reflink.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
> > >   fs/xfs/xfs_reflink.h |  3 +++
> > >   3 files changed, 52 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 9762fa503a41..243640fe4874 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -527,7 +527,10 @@ xfs_dio_write_end_io(
> > >   	nofs_flag = memalloc_nofs_save();
> > >   	if (flags & IOMAP_DIO_COW) {
> > > -		error = xfs_reflink_end_cow(ip, offset, size);
> > > +		if (iocb->ki_flags & IOCB_ATOMIC)
> > > +			error = xfs_reflink_end_atomic_cow(ip, offset, size);
> > > +		else
> > > +			error = xfs_reflink_end_cow(ip, offset, size);
> > >   		if (error)
> > >   			goto out;
> > >   	}
> > > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> > > index 3dab3ba900a3..d097d33dc000 100644
> > > --- a/fs/xfs/xfs_reflink.c
> > > +++ b/fs/xfs/xfs_reflink.c
> > > @@ -986,6 +986,51 @@ xfs_reflink_end_cow(
> > >   		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
> > >   	return error;
> > >   }
> > > +int
> > > +xfs_reflink_end_atomic_cow(
> > > +	struct xfs_inode		*ip,
> > > +	xfs_off_t			offset,
> > > +	xfs_off_t			count)
> > > +{
> > > +	xfs_fileoff_t			offset_fsb;
> > > +	xfs_fileoff_t			end_fsb;
> > > +	int				error = 0;
> > > +	struct xfs_mount		*mp = ip->i_mount;
> > > +	struct xfs_trans		*tp;
> > > +	unsigned int			resblks;
> > > +
> > > +	trace_xfs_reflink_end_cow(ip, offset, count);
> > > +
> > > +	offset_fsb = XFS_B_TO_FSBT(ip->i_mount, offset);
> > > +	end_fsb = XFS_B_TO_FSB(ip->i_mount, offset + count);
> > 
> > Use @mp here instead of walking the pointer.
> 
> Yes
> 
> > 
> > > +
> > > +	resblks = (end_fsb - offset_fsb) *
> > > +			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
> > 
> > How did you arrive at this computation?
> 
> hmmm... you suggested this, but maybe I picked it up incorrectly :)
> 
> > The "b" parameter to
> > XFS_NEXTENTADD_SPACE_RES is usually the worst case number of mappings
> > that you're going to change on this file.  I think that quantity is
> > (end_fsb - offset_fsb)?
> 
> Can you please check this versus what you suggested in
> https://lore.kernel.org/linux-xfs/20250206215014.GX21808@frogsfrogsfrogs/#t

Ah, yeah, that ^^ is correct.  This needs a better comment then:

	/*
	 * Each remapping operation could cause a btree split, so in
	 * the worst case that's one for each block.
	 */
	resblks = (end_fsb - offset_fsb) *
			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);

--D

> > 
> > > +
> > > +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
> > > +			XFS_TRANS_RESERVE, &tp);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > > +	xfs_trans_ijoin(tp, ip, 0);
> > > +
> > > +	while (end_fsb > offset_fsb && !error)
> > > +		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
> > > +							end_fsb);
> > 
> > Overly long line, and the continuation line only needs to be indented
> > two more tabs.
> 
> ok
> 
> > 
> > > +
> > > +	if (error) {
> > > +		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
> > > +		goto out_cancel;
> > > +	}
> > > +	error = xfs_trans_commit(tp);
> > > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > > +	return 0;
> > 
> > Why is it ok to drop @error here?  Shouldn't a transaction commit error
> > should be reported to the writer thread?
> > 
> 
> I can fix that, as I should not ignore errors from xfs_trans_commit()
> 
> Thanks,
> John
> 

