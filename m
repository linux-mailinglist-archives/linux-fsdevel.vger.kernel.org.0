Return-Path: <linux-fsdevel+bounces-11406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C685387C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B563286DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3381E604B5;
	Tue, 13 Feb 2024 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRgat5YL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A160277;
	Tue, 13 Feb 2024 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845825; cv=none; b=GUyo34wwukATmeCBmy4UJYYnWuu+hUz3fAYIhcCkWIgimHIm6NEywo3+rWCaDuL3aCfL/bnP9WWPTR0r78V7hfhjLdlRwIrcVTZFgXGcbdLi5IQZ/dUcuhxvXSkZuEaFY1h3jFdLneGYrvZX+Ab4WzXvyLZQOxhtai0gJpMUEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845825; c=relaxed/simple;
	bh=weTfkdDGfVyj9ft48D1i7g/tBfv43g3swJkzlG5GT7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1KU2SKw4JXvkeWdc0BJWm7Cf6QL/5zVGfAiWgy+KkCKzxWYeeT5lFi+utGRsm4+X3bezpImAXYzEXQrLZPH3hidCYzFYRpUl/Ib/1LWdAYVihM6ql5kUBWeHecgAS6X224pOH6uPmREePSK9zsfTQzdhn3jb8TYQPmUub+YyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRgat5YL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299A0C43390;
	Tue, 13 Feb 2024 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707845825;
	bh=weTfkdDGfVyj9ft48D1i7g/tBfv43g3swJkzlG5GT7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRgat5YLmBlCUakEyYE3n6PfDxy+ugO7fNxY/oIoUHCH/jNIZxiw6luO2bZ5Ln0zO
	 8dc2au/LoB7zgGiIqfXN45FSe5p2blBJknTqydtiZ5Ak86al+yRm58ncY3pAebrBbv
	 pZh26fXkrJcJz17DKn+pcumVclhI3SyOUOl5FryZ6geh2yOfbenW3zn4VxUAzTPCrQ
	 VJ6cuGU2+fPCKziiJ9wOSjb72APkkw65xXOGXGRCef/mDtszsyeBFPd82tpsMGFw4Z
	 PuQ8u9bpTNFpGL/6PzGEHFEMEe/61VgPTK+60+5NtxPhh2jDpvdt441hr8FFl94DDd
	 7N73lD7HI2dKQ==
Date: Tue, 13 Feb 2024 09:37:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 4/6] fs: xfs: Support atomic write for statx
Message-ID: <20240213173704.GB6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-5-john.g.garry@oracle.com>
 <20240202180517.GJ6184@frogsfrogsfrogs>
 <9b966c59-3b9f-4093-9913-c9b8a3469a8b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b966c59-3b9f-4093-9913-c9b8a3469a8b@oracle.com>

On Mon, Feb 05, 2024 at 01:10:54PM +0000, John Garry wrote:
> On 02/02/2024 18:05, Darrick J. Wong wrote:
> > On Wed, Jan 24, 2024 at 02:26:43PM +0000, John Garry wrote:
> > > Support providing info on atomic write unit min and max for an inode.
> > > 
> > > For simplicity, currently we limit the min at the FS block size, but a
> > > lower limit could be supported in future.
> > > 
> > > The atomic write unit min and max is limited by the guaranteed extent
> > > alignment for the inode.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_iops.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> > >   fs/xfs/xfs_iops.h |  4 ++++
> > >   2 files changed, 49 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index a0d77f5f512e..0890d2f70f4d 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -546,6 +546,44 @@ xfs_stat_blksize(
> > >   	return PAGE_SIZE;
> > >   }
> > > +void xfs_get_atomic_write_attr(
> > 
> > static void?
> 
> We use this in the iomap and statx code
> 
> > 
> > > +	struct xfs_inode *ip,
> > > +	unsigned int *unit_min,
> > > +	unsigned int *unit_max)
> > 
> > Weird indenting here.
> 
> hmmm... I thought that this was the XFS style
> 
> Can you show how it should look?

The parameter declarations should line up with the local variables:

void
xfs_get_atomic_write_attr(
	struct xfs_inode	*ip,
	unsigned int		*unit_min,
	unsigned int		*unit_max)
{
	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
	struct block_device	*bdev = target->bt_bdev;
	struct request_queue	*q = bdev->bd_queue;
	struct xfs_mount	*mp = ip->i_mount;
	unsigned int		awu_min, awu_max, align;
	xfs_extlen_t		extsz = xfs_get_extsz(ip);

> > 
> > > +{
> > > +	xfs_extlen_t		extsz = xfs_get_extsz(ip);
> > > +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> > > +	struct block_device	*bdev = target->bt_bdev;
> > > +	unsigned int		awu_min, awu_max, align;
> > > +	struct request_queue	*q = bdev->bd_queue;
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +
> > > +	/*
> > > +	 * Convert to multiples of the BLOCKSIZE (as we support a minimum
> > > +	 * atomic write unit of BLOCKSIZE).
> > > +	 */
> > > +	awu_min = queue_atomic_write_unit_min_bytes(q);
> > > +	awu_max = queue_atomic_write_unit_max_bytes(q);
> > > +
> > > +	awu_min &= ~mp->m_blockmask;
> > 
> > Why do you round /down/ the awu_min value here?
> 
> This is just to ensure that we returning *unit_min >= BLOCKSIZE
> 
> For example, if awu_min, max 1K, 64K from the bdev, we now have 0 and 64K.
> And below this gives us awu_min, max of 4k, 64k.
> 
> Maybe there is a more logical way of doing this.

	awu_min = roundup(queue_atomic_write_unit_min_bytes(q),
			  mp->m_sb.sb_blocksize);

?

> 
> > 
> > > +	awu_max &= ~mp->m_blockmask;
> > 
> > Actually -- since the atomic write units have to be powers of 2, why is
> > rounding needed here at all?
> 
> Sure, but the bdev can report a awu_min < BLOCKSIZE
> 
> > 
> > > +
> > > +	align = XFS_FSB_TO_B(mp, extsz);
> > > +
> > > +	if (!awu_max || !xfs_inode_atomicwrites(ip) || !align ||
> > > +	    !is_power_of_2(align)) {
> > 
> > ...and if you take my suggestion to make a common helper to validate the
> > atomic write unit parameters, this can collapse into:
> > 
> > 	alloc_unit_bytes = xfs_inode_alloc_unitsize(ip);
> > 	if (!xfs_inode_has_atomicwrites(ip) ||
> > 	    !bdev_validate_atomic_write(bdev, alloc_unit_bytes))  > 		/* not supported, return zeroes */
> > 		*unit_min = 0;
> > 		*unit_max = 0;
> > 		return;
> > 	}
> > 
> > 	*unit_min = max(alloc_unit_bytes, awu_min);
> > 	*unit_max = min(alloc_unit_bytes, awu_max);
> 
> Again, we need to ensure that *unit_min >= BLOCKSIZE

The file allocation unit and hence the return value of
xfs_inode_alloc_unitsize is always a multiple of sb_blocksize.

--D

> Thanks,
> John
> 
> 

