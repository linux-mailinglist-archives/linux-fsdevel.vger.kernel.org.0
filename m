Return-Path: <linux-fsdevel+bounces-26837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CBE95BFE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 22:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2B2285BF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD2F1D3647;
	Thu, 22 Aug 2024 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnoZFWQN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60A1D1728;
	Thu, 22 Aug 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359449; cv=none; b=H0cIgCiSleHjfl9FYBaXDrnu+6HXjZu8Pdq9bYxBJWSuz51P2CKiwitlY9+GXLJyGWUB6wZvMVzCfWaCyj0P+YnESxY6EzxFMXEfvKGnPu+pA+xqIO6r8BNhO9Oi3fskULrKiFVBdzhAo8IY1+N43pR6hQpHCJEfCjwsxRhhq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359449; c=relaxed/simple;
	bh=CWY8to166mK7WMYgXiUyeMviy3nbwLD4WUFLbxKhleM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUwIiuldaxFiXPPOqazcW7Myzn9gpCjULqgI3Sq70FcVhoLsZ8FA3buA1Ml+MOD1f/D8wvoCPf1ZmF7bLBJ4XlR6r9RiXi/TElPkPyAWdUMU+2WT2RFVUgh4O+B89hD5beYwAb2+SXQBZ/simMOFI75WkauLcQlzCq58XoJBj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnoZFWQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB7FC32782;
	Thu, 22 Aug 2024 20:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724359448;
	bh=CWY8to166mK7WMYgXiUyeMviy3nbwLD4WUFLbxKhleM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnoZFWQN/17hHKS9tlzz6Tkey7xKbs5izv63sI6fXZGcznsH7PVVREZZ5Ca2kb+vD
	 GF8L6UuaaUyFbeLAvQwrJa85KtmzjJ0nRQ+eMiZV832rEXz09x3mDComtYgI21oTih
	 puSP1283+263x97O1wmFiMPuToAp+68AQd9Yid5CzVPmYaWLcVNVHuAK/IyMZno153
	 5aUeQNEkS13q/TmVhN0zcvJ/3UvkHQmpaD6nzBZPsRwSr4cQP/qj5PsUB+XVNmOflR
	 zfB4ovrloEIujf2mU10CECp3KnJfIPZVa4FLJGSlL1UTfoXhU2R3mh/TdWqI25/p1p
	 1TjAVMz6fDcdw==
Date: Thu, 22 Aug 2024 13:44:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 7/7] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Message-ID: <20240822204407.GU865349@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-8-john.g.garry@oracle.com>
 <20240821171142.GM865349@frogsfrogsfrogs>
 <7c5fdd14-5c59-4292-b4b5-b0d49ba1bce6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5fdd14-5c59-4292-b4b5-b0d49ba1bce6@oracle.com>

On Thu, Aug 22, 2024 at 07:04:02PM +0100, John Garry wrote:
> On 21/08/2024 18:11, Darrick J. Wong wrote:
> > On Sat, Aug 17, 2024 at 09:48:00AM +0000, John Garry wrote:
> > > For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
> > > flag. Only direct IO is currently supported, so check for that also.
> > > 
> > > We rely on the block layer to reject atomic writes which exceed the bdev
> > > request_queue limits, so don't bother checking any such thing here.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_file.c | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 9b6530a4eb4a..3489d478809e 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1149,6 +1149,18 @@ xfs_file_remap_range(
> > >   	return remapped > 0 ? remapped : ret;
> > >   }
> > > +static bool xfs_file_open_can_atomicwrite(
> > > +	struct inode		*inode,
> > > +	struct file		*file)
> > > +{
> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > +
> > > +	if (!(file->f_flags & O_DIRECT))
> > > +		return false;
> > > +
> > > +	return xfs_inode_has_atomicwrites(ip);
> > 
> > ...and here too.  I do like the shift to having an incore flag that
> > controls whether you get untorn write support or not.
> 
> Do you mean that add a new member to xfs_inode to record this? If yes, it
> sounds ok, but we need to maintain consistency (of that member) whenever
> anything which can affect it changes, which is always a bit painful.

I actually meant something more like:

static bool
xfs_file_open_can_atomicwrite(
	struct file		*file,
	struct inode		*inode)
{
	struct xfs_inode	*ip = XFS_I(inode);
	struct xfs_mount	*mp = ip->i_mount;
	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);

	if (!(file->f_flags & O_DIRECT))
		return false;
	if (!xfs_inode_has_atomicwrites(ip))
		return false;
	if (mp->m_dalign && (mp->m_dalign % ip->i_extsize))
		return false;
	if (mp->m_swidth && (mp->m_swidth % ip->i_extsize))
		return false;
	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
		return false;
	if (xfs_inode_alloc_unitsize(ip) > target->bt_bdev_awu_max)
		return false;
	return true;
}

--D

> John
> 

