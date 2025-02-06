Return-Path: <linux-fsdevel+bounces-41130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CD3A2B467
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 22:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777691886792
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A1323645C;
	Thu,  6 Feb 2025 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLjXNQud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9982236F7;
	Thu,  6 Feb 2025 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878616; cv=none; b=rvWfPzunZLbUyCaJm1axp5Chkl1gNtFIYJCb0xy7tiA2BNL/Vbp1fMJblhSUepX20afFDYNXqkYqxCBY/l5UXcspMGH65UrNBm2Kb/9w5pF2FY7i2gdqPhQMbVcrzTIOC26vkXm7qLjKvapjEoy/bZbRFEr6+GTG3f7WdLu3hcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878616; c=relaxed/simple;
	bh=Ubxei8U3JTtyPTNq58vGjWgHxVoG/GGbarYbPV1Eqqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/iu1UTnC5g/RSoV3I0oj0Wqs0H31Eylao7JUDSocD9vDEHqVYmyE2A8VzzzsHB/fbXu7GhZf4gCEAyot60S1usf+/vVji59c4Y8SzMSB97+h1dTZQaysTITHR8YzOZxTaswRY+/wzIf/b3QVecyBOTFGBWm27VHp33DWYb/30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLjXNQud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4274FC4CEDD;
	Thu,  6 Feb 2025 21:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738878615;
	bh=Ubxei8U3JTtyPTNq58vGjWgHxVoG/GGbarYbPV1Eqqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLjXNQudWmRjzfBSwc4V2vNciIDjiWTgym/xxrkSUx0PajM4zQfwNO3sPCj2e3kPv
	 mbPlZA3sYP4zhYB4fPgF4ilwbXAJ+31UiUX+R9GJxPa3erQ0niWdbag42TrrdtBozI
	 fbEXaO8qOOPelaJT1I2By94VKWmKnI/uS4WTlm/OGco7dJrk5T69cNXj3C6lev7oFR
	 M/8rc2SDu9GwzqmCPR0fM6H0skenlwxYJmZ4rASwmiCJ8xl/8VxsTjGJB2YM104rkr
	 m9jUz96wviU8qFJGQm2ioKub6QoJ2SIUftJYbATiJnWkxouJTus1AY+XY3ssZjjYmB
	 Hzm5EczVw5kCA==
Date: Thu, 6 Feb 2025 13:50:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 08/10] xfs: Commit CoW-based atomic writes atomically
Message-ID: <20250206215014.GX21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-9-john.g.garry@oracle.com>
 <20250205194740.GW21808@frogsfrogsfrogs>
 <ee8a6ff2-d1e3-4ee8-9949-cf57279ee5d7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee8a6ff2-d1e3-4ee8-9949-cf57279ee5d7@oracle.com>

On Thu, Feb 06, 2025 at 10:27:45AM +0000, John Garry wrote:
> On 05/02/2025 19:47, Darrick J. Wong wrote:
> > On Tue, Feb 04, 2025 at 12:01:25PM +0000, John Garry wrote:
> > > When completing a CoW-based write, each extent range mapping update is
> > > covered by a separate transaction.
> > > 
> > > For a CoW-based atomic write, all mappings must be changed at once, so
> > > change to use a single transaction.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_file.c    |  5 ++++-
> > >   fs/xfs/xfs_reflink.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
> > >   fs/xfs/xfs_reflink.h |  3 +++
> > >   3 files changed, 55 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 12af5cdc3094..170d7891f90d 100644
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
> > > index dbce333b60eb..60c986300faa 100644
> > > --- a/fs/xfs/xfs_reflink.c
> > > +++ b/fs/xfs/xfs_reflink.c
> > > @@ -990,6 +990,54 @@ xfs_reflink_end_cow(
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
> > > +	bool				commit = false;
> > > +
> > > +	trace_xfs_reflink_end_cow(ip, offset, count);
> > > +
> > > +	offset_fsb = XFS_B_TO_FSBT(ip->i_mount, offset);
> > > +	end_fsb = XFS_B_TO_FSB(ip->i_mount, offset + count);
> > > +
> > > +	resblks = XFS_NEXTENTADD_SPACE_RES(ip->i_mount,
> > > +				(unsigned int)(end_fsb - offset_fsb),
> > > +				XFS_DATA_FORK);
> > > +
> > > +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
> > 
> > xfs gained reflink support for realtime volumes in 6.14-rc1, so you now
> > have to calculate for that in here too.
> > 
> > > +			XFS_TRANS_RESERVE, &tp);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > > +	xfs_trans_ijoin(tp, ip, 0);
> > > +
> > > +	while (end_fsb > offset_fsb && !error)
> > > +		error = xfs_reflink_end_cow_extent_locked(ip, &offset_fsb,
> > > +						end_fsb, tp, &commit);
> > 
> > Hmm.  Attaching intent items to a transaction consumes space in that
> > transaction, so we probably ought to limit the amount that we try to do
> > here.  Do you know what that limit is?  I don't,
> 
> nor do I ...
> 
> > but it's roughly
> > tr_logres divided by the average size of a log intent item.
> 
> So you have a ballpark figure on the average size of a log intent item, or
> an idea on how to get it?

You could add up the size of struct
xfs_{bui,rmap,refcount,efi}_log_format structures and add 20%, that will
give you a ballpark figure of the worst case per-block requirements.

My guess is that 64 blocks is ok provided resblks is big enough.  But I
guess we could estimate it (very conservatively) dynamically too.

(also note tr_itruncate declares more logres)

> > This means we need to restrict the size of an untorn write to a
> > double-digit number of fsblocks for safety.
> 
> Sure, but won't we also still be liable to suffer the same issue which was
> fixed in commit d6f215f359637?

Yeah, come to think of it, you need to reserve the worst case space
reservation, i.e. each of the blocks between offset_fsb and end_fsb
becomes a separate btree update.

	resblks = (end_fsb - offset_fsb) *
			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);

--D

> > 
> > The logic in here looks reasonable though.
> > 
> 
> Thanks,
> John
> 
> > --D
> > 
> > > +
> > > +	if (error || !commit)
> > > +		goto out_cancel;
> > > +
> > > +	if (error)
> > > +		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
> > > +	error = xfs_trans_commit(tp);
> > > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > > +	return error;
> > > +out_cancel:
> > > +	xfs_trans_cancel(tp);
> > > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > > +	return error;
> > > +}
> > >   /*
> > >    * Free all CoW staging blocks that are still referenced by the ondisk refcount
> > > diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> > > index ef5c8b2398d8..2c3b096c1386 100644
> > > --- a/fs/xfs/xfs_reflink.h
> > > +++ b/fs/xfs/xfs_reflink.h
> > > @@ -45,6 +45,9 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
> > >   		xfs_off_t count, bool cancel_real);
> > >   extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
> > >   		xfs_off_t count);
> > > +		int
> > > +xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
> > > +		xfs_off_t count);
> > >   extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
> > >   extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
> > >   		struct file *file_out, loff_t pos_out, loff_t len,
> > > -- 
> > > 2.31.1
> > > 
> > > 
> 
> 

