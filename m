Return-Path: <linux-fsdevel+bounces-22039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8300911484
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 23:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB9EB22346
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 21:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECBC8564A;
	Thu, 20 Jun 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlQZkEWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02FE78C8E;
	Thu, 20 Jun 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918643; cv=none; b=jn/TCGYywP8ZkBHVbXCG9rq1AOId25kJTTdgcQBspU2ydrNUymQYAXwXORkF4GxSo0Xw/cAcK2U1SFiZl47sflIACc8oMEg3rsNlEAI8+ScXTxxuH87xzAmYd4vxNwQkNvME6UNUj1LRQ4O9cqG4MrI0njeiUSaSFLRDRTVU3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918643; c=relaxed/simple;
	bh=J2GqEQCdBgJeMDsHOUD3ggS0L8MaxCNWl/BVWnLRCW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Klh52aQGeE2rm+1S/lVne1qMOtv44ALA3sso6+FQ0/MD+Xno5DrHOCaVgOaly34ujNaKTHct8zvolmUcuKjoAZjDGcZj+yR/foe+f0O2AGLNs0YsK+LGnZVQf6R3VfvgwTLkpHghJsYgUaN6KYGlv8Hu+64NrrIwdEgTCgS2QFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlQZkEWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578C8C2BD10;
	Thu, 20 Jun 2024 21:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718918642;
	bh=J2GqEQCdBgJeMDsHOUD3ggS0L8MaxCNWl/BVWnLRCW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlQZkEWXuYjG3lBPD+CbeqHswxAsU7y4iss7QjmrwwSkTw2iU3E6o6btinmhwPHrD
	 lSF/mb5wOLfVwxtjYYm93dMIUn1hfwPO7/uvnuUvaMGfIVTVH8Kn/kMXsydRkfKkKk
	 +q9uKCYgckPzfqcC2uHLzy4ZEe1BFH/G9Q8G00qfYW4ZlnjgKp1D8f5mbTBTzHet3f
	 KJRe02ZO01MDudREL9gtQdj64PgKYAVNDPPdkW0hXvesX4jdchaliSxKMN5OssSrSq
	 Ecnj4xZ09k4NozRYTQARzo3zXOkrOETiUmVHdKRiMwF75ak/8AVeIkVdoL0kbhtqfE
	 xzqtOujZzBqdw==
Date: Thu, 20 Jun 2024 14:24:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.com,
	chandan.babu@oracle.com, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
	ritesh.list@gmail.com, mcgrof@kernel.org,
	mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
	miklos@szeredi.hu, martin.petersen@oracle.com
Subject: Re: [PATCH v4 01/22] fs: Add generic_atomic_write_valid_size()
Message-ID: <20240620212401.GA3058325@frogsfrogsfrogs>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-2-john.g.garry@oracle.com>
 <20240612211040.GJ2764752@frogsfrogsfrogs>
 <a123946e-1df2-48da-b120-67b50c3aa9f5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a123946e-1df2-48da-b120-67b50c3aa9f5@oracle.com>

On Thu, Jun 13, 2024 at 08:35:53AM +0100, John Garry wrote:
> On 12/06/2024 22:10, Darrick J. Wong wrote:
> > On Fri, Jun 07, 2024 at 02:38:58PM +0000, John Garry wrote:
> > > Add a generic helper for FSes to validate that an atomic write is
> > > appropriately sized (along with the other checks).
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   include/linux/fs.h | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 069cbab62700..e13d34f8c24e 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -3645,4 +3645,16 @@ bool generic_atomic_write_valid(loff_t pos, struct iov_iter *iter)
> > >   	return true;
> > >   }
> > > +static inline
> > > +bool generic_atomic_write_valid_size(loff_t pos, struct iov_iter *iter,
> > > +				unsigned int unit_min, unsigned int unit_max)
> > > +{
> > > +	size_t len = iov_iter_count(iter);
> > > +
> > > +	if (len < unit_min || len > unit_max)
> > > +		return false;
> > > +
> > > +	return generic_atomic_write_valid(pos, iter);
> > > +}
> > 
> > Now that I look back at "fs: Initial atomic write support" I wonder why
> > not pass the iocb and the iov_iter instead of pos and the iov_iter?
> 
> The original user of generic_atomic_write_valid() [blkdev_dio_unaligned() or
> blkdev_dio_invalid() with the rename] used these same args, so I just went
> with that.

Don't let the parameter types of static blockdev helpers determine the
VFS API that filesystems need to implement untorn writes.

In the block layer enablement patch, this could easily be:

bool generic_atomic_write_valid(const struct kiocb *iocb,
				const struct iov_iter *iter)
{
	size_t len = iov_iter_count(iter);

	if (!iter_is_ubuf(iter))
		return false;

	if (!is_power_of_2(len))
		return false;

	if (!IS_ALIGNED(iocb->ki_pos, len))
		return false;

	return true;
}

Then this becomes:

bool generic_atomic_write_valid_size(const struct kiocb *iocb,
				     const struct iov_iter *iter,
				     unsigned int unit_min,
				     unsigned int unit_max)
{
	size_t len = iov_iter_count(iter);

	if (len < unit_min || len > unit_max)
		return false;

	return generic_atomic_write_valid(iocb, iter);
}

Yes, that means you have to rearrange the calling conventions of
blkdev_dio_invalid a little bit, but the first two arguments match
->read_iter and ->write_iter.  Filesystem writers can see that the first
two arguments are the first two parameters to foofs_write_iter() and
focus on the hard part, which is figuring out unit_{min,max}.

static ssize_t
xfs_file_dio_write(
	struct kiocb		*iocb,
	struct iov_iter		*from)
{
...
	if ((iocb->ki_flags & IOCB_ATOMIC) &&
	    !generic_atomic_write_valid_size(iocb, from,
			i_blocksize(inode),
			XFS_FSB_TO_B(mp, ip->i_extsize)))
		return -EINVAL;
	}


> > And can these be collapsed into a single generic_atomic_write_checks()
> > function?
> 
> bdev file operations would then need to use
> generic_atomic_write_valid_size(), and there is no unit_min and unit_max
> size there, apart from bdev awu min and max. And if I checked them, we would
> be duplicating checks (of awu min and max) in the block layer.

Fair enough, I concede this point.

--D

> 
> Cheers,
> John
> 

