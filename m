Return-Path: <linux-fsdevel+bounces-43647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB86FA59DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FE7170544
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C55235C1B;
	Mon, 10 Mar 2025 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLKxfv7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6F22D4C3;
	Mon, 10 Mar 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627507; cv=none; b=Ae0CxxMrMraTb6HhIJyOqkgq4v+eJGTgr1S3i0JkXFbOcX93J7WnEW64YWxFJK9V+f0qGZC6pUTa1N8hExOU4u1ZbOcjYqpmH26Yzs5HPL7uks7kW/SfFNSN55Qh75HT5+SnBlQ4Lb5EWAFlJvp9r3SPBZx34l74jDboNkG/n7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627507; c=relaxed/simple;
	bh=BghEd2GQW3wTIlHStsjpZEDMB9FucNbdaiZrISQmQN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF/RIEzLwwxJy907HppyABktyBSuDnrL8tGTjI86VduU2R75DiOegnbeHS5zo/E4KlwlIw7bzcm65iqYkKfxF+28C9ewmDz0uHjVeDGAKdaiIZFvdAn3Mg3PMZhZGBzWEQptpapV155cxkzuh4aFD+ua5NkPw+8fOkP/DMGsKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLKxfv7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF18C4CEED;
	Mon, 10 Mar 2025 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627507;
	bh=BghEd2GQW3wTIlHStsjpZEDMB9FucNbdaiZrISQmQN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLKxfv7TquaSQVj6pduRdJDLTKPzknb5tkgsZMzpLvUTvE9PEYMQsIjrM4VFFgYIN
	 veK3Jwsfb3aoCpCdWqKhvnl4zMBDJHVUR0jca3yqUZ8zH5UkMHxrnBUtHZlyquNf9h
	 oe4WgGBn9PoHeBGiFmq9gcv+Q1NvEL63XpQrx53yLCRmhUciVfY6nGvnLfP12N0Zo4
	 iYEwCZAQVnCT40WqIKXo4ZaV6RNvCJz6+Yugzn27g1jzuyUHWHQnHprenZENXDlpr8
	 pFqP/yG7Jhf9+nzn3j2o3mzEND2mwXgXGu8yJ6CUYm8ekFhSQBej/CiazZVpKJiijW
	 Qc+CSbiSKKWiA==
Date: Mon, 10 Mar 2025 10:25:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, brauner@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 09/12] xfs: Add xfs_file_dio_write_atomic()
Message-ID: <20250310172507.GU2803749@frogsfrogsfrogs>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-10-john.g.garry@oracle.com>
 <877c4x57j8.fsf@gmail.com>
 <5e6795b1-305c-40a0-84d0-43dfb4ee6cd7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6795b1-305c-40a0-84d0-43dfb4ee6cd7@oracle.com>

On Mon, Mar 10, 2025 at 03:24:23PM +0000, John Garry wrote:
> On 10/03/2025 13:39, Ritesh Harjani (IBM) wrote:
> > John Garry <john.g.garry@oracle.com> writes:
> > 
> > > Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.
> > > 
> > > In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
> > > in CoW-based atomic write mode.
> > > 
> > > For CoW-based mode, ensure that we have no outstanding IOs which we
> > > may trample on.
> > > 
> > > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 42 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 51b4a43d15f3..70eb6928cf63 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -619,6 +619,46 @@ xfs_file_dio_write_aligned(
> > >   	return ret;
> > >   }
> > > +static noinline ssize_t
> > > +xfs_file_dio_write_atomic(
> > > +	struct xfs_inode	*ip,
> > > +	struct kiocb		*iocb,
> > > +	struct iov_iter		*from)
> > > +{
> > > +	unsigned int		iolock = XFS_IOLOCK_SHARED;
> > > +	unsigned int		dio_flags = 0;
> > > +	ssize_t			ret;
> > > +
> > > +retry:
> > > +	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = xfs_file_write_checks(iocb, from, &iolock);
> > > +	if (ret)
> > > +		goto out_unlock;
> > > +
> > > +	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
> > > +		inode_dio_wait(VFS_I(ip));
> > > +
> > > +	trace_xfs_file_direct_write(iocb, from);
> > > +	ret = iomap_dio_rw(iocb, from, &xfs_atomic_write_iomap_ops,
> > > +			&xfs_dio_write_ops, dio_flags, NULL, 0);
> > > +
> > > +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
> > > +	    !(dio_flags & IOMAP_DIO_ATOMIC_SW)) {
> > > +		xfs_iunlock(ip, iolock);
> > > +		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
> > > +		iolock = XFS_IOLOCK_EXCL;
> > > +		goto retry;
> > > +	}
> > 
> > IIUC typically filesystems can now implement support for IOMAP_ATOMIC_SW
> > as a fallback mechanism, by returning -EAGAIN error during
> > IOMAP_ATOMIC_HW handling from their ->iomap_begin() routine.  They can
> > then retry the entire DIO operation of iomap_dio_rw() by passing
> > IOMAP_DIO_ATOMIC_SW flag in their dio_flags argument and handle
> > IOMAP_ATOMIC_SW fallback differently in their ->iomap_begin() routine.
> > 
> > However, -EAGAIN can also be returned when there is a race with mmap
> > writes for the same range. We return the same -EAGAIN error during page
> > cache invalidation failure for IOCB_ATOMIC writes too.  However, current
> > code does not differentiate between these two types of failures. Therefore,
> > we always retry by falling back to SW CoW based atomic write even for
> > page cache invalidation failures.
> > 
> > __iomap_dio_rw()
> > {
> > <...>
> > 		/*
> > 		 * Try to invalidate cache pages for the range we are writing.
> > 		 * If this invalidation fails, let the caller fall back to
> > 		 * buffered I/O.
> > 		 */
> > 		ret = kiocb_invalidate_pages(iocb, iomi.len);
> > 		if (ret) {
> > 			if (ret != -EAGAIN) {
> > 				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
> > 								iomi.len);
> > 				if (iocb->ki_flags & IOCB_ATOMIC) {
> > 					/*
> > 					 * folio invalidation failed, maybe
> > 					 * this is transient, unlock and see if
> > 					 * the caller tries again.
> > 					 */
> > 					ret = -EAGAIN;
> > 				} else {
> > 					/* fall back to buffered write */
> > 					ret = -ENOTBLK;
> > 				}
> > 			}
> > 			goto out_free_dio;
> > 		}
> > <...>
> > }
> > 
> > It's easy to miss such error handling conditions. If this is something
> > which was already discussed earlier, then perhaps it is better if
> > document this.  BTW - Is this something that we already know of and has
> > been kept as such intentionally?
> > 
> 
> On mainline, for kiocb_invalidate_pages() error for IOCB_ATOMIC, we always
> return -EAGAIN to userspace.
> 
> Now if we have any kiocb_invalidate_pages() error for IOCB_ATOMIC, we retry
> with SW CoW mode - and if it fails again, we return -EAGAIN to userspace.
> 
> If we choose some other error code to trigger the SW-based COW retry (so
> that we don't always retry for kiocb_invalidate_pages() error when
> !IOMAP_DIO_ATOMIC_HW), then kiocb_invalidate_pages() could still return that
> same error code and we still retry in SW-based COW mode - is that better? Or
> do we need to choose some error code which kiocb_invalidate_pages() would
> never return?
> 
> Note that -EAGAIN is used by xfs_file_dio_unwrite_unaligned(), so would be
> nice to use the same error code.

Frankly I don't see why it's a problem that EAGAIN triggers the software
fallback no matter what tripped that.  Maybe the writer would be ok with
the retry even if it came from an (unlikely) mmap write collision.

--D

> Thanks,
> John
> 

